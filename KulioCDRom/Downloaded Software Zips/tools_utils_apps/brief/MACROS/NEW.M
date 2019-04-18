;**
;**		BRIEF -- Basic Reconfigurable Interactive Editing Facility
;**
;**		Written by Dave Nanian and Michael Strickman.
;**

;**
;**		new.m:
;**
;**		This macro file contains some new key assignments that we think are
;**	useful.  We hope to get feedback on them from you!  If you like them,
;**	these commands, please tell us through the BBS (1-617-659-1479, 24 Hrs
;**	a day) or through a friendly phone call (use the 800 number).  Thanks
;**	for your help.
;**
;**		The new features are as follows:
;**
;**		do_mac_typing/ If characters are inserted from the keyboard when
;**		self_insert:	a block is marked, block is deleted first.  This
;**							emulates the behavior of Microsoft Windows and the
;**							Macintosh.
;**
;**		Revision history:
;**		-----------------

;**
;**		_do_mac_typing/self_insert:
;**
;**		This replacement macro emulates Microsoft Windows and Macintosh
;**	behavior when characters are typed when a block is marked.  The block
;**	is deleted before the characters are inserted.
;**

(replacement self_insert
	(
		(if (&& (! (inq_system)) (inq_marked))
			(delete_block)
		)
		(self_insert)
	)
)
