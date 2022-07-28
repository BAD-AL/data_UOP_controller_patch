------------------------------------------------------------------
-- uop recovered source
-- by Anakain
------------------------------------------------------------------

--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- Single player Tabs layout
local tab_pcsingle_ypos = 45
local tab_pcsingle_width = 198.125

gPCSinglePlayerTabsLayout = {
	{ tag = "_tab_campaign",	string = "ifs.sp.campaign", screen = "ifs_sp_campaign",		xPos = 100, width = tab_pcsingle_width - 15, yPos = tab_pcsingle_ypos, link_down =nil, link_up= "_tab_single" },
	{ tag = "_tab_gc",		string = "ifs.meta.title",				screen = "ifs_sp_gc_main", width = tab_pcsingle_width + 45, yPos = tab_pcsingle_ypos, link_down =nil, link_up= "_tab_multi" },
	{ tag = "_tab_instant",		string = "ifs.instant.title",				screen = "ifs_missionselect", width = tab_pcsingle_width , yPos = tab_pcsingle_ypos, link_down =nil, link_up= "_tab_options" },
	{ tag = "_tab_career",		string = "ifs.main.career",				screen = "ifs_careerstats", width = tab_pcsingle_width - 30, yPos = tab_pcsingle_ypos, link_down =nil, link_up= "_tab_profile" },
}

ifs_sp_campaign_vbutton_layout = {
--	yTop = -70,
	xWidth = 300,
	width = 300,
	xSpacing = 10,
	ySpacing = 5,
	font = gMenuButtonFont,
	bLeftJustifyButtons = 1, 
	buttonlist = { 
		{ tag = "training", string = "ifs.sp.training", link_up= "_tab_campaign"},
		{ tag = "spacetraining", string = "ifs.sp.spacetraining", },

		{ tag = "riseempire", string = "ifs.meta.load.new", },

		-- campaign list - possibly enable when the game is beaten?
		{ tag = "campaign", string = "ifs.sp.campaign1.title", },

		{ tag = "load_campaign", string = "ifs.meta.load.btnload", },
        { tag = "bonus",         string = "ifs.unlock.title"},
		{ tag = "credits", string = "ifs.credits.title", yAdd = 20,},
	},
	--title = "ifs.sp.campaign",
--	rotY = 35,
}

ifs_sp_gc_vbutton_layout = {
--	yTop = -70,
	xWidth = 300,
	width = 300,
	xSpacing = 10,
	ySpacing = 5,
	font = gMenuButtonFont,
	bLeftJustifyButtons = 1, 
	buttonlist = custom_GetGCButtonList(),
	-- { 
		-- { tag = "1", string = "ifs.meta.Configs.1", },
		-- { tag = "2", string = "ifs.meta.Configs.2", },
		-- { tag = "3", string = "ifs.meta.Configs.3", },
		-- { tag = "4", string = "ifs.meta.Configs.4", },
		-- -- no splitscreen on PC
		-- --{ tag = "custom", string = "ifs.meta.Configs.custom", },
		-- { tag = "load", string = "ifs.meta.load.btnload", },
	-- },
	--title = "ifs.meta.title",
--	rotY = 35,
}


AskHistorical_Button_Layout = {
	yTop = 0,
	width = 300,
	font = gPopupButtonFont,
	buttonlist = { 
		{ tag = "yes", string = "ifs.sp.play", },
		{ tag = "no", string = "ifs.sp.skip", },
	},
--	nocreatebackground = 1,
}

-- General handler for a "Ok" dialog

Popup_Ask_Historical = NewPopup {
	ScreenRelativeX = 0.5, -- centered onscreen
	ScreenRelativeY = 0.5,
	height = 240,
	width = 400,
	ZPos = 50,
	ButtonHeightHint = 70,

	title = NewIFText {
		font = gPopupTextFont,
		textw = 370,
		texth = 160,
		y2 = -110,
		flashy=0,
	},

	buttons = NewIFContainer {
		y = 50,
	},

	fnSetMode = gPopup_YesNo_fnSetMode,
	fnActivate = gPopup_YesNo_fnActivate,
	Input_Accept = gPopup_YesNo_fnInput_Accept,
	Input_GeneralRight = gPopup_YesNo_fnInput_GeneralRight,
	Input_GeneralLeft = gPopup_YesNo_fnInput_GeneralLeft,
	
	Input_Back = function(this)
		ifs_sp_campaign.bCancelAsk = 1
		this.CurButton = "no"
		gPopup_YesNo_fnInput_Accept(this)
	end,
}


function ifs_sp_campaign_StartSaveProfile()
--	print("ifs_sp_campaign_StartSaveProfile")
	
	ifs_saveop.doOp = "SaveProfile"
	ifs_saveop.OnSuccess = ifs_sp_campaign_SaveProfileSuccess
	ifs_saveop.OnCancel = ifs_sp_campaign_SaveProfileCancel
	local iProfileIdx = 1 + ScriptCB_GetPrimaryController()
	ifs_saveop.saveName = ScriptCB_GetProfileName(iProfileIdx)
	ifs_saveop.saveProfileNum = iProfileIdx
	ifs_movietrans_PushScreen(ifs_saveop)
end

function ifs_sp_campaign_SaveProfileSuccess()
--	print("ifs_sp_campaign_SaveProfileSuccess")
	local this = ifs_sp_campaign
	
	-- exit ifs_saveop
	ScriptCB_PopScreen()

	if(this.NextScreenAfterSave) then
--		print("  staying here, will push from Enter")
	else
		-- exit this screen
		ScriptCB_PopScreen()
	end
end

function ifs_sp_campaign_SaveProfileCancel()
--	print("ifs_sp_campaign_SaveProfileCancel")
	local this = ifs_sp_campaign
	
	-- exit ifs_saveop
	ScriptCB_PopScreen()

	if(this.NextScreenAfterSave) then
--		print("  staying here, will push from Enter")
	else
		-- exit this screen
		ScriptCB_PopScreen()
	end
end

-- 
function ifs_sp_campaign_fnUpdateButtonVis(this)
	local bIsSplit = ScriptCB_IsSplitscreen()
	local bCompletedTraining = 1 -- = ScriptCB_GetSPProgress(1) > 0
	local bCompletedRise = 1 -- ScriptCB_GetSPProgress(2) > 0
	
	-- hide campaign list button if not activated
	if(this.buttons.campaign) then
		if( not this.showCampaignList) then
            this.buttons.campaign.hidden = true
		else
		   this.buttons.campaign.hidden = false
		end
	end
	
	if(this.buttons.training) then
		this.buttons.training.hidden = bIsSplit
	end
	if(this.buttons.riseempire) then
		this.buttons.riseempire.bDimmed = not bCompletedTraining
	end
	if(this.buttons.spacetraining) then
		this.buttons.spacetraining.hidden = bIsSplit
	end
	if(this.buttons.load_campaign) then
		this.buttons.load_campaign.bDimmed = (not bCompletedTraining) and (not bIsSplit)
	end
	return ShowHideVerticalButtons(this.buttons,ifs_sp_campaign_vbutton_layout)
end

function ifs_sp_gc_fnUpdateButtonVis(this)
	local bIsSplit = ScriptCB_IsSplitscreen()
	local bCompletedTraining = 1 -- = ScriptCB_GetSPProgress(1) > 0
	local bCompletedRise = 1 -- ScriptCB_GetSPProgress(2) > 0
	
	if(this.buttons["1"]) then
		this.buttons["1"].bDimmed = (not bCompletedRise) and (not bIsSplit)
	end
	if(this.buttons["2"]) then
		this.buttons["2"].bDimmed = (not bCompletedRise) and (not bIsSplit)
	end
	if(this.buttons["3"]) then
		this.buttons["3"].bDimmed = (not bCompletedRise) and (not bIsSplit)
	end
	if(this.buttons["4"]) then
		this.buttons["4"].bDimmed = (not bCompletedRise) and (not bIsSplit)
	end
	if(this.buttons.custom) then
		this.buttons.custom.bDimmed = this.buttons["1"].bDimmed
	end
	if(this.buttons.load) then
		this.buttons.load.bDimmed = (not bCompletedTraining) and (not bIsSplit)
	end
	return ShowHideVerticalButtons(this.buttons,ifs_sp_gc_vbutton_layout)
end

-- Callback when the "play training" dialog is done. If bResult is
-- true, the user selected 'yes'
function ifs_sp_campaign_fnPostAskTraining(bResult)
	local this = ifs_sp_campaign

	if(ifs_sp_campaign.bCancelAsk) then
		ifs_sp_campaign.bCancelAsk = nil -- clear flag
		ifs_sp_campaign_fnUpdateButtonVis(this)
		IFObj_fnSetVis(this.buttons, 1)
	elseif (bResult) then
		ScriptCB_SetGameRules("campaign")
		ScriptCB_ClearMissionSetup()
		ScriptCB_SetInTrainingMission(1)
		ScriptCB_SetMissionNames("geo1c_c", nil)
		ScriptCB_EnterMission()
	else
		-- Skipping training. Stay on this screen, and enable Rise of the Empire
		ScriptCB_SetSPProgress(1,2)
		ifs_sp_campaign_fnUpdateButtonVis(this)
		IFObj_fnSetVis(this.buttons, 1)

		-- If this was on the way to some choice, execute it now
		if(this.BackupCurButton) then
			this.CurButton = this.BackupCurButton
			this:Input_Accept()
		end
	end

	this.BackupCurButton = nil
end

-- Intercepts the call to various options (ROTE, *conquest). Reads
-- this.CurButton, and internal states. Returns true if the call is to
-- proceed, nil if it to not proceed (or it's still asking). Will
-- re-call Input_Accept() if the user hits 'yes' in the dialog
function ifs_sp_campaign_fnAskTraining(this)
	bCompletedTraining = ScriptCB_GetSPProgress(1) > 0
	if(bCompletedTraining) then
		return 1
	end

	-- Hasn't completed training. Store choice, in case they want to
	-- skip out.
	this.BackupCurButton = this.CurButton
	IFObj_fnSetVis(this.buttons, nil)
	Popup_Ask_Historical.CurButton = "yes" -- default
	Popup_Ask_Historical.fnDone = ifs_sp_campaign_fnPostAskTraining
	Popup_Ask_Historical:fnActivate(1)
	gPopup_fnSetTitleStr(Popup_Ask_Historical, "ifs.sp.asktraining")
end

-- movie/image background HERE --
local movie_background = nil -- "shell_main"
local image_background = "iface_bg_2"

ifs_sp_campaign = NewIFShellScreen {
	movieIntro      = nil, -- WAS "ifs_sp_campaign_intro",
	movieBackground = movie_background,-- "shell_sub_left", -- WAS "ifs_sp_campaign",
	music           = "shell_soundtrack",
	bg_texture      = image_background,
	bNohelptext_backPC = 1,

	buttons = NewIFContainer {
		ScreenRelativeX = 0.5, -- center
		ScreenRelativeY = 0.5, -- center
	},

	Enter = function(this, bFwd)
		--gPCBetaBuild = "brad is a crapface"
		if(gPCBetaBuild) then
			--ScriptCB_PopScreen()	
			ScriptCB_PushScreen("ifs_mpgs_login")
			return
		end
		-- tabs	
		if(gPlatformStr == "PC") then
			-- set pc profile & title version text
			UpdatePCTitleText(this)
			ScriptCB_SetConnectType("wan")
			ScriptCB_CancelLogin()
			ScriptCB_SetConnectType("lan")
			
			ifelem_tabmanager_SetSelected(this, gPCMainTabsLayout, "_tab_single")
			ifelem_tabmanager_SetSelected(this, gPCSinglePlayerTabsLayout, "_tab_campaign", 1)
			
			-- single player settings
			ifs_sp.bForSplitScreen = nil
			ScriptCB_SetSplitscreen( nil )
			ScriptCB_CancelLogin()
			ScriptCB_CloseNetShell(1)			
			ScriptCB_SetInNetGame( nil )			
		end
	
		gIFShellScreenTemplate_fnEnter(this, bFwd) -- call default enter function
		gMovieDisabled = nil

		if(bFwd and ScriptCB_IsCampaignStateSaved()) then
			if(ScriptCB_IsCurProfileDirty()) then
				this.NextScreenAfterSave = ifs_campaign_main
				ifs_sp_campaign_StartSaveProfile()
			else
				ifs_movietrans_PushScreen(ifs_campaign_main)
			end
		end

		if(bFwd and ScriptCB_GetInTrainingMission()) then
			ScriptCB_SetSPProgress(1,1) -- note this is complete
			ScriptCB_SetInTrainingMission(nil) -- clear flag so this doen't happen again
		end

--		-- if its splitscreen, change the orange title to say "splitscreen"
--		if(ScriptCB_IsSplitscreen()) then
--			IFText_fnSetString(this.buttons._titlebar_,"ifs.main.split")
--		else
--			IFText_fnSetString(this.buttons._titlebar_,"ifs.main.sp")
--		end

		if(bFwd) then
			this.CurButton = ifs_sp_campaign_fnUpdateButtonVis(this)
		end
		SetCurButton(this.CurButton)

		if((not bFwd) and (this.NextScreenAfterSave)) then
			ifs_movietrans_PushScreen(this.NextScreenAfterSave)
			this.NextScreenAfterSave = nil
		end

		gMovieAlwaysPlay = 1
		this.iCheatState = 0
	end,
	
	Exit = function(this, bFwd)
		if (not bFwd) then
			gMovieAlwaysPlay = nil
			ScriptCB_SetGameRules("instantaction")
		end

		gIFShellScreenTemplate_fnLeave(this, bFwd)
	end,

	Input_Accept = function(this)
	
		--print("ifs_sp_campaign: Input_Accept(): Entered: ", this.CurButton or "[Nil]")
		
		this.iCheatState = 0
		if(gPlatformStr == "PC") then
			-- If the tab manager handled this event, then we're done
			if( ifelem_tabmanager_HandleInputAccept(this, gPCMainTabsLayout) or
				ifelem_tabmanager_HandleInputAccept(this, gPCSinglePlayerTabsLayout, 1) ) then			
				return
			end
		end

		-- If base class handled this work, then we're done
		if(gShellScreen_fnDefaultInputAccept(this)) then
			return
		end

		-- Next screen to go to at end of Input_Accept, if this is not-nil
		-- at the bottom
		local ScreenToPush = nil
		if (this.CurButton == "riseempire") then
			ifelm_shellscreen_fnPlaySound(this.acceptSound)
			-- Ken, do something in ifs_freeform_rise_newload's "new" code.
			if(ifs_sp_campaign_fnAskTraining(this)) then
				--ScreenToPush = ifs_freeform_rise_newload
				
				-- code from ifs_freeform_rise_newload.lua
				ScriptCB_ClearMetagameState()
				ScriptCB_ClearCampaignState()
				ScriptCB_ClearMissionSetup()
				ScriptCB_SetLastBattleVictoryValid(nil)
				ifs_movietrans_PushScreen(ifs_campaign_main)
			end
		elseif (this.CurButton == "credits") then
			ScreenToPush = ifs_credits
		elseif (this.CurButton == "meta") then
			ifelm_shellscreen_fnPlaySound(this.acceptSound)
			if(ifs_sp_campaign_fnAskTraining(this)) then
				ScreenToPush = ifs_freeform_pickscenario
			end
		elseif (this.CurButton == "custom") then
			ifelm_shellscreen_fnPlaySound(this.acceptSound)
			if(ifs_sp_campaign_fnAskTraining(this)) then
				ScreenToPush = ifs_freeform_customsetup
			end
		elseif (this.CurButton == "campaign") then
			ifelm_shellscreen_fnPlaySound(this.acceptSound)
			ScriptCB_SetGameRules("campaign")
			--ifs_sp_briefing.era = "c1"
			ScreenToPush = ifs_sp_campaign_list
		elseif (this.CurButton == "training") then
			ifelm_shellscreen_fnPlaySound(this.acceptSound)
			-- If training has been completed, assme they want to replay it.
			ifs_sp_campaign_fnPostAskTraining(1)
		elseif (this.CurButton == "campaign") then
			ifelm_shellscreen_fnPlaySound(this.acceptSound)
			ScriptCB_SetGameRules("campaign")
			ifs_sp_campaign_briefing.era = "c1"
			ScreenToPush = ifs_sp_campaign_briefing
		elseif (this.CurButton == "load_campaign") then
			ifelm_shellscreen_fnPlaySound(this.acceptSound)
			-- code from ifs_freeform_rise_newload.lua
			ifs_campaign_load.Mode = "Load"
			ifs_campaign_load.SkipPromptSave = 1
			ifs_movietrans_PushScreen(ifs_campaign_load)
			-- old code
			--ifs_freeform_load.Mode = "Load"
			--ScreenToPush = ifs_freeform_load
			
		elseif (this.CurButton == "spacetraining") then
			ifelm_shellscreen_fnPlaySound(this.acceptSound)
			ScreenToPush = ifs_spacetraining
		
		elseif ((this.CurButton == "1") or (this.CurButton == "2") or
						(this.CurButton == "3") or (this.CurButton == "4")) then
			ifelm_shellscreen_fnPlaySound(this.acceptSound)
			-- always clear the quit player here
			ScriptCB_SetQuitPlayer(1)
			if(ifs_sp_campaign_fnAskTraining(this)) then 
				ScreenToPush = ifs_freeform_main
				if (this.CurButton == "1") then
					-- rebel scenario
					ifs_freeform_start_all(ifs_freeform_main)
				elseif (this.CurButton == "2") then
					-- cis scenario
					ifs_freeform_start_cis(ifs_freeform_main)
				elseif (this.CurButton == "3") then
					-- republic scenario
					ifs_freeform_start_rep(ifs_freeform_main)
				elseif (this.CurButton == "4") then
					-- empire scenario
					ifs_freeform_start_imp(ifs_freeform_main)
				else
					ScreenToPush = nil
				end
			end
		end

		if(ScreenToPush) then
			-- Fix for 4903 - don't prompt to save right before a load.
			if((ScriptCB_IsCurProfileDirty()) and (this.CurButton ~= "load")) then
				this.NextScreenAfterSave = ScreenToPush
				ifs_sp_campaign_StartSaveProfile()
			else
				ifs_movietrans_PushScreen(ScreenToPush)
			end
		end -- have a ScreenToPush
		
	end,

	Input_Back = function(this)
		this.iCheatState = 0
        ifs_login.EnterDoNothing = 1
		if(ScriptCB_IsCurProfileDirty()) then
			this.NextScreenAfterSave = nil
			ifs_sp_campaign_StartSaveProfile()
		else
			--otherwise just exit
			ScriptCB_PopScreen()
		end		
	end,

	Input_Misc = function(this)
		if((this.iCheatState == 0) or (this.iCheatState == 2) or (this.iCheatState == 4)) then
			this.iCheatState = this.iCheatState + 1
		end
	end,

	Input_Misc2 = function(this)
		if((this.iCheatState == 1) or (this.iCheatState == 3) or (this.iCheatState == 5)) then
			this.iCheatState = this.iCheatState + 1
		end

		if(this.iCheatState == 6) then
			ScriptCB_SetSPProgress(2,2)
			ifs_sp_campaign_fnUpdateButtonVis(this)
		end
	end,

}

-- end ifs_sp_campaign screen, begin ifs_sp_gc_main screen

ifs_sp_gc_main = NewIFShellScreen {
	movieIntro      = nil, -- WAS "ifs_sp_campaign_intro",
	movieBackground = movie_background,-- "shell_sub_left", -- WAS "ifs_sp_campaign",
	music           = "shell_soundtrack",
	bg_texture      = image_background,
	bNohelptext_backPC = 1,

	buttons = NewIFContainer {
		ScreenRelativeX = 0.5, -- center
		ScreenRelativeY = 0.5, -- center
	},

	Enter = function(this, bFwd)
		-- tabs	
		if(gPlatformStr == "PC") then
			-- set pc profile & title version text
			UpdatePCTitleText(this)
			
			ifelem_tabmanager_SetSelected(this, gPCMainTabsLayout, "_tab_single")
			ifelem_tabmanager_SetSelected(this, gPCSinglePlayerTabsLayout, "_tab_gc", 1)
			
			-- single player settings
			ifs_sp.bForSplitScreen = nil
			ScriptCB_SetSplitscreen( nil )
			ScriptCB_CancelLogin()			
			ScriptCB_CloseNetShell(1)			
			ScriptCB_SetInNetGame( nil )			
		end
	
		gIFShellScreenTemplate_fnEnter(this, bFwd) -- call default enter function
		gMovieDisabled = nil

		if(bFwd and ScriptCB_IsCampaignStateSaved()) then
			if(ScriptCB_IsCurProfileDirty()) then
				this.NextScreenAfterSave = ifs_campaign_main
				ifs_sp_campaign_StartSaveProfile()
			else
				ifs_movietrans_PushScreen(ifs_campaign_main)
			end
		end

		if(bFwd and ScriptCB_GetInTrainingMission()) then
			ScriptCB_SetSPProgress(1,1) -- note this is complete
			ScriptCB_SetInTrainingMission(nil) -- clear flag so this doen't happen again
		end

--		-- if its splitscreen, change the orange title to say "splitscreen"
--		if(ScriptCB_IsSplitscreen()) then
--			IFText_fnSetString(this.buttons._titlebar_,"ifs.main.split")
--		else
--			IFText_fnSetString(this.buttons._titlebar_,"ifs.main.sp")
--		end

		if(bFwd) then
			this.CurButton = ifs_sp_gc_fnUpdateButtonVis(this)
		end
		SetCurButton(this.CurButton)

		if((not bFwd) and (this.NextScreenAfterSave)) then
			ifs_movietrans_PushScreen(this.NextScreenAfterSave)
			this.NextScreenAfterSave = nil
		end

		gMovieAlwaysPlay = 1
		this.iCheatState = 0
	end,
	
	Exit = function(this, bFwd)
		if (not bFwd) then
			gMovieAlwaysPlay = nil
			ScriptCB_SetGameRules("instantaction")
		end

		gIFShellScreenTemplate_fnLeave(this, bFwd)
	end,

	Input_Accept = function(this)
		this.iCheatState = 0
		if(gPlatformStr == "PC") then
			-- If the tab manager handled this event, then we're done
			if( ifelem_tabmanager_HandleInputAccept(this, gPCMainTabsLayout) or
				ifelem_tabmanager_HandleInputAccept(this, gPCSinglePlayerTabsLayout, 1) ) then			
				return
			end
		end

		-- If base class handled this work, then we're done
		if(gShellScreen_fnDefaultInputAccept(this)) then
			return
		end

		-- Next screen to go to at end of Input_Accept, if this is not-nil
		-- at the bottom
		local ScreenToPush = nil

		if (this.CurButton == "riseempire") then
			-- Ken, do something in ifs_freeform_rise_newload's "new" code.
			--if(ifs_sp_campaign_fnAskTraining(this)) then
				ScreenToPush = ifs_freeform_rise_newload
			--end
		elseif (this.CurButton == "meta") then
			--if(ifs_sp_campaign_fnAskTraining(this)) then
				ScreenToPush = ifs_freeform_pickscenario
			--end
		elseif (this.CurButton == "custom") then
			--if(ifs_sp_campaign_fnAskTraining(this)) then
				ScreenToPush = ifs_freeform_customsetup
			--end
		elseif (this.CurButton == "campaign") then
			ScriptCB_SetGameRules("campaign")
			ifs_sp_briefing.era = "c1"
			ScreenToPush = ifs_sp_briefing
		elseif (this.CurButton == "training") then
			-- If training has been completed, assme they want to replay it.
			ifs_sp_campaign_fnPostAskTraining(1)
		elseif (this.CurButton == "campaign") then
			ScriptCB_SetGameRules("campaign")
			ifs_sp_campaign_briefing.era = "c1"
			ScreenToPush = ifs_sp_campaign_briefing
		elseif (this.CurButton == "load") then
			ifs_freeform_load.Mode = "Load"
			ScreenToPush = ifs_freeform_load
		else
			-- always clear the quit player here
			ScriptCB_SetQuitPlayer(1)
			
			ScreenToPush = ifs_freeform_main
			if not custom_PressedGCButton(this.CurButton) then 
			
			--if(ifs_sp_campaign_fnAskTraining(this)) then 
				if (this.CurButton == "1") then
					-- rebel scenario
					ifs_freeform_start_all(ifs_freeform_main)
				elseif (this.CurButton == "2") then
					-- cis scenario
					ifs_freeform_start_cis(ifs_freeform_main)
				elseif (this.CurButton == "3") then
					-- republic scenario
					ifs_freeform_start_rep(ifs_freeform_main)
				elseif (this.CurButton == "4") then
					-- empire scenario
					ifs_freeform_start_imp(ifs_freeform_main)
				elseif (this.CurButton == "0") then
					print("ifs_sp_gc_main: Input_Accept(): Button pressed: 0")
					ifs_freeform_start_zer(ifs_freeform_main)
				else
					ScreenToPush = nil
				end
			end
		end

		if(ScreenToPush) then
			ifelm_shellscreen_fnPlaySound(this.acceptSound)
			-- Fix for 4903 - don't prompt to save right before a load.
			if((ScriptCB_IsCurProfileDirty()) and (this.CurButton ~= "load")) then
				this.NextScreenAfterSave = ScreenToPush
				ifs_sp_campaign_StartSaveProfile()
			else
				ifs_movietrans_PushScreen(ScreenToPush)
			end
		end -- have a ScreenToPush
		
	end,

	Input_Back = function(this)
		this.iCheatState = 0
        ifs_login.EnterThenExit = 1
		if(ScriptCB_IsCurProfileDirty()) then
			this.NextScreenAfterSave = nil
			ifs_sp_campaign_StartSaveProfile()
		else
			--otherwise just exit
			ScriptCB_PopScreen()
		end		
	end,

	Input_Misc = function(this)
		if((this.iCheatState == 0) or (this.iCheatState == 2) or (this.iCheatState == 4)) then
			this.iCheatState = this.iCheatState + 1
		end
	end,

	Input_Misc2 = function(this)
		if((this.iCheatState == 1) or (this.iCheatState == 3) or (this.iCheatState == 5)) then
			this.iCheatState = this.iCheatState + 1
		end

		if(this.iCheatState == 6) then
			ScriptCB_SetSPProgress(2,2)
			ifs_sp_gc_fnUpdateButtonVis(this)
		end
	end,

}

-- end ifs_sp_gc_main screen --

function ifs_sp_campaign_fnBuildScreen( this ) 
	if(gPlatformStr == "PC") then
		-- add pc profile & title version text
		AddPCTitleText( this )
		
		gPCMainTabsLayout[1].link_down = "_tab_campaign"
		gPCMainTabsLayout[2].link_down = "_tab_gc"
		gPCMainTabsLayout[3].link_down = "_tab_instant"
		gPCMainTabsLayout[4].link_down = "_tab_career"
		gPCMainTabsLayout[5].link_down = "_tab_career"
		gPCMainTabsLayout[6].link_down = "_tab_career"

		if(this == ifs_sp_campaign) then
			gPCSinglePlayerTabsLayout[1].link_down = "training"
			gPCSinglePlayerTabsLayout[2].link_down = "training"
			gPCSinglePlayerTabsLayout[3].link_down = "training"
			gPCSinglePlayerTabsLayout[4].link_down = "training"
			ifs_sp_gc_vbutton_layout.buttonlist[1].link_up = "_tab_gc"
		else
			gPCSinglePlayerTabsLayout[1].link_down = "1"
			gPCSinglePlayerTabsLayout[2].link_down = "1"
			gPCSinglePlayerTabsLayout[3].link_down = "1"
			gPCSinglePlayerTabsLayout[4].link_down = "1"
		end


		-- Add tabs to screen
		ifelem_tabmanager_Create(this, gPCMainTabsLayout, gPCSinglePlayerTabsLayout)

		gPCMainTabsLayout[1].link_down = nil
		gPCMainTabsLayout[2].link_down = nil
		gPCMainTabsLayout[3].link_down = nil
		gPCMainTabsLayout[4].link_down = nil
		gPCMainTabsLayout[5].link_down = nil
		gPCMainTabsLayout[6].link_down = nil
		gPCSinglePlayerTabsLayout[1].link_down = nil
		gPCSinglePlayerTabsLayout[2].link_down = nil
		gPCSinglePlayerTabsLayout[3].link_down = nil
		gPCSinglePlayerTabsLayout[4].link_down = nil
	end
end

ifs_sp_campaign_fnBuildScreen( ifs_sp_campaign )
ifs_sp_campaign_fnBuildScreen( ifs_sp_gc_main )
ifs_sp_campaign_fnBuildScreen = nil

AddVerticalButtons(Popup_Ask_Historical.buttons,AskHistorical_Button_Layout)
CreatePopupInC(Popup_Ask_Historical,"Popup_Ask_Historical")
Popup_Ask_Historical.buttons.x2 = Popup_Ask_Historical.buttons.x

ifs_sp_campaign.CurButton = AddVerticalButtons(ifs_sp_campaign.buttons,ifs_sp_campaign_vbutton_layout)
ifs_sp_gc_main.CurButton = AddVerticalButtons(ifs_sp_gc_main.buttons,ifs_sp_gc_vbutton_layout)

AddIFScreen(ifs_sp_campaign,"ifs_sp_campaign")
AddIFScreen(ifs_sp_gc_main,"ifs_sp_gc_main")
