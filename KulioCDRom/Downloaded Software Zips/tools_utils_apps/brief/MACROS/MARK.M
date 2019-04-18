;**	_init macro.
;**	Do not change this macro (always overwritten by Setup).
(macro _init
	(
		(extern	autosave				;**	External macro declarations
					toggle_re
		)
	      (color 0 10 14 7 13 0x80)	;**	Set the screen colors
              (autoload "WFIND"  "Wfind")
              (assign_to_key "<Alt-F2>"   "wfind")
	)
)

;**	Initials macro.
;**	Use this macro for additional customization.
;**	Put your custom stuff here, not in above "_init" macro!
(macro LEW
	(
		;**	Put your changes here.
  ;;; (autoload "WFIND"  "Wfind")
  ;;; (assign_to_key "<Alt-F2>"   "wfind")
		(return)
	)
)


;**	File Extension Macros, etc.
;**	Macros marked "Overwritable" may be overwritten by SETUP.

;**
;**  chcase - change the case of the character at the cursor position
;**

(macro chcase
  (
    (string this_char )

    ( = this_char ( read 1 ) )
    (if ( > this_char "Z" )
      ( = this_char (upper this_char ) )
    ;else
      ( = this_char (lower this_char ) )
    )
    ( delete_char )
    ( insert this_char )
  )
)

;**
;**		  mark_a_line - sets the mark (move etc.) on a complete line and
;**                    leaves the cursor at the beginning of the line
;**
(macro mark_a_line
  (
	(if (inq_marked)
		(swap_anchor)
		;else
		(
			(end_of_line)      
			(drop_anchor)
   		(beginning_of_line)
		)
  	)
  )
)

;**    Macro to repeat a line, repeats line with current cursor
(macro repeat_line
  (
   (int my_line 
	     my_row)
	(inq_position my_line my_row)
	(mark_a_line)
	(copy)
	(end_of_line)
   (insert "\n")
	(paste)
   (delete_char)
	(move_abs (+ 1 my_line) my_row)
  )
)

;**
;** DOSHELL - DOS Shell Facility Version 2
;**
;**  Written by Henry C. Clark.
;**
;**  Installation:
;**      Put a command like :     (assign_to_key "<Ctrl-q>" "doshell")
;**   and the DOSHELL macro into your initials file.
;**   Insure that the DOSHELL and RESULT_FILE paths are valid, 
;**   then compile the initials file. ( see Installation Dependent )
;**
;**  Purpose:
;**      Executes one or more DOS commands, redirects their output,
;**   an collects the results into a file buffer called DOSHELL.
;**
;**  Command specification ( what gets executed ):
;**      Marked text, including partial line and multiple lines.
;**   Default command is all of current line.  Column mark functions
;**   like Regular mark.  In multiple line batch, ignores blank lines.
;**
;**  Hints:
;**      Use Ctrl-minus to delete the DOSHELL file, or UNDO to clear
;**   the last command.
;**   Execute commands typed in DOSHELL to simulate STDIN/STDOUT.
;**

(macro doshell
   (
      (extern to_bottom          ;** used by display
      )

      (string command            ;** command user selects
              command_line       ;** command passed to DOS
              cmd_file           ;** the file containing the command
              result_file        ;** the redirected output file
              doshell_file       ;** the DOSHELL file
      )
      (int    start_line         ;** starting or only command line
              start_col          ;** starting command column
              end_line           ;** ending or only command line
              end_col            ;** end of command, or end of line
              char_cnt           ;** size of raw command
              result_start       ;** starting line of result
              result_end         ;** ending line of result
              ret_code           ;** return code
      )

      ;**
      ;** INSTALLATION DEPENDENT ( you may change between the quotes )
      ;**
      (= result_file "c:\\brief\\tmpbuf")    ;** must include drive
      (= doshell_file "c:\\brief\\doshell")    ;** must include drive

      ;**
      ;** Get filename containing command(s)
      ;**
      (inq_names cmd_file)

      ;**
      ;** Get start and end of user selected command text
      ;**
      (= ret_code (inq_marked start_line start_col end_line end_col ))

      ;**
      ;** Check if mark is active
      ;**
      (if (!= ret_code 0)
         (
         ;**
         ;** GOT Marked text
         ;**
         (raise_anchor)

         ;**
         ;** Check if Multi-line
         ;**
         (if (!= start_line end_line)
            (
            ;**
            ;** More than one line, set end column
            ;**
            (move_abs start_line start_col)
            (end_of_line)
            (= ret_code (inq_position start_line end_col))
            (if (!= ret_code 0)
               (
               (-= end_line ret_code)
               )
            )
            )
         ;else
            (
            ;**
            ;** Single line mark, Check for Line mark
            ;**
            (if (!= ret_code 3)
               ;**
               ;** NOT line mark, add to end column
               ;**
               (
               (+= end_col 1 )
               )
            ;else
               (
               ;**
               ;** GOT line mark, set end column
               ;**
               (end_of_line)
               (inq_position start_line end_col)
               )
            )
            )
         )
         )
      ;else
         (
         ;**
         ;** NO Marked Text, default to current whole line
         ;**
         (= start_col 1)
         (end_of_line)
         (inq_position start_line end_col)
         (= end_line start_line)
         )
      )

      ;**
      ;** Loop for each marked line
      ;**
      ( while ( <= start_line end_line )
         (
         (move_abs start_line start_col)

         ;**
         ;** Find command string length
         ;**
         (= char_cnt (- end_col start_col))

         ;**
         ;** Check if command available on this line
         ;**
         (if ( > char_cnt 0 )
            (
            ;**
            ;** YES, Read and compress command string
            ;**
            (= command_line ( read char_cnt))
            (= command (compress command_line))
            (= ret_code (search_string "\n" command))
            (if ret_code
               (
               (= command (substr command 1 (- ret_code 1)))
               )
            )

            ;**
            ;** Append redirect to form command line
            ;**
            (= command_line command)
            (+= command_line (+ " >&" result_file))

            ;**
            ;** Execute command ( ret_code not handled )
            ;**
            (message command)
            (= ret_code (dos command_line 1))

            ;**
            ;** Go to DOSHELL file for accumulation
            ;**
            (edit_file doshell_file)

            ;**
            ;** Check if DOSHELL file different from command file
            ;**
            (if (!= cmd_file doshell_file)
               (
               ;**
               ;** YES, Record Command Used
               ;**
               (beginning_of_line)
               (insert "\n")
               (up)
               (insert command)
               )
            )
            ;**
            ;** Read in result file, just after command
            ;**
            (down)
            (beginning_of_line)
            (insert "\n")
            (inq_position result_start end_col)
            (read_file result_file)
            (insert "\n")
            (inq_position result_end end_col)
            (del result_file)

            ;**
            ;** Return to command file
            ;**
            (edit_file cmd_file)

            ;**
            ;** Check if DOSHELL file is the command file
            ;**
            (if (== cmd_file doshell_file)
               (
               ;**
               ;** YES, adjust end line to account for result insert
               ;**
               (+= end_line (- result_end result_start))
               (+= end_line 1)
               (inq_position start_line start_col)
               )
            ;else
               (
               ;**
               ;** NO (different file), just increment to next command line
               ;**
               (+= start_line 1 )
               )
            )
            )
         ;else
            ;**
            ;** NO available command, next command line
            ;**
            (
            (+= start_line 1 )
            )
         )

         ;**
         ;** While loop final step, set up next command line
         ;**
         (= start_col 1)
         (move_abs start_line start_col)
         (end_of_line)
         (= ret_code (inq_position start_line end_col))
         (if (!= ret_code 0)
            ;**
            ;** Adjust for past end of text
            ;**
            (
            (-= end_line ret_code)
            )
         )
         )
      )
      ;**
      ;** Display final results
      ;**
      (edit_file doshell_file)
      (to_bottom)
   )
)

;**
;** DOSHELL - DOS Shell Facility
;**
;**  Henry C. Clark
;**
;**
;**(macro doshell
;**   (
;**      (string command                ;** the command user runs
;**              command_line           ;** the command passed to DOS
;**              result_file            ;** the redirected output file
;**      )
;**      (int    start_line
;**              start_col
;**              end_line
;**              end_col
;**              char_cnt
;**              ret_code
;**      )
;**      ;**
;**      ;** Get start and end of user selected command text
;**      ;**
;**      (if (inq_marked start_line start_col end_line end_col )
;**         (
;**         ;**
;**         ;** Marked text
;**         ;**
;**         (raise_anchor)
;**         (+= end_col 1 )
;**         )
;**      ;else
;**         (
;**         ;**
;**         ;** Default to current whole line
;**         ;**
;**         (= start_col 1)
;**         (end_of_line)
;**         (inq_position start_line end_col)
;**         )
;**      )
;**
;**      ;**
;**      ;** Read and compress command string
;**      ;**
;**      (= char_cnt (- end_col start_col))
;**      (if (<= char_cnt 0 )
;**         (
;**         (error "No command found.")
;**         (return 0)
;**         )
;**      )
;**      (move_abs start_line start_col)
;**      (= command_line ( read char_cnt))
;**      (= command (compress command_line))
;**
;**      ;**
;**      ;** Append redirect to form command line
;**      ;**
;**      (= result_file "\\doc\\brief\\tmpbuf")
;**      (= command_line command)
;**      (+= command_line (+ " >&" result_file))
;**
;**      ;**
;**      ;** Ready to execute command
;**      ;**
;**      (message command_line)
;**      (= ret_code (dos command_line 1))
;**
;**      ;**
;**      ;** Look at results
;**      ;**
;**      (edit_file "\\doc\\brief\\doshell")
;**      (save_position)
;**      (read_file result_file)
;**      (del result_file)
;**      (restore_position)
;**      (message command)
;**   )
;**)
;**

;**	Overwritable by Setup
(macro default
	(
		(tabs 5 9 13 17 22 30 35 40 44 48 52 56 60 62 64)
	)
)

;**	Overwritable by Setup
(macro .c
	(
  ;** (tabs 5 9 13 17 21 25 33 37 41 45 53 61)
		(tabs 4 8 12 16 20 24 28 32 36 40 50 55 60 65 73 78 82 84 86 88 90)
	)
)

;**	Overwritable by Setup
(macro .asm
	(
		(tabs 9 17)
	)
)

;**	Overwritable by Setup
(macro .m
	(
		(tabs 4 7)
	)
)

;**	Overwritable by Setup
(macro .dok
	(
		(tabs 9 17)
	)
)

;**	Overwritable by Setup
(macro .ext
	(
		(tabs 9 17)
	)
)

;**	Overwritable by Setup
(macro .doc
	(
		(tabs 6 15 20 30 35 40 45 50 55 60 75)
	)
)

;**	Overwritable by Setup
(macro .txt
	(
		(tabs 5 10 15 20 30 40 50 60 65 75 80)
	)
)


