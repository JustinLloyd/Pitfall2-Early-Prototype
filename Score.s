					INCLUDE	"Standard.i"
					INCLUDE "GlobalData.i"
;					INCLUDE	"Health.i"
					INCLUDE	"Score.i"
					INCLUDE	"PlayerData.i"


;********************************************************************
; NAME:	ScoreReset													*
;																	*
; This function resets the player's score.							*
;																	*
;																	*
;																	*
;********************************************************************
					FT_GAME
ScoreReset:			PUSH	HL
					LD		HL,g_player_score
					XOR		A
					REPT	4
					LD		[HL+],A
					ENDR
					POP		HL
					RET


;********************************************************************
; NAME:	ScoreAdd													*
; I/P:	BC	-- # points to add										*
;																	*
;********************************************************************
					FT_GAME
ScoreAdd:			PUSH	HL
					LD		HL,g_player_score
					LD		A,[HL]
					ADD		C
					LD		[HL+],A
					LD		A,[HL]
					ADC		B
					LD		[HL+],A
					LD		A,[HL]
					ADC		0
					LD		[HL+],A
					LD		A,[HL]
					ADC		0
					LD		[HL+],A
					POP		HL
					RET

;********************************************************************
; NAME:	ScoreSub													*
;																	*
;																	*
;********************************************************************
					FT_GAME
ScoreSub:
					PUSH	HL
					LD		HL,g_player_score
					LD		A,[HL]
					SUB		C
					LD		[HL+],A
					LD		A,[HL]
					SBC		B
					LD		[HL+],A
					LD		A,[HL]
					SBC		0
					LD		[HL+],A
					LD		A,[HL]
					SBC		0
					LD		[HL+],A
					POP		HL
					RET


;********************************************************************
; NAME:	ScorePrint													*
;																	*
;																	*
;********************************************************************
					RSSET	$FF90
k_SCORE_BCD			RB		8
					FT_GAME
ScorePrint:			LD		A,[g_scoreChanged]
					OR		A
					RET		Z
					PUSHALL
					XOR		A
					LD		[g_scoreChanged],A
;					LD		A,[g_player_score]
;					LD		C,A
;					LD		A,[g_player_score+1]
;					LD		B,A
;					LD		A,[g_player_score+2]
;					LD		E,A
;					LD		A,[g_player_score+3]
;					LD		D,A
;					LD		HL,k_SCORE_BCD
;					CALL	Bin2Dec32
;					LD		HL,$9C2B
;					LD		C,$87
;					LDH		A,[k_SCORE_BCD+1]
;					PRINT_DIGITS
;					LDH		A,[k_SCORE_BCD+2]
;					PRINT_DIGITS
;					LDH		A,[k_SCORE_BCD+3]
;					PRINT_DIGITS
;					LDH		A,[k_SCORE_BCD+4]
;					PRINT_DIGITS
					POPALL
					RET
