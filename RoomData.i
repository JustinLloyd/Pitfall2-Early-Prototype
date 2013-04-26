					IF		!DEF(__ROOMDATA_I__)
__ROOMDATA_I__		SET		1
					INCLUDE	"test.i"

k_ROOM_W_TILES		EQU		20
k_ROOM_W_PIX		EQU		k_ROOM_W_TILES*8
k_ROOM_H_TILES		EQU		6
k_ROOM_H_PIX		EQU		k_ROOM_H_TILES*8

;k_MAP_W_ROOMS		EQU		8
;k_MAP_H_ROOMS		EQU		30




; vram offsets for special features
k_VRAM_SAVE				EQU		32*4+5
k_VRAM_LADDER			EQU		32*0+9


; vram offsets for background components
k_VRAM_BKG				EQU		32*0+0


; vram offsets for floor components
k_VRAM_FLOOR			EQU		32*4+0



; takes a room #, returns the creature code

GetLeftExit
GetRightExit
GetFloor
GetCreature
GetItem
GetBackground
GetFeature
GetLadder
GetSavePoint

						IF		0
getCreatureCode:		MACRO
						LD		A,L
						AND		$FC
						ADD		m_room_creature
						LD		L,A
						LD		A,[HL]
						SWAP	A
						AND		$0F
						ENDM

getItemCode:			MACRO
						LD		A,L
						AND		$FC
						ADD		m_room_item
						LD		L,A
						LD		A,[HL]
						AND		$0F
						ENDM

getUniqueCode:			MACRO
						LD		A,L
						AND		$FC
						ADD		m_room_unique
						LD		L,A
						LD		A,[HL]
						SWAP	A
						AND		$0F
						ENDM

getSpecialCode:			MACRO
						LD		A,L
						AND		$FC
						ADD		m_room_special
						LD		L,A
						LD		A,[HL]
						AND		$0F
						ENDM

getBackgroundCode:		MACRO
						LD		A,L
						AND		$FC
						ADD		m_room_background
						LD		L,A
						LD		A,[HL]
						SWAP	A
						AND		$0F
						ENDM

getFloorCode:			MACRO
						LD		A,L
						AND		$FC
						ADD		m_room_floor
						LD		L,A
						LD		A,[HL]
						AND		$0F
						ENDM

getExitCode:			MACRO
						LD		A,L
						AND		$FC
						ADD		m_room_exits
						LD		L,A
						LD		A,[HL]
						SWAP	A
						AND		$0F
						ENDM
						ENDC
						ENDC
