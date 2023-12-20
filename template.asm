         load    R2,0
         jmp     Print       ;Print number in R2

         org     60h
Print:
; Put the number in R2 in the output window
; Changed registers: R0, RA, RB, RC, RE, RF
         load    R0,39h      ;ASCII-code of '9'
         load    RA,30h      ;ASCII-code of '0'
         load    RB,7        ;'A'-'0'+10  (correction from numbers to letters)
         ; determine high nibble
         load    RC,0F0h     ;filter high nibble
         and     RE,R2,RC    ;high nibble of R2 in RE
         ror     RE,4        ;shift to low nibble
         addi    RE,RE,RA    ;make it ASCII
         jmpLE   RE<=R0,isNum1    ;is an ASCII number
         addi    RE,RE,RB         ;correct to ASCII letter
isNum1:  store   RE,[HiNibble]    ;put high nibble on its place
         ; determine low nibble
         load    RC,0Fh      ;filter low nibble
         and     RE,R2,RC    ;low nibble of R2 in RE
         addi    RE,RE,RA    ;make it ASCII
         jmpLE   RE<=R0,isNum2    ;is an ASCII number
         addi    RE,RE,RB         ;correct to ASCII letter
isNum2:  store   RE,[LoNibble]    ;put low nibble on its place
         ; print string
         load    R0,0        ;string terminator
         load    RA,Text
         load    RB,1        ;index increaser
NextChar:load    RF,[RA]     ;put character in output window
         jmpEQ   RF=R0,Exit  ;when string-terminator, then exit
         addi    RA,RA,RB    ;increase index
         jmp     NextChar
Exit:    halt

Text:    db      10,"Answer : $"
HiNibble:db      '?'
LoNibble:db      '?'
         db      0           ;string-terminator

         org     0A0h        ;the row starts here
Rij:     db      0Eh, 10h, 1Ah, 6, -5, 24h, 6
         db      0

