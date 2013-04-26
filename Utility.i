
					IF		!DEF(__UTILITY_I__)
__UTILITY_I__		SET		1

					GLOBAL	SetBGP
					GLOBAL	SetOBJP
					GLOBAL	SetOBJPEntry
					GLOBAL	SetSpriteData
					GLOBAL	LCD_Off
					GLOBAL	LCD_On
					GLOBAL	MemoryZeroSmall
					GLOBAL	MemoryZeroBig
					GLOBAL	ScrollBG
					GLOBAL	MoveBG
					GLOBAL	WaitUntilVBLDone
					GLOBAL	LoadTileData
					GLOBAL	VerifyCGB
					GLOBAL	DoubleSpeed
					GLOBAL	Bin2Dec8
					GLOBAL	Bin2Dec16
					GLOBAL	Bin2Dec32
					GLOBAL	SetDynamicOBJP
					GLOBAL	DrawImage
					GLOBAL	FadeOutAllBGP
					GLOBAL	FadeColour

;********************************************************************
; NAME:	PRINT_DIGITS												*
; I/P:	HL	-- -> VRAM to write digits to							*
;		C	-- vram attrib to write									*
;		A	-- two digit BCD value to print							*
;																	*
;********************************************************************
PRINT_DIGITS:		MACRO
					LD		E,A
					SWAP	A
					AND		$0F
					ADD		$01
					LD		B,A

					VRAMBANK	1
					WaitForVRAM
					LD		[HL],C
					VRAMBANK	0
					LD		[HL],B
					INC		L

					LD		A,E
					AND		$0F
					ADD		$01
					LD		B,A

					VRAMBANK	1
					WaitForVRAM
					LD		[HL],C
					VRAMBANK	0
					LD		[HL],B
					INC		L
					ENDM


;********************************************************************
; NAME:	DBGMSG														*
;																	*
;																	*
;********************************************************************
DBGMSG:				MACRO
					LD		D,D
					JR		.continue\@
					DW		$6464
					DW		0
					DB		\1
.continue\@:
					ENDM


;********************************************************************
; NAME:	WaitForVBLDone												*
;																	*
;																	*
;********************************************************************

WaitForVBLDone:		MACRO
					XOR		A
					LD		[g_vblDone],A							; pick up vbl done flag
.WaitForVBL\@:		HALT											; wait for an interrupt to occur
					NOP												; always nop after halt
					LD		A,[g_vblDone]							; pick up vbl done flag
																	; warning: we may lose a vbl intr if it occurs now
					OR		A										; is vbl done flag set?
					JR		Z,.WaitForVBL\@							; no, it wasn't a vbl intr, wait for next interrupt
					XOR		A										; clear vbl done flag
					LD		[g_vblDone],A							; store vbl done flag
					ENDM


;************************************************************************
;																		*
; NAME:	WaitForVRAM (MACRO)												*
; REGS:	A																*
;																		*
; This macro waits until VRAM is available.								*
;																		*
;************************************************************************

WaitForVRAM:		MACRO
.WaitLoop\@			LDH		A,[r_STAT]								; pick up current lcd status ($41)
					AND		2										; is vram available? (bit 1)
					JR		NZ,.WaitLoop\@							; no, loop until it is
					ENDM


;************************************************************************
;																		*
; NAME:	WaitForOAM (MACRO)												*
; REGS:	A																*
;																		*
; This macro waits until OAM RAM is available.							*
;																		*
;************************************************************************

WaitForOAM:			MACRO
.WaitLoop\@			LDH		A,[r_STAT]								; pick up current lcd status ($41)
					AND		k_LCD_STATM_OAM						; is oam available? (bit 1)
					JR		NZ,.WaitLoop\@							; no, loop until it is
					ENDM

;************************************************************************
;																		*
; NAME:	WaitForOAM (MACRO)												*
; REGS:	A																*
;																		*
; This macro waits until OAM RAM is available.							*
;																		*
;************************************************************************

CGBRGBToCGBQB:		MACRO
					LD		A,((((\1)<<6)&$00FF)|(((\2)<<4)&$00FF)|(((\3)<<2)&$00FF)|(((\4)&$00FF)))
					ENDM

;************************************************************************
;																		*
; NAME:	SHOW_BG (MACRO)													*
; REGS:	A																*
;																		*
; This macro turns on the background.									*
;																		*
;************************************************************************

SHOW_BG:			MACRO
					LDH		A,[r_LCDC]								; pick up current value of lcd controller ($40)
					OR		k_LCDCM_BG_ON						; turn on background (bit 0)
					LDH		[r_LCDC],A								; store modified lcd controller ($40)
					ENDM

;************************************************************************
;																		*
; NAME:	HIDE_BG (MACRO)													*
; REGS:	A																*
;																		*
; This macro turns off the background.									*
;																		*
;************************************************************************

HIDE_BG:			MACRO
					LDH		A,[r_LCDC]								; pick up current value of lcd controller ($40)
					AND		k_LCDCM_BG_OFF						; turn off background (bit 0)
					LDH		[r_LCDC],A								; store modified lcd controller ($40)
					ENDM

;************************************************************************
;																		*
; NAME:	SHOW_OBJ (MACRO)												*
; REGS:	A																*
;																		*
; This macro turns on sprites/objects.									*
;																		*
;************************************************************************

SHOW_OBJ:			MACRO
					LDH		A,[r_LCDC]
					OR		k_LCDCM_OBJ_ON
					LDH		[r_LCDC],A
					ENDM

;************************************************************************
;																		*
; NAME:	HIDE_OBJ (MACRO)												*
; REGS:	A																*
;																		*
; This macro turns off sprites/objects.									*
;																		*
;************************************************************************

HIDE_OBJ:			MACRO
					LDH		A,[r_LCDC]
					AND		k_LCDCM_OBJ_OFF
					LDH		[r_LCDC],A
					ENDM


;************************************************************************
;																		*
; NAME:	SPRITES_8X8 (MACRO)												*
; REGS:	A																*
;																		*
; This macro sets sprites to 8x16 mode.									*
;																		*
;************************************************************************

SPRITES_8X8:		MACRO
					LDH		A,[r_LCDC]								; pick up current value of lcd controller ($40)
					AND		k_LCDCM_OBJ8						; turn on 8x8 pixel sprites (bit 2)
					LDH		[r_LCDC],A								; store modified lcd controller ($40)
					ENDM

;************************************************************************
;																		*
; NAME:	SPRITES_8X16 (MACRO)											*
; REGS:	A																*
;																		*
; This macro sets sprites to 8x16 mode.									*
;																		*
;************************************************************************

SPRITES_8X16:		MACRO
					LDH		A,[r_LCDC]								; pick up current value of lcd controller ($40)
					OR		k_LCDCM_OBJ16						; turn on 8x16 pixel sprites (bit 2)
					LDH		[r_LCDC],A								; store modified lcd controller ($40)
					ENDM

;************************************************************************
;																		*
; NAME:	VRAMBANK (MACRO)												*
; REGS:	A																*
;																		*
; This macro sets the VRAM bank to the specified bank					*
;																		*
;************************************************************************

VRAMBANK:			MACRO
__cond				EQUS	STRTRIM(STRUPR("\1"))
					IF		(STRCMP("{__cond}","0")==0)
						XOR		A										; set vram bank to 0
					ELSE
						IF		(STRCMP("{__cond}","1")==0)
							LD		A,1										; set vram bank to 1
						ELSE
							FAIL "Parameter supplied must be 0 or 1 for the desired vram bank"
						ENDC
					ENDC

					LDH		[r_VRAM_BANK],A							; store vram bank # in vram bank register ($4F)
					PURGE	__cond
					ENDM


;************************************************************************
;																		*
; NAME:	PUSHALL (MACRO)													*
;																		*
; This macro pushes all of the registers on to the stack.				*
;																		*
;************************************************************************

PUSHALL:			MACRO
					PUSH	AF										; save register
					PUSH	BC										; save register
					PUSH	DE										; save register
					PUSH	HL										; save register (HL must always be last register to be pushed on stack)
					ENDM

;************************************************************************
;																		*
; NAME:	POPALL (MACRO)													*
;																		*
; This macro pops all of the registers from the the stack.				*
;																		*
;************************************************************************

POPALL:				MACRO
					POP		HL										; restore register
					POP		DE										; restore register
					POP		BC										; restore register
					POP		AF										; restore register
					ENDM


;************************************************************************
;																		*
; NAME:	LOOKUP_16BIT_ADDR (MACRO)										*
; I/P:	A	-- index													*
;		HL	-- base address of lookup table								*
; REGS:	HL																*
;																		*
; This macro converts an index to a 16-bit offset, adds the offset to a	*
; base address, and loads a 16-bit value/address from the calculated	*
; effective address.													*
;																		*
;************************************************************************

LOOKUP_16BIT_ADDR:	MACRO
					PUSH	BC										; save register									(16T)
					PUSH	AF										; save register									(16T)
					ADD		A										; convert index to 16-bit offset				(4T)
					LD		C,A										; copy offset to lo-byte of offset				(4T)
					LD		B,0										; set hi-byte of offset to zero					(8T)
					ADD		HL,BC									; add offset to base address					(8T)
					LD		A,[HL+]									; pick up lo-byte from table					(8T)
					LD		C,A										; copy lo-byte									(4T)
					LD		A,[HL]									; pick up hi-byte from tale						(8T)
					LD		H,A										; copy hi-byte to final table address			(4T)
					LD		L,C										; copy lo-byte to final table address			(4T)
					POP		AF										; restore register								(12T)
					POP		BC										; restore register								(12T)
					ENDM

;
;
;SET_BG_DATA:		MACRO
;					LD		DE,\3
;					PUSH	DE
;					LD		A,\2
;					PUSH	AF
;					INC		SP
;					LD		A,\1
;					PUSH	AF
;					INC		SP
;					CALL	SetBGData
;					ADD		SP,4
;					ENDM

;SET_BG_TILES:		MACRO
;					LD		DE,\5
;					PUSH	DE
;					LD		A,\4
;					PUSH	AF
;					INC		SP
;					LD		A,\3
;					PUSH	AF
;					INC		SP
;					LD		A,\2
;					PUSH	AF
;					INC		SP
;					LD		A,\1
;					PUSH	AF
;					INC		SP
;					CALL	SetBGTiles
;					ADD		SP,6
;					ENDM

;SUB8_BC:			MACRO
;					PUSH	HL
;					LD		H,$FF
;					LD		L,($FF-\1)+1
;					ADD		HL,BC
;					LD		B,H
;					LD		C,L
;					POP		HL
;					ENDM

;ADD8_DE:			MACRO
;					PUSH	HL										; save HL register
;					LD		H,$00									; set hi-byte of first operand to 0
;					LD		L,\1									; set lo-byte of first operand to specified 8-bit value
;					ADD		HL,DE									; add first operand to current value of DE register
;					LD		D,H										; copy hi-byte of result
;					LD		E,L										; copy lo-byte of result
;					POP		HL										; restore HL register
;					ENDM

;SUB16_BC:			MACRO
;					PUSH	HL
;					LD		H,$FF
;					LD		L,($FF-\1)+1
;					ADD		HL,BC
;					LD		B,H
;					LD		C,L
;					POP		HL
;					ENDM
;	
;ADD16_BC:			MACRO
;					PUSH	HL
;					LD		H,$00
;					LD		L,\1
;					ADD		HL,BC
;					LD		B,H
;					LD		C,L
;					POP		HL
;					ENDM
;	
;ADD16_DE:			MACRO
;					PUSH	HL
;					LD		H,$00
;					LD		L,\1
;					ADD		HL,DE
;					LD		D,H
;					LD		E,L
;					POP		HL
;					ENDM	
;
;SUB16_HL:			MACRO
;					PUSH	BC
;					LD		B,$FF
;					LD		C,($FF-\1)+1
;					ADD		HL,BC
;					POP		BC
;					ENDM

;ADD8_HL:			MACRO
;					PUSH	BC										; save register
;					LD		B,$00									; set hi-byte of operand to 0
;					LD		C,\1									; set lo-byte of operand to specified 8-bit value
;					ADD		HL,BC									; add operand to current value of HL register
;					POP		BC										; restore register
;					ENDM


;********************************************************************
; NAME:	LCALL (MACRO)												*
;																	*
; This macro only works for make far calls from bank 0. It cannot	*
; be called from any other bank.									*
;																	*
;********************************************************************
;LCALL:				MACRO
;					LD		A,BANK(\1)
;					LD		[r_MBC5_ROM_SEL],A						; select rom bank												(16T)
;					CALL	\1
;					ENDM


BREAK:				MACRO
					IF		k_DEBUG==1
					LD		B,B
					ENDC
					ENDM


ASSERT:				MACRO
					IF		k_DEBUG==1
__cond				EQUS	STRTRIM(STRUPR("\2"))
					IF		(STRCMP("{__cond}",">")==0)
						ASSERTGT	\1,\3
					ENDC

					IF		STRCMP("{__cond}","==")==0
						ASSERTEQ	\1,\3
					ENDC

					IF		STRCMP("{__cond}","<")==0
						ASSERTLT	\1,\3
					ENDC
					PURGE	__cond
					ENDC
					ENDM


ASSERTGT:			MACRO
					IF		k_DEBUG==1
__p1				EQUS	STRTRIM(STRLWR("\1"))
__p2				EQUS	STRTRIM(STRLWR("\2"))
;					IF      (STRCMP("{__p1}","BC")==0) || (STRCMP("{__p1}","DE")==0) || (STRCMP("{__p1}","HL")==0)
__rp1_msb			EQUS    STRSUB("\1",1,1)
__rp1_lsb			EQUS    STRSUB("\1",2,1)

					PUSH	AF
					LD		A,__rp1_msb
					ADD		$80
					CP		$80
					JR		NZ,.NotEqual\@
					LD		A,__rp1_lsb
					CP		0
.NotEqual\@:
					JR		NC,.FailedCondition\@
					BREAK
.FailedCondition\@:

					POP		AF
					PURGE	__p1
					PURGE	__p2
					PURGE	__rp1_msb
					PURGE	__rp1_lsb
					ENDC
					ENDM

					ENDC											; UTILITY_INC
