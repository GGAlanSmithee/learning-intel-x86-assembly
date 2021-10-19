BITS 16                 ; specify target processor mode as 16 bits (https://nasm.us/doc/nasmdoc7.html)
ORG 0x7c00              ; specify base address, where the bootloader should be loaded into memory

mov cl, 0

loop:
    call print          ; makes a procedure call to the label "print"

    inc cl

    cmp cl, 10          ; compare cl to 10
        jl loop         ; if less, jump to the label "loop" (jl = jump if less)
        jmp exit        ; fallback: jump to the label "exit"

print:                  ; print character (from A to J)
    mov ah, 0x0e
    mov bl, cl
    add bl, 65
    mov al, bl
    int 0x10
    ret                 ; return to the memory address where this label was called from

exit:

TIMES 510-($-$$) db 0   ; assure the script is a total of 512 bytes (including magic bytes)
dw 0xaa55               ; add magic bytes, instructing the BIOS that this is bootable
