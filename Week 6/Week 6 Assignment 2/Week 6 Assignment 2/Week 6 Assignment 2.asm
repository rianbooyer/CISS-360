;Week 6 Assignment 2
;Rian Booyer
;CISS 360 ADE
COMMENT ~
Prime Numbers
Write a program that generates all prime numbers between 2 and 1000, using the Sieve of Eratosthenes
method. You can find many articles that describe the method for finding primes in this
manner on the Internet. Display all the prime values.
{2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67,
  71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 
 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229,
  233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 
 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401,
  409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 
 491, 499, 503, 509, 521, 523, 541, 547, 557, 563, 569, 571, 577, 587, 593, 
 599, 601, 607, 613, 617, 619, 631, 641, 643, 647, 653, 659, 661, 673, 677,
  683, 691, 701, 709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773, 
 787, 797, 809, 811, 821, 823, 827, 829, 839, 853, 857, 859, 863, 877, 881,
  883, 887, 907, 911, 919, 929, 937, 941, 947, 953, 967, 971, 977, 983, 991, 997}
~
Include Irvine32.inc

;some constants
n=1000
n_terminal=31
    

.data
prime BYTE n DUP(?)

.code
main PROC
    ; fill array with 1's
    mov   edi,OFFSET prime+2
    mov   ecx,n-2		;set counter to 998 instead of 1000
    mov   eax,1		;set eax to 1
    rep stosb			;repeat and store string bytes
    
    mov   WORD PTR [prime],cx   ;cx is 0
    mov   esi,eax		; esi=1 loop starts at 1
L1:
    inc   esi			; move to next number
    cmp   esi,n_terminal
    ja    L3			;if above jump to l3
    cmp   prime[esi],al	
    jne   L1			;if the cmp is not equal it's not a prime 
    
    mov   edi,esi		
    imul  edi,edi		
L2:
    cmp   edi,n		;check edi if it is larger than n (31)
    jae   L1			; if above or equal jump back to l1
    mov   prime[edi],ah	; set to 0 or non prime number
    add   edi,esi		; add esi to edi
    jmp   L2

L3:
   
    mov   esi,eax       
PL:	;print the primes
    inc   esi			; make sure esi doesn't go over n
    cmp   esi,n
    jae   Lend			;if n is over esi go to lend (end)
    cmp   BYTE PTR prime[esi],1 ; eax/al is modified from "WriteDec"
    jne   PL   ;if not a prime loop back untill it is
    ; Print Primes
    mov   eax,esi
    call  WriteDec     ;output decimal
    call  Crlf
    jmp   PL

Lend:
	call WaitMsg
	INVOKE ExitProcess,0
main ENDP
END main