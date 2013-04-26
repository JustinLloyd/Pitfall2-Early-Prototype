		;;
		;; regmap.inc
		;;
		;; Register address mapping.
		;;

		;; my own names for the following
_ROMBANK EQU $2000				; Start of selectable Rom Bank 16K 
_BGSCREEN EQU $9800				; Background Screen Data 1
_OAM EQU $FE00					; sprite table

		;; standard GB register names where possible
_P1 EQU $FF00					; Pad port

_TIMA EQU $FF05					;  Timer Counter
_TMA EQU $FF06					;  Timer Modulo
_TAC EQU $FF07					;  Timer Control

		
_IR EQU $FF0F					; Interrupt request
_IE EQU $FFFF					; Interrupt enable

_DIV EQU $FF04					; Divider Register (1/16779 sec)

_LCDC EQU $FF40					; LCD control register
_LY	  EQU $FF44					; LCD control register
_VBK EQU $FF4F					; Display RAM Bank Register selects blocks
_SCX EQU $FF43					; X Scroll value for screen 
		
_NR10 EQU $FF10					; Sound register 1 (Sweep)
_NR11 EQU $FF11					; Sound register 1 (Length/Wave)
_NR12 EQU $FF12					; Sound register 1 (Envelope)
_NR13 EQU $FF13					; Sound register 1 (Frequency Lo)
_NR14 EQU $FF14					; Sound register 1 (Frequency Hi)

		
_NR21 EQU $FF16					; Sound Register 2 (Wave Duty Pattern)
_NR22 EQU $FF17					; Sound Register 2 (Sound Envelope)
_NR23 EQU $FF18					; Sound Register 2 (Frequency Lo)
_NR24 EQU $FF19					; Sound Register 2 (Frequency Hi)

		
_NR30 EQU $FF1A					; Sound Register 3 (Start / Stop)
_NR31 EQU $FF1B					; Sound Register 3 (length)
_NR32 EQU $FF1C					; Sound Register 3 (Output level)
_NR33 EQU $FF1D					; Sound Register 3 (Frequency Lo)
_NR34 EQU $FF1E					; Sound Register 3 (Frequency Hi)
		
_WAVE EQU $FF30					; 15 byte (30 Nibble) Wave table for sound 3
		
_NR41 EQU $FF20					; Sound Register 4 (Sound Length)
_NR42 EQU $FF21					; Sound Register 4 (Envelope)
_NR43 EQU $FF22					; Sound Register 4 (frequency / step)
_NR44 EQU $FF23					; Sound Register 4 (Control)
				
_NR50 EQU $FF24					; Sound Register 5 (Sound Control)
_NR51 EQU $FF25					; Sound Register 5 (Output Terminals)
_NR52 EQU $FF26					; Sound Register 5 (Master Sound Switch)


_BCPS EQU $FF68					; BG Color Palette Write Specification
_BCPD EQU $FF69					; BG Write Data






