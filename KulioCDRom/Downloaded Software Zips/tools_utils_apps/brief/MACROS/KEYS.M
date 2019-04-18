;**
;**		BRIEF -- Basic Reconfigurable Interactive Editing Facility
;**
;**		Written by Dave Nanian and Michael Strickman.
;**

;**
;**		keys.m:
;**
;**		This macro allows basic reconfiguration of the key assignments
;**	for the commands provided with BRIEF.  It displays a menu containing
;**	a list of commands, and an adjacent window containing the key
;**	assignment(s) for the currently highlighted command.  By selecting
;**	a command, the user can move into the window, and add or delete
;**	key assignments with Ins and Del.
;**
;**		The macro uses the Dialog Manager for the menu it displays.  The
;**	key assignments are changed by modifying and/or adding (assign_to_key)
;**	calls to keyboard.h.  If no keyboard.h can be found, the macro can
;**	be used as an online quick reference card, to find the key sequence
;**	associated with each command.  If a non-zero parameter is supplied,
;**	the macro inserts the key assignments into the current buffer, instead
;**	of keyboard.h.
;**
;**		Revision history:
;**		-----------------
;**

#include "dialog.h"

;**
;**		keys:
;**
;**		This macro sets up the buffers needed: one for the command menu,
;**	one for the key assignment display, and one for keyboard.h.  It then
;**	calls the Dialog Manager to process commands, and when the user
;**	finishes, it writes keyboard.h and registers a macro to recompile
;**	startup, if necessary.
;**

(macro keys
	(
		(extern	add_to_path
					search_path
		)
		(int		menu_buf
					key_buf
					include_buf
					menu_win
					key_win
					orig_keyboard
					old_buffer
					key_parm
		)
		(string	search_text
					include_file
					bpath
					message_str
		)
		(global	search_text
					menu_buf
					key_buf
					include_buf
					menu_win
					key_win
					orig_keyboard
					key_parm
					bpath
					include_file
		)
		(= old_buffer (inq_buffer))
		(= orig_keyboard (inq_keyboard))

		(= include_file (add_to_path _dialog_dir "commands.mnu"))

		(if (! (exist include_file))
			(
				(error "Unable to locate help files (commands.mnu).")
				(return)
			)
		)

		(= menu_buf (create_buffer "Commands" include_file 1))
		(set_buffer menu_buf)
		(= search_text (read))

		(= bpath (inq_environment "BPATH"))

		(if (== (substr bpath 1 1) ";")
			(= bpath (substr bpath 2))
		)

		(if (== (substr bpath 1 1) ".")
			(= bpath (substr bpath (+ (index bpath ";") 1)))
		)

		(if (== bpath "")
			(= bpath "/brief/macros")
		)

		(= include_file (search_path bpath "keyboard.h"))

		(= key_parm 0)
		(get_parm 0 key_parm)

		(if (! key_parm)
			(= include_buf (if (== include_file "") 0 (create_buffer "Macro" 
				include_file 1)))
		;else
			(
				(= key_parm old_buffer)
				(= include_buf 0)
			)
		)

		(= key_buf (create_buffer "Assignments" NULL 1))
		(create_window 41 21 72 1 (if (|| include_buf key_parm) ", Del to delete, Ins to add" "Current Key Assignments"))
		(= key_win (inq_window))
		(attach_buffer key_buf)
		(set_buffer key_buf)
		(refresh)

		(if (|| include_buf key_parm)
			(sprintf message_str ", , %c, Enter, Ins, or Esc" 26)
		;else
			(= message_str ", , Enter, or Esc")
		)

		(_process_menu 7 1 38 1 NULL message_str NULL menu_buf "_keys_menu" 1)

		(set_window key_win)

		(delete_window)

		(if include_buf
			(
				(set_buffer include_buf)
				(if (inq_modified)
					(
						(if (&& (get_parm NULL message_str "Save changes permanently [yn]? " 1)
								  (index "nN" message_str))
							(message "Changes only effective for this editing session.")
						;else
							(
								(message "")		; Clear cancelled message if there.
								(register_macro 5 "_keys_exit")
								(write_buffer)
								(message "Changes saved.")
							)
						)
					)
				)
				(if (!= old_buffer include_buf)
					(delete_buffer include_buf)
				)
			)
		)

		(set_buffer old_buffer)

		(delete_buffer menu_buf)
		(delete_buffer key_buf)
		(call_registered_macro 1)
	)
)

;**
;**		_keys_menu:
;**
;**		This macro is the action routine for the command menu.  It handles
;**	initialization, changing the menu selection, choosing a menu item,
;**	and terminating the menu.  All other menu events are irrelevant.
;**

(macro _keys_menu
	(
		(int 		event_type
					text_found
					old_keyboard
		)

		(string	button_text
					assign_text
		)

		(global	text_found
					button_text
		)

		(get_parm 0 event_type)
		(switch event_type

			DIALOG_INIT
				(
					(extern _dialog_menu_pick)

					(= menu_win (inq_window))
					(get_parm 2 button_text)
					(_keys_menu DIALOG_ALTER_MENU NULL button_text)
					(assign_to_key "<Right>" "_dialog_menu_pick")
					(if (|| include_buf key_parm)
						(
							(assign_to_key "<Ins>" "_keys_insert")
							(if key_parm
								(assign_to_key "<Enter>" "_keys_insert")
							)
						)
					)
					(if include_buf
						(message "Select item with Enter, add assignment with Ins.")
					;else
						(message " and  to view key assignments.")
					)
				)

			DIALOG_ALTER_MENU
				(
					(_keys_menu_message)
					(get_parm 2 button_text)
					(= button_text
						(substr button_text (+ (index button_text ";") 1)))
					(sprintf search_text "(assign_to_key \"%%s\" \"%s\"" button_text)

					(set_buffer key_buf)
					(= old_keyboard (inq_keyboard))
					(keyboard_push orig_keyboard)
					(= assign_text (inq_assignment button_text 1))
					(if (== assign_text "")
						(= assign_text (+ (_get_command_str) button_text))
					)
					(while (! (inq_position))
						(delete_line)
					)
					(insert assign_text)
					(top_of_buffer)
					(translate "\\<-also\\>" "\n" 1)
					(translate "{\\<-and\\>}|{\\<-or\\>\\<*\\>}" "" 1)
					(set_buffer menu_buf)
					(keyboard_pop 1)
				)
			DIALOG_PICK_MENU
				(
					(if (! include_buf)
						(
							(error "Unable to find macro source; can't reconfigure.")
							(return 1)
						)
					)
					(set_window key_win)
					(keyboard_push)
					(if (strlen (ltrim (read)))
						(drop_anchor 3)
					)

					(_keys_message)
					(assign_to_key "<Up>" "_keys_up")
					(assign_to_key "<Down>" "_keys_down")
					(assign_to_key "<Ins>" "_keys_insert")
					(assign_to_key "<Del>" "_keys_delete")
					(assign_to_key "<Alt-d>" "_keys_delete")
					(assign_to_key "<Esc>" "exit")
					(assign_to_key "<F10>" "exit")
					(assign_to_key "<Left>" "exit")
					(refresh)

					(process)
					(keyboard_pop)
					(raise_anchor)
					(set_window menu_win)
					(_keys_menu_message)
				)
			DIALOG_TERM
				(
					(message "Returning to editing session...")
					(assign_to_key "<Ins>" "nothing")
					(assign_to_key "<Right>" "nothing")
					(assign_to_key "<Enter>" "_dialog_menu_pick")
				)
		)
	(return 1)
	)
)


;**
;**		_keys_up:
;**
;**		When the user presses the up arrow in the Assignments window,
;**	this macro is called.  If the user isn't at the top of the buffer,
;**	it moves the mark up one line.
;**

(macro _keys_up
	(
		(int		line)

		(inq_position line)
		(if (> line 1)
			(
				(move_rel -1 0)
				(raise_anchor)
				(drop_anchor 3)
			)
		)
	)
)

;**
;**		_keys_down:
;**
;**		Likewise, when the user presses the down arrow in the Assignments 
;**	window, this macro is called.  If the user isn't at the bottom of the
;**	buffer, it moves the mark down one line.
;**

(macro _keys_down
	(
		(move_rel 1 0)
		(if (! (inq_position))
			(
				(raise_anchor)
				(drop_anchor 3)
			)
		;else
			(move_rel -1 0)
		)
	)
)

;**
;**		_keys_insert:
;**
;**		This one does all the work.  If the user wants to add a key
;**	assignment, it asks for the new assignment, gets rid of the old
;**	assignment (both in the Assignment window and in the keyboard.h
;**	file), and inserts the new assign_to_key statement at the bottom
;**	of the first macro in keyboard.h (the keyboard macro), or in the
;**	current buffer, depending on the parameter passed to keys.
;**

(macro _keys_insert
	(
		(int		key_value
					old_win
					old_buffer
					found
					i
					abort_insert
		)

		(string	key_string
					insert_string
					cur_key
		)

		(= old_win (inq_window))
		(= old_buffer (inq_buffer))
		(set_window key_win)

		(message "Type the key sequence; press Enter to end.")
		(while (== (= key_value (read_char)) -1))
		(insert "\n")
		(up)
		(while (!= (& key_value 0xff) 0x0d)
			(
				(= cur_key (int_to_key key_value))
				(insert cur_key)
				(+= key_string cur_key)
				(message "Continue; press Enter to end, Esc to cancel." key_string)
				(if (== (++ i) 5)
					(break)
				)
				(while (== (= key_value (read_char)) -1))
				(if (== key_value 0x11b)	; Escape was pressed.
					(
						(= abort_insert 1)
						(break)
					)
				)
			)
		)

		(delete_line)
		(beginning_of_line)

		(if abort_insert
			(message "Keystroke cancelled.")
		;else
			(
				(if (== key_string "")
					(= key_string "<Enter>")
				)

				(message "Processing assignment...")
				(keyboard_push orig_keyboard)
				(assign_to_key key_string button_text)
				(keyboard_pop 1)

				(save_position)
				(top_of_buffer)
				(= found (search_fwd key_string 0 NULL 0))
				(restore_position)
				(set_buffer old_buffer)

				(if found
					(error "Key sequence already assigned.")
				;else
					(
						(sprintf insert_string "(assign_to_key \"%s\"" key_string)
						(if include_buf
							(
								(set_buffer include_buf)
								(top_of_buffer)
								(if (search_fwd insert_string 0)
									(
										(delete_line)
										(beginning_of_line)
									)
								)
							)
						)
						(+= insert_string " \"")
						(+= insert_string button_text)

						(if include_buf
							(
								(if (search_fwd "<\\c[ \t]+)\n)")
									(
										(insert (+ (+ "\t\t" insert_string) "\")\n"))
										(up)
										(sprintf insert_string "Assigned %s to %%s." button_text)
										(message insert_string key_string)
									)
								;else
									(error "Unable to locate end of macro.")
								)
							)
						;else
							(
								(if key_parm
									(
										(set_buffer key_parm)
										(insert (+ insert_string "\")\n"))
									)
								)
								(message "String inserted in current buffer.")
							)
						)
						(set_buffer key_buf)
						(insert (+ key_string "\n"))
						(raise_anchor)
						(if (== (read) "\n")
							(delete_line)
						)
						(up)
						(drop_anchor 3)
					)
				)
			)
		)
		(set_buffer old_buffer)
		(set_window old_win)
	)
)

;**
;**		_keys_delete:
;**
;**		This macro is called when the user deletes a key assignment.
;**	It assigns the key sequence to "nothing" in the original keyboard,
;**	and deletes the text from the Assignments window and the keyboard.h
;**	file (if it is there).
;**

(macro _keys_delete
	(
		(string	key_string
					search_str
					command_str
		)

		(= key_string (trim (read)))
		(= command_str (_get_command_str))
		(if (!= (substr key_string 1 (strlen command_str)) command_str)
			(
				(keyboard_push orig_keyboard)

				(assign_to_key key_string "nothing")
				(set_buffer include_buf)
				(message "Locating old assignment...")
				(top_of_buffer)
				(sprintf search_str search_text key_string)
				(if (search_fwd search_str 0 0)
					(
						(delete_line)
						(beginning_of_line)
					)
				;else
					(if (search_fwd "<\\c[ \t]+)\n)")
						(
							(sprintf search_str "\t\t(assign_to_key \"%s\" \"nothing\")\n" key_string)
							(insert search_str)
							(up)
						)
					;else
						(error "Unable to locate end of macro.")
					)
				)

				(set_buffer key_buf)
				(set_window key_win)
				(delete_block)
				(if (inq_position)
					(up)
				)
				(if (strlen (ltrim (read)))
					(drop_anchor 3)
				)
				(keyboard_pop 1)
				(_keys_message)
			)
		)
	)
)

;**
;**		_keys_exit:
;**
;**		This macro is called when the user exits, if there have been
;**	any modifications to keyboard.h.  It recompiles the startup macro,
;**	so the assignments will be in effect next time BRIEF is run.
;**

(macro _keys_exit
	(
		(int old_buffer)
		(string command_string)

		(= old_buffer (inq_buffer))

		(if (= include_buf (create_buffer "Macros" include_file 1))
			(
				(set_buffer include_buf)
				(message "Recompiling startup macro...")
				(if (inq_modified)
					(write_buffer)
				)
				(sprintf command_string "cm %s >&temp.$b$" (add_to_path bpath "startup"))
				(if (dos command_string)
					(
						(int i)

						(pause_on_error 1)
						(error "Compile failed; run \"cm startup\". Press a key.")
					)
				;else
					(message "Reconfiguration complete.")
				)
				(del "temp.$b$")
			)
		;else
			(error "Unable to locate %s." include_file)
		)

		(set_buffer old_buffer)
	)
)

;**
;**		_keys_message, _keys_menu_message:
;**
;**		These macros simply display the appropriate message when
;**	they are called.
;**

(macro _keys_message
	(message "Press Ins to add assignment, Del to delete.")
)

(macro _keys_menu_message
	(
		(if include_buf
			(message "Select item with Enter, add assignment with Ins.")
		;else
			(message " and  to view key assignments.")
		)
	)
)

;**
;**		_get_command_str:
;**
;**		Gets the key sequence that is used for the execute_macro
;**	primitive.  If multiple assignments exist, only the first one
;**	is used.
;**

(macro _get_command_str
	(
		(string	command_str
		)

		(int		command_len
		)

		(keyboard_push orig_keyboard)
		(= command_str (inq_assignment "execute_macro" 1))
		(keyboard_pop 1)
		(if (= command_len (index command_str "<-and>"))
			(= command_str (substr command_str 1 (- command_len 1)))
		)
		(if (= command_len (index command_str "<-also>"))
			(= command_str (substr command_str 1 (- command_len 1)))
		)
		(returns (+ command_str " "))
	)
)
