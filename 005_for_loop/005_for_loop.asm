BITS 16                 ; specify target processor mode as 16 bits (https://nasm.us/doc/nasmdoc7.html)
ORG 0x7c00              ; specify base address, where the bootloader should be loaded into memory

mov cl, 0

loop:
    mov ah, 0x0e        ; print character (from A to J)
    mov bl, cl          ; move the value stored in the cl register into the bl register
    add bl, 65          ; add 65 to the value stored in bl (in ASCI, A = 65, B = 66 etc)
    mov al, bl
    int 0x10

    inc cl

    cmp cl, 10          ; compare cl to 10
        jl loop         ; if less, jump to the label "loop" (jl = jump if less)
        jmp exit        ; fallback: jump to the label "exit"

exit:

TIMES 510-($-$$) db 0   ; assure the script is a total of 512 bytes (including magic bytes)
dw 0xaa55               ; add magic bytes, instructing BIOS that this is bootable
