;Week 2 Assignment 3
;Rian Booyer
;CISS 360 ADE
COMMENT ~
3. Data Definitions
Write a program that contains a definition of each data type listed in Table 3-2 in Section 3.4.
Initialize each variable to a value that is consistent with its data type.
~

;INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD



.data

myByte BYTE 234					;0 to 255
mySbyte SBYTE -120					;-128 to 127
myWord WORD 65532					;0 - 65535
mySword SWORD -22020				; -32,768 to 32,767
myDword DWORD 4200000000				;0 to 4294967295 
mySdword SDWORD -2100000000			;-2147483648 to 2147483647
myFword FWORD 1C1162072205h			;48 bit - 2E+48
myQword QWORD 6A82111EB7C20A95h		;64 bit - 2E+64
myTbyte TBYTE 0EB211111111118B0F400h	; 80 bit - 2E+80
myReal4 REAL4 -1.34					;32 bit (4 byte) IEEE short real
myReal8 REAL8 4.3E-10				; 64-bit (8 byte) IEEE long real
myReal10 REAL10 4.1E+4096			;80-bit (10 byte) IEEE extended real


.code
main proc
	mov al,myByte
	mov al,mySbyte
	mov ax,myWord
	mov ax,mySword
	mov eax,myDword
	mov eax,mySdword
	mov eax,myReal4
	;don't know yet how to deal with numbers bigger than 32 bit i know they have to be split into upper or lower or multiple 32 bit
					
	INVOKE ExitProcess,0
main endp
end main