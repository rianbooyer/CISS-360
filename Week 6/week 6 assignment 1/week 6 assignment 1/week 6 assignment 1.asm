;Rian Booyer
;Week 6 Assignment 1

comment ~
Write a procedure that performs simple encryption by rotating each plaintext byte a varying
number of positions in different directions. For example, in the following array that represents
the encryption key, a negative value indicates a rotation to the left and a positive value indicates
a rotation to the right. The integer in each position indicates the magnitude of the rotation:
key BYTE -2, 4, 1, 0, -3, 5, 2, -4, -4, 6
Your procedure should loop through a plaintext message and align the key to the first 10 bytes of
the message. Rotate each plaintext byte by the amount indicated by its matching key array value.
Then, align the key to the next 10 bytes of the message and repeat the process. Write a program
that tests your encryption procedure by calling it twice, with different data sets.
~
Include Irvine32.inc
.386
.data
convertString BYTE "Hello My Name Is Rian", 0
key BYTE -2, 4, 1, 0, -3, 5, 2, -4, -4, 6
msgEncrypted byte "Encrypted",13,10,0
msgDecrypted byte "Decrypted",13,10,0
.code
main proc
mov eax, 0
mov ecx, SIZEOF convertString		;pass the array size as counter initializer
mov edx, OFFSET ConvertString		;pointer to the string to convert
mov esi, OFFSET key				;pointer to the key array
mov ebx, 0					;for use as a central position for comparison

call WriteString				;to display the string
call Crlf

call EncDec					;encrypt

call WriteString				;Display encoded string
call crlf

mov ebx, 1					;Decrypt by forcing one to ebx
call EncDec

call WriteString				;Display decrypted string
call Crlf



	invoke ExitProcess,0
main endp

EncDec proc
pushad
	cmp ebx, 0
	JE L2
		MOV EBX, ESI	
		ADD EBX, 9 ;the length of key
L1: ;decoding loop

		MOV AL, [EDX]			;move value of string into al
		PUSH ECX				;preserve ecx
		MOV CL, [ESI]			;move value of the key to cl
		ROR AL, CL			; Rotate string (char) value of the key
		MOV [EDX], AL			;store new char into edx value
		POP ECX				;restore ecx

		CMP ESI, EBX			;If at the end of the number of keys go to the first reset
		JE reset1
		
		INC ESI				;increments to the next key
		
		JMP endReset1			;jumps past the reset section
	reset1:
		SUB ESI, 9			;moves back to the first key
	endReset1:
		
		INC EDX			;increments edx to next char in string
		loop L1			;loops back to L1 for next char 

		;msg to show it's decrypted
		push edx
		mov edx, offset msgDecrypted
		call WriteString
		pop edx

	JMP EncodeEnd


L2:
	mov ebx, esi
	add ebx, 9			;key length to ebx if key length changes this MUST BE CHANGED
	l2Loop:

		mov al, [edx]		;store the value of the string into al
		push ecx			;preserve ecx
		mov cl, [esi]		;moves the pointer of the key into cl
		rol al,cl			;rotates left by the ammount in the key
		mov [edx], al		;moves the rated value back into edx pointer value
		pop ecx

		cmp esi, ebx		;if keys are used restart at the beginning
		je reset2
		inc esi			;increment esi to move to next key

		jmp endReset2
	reset2:
		sub esi, 9		;moves esi back to the first key number

	endReset2:
		inc edx			;increments edx to next char in string array
	loop l2Loop
	
	push edx
	mov edx, offset msgEncrypted
	call WriteString
	pop edx

EncodeEnd:
popad
ret
EncDec endp
end main