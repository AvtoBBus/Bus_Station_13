%include "/home/mrvoker_/Документы/asm/lab2/io64_float.inc"
%include "io64.inc"

section .data
    a: dd 0.0
    zero: dd 0.0
    five: dd 5.0
    ten: dd 10.0
    tenten: dd 100.0
    input_num: dd -420.19 ;num to rounding

global main
section .text
main:
    mov rbp, rsp        ; for correct debugging
    movss xmm0, [input_num]
    
    movss [a], xmm0 ; абсолютное значение числа
    fld dword[a] 
    fabs
    fstp dword[a]
    movss xmm0, [a]
    
    mulss xmm0, [ten]
    
    fld dword[ten]      ; остаток от числа
    movss [a], xmm0
    fld dword[a] 
    fprem
    fstp dword[a]
    movss xmm0, [a]
    
    comiss xmm0, [five]
    movss xmm0, [input_num]
    jnb af ; above five
    jna bf ; below five
    
    
af:
    comiss xmm0, [zero]
    jb bzaf ; below zero
    cvtss2si rax, xmm0
    dec rax
    jmp exit

bf:
    comiss xmm0, [zero]
    jb bzbf ; below zero
    cvtss2si rax, xmm0
    jmp exit
   
bzaf:
    cvtss2si rax, xmm0
    jmp exit

bzbf:
    cvtss2si rax, xmm0
    dec rax
    jmp exit
      
exit:
    PRINT_DEC 4, eax
    finit
    xor eax, eax
    ret