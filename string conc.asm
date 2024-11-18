section .data
    firstName db "John", 0           ; First name (value: "John")
    middleName db "F.", 0            ; Middle name (value: "F.")
    lastName db "Doe", 0             ; Last name (value: "Doe")
    fullName db 50 dup(0)            ; Reserve space for the concatenated full name

section .bss
    ; Reserved space for firstName, middleName, and lastName
    first resb 10
    middle resb 10
    last resb 10

section .text
    global _start

_start:
    ; Concatenate first name
    mov esi, firstName               ; Load address of firstName into esi
    mov edi, fullName                ; Load address of fullName into edi
concatenate_first:
    mov al, [esi]                    ; Load a byte from firstName
    cmp al, 0                        ; Check if end of first name
    je middle_name
    mov [edi], al                    ; Store byte into fullName
    inc esi                          ; Increment source pointer
    inc edi                          ; Increment destination pointer
    jmp concatenate_first

middle_name:
    ; Add space between first and middle names
    mov al, ' '                      ; Load a space character into AL
    mov [edi], al                    ; Store space into fullName
    inc edi                          ; Increment destination pointer

    ; Concatenate middle name
    mov esi, middleName              ; Load address of middleName into esi
concatenate_middle:
    mov al, [esi]                    ; Load a byte from middleName
    cmp al, 0                        ; Check if end of middle name
    je last_name
    mov [edi], al                    ; Store byte into fullName
    inc esi                          ; Increment source pointer
    inc edi                          ; Increment destination pointer
    jmp concatenate_middle

last_name:
    ; Add space between middle and last names
    mov al, ' '                      ; Load a space character into AL
    mov [edi], al                    ; Store space into fullName
    inc edi                          ; Increment destination pointer

    ; Concatenate last name
    mov esi, lastName                ; Load address of lastName into esi
concatenate_last:
    mov al, [esi]                    ; Load a byte from lastName
    cmp al, 0                        ; Check if end of last name
    je done
    mov [edi], al                    ; Store byte into fullName
    inc esi                          ; Increment source pointer
    inc edi                          ; Increment destination pointer
    jmp concatenate_last

done:
    ; Print the concatenated full name
    mov eax, 4                       ; syscall number for sys_write
    mov ebx, 1                       ; file descriptor (stdout)
    mov edx, 50                      ; Maximum length of full name
    mov ecx, fullName                ; Pointer to fullName buffer
    int 0x80                         ; Trigger syscall to print

    ; Exit program
    mov eax, 1                       ; syscall number for sys_exit
    xor ebx, ebx                     ; Exit code 0
    int 0x80                         ; Trigger syscall to exit
