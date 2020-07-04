;Week 2 Assignment 2
;Rian Booyer
;CISS 360 ADE
COMMENT ~
2. Symbolic Integer Constants
Write a program that defines symbolic constants for all seven days of the week. Create an array
variable that uses the symbols as initializers.
~

;INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD



.data

;following define symbolic constants using =
Monday = 0
Tuesday = 1
Wednesday = 2
Thursday = 3
Friday = 4
Saturday = 5
Sunday = 6

daysOfWeek DWORD Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday ;creates an array variable of symbolic constants


.code
main proc
	
	;i don't know yet how to test this any suggestions would be appreciated.

					
	INVOKE ExitProcess,0
main endp
end main