					INCLUDE	"Standard.i"
					INCLUDE	"GlobalData.i"
					INCLUDE "Initialise.i"
					INCLUDE "Sprites.i"
					INCLUDE	"Object.i"
					INCLUDE	"Level.i"
					INCLUDE "Font.i"
					INCLUDE "Shift.i"
					INCLUDE "Pitfall2.i"
					INCLUDE "Score.i"
					INCLUDE	"Player.i"
					INCLUDE "Sound.inc"
					INCLUDE	"PlayerData.i"
					INCLUDE	"Logo.i"
										
					GLOBAL	CodeStart


;********************************************************************
; NAME:	CodeStart													*
; REGS:	AF,HL,BC,DE													*
;																	*
; This function is the main entry point to the game. It initialises	*
; the gameboy, sets up the levels, runs the main game loop, and		*
; handles everything else required.									*
;																	*
;********************************************************************
					DT_VARS
					SECTION "Code Start",HOME[$150]
CodeStart:			LD		SP,g_stackTop							; -> stack to stack ram
					LD		[g_cpuType],A							; store gameboy type
CodeRestart:		CALL	Initialise								; initialise gameboy
					CALL	DoubleSpeed								; kick gameboy in to double-speed mode
					CALL	InitGame
					ROMBANK	1										; switch to default rom bank
					CALL	PlayGame

.WaitForever:		JR		.WaitForever


;********************************************************************
; NAME:	PlayGame													*
;																	*
;********************************************************************
					FT_GAME
PlayGame:								
					XOR		A										; set game is paused flag to false
					LD		[g_isPaused],A							; store is paused flag
				; initialise game
					CALL	ScoreReset								; reset player's score
PlayLevel:
					LD		A,1										; set player is alive flag to true
					LD		[g_player_isAlive],A					; store player is alive flag


;********************************************************************
;																	*
; GameLoop															*
;																	*
;********************************************************************
GameLoop:			
					WaitForVBLDone									; wait for vbl
					LD		A,[g_scrollingLogo]
					OR		A
					CALL	NZ,ScrollATVILogo
				; FIX THIS -- also need to set palettes at this point
				; FIX THIS -- also need to redraw the background map
					LD		A,[g_player_isAlive]					; pick up player is alive flag
					OR		A										; test player is alive flag
					JP		Z,PlayerDead							; player is dead? yes, so handle player death
					LD		A,[g_isPaused]							; pick up is game paused flag
					OR		A										; test pause flag
					JP		NZ,GamePaused							; pause flag=true? yes, so pause the game
					CALL	HandlePlayerInput						; handle player input
					IF		k_SOUND_ENABLE==1
					CALL	sound_update							; update in-game sound
					ENDC


					LD		A,[g_vblDone]							; pick up is vbl complete flag?
					OR		A										; test flag
					JP		NZ,GameLoop								; vbl complete? no, wait until it is
					XOR		A										; set vbl done flag to false
					LD		[g_vblDone],A							; store new vbl done flag
					; wait for vbl done flag to be true (it might already be true)
.Pause1:			LD		A,[g_vblDone]							; pick up is vbl complete flag?
					OR		A										; test flag
					JR		Z,.Pause1								; vbl complete? no, wait until it is
					JP		GameLoop								; perform next game frame
