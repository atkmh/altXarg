;**
;**		BRIEF -- Basic Reconfigurable Interactive Editing Facility
;**
;**		Written by Dave Nanian and Michael Strickman.
;**

;**
;**		column.m:
;**
;**		This file contains a set of macros that let perform block operations
;**	columns of text.  These macros are called by the standard replacement
;**	macros; this makes sure that the column functions aren't pulled in unless
;**	they're needed.
;**
;**		Revision history:
;**		-----------------

#define	REG_MARK		1
#define	COL_MARK		2
#define	LINE_MARK	3
#define	NI_MARK		4
#define	NOTHING		0
#define	REPLACE		1
#define	REMOVE		2

(extern	gen_block)

;**
;**		_col_copy, _do_col_copy:
;**
;**		This macro copies a marked area to another buffer.  It uses the
;**	generic block operation routine to loop through the marked lines.
;**	It then inserts these lines into a special buffer.  Once all the
;**	lines have been copied, this special buffer is copied to the scrap.
;**

(macro _col_copy
	(
		(int		col_buf
					append
		)
		(global	col_buf)

		(get_parm 0 append)
		(= col_buf (create_buffer "Column" NULL 1))
		(gen_block "_do_col_copy" "Copying columns to scrap")
		(_complete_col append)
		(raise_anchor)
		(message "Columns copied to scrap.")
	)
)

(macro _do_col_copy
	(
		(int		old_buf)

		(string	line)

		(get_parm 0 line)
		(= old_buf (inq_buffer))
		(set_buffer col_buf)

		(if (! (index line "\n"))
			(+= line "\n")
		)
		(insert line)
		(set_buffer old_buf)
		(returns NOTHING)
	)
)

;**
;**		_col_cut, _do_col_cut:
;**
;**		This macro cuts a marked area to another buffer.  It uses the
;**	generic block operation routine to loop through the marked lines.
;**	It then inserts these lines into a special buffer.  Once all the
;**	lines have been cut, this special buffer is copied to the scrap.
;**

(macro _col_cut
	(
		(int	start_col
				append
		)
		(get_parm 0 append)
		(inq_marked NULL start_col)
		(= col_buf (create_buffer "Column" NULL 1))
		(gen_block "_do_col_cut" "Deleting columns to scrap")
		(_complete_col append)
		(raise_anchor)
		(move_abs 0 start_col)
		(message "Columns deleted to scrap.")
	)
)

(macro _do_col_cut
	(
		(int		old_buf)

		(string	line)

		(get_parm 0 line)
		(= old_buf (inq_buffer))
		(set_buffer col_buf)

		(if (! (index line "\n"))
			(+= line "\n")
		)
		(insert line)
		(set_buffer old_buf)
		(returns REMOVE)
	)
)

;**
;**		_complete_col:
;**
;**		This routine puts the column scrap buffer onto the regular scrap
;**	and then deletes it.  If the append parameter is specified, it is passed
;**	through to copy.
;**

(macro _complete_col
	(
		(int	old_buf
				append
		)
		(get_parm 0 append)
		(= old_buf (inq_buffer))
		(set_buffer col_buf)
		(top_of_buffer)
		(drop_anchor COL_MARK)
		(end_of_buffer)
		(prev_char)
		(copy append)
		(set_buffer old_buf)
		(delete_buffer col_buf)
	)
)

;**
;**		_col_paste, _do_col_paste:
;**
;**		This routine pastes the standard scrap as columnar information.
;**

(macro _col_paste
	(
		(= col_buf (inq_buffer))
		(set_buffer (inq_scrap))
		(top_of_buffer)
		(drop_anchor LINE_MARK)
		(end_of_buffer)
		(gen_block "_do_col_paste" "Inserting columns")
		(raise_anchor)
		(set_buffer col_buf)
		(message "Columns inserted.")
	)
)

(macro _do_col_paste
	(
		(int	scrap_buf
				curr_col
		)
		(string	line)

		(= scrap_buf (inq_buffer))
		(get_parm 0 line)
		(= line (substr line 1 (- (strlen line) 1)))
		(set_buffer col_buf)
		(inq_position NULL curr_col)
		(insert line)
		(move_rel 1 0)
		(move_abs 0 curr_col)
		(set_buffer scrap_buf)
		(returns NOTHING)
	)
)

;**
;**		_col_delete, _do_col_delete:
;**
;**		This macro deletes a marked columnar area.  It uses the generic
;**	block operation routine to loop through the marked lines.  It then
;**	simply tells the routine to remove the information.
;**

(macro _col_delete
	(
		(int	start_col)

		(inq_marked NULL start_col)
		(gen_block "_do_col_delete" "Deleting columns")
		(raise_anchor)
		(move_abs 0 start_col)
		(message "Columns deleted.")
	)
)

(macro _do_col_delete
	(returns REMOVE)
)
