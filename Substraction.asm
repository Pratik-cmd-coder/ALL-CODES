section .data
    num1 db 0x50
    num2 db 0x20
    result db 0

section .bss

section .text
    global _start

_start:
    mov al, [num1]
    mov bl, [num2]
    sub al, bl
    mov [result], al

    mov eax, 1
    xor ebx, ebx
    int 0x80
