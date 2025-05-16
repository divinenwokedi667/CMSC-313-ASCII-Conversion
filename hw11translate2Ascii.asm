; Divine Nwokedi
; CMSC 313 UMBC

SECTION .data
inputBuf:

    db  0x83,0x6A,0x88,0xDE,0x9A,0xC3,0x54,0x9A
inputLen equ 8 ; 8 different bytes, 8 different loops

SECTION .bss
outputBuf:
    resb 80 ; reserving 80 bytes for output

SECTION .text
    global _start
    
_start:
    mov esi, inputBuf
    mov edi, outputBuf
    mov ecx, inputLen
    
hex_loop: ;loop through each given byte and process them, splitting them in fours to get each digit
    cmp ecx, 0 ; keep track of counter
    je .done
    
    mov al, [esi] ; using al instead of a larger register like eax because we are manipulating 4 bit chunks at once
    inc esi
    mov ah, al ; save full byte for later use
    
    shr al, 4 ; shift bits to right to only get first number
    call convert
    mov [edi], al
    inc edi
    
    mov al, ah ; get original byte back
    and al, 0x0F ;mask 4 largest bits away
    call convert
    mov [edi], al
    inc edi ; store in output, increment after
    
    mov al, ' '
    mov [edi], al
    inc edi
    
    dec ecx
    jmp hex_loop
    
.done: ; loop has been completed, now to write and exit
    mov byte [edi], 0x0A ; append newline
    inc edi              ; include it in final output

    mov eax, 4           ; sys_write
    mov ebx, 1           ; stdout
    mov ecx, outputBuf
    mov edx, edi
    sub edx, outputBuf   ; edx = number of bytes to write
    int 0x80

    mov eax, 1           ; sys_exit
    mov ebx, 0
    int 0x80
    
convert: ; conversion function, used to convert each hex digit into its respective ASCII representation
    cmp al, 9
    jbe .num
    add al, 0x37 ; for "letters" in hex
    ret
.num:
    add al, 0x30 ; for digits in hex
    ret