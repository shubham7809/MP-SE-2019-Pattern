%macro print 2
mov eax,4
mov ebx,1
mov ecx,%1
mov edx,%2
int 80h
%endmacro

section .data
nline db 10
nline_len equ $-nline

pmsg db 10,'The no. of positive elements in 32-bit array:',0
pmsg_len equ $-pmsg

nmsg db 10,'The no. of negative elements in 32-bit array:',0
nmsg_len equ $-nmsg

arr32 dd -1H,4H,-2H,-9H,-3H
n equ 5

section .bss

p_count resb 1
n_count resb 1
char_count resb 1

section .text

global _start
_start:

mov esi,arr32
mov edi,n

mov ebx,0
mov ecx,0

next_num:
mov eax,[esi]
RCL eax,1
jc negative

positive:
inc ebx
jmp next

negative:
inc ecx
next:
add esi,4
dec edi

jnz next_num
mov[p_count],ebx
mov[n_count],ecx

print pmsg,pmsg_len
mov eax,[p_count]
call disp32_proc

print nmsg,nmsg_len
mov eax,[n_count]
call disp32_proc
print nline,nline_len

mov eax,1
mov ebx,0
int 80h

disp32_proc:

add al,30h
mov[char_count],eax
print char_count,1
ret


;==============O/P==========
;gurukul@gurukul-ThinkCentre-M800:~$ nasm -f elf64 ass5.asm
;gurukul@gurukul-ThinkCentre-M800:~$ ld -o ass5 ass5.o
;gurukul@gurukul-ThinkCentre-M800:~$ ./ass5
;The no. of positive elements in 32-bit array:1
; no. of negative elements in 32-bit array:4

