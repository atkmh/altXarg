;**
;**		BRIEF -- Basic Reconfigurable Interactive Editing Facility
;**
;**		Written by Dave Nanian and Michael Strickman.
;**

;**
;**		windows.m:
;**
;**		This file contains all of the standard BRIEF macros for window
;**	manipulation.
;**
;**		Revision history:
;**		-----------------

(extern	display_file_name)

;**
;**		change_window:
;**
;**		This macro adds a file name display to the normal change_window
;**	function.
;**

(replacement change_window
	(
		(if (!= (inq_called) "")
			(return (change_window))
		;else
			(
				(int	ret_code)

				(set_msg_level 0)

				(if (> (= ret_code (change_window)) 0)
					(display_file_name)
				)
				(return ret_code)
			)
		)
	)
)

;**
;**		create_edge:
;**
;**		This macro sets colors for newly created windows.
;**

(replacement create_edge
	(
		(int	ret_code)

		(if (> (= ret_code (create_edge)) 0)
			(window_color)
		)
		(return ret_code)
	)
)

;**		to_top:
;**
;**		This function moves the current line to the top of the window.
;**

(macro to_top
	(
		(int			curr_line)

		(inq_position curr_line)
		(set_top_left curr_line)
	)
)

;**		to_bottom:
;**
;**		This function moves the current line to the bottom of the window,
;**	or as close as it possibly can (line number one must stay at the top
;**	of the window).
;**

(macro to_bottom
	(
		(int			curr_line
						num_lines
		)
		(inq_position curr_line)
		(inq_window_size num_lines)

		(if (above_eq curr_line num_lines)
			(set_top_left (- curr_line (- num_lines 1)))
		;else
			(set_top_left 1)
		)
	)
)

;**
;**		center_line:
;**
;**		This macro attempts to center the given line in the current window.
;**	If the line cannot be centered because it is too close to the top of
;**	the window, it is left in the same place.
;**

(macro center_line
	(
		(int	curr_line
				num_lines
				top_line
		)
		(inq_position curr_line)
		(inq_window_size num_lines)
		(++ num_lines)
		(/= num_lines 2)
		(= top_line (- curr_line num_lines))

		(if (&& (below top_line curr_line) (!= top_line 0))
			(set_top_left top_line)
		;else
			(set_top_left 1)
		)
	)
)

;**
;**		screen_up:
;**
;**		This macro scrolls the screen up by one line, leaving the cursor on
;**	the same line, if possible.
;**

(macro screen_up
	(
		(int		curr_line
					top_line
		)
		(inq_position curr_line)
		(top_of_window)
		(inq_position top_line)

		(if (== top_line curr_line)
			(++ curr_line)
		)
		(set_top_left (++ top_line))
		(move_abs curr_line 0)
	)
)

;**
;**		screen_down:
;**
;**		This macro scrolls the screen down by one line, leaving the cursor
;**	on the same line, if possible.
;**

(macro screen_down
	(
		(int		curr_line
					top_line
					end_line
		)
		(inq_position curr_line)
		(end_of_window)
		(inq_position end_line)
		(top_of_window)
		(inq_position top_line)

		(if (!= top_line 1)
			(
				(set_top_left (-- top_line))
				(-= curr_line (== end_line curr_line))
			)
		)
		(move_abs curr_line 0)
	)
)

;**
;**		left_side:
;**
;**		This macro moves the cursor to the left side of the window.
;**

(macro left_side
	(
		(int		shift)

		(inq_window_size NULL NULL shift)
		(move_abs 0 (+ shift 1))
	)
)

;**
;**		right_side:
;**
;**		This macro moves the cursor to the left side of the window.
;**

(macro right_side
	(
		(int		num_cols
					shift
		)
		(inq_window_size NULL num_cols shift)
		(move_abs 0 (+ num_cols shift))
	)
)
