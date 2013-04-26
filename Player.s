					INCLUDE	"Standard.i"
					INCLUDE	"GlobalData.i"
					INCLUDE	"Level.i"
					INCLUDE "Pitfall2.i"
					INCLUDE "Score.i"
					INCLUDE	"Player.i"


;************************************************************************
;*																		*
;* NAME:	HandlePlayerInput											*
;*																		*
;* This function reads the joypad for player input and then moves the	*
;* player sprite around depending on what they want to do.				*
;*																		*
;************************************************************************
					FT_GAME
HandlePlayerInput:

					LD		A,[g_joypadStatus]						; pick up current joypad status
					LD		E,A										; copy joypad status
.TryClimbUp:		LD		A,E										; retrieve current joypad status
					AND		A,k_JOYPAD_UP							; is "UP" key pressed?
					JR		Z,.TryClimbDown							; no, look for another key
					LD		A,1										; set amount to scroll map
					CALL	ScrollMapDown							; scroll map down
					JR		.Exit									; look for another key
.TryClimbDown:		LD		A,E										; retrieve current joypad status
					AND		A,k_JOYPAD_DOWN							; is "DOWN" key pressed?
					JR		Z,.Exit									; no, try another key
					LD		A,1										; set amount to scroll map
					CALL	ScrollMapUp								; scroll map up
					JR		.Exit									; look for another key
.TryRestart:		LD		A,E										; retrieve current joypad status
					AND		(k_JOYPAD_SELECT | k_JOYPAD_START)		; mask "SELECT" & "START" keys
					CP		(k_JOYPAD_SELECT | k_JOYPAD_START)		; are "SELECT" & "START" keys pressed?
					JR		NE,.Exit								; no, so just exit input function
					JP		CodeRestart								; warm restart machine
.Exit:				RET												; exit function
