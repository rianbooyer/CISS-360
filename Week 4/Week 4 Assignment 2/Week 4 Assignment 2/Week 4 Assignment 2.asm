;Week 4 Assignment 2
;Rian Booyer
;CISS 360 ADE
COMMENT ~
6. Random Strings
Create a procedure that generates a random string of length L, containing all capital letters.
When calling the procedure, pass the value of L in EAX, and pass a pointer to an array of byte
that will hold the random string. Write a test program that calls your procedure 20 times and displays
the strings in the console window.
~

INCLUDE Irvine32.inc

.data
mainPrompt BYTE "Generating and displaying 20 strings: ",13,10,0
L byte 5d												;sets size of string
stringArray byte 5 dup("?")		;creates a byte array of 5 uninitialized 

.code
main proc
	
	mov edx,OFFSET mainPrompt	;move mainprompt array to edx for display with WriteString
	call WriteString
	mov esi,offset stringArray	;creates offset pointer and stores into esi
	mov ecx, 20				;Initialize counter to 20
	L1:
	movzx eax,L				;move value of L to eax before calling procedure (i guess this passes it?)
	call RandomString			;call's RandomString
	loop L1
	
					
	INVOKE ExitProcess,0
main endp


;---------------------------------------------------------
; RandomString
;
;Generates strings of L characters wide and outputs them to
;the screen
; Receives: EAX ECX ESI
; 
; Returns: Nothing, output is to screen
;---------------------------------------------------------
RandomString proc USES ecx eax esi		;randomString process with USES to push and pop ecx counter and eax value and esi 
	mov ecx,eax					;initialize counter with value from eax (5)
	
	L2:
	mov eax,0						;initializes eax to 0 not needed but used for debug
	mov al, 26					;stores the range i want 0 to 26
	call RandomRange				;calls RandomRange 
	add al, 65					;Adds 65 to random range so 0 is A and 25 is Z
	mov [esi]+[ecx-1],al			;for pointer address
	;mov stringArray[ecx-1],al		;moves al onto the string array at index of ecx count - 1 to get correct size of L numbers
	loop L2						;end loop
	;mov edx,OFFSET stringArray		;moves the offset of StringArray to edx for Writestring output to screen
	mov edx,esi		;moves the offset pointed to by esi to edx for WriteString output to screen
	call WriteString
	call Crlf						;newline so all the strings don't appear on the same line
	
		
	ret
RandomString endp
end main