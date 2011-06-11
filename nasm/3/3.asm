[SECTION .data]
  Response db "Result = %d",10,0
  BIG_NUMBER equ 600851475143

[SECTION .bss]

  PRIMES resq 10000000
  NUM_PRIMES resq 1

[SECTION .text]

extern printf


align 64
get_another_prime:
  push rdx
  push rbx
  push rcx
  push r8

  mov r8, [NUM_PRIMES]
  xor rdx, rdx
  mov rbx, [PRIMES + r8 * 8 - 8] ; Value of largest known prime
.loop:
  add rbx, 2         ; increment candidate to next odd number
  xor r8, r8

.seeIfDivisibleByPrime:
  mov rax, [PRIMES + r8 * 8]     ; push the current prime into rax 
  mul rax            ; square the prime
  cmp rax, rbx       ; If bigger than our candidate then our candidate must be prime
  jg .done
  
  xor rdx, rdx       ; zero rdx
  mov rax, rbx       ; divide prime candidate by next in list
  div qword [PRIMES + r8 * 8]
  cmp rdx, 0          ; If remainder is zero then candidate is composite
  jz .loop
  inc r8
  jmp .seeIfDivisibleByPrime

.done:
  inc qword [NUM_PRIMES]
  mov r8, [NUM_PRIMES]
  mov [PRIMES + r8 * 8 - 8], rbx
  pop r8
  pop rcx
  pop rbx
  pop rdx
  ret
  

global main
main:

  mov qword [PRIMES], 2
  mov qword [PRIMES + 8], 3
  mov qword [NUM_PRIMES], 2

  mov r9, 1000000
  align 64
loop:

  call get_another_prime
  dec r9
  jnz loop
  mov qword r8, [NUM_PRIMES]
  mov rsi, [PRIMES + r8 * 8 - 8]

  push rbp
	mov rbp,rsp
  mov rdi, Response
	mov rax, 0	
	call printf	

;;; Everything after this is boilerplate; use it for all ordinary apps!
  mov rsp, rbp
  pop rbp
	ret		; Return control to Linux
  
