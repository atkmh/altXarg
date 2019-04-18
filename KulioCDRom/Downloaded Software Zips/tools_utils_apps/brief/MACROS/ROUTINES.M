;**
;**		BRIEF -- Basic Reconfigurable Interactive Editing Facility
;**
;**		Written by Dave Nanian and Michael Strickman.
;**

;**
;**		routines.m:
;**
;**		This file contains macros that allow a programmer to select a
;**	C routine from a menu and then go to it.  It makes a few assumptions
;**	about programming style:  routines must begin in column one, and
;**	the line with the declaration must end with a close paren (")").
;**
;**
;**		Revision history:
;**		-----------------

#include	"dialog.h"

;**
;**		routines:
;**
;**		This macro implements the "go to a routine" feature of BRIEF.  It
;**	scans the file for routine declarations, and builds a menu that gets
;**	passed to the BRIEF dialog manager.  If a routine is selected from this
;**	menu, on exit "_r_line" will have a non-zero value, and we go to that
;**	line of the file.
;**

(macro routines
	(
		(int		menu_buf
					old_buf_id
					line
					_r_line
					loc
		)
		(string	menu_line
					routine_name
		)
		(global	_r_line)

		(= _r_line 0)
		(save_position)
		(top_of_buffer)
		(= old_buf_id (inq_buffer))
		(= menu_buf (create_buffer "Routines" NULL 1))
		(message "Scanning for routines...")

		(while (search_fwd "<[~ \t#/\\*;\n\\{\\}(]")
			(
				(= routine_name (read))
				(= loc (strlen routine_name))

				(while (index " \t\n" (substr routine_name loc 1))
					(-- loc)
				)
				(if (&& (!= loc 1) (== (substr routine_name loc 1) ")"))
					(
						(++ _r_line)
						(message "Scanning for routines [#%d]..." _r_line)
						(= loc (search_string "[~ \t(\\*]\\c[ \t]@(" routine_name))
						(= routine_name (+ (substr routine_name 1 (-- loc)) "\n"))
						(= routine_name (substr routine_name (search_string "[~ \t\\*][~ \t\\*]@>" routine_name)))
						(= routine_name (substr routine_name 1 (- (strlen routine_name) 1)))

						(inq_position line)
						(sprintf menu_line "\n%s\t%d;" routine_name line)

						(set_buffer menu_buf)
						(insert menu_line)
						(set_buffer old_buf_id)
					)
				)
				(next_char)
			)
		)
		(= _r_line 0)
		(restore_position)
		(set_buffer menu_buf)
		(inq_position line)
		(top_of_buffer)

		(if (> line 1)
			(
				(delete_line)
				(tabs 80)

				(if (> (+= line 3) 20)
					(= line 20)
				)
				(set_buffer old_buf_id)
				(_process_menu 30 line 50 3 NULL "" NULL menu_buf "_r_action" TRUE)

				(if _r_line
					(goto_line _r_line)
				)
			)
		;else
			(
				(set_buffer old_buf_id)
				(delete_buffer menu_buf)
				(message "No routines found.")
			)
		)
	)
)

;**
;**		_r_action:
;**
;**		This routine is called by the dialog manager when a routine is
;**	selected.
;**

(macro _r_action
	(
		(int	event_type)

		(string	button_text)

		(get_parm 0 event_type)

		(switch event_type

			DIALOG_PICK_MENU
			NULL
			DIALOG_F10
				(
					(get_parm 2 button_text)
					(= _r_line (atoi (substr button_text (+ (rindex button_text "\t") 1))))
					(_dialog_esc)
				)
		)
		(returns TRUE)
	)
)
