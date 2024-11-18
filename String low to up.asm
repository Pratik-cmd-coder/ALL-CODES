section .data
    string db "Pratik", 10    ; String to be converted to uppercase, 10h is newline character
    len equ $ - string             ; Length of the string

section .text
    global _start

_start:
    ; Convert string to uppercase
    lea ecx, [string]              ; Load address of the string into ECX
    call toUpper                   ; Convert the string to uppercase

    ; Print the converted string
    mov eax, 4                     ; Syscall number for sys_write
    mov ebx, 1                     ; File descriptor (stdout)
    mov ecx, string                ; Address of the string to print
    mov edx, len                   ; Length of the string
    int 0x80                       ; Invoke syscall

    ; Exit the program
    mov eax, 1                     ; Syscall number for sys_exit
    xor ebx, ebx                   ; Exit code 0
    int 0x80                       ; Invoke syscall to exit

; Function: toUpper
; Description: Converts all lowercase characters in the string to uppercase.
; Input: ECX - Pointer to the string
; Output: String modified in-place
toUpper:
    .next_char:
        mov al, [ecx]              ; Load the current character into AL
        test al, al                ; Check if AL is 0 (null terminator)
        je .done                   ; If zero, end of string reached

        cmp al, 'a'                ; Check if character >= 'a'
        jb .skip                   ; If less than 'a', skip conversion
        cmp al, 'z'                ; Check if character <= 'z'
        ja .skip                   ; If greater than 'z', skip conversion

        sub al, 0x20               ; Convert lowercase to uppercase
        mov [ecx], al              ; Store the uppercase character back

    .skip:
        inc ecx                    ; Move to the next character
        jmp .next_char             ; Repeat for the next character

    .done:
        ret                        ; Return from the function
