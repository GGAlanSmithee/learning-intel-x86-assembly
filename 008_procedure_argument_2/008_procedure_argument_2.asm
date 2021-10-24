BITS 16                 ; specify target processor mode as 16 bits (https://nasm.us/doc/nasmdoc7.html)
ORG 0x7c00              ; specify base address, where the bootloader should be loaded into memory

mov cl, 'A'             ; assing "A" and "B" to the low and high bits of the cx registers
mov ch, 'B'
mov dl, 'C'
mov dh, 'D'

push cx                 ; push the cx register in the stack (must be 16 bits, since we're in 16 bits mode)
push dx

call procedure          ; call the procedure that will use the arguments

pop dx                  ; reset registes after returning from the procedure
pop cx

mov al, 'E'         ; print "E" so we can see that program execution continues as expected
int 0x10

; print the original registers in reverse order to show they are intact

mov al, dh          ; print "D"
int 0x10
mov al, dl          ; print "C"
int 0x10
mov al, ch          ; print "B"
int 0x10
mov al, cl          ; print "A"
int 0x10

jmp end              ; go to the label "end", effictevly ending the execution of the program

procedure:
    push bp         ; push bp to the stack, making it the entry point of the stack frame
    mov bp, sp      ; set bp to sp, making the fram pointer point to the top of the stack

    mov bx, [bp+6]  ; get the first argument, offset = bp (2 byte) + argument (2 byte) + argument (2 byte)

    mov ah, 0x0e
    
    mov al, bl      ; print "A"
    int 0x10

    mov al, bh      ; print "B"
    int 0x10

    mov bx, [bp+4]  ; get the second argument, offset = bp (2 byte) + argument (2 byte)

    mov al, bl      ; print "C"
    int 0x10

    mov al, bh      ; print "D"
    int 0x10

    mov sp, bp      ; set sp to bp, the entry point of the function
    pop bp          ; pop the entry point, resetting sp to the return address

    ret

end:

TIMES 510-($-$$) db 0   ; assure the script is a total of 512 bytes (including magic bytes)
dw 0xaa55               ; add magic bytes, instructing the BIOS that this is bootable
