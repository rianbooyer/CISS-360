;Week # Assignment #
;Rian Booyer
;CISS 360 ADE
COMMENT ~
;assignment details go here
~

INCLUDE Irvine32.inc
COMMENT ~
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
~


.data

.code
main proc
	
	

					
	INVOKE ExitProcess,0
main endp
end main