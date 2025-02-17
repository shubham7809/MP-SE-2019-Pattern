section .data
	msg1 db 10,13,"Enter 5 64-bit numbers"
	len1 equ $-msg1
	msg2 db 10,13,"The 5 64-bit numbers are"
	len2 equ $-msg2

section .bss
	array resd 200
	counter resb 1

section .text
	global_start
	_start:


;display
	mov Rax,1
	mov Rdi,1
	mov Rsi,msg1
	mov Rdx,len1
	syscall
;accept

mov byte[counter],05
mov rbx,00
	loop1:
		mov rax,0
		mov rdi,0
		mov rsi, array
		add rsi,rbx
		mov rdx,17
		syscall
		add rbx,17
		dec byte[counter]
		JNZ loop1
;display
	mov Rax,1
	mov Rdi,1
	mov Rsi,msg2
	mov Rdx,len2
	syscall

;display
mov byte[counter],05
mov rbx,00
	loop2:
		mov rax,1
		mov rdi,1
		mov rsi, array
		add rsi,rbx
		mov rdx,17
		syscall
		add rbx,17
		dec byte[counter]
		JNZ loop2
	;exit system call
	mov rax,60
	mov rdi,0
	syscall

	  

