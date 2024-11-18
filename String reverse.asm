section .data
    msg db "Pratik", 0               ; Original string to be reversed
    len equ $ - msg                  ; Length of the string

section .bss
    rstring resb 14                  ; Reserve space for reversed string

section .text
    global _start

_start:
    ; Print the original string
    mov eax, 4                       ; Syscall number for sys_write
    mov ebx, 1                       ; File descriptor (stdout)
    mov ecx, msg                     ; Address of the string to print
    mov edx, len                     ; Length of the string
    int 0x80                          ; Invoke syscall to print the string

    ; Prepare for reversing the string
    mov esi, msg                     ; Load address of the original string into ESI
    lea edi, [rstring + len - 1]     ; Load address of rstring (reversed) into EDI (pointing to the last byte)

reverse_loop:
    lodsb                            ; Load byte at [esi] into AL, increment ESI
    cmp al, 0                        ; Check if we've reached the end of the string
    je reverse_done                  ; If zero (null terminator), jump to done
    mov [edi], al                    ; Store byte from AL into [edi] (reverse the order)
    dec edi                           ; Move EDI backwards (to next available space in rstring)
    jmp reverse_loop                 ; Repeat the loop

reverse_done:
    mov byte [edi], 0                ; Null-terminate the reversed string

    ; Print the reversed string
    mov eax, 4                       ; Syscall number for sys_write
    mov ebx, 1                       ; File descriptor (stdout)
    mov ecx, rstring                 ; Address of the reversed string
    mov edx, len                     ; Length of the string
    int 0x80                          ; Invoke syscall to print the reversed string

    ; Exit the program
    mov eax, 1                       ; Syscall number for sys_exit
    xor ebx, ebx                     ; Exit code 0
    int 0x80                          ; Invoke syscall to exit
