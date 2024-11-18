section .data
    s1 db 'Pratik', 0           ; String to be converted from uppercase to lowercase
    len equ $ - s1              ; Length of s1

section .bss
    s2 resb 20                  ; Reserve 20 bytes for the lowercase string (s2)

section .text
    global _start

_start:
    ; Initialize registers for the conversion process
    mov ecx, len                ; Set the length of string1 (s1) into ECX
    mov esi, s1                 ; Load address of s1 (source string) into ESI
    mov edi, s2                 ; Load address of s2 (destination for lowercase string) into EDI

UpptoLow:
    lodsb                       ; Load byte from s1 into AL, increment ESI
    or al, 20h                  ; Convert uppercase letter to lowercase by setting bit 5 of AL
    stosb                       ; Store converted byte in s2, increment EDI
    loop UpptoLow               ; Repeat until ECX (length) becomes 0

    ; Print the converted lowercase string
    mov eax, 4                  ; Syscall number for sys_write
    mov ebx, 1                  ; File descriptor 1 (stdout)
    mov edx, 20                 ; Length of message to write (buffer size of 20)
    mov ecx, s2                 ; Pointer to the lowercase string
    int 0x80                    ; Make the syscall

    ; Exit the program
    mov eax, 1                  ; Syscall number for sys_exit
    xor ebx, ebx                ; Exit code 0
    int 0x80                    ; Make the syscall
