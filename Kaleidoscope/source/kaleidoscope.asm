; I affirm that all code given below was written solely by me, Xavier Betancourt, and that
; any help I received adhered to the rules states for this exam
; Last Modified: 4/21/2020

; Kaleidoscope: Program that loops continuosly and makes an ever-changing random pattern

INCLUDE Irvine32.inc

.data
; definition of the colors used in the program
color DWORD (cyan+(cyan*16)), (blue+(blue*16)), (lightBlue+(lightBlue*16)), (black+(black*16))
      DWORD (lightMagenta+(lightMagenta*16)), (white+(white*16)), (red+(red*16)), (lightRed+(lightRed*16))
	  DWORD (gray+(gray*16)), (green+(green*16)), (brown+(brown*16)), (yellow+(yellow*16))

DefaultColor = lightGray + (black * 16) ; default console window's color

; square string that will be used to print the colors defined above (two spaces that form a square)
square BYTE "  ",0

.code
main PROC
call Randomize ; initialize seed for RandomRange procedure

mov ecx, 0 ; loops INFINITE times
; outer loop prints the kaleidoscopes multiple times
OuterLoop:
mov ecx, 26 ; counter of the loop
	; vertical loop repeats the fillHorizontal process
	vertical:              
	push ecx 
		; fillHorizontal prints the squares and an endl at the end
		call fillHorizontal          
	pop ecx ; decrease the counter
	loop vertical
call clearWindow
loop OuterLoop

main ENDP

;--------------------------------------------------------------------
; setRandomColor
;
; Sets a random color to display the square string using the color
; defined
; Receives: NA
; Returns EAX = random color 
;---------------------------------------------------------------------
setRandomColor PROC
	mov eax, 12 ; for the range (0-11)
	call RandomRange ; pseudorandom integer
	mov eax, color[eax*TYPE color]
	ret
setRandomColor ENDP

;--------------------------------------------------------------------
; fillHorizontal
;
; Fills the colored squares horizontally one by one until the last one
; and then calls an end line to wait for the vertical loop to initialize
; the loop again
; Receives: SetRandomColor PROC
; Returns: NA
;---------------------------------------------------------------------
fillHorizontal PROC
	mov ecx, 25 ; number of squares in the horizontal line
	horizontal:
		call setRandomColor ; gets the eax with the color chosen
		call SetTextColor
		mov	edx,OFFSET square
		call WriteString ; write the square string with the random color
	loop horizontal
	call crlf ; endl and repeat vertical loop
	ret
fillHorizontal ENDP

;--------------------------------------------------------------------
; clearWindow
;
; Reestablishes the default of the console window clearing the screen
; with the kaleidoscope. It also delays the window so the user can see
; the kaleidoscope for more time until it gets updated
;
; Receives: NA
; Returns: NA
;---------------------------------------------------------------------
clearWindow PROC
	mov eax, 1000 ; 1000ms 
	call Delay ; delay the next operation
	mov eax, DefaultColor ; set the screen's default color
	call SetTextColor
	call Clrscr ; clear the contents of the screen
	ret
clearWindow ENDP
END main