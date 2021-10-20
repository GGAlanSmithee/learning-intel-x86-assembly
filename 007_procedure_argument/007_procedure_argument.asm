BITS 16                 ; specify target processor mode as 16 bits (https://nasm.us/doc/nasmdoc7.html)
ORG 0x7c00              ; specify base address, where the bootloader should be loaded into memory

argument_1: dw '1'
argument_2: dw 'Hello', '\0'
argument_3: dw 42

jmp example_1

; ----------------------------- GENERAL PURPOSE REGISTER EXAMPLE -------------------------------------

example_1:

mov bl, [argument_1]               ; store address of argument 1 in the bl register
mov cl, [argument_2]               ; store address of argument 2 in the cl register
mov dl, [argument_3]               ; store address of argument 3 in the cl register

call via_general_purpose_registers ; call the procedure

jmp example_2                      ; go to the next example

via_general_purpose_registers:     ; takes arguments as set in the general-purpose registers and prints them
    mov ah, 0x0e
    mov al, bl
    int 0x10

    mov ah, 0x0e                    ; only print "H", not "Hello", to keep this example simple
    mov al, cl
    int 0x10

    mov ah, 0x0e                    ; will print '*', not "42", to keep this example simple
    mov al, dl
    int 0x10

    ret


; ---------------------------------- ARGUMENT LIST EXAMPLE -------------------------------------------

example_2:

mov bl, '2'                        ; set the "bl" register to '2'

call via_an_argument_list

jmp example_3                      ; go to the next example

via_an_argument_list:
    mov ah, 0x0e
    mov al, bl
    int 0x10
    ret


; -------------------------------------- STACK EXAMPLE -----------------------------------------------

example_3:

mov bl, '3'                        ; set the "bl" register to '3'

call via_the_stack

jmp end

via_the_stack:
    mov ah, 0x0e
    mov al, bl
    int 0x10
    ret

end:

TIMES 510-($-$$) db 0   ; assure the script is a total of 512 bytes (including magic bytes)
dw 0xaa55               ; add magic bytes, instructing the BIOS that this is bootable
