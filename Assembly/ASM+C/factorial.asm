; 64 bit 
; int64_t factorial(int64_t n)

	global factorial
	section .text

factorial:
	
	;parameters are passed in order for integers and pointers  in rdi, rsi, rdx, rcx, r8, r9; float and double in xmm registers
	mov rax, 1
        mov rcx, rdi

        .multiply:
           mul rcx
        loop .multiply

	ret
