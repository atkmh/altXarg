;**
;**		BRIEF -- Basic Reconfigurable Interactive Editing Facility
;**
;**		Written by Dave Nanian and Michael Strickman.
;**

;**		pvcs.m:
;**
;**		This macro package makes BRIEF work quite well with PVCS.
;**

#define	READ_ONLY		0x01

(macro _init
	(
		(int		vcs_buf)

		(global	vcs_buf)

		;**
		;**	This macro cleans up modified/unmodified logfiles.
		;**

		(register_macro 5 "vcs_exit")
	)
)

;**
;**		_pvcs_new:
;**
;**		This macro creates a workfile from a PVCS logfile if the file
;**	does not exist.
;**

(macro _pvcs_new
	(
		(string	file_name
					path
					old_msg
					cmd_line
					old_path
					old_drive
					just_name
		)
		(int		ret_code
					curr_buf
					old_msg_level
		)
		;**
		;**		First, we retrieve the name of the file we're trying to
		;**	obtain.  This name is split into a filename component and
		;**	a path component.  We then change to the drive and directory
		;**	of this file, since most version control need to be run from
		;**	there to work properly.
		;**

		(inq_names file_name)

		(= path (substr file_name 1 (rindex file_name (substr file_name 3 1))))

		(if (> (strlen path) 3)
			(= path (substr path 1 (- (strlen path) 1)))
		)
		(= just_name (substr file_name (+ (rindex file_name (substr file_name 3 1)) 1)))

		(= old_msg_level (inq_msg_level))
		(set_msg_level 0)
		(= old_msg (inq_message))
		(message "Retrieving workfile %s..." just_name)
		(set_msg_level old_msg_level)

		(getwd "" old_drive)
		(getwd path old_path)
		(cd path)
		(cd (substr path 1 2))

		(= curr_buf (inq_buffer))

		(sprintf cmd_line "get (%s) >&bvcs.tmp" just_name)

		(if (= ret_code (dos cmd_line))
			(
				(if (> ret_code 0)
					(
						(int	buf_id)

						(set_buffer (= buf_id (create_buffer "PVCS Error" "bvcs.tmp" 1)))

						(if (! (search_fwd "{can't locate logfile}|{is not a directory}"))
							(
								(keyboard_push)
								(assign_to_key "<PgUp>" "page_up")
								(assign_to_key "<PgDn>" "page_down")
								(assign_to_key "<Esc>" "exit")
								(assign_to_key "<Home>" "top_of_buffer")
								(assign_to_key "<End>" "end_of_buffer")
								(assign_to_key "<Up Arrow>" "up")
								(assign_to_key "<Down>" "down")

								(create_window 2 23 78 2 "PVCS error window -- Esc to exit")
								(attach_buffer buf_id)
								(refresh)

								(process)

								(keyboard_pop)
								(delete_window)
							)
						)
						(delete_buffer buf_id)
						(set_buffer curr_buf)
					)
				)
				(message "%s" old_msg)
			)
		;else
			(
				(int	size
						file_date
						file_time
						attribute
				)
				;**
				;**		If the file has been successfully retrieved, we put its
				;**	name in the vcs_buf along with its current date, time, size
				;**	and attribute.  This information is used later to determine
				;**	whether or not the file should be checked in.
				;**

				(if (! vcs_buf)
					(= vcs_buf (create_buffer "PVCS" NULL 1))
				)
				(set_buffer vcs_buf)

				(insert (+ file_name "\n"))
				(file_pattern just_name)
				(find_file NULL size file_date file_time attribute)
				(sprintf path "%d %d %d %d\n" size file_date file_time attribute)
				(insert path)
				(delete_buffer curr_buf)
				(set_buffer (create_buffer just_name file_name))

				(if (& attribute READ_ONLY)
					(error "NOCHECKLOCK not specified; file is read-only.")
				;else
					(message "")
				)
			)
		)
		(del "bvcs.tmp")
		(cd old_path)
		(cd (substr old_drive 1 2))
		(return "")
	)
)

;**
;**		vcs_exit:
;**
;**		This macro registers another macro, which must run LAST!  This is
;**	because it deletes (or can delete) a lot of files that are being
;**	edited.  It also deletes lots of buffers -- buffers that other macros
;**	may want around.  Tough!
;**

(macro vcs_exit

	(if vcs_buf
		(register_macro 5 "_vcs_exit")
	)
)

(macro _vcs_exit
	(
		(string	just_name
					file_name
					path
					old_path
					cmd_line
					reply
		)
		(int		curr_buf
					ret_code
					old_msg_level
					file_date
					old_date
					file_time
					old_time
					size
					old_size
					attribute
					old_attribute
		)
		(set_buffer vcs_buf)
		(= curr_buf (next_buffer 1))

		;**
		;**		First, we want to delete all of the buffers except for
		;**	the vcs_buf.  This frees up as much memory as possible.
		;**

		(while (!= curr_buf vcs_buf)
			(
				(delete_buffer curr_buf)
				(set_buffer vcs_buf)
				(= curr_buf (next_buffer 1))
			)
		)
		(top_of_buffer)

		(= old_msg_level (inq_msg_level))
		(set_msg_level 0)

		(while (!= (read) "\n")
			(
				(= file_name (read))
				(= file_name (substr file_name 1 (- (strlen file_name) 1)))
				(= path (substr file_name 1 (rindex file_name (substr file_name 3 1))))
		
				(if (> (strlen path) 3)
					(= path (substr path 1 (- (strlen path) 1)))
				)
				(= just_name (substr file_name (+ (rindex file_name (substr file_name 3 1)) 1)))
				(down)
				(= file_name (read))
				(= old_size (atoi file_name))
				(= file_name (substr file_name (+ (index file_name " ") 1)))
				(= old_date (atoi file_name))
				(= file_name (substr file_name (+ (index file_name " ") 1)))
				(= old_time (atoi file_name))
				(= file_name (substr file_name (+ (index file_name " ") 1)))
				(= old_attribute (atoi file_name))
				(down)

				(getwd "" cmd_line)
				(getwd path old_path)
				(= old_path (+ (substr cmd_line 1 1) (substr old_path 2)))
				(cd path)
				(cd (substr path 1 2))

				(file_pattern just_name)
				(find_file NULL size file_date file_time attribute)

				(if (|| (!= old_size size) (|| (!= old_date file_date) (|| (!= old_time file_time) (|| (!= old_attribute attribute)))))
					(
						(if (!= reply "q")
							(
								(message "Checking workfile \"%s\"..." just_name)

								(sprintf cmd_line "vdiff -q -t -r %s %s >&bvcs.tmp" just_name just_name)

								(if (== (= ret_code (dos cmd_line)) 2)
									(
										(if (!= reply "g")
											(if (! (get_parm NULL reply (+ (+ "Check in " just_name) " [yngq]? ") 1))
												(= reply "q")
											)
										)
										(if (&& (strlen reply) (index "yg" (lower reply)))
											(
												(sprintf cmd_line "put (%s)" just_name)
												(dos cmd_line)
											)
										)
									)
								;else
									(if (== ret_code 0)
										(del just_name)
									)
								)
							)
						)
					)
				;else
					(del just_name)
				)
				(del "bvcs.tmp")
				(cd (substr old_path 3))
				(cd (substr old_path 1 2))
			)
		)
		(delete_buffer vcs_buf)
	)
)
