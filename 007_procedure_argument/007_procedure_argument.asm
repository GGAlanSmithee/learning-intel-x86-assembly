BITS 16                 ; specify target processor mode as 16 bits (https://nasm.us/doc/nasmdoc7.html)
ORG 0x7c00              ; specify base address, where the bootloader should be loaded into memory

argument_1: db '1'
argument_2: dw 'A'
argument_3: dd 1                ; smiley face

mov bl, [argument_1]            ; store address of argument 1 in the bl register
mov cl, [argument_2]            ; store address of argument 2 in the cl register
mov dl, [argument_3]            ; store address of argument 3 in the cl register

call procedure                  ; call the procedure

jmp end                         ; quit example

procedure:                      ; takes arguments as set in the general-purpose registers and prints them
    mov ah, 0x0e
    mov al, bl
    int 0x10

    mov ah, 0x0e
    mov al, cl
    int 0x10

    mov ah, 0x0e
    mov al, dl
    int 0x10

    ret

end:

TIMES 510-($-$$) db 0   ; assure the script is a total of 512 bytes (including magic bytes)
dw 0xaa55               ; add magic bytes, instructing the BIOS that this is bootable
