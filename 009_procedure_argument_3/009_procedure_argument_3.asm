BITS 16                 ; specify target processor mode as 16 bits (https://nasm.us/doc/nasmdoc7.html)
ORG 0x7c00              ; specify base address, where the bootloader should be loaded into memory

mov si, -1

struc person
	id:             resw 1
	name:           resb 20
    description:    resb 100
endstruc

mov bx, [bob + name]
push bx
call print
pop bx

jmp end

print:
    mov bp, sp
    mov si, -1

    ; mov bl, [bp + 2]

    ; mov ah, 0x0e
    ; mov al, bl    
    ; int 0x10

    ; mov sp, bp
    ; pop bp
    ; ret

    .loop:
        inc si
        mov bl, [bp + 2 + si]

        cmp bl, 0
            jne .ifTrue

        .else:
            mov sp, bp
            pop bp
            ret

        .ifTrue:
            mov ah, 0x0e
            mov al, bl
            int 0x10

            jmp .loop
        

bob:
    istruc person
        at id,          dw 1
        at name,        db 'Bob', 0
        at description, db 'Builder Bob builds the blocks, one bit at a time', 0
    iend

end:
    mov ah, 0x0e
    mov al, 'P'
    int 0x10

TIMES 510-($-$$) db 0   ; assure the script is a total of 512 bytes (including magic bytes)
dw 0xaa55               ; add magic bytes, instructing the BIOS that this is bootable
