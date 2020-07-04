;Week 7 Assignment 1
;Rian Booyer
;CISS 360 ADE
COMMENT	~
FindLargest Procedure
Create a procedure named FindLargest that receives two parameters: a pointer to a signed
doubleword array, and a count of the array’s length. The procedure must return the value of
the largest array member in EAX. Use the PROC directive with a parameter list when declaring
the procedure. Preserve all registers (except EAX) that are modified by the procedure.
Write a test program that calls FindLargest and passes three different arrays of different
lengths. Be sure to include negative values in your arrays. Create a PROTO declaration for
FindLargest.
~
INCLUDE Irvine32.inc

FindLargest PROTO,
	passedArray: PTR DWORD,
	arraySize: DWORD
.data
;numArray DWORD 50h, 120h, 110h, 75h, 150h, 201h, 801h ,0h	;maybe create random number array
numArray DWORD -10d,50h, 120h, 110h, 75h, 150h, 201h, 801h ,0h 
numArrayLength DWORD ?
largest DWORD ?
largestMessage byte "The largest number in the array is:",0
orMessage byte " or ",0
hexMessage byte " hex",13,10,0

.code
main PROC 
	; clearing stuff for debugging only
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	
	mov numArrayLength, LENGTHOF numArray					; Store length of array into variable
	push edx ;preserve edx since invoke widens the arguments before it pushes them onto the stack (both eax and edx)
	INVOKE FindLargest, ADDR NumArray, numArrayLength		; call find largest and pass array and array length to it
	pop edx ; restore edx

	;start output to screen
	mov edx, offset largestMessage
	call WriteString
	call WriteDec
	mov edx, offset orMessage
	call WriteString
	call WriteHex
	mov edx,offset hexMessage
	call WriteString
	call Crlf
	call WaitMsg


	exit
main ENDP

FindLargest PROC,
	passedArray: PTR DWORD,
	arraySize: DWORD
	
	mov esi, passedArray		;moves passed array pointer to esi
	mov ecx, arraySize			;moves the array size into counter
	mov eax, [esi]				;moves the offset of esi into eax
	dec ecx					;decrements counter
	
procArray:					;loop for processing the array
	add esi, 4				;adds 4 to esi to move through the array
	mov ebx, [esi]				;moves current value of esi to ebx for comparison

	cmp ebx, eax				;compares eax and ebx
	JLE NGT					;if eax is lower than ebx then jump to ngt and loop back to keep processing

	mov eax, ebx				;if ebx is higher store it onto eax
NGT:
	loop procArray				;loop back for processing array
	ret
FindLargest ENDP
end main