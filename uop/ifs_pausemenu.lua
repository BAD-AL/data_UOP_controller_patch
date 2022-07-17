------------------------------------------------------------------
-- ifs_pausemanu.lua 
-- Zerted uop 1.3 r130 
-- uop recovered source
-- by Anakain & BAD_AL
------------------------------------------------------------------

--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- Ingame pause menu

ifspausemenu_vbutton_layout = {
	ySpacing = 5,
	width = 260,
	font = gMenuButtonFont,
	buttonlist = { 
		{ tag = "resume", string = "common.resume", },
		{ tag = "lobby", string = "game.pause.playerlist", },
		{ tag = "friends", string = "ifs.onlinelobby.friendslist", },
		{ tag = "freecam", string = "game.pause.freecam", },
		{ tag = "console", string = "Fake Console", },
		{ tag = "opts", string = "ifs.main.options", },
		{ tag = "suicide", string = "game.pause.suicide", },
		{ tag = "recent", string = "common.mp.recent", },
		{ tag = "restart", string = "common.restart", },
		{ tag = "quit", string = "common.quit", },
		{ tag = "exit", string = "common.quit2windows", },
	},
	title = "game.pause.title",
}

-- Turns pieces on/off as requested
function ifs_pausemenu_fnSetPieceVis(this, bVis)
	IFObj_fnSetVis(this.buttons,bVis)
end

-- Sets text for the camera entry to the right settings
function ifs_pausemenu_fnUpdateFreecamText(this)
	if(this.buttons.freecam) then
		if(this.bChaseCam) then
			RoundIFButtonLabel_fnSetString(this.buttons.freecam,"game.pause.followcam")
		else
			RoundIFButtonLabel_fnSetString(this.buttons.freecam,"game.pause.freecam")
		end
	end
end

function ifs_pausemenu_fnGetActiveInstance()
	local Active = ScriptCB_GetPausingViewport()
	if (Active == 0) then
		return ifs_pausemenu
	elseif (Active == 1) then
		return ifs_pausemenu2
	elseif (Active == 2) then
		return ifs_pausemenu3
	elseif (Active == 3) then
		return ifs_pausemenu4
	end
end

-- Callback for when the "really quit?" popup is over.  If bResult is
-- true, user wanted to quit
function ifs_pausemenu_fnQuitPopupDone(bResult)
	local this = ifs_pausemenu_fnGetActiveInstance()
	SetCurButton("quit", this)
	if((gPlatformStr == "PC") or (not bResult)) then -- fix for BF2 bug 5091, 5724
		ifs_pausemenu_fnSetPieceVis(this,1) -- always restore screen
	else
		this.bNoInput = 1
	end

	if(bResult) then
		ifelm_shellscreen_fnPlaySound(this.acceptSound)
		ScriptCB_QuitToShell()
	else
		ifelm_shellscreen_fnPlaySound(this.cancelSound)
	end
	Popup_YesNo_Large.fnDone = nil
end

-- Callback for when the "really quit?" popup is over.  If bResult is
-- true, user wanted to quit
function ifs_pausemenu_fnExitPopupDone(bResult)
	local this = ifs_pausemenu_fnGetActiveInstance()
	SetCurButton("exit", this)
	if((gPlatformStr == "PC") or (not bResult)) then -- fix for BF2 bug 5091, 5724
		ifs_pausemenu_fnSetPieceVis(this,1) -- always restore screen
	else
		this.bNoInput = 1
	end

	if(bResult) then
		ifelm_shellscreen_fnPlaySound(this.acceptSound)
		ScriptCB_CloseNetShell()
		ScriptCB_QuitToWindows()
	else
		ifelm_shellscreen_fnPlaySound(this.cancelSound)
	end
	Popup_YesNo_Large.fnDone = nil
end

-- Callback for when the "really quit?" popup is over.  If bResult is
-- true, user wanted to quit
function ifs_pausemenu_fnSuicidePopupDone(bResult)
	local this = ifs_pausemenu_fnGetActiveInstance()
	SetCurButton("suicide", this)
	ifs_pausemenu_fnSetPieceVis(this,1) -- always restore screen

	if(bResult) then
		ifelm_shellscreen_fnPlaySound(this.acceptSound)
		ScriptCB_PlayerSuicide(this.Viewport) -- top player
		ScriptCB_Unpause(this.Viewport)
	else
		ifelm_shellscreen_fnPlaySound(this.cancelSound)
	end

	Popup_YesNo_Large.fnDone = nil
end

-- Callback for when the "really restart?" popup is over.  If bResult is
-- true, user wanted to restart
function ifs_pausemenu_fnRestartPopupDone(bResult)
	local this = ifs_pausemenu_fnGetActiveInstance()
	SetCurButton("restart", this)
	if((gPlatformStr == "PC") or (not bResult)) then -- fix for BF2 bug 5091, 5724
		ifs_pausemenu_fnSetPieceVis(this,1) -- always restore screen
	else
		this.bNoInput = 1
	end

	if(bResult) then
		ifelm_shellscreen_fnPlaySound(this.acceptSound)
		ScriptCB_RestartMission()
	else
		ifelm_shellscreen_fnPlaySound(this.cancelSound)
	end

	Popup_YesNo_Large.fnDone = nil
end

function ifs_pausemenu_fnDoExit()
	Popup_YesNo_Large.CurButton = "no" -- default
	Popup_YesNo_Large.fnDone = ifs_pausemenu_fnExitPopupDone
	ifs_pausemenu_fnSetPieceVis(ifs_pausemenu, nil)
	Popup_YesNo_Large:fnActivate(1)
	gPopup_fnSetTitleStr(Popup_YesNo_Large, "ifs.main.askquit")
end

function ifs_pausemenu_fnJustExit()
	ifs_pausemenu_fnExitPopupDone(true)
end

function ifs_pausemenu_fnSaveProfileCancel()
--	print("ifs_pausemenu_fnSaveProfileCancel")
	
	-- back to the "its dirty, save?" prompt when we enter
	--ifs_pausemenu.TryToBackup = 1
	-- pop ifs_saveop, return to ifs_pausemenu
	ScriptCB_PopScreen()
end


function ifs_pausemenu_fnSaveDirtyAcceptQuit(fRet)
	Popup_LoadSave2.fnAccept = nil
	Popup_LoadSave2:fnActivate(nil)

	ifs_pausemenu.do_save = nil
	if(fRet < 1.5) then
--		print("ifs_pausemenu_SaveDirtyAccept(A - Save)")
		ifs_pausemenu.do_save = 1
		ifs_saveop.doOp = "SaveProfile"
		ifs_saveop.OnSuccess = ifs_pausemenu_fnJustExit --ifs_pausemenu_fnDoExit
		ifs_saveop.OnCancel = ifs_pausemenu_fnSaveProfileCancel
		local iProfileIdx = 1 + ScriptCB_GetPrimaryController()
		ifs_saveop.saveName = ScriptCB_GetProfileName(iProfileIdx)
		ifs_saveop.saveProfileNum = iProfileIdx
		ifs_saveop.NoPromptSave = 1
		ifs_movietrans_PushScreen(ifs_saveop)
	elseif(fRet < 2.5) then
--		print("ifs_pausemenu_fnSaveDirtyAccept(B - Exit without saving)")
		--ifs_pausemenu_fnDoExit()
		ifs_pausemenu_fnJustExit()
	else
--		print("ifs_pausemenu_fnSaveDirtyAccept(C - Cancel)")
		-- show this screen
		IFObj_fnSetVis(ifs_pausemenu.buttons,1)
	end	
end


-- Function shared by instances: enter 
function ifs_pausemenu_fnEnter(this, bFwd, iInstance)
	if(this.buttons and this.buttons.FriendIcon) then
		local IconIdx = ScriptCB_GetFriendListIcon()
		local UVs = gXLFriendsEnum2UVs[IconIdx+1] -- lua counts from 1
		IFImage_fnSetUVs(this.buttons.FriendIcon,UVs.u,UVs.v,UVs.u+0.25,UVs.v+0.25)
	end

	-- Default fnEnter doesn't know about the multi-viewport active buttons. So,
	-- clear out varbs it uses to keep from bouncing multiple buttons at once
	-- NM 8/6/05
	gCurScreenTable = this
	SetCurButton(nil, this)
	this.CurButton = nil

	gIFShellScreenTemplate_fnEnter(this, bFwd)

	-- if we're returning from the below, bail right back to the game
	if((not bFwd) and this.PopAfterPlayerList) then
		this.PopAfterPlayerList = nil
		ScriptCB_ResetSkipToPlayerList()
		ScriptCB_Unpause(this.Viewport)
		return
	end
	-- if we're in a net game and the user hits 'tab', jump right to the player list
	if(bFwd and ScriptCB_SkipToPlayerList() and ScriptCB_InNetGame()) then
		this.PopAfterPlayerList = 1
		ifs_movietrans_PushScreen(ifs_mp_lobby)
		return
	end
	this.PopAfterPlayerList = nil
	ScriptCB_ResetSkipToPlayerList()

	ifs_pausemenu_fnUpdateFreecamText(this)
	if(this.CurButton) then
		IFButton_fnSelect(this.buttons[this.CurButton],nil) -- Deactivate old button
	end

	-- Refresh which buttons are shown
	this.buttons.lobby.hidden = gDemoBuild or (not ScriptCB_InNetGame())
	
	if(ScriptCB_GetGameRules() == "metagame") then
		this.buttons.restart.hidden = 1
	else
		this.buttons.restart.hidden = ScriptCB_InNetGame()
	end

	--this.buttons.exit.hidden = (gPlatformStr ~= "PC" or ScriptCB_InNetGame()) 
	--this.buttons.freecam.hidden = nil

	local bShowFriends
	if(gPlatformStr == "XBox") then
		-- XBox has to worry about which viewport(s) have signed-in users
		-- BF2 bug 9214 - NM 8/15/05
		local iJoystick = ScriptCB_GetPausingJoystick()
		bShowFriends = ScriptCB_XL_IsLoggedIn(nil, iJoystick + 1) -- only visible if successfully signed in
	else
		-- GS has only one viewport to worry about 
		bShowFriends = ScriptCB_IsLoggedIn()
	end
	this.buttons.friends.hidden = not bShowFriends
	this.bIsLoggedIn = bShowFriends

	if(this.buttons.recent) then
		this.buttons.recent.hidden = not ((ScriptCB_InNetGame()) and (gOnlineServiceStr == "XLive"))
	end
	--this.buttons.console.hidden = nil

	if(ScriptCB_IsDedicated()) then
		this.buttons.freecam.hidden = 1
		--			this.buttons.lobby.hidden = 1 -- Disabled NM 7/22/04 - I think we need to show this
		this.buttons.opts.hidden = 1
		this.buttons.suicide.hidden = 1
	elseif (ScriptCB_IsSplitscreen()) then
		-- this.buttons.lobby.hidden    = 1
		this.buttons.exit.hidden     = 0
	end

	-- Hide ability to go to lua screens that are deleted by PS2 when the
	-- stats screens opens up. Do NOT modify these without also looking into
	-- other ways to free up Lua memory on the PS2 - NM 5/25/05
	if(ScriptCB_IsGameOver()) then
		this.buttons.lobby.hidden = 1
		this.buttons.opts.hidden = 1
		this.buttons.suicide.hidden = 1
	end

	-- Function test added NM 6/14/05. Remove after about a week.
	if(ScriptCB_IsGuest and ScriptCB_IsGuest()) then
		this.buttons.lobby.hidden = 1
		this.buttons.friends.hidden = 1
		this.buttons.recent.hidden = 1
		this.bIsGuest = 1
		bShowFriends = nil -- have code below hide it.
	else
		this.bIsGuest = nil
	end

	this.CurButton = ShowHideVerticalButtons(this.buttons,ifspausemenu_vbutton_layout)

	if (bFwd) then
		ifelm_shellscreen_fnPlaySound(this.acceptSound)
	end

	SetCurButton(this.CurButton, this)

	-- Move friends icon if appropriate
	if(bShowFriends) then
		local fLeft, fTop, fRight, fBot = IFText_fnGetDisplayRect(this.buttons.friends.label)
		local TextW = fRight - fLeft
		local XPos = fRight + 20
		local YPos = this.buttons.friends.y - 15
		IFObj_fnSetPos(this.buttons.FriendIcon,XPos,YPos)
	else
		IFObj_fnSetVis(this.buttons.FriendIcon, nil) -- just hide it.
	end
end

-- Function shared by instances: Update 
function ifs_pausemenu_fnUpdate(this, fDt)
	-- Call default base class's update function (make button bounce)
	gIFShellScreenTemplate_fnUpdate(this,fDt)

	-- Periodically, see if we're still logged in. As we show 'friends' in
	-- the Syslink UI, we need to immediately hide that if the XLive login
	-- goes sour.
	this.fFriendCheck = this.fFriendCheck - fDt
	if((gPlatformStr == "XBox") and (not this.bIsGuest) and (this.fFriendCheck < 0)) then
		this.fFriendCheck = 0.2
		local iJoystick = ScriptCB_GetPausingJoystick()
		local bIsLoggedIn = ScriptCB_XL_IsLoggedIn(nil, iJoystick + 1)
		if(this.bIsLoggedIn ~= bIsLoggedIn) then
			this.bIsLoggedIn = bIsLoggedIn
			this.buttons.friends.hidden = not this.bIsLoggedIn
			IFObj_fnSetVis(this.buttons.FriendIcon, this.bIsLoggedIn)
			ShowHideVerticalButtons(this.buttons,ifspausemenu_vbutton_layout) -- refresh buttons
			if (this.CurButton == "friends") then
				this:Input_GeneralUp() -- move off now-disabled option
			end
		end
	end
end

-- Function shared by instances: Input_Accept 
function ifs_pausemenu_fnInput_Accept(this)
	if(this.bNoInput) then
		return
	end

	-- If base class handled this work, then we're done
	if(gShellScreen_fnDefaultInputAccept(this)) then
		return
	end

	ifelm_shellscreen_fnPlaySound(this.acceptSound)

	if(this.CurButton == "resume") then
		ScriptCB_Unpause(this.Viewport)
	elseif (this.CurButton == "quit") then
		-- this hack
		ScriptCB_SetQuitPlayer(1)
		
		Popup_YesNo_Large.CurButton = "no" -- default
		Popup_YesNo_Large.fnDone = ifs_pausemenu_fnQuitPopupDone
		Popup_YesNo_Large:fnActivate(1)
		if (ScriptCB_GetAmHost()) then
			if (ScriptCB_GetGameRules() == "metagame") then
				gPopup_fnSetTitleStr(Popup_YesNo_Large, "ifs.pause.warn_quit_meta")
			else
				gPopup_fnSetTitleStr(Popup_YesNo_Large, "ifs.pause.warn_host_quit")
			end					
		elseif (ScriptCB_GetGameRules() == "metagame") then
			gPopup_fnSetTitleStr(Popup_YesNo_Large, "ifs.pause.warn_quit_meta")
		else
			gPopup_fnSetTitleStr(Popup_YesNo_Large, "ifs.pause.warn_quit")
		end
		ifs_pausemenu_fnSetPieceVis(this, nil)

	elseif (this.CurButton == "freecam") then
		this.bChaseCam = not this.bChaseCam
		ScriptCB_Freecamera()
		ifs_pausemenu_fnUpdateFreecamText(this)
	elseif (this.CurButton == "exit") then
	
		-- is the current profile dirty?
		if(ScriptCB_IsCurProfileDirty(1)) then
	--		print("profile dirty, prompting save")
			
			-- hide this screen
			IFObj_fnSetVis(ifs_pausemenu.buttons,nil)
			
			-- set the button text
			IFText_fnSetString(Popup_LoadSave2.buttons.A.label,ifs_saveop.PlatformBaseStr .. ".saveandexit")
			IFText_fnSetString(Popup_LoadSave2.buttons.B.label,ifs_saveop.PlatformBaseStr .. ".exitnosave")
			IFText_fnSetString(Popup_LoadSave2.buttons.C.label,ifs_saveop.PlatformBaseStr .. ".cancel")
			-- set the button visibility
			Popup_LoadSave2:fnActivate(1)
			-- set the load/save title text
			IFObj_fnSetVis(Popup_LoadSave2.buttons.A.label,1)
			IFObj_fnSetVis(Popup_LoadSave2.buttons.B.label,1)
			IFObj_fnSetVis(Popup_LoadSave2.buttons.C.label,1)
			gPopup_fnSetTitleStr(Popup_LoadSave2, ifs_saveop.PlatformBaseStr .. ".save24")
			Popup_LoadSave2_SelectButton(1)
			IFObj_fnSetVis(Popup_LoadSave2, not ScriptCB_IsErrorBoxOpen())
			Popup_LoadSave2_ResizeButtons()
			Popup_LoadSave2.fnAccept = ifs_pausemenu_fnSaveDirtyAcceptQuit
			return
		end
		
		ifs_pausemenu_fnDoExit()

	elseif (this.CurButton == "lobby") then
		ifs_movietrans_PushScreen(ifs_mp_lobby)
	elseif (this.CurButton == "opts") then
		if(gPlatformStr == "PC") then
			ifs_movietrans_PushScreen(ifs_opt_general)
		else
			ifs_movietrans_PushScreen(ifs_opt_top)
		end
	elseif (this.CurButton == "friends") then
		if(ScriptCB_GetOnlineService() == "XLive") then
			ifs_mpxl_friends.bRecentMode = nil
			ifs_movietrans_PushScreen(ifs_mpxl_friends)
		else
			ifs_movietrans_PushScreen(ifs_mpgs_friends)
		end
	elseif (this.CurButton == "recent") then
		ifelm_shellscreen_fnPlaySound("shell_menu_accept")    
		ifs_mpxl_friends.bRecentMode = 1
		ifs_movietrans_PushScreen(ifs_mpxl_friends)
	elseif (this.CurButton == "stats") then
		ifs_movietrans_PushScreen(ifs_teamstats)
	elseif (this.CurButton == "console") then
		ifs_movietrans_PushScreen(ifs_fakeconsole)
	elseif (this.CurButton == "restart") then
		Popup_YesNo_Large.CurButton = "no" -- default
		Popup_YesNo_Large.fnDone = ifs_pausemenu_fnRestartPopupDone
		ifs_pausemenu_fnSetPieceVis(this, nil)
		Popup_YesNo_Large:fnActivate(1)
		gPopup_fnSetTitleStr(Popup_YesNo_Large, "ifs.pause.warn_restart")
	elseif (this.CurButton == "suicide") then
		Popup_YesNo_Large.CurButton = "no" -- default
		Popup_YesNo_Large.fnDone = ifs_pausemenu_fnSuicidePopupDone
		ifs_pausemenu_fnSetPieceVis(this, nil)
		Popup_YesNo_Large:fnActivate(1)
		gPopup_fnSetTitleStr(Popup_YesNo_Large, "game.pause.suicide_prompt")
	end
end

ifs_pausemenu = NewIFShellScreen {
	nologo = 1,
	bAcceptIsSelect = 1,
	movieIntro      = nil, -- played before the screen is displayed
	movieBackground = nil, -- played while the screen is displayed
	bFriendsIcon = 1,
	bDimBackdrop = 1,
	bNohelptext_backPC = 1,

	buttons = NewIFContainer {
		ScreenRelativeX = 0.5, -- center
		ScreenRelativeY = 0.5, -- center
	},

	Enter = function(this, bFwd)
		ifs_pausemenu_fnEnter(this,bFwd, 1) -- Call function shared between instances
	end,

	Exit = function(this, bFwd)
		SetCurButton(nil, this) -- clear out button highlight
		this.CurButton = nil
	end,

	fFriendCheck = 0.1,
	Update = function(this, fDt)
		ifs_pausemenu_fnUpdate(this, fDt)
	end,

	Input_Accept = function(this)
		ifs_pausemenu_fnInput_Accept(this) -- Call function shared between instances
	end,

	-- Override default behavior
	Input_Back = function(this)
		if(this.bNoInput) then
			return
		end
		ifelm_shellscreen_fnPlaySound(this.exitSound)
		ScriptCB_Unpause(this.Viewport)
	end,
}

ifs_pausemenu2 = NewIFShellScreen2 {
	nologo = 1,
	bFriendsIcon = 1,
	bAcceptIsSelect = 1,
	bDimBackdrop = 1,
	bNohelptext_backPC = 1,

	buttons = NewIFContainer {
		ScreenRelativeX = 0.5, -- center
		ScreenRelativeY = 0.5, -- center
	},

	Enter = function(this, bFwd)
		ifs_pausemenu_fnEnter(this, bFwd, 2) -- Call function shared between instances
	end,

	Exit = function(this, bFwd)
		SetCurButton(nil, this) -- clear out button highlight
		this.CurButton = nil
	end,

	fFriendCheck = 0.1,
	Update = function(this, fDt)
		ifs_pausemenu_fnUpdate(this, fDt)
	end,

	Input_Accept = function(this)
		ifs_pausemenu_fnInput_Accept(this) -- Call function shared between instances
	end,

	-- Override default behavior
	Input_Back = function(this)
		if(this.bNoInput) then
			return
		end
		ifelm_shellscreen_fnPlaySound(this.exitSound)
		ScriptCB_Unpause(1)
	end,

	Input_GeneralUp = function(this)
		-- If base class handled this work, then we're done
		if(gShellScreen_fnDefaultInputUp(this)) then
			return
		end

		if(this.buttons) then
			this.CurButton = FollowButtonLink(this.buttons,this.CurButton,"link_up")
			SetCurButton(this.CurButton, this)
		end
	end,

	Input_GeneralDown = function(this)
		-- If base class handled this work, then we're done
		if(gShellScreen_fnDefaultInputUp(this)) then
			return
		end

		if(this.buttons) then
			this.CurButton = FollowButtonLink(this.buttons,this.CurButton,"link_down")
			SetCurButton(this.CurButton, this)
		end
	end,
}

ifs_pausemenu3 = NewIFShellScreen2 {
	nologo = 1,
	bFriendsIcon = 1,
	bAcceptIsSelect = 1,
	bDimBackdrop = 1,
	bNohelptext_backPC = 1,

	buttons = NewIFContainer {
		ScreenRelativeX = 0.5, -- center
		ScreenRelativeY = 0.5, -- center
		y = -30,
	},

	Enter = function(this, bFwd)
		ifs_pausemenu_fnEnter(this, bFwd, 3) -- Call function shared between instances
	end,

	Exit = function(this, bFwd)
		SetCurButton(nil, this) -- clear out button highlight
		this.CurButton = nil
	end,

	fFriendCheck = 0.1,
	Update = function(this, fDt)
		ifs_pausemenu_fnUpdate(this, fDt)
	end,

	Input_Accept = function(this)
		ifs_pausemenu_fnInput_Accept(this) -- Call function shared between instances
	end,

	-- Override default behavior
	Input_Back = function(this)
		if(this.bNoInput) then
			return
		end
		ifelm_shellscreen_fnPlaySound(this.exitSound)
		ScriptCB_Unpause(2)
	end,

	Input_GeneralUp = function(this)
		-- If base class handled this work, then we're done
		if(gShellScreen_fnDefaultInputUp(this)) then
			return
		end

		if(this.buttons) then
			this.CurButton = FollowButtonLink(this.buttons,this.CurButton,"link_up")
			SetCurButton(this.CurButton, this)
		end
	end,

	Input_GeneralDown = function(this)
		-- If base class handled this work, then we're done
		if(gShellScreen_fnDefaultInputUp(this)) then
			return
		end

		if(this.buttons) then
			this.CurButton = FollowButtonLink(this.buttons,this.CurButton,"link_down")
			SetCurButton(this.CurButton, this)
		end
	end,
}

ifs_pausemenu4 = NewIFShellScreen2 {
	nologo = 1,
	bFriendsIcon = 1,
	bAcceptIsSelect = 1,
	bDimBackdrop = 1,
	bNohelptext_backPC = 1,

	buttons = NewIFContainer {
		ScreenRelativeX = 0.5, -- center
		ScreenRelativeY = 0.5, -- center
		y = -30,
	},

	Enter = function(this, bFwd)
		ifs_pausemenu_fnEnter(this, bFwd, 4) -- Call function shared between instances
	end,

	Exit = function(this, bFwd)
		SetCurButton(nil, this) -- clear out button highlight
		this.CurButton = nil
	end,

	fFriendCheck = 0.1,
	Update = function(this, fDt)
		ifs_pausemenu_fnUpdate(this, fDt)
	end,

	Input_Accept = function(this)
		ifs_pausemenu_fnInput_Accept(this) -- Call function shared between instances
	end,

	-- Override default behavior
	Input_Back = function(this)
		if(this.bNoInput) then
			return
		end
		ifelm_shellscreen_fnPlaySound(this.exitSound)
		ScriptCB_Unpause(3)
	end,

	Input_GeneralUp = function(this)
		-- If base class handled this work, then we're done
		if(gShellScreen_fnDefaultInputUp(this)) then
			return
		end

		if(this.buttons) then
			this.CurButton = FollowButtonLink(this.buttons,this.CurButton,"link_up")
			SetCurButton(this.CurButton, this)
		end
	end,

	Input_GeneralDown = function(this)
		-- If base class handled this work, then we're done
		if(gShellScreen_fnDefaultInputUp(this)) then
			return
		end

		if(this.buttons) then
			this.CurButton = FollowButtonLink(this.buttons,this.CurButton,"link_down")
			SetCurButton(this.CurButton, this)
		end
	end,

}

if(not ScriptCB_IsSplitscreen()) then
	ifs_pausemenu.Viewport = 0
	ifs_pausemenu.CurButton = AddVerticalButtons(ifs_pausemenu.buttons,ifspausemenu_vbutton_layout)
	AddIFScreen(ifs_pausemenu, "ifs_pausemenu", 1)

	ifs_pausemenu2 = nil -- flush from memory
	ifs_pausemenu3 = nil -- flush from memory
	ifs_pausemenu4 = nil -- flush from memory
else
	-- is splitscreen. Rearrange things
	ifspausemenu_vbutton_layout.font = "gamefont_small"

	if(ScriptCB_GetNumCameras() > 2) then
		local w,h = ScriptCB_GetSafeScreenInfo() -- of the usable screen
		ifspausemenu_vbutton_layout.HardWidthMax = w * 0.42
	end

	-- No gaps between items; we need to compress for space. 
	ifspausemenu_vbutton_layout.bNoDefaultSizing = 1

	ifs_pausemenu.CurButton = AddVerticalButtons(ifs_pausemenu.buttons,ifspausemenu_vbutton_layout)
	ifs_pausemenu.Viewport = 0
	AddIFScreen(ifs_pausemenu,"ifs_pausemenu")

	ifs_pausemenu2.CurButton = AddVerticalButtons(ifs_pausemenu2.buttons,ifspausemenu_vbutton_layout)
	ifs_pausemenu2.Viewport = 1
	AddIFScreen(ifs_pausemenu2,"ifs_pausemenu2")
	ifs_pausemenu2 = DoPostDelete(ifs_pausemenu2)

	if(gPlatformStr == "XBox") then
		ifs_pausemenu3.CurButton = AddVerticalButtons(ifs_pausemenu3.buttons,ifspausemenu_vbutton_layout)
		ifs_pausemenu3.Viewport = 2
		AddIFScreen(ifs_pausemenu3,"ifs_pausemenu3")
		ifs_pausemenu3 = DoPostDelete(ifs_pausemenu3)
		
		ifs_pausemenu4.CurButton = AddVerticalButtons(ifs_pausemenu4.buttons,ifspausemenu_vbutton_layout)
		ifs_pausemenu4.Viewport = 3
		AddIFScreen(ifs_pausemenu4,"ifs_pausemenu4")
		ifs_pausemenu4 = DoPostDelete(ifs_pausemenu4)
	end
end

ifs_pausemenu = DoPostDelete(ifs_pausemenu)

