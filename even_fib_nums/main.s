; find all even fibonacci nubmers under four million
; compile with
;   nasm -f elf64 main.s
;   gcc -o main main.o

bits 64
section .text
global main

; ebx: number to add to sum
add_sum:
  push rbp
  mov rbp, rsp
  push rax

  mov rax, rbx
  mov rax, qword [REL sum]
  add rax, rbx
  mov qword [REL sum], rax

  pop rax
  mov rsp, rbp
  pop rbp
  ret

main:
  push rbp
  mov rbp, rsp

  ; init sum
  mov rax, 0
  mov qword [REL sum], rax

  sub rsp, 0x08 ; space for two 32 bit numbers
  mov dword [rbp - 0x04], 0 ; prev fib 1
  mov dword [rbp  - 0x08], 1 ; prev fib 2

fib_loop:
  ; get next fib number into ebx
  mov ebx, dword [rbp - 0x04]
  add ebx, dword [rbp - 0x08]
  
  ; check if less than four million
  cmp ebx, 4000000
  jge _end
  
  ; check if even
  test ebx, 1 ; ZF = 0 if ebx is odd
  jne skip_add
  call add_sum

skip_add:
  ; update local var fib numbers
  mov eax, dword [rbp - 0x08]
  mov dword [rbp - 0x04], eax
  mov dword [rbp - 0x08], ebx

  jmp fib_loop

_end:
  mov rsp, rbp
  pop rbp

  mov rax, 60
  mov rdi, rbx
  syscall

section .bss
sum resq 1
