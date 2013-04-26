					INCLUDE	"Standard.i"
					INCLUDE "Joypad.i"

;********************************************************************
;*																	*
;*																	*
;*																	*
;* REGS: A,B														*
;*																	*
;********************************************************************
					FT_GAME
ScanJoypad:
					LD		A,k_P1F_5								; set value to output on line P15 ($20)
					LDH		[r_P1],A								; output to joypad control lines ($FF00)
					LDH		A,[r_P1]								; read & discard first value returned ($FF00)
					LDH		A,[r_P1]								; read status lines ($FF00)
					CPL												; joypad input from h/w is inverted, so flip it
					AND		A,$0F									; grab START, SELECT, B, & A buttons
					SWAP	A										; move to high nibble
					LD		B,A										; save button status for later use
					LD		A,k_P1F_4								; set value to output on line P15 ($10)
					LDH		[r_P1],A								; output to joypad control lines ($FF00)
					LDH		A,[r_P1]								; read & discard first few values returned ($FF00)
					LDH		A,[r_P1]								; ($FF00)
					LDH		A,[r_P1]								; ($FF00)
					LDH		A,[r_P1]								; ($FF00)
					LDH		A,[r_P1]								; ($FF00)
					LDH		A,[r_P1]								; read status lines ($FF00)
					CPL												; flip inverted input from h/w
					AND		$0F										; grab d-pad buttons
					OR		B										; mask all joypad buttons together
					SWAP	A										; swap both joypad nibbles

					LD		B,A										; copy current joypad input status
					LD		A,[g_joypadStatus]						; pick up previous joypad input status
					XOR		A,B										; determine which buttons changed since last read
					AND		A,B										; determine those buttons that have been pressed since last read
					LD		[g_joypadChange],A						; save joypad change information
					LD		A,B										; retrieve current joypad input status

					LD		[g_joypadStatus],A						; save new joypad input status
					LD		A,k_P1F_5|k_P1F_4						; set value to reset P14/P15 lines ($30)
					LDH		[r_P1],A								; reset joypad h/w ($FF00)
					RET												; exit function


					DT_VARS	"Joypad"
g_joypadStatus:		DS		1
g_joypadChange:		DS		1
