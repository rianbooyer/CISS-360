;Week 5 Assignment 2
;Rian Booyer
;CISS 360 ADE
COMMENT ~
College Registration
Using the College Registration example from Section 6.7.3 as a starting point, do the following:
• Recode the logic using CMP and conditional jump instructions (instead of the .IF and
.ELSEIF directives).
• Perform range checking on the credits value; it cannot be less than 1 or greater than 30. If an
invalid entry is discovered, display an appropriate error message.
• Prompt the user for the grade average and credits values.
• Display a message that shows the outcome of the evaluation, such as “The student can register”
or “The student cannot register”.
(The Irvine32 library is required for this solution program.)
~

INCLUDE Irvine32.inc
COMMENT ~
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
~


.data

gradeAverage  DWORD 275	; test value
credits       DWORD 12	; test value
promptGradeAverage byte "What is the grade average of the student: ",0
promptCreditsValue byte "How many credits does the student have: ",0
creditsInvalid byte "You have entered a value outside of range. Range is 1 to 30",13,10,0
regYes byte "The student can register.",13,10,0
regNo byte "The student cannot register at this time.",13,10,0
creditsLowVal equ 0
creditsHighVal equ 30

.code
main proc
	;mov OkToRegister,FALSE
	;IF gradeAverage > 350
	;   mov OkToRegister,TRUE
	;ELSEIF (gradeAverage > 250) && (credits <= 16)
	;   mov OkToRegister,TRUE
	;ELSEIF (credits <= 12)
	;   mov OkToRegister,TRUE
	;ENDIF

	;prompt for grade average
	mov edx, offset promptGradeAverage
	call WriteString
	CALL ReadInt
	mov gradeAverage, eax	;moves readint (eax) into gradeAverage for storage

	
CredCheck:				;return if not in range
			;prompt for credits
	mov edx, offset promptCreditsValue
	call WriteString
	call ReadInt
	mov credits, eax

	;check credit values 1 to 30

		;check if greater than 1
		
		cmp eax,CreditsLowVal
		jbe CredInvalid
		
		;check if less than 30
		
		
		cmp eax,CreditsHighVal
		jg CredInvalid			;give error if greater than 30
		jbe CheckOK
	
CredInvalid:
	push edx
	mov edx, offset creditsInvalid
	call WriteString
	call WaitMsg
	call Crlf
	jmp CredCheck				;jumps back to prompt if the credit values are out of range
	pop edx

CheckOK:
	call IsOk	

					
	INVOKE ExitProcess,0
main endp

;IsOk - checks value sof gradeAverage and credits to make sure it's ok or not to register
IsOk PROC USES eax ebx
	mov eax, gradeAverage			;store gradeAverage in eax for comparison
	mov ebx, credits				;store credits in ebx for comparison
	
	;check if grade average is greater than 350
	cmp eax,350
	ja Procede		;strait to register if above 350
	
	;check if grade average is greater than 250 if so jump to np to check credits <= 16 or
	;jump to NP1 to check if credits are <=12
	cmp eax, 250		
	ja NP
	jmp NP1
	
NP:
	;check if  les than or equal to 16
	cmp ebx,16
	jbe Procede			
	jmp NotProcede
	
NP1:
	cmp ebx,12
	jbe Procede
	jmp NotProcede
	

Procede: 
call RegisterOk

NotProcede: 
call RegisterNOK



ret
IsOk endp

;RegisterOK - calls the message to display if it's ok to register then exits the program
RegisterOk PROC 

	mov edx, offset regYes
	call WriteString 
	call WaitMsg
	call Crlf
	INVOKE ExitProcess,0
RegisterOk endp

;RegisterNOK - calls the message to display if it is not ok to register
RegisterNOK proc ;USES edx
	mov edx, offset regNo
	call WriteString
	call WaitMsg
	call Crlf
	INVOKE ExitProcess,0
RegisterNOK endp
end main