# OS Development Learning

A collection of x86 assembly examples for learning OS development concepts.

## Project Structure

```
├── docs/                    # Reference documentation
│   ├── interrupts.md        # BIOS interrupt reference
│   └── registers.md         # Register usage guide
├── 01-hello-world/          # Basic bootloader
├── 02-string-printing/      # String printing functions
│   ├── boot.asm             # Main bootloader
│   └── print.asm            # Reusable print routine
└── 03-disk-reading/         # Reading sectors from disk
    ├── boot.asm             # Main bootloader
    └── sector1.asm          # Data sector
```

## Prerequisites

- NASM (Netwide Assembler)
- QEMU or VirtualBox for testing

## Building

```bash
# Example: Build the string printing example
cd 02-string-printing
nasm -f bin boot.asm -o boot.bin

# Run in QEMU
qemu-system-i386 -fda boot.bin
```

## Learning Path

1. **01-hello-world** - Basic bootloader structure
2. **02-string-printing** - Functions and string handling
3. **03-disk-reading** - BIOS interrupts and disk I/O

## References

- See `docs/` for register and interrupt documentation
