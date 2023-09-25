%include "/home/mrvoker_/Документы/asm/lab2/io64_float.inc"

; ===calc_arccos===
; arccos(b) = arctg(sqrt( (1-b) / (1+b) ))
; 1 b - 1 b + / sqrt arctg
; ===calc_arccos===
;
; ===calc_example===
; cos(ln(x + a)) = b
; x = (e ^ arccos(b)) - a
; e result ^ a -
; ===calc_example===


section .data
    a: dd 2.0
    b: dd 0.5
    x: dd 0.0
    one: dd 1.0
    result: dd 0.0

global main
section .text
main:
    mov rbp, rsp; for correct debugging (ok)
    movss xmm0, [one]
    subss xmm0, [b]
    movss xmm1, [one]
    addss xmm1, [b]
    divss xmm0, xmm1
    sqrtss xmm0, xmm0
    movss [result], xmm0
    fld dword[result]
    fld1
    fpatan
    jmp calc_example
    
calc_example:
    fldl2e
    fyl2x         ; Стек FPU теперь содержит: ST(0)=y*log2(x)
    fld st0       ; Создаем еще одну копию z
    frndint       ; Округляем ST(0)=round(z)         | ST(1)=z
    fxch st1      ; ST(0)=z                          | ST(1)=round(z)
    fsub st0,st1  ; ST(0)=z-round(z)                 | ST(1)=round(z)
    f2xm1         ; ST(0)=2**(z-round(z))-1          | ST(1)=round(z)
    fld1          ; ST(0)=1                          | ST(1)=2**(z-round(z))-1  | ST(2)=round(z)
    faddp st1,st0 ; ST(0)=2**(z-round(z))            | ST(1)=round(z)
    fscale
    
    fstp dword[result]
    movss xmm0, [result]
    subss xmm0, [a]
    jmp exit  
    
exit:
    movss [result], xmm0
    fld dword[result]
    xor eax, eax
    ret