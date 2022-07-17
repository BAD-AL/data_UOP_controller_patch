-- ifs_freeform_battle_mode.lua  - zerted patch 1.3
-- verified by BAD_AL
-- 
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

ifs_battle_mode_enter_sound = "mtg_%s_mode_select"

ifs_freeform_battle_vbutton_layout = {
--	yTop = -70,
	xWidth = 300,
	width = 300,
	xSpacing = 10,
	ySpacing = 5,
	font = gMenuButtonFont,
	buttonlist = custom_GetFreeformBattleModeList()
	--[[{ 
		{ tag = "con",   string = "modename.name.con",   },
		{ tag = "ctf",   string = "modename.name.ctf",   },
		{ tag = "1flag", string = "modename.name.1flag", },
		{ tag = "tdm",   string = "modename.name.tdm",   },
		{ tag = "obj",   string = "modename.name.obj",   },
	}]],
	title = "ifs.missionselect.selectmode",
}

ifs_freeform_battle_mode = NewIFShellScreen {
	nologo = 1,
	movieIntro      = nil,
	movieBackground = nil,
	bNohelptext_accept = 1,
	bNohelptext_back = 1,
	bNohelptext_backPC = 1,

	buttons = NewIFContainer {
		ScreenRelativeX = 0.5, -- center
		ScreenRelativeY = gDefaultButtonScreenRelativeY, -- center
	},
	
	Enter = function(this, bFwd)
		gIFShellScreenTemplate_fnEnter(this, bFwd) -- call default enter function
		
		ifs_freeform_SetButtonVis( this, "back", nil )
		ifs_freeform_SetButtonVis( this, "misc", nil )
		ifs_freeform_SetButtonVis( this, "help", nil )
		ifs_freeform_SetButtonName( this, "accept", "ifs.freeform.pickmode" )

		-- get the appropriate map mode list
		this.modes = (ifs_freeform_main.planetFleet[ifs_freeform_main.planetSelected] == 0)
			and ifs_freeform_main.spaceMission or ifs_freeform_main.planetMission[ifs_freeform_main.planetSelected]
		
		-- switch to other player
		if ifs_freeform_main.joystick_other then
			this.originalTeam = ifs_freeform_main.playerTeam
			ifs_freeform_main:SetActiveTeam(3 - ifs_freeform_main.playerTeam)
		end
		
		-- skip if there is only one mode
		local count = 0
		for mode, mission in pairs(this.modes) do
			count = count + 1
		end
		if count <= 1 then
			this:Input_Accept()
			return
		end
		
		ifs_freeform_main:PlayVoice(string.format(ifs_battle_mode_enter_sound, ifs_freeform_main.playerSide))
			
		this.PrevButton = nil
		
		IFObj_fnSetVis(this.title, nil)
		IFText_fnSetUString(this.title.text, 
			ScriptCB_usprintf("ifs.freeform.defendmode",
				ScriptCB_getlocalizestr(ifs_freeform_main.teamName[ifs_freeform_main.playerTeam])
			)
		)

		ifs_freeform_main:UpdatePlayerText(this.player)
		
		-- show only buttons corresponding to game modes
		for _, desc in ipairs(ifs_freeform_battle_vbutton_layout.buttonlist) do
			this.buttons[desc.tag].hidden = not this.modes[desc.tag]
		end
		
		-- show the button list
		this.CurButton = ShowHideVerticalButtons(this.buttons,ifs_freeform_battle_vbutton_layout)
		SetCurButton(this.CurButton)
	end,

	Exit = function(this, bFwd)
		-- switch back to original player
		if this.originalTeam then
			ifs_freeform_main:SetActiveTeam(this.originalTeam)
		end
	end,

	Input_KeyDown = function(this, iKey)
		if iKey == 10 or iKey == 13 then
			-- enter -> accept
			this.CurButton = "_accept"
			this:Input_Accept(-1)
		end
	end,
	
	Input_GeneralUp = function(this, joystick)
 		ifelm_shellscreen_fnPlaySound(this.selectSound)
		gDefault_Input_GeneralUp(this)
	end,
	
	Input_GeneralDown = function(this, joystick)
 		ifelm_shellscreen_fnPlaySound(this.selectSound)
		gDefault_Input_GeneralDown(this)
	end,
	
	Input_Accept = function(this, joystick)
		-- If base class handled this work, then we're done
		if(gShellScreen_fnDefaultInputAccept(this)) then
			return
		end
		ifelm_shellscreen_fnPlaySound(this.acceptSound)

        --[[if(gPlatformStr == "PC" and joystick) then
            --print( "this.CurButton = ", this.CurButton )
            if( this.CurButton == "_accept" ) then
                -- fall through
            else
				return
			end
		end]]
		if( this.CurButton == "_accept" ) then
            print("ifs_freeform_battle_mode: Input_Accept(): Ignoring _accept button")
			return
		end
		print("ifs_freeform_battle_mode: Input_Accept(): CurButton: ", this.CurButton or "[Nil]")
		
		
 		print("ifs_freeform_battle_mode: Input_Accept(): Mission to lanuch: ",
				this.modes [this.CurButton ] or "[Nil]" )
				
		-- set the mission to launch
		ifs_freeform_main:SetLaunchMission(this.modes[this.CurButton])
		
		-- go to the next screen
		ScriptCB_PushScreen("ifs_freeform_battle_card")
	end, -- Input_Accept

	Input_Back = function(this, joystick)
		-- can't go back
	end,
	
	Input_Start = function(this, joystick)
		-- open pause menu
		ScriptCB_PushScreen("ifs_freeform_menu")
	end,
	
	Update = function(this, fDt)
		gIFShellScreenTemplate_fnUpdate(this, fDt) -- call base class

		if this.CurButton and this.CurButton ~= this.PrevButton then
			this.PrevButton = this.CurButton
			IFText_fnSetString(this.info.text, "modename.description." .. this.CurButton)
		end
	end,
}

ifs_freeform_AddCommonElements(ifs_freeform_battle_mode)
ifs_freeform_battle_mode.CurButton = AddVerticalButtons(ifs_freeform_battle_mode.buttons,ifs_freeform_battle_vbutton_layout)
AddIFScreen(ifs_freeform_battle_mode,"ifs_freeform_battle_mode")

