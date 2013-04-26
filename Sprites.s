					INCLUDE	"Sprites.i"
					SECTION "Graphics Data",DATA[$4000],BANK[k_BK_GFX_DATA]
					INCLUDE	"Sprites\\RoomTiles.s"
					INCLUDE	"Sprites\\ATVILogo.s"
					INCLUDE	"Sprites\\FloorTypes.s"
					INCLUDE	"Sprites\\FeatureTypes.s"
					INCLUDE	"Sprites\\BkgTypes.s"

					SECTION "Palette Data",DATA[$6000],BANK[k_BK_GFX_DATA]
RoomPalData:		DW		RoomTilesCGBPal0c0,RoomTilesCGBPal0c1,RoomTilesCGBPal0c2,RoomTilesCGBPal0c3
					DW		RoomTilesCGBPal1c0,RoomTilesCGBPal1c1,RoomTilesCGBPal1c2,RoomTilesCGBPal1c3
					DW		RoomTilesCGBPal2c0,RoomTilesCGBPal2c1,RoomTilesCGBPal2c2,RoomTilesCGBPal2c3
					DW		RoomTilesCGBPal3c0,RoomTilesCGBPal3c1,RoomTilesCGBPal3c2,RoomTilesCGBPal3c3
					DW		RoomTilesCGBPal4c0,RoomTilesCGBPal4c1,RoomTilesCGBPal4c2,RoomTilesCGBPal4c3
					DW		RoomTilesCGBPal5c0,RoomTilesCGBPal5c1,RoomTilesCGBPal5c2,RoomTilesCGBPal5c3
					DW		RoomTilesCGBPal6c0,RoomTilesCGBPal6c1,RoomTilesCGBPal6c2,RoomTilesCGBPal6c3
					DW		RoomTilesCGBPal7c0,RoomTilesCGBPal7c1,RoomTilesCGBPal7c2,RoomTilesCGBPal7c3

					SECTION	"ATVI Palette",DATA
ATVILogoPalData:	DW		ATVILogoCGBPal0c1,ATVILogoCGBPal0c2,ATVILogoCGBPal0c3
					DW		ATVILogoCGBPal1c1,ATVILogoCGBPal1c2,ATVILogoCGBPal1c3
					DW		ATVILogoCGBPal2c1,ATVILogoCGBPal2c2,ATVILogoCGBPal2c3

					SECTION	"Score Palette",DATA
ScorePalData:		DW		ATVILogoCGBPal0c1,ATVILogoCGBPal0c2,ATVILogoCGBPal0c3
					DW		ATVILogoCGBPal1c1,ATVILogoCGBPal1c2,ATVILogoCGBPal1c3
