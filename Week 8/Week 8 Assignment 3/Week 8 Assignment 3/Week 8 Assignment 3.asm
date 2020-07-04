;Week 8 Assignment 3
;Rian Booyer
;CISS 360 ADE
COMMENT ~
Str_nextWord Procedure
Write a procedure called Str_nextWord that scans a string for the first occurrence of a certain
delimiter character and replaces the delimiter with a null byte. There are two input parameters: a
pointer to the string and the delimiter character. After the call, if the delimiter was found, the Zero
flag is set and EAX contains the offset of the next character beyond the delimiter. Otherwise, the
Zero flag is clear and EAX is undefined. The following example code passes the address of target
and a comma as the delimiter:
.data
target BYTE "Johnson,Calvin",0
.code
INVOKE Str_nextWord, ADDR target, ','
jnz notFound
~

INCLUDE Irvine32.inc
COMMENT ~
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
~

Str_nextWord PROTO,
	targetStr: ptr byte,
	char1:byte
.data
origStrMsg byte "The original string is: ",0
target BYTE "Johnson,Calvin",0
notFoundStr byte "Delimiter NOT found!",13,10,0
saveLocStr byte "Location saved from eax: ",0
saveLocChar byte "Char at location: ",0
delim byte ','
saveLoc dword ?
len DWORD ?
.code
main proc
	mov len, LENGTHOF target
	mov edx, offset origStrMsg
	call WriteString
	mov edx, offset target
	call WriteString
	call Crlf
	INVOKE Str_nextWord, ADDR target, delim
	jnz L1
	jz L2
	
L1:
	mov edx, offset notFoundStr
	call WriteString
	jmp L3

L2:	

	
	mov edx, offset saveLocStr
	call WriteString
	mov eax, saveLoc
	call WriteDec
	call Crlf
	mov edx, offset saveLocChar
	call WriteString
	
	mov edx, offset target
	mov ecx, saveLoc
	mov al, [edx+ecx]
	call WriteChar
	call Crlf
L3:
	call WaitMsg				
	INVOKE ExitProcess,0
main endp

Str_nextWord PROC USES eax ecx esi edi,
	targetStr: ptr byte,
	char1:byte
	
	mov edi, targetStr
	mov al, char1
	mov ecx, len
	cld
	repne scasb		;scans to find if delimiter is found if it is zero is set to 1
	jnz notFound		;jump if not found
	inc ecx			
	mov saveLoc, ecx	;store location of element after null string into saveLoc
	dec edi			;decrement edi
	mov edx, 0		;set null value to edx
	mov [edi],dl		;move null value to element

	;restore values
	mov eax, saveLoc	;store location of next element into eax
	test al,0			;restore zero flag
	
notFound:

	;call dumpregs to show that eax has the next element from the null element and
	;to show that the zero flag is set
	call DumpRegs	
ret


Str_nextWord endp
end main