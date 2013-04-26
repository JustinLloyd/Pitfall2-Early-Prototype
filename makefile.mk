# General Defines
# ======================================================================

#
# general declares

#
# comment out the following line for a release build
DEFDEBUG =-DDEBUG

#
# include directories, add any extra include paths here
INCDIRS =-ic:\gameboy\include\

# Compiler/Assembler/Linker Options
# ======================================================================
GBDK2RGB=c:\gameboy\bin\gbdk2rgbds.exe
CC=c:\gameboy\sdk\bin\lcc
ASM=c:\gameboy\bin\rgbasm.exe 
#ASM=c:\work\gameboy\rgbasm\debug\rgbasm.exe 
LINK=c:\gameboy\bin\xlink.exe
FIXUP=c:\gameboy\bin\rgbfix.exe

CCOPTIONS=-A -Wa-l -c
ASMOPTIONS =-rd -dDep.txt
LINKOPTS =-mPitfall2.map -nPitfall2.sym
FIXUPOPTS =-o -pff -v -b19

# Project Files
# ======================================================================
OBJS =	Makefile.mk \
	Linkfile.lik \
	Pitfall2.obj \
	ROMHeader.obj \
	Utility.obj \
	Initialise.obj \
	Joypad.obj \
	GlobalData.obj \
	Font.obj \
	FontData.obj \
	CopyData.obj \
	Interrupts.obj \
	Sprites.obj \
	Level.obj \
	sound.obj \
	Object.obj \
	Score.obj \
	Player.obj \
	PlayerData.obj \
	Pickup.obj \
	rooms.obj \
	logo.obj \
	RoomData.obj \
	banks.obj


# Project Targets
# ======================================================================
Pitfall2.gb: $(OBJS)
#	cd objs
	$(LINK) $(LINKOPTS) linkfile.lik
#	cd ..
	$(FIXUP) $(FIXUPOPTS) Pitfall2.gb
	copy Pitfall2.gb "c:\gameboy\no$$gmb\slot\Pitfall2.gb"
	copy Pitfall2.sym "c:\gameboy\no$$gmb\slot\Pitfall2.sym"

#	copy Pitfall2.gb "\\miyuki\slot\Pitfall2.gb"
#	copy Pitfall2.sym "\\miyuki\slot\Pitfall2.sym"


# Other Targets
# ======================================================================
clean:
	del *.obj
	del *.o
	del *.gb
	del dep.txt


# Implicit Rules
# ======================================================================
.c.obj:
	$(CC) $(CCOPTIONS) -A -c -o $&.o $&.c
	$(GBDK2RGB) $&.o $&.obj

.s.obj:
	$(ASM) $(ASMOPTIONS) -o$&.obj $&.S

.asm.obj:
	$(ASM) $(ASMOPTIONS) -o$&.obj $&.ASM

.z80.obj:
	$(ASM) $(ASMOPTIONS) -o$&.obj $&.Z80

#.c.s:
#	$(CC) -A -S $&.c


# Build Dependencies
# ======================================================================
Pitfall2.obj: Pitfall2.S Standard.i Hardware.i Math.i Load.i Joypad.i CopyData.i Utility.i Banks.i Sprites.i Sprites\RoomTiles.i Sprites\ATVILogo.i Sprites\GroundTiles.inc GlobalData.i Initialise.i Object.i Font.i Shift.i Pitfall2.i Score.i Player.i Sound.inc PlayerData.i Logo.i 
ROMHeader.obj: ROMHeader.S 
Utility.obj: Utility.S Standard.i Hardware.i Math.i Load.i Joypad.i CopyData.i Utility.i Banks.i Sprites.i Sprites\RoomTiles.i Sprites\ATVILogo.i Sprites\GroundTiles.inc Shift.i GlobalData.i Font.i 
Initialise.obj: Initialise.S Standard.i Hardware.i Math.i Load.i Joypad.i CopyData.i Utility.i Banks.i Sprites.i Sprites\RoomTiles.i Sprites\ATVILogo.i Sprites\GroundTiles.inc GlobalData.i Initialise.i Object.i Level.i Font.i Sound.inc Interrupts.i Player.i Logo.i 
Joypad.obj: Joypad.S Standard.i Hardware.i Math.i Load.i Joypad.i CopyData.i Utility.i Banks.i Sprites.i Sprites\RoomTiles.i Sprites\ATVILogo.i Sprites\GroundTiles.inc 
GlobalData.obj: GlobalData.S Standard.i Hardware.i Math.i Load.i Joypad.i CopyData.i Utility.i Banks.i Sprites.i Sprites\RoomTiles.i Sprites\ATVILogo.i Sprites\GroundTiles.inc GlobalData.i 
Font.obj: Font.S Banks.i Font.i FontData.i Hardware.i Utility.i Shift.i 
FontData.obj: FontData.S Banks.i FontData.i 
CopyData.obj: CopyData.S standard.i Hardware.i Math.i Load.i Joypad.i CopyData.i Utility.i Banks.i Sprites.i Sprites\RoomTiles.i Sprites\ATVILogo.i Sprites\GroundTiles.inc 
Interrupts.obj: Interrupts.S Standard.i Hardware.i Math.i Load.i Joypad.i CopyData.i Utility.i Banks.i Sprites.i Sprites\RoomTiles.i Sprites\ATVILogo.i Sprites\GroundTiles.inc GlobalData.i Interrupts.i Logo.i 
Sprites.obj: Sprites.S Sprites.i Banks.i Sprites\RoomTiles.i Sprites\ATVILogo.i Sprites\GroundTiles.inc Sprites\RoomTiles.s Sprites\ATVILogo.s Sprites\FloorTypes.s Sprites\FloorTypes.i RoomData.i Sprites\FeatureTypes.s Sprites\FeatureTypes.i Sprites\BkgTypes.s Sprites\BkgTypes.i 
Level.obj: Level.S Standard.i Hardware.i Math.i Load.i Joypad.i CopyData.i Utility.i Banks.i Sprites.i Sprites\RoomTiles.i Sprites\ATVILogo.i Sprites\GroundTiles.inc GlobalData.i Level.i Shift.i RoomData.i Sprites\FloorTypes.i Sprites\FeatureTypes.i Sprites\BkgTypes.i Rooms.i Rooms\Room1.i 
sound.obj: sound.S regmap.inc sound.inc Banks.i tune_0.inc tune_2.inc tune_3.inc 
Object.obj: Object.S Standard.i Hardware.i Math.i Load.i Joypad.i CopyData.i Utility.i Banks.i Sprites.i Sprites\RoomTiles.i Sprites\ATVILogo.i Sprites\GroundTiles.inc GlobalData.i Initialise.i Object.i Sound.inc Shift.i 
Score.obj: Score.S Standard.i Hardware.i Math.i Load.i Joypad.i CopyData.i Utility.i Banks.i Sprites.i Sprites\RoomTiles.i Sprites\ATVILogo.i Sprites\GroundTiles.inc GlobalData.i Score.i PlayerData.i 
Player.obj: Player.S Standard.i Hardware.i Math.i Load.i Joypad.i CopyData.i Utility.i Banks.i Sprites.i Sprites\RoomTiles.i Sprites\ATVILogo.i Sprites\GroundTiles.inc GlobalData.i Pitfall2.i Score.i Player.i 
PlayerData.obj: PlayerData.S PlayerData.i 
Pickup.obj: Pickup.S Standard.i Hardware.i Math.i Load.i Joypad.i CopyData.i Utility.i Banks.i Sprites.i Sprites\RoomTiles.i Sprites\ATVILogo.i Sprites\GroundTiles.inc Object.i GlobalData.i Score.i 
rooms.obj: rooms.S Rooms\Room1.i Rooms\Room1.s 
Logo.obj: Logo.S Standard.i Hardware.i Math.i Load.i Joypad.i CopyData.i Utility.i Banks.i Sprites.i Sprites\RoomTiles.i Sprites\ATVILogo.i Sprites\GroundTiles.inc GlobalData.i Logo.i 
RoomData.obj: RoomData.S RoomData.i 
banks.obj: banks.S Banks.i 
