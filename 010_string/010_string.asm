BITS 16                 ; specify target processor mode as 16 bits (https://nasm.us/doc/nasmdoc7.html)
ORG 0x7c00              ; specify base address, where the bootloader should be loaded into memory

string: db "Hello, World!", '\0'    ; declare the symbol "string" and define it to be "Hello, World!"
mov bx, 0                           ; use the "si" register as the character index, starting at 0

print:                              ; generic print method
    mov cl, [string + bx]

    cmp cl, '\0'                    ; if we're at the end of the string (null terminator character) exit the loop
        je end

    mov ah, 0x0e
    mov al, cl
    int 0x10

    inc bx                          ; increment index

    jmp print                       ; continue loop through the string, printing it character by character

end:

TIMES 510-($-$$) db 0   ; assure the script is a total of 512 bytes (including magic bytes)
dw 0xaa55               ; add magic bytes, instructing the BIOS that this is bootable
