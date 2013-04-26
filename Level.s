					INCLUDE	"Standard.i"
					INCLUDE	"GlobalData.i"
					INCLUDE	"Level.i"
;					INCLUDE "LevelData.i"
					INCLUDE "Shift.i"
					INCLUDE	"RoomData.i"
					INCLUDE	"Sprites\\FloorTypes.i"
					INCLUDE	"Sprites\\FeatureTypes.i"
					INCLUDE	"Sprites\\BkgTypes.i"
					INCLUDE "RoomData.i"


					RSSET	$FF90
g_blockPtr			RB		2
g_attrPtr			RB		2
g_indexPtr			RB		2

					DT_VARS
g_roomData			DS		16

;********************************************************************
; NAME:	LoadLevelTiles												*
;																	*
; This function copies the tile data from rom to vram for the		*
; various parts of the background.									*
;																	*
;********************************************************************
					INCLUDE	"Rooms.i"
					FT_GAME
LoadLevelTiles:
					LD		E,L
					VRAMBANK	0									; enable lower vram bank
					PUSHBK	BANK(RoomTilesTileData)
					LD		BC,RoomTilesTileData

					LD		D,128									; load 128 tiles
					LD		E,0										; first tile to load is #0
					LD		A,$90									; load in to middle background tile bank
					CALL	LoadTileData							; load tile data to vram


					ROMBANK	BANK(RoomPalData)
					LD		HL,RoomPalData
					LD		B,0										; first palette to load is #0
					LD		C,8
					CALL	SetBGP									; set background palettes
; FIX THIS -- not yet done
;	copy 128 tiles for animated background
;	copy 128 tiles for special effects
					POPBK
					RET



;********************************************************************
; NAME:	ScrollMapDown												*
; I/P:	A	-- number of pixels to scroll (must be < 48)			*
;																	*
; This function scrolls the map down by altering the world y		*
; position. If an extra room requires drawing it takes care of		*
; that.																*
;																	*
;********************************************************************

					FT_GAME
ScrollMapDown:		LD		E,A										; copy # pixels to scroll by
					LD		A,[g_worldData+m_world_scrollY]			; pick up world scroll counter
					LD		B,A										; save current world scroll counter value for later use
					ADD		E										; add # pixels to scroll by
					CP		k_ROOM_H_PIX							; compare scroll counter to room height in pixels
					JR		LT,.JustScrollScreen					; scroll counter less than room height? yes, so just scroll screen
				; are we scrolling off bottom of map?
					LD		A,[g_worldData+m_world_room]			; pick up current world room #
					CP		k_LEVEL_1_HEIGHT-4						; at end of map?
					RET		EQ										; yes, so just exit
				; add scroll delta to scroll counter
					LD		A,B										; get current world scroll counter
					ADD		E										; add # pixels to scroll by
					SUB		k_ROOM_H_PIX							; subtract height of room
					LD		[g_worldData+m_world_scrollY],A			; store new world scroll counter
				; add scroll delta to world y pos
					LD		A,[g_worldData+m_world_posY_LSB]		; pick up lsb of map y coord
					ADD		E										; add # pixels to scroll vertically
					LD		[g_worldData+m_world_posY_LSB],A		; store lsb of map y coord
					LD		A,[g_worldData+m_world_posY_MSB]		; pick up msb of map y coord
					ADC		0										; add carry from previous addition
					LD		[g_worldData+m_world_posY_MSB],A		; store new msb of map y coord
				; add scroll delta to screen y pos
					LD		A,[g_worldData+m_world_scrY]			; pick up screen y coord
					ADD		E										; add # pixels to scroll vertically
					LD		[g_worldData+m_world_scrY],A			; store new screen y coord
				; increment room #
					LD		A,[g_worldData+m_world_room]			; pick up current world room #
					INC		A										; increment room # to next row
					LD		[g_worldData+m_world_room],A			; store new room #
				; draw room at bottom of screen
					CALL	DrawBottomRoom							; draw a new room at bottom of screen
					RET												; exit function
.JustScrollScreen:
				; add scroll delta to scroll counter
					LD		A,B										; pick up world scroll counter
					ADD		E										; add # pixels to scroll by
					LD		[g_worldData+m_world_scrollY],A			; store new world scroll counter 
				; add scroll delta to world y pos
					LD		A,[g_worldData+m_world_posY_LSB]		; pick up lsb of map y coord
					ADD		E										; add # pixels to scroll vertically
					LD		[g_worldData+m_world_posY_LSB],A		; store lsb of map y coord
					LD		A,[g_worldData+m_world_posY_MSB]		; pick up msb of map y coord
					ADC		0										; add carry from previous addition
					LD		[g_worldData+m_world_posY_MSB],A		; store new msb of map y coord
				; add scroll delta to screen y pos
					LD		A,[g_worldData+m_world_scrY]			; pick up screen y coord
					ADD		E										; add # pixels to scroll vertically
					LD		[g_worldData+m_world_scrY],A			; store screen y coord
					RET


;********************************************************************
; NAME:	ScrollMapUp													*
; I/P:	A	-- number of pixels to scroll (must be < 48)			*
;																	*
; This function scrolls the map up by altering the world y			*
; position. If an extra room requires drawing it takes care of		*
; that.																*
;																	*
;********************************************************************
					FT_GAME
ScrollMapUp:		LD		E,A										; copy # pixels to scroll by
					LD		A,[g_worldData+m_world_scrollY]			; pick up world scroll counter
					LD		B,A										; save current world scroll counter value for later use
					SUB		E										; subtract # pixels to scroll by
					JR		NC,.JustScrollScreen					; scroll counter > 0? yes, so just scroll screen
				; are we scrolling off bottom of map?
					LD		A,[g_worldData+m_world_room]			; pick up current world room #
					CP		k_LEVEL_1_HEIGHT-4						; at start of map?
					OR		A										; at start of map?
					RET		EQ										; yes, so just exit
				; subtract scroll delta from scroll counter
					LD		A,B										; get current world scroll counter
					SUB		E										; add # pixels to scroll by
					ADD		k_ROOM_H_PIX							; add height of room
					LD		[g_worldData+m_world_scrollY],A			; store new world scroll counter
				; subtract scroll delta fom world y pos
					LD		A,[g_worldData+m_world_posY_LSB]		; pick up lsb of map y coord
					SUB		E										; add # pixels to scroll vertically
					LD		[g_worldData+m_world_posY_LSB],A		; store lsb of map y coord
					LD		A,[g_worldData+m_world_posY_MSB]		; pick up msb of map y coord
					SBC		0										; add carry from previous addition
					LD		[g_worldData+m_world_posY_MSB],A		; store new msb of map y coord
				; subtract scroll delta from screen y pos
					LD		A,[g_worldData+m_world_scrY]			; pick up screen y coord
					SUB		E										; add # pixels to scroll vertically
					LD		[g_worldData+m_world_scrY],A			; store new screen y coord
				; decrement room #
					LD		A,[g_worldData+m_world_room]			; pick up current world room #
					DEC		A										; increment room # to next row
					LD		[g_worldData+m_world_room],A			; store new room #
				; draw room at bottom of screen
					CALL	DrawTopRoom								; draw a new room at bottom of screen
					RET												; exit function
.JustScrollScreen:
				; add scroll delta to scroll counter
					LD		A,B										; pick up world scroll counter
					SUB		E										; add # pixels to scroll by
					LD		[g_worldData+m_world_scrollY],A			; store new world scroll counter 
				; add scroll delta to world y pos
					LD		A,[g_worldData+m_world_posY_LSB]		; pick up lsb of map y coord
					SUB		E										; add # pixels to scroll vertically
					LD		[g_worldData+m_world_posY_LSB],A		; store lsb of map y coord
					LD		A,[g_worldData+m_world_posY_MSB]		; pick up msb of map y coord
					SBC		0										; add carry from previous addition
					LD		[g_worldData+m_world_posY_MSB],A		; store new msb of map y coord
				; add scroll delta to screen y pos
					LD		A,[g_worldData+m_world_scrY]			; pick up screen y coord
					SUB		E										; add # pixels to scroll vertically
					LD		[g_worldData+m_world_scrY],A			; store screen y coord
					RET


;********************************************************************
; NAME:	BlockVRAMOffset												*
;																	*
;																	*
;********************************************************************
					FT_GAME
BlockVRAMOffset:	PUSH	AF
					PUSH	BC
				; get block width & height
					LD		A,[g_blockPtr]
					LD		C,A
					LD		A,[g_blockPtr+1]
					LD		B,A
					INC		BC
					INC		BC
					LD		A,[BC]
					INC		BC
					ADD		L
					LD		L,A
					LD		A,[BC]
					ADC		H
					LD		H,A
					POP		BC
					POP		AF
					RET


;********************************************************************
; NAME:	GetBlockData												*
; I/P:	B	-- floor # to retrieve block data for					*
;		DE	-- -> floor component lookup table						*
;																	*
;********************************************************************
					FT_GAME
GetBlockData:		PUSH	HL
					LD		A,B
					ADD		A										; * 2
					ADD		E
					LD		L,A
					LD		A,D
					ADC		0
					LD		H,A
				; get -> block attributes
					LD		A,[HL+]									; pick up block width
					LD		[g_blockWidth],A
					LD		A,[HL+]
					LD		[g_blockHeight],A
					LD		A,[HL+]
					LD		[g_blockVRAMOffset],A
					LD		A,[HL+]
					LD		[g_blockVRAMOffset+1],A
				; get animation frame & calculate pointers
					LD		A,[HL+]
					ADD		A
					ADD		A
					ADD		L
					LD		L,A
					LD		A,0
					ADC		H
					LD		H,A
				; get -> attribute map
					LD		A,[HL+]


					LDH		[g_blockPtr],A
					LD		A,[HL+]
					LDH		[g_blockPtr+1],A
				; get -> attribute map
					LD		A,[HL+]
					LDH		[g_attrPtr],A
					LD		A,[HL+]
					LDH		[g_attrPtr+1],A
				; get -> index map
					LD		A,[HL+]
					LDH		[g_indexPtr],A
					LD		A,[HL]
					LDH		[g_indexPtr+1],A
					POP		HL
					RET


;********************************************************************
; NAME:	GetBlockPtrs												*
; I/P:	B	-- room # to retrieve block ptrs for					*
;		DE	-- block type code #									*
;																	*
;********************************************************************
					FT_GAME
GetBlockPtrs:		PUSH	HL
					LD		A,B
					ADD		A										; * 2
					ADD		A										; * 4
					ADD		B										; * 5
					ADD		B										; * 6
					ADD		E
					LD		L,A
					LD		A,D
					ADC		0
					LD		H,A
				; get -> block attributes
					LD		A,[HL+]
					LDH		[g_blockPtr],A
					LD		A,[HL+]
					LDH		[g_blockPtr+1],A
				; get -> attribute map
					LD		A,[HL+]
					LDH		[g_attrPtr],A
					LD		A,[HL+]
					LDH		[g_attrPtr+1],A
				; get -> index map
					LD		A,[HL+]
					LDH		[g_indexPtr],A
					LD		A,[HL]
					LDH		[g_indexPtr+1],A
					POP		HL
					RET


;********************************************************************
; NAME:	GetBlockAttrPtr												*
;																	*
;																	*
;********************************************************************
					FT_GAME
GetBlockAttrPtr:	PUSH	AF
					LD		A,[g_attrPtr]
					LD		C,A
					LD		A,[g_attrPtr+1]
					LD		B,A
					POP		AF
					RET


;********************************************************************
; NAME:	GetBlockIndexPtr											*
;																	*
;																	*
;********************************************************************
					FT_GAME
GetBlockIndexPtr:	PUSH	AF
					LD		A,[g_indexPtr]
					LD		C,A
					LD		A,[g_indexPtr+1]
					LD		B,A
					POP		AF
					RET


;********************************************************************
; NAME:	GetBlockSize												*
;																	*
;																	*
;********************************************************************
					FT_GAME
GetBlockSize:		PUSH	AF
					PUSH	HL
				; get block width & height
					LD		A,[g_blockPtr]
					LD		L,A
					LD		A,[g_blockPtr+1]
					LD		H,A
					LD		A,[HL+]
					LD		D,A
					LD		E,[HL]
					POP		HL
					POP		AF
					RET


;********************************************************************
; NAME:	DrawBlock													*
;																	*
;																	*
;********************************************************************
					FT_GAME
DrawBlock2:			PUSHALL
					CALL	GetBlockPtrs2
				; get block size
					CALL	GetBlockSize
				; calculate vram address for background
					CALL	BlockVRAMOffset
					VRAMBANK	1									; set vram bank 1
					CALL	GetBlockAttrPtr
					CALL	CopyBlock
					VRAMBANK	0									; set vram bank 0
					CALL	GetBlockIndexPtr
					CALL	CopyBlock
					POPALL
					RET


;********************************************************************
; NAME:	DrawBlock													*
;																	*
;																	*
;********************************************************************
					FT_GAME
DrawBlock:			PUSHALL
					CALL	GetBlockPtrs
				; get block size
					CALL	GetBlockSize
				; calculate vram address for background
					CALL	BlockVRAMOffset
					VRAMBANK	1									; set vram bank 1
					CALL	GetBlockAttrPtr
					CALL	CopyBlock
					VRAMBANK	0									; set vram bank 0
					CALL	GetBlockIndexPtr
					CALL	CopyBlock
					POPALL
					RET


;********************************************************************
; NAME:	NextVRAMRow													*
; I/P:	HL	-- vram address											*
;																	*
;********************************************************************
NextVRAMRow:		MACRO
					PUSH	AF							; 4
					LD		A,L							; 1
					AND		$E0							; 2
					ADD		32							; 2
					LD		L,A							; 1
					LD		A,0							; 2
					ADC		H							; 1
					AND		$03							; 2
					OR		$98							; 2
					LD		H,A							; 1
					POP		AF							; 3
					ENDM


;********************************************************************
; NAME:	DrawRoomFeature												*
; I/P:	B	-- feature type code #									*
;		HL	-- -> vram												*
;																	*
;********************************************************************
					FT_GAME
DrawRoomFeature:	PUSHALL
					XOR		A
					CP		B
					JR		EQ,.ExitFeature
					PUSHBK	BANK(FeatureTypeTable)
				; calculate address of graphic data for specified feature type
					LD		DE,FeatureTypeTable
				; block copy background to vram
					CALL	DrawBlock
					POPBK
.ExitFeature:		POPALL
					RET


;********************************************************************
; NAME:	DrawRoomBkg													*
; I/P:	B	-- bkg type code #										*
;		HL	-- -> vram												*
;																	*
;********************************************************************
					FT_GAME
DrawRoomBkg:		PUSHALL
					XOR		A
					CP		B
					JR		EQ,.ExitBkg
					PUSHBK	BANK(BkgTypeTable)
					LD		DE,BkgTypeTable
					CALL	DrawBlock
					POPBK
.ExitBkg:			POPALL
					RET


;********************************************************************
; NAME:	DrawRoomFloor												*
; I/P:	B	-- floor type code #									*
;		HL	-- -> vram												*
;																	*
;********************************************************************
					FT_GAME
DrawRoomFloor:		PUSHALL
					XOR		A
					CP		B
					JR		EQ,.ExitFloor
					PUSHBK	BANK(FloorTypeTable)
					BREAK
					LD		A,[FloorTypesCount]
					CP		B
					JR		C,.ExitFloor
				; calculate vram address for floor
					LD		DE,FloorTypesTable
					CALL	DrawBlock2
					POPBK
.ExitFloor:			POPALL
					RET


;********************************************************************
; NAME:	DrawRoom													*
;																	*
;																	*
;********************************************************************
					FT_GAME
ClearRoom:			PUSHALL
					PUSH	HL
					VRAMBANK	1
					LD		A,0
					LD		B,6
.ClearAttrRow:		LD		C,20
.ClearAttrTile:		WaitForVRAM
					LD		A,$03
					LD		[HL+],A
					DEC		C
					JR		NZ,.ClearAttrTile
					NextVRAMRow
					DEC		B
					JR		NZ,.ClearAttrRow

					POP		HL
					VRAMBANK	0
					LD		A,$03
					LD		B,6
.ClearIndexRow:		LD		C,20
.ClearIndexTile:	WaitForVRAM
					LD		A,$00
					LD		[HL+],A
					DEC		C
					JR		NZ,.ClearIndexTile
					NextVRAMRow
					DEC		B
					JR		NZ,.ClearIndexRow
					POPALL
					RET


;********************************************************************
; NAME:	DrawTopRoom													*
;																	*
;																	*
;********************************************************************
					FT_GAME
DrawTopRoom:
					LD		A,[g_worldData+m_world_room]
					DEC		A
					CP		$FF
					JR		NE,.NotNegative
					XOR		A
.NotNegative:		LD		B,A
					CALL	DrawRoom
					RET


;********************************************************************
; NAME:	DrawBottomRoom												*
;																	*
;																	*
;********************************************************************
					FT_GAME
DrawBottomRoom:
					LD		A,[g_worldData+m_world_room]
					ADD		3
					CP		29
					JR		LT,.NotOffEndOfMap
					LD		A,29
.NotOffEndOfMap:	LD		B,A
					CALL	DrawRoom
					RET


;********************************************************************
; NAME:	DrawRoom													*
;																	*
;																	*
;********************************************************************
					FT_GAME
RoomVRAMOffset:	DW		32*0, 32*6, 32*12, 32*18, 32*24, 32*30, 32*4, 32*10, 32*16, 32*22, 32*28, 32*2, 32*8, 32*14, 32*20, 32*26

; i/p:	B	-- room # to draw

DrawRoom:			PUSHALL
				; calculate room data address
					PUSHBK	BANK(LEVEL_1)
					LD		D,B
					LD		C,B
					LD		B,0
					SLA16	BC,3
					LD		A,(LEVEL_1 & $FF)
					ADD		C
					LD		L,A
					LD		A,((LEVEL_1>> 8) & $FF)
					ADC		B
					LD		H,A
				; copy room data to temporary buffer
					PUSH	BC
					LD		E,16
					LD		BC,g_roomData
.CopyRoomData:		LD		A,[HL+]
					LD		[BC],A
					INC		BC
					DEC		E
					JR		NZ,.CopyRoomData
					POP		BC
				; calculate vram address
					LD		A,D
					AND		$0F
					ADD		A
					ADD		(RoomVRAMOffset & $FF)
					LD		L,A
					LD		A,((RoomVRAMOffset >> 8) & $FF)
					ADC		0
					LD		H,A
					LD		A,[HL+]
					LD		H,[HL]
					LD		L,A
					LD		A,(k_VRAM_BG_LOW & $FF)
					ADD		L
					LD		L,A
					LD		A,((k_VRAM_BG_LOW >> 8) & $FF)
					ADC		H
					LD		H,A

				; clear room
					CALL	ClearRoom
				; draw background
					LD		A,[g_roomData+1]
					LD		B,A
					CALL	DrawRoomBkg
				; draw floor
					LD		A,[g_roomData+0]
					LD		B,A
					CALL	DrawRoomFloor
				; draw exits
;					CALL	DrawRoomExits
				; draw special features
					CALL	DrawRoomFeature
				; draw creatures
;					CALL	DrawRoomCreature
				; draw items
;					CALL	DrawRoomItem
					POPBK
					POPALL
					RET


;********************************************************************
; NAME:	DrawRoomFeature												*
;																	*
;																	*
;********************************************************************
DrawRoomFeature:	PUSHALL
				; draw ladder
					BREAK
					LD		A,[g_roomData+6]
					AND		k_FEATURE_LADDER_MSK
					JR		Z,.NoLadder
					LD		B,k_FEATURE_LADDER
					CALL	DrawRoomFeature
				; draw save point
.NoLadder:			LD		A,[g_roomData+6]
					AND		k_FEATURE_SAVE_POINT_MSK
					JR		Z,.NoSavePoint
					LD		B,k_FEATURE_SAVE_POINT
					CALL	DrawRoomFeature
.NoSavePoint:
				POPALL
				RET

;********************************************************************
; NAME:	CopyBlock													*
;																	*
;																	*
;********************************************************************
					RSSET	$FF80
k_BLOCK_WIDTH		RB		1

					FT_GAME
CopyBlock:			PUSHALL
					LD		A,H
					AND		$03
					OR		$98
					LD		H,A
					LD		A,D										; get width of block to copy
					LDH		[k_BLOCK_WIDTH],A						; save width of block to copy
				; copy tile indices
.CopyRow:			LDH		A,[k_BLOCK_WIDTH]						; get width of block to copy
					LD		D,A										; set loop counter for width of block to copy
				; copy an entire row of tile indices
.CopyTile:			WaitForVRAM										; wait for vram to become available
					LD		A,[BC]									; pick up current tile index from source data
					LD		[HL+],A									; store new tile index in vram
					INC		BC										; increment dest ->
					DEC		D										; decrement # tiles to copy in this row
					JR		NZ,.CopyTile							; more tiles in this row? yes, so copy another tile
				; step to next vram row
					LDH		A,[k_BLOCK_WIDTH]						; pick up width of block to copy
					LD		D,A										; copy width of block
					LD		A,32									; # tiles remaining in a vram row after a straight screen copy
					SUB		D										; subtract width of block that was just copied
					ADD		L										; add # tiles remaining to lsb of dest addr
					LD		L,A										; set new lsb of dest addr
					LD		A,0										; msb of # tiles remaining in a vram row
					ADC		H										; add # tiles remaining to msb of dest addr
					AND		$03										; mask valid vram range
					OR		$98										; add start of vram
					LD		H,A										; set new msb of dest addr
					DEC		E										; decrement # rows to copy
					JR		NZ,.CopyRow								; more rows remaining? yes, so draw another row
					POPALL											; restore registers
					RET												; exit function
					PURGE	k_BLOCK_WIDTH


;********************************************************************
; NAME:	GetRoomData													*
;																	*
;																	*
;********************************************************************
					FT_GAME
GetRoomData:
					RET


;********************************************************************
; NAME:	DrawScreen													*
;																	*
;																	*
;********************************************************************
					FT_GAME
DrawScreen:			PUSH	BC
					CALL	DrawRoom
					INC		B
					CALL	DrawRoom
					INC		B
					CALL	DrawRoom
					INC		B
					CALL	DrawRoom
					POP		BC
					RET
