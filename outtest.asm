         load    RF,0        ;initialize to 0
         load    R7,1        ;increase step
NextChar:addi    RF,RF,R7    ;increase (is written to RF(=screen))
         jmp     NextChar    ;repeat
