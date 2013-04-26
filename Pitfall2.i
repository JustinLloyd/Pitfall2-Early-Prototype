					GLOBAL	ExecuteAI
					GLOBAL	CodeStart
					GLOBAL	CodeRestart


;********************************************************************
; NAME:	DMA_SPRITES (MACRO)											*
;																	*
; This macro DMA's the sprite tile buffer to VRAM. It currently		*
; moves 27 tiles worth of information to tile RAM.					*
;																	*
;																	*
;********************************************************************

DMA_SPRITES:		MACRO
					VRAMBANK	1									; switch to upper vram bank
					LD		A,((g_spriteBuffer>>8)&$FF)				; get msb of tile buffer addr										(1)
					LDH		[r_HDMA1],A								; set msb of dma source addr										(3)
					LD		A,(g_spriteBuffer & $FF)				; get lsb of tile buffer addr										(1)
					LDH		[r_HDMA2],A								; set msb of dma source addr										(3)
					LD		A,$80									; get msb of vram addr												(1)
					LDH		[r_HDMA3],A								; set msb of dma dest addr											(3)
					XOR		A										; get lsb of vram addr												(1)
					LDH		[r_HDMA4],A								; set lsb of dma dest addr											(3)
					LD		A,31									; move 32 tiles of information (32*16 bytes)						(2)
					LDH		[r_HDMA5],A								; set length of dma & begin transfer								(3)
					ENDM


;********************************************************************
; NAME:	DMA_ICONS (MACRO)											*
;																	*
; This macro DMA's the sprite tile buffer to VRAM. It currently		*
; moves 27 tiles worth of information to tile RAM.					*
;																	*
;																	*
;********************************************************************

DMA_ICONS:			MACRO
					VRAMBANK	0									; switch to upper vram bank
					LD		A,((g_bkgTileBuffer>>8)&$FF)			; get msb of tile buffer addr										(1)
					LDH		[r_HDMA1],A								; set msb of dma source addr										(3)
					LD		A,(g_bkgTileBuffer & $FF)				; get lsb of tile buffer addr										(1)
					LDH		[r_HDMA2],A								; set msb of dma source addr										(3)
					LD		A,$86									; get msb of vram addr												(1)
					LDH		[r_HDMA3],A								; set msb of dma dest addr											(3)
					XOR		A										; get lsb of vram addr												(1)
					LDH		[r_HDMA4],A								; set lsb of dma dest addr											(3)
					LD		A,31									; move 32 tiles of information (32*16 bytes)						(2)
					LDH		[r_HDMA5],A								; set length of dma & begin transfer								(3)
					ENDM

;********************************************************************
; NAME:	SET_PALETTES (MACRO)										*
;																	*
; This macro sets the dynamic palettes.								*
;																	*
;																	*
;********************************************************************

SET_PALETTES:		MACRO
					LD		HL,g_palBuffer
					LD		DE,r_OCPD								; -> gb object colour register												(12T)
					LD		C,6
;					WaitForVRAM
					LD		A,$80										; copy first colour index											(4T)
					LDH		[r_OCPS],A								; set gb colour register to first colour index ($68)				(12T)
;					WaitForVRAM
.PaletteLoop:
;					WaitForVRAM
;					XOR		A										; clear first colour to black
;					LD		[DE],A									; clear lo-byte of first colour
;					LD		[DE],A									; clear hi-byte of first colour
					REPT	8
					LD		A,[HL+]									; pick up colour data and increment pointer							(8T)
					LD		[DE],A									; store colour data in gameboy colour register ($69)				(8T)
					ENDR
;					INC		L
;					INC		L
					DEC		C										; decrement colour counter
					JR		NZ,.PaletteLoop							; zero? no, so copy another colour byte
					ENDM

					ENDC