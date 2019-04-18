;**
;**		BRIEF -- Basic Reconfigurable Interactive Editing Facility
;**
;**		Written by Dave Nanian and Michael Strickman.
;**

;**
;**		restore.m:
;**
;**		This macro saves and restore search and translate global
;**	variables, as well as the buffers (and positions therein)
;**	active when BRIEF was last exited.  There are five parts/macros:
;**	part one (save_state) saves the fixed state information, part two
;**	(_save_state) saves the variable information (and can be replaced
;**	by the user), part three (.rst) restores the list of files and
;**	their positions, part four (restore) restores the fixed editing
;**	information, and part five (_restore) restores the variable
;**	editing information (and can be replaced by the user).
;**

#define REG_EXIT_ACTION 5
#define TRUE				1
#define FALSE				0
#define SYSTEM				1

(extern	_reg_exp
			_s_pat
			_r_pat
			_t_pat
			_dir
			_t_dir
			_block_search
			_check_warnings
)

;**
;**		save_state:
;**
;**		This macro, when registered as an EXIT_ACTION (type 5)
;**	registered macro, saves the state of the search variables
;**	as well as the names and positions of the current files.
;**
;**	The layout of the state file is as follows:
;**
;**	 Search direction, regular expression setting,
;**	  search block setting, translate direction and
;**	  warnings-only compile setting.
;**	 Search pattern.
;**	 Translate pattern.
;**	 Replacement string.
;**	 Optional user save information.
;**	 The string "[FILES]".
;**	 A variable number of file records, which contain:
;**		 The full, qualified path of the file.
;**		 The line and column the cursor was on, and any bookmarks.
;**		  The bookmarks are of the form <number> <line> <column>.
;**

(macro save_state
	(
		(int		save_buf_id
					start_buf_id
					old_backup
		)
		(string	file_name
					info
		)
		;**
		;**		If the user hasn't specified a BFILE as yet (if there
		;**	isn't any BFILE in the environment, (inq_environment) returns
		;**	the null string), or the given BFILE is invalid in some other
		;**	way,  we can't save the state.  We display a message to this
		;**	effect and exit.
		;**

		(if (== (= file_name (lower (inq_environment "BFILE"))) "")
			(error "No BFILE specified, state not saved.")
		;else
			(
				;**
				;**		Here we create a buffer for the state file.  It's created
				;**	as a system buffer to prevent it from appearing in the buffer
				;**	list (and getting saved along with the other files).
				;**
				;**		We delete the file first to make sure it's empty.

				(del file_name)

				(if (! (= save_buf_id (create_buffer "State" file_name SYSTEM)))
					(error "Invalid BFILE, state not saved.")
				;else
					(
						;**
						;**		We need to reset the current buffer later, since
						;**	other macros could run after we do and we don't want
						;**	to leave BRIEF in an unstable state.  We save its
						;**	buffer id before continuing.
						;**

						(= start_buf_id (inq_buffer))
						(set_buffer save_buf_id)

						;**
						;**		First, we save the "global" save information.
						;**	This includes the search and translate directions,
						;**	the regular expression setting, the block search
						;**	setting, and the search and translate patterns.
						;**

						(sprintf info "%d %d %d %d %d\n" _dir _reg_exp _block_search _t_dir _check_warnings)
						(insert info)

						;**
						;**		The search and translate patterns could,
						;**	potentially, have newline characters in them.
						;**	The _remove_newlines subroutine replaces those
						;**	newline characters with \n, the regular expression
						;**	that means "newline".
						;**

						(insert (_remove_newlines _s_pat))
						(insert (_remove_newlines _t_pat))
						(insert (_remove_newlines _r_pat))

						;**
						;**		Now we call the _save_state macro to save the
						;**	remainder of the state information.  Note that
						;**	this macro can be replaced to extend restore's
						;**	capabilities.
						;**

						(_save_state start_buf_id)
						(set_buffer save_buf_id)

						;**
						;**		Finally, we write the restore file to disk.
						;**	Since we don't want backup files created, we
						;**	turn those off.  We put it back the way it was
						;**	before exiting, since other macros could run
						;**	once we're through.
						;**

						(= old_backup (set_backup FALSE))
						(write_buffer)
						(set_backup old_backup)
						(delete_buffer save_buf_id)
						(set_buffer start_buf_id)
					)
				)
			)
		)
	)
)

;**
;**		_save_state:
;**
;**		This macro gets called to save the variable length
;**	state information.  Other macros can replace it to
;**	save additional information.
;**

(macro _save_state
	(
		(int		save_buf_id
					start_buf_id
					curr_buf_id
		)
		(string	info)

		;**
		;**		Now that the global state information is
		;**	saved, we insert the file separator and loop
		;**	through the buffer list.
		;**
		;**		This loop goes through each non-system buffer
		;**	in the buffer list, using (set_buffer) and (next_buffer).
		;**	Note that we skip over the first buffer and save
		;**	it last:  this ensures that the buffer list is
		;**	restored in the correct order when it comes time to do
		;**	so.
		;**
		;**		We skip the system buffer manually, rather than
		;**	with the (next_buffer) parameter, because we could
		;**	have been entered with the current buffer being a
		;**	system buffer.  If this were the case, and we used
		;**	(next_buffer), we would never come back to the starting
		;**	buffer and would infinite loop.
		;**
		;**

		(get_parm 0 start_buf_id)
		(= save_buf_id (inq_buffer))

		(insert "[FILES]")

		(set_buffer start_buf_id)

		(while (!= start_buf_id curr_buf_id)
			(
				(set_buffer (= curr_buf_id (next_buffer 1)))

				(if (! (inq_system))
					(
						(int	i
								temp_buf
								line
								col
						)
						(inq_names info)
						(inq_position line col)

						(set_buffer save_buf_id)
						(sprintf info "\n%s\n%u %u" info line col)
						(insert info)
						(= info "")

						(while (< i 10)
							(
								(if (&& (goto_bookmark i temp_buf line col) (== temp_buf curr_buf_id))
									(sprintf info "%s %d %u %u" info i line col)
								)
								(++ i)
							)
						)
						(insert info)
					)
				)
				(set_buffer curr_buf_id)
			)
		)
	)
)

;**
;**		.rst:
;**
;**		This macro is, quite frankly, a mite strange.  When the
;**	user types "b" with no arguments, BRIEF automatically loads
;**	the file specified by the BFILE environment variable.  If
;**	that file has the extension ".rst", this macro runs.
;**
;**		This macro then restores the files that were active
;**	during the last editing session.  The state file buffer
;**	(specified in the BFILE) isn't deleted -- the restore macro,
;**	which runs after the file loading sequence, does that after
;**	restoring the state of the search and translate variables.
;**

(macro .rst
	(
		(string	file_name)

		;**
		;**		We need the name of the current file for the next test.
		;**	All we need is the buffer name, which is the last parameter.
		;**	The NULL placeholder is used to omit the additional information.
		;**

		(inq_names NULL NULL file_name)

		;**
		;**		This logic only makes sense the first time this
		;**	file extension macro is called.  If we're running
		;**	it for the second time, or the file isn't the same
		;**	as the state file (maintained in the BFILE environment
		;**	variable), we skip it.  Initialization logic for "real"
		;**	.rst files can be placed in the "true" clause of the
		;**	if statement (replacing or supplementing the (tabs)
		;**	statement).
		;**
		;**		We use "index" here because the only thing we really
		;**	care about is that the file name matches the name of the
		;**	file specified in BFILE -- remember that the path specified
		;**	could be relative.
		;**

		(if (! (&& (first_time) (index (lower (inq_environment "BFILE")) file_name)))
			(tabs 9)
		;else
			(
				(int	buffer_id
						current_buffer
						line
						col
						old_msg_level
				)
				(string file_line)

				(= old_msg_level (inq_msg_level))

				;**
				;**		BRIEF has already edited the state file (because
				;**	of normal BFILE processing) and made it the current
				;**	buffer.  We get its buffer id for future use, search
				;**	for the [FILES] string that tells us where the file
				;**	data starts, and process the file information, which
				;**	is in the following format (each field is on a separate
				;**	line):
				;**
				;**	 Full, qualified path of the file name.
				;**	 Line number.
				;**	 Column number.
				;**

				(= buffer_id (inq_buffer))

				;**
				;**		Note that if the telltale [FILES] string isn't
				;**	found, we can't process the .rst file.
				;**

				(if (search_fwd "[FILES]" 0)
					(
						(down)
				
						;**
						;**		Here's the loop that processes the file
						;**	information.  We continue restoring files
						;**	until there's no more information in the
						;**	file to restore (signaled by EOF).
						;**
						;**		Note that the macro that saved the state
						;**	does so in such a way that the files are in
						;**	reverse order -- the last file in the .rst
						;**	file is the one that was current when the
						;**	user left BRIEF.
						;**

						(while (! (inq_position))
							(
								(= file_name (trim (read)))
								(down)
								(= line (atoi (= file_line (trim (ltrim (compress (read)))))))
								(= col (atoi (substr file_line (+ (index file_line " ") 1))))
								(down)

								;**
								;**		The edit_file call is used to load
								;**	the file back in because it deals with
								;**	all the details of attaching the buffer
								;**	to the window, calling the proper init
								;**	macros, setting the current buffer, etc.
								;**
								;**		If the call to edit_file fails, we
								;**	know something has gone wrong.  So we
								;**	ignore this file and continue to the
								;**	next.
								;**

								(set_msg_level 0)

								(if (> (edit_file file_name) 0)
									(
										(move_abs line col)
										(= current_buffer (inq_buffer))

										;**
										;**		At this point, the restored
										;**	file has been made the current
										;**	buffer.  We have to make our
										;**	state file current so the top
										;**	of the loop works correctly.
										;**

										(set_buffer buffer_id)
									)
								)
								(set_msg_level old_msg_level)
							)
						)
						;**
						;**		If any files were restored properly, we
						;**	set the current buffer to the buffer in the
						;**	current window.  And we're done!
						;**

						(if current_buffer
							(set_buffer current_buffer)
						)
					)
				)
			)
		)
	)
)

;**
;**		restore:
;**
;**		This macro restores the state of the search and translate
;**	global variables, as well as the list of bookmarks for each
;**	currently edited file.
;**
;**		Note that if the ".rst" macro ran when BRIEF was started,
;**	the state file (BFILE) has already been loaded.  In this case,
;**	(create_buffer) just gives us its buffer ID, and doesn't bother
;**	loading the file again.
;**

(macro restore
	(
		(if (first_time)
			(
				(string file_name)

				;**
				;**		First, we register the macro that will end up
				;**	saving the state of the session for the next time
				;**	around.
				;**

				(register_macro REG_EXIT_ACTION "save_state")

				;**
				;**		If this macro runs, and no BFILE is specified,
				;**	we can't restore the state (you can't restore
				;**	what isn't there).  So we put up an error message
				;**	and exit.  If the file doesn't exist, we don't
				;**	proceed -- once again there's nothing to restore!
				;**

				(if (== (= file_name (lower (inq_environment "BFILE"))) "")
					(error "No BFILE specified, state not restored.")
				;else
					(if (exist file_name)
						(
							(int	buffer_id
									old_buffer
							)
							(string	file_line)

							;**
							;**		Before we make the state file buffer current,
							;**	we have to ensure the old buffer (which is
							;**	in the main window) is saved away.  Before
							;**	we exit the macro, we have to reset it --
							;**	otherwise, BRIEF gets very unhappy.
							;**

							(= old_buffer (inq_buffer))

							;**
							;**		If the buffer creation fails ((create_buffer)
							;**	returns 0), we tell the user about the problem
							;**	and stop.  Otherwise, we continue with the restore.
							;**

							(if (! (= buffer_id (create_buffer "Restore" file_name)))
								(error "Invalid BFILE specified.")
							;else
								(
									;**
									;**		Here we make the restore buffer current
									;**	and parse the information in the state file.
									;**	This information is in the following format,
									;**	with each group on a separate line:
									;**
									;**	 The search direction, regular expression setting,
									;**	  search block setting, translate direction and
									;**	  warnings-only compile setting.
									;**	 The search pattern.
									;**	 The translate pattern.
									;**	 The replacement string.
									;**
									;**		No error checking is done on the results
									;**	of the parse:  if the numbers aren't right,
									;**	the (atoi) call will fail and everything will
									;**	default to 0 (if the strings don't exist,
									;**	they'll be null).
									;**	

									(set_buffer buffer_id)
									(top_of_buffer)
									(= file_line (trim (ltrim (compress (read)))))
									(= _dir (atoi file_line))
									(= file_line (substr file_line (+ (index file_line " ") 1)))
									(= _reg_exp (atoi file_line))
									(= file_line (substr file_line (+ (index file_line " ") 1)))
									(= _block_search (atoi file_line))
									(= file_line (substr file_line (+ (index file_line " ") 1)))
									(= _t_dir (atoi file_line))
									(= file_line (substr file_line (+ (index file_line " ") 1)))
									(= _check_warnings (atoi file_line))
									(down)

									;**
									;**		Note that we can't use (trim) here --
									;**	the saved string could have trailing spaces.
									;**

									(= _s_pat (read))
									(= _s_pat (substr _s_pat 1 (- (strlen _s_pat) 1)))
									(down)
									(= _t_pat (read))
									(= _t_pat (substr _t_pat 1 (- (strlen _t_pat) 1)))
									(down)
									(= _r_pat (read))
									(= _r_pat (substr _r_pat 1 (- (strlen _r_pat) 1)))

									;**
									;**		Now we call the _restore macro to finish
									;**	up the restoration.  Note that this macro
									;**	can be replaced to extend restore's
									;**	capabilities.
									;**

									(_restore old_buffer)
									(set_buffer buffer_id)

									;**
									;**		Here we make sure the state file buffer
									;**	isn't the same as the buffer that was current
									;**	when we entered the macro.  This shouldn't
									;**	happen, but it could.
									;**

									(if (!= old_buffer buffer_id)
										(
											(set_buffer old_buffer)
											(delete_buffer buffer_id)
										)
									)
								)
							)
						)
					)
				)
			)
		)
	)
)

;**
;**		_restore:
;**
;**		This macro restores the variable editing information.
;**	It can be replaced by the user to extend restore's
;**	capabilities.
;**

(macro _restore
	(
		(int	save_buf_id)

		;**
		;**		Now, we restore the list of bookmarks.
		;**	We check to see if each buffer in the file
		;**	list is being editing in this session.  If
		;**	so, its bookmarks are restored.
		;**

		(= save_buf_id (inq_buffer))
		(top_of_buffer)

		(if (search_fwd "[FILES]" 0)
			(
				(int		bookmark_num
							loc
							curr_buf
							line
							col
				)
				(string	file_line)

				(down)
				(= curr_buf (next_buffer 1))

				(while (!= curr_buf save_buf_id)
					(
						(set_buffer curr_buf)

						(if (! (inq_system))
							(
								(inq_names file_line)
								(set_buffer save_buf_id)
								(save_position)

								(if (search_fwd file_line 0)
									(
										(down)
										(= file_line (trim (ltrim (compress (read)))))
										(= file_line (substr file_line (+ (index file_line " ") 1)))

										(while (= loc (index file_line " "))
											(
												(= bookmark_num (atoi (= file_line (substr file_line (+ loc 1)))))
												(= line (atoi (= file_line (substr file_line (+ (index file_line " ") 1)))))
												(= col (atoi (= file_line (substr file_line (+ (index file_line " ") 1)))))
												(drop_bookmark bookmark_num "y" curr_buf line col)
											)
										)
									)
								)
								(restore_position)
								(set_buffer curr_buf)
							)
						)
						(= curr_buf (next_buffer 1))
					)
				)
				(set_buffer save_buf_id)
			)
		)
	)
)

;**
;**		_remove_newlines:
;**
;**		This macro replaces all newline characters with the
;**	character sequence "\n".  This prevents problems when a
;**	search pattern with a newline in it is inserted.
;**

(macro _remove_newlines
	(
		(int		loc)

		(string	trans_str)

		(get_parm 0 trans_str)

		;**
		;**		This loop checks for newlines in the passed string.  If
		;**	once is found, the string is split into two parts:  the part
		;**	before the newline, and the part after.  The two halves are
		;**	then put back together again, with a newline regular expression
		;**	("\n") in between.
		;**

		(while (= loc (index trans_str "\n"))
			(= trans_str (+ (+ (substr trans_str 1 (- loc 1)) "\\n")
				(substr trans_str (+ loc 1))))
		)
		(returns (+ trans_str "\n"))
	)
)
