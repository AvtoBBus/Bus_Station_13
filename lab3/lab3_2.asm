%include "io64.inc"

section .data
    num1: dd 10.5
    num2: dd 26.6
    

section .text
global CMAIN
CEXTERN access7
extern exit
CMAIN:
    push    rbp
    mov     rbp, rsp
    
    call access7
    
    pop     rbp
    ret