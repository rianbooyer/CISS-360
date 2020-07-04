;Week 5 Assignment 1
;Rian Booyer
;CISS 360 ADE
COMMENT ~
Filling an Array
Create a procedure that fills an array of doublewords with N random integers, making sure the
values fall within the range j...k, inclusive. When calling the procedure, pass a pointer to the
array that will hold the data, pass N, and pass the values of j and k. Preserve all register values
between calls to the procedure. Write a test program that calls the procedure twice, using different
values for j and k. Verify your results using a debugger.
~

INCLUDE Irvine32.inc
COMMENT ~
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
~


.data
randArray DWORD ?				;setup variable with nothing for array
;randArray DWORD 10 dup(?)
nVar DWORD ?					;Number of array elements
jVar DWORD ?					;low number

kVar DWORD ?					;high number

;prompts
promptOriginal byte "Original, j is 50, k is 100, n is 10",13,10,0
test1 byte "Test 1 ja is 500, k is 2000, n is 10",13,10,0
test2 byte "Test 2, j is 10,000, k is 100,000, n is 5",13,10,0
.code
main proc
	
	mov edx, offset promptOriginal	;stores offset of prompt original message to edx for writestring
	call WriteString	
	
	mov nVar,10d
	mov jVar,50d
	mov kVar,100d
	mov ecx,nVar				;stores value of nVar into ecx
	mov edx,offset randArray		;restore randArray offset to edx
	pusha					;store registers to stack
	call randArrayAssign
	popa						;restore registers
	call DisplayArray			;displays the array to screen
		
						
	;test 1
	mov edx, offset test1		;store offset of test 1 string to edx for writestring
	call WriteString

	mov jVar,500d				;store variables
	mov kVar,2000d
	mov nVar, 10d
	mov ecx, nVar				;stores nVar into ecx counter
	mov edx, offset randArray	;restore offset of randArray to edx

	pusha					;store registers to stack
	call randArrayAssign		;call randArrayAssign again
	popa						;store registers to stack
	call DisplayArray			;displays the array to screen
	
	;test 2
	mov edx, offset test2		;store offset of test 2 string to edx for writestring
	call WriteString
	
	mov jVar,10000d			;store variable values
	mov kVar,100000d
	mov nVar, 5d
	mov ecx,nVar				;store nVar in ecx
	mov edx, offset randArray	;restore offset of randArray to edx
	pusha					;store registers to stack
	call randArrayAssign		;call randArrayAssign again
	popa						;restores registers from stack
	call DisplayArray			;displays the array to screen
	call WaitMsg				
					
	INVOKE ExitProcess,0
main endp

randArrayAssign proc
	call Randomize				;set the seed
	mov esi, 0				;set esi to 0 for array traversal
	mov eax, kVar				;set eax to kVar for randomRange
	mov ebx, jVar				;set value of jVar to ebx and comp operations
	push eax					;push eax to stack
	mov ecx, eax				; had to add this for problems with eax being modified without warning
rep1:
	
	push ebx					;pushes ebx to stack
	mov eax,ecx				;restores eax from ecx
	call RandomRange			;generate random number
	
	cmp eax, ebx				;compares eax to ebx
	pop ebx					;restores ebx from stack
	jl rep1					;jumps to rep1 if eax is lower than ebx
	
	
	mov [edx], eax				;move random number from eax to first position of array
	add esi, 4				;increment esi by 4 to move to second position
	dec nVar					;since the first element is populated add 4
	mov ecx,nVar				;since the first element is populated remove 1 from N
	
	pop eax					;restore eax
L1:
	push eax					;stores eax to stack
	push ebx					;pushes value of eax to stack which is value of kVar this prevents modification of the upper range by loop
	push ecx					;stores ecx to stack
	mov ecx,eax				;same as above for restore of eax later because of unwanted modification after 3 loops
			rand2:
				push ebx			;stores ebx on stack
				mov eax,ecx		;restores eax value from ecx
				call RandomRange	;calls RandomRange for range between 0 and 100
				cmp eax, ebx		;comparison
				pop ebx			;restores ebx
				jl rand2			;jumps to rand2 if value is less than ebx
	
	mov [edx + esi],eax			;move random number generated to edx at position esi
		
	add esi, 4				;increments through the list
	
	pop ecx					;restores ecx counter
	pop ebx					;restores ebx low end value
	pop eax					;restores eax with kVar value
	loop L1					;returns back to L1 as long as counter is not 0
	
	ret						;returns from procedure
randArrayAssign endp

;display array outputs the array results to the screen by moving through the randArray and calling WriteInt
DisplayArray proc USES ecx
mov edx, offset randArray
mov esi,0
;mov ecx, nVar	; can't use for some reason nVar changes durring random number assignment
mov eax, [edx]
call WriteInt
call Crlf
add esi,4
dec ecx
L1:
	mov eax, [edx + esi]
	call WriteInt
	call Crlf
	add esi,4
loop L1
	
ret
DisplayArray endp
end main