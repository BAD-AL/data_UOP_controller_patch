------------------------------------------------------------------
-- uop recovered source
-- by Anakain
------------------------------------------------------------------

--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

__ProcessedAwardEffects__ = false

ifs_sideselect_vbutton_layout = {
	xWidth = 205,
	width = 205,
	xSpacing = 6,
	ySpacing = 5,
	font = gMenuButtonFont,
	buttonlist = { 
		{ tag = "fakeTeam1", string = CustomEraTeam1 or "Team 1", },
		{ tag = "fakeTeam2", string = CustomEraTeam2 or "Team 2", },
		{ tag = "team1", string = "ifs.sideselect.spectate", },
		{ tag = "team2", string = "ifs.sideselect.spectate", },
		{ tag = "auto", string = "ifs.sideselect.autoassign", },
		{ tag = "spec", string = "ifs.sideselect.spectate", },
	},	
	title = "ifs.sideselect.chooseteam",
	bBlackBackdrop = 1,
}

function ifs_sideselect_fnBuildScreen(this, mode)
	print("ifs_sideselect_fnBuildScreen()")
	
	local w,h = ScriptCB_GetSafeScreenInfo() -- of the usable screen

--BradR 7/27/05- removing this element 
--	this.title = NewIFText {
--		string = "ifs.missionselect.pickside",
--		font = "gamefont_large",
--		y = 15,
--		textw = 300, -- center on screen. Fixme: do real centering!
--		ScreenRelativeX = 0.5, -- center
--		ScreenRelativeY = 0, -- top
--		inert = 1, -- delete out of Lua mem when pushed to C
--		nocreatebackground = 1,
--	}

	-- Make a container that's aligned to the left-top of the screen
	-- to shove our stuff into
	this.Info = NewIFContainer {
		ScreenRelativeX = 0.0,
		ScreenRelativeY = 0.0,
		inert = 1, -- delete from Lua memory once pushed to C
	}
	
	this.buttons = NewIFContainer {
		ScreenRelativeX = 0.75, -- right
		ScreenRelativeY = 0.5, -- center
		y = 30, -- offset slightly down
		x = -30,
		--rotY = -30,
		--rotX = -20,
		--rotZ = 1,
	}
	
	-- Clamp button widths to keep them onscreen
	ifs_sideselect_vbutton_layout.HardWidthMax = (w * 2 * (1.0 - this.buttons.ScreenRelativeX)) - 32
	
	if(not ScriptCB_IsSplitscreen()) then
	elseif (ScriptCB_GetNumCameras() > 2) then
		-- 3/4 way splitscreen. Shrink stuff more
		this.buttons.ScreenRelativeX = 0.675
		ifs_sideselect_vbutton_layout.HardWidthMax = (w * (1.0 - this.buttons.ScreenRelativeX)) - 32
		this.buttons.y = -10
		ifs_sideselect_vbutton_layout.font = "gamefont_tiny"
	else
		-- 2-way splitscreen
		this.buttons.y = -15
		ifs_sideselect_vbutton_layout.font = "gamefont_medium"
	end

	AddVerticalButtons(this.buttons,ifs_sideselect_vbutton_layout)

end

function ifs_sideselect_fnEnter(this, bFwd)
	-- Default fnEnter doesn't know about the multi-viewport active buttons. So,
	-- clear out varbs it uses to keep from bouncing multiple buttons at once
	-- NM 8/6/05
	if(this.Viewport) then
		gCurScreenTable = this
		SetCurButton(nil, this)
		this.CurButton = nil
	end

	gIFShellScreenTemplate_fnEnter(this, bFwd) -- call default enter function

	if(bFwd) then
		local bteam1, bteam2, bauto, bspec = ScriptCB_GetSideSelectButtonSetting()
		if( bteam1 == 0 ) then
			this.buttons.fakeTeam1.hidden = 1
			this.buttons.fakeTeam1.bDimmed = nil
			this.buttons.team1.hidden = 1
			this.buttons.team1.bDimmed = nil
		elseif( bteam1 == 1 ) then
			this.buttons.fakeTeam1.hidden = nil
			this.buttons.fakeTeam1.bDimmed = 1
			this.buttons.team1.hidden = nil
			this.buttons.team1.bDimmed = 1
		else
			this.buttons.fakeTeam1.hidden = nil
			this.buttons.fakeTeam1.bDimmed = nil
			this.buttons.team1.hidden = nil
			this.buttons.team1.bDimmed = nil
		end
		
		if( bteam2 == 0 ) then
			this.buttons.fakeTeam2.hidden = 1
			this.buttons.fakeTeam2.bDimmed = nil
			this.buttons.team2.hidden = 1
			this.buttons.team2.bDimmed = nil
		elseif( bteam2 == 1 ) then
			this.buttons.fakeTeam2.hidden = nil
			this.buttons.fakeTeam2.bDimmed = 1
			this.buttons.team2.hidden = nil
			this.buttons.team2.bDimmed = 1
		else
			this.buttons.fakeTeam2.hidden = nil
			this.buttons.fakeTeam2.bDimmed = nil
			this.buttons.team2.hidden = nil
			this.buttons.team2.bDimmed = nil
		end
		
		if( bauto == 0 ) then
			this.buttons.auto.hidden = 1
			this.buttons.auto.bDimmed = nil
		elseif( bauto == 1 ) then
			this.buttons.auto.hidden = nil
			this.buttons.auto.bDimmed = 1
		else
			this.buttons.auto.hidden = nil
			this.buttons.auto.bDimmed = nil
		end
		
		if( bspec == 0 ) then
			this.buttons.spec.hidden = 1
			this.buttons.spec.bDimmed = nil
		elseif( bspec == 1 ) then
			this.buttons.spec.hidden = nil
			this.buttons.spec.bDimmed = 1
		else
			this.buttons.spec.hidden = nil
			this.buttons.spec.bDimmed = nil
		end
	end
	
	if SupportsCustomEraTeams then
		print("ifs_sideselect_fnEnter(): Map supports custom era teams")
		
		this.buttons.team1.hidden = 1
		this.buttons.team2.hidden = 1
	else
		print("ifs_sideselect_fnEnter(): Map does not support custom era teams")
		
		this.buttons.fakeTeam1.hidden = 1
		this.buttons.fakeTeam2.hidden = 1
	end
	
	this.CurButton = ShowHideVerticalButtons(this.buttons, ifs_sideselect_vbutton_layout)
	if(this.Viewport) then
		SetCurButton(this.CurButton, this)
	else
		SetCurButton(this.CurButton)
	end
	
	if __ProcessedAwardEffects__ == false then
		__ProcessedAwardEffects__ = true
		
		if ScriptCB_IsFileExist(__v13patchSettings_noAwards__) == 0 then
			print("ifs_sideselect_fnEnter(): The award settings file does not exist")
		else
			print("ifs_sideselect_fnEnter(): The award settings file exists")
			if not ff_CommandRemoveAwardEffects then
				print("ifs_sideselect_fnEnter(): Error: Cannot remove awards effects.  The needed FakeConsole function is missing")
			else
				print("ifs_sideselect_fnEnter(): Starting to remove award effects...")
				ff_CommandRemoveAwardEffects()
				print("ifs_sideselect_fnEnter(): Finished removing award effects.")
			end
		end
	end
	
	
end

ifs_sideselect1 = NewIFShellScreen {
	nologo = 1,
	bNohelptext_back = 1,
	bNohelptext_backPC = 1,
	bAcceptIsSelect = 1,
	bDimBackdrop = 1,

	-- Actual contents are created in ifs_sideselect_fnBuildScreen

	-- Note: for now, the exe is handling all the inputs/events, so this
	-- screen has no Enter/Exit/Update/Input handlers. It does have an
	-- Input_Back handler to override the base class's default functionality
	-- (go to previous screen)
	Input_Back = function(this)
	end,
	Input_GeneralLeft = function(this,bFromAI)
	end,
	Input_GeneralRight = function(this,bFromAI)
	end,

	Enter = function(this, bFwd)
		ifs_sideselect_fnEnter(this, bFwd)
	end,
	
	Input_KeyDown = function(this, iKey)
		--local r2 = ScriptCB_GetSideSelectButtonSetting()
		local bteam1, bteam2, bauto, bspec = ScriptCB_GetSideSelectButtonSetting()
		
		if iKey == 97 or iKey == 65 or iKey == 51 then
			
			if bauto ~= 0 and bauto ~= 1 then
				ShowMessageText("mods.shortcuts.auto")
				this.CurButton = "auto"
			end

		elseif iKey == 49 then
			
			if bteam1 ~= 0 and bteam1 ~= 1 then
				ShowMessageText("mods.shortcuts.team1")
				this.CurButton = "team1"
			end
			
		elseif iKey == 50 then
		
			if bteam2 ~= 0 and bteam2 ~= 1 then
				ShowMessageText("mods.shortcuts.team2")
				this.CurButton = "team2"
			end
		
		elseif iKey == 52 then
			if bspec ~= 0 and bspec ~= 1 then
				ShowMessageText("mods.shortcuts.spec")
				this.CurButton = "spec"
			end
		end

	end,
	
	Update = function(this, fDt)
	
		if this.CurButton == "fakeTeam1" then
			this.CurButton = "team1"
			SetCurButton("team1")
		elseif this.CurButton == "fakeTeam2" then
			this.CurButton = "team2"
			SetCurButton("team2")
		end
	end
	
}

ifs_sideselect2 = NewIFShellScreen {
	nologo = 1,
	bNohelptext_back = 1, 
	bNohelptext_backPC = 1,
	bAcceptIsSelect = 1,
	bDimBackdrop = 1,

	-- Actual contents are created in ifs_sideselect_fnBuildScreen

	-- Note: for now, the exe is handling all the inputs/events, so this
	-- screen has no Enter/Exit/Update/Input handlers. It does have an
	-- Input_Back handler to override the base class's default functionality
	-- (go to previous screen)
	Input_Back = function(this)
	end,
	Input_GeneralLeft = function(this,bFromAI)
	end,
	Input_GeneralRight = function(this,bFromAI)
	end,

	Enter = function(this, bFwd)
		ifs_sideselect_fnEnter(this, bFwd)
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

ifs_sideselect3 = NewIFShellScreen {
	nologo = 1,
	bNohelptext_back = 1, 
	bNohelptext_backPC = 1,
	bAcceptIsSelect = 1,
	bDimBackdrop = 1,

	-- Actual contents are created in ifs_sideselect_fnBuildScreen

	-- Note: for now, the exe is handling all the inputs/events, so this
	-- screen has no Enter/Exit/Update/Input handlers. It does have an
	-- Input_Back handler to override the base class's default functionality
	-- (go to previous screen)
	Input_Back = function(this)
	end,
	Input_GeneralLeft = function(this,bFromAI)
	end,
	Input_GeneralRight = function(this,bFromAI)
	end,

	Enter = function(this, bFwd)
		ifs_sideselect_fnEnter(this, bFwd)
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

ifs_sideselect4 = NewIFShellScreen {
	nologo = 1,
	bNohelptext_back = 1, 
	bNohelptext_backPC = 1,
	bAcceptIsSelect = 1,
	bDimBackdrop = 1,

	-- Actual contents are created in ifs_sideselect_fnBuildScreen

	-- Note: for now, the exe is handling all the inputs/events, so this
	-- screen has no Enter/Exit/Update/Input handlers. It does have an
	-- Input_Back handler to override the base class's default functionality
	-- (go to previous screen)
	Input_Back = function(this)
	end,
	Input_GeneralLeft = function(this,bFromAI)
	end,
	Input_GeneralRight = function(this,bFromAI)
	end,

	Enter = function(this, bFwd)
		ifs_sideselect_fnEnter(this, bFwd)
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

--	print("SingleScreen")
	--its not splitscreen do it normally
	ifs_sideselect_fnBuildScreen(ifs_sideselect1, 0)
	AddIFScreen(ifs_sideselect1,"ifs_sideselect1")
	ifs_sideselect2 = nil -- flush from memory
	ifs_sideselect3 = nil -- flush from memory
	ifs_sideselect4 = nil -- flush from memory
	
else
	-- is splitscreen. Rearrange things
--	print("Splitscreen")

	if(ScriptCB_GetNumCameras() > 2) then
		local w,h = ScriptCB_GetSafeScreenInfo() -- of the usable screen
		ifs_sideselect_vbutton_layout.HardWidthMax = w * 0.45
	end
	
	ifs_sideselect_fnBuildScreen(ifs_sideselect1, 1)
	ifs_sideselect1.Viewport = 0
	AddIFScreen(ifs_sideselect1,"ifs_sideselect1")

	ifs_sideselect_fnBuildScreen(ifs_sideselect2, 1)
	ifs_sideselect2.Viewport = 1
	AddIFScreen(ifs_sideselect2,"ifs_sideselect2")
	ifs_sideselect2 = DoPostDelete(ifs_sideselect2)

	if(gPlatformStr == "XBox") then 
		ifs_sideselect_fnBuildScreen(ifs_sideselect3, 1)
		ifs_sideselect3.Viewport = 2
		AddIFScreen(ifs_sideselect3,"ifs_sideselect3")
		ifs_sideselect3 = DoPostDelete(ifs_sideselect3)

		ifs_sideselect_fnBuildScreen(ifs_sideselect4, 1)
		ifs_sideselect4.Viewport = 3
		AddIFScreen(ifs_sideselect4,"ifs_sideselect4")
		ifs_sideselect4 = DoPostDelete(ifs_sideselect4)
	else
		ifs_sideselect3 = nil -- flush from memory
		ifs_sideselect4 = nil -- flush from memory
	end
end

ifs_sideselect_fnBuildScreen = nil -- free up memory
ifs_sideselect1 = DoPostDelete(ifs_sideselect1)
