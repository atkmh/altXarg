;* c comments checker.
;*  K. Schopmeyer 6 May 1986
;* This check macro works by highlighting the area beween the next start
;* comment and the end of the start comment.  this version does not 
;* account for nesting.
(macro cmts 
	(								 	
	(keyboard_push)
	(message " Cmt srch -  next cmt  Back Home PgUp, PgDn esc exit")
	(assign_to_key "%#80" "next_cmt")	;   for next
	(assign_to_key "%#71" "cmt_top")	 	; home for top
	(assign_to_key "%#72" "cmt_back") 	;  for back one
	(assign_to_key "%#73" "cmt_pageu") 	; PgUp for page Up
	(assign_to_key "%#81" "cmt_paged") 	; PgDn for page down
	(assign_to_key "#27" "exit")
	(process)
	(keyboard_pop)
	(raise_anchor)
	(message "Comments search Finished")
	)
)

(macro next_cmt
	(
		(int re1 rs2) 
		(message " Cmt srch - N forward, T top,P page, b back, esc exit")
  		(raise_anchor)
		(if ( > ( search_fwd "/*" 0) 0)
			(
		 		(drop_anchor 1)
				(move_rel 0 2)
 				(if ( <= (search_fwd "{/\\*}|{\\*/}" 1 ) 0)
					(message "Posssibly No Comment end Or Nested Comments")
				)
				( if (!=  (read 1) "*" ) 
					(message "nesting or error " )
				)
   			(move_rel 0 1)
			)
		;else
			(message "No cmt start found")
		)
	)
)
(macro cmt_pageu
	 (
		 (raise_anchor)
		 (move_rel -20 0)
 	 )
)
(macro cmt_paged
	 (
		 (raise_anchor)
		 (move_rel 20 0)
 	 )
)
(macro cmt_top
	 (
		 (raise_anchor)
		 (move_abs 1 1)
 	 )
)

(macro cmt_back
	 (
		(if (inq_marked)
			(
	   		(raise_anchor)
	 			(prev_char)
		 		(search_back "/*" 0)
			)
		)
	 	(prev_char)
		 (search_back "/*" 0)
	 	(prev_char)
		 (next_cmt)
	  )
)
