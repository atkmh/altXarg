;**
;**		BRIEF -- Basic Reconfigurable Interactive Editing Facility
;**
;**		Written by Dave Nanian and Michael Strickman.
;**

;**
;**		startup.m:
;**
;**		This macro file is automatically loaded at the start of each editing
;**	session.  If you want to change the default configuration of BRIEF,
;**	you will have to modify this file.  The built-in key assignments are
;**	listed in the file sample.m.
;**
;**		Revision history:
;**		-----------------

#include	"keyboard.h"
#include	"misc.h"

;**
;**		The following macro is invoked once, after the first buffer has been
;**	loaded at the start of each editing session.
;**

(macro startup
	(
		;**
		;**		First, we call the "keyboard" macro, included above.  This
		;**	macro defines all of the BRIEF commands and keystrokes that are
		;**	implemented as macros, and tells BRIEF which files they can be
		;**	found in.
		;**

		(keyboard)

		;**
		;**		Here we load the language package.  If there's no BPACKAGES
		;**	environment variable, this load in unnecessary.
		;**

		(if (strlen (inq_environment "BPACKAGES"))
			(load_macro "language")
		)
		(register_macro 3 "_do_beep")						;** Beep for invalid keystrokes.
	)
)

;**		This macro, which is called when a file with a .c extension is read
;**	into a buffer, sets the tabs.
;**
;**		Note that the (tabs) macro primitive replicates the distance of the
;**	last tab stop until the end of the line.

(macro .c
	(tabs 4 7)
)

;**	The following macros are called when files with their names as
;**	extensions are read into buffers.

(macro .m
	(.c)								;** Tabs are the same as a c file.
)

(macro .h
	(.c)								;** Tabs are the same as a c file.
)

(macro .asm
	(tabs 9 17)
)

;**
;**		The next macro is called if the extension of the file does not match
;**	any of the previous macros (".h", ".c", ".m", ".asm").
;**

(macro default
	(.asm)							;** By default, use assembler-style tabs.
)

;**
;**		_do_beep:
;**
;**		This macro calls the beep primitive -- beep cannot be registered.
;**

(macro _do_beep
	(beep)
)

;**
;**		_exit:
;**
;**		Performs the same function as exit, but does not register as
;**	a context-sensitive help macro.  No name beginning with _ does.
;**

(macro _exit
	(exit)
)
