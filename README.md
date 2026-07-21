# os-dev

x86 assembly bootloader examples for learning OS development.

## Examples

1. **01-hello-world** -- minimal bootloader, prints "Hello World"
2. **02-string-printing** -- reusable print routine with string handling
3. **03-disk-reading** -- BIOS interrupts and disk I/O

## Build and run

```bash
cd 02-string-printing
nasm -f bin boot.asm -o boot.bin
qemu-system-i386 -fda boot.bin
```

## Prerequisites

- NASM
- QEMU or VirtualBox

## References

`docs/` has register usage and BIOS interrupt references.

## License

MIT
