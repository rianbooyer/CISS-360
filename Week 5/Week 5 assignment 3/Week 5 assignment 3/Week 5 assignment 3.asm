;Week 5 Assignment 3
;Rian Booyer
;CISS 360 ADE
COMMENT ~
Boolean Calculator (1)
Create a program that functions as a simple boolean calculator for 32-bit integers. It should display
a menu that asks the user to make a selection from the following list:
1. x AND y
2. x OR y
3. NOT x
4. x XOR y
5. x AND_op Y
6. x OR_op Y
7. x NOT_op Y
8. x XOR_op y
9. Exit program
When the user makes a choice, call a procedure that displays the name of the operation about to
be performed. You must implement this procedure using the Table-Driven Selection technique,
shown in Section 6.5.4. (You will implement the operations in Exercise 6.) 
Continue the solution program from Exercise 5 by implementing the following procedures:
• AND_op: Prompt the user for two hexadecimal integers. AND them together and display the
result in hexadecimal.
• OR_op: Prompt the user for two hexadecimal integers. OR them together and display the
result in hexadecimal.
• NOT_op: Prompt the user for a hexadecimal integer. NOT the integer and display the result in
hexadecimal.
• XOR_op: Prompt the user for two hexadecimal integers. Exclusive-OR them together and
display the result in hexadecimal.

~

INCLUDE Irvine32.inc
COMMENT ~
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
~


.data
;main menu section
txtMenuLabel byte "Boolean Calculator",13,10,0
txtOp1 byte "1. x AND y",13,10,0
txtOp2 byte "2. x OR y",13,10,0
txtOp3 byte "3. NOT x",13,10,0
txtOp4 byte "4. x XOR y",13,10,0
txtOp5 byte "5. x AND_op Y",13,10,0
txtOp6 byte "6. x OR_op Y",13,10,0
txtOp7 byte "7. x NOT_op Y",13,10,0
txtOp8 BYTE "8. x XOR_op y",13,10,0
txtOp9 byte "9. Exit program",13,10,0
txtInputOption byte "Please enter your choice: ",0
menuChoice dword ?
;ask for x and y
askXVal byte "Please enter value for X: ",0
askYVal byte "Please enter value for Y: ",0
solution byte "The solution is: ",0
;x and y value's
xVal dword ?
yVal dword ?

;proc titles

CaseTable BYTE 1
		DWORD XANDY
		byte 2
		DWORD XORY
		byte 3
		DWORD NOTX
		byte 4
		DWORD XXORY
		byte 5
		DWORD XAND_OPY
		byte 6
		DWORD XOR_OPY
		byte 7
		DWORD XNOT_OPY
		byte 8
		DWORD XXOR_OPY
		byte 9
		DWORD ExitProgram
NumberOfEntries = 9
XANDYTitle BYTE "X and Y - Integers Only",13,10,0
XORYTitle byte "X or Y - Integers Only",13,10,0
NOTYTITLE byte "NOT Y - Integers Only",13,10,0
XXORYTitle byte "X XOR Y - Integers Only",13,10,0

XAND_OPYTitle byte "X AND_op Y - Hex Only",13,10,0
XOR_OPYTitle byte "X OR_OP Y - Hex Only",13,10,0
NOT_OPYTitle byte "NOT_op Y - Hex Only",13,10,0
XXOR_OPYTitle byte "X XOR_op Y - Hex Only",13,10,0
.code
main proc
	call DisplayMenu
	pusha
	call MenuProcess
	popa
					
	INVOKE ExitProcess,0
main endp

MenuProcess proc
	mov eax, menuChoice
	mov ebx, offset CaseTable
	mov ecx, NumberOfEntries
	
L1:
	cmp al,[ebx]
	jne L2
	pusha
	call NEAR PTR [ebx +1]
	popa
	jmp L3

L2:
	add ebx,5
	loop L1
L3:
	call main
	;call ExitProgram	
	ret
MenuProcess endp

DisplayMenu proc USES edx eax
	call Clrscr
	mov edx,offset txtMenuLabel
	call WriteString
	mov edx,offset txtOp1
	call WriteString
	mov edx,offset txtOp2
	CALL WriteString
	mov edx,offset txtOp3
	call WriteString
	mov edx,offset txtOp4
	call WriteString
	mov edx,offset txtOp5
	call WriteString
	mov edx,offset txtOp6
	call WriteString
	mov edx,offset txtOp7
	call WriteString
	mov edx,offset txtOp8
	call WriteString
	mov edx, offset txtOp9
	call WriteString
	mov edx, offset txtInputOption
	call WriteString
	call ReadInt
	mov menuChoice, eax
	ret
DisplayMenu endp

XANDY proc
	call Clrscr
	mov edx, offset XANDYTitle 
	call WriteString
	mov edx,offset askXVal
	call WriteString
	call ReadInt
	mov ebx, eax
	mov edx,offset askYVal
	call WriteString
	call ReadInt
	AND eax,ebx
	mov edx,offset solution
	call WriteString
	call WriteInt
	call Crlf
	call WaitMsg
	ret

XANDY endp
XORY proc
call Clrscr
	mov edx, offset XORYTitle 
	call WriteString
	mov edx,offset askXVal
	call WriteString
	call ReadInt
	mov ebx, eax
	mov edx,offset askYVal
	call WriteString
	call ReadInt
	OR eax,ebx
	mov edx,offset solution
	call WriteString
	call WriteInt
	call Crlf
	call WaitMsg
	ret

XORY endp
NOTX proc
call Clrscr
	mov edx, offset NOTYTitle 
	call WriteString
	mov edx,offset askYVal
	call WriteString
	call ReadInt
	not eax	
	neg eax
	mov edx,offset solution
	call WriteString
	call WriteInt
	call Crlf
	call WaitMsg
	ret

NOTX endp
XXORY proc
call Clrscr
	mov edx, offset XXORYTitle 
	call WriteString
	mov edx,offset askXVal
	call WriteString
	call ReadInt
	mov ebx, eax
	mov edx,offset askYVal
	call WriteString
	call ReadInt
	XOR eax,ebx
	mov edx,offset solution
	call WriteString
	call WriteInt
	call Crlf
	call WaitMsg
	ret
XXORY endp
XAND_OPY proc ;USES eax ebx edx
	call Clrscr
	mov edx,offset XAND_OPYTitle
	call WriteString
	mov edx,offset askXVal
	call WriteString
	call ReadHex
	mov ebx, eax
	mov edx,offset askYVal
	call WriteString
	call ReadHex
	AND eax,ebx
	mov edx,offset solution
	call WriteString
	call WriteHex
	call Crlf
	call WaitMsg
	ret
XAND_OPY endp
XOR_OPY proc

call Clrscr
	mov edx,offset XOR_OPYTitle
	call WriteString
	mov edx,offset askXVal
	call WriteString
	call ReadHex
	mov ebx, eax
	mov edx,offset askYVal
	call WriteString
	call ReadHex
	or eax,ebx
	mov edx,offset solution
	call WriteString
	call WriteHex
	call Crlf
	call WaitMsg
	ret
XOR_OPY endp
XNOT_OPY proc
mov edx,offset NOT_OPYTitle
	call WriteString
	
	
	mov edx,offset askYVal
	call WriteString
	call ReadHex
	NOT eax
	mov edx,offset solution
	call WriteString
	call WriteHex
	call Crlf
	call WaitMsg
	ret

XNOT_OPY endp
XXOR_OPY proc
call Clrscr
	mov edx,offset XXOR_OPYTitle
	call WriteString
	mov edx,offset askXVal
	call WriteString
	call ReadHex
	mov ebx, eax
	mov edx,offset askYVal
	call WriteString
	call ReadHex
	xor eax,ebx
	mov edx,offset solution
	call WriteString
	call WriteHex
	call Crlf
	call WaitMsg
	ret

XXOR_OPY endp
ExitProgram proc
INVOKE ExitProcess,0
ExitProgram endp
end main