mkdir working 
del  /Q working\*
 
:: un-comment to Generate Debug Code:
::set LUA_DEBUG_SYMBOLS=""

:: common.lvl 
LVLTool  -file lvl_feb9/common.lvl   -o working\common.lvl -a uop\popup_prompt.lua 
LVLTool  -file working/common.lvl -r uop\ifs_pausemenu.lua 
::LVLTool  -file working/common.lvl -r uop\ifs_teamstats.lua 
LVLTool  -file working/common.lvl -r 000addme\texture2\bf2_basicbutton_left.tga
LVLTool  -file working/common.lvl -r 000addme\texture2\bf2_basicbutton_mid.tga
LVLTool  -file working/common.lvl -r 000addme\texture2\bf2_basicbutton_right.tga
LVLTool  -file working/common.lvl -r 000addme\texture2\bf2_buttons_botleft.tga
LVLTool  -file working/common.lvl -r 000addme\texture2\bf2_buttons_botright.tga
LVLTool  -file working/common.lvl -r 000addme\texture2\bf2_buttons_items_center.tga
LVLTool  -file working/common.lvl -r 000addme\texture2\bf2_buttons_midleft.tga
LVLTool  -file working/common.lvl -r 000addme\texture2\bf2_buttons_midright.tga
LVLTool  -file working/common.lvl -r 000addme\texture2\bf2_buttons_title_center.tga
LVLTool  -file working/common.lvl -r 000addme\texture2\bf2_buttons_topleft.tga
LVLTool  -file working/common.lvl -r 000addme\texture2\bf2_buttons_topright.tga
LVLTool  -file working/common.lvl -r 000addme\texture2\bf2_buttons_upleft.tga
LVLTool  -file working/common.lvl -r 000addme\texture2\bf2_buttons_upright.tga
LVLTool  -file working/common.lvl -r 000addme\texture2\bf2_dropdown_arrow.tga
LVLTool  -file working/common.lvl -r 000addme\texture2\bf2_radiobutton_off.tga
LVLTool  -file working/common.lvl -r 000addme\texture2\bf2_radiobutton_on.tga
LVLTool  -file working/common.lvl -r 000addme\texture2\buttonleft.tga
LVLTool  -file working/common.lvl -r 000addme\texture2\buttonmid.tga
LVLTool  -file working/common.lvl -r 000addme\texture2\headerbuttonleft.tga
LVLTool  -file working/common.lvl -r 000addme\texture2\headerbuttonleft_highlighted.tga
LVLTool  -file working/common.lvl -r 000addme\texture2\headerbuttonmid.tga
LVLTool  -file working/common.lvl -r 000addme\texture2\headerbuttonmid_highlighted.tga
LVLTool  -file working/common.lvl -r 000addme\texture2\headerbuttonright.tga
LVLTool  -file working/common.lvl -r 000addme\texture2\headerbuttonright_highlighted.tga

:: ingame.lvl 
LVLTool  -file lvl_feb9/ingame.lvl     -o working\ingame.lvl -a uop\fakeconsole_functions.lua 
LVLTool  -file working/ingame.lvl   -a uop\utility_functions2.lua 
LVLTool  -file working/ingame.lvl   -r uop\ifs_fakeconsole.lua 
LVLTool  -file working/ingame.lvl   -r uop\ifs_sideselect.lua 
LVLTool  -file working/ingame.lvl   -r patch\game_interface.lua 

:: shell.lvl 
LVLTool  -file lvl_feb9/shell.lvl  -o working\shell.lvl -r uop\ifs_freeform_battle_mode.lua 
LVLTool  -file working/shell.lvl   -a uop\ifs_era_handler.lua 
LVLTool  -file working/shell.lvl   -r uop\ifs_instant_options.lua 
LVLTool  -file working/shell.lvl   -r uop\ifs_missionselect.lua 
LVLTool  -file working/shell.lvl   -r uop\ifs_missionselect_pcmulti.lua 
LVLTool  -file working/shell.lvl   -r uop\ifs_mpgs_pclogin.lua 

::LVLTool  -file working/shell.lvl   -r uop\ifs_login.lua 
::LVLTool  -file working/shell.lvl   -r uop\ifs_mp_peaderboard.lua ???
::LVLTool  -file working/shell.lvl   -r uop\ifs_mp_sessionlist.lua???

LVLTool  -file working/shell.lvl   -r uop\ifs_sp_campaign.lua 
LVLTool  -file working/shell.lvl   -r uop\missionlist.lua 
LVLTool  -file working/shell.lvl   -r patch\shell_interface.lua 
LVLTool  -file working/shell.lvl   -r patch\iface_bgmeta_space.tga
LVLTool  -file working/shell.lvl   -r patch\shell_movies.config

::copy /y working\*.lvl "E:\Steam\steamapps\common\Star Wars Battlefront II Classic\GameData\data\_LVL_PC"
::copy /y 000addme\addme.script "E:\Steam\steamapps\common\Star Wars Battlefront II Classic\GameData\addon\000
