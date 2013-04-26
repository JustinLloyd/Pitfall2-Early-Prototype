					INCLUDE	"Standard.i"
					INCLUDE	"GlobalData.i"
					INCLUDE "Initialise.i"
					INCLUDE "Sprites.i"

SetLevel:
	calculate level rom bank # from specified level #
	store level rom bank # in global data
	exit function

CopyLevelTiles:
	pick up level rom bank # from global data
	// copy 256 tiles for static background
	// copy 128 tiles for animated background
	// copy 128 tiles for special effects
	exit function

; scroll the map in x & y by delta amounts
ScrollMapLeft:
	
	x = world x - specified delta x
	if x < 0
		delta x = specified delta x - x
		world x = 0
	else
		world x = x
		delta x = specified delta x

	world screen x = world screen x - delta x
	scx = scx - delta x
	boundary = scx mod 7
	if boundary = 0
		
		draw column on left


; position the map at a specific x,y coord
MoveMap:
	store specified x coord in map x coord in global data
	store specified y coord in map y coord in global data
	draw map

; this function draws one column on the left edge of the map, just off screen
DrawLeftEdgeColumn:
	pick up world x coord
	pick up world y coord
	convert x & y to map data memory offset
	add map data memory offset to map data base address

; this function draws one column on the right edge of the map, just off screen
DrawRightEdgeColumn:

; this function draws one row on the top edge of the map, just off screen
DrawTopEdgeRow:

; this function draws one row on the bottom edge of the map, just off screen
DrawBottomEdgeRow:

; this function draws the entire map from scratch
; it repositions the gb scx & scy registers to 16,16
; the map is drawn 4 columns wider, and 4 rows taller than the visible area to allow for scrolling
DrawMap:
	pick up world x coord
	pick up world y coord
	convert x & y to map data memory offset
	add map data memory offset to map data base address
	calculate map pitch from it's width
	subtract screen width from map pitch
	pick up level rom bank #
	select rom bank
	for row=0 to 21
		for col=0 to 23
			add map pitch to map data address
			select tile bank 1
			pick up tile attribute
			store tile attribute at col,row
			select tile bank 0
			pick up tile index number
			store tile index at col,row
		next
	next