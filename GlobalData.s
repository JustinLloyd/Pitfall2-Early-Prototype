					INCLUDE	"Standard.i"
					INCLUDE	"GlobalData.i"
;					INCLUDE	"StaticData.i"


					SECTION	"GlobalData",BSS[$C000]					; must absolutely, positively, be here
g_cpuType:			DS		1										; gameboy console type id
g_stack:			DS		255										; reserve 256 bytes for stack (must be on a 256 byte boundary)
g_stackTop:															; top of stack
					SECTION	"SpriteBuffer",BSS[$C100]				; must absolutely, positively, be on a 256 byte boundary
g_spriteBuffer:		DS		16*32									; vram buffer for dynamic sprite data
					SECTION	"TileBuffer",BSS[$C300]					; must absolutely, positively, be on a 256 byte boundary
g_bkgTileBuffer:	DS		16*32									; vram buffer for dynamic background tiles
					SECTION	"OAMBuffer",BSS[$C500]					; must absolutely, positively, be on a 256 byte boundary
g_oamBuffer:		DS		160										; oam buffer for doing dma to/from oam
					DS		16										; padding bytes for optimisation
					SECTION	"ScoreBuffer",BSS[$C600]				; must absolutely, positively, be on a 256 byte boundary
g_scoreBuffer:		DS		16*6									; buffer for drawing score digits
					SECTION	"LogoBuffer",BSS[$C700]					; must absolutely, positively, be on a 256 byte boundary
g_logoBuffer:		DS		16*6									; buffer for drawing animated atvi logo
					SECTION	"PalBuffer",BSS[$C800]					; must absolutely, positively, be on a 256 byte boundary
g_palBuffer:		DS		4*2*6									; palette buffer for dynamic palettes

;					SECTION	"StaticBuffer",BSS[$C900]					; must absolutely, positively, be on a 256 byte boundary
;g_staticBuffer:		DS		4*k_MAX_STATICS

;					DT_VARS
g_vblFrameCount:	DS		2										; VBL frame counter
g_musicEnabled:		DS		1										; is in-game music currently enabled?
;g_tuneNumber:		DS		1										; tune # currently playing
;g_controlMethod:	DS		1										; joypad layout for control
;g_ctrlMethodFunc:	DS		2
g_vblDone:			DS		1										; vbl flag (true=vbl is complete)
g_isPaused:			DS		1
g_nextOAMCount:		DS		1
g_nextOAMEntry:		DS		2
g_nextOBPCount:		DS		1
g_nextTileCount:	DS		1
g_nextTileEntry:	DS		2
;g_nextStaticCount:	DS		1
;g_nextStaticEntry:	DS		2
;g_serialStatus:		DS		1
;g_serialInput:		DS		1
;g_serialOutput:		DS		1
g_scoreChanged:		DS		1										; has player score changed since last frame?
g_scrollingLogo:	DS		1										; is atvi logo scrolling?
g_logoFrame:		DS		1										; frame # of atvi logo
g_logoPause:		DS		1										; pause duration of atvi logo


; move the following in to it's own .S/.I file eventually
; it should be declared on a 256-byte boundary, that way, you can "INC L" and not be concerned with wrap.
; You can also "LD L,0" and point to the start of the world data.
					SECTION	"WorldData",BSS[$CA00]
g_worldData:		DS		m_world_SIZEOF
					PRINTT	"World data struct size is "
					PRINTV	m_world_SIZEOF
					PRINTT	" bytes.\n"


