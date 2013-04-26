					INCLUDE	"PlayerData.i"
					
; move the following in to it's own .S/.I file eventually
; it should be declared on a 256-byte boundary, that way, you can "INC L" and not be concerned with wrap.
; You can also "LD L,0" and point to the start of the player data.
					SECTION	"PlayerData",BSS[$CD00]
g_player:															; player structure
g_player_score:		DS		4										; total score for player (BCD format)
g_player_isAlive:	DS		1										; true if player is alive
g_player_bonus:		DS		1
