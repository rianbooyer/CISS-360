;Week 3 Assignment 2
;Rian Booyer
;CISS 360 ADE
COMMENT	!
Write a program with a loop and indexed addressing that calculates the sum of all the gaps
between successive array elements. The array elements are doublewords, sequenced in nondecreasing
order. So, for example, the array {0, 2, 5, 9, 10} has gaps of 2, 3, 4, and 1, whose sum
equals 10.
!

INCLUDE Irvine32.inc ;i have to put this into the program source directory

COMMENT ~
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
~


.data
myArray DWORD 0d,1d,8d,12d,100d ;spaces are 1,7,4,88
mySum DWORD 0d
.code
main proc
	mov ah, byte ptr myArray		;stores 0 (first dword) into ah
	mov al, byte ptr myArray+4	;stores 1 (second dword) into al
	sub al,ah					;subtracts 0 from 1 equals 1
	movzx ebx, al				;moves with zero fill al (1) into ebx
	mov mySum,ebx				;adds ebx to mysum to equal 1 hex
	mov ah, byte ptr myArray+4	;stores 1 (second dword) into ah
	mov al,byte ptr myArray+8	;stores 8 (third dword) into al
	sub al,ah					;subtracts 1 from 8 resulting in 7
	movzx ebx, al				; moves with zero fill 7 into ebx
	add mysum, ebx				; adds ebx to mysum to equal 8 hex
	mov ah, byte ptr myArray+8	;Stores 8 (third dword) into ah
	mov al,byte ptr myArray+12	;stores 12 (fourth dword) into al
	sub al,ah					;subtracts 8 from 12 to get 4
	movzx ebx, al				; stores 4 into ebx
	add mysum, ebx				; adds ebx to mysum resulting in 13 or 0c hex
	mov ah, byte ptr myArray+12	;stores 12 (fourth dword) into ah
	mov al,byte ptr myArray+16	;stores 100 (fifth dword) into al
	sub al,ah					; subtracts 12 from 100 resulting in 88 or 58hex
	movzx ebx, al				;moves with zero fill al into ebx
	add mysum, ebx				;adds ebx to mysum resulting in 100 or 64 hex

					
	INVOKE ExitProcess,0
main endp
end main