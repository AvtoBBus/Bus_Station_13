
%include "io64.inc"

;insert sort mass
;for step in range(1, len(array)):
;        key = array[step]
;        j = step - 1
;        while j >= 0 and key < array[j]:
;            array[j + 1] = array[j]
;            j -= 1
;        array[j + 1] = key

section .data
    array: times 1024 db 0
    size: dd 0
    key: dd 0
    
global main
section .text
main:
    mov rbp, rsp; for correct debugging
    GET_DEC 4, eax ;input mass size
    mov [size], eax
    
    mov esi, 0
    
    input_cycle:
        GET_DEC 4, eax
        mov [array + 4 * esi], eax
        
        inc esi
        cmp esi, [size]
        jne input_cycle
        
    mov ecx, 1 ; step
    mov esi, 0 ; j
    
    PRINT_STRING "Before:  "
    jmp print_mass
    
    start_sort_cycle:
        mov eax, [array + 4 * ecx]
        mov [key], eax ; key = array[step]
        mov esi, ecx
        dec esi ; j = step - 1
        
        mov eax, [key]       
        cmp eax, [array + 4 * esi]
        jbe move_elem; key < array[j]
        jg sort
    
    move_elem:
        mov eax, [array + 4 * esi]
        mov [array + 4 * (esi + 1)], eax ; array[j+1] = array[j]
        dec esi ; j -= 1
        mov eax, [key]      
        cmp eax, [array + 4 * esi]
        jbe move_elem; key < array[j]
        jmp sort
    
    sort:
        mov eax, [key]
        mov [array + 4 * (esi + 1)], eax ; array[j+1] = key
        inc ecx
        cmp ecx, [size]
        jne start_sort_cycle
        
    
    mov esi, 0
    PRINT_STRING "After:     "
    print_mass:
        mov eax, [array + 4 * esi]
        PRINT_DEC 4, eax
        PRINT_CHAR ' '
        
        inc esi
        cmp esi, [size]
        jne print_mass
        
        NEWLINE
        cmp ecx, [size]
        jne start_sort_cycle
    
    
    xor eax, eax
    ret