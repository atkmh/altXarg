;**
;**		BRIEF -- Basic Reconfigurable Interactive Editing Facility
;**
;**		Written by Dave Nanian and Michael Strickman.
;**

#include	"dialog.h"

;**
;**		buffers.m:
;**
;**		This file contains all of the standard BRIEF macros for buffer
;**	manipulation.
;**
;**		Revision history:
;**		-----------------

;**
;**		buf_list:
;**
;**		This macro provides the user with a list of buffers that can be
;**	manipulated and scrolled through.  It is of interest because it
;**	simulates an array of buffer ids using a system buffer.  Macro
;**	programmers interested in using arrays should examine this code
;**	carefully before implementing an array system of their own.
;**

#define	SYSTEM	1						;** The value to use for system buffers.
#define	NEW_FILE	1						;** The value to use for new file attachments.

(extern	display_file_name
			_bad_key
)

(macro buf_list
	(
		(int			_buf_list			;** Buffer that contains visible list.
						_buf_array			;** Buffer that simulates an array.
						_end_buf				;** The buffer to be attached on exit.
						num_bufs				;** The number of buffers in the list.
						start_buf			;** The buffer we started on.
						curr_buf				;** The buffer we're on (in the loop).
						modified				;** Is the current buffer modified?
						_expert				;** Are we in expert mode?
		)
		(string		file_name			;** The file name of the buffer.
						buffer_name			;** The buffer name.
						file_line			;** Buffer for line to insert.
		)
		(global		_buf_list
						_buf_array
						_end_buf
						_expert
		)
		(if (get_parm 0 _expert)
			(= _expert (! (! _expert)))
		;else
			(= _expert 0)
		)

;**
;**		First, we create the array and list buffers, making sure that they
;**	have the "system" attributes.  We use non-file buffers because this is
;**	temporary information.
;**
;**		The "_buf_list" buffer contains a textual list of all of the non
;**	system buffers currently in memory.  "_buf_array" contains a list of the
;**	corresponding buffer pointers.  Note that the buffer pointers are not
;**	inserted into the buffer as is -- they are converted to string integers
;**	first.  This prevents inserting bad characters like tab, return and EOF.
;**

		(message "Creating buffer list...")

		;**		First, we get the ID of the current buffer -- we have to
		;**	restore it at the end of the macro.  After that, we create the
		;**	array buffer and put it aside for the moment.  Note that the
		;**	array buffer is a non-file buffer -- this prevents disk accesses
		;**	since the file is held completely in memory.

		(= start_buf (= _end_buf (inq_buffer)))
		(= _buf_array (create_buffer "Buffer Array" NULL SYSTEM))

		;**		Now, we create the buffer that the user will actually see on
		;**	the screen, set it to be the current buffer, and set the tabs to
		;**	the values we want (tabs default to every column).

		(= _buf_list (create_buffer "Buffer List" NULL SYSTEM))
		(set_buffer _buf_list)
		(tabs 5)

		;**		This loop creates both buffer lists:  the non-system buffers
		;**	are looped through and information about them are culled and added
		;**	to the list.

		(while (!= start_buf curr_buf)
			(
				(if (! curr_buf)
					(= curr_buf start_buf)
				;else
					(
						(set_buffer _buf_list)
						(insert "\n")
						(set_buffer _buf_array)
						(insert "\n")
					)
				)
				(++ num_bufs)
				(message "Creating buffer list [#%d]..." num_bufs)
				(set_buffer curr_buf)
				(inq_names file_name NULL buffer_name)
				(= modified (inq_modified))
				(set_buffer _buf_list)

				(if (! _expert)
					(
						(sprintf file_line "%d)\tBuffer \"%s\" has " num_bufs buffer_name)
						(insert file_line)
						(sprintf file_line "%sbeen modified.\n\tFile: " (if modified "" "not "))
						(insert file_line)
					)
				;else
					(
						(sprintf file_line "%d)\t" num_bufs)
						(insert file_line)
					)
				)
				(insert file_name)

				(if modified
					(insert "*")
				)
				(set_buffer _buf_array)
				(sprintf file_line "%d" curr_buf)
				(insert file_line)
				(set_buffer curr_buf)
				(= curr_buf (next_buffer))
			)
		)
		(message "List created.")

;**
;**		At this point, the array buffer and list buffer have been created
;**	and filled in.  We create a window to display the list in, initialize
;**	the marked area, set up a keymap, and call process.  Process handles
;**	the mainline loop -- we need only provide action routines.
;**

		(create_window 5 17 74 4 " or  to select, E to edit, D to delete, W to write, ESC to exit.")
		(attach_buffer _buf_list)

		(keyboard_push)
		(assign_to_key "<Down-Arrow>" "_buf_down")
		(assign_to_key "<Up-Arrow>" "_buf_up")
		(assign_to_key "<PgUp>" "_buf_pgup")
		(assign_to_key "<PgDn>" "_buf_pgdn")
		(assign_to_key "<Home>" "_buf_home")
		(assign_to_key "<End>" "_buf_end")
		(assign_to_key "<Ctrl-PgUp>" "_buf_home")
		(assign_to_key "<Ctrl-PgDn>" "_buf_end")
		(assign_to_key "d" "_buf_delete")
		(assign_to_key "D" "_buf_delete")
		(assign_to_key "<Ctrl-minus>" "_buf_delete")
		(assign_to_key "e" "_buf_edit")
		(assign_to_key "E" "_buf_edit")
		(assign_to_key "<Alt-e>" "_buf_edit")
		(assign_to_key "W" "_buf_write")
		(assign_to_key "w" "_buf_write")
		(assign_to_key "<Alt-w>" "_buf_write")
		(assign_to_key "<Enter>" "_buf_edit")
		(assign_to_key "<Esc>" "exit")

		(move_abs (- 2 _expert) 100)
		(drop_anchor)
		(move_abs 1 1)
		(set_buffer _buf_array)
		(move_abs 1 1)
		(set_buffer _buf_list)
		(refresh)

		(process)

		;**		Now that we're back from the processing, we pop the keymap that
		;**	we created, raise the assorted anchors, and delete the temporary
		;**	window and the buffers.

		(keyboard_pop)
		(raise_anchor)
		(delete_window)
		(delete_buffer _buf_list)
		(delete_buffer _buf_array)

		;**		If we end with a different buffer than we started with, we
		;**	attach it to the current window and display its file name.
		;**	Otherwise, we set the current buffer back, and call NEW_FILE
		;**	to make sure its defaults are reset.

		(set_buffer _end_buf)
		(inq_names file_name)
		(edit_file file_name)
	)
)

;**
;**		_buf_down:
;**
;**		This routine is called whenever the user presses a down arrow.
;**	It moves the array buffer and list buffer's current lines, ensuring
;**	the user does not go past the end of the buffer.
;**

(macro _buf_down
	(
		(move_rel (- 3 (* _expert 2)) 0)

		(if (inq_position)
			(
				(move_rel (+ -3 (* _expert 2)) 0)
				(return 0)
			)
		;else
			(
				(raise_anchor)
				(drop_anchor 3)
				(move_rel (+ -1 _expert) 0)
				(set_buffer _buf_array)
				(down)
				(set_buffer _buf_list)
				(return 1)
			)
		)
	)
)

;**
;**		_buf_up:
;**
;**		This macro is called whenever the user presses the up arrow.  It
;**	moves up in the list and array buffers, not going past the top of the
;**	buffer.
;**

(macro _buf_up
	(
		(int	line)

		(inq_position line)

		(if (! (up))
			(return 0)
		;else
			(
				(raise_anchor)
				(drop_anchor 3)
				(move_rel (+ -1 _expert) 0)
				(set_buffer _buf_array)
				(move_rel -1 0)
				(set_buffer _buf_list)
				(return 1)
			)
		)
	)
)

;**
;**		_buf_pgup:
;**
;**		This macro is called whenever the user presses PgUp.  It moves up
;**	one screen in the list and array buffers, not going past the top of the
;**	buffer.
;**

(macro _buf_pgup
	(
		(int	num_lines)

		(= num_lines (* 6 (+ _expert 1)))

		(while num_lines
			(
				(_buf_up)
				(-- num_lines)
			)
		)
	)
)

(macro _buf_home
 	(while (_buf_up))
)

;**
;**		_buf_pgdn:
;**
;**		This macro is called whenever the user presses PgDn.  It moves
;**	down one page/screen in the buffer list and the array.
;**

(macro _buf_pgdn
	(
		(int		num_lines)

		(= num_lines (* 6 (+ _expert 1)))

		(while num_lines
			(
				(_buf_down)
				(-- num_lines)
			)
		)
	)
)

(macro _buf_end
	(while (_buf_down))
)

;**
;**		_buf_delete:
;**
;**		This routine is called when the user wants to delete a buffer.
;**	It makes sure the buffer is not in a window, and prompts the user
;**	if the buffer has been modified.
;**

(macro _buf_delete
	(
		(int	buf_to_delete
				ret_code
		)
		(string	misc_str)

		(set_buffer	_buf_array)
		(= buf_to_delete (atoi (read)))
		(set_buffer buf_to_delete)
		(= misc_str "y")

		(if (! (inq_views))
			(
				(if (inq_modified)
					(
						(keyboard_flush)

						(if (! (get_parm NULL misc_str "This buffer has not been saved.  Delete [ynw]? " 1))
							(= misc_str "n")
						)
					)
				)
				(if (|| (index "yY" misc_str) (&& (index "wW" misc_str) (> (_buf_write) 0)))
					(
						(set_buffer _buf_list)
						(delete_line)

						(if (! _expert)
							(delete_line)
						)
						(set_buffer _buf_array)
						(delete_line)
						(delete_buffer buf_to_delete)
						(set_buffer _buf_list)

						(if (inq_position)
							(_buf_up)
						;else
							(
								(raise_anchor)
								(move_rel (- 1 _expert) 0)
								(drop_anchor 3)
								(move_rel (+ -1 _expert) 0)
							)
						)
					)
				;else
					(if (! (index "wW" misc_str))
						(message "Buffer not deleted.")
					)
				)
			)
		;else
			(error "You can't delete a viewed buffer.")
		)
		(set_buffer _buf_list)
	)
)

;**		_buf_edit:
;**
;**		This routine is called when the user is on a buffer that he wants
;**	to edit.  It sets the global "_end_buf" variable to the current
;**	line's buffer, and calls exit so no further processing takes place.
;**

(macro _buf_edit
	(
		(set_buffer _buf_array)
		(= _end_buf (atoi (read)))
		(set_buffer _buf_list)
		(exit)
	)
)

;**
;**		_buf_write:
;**
;**		This routine is called when the user wants to write a modified
;**	buffer.  It makes sure the buffer is modified -- if so, it's written
;**	and the information in the window is updated.
;**

(macro _buf_write
	(
		(int	old_msg_level
				ret_code
		)

		(set_buffer	_buf_array)
		(set_buffer (atoi (read)))

		(if (inq_modified)
			(
				(= old_msg_level (inq_msg_level))
				(set_msg_level 0)

				(if (> (= ret_code (write_buffer)) 0)
					(
						(set_msg_level old_msg_level)
						(set_buffer _buf_list)

						(if (! _expert)
							(
								(search_fwd "has \\c")
								(insert "not ")
								(down)
							)
						)
						(end_of_line)
						(backspace)
						(move_rel (+ -1 _expert) -100)
					)
				;else
					(set_msg_level old_msg_level)
				)
			)
		;else
			(error "Buffer not modified.")
		)
		(set_buffer _buf_list)
		(returns ret_code)
	)
)

;**
;**		edit_file:
;**
;**		This macro replaces the built-in edit_file function:  it displays
;**	the file name of the edited file if the edit operation was successful.
;**

(replacement edit_file
	(
		(int	ret_code
				old_msg_level
		)
		(= old_msg_level (inq_msg_level))

		(if (== (inq_called) "")
			(set_msg_level 0)
		)
		(= ret_code (edit_file))
		(set_msg_level old_msg_level)

		(if (== ret_code 1)
			(display_file_name)
		)
		(return ret_code)
	)
)

;**
;**		edit_next_buffer:
;**
;**		Edits the next buffer in the buffer list in the current window.  If
;**	there are no other buffers, an error message is displayed.
;**

(macro edit_next_buffer
	(
		(string	file_name)

		(int		new_buffer)

		(= new_buffer (next_buffer))

		(if (!= new_buffer (inq_buffer))
			(
				(set_buffer new_buffer)
				(inq_names file_name)
				(edit_file file_name)
			)
		;else
			(error "No other buffers.")
		)
	)
)

;**
;**		edit_prev_buffer:
;**
;**		Edits the previous buffer in the buffer list.
;**

(macro edit_prev_buffer
	(
		(string	file_name)

		(int		old_buffer)

		(= old_buffer (inq_buffer))

		(while (!= (next_buffer) old_buffer)
			(set_buffer (next_buffer))
		)
		(if (!= (inq_buffer) old_buffer)
			(
				(inq_names file_name)
				(edit_file file_name)
			)
		;else
			(error "No other buffers.")
		)
	)
)

;**
;**		delete_curr_buffer:
;**
;**		This function deletes the current buffer, if it is unmodified,
;**	there is another buffer in the list to replace it, and it is only
;**	visible in one window.
;**
;**		If the buffer is modified, the user is asked if he really wants to
;**	delete the buffer.  If he answers yes, the deletion is performed.
;**
;**		If there are no other buffers, or the buffer is in more than one
;**	window, the deletion is not performed.
;**

(macro delete_curr_buffer
	(
		(int			old_buf_id
						new_buf_id
		)
		(string		reply
						file_name
		)
		(= old_buf_id (inq_buffer))
		(= new_buf_id (next_buffer))

		(if (== old_buf_id new_buf_id)
			(
				(error "Can't delete: no other buffers.")
				(return 0)
			)
		)
		(if (!= (inq_views) 1)
			(
				(message "Can't delete: buffer is in multiple windows.")
				(return 0)
			)
		)
		(if (inq_modified)
			(
				(keyboard_flush)

				(if (! (get_parm NULL reply "This buffer has not been saved.  Delete [ynw]? " 1))
					(return 0)
				;else
					(if (|| (! (strlen reply)) (! (index "yYwW" reply)))
						(
							(message "Buffer not deleted.")
							(return 0)
						)
					)
				)
				(if (index "wW" reply)
					(
						(int	old_msg_level
								ret_code
						)
						(= old_msg_level (inq_msg_level))
						(set_msg_level 0)
						(= ret_code (write_buffer))
						(set_msg_level old_msg_level)
						
						(if (<= ret_code 0)
							(return 0)
						)
					)
				)
			)
		)
		(set_buffer new_buf_id)
		(inq_names file_name NULL)
		(set_buffer old_buf_id)
		(edit_file file_name)
		(delete_buffer old_buf_id)
		(return 1)
	)
)

;**
;**		_bad_key:
;**
;**		This routine adds menus to some prompts.
;**

(replacement _bad_key
	(
		(int	key_pressed)

		(= key_pressed (read_char))

		(if (&& (== (inq_command) "goto_bookmark") (== key_pressed (key_to_int "<Tab>")))
			(return (_bookmark_menu))
		)
		(push_back key_pressed)
		(return (_bad_key))
	)
)

;**
;**		_bookmark_menu:
;**
;**		This routine actually handles the "invalid keystroke" event
;**	when in the bookmark prompt.
;**

(macro _bookmark_menu
	(
 		(int	menu_buf
 				old_buf
 				curr_buf
				line
				col
				i
				num_bookmarks
				_bookmark
		)
		(string	bookmark
					file_name
		)
		(global	_bookmark)

		(while (< i 10)
			(
				(if (goto_bookmark i curr_buf line col)
					(++ num_bookmarks)
				)
				(++ i)
			)
		)
		(if (== num_bookmarks 0)
			(beep)
		;else
			(
				(int	num_lines
						num_cols
						lx
						by
						rx
						ty
				)
				(= old_buf (inq_buffer))
				(sprintf bookmark "%d bookmark%s" num_bookmarks (if (== num_bookmarks 1) "" "s"))
				(set_buffer (= menu_buf (create_buffer bookmark NULL SYSTEM)))
				(= num_bookmarks 0)
				(= i 1)
				(tabs 2 13 19 25 80)

				(while (<= i 10)
					(
						(if (goto_bookmark i curr_buf line col)
							(
								(if (== (++ num_bookmarks) 1)
									(insert "\n\tBookmark\tLine\tCol\tFile\n\t--------\t----\t---\t----")
								)
								(insert "\n")
								(set_buffer curr_buf)
								(inq_names file_name)
								(sprintf bookmark "\t%d\t%d\t%d\t%s\t;" i line col file_name)
								(sprintf bookmark "%s%d" bookmark i)
								(set_buffer menu_buf)
								(insert bookmark)
							)
						)
						(++ i)
					)
				)
				(set_buffer old_buf)

				(= _bookmark -1)
				(inq_screen_size num_lines num_cols)

				(/= num_lines 2)
				(/= num_cols 2)

				(= lx (- num_cols 36))
				(= rx (+ num_cols 36))
				(= ty (- num_lines (+ 4 (/ (+ num_bookmarks 4) 2))))
				(= by (+ ty (+ num_bookmarks 5)))

				(_process_menu lx by rx ty NULL
									" or  to move, <Enter> to select, <Esc> to exit"
									NULL menu_buf "_bookmark_action" TRUE)

				(if (>= _bookmark 0)
					(
						(sprintf bookmark "%d" _bookmark)
						(push_back (key_to_int "<Enter>"))
						(return bookmark)
					)
				)
			)
		)
 		(returns (inq_cmd_line))
	)
)

;**
;**		_bookmark_action:
;**
;**		This is the action routine for the dialog manager.
;**

(macro _bookmark_action
	(
		(int	event_type)

		(string	button_text)

		(get_parm 0 event_type)

		(switch event_type

			DIALOG_MOVE_MENU
				(
					(get_parm 2 button_text)

					(if (index button_text ";")
						(returns TRUE)
					;else
						(returns FALSE)
					)
				)
			DIALOG_PICK_MENU
			NULL
			DIALOG_F10
				(
					(get_parm 2 button_text)
					(= _bookmark (atoi (substr button_text (+ (rindex button_text ";") 1))))
					(_dialog_esc)
					(returns TRUE)
				)
		)
	)
)
