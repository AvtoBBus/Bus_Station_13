; y = cos(a*x)-b
; a x * cos b -

section .data
    
    a: dd 2.0
    b: dd 1.0
    x: dd 3.0
    result: dd 0.0

section .text 
global main

main:
    fld dword[a]
    fld dword[x]
    fmul
    fcos
    fld dword[b]
    fsub
    fstp dword[result]
    xor eax,eax
    ret

