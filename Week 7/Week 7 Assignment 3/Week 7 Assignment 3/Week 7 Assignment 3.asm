;Week 7 Assignment 3
;Rian Booyer
;CISS 360 ADE
COMMENT ~
FindThrees Procedure
Create a procedure named FindThrees that returns 1 if an array has three consecutive values of
3 somewhere in the array. Otherwise, return 0. The procedure’s input parameter list contains a
pointer to the array and the array’s size. Use the PROC directive with a parameter list when
declaring the procedure. Preserve all registers (except EAX) that are modified by the procedure.
Write a test program that calls FindThrees several times with different arrays.
~
INCLUDE Irvine32.inc
COMMENT ~
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
~
FindThrees PROTO, 
	pArr: PTR BYTE, 
	arrLen: BYTE
	
.data
strContains BYTE "The array contains three consecutive 3.",13,10,0
strDoesNotContain BYTE "The array does not contain three consecutive 3.",13,10,0
arrOne BYTE 1, 2, 3, 5
arrTwo BYTE 3, 3, 2, 8, 3
arrThree BYTE 5, 2, 3, 3, 3, 9
.code
main PROC
;First Array
INVOKE FindThrees, ADDR arrOne, LENGTHOF arrOne
.IF eax == 1
	call cont
.ELSE
	call notCont
.ENDIF

; Second Array
INVOKE FindThrees, ADDR arrTwo, LENGTHOF arrTwo
.IF eax == 1
	call cont
.ELSE
	call notCont
.ENDIF

; Third Array
INVOKE FindThrees, ADDR arrThree, LENGTHOF arrThree
.IF eax == 1
	call cont
.ELSE
	call notCont
.ENDIF
	call WaitMsg

	INVOKE ExitProcess,0
main ENDP
FindThrees PROC USES esi ecx ebx,
pArr: PTR BYTE,		; points the array
arrLen: BYTE		; the length of array

	mov eax,0			; initialize EAX to 0 
	mov esi,pArr		; ESI Initialized to pointer of array
	movzx ecx,arrLen	;set array length as the counter ecx
	sub ecx,2			; as next 2 elements were observed
L1:
;use only bl for comparison since we don't need anything over 8 bits
	mov bl, 0				;for making debugging easier
	mov bl, [esi]			;move the value of [esi] to bl for .if comparison first value of [esi]
	.IF bl == 3			
	mov bl, [esi+1]		;second value of [esi]
	.IF bl == 3
	mov bl, [esi+2]		;third value of [esi]
	.IF bl == 3
	mov eax,1				; set EAX = 1 if the previous three values equals 3
	jmp L2				;jump to l2 to return
	.ENDIF
	.ENDIF
	.ENDIF
	inc esi				;Increment ESI if the above doesn't equal 3 threes for next comparison
	loop L1
L2:
	ret					; returns EAX
FindThrees ENDP

cont proc USES edx
	mov edx, offset strContains
	call WriteString
	ret
cont endp


notCont proc USES edx
	mov edx,offset strDoesNotContain
	call WriteString
	ret
notCont endp
END main