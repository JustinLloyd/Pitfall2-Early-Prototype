					INCLUDE "Standard.i"
					INCLUDE	"GlobalData.i"
					INCLUDE "Utility.i"
					INCLUDE "Initialise.i"
					INCLUDE	"Object.i"
					INCLUDE	"Level.i"
;					INCLUDE "Pitfall2.i"
					INCLUDE "Font.i"
					INCLUDE "Sound.inc"
					INCLUDE "Interrupts.i"
					INCLUDE "Player.i"
					INCLUDE	"Logo.i"


;************************************************************************
;																		*
; NAME:	InitMemory														*
;																		*
;************************************************************************
					FT_GAME
InitMemory:			PUSHALL											; save registers
				; clear bank 0 of wram from stack top to end of ram bank
					LD		HL,g_stackTop							; -> start of work ram
					LD		BC,k_RAM_BANK_LENGTH-(g_stackTop-k_RAM)	; clear 4kb of ram
					CALL	MemoryZeroBig							; clear work ram
				; clear oam ram
					LD		HL,k_OAMRAM								; -> oam ram
					LD		B,$A0									; clear 160 bytes of oam ram
					CALL	MemoryZeroSmall							; clear oam ram
				; clear hi ram
					LD		HL,k_HIRAM								; -> hi-ram
					LD		B,k_HIRAM_LENGTH						; clear 70 bytes of hi-ram (but not the stack area)
					CALL	MemoryZeroSmall							; clear hi-ram
				; clear all wram that can be bank switched
					LD		A,7										; set ram bank counter to last available ram bank
.ClearWorkRAM:		LDH		[r_SVBK],A								; switch ram bank
					LD		HL,k_RAM_BANK_UPR						; -> start of upper ram bank
					LD		BC,k_RAM_BANK_LENGTH					; set length of memory to length of one ram bank
					PUSH	AF										; save register
					CALL	MemoryZeroBig							; clear 4KB of ram
					POP		AF										; restore register
					DEC		A										; decrement ram bank counter
					JR		NZ,.ClearWorkRAM						; no, another ram bank
				; restore original ram bank
					LD		A,1										; set ram bank #1
					LDH		[r_SVBK],A								; restore ram bank that was here before entering function
					POPALL											; restore registers
					RET												; exit function


;************************************************************************
;																		*
; NAME:	InitDisplay														*
;																		*
;************************************************************************
					FT_GAME
InitDisplay:		CALL	LCD_Off									; turn display off
					XOR		A										; load #0
					LDH		[r_SCX],A								; clear background scroll X register
					LDH		[r_SCY],A								; clear background scroll Y register
					LDH		[r_STAT],A								; clear lcd status register
					LDH		[r_WY],A								; clear window y position
;					LD		A,$07									; set x coord of window
					LDH		[r_WX],A								; set window x position
					LD		E,31
					CALL	FadeOutAllBGP
;					CGBRGBToCGBQB	k_COLOUR_GREY, k_COLOUR_DARK_GREY, k_COLOUR_LIGHT_GREY, k_COLOUR_TRANSPARENT	; "normal" colour palette
;					LDH		[r_BGP],A								; set BG palette
;					LDH		[r_OBP0],A								; set OBJ0 palette
;					LDH		[r_OBP1],A								; set OBJ1 palette
					LDH		A,[r_LCDC]
					AND		A,k_LCDCM_BG8800
					LDH		[r_LCDC],A
					RET


;************************************************************************
;																		*
; NAME:	InitSprites														*
;																		*
;************************************************************************
					FT_GAME
InitSprites:		SPRITES_8X8										; turn on 8x8 pixel sprite mode
					SHOW_OBJ										; turn on sprites
					RET


;************************************************************************
;																		*
; NAME:	InitBackground													*
;																		*
;************************************************************************
					FT_GAME
InitBackground:		SHOW_BG											; turn on background
					RET												; exit function


;************************************************************************
;																		*
; NAME:	Initialise														*
;																		*
;************************************************************************
					FT_GAME
Initialise:			DI												; disable interrupts
;					LD		D,A										; copy gameboy type
					XOR		A										; set interrupt flag to no interrupts
					LDH		[r_IE],A								; reset all interrupts
					LD		[r_IF],A								; clear all pending interrupts
					CALL	LCD_Off									; turn off the lcd
					CALL	InitMemory								; initialise memory
;					LD		A,D										; retrieve gameboy type
;					LD		[g_cpuType],A							; store gameboy type
					CALL	VerifyCGB								; verify that this is a colour gameboy
					CALL	InitDisplay								; initialise display
					CALL	InitOAMDMA								; initialise oam dma function
					CALL	InitGameInter							; initialise game interrupt routines
					CALL	LCD_On									; turn on lcd display
					RET												; exit function


;************************************************************************
;																		*
; NAME:	InitWorld														*
;																		*
;************************************************************************
InitWorld:			LD		A,0										; load first level
;					BREAK
					CALL	LoadLevel								; load level data & display map
					LD		A,0
					LD		[g_worldData+m_world_room],A
					LD		B,A
					CALL	DrawScreen
;					LD		B,0										; set map col to 0
;					LD		C,0										; set map row to 0
;					CALL	SetMapPos								; set initial map position
					RET


;************************************************************************
;*																		*
;* NAME:	InitOAMDMA													*
;* I/P:		HL	--	-> OAM source data									*
;*																		*
;************************************************************************
					FT_GAME
InitOAMDMA:			PUSHALL
					LD		HL,OAMDMACode
					LD		BC,$FFF0
					LD		DE,OAMDMACodeEnd-OAMDMACode
					CALL	MemCopySmall
					POPALL
					RET

OAMDMACode:			LD		A,((g_oamBuffer>>8)&$FF)
					LDH		[r_DMA],A
					LD		A,$28
.Wait:				DEC		A
					JR		NZ,.Wait
					RET
OAMDMACodeEnd:


;************************************************************************
;*																		*
;* NAME:	InitGame													*
;*																		*
;************************************************************************
					FT_GAME
InitGame:
					CALL	InitGameInter
;					CALL	InitBackground							; initialise background
					CALL	InitSprites								; initialise game sprites
					CALL	InitStaticSprTiles						; initialise static sprite tiles
					CALL	InitWorld								; initialise game world
					LD		A,1										; set score has changed flag
					LD		[g_scoreChanged],A						; store new score has changed flag
;					CALL	InitFont								; initialise font and console output
;					CALL	sound_init								; initialise sound engine
;					LD		A,1										; set in-game music flag to "on"
;					LD		[g_musicEnabled],A						; enable in-game music
					EI												; enable interrupts
					NOP
					RET
