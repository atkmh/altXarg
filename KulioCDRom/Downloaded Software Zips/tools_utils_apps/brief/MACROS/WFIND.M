;**		BRIEF -- Basic Reconfigurable Interactive Editing Facility
;**
;**		Written by K. Schopmeyer
;**
;**		wfind.m - open dialog nenu and list instance of word under cursor
;**
;**
;**   WFIND - Searches for text and presents a menu for selection.
;**   NOTE: Find uses the Dialog Manager.
;**
;**	Using either the word under the current cursor positon or
;**   the currently marked block if a block is marked, find searches
;**   the buffer for matches and presents a menu showing all of the
;**   instances found with the line number.  The user can scroll through
;**   the menu to select a line and then press enter to go to that line.
;**   ESC discards the menu without change.
;**   We use _s_pat to store the search string.
;**   NOTE: we do not format the menu lines in the menu buffer with
;**   ; but operate unformatted.  It works and is faster.
;**   Installation:
;** 
;**   Copy this text into your macros sub-directory and compile it.
;**   Insert these lines into your initials macro and re-compile it.
;**
;**      (autoload "WFIND"  "Wfind")
;**      (assign_to_key "<Alt-F2>"   "wfind")
;**
;**		Revision history:
;**		-----------------
;**      Original 5 March 1989.  Version 1.
;**
;**	 Proposed Modifications:
;**    1.Use the grey minus to exit without deleting the buffer.  If the
;**    buffer exists on rentry, just reenter it.
;**	 2. Alternate form for ask for string and then search.
;**    3. Use an alternate key to reenter without rescanning.
;**       This means that we don't delete the buffer on exit but
;**       On the next call.
;**
#include "c:\brief\macros\dialog.h"
;**
;**
;**

(macro wfind
   (
      (extern _s_pat	)
      (int stline 
         endline
         stcol
         endcol
         work
         length
      )
      (save_position)						  ;** save current position
		(if (!(inq_marked))					  ;** if not marked, mark the
 		   (										  ;** current work 
				(markword)
			)
		)
      (if (inq_marked)                    ;** see if there is a marked block
         (
            (inq_position stline stcol)   ;** record the position of the cursor
            (swap_anchor)                 ;** brings position to end of marked block
            (inq_position endline endcol) ;** record end of marked block
            (swap_anchor)                 ;** switch back to beginning of block
            (if (!= endline stline)
               (
						(error "Block to large");
						(return)
               )
            ;else
               (if (< endcol stcol)			;** swap if mark inverted
                  (
                     (= work stcol)       ;** swap end column and start column
                     (= stcol endcol)     ;** to get positive length of the
                     (= endcol work)      ;** marked string
                  )
               )
            )
            (= length (- endcol stcol))   ;** get length of marked string
            (move_abs stline stcol)       ;** move to beginning of string
            (= _s_pat (read (+ length 1)));** read marked string into _s_pat
            (move_rel 0 (+ length 1))		;** ???? probab don't need
            (raise_anchor)                ;** remove mark
            (restore_position)            ;** and go back where we started.
            (do_find)
         )
      )
   )
)
;** set mark on the word under the cursor.  The definition of word in
;** lnanguage dependent so we use the language dependent word definitions
;** to determine the word.
(macro markword
	(
      (wordbeg)
      (mark 1)
      (wordend)
      (left)
	)
)

;**
;**   Find the end of the word under the cursor.
;**
(macro wordend
   (
      (search_fwd "[ ();:=+@^<>{}*,$\\t\\n\\)\\'\\.\"\\\/\\,\\\\]")
   )
)

;**
;**   Jump back to the beginning of the keyword under the cursor
;**
(macro wordbeg
   (
      (search_back "[ ();:=+@^<>{}*,$.\\n\\t'\"(]+\\c[~ \\t]")
   )
)

;**   
;**   Find all occurences of the search pattern and place them
;**   in a buffer that is named as a menu buffer
;**   

(macro do_find
   (
      (extern  _s_pat
               center_line)

      (int     menu_buf_id
               old_buf_id
               line
               max_lines
               goto_ln
               c_loc
					line_count
      )


      (string  menu_line
               routine_name
        ;**       include_file
               message_str
					menu_bfr
      )

      (global  goto_ln
         ;**      menu_buf_id
         ;**      old_buf_id
                  menu_bfr
      )

      (= line_count 0)							;** clear the location counter

      (save_position) 							;** in the source buffer.
      (top_of_buffer) 							;** in the source buffer.

      (= old_buf_id (inq_buffer)) 			;** Save original buffer ID

      (= menu_bfr  "$$$find.mnu")
      (= menu_buf_id (create_buffer "Find List" NULL 1))
;**      (= menu_buf_id (create_buffer "Find line List" NULL 1))

;**      (set_buffer menu_buf_id)		 ;* Purge data in menu buffer

;**      (top_of_buffer)
;**      (drop_anchor 3)
;**      (end_of_buffer)
;**      (delete_block)
;**
;**      (set_buffer old_buf_id)
      (message "Scanning for [%s] ..." _s_pat)
      (while (search_fwd _s_pat)
         (
            (save_position)
            (move_abs 0 1)
            (= routine_name (trim (ltrim (read))))
            (restore_position)				;* prepare for next search
            (next_char)
            (= c_loc (strlen routine_name))
            (if (> c_loc 0)
               (
                  (++ line_count)			 ;* count number of lines found
                  (message "Scanning for [%s], [#%d] ..." _s_pat line_count)

;**                  (int routine_length)
;**                  (= routine_length (strlen routine_name))
;**                  (int insert_spaces)
;**                  (= insert_spaces (- 64 routine_length))

                  (inq_position line)			  ;** get current line number

                  (set_buffer menu_buf_id)	  ;* go to menu bfr to insert line

                  (sprintf menu_line "%4.4d  %s\n" line routine_name)
                  (insert menu_line)
                  (set_buffer old_buf_id)		  ; restore orig bfr 
               )
            )
         )
      )
      (restore_position)			  ;** restore position in orig buffer
      (set_buffer menu_buf_id)	  ;** set to menu buffer
      (delete_line)					  ;** delete last end of line
;*		(end_of_buffer)				  ;** reset end of buffer
;*		(inq_position max_lines)	  ;** get last line position, ie. number lines
      ( = max_lines line_count)        
		(+= line_count  1)
      (top_of_buffer)				  ;* return to top of buffer

      (if (>= line_count 1)
         (
            (int max_wind)							 ;** size the display menu window
            (inq_screen_size max_wind NULL)
            (= max_wind (- max_wind 4))
            (if (> (+= line_count 2) max_wind)
               (= line_count max_wind)
            )

            (sprintf message_str "%d Lines Found" max_lines )
            (_process_menu 05 line_count 75 2 NULL message_str NULL menu_buf_id "_count_goto" 1)

;**            (set_buffer menu_buf_id)
;**            (write_buffer)			;** use as diagnostic

            (delete_buffer menu_buf_id)
            (set_buffer old_buf_id)
            (if goto_ln
               (
                  (goto_line goto_ln)
                  (search_fwd "<[ \\t]@\\c[~ \\t]+" 1 0)
                  (center_line)
;**               (message "Line Located.")
               )
            )
         )
       ;else
         (
            (set_buffer old_buf_id)
            (delete_buffer menu_buf_id)
            (message "No Lines Found.")
            (push_back (key_to_int "<Esc>"))
         )
      )
   )
)
;**
;**   This routine is called by the menu package when a routine is
;**   selected.
;**

(macro _count_goto
   (
      (string  line_string)

      (int  event_type
            ret_val
      )
      (= ret_val TRUE)
      (get_parm 0 event_type)
      (switch event_type

         DIALOG_ESCAPE						  ;* ESC. just get out
            (
               (= ret_val TRUE)
            )
         DIALOG_GREY_MINUS					  ;* No ssspecial use now
            (
          ;**     (push_back (key_to_int "<Esc>"))
               (= ret_val TRUE)
            )
         DIALOG_PICK_MENU					  ;* select functio to goto
            (
               (get_parm 2 line_string)	 ;* second parm is line number
               (= goto_ln (atoi (substr line_string 1 4)))  ;** first 4 char
               (push_back (key_to_int "<Esc>"))
               (= ret_val TRUE)
            )
      )
      (returns ret_val)						  ;** required by dialog mgr
   )
)
