%include "/home/mrvoker_/Документы/asm/lab2/io64_float.inc"

; ===calc_cosh===
; cosh(b) = (e ^ b - e ^ (-b)) / 2
; e b ^ e -b ^ - 2 /
; ===calc_arccos===
;
; ===calc_example===
; y <= cosh(x-a)
; x a - cosh
; ===calc_example===


section .data
    a: dd 1.0
    b: dd 1.0
    x: dd 7.0
    y: dd 5.0
    help: dd 0.0
    help2: dd 0.0
    help3: dd 2.0

global main
section .text
main:
    mov rbp, rsp; for correct debugging (ok)
    movss xmm0, [x]
    subss xmm0, [a]
    jmp calc_cosh
    
calc_cosh:
    movss [help], xmm0
    fld dword[help]
    fldl2e
    
    ;exponentation
    fyl2x         
    fld st0       
    frndint       
    fxch st1      
    fsub st0,st1  
    f2xm1         
    fld1 
    faddp st1,st0
    fscale
    ;exponentation
    
    fld dword[help]
    fld1
    fchs
    fldl2e
    
    ;exponentation
    fyl2x         
    fld st0       
    frndint       
    fxch st1      
    fsub st0,st1  
    f2xm1         
    fld1 
    faddp st1,st0
    fscale
    ;exponentation
  
    fxch st2
    fstp dword[help2]
    fstp dword[help2]
    fxch st1
    
    fstp dword[help]
    movss xmm0, [help]    
    fstp dword[help]
    subss xmm0, [help]
    divss xmm0, [help3]   
    
    movss [help], xmm0
    fld dword[help]
    
    jmp check

check:
    comiss xmm0, [y]
    jae exit1
    jmp exit2
  
exit1:
    PRINT_STRING "YES"
    jmp exit
    
exit2:
    PRINT_STRING "NO"
    jmp exit
    
exit:
    xor eax, eax
    ret