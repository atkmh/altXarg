;***
;***  BRIEF - Basic Reconfigurable Interactive Editing Facility
;***  ---------------------------------------------------------
;***
;***  This macro opens a window with a hex
;***  to Ascii translation table.
;***
;***  Roberto T. Edwards
;***  800 Victory Boulevard
;***  Staten Island, N.Y. 10301
;***

(macro ascii
   (
      (int  asc_tabl_buf   ;*** use this buffer for the table
            edit_buffer    ;*** this was in use before the table was put up
            page_num       ;*** active ascii table page
            key            ;*** last keystroke
            done           ;*** flag 1 => exit  0 => get another keystroke
      )
      (= done 0)        ; set to 1 to exit from the macro
      (= page_num 1)    ; init page counter
      (= asc_tabl_buf (create_buffer "Ascii Table" "$asc$.tmp" 1))
      (= edit_buffer   (inq_buffer))
      (set_buffer asc_tabl_buf)
      (create_window 0 22 53 1 "PgUp-Prev PgDn-Nxt Home-Fst End-Lst Esc-Exit")
      (attach_buffer asc_tabl_buf)
      (page_1)          ;*** start with page 1 of the Ascii table
		(refresh)
      (while (! done )
         (
            (while (== (= key (read_char)) -1))    ;*** wait for a keystroke
            (if (== key 0)                         ;*** was it a special key?
               (
               ;***
               ;*** Brief doesn't really have an if-then-else construct
               ;*** so the only way to do it is the following. It works,
               ;*** but I sure have to use a lot of parentheses and
               ;*** nesting! If there's another way, I'd love to hear
               ;*** about it.
               ;***
                  (= key (read_char))
                  (if (== key 81)                        ;*** PgDn
                     (if (< page_num 5)
                        (+= page_num 1)
                     )
                  ; else             
                     (if (== key 73)                     ;*** PgUp
                        (if (> page_num 1)
                           (-= page_num 1)
                        )
                     ; else
                        (if (== key 71)                  ;*** Home
                           (= page_num 1)
                        ; else
                           (if (== key 79)               ;*** End
                              (= page_num 5)
                           )
                        )
                     )
                  )
                  ;***
                  ;*** Now, check which page should be displayed.
                  ;***
                  (if (== page_num 1)
                     (page_1)
                  ; else
                     (if (== page_num 2)
                        (page_2)
                     ; else
                        (if (== page_num 3)
                           (page_3)
                        ; else
                           (if (== page_num 4)
                              (page_4)
                           ; else
                              (if (== page_num 5)
                                 (page_5)
                              )
                           )
                        )
                     )
                  )
               )
            ;***
            ;*** We get here if key != 0
            ;*** else check if the escape key was hit
            ;***
               (if (== key 283)     ;*** if so, exit 
                  (= done 1)
               )
            )
         )
      );*** end while

      (delete_window)               ;*** close the window we've been using
      (delete_buffer asc_tabl_buf)  ;*** delete the buffer
      (set_buffer edit_buffer)      ;*** make the last buffer current
   )
   ;***
   ;*** All done!
   ;***
)

(macro page_1
   (
      (move_abs 1 1)
      (insert " Dec  Hex  Chr     Dec  Hex  Chr     Dec  Hex  Chr\n")
      (insert " ===  ===  ===     ===  ===  ===     ===  ===  ===\n")
      (insert " 000  00H  NUL     018  12H  DC2    036  24H   $ \n")
      (insert " 001  01H  SOH    019  13H  DC3    037  25H   % \n")
      (insert " 002  02H  STX    020  14H  DC4    038  26H   & \n")
      (insert " 003  03H  ETX    021  15H  NAK    039  27H   ' \n")
      (insert " 004  04H  EOT    022  16H  SYN    040  28H   ( \n")
      (insert " 005  05H  ENQ    023  17H  ETB    041  29H   ) \n")
      (insert " 006  06H  ACK    024  18H  CAN    042  2AH   * \n")
      (insert " 007  07H  BEL    025  19H  EM     043  2BH   + \n")
      (insert " 008  08H  BS  \   026  1AH  SUB     044  2CH   \, \n")
      (insert " 009  09H  HT      027  1BH  ESC \   045  2DH   - \n")
      (insert " 010  0AH  LF      028  1CH  FS  \   046  2EH   . \n")
      (insert " 011  0BH  VT     029  1DH  GS     047  2FH   / \n")
      (insert " 012  0CH  FF     030  1EH  RS     048  30H   0 \n")
      (insert " 013  0DH  CR      031  1FH  US     049  31H   1 \n")
      (insert " 014  0EH  SO     032  20H  SP      050  32H   2 \n")
      (insert " 015  0FH  SI     033  21H  !       051  33H   3 \n")
      (insert " 016  10H  DLE    034  22H  \"       052  34H   4 \n")
      (insert " 017  11H  DC1    035  23H  #       053  35H   5  ")
      (refresh)
   )
)

(macro page_2
   (
      (move_abs 1 1)
      (insert " Dec  Hex  Chr     Dec  Hex  Chr     Dec  Hex  Chr\n")
      (insert " ===  ===  ===     ===  ===  ===     ===  ===  ===\n")
      (insert " 054  36H   6      072  48H   H      090  5AH   Z \n")
      (insert " 055  37H   7      073  49H   I      091  5BH   [ \n")
      (insert " 056  38H   8      074  4AH   J      092  5CH   \\ \n")
      (insert " 057  39H   9      075  4BH   K      093  5DH   ] \n")
      (insert " 058  3AH   :      076  4CH   L      094  5EH    ^ \n")
      (insert " 059  3BH   \;      077  4DH   M      095  5FH   _ \n")
      (insert " 060  3CH   <      078  4EH   N      096  60H   ` \n")
      (insert " 061  3DH   =      079  4FH   O      097  61H   a \n")
      (insert " 062  3EH   >      080  50H   P      098  62H   b \n")
      (insert " 063  3FH   ?      081  51H   Q      099  63H   c \n")
      (insert " 064  40H   @      082  52H   R      100  64H   d \n")
      (insert " 065  41H   A      083  53H   S      101  65H   e \n")
      (insert " 066  42H   B      084  54H   T      102  66H   f \n")
      (insert " 067  43H   C      085  55H   U      103  67H   g \n")
      (insert " 068  44H   D      086  56H   V      104  68H   h \n")
      (insert " 069  45H   E      087  57H   W      105  69H   i \n")
      (insert " 070  46H   F      088  58H   X      106  6AH   j \n")
      (insert " 071  47    G      089  59H   Y      107  6BH   k  ")
		(refresh)
   )
)

(macro page_3
   (
      (move_abs 1 1)
      (insert " Dec  Hex  Chr     Dec  Hex  Chr     Dec  Hex  Chr\n")
      (insert " ===  ===  ===     ===  ===  ===     ===  ===  ===\n")
      (insert " 108  6CH   l      126  7EH   ~      144  90H   ê \n")
      (insert " 109  6DH   m      127  7FH         145  91H   ë \n")
      (insert " 110  6EH   n      128  80H   Ä      146  92H   í \n")
      (insert " 111  6FH   o      129  81H   Å      147  93H   ì \n")
      (insert " 112  70H   p      120  82H   Ç      148  94H   î \n")
      (insert " 113  71H   q      131  83H   É      149  95H   ï \n")
      (insert " 114  72H   r      132  84H   Ñ      150  96H   ñ \n")
      (insert " 115  73H   s      133  85H   Ö      151  97H   ó \n")
      (insert " 116  74H   t      134  86H   Ü      152  98H   ò \n")
      (insert " 117  75H   u      135  87H   á      153  99H   ô \n")
      (insert " 118  76H   v      136  88H   à      154  9AH   ö \n")
      (insert " 119  77H   w      137  89H   â      155  9BH   õ \n")
      (insert " 120  78H   x      138  8AH   ä      156  9CH   ú \n")
      (insert " 121  79H   y      139  8BH   ã      157  9DH   ù \n")
      (insert " 122  7AH   z      140  8CH   å      158  9EH   û \n")
      (insert " 123  7BH   {      141  8DH   ç      159  9FH   ü \n")
      (insert " 124  7CH   |      142  8EH   é      160  A0H   † \n")
      (insert " 125  7DH   }      143  8FH   è      161  A1H   °  ")
		(refresh)
   )
)

(macro page_4
   (
      (move_abs 1 1)
      (insert " Dec  Hex  Chr     Dec  Hex  Chr     Dec  Hex  Chr\n")
      (insert " ===  ===  ===     ===  ===  ===     ===  ===  ===\n")
      (insert " 162  A2H   ¢      180  B4H   ¥      198  C6H   ∆ \n")
      (insert " 163  A3H   £      181  B5H   µ      199  C7H   « \n")
      (insert " 164  A4H   §      182  B6H   ∂      200  C8H   » \n")
      (insert " 165  A5H   •      183  B7H   ∑      201  C9H   … \n")
      (insert " 166  A6H   ¶      184  B8H   ∏      202  CAH     \n")
      (insert " 167  A7H   ß      185  B9H   π      203  CBH   À \n")
      (insert " 168  A8H   ®      186  BAH   ∫      204  CCH   Ã \n")
      (insert " 169  A9H   ©      187  BBH   ª      205  CDH   Õ \n")
      (insert " 170  AAH   ™      188  BCH   º      206  CEH   Œ \n")
      (insert " 171  ABH   ´      189  BDH   Ω      207  CFH   œ \n")
      (insert " 172  ACH   ¨      190  BEH   æ      208  D0H   – \n")
      (insert " 173  ADH   ≠      191  BFH   ø      209  D1H   — \n")
      (insert " 174  AEH   Æ      192  C0H   ¿      210  D2H   “ \n")
      (insert " 175  AFH   Ø      193  C1H   ¡      211  D3H   ” \n")
      (insert " 176  B0H   ∞      194  C2H   ¬      212  D4H   ‘ \n")
      (insert " 177  B1H   ±      195  C3H   √      213  D5H   ’ \n")
      (insert " 178  B2H   ≤      196  C4H   ƒ      214  D6H   ÷ \n")
      (insert " 179  B3H   ≥      197  C5H   ≈      215  D7H   ◊  ")
		(refresh)
   )
)

(macro page_5
   (
      (move_abs 1 1)
      (insert " Dec  Hex  Chr     Dec  Hex  Chr     Dec  Hex  Chr\n")
      (insert " ===  ===  ===     ===  ===  ===     ===  ===  ===\n")
      (insert " 216  D8H   ÿ      234  EAH   Í      252  FCH   ¸ \n")
      (insert " 217  D9H   Ÿ      235  EBH   Î      253  FDH   ˝ \n")
      (insert " 218  DAH   ⁄      236  ECH   Ï      254  FEH   ˛ \n")
      (insert " 219  DBH   €      237  EDH   Ì      255  FFH     \n")
      (insert " 220  DCH   ‹      238  EEH   Ó                   \n")
      (insert " 221  DDH   ﬁ      239  EFH   Ô                   \n")
      (insert " 222  DEH   ﬁ      240  F0H                      \n")
      (insert " 223  DFH   ﬂ      241  F1H   Ò                   \n")
      (insert " 224  E0H   ‡      242  F2H   Ú                   \n")
      (insert " 225  E1H   ·      243  F3H   Û                   \n")
      (insert " 226  E2H   ‚      244  F4H   Ù                   \n")
      (insert " 227  E3H   „      245  F5H   ı                   \n")
      (insert " 228  E4H   ‰      246  F6H   ˆ                   \n")
      (insert " 229  E5H   Â      247  F7H   ˜                   \n")
      (insert " 230  E6H   Ê      248  F8H   ¯                   \n")
      (insert " 231  E7H   Á      249  F9H   ˘                   \n")
      (insert " 232  E8H   Ë      250  FAH   ˙                   \n")
      (insert " 233  E9H   È      251  FBH   ˚                    ")
		(refresh)
   )
)
