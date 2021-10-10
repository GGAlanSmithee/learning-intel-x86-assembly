BITS 32                 ; specify target processor mode as 32 bits (https://nasm.us/doc/nasmdoc7.html)
ORG 7c00H              ; specify base address, where the bootloader should be loaded into memory

; START EXAMPLE CODE 

mov ah, 0x0e            ; set the ah register to 0x0e
mov al, 'A'             ; move the value 'A' into the al register
int 0x10                ; call interrupt 10

; END EXAMPLE CODE 

TIMES 510-($-$$) db 0   ; assure the script is a total of 512 bytes (including magic bytes)
dw 0xaa55               ; add magic bytes, instructing BIOS that this is bootable
