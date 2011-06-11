[SECTION .data]
  Response db "Result = %d",10,0
  MAX_FIBONACCI equ 4000000

[SECTION .bss]

[SECTION .text]

extern printf

global main

main:

  mov r8, 1     ; The nth Fibonacci term
  mov r9, 2     ; The n+1st Fibonacci term
  xor r10, r10   ; The sum of the even Fibonacci terms
loop:

  cmp r9, MAX_FIBONACCI
  jg done

  mov rax, r9
  shr rax, 1
  jc next_fib

  add r10, r9
next_fib:
  mov rax, r9
  add r9, r8
  mov r8, rax

  jmp loop

done:

  push rbp
	mov rbp,rsp
  mov rsi, r10
  mov rdi, Response
	mov rax, 0	
	call printf	

;;; Everything after this is boilerplate; use it for all ordinary apps!
  mov rsp, rbp
  pop rbp
	ret		; Return control to Linux
  
