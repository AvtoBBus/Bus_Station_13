%include "/home/mrvoker_/Документы/asm/lab2/io64_float.inc"
section .data
    a: dd 0.0
    five: dd 5.0
    ten: dd 10.0
    tenten: dd 100.0
    input_num: dd 420.69 ;num to rounding

global main
section .text
main:
    mov rbp, rsp; for correct debugging
    fldz
    fld1
    fld dword[five]
    fld dword[tenten]
    fld dword[ten]
    fld dword[input_num]
    fabs 
    fmul st0, st1
    fprem
    fcomi st3
    ja exit1
    jb exit2

exit1:
    fstp dword[a]
    fld dword[input_num]
    frndint
    fcomi st5
    ja az
    jb exit
    
exit2:
    fstp dword[a]
    fld dword[input_num]
    frndint
    fcomi st5
    ja exit
    jb bz
    
az:
    fsub st0, st4
    jmp exit
    
bz:
    fsub st0, st4
    jmp exit
    
exit:

    fstp dword[a]
    movss xmm0, [a]
    cvtss2si rax, xmm0
    PRINT_DEC 4, rax
    
    finit
    xor eax, eax
    ret