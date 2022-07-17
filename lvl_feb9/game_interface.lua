-- game_interface.lua (controller update, FEB 9, 2021)
--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--
if(ScriptCB_GetCurrentAspect == nil) then
    -- These are important to define when using the mod_tools debugger with the .lvls
    -- from the Feb 9 Controller update
	ScriptCB_GetCurrentAspect = function ()
		return 0.5625
	end

	ScriptCB_GetTargetAspect = function()
		return 0.75
	end
	--ScriptCB_ReadRightstick()
	ScriptCB_ResetGamepadToDefault = function()
	end

	ScriptCB_IsJoyUsed = function ()
		return false
	end
	--[[ unused
	ScriptCB_IsKeyboardUsed = function()
		return 1
	end ]]

	-- used in \ifs_missionselect_pcmulti.script
	function ScriptCB_GetJoyButtonPressed()
		return false
	end
else
    print("You are using a Battlefront 2 exe that supports a Controller!")
end

-- Master include for StarWars: Frontline ingame interface, lua
-- component. The game should be able to include this file and nothing
-- else.

gPlatformStr = ScriptCB_GetPlatform()

-- Note: we don't call ScriptCB_GetOnlineService(), which returns what
-- the binary was compiled for (XLive vs GameSpy). We want the current
-- connection type, which is "LAN", "XLive" or "GameSpy"
gOnlineServiceStr = ScriptCB_GetConnectType()
--	gOnlineServiceStr = ScriptCB_GetOnlineService()

gLangStr,gLangEnum = ScriptCB_GetLanguage()

-- Load designer-specified globals
ScriptCB_DoFile("globals")

-- Load player stats points
ScriptCB_DoFile("points")

--
--
-- Load utility functions
ScriptCB_DoFile("interface_util")
ScriptCB_DoFile("ifelem_button")
ScriptCB_DoFile("ifelem_roundbutton")
ScriptCB_DoFile("ifelem_flatbutton")
ScriptCB_DoFile("ifelem_buttonwindow")
ScriptCB_DoFile("ifelem_segline")
ScriptCB_DoFile("ifelem_popup")
ScriptCB_DoFile("ifelem_listmanager")
ScriptCB_DoFile("ifelem_helptext")
ScriptCB_DoFile("ifelem_shellscreen")
ScriptCB_DoFile("ifelem_titlebar")
ScriptCB_DoFile("ifelem_borderrect")
ScriptCB_DoFile("ifelem_hslider")
ScriptCB_DoFile("ifelem_form")
ScriptCB_DoFile("ifelem_AnimationMgr")
ScriptCB_DoFile("ifs_movietrans_game")
if(gPlatformStr == "PC") then
	ScriptCB_DoFile("ifelem_tabmanager")
	ScriptCB_DoFile("ifutil_mouse")
	ScriptCB_DoFile("ifelem_editbox")
end

--
--
-- Load screens. Will be activated by gamecode, not us.

ScriptCB_DoFile("ifs_opt_top")

ScriptCB_DoFile("ifs_opt_controller_mode")

if(gPlatformStr == "PC") then
	ScriptCB_DoFile("pctabs_options")
end

if(gPlatformStr ~= "PC") then
	ScriptCB_DoFile("controller_presets")
	ScriptCB_DoFile("ifs_opt_controller_common")
	ScriptCB_DoFile("ifs_opt_controller_vehunit")
else 
	ScriptCB_DoFile("controller_presets")
	ScriptCB_DoFile("ifs_opt_controller_common")
	ScriptCB_DoFile("ifs_opt_pccontroller")
end

ScriptCB_DoFile("ifs_opt_general")
if( gPlatformStr == "PC" ) then 
	ScriptCB_DoFile("ifs_opt_pcsound")
else 
	ScriptCB_DoFile("ifs_opt_sound")
end 

ScriptCB_DoFile("ifs_opt_mp_listtags")
ScriptCB_DoFile("ifs_opt_mp")

if(gPlatformStr == "PC") then
	ScriptCB_DoFile("ifs_saveop")

	--ScriptCB_DoFile("ifs_opt_pckeyboard")
	ScriptCB_DoFile("ifs_opt_pccontrols")
	ScriptCB_DoFile("ifs_opt_pcvideo")
	ScriptCB_DoFile("ifs_pc_SpawnSelect")
	ScriptCB_DoFile("ifs_pc_spectator")
end

ScriptCB_DoFile("ifs_sideselect")
ScriptCB_DoFile("ifs_charselect")
ScriptCB_DoFile("ifs_mapselect")
ScriptCB_DoFile("ifs_readyselect")

ScriptCB_DoFile("popups_common")
ScriptCB_DoFile("popup_ok")

if(gPlatformStr ~= "PS2") then
	ScriptCB_DoFile("popup_ab")
	ScriptCB_DoFile("popup_busy")
end

ScriptCB_DoFile("popup_yesno")
ScriptCB_DoFile("popup_yesno_large")
ScriptCB_DoFile("error_popup")
if(gPlatformStr == "PC") then
	ScriptCB_DoFile("popup_loadsave2")
end

ScriptCB_DoFile("ifs_pausemenu")
ScriptCB_DoFile("ifs_fakeconsole")

ScriptCB_DoFile("ifs_teamstats")
ScriptCB_DoFile("ifs_personalstats")
ScriptCB_DoFile("ifs_awardstats")
ScriptCB_DoFile("ifs_careerstats")

ScriptCB_DoFile("ifs_mp_lobby")

ScriptCB_DoFile("popups_lobby")
ScriptCB_DoFile("popup_vote")

-- Pull in XBox-only pages (with mpxl in the name)
if(ScriptCB_GetOnlineService() == "XLive") then
	ScriptCB_DoFile("ifs_mpxl_friends")
	ScriptCB_DoFile("ifs_mpxl_feedback")
	ScriptCB_DoFile("ifs_mpxl_voicemail")
else
	ScriptCB_DoFile("ifs_mpgs_friends")
end
