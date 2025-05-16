HW#11 Print out data in ascii hex
Divine Nwokedi  
CMSC 313
UMBC

DESCRIPTION:
This program reads 8 bytes from a given input buffer (inputBuf) and converts each byte into a two-digit hexadecimal ASCII representation of itself. The result is stored in outputBuf and printed to the screen, each separated by a space with a newline added to the end of the output.

BUILD INSTRUCTIONS:
Runs with 32-bit system with using nasm and ld
Use the commands:
nasm -f elf32 hw11translate2Ascii.asm -o hw11translate2Ascii.o
ld -m elf_i386 hw11translate2Ascii.o -o hw11translate2Ascii

and use this command to run
./hw11translate2Ascii

