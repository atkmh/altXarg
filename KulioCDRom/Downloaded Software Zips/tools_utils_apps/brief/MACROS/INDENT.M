;**
;**		BRIEF -- Basic Reconfigurable Interactive Editing Facility
;**
;**		Written by Dave Nanian and Michael Strickman.
;**

;**		indent.m:
;**
;**		This macro performs automatic indenting for a number of languages.
;**	Other languages can be supported through the standard BPACKAGES
;**	interface.
;**
;**		Revision history:
;**		-----------------

#define	SEMI_COLON			1			;** Code for semicolon.
#define	OPEN_BRACE			2			;** Code for open brace.
#define	CLOSE_BRACE			3			;** Code for close brace.

#define	MIN_ABBREV			1			;** Increase this to specify longer
												;** default minimum abbreviations.

#define	REG_MARK				1			;** Regular marks.
#define	COL_MARK				2			;** Column marks.
#define	LINE_MARK			3			;** Line marks.
#define	NI_MARK				4			;** Non-inclusive marks.

#define	C_SKIP_PAT	"{{/\\*+{[~*]|{[~/]\\*}}@\\*/}|{//*\n}|{\n{[~ \xc\t\n]@:}|{[ \xc\t]@#*}}|[ \xc\t\n]}@"
#define	ABBREV_LIST	"\xffelse \xffelse if ()\xffif ()\xffwhile ()\xfffor ()\xffdo\xffswitch ()\xffcase :\xffreturn \xff"

#define	ELSE_LOC				1
#define	RETURN_LOC			60

(extern	back_tab
			open_line
)

(macro _init
	(
		(int		_c_min_abbrev
					_c_smart
					_c_template
					_c_alt_template
					_r_keymap
					_c_indent_open
					_c_indent_close
					_c_indent_first
		)
		(global	_c_min_abbrev
					_c_smart
					_c_template
					_c_alt_template
					_r_keymap
					_c_indent_open
					_c_indent_close
					_c_indent_first
		)
		(keyboard_push)
		(assign_to_key "<Enter>" ".c_indent")
		(assign_to_key "<Tab>" "slide_in")
		(assign_to_key "<Shift-Tab>" "slide_out")
		(assign_to_key "<{>" ".c_open_brace")
		(assign_to_key "<}>" ".c_close_brace")
		(assign_to_key "<Ctrl-{>" "just_brace")
		(assign_to_key "<Ctrl-}>" "just_cbrace")
		(= _c_smart (inq_keyboard))
		(keyboard_pop 1)

		(keyboard_push)
		(assign_to_key "<Enter>" ".c_indent")
		(assign_to_key "<Tab>" "slide_in")
		(assign_to_key "<Shift-Tab>" "slide_out")
		(assign_to_key "<Space>" ".c_abbrev")
		(assign_to_key "<{>" "brace_expand")
		(assign_to_key "<}>" ".c_close_brace")
		(assign_to_key "<Ctrl-{>" "just_brace")
		(assign_to_key "<Ctrl-}>" "just_cbrace")
		(assign_to_key "<Ctrl-s>" "just_space")
		(= _c_template (inq_keyboard))
		(keyboard_pop 1)

		(keyboard_push)
		(assign_to_key "<Enter>" ".c_indent")
		(assign_to_key "<Tab>" ".c_abbrev")
		(assign_to_key "<Shift-Tab>" "slide_out")
		(assign_to_key "<{>" "brace_expand")
		(assign_to_key "<}>" ".c_close_brace")
		(assign_to_key "<Ctrl-{>" "just_brace")
		(assign_to_key "<Ctrl-}>" "just_cbrace")
		(assign_to_key "<Ctrl-s>" "just_space")
		(= _c_alt_template (inq_keyboard))
		(keyboard_pop 1)

		(keyboard_push)
		(assign_to_key "<Enter>" "r_indent")
		(assign_to_key "<Tab>" "slide_in")
		(assign_to_key "<Shift-Tab>" "slide_out")
		(= _r_keymap (inq_keyboard))
		(keyboard_pop 1)
	)
)

;**
;**		.c_template_first, .cpp_template_first,
;**		.c_smart_first, .cpp_smart_first,
;**		_regular_first:
;**
;**		These macros are called by the BPACKAGES parser in language.m.
;**	They initialize the local keymaps for the various indenting functions,
;**	set the abbreviation length and adjust the indenting style.
;**

(macro .c_template_first
	(
		(= _c_min_abbrev MIN_ABBREV)
		(get_parm 0 _c_min_abbrev)

		(if (== _c_min_abbrev 0)
			(
				(use_local_keyboard _c_alt_template)
				(= _c_min_abbrev 1)
			)
		;else
			(use_local_keyboard _c_template)
		)
		(= _c_indent_open 1)
		(= _c_indent_close 1)
		(= _c_indent_first 0)
		(get_parm 1 _c_indent_open)
		(get_parm 2 _c_indent_close)
		(get_parm 3 _c_indent_first)
		(returns "")
	)
)

(macro .cpp_template_first
	(
		(= _c_min_abbrev MIN_ABBREV)
		(get_parm 0 _c_min_abbrev)

		(if (== _c_min_abbrev 0)
			(
				(use_local_keyboard _c_alt_template)
				(= _c_min_abbrev 1)
			)
		;else
			(use_local_keyboard _c_template)
		)
		(= _c_indent_open 1)
		(= _c_indent_close 1)
		(= _c_indent_first 0)
		(get_parm 1 _c_indent_open)
		(get_parm 2 _c_indent_close)
		(get_parm 3 _c_indent_first)
		(returns "")
	)
)

(macro .c_smart_first
	(
		(use_local_keyboard _c_smart)
		(= _c_indent_open 1)
		(= _c_indent_close 1)
		(= _c_indent_first 0)
		(get_parm 0 _c_indent_open)
		(get_parm 1 _c_indent_close)
		(get_parm 2 _c_indent_first)
		(returns "")
	)
)

(macro .cpp_smart_first
	(
		(use_local_keyboard _c_smart)
		(= _c_indent_open 1)
		(= _c_indent_close 1)
		(= _c_indent_first 0)
		(get_parm 0 _c_indent_open)
		(get_parm 1 _c_indent_close)
		(get_parm 2 _c_indent_first)
		(returns "")
	)
)

(macro _regular_first
	(
		(use_local_keyboard _r_keymap)
		(returns "")
	)
)

;**
;**		.c_indent:
;**
;**		This macro does syntax-sensitive indenting ("smart indenting") for
;**	C language files.
;**

(macro .c_indent
	(
		(int		curr_indent_col		;** Current unmodified indent col.
					following_position	;** Column of end of line following cursor.
					curr_col					;** Column cursor is on when called.
					curr_line				;** Column line is on when called.
					what_is_char_1			;** End of first line's character identifier.
					what_is_char_2			;** End of second line's indentifier.
					level						;** Current indenting level.
		)
		(string	following_string)		;** All characters following the cursor.

		;**
		;**		Gather information on the two previous non-blank lines.
		;**

		(if (! (inq_mode))
			(end_of_line)
		)
		(inq_position curr_line curr_col)
		(end_of_line)
		(inq_position NULL following_position)

		;**
		;**		If there are characters following the cursor, save them in
		;**	following_string.
		;**

		(if (> following_position curr_col)
			(
				(drop_anchor NI_MARK)
				(move_abs 0 curr_col)
				(= following_string (ltrim (read)))
				(delete_block)
			)
		)
		(if (> (search_back C_SKIP_PAT -2) 1)
			(
				(string	line_end)

				(prev_char)
				(= what_is_char_2 (index ";{}" (read 1)))
				(= line_end (read))
				(delete_to_eol)
				(insert (trim line_end))

				(beginning_of_line)
				(next_char (- (strlen (read)) (strlen (ltrim (read)))))
				(inq_position NULL curr_indent_col)
				(prev_char)

				(if (> (search_back C_SKIP_PAT -2) 1)
					(
						(prev_char)
						(= what_is_char_1 (index ";{}" (read 1)))
					)
				;else
					(= what_is_char_1 SEMI_COLON)
				)
			)
		;else
			(
				(= what_is_char_1 (= what_is_char_2 SEMI_COLON))
				(= curr_indent_col 1)
			)
		)
		(move_abs curr_line curr_indent_col)

;**
;**		We've determined the last two non-blank lines' last characters
;**	as well as the column position of the first non-blank character.
;**	Now we position the cursor on the new line's proper level.
;**

		(if (== curr_indent_col 1)
			(if (&& (! _c_indent_first) (== what_is_char_2 OPEN_BRACE))
				(+= curr_indent_col (distance_to_tab))
			)
		;else
			(switch what_is_char_2
				SEMI_COLON
					(if (! what_is_char_1)
						(-- curr_indent_col)
					)
				CLOSE_BRACE
					(if _c_indent_close
						(-- curr_indent_col)
					)
				OPEN_BRACE
					(if (|| what_is_char_1 (! _c_indent_open))
						(+= curr_indent_col (distance_to_tab))
					)
				NULL
					(+= curr_indent_col (distance_to_tab))
			)
		)
		(move_abs 0 curr_col)

		(if (! (get_parm 0 curr_col))
			(
				(if (== (inq_assignment (inq_command) 1) "<Enter>")
					(self_insert (key_to_int "<Enter>"))
				;else
					(self_insert (key_to_int "<Ctrl-m>"))
				)
			)
		)
		(beginning_of_line)
		(= curr_col (+ (distance_to_tab) 1))

		(while (<= curr_col curr_indent_col)
			(
				(move_abs 0 curr_col)
				(++ level)
				(+= curr_col (distance_to_tab))
			)
		)
		(if (!= following_string "")
			(
				(= following_string (substr following_string 1 (- (strlen following_string) 1)))
				(save_position)
				(insert following_string)
				(restore_position)
			)
		)
		(returns level)
	)
)

;**
;**		r_indent:
;**
;**		This macro does "standard" style indenting, indenting new lines
;**	to the same column as the previous non-blank line.
;**

(macro r_indent
	(
		(int		curr_indent_col
					following_position
					curr_col
					curr_line
		)
		(string	following_string)

;**
;**		First, check to see if there are any following characters on the
;**	line.  If so, read them into a temporary variable and delete from the
;**	first line.
;**
;**		Get column of last non-blank line.
;**

		(if (! (inq_mode))
			(end_of_line)
		)
		(inq_position curr_line curr_col)
		(end_of_line)
		(inq_position NULL following_position)

		(if (> following_position curr_col)
			(
				(drop_anchor NI_MARK)
				(move_abs 0 curr_col)
				(= following_string (ltrim (read)))
				(delete_block)
			)
		)
		(if (search_back "<*\\c[~ \\t\\n]")
			(inq_position NULL curr_indent_col)
		;else
			(= curr_indent_col 1)
		)
		(move_abs curr_line curr_col)

		;**
		;**		We've determined the last non-blank lines' indent level -- do return,
		;**	indent, line split, and clean up.
		;**

		(if (== (inq_assignment (inq_command) 1) "<Enter>")
			(self_insert (key_to_int "<Enter>"))
		;else
			(self_insert (key_to_int "<Ctrl-m>"))
		)
		(move_abs 0 curr_indent_col)

		(if (!= following_string "")
			(
				(= following_string (substr following_string 1 (- (strlen following_string) 1)))
				(insert following_string)
				(move_abs 0 curr_indent_col)
			)
		)
	)
)

;**
;**		slide_in:
;**
;**		This macros slides a marked block of text in one tab stop per press
;**	of the tab key (-->|).
;**

(macro slide_in
	(
		(int	start_line
				start_col
				end_line
				mark_type
		)
		(if (= mark_type (inq_marked start_line start_col end_line))
			(
				(int	cursor_line
						cursor_col
						mark_line
						mark_col
						num_lines
						old_mode
						tab_key
				)
				(inq_position cursor_line cursor_col)
				(swap_anchor)
				(inq_position mark_line mark_col)

				(if (!= mark_type COL_MARK)
					(= start_col 1)
				)
				(move_abs start_line start_col)
				(raise_anchor)

				(= old_mode (inq_mode))
				(insert_mode 1)
				(= tab_key (key_to_int "<Tab>"))

				(while (<= start_line end_line)
					(
						(search_fwd "[~ \t]")

						(if (!= (read 1) "\n")

							;**
							;**		Note that self_inserting the complete
							;**	key definition ensures the Tab is converted
							;**	to spaces if -t is used.
							;**

							(self_insert tab_key)
						)
						(move_abs (++ start_line) start_col)
					)
				)
				(move_abs mark_line mark_col)
				(drop_anchor mark_type)
				(move_abs cursor_line cursor_col)
				(insert_mode old_mode)
			)
		;else
			(self_insert (key_to_int "<Tab>"))
		)
	)
)

;**
;**		slide_out:
;**
;**		This macros slides a marked block of text out one tab stop per press
;**	of the back-tab key (|<--).
;**

(macro slide_out
	(
		(int	start_line
				start_col
				end_line
				mark_type
		)
		(if (= mark_type (inq_marked start_line start_col end_line))
			(
				(int	num_lines)

				(save_position)

				(if (!= mark_type COL_MARK)
					(= start_col 1)
				)
				(move_abs start_line start_col)

				(while (<= start_line end_line)
					(
						(int	curr_col)

						(search_fwd "[~ \t]")
						(inq_position NULL curr_col)

						(if (> curr_col start_col)
							(
								(drop_anchor 4)
								(back_tab)
								(inq_position NULL curr_col)

								(if (< curr_col start_col)
									(move_abs 0 start_col)
								)
								(delete_block)
							)
						)
						(move_abs (++ start_line) start_col)
					)
				)
				(restore_position)
			)
		;else
			(back_tab)
		)
	)
)

;**
;**		Template editing macros:
;**
;**		These macro performs simple template editing for C programs.  Each
;**	time the space bar is pressed, the characters before the cursor are
;**	checked to see if they are "if", "else if", "while", "for", "do",
;**	"switch" or "case" (or abbreviations for them).  These keywords must
;**	only be preceded with spaces or tabs, and be typed at the end of a
;**	line.  If a match is found, the remainder of the statement is filled
;**	in automatically.
;**
;**		In addition, a brace pairer is included -- this automatically
;**	inserts a matching brace at the proper indentation level when an
;**	opening brace is typed in.  To insert a brace without a matching
;**	brace (it attempts to be smart about matching braces, but you never
;**	can make this type of thing quite smart enough), type either Ctrl-{
;**	or quote the brace with Alt-q.
;**

;**
;**		.c_abbrev:
;**
;**		This function checks to see if the characters before the space just
;**	typed (and actually inserted by this function) are destined to be
;**	followed by the remainder of a C construct.
;**

(macro .c_abbrev
	(
		(int	done)

		(if (== (read 1) "\n")
			(
				(string	line)

				(int		loc)

				(save_position)
				(beginning_of_line)
				(= line (trim (ltrim (read))))
				(restore_position)

				(if (&& (! (index " \t\n" (substr line 1 1))) (&& (strlen line) (< (strlen line) 8)))
					(
						(int		length)

						(= line (+ "\xff" line))

						(if (&& (< _c_min_abbrev (strlen line))
								(= loc (search_string line ABBREV_LIST length 0)))
							(
								(string		completion)

								(= completion (substr ABBREV_LIST (+ loc length)))
								(= completion (substr completion 1 (- (index completion "\xff") 1)))
								(insert completion)

								(if (== (substr line 2 1) "d")
									(
										(open_line)
										(brace_expand)
										(save_position)
										(move_rel 1 0)
										(open_line)
										(insert "while ();")
										(restore_position)
									)
								;else
									;**
									;**		Don't back up for "else" and "return".  Also,
									;**	make sure completed templates aren't expanded
									;**	again.
									;**

									(if (&& (strlen completion) (&& (!= loc ELSE_LOC) (!= loc RETURN_LOC)))
										(prev_char)
									)
								)
								(= done (strlen completion))
							)
						)
					)
				)
			)
		)
		(if (! done)
			(if (== (inq_local_keyboard) _c_alt_template)
				(slide_in)
			;else
				(self_insert)
			)
		)
	)
)

;**
;**		brace_expand:
;**
;**		This function checks to see if the typed brace should be indented
;**	and matched to the current indenting level.
;**

(macro brace_expand
	(
		(string		line)

		(save_position)
		(beginning_of_line)
		(= line (read))
		(restore_position)
		(.c_open_brace)

		(if
			(&& 
				(search_string "<|{{else}|{do}}|{{typedef}|{struct}[ \t]@[~ \t\n]@}|)[ \t]@>" line)
				(== "" (trim (ltrim (read))))
			)
			(
				(int	col)

				(inq_position NULL col)

				(.c_indent)
				(save_position)

				(if (== col 2)
					(insert "\n}")
				;else
					(
						(inq_position NULL col)
						(insert "\n")

						(if (== _c_indent_close 1)
							(
								(move_abs 0 col)
								(insert "}")
							)
						;else
							(.c_close_brace)
						)
					)
				)
				(restore_position)
			)
		)
	)
)

;**
;**		just_brace, just_cbrace, just_space:
;**
;**		These functions insert unexpanded and expanded braces and spaces.
;**

(macro just_brace
	(insert "{")
)

(macro just_cbrace
	(insert "}")
)

(macro just_space
	(insert " ")
)

(macro .c_open_brace
	(
		(save_position)
		(beginning_of_line)

		(if (== "" (trim (ltrim (read))))
			(
				(restore_position)
				(.c_indent 1)

				(if (! _c_indent_open)
					(back_tab)
				)
			)
		;else
			(restore_position)
		)
		(self_insert '{')
	)
)
				
(macro .c_close_brace
	(
		(save_position)
		(beginning_of_line)

		(if (== "" (trim (ltrim (read))))
			(
				(restore_position)

				(if (|| (&& (! _c_indent_first) (== (.c_indent 1) 1)) (! _c_indent_close))
					(back_tab)
				)
			)
		;else
			(restore_position)
		)
		(self_insert '}')
	)
)

;**
;**		comment_block:
;**
;**		This macro comments out a block of code.  It tries to be intelligent
;**	about things like comments inside the block -- if it finds one, it
;**	escapes it and moves on.
;**
;**		Two different types of blocks are created, depending on the cursor
;**	start and end positions.  If both are in column one, comment_block
;**	assumes a "block" type comment is desired.  Block comments have "**"
;**	inserted in rows other than the first and last.
;**
;**		If the start and end columns are not both in column one, the area is
;**	simply bracketed with "/*" and "*/".
;**

(macro comment_block
	(
		(int	start_line
				start_col
				end_line
				end_col
				curr_col
		)
		(if (inq_marked start_line start_col end_line end_col)
			(
				(string	pattern)

				(raise_anchor)
				(save_position)
				(move_abs end_line end_col)
				(insert "\xff")
				(move_abs start_line start_col)

				(if (== start_col 1)
					(insert "/* ")
				;else
					(insert " /* ")
				)
				(if (&& (== start_col 1) (== end_col 1))
					(= pattern "{/\\*}|{\\*/}|{\\*\\*}|<|\xff")
				;else
					(= pattern "{/\\*}|{\\*/}|{\\*\\*}|\xff")
				)
				(while (&& (search_fwd pattern) (!= "\xff" (read 1)))
					(
						(inq_position NULL curr_col)

						(if (&& (== curr_col 1) (&& (== start_col 1) (== end_col 1)))
							(insert "**\t")
						;else
							(
								(insert "\\")
								(right)
							)
						)
					)
				)
				(delete_char)

				(if (== end_col 1)
					(insert "*/ ")
				;else
					(insert " */ ")
				)
				(restore_position)
			)
		;else
			(error "No marked block.")
		)
	)
)

;**
;**		uncomment_block:
;**
;**		This routine uncomments a block of code that was commented out by
;**	comment_block.  It removed the comment and leading "**" characters (if
;**	appropriate), and restores the internal comments to their original,
;**	un-escaped state.
;**

(macro uncomment_block
	(
		(int	start_line
				start_col
				end_line
				end_col
		)
		(if (inq_marked start_line start_col end_line end_col)
			(
				(raise_anchor)
				(save_position)
				(move_abs end_line end_col)
				(insert "\xff")
				(move_abs start_line start_col)

				(while (!= (read 1) "\xff")
					(
						(search_fwd "{</\\* }|{<\\*/ }|{ /\\* }|{<\\*\\*\t}|{ \\*/ }|{\\\\\\*}|{\\\\/\\*}|\xff")

						(if (!= (read 1) "\xff")
							(
								(if (== (read 1) "\\")
									(
										(delete_char)
										(right)
									)
								;else
									(
										(drop_anchor)

										(if (|| (!= (read 1) " ") (== (read 2) "**"))
											(move_rel 0 2)
										;else
											(move_rel 0 3)
										)
										(delete_block)
									)
								)
							)
						)
					)
				)
				(delete_char)
				(restore_position)
			)
		;else
			(error "No marked block.")
		)
	)
)
