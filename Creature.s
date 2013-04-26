					INCLUDE	"Creature.i"

; bat's start on the left, fly left to right, then cycle right to left
; condor's start on the right, fly right to left, then cycle left to right
; scorpion's start in the center, move left to right, and cycle left to right, they home in on the player
; eel's start on the left, swim left to right, then cycle left to right
; frog's start right of center, hop left, hop right, and repeat

;CreatureData:		DW		BatData
;					DW		ScorpionData

;ScorpionData:		DB		80,5									; start position
;					DW		ScorpionMoveTable						; movement table
					

;ScorpionMoveTable:	DB		1,0

;BatData:			DB		30,30									; start position
;					DW		BatFirstMoveTable						; first movements of bat
;					DW		BatCycleMoveTable

;BatFirstMoveTable:	DB		1,1
;					DB		1,1
;					DB		1,1
;					DB		1,1
;					DB		1,1
;					DB		1,-1
;					DB		1,-1
;					DB		1,-1
;					DB		1,-1
;					DB		1,-1

;BatCycleMoveTable:	DB		-1,1
;					DB		-1,1
;					DB		-1,1
;					DB		-1,1
;					DB		-1,1
;					DB		-1,-1
;					DB		-1,-1
;					DB		-1,-1
;					DB		-1,-1
;					DB		-1,-1

					FT_GAME
CreatureInit:
				; set start position of creature
				; set creature type
				; set animation frame to 0
				; set first move flag
				; set first move index to 0
				; set cycle move index to 0
					RET

					FT_GAME
CreatureMove:
				; get "creature can detect player" flag
				; determine if player is in range
				; if player is in range, home in on player, exit function
				; get first move flag
				; if first move flag = 0, process cycle move
				; get first move index
				; calculate address of movement delta's
				; get x movement delta
				; add to creature x position
				; get y movement delta
				; add to creature y position
				; add 1 to first move index
				; if not end of first move table, exit function
				; set first move flag to 0
				; exit function
				; get cycle move index
				; calculate address of movement delta's
				; get x movement delta
				; add to creature x position
				; get y movement delta
				; add to creature y position
				; add 1 to cycle move index
				; if not end of cycle move table, exit function
				; set cycle move index to 0
				; exit function
					RET

CreatureCollide:
					RET

CreatureUpdate:
					RET
CreatureDraw:
					RET



DrawBat:
DrawScorpion:
DrawFrog:
DrawCondor:
					RET
