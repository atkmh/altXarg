;**	_init macro.
;**	Do not change this macro (always overwritten by Setup).
(macro _init
	(
		(extern	autosave				;**	External macro declarations
					toggle_re
		)
		(color 0 7 15 7 15 0x80)	;**	Set the screen colors
	)
)

;**	Initials macro.
;**	Use this macro for additional customization.
(macro AAA
	(
		;**	Put your changes here.
		(return)
	)
)


;**	File Extension Macros, etc.
;**	Macros marked "Overwritable" may be overwritten by SETUP.


;**	Overwritable by Setup
(macro default
	(
		(tabs 9 17)
	)
)
