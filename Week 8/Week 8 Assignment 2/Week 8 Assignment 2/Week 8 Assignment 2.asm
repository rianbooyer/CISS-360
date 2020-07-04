;Week 8 Assignment 2
;Rian Booyer
;CISS 360 ADE
COMMENT ~
Str_remove Procedure
Write a procedure named Str_remove that removes n characters from a string. Pass a pointer to
the position in the string where the characters are to be removed. Pass an integer specifying the
number of characters to remove. The following code, for example, shows how to remove “xxxx”
from target:

~

INCLUDE Irvine32.inc
COMMENT ~
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
~
Str_Remove PROTO, 
		tgt:ptr byte, 
		cnt:dword

My_Str_Trim PROTO,
	arrPtr: ptr byte,
	TempArray:ptr byte,
	arrLen:dword


.data
strOrig byte "Original string is: ",0
strResult byte "Result String: ",0
target BYTE "abcxxxxdefghijklmnopqrstuvwxyz",13,10,0
tempString byte 30 dup(0)
.code
main proc
	
	mov edx, offset strOrig
	call WriteString
	mov edx, offset target
	call WriteString
	call Crlf	;add extra line break
	invoke Str_Remove, addr[target+3],4	;calls string remove with the 3rd element of the target string and 4 to remove the following 4 elements
	invoke My_Str_Trim, addr[target],addr[tempString],LENGTHOF target ;invokes my_Str_Trim to trim out the middle spaces

	;display
	mov edx,offset strResult
	call WriteString
	mov edx, offset tempString
	call WriteString
	call Crlf
	call WaitMsg

					
	INVOKE ExitProcess,0
main endp

Str_Remove PROC, 
	targt:ptr BYTE,
	cnt: dword
	;clear for easy debugging
	mov ecx, 0
	mov eax,0

	mov ecx, cnt ;set counter to passed number of chars to remove
	mov eax, targt ;moves the address in target to eax
L1:
	mov byte ptr [eax],1	;since it starts at a predeturmined element move 1 to that element
	inc eax				;increment eax
	loop L1				;loop to replace remaining elements from count (cnt) with 1's
	
ret
Str_Remove endp

;My_Str_Trim 
;receives an array pointer to the original string, pointer to the temp string, and the length of the original string
;then moves through string looking for the 1's placed durring the Str_Remove procedure. If it doesn't find a 1 it copies
;the element of the original string to the tempString, if it finds a 1 it increments the original string untill the element
;does not equal 1 then continues copying elements
My_Str_Trim proc,
	arrPtr: ptr byte,
	TempArray:ptr byte,
	arrLen:dword
	mov ecx, 0
	mov eax, 0
	mov ebx, 0

	mov ecx,arrLen			;move arrLen as counter
	mov eax, arrPtr		;move original string ptr to eax
	mov ebx,TempArray		;move tempArray (Temp String) ptr to ebx

M1:
	mov dl, [eax]			;moves value of eax to dl
	cmp dl,1				;compares dl and 1
	je M2				;if they equal it jumps to m2 to increment eax and loop back
	mov [ebx],dl			; if it doesn't equal 1 it copies dl into the element in ebx
	inc eax				;increment eax to next element
	inc ebx				;increment ebx to next element
	loop M1				;loop to m1 to analyze and process next set of elements
	jmp M3				;jumps to m3 which ends procedure
M2:
	inc eax				;increments eax if 1 is found in m1
	LOOP M1				;loops back to m1
M3:						;label to jump to end trimm
	ret
My_Str_Trim endp
end main