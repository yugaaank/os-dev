# 01 - Hello World

The simplest possible bootloader. Prints "Hello World" directly to screen.

## How It Works

### Bootloader Basics

When a PC boots, the BIOS loads the first 512 bytes from the disk into memory at address `0x7C00` and jumps to it. This 512-byte block is called the **boot sector**.

### Code Breakdown

```asm
org 0x7C00      ; Tell NASM we're loaded at address 0x7C00
bits 16          ; We're in 16-bit real mode (the CPU's initial state)
```

### BIOS Interrupt 0x10 - Video Services

```asm
mov ah, 0x0E    ; Function 0x0E = Teletype output (print character)
mov al, 'H'     ; Character to print
int 0x10        ; Call BIOS interrupt
```

`int 0x10` calls the BIOS video interrupt. With `AH=0x0E`, it prints the character in `AL` to the screen at the current cursor position.

### Infinite Loop

```asm
jmp $           ; $ = current address, so this loops forever
```

The CPU must keep executing something. Without this, it would continue into random memory.

### Boot Signature

```asm
times 510 - ($-$$) db 0   ; Pad with zeros until byte 510
dw 0xAA55                 ; Magic number at bytes 511-512
```

The BIOS checks for `0xAA55` at the end of the boot sector. Without it, the BIOS won't boot from this disk.

## Build & Run

```bash
nasm -f bin boot.asm -o boot.bin
qemu-system-i386 -fda boot.bin
```
