global _start
_start:
    jmp hello

shellcode:
    pop rsi
    xor rax, rax
    mov al, 1 ; sys_write
    mov rdi, rax
    mov rdx, rdi
    add rdx, 14
    syscall

    xor rax, rax
    add rax, 60 ; sys_exit
    xor rdi, rdi ; exit(0)
    syscall

hello:
    call shellcode
    db 'Hello world!', 0xa
