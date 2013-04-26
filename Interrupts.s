					INCLUDE	"Standard.i"
					INCLUDE	"GlobalData.i"
					INCLUDE "Interrupts.i"
					INCLUDE	"Logo.i"


k_INTER_RAM_SIZE	EQU		128

					SECTION	"Interrupt Code",BSS
g_lcdIntrCode:		DS		k_INTER_RAM_SIZE
g_vblIntrCode:		DS		k_INTER_RAM_SIZE
;g_tmrIntrCode:		DS		k_INTER_RAM_SIZE
;g_sioIntrCode:		DS		k_INTER_RAM_SIZE
;g_joyIntrCode:		DS		k_INTER_RAM_SIZE

					SECTION	"GameboyROM",HOME[$0]
					DS		$40

					SECTION	"VBL Interrupt",HOME[$40]
					JP		g_vblIntrCode

					SECTION	"LCD Interrupt",HOME[$48]
					JP		g_lcdIntrCode

					SECTION	"Timer Interrupt",HOME[$50]
					RETI

					SECTION	"Serial Interrupt",HOME[$58]
;					JP		SIOInterrupt
					RETI

					SECTION	"Joypad Interrupt",HOME[$60]
					RETI


SETINT:				MACRO
__start				EQUS	STRTRIM("\1")
__end				EQUS	STRTRIM("\2")
__size				EQU		__end-__start
					IF		__size>k_INTER_RAM_SIZE
						FAIL	"Interrupt function is larger than available RAM"
					ENDC

					LD		HL,\1
					LD		DE,__size
					LD		BC,\3
					CALL	MemCopySmall
					PURGE	__start,__end,__size
					ENDM


;********************************************************************
; NAME:	GameLCDInter												*
;																	*
; This function handles the in-game LCDC interrupt. It's only job	*
; is to set two background palettes when LYC == LY. This occurs in	*
; two places, once at the line that is the start of the window, and	*
; once on the line that is the bottom of the window.				*
;																	*
;********************************************************************
ATVILogoData:		DB			k_ATVI_LOGO_Y,k_ATVI_LOGO_X,0,6
					DB			k_ATVI_LOGO_Y,k_ATVI_LOGO_X+8,1,6
					DB			k_ATVI_LOGO_Y,k_ATVI_LOGO_X+16,2,6
					DB			k_ATVI_LOGO_Y,k_ATVI_LOGO_X+24,3,6
					DB			k_ATVI_LOGO_Y,k_ATVI_LOGO_X+32,4,6
					DB			k_ATVI_LOGO_Y,k_ATVI_LOGO_X+40,5,6
					DB			k_ATVI_LOGO_Y+8,k_ATVI_LOGO_X,6,7
					DB			k_ATVI_LOGO_Y+8,k_ATVI_LOGO_X+8,7,7
					DB			k_ATVI_LOGO_Y+8,k_ATVI_LOGO_X+16,8,7
					DB			k_ATVI_LOGO_Y+8,k_ATVI_LOGO_X+24,9,7
					DB			k_ATVI_LOGO_Y+8,k_ATVI_LOGO_X+32,10,7
					DB			k_ATVI_LOGO_Y+8,k_ATVI_LOGO_X+40,11,7

					FT_INTR
GameLCDInter:		PUSHALL											; preserve registers (8C)
				; wait for hblank to occur
;.WaitHBL:			LDH		A,[r_STAT]
;					AND		$03
;					JR		NZ,.WaitHBL
				; set background display address
;					LDH		A,[r_LCDC]
;					SET		4,A
;					LDH		[r_LCDC],A
				; at line # to show atvi logo?
;					BREAK
.Wait:				LDH		A,[r_LY]								; pick up current video line # (3C)
					CP		k_ATVI_LOGO_Y-3							; equal to 3 lines before logo sprites are needed? (2C)
					JR		EQ,.DrawLogo							; yes, so draw atvi logo (3C/2C)
					JR		.Wait									; wait until video scanline is at desired value (3C)
;					CALL	EQ,DrawATVILogo
				; display score
				; load score palette
				; set sprites for score
				; set lyc for atvi logo
				; exit function
;					BREAK
					POPALL											; (8C)
					RETI											; (4C)
.DrawLogo:
					CALL	DrawATVILogo							; (6C)
				; set lyc for score
				; exit function
					POPALL											; restore registers (8C)
					RETI											; return from interrupt (4C)
GameLCDInterEnd:


;********************************************************************
; NAME:	GameVBLInter												*
; DEST: None														*
;																	*
; This function handles the in-game VBL interrupt. It updates the	*
; OAM, scrolls the screen h/w registers, scans the joypad for		*
; player input, updates the frame counter and sets the vbl done		*
; flag. The function itself is copied in to RAM and executed from	*
; there so that multiple interrupt service routines can be set up	*
; for different parts of the game.									*
;																	*
;********************************************************************
					FT_INTR
GameVBLInter:		PUSHALL											; preserve registers
;					LDH		A,[r_LCDC]
;					RES		4,A										; set bkg tile set to 8800-97ff
;					LDH		[r_LCDC],A
					LD		A,[g_vblFrameCount]						; pick up current frame count								(4)
					AND		$01										; mask vbl frame counter for odd/even frames				(2)
					JR		Z,.EveryFrame							; is this an even frame? yes, so don't scan the joypad		(3/2)
					CALL	$FFF0									; dma oam data to oam ram									(6)
					LD		A,[g_worldData+m_world_scrX]			; pick up screen scroll x position							(4)

					LDH		[r_SCX],A								; set screen scroll x register								(3)
					LD		A,[g_worldData+m_world_scrY]			; pick up screen scroll y position							(4)
					LDH		[r_SCY],A								; set screen scroll y register								(3)
					CALL	ScanJoypad								; update joypad status										(6)
.EveryFrame:		LD		A,[g_vblFrameCount]						; pick up current frame count								(4)
					INC		A										; increment frame #											(1)
					LD		[g_vblFrameCount],A						; store new frame count value								(4)
					LD		A,[g_vblFrameCount+1]					; pick up current frame count								(4)
					ADC		0										; increment frame #											(1)
					LD		[g_vblFrameCount+1],A					; store new frame count value								(4)
					LD		A,$01									; indicate that vbl is complete								(2)
					LD		[g_vblDone],A							; set vbl done flag											(4)
					POPALL											; restore registers
					RETI											; return from interrupt
GameVBLInterEnd:


;********************************************************************
; NAME:	InitGameInter												*
;																	*
; This function initialises the interrupts, it copies any required	*
; interrupt routines in to RAM at their desginated addresses.		*
;																	*
;********************************************************************
					FT_GAME
InitGameInter:		PUSH	DE										; preserve register
					PUSH	BC										; preserve register
					PUSH	HL										; preserve register
					DI												; disable interrupts
				; set lcd interrupt function
					SETINT	GameLCDInter,GameLCDInterEnd,g_lcdIntrCode	; set up lcd interrupt
				; set vbl interrupt
					SETINT	GameVBLInter,GameVBLInterEnd,g_vblIntrCode		; set up vblank interrupt
				; set first lyc position
					LD		A,k_ATVI_LOGO_Y-4						; get vertical position of atvi logo
					LDH		[r_LYC],A								; set the interrupt line for atvi logo display
				; enable lyc in video controller
					LDH		A,[r_STAT]								; get video status bits ($41)
					OR		k_STATF_LYC								; enable lyc in video control (bit 6)
;					SET		6,A
					LDH		[r_STAT],A								; store new video status ($1)
				; enable game interrupts
					LD		A,(k_IEF_VBLANK | k_IEF_LCDC)			; set vblank & lcd interrupts on
					LDH		[r_IE],A								; set interrupt enable flags
					POP		HL										; restore register
					POP		BC										; restore register
					POP		DE										; restore register
					RET												; exit function
