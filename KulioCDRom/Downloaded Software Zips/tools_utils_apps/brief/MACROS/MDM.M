;**	_init macro.
;**	Do not change this macro (always overwritten by Setup).
(macro _init
	(
		(extern	autosave				;**	External macro declarations
					toggle_re
		)
	)
)

;**	Overwritable by Setup
(macro default
	(
		(tabs 9 17 20 30 40 50 60 70 75 80 90)
	)
)

;**	Overwritable by Setup
(macro .c
	(
		(tabs 5 9 13 17 21 25 33 37 41 45 53 61)
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


