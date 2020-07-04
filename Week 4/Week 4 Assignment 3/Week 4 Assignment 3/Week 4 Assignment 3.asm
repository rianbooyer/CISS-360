;Week # Assignment #
;Rian Booyer
;CISS 360 ADE
COMMENT ~
8. Color Matrix
Write a program that displays a single character in all possible combinations of foreground and
background colors (16 x 16 = 256). The colors are numbered from 0 to 15, so you can use a
nested loop to generate all possible combinations.
~

INCLUDE Irvine32.inc
.data
prompt1 DWORD 'A'

.code
main PROC

	mov  ecx,16	; sets ecx to 16 for the L1 Loop counter

	L1:	
		push ecx		;Pushes the L1 counter onto the stack so it can be retrieved later
		mov  ecx,15	;Sets the value of ecx to 16 for the L2 counter

			L2:	
					pop  eax		;pops the L2 counter off the stack and stores in eax
					push eax		;Saves the counter onto the stack
					rol  eax,4	; sets AL for the background color
					add  eax,ecx	; adds the inner loop counter of ECX
					sub  eax,1	; sets AL for the foreground color
					call SetTextColor
					;mov  edx,offset prompt	;calls prompt to display a (setup as string but could be a char)
					;call WriteString
					mov eax,prompt1		;moves character value from prompt1 to eax for writechar display on screen
					call WriteChar
			Loop L2

		call Crlf		; new line

		pop  ecx		;retrieves counter varaible from stack
	Loop L1

	mov  eax,white + (black * 16)	;resets the color
	call SetTextColor	
	
	

	
					
	INVOKE ExitProcess,0
main endp
end main