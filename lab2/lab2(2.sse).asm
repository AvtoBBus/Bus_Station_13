;%include "/home/mrvoker_/Документы/asm/lab2/io64_float.inc"

;y = a * sin(b * x) + cos(c * x)
;b x * sin a *
;c x * cos result +

section .data
    a: dd 8.0
    b: dd 2.0
    c: dd 4.0
    x: dd 15.0
    help: dd 0.0
    result: dd 0.0

global main
section .text
main:
    mov rbp, rsp; for correct debugging (ok)
    movss xmm0, [b]
    mulss xmm0, [x]
    
    movss [result], xmm0 ; sin(b * x)
    fld dword[result] 
    fsin
    fstp dword[result]
    movss xmm0, [result]
    
    mulss xmm0, [a]
    movss [result], xmm0
    
    movss xmm0, [c]
    mulss xmm0, [x]
    movss xmm1 , xmm0
    
    movss [help], xmm1 ; cos(c * x)
    fld dword[help] 
    fcos
    fstp dword[help]
    movss xmm1, [help]
    
    movss xmm0,[result]
    addss xmm0, xmm1   
    movss [result], xmm0
    fld dword[result]
    jmp exit
    
exit:
    xor eax, eax
    ret