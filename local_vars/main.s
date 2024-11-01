; 64 bit program
; compiled with
;   nasm -f elf64 main.s
;   ld main.o

bits 64
section .text
global _start

_start:
  push rbp
  mov rbp, rsp

  sub rsp, 0x10

  mov qword [rbp + 0x08], 1234
  mov qword [rbp + 0x10], 5678

  mov rax, [rbp + 0x08]
  add rax, [rbp + 0x10]

  mov rsp, rbp
  pop rbp

  mov rax, 60
  xor rdi, rdi
  syscall
