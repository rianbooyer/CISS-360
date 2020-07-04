;Week 8 Assignment 1
;Rian Booyer
;CISS 360 ADE
COMMENT ~
Str_concat Procedure
Write a procedure named Str_concat that concatenates a source string to the end of a target
string. Sufficient space must exist in the target string to accommodate the new characters. Pass
pointers to the source and target strings. Here is a sample call:
.data
targetStr BYTE "ABCDE",10 DUP(0)
sourceStr BYTE "FGH",0
.code
INVOKE Str_concat, ADDR targetStr, ADDR sourceStr
~

INCLUDE Irvine32.inc
COMMENT ~
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
~
Str_concat PROTO,
	src:ptr BYTE,
	tgt:ptr byte,
	sCnt:dword,
	tCnt:dword
.data
targetStrMsg byte "Target String Is: ",0
sourceStrMsg byte "Source String Is: ",0
resultMsg byte "Result of Target Is: ",0
targetStr BYTE "ABCDE",10 DUP(0)
sourceStr BYTE "FGH",13,10,0

.code
main PROC
	;beginning display
	mov edx, offset targetStrMsg
	call WriteString
	mov edx, offset targetStr
	call WriteString
	call Crlf
	mov edx, offset sourceStrMsg
	call WriteString
	mov edx, offset SourceStr
	call WriteString
	;invoke str_concat
	INVOKE Str_concat, ADDR sourceStr, ADDR targetStr,LENGTHOF sourceStr, LENGTHOF TargetStr
	;display results
	mov edx, offset resultMsg
	call WriteString
	mov edx, offset targetStr
	call WriteString
	call Crlf
	call WaitMsg

exit
main ENDP

Str_concat PROC USES eax ecx esi edi,
		src:PTR BYTE, 
		tgt:PTR BYTE, 
		sCnt:dword,
		tCnt:dword
	mov ecx,sCnt			;move length of source to ecx for counter
	mov edx,tCnt			;move length of target to edx for use later


	mov esi, src			;move source to esi for movsb
	mov edi, tgt			;move target to edi for same

L1:
	mov dl, [edi]			;mov value of edi to dl for comparison
	cmp dl, 0				;compare value of dl to 0 if they are not equal jump to l2 for increment untill found
	jne L2	
	je L3				;jump if equal to start concatenating the strings so that the end of one string matches beginning of the other
	loop L1
L2:
	inc edi				;increment edi
	loop L1
L3:
	mov ecx,sCnt			;move count of source to ecx
	cld					;forward
	rep movsb				;copy the strings together
ret
Str_concat ENDP

END main