[SECTION .data]
  Response db "Result = %d",10,0
  MAX_COUNT equ 1000

[SECTION .bss]

[SECTION .text]

extern printf

global main

main:

  xor rsi, rsi   ; The sum of integers divisible by three or 5
  xor rdi, rdi   ; The next integer to try
loop:
  inc rdi
  cmp rdi, MAX_COUNT
  jge done
  
  mov rax, rdi
  xor rdx, rdx
  mov r8, 3
  div r8
  cmp rdx, 0
  jz add_me_baby
  
  mov rax, rdi
  xor rdx, rdx
  mov r8, 5
  div r8
  cmp rdx, 0
  jz add_me_baby

  jmp loop

add_me_baby:
  add rsi, rdi
  jmp loop


done:

  push rbp
	mov rbp,rsp
  mov rdi, Response
	mov eax, 0	
	call printf	

;;; Everything after this is boilerplate; use it for all ordinary apps!
  mov rsp, rbp
  pop rbp
	ret		; Return control to Linux
  
