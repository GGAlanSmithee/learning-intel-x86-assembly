BITS 16                 ; specify target processor mode as 16 bits (https://nasm.us/doc/nasmdoc7.html)
ORG 0x7c00              ; specify base address, where the bootloader should be loaded into memory

one:
    mov ah, 0x0e
    mov al, '1'
    int 0x10
    jmp three           ; jump to the label 'three'

two:
    mov ah, 0x0e
    mov al, '2'
    int 0x10
    jmp continue        ; jump to the label 'continue', effectively ending the program execution

three:
    mov ah, 0x0e
    mov al, '3'
    int 0x10
    jmp two             ; jump to the label 'two'

continue:

TIMES 510-($-$$) db 0   ; assure the script is a total of 512 bytes (including magic bytes)
dw 0xaa55               ; add magic bytes, instructing the BIOS that this is bootable
