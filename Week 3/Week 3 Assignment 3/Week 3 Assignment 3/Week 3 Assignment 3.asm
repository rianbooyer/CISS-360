;Week 3 Assignment 3
;Rian Booyer
;CISS 360 ADE
COMMENT ~
;assignment details go here
7. Copy a String in Reverse Order
Write a program with a loop and indirect addressing that copies a string from source to target,
reversing the character order in the process. Use the following variables:
source BYTE "This is the source string",0
target BYTE SIZEOF source DUP('#')

- found writestring from http://programming.msjc.edu/asm/help/index.html?page=source%2Fabout.htm
~

INCLUDE Irvine32.inc
COMMENT ~
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
~


.data
source BYTE "This is the source string",0
target BYTE SIZEOF source DUP('#')				; to get rid of the # at the end it needs to be: target BYTE SIZEOF source - 1 DUP('#')
newline BYTE ' ',13,10,0						;same functionality would work if source was: source BYTE "This is the source string",13,10,0
.code
main proc
		mov edx, OFFSET source				;moves the offset of source to edx for writestring (still trying to understand why edx but must be something in the inc)
		call WriteString					;calls irvine writestring to output the source string to screen
		mov edx, OFFSET newline				;moves the offset of newline to edx this gives me a newline without editing source
		call WriteString					;outputs newline array to screen
		
		;begin of reversal process		
		mov esi,0							;initializes esi to 0
		mov edi,LENGTHOF source - 2			;initializes edi with the length of source - 2
       	mov ecx,SIZEOF source				;stores the sizeof source in ecx for use as a counter
    L1:									;begin loop
		mov al,source[esi]					;stores value of source at position from esi which is incremented later
		mov target[edi],al					;stores the value stored from previous statement in al to target array at position from edi
		inc esi							;increments esi to next position
		dec edi							;decrements edi for position change
		loop L1							;loops to L1
		mov edx, OFFSET target				;moves the offset of target to edx for output to screen using writestring
		call WriteString					;output reverse string to screen although it has the # at the end from dup('#')
		
	

					
	INVOKE ExitProcess,0
main endp
end main