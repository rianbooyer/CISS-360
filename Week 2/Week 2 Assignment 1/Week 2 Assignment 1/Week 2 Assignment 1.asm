;Week 2 Assignment 1
;Rian Booyer
;CISS 360 ADE

;INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD



.data
Mysum DWORD 0		;Mysum variable declaration for final store of result

.code
main proc
	mov eax,5		;move 5 onto eax register
	mov ebx,10	;move 10 onto ebx register
	mov ecx,3		;move 3 onto ecx register
	mov edx,2		;move 2 onto edx register
	add eax,ebx	;adds ebx to eax and stores in eax
	add ecx,edx	;adds edx to ecx and stores in ecx
	sub eax,ecx	;subtracts ecx from eax and stores into eax
	mov Mysum,eax	;moves value stored in eax to Mysum (should be 10)

					
	INVOKE ExitProcess,0
main endp
end main