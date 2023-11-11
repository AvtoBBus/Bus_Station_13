%include "io64.inc" 
 
section .data 
num_to_rnd: dd 4.3
round: db 0 
 
section .text 
global main 
  
main: 
    push rbp
    mov rbp, rsp
    movss xmm0, [num_to_rnd] 
    stmxcsr [round] 
    and dword[round], 0xFFFFDFFF 
    or dword[round], 0x00002000 
    ldmxcsr [round] 
    cvtss2si eax, xmm0 
    PRINT_DEC 8, rax 
    xor eax, eax
    leave
    ret
    
