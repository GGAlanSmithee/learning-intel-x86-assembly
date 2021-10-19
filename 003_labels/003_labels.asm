BITS 16                 ; specify target processor mode as 16 bits (https://nasm.us/doc/nasmdoc7.html)
ORG 0x7c00              ; specify base address, where the bootloader should be loaded into memory

val: db 'L'             ; define the value 'L' and create the label val that points to it

print:                  ; define the label print (this has no effect in our program)
    mov ah, 0x0e        
    mov al, [val]       ; dereference the val label to the memory address it is pointing to (where 'A' is stored)
    int 0x10

TIMES 510-($-$$) db 0   ; assure the script is a total of 512 bytes (including magic bytes)
dw 0xaa55               ; add magic bytes, instructing the BIOS that this is bootable
