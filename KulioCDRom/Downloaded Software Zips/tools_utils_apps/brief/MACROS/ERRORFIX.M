;**
;**		BRIEF -- Basic Reconfigurable Interactive Editing Facility
;**
;**		Written by Dave Nanian and Michael Strickman.
;**

;**		errorfix.m
;**
;**		This file contains the main driver and support macros for BRIEF's
;**	error location facility.
;**

#define	TRUE			1
#define	FALSE			0

#define	WARNING		1
#define	ERROR			2

(extern	add_to_path
			center_line
			_exit
)

;**
;**		next_error:
;**
;**		This routine is the engine for BRIEF's error location facility.  It
;**	reads in the error file and calls the appropriate routines to display
;**	either an individual error message or a window full of error message
;**	information.
;**
;**		If no parameter (or zero) is passed to next_error, the error file is
;**	read into a buffer and searched for error messages.  If the buffer is
;**	empty, the message "No errors." is displayed and the error buffer is
;**	removed.  If the buffer is not empty, and a message can be located, the
;**	text of the message is displayed on the message line, the cursor is placed
;**	on the first non-blank character of the line containing the error, and that
;**	line is centered in the window.  If no messages can be located, the error
;**	file is presented in a pop-up window.
;**
;**		If a "1" is passed to next_error, the error information is displayed in
;**	a window, with the current message highlighted.  If no messages could be
;**	recognised, the highlight is not displayed, and the cursor can be moved
;**	anywhere within the file.
;**
;**		If a "2" is passed to next_error, the error file is tested to see if
;**	any messages can be recognised.  If so, the same action is taken as with
;**	next_error 0.  If not, no message is displayed and the error file buffer
;**	is deleted.
;**
;**		In all cases, next_error returns 0 if no error was found, and non-zero
;**	if there was an error.
;**

(macro next_error
	(
		(int		error_buf
					curr_buf
					line
					col
					error_type
					more_errors
					prev_errors
					errors_exist
					action
					windowed
					_cancel_errorfix
		)
		(string	error_msg
					error_file
					buf_name
					parms
					error_extension
		)
		(global	_cancel_errorfix)

		(inq_names error_file error_extension buf_name)
		(= curr_buf (inq_buffer))
		(= _cancel_errorfix FALSE)

		(if (strlen error_extension)
			(= error_file (substr error_file 1 (- (rindex error_file ".") 1)))
		)
		(+= error_file ".err")
		(= error_extension (+ "." error_extension))
		(= parms (+ (+ error_extension " ") buf_name))

		(if (! (= error_buf (create_buffer "Error File" error_file TRUE)))
			(return FALSE)
		)
		(set_buffer error_buf)

		(save_position)
		(top_of_buffer)
		(= errors_exist (end_of_buffer))
		(restore_position)
		(get_parm 0 action)

		(if (! errors_exist)
			(
				(if (!= action 2)
					(message "No errors.")
				)
			)
		;else
			(
				(= windowed (== action 1))
				(save_position)
				(= more_errors (execute_macro (+ "_call_next " parms)))

				(if (&& more_errors windowed)
					(execute_macro (+ "_call_prev " parms))
				;else
					(
						(down)
						(save_position)
						(= prev_errors (execute_macro (+ "_call_prev " parms)))
						(restore_position)
						(restore_position)
						(save_position)
					)
				)
				(= errors_exist (|| more_errors prev_errors))

				(if (= windowed (&& (!= action 2) (|| windowed (! errors_exist))))
					(
						(int	lines
								cols
						)
						(keyboard_push)
						(assign_to_key "<Enter>" "_exit")
						(assign_to_key "<Esc>" "_error_cancel")
						(assign_to_key "<Left>" "left")
						(assign_to_key "<Right>" "right")
						(assign_to_key "<Home>" "beginning_of_line")
						(assign_to_key "<End>" "end_of_line")

						(if errors_exist
							(
								(drop_anchor 3)
								(assign_to_key "<Up>" (+ "_call_prev " parms))
								(assign_to_key "<Down>" (+ "_call_next " parms))
							)
						;else
							(
								(assign_to_key "<Up>" "up")
								(assign_to_key "<Down>" "down")
							)
						)
						(beginning_of_line)
						(inq_screen_size lines cols)
						(create_window 5 (- lines 4) (- cols 5) 3 " or  to move, <Enter> to select, <Esc> to exit")
						(attach_buffer error_buf)
						(refresh)
						(process)

						(if errors_exist
							(raise_anchor)
						)
						(delete_window)
						(set_buffer curr_buf)
						(keyboard_pop)
						(set_buffer error_buf)
					)
				)
				;**
				;**		At this point the cursor is pointing at the requested error
				;**	message.  If the user didn't cancel, we display the chosen message
				;**	and move the cursor to the appropriate line.
				;**

				(restore_position errors_exist)

				(if (! _cancel_errorfix)
					(
						(if (! (inq_macro (+= error_extension "_error_info")))
							(= error_extension "_error_info")
						)
						(if
							(&&
								(|| (&& windowed errors_exist) more_errors)
								(= error_type (execute_macro error_extension buf_name line col error_msg curr_buf))
							)
							(
								(set_buffer curr_buf)

								(if (> error_type 0)
									(
										(goto_old_line line)
										(center_line)

										(if col
											(move_abs 0 col)
										;else
											(
												(beginning_of_line)
												(next_char (- (strlen (trim (read))) (strlen (ltrim (trim (read))))))
											)
										)
									)
								)
								(if (|| (== error_type ERROR) (== (* error_type -1) ERROR))
									(error error_msg)
								;else
									(message error_msg)
								)
							)
						;else
							(
								(if windowed
									(message (trim (ltrim (read))))
								;else
									(if errors_exist
										(message "No more errors.")
									)
								)
							)
						)
					)
				)
			)
		)
		(set_buffer curr_buf)

		(if (&& (! (inq_views error_buf)) (&& (! more_errors) (! windowed)))
			(delete_buffer error_buf)
		)
		(if _cancel_errorfix
			(message "")
		)
		(returns more_errors)
	)
)

;**
;**		_call_next:
;**
;**		This macro is used to call the _next_error function.  It checks to
;**	see if there is a file extension specific function first.  If not, it
;**	calls the generic function.
;**

(macro _call_next
	(
		(string	error_extension
					file_name
					macro_name
		)
		(int		ret_code
					mark_type
					col
		)
		(if (= mark_type (inq_marked))
			(raise_anchor)
		)
		(get_parm 0 error_extension)
		(get_parm 1 file_name)
		(= macro_name "_next_error")

		(if (inq_macro (+ error_extension macro_name))
			(= macro_name (+ error_extension macro_name))
		)
		(inq_position NULL col)
		(restore_position)
		(= ret_code (execute_macro (+ macro_name (+ " " (+ error_extension (+ " " file_name))))))
		(save_position)
		(move_abs 0 col)

		(if mark_type
			(drop_anchor mark_type)
		)
		(returns ret_code)
	)
)

;**
;**		_call_prev:
;**
;**		This macro is used to call the _prev_error function.  It checks to
;**	see if there is a file extension specific function first.  If not, it
;**	calls the generic function.
;**

(macro _call_prev
	(
		(string	error_extension
					file_name
					macro_name
		)
		(int		ret_code
					mark_type
					col
		)
		(if (= mark_type (inq_marked))
			(raise_anchor)
		)
		(inq_position NULL col)
		(restore_position)
		(save_position)

		(if (up)
			(end_of_line)
		)
		(get_parm 0 error_extension)
		(get_parm 1 file_name)
		(= macro_name "_prev_error")

		(if (inq_macro (+ error_extension macro_name))
			(= macro_name (+ error_extension macro_name))
		)
		(restore_position (! (= ret_code (execute_macro (+ macro_name (+ " " (+ error_extension (+ " " file_name))))))))
		(save_position)
		(move_abs 0 col)

		(if mark_type
			(drop_anchor mark_type)
		)
		(returns ret_code)
	)
)

(macro _error_cancel
	(
		(= _cancel_errorfix 1)
		(_exit)
	)
)

;**
;**		_next_error, _prev_error, _error_info:
;**
;**		These routines are the default routines for locating error
;**	information.  They can be enhanced with file extension specific
;**	error location functions that are written for a specific compiler.
;**
;**		The _next_error and _prev_error macros move the cursor to the
;**	next and previous error message, respectively.  They return TRUE
;**	if another error message is found, and FALSE otherwise.
;**
;**		_error_info takes a given line in the error buffer (located by
;**	the _next and _previous error routines) and returns the information
;**	needed by BRIEF to locate the error message.  It returns 0 if there
;**	is no error message, 1 if the error is a warning, and 2 if it's an
;**	error.  It also returns the line and column in the file the error
;**	corresponds to, as well as the message that should be displayed at
;**	the bottom of the window.
;**

;**
;**		_next_error, _prev_error:
;**
;**		Both of these routines are passed the extension of the file that
;**	has been compiled and the full file name.  Although the generic
;**	routines don't make use of this information, extension-specific
;**	routines could.
;**

(macro _next_error
	(returns (search_fwd "<*.[a-zA-Z][~ \t\n]@[ \t,(:][ \t]@{line }@\\c[0-9]" 1 0))
)

(macro _prev_error
	(returns (search_back "<*.[a-zA-Z][~ \t\n]@[ \t,(:][ \t]@{line }@\\c[0-9]" 1 0))
)

;**
;**		_error_info:
;**
;**		This routine parses a given error line and returns information
;**	about it.  It is passed the following parameters:
;**
;**		Parameter				Description
;**		---------            -----------
;**			0						The name of the file the error was in.
;**
;**		The following are write-only parameters passed back to the calling
;**	function:
;**
;**		Parameter				Description
;**		---------				-----------
;**			1						The line of the file the error was on.
;**			2						The column of the file the error was on.
;**									If 0 is passed back, the first non-blank
;**									character is assumed.
;**			3						The actual error message, minus any useless
;**									information.
;**
;**		Finally, this last parameter is the buffer identifier of the source
;**	buffer.
;**
;**		Parameter				Description
;**		---------				-----------
;**			4						The buffer identifier of the source buffer.
;**
;**		_error_info returns an integer corresponding to the level of the
;**	error encountered.
;**
;**		Error Code				Meaning
;**		----------				-------
;**			0 						No error
;**			1						Warning error in source file
;**			-1						Warning error in another file
;**			2						"Normal" error in source file
;**			-2						"Normal" error in another file
;**
;**		This information is used by the next_error driver to determine
;**	how to display the message.
;**

(macro _error_info
	(
		(int	error_level
				error_line
		)
		(string	error_text
					error_file
		)
		(get_parm 0 error_file)

		(if (! (= error_line (atoi (read 10))))
			(if (== "0" (read 1))
				(= error_line 1)
			;else
				(return FALSE)
			)
		)
		(save_position)
		(beginning_of_line)
		(= error_text (trim (ltrim (read))))
		(restore_position)

		(= error_level (+ WARNING (! (index (lower error_text) "warning"))))

		(if (index (lower error_text) error_file)
			(
				(= error_text (trim (ltrim (read))))
				(= error_text (substr error_text (search_string "['`\"a-zA-Z]" error_text)))
			)
		;else
			(*= error_level -1)
		)
		(put_parm 1 error_line)
		(put_parm 2 0)
		(put_parm 3 error_text)
		(returns error_level)
	)
)
