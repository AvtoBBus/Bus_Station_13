%include "io64.inc"
section .rodata
    formatInt: db `%d`, 0
    formatOutInt: db `%d `, 0
    
global main
section .text
extern printf
extern scanf
extern malloc
extern free
main:
    mov rbp, rsp; for correct debugging  
    push rbp  
    sub rsp, 32     
    
    
    lea rdi, formatInt
    lea rsi, [r12]
    call scanf
    mov r12, rsi ; r12 = size
    
    mov rax, 4
    mul r12
    mov rdi, rax
    call malloc
    mov rbx, rax
    mov r13, 0
        
    input_cycle:
    
        lea rdi, [formatInt]
        lea rsi, [rbx + 4 * r13]
        call scanf
        inc r13
        cmp r13, r12
        jne input_cycle
        
    mov r14, 1 ; ecx - step
    mov r15, 0 ; esi - j
     
    start_sort_cycle:
        mov r13d, [rbx + 4 * r14] ; key = array[step]
        mov r15, r14
        dec r15 ; j = step - 1
              
        cmp r13d, [rbx + 4 * r15]
        jle move_elem; key < array[j]
        jg sort
     
    move_elem:
        mov eax, [rbx + 4 * r15]
        mov [rbx + 4 * (r15 + 1)], eax ; array[j+1] = array[j]
        cmp r15, 0
        je insert_elem
        dec r15 ; j -= 1      
        cmp r13d, [rbx + 4 * r15]
        jle move_elem; key < array[j]
        jmp sort
     
    insert_elem:
        mov [rbx], r13d ; array[0] = key
        inc r15
        cmp r15, r12
        jne start_sort_cycle
        jmp finish
     
    sort:
        mov [rbx + 4 * (r15 + 1)], r13d ; array[j+1] = key
        inc r14
        cmp r14, r12
        jne start_sort_cycle
        mov r13, 0
        jmp finish
        
    finish:
        mov rdi, formatOutInt
        mov dword rsi, [rbx + 4 * r13]
        call printf
               
        inc r13
        cmp r13, r12
        jne finish
        
        mov rdi, rbx
        call free
        
        pop rbp
        add rsp, 32
        
        xor eax, eax
        ret
