					INCLUDE	"Standard.i"
					INCLUDE "Shift.i"
					INCLUDE	"GlobalData.i"
					INCLUDE	"Font.i"


;************************************************************************
;																		*
; NAME:	LCD_Off															*
; REGS:	A																*
;																		*
; This function switches off the LCD. It takes no parameters and		*
; returns nothing. It waits until the VBL period before switching the	*
; LCD off, as per GB specs.												*
;																		*
;************************************************************************
					FT_GAME
LCD_Off:			LDH		A,[r_LCDC]								; read current value of LCD control register ($FF40)
					ADD		A										; test lcd off flag (msb), is LCD already off?
					RET		NC										; carry is not set, so lcd is off, just exit
.InsideVBL:			LDH		A,[r_LY]								; pick up current scan line # ($FF44)
					CP		$92										; inside vbl region?
					JR		NC,.InsideVBL							; yes, wait until vbl region is left
.OutsideVBL:		LDH		A,[r_LY]								; pick up current scan line # ($FF44)
					CP		$91										; inside vbl region?
					JR		C,.OutsideVBL							; no, loop until vbl region is entered
					LDH		A,[r_LCDC]								; pick up current LCD control register ($FF40)
					AND		k_LCDCM_LCD_OFF							; mask off "lcd on/off" (bit 7) control bit
					LDH		[r_LCDC],A								; switch off LCD ($FF40)
					RET												; exit function


;************************************************************************
;																		*
; NAME:	LCD_On															*
; REGS:	A																*
;																		*
; This function switches on the LCD. It takes no parameters and returns	*
; nothing.																*
;																		*
;************************************************************************
					FT_GAME
LCD_On:				LDH		A,[r_LCDC]								; read current value of LCD control register ($FF40)
					OR		k_LCDCM_LCD_ON							; mask in LCD ON control bit
					LDH		[r_LCDC],A								; switch on LCD
					RET												; exit function

; I/P:	BC	-- 16-bit colour in Gameboy BGR format
; B = 0GGGGGBB
; C = BBBRRRRR

;************************************************************************
;																		*
; NAME:	FadeColour														*
; I/P:	BC	-- 16-bit colour in GameBoy GBR format						*
;		E	-- distance to fade by										*
; RET:	BC	-- "faded" 16-bit colour in GameBoy GBR format				*
; REGS:	AF, BC															*
;																		*
; This function fades out all of the background palettes.				*
;																		*
;************************************************************************
;FadeColour:			PUSH	DE
;				; fade down green component
;					LD		A,B
;					SRL		A
;					SRL		A
;					AND		$1F
;					SUB		E
;					JR		NC,.BlueRolledOver
;					XOR		A
;.BlueRolledOver:	SLA		A
;					SLA		A
;					LD		D,A
;					LD		A,B
;					AND		$03
;					OR		D
;					LD		B,A
;
;				; fade down blue component
;					LD		A,B
;					SWAP	A
;					LD		D,A
;					LD		A,C
;					SWAP	A
;					OR		D
;					SRL		A
;					AND		$1F
;					SUB		E
;					JR		NC,.GreenRolledOver
;					XOR		A
;.GreenRolledOver:	SLA		A
;					SWAP	A
;					LD		D,A
;					LD		A,B
;					AND		$7C
;					LD		B,A
;					LD		A,D
;					AND		$03
;					OR		B
;					LD		B,A
;					LD		A,C
;					AND		$1F
;					LD		C,A
;					LD		A,D
;					AND		$E0
;					OR		C
;					LD		C,A
;
;				; fade down red component
;					LD		A,C
;					AND		$1F
;					SUB		E
;					JR		NC,.RedRolledOver
;					XOR		A
;.RedRolledOver:		LD		D,A
;					LD		A,C
;					AND		$E0
;					OR		D
;					LD		C,A
;					POP		DE
;					RET

;************************************************************************
;																		*
; NAME:	FadeOutAll														*
; I/P:	E	-- speed to fade by											*
; REGS:	A																*
;																		*
; This function fades out all of the background palettes by a single	*
; step. Call repeatedly to fade to black.								*
;																		*
;************************************************************************
;					FT_UTIL
;FadeOutAll:			PUSHALL
;					LD		D,0
;.FadeLoop:			WaitForVRAM
;				; get current colour entry
;					LD		A,D
;					LDH		[r_BCPS],A
;					LDH		A,[r_BCPD]
;					LD		C,A
;					INC		D
;					LD		A,D
;					LDH		[r_BCPS],A
;					LDH		A,[r_BCPD]
;					LD		B,A
;					DEC		D
;				; fade colour by one step
;					CALL	FadeColour
;				; set new colour entry
;					WaitForVRAM
;					LD		A,D
;					LDH		[r_BCPS],A
;					LD		A,B
;					LDH		[r_BCPD],A
;					INC		D
;					LD		A,D
;					LD		[r_BCPS],A
;					LD		A,C
;					LDH		[r_BCPD],A
;					INC		D
;					LD		A,8*4
;					CP		D
;					JR		NE,.FadeLoop
;					POPALL
;					RET


;************************************************************************
;*																		*
;* NAME:	MemoryZeroBig												*
;* I/P:		HL	-- start address to clear								*
;*			BC	-- # bytes to clear										*
;* REGS:	A,HL,BC														*
;*																		*
;************************************************************************
					FT_GAME
MemoryZeroBig:		XOR		A										; set value to write to memory		
.ClearMemory\@:		LD		[HL+],A									; write value to memory and increment memory pointer
					DEC		C										; decrement # bytes to write
					JR		NZ,.ClearMemory
					DEC		B
					JR		NZ,.ClearMemory							; all bytes written? no, so write another byte
					RET												; exit function


;************************************************************************
;*																		*
;* NAME:	MemoryZeroSmall												*
;* I/P:		HL	-- start address to clear								*
;*			BC	-- # bytes to clear										*
;* REGS:	A,HL,BC														*
;*																		*
;************************************************************************
					FT_GAME
MemoryZeroSmall:	XOR		A
.ClearMemory:		LD		[HL+],A
					DEC		B
					JR		NZ,.ClearMemory
					RET


;************************************************************************
;*																		*
;* NAME:	SetBGPEntry													*
;* I/P:		BC	-- -> source palette data								*
;*			D	-- first palette entry to set							*
;*			E	-- # palette entries to set								*
;* REGS:	BC,DE,A,HL													*
;*																		*
;************************************************************************
					FT_GAME
SetBGPEntry:		LD      A,D		; E = first_palette
					ADD		A		; A *= 8
					ADD		A
					ADD		A
					ADD		E		; A += 2 * pal_entry
					ADD		E
					LD		E,A		; A = first BCPS data
.SetPalette:		LDH		A,[r_STAT]
					AND		$02
					JR		NZ,.SetPalette
					LD		A,E
					LDH		[r_BCPS],A
					LD		A,C
					LDH		[r_BCPD],A
					INC		E		; next BCPS
					LD		A,E
					LDH		[r_BCPS],A
					LD		A,B
					LDH		[r_BCPD],A
					RET


;********************************************************************
;*																	*
;* NAME:	SetBGPalette											*
;* I/P:		HL	-- -> palette to set								*
;*			B	-- first palette to set								*
;*			C	-- # palettes to set								*
;* DESTROY:	A,BC,HL,DE												*
;*																	*
;********************************************************************
					FT_GAME
SetBGP:				LD      A,B										; copy start palette index											(4T)
					ADD		A										; calculate start # for current colour index (* 8)					(4T)
					ADD		A										;																	(4T)
					ADD		A										;																	(4T)
					OR		$80										; enable BCPS auto-increment bit (bit 7)							(8T)
					LD		B,A										; set start colour index											(4T)
					LD		A,C										; copy # palettes to set
					ADD		A										; * 2
					ADD		A										; * 4
					ADD		A										; * 8
					LD		C,A										; copy # palettes to set
.IndexWait:			LDH		A,[r_STAT]								; pick up lcd status register ($41)									(12T)
					AND		k_STATM_OAM							; mask "oam used by cpu" bit (bit 2)								(8T)
					JR		NZ,.IndexWait							; oam ram is available? no, loop until it is						(12/8T)
					LD		A,B										; copy first colour index											(4T)
					LDH		[r_BCPS],A								; set gb colour register to first colour index ($68)				(12T)
					LD		DE,r_BCPD								; -> gb colour register												(12T)
.PaletteLoop:		WaitForVRAM
					LD		A,[HL+]									; pick up colour data and increment pointer							(8T)
					LD		[DE],A									; store colour data in gameboy colour register ($69)				(8T)
					DEC		C										; decrement # palettes to write										(4T)
					JR		NZ,.PaletteLoop							; no, process next colour											(12T/8T)
					RET												; exit function														(16T)


;********************************************************************
;*																	*
;* NAME:	SetOBJPEntry											*
;* I/P:		HL	-- -> palette to set								*
;*			B	-- palette to set									*
;* DESTROY:	A,BC,HL,DE												*
;*																	*
;********************************************************************

SetOBJPEntry:		LD      A,B										; copy start palette index											(4T)
					ADD		A										; calculate start # for current colour index (* 8)					(4T)
					ADD		A										; x4																(4T)
					ADD		A										; x8																(4T)
					OR		$80										; enable OCPS auto-increment bit (bit 7)							(8T)
					LD		B,A										; set start colour index											(4T)
.IndexWait:			LDH		A,[r_STAT]								; pick up lcd status register ($41)									(12T)
					AND		k_STATM_OAM							; mask "oam used by cpu" bit (bit 2)								(8T)
					JR		NZ,.IndexWait							; oam ram is available? no, loop until it is						(12/8T)
					LD		A,B										; copy first colour index											(4T)
					LDH		[r_OCPS],A								; set gb colour register to first colour index ($68)				(12T)
					LD		DE,r_OCPD								; -> gb object colour register												(12T)
.WaitForVRAM:		LDH		A,[r_STAT]								; pick up lcd status register ($41)									(12T)
					AND		k_STATM_OAM							; mask "oam used by cpu" bit (bit 2)								(8T)
					JR		NZ,.WaitForVRAM							; oam ram is available? no, loop until it is						(12T/8T)
					XOR		A										; clear first colour to black
					LD		[DE],A									; clear lo-byte of first colour
					LD		[DE],A									; clear hi-byte of first colour
					LD		C,6										; set # colour bytes to copy
.PaletteLoop:		LDH		A,[r_STAT]								; pick up lcd status register ($41)									(12T)
					AND		k_STATM_OAM							; mask "oam used by cpu" bit (bit 2)								(8T)
					JR		NZ,.PaletteLoop							; oam ram is available? no, loop until it is						(12T/8T)
					LD		A,[HL+]									; pick up colour data and increment pointer							(8T)
					LD		[DE],A									; store colour data in gameboy colour register ($69)				(8T)
					DEC		C										; decrement colour counter
					JR		NZ,.PaletteLoop							; zero? no, so copy another colour byte
					RET												; exit function														(16T)


;********************************************************************
;*																	*
;* NAME:	SetDynamicOBJP											*
;* I/P:		HL	-- -> palette data									*
;*			B	-- palette to set									*
;* DESTROY:	AF														*
;*																	*
;********************************************************************

SetDynamicOBJP:		PUSH	DE
					PUSH	HL
					LD		DE,g_palBuffer
					LD      A,B
					ADD		A
					ADD		A
					ADD		A
					ADD		A,E
					LD		E,A
					XOR		A
					LD		[DE],A
					INC		E
					LD		[DE],A
					INC		E
					REPT	6
					LD		A,[HL+]
					LD		[DE],A
					INC		E
					ENDR
					POP		HL
					POP		DE
					RET						



;********************************************************************
;*																	*
;* NAME:	SetOBJP													*
;* I/P:		HL	-- -> palette to set								*
;*			B	-- first palette to set								*
;*			C	-- # palettes to set								*
;* DESTROY:	A,BC,HL,DE												*
;*																	*
;********************************************************************

SetOBJP:			LD      A,B										; copy start palette index											(4T)
					ADD		A										; calculate start # for current colour index (* 8)					(4T)
					ADD		A										; x4																(4T)
					ADD		A										; x8																(4T)
					OR		$80										; enable OCPS auto-increment bit (bit 7)							(8T)
					LD		B,A										; set start colour index											(4T)
.IndexWait:			LDH		A,[r_STAT]								; pick up lcd status register ($41)									(12T)
					AND		k_STATM_OAM								; mask "oam used by cpu" bit (bit 2)								(8T)
					JR		NZ,.IndexWait							; oam ram is available? no, loop until it is						(12/8T)
					LD		A,B										; copy first colour index											(4T)
					LDH		[r_OCPS],A								; set gb colour register to first colour index ($68)				(12T)
					LD		DE,r_OCPD								; -> gb object colour register												(12T)
.PaletteLoop:		LDH		A,[r_STAT]								; pick up lcd status register ($41)									(12T)
					AND		k_STATM_OAM								; mask "oam used by cpu" bit (bit 2)								(8T)
					JR		NZ,.PaletteLoop							; oam ram is available? no, loop until it is						(12T/8T)
					XOR		A										; clear first colour to black
					LD		[DE],A									; clear lo-byte of first colour
					LD		[DE],A									; clear hi-byte of first colour
					REPT	6										; repeat for 3 colours
					LD		A,[HL+]									; pick up colour data and increment pointer							(8T)
					LD		[DE],A									; store colour data in gameboy colour register ($69)				(8T)
					ENDR
					DEC		C										; decrement # palettes to write										(4T)
					XOR		A										; set cpu status flags
					CP		C										; is current colour index = last colour index?						(4T)
					JR		NZ,.PaletteLoop							; no, process next colour											(12T/8T)
					RET												; exit function														(16T)


;********************************************************************
;* NAME:	MemorySet												*
;* I/P:		A	-- value to set memory too							*
;*			HL	-- -> start of memory to set						*
;*			BC	-- # bytes to set									*
;*																	*
;********************************************************************
					FT_GAME
MemorySet:			INC		B
					INC		C
					JR		.skip
.loop:				LD		[HL+],A
.skip:				DEC		C
					JR		NZ,.loop
					DEC		B
					JR		NZ,.loop
					RET


;********************************************************************
;* NAME:	MemoryCopy												*
;* I/P:		HL	-- -> source memory									*
;*			DE	-- -> destination memory							*
;*			BC	-- # bytes to set									*
;*																	*
;********************************************************************
					FT_GAME
MemoryCopy:			INC		B
					INC		C
					JR		.skip
.loop:				LD		A,[HL+]
					LD		[DE],A
					INC		DE
.skip:				DEC		C
					JR		NZ,.loop
					DEC		B
					JR		NZ,.loop
					RET


;************************************************************************
;*																		*
;* NAME:	WaitUntilVBLDone											*
;* I/P:																	*
;* REGS:																*
;*																		*
;************************************************************************
					FT_GAME
;WaitUntilVBLDone:	LDH		A,[r_LCDC]								; pick up current value of lcd controller ($FF40)
;					ADD		A										; quick test of "lcd display on/off" (bit 7)
;					RET		NC										; if lcd already off, exit function
;.WaitForVBL\@:		HALT											; wait for an interrupt to occur
;					NOP												; always nop after halt
;					LD		A,[g_vblDone]							; pick up vbl done flag
;																	; warning: we may lose a vbl intr if it occurs now
;					OR		A										; is vbl done flag set?
;					JR		Z,.WaitForVBL\@							; no, it wasn't a vbl intr, wait for next interrupt
;					XOR		A										; clear vbl done flag
;					LD		[g_vblDone],A							; store vbl done flag
;					RET


;************************************************************************
;																		*
; NAME:	DrawImage														*
; I/P:		HL	-- -> location in vram to write to						*
;			BC	-- -> image tile attribute data							*
;			DE	-- -> image tile index data								*
; DEST:	NONE															*
;																		*
; This function draws an image on the screen. It takes three			*
; parameters. A pointer to the location in VRAM to draw the image. A	*
; pointer to the source image tile attribute data and a pointer to the	*
; source image tile index data.											*
;																		*
;************************************************************************
					FT_GAME
DrawImage:			PUSHALL											; preserve all registers
					PUSH	DE										; save -> source tile indices
					PUSH	HL										; save -> destination vram address
				; copy tile attributes
					VRAMBANK	1									; set vram bank 1
					LD		D,18									; set loop for 18 rows
.CopyAttr:			LD		E,20									; set loop for 20 tiles per row
				; copy an entire row of tile attributes
.CopyAttrRow:		WaitForVRAM										; wait for vram to become available
					LD		A,[BC]									; pick up current tile index from source data
					LD		[HL+],A									; store new tile index in vram
					INC		BC										; increment dest ->
					DEC		E										; decrement # tiles to copy in this row
					JR		NZ,.CopyAttrRow							; more tiles in this row? yes, so copy another tile
				; step to next vram row
					LD		A,12									; # tiles remaining in a vram row after a straight screen copy
					ADD		L										; add # tiles remaining to lsb of dest addr
					LD		L,A										; set new lsb of dest addr
					LD		A,0										; msb of # tiles remaining in a vram row
					ADC		H										; add # tiles remaining to msb of dest addr
					LD		H,A										; set new msb of dest addr
					DEC		D										; decrement # rows to copy
					JR		NZ,.CopyAttr							; more rows remaining? yes, so draw another row
					POP		HL										; get -> destination vram address
					POP		BC										; get -> source tile indices
				; copy tile indices
					VRAMBANK	0									; set vram bank 0
					LD		D,18									; set loop for 18 rows
.CopyIndices:		LD		E,20									; set loop for 20 tiles per row
				; copy an entire row of tile indices
.CopyIndicesRow:	WaitForVRAM										; wait for vram to become available
					LD		A,[BC]									; pick up current tile index from source data
					LD		[HL+],A									; store new tile index in vram
					INC		BC										; increment dest ->
					DEC		E										; decrement # tiles to copy in this row
					JR		NZ,.CopyIndicesRow						; more tiles in this row? yes, so copy another tile
				; step to next vram row
					LD		A,12									; # tiles remaining in a vram row after a straight screen copy
					ADD		L										; add # tiles remaining to lsb of dest addr
					LD		L,A										; set new lsb of dest addr
					LD		A,0										; msb of # tiles remaining in a vram row
					ADC		H										; add # tiles remaining to msb of dest addr
					LD		H,A										; set new msb of dest addr
					DEC		D										; decrement # rows to copy
					JR		NZ,.CopyIndices							; more rows remaining? yes, so draw another row
					POPALL											; restore all registers
					RET												; exit function


;************************************************************************
;*																		*
;* NAME:	ScrollBG													*
;* I/P:		B = background x position									*
;*			C = backgorund y position									*
;* REGS:	A															*
;*																		*
;************************************************************************
					FT_GAME
ScrollBG:			XOR	A											; clear accumulator
					CP		B										; is x offset = 0?
					JR		Z,.XisZero								; yes, skip to y offset
					LDH		A,[r_SCX]								; no, pick up current screen x position
					ADD		B										; add x offset
					LDH		[r_SCX],A								; store screen x position
.XisZero:			XOR		A										; clear accumulator
					CP		C										; is y offset = 0?
					RET		Z										; yes, exit function
					LDH		A,[r_SCY]								; no, pick up current screen y position
					ADD		C										; add y offset
					LDH		[r_SCY],A								; store screen y position
					RET												; exit function


;************************************************************************
;*																		*
;* NAME:	MoveBG														*
;* I/P:		B = background x position									*
;*			C = backgorund y position									*
;* REGS:	A															*
;*																		*
;************************************************************************
					FT_GAME
MoveBG:				LD		A,B										; copy screen x position
					LDH		[r_SCX],A								; store screen x position
					LD		A,C										; copy screen y position
					LDH		[r_SCY],A								; store screen y position 
					RET												; exit function




;************************************************************************
;*																		*
;* NAME:	LoadTileData												*
;* I/P:		A	-- tile data vram region to write to ($80/$88/$90)		*
;*			BC	-- -> tile source data									*
;*			D	-- # of tiles to load									*
;*			E	-- # first tile to load									*
;*																		*
;* This function is for general purpose tile loading in non-speed		*
;* critical functions.													*
;*																		*
;************************************************************************
					FT_GAME
LoadTileData:		PUSHALL
					LD		H,0
					LD		L,E
					SLA16	HL,4
					ADD		H
					LD		H,A										; set hi-byte of tile bank address
.tileCopy:			LD		E,16									; loop counter for moving 16 bytes per tile
.rowCopy:			LDH		A,[r_STAT]								; pick lcd status register ($41)
					AND		$02
					JR		NZ,.rowCopy								; no, so loop until it is
					LD		A,[BC]									; pick up tile byte to copy
					LD		[HL+], A								; store tile data in vram
					INC		BC										; increment pointer to source tile data
					DEC		E										; decrement number of rows to copy
					JR		NZ, .rowCopy							; more tile rows to copy? yes, so copy next row
					DEC		D										; decrement number of tiles to copy
					JR		NZ, .tileCopy							; more tiles to copy? yes, so copy next tile
					POPALL
					RET												; exit function


;************************************************************************
;																		*
; NAME:	VerifyCGB														*
; REGS:	A,DE															*
;																		*
; This function verifies that the software is running on a Colour		*
; Gameboy and displays an appropriate message before executing an		*
; infinite loop.														*
;																		*
;************************************************************************
					FT_GAME
VerifyCGB:			LD		A,[g_cpuType]							; pick up gameboy console type
					CP		17										; is it a colour gameboy?
					RET		Z										; yes, so exit function
					LD		HL,.CGBOnlyMessage						; -> cgb only message
;					CALL	PrintString								; display string
.LoopForever:		JR		.LoopForever							; freeze gameboy, loop forever

.CGBOnlyMessage:	DB		" This Game Pak is\n"
					DB		"specially designed\n"
					DB		"for Game Boy Colour\n"
					DB		" Please use a Game\n"
					DB		"Boy Colour Unit to\n"
					DB		"  play this game",0


;************************************************************************
;																		*
; NAME:	DoubleSpeed														*
;																		*
; This function switches the Colour Gameboy to double-speed mode.		*
;																		*
;************************************************************************
					FT_GAME
DoubleSpeed:		PUSH	HL
					PUSH	AF
					DI
					LD		HL,r_IE
					LD		A,[HL]
					PUSH	AF 
					XOR		A
					LD		[HL],A
					LD		[r_IF],A
					LD		A,$30
					LD		[r_P1],A
					LD		A,1
					LD		[r_KEY1],A
					STOP
					POP		AF
					LD		[HL],A
					EI
					POP		AF
					POP		HL
					RET 


;********************************************************************
; NAME:	Bin2DecTable												*
;																	*
;********************************************************************
					SECTION	"Bin2DecTable",DATA[$4F00],BANK[k_BK_MISC]
Bin2Dec8Table:		DB		$01,$00									; bit #1
					DB		$02,$00									; bit #2
					DB		$04,$00									; bit #3
					DB		$08,$00									; bit #4
					DB		$16,$00									; bit #5
					DB		$32,$00									; bit #6
					DB		$64,$00									; bit #7
					DB		$28,$01									; bit #8

Bin2Dec16Table:		DB		$01,$00,$00								; bit #1
					DB		$02,$00,$00								; bit #2
					DB		$04,$00,$00								; bit #3
					DB		$08,$00,$00								; bit #4
					DB		$16,$00,$00								; bit #5
					DB		$32,$00,$00								; bit #6
					DB		$64,$00,$00								; bit #7
					DB		$28,$01,$00								; bit #8
					DB		$56,$02,$00								; bit #9
					DB		$12,$05,$00								; bit #10
					DB		$24,$10,$00								; bit #11
					DB		$48,$20,$00								; bit #12
					DB		$96,$40,$00								; bit #13
					DB		$92,$81,$00								; bit #14
					DB		$84,$63,$01								; bit #15
					DB		$68,$27,$03								; bit #16


Bin2Dec32Table:		DB		$01,$00,$00,$00,$00						; bit #1
					DB		$02,$00,$00,$00,$00						; bit #2
					DB		$04,$00,$00,$00,$00						; bit #3
					DB		$08,$00,$00,$00,$00						; bit #4
					DB		$16,$00,$00,$00,$00						; bit #5
					DB		$32,$00,$00,$00,$00						; bit #6
					DB		$64,$00,$00,$00,$00						; bit #7
					DB		$28,$01,$00,$00,$00						; bit #8
					DB		$56,$02,$00,$00,$00						; bit #9
					DB		$12,$05,$00,$00,$00						; bit #10
					DB		$24,$10,$00,$00,$00						; bit #11
					DB		$48,$20,$00,$00,$00						; bit #12
					DB		$96,$40,$00,$00,$00						; bit #13
					DB		$92,$81,$00,$00,$00						; bit #14
					DB		$84,$63,$01,$00,$00						; bit #15
					DB		$68,$27,$03,$00,$00						; bit #16
					DB		$36,$55,$06,$00,$00						; bit #17
					DB		$72,$10,$13,$00,$00						; bit #18
					DB		$44,$21,$26,$00,$00						; bit #19
					DB		$88,$42,$52,$00,$00						; bit #20
					DB		$76,$85,$04,$01,$00						; bit #21
					DB		$52,$71,$09,$02,$00						; bit #22
					DB		$04,$43,$19,$04,$00						; bit #23
					DB		$08,$86,$38,$08,$00						; bit #24
					DB		$16,$72,$77,$16,$00						; bit #25
					DB		$32,$44,$55,$33,$00						; bit #26
					DB		$64,$88,$10,$67,$00						; bit #27
					DB		$28,$77,$21,$34,$01						; bit #28
					DB		$56,$54,$43,$68,$02						; bit #29
					DB		$12,$09,$87,$36,$05						; bit #30
					DB		$24,$18,$74,$73,$10						; bit #31
					DB		$48,$36,$48,$47,$21						; bit #32


;********************************************************************
; NAME:	Bin2Dec8													*
; I/P:	B	-- 8-bit number to convert to decimal					*
;		HL	-- destination address of converted bcd number			*
;																	*
;********************************************************************
					FT_MISC
					FARFUNC	Bin2Dec8
					PUSHALL
					XOR		A
					LD		[HL+],A
					LD		[HL],A
					LD		E,L
					LD		D,H
;					ROMBANK	BANK(Bin2Dec8Table)
					LD		HL,Bin2Dec8Table
					LD		C,8
.BitRoll:
					RR		B
					JR		NC,.NextBit

					PUSH	BC
					PUSH	DE
; add two bcd numbers together
					LD		C,2
					LD		B,0
.BCDAdd:			LD		A,[DE]
					ADD		B
					ADD		[HL]
					DAA
					LD		[DE],A
					LD		B,0
					RL		B
					INC		L
					DEC		DE
					DEC		C
					JR		NZ,.BCDAdd
					POP		DE
					POP		BC
					JR		.BitLoop

.NextBit:			INC		L
					INC		L

.BitLoop:			DEC		C
					JR		NZ,.BitRoll
					POPALL
					RET


;********************************************************************
; NAME:	Bin2Dec16													*
; I/P:	BC	-- 16-bit number to convert to decimal					*
;		DE	-- destination address of converted bcd number			*
;																	*
;********************************************************************
					RSSET	$FF80
k_BYTE_COUNT		RB		1
					FT_MISC
					FARFUNC	Bin2Dec16
					PUSHALL
					PUSH	BC										; push msb of specified 16-bit number on stack
					LD		B,C										; copy lsb of specified 16-bit number
					PUSH	BC										; push lsb of specified 16-bit number on stack
					INC		DE										; -> end of bcd string
					INC		DE
;					ROMBANK	BANK(Bin2Dec16Table)					; switch to rom bank for 
					LD		HL,Bin2Dec16Table
					LD		A,2
					LDH		[k_BYTE_COUNT],A
.ConvertByte:		POP		BC
					LD		C,8
.BitRoll:			RR		B
					JR		NC,.NextBit

					PUSH	BC
					PUSH	DE
; add two bcd numbers together
					LD		C,3
					LD		B,0
.BCDAdd:			LD		A,[DE]
					ADD		B
					ADD		[HL]
					DAA
					LD		[DE],A
					LD		B,0
					RL		B
					INC		L
					DEC		DE
					DEC		C
					JR		NZ,.BCDAdd
					POP		DE
					POP		BC
					JR		.BitLoop

.NextBit:			INC		L
					INC		L
					INC		L

.BitLoop:			DEC		C
					JR		NZ,.BitRoll
					LDH		A,[k_BYTE_COUNT]
					DEC		A
					LDH		[k_BYTE_COUNT],A
					JR		NZ,.ConvertByte

					POPALL
					RET
					PURGE	k_BYTE_COUNT


;********************************************************************
; NAME:	Bin2Dec32													*
; I/P:	BC	-- lower 16-bits of 32-bit number to convert to decimal	*
;		DE	-- upper 16-bits of 32-bit number to convert to decimal	*
;		HL	-- destination address of converted bcd number			*
;																	*
;********************************************************************
					RSSET	$FF80
k_BYTE_COUNT		RB		1										; loop counter for number of bytes to convert
					FT_MISC
					FARFUNC	Bin2Dec32
					PUSHALL											; preserve all registers
					PUSH	DE										; push mmsb of specified 16-bit number on stack
					LD		D,E										; copy mlsb of specified 16-bit number
					PUSH	DE										; push mlsb of specified 16-bit number on stack
					PUSH	BC										; push lmsb of specified 16-bit number on stack
					LD		B,C										; copy llsb of specified 16-bit number
					PUSH	BC										; push llsb of specified 16-bit number on stack
					XOR		A										; set initial bcd value
					LD		[HL+],A									; clear bcd string
					LD		[HL+],A
					LD		[HL+],A
					LD		[HL+],A
					LD		[HL],A
					LD		E,L										; copy lsb of end of string to dest ptr
					LD		D,H										; copy msb of end of string to dest ptr
;					ROMBANK	BANK(Bin2Dec32Table)					; switch to rom bank for 32-bit bcd conversion table
					LD		HL,Bin2Dec32Table						; -> 32-bit bcd conversion table
					LD		A,4										; set # bytes to convert
					LDH		[k_BYTE_COUNT],A						; store # bytes to convert loop counter
.ConvertByte:		POP		BC										; get byte 
					LD		C,8										; loop counter for # bits to test
.BitRoll:			RR		B										; shift bit in to carry flag
					JR		NC,.NextBit								; carry flag clear? yes, so examine next bit
					PUSH	BC										; save byte of number being converted for later
					PUSH	DE										; save bcd string dest ptr
					LD		C,5										; # bcd bytes to add
					LD		B,0										; set initial bcd carry bit to zero
.BCDAdd:			LD		A,[DE]									; pick up bcd character from bcd string
					ADD		B										; add bcd carry bit from previous result
					ADD		[HL]									; add bcd char to bcd string for this bit
					DAA												; decimal adjust
					LD		[DE],A									; store new bcd char at dest ptr
					LD		B,0										; clear any previous bcd carry bit
					RL		B										; retrieve bcd carry bit from daa operation
					INC		L										; -> next bcd character to add
					DEC		DE										; -> previous bcd char in dest bcd string
					DEC		C										; decrement # bcd chars to add
					JR		NZ,.BCDAdd								; loop counter = 0? no, so add another bcd char
					POP		DE										; restore bcd string dest ptr
					POP		BC										; restore current 8-bit
					JR		.BitLoop								; convert next bit in number
.NextBit:			INC		L										; -> next line of bcd chars to add
					INC		L
					INC		L
					INC		L
					INC		L
.BitLoop:			DEC		C										; decrement # bytes to convert
					JR		NZ,.BitRoll								; this byte converted? no, so convert another bit
					LDH		A,[k_BYTE_COUNT]						; pick up # bytes to convert
					DEC		A										; decrement # bytes to convert
					LDH		[k_BYTE_COUNT],A						; store new # bytes to convert
					JR		NZ,.ConvertByte							; all bytes converted? no, so convert next byte
					POPALL											; restore all registers
					RET												; exit function
					PURGE	k_BYTE_COUNT


;************************************************************************
;																		*
; NAME:	FadeColor														*
; I/P:	BC	-- 16-bit colour in GameBoy GBR format						*
;		E	-- distance to fade by										*
; RET:	BC	-- "faded" 16-bit colour in GameBoy GBR format				*
; REGS:	AF, BC															*
;																		*
; This function fades out all of the background palettes.				*
;																		*
;************************************************************************
					FT_MISC
					FARFUNC	FadeColor
					PUSH	DE
				; fade down blue component
					LD		A,B
					SRL		A						;shift right 2 times
					SRL		A
					AND		$1F
					SUB		E
					JR		NC,.BlueRolledOver
					XOR		A
.BlueRolledOver:	SLA		A
					SLA		A
					LD		D,A
					LD		A,B
					AND		$03
					OR		D
					AND		$7F
					LD		B,A
				; fade down green component
					LD		A,B
					SWAP	A
					AND		A,$30
					LD		D,A
					LD		A,C
					SWAP	A
					AND		A,$0E
					OR		D
					SRL		A
					AND		$1F
					SUB		E
					JR		NC,.GreenRolledOver
					XOR		A
.GreenRolledOver:	SLA		A
					SWAP	A
					LD		D,A
					LD		A,B
					AND		$7C
					LD		B,A
					LD		A,D
					AND		$03
					OR		B
					AND		$7F
					LD		B,A
					LD		A,C
					AND		$1F
					LD		C,A
					LD		A,D
					AND		$E0
					OR		C
					LD		C,A
				; fade down red component
					LD		A,C
					AND		$1F
					SUB		E
					JR		NC,.RedRolledOver
					XOR		A
.RedRolledOver:		LD		D,A
					LD		A,C
					AND		$E0
					OR		D
					LD		C,A
					POP		DE
					RET


;************************************************************************
;																		*
; NAME:	FadeOutAllBGP													*
; I/P:	E	-- speed to fade by											*
; REGS:	A																*
;																		*
; This function fades out all of the background palettes by a single	*
; step. Call repeatedly to fade to black.								*
;																		*
;************************************************************************
					FT_MISC
					FARFUNC	FadeOutAllBGP
					PUSHALL
					LD		D,0
.FadeLoop:			WaitForVRAM
				; get current colour entry
					LD		A,D
					LDH		[r_BCPS],A
					LDH		A,[r_BCPD]
					LD		C,A
					INC		D
					LD		A,D
					LDH		[r_BCPS],A
					LDH		A,[r_BCPD]
					LD		B,A
					DEC		D
				; fade colour by one step
					CALL	FadeColor
				; set new colour entry
					WaitForVRAM
					LD		A,D
					LDH		[r_BCPS],A
					LD		A,C
					LDH		[r_BCPD],A
					INC		D
					LD		A,D
					LD		[r_BCPS],A
					LD		A,B
					LDH		[r_BCPD],A
					INC		D
					LD		A,8*4*2
					CP		D
					JR		NE,.FadeLoop
					POPALL
					RET

