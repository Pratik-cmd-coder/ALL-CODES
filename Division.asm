section .data
    num1    db  50         ; Dividend
    num2    db  7          ; Divisor
    quotient db 0          ; To store the quotient
    remainder db 0         ; To store the remainder

section .text
    global _start           ; Entry point

_start:
    mov al, [num1]          ; Load dividend into AL
    mov bl, [num2]          ; Load divisor into BL

    xor ah, ah              ; Clear AH (required for division)
    div bl                  ; Divide AX by BL (AL / BL)
                            ; Result: Quotient in AL, Remainder in AH

    mov [quotient], al      ; Store the quotient
    mov [remainder], ah     ; Store the remainder

    mov eax, 1              ; System call number for exit
    xor ebx, ebx            ; Exit code 0 (success)
    int 0x80                ; Invoke system call
