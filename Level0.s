;
; level 0 data file

					SECTION	"Level 0 Tile Data",DATA[$4000],BANK[k_BK_LEVEL_0_TILE_DATA]
					; define tile data here
					; should not be larger than $1E00 bytes or 480 tiles

					SECTION "Level 0 Map Info",DATA[$5E00],BANK[k_BK_LEVEL_0_TILE_DATA]
					; define map info here, this includes dimensions of map, etc

					SECTION "Level 0 Palette Data",DATA[$6100],BANK[k_BK_LEVEL_0_TILE_DATA]
					; define palette data here
