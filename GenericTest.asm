; NeoPixelCoordinateConverterTest.asm

; Collection of subroutines and useful code

ORG 0
Start:

	IN		Switches		; Get value from the switches
	OUT		LEDs

	
	JUMP	Start
	
DelayAC:
	STORE  DelayTime   ; Save the desired delay
	OUT    Timer       ; Reset the timer
WaitingLoop:
	IN     Timer       ; Get the current timer value
	SUB    DelayTime
	JNEG   WaitingLoop ; Repeat until timer = delay value
	RETURN
DelayTime: DW 0

; Test coordinates
colrow15_2:		DW &H02F
count:			DW 0

; IO address constants
Switches:  EQU &H000
LEDs:      EQU &H001
Timer:     EQU &H002
Hex0:      EQU &H004
Hex1:      EQU &H005
NPConverter: EQU &H0F0
NPController: EQU &H0F7