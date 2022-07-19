# Repository
https://github.com/BAD-AL/data_UOP_controller_patch

![PC Controller Support](ControllerSupportThumbnail.png)

## About
In February 2021 There was an Update to Star Wars Battlefront II on Steam.
The release added native controller support to the Steam version of the Game.

The update was reverted the next day due to incompatibilities with the un-official patch. 
I've been tinkering with that release and have gotten it into a functional state with the un-official patch.

## Known bugs:
 * Mouse doesn't work to select planets in galactic conquest. Workaround - use the dpad or left thumbstick instead.
 * Sometimes the 'A' controller button doesn't work to register a move in galactic conquest. Workaround - use the mouse to click the move button.
 * Preview videos don't seem to work on the 'Instant action'/mission select screen.

## Compatibility
 * Steam Game version only. Will not work with any other version of the game. Needs a legal license from Steam, they know what you own and won't let you play unless you own it.
 * You must already own the game on steam in order to use this package. If you do not own the Steam version, then buy it.

 ## Install
 1. Download the latest version from the release section of the repo.
 2. Backup your files (see the notes below to see which files to backup).
 3. Unzip the release package, copy and paste the 'GameData' folder over your 'GameData' folder.
 4. The following folders will be added:
    * GameData/addon/000
    * GameData/addon/AAA-v1.3patch (no changes from the un-official patch release)
 5. The following files will be overwritten (so back these up):
    * GameData/BattlefrontII.exe
    * GameData/alsoft.ini
    * GameData/Galaxy.dll
    * GameData/OpenAI32.dll
    * GameData/steam_api.dll
    * GameData/data/_LVL_PC/movies/pre-movie.mvs
    * GameData/data/_LVL_PC/common.lvl
    * GameData/data/_LVL_PC/ingame.lvl
    * GameData/data/_LVL_PC/shell.lvl

## BF2 Modder
 * BAD_AL

## Special Thanks
 * Pandemic for this awesome Game and modtools
 * Disney for continued support
 * GT-Anakin for reverse-engeneering many of the UOP Lua files
 * Zerted for the original UOP.
