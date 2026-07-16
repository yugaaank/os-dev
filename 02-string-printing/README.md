# 02 - String Printing

Introduces **functions** and **string handling**. Prints "Hello" using a reusable print routine.

## How It Works

### The Problem with 01-hello-world

Printing one character at a time is tedious. For longer strings, we need a function.

### String Representation

```asm
message:
  db "Hello", 0    ; Store string in memory, null-terminated (0)
```

Strings are stored as consecutive bytes. The `0` (null terminator) marks the end.

### SI Register - String Pointer

```asm
mov si, message    ; SI points to the start of the string
call print_string  ; Call our function
```

The `SI` (Source Index) register holds the address of the current character.

### The Print Function (print.asm)

```asm
print_string:
  .loop:
    mov al, [si]      ; Load byte at SI into AL
    cmp al, 0         ; Is it null (0)?
    je .done          ; If yes, we're done
    int 0x10          ; Print the character
    inc si            ; Move to next character
    jmp .loop         ; Repeat
  .done:
    ret               ; Return to caller
```

This loops through each character until it hits the null terminator.

### Labels

- `print_string:` - Function entry point
- `.loop:` - Local label (scoped to `print_string`)
- `.done:` - Local label for the exit

### Include Directive

```asm
%include "print.asm"    ; Paste contents of print.asm here
```

NASM literally copies the file contents at this point. The function must be defined before it's called, or placed after the `call` instruction.

## Build & Run

```bash
nasm -f bin boot.asm -o boot.bin
qemu-system-i386 -fda boot.bin
```
