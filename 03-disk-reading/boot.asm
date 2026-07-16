org 0x7c00
bits 16

mov bp, 0x8000
mov sp, bp


mov ch, 0x00
mov cl, 0x02
mov dh, 0x00

mov ax, 0x0000
mov es, ax
mov bx, 0x8000

mov ah, 0x02
mov al, 0x01

int 0x13
jc disk_error

mov ah, 0x0E
mov si, 0x8000
print:
  mov al, [si]
  int 0x10
  inc si
  cmp al, 0
  je done
  jmp print
jmp $

done:
jmp $


disk_error:
  mov ah, 0x0E
  mov al, 'E'
  int 0x10

  jmp $



times 510 - ($-$$) db 0
dw 0xAA55
