BITS 16                 ; specify target processor mode as 16 bits (https://nasm.us/doc/nasmdoc7.html)
ORG 0x7c00              ; specify base address, where the bootloader should be loaded into memory

mov bl, '1'
mov cl, 'A'
mov dl, 1                       ; smiley face

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
