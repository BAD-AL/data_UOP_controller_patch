mkdir working 
del  /Q working\*
 
:: un-comment to Generate Debug Code:
set LUA_DEBUG_SYMBOLS=""

:: common.lvl 
LVLTool  -file lvl_feb9/common.lvl   -o working\common.lvl -a uop\popup_prompt.lua 
LVLTool  -file working/common.lvl -r uop\ifs_pausemenu.lua 
LVLTool  -file working/common.lvl -r uop\ifs_teamstats.lua 

:: ingame.lvl 
LVLTool  -file lvl_feb9/ingame.lvl     -o working\ingame.lvl -a uop\fakeconsole_functions.lua 
LVLTool  -file working/ingame.lvl   -a uop\utility_functions2.lua 
LVLTool  -file working/ingame.lvl   -r uop\ifs_fakeconsole.lua 
::LVLTool -file  working/ingame.lvl  -r uop\ifs_sideselect.lua ???
LVLTool  -file working/ingame.lvl   -r patch\game_interface.lua 

:: shell.lvl 
LVLTool  -file lvl_feb9/shell.lvl     -o working\shell.lvl -r uop\ifs_freeform_battle_mode.lua 
LVLTool  -file working/shell.lvl   -a uop\ifs_era_handler.lua 
LVLTool  -file working/shell.lvl   -r uop\ifs_instant_options.lua 
LVLTool  -file working/shell.lvl   -r uop\ifs_missionselect.lua 
LVLTool  -file working/shell.lvl   -r uop\ifs_missionselect_pcmulti.lua 
LVLTool  -file working/shell.lvl   -r uop\ifs_mpgs_pclogin.lua 
LVLTool  -file working/shell.lvl   -r uop\ifs_login.lua 
LVLTool  -file working/shell.lvl   -r uop\ifs_sp_campaign.lua 
LVLTool  -file working/shell.lvl   -r uop\missionlist.lua 
LVLTool  -file working/shell.lvl   -r patch\shell_interface.lua 
LVLTool  -file working/shell.lvl   -r patch\iface_bgmeta_space.tga
