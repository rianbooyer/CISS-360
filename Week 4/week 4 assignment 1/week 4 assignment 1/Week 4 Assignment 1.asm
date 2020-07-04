;Week 4 Assignment 1
;Rian Booyer
;CISS 360 ADE
COMMENT ~
3. Simple Addition (1)
Write a program that clears the screen, locates the cursor near the middle of the screen, prompts
the user for two integers, adds the integers, and displays their sum.
4. Simple Addition (2)
Use the solution program from the preceding exercise as a starting point. Let this new program
repeat the same steps three times, using a loop. Clear the screen after each loop iteration.
~

INCLUDE Irvine32.inc



.data
pMessage BYTE "Please enter and Integer: ",0
pResult BYTE "The sum of the integers is: ",0

.code
main proc
	mov ecx, 3						;sets 3 to ecx for loop counter
	L1:
	call IntSum						;calls InSum procedure to get inputs and display outputs
	call Clrscr						;clears screen adds time for some reason between loops
	loop L1
					
	INVOKE ExitProcess,0
main endp

IntSum PROC 
	mov ebx, 0						;clears ebx not necessary but just wanted to
	mov dh,10		; goes to center of screen
	mov dl,39
	CALL Gotoxy
	mov edx,OFFSET pMessage				;moves offset of message asking for int to edx
	call WriteString					;prints out int message
	call ReadInt						;reads int into eax
	add ebx,eax						;adds new int stored in eax to ebx
	mov dh,11							; goes to center of screen and one row down
	mov dl,39
	CALL Gotoxy
	mov edx,OFFSET pMessage				;moves offset of message asking for int to edx
	call WriteString					;prints out int message
	call ReadInt						;reads int into eax
	add ebx,eax						;adds new int stored in eax to ebx
	
	mov dh,12							; goes to center of screen and two rows down
	mov dl,39
	CALL Gotoxy
	mov edx,OFFSET pResult				;moves offset of result message to edx
	call WriteString					;prints out result message
	mov eax,ebx						;moves result to eax for writeint
	call WriteInt						;writes int to screen after result message
	call Crlf							;line return for display before waitmsg
	mov dh,13							; goes to center of screen and two rows down
	mov dl,39
	CALL Gotoxy
	call WaitMsg
	ret
IntSum endp
end main