;**
;**		BRIEF -- Basic Reconfigurable Interactive Editing Facility
;**
;**		Written by Dave Nanian and Michael Strickman.
;**

;**
;**		compile.m:
;**
;**		This file contains all of the standard BRIEF macros for compiling
;**	files.
;**
;**		Revision history:
;**		-----------------

(extern	add_to_path
			next_error
			_check_warnings
)

;**
;**		compile_it:
;**
;**		This function automatically compiles the file in the current
;**	buffer.  It uses the "BC<extension>" environment variable to
;**	determine what to do with any given file.  If no "BC<extension>"
;**	environment variable exists for the specific file extension being
;**	compiled, compile_it checks to see if it's ".c", ".m" or ".asm".  If
;**	it's a macro file the "cm" macro is executed; if it's a C file, a
;**	generic "cc" command is used, and if it's an ASM file, the Macro
;**	Assembler is invoked.
;**
;**		Other compilers can be supported very easily.  Simply set a
;**	"BC<extension>" environment variable to the "pass string" you
;**	want to use.  For example, if you wanted to call the (fictitious)
;**	UnderWare C compiler, which has two passes called "under" and "ware",
;**	you'd use the command:
;**
;**			set bcc="under %s;ware %s"
;**
;**		You must place the pass string in quotes.  If you don't, compile_it
;**	calls a macro named whatever is in the pass string.  So, for example,
;**	if you accidently set your pass string using the command:
;**
;**			set bcc=under %s;ware %s
;**
;**	compile_it would call a macro named "under %s;ware %s".  This probably
;**	isn't what you want -- but this feature can be useful if you want to
;**	run some sort of custom macro for the file extension (compile_it does
;**	this when compiling cm files).
;**
;**		Also note that DOS requires you to double any % characters that
;**	appear in a batch file.  So if you were setting the BCC variable in
;**	your autoexec, you would use the line:
;**
;**			set bcc="under %%s;ware %%s"
;**
;**		Each pass begins with the name of the executable program that does
;**	that compilation pass.  That is followed by the a space, the special
;**	string "%s", which is replaced by the filename (with NO extension),
;**	and the multiple pass separation character ";".  If you want to put
;**	a ";" in your pass string, use "\;".
;**
;**		These special characters are very important -- don't forget them!
;**	Remember that the special "%s" string is only replaced by the filename,
;**	not the filename and the extension.  Up to two of these can be specified
;**	in any given pass.  If your compiler requires the extension as well,
;**	place it after this string (e.g. "cc -c %s.c").
;**
;**		If you want to pass options to your compiler, you can place them
;**	either before or after the "%s".  Placing them before puts the option
;**	before the filename, and vice versa.
;**
;**		If you compiler doesn't return an error code, put an exclamation
;**	point in front of the first pass string (either inside or outside the
;**	quotes); this will override the current warnings_only setting and
;**	automatically check for errors in the compiler output.
;**

(macro compile_it
	(
		(string	extension
					command
		)
		(inq_names NULL extension)
		(= command (trim (ltrim (inq_environment (+ "BC" (upper extension))))))

		(if (!= command "")
			(
				(if (index command "\"")
					(
						(int	loc)

						(while (= loc (index command "\""))
							(= command (+ (substr command 1 (- loc 1)) (substr command (+ loc 1))))
						)
						(if (== "!" (substr command 1 1))
							(returns (cc (substr command 2) extension 1))
						;else
							(returns (cc command extension))
						)
					)
				;else
					(if (== "!" (substr command 1 1))
						(returns (execute_macro (substr command 2) 1))
					;else
						(returns (execute_macro command _check_warnings))
					)
				)
			)
		;else
			(
				(if (== extension "m")
					(returns (cm))
				;else
					(if (== extension "asm")
						(returns (cc "masm %s\\;" extension))
					;else
						(if (== extension "c")
							(returns (cc "cc -c %s.c" extension))
						;else
							(
								(error "Can't compile: no BC%s environment variable." (upper extension))
								(returns -1)
							)
						)
					)
				)
			)
		)
	)
)

;**
;**		warnings_only:
;**
;**		This macro toggles whether or not errors are searched for when a
;**	compile is done and the compiler returns "no errors".  Note that its
;**	value is saved in the state file.
;**

(macro warnings_only
	(
		(int		ret_code
					previous_value
		)
		(= previous_value _check_warnings)

		(if (! (= ret_code (get_parm 0 _check_warnings)))
			(= _check_warnings (! _check_warnings))
		)
		(if (|| (! ret_code) (== (inq_called) ""))
			(message "Compile warning detection %s." (if _check_warnings "on" "off"))
		)
		(returns previous_value)
	)
)

;**
;**		cc:
;**
;**		This routine compiles the file in the current buffer using the
;**	passed "pass string" and the BRIEF DOS command.  It needs a lot
;**	of memory to run (you should have at least 256K and start with -M20)
;**	so be careful!
;**
;**		The "pass string" passed should be of the form:
;**
;**			pass_1 %s;pass_2 %s;...pass_n %s
;**
;**		The optional second parameter is an extended file type -- this is
;**	used by the "cm" macro, and to compile other types of files (e.g.
;**	.asm).
;**
;**		If no pass string is specified, it defaults to a generic "cc"
;**	command.  If no extension is specified, it defaults to "c".
;**

(macro cc
	(
		(string		file_name			;** The name of the file we're compiling.
						command_line		;** The compile command line.
						path					;** The path of the file we're compiling.
						old_path				;** The original path we were on.
						passes				;** The names of the passes.
						error_file			;** The file to put error information in.
		)
		(int			loc					;** Generic index place holder.
						ret_code				;** Return code from DOS.
						buffer_id			;** Buffer ID of error buffer.
						check_warnings		;** Examine resule of compile for errors?
		)
		;**
		;**		We get the name of the file from inq_names (the extension is
		;**	put in the command_line variable so we don't have to declare too
		;**	many strings) and check to see if it is a C file.
		;**

		(if (! (get_parm 1 passes))
			(= passes "c")
		)
		(if (! (get_parm 2 check_warnings))
			(= check_warnings _check_warnings)
		)
		(inq_names path command_line file_name)
		(= ret_code 1)

		(if (== command_line passes)
			(
			;**
			;**		If the file has been modified, we want to make sure the
			;**	current version gets compiled, so we write it to disk.
			;**
			;**		Note that if the user does not specify a pass string, it
			;**	defaults to a generic "cc" command, which works with the
			;**	Wizard C compiler (and a few others).
			;**

				(if (! (get_parm 0 passes))
					(= passes "cc -c %s.c")
				)
				(if (inq_modified)
					(
						(int			old_msg_level)

						(= old_msg_level (inq_msg_level))
						(set_msg_level 0)
						(= ret_code (write_buffer))
						(set_msg_level old_msg_level)
					)
				)
				(if (>= ret_code 0)
					(
						;**
						;**		Now we parse the filename off the path string,
						;**	making sure to handle the possible presence of forward
						;**	and backward slash characters.  We then replace the
						;**	file_name's ".c" with ".err" for redirection purposes.
						;**
		
						(= path (substr path 1 (rindex path (substr path 3 1))))

						(if (> (strlen path) 3)
							(= path (substr path 1 (- (strlen path) 1)))
						)
						(= file_name (substr file_name 1 (- (index file_name ".") 1)))
						(= error_file (+ file_name ".err"))
						(= ret_code 0)
		
						;**
						;**		We want the .obj file to end up in the file's
						;**	directory, so we change to the directory where the
						;**	file is, saving the current directory.  We also make
						;**	the file's drive the default drive.
						;**
		
						(getwd "" command_line)
						(getwd path old_path)
						(= old_path (+ (substr command_line 1 1) (substr old_path 2)))
						(cd path)
						(cd (substr path 1 2))
		
						;**
						;**		If there is already a buffer for the error file, we
						;**	"create" it (create_buffer returns the ID of a buffer
						;**	that already existed) and then delete it immediately.
						;**	Note that under some very obscure circumstances, the
						;**	create_buffer call could fail.  If it does, it'll
						;**	return 0, which is an invalid buffer id.  We check for
						;**	this case since delete_buffer does not.
						;**

						(if (= buffer_id (create_buffer "Error File" error_file 1))
							(delete_buffer buffer_id)
						)

						;**
						;**		This loop goes through each pass of the compiler,
						;**	checks to see if the return code was OK, and, if so,
						;**	continues along.  If an error occurs, the loop exits
						;**	immediately.
						;**
		
						(while (&& (! ret_code) (strlen passes))
							(
								(if (= loc (search_string "[~\\\\]\\c;" passes))
									(
										(= command_line (substr passes 1 (- loc 1)))
										(= passes (substr passes (+ loc 1)))
									)
								;else
									(
										(= command_line passes)
										(= passes "")
									)
								)
								(+= command_line (+ " >&" error_file))

								(while (= loc (search_string "\\\\;" command_line))
									(= command_line (+ (substr command_line 1 (- loc 1)) (substr command_line (+ loc 1))))
								)
								(sprintf command_line command_line file_name file_name file_name file_name file_name file_name file_name)
								(message command_line)

								(if (> (= ret_code (dos command_line 0)) 0)
									(next_error)
								;else
									(if (&& (== ret_code 0) check_warnings)
										(= ret_code (next_error 2))
									)
								)
							)
						)
						;**
						;**		Finally, we restore the old directory.  If the
						;**	compilation did not succeed, the next_error macro
						;**	was called to place the cursor under the error.
						;**
						;**		Otherwise, the temporary file is deleted and a
						;**	message is printed.
						;**
		
						(if (<= ret_code 0)
							(
								(del error_file)

								(if (== ret_code 0)
									(message "Compilation successful.")
								)
							)
						)
						(cd (substr old_path 3))
						(cd (substr old_path 1 2))
					)
				)
			)
		;else
			(error "Current buffer is not a .%s file." passes)
		)
		(returns ret_code)
	)
)

;**
;**		cm:
;**
;**		This macro compiles the macro in the current buffer (if there is one).
;**	If the compilation was successful, the macro is re-loaded (or loaded, as
;**	the case may be).  If the compilation failed, the errorfix macro
;**	is used to locate the problem in the .m file.
;**
;**		Note that the "cc" macro is used to do most of the work.  This macro
;**	merely calls "cc" with the parameters required for compilation of a
;**	macro file, then loads the file if the compilation was successful.
;**

(macro cm
	(
		(int		check_warnings
					curr_parm
		)
		(string	command_line)

		(= curr_parm 10)

		(while (&& (> curr_parm 0) (! (get_parm curr_parm check_warnings)))
			(-- curr_parm)
		)
		(if (> curr_parm 0)
			(
				(get_parm 0 command_line)

				(if (strlen (= command_line (trim (ltrim command_line))))
					(= command_line (+ " " command_line))
				)
			)
		)
		(= command_line (+ (+ "cm" command_line) " %s"))

		(if (! (cc command_line "m" check_warnings))
			(
				(int		old_msg_level)

				(string	name)

				(inq_names name)
				(= name (substr name 1 (- (strlen name) 2)))
				(= old_msg_level (inq_msg_level))
				(set_msg_level 3)
				(delete_macro name)
				(set_msg_level old_msg_level)
				(load_macro name)
				(message "Macro compiled and loaded.")
			)
		)
	)
)
