;Week 6 Assignment 3
;Rian Booyer
;CISS 360 ADE
COMMENT ~
Bitwise Multiplication
Write a procedure named BitwiseMultiply that multiplies any unsigned 32-bit integer by
EAX, using only shifting and addition. Pass the integer to the procedure in the EBX register,
and return the product in the EAX register. Write a short test program that calls the procedure
and displays the product. (We will assume that the product is never larger than 32 bits.) This is
a fairly challenging program to write. 

One possible approach is to use a loop to shift the multiplier
to the right, keeping track of the number of shifts that occur before the Carry flag is set.
The resulting shift count can then be applied to the SHL instruction, using the multiplicand as
the destination operand. Then, the same process must be repeated until you find the last 1 bit
in the multiplier.
~

INCLUDE Irvine32.inc
COMMENT ~
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
~
.data
xString byte "x",0
equalString byte "=",0
resultString byte "The Result: ",0

;set values here
multiplier DWORD 22
multiplicand DWORD 5
;multiplier
;x multiplicand
.code
main PROC
	call Crlf
	mov eax, multiplier
	call WriteDec
	mov edx, offset xString
	call WriteString
	mov eax, multiplicand
	call WriteDec
	mov edx, offset equalString
	call WriteString
	
	;set values of eax and ebx
	mov ebx,multiplicand
	mov eax,multiplier
   
	;call bitwise multiply
	call BitwiseMultiply  

	;display result since result is already in eax just call writedec
	call WriteDec 
	call Crlf  
	call WaitMsg
	
   
  INVOKE ExitProcess,0
main ENDP


BitwiseMultiply PROC uses ecx edx esi
	; EBX = multiplicand, EAX = multiplier
	mov edx,0		;clear edx
	mov ecx,32		;set counter to 32 for 32 bits
L1:   
	test ebx,1	;checks to see if LSB is set
	jz   L2		;If lsb isn't set jump to l2
	add edx,eax		;If lsb is set add multiplicand to product
	jc   L3		

L2:
	shr ebx,1   ;shift ebx right 1
	shl eax,1   ;match by shifting eax left 1
	jc   L3	;if carry jump to L3
	loop L1	;repeats untill all 32 bits have been examined or a carry is set

L3:   
	mov eax,edx   ;moves edx to eax for return to main on proper register

	ret
BitwiseMultiply ENDP
END main