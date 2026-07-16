org 0x7C00
bits 16

mov ah, 0x0E
mov si, message

call print_string

jmp $

message:
  db "Hello", 0

%include "print.asm"

times 510-($-$$) db 0
dw 0xAA55
