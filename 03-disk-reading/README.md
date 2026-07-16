# 03 - Disk Reading

Reads data from a disk sector into memory using BIOS interrupt `0x13`.

## How It Works

### Why Read from Disk?

The boot sector is only 512 bytes. For larger programs, we need to load additional sectors from disk. This example loads sector 2 and prints its contents.

### Disk Layout

| Sector | Address | Contents |
|--------|---------|----------|
| 1 (boot) | 0x7C00 | Our bootloader code |
| 2 | 0x8000 | Data: "HELLO" (loaded by bootloader) |

### Setting Up the Stack

```asm
mov bp, 0x8000    ; Base pointer
mov sp, bp        ; Stack pointer = base (empty stack)
```

The stack grows downward. Setting SP = BP means the stack is empty.

### BIOS Interrupt 0x13 - Disk Services

```asm
; CHS addressing parameters
mov ch, 0x00      ; Cylinder 0
mov cl, 0x02      ; Sector 2 (1-indexed)
mov dh, 0x00      ; Head 0

; Where to load the data
mov ax, 0x0000
mov es, ax        ; ES = segment (0x0000)
mov bx, 0x8000    ; BX = offset (0x8000)
; Effective address = ES*16 + BX = 0x8000

; Function and count
mov ah, 0x02      ; Function 0x02 = Read sectors
mov al, 0x01      ; Read 1 sector

int 0x13          ; Call BIOS disk interrupt
jc disk_error     ; If CF=1, error occurred
```

### Error Handling

```asm
jc disk_error     ; Jump if Carry Flag is set

disk_error:
  mov al, 'E'     ; Print 'E' for error
  int 0x10
  jmp $
```

BIOS sets the Carry Flag (`CF=1`) on failure. Always check it after disk operations.

### Data Sector (sector1.asm)

```asm
db 'HELLO', 0       ; Our data
times 506 db 0      ; Pad to 512 bytes
```

Each sector is exactly 512 bytes. The padding ensures correct sector alignment.

### Memory After Load

```
0x8000: H
0x8001: E
0x8002: L
0x8003: L
0x8004: O
0x8005: 0 (null terminator)
```

### CHS vs LBA

This example uses **CHS** (Cylinder-Head-Sector) addressing, the traditional method. Modern systems use **LBA** (Logical Block Addressing) which treats sectors as a flat array.

## Build & Run

```bash
nasm -f bin boot.asm -o boot.bin
nasm -f bin sector1.asm -o sector1.bin

# Create a floppy image with both sectors
cat boot.bin sector1.bin > os.img
dd if=/dev/zero bs=512 count=1 >> os.img  # Pad to floppy size

qemu-system-i386 -fda os.img
```
