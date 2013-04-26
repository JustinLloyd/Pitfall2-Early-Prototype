					IF		!DEF(__BANKS_I__)
__BANKS_I__			SET		1

k_BANK_NUMBER			EQU		$7FFF								; address where current bank # can be found
						RSSET	1
k_RAMBK_OBJECT_DATA		RB		1									; bank #1
k_RAMBK_LEVEL_OVL_LWR	RB		1									; bank #2
k_RAMBK_LEVEL_OVL_UPR	RB		1									; bank #3

						RSSET	0
k_BK_GAME				RB		1									; bank #0
k_BK_MISC				RB		1									; bank #1
k_BK_UNUSED2			RB		1									; bank #2
k_BK_UNUSED3			RB		1									; bank #3
k_BK_UNUSED4			RB		1									; bank #4
k_BK_DATA_TABLE			RB		0									; bank #5
k_BK_SOUND				RB		1									; bank #6
k_BK_GFX_DATA			RB		1									; bank #7 -- this is where general purpose graphics go, fonts, logos, etc

; rom bank defines for level data
k_BK_LEVELS				RB		0									; bank #8 -- first bank # where level data starts

; define bank numbers for levels
;k_BK_LVL_1				RB		0									; bank #8
;k_BK_LVL_1_TILE_DATA	RB		0									; bank #8
;k_BK_LVL_1_PALETTE		RB		0									; bank #8
;k_BK_LVL_1_OVERLAY		RB		0									; bank #8
;k_BK_LVL_1_TILE_ATTR	RB		0									; bank #8
;k_BK_LVL_1_TILE_IDX		RB		1									; bank #8

;k_BK_LVL_2				RB		0									; bank #9
;k_BK_LVL_2_TILE_DATA	RB		0									; bank #9
;k_BK_LVL_2_PALETTE		RB		0									; bank #9
;k_BK_LVL_2_OVERLAY		RB		1									; bank #9
;k_BK_LVL_2_TILE_ATTR	RB		1									; bank #10
;k_BK_LVL_2_TILE_IDX		RB		1									; bank #11

;k_BK_LVL_3				RB		0									; bank #12
;k_BK_LVL_3_TILE_DATA	RB		0									; bank #12
;k_BK_LVL_3_PALETTE		RB		0									; bank #12
;k_BK_LVL_3_OVERLAY		RB		1									; bank #12
;k_BK_LVL_3_TILE_ATTR	RB		0									; bank #13
;k_BK_LVL_3_TILE_IDX		RB		1									; bank #13

;k_BK_LVL_4				RB		0									; bank #14
;k_BK_LVL_4_TILE_DATA	RB		0									; bank #14
;k_BK_LVL_4_PALETTE		RB		0									; bank #14
;k_BK_LVL_4_OVERLAY		RB		1									; bank #14
;k_BK_LVL_4_TILE_ATTR	RB		1									; bank #15
;k_BK_LVL_4_TILE_IDX		RB		1									; bank #16

;k_BK_LVL_5				RB		0									; bank #17
;k_BK_LVL_5_TILE_DATA	RB		0									; bank #17
;k_BK_LVL_5_PALETTE		RB		0									; bank #17
;k_BK_LVL_5_OVERLAY		RB		1									; bank #17
;k_BK_LVL_5_TILE_ATTR	RB		0									; bank #18
;k_BK_LVL_5_TILE_IDX		RB		1									; bank #18

;k_BK_LVL_6				RB		0									; bank #19
;k_BK_LVL_6_TILE_DATA	RB		0									; bank #19
;k_BK_LVL_6_PALETTE		RB		0									; bank #19
;k_BK_LVL_6_OVERLAY		RB		1									; bank #19
;k_BK_LVL_6_TILE_ATTR	RB		0									; bank #20
;k_BK_LVL_6_TILE_IDX		RB		1									; bank #20

;k_BK_LVL_7				RB		0									; bank #21
;k_BK_LVL_7_TILE_DATA	RB		0									; bank #21
;k_BK_LVL_7_PALETTE		RB		0									; bank #21
;k_BK_LVL_7_OVERLAY		RB		1									; bank #21
;k_BK_LVL_7_TILE_ATTR	RB		1									; bank #22
;k_BK_LVL_7_TILE_IDX		RB		1									; bank #23

;k_BK_LVL_8				RB		0									; bank #24
;k_BK_LVL_8_TILE_DATA	RB		0									; bank #24
;k_BK_LVL_8_PALETTE		RB		0									; bank #24
;k_BK_LVL_8_OVERLAY		RB		1									; bank #24
;k_BK_LVL_8_TILE_ATTR	RB		0									; bank #25
;k_BK_LVL_8_TILE_IDX		RB		1									; bank #25

;k_BK_LVL_9				RB		0									; bank #26
;k_BK_LVL_9_TILE_DATA	RB		0									; bank #26
;k_BK_LVL_9_PALETTE		RB		0									; bank #26
;k_BK_LVL_9_OVERLAY		RB		1									; bank #26
;k_BK_LVL_9_TILE_ATTR	RB		0									; bank #27
;k_BK_LVL_9_TILE_IDX		RB		1									; bank #27

;k_BK_LVL_15				RB		0									; bank #28
;k_BK_LVL_15_TILE_DATA	RB		0									; bank #28
;k_BK_LVL_15_PALETTE		RB		0									; bank #28
;k_BK_LVL_15_OVERLAY		RB		1									; bank #28
;k_BK_LVL_15_TILE_ATTR	RB		0									; bank #29
;k_BK_LVL_15_TILE_IDX	RB		1									; bank #29

;k_BK_LVL_16				RB		0									; bank #30
;k_BK_LVL_16_TILE_DATA	RB		0									; bank #30
;k_BK_LVL_16_PALETTE		RB		0									; bank #30
;k_BK_LVL_16_OVERLAY		RB		1									; bank #30
;k_BK_LVL_16_TILE_ATTR	RB		1									; bank #31
;k_BK_LVL_16_TILE_IDX	RB		1									; bank #32

;k_BK_LVL_17				RB		0									; bank #33
;k_BK_LVL_17_TILE_DATA	RB		0									; bank #33
;k_BK_LVL_17_PALETTE		RB		0									; bank #33
;k_BK_LVL_17_OVERLAY		RB		1									; bank #33
;k_BK_LVL_17_TILE_ATTR	RB		0									; bank #34
;k_BK_LVL_17_TILE_IDX	RB		1									; bank #34

;k_BK_LVL_18				RB		0									; bank #35
;k_BK_LVL_18_TILE_DATA	RB		0									; bank #35
;k_BK_LVL_18_PALETTE		RB		0									; bank #35
;k_BK_LVL_18_OVERLAY		RB		1									; bank #35
;k_BK_LVL_18_TILE_ATTR	RB		1									; bank #36
;k_BK_LVL_18_TILE_IDX	RB		1									; bank #37



k_BK_LAST				RB		0									; bank #41 -- last bank # used, must be at end of list

;********************************************************************
; NAME: ROMBANK (macro)												*
; I/P:	parameter 1	-- 8-bit rom bank # to set						*
; REGS:	A															*
; AUTH:	JLloyd -- 99/05/07											*
;																	*
; This macro sets the second rom bank to the specified #. It takes	*
; a single 8-bit immediate value that identifies the rom bank. The	*
; A register is destroyed.											*
;																	*
;********************************************************************

ROMBANK:			MACRO
					LD		A,\1									; set rom bank to specified #									(16T)
					LD		[r_MBC5_ROM_SEL],A						; select rom bank												(16T)
					ENDM


;********************************************************************
; NAME: RAM_BANK (macro)											*
; I/P:	parameter 1	-- 8-bit ram bank # to set						*
; REGS:	A															*
; AUTH:	JLloyd -- 99/05/07											*
;																	*
; This macro sets the second ram bank to the specified #. It takes	*
; a single 8-bit immediate value that identifies the ram bank. The	*
; A register is destroyed.											*
;																	*
;********************************************************************

RAM_BANK:			MACRO
					FAIL	"RAM BANK Macro not yet implemented"
					LD		A,\1									; set rom bank to specified #									(16T)
					LD		[r_MBC5_RAM_SELECT],A					; select rom bank												(16T)
					ENDM


;********************************************************************
; NAME: FARCALL (macro)												*
; I/P:	parameter 1	-- function to call								*
; REGS:	NONE														*
; AUTH:	JLloyd -- 99/09/17											*
;																	*
; This macro makes a call to a function in another ROM bank that is	*
; "safe". It reads the current ROM bank number, saves it for later	*
; switches ROM banks, calls the specified function,	restores the	*
; previous ROM bank, and returns to the calling function. It is		*
; primarily designed to be placed in ROM bank #0 as part of a stub	*
; function.															*
;																	*
;********************************************************************

FARCALL:			MACRO
					PUSH	AF										; preserve register						(4C)
					LD		A,[k_BANK_NUMBER]						; pick up the current rom bank #		(3C)
					PUSH	AF										; save current rom bank # for later		(4C)
					LD		A,BANK(\1)								; get rom bank # of specified function	(2C)
					LD		[r_MBC5_ROM_SEL],A						; switch rom banks						(3C)
					CALL	\1										; call specified function				(6C)
					POP		AF										; restore previous rom bank #			(3C) 
					LD		[r_MBC5_ROM_SEL],A						; switch rom banks						(3C)
					POP		AF										; restore register						(3C)
					ENDM


;********************************************************************
; NAME: FARFUNC (macro)												*
; I/P:	parameter 1	-- function to call								*
; REGS:	NONE														*
; AUTH:	JLloyd -- 99/09/17											*
;																	*
; This macro declares a far function. It creates a header that is	*
; placed in bank #0 that will call the actual function.				*
;																	*
;********************************************************************
FARFUNC:			MACRO
					PUSHS											; preserve current section details
					SECTION	"FARFUNC\@",HOME						; place stub function in bank #0
\1:					FARCALL	\1Hi									; make a far call to the specified function
					RET												; exit stub function					(4C)
					POPS											; restore previous section details
\1Hi::				ENDM


;********************************************************************
; NAME: PUSHBK (macro)												*
; AUTH:	JLloyd -- 99/09/22											*
;																	*
;																	*
;********************************************************************

PUSHBK:				MACRO
					LD		A,[k_BANK_NUMBER]						; pick up the current rom bank #		(3C)
					PUSH	AF										; save current rom bank # for later		(4C)
					LD		A,\1									; get rom bank # of specified function	(2C)
					LD		[r_MBC5_ROM_SEL],A						; switch rom banks						(3C)
					ENDM


;********************************************************************
; NAME: POPBK (macro)												*
; AUTH:	JLloyd -- 99/09/22											*
;																	*
;																	*
;********************************************************************

POPBK:				MACRO
					POP		AF										; restore previous rom bank #			(3C) 
					LD		[r_MBC5_ROM_SEL],A						; switch rom banks						(3C)
					ENDM


;********************************************************************
; NAME: FT_INTR (macro)												*
; AUTH:	JLloyd -- 99/04/01											*
;																	*
; This macro sets the section in the assembler to that used by		*
; interrupt routines.												*
;																	*
;********************************************************************

FT_INTR:			MACRO
					SECTION	"INTR\@",HOME
					ENDM


;********************************************************************
; NAME: FT_UTIL (macro)												*
; AUTH:	JLloyd -- 99/04/01											*
;																	*
; This macro sets the section in the assembler to that used by		*
; utility routines.													*
;																	*
;********************************************************************

FT_GAME:			MACRO
					SECTION	"GAME\@",HOME				;	(bank #0)
					ENDM

FT_MISC:			MACRO
					SECTION	"MISC\@",CODE,BANK[k_BK_MISC]
					ENDM

DT_VARS:			MACRO
					SECTION	"VARS\@",BSS				; FIX THIS
					ENDM

; FIX THIS -- place this in the correct rom bank # (k_BK_DATA_MISC)
DT_DATA:			MACRO
					SECTION	"DATA\@",DATA				; FIX THIS
					ENDM

; FIX THIS -- place this in the correct rom bank # (k_BK_DATA_TABLE)
DT_TABLE:			MACRO
					SECTION	"DATA\@",DATA
					ENDM

DT_GFX_DATA:		MACRO
					SECTION	"GFX DATA\@",DATA,BANK[k_BK_GFX_DATA]
					ENDM

					ENDC
