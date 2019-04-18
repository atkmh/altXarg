;**
;**		BRIEF -- Basic Reconfigurable Interactive Editing Facility
;**
;**		Written by Dave Nanian and Michael Strickman.
;**

;**
;**		search.m:
;**
;**		This file contains all of the standard BRIEF macros for search
;**	and translate.
;**
;**		Revision history:
;**		-----------------

;**
;**		search:
;**
;**		This macro defines the global variables needed by the search and
;**	translate macros.
;**

#define	FORWARD	1						;** Value used to search FORWARD.
#define	BACKWARD	0						;** Value used to search BACKWARD.

#define	TRUE		1						;** Standard definitions of TRUE & FALSE.
#define	FALSE		0

(extern	_dir
			_t_dir
			_reg_exp
			_block_search
			_s_pat
			_t_pat
			_r_pat
)

;**
;**		next_word, _next_word:
;**
;**		Locates the next word in the file using a regular expression.  If
;**	there are no following words in the file, the cursor does not move.
;**

(macro next_word
	(
		(string	extension)

		(inq_names NULL extension)
		(= extension (+ (+ "." extension) "_next_word"))
		(returns (execute_macro (if (inq_macro extension) extension "_next_word")))
	)
)


(macro _next_word
	(
		(int	ret_val)

		(save_position)

		(if (! (index " \t" (read 1)))
			(next_char)
		)
		(= ret_val (search_fwd "<|[ \\t][~ \\t\\n]"))

		(if (index " \t" (read 1))
			(next_char)
		)
		(restore_position (! ret_val))
		(returns ret_val)
	)
)

;**
;**		previous_word, _previous_word:
;**
;**		Locates the previous word in the file using a regular expression.  If
;**	there are no preceding words in the file, the cursor does not move.
;**

(macro previous_word
	(
		(string	extension)

		(inq_names NULL extension)
		(= extension (+ (+ "." extension) "_previous_word"))
		(returns (execute_macro (if (inq_macro extension) extension "_previous_word")))
	)
)

(macro _previous_word
	(
		(int	ret_val)

		(save_position)

		(if (! (index " \t" (read 1)))
			(prev_char)
		)
		(= ret_val (search_back "<|[ \\t][~ \\t\\n]" 2))

		(if (index " \t" (read 1))
			(next_char)
		)
		(restore_position (! ret_val))
		(returns ret_val)
	)
)

;**
;**		.c_next_word, .c_previous_word, .cpp_next_word, .cpp_previous_word,
;**		.h_next_word, .h_previous_word, .hpp_next_word, .hpp_previous_word,
;**		.inc_next_word, .inc_previous_word, .m_next_word, .m_previous_word,
;**		.asm_next_word, .asm_previous_word:
;**
;**		These definitions are used as "language sensitive" word patterns
;**	for C, Assembler and the BRIEF macro language.
;**


(macro .c_next_word
	(
		(int	ret_val)

		(save_position)

		(if (! (index " \t()[]{},.;\"'+-=*/|!&<>#" (read 1)))
			(next_char)
		)
		(= ret_val (search_fwd "<|[ \t()\\[\\]{},.;\"'+\\-*\\\\/=|!&><#][~ \t()\\[\\]{},.;\"'+\\-*\\\\/=|!&><#\n]"))

		(if (index " \t()[]{},.;\"'+-=*/|!&<>#" (read 1))
			(next_char)
		)
		(restore_position (! ret_val))
		(returns ret_val)
	)
)

(macro .c_previous_word
	(
		(int	ret_val)

		(save_position)

		(if (! (index " \t()[]{},.;\"'+-=*/\\|!&<>#" (read 1)))
			(prev_char)
		)
		(= ret_val (search_back "<|[ \t()\\[\\]{},.;\"'+\\-*\\\\/=|!&><#][~ \t()\\[\\]{},.;\"'+\\-*\\\\/=|!&><#\n]" 2))

		(if (index " \t()[]{},.;\"'+-=*/|!&<>#" (read 1))
			(next_char)
		)
		(restore_position (! ret_val))
		(returns ret_val)
	)
)

(macro .cpp_next_word
	(returns (.c_next_word))
)

(macro .cpp_previous_word
	(returns (.c_previous_word))
)

(macro .h_next_word
	(returns (.c_next_word))
)

(macro .h_previous_word
	(returns (.c_previous_word))
)

(macro .hpp_next_word
	(returns (.c_next_word))
)

(macro .hpp_previous_word
	(returns (.c_previous_word))
)

(macro .inc_next_word
	(returns (.c_next_word))
)

(macro .inc_previous_word
	(returns (.c_previous_word))
)

(macro .m_next_word
	(
		(int	ret_val)

		(save_position)

		(if (! (index " \t();\"'#" (read 1)))
			(next_char)
		)
		(= ret_val (search_fwd "<|[ \t();\"'#][~ \t();\"'#\n]"))

		(if (index " \t();\"'#" (read 1))
			(next_char)
		)
		(restore_position (! ret_val))
		(returns ret_val)
	)
)

(macro .m_previous_word
	(
		(int	ret_val)

		(save_position)

		(if (! (index " \t();\"'#" (read 1)))
			(prev_char)
		)
		(= ret_val (search_back "<|[ \t();\"'#][~ \t();\"'#\n]" 2))

		(if (index " \t();\"'#" (read 1))
			(next_char)
		)
		(restore_position (! ret_val))
		(returns ret_val)
	)
)

(macro .asm_next_word
	(returns (.c_next_word))
)

(macro .asm_previous_word
	(returns (.c_previous_word))
)

;**
;**		search_fwd:
;**
;**		This macro is used to search forward in the buffer from the
;**	keyboard level.  If there is a previously defined pattern, it is
;**	displayed on the command line.  Typing any character makes this pattern
;**	vanish and the new one will take its place.  If Esc is typed, the old
;**	pattern is retained.
;**

(replacement search_fwd
	(
		;**
		;**		If we're not being called from the keyboard, we don't want
		;**	to extend the search command at all.
		;**

		(if (!= (inq_called) "")
			(return (search_fwd))
		;else
			(
				(int	old_msg_level
						ret_code
				)
				(string	prompt)

				;**
				;**		We set the message level to 0 so that the user can see
				;**	the messages that the search command displays.
				;**

				(= old_msg_level (inq_msg_level))
				(set_msg_level 0)

				;**
				;**		It's nice to be able to see the setting of the regular
				;**	expression toggle in the search string.  We check to see
				;**	what it is, and change the search prompt accordingly.
				;**

				(sprintf prompt " Search %sfor: " (if _reg_exp "" "(RE off) "))

				(if (get_parm 0 _s_pat prompt NULL _s_pat)
					(
						(= _dir FORWARD)

						;**
						;**		Finally, we search for the specified pattern, using
						;**	the current regular expression setting.  Since we've
						;**	given the pattern in the function call, the user is
						;**	not prompted.
						;**

						(= ret_code (search_fwd _s_pat _reg_exp NULL _block_search))
					)
				;else
					(= ret_code -1)
				)
				(set_msg_level old_msg_level)
				(returns ret_code)
			)
		)
	)
)

;**
;**		search_back:
;**
;**		This macro is used to search backward in the buffer from the
;**	keyboard level.  If there is a previously defined pattern, it is
;**	displayed on the command line.  Typing any character makes this pattern
;**	vanish and the new one will take its place.  If Esc is typed, the old
;**	pattern is retained.
;**

(replacement search_back
	(
		;**
		;**		If we're not being called from the keyboard, we don't want
		;**	to extend the search command at all.
		;**

		(if (!= (inq_called) "")
			(return (search_back))
		;else
			(
				(int			old_msg_level
								ret_code
				)
				(string		prompt)

				;**
				;**		We set the message level to 0 so that the user can see
				;**	the messages that the search command displays.
				;**

				(= old_msg_level (inq_msg_level))
				(set_msg_level 0)

				;**
				;**		It's nice to be able to see the setting of the regular
				;**	expression toggle in the search string.  We check to see
				;**	what it is, and change the search prompt accordingly.
				;**

				(sprintf prompt " Search %sfor: " (if _reg_exp "" "(RE off) "))

				;**
				;**		Here we retrieve the search pattern for the user.  Note
				;**	that we pass the previous search pattern (which is stored in
				;**	the global variable _s_pat) to _get_default as a default prompt
				;**	response.
				;**

				(if (get_parm 0 _s_pat prompt NULL _s_pat)
					(
						(= _dir BACKWARD)

						;**
						;**		Finally, we search for the specified pattern, using
						;**	the current regular expression setting.  Since we've
						;**	given the pattern in the function call, the user is
						;**	not prompted.
						;**

						(= ret_code (search_back _s_pat _reg_exp NULL _block_search))
					)
				;else
					(= ret_code -1)
				)
				(set_msg_level old_msg_level)
				(returns ret_code)
			)
		)
	)
)

;**
;**		translate_back:
;**
;**		This routine handles calls to translate back from the keyboard level.
;**

(macro translate_back
	(returns (translate))
)

;**
;**		translate:
;**
;**		This routine handles calls to translate from the keyboard level,
;**	making sure that the call heeds the value of the regular expression
;**	toggle.  As a special bonus, BRIEF will use the value of the last
;**	thing searched for as the translation pattern if no pattern is
;**	entered.  Once a translate pattern is specified, the search and
;**	translate patterns separate -- a pattern is maintained for each
;**	operation.
;**

(replacement translate
	(
		(int	old_msg_level
				ret_code
				dir
		)
		(string	pattern
					default_pat
					prompt
		)
		;**
		;**		If we're not being called from the keyboard, we don't want
		;**	to extend the search command at all.
		;**

		(if (!= (inq_called) "")
			(if (!= (inq_called) "translate_back")
				(return (translate))
			;else
				(= dir BACKWARD)
			)
		;else
			(= dir FORWARD)
		)
		(= old_msg_level (inq_msg_level))
		(set_msg_level 0)

		;**
		;**		It's nice to be able to see the setting of the regular
		;**	expression toggle in the search string.  We check to see
		;**	what it is, and change the translate prompt accordingly.
		;**

		(sprintf prompt "%c Pattern%s: " (if dir '' '') (if _reg_exp "" " (RE off)"))

		;**
		;**		If there haven't been any previous translate patterns,
		;**	we use the last search pattern as the default response to
		;**	the Pattern: prompt.  Otherwise, we use the previous
		;**	translate pattern.
		;**

		(if (! (strlen _t_pat))
			(= default_pat _s_pat)
		;else
			(= default_pat _t_pat)
		)
		(if (get_parm 0 pattern prompt NULL default_pat)
			(
				(if (get_parm 1 _r_pat "Replacement: " NULL _r_pat)
					(
						(= _t_pat pattern)
						(= _t_dir dir)
						(= ret_code (translate _t_pat _r_pat NULL _reg_exp NULL (inq_marked) _t_dir))
					)
				;else
					(= ret_code -1)
				)
			)
		;else
			(= ret_code -1)
		)
		(set_msg_level old_msg_level)
		(returns ret_code)
	)
)

;**
;**		search_again:
;**
;**		This macro uses the information provided by search_fwd and search_back
;**	to search for the same pattern again, in the same direction.
;**

(macro search_again
	(
		(int		ret_code
					old_msg_level
		)
		;**
		;**		We set the message level to 0 so that the user can see
		;**	the messages that the search commands display.
		;**

		(= old_msg_level (inq_msg_level))
		(set_msg_level 0)

		;**
		;**		We check to see if there is a previous search pattern --
		;**	if not, we can't search for it.
		;**

		(if (strlen _s_pat)
			(
				;**
				;**		We're searching again, so we have to move before
				;**	we call the appropriate search routine.  We do this
				;**	to ensure we don't find the same pattern a second
				;**	time.  The current cursor location is saved on the
				;**	position stack because of this:  if the search fails,
				;**	we want to put the cursor back where it was before the
				;**	movement.
				;**

				(save_position)

				(if (== _dir BACKWARD)
					(
						(prev_char)
						(= ret_code (search_back _s_pat _reg_exp NULL _block_search))
					)
				;else
					(
						(next_char)
						(= ret_code (search_fwd _s_pat _reg_exp NULL _block_search))
					)
				)
				;**
				;**		Restore the cursor position if the search failed.
				;**

				(restore_position (! ret_code))
			)
		;else
			(
				(error "No previous search pattern.")
				(beep)
			)
		)
		(set_msg_level old_msg_level)
		(returns ret_code)
	)
)

;**
;**		translate_again:
;**
;**		This call implements the translate_again command -- it uses the values
;**	of the various global translate variables to perform the translation.
;**

(macro translate_again
	(
		(int	ret_code
				old_msg_level
		)
		(= old_msg_level (inq_msg_level))
		(set_msg_level 0)

		(if (|| (strlen _t_pat) (strlen _r_pat))
			(= ret_code (translate _t_pat _r_pat NULL _reg_exp NULL (inq_marked) _t_dir))
		;else
			(
				(error "No previous translate pattern.")
				(beep)
			)
		)
		(set_msg_level old_msg_level)
		(returns ret_code)
	)
)

;**
;**		toggle_re:
;**
;**		This macro toggles the state of the regular expression global
;**	variable, which controls whether regular expressions are used during
;**	search and translate.
;**

(macro toggle_re
	(
		(int	ret_code
				previous_value
		)
		(= previous_value _reg_exp)

		(if (! (= ret_code (get_parm 0 _reg_exp)))
			(= _reg_exp (! _reg_exp))
		)
		(if (|| (! ret_code) (== (inq_called) ""))
			(
				;**
				;**		This displays a message on the status line showing the
				;**	new regular expression setting.  Note the use of (if) --
				;**	this is the equivalent of the C ?: operator.  If the
				;**	expression is true, the statement evaluates to "off";
				;**	otherwise, it evaluates to "on".
				;**
				;**		Also note that the message is not displayed unless
				;**	the macro is called from the keyboard or the command is
				;**	used as a toggle.
				;**

				(message "Regular expressions %s." (if _reg_exp "on" "off"))
			)
		)
		(returns previous_value)
	)
)

;**
;**		block_search:
;**
;**		This macro toggles the state of block searching.
;**

(macro block_search
	(
		(int	ret_code
				previous_value
		)
		(= previous_value _block_search)

		(if (! (= ret_code (get_parm 0 _block_search)))
			(= _block_search (! _block_search))
		)
		(if (|| (! ret_code) (== (inq_called) ""))
			(message "Block searching %s." (if _block_search "on" "off"))
		)
		(returns previous_value)
	)
)

;**
;**		i_search:
;**
;**		This macro implements a simple incremental search.  It does not
;**	allow regular expressions to be specified.  The Esc key terminates
;**	the search.
;**
;**		The backspace key moves you to the previously matched pattern.
;**

(macro i_search
	(
		(int			char
						level
		)
		(string		pattern
						character
						assignment
		)
		;**
		;**		We use the save_position/restore_position commands to keep
		;**	track of the previously matched location.  Searching back for
		;**	the identical pattern would not work, since it would match the
		;**	current occurrence.  In addition, prev_char then search_back
		;**	would not match if the current occurrence were the correct one.
		;**

		(save_position)

		(while TRUE
			(
				;**
				;**		Since we want the cursor to remain on the screen in the
				;**	proper place, we create a "pseudo-cursor" with an IBM
				;**	graphics character.
				;**

				(message "I-search for: %sÜ" pattern)

				(while (== (= char (read_char)) -1))

				(if (== char (key_to_int "<Esc>"))
					(break)
				)
				(sprintf character "%s#%d" character char)
				(= assignment (inq_assignment character))

				(if (|| (== assignment "self_insert") (== assignment "nothing"))
					(
						(if (== char (key_to_int "<Backspace>"))
							(
								(if (> (strlen pattern) 1)
									(= pattern (substr pattern 1 (- (strlen pattern) 1)))
								;else
									(= pattern "")
								)
								(restore_position)
		
								(if (! (-- level))
									(
										(save_position)
										(= level 1)
									)
								)
							)
						;else
							(
								;**
								;**		Now we have a character that we can search for.
								;**	We add it to the string of characters, and use
								;**	the search_fwd command to locate it.  While we're
								;**	searching, we place an ellipsis after the
								;**	string, so the user know's we're doing something.
								;**

								(sprintf character "%c" (& char 0xff))
								(+= pattern character)
								(save_position)
								(message "I-search for: %sÜ..." pattern)

								(if (! (search_fwd pattern FALSE))
									(
										(beep)
										(restore_position)
										(= pattern (substr pattern 1 (- (strlen pattern) 1)))
									)
								;else
									(++ level)
								)
							)
						)
						(refresh)
						(= character "")
					)
				;else
					(if (!= assignment "ambiguous")
						(
							(= character "")

							(if (== assignment "search_again")
								(
									(message "I-search for: %sÜ..." pattern)
									(save_position)
									(next_char)

									(if (! (search_fwd pattern FALSE))
										(
											(beep)
											(restore_position)
										)
									;else
										(
											(refresh)
											(restore_position FALSE)
										)
									)
								)
							;else
								(beep)
							)
						)
					)
				)
			)
		)
		;**
		;**		When finished, we pop all of the saved positions off the
		;**	stack.  Note the use of the "pop, don't move" parameter with
		;**	restore_position.
		;**

		(while (>= (-- level) 0)
			(restore_position FALSE)
		)
		(message "I-search ended.")
	)
)
