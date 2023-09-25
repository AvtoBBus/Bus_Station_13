; y = cos(a*x)-b

section .data
    
    a: dd 2.0
    b: dd 1.0
    x: dd 3.0
    result: dd 0.0


section .text 
global main

main:
    movss xmm0, [a]
    mulss xmm0, [x]
    movss [result], xmm0
    fld dword[result]
    fcos
    fstp dword[result]
    movss xmm0, [result]
    subss xmm0, [b]
    movss [result], xmm0
   
    xor eax,eax
    ret