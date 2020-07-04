;Week 7 Assignment 2
;Rian Booyer
;CISS 360 ADE
COMMENT ~
Chess Board
Write a program that draws an 8 x8 chess board, with alternating gray and white squares. You
can use the SetTextColor and Gotoxy procedures from the Irvine32 library. Avoid the use of global
variables, and use declared parameters in all procedures. Use short procedures that are
focused on a single task.
~

INCLUDE Irvine32.inc
COMMENT ~
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
~
SetColor PROTO forecolor:BYTE, backcolor: BYTE
WriteColorChar PROTO char:BYTE, forecolor:BYTE, backcolor:BYTE
OddRow PROTO color:BYTE
EvenRow PROTO color:BYTE

.data
rows = 8
col = 8
hChars = 2

.code
main PROC
    mov ecx, rows / hChars	;number of chars per row to ecx counter
L1:
    INVOKE OddRow, gray		;call oddrow with the value of grey
    call Crlf
    INVOKE EvenRow, gray		;call evenrow with value of gray
    call Crlf
    loop L1

    INVOKE SetColor, lightGray, black ; return to normal color
    call Crlf

    exit
main ENDP

;OddRow receives the color passed, sets a loop counter, and calls a loop to write
;the row colors to the screen
OddRow PROC uses ecx, color:BYTE	
    mov ecx, col / hChars	;move the number of chars per column to ecx for counter
L1:
	;calls the writeColorChar to actually print the chars on screen
    INVOKE WriteColorChar, ' ', color, color
    INVOKE WriteColorChar, ' ', color, color
    INVOKE WriteColorChar, ' ', white, white
    INVOKE WriteColorChar, ' ', white, white
    loop L1

    ret
OddRow ENDP

;Even Row - same as oddrow but switches the colors around to match a chessboard layout
EvenRow PROC uses ecx, color:BYTE
    mov ecx, col / hChars
L1:
    INVOKE WriteColorChar, ' ', white, white
    INVOKE WriteColorChar, ' ', white, white
    INVOKE WriteColorChar, ' ', color, color
    INVOKE WriteColorChar, ' ', color, color
    loop L1

    ret
EvenRow ENDP

;WriteColorChar - sets the forecolor ang back color to what is passed then moves the char passed
;to al for writechar to write the space to the screen in the correct colors can be used 
;with grey or white
WriteColorChar PROC USES eax, char:BYTE, forecolor:BYTE, backcolor:BYTE 
    INVOKE SetColor, forecolor, backcolor
    mov al, char
    call WriteChar

    ret
WriteColorChar ENDP

;SetColor receives the forecolor and back color. moves the backcolor to eax shifts it left by 4 
;then stores the forecolor into al for setTextColor from irvine
SetColor PROC, forecolor:BYTE, backcolor:BYTE
    movzx eax, backcolor
    shl eax, 4
    or al, forecolor
    call SetTextColor       
    ret
SetColor ENDP
END MAIN