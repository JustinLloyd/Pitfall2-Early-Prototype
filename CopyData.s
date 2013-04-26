					INCLUDE	"standard.i"

	

	;; Copy part (size = DE) of the VRAM from (BC) to (HL)

					FT_GAME
;copy_vram:
;					LDH		A,[r_STAT]
;					AND		$02
;					JR		NZ,copy_vram
;					LD		A,[BC]
;					LD		[HL+],A
;					INC		BC
;					DEC		DE
;					LD		A,D
;					OR		E
;					JR		NZ,copy_vram
;					RET
;
;					FT_UTIL
;_set_data::
;_get_data::
;					PUSH	BC
;					LD		HL,[SP+9]	; Skip return address and registers
;					LD		D,[HL]		; DE = len
;					DEC		HL
;					LD		E,[HL]
;					DEC		HL
;					LD		B,[HL]		; BC = src
;					DEC		HL
;					LD		C,[HL]
;					DEC		HL
;					LD		A,[HL-]		; HL = dst
;					LD		L,[HL]
;					LD		H,A
;					CALL	copy_vram
;					POP	BC
;					RET


;************************************************************************
;* NAME:	MemCopyBig													*
;* I/P:		HL	-- -> source addr										*
;*			BC	-- -> destination addr									*
;*			DE	-- length of data to copy								*
;*																		*
;* This function copies a block of memory from the specified source		*
;* to the specified destination address. It takes three parameters, a	*
;* data source address, a data destination address, and the length of 	*
;* the data block to copy. It does not check for overlapping regions of	*
;* memory.																*
;*																		*
;************************************************************************
					FT_GAME
MemCopyBig:			PUSHALL
.CopyData:			LD		A,[HL+]
					LD		[BC],A
					INC		BC
					DEC		E
					JR		NZ,.CopyData
					DEC		D
					JR		NZ,.CopyData
					POPALL
					RET


;************************************************************************
;* NAME:	MemCopySmall												*
;* I/P:		HL	-- -> source addr										*
;*			BC	-- -> destination addr									*
;*			E	-- length of data to copy								*
;*																		*
;* This function copies a block of memory from the specified source		*
;* to the specified destination address. It takes three parameters, a	*
;* data source address, a data destination address, and the length of 	*
;* the data block to copy. It does not check for overlapping regions of	*
;* memory.																*
;*																		*
;************************************************************************
					FT_GAME
MemCopySmall:		PUSHALL
.CopyData:			LD		A,[HL+]
					LD		[BC],A
					INC		BC
					DEC		E
					JR		NZ,.CopyData
					POPALL
					RET
