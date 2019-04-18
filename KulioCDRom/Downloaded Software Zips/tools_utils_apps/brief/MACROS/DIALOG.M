;**
;**		BRIEF -- Basic Reconfigurable Interactive Editing Facility
;**
;**		Written by Dave Nanian and Michael Strickman.
;**

;**
;**		dialog.m:
;**
;**		This file contains all of the standard BRIEF macros for the
;**	dialog and menu manager.
;**
;**		Revision history:
;**		-----------------
;**

#include "dialog.h"

;**
;**		Dialog Manager Package:  Note to Macro Programmers
;**
;**		Input to an interactive macro must ultimately come from the
;**	keyboard.  In addition to the primitive calls for keyboard
;**	handling (assign_to_key, get_parm, read_char, etc.) we have
;**	provided two high-level calls which provide a simple, consistent,
;**	and attractive user interface.  We strongly recommend that you
;**	use the built-in dialog manager calls in your macros instead of
;**	writing your own user interface.
;**

(extern	_exit
			add_to_path
			to_bottom
			center_line
)

;**
;**		init:
;**
;**		Initialize the dialog manager package.  This must always be
;**	the first call to the dialog manager; it is run whenever the
;**	file is loaded.
;**

(macro _init
	(
		(if (first_time)
			(
				(int		_dialog_level
							_dialog_type
							_dialog_row
							_dialog_col
							_dialog_field_keymap
							_dialog_list_keymap
							_dialog_menu_keymap
							_dialog_size
							_dialog_data_buf
							_dialog_disp_buf
							_dialog_mode
				)
				(string	_dialog_action_func
							_dialog_dir
				)
				(global	_dialog_action_func
							_dialog_dir
							_dialog_level
							_dialog_type
							_dialog_row
							_dialog_col
							_dialog_field_keymap
							_dialog_list_keymap
							_dialog_menu_keymap
							_dialog_size
							_dialog_data_buf
							_dialog_disp_buf
							_dialog_mode
				)

				;**	First we get the name of the directory in which the
				;**	menu files and help files are kept.

				(if (! (strlen (= _dialog_dir (inq_environment "BHELP"))))
					(= _dialog_dir "/brief/help")
				)

				;**	We now create 3 keymaps; the only assignments they have
				;**	in common are the grey - and the Esc key.

				;**	Here we create a keymap for use with menus.  Note that
				;**	at every level you can use the INIT and TERM hooks to
				;**	add your own key assignments to this keymap; just
				;**	remember to restore the old assignments, or your keys
				;**	will be wrong when you return to a lower-level menu.

				(keyboard_push)
				(keyboard_typeables)
				(assign_to_key "<Down>" "_dialog_menu_down")
				(assign_to_key "<Space>" "_dialog_menu_down")
				(assign_to_key "<Up>" "_dialog_menu_up")
				(assign_to_key "<Backspace>" "_dialog_menu_up")
				(assign_to_key "<Enter>" "_dialog_menu_pick")
				(assign_to_key "<Esc>" "_dialog_esc")
				(assign_to_key "<Keypad minus>" "_dialog_grey_minus")
				(assign_to_key "<Home>" "_dialog_menu_home")
				(assign_to_key "<Ctrl-Home>" "_dialog_menu_home")
				(assign_to_key "<End>" "_dialog_menu_end")
				(assign_to_key "<Ctrl-End>" "_dialog_menu_end")
				(assign_to_key "<PgUp>" "_dialog_menu_pgup")
				(assign_to_key "<PgDn>" "_dialog_menu_pgdn")
				(= _dialog_menu_keymap (inq_keyboard))
				(keyboard_pop TRUE)

				;**	Here we create a keymap for use with lists.  It also
				;**	contains the general field-to-field key assignments.

				(keyboard_push)
				(keyboard_typeables)
				(assign_to_key "<F10>" "_dialog_f10")
				(assign_to_key "#13" "_dialog_next_and_save")
				(assign_to_key "<Esc>" "_dialog_esc")
				(assign_to_key "<Keypad minus>" "_dialog_grey_minus")
				(assign_to_key "<Tab>" "_dialog_next")
				(assign_to_key "<Down>" "_dialog_next")
				(assign_to_key "<Shift-Tab>" "_dialog_prev")
				(assign_to_key "<Up>" "_dialog_prev")
				(assign_to_key "<Ctrl-Home>" "_dialog_home")
				(assign_to_key "<Ctrl-End>" "_dialog_end")
				(assign_to_key "<Backspace>" "_list_prev")
				(assign_to_key "<Left>" "_list_prev")
				(assign_to_key "<Space>" "_list_next")
				(assign_to_key "<Right>" "_list_next")
				(assign_to_key "<Home>" "_list_home")
				(assign_to_key "<End>" "_list_end")
				(= _dialog_list_keymap (inq_keyboard))
				(keyboard_pop TRUE)

				;**	Here we create a keymap for use with typed fields.
				;**	When we're done, we restore the previous keymap.

				(keyboard_push)
				(assign_to_key "<Backspace>" "_field_bksp")
				(assign_to_key "<Space>" "self_insert")
				(assign_to_key "<Left>" "_field_left")
				(assign_to_key "<Right>" "_field_right")
				(assign_to_key "<Del>" "_field_del")
				(assign_to_key "<Home>" "_field_home")
				(assign_to_key "<End>" "_field_end")
				(assign_to_key "<Alt-k>" "_field_delete_to_eol")
				(assign_to_key "<Alt-d>" "_field_del_line")
				(assign_to_key "<Ins>" "insert_mode")
				(assign_to_key "<Alt-i>" "insert_mode")
				(= _dialog_field_keymap (inq_keyboard))
				(keyboard_pop TRUE)

				;**	Here we register a macro that will be invoked
				;**	whenever a typed character is inserted.  It calls
				;**	one of three special-purpose macros depending on
				;**	whether or not we were in a menu, list or typed field.
				(register_macro 0 "_typeable_key")
			)
		)
	)
)

;**
;**		_remove_dialog_manager:
;**
;**		You should call this macro whenever you are finished using the
;**	dialog manager.  It will free the keymaps created in dialog_manager
;**	and unregister the macro used for going to a menu button by name.
;**	It would be nice to have this function unload the macro file, but
;**	that's for a future release.
;**		Don't call this macro if you plan to use the dialog manager
;**	again in the same session.
;**

(macro _remove_dialog_manager
	(if (first_time)
		(
			(unregister_macro 0 "_typeable_key")
			(keyboard_push _dialog_menu_keymap)
			(keyboard_pop)
			(keyboard_push _dialog_list_keymap)
			(keyboard_pop)
			(keyboard_push _dialog_field_keymap)
			(keyboard_pop)
		)
	)
)


;**
;**		_dialog_f10, _dialog_esc, _dialog_grey_minus:
;**
;**		Call the action function with an appropriate code and exit
;**	from the dialog box, menu, or entire dialog manager.
;**

(macro _dialog_f10
	(
		;**	When the F10 key is pressed, we have to verify the
		;**	current field before we can exit.  This function is
		;**	only used in DIALOG_DBOX_MODE.

		(if (&& (_dialog_exit) (execute_macro _dialog_action_func DIALOG_F10))
			(_exit)
		)
	)
)

(macro _dialog_esc
	(
		(int		curr_level)

		(execute_macro _dialog_action_func DIALOG_ESCAPE)
		(= curr_level _dialog_level)

		(while curr_level
			(
				(_exit)
				(-- curr_level)
			)
		)
	)
)

(macro _dialog_grey_minus
	(
		;**	When the grey - key is pressed, we immediately exit one level.

		(execute_macro _dialog_action_func DIALOG_GREY_MINUS)
		(_exit)
	)
)

;**
;**		_format_dialog:
;**
;**		Parses the information buffer and formats the display buffer,
;**	leaving the display buffer current.
;**

(macro _format_dialog
	(
		(int		pos
					open_paren
		)
		(string	line)

		(set_buffer _dialog_disp_buf)
		(tabs 2)
		(set_buffer _dialog_data_buf)
		(inq_names NULL NULL line)
		(execute_macro _dialog_action_func DIALOG_CREATE_DBOX NULL line)
		(top_of_buffer)

		;**	Display all fields.  We allow white space before the
		;**	format commands in the buffer.

		(while (search_fwd "<[ \\t]@\\c[FLINTS]" TRUE FALSE)
			(
				(= pos (+ (index (= line (_dialog_set_globals)) "\"") 1))
				(= line (substr line pos (- (rindex line "\"") pos)))
				(next_char)

				;**	If we are formatting a list, we first make sure there's
				;**	a current item.  If there isn't, we must skip over the
				;**	field since it could create serious errors later.  If
				;**	there is a current item but it's not the first item,
				;**	we prepend a tab to the list so we'll be able to find
				;**	the first button.  We also stick a tab at the end of the
				;**	list so we can find the end of the last item.

				(if (== _dialog_type LIST)
					(if (= open_paren (index line "("))
						(
							(if (> open_paren 1)
								(= line (+ "\t" line))
							)
							(-- _dialog_col)
							(+= line "\t")
						)
					)
				;else
					(= open_paren TRUE)
				)

				;**	Likewise, if we encounter a field in the data buffer
				;**	that is too long, we delete it and skip over it
				;**	in the formatting process.

				(= pos (- (+ _dialog_col (strlen line)) _dialog_size))

				(if (|| (! open_paren) (> pos 0))
					(
						(if open_paren
							(error "Field %d columns too wide for window." pos)
						;else
							(error "No current item in list.")
						)
						(delete_line)
						(beginning_of_line)
					)
				;else
					(
						(set_buffer _dialog_disp_buf)
						(move_abs _dialog_row _dialog_col)

						;**	This makes sure we're not already past end of line
						;**	if a field is blank to begin with.

						(if (strlen line)
							(insert line)
						;else
							(
								(insert "\t")
								(prev_char)
								(delete_char)
							)
						)
						(set_buffer _dialog_data_buf)
					)
				)
			)
		)
		(top_of_buffer)
		(search_fwd "<[ \\t]@\\c[FLINS]" TRUE FALSE)
		(_dialog_enter)
	)
)


;**
;**		_process_dialog_box:
;**
;**		Creates a dialog box window on the screen and a display
;**	buffer to go in it.  Makes sure an information buffer exists.
;**	Calls _format_dialog to prepare the display buffer.  Then makes
;**	the first field in the dialog box current and highlights it.
;**	Enters interactive mode, calling the user's action function
;**	whenever "interesting" events occur.
;**
;**	When the user exits, this function deletes the display buffer
;**	and dialog box window, deletes the data buffer as well if that
;**	buffer is a system buffer, pops the keymaps that were created,
;**	restores the editing mode and tab/space mode, etc.
;**

(macro _process_dialog_box
	(
		(int		lx
					by
					rx
					ty
					old_buf_id
					created_buffer
					former_type
					former_row
					former_col
					former_size
					former_data_buf
					former_disp_buf
					former_mode
		)
		(string	pathname
					former_action_func
		)

		;**	Save the current value of the global variable _dialog_data_buf.

		(= former_data_buf _dialog_data_buf)

		;**	If we are passed an existing buffer id, we use that buffer;
		;**	if not, but we are passed the name of an existing file,
		;**	we create the buffer.  If we get neither parameter, we
		;**	fail.

		(if (&& (! (get_parm 7 _dialog_data_buf)) (get_parm 6 pathname))
			(
				;**	If the file name is absolute (which we determine by
				;**	the presence of special characters) we don't look for
				;**	it in the BHELP directory.

				(if (! (search_string "[:/\\\\]" pathname NULL TRUE))
					(= pathname (add_to_path _dialog_dir pathname))
				)

				;**	If the file exists, we put it in a buffer.
				
				(if (= created_buffer (exist pathname))
					(= _dialog_data_buf
						(create_buffer "Information" pathname TRUE))
				)
			)
		)

		;**	Make sure that we have a valid buffer id at this point (we
		;**	don't care if both the pathname and buffer id were specified;
		;**	we just want to have something to display).

		(if (! _dialog_data_buf)
			(
				(error "Can't create dialog box.")
				(= _dialog_data_buf former_data_buf)
				(return FALSE)
			)
		)

		(message "Creating dialog box...")

		;**	Here we save the former value of _dialog_action_func
		;**	and increment the _dialog_level counter so recursive
		;**	invocations will know about this one.  We also save
		;**	the values of all the other global variables.

		(++ _dialog_level)
		(= former_action_func _dialog_action_func)
		(= former_type _dialog_type)
		(= former_row _dialog_row)
		(= former_col _dialog_col)
		(= former_size _dialog_size)
		(= former_disp_buf _dialog_disp_buf)
		(= former_mode _dialog_mode)

		(= _dialog_mode DIALOG_DBOX_MODE)

		(= old_buf_id (inq_buffer))

		;**	Here we create a non-file system buffer which we
		;**	can display in the new window.  This buffer will be
		;**	formatted by the information in _dialog_data_buf.
		;**	At this point, the pathname is no longer needed, so we
		;**	put the string to new uses (getting the buffer name
		;**	and later the window-bottom message).

		(get_parm 4 pathname)
		(= _dialog_disp_buf (create_buffer pathname NULL TRUE))

		(get_parm 0 lx)
		(get_parm 1 by)
		(get_parm 2 rx)
		(get_parm 3 ty)
		(get_parm 5 pathname)
		(get_parm 8 _dialog_action_func)
		(= _dialog_size (- (- rx lx) 1))
		(keyboard_push _dialog_list_keymap)

		;**	Now we call _format_dialog to design the display buffer
		;**	and we create a window to put it in.  We postpone
		;**	refreshing the display.

		(_format_dialog)
		(create_window lx by rx ty pathname)
		(attach_buffer _dialog_disp_buf)

		;**	We save the old value of Use Tab Characters in the
		;**	pathname variable, and the old Editing Mode in lx.

		(= lx (inq_mode))
		(= pathname (use_tab_char "n"))

		;**	Call the action function to indicate we are done initializing.
		;**	This is a good place for you to put your own keys into the
		;**	keymap; by default, your key assignments will go into the
		;**	global keymap for both lists and typed fields, but you may
		;**	select one of the local keymaps and put assignments into it
		;**	as long as you change back.  A typical use of this feature
		;**	would be to install a help function by assigning it to Alt-h.
		;**	Don't try to change the basic functioning of either the
		;**	lists or the fields, however.

		(message "Dialog box created.")
		(execute_macro _dialog_action_func DIALOG_INIT)
		(refresh)
		(process)

		(execute_macro _dialog_action_func DIALOG_TERM)

		;**	When we get here (after the user presses one of the three
		;**	keys F10, Esc, and Grey -) we start cleaning up.  First
		;**	we unassociate any current local keymap and pop the
		;**	list keymap.  We preserve both keymaps for future use.

		(use_local_keyboard 0)
		(keyboard_pop TRUE)

		;**	Now we restore some modes.

		(if (!= lx (inq_mode))
			(insert_mode)
		)
		(use_tab_char pathname)

		;**	After processing the dialog box, we restore the
		;**	previous state and return TRUE.  We only delete the
		;**	information buffer if we created it and if it is
		;**	not visible in any windows.  We delete the display
		;**	buffer regardless.

		(delete_window)
		(set_buffer _dialog_data_buf)

		(if (&& created_buffer (! (inq_views)))
			(delete_buffer _dialog_data_buf)
		)
		(delete_buffer _dialog_disp_buf)
		(set_buffer old_buf_id)

		;**	Decrement the dialog level and restore the values of the
		;**	globals.  If the level becomes zero, we're leaving the
		;**	dialog manager for good, so we re-run the new file
		;**	macros and clear the message line.

		(if (! (-- _dialog_level))
			(
				(call_registered_macro 1)
				(message "")
			)
		)
		(= _dialog_action_func former_action_func)
		(= _dialog_type former_type)
		(= _dialog_row former_row)
		(= _dialog_col former_col)
		(= _dialog_size former_size)
		(= _dialog_disp_buf former_disp_buf)
		(= _dialog_data_buf former_data_buf)
		(= _dialog_mode former_mode)
		(returns TRUE)
	)
)


;**
;**		_dialog_next_and_save:
;**
;**		Acts just like _dialog_next, but when invoked on the last field
;**	in the dialog manager, simulates a press of F10.
;**

(macro _dialog_next_and_save
	(
		;**	If we can leave the current field (the input is valid),
		;**	we look for another field to enter.  If there is none,
		;**	we pretend F10 was pressed, and we signal to save the screen.

		(if (_dialog_exit)
			(
				(set_buffer _dialog_data_buf)
				(end_of_line)

				;**	If we have no other field to go to, we pretend F10 was
				;**	pressed; if it's OK to exit, we exit one process level.
				;**	If we can't exit, we reenter the same field.  (If we
				;**	have another field to begin with, we enter it.)

				(if (! (search_fwd "<[ \\t]@\\c[FLINS]" TRUE FALSE))
					(if (execute_macro _dialog_action_func DIALOG_F10)
						(
							(_exit)
							(return TRUE)
						)
					;else
						(beginning_of_line)
					)
				)
				(_dialog_enter)
			)
		)
	)
)

;**
;**		_dialog_next, _dialog_prev, _dialog_home, _dialog_end:
;**
;**		These four macros move the highlight to another field and set
;**	all the global variables for that field.  There is some redundant
;**	code, because performance is fairly important.
;**

(macro _dialog_next
	(if (_dialog_exit)
		(
			(set_buffer _dialog_data_buf)

			;**	Find the line on which the desired field is defined.

			(end_of_line)
			(if (! (search_fwd "<[ \\t]@\\c[FLINS]" TRUE FALSE))
				(beginning_of_line)
			)
			(_dialog_enter)
		)
	)
)


(macro _dialog_prev
	(if (_dialog_exit)
		(
			(set_buffer _dialog_data_buf)
			(if (! (&& (up) (search_back "<[ \\t]@\\c[FLINS]" TRUE FALSE)))
				(down)
			)
			(_dialog_enter)
		)
	)
)

(macro _dialog_home
	(if (_dialog_exit)
		(
			(set_buffer _dialog_data_buf)
			(top_of_buffer)
			(search_fwd "<[ \\t]@\\c[FLINS]" TRUE FALSE)
			(_dialog_enter)
		)
	)
)

(macro _dialog_end
	(if (_dialog_exit)
		(
			(set_buffer _dialog_data_buf)
			(end_of_buffer)
			(search_back "<[ \\t]@\\c[FLINS]" TRUE FALSE)
			(_dialog_enter)
		)
	)
)

;**
;**		_dialog_set_globals:
;**
;**		This macro sets the global variables _dialog_type, _dialog_row,
;**	and _dialog_col by reading information from the data buffer.  It
;**	returns the line read.
;**

(macro _dialog_set_globals
	(
		(string line)

		;**	We require that the row and column numbers follow
		;**	the first ( and , in the string, respectively,
		;**	although there may be whitespace in between.  The
		;**	only two double quotes in the string must surround
		;**	the text of the field.

		(= _dialog_type (index "FLINTS" (upper (substr (= line (read)) 1 1))))
		(= _dialog_row (atoi (substr line (+ (index line "(") 1))))
		(= _dialog_col (atoi (substr line (+ (index line ",") 1))))
		(returns line)
	)
)

;**
;**		_dialog_enter:
;**
;**		Sets up to enter a list or a field based on the data buffer
;**	and global variables.
;**

(macro _dialog_enter
	(
		(int		offset
					len
		)
		(string	field)

		(_dialog_set_globals)
		(set_buffer _dialog_disp_buf)
		(move_abs _dialog_row _dialog_col)

		;**	We perform the appropriate initializations and highlighting
		;**	depending on the type of the field.  If we are entering
		;**	a list, we may have to reset _dialog_col to compensate for
		;**	an initial tab.

		(if (== _dialog_type LIST)
			(
				(insert_mode TRUE)
				(-- _dialog_col)
				(prev_char)
				(= field (read))
				(= len (- (- (index field ")") (= offset (index field "("))) 1))
				(move_rel 0 (- offset 1))
				(delete_char)
				(insert "\t")
				(move_rel 0 len)
				(delete_char)
				(insert "\t")
				(move_rel 0 -2)
				(drop_anchor)
				(move_rel 0 (- 1 len))
				(execute_macro _dialog_action_func DIALOG_ENTER_LIST _dialog_row
					(substr field (++ offset) len))
			)

		;else
			(
				;**		Highlight the field and call the action function.
				(use_local_keyboard _dialog_field_keymap)
				(end_of_line)
				(drop_anchor)
				(move_abs 0 _dialog_col)
				(execute_macro _dialog_action_func DIALOG_ENTER_FIELD _dialog_row
					(_field_contents))
			)
		)
	)
)

;**
;**		_dialog_exit:
;**
;**		This routine is called whenever the user is leaving a field or
;**	a list.  First, if the user is leaving a typed field, it calls the
;**	built-in data validation routine for that type.  If the data is
;**	invalid, it prints an error message and returns FALSE.  If the data
;**	is valid, it calls the action function with either the list or field
;**	parameter and the value of the list or field.  If the action function
;**	returns TRUE (i.e. the field's contents were still valid), it
;**	removes the highlight (if any), and unassociates the current local
;**	keymap.  Returns what the action function returned.
;**

(macro _dialog_exit
	(
		(int		retval)

		(string	value)

		(if (== _dialog_type LIST)
			(
				;**	Note that in the execute_macro call below, if the action
				;**	function never gets its last parameter, _list_button
				;**	never gets called.

				(if (= retval (execute_macro _dialog_action_func DIALOG_EXIT_LIST
					_dialog_row (_list_button)))
					(
						;**	Change the highlight back to parens.

						(raise_anchor)
						(prev_char)
						(translate "\\t{*}\\t" "(\\0)" FALSE TRUE)
					)
				)
			)

		;else
			(
				(= value (_field_contents))
				(if (= retval (&& (_dialog_validate value)
					(execute_macro _dialog_action_func DIALOG_EXIT_FIELD _dialog_row value)))
					(
						(raise_anchor)
						(use_local_keyboard 0)
						(message "")
					)
				)
			)
		)
		(returns retval)
	)
)

;**
;**		_list_next, _list_prev:
;**
;**		Moves the mark from one button to the next or previous button
;**	on a list.  Lists do not wrap.
;**

(macro _list_next
	(
		(raise_anchor)
		(save_position)
		(search_fwd "{\\t\\c[~\\t]}|\\n" TRUE)
		(restore_position (at_eol))
		(_list_highlight)
 	)
)

(macro _list_prev
	(
		(int		col
					len
		)
		(raise_anchor)
		(inq_position NULL col)

		;**	If we move past the beginning of the list when we move two
		;**	columns left, there is no previous button.  If we are still
		;**	in the list, we are at the end of the previous button.
		;**	All we have to do is move one past the previous tab character.
		;**	This we do in 2 steps because we have to read, starting at
		;**	the beginning of the list.

		(if (> (= len (- (-= col 2) _dialog_col)) 0)
			(
				(move_abs 0 _dialog_col)
				(move_rel 0 (rindex (read len) "\t"))
			)
		)
		(_list_highlight)
	)
)

;**
;**		_list_highlight:
;**
;**		Highlights the list button where the cursor is.  Also, since
;**	this function is called by all the functions that change the value
;**	of a list, calls the action function with that code.
;**

(macro _list_highlight
	(
		(string	value)

		(int		len)

		(= len (- (index (= value (read)) "\t") 2))
		(move_rel 0 len)
		(drop_anchor)
		(move_rel 0 (- 0 len))
		(execute_macro _dialog_action_func DIALOG_ALTER_LIST _dialog_row (substr value 1 len))
	)
)

;**
;**		_list_home, _list_end:
;**
;**		Moves the highlight to the first or last button on a list.
;**

(macro _list_home
	(
		(move_abs 0 _dialog_col)
		(_list_next)
	)
)

(macro _list_end
	(
		(end_of_line)
		(_list_prev)
	)
)

;**
;**		_list_go:
;**
;**		Reads a character (that was just inserted; _list_go is
;**	called as a type 0 registered macro) from the buffer and deletes
;**	it, then looks for a matching button before the end of the list.
;**	If there is none, looks for one starting with the first item.
;**	If there is still none, stays put.  (If a button is found,
;**	_list_go moves to it and highlights it.)
;**
;**		Note that alphabetic keys pressed will only find buttons
;**	beginning with the upper case versions of the letters.
;**

(macro _list_go
	(
		(int		col
					offset
		)
		(string	pattern)

		(raise_anchor)
		(prev_char)
		(= pattern (+ "\t" (upper (read 1))))
		(delete_char)

		(if (= offset (index (read) pattern))
			(move_rel 0 offset)
		;else
			(
				(save_position)
				(move_abs 0 _dialog_col)
				(if (= offset (index (read) pattern))
					(move_rel 0 offset)
				;else
					(beep)
				)
				(restore_position (! offset))
			)
		)
		(_list_highlight)
	)
)

;**
;**		_typeable_key:
;**
;**		For dialog boxes, if we are in a list, calls _list_go.  Otherwise,
;**	calls _field_insert.  For menus, calls _menu_go.  For other cases,
;**	does nothing.
;**

(macro _typeable_key
	(if _dialog_mode
		(if (== _dialog_mode DIALOG_MENU_MODE)
			(_menu_go)
		;else
			(if (== _dialog_type LIST)
				(_list_go)
			;else
				(_field_insert)
			)
		)
	)
)

;**
;**		_field_insert:
;**
;**		Makes sure that there's still room left in the window; if not,
;**	removes the last key inserted, beeps and prints an error message.
;**	Handles both insert and overstrike mode.
;**

(macro _field_insert
	(
		(int		last_col)

		(if (inq_marked)
			(
				(raise_anchor)
				(delete_to_eol)
			)
		)
		(save_position)

		(if (inq_mode)
			(end_of_line)
		)
		(inq_position NULL last_col)
		(restore_position)

		(if (>= last_col _dialog_size)
			(
				(prev_char)
				(delete_char)
				(error "Field is full.")
				(beep)
			)
		)
	)
)

;**
;**		_field_bksp:
;**
;**		Backs the cursor up in a typed field (if it's not already at
;**		the beginning of the field) and deletes it.  In overstrike
;**		mode, this function replaces the deleted character with a space.
;**

(macro _field_bksp
	(
		(int		cur_col)

		(inq_position NULL cur_col)

		(if (inq_marked)
			(
				(raise_anchor)
				(delete_to_eol)
			)
		)

		(if (> cur_col _dialog_col)
			(
				(left)
				(if (! (at_eol))
					(
						(delete_char)
						(if (! (inq_mode))
							(
								(insert " ")
								(prev_char)
							)
						)
					)
				)
			)
		)
	)
)

;**
;**		_field_left, _field_right:
;**
;**		Moves the cursor to the left or to the right in the field, if
;**	possible.  If the field is marked (which implies that the cursor
;**	is still at the beginning of the field), the highlight is removed.
;**

(macro _field_left
	(
		(int		cur_col)

		(raise_anchor)
		(inq_position NULL cur_col)

		(if (> cur_col _dialog_col)
			(left)
		)
	)
)

(macro _field_right
	(
		(int		cur_col)

		(raise_anchor)
		(inq_position NULL cur_col)

		(if (< cur_col (- _dialog_size 1))
			(right)
		)
	)
)

;**
;**		_field_del:
;**
;**		Deletes a character, as long as it's not a newline.  Works the
;**	same way in both insert and overstrike modes.  If the field is still
;**	marked, deletes the whole thing.
;**

(macro _field_del
	(
		(if (! (at_eol))
			(if (inq_marked)
				(
					(raise_anchor)
					(delete_to_eol)
				)
			;else
				(delete_char)
			)
		)
	)
)

;**
;**		_field_end, _field_home:
;**
;**		Removes the mark if there is one, then positions the cursor
;**	at the end or beginning of the field.
;**

(macro _field_end
	(
		(raise_anchor)
		(end_of_line)
	)
)

(macro _field_home
	(
		(raise_anchor)
		(move_abs 0 _dialog_col)
	)
)

;**
;**		_field_del_line, _field_delete_to_eol:
;**
;**		Deletes either the entire field or the field contents after the
;**	cursor position, removing any mark first.
;**

(macro _field_del_line
	(
		(move_abs 0 _dialog_col)
		(_field_delete_to_eol)
	)
)

(macro _field_delete_to_eol
	(
		(raise_anchor)
		(delete_to_eol)
	)
)

;**
;**		_dialog_validate:
;**
;**		Determines if the current field meets predefined criteria for
;**	being a nonblank string, integer, or file name.  (Used for all typed
;**	fields.)  Returns TRUE if the string satisfied the criteria for
;**	the current type, _dialog_type, or if the current type was not
;**	a nonblank string, integer, or file name type.
;**

(macro _dialog_validate
	(
		(string	value)

		(int		retval)

		(= retval TRUE)
		(get_parm 0 value)

		(switch _dialog_type

			FILENAME
				(if (! (= retval (is_filename value)))
					(error "This field must be a filename.")
				)
			INTEGER
				(if (! (= retval (search_string 
					"<[ \\t]@{[\\-+][0-9]+}|{[0-9]+}[ \t]@\n" 
					(+ value "\n") NULL TRUE)))
					(error "This field must be an integer.")
				)
			NONBLANK
				(if (! (= retval (search_string
					"[~ \\t\\n]" value NULL TRUE)))
					(error "This field may not be blank.")
				)
		)

		(if (! retval)
			(beep)
		)
		(returns retval)
	)
)

;**
;**		is_filename:
;**
;**		Returns TRUE if a string contains a syntactically correct
;**	filename.  Note:  this regular expression will catch most, but
;**	not all, incorrect file names.  Among the cases that it will not
;**	catch are two drive specifiers, extra or misplaced periods, omitted
;**	filename (just extension), and name or extension too long.
;**

(macro is_filename
	(
		(string name)

		(get_parm 0 name)

		(returns (search_string
			"<{[a-z]:}@[\\\\/]@{[~- \"%*-,/:-?\\[-\\]|]+[\\\\/]}@[~- \"%*-,/:-?\\[-\\]|]+>"
			(+ name "\n") NULL TRUE FALSE))
	)
)

;**
;**		at_eol:
;**
;**		Returns TRUE if the current position is at the end of a line,
;**	FALSE otherwise.
;**

(macro at_eol
	(returns (== (read 1) "\n"))
)

;**
;**		_format_menu:
;**
;**		Automatically centers each line of the menu buffer in the
;**	window, and moves the rest of the line out of sight.  Normally not
;**	done, since it's faster if you format your own menus.
;**

(macro _format_menu
	(
		(int		button_offset
					button_length
		)
		(string	button
					text
		)
		(top_of_buffer)

		(while (! (inq_position))
			(
				(= button (_menu_button))
				(= button_offset (index button ";"))
				(= text (ltrim (substr button (+ button_offset 1))))
				(= button (trim (substr button 1 (- button_offset 1))))
				(= button_length (strlen button))
				(= button_offset (+ (/ (- _dialog_size button_length) 2) 1))

				(delete_to_eol)
				(move_abs 0 button_offset)
				(insert button)
				(move_abs 0 (+ _dialog_size 1))
				(insert (+ ";" text))
				(beginning_of_line)
				(down)
			)
		)
	)
)

;**
;**		_process_menu:
;**
;**		Creates and processes a menu, calling the user when interesting
;**	events occur.
;**

(macro _process_menu
	(
		(int		lx
					by
					rx
					ty
					old_buf_id
					menu_buf_id
					old_size
					created_buffer
					former_mode
					fast_mode
					screen_x
					screen_y
					retval
		)
		(string	pathname
					former_action_func
		)

		;**	If we are passed an existing buffer id, we use that buffer;
		;**	if not, but we are passed the name of an existing file,
		;**	we create the buffer.  If we get neither parameter, we
		;**	fail.

		(if (&& (! (get_parm 7 menu_buf_id)) (get_parm 6 pathname))
			(
				;**	If the file name is absolute (which we determine by
				;**	the presence of special characters) we don't look for
				;**	it in the BHELP directory.

				(if (! (search_string "[:/\\\\]" pathname NULL TRUE))
					(= pathname (add_to_path _dialog_dir pathname))
				)

				;**	If the file exists already, we put it in a buffer.
				;**	Note that we use a spare string variable, former_
				;**	action_func, to get the buffer name parameter.
				
				(if (exist pathname)
					(
						(get_parm 4 former_action_func)
						(= menu_buf_id 
							(create_buffer former_action_func pathname TRUE))
						(= created_buffer TRUE)
					)
				)
			)
		)

		;**	We have a menu buffer ID if we got one as a parameter or if
		;**	create_buffer above succeeded.  If we have one, we can create
		;**	the menu.  If not, we return immediately so that the
		;**	ensuing code does not have to be part of the if statement;
		;**	this saves precious stack space, allowing for more nesting.

		(if (! menu_buf_id)
			(
				(error "Can't create menu.")
				(return FALSE)
			)
		)

		(= old_buf_id (inq_buffer))
		(message "Creating menu...")

		;**	Here we save the former value of _dialog_action_func
		;**	and increment the _dialog_level counter so recursive
		;**	invocations will know about this one.

		(++ _dialog_level)
		(= former_action_func _dialog_action_func)
		(= former_mode _dialog_mode)
		(= _dialog_mode DIALOG_MENU_MODE)

		;**	Now that we've created the menu buffer, we call the
		;**	menu creation event in case we want to do any raw
		;**	processing on the menu (like adding our own buttons).
		;**	For this event, the menu buffer is guaranteed current.
		;**	We pass the buffer name to the action function, reusing
		;**	a string variable again.

		(get_parm 8 _dialog_action_func)
		(set_buffer menu_buf_id)
		(inq_names NULL NULL pathname)
		(execute_macro _dialog_action_func DIALOG_CREATE_MENU NULL
			pathname)

		;**	We reuse pathname to hold the bottom line message.
		;**	Note that if lx == rx or by == ty, we have to calculate
		;**	rx (width) and by (height) automatically.

		(get_parm 5 pathname)
		(get_parm 0 lx)
		(get_parm 1 by)
		(get_parm 2 rx)
		(get_parm 3 ty)

		;**	If either window dimension is zero, we size the window
		;**	automatically.  It has to be at least 1 line x 14 cols
		;**	(larger if a long bottom line message is to be displayed).

		(if (|| (== lx rx) (== ty by))
			(
				(top_of_buffer)

				;**	Use the first semicolon, if any, and the number
				;**	of lines to get the optimum size.  (No semicolon:
				;**	use a 14-column window.)

				(if (search_fwd ";" FALSE)
					(inq_position NULL rx)
				;else
					(= rx 15)
				)
				(+= rx lx)
				(end_of_buffer)
				(inq_position by)
				(+= by (+ ty 1))
				(top_of_buffer)

				;**	Make sure the window will fit on the screen;
				;**	if it won't, shrink it.  Leave room for the
				;**	"shadows".

				(inq_screen_size screen_y screen_x)
				(-= screen_y 4)
				(-= screen_x 3)

				(if (< screen_y by)
					(= by screen_y)
				)
				(if (< screen_x rx)
					(= rx screen_x)
				)
			)
		)

		;**	If either dimension is too small, display an error
		;**	message and not the window.  Note that we duplicate
		;**	all the "cleanup" code here so we can return
		;**	immediately.  That's because the code size is less
		;**	crucial than the maximum nesting depth here, since
		;**	the macro is intended to be called recursively and
		;**	nesting in macros consumes a ton of stack space.

		(= screen_x (+ (strlen pathname) 2))
		(= screen_y (- rx lx))

		(if (|| (|| (<= (- by ty) 1) (<= screen_y 14))
			(<= screen_y screen_x))
			(
				(error "Window would be too small.")

				(if (&& created_buffer (! (inq_views)))
					(delete_buffer menu_buf_id)
				)
				(set_buffer old_buf_id)

				(if (! (-- _dialog_level))
					(
						(call_registered_macro 1)
						(message "")
					)
				)
				(= _dialog_action_func former_action_func)
				(= _dialog_mode former_mode)
				(return FALSE)
			)
		)

		(= old_size _dialog_size)
		(= _dialog_size (- (- rx lx) 1))
		(keyboard_push _dialog_menu_keymap)

		;**	If we were passed a tenth parameter, and it was TRUE,
		;**	we change to "fast" mode (meaning the window is already
		;**	formatted--centered, if desired, and no visible semicolons).

		(if (! (&& (get_parm 9 fast_mode) fast_mode))
			(_format_menu)
		)

		;**	Now we display the menu window, but we postpone refreshing
		;**	the display until we highlight the first button.

		(create_window lx by rx ty pathname)
		(attach_buffer menu_buf_id)
		(message "Menu created.")

		;**	Go to the top of the buffer, call the init event,
		;**	highlight the first selectable line, redraw the screen,
		;**	and go into interactive mode.

		(top_of_buffer)
		(execute_macro _dialog_action_func DIALOG_INIT)
		(_dialog_menu_home)
		(refresh)
		(process)

		;**	Remove the highlight, then the keyboard, then the window.

		(raise_anchor)
		(execute_macro _dialog_action_func DIALOG_TERM)
		(keyboard_pop TRUE)
		(delete_window)

		;**	Restore the old current buffer and delete the menu
		;**	buffer, if we created the buffer ourselves and
		;**	it's not visible in any window.

		(if (&& created_buffer (! (inq_views)))
			(delete_buffer menu_buf_id)
		)
		(set_buffer old_buf_id)

		;**	Decrement the menu level.  If it is zero,
		;**	we're leaving the menu package for good--so re-run the
		;**	new file macros, and clear the message line.

		(if (! (-- _dialog_level))
			(
				(call_registered_macro 1)
				(message "")
			)
		)
		(= _dialog_action_func former_action_func)
		(= _dialog_mode former_mode)
		(= _dialog_size old_size)
		(returns TRUE)
	)
)

;**
;**		_menu_highlight:
;**
;**		Calls the menu alter event.  If it succeeds, highlights the
;**	current menu line using a line mark.
;**

(macro _menu_highlight
	(
		(int line)

		(inq_position line)

		(if (execute_macro _dialog_action_func DIALOG_MOVE_MENU line (_menu_button))
			(
				(raise_anchor)
				(drop_anchor 3)
				(returns TRUE)
			)
		;else
			(returns FALSE)
		)
	)
)

;**
;**		_dialog_menu_home:
;**
;**		Moves the selection to the first selectable item on the menu.
;**	Calls the action function with the new line number and menu button
;**	text.
;**

(macro _dialog_menu_home
	(
		(top_of_buffer)

		(while (! (_menu_highlight))
			(down)
		)
	)
)

;**
;**		_dialog_menu_end:
;**
;**		Moves to the last selectable item on the menu.  Calls the
;**	action function with the new line number and menu button text.
;**

(macro _dialog_menu_end
	(
		(end_of_buffer)
		(beginning_of_line)
		(to_bottom)

		(while (! (_menu_highlight))
			(up)
		)
	)
)


;**
;**		_dialog_menu_pgup, _dialog_menu_pgdn:
;**
;**		Pages up or down in a menu.
;**

(macro _dialog_menu_pgup
	(
		(page_up)

		(if (! (|| (_menu_highlight) (_dialog_menu_up)))
			(_dialog_menu_down)
		)
	)
)

(macro _dialog_menu_pgdn
	(
		(page_down)

		(while (inq_position)
			(up)
		)

		(if (! (|| (_menu_highlight) (_dialog_menu_down)))
			(_dialog_menu_up)
		)
	)
)


;**
;**		_dialog_menu_down:
;**
;**		Moves the current selection down, stopping at next selectable
;**	item; if the bottom of the menu is encountered, returns to the
;**	previous position.  Returns whether or not it succeeded in moving.
;**		Calls the action function with the new line number and menu
;**	button text as parameters.
;**

(macro _dialog_menu_down
	(
		(int failed)

		(save_position)

		(while TRUE
			(
				(down)

				(if (inq_position)
					(
						(++ failed)
						(break)
					)
				;else
					(if (_menu_highlight)
						(break)
					)
				)
			)
		)
		(restore_position failed)
		(returns (! failed))
	)
)

;**
;**		_dialog_menu_up:
;**
;**		Moves the current selection up to the previous selectable
;**	item, if there are any.  Returns TRUE if it succeeded.
;**

(macro _dialog_menu_up
	(
		(int		moved)

		(save_position)

		(while (up)
			(if (_menu_highlight)
				(
					(++ moved)
					(break)
				)
			)
		)
		(if (! moved)
			(set_top_left 1 1)
		)
		(restore_position (! moved))
		(returns moved)
	)
)

;**
;**		_menu_go:
;**
;**		Reads a character (that was just inserted; _menu_go is
;**	called by a type 0 registered macro) from the buffer and deletes
;**	it, then looks for a matching button before the end of the menu.
;**	If there is none, looks for one starting with the first item.
;**	If there is still none, stays put.  (If a selectable button is found,
;**	_menu_go moves to it and highlights it.)
;**

(macro _menu_go
	(
		(string	pattern)

		(int		end_line
					after_line
					start_line
					start_col
					failed
		)

		;**	Figure out what key was pressed.

		(prev_char)
		(= pattern (read 1))
		(delete_char)

		;**	If the character is a regular expression character, we make
		;**	sure to put a backslash in front of it.

		(if (index "?*@+|\\<>%${}[]~-" pattern)
			(= pattern (+ "\\" pattern))
		)
		(= pattern (+ "<[ \\t]@" pattern))

		;**	Find the last line of the window; if the search takes us
		;**	outside it, we want to center the line in the window.

		(inq_position start_line start_col)
		(end_of_window)
		(inq_position end_line)
		(move_abs start_line start_col)

		;**	Search from the current position to EOF, breaking if
		;**	a selectable line is found.  If the pattern is not found,
		;**	start searching from the top of the file down.

		(while (! failed)
			(
				(next_char)

				(if (<= (search_fwd pattern TRUE FALSE) 0)
					(
						(move_abs start_line start_col)
						(drop_anchor)
						(top_of_buffer)

						(while (! failed)
							(
								(if (<= (search_fwd pattern TRUE FALSE TRUE) 0)
									(++ failed)
								;else
									(if (_menu_highlight)
										(
											(inq_position after_line)

											(if (> after_line end_line)
												(center_line)
											)
											(return)
										)
									)
								)
								(next_char)
							)
						)
						(raise_anchor)
					)
				;else
					(if (_menu_highlight)
						(
							(inq_position after_line)

							(if (> after_line end_line)
								(center_line)
							)
							(return)
						)
					)
				)
			)
		)
		(move_abs start_line start_col)
	)
)

;**
;**		_dialog_menu_pick:
;**
;**		Processes the menu line that is selected when the user presses
;**	Enter.
;**

(macro _dialog_menu_pick
	(
		(int		line)

		(inq_position line)
		(execute_macro _dialog_action_func DIALOG_PICK_MENU line (_menu_button))
	)
)

;**
;**		_menu_button:
;**
;**		Returns the text of the current menu button, with leading and
;**	trailing white space removed.
;**

(macro _menu_button
	(returns (trim (ltrim (read))))
)

;**
;**		_list_button:
;**
;**		Returns the text of the current list button, excluding any
;**	surrounding parentheses or tabs.
;**

(macro _list_button
	(
		(string button)

		(= button (read))
		(returns (substr button 1 (- (index button "\t") 1)))
	)
)

;**
;**		_field_contents:
;**
;**		Returns the contents of the current field, not including the
;**	newline, and regardless of the cursor position.
;**

(macro _field_contents
	(
		(string field)

		(save_position)
		(move_abs 0 _dialog_col)
		(= field (read))
		(restore_position)
		(returns (substr field 1 (- (strlen field) 1)))
	)
)
