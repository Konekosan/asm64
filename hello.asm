global _start
_start:
    jmp _hello

_write:
    ;write(1, "Hello world!", 14)
    pop rsi			;rsi = Hello world !
    xor rdi, rdi
    inc rdi
    xor rdx, rdx
    add dl, 14
    xor rax, rax
    mov al, 1
    syscall

    xor rax, rax
    add rax, 60 ; sys_exit
    xor rdi, rdi ; exit(0)
    syscall

_hello:
    call _write
    db 'Hello world!', 0xa
