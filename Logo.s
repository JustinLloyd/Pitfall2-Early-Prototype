				INCLUDE	"Standard.i"
				INCLUDE	"GlobalData.i"
				INCLUDE	"Logo.i"

; length of pauses (in game frames) for logo animation (a game frame is currently two video frames)
k_LONG_PAUSE		EQU		60
k_SHORT_PAUSE		EQU		3


;********************************************************************
; NAME:	DrawATVILogo												*
;																	*
; This function sets up a group of sprites to display the			*
; Activision logo at the bottom of the screen.						*
;																	*
;********************************************************************
					FT_GAME

DrawATVILogo:
				; prepare to set palettes for atvi logo
					LD		HL,ATVILogoPalData						; -> atvi logo palette data											(3C)
					LD		DE,r_OCPD								; -> gb object colour register										(3C)
					LD		A,$80+(k_OBP_ATVI_LOGO0*8)				; copy first colour index											(2C)
					LDH		[r_OCPS],A								; set gb colour register to first colour index ($68)				(3C)
					REPT	3
;					WaitForVRAM
				; set up 1st atvi logo palette
					XOR		A										; clear first colour to black										(1C)
					LD		[DE],A									; clear lo-byte of first colour										(2C)
					LD		[DE],A									; clear hi-byte of first colour										(2C)
					REPT	6
					LD		A,[HL+]									; pick up colour data and increment pointer							(2C)
					LD		[DE],A									; store colour data in gameboy colour register ($69)				(2C)
					ENDR
					ENDR

					LD		A,[g_scrollingLogo]						; (4C)
					OR		A										; (1C)
					CALL	Z,DrawStaticLogo						; (6C/3C)
					CALL	NZ,DrawAnimLogo							; (6C/3C)
					RET												; (4C)


;********************************************************************
; NAME:	DrawAnimLogo												*
;																	*
;********************************************************************
					FT_GAME
ATVIAnimLogo:		DB			k_ATVI_LOGO_Y,k_ATVI_LOGO_X,   0,5
					DB			k_ATVI_LOGO_Y,k_ATVI_LOGO_X+8, 1,5
					DB			k_ATVI_LOGO_Y,k_ATVI_LOGO_X+16,2,5
					DB			k_ATVI_LOGO_Y,k_ATVI_LOGO_X+24,3,5
					DB			k_ATVI_LOGO_Y,k_ATVI_LOGO_X+32,4,5
					DB			k_ATVI_LOGO_Y,k_ATVI_LOGO_X+40,5,5
					DB			k_ATVI_LOGO_Y,k_ATVI_LOGO_X,   6,6
					DB			k_ATVI_LOGO_Y,k_ATVI_LOGO_X+8, 7,6
					DB			k_ATVI_LOGO_Y,k_ATVI_LOGO_X,   8,7
					DB			k_ATVI_LOGO_Y,k_ATVI_LOGO_X+8, 9,7
DrawAnimLogo:
				; set sprites for atvi logo
.SetSprites:		LD		HL,k_OAMRAM+k_ATVI_SPR_START*4			; -> sprite oam for atvi logo (3C)
					LD		DE,ATVIAnimLogo							; (3C)
					LD		B,10									; (2C)
.SetAnimLoop:
					REPT	3
					LD		A,[DE]									; (2C)
					LD		[HL+],A									; (2C)
					INC		DE										; (2C)
					ENDR
					LD		A,[DE]									; (2C)
					OR		k_OAMM_TILE_BANK_HI						; (2C)
					LD		[HL+],A									; (2C)
					INC		DE										; (2C)
					DEC		B										; (1C)
					JR		NZ,.SetAnimLoop							; (3C/2C)
					RET												; (4C)




;********************************************************************
; NAME:	DrawStaticLogo												*
;																	*
;********************************************************************
					FT_GAME
ATVIStaticLogo:		DB			k_ATVI_LOGO_Y,k_ATVI_LOGO_X,   6,6
					DB			k_ATVI_LOGO_Y,k_ATVI_LOGO_X+8, 7,6
					DB			k_ATVI_LOGO_Y,k_ATVI_LOGO_X,   8,7
					DB			k_ATVI_LOGO_Y,k_ATVI_LOGO_X+8, 9,7
					DB			k_ATVI_LOGO_Y,k_ATVI_LOGO_X+16,2,5
					DB			k_ATVI_LOGO_Y,k_ATVI_LOGO_X+24,3,5
					DB			k_ATVI_LOGO_Y,k_ATVI_LOGO_X+32,4,5
					DB			k_ATVI_LOGO_Y,k_ATVI_LOGO_X+40,5,5
				; set sprites for atvi logo
DrawStaticLogo:
					LD		HL,k_OAMRAM+k_ATVI_SPR_START*4			; -> sprite oam for atvi logo
					LD		DE,ATVIStaticLogo
					LD		B,8
.SetStaticLoop:
					WaitForVRAM
					LD		A,[DE]
					LD		[HL+],A
					INC		DE
					LD		A,[DE]
					LD		[HL+],A
					INC		DE
					LD		A,[DE]
					LD		[HL+],A
					INC		DE
					LD		A,[DE]
					OR		k_OAMM_TILE_BANK_HI
					LD		[HL+],A
					INC		DE
					DEC		B
					JR		NZ,.SetStaticLoop
					RET


;********************************************************************
; NAME:	ScrollATVILogo												*
;																	*
;********************************************************************
					FT_GAME
ScrollATVILogo:		LD		A,[g_logoPause]
					OR		A
					JR		Z,.NextFrame
					DEC		A
					LD		[g_logoPause],A
					RET
.NextFrame:			LD		A,[g_logoFrame]
					INC		A
					CP		9
					JR		NE,.NotLastFrame
					XOR		A
.NotLastFrame:		LD		[g_logoFrame],A
					CP		0
					JR		EQ,.LongPause
					CP		8
					JR		NE,.ShortPause
.LongPause:			LD		A,k_LONG_PAUSE
					JR		.SetPauseTime
.ShortPause:		LD		A,k_SHORT_PAUSE
.SetPauseTime:		LD		[g_logoPause],A
					LD		A,[g_logoFrame]
					CP		0
					JR		NE,.NotFirst
					CALL	PausedATVILogo
					JR		.Exit
.NotFirst:			CP		8
					JR		NE,.NotLast
					CALL	InGameATVILogo
					JR		.Exit
.NotLast:			CALL	MergeATVILogo
.Exit:				RET


;********************************************************************
; NAME:	LoadLogoTileData											*
;																	*
;********************************************************************
					RSSET	$FF80
k_STRIDE			EQU		32
k_NUM_TILES			EQU		10
k_NUM_LINES			EQU		8

					FT_GAME
LoadLogoTileData:	PUSHALL
					LD		HL,k_VRAM_TILE_BANK_0
					LD		D,k_NUM_TILES
.tileCopy:			LD		E,k_NUM_LINES
					PUSH	BC
.rowCopy:			LDH		A,[r_STAT]								; pick lcd status register ($41)
					AND		$02
					JR		NZ,.rowCopy								; no, so loop until it is
					LD		A,[BC]									; pick up tile byte to copy
					LD		[HL+], A								; store tile data in vram
					INC		BC										; increment pointer to source tile data
					LD		A,[BC]									; pick up tile byte to copy
					LD		[HL+], A								; store tile data in vram
					INC		BC										; increment pointer to source tile data
					DEC		E										; decrement number of rows to copy
					JR		NZ, .rowCopy							; more tile rows to copy? yes, so copy next row
					POP		BC
					LD		A,k_STRIDE
					ADD		C
					LD		C,A
					LD		A,0
					ADC		B
					LD		B,A
					DEC		D										; decrement number of tiles to copy
					JR		NZ, .tileCopy							; more tiles to copy? yes, so copy next tile
					POPALL
					RET												; exit function
					PURGE	k_STRIDE,k_NUM_TILES,k_NUM_LINES


;********************************************************************
; NAME:	StartATVILogo												*
;																	*
;********************************************************************
					FT_GAME
StartATVILogo:
					LD		A,1
					LD		[g_scrollingLogo],A
					XOR		A
					LD		[g_logoFrame],A
					LD		A,k_LONG_PAUSE
					LD		[g_logoPause],A
					CALL	PausedATVILogo
					RET

;********************************************************************
; NAME:	StopATVILogo												*
;																	*
;********************************************************************
					FT_GAME
StopATVILogo:
					LD		A,0
					LD		[g_scrollingLogo],A
					CALL	InGameATVILogo
					RET


;********************************************************************
; NAME:	PausedATVILogo												*
;																	*
;********************************************************************
					FT_GAME
PausedATVILogo:		PUSH	BC
					PUSHBK	BANK(ATVILogoTileData)					; switch to rom bank that holds logo data
					VRAMBANK	1									; switch to "static sprites vram bank"
					LD		BC,ATVILogoTileData						; -> atvi logo tile data
					CALL	LoadLogoTileData							; load tile data
					POPBK
					POP		BC
					RET


;********************************************************************
; NAME:	InGameATVILogo												*
;																	*
;********************************************************************
					FT_GAME
InGameATVILogo:		PUSH	BC
					PUSHBK	BANK(ATVILogoTileData)					; switch to rom bank that holds logo data
					VRAMBANK	1									; switch to "static sprites vram bank"
					LD		BC,ATVILogoTileData+1*16				; -> atvi logo tile data
					CALL	LoadLogoTileData						; load tile data
					POPBK
					POP		BC
					RET


;********************************************************************
; NAME:	DrawStaticLogo												*
;																	*
;********************************************************************
					FT_GAME
MergeATVILogo:		PUSHALL
					PUSHBK	BANK(ATVILogoTileData)
					VRAMBANK	1									; switch to "atvi logo vram bank"
				; calculate start address
					LD		BC,ATVILogoTileData						; -> atvi logo tile data
					LD		A,[g_logoFrame]
					ADD		A
					ADD		C
					LD		C,A
					LD		A,0
					ADC		B
					LD		B,A
					CALL	LoadLogoTileData						; load tile data

					POPBK
					POPALL
					RET
