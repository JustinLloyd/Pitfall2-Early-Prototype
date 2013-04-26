					IF		!DEF(__GLOBALDATA_I__)
__GLOBALDATA_I__	SET		1
					GLOBAL	g_stack
					GLOBAL	g_stackTop
					GLOBAL	g_spriteRAM
					GLOBAL	g_vblFrameCount
					GLOBAL	g_controlMethod
;					GLOBAL	g_ctrlMethodFunc
					GLOBAL	g_cpuType
					GLOBAL	g_vblDone
					GLOBAL	g_worldData
					GLOBAL	g_oamBuffer
					GLOBAL	g_spriteBuffer
					GLOBAL	g_bkgTileBuffer
					GLOBAL	g_palBuffer
					GLOBAL	g_musicEnabled
					GLOBAL	g_tuneNumber
					GLOBAL	g_nextOAMEntry
					GLOBAL	g_nextOAMCount
					GLOBAL	g_nextOBPCount
					GLOBAL	g_nextTileCount
					GLOBAL	g_nextTileEntry
					GLOBAL	g_isPaused
					GLOBAL	g_scoreChanged
					GLOBAL	g_scrollingLogo
					GLOBAL	g_logoFrame
					GLOBAL	g_logoPause


; positions of on-screen components
k_SCORE_X			EQU		30										; horizontal position of score on screen
k_SCORE_Y			EQU		4										; vertical position of score on screen
k_ATVI_LOGO_X		EQU		20										; horizontal position of atvi logo on screen
k_ATVI_LOGO_Y		EQU		148										; vertical position of atvi logo on screen

; sprite assignments
k_ATVI_SPR_START	EQU		30										; first sprite # that atvi logo will use


; palette assignments
k_OBP_SCORE			EQU		6										; score palette
k_OBP_ATVI_LOGO0	EQU		5										; atvi logo palette #0
k_OBP_ATVI_LOGO1	EQU		6										; atvi logo palette #1
k_OBP_ATVI_LOGO2	EQU		7										; atvi logo palette #2

					RSRESET
m_world_posX		RB		0										; scroll x position on world map (16-bit)
m_world_posX_LSB	RB		1										; scroll x position on world map LSB
m_world_posX_MSB	RB		1										; scroll x position on world map MSB
m_world_posY		RB		0										; scroll y position on world map (16-bit)
m_world_posY_LSB	RB		1										; scroll y position on world map LSB
m_world_posY_MSB	RB		1										; scroll y position on world map MSB
m_world_scrX		RB		1										; screen x position 
m_world_scrY		RB		1										; screen y position
m_world_scrollY		RB		1										; vertical scroll counter
;m_world_scrollX		RB		1										; horizontal scroll counter
m_world_level		RB		1										; current level index #
m_world_room		RB		1										; current room number
m_world_mapWidth	RB		1										; width of map
m_world_mapHeight	RB		1										; height of map
m_world_scrRowOff	RB		2
m_world_SIZEOF		RB		0										; size of the world structure in bytes
					ENDC
