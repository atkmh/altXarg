;**
;**		BRIEF -- Basic Reconfigurable Interactive Editing Facility
;**
;**		Written by Dave Nanian and Michael Strickman.
;**

;**
;**		autosave.m:
;**
;**		This macro implements a simple autosave feature using the BRIEF
;**	idle action registered macro facility.  Every time the user is idle
;**	for the amount of time specified by -i<num>, the buffer list is checked
;**	and modified files are automatically written to disk as "filename.asv"
;**	(stands for AutoSaVe).
;**
;**		Autosaving can be forced after a number of minutes by passing the
;**	number of minutes between forced autosaves to the autosave macro.  Note
;**	that this type of autosave can not be interrupted, and could become quite
;**	annoying if the value is too low.
;**
;**		Revision history:
;**		-----------------
;**

(macro autosave
	(
		(int	force_autosave
				save_buf
				last_idle_save
				last_save_time
				last_save_day
				hours
				minutes
		)
		(global	force_autosave
					save_buf
					last_idle_save
					last_save_time
					last_save_day
		)
		(register_macro 4 "save_files")
		(register_macro 5 "save_exit")
		(get_parm 0 force_autosave)
		(date NULL NULL last_save_day)
		(time hours minutes)
		(= last_save_time (+ minutes (* hours 60)))
	)
)

;**
;**		save_files:
;**
;**		This macro loops through the buffer list, writing all of the modified
;**	buffers.  Note that a special buffer is created to keep track of the
;**	autosaved files.
;**

(macro save_files
	(
		(int		curr_buf
					old_buf
					saved
					do_autosave
					force_save
					hours
					minutes
					day
		)
		(date NULL NULL day)
		(time hours minutes)
		(= force_save (&& force_autosave (>= (- (+ minutes (* (+ hours (if (!= day last_save_day) 24 0)) 60)) last_save_time) force_autosave)))

		(if (< (inq_idle_time) last_idle_save)
			(= last_idle_save 0)
		)
		(if (|| force_save (&& (> (inq_idle_time) (inq_idle_default)) (== last_idle_save 0)))
			(
				(= last_idle_save (inq_idle_time))
				(= curr_buf (inq_buffer))

				;**
				;**		This loop goes through the buffer list, and stops when
				;**	all non-system buffers have been checked.
				;**
				;**		Note that if this is an idle save and the users starts
				;**	typing, the loop stops.  This prevents the autosave from
				;**	continuing when the user has made the transition from an
				;**	idle to a non-idle state.
				;**
				;**		If this is a forced save, all buffers are saved before
				;**	stopping.
				;**

				(while (! (|| (== curr_buf old_buf) (&& (! force_save) (inq_kbd_char))))
					(
						(if (! old_buf)
							(= old_buf curr_buf)
						)
						(if (&& (inq_modified) (! (inq_system)))
							(
							;**
							;**		If the current buffer is modified, and is not a system
							;**	buffer, we have to write it to disk.
							;**

								(string	name
											extension
								)
								(inq_names name extension)

								(if (strlen extension)
									(= name (substr name 1 (- (rindex name (+ "." extension)) 1)))
								)
								(+= name ".asv")

								(inq_names NULL NULL extension)

								(save_position)
								(top_of_buffer)
								(drop_anchor 3)

								(if (! save_buf)
									(= save_buf (create_buffer "Autosaves" NULL 1))
								)
								(set_buffer save_buf)
								(top_of_buffer)

								;**
								;**		If the file has been autosaved already, we
								;**	have some additional work to do.
								;**

								(if (search_fwd name 0)
									(
										;**
										;**		If this is a forced save, we do it
										;**	whether the files are the same or not.
										;**

										(if force_save
											(
												(del name)
												(++ do_autosave)
											)
										;else
											(
												(int	comp_buf
														done
												)
												(string	line_1
															line_2
												)

												;**
												;**		At this point, we know the file has
												;**	been saved once before.  Here, we check
												;**	to see if the file has actually been
												;**	modified since the last autosave.  This
												;**	is done by performing a line-by-line
												;**	comparison of the two files.  Note that
												;**	this comparison (and the entire autosave)
												;**	is aborted if the users starts typing.
												;**

												(if (= comp_buf (create_buffer "Save Comp" name 1))
													(
														(while (! (|| (inq_kbd_char) done))
															(
																(set_buffer curr_buf)

																;**
																;**		If we're past the end of the
																;**	file, we use the null string rather
																;**	than the newline character that read
																;**	usually returns.  If this wasn't
																;**	done, files with newline characters
																;**	at their ends would match files
																;**	that were essentially the same but
																;**	shorter.
																;**

																(if (inq_position)
																	(= line_1 "")
																;else
																	(
																		(= line_1 (read))
																		(move_rel 1 0)
																	)
																)
																(set_buffer comp_buf)

																(if (inq_position)
																	(= line_2 "")
																;else
																	(
																		(= line_2 (read))
																		(move_rel 1 0)
																	)
																)
																(+= done (|| (!= line_1 line_2) (== line_1 "")))
															)
														)
														(set_buffer curr_buf)
														(delete_buffer comp_buf)

														;**
														;**		We want to actually perform the save
														;**	if the users hasn't typed anything and
														;**	the last lines compared didn't match.
														;**

														(if (&& (! (inq_kbd_char)) (!= line_1 line_2))
															(
																(++ do_autosave)

																;**
																;**		We delete the previously saved
																;**	file at this point.  If we didn't,
																;**	a backup file could be created.
																;**

																(del name)
															)
														)
													)
												)
											)
										)
									)
								;else
									(
										(insert (+ name "\n"))
										(++ do_autosave)
									)
								)
								(if do_autosave
									(
										(++ saved)
										(set_buffer curr_buf)
										(message "Autosaving %s..." extension)
										(end_of_buffer)

										(if (< (write_block name) 0)
											(raise_anchor)
										)
										(-- do_autosave)
									)
								;else
									(raise_anchor)
								)
								(restore_position)
							)
						)
						;**
						;**		When we go to the next buffer, we ask next buffer for
						;**	all of the buffers, not just non-system.  This way, if we
						;**	started with a system buffer, we don't infinite loop.
						;**

						(= curr_buf (set_buffer (next_buffer 1)))
					)
				)
				(if old_buf
					(set_buffer old_buf)
				)
				(if (|| force_save saved)
					(
						(if (|| force_save (! (inq_kbd_char)))
							(
								(= last_save_day day)
								(= last_save_time (+ minutes (* hours 60)))
							)
						)
						(if saved
							(message "Autosave complete.")
						)
					)
				)
			)
		)
	)
)

;**
;**		save_exit:
;**
;**		This routine is called just before BRIEF is going to exit for real.
;**	At that time, all of the autosaved files are deleted from the disk
;**	since they are no longer needed.
;**

(macro save_exit
	(
		(string		name)

		(int			old_buf)

		(if save_buf
			(
				(= old_buf (inq_buffer))
				(set_buffer save_buf)
				(top_of_buffer)

				(while (! (inq_position))
					(
						(= name (read))
						(del (substr name 1 (- (strlen name) 1)))
						(move_rel 1 0)
					)
				)
				(set_buffer old_buf)
			)
		)
	)
)
