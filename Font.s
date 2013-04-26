					INCLUDE	"Banks.i"
					INCLUDE	"Font.i"
					INCLUDE	"FontData.i"
					INCLUDE "Hardware.i"
					INCLUDE "Utility.i"
					INCLUDE "Shift.i"


					DT_VARS
PrintCol:			DS	1
PrintRow:			DS	1
VRAMAddr:			DS	2

;********************************************************************
; NAME:	InitFont													*
;																	*
;********************************************************************
					FT_GAME
InitFont:			PUSHBK	BANK(FontData)
					VRAMBANK	0
					LD		E,0
					LD		D,37
					LD		A,$80
					LD		BC,FontData
					CALL	LoadTileData
				; FIX THIS -- the following code can be removed in the final build
				; just set the appropriate condition to 0
;					IF		1
;					VRAMBANK	1
;					LD		E,0
;					LD		D,37
;					LD		A,$88
;					LD		BC,FontData
;					CALL	LoadTileData
;					ENDC
;					CALL	CursorHome
					POPBK
					RET


;********************************************************************
; NAME:	CursorHome													*
;																	*
;********************************************************************
;					FT_GAME
;CursorHome:			PUSH	AF
;					LD		A,0
;					LD		[PrintCol],A
;					LD		[PrintRow],A
;					POP		AF
;					RET


;********************************************************************
; NAME:	CursorRight													*
;																	*
;********************************************************************
;					FT_GAME
;CursorRight:		PUSH	AF
;					LD		A,[PrintCol]
;					INC		A
;					LD		[PrintCol],A
;					POP		AF
;					RET


;********************************************************************
; NAME:	PrintString													*
; I/P:	HL	--	-> null-terminated string							*
;																	*
;********************************************************************
;					FT_GAME
;PrintString:		PUSH	HL										; preserve register
;					PUSH	AF										; preserve register
;.Print:				LD		A,[HL+]									; pick up next character to print
;					OR		A										; test character code
;					JR		Z,.Exit									; is current character == NULL? yes, so end of string, exit function
;					CP		$0D										; is current character == CR?
;					JR		NE,.NotNewline							; no, so try a different character
;					CALL	NewLine									; move cursor to new line
;					JR		.Print									; print next character
;
;.NotNewline:		CP		$0C										; is current character == CLS?
;					JR		NE,.NotHome								; no, so try a different character
;					CALL	CursorHome								; move cursor to home position
;					JR		.Print									; print next character
;
;.NotHome:			CP		$01										; is current character == CURSOR RIGHT?
;					JR		NE,.NotCursorRight						; no, so try a different character
;					CALL	CursorRight								; move cursor one character space right
;					JR		.Print									; print next character
;
;.NotCursorRight:	CALL	PrintChar								; display current character
;					JR		.Print									; print next character
;.Exit:				POP		AF										; restore register
;					POP		HL										; restore register
;					RET												; exit function


;********************************************************************
; NAME:	PrintChar													*
; I/P:	A	-- ASCII code of character to display					*
;																	*
; This function prints a character on the screen. It takes a single	*
; parameter that is the character to be printed. The character must	*
; be one of the printable characters between ASCII code 32 and 126.	*
; The correct VRAM address is calculated from the cursor column &	*
; row.																*
;																	*
;********************************************************************
;					FT_GAME
;PrintChar:			PUSHALL
;					LD		C,A
;					PUSHBK	k_BK_GFX_DATA
;					LD		B,0
;					LD		HL,CharLookup
;					ADD		HL,BC
;					LD		C,[HL]
;
;					LD		A,[PrintRow]
;					LD		E,A
;					LD		D,0
;					SLA16	DE,5
;					LD		A,[PrintCol]
;					ADD		E
;					LD		E,A
;					LD		A,0
;					ADC		D
;					LD		D,A
;					LD		HL,k_VRAM_BG_LOW
;					ADD		HL,DE
;
;					VRAMBANK	1
;.SetPalette1:		WaitForVRAM
;					LD		A,8
;					LD		[HL],A
;
;					VRAMBANK	0
;.SetPalette2:		WaitForVRAM
;					LD		A,C
;					ADD		128
;					LD		[HL],A
;					CALL	CursorRight
;					POPBK
;					POPALL
;					RET


;********************************************************************
; NAME:	GotoXY														*
; I/P:	B	-- column number to move cursor to						*
;		C	-- row number to move cursor to							*
;																	*
; This function moves the cursor the specified column & row number.	*
; It takes two parameters, the column number and row number of the	*
; new cursor position. Range checking is performed to ensure that	*
; the values remain in the VRAM region.								*
;																	*
;********************************************************************
;					FT_GAME
;GotoXY:				PUSH	AF
;					LD		A,B
;					AND		$1F
;					LD		[PrintCol],A
;					LD		A,C
;					AND		$1F
;					LD		[PrintRow],A
;					POP		AF
;					RET


;********************************************************************
; NAME:	NewLine														*
;																	*
; This function moves the cursor to the beginning of the next row.	*
;																	*
;********************************************************************
;					FT_GAME
;NewLine:			PUSH	AF
;					XOR		A
;					LD		[PrintCol],A
;					LD		A,[PrintRow]
;					INC		A
;					LD		[PrintRow],A
;					POP		AF
;					RET


;********************************************************************
; NAME:	LineFeed													*
;																	*
;********************************************************************
;					FT_GAME
;LineFeed:			PUSH	AF
;					LD		A,[PrintRow]
;					INC		A
;					LD		[PrintRow],A
;					POP		AF
;					RET


;********************************************************************
; NAME:	CarriageReturn												*
;																	*
;********************************************************************
;					FT_GAME
;CarriageReturn:		PUSH	AF
;					XOR		A
;					LD		[PrintCol],A
;					POP		AF
;					RET
