%include "/home/mrvoker_/Документы/asm/Bus_Station_13/lab2/io64_float.inc"
%include "io64.inc"


section .data
    a: dd 0.0
    z: dd 0.0
    ten: dd 10.0
    input_num: dd 0.0 ;num to rounding

global main
section .text

set_round_down:
    sub rsp,8 ; allocate space on stack
    fstcw [rsp] ; save the control word
    mov al, [rsp+1] ; get the higher 8 bits
    and al, 0xF3 ; reset the RC field to 0
    or al, 0x04 ; set the RC field to 0x10
    mov [rsp+1], al
    fldcw [rsp] ; load the control word
    add rsp, 8 ; 'free' the allocated stack space
    ret

main:
    mov rbp, rsp; for correct debugging
    
    fld1
    fld dword[ten]
    GET_DEC 8, rax
    cvtsi2ss xmm0, rax
    movss dword[a], xmm0
    fld dword[a]
    
    GET_DEC 8, rax
    cvtsi2ss xmm0, rax
    movss dword[input_num], xmm0
    
    cycle:
        fdiv st1
        fcomi st2
        jae cycle
    
    fstp dword[a]
    
    movss xmm0, dword[input_num]
    comiss xmm0, dword[z]
    jb sub_fractional
    jae add_fractional
    
add_fractional:
    addss xmm0, dword[a]
    movss dword[input_num], xmm0
    jmp start_rounding
      
sub_fractional:
    subss xmm0, dword[a]
    movss dword[input_num], xmm0
    jmp start_rounding
    

start_rounding:
    push rbp
    mov rbp, rsp
    call set_round_down
    fld dword[input_num]
    frndint
    fstp dword[input_num]
    movss xmm0, dword[input_num]
    cvtss2si rax, xmm0
    PRINT_DEC 8, rax
    xor eax, eax
    leave
    ret