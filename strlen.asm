section .data
m2 db 10,10,'Enter the string:'
m2_len equ $-m2
m3 db 'Length of the stirng is:'
m3_len equ $-m3

section .bss
srcstr resb 20
count resb 1
dispbuff resb 2

%macro disp 2
mov eax,4
mov ebx,1
mov ecx,%1
mov edx,%2
int 80h
%endmacro

%macro acceptstr 1
mov eax,03
mov ebx,0
mov ecx,%1
int 80h
%endmacro

section .text
global _start
_start:

disp m2,m2_len
acceptstr srcstr
dec al
mov[count],al
disp m3,m3_len
mov bl,[count]
call display

mov eax,01
int 80h

display:
mov cl,2
mov edi,dispbuff

d1:
rol bl,4
mov al,bl
and al,0fh
cmp al,09
jbe d2
add al,07

d2:
add al,30h
mov [edi],al
inc edi
dec cl
jnz d1

disp dispbuff,2
ret

;=======OUTPUT============
;lenovo@ubuntu:~$ nasm -f elf strlen.asm
;lenovo@ubuntu:~$ ld -m elf_i386 strlen.o
;lenovo@ubuntu:~$ ./a.out


;Enter the string:SNJBCOE
;Length of the stirng is:07 

