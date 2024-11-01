; This program finds the multiples of 3 and 5 from 0 - 1000 and sums them
;
; Compile with
;   nasm -f elf64 main.s
;   gcc -no-pie -nostartfiles -o main main.o

SECTION .text
global _start
extern printf

add_sum:
  ; increment sum if reaminder == 0
  mov eax, [sum]
  add eax, [current]
  mov [sum], eax
  jmp loop_end

_start:
  mov ecx, 1000 ; start count
  jmp loop_start

loop_start:
  mov eax, [current]
  xor edx, edx ; clear edx
  mov ebx, 3
  div ebx
  cmp edx, 0 ; remainder in edx, if 0, current divisible by 3
  je add_sum

  ; same for 5
  mov eax, [current]
  xor edx, edx
  mov ebx, 5
  div ebx
  cmp edx, 0
  je add_sum

loop_end:
  mov eax, [current]
  inc eax
  mov [current], eax

  loop loop_start

_end:
  mov edi, currentMsg 
  mov eax, [sum]
  mov esi, eax
  xor eax, eax
  call printf

  mov eax, 60 ; syscall: exit
  xor edi, edi ; status 0
  syscall

SECTION .data
current: DD 1
sum: DD 0
currentMsg: DB "Sum: %d", 0x0A, 0 ; 0xA is the newline
