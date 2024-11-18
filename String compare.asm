section .data
    s1 db "Hello world!", 0          
    lens1 equ $ - s1                

    s2 db "Hello, world", 0          
    lens2 equ $ - s2                 

    msg_eq db "Strings are equal", 0 
    len_eq equ $ - msg_eq            

    msg_neq db "Strings are not equal", 0 
    len_neq equ $ - msg_neq               

section .text
    global _start

_start:
    
    mov esi, s1                   
    mov edi, s2                     
    mov ecx, lens2                  

    
    repe cmpsb                      

   
    jne strings_not_equal          
    section

    ; If strings are equal
    mov eax, 4                      
    mov ebx, 1                      
    mov ecx, msg_eq                
    mov edx, len_eq                 
    int 0x80                        
    jmp exit                        

    strings_not_equal:
    
    mov eax, 4                      
    mov ebx, 1                      
    mov ecx, msg_neq                
    mov edx, len_neq                
    int 0x80                        

exit:
    ; Exit program
    mov eax, 1                      ; Syscall: exit
    xor ebx, ebx                    ; Exit code: 0
    int 0x80                        ; Make the syscall
