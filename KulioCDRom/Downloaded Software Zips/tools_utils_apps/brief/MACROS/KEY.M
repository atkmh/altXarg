;**
;**		BRIEF -- Basic Reconfigurable Interactive Editing Facility
;**
;**		Written by Dave Nanian and Michael Strickman.
;**

;**		key.m:
;**
;**		This macro makes it easy to input the yucchy assign_to_key
;**	key descriptions.  Note that if the user answers yes to the
;**	question "Recognize that specific %c? ", the entire keycode,
;**	including the scan code, is used as a string.  This forces
;**	BRIEF to use only that specific key on the keyboard.
;**
;**		Revision history:
;**		-----------------

(macro key
	(
		(int		key_value
					done
		)
		(string	to_insert
					reply
		)
		(= to_insert "\"")
		(= done 0)
		(message "Press the keys you want converted, Esc to end.")

		(while (! done)
			(
				(while (== (= key_value (read_char)) -1))

				(if (!= key_value 283)
					(
						(if (% key_value 256)
							(
								(sprintf reply "%c" (% key_value 256))

								(if (index "0123456789*.-+\t\n" reply)
									(
										(sprintf reply "Recognize only that specific %c? " key_value)

										(if (get_parm NULL reply reply 1)
											(
												(if (! (index "yY" reply))
													(%= key_value 256)
												)
											)
										;else
											(= done 2)
										)
									)
								;else
									(%= key_value 256)
								)
							)
						)
						(if (! done)
							(
								(sprintf reply "#%d" key_value)
								(+= to_insert reply)
							)
						)
					)
				;else
					(= done 1)
				)
				(if (! done)
					(message "Continue, or Esc to end.")
				)
			)
		)
		(if (!= done 2)
			(if (> (strlen to_insert) 1)
				(
					(+= to_insert "\"")
					(insert to_insert)
					(message "Sequence inserted.")
				)
			;else
				(message "Nothing to insert.")
			)
		)
	)
)
