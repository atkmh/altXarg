;**
;**		BRIEF -- Basic Reconfigurable Interactive Editing Facility
;**
;**		Written by Dave Nanian and Michael Strickman.
;**

;**
;**		prompt.m:
;**
;**		This file contains routines that deal with prompt responses.  This
;**	includes the prompt history function and file name completion.
;**
;**		The history macro keeps track of all the >1 character responses
;**	made to prompts throughout the system.  They can then be retrieved
;**	using the up and down arrow keys at the prompt.
;**
;**		The complete macro expands file names at the edit_file, read_file,
;**	load_macro, and delete_macro prompts (as well as prompts that a
;**	user has added to the list).  If a file name is ambiguous, it
;**	pops up a menu of choices.
;**

#include "dialog.h"

#define	COMPLETION_COMMANDS			" edit_file read_file load_macro delete_macro "
#define	DIRECTORY						0x10

;**
;**		_init:
;**
;**		When history is loaded, this macro creates the buffer that retains the
;**	history information.  Note that this is a non-file system buffer.
;**

(macro _init
	(
		(string	_last_response)

		(int	_history_buf)

		(global	_history_buf
					_last_response
		)
		(= _history_buf (create_buffer "History" NULL 1))
		(register_macro 5 "history_exit")
	)
)

;**
;**		history_exit:
;**
;**		This macro zeros the history buffer setting so, once exit has been
;**	chosen (and confirmed), no further history processing is done.
;**

(macro history_exit
	(= _history_buf 0)
)

;**
;**		_completion_commands:
;**
;**		Returns a list of commands on which file name completion can be
;**	done.  You may replace this macro to add your own commands to the list.
;**

(macro _completion_commands
	(returns COMPLETION_COMMANDS)
)

;**
;**		_prompt_begin:
;**
;**		This macro is called just before a prompt is displayed to the user.
;**	It inserts the current prompt information to keep things straight, and
;**	then attempts to locate previous history information in the buffer.  If
;**	this information is found, the cursor is left there.  If not, the cursor
;**	is left at the top of the file.
;**

(macro _prompt_begin
	(
		(if _history_buf
			(
				(int	old_buf
						old_msg_level
				)
				(string	curr_prompt
							curr_command
				)
				(= old_buf (inq_buffer))
				(= old_msg_level (inq_msg_level))

				(set_msg_level 3)
				(set_buffer _history_buf)

				(save_position)
				(top_of_buffer)
				(get_parm 0 curr_prompt)
				(insert curr_prompt)
				(beginning_of_line)

				(search_fwd (+ "[" (+ (inq_command) (+ "]::[" (+ curr_prompt "]")))) 0)
				(set_buffer old_buf)
				(set_msg_level old_msg_level)
			)
		)
		(returns (inq_cmd_line))
	)
)

;**
;**		_bad_key:
;**
;**		This macro keeps tabs on the "illegal" keys pressed at the prompt.  If
;**	the up or down arrows are pressed, we jump into action, moving around in
;**	the history buffer.  If the bad key is <Tab>, we try to expand the filename.
;**

(macro _bad_key
	(
		(int		key_pressed
					old_buf
					old_msg_level
		)
		(string	command)

		(= command (inq_command))
		(= old_buf (inq_buffer))
		(= old_msg_level (inq_msg_level))

		;**
		;**		If the bad key is a Tab, we check to see if we can complete
		;**	the file name on the command line (if, indeed, the command
		;**	is one of the ones we care about).
		;**

		(if (== (= key_pressed (read_char)) (key_to_int "<Tab>"))
			(
				(if (! (index (_completion_commands) (+ " " (+ command " "))))
					(
						(push_back key_pressed)
						(returns 0)
					)
				;else
					(
						(int		pos
									file_list_buf
									attribute
									fwd_slash
						)
						(string	filespec
									path
						)
						;**
						;**	If BRIEF is using forward slashes in the path name rather
						;**	than backslashes, or the user used forward slashes in his
						;**	current prompt response, we use forward slashes too.
						;**

						(inq_names filespec)
						(= fwd_slash (|| (index filespec "/") (index (inq_cmd_line) "/")))

						;**
						;**	First, we separate the filespec to be expanded into
						;**	path and file parts.
						;**

						(= filespec (trim (inq_cmd_line)))

						(if (= pos (search_string "[:/\\\\][~:/\\\\]@>" filespec NULL TRUE))
							(
								(= path (substr filespec 1 pos))
								(= filespec (substr filespec (++ pos)))
							)
						)

						;**
						;**	If there is no file name on the command line, or if
						;**	there's just a base part with no extension, we look
						;**	for files matching the base plus "*.*".  Otherwise, we
						;**	add a single "*".  (If the user put wildcard
						;**	characters into the file name, we just expand his
						;**	specification.)
						;**

						(if (! (search_string "[?*]" filespec NULL TRUE))
							(if (rindex filespec ".")
								(+= filespec "*")
							;else
								(+= filespec "*.*")
							)
						)
						;**
						;**	Get a list of matching files into a buffer.  Don't count
						;**	directories.  We can use cur_cmd as a work string.  When
						;**	we're done, the cursor will be one line past the last
						;**	file name and cur_cmd will contain the last name matched.
						;**

						(set_buffer (= file_list_buf (create_buffer "Files" NULL TRUE)))
						(file_pattern (+ path filespec))

						(while (find_file filespec NULL NULL NULL attribute)
							(if (!= filespec ".")
								(							
									(if (& attribute DIRECTORY)
										(+= filespec (if fwd_slash "/" "\\"))
									)
									(insert (+ (= command (lower filespec)) "\n"))
								)
							)
						)
						(inq_position pos)
						(delete_line)
						(set_buffer old_buf)

						;**
						;**	If we found exactly one match, update the command line.
						;**	If we found none, beep, but don't change the display.
						;**	If we found multiple matches, let the user choose one
						;**	to return.  If he declines to choose, don't change the
						;**	command line.  Note that we sometimes push back an <End>
						;**	to prevent the command line being highlighted, sometimes
						;**	an <Enter> to force the command to take the argument.
						;**	If the end result is a directory specifier, we push back
						;**	a <Tab> to force expansion on the directory.
						;**

						(if (-- pos)
							(
								(if (== pos 1)							;** Exactly one match.
									(
										(= command (+ path command))
										(push_back (key_to_int "<End>"))
									)
								;else										;** Multiple matches.
									(
										;**
										;**	Compute the screen size of the menu.
										;**

										(inq_screen_size attribute)
										(-= attribute 4)

										(if (<= (= pos (- attribute (+ pos 1))) 0)
											(= pos 1)
										)
										;**
										;**	Turn messages off so we don't overwrite the
										;**	current prompt.  Then pop up the file list.
										;**	The action macro will leave the cursor on
										;**	a ">" marking the current file, if one is
										;**	selected.  ">" is not legal in file names.
										;**

										(set_msg_level 3)
										(_process_menu 15 attribute 30 pos NULL ""
											NULL file_list_buf "complete_action" TRUE)
										(set_msg_level old_msg_level)

										(set_buffer file_list_buf)
										(= command (trim (read)))
										(set_buffer old_buf)

										(if (index command ">")		;** Selected a match.
											(
												(= command (+ path (= filespec (substr command 2))))

												(if (search_string "[/\\\\]" filespec NULL TRUE)
													(push_back (key_to_int "<End>"))
												;else
													(push_back (key_to_int "<Enter>"))
												)
											)
										;else								;** Did not select.
											(
												(= command (inq_cmd_line))
												(push_back (key_to_int "<End>"))
											)
										)
									)
								)
							)
						;else											;** No matches.
							(
								(beep)
								(= command (inq_cmd_line))
								(push_back (key_to_int "<End>"))
							)
						)
						(delete_buffer file_list_buf)
						(returns command)
					)
				)
			)

		;**
		;**		If the bad key wasn't a Tab, we check to see if we have to
		;**	to do history stuff.
		;**

		;else
			(
				(if (! _history_buf)
					(
						(push_back key_pressed)
						(returns 0)
					)
				;else
					(
						(int		line
									pass
						)
						(string	prompt)

						(set_msg_level 3)
						(= old_buf (inq_buffer))
						(set_buffer _history_buf)
						(inq_position line)

						(switch key_pressed

							(key_to_int "<Alt-l>")
								(= prompt _last_response)

							(key_to_int "<Up>")
							NULL
							(key_to_int "<Keypad-Up>")
								(
									(if (!= line 1)
										(
											(while (&& (< pass 2) (|| (! (strlen prompt)) (== prompt (inq_cmd_line))))
												(
													(down)

													(if (|| (inq_position) (index (read) "]::["))
														(
															(++ pass)
															(search_back "]::[" 0)
															(down)
															(beginning_of_line)
														)
													)
													(= prompt (read))
													(= prompt (substr prompt 1 (- (strlen prompt) 1)))
												)
											)
										)
									)
								)
							(key_to_int "<Down>")
							NULL
							(key_to_int "<Keypad-Down>")
								(
									(if (!= line 1)
										(
											(while (&& (< pass 2) (|| (! (strlen prompt)) (== prompt (inq_cmd_line))))
												(
													(if (index (read) "]::[")
														(
															(down)

															(if (search_fwd "]::[" 0)
																(up)
															;else
																(end_of_buffer)
															)
															(beginning_of_line)
														)
													;else
														(up)
													)
													(= prompt (read))

													(if (index prompt "]::[")
														(
															(++ pass)
															(down)

															(if (search_fwd "]::[" 0)
																(up)
															;else
																(end_of_buffer)
															)
															(beginning_of_line)
															(= prompt (read))
														)
													)
													(= prompt (substr prompt 1 (- (strlen prompt) 1)))
												)
											)
										)
									)
								)
						)
						(set_buffer old_buf)
						(set_msg_level old_msg_level)

						(if (strlen prompt)
							(returns prompt)
						;else
							(
								(push_back key_pressed)
								(returns 0)
							)
						)
					)
				)
			)
		)
	)
)

;**
;**		complete_action:
;**
;**		When the user presses <Enter> at the file list menu, mark the
;**	selected file with a greater-than symbol and force an exit from
;**	the menu.  The macro relies on the dialog manager's guarantee that
;**	the cursor position when a button is picked will be the beginning
;**	of the button line in the menu buffer in order to mark the button
;**	in the least amount of time.
;**

(macro complete_action
	(
		(int		event_type)

		(get_parm 0 event_type)

		(if (== event_type DIALOG_PICK_MENU)
			(
				(insert ">")
				(left)
				(_dialog_esc)
			)
		)
		(returns TRUE)
	)
)

;**
;**		_prompt_end:
;**
;**		After the prompting operation has been completed, this macro inserts the
;**	response into the buffer if the prompt hasn't been cancelled and it's more
;**	than one character long (we don't want to bother retaining [ynw] answers).
;**

(macro _prompt_end
	(
		(if _history_buf
			(
				(int	old_buf
						old_msg_level
				)
				(string	response
							prompt
				)
				(= old_msg_level (inq_msg_level))
				(set_msg_level 3)
				(= old_buf (inq_buffer))
				(set_buffer _history_buf)
				(top_of_buffer)

				(= response (inq_cmd_line))
				(= prompt (read))
				(= prompt (substr prompt 1 (- (strlen prompt) 1)))
				(delete_to_eol)

				(if (> (strlen response) 1)
					(
						(= _last_response response)

						(if (!= "Command cancelled." (inq_message))
							(
								(int	start_line
										end_line
								)
								(if (! (search_fwd (+ "[" (+ (inq_command) (+ "]::[" (+ prompt "]")))) 0))
									(
										(end_of_buffer)
										(down)
										(beginning_of_line)
										(insert (+ "[" (+ (inq_command) (+ "]::[" (+ prompt "]")))))
									)
								)
								(down)
								(inq_position start_line)
								(beginning_of_line)
								(insert (+ response (if (inq_position) "" "\n")))
								(move_abs start_line 1)
								(= response (read))

								(if (search_fwd "]::[" 0)
									(up)
								;else
									(end_of_buffer)
								)
								(inq_position end_line)

								(if (>= (- end_line start_line) 10)
									(delete_line)
								)
								(move_abs start_line 1)
								(down)

								(while (&& (! (inq_position)) (! (index (read) "]::[")))
									(
										(if (== response (read))
											(
												(delete_line)
												(break)
											)
										)
										(down)
									)
								)
							)
						)
					)
				)
				(restore_position)
				(set_msg_level old_msg_level)
				(set_buffer old_buf)
			)
		)
		(returns 0)
	)
)
