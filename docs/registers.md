## Function Numbers

Function number goes into AH

Printing on screen: 0x0E
Reading sectors: 0x02

## Number of Sector
Number of sectors goes into AL ( simple count of sectors)

## Which drive?
Drive info goes into DL

## Where data goes in RAM
segment:offset pair = ES:BX

ES = 0000, BX = 1000
address = 0000 x 16 + 1000

## Cylinder, Head, Sector
Used for older system, CHS addressing

Modern used LBA (Logical Block Addressing)

## Flags register
Special register that stores information about the last operation

ZF = Zero flag (1 when output is 0, 0 when output is not 0)
CF = Carry flag ( arithmetic and reporting errors, 255+1 = 256 (result overflow, cpi sets CF = 1) ) BIOS uses CF to represent SUCCESS or FAILURE

to check ZF we use je
to check CF we use jc
