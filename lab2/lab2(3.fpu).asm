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
    result: dd 0.0

global main
section .text
main:
    mov rbp, rsp; for correct debugging (ok)
    fld1
    fld dword[b]
    fsub
    fld1
    fld dword[b]
    fadd
    fsqrt
    fxch st1, st0
    fstp dword[result]
    fld1
    fxch st1, st0
    fpatan
    fstp dword[result]
    jmp calc_example
    
calc_example:
    fld dword[result]
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
    fld dword[a]
    fsub
    fstp dword[result]   
    
exit:
    xor eax, eax
    ret