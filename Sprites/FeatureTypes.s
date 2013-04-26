					INCLUDE	"Sprites\\FeatureTypes.i"
					INCLUDE	"RoomData.i"
					
					SECTION	"FeatureType",DATA
FeatureTypeTable:	DW		0,0,0
					DW		Feature1_Data,Feature1_Attr,Feature1_Map
					DW		Feature2_Data,Feature2_Attr,Feature2_Map

; k_FEATURE_0_NONE
					; no data defined for this background type

; k_FEATURE_1_SAVE_POINT
Feature1_Data:		DB		1,1
					DW		k_VRAM_SAVE
Feature1_Attr:		DB		$04
Feature1_Map:		DB		$17

; k_FEAT_LADDER
Feature2_Data:		DB		2,4
					DW		k_VRAM_LADDER
Feature2_Attr:		DB		$03,$23
					DB		$03,$23
					DB		$03,$23
					DB		$03,$23
Feature2_Map:		DB		$19,$19
					DB		$19,$19
					DB		$19,$19
					DB		$19,$19
