; Simple test for the NeoPixel peripheral

ORG 0
Start:

	IN		Switches					; Get value from the switches
	OUT		LEDs
	IN		NPGameController
	OUT		Hex0
	
	ADD		count
	STORE	count
	OUT		Hex0
	
	LOADI	5
	CALL	DelayAC
	OUT		NPGameController
	
	
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
Switches:  EQU 000
LEDs:      EQU 001
Timer:     EQU 002
Hex0:      EQU 004
Hex1:      EQU 005
PXL_A:     EQU &H0B0
PXL_RGB:   EQU &H0B1
PXL_ALL:   EQU &H0B2
PXL_R:     EQU &H0B3
PXL_G:     EQU &H0B4
PXL_B:     EQU &H0B5

NPGameController: EQU &H0F7
