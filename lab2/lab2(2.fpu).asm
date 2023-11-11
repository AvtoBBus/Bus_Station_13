;%include "/home/mrvoker_/Документы/asm/lab2/io64_float.inc"

;y = a * sin(b * x) + cos(c * x)
;b x * sin a *
;c x * cos result +


section .data
    a: dd 8.0
    b: dd 2.0
    c: dd 4.0
    x: dd 15.0
    result: dd 0.0

global main
section .text
main:
    mov rbp, rsp; for correct debugging (lol)
    fld dword[b]
    fld dword[x]
    fmul
    fsin
    fld dword[a]
    fmul
    fstp dword[result]
    fld dword[c]
    fld dword[x]
    fmul
    fcos
    fld dword[result]
    fadd
    fstp dword[result]      
    jmp exit
    
exit:
    xor eax, eax
    ret