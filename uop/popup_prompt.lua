-- popup_prompt.lua (zerted  PC v1.3 r129 patch )
-- verified decompile by cbadal 


function gPopup_Prompt_fnActivate(this,vis)
	this:fnDefaultActivate(vis)
	if(vis) then
		if( gCurScreenTable and gCurScreenTable.Helptext_Back) then 
				this.EntryScreenTable = gCurScreenTable
				this.bBackVis = IFObj_fnGetVis(gCurScreenTable.Helptext_Back)
				IFObj_fnSetVis(gCurScreenTable.Helptext_Back,nil)
		else 
			this.EntryScreenTable = nil -- 26
		end 
		
		local tagOfFirst = nil 
		local maxItemWidth  = nil 
		tagOfFirst, maxItemWidth = ShowHideVerticalButtons(this.buttons,Vertical_YesNoButtons_layout)
		
		this.fMinWidth = maxItemWidth + 20 
		
		-- Default: "yes" is selected, if not already set
		this.CurButton = this.CurButton or "yes"

		-- A little extra work, but shouldn't be too bad: deselect all
		-- buttons on entry
		IFButton_fnSelect(this.buttons.no,nil)
		IFButton_fnSelect(this.buttons.yes,nil)

		-- Select right button.
		IFButton_fnSelect(this.buttons[this.CurButton],1)
		gCurHiliteButton = this.buttons[this.CurButton]
		
		-- accept input from all controllers
		if (ifs_saveop and ifs_saveop.saveProfileNum) then
			this.iOnlyJoystick = ifs_saveop.saveProfileNum
		end
		if(this.iOnlyJoystick) then
			this.wasRead = ScriptCB_SetHotController(this.iOnlyJoystick)
		end
	else
		-- restore previous input state
		if(this.iOnlyJoystick) then
			ScriptCB_SetHotController(this.wasRead)
			this.wasRead = nil
			this.iOnlyJoystick = nil
		end 
		if(this.EntryScreenTable) then 
			IFObj_fnSetVis(this.EntryScreenTable.Helptext_Back, this.bBackVis)
			this.EntryScreenTable = nil
		end
		
	end
	
end






function gPopup_Prompt_fnInput_Accept(this, iJoystick)
	if (this.CurButton) then 
		gPopup_Prompt_fnActivate(this, nil)
		ifelm_shellscreen_fnPlaySound("shell_menu_accept")

		if( this.fnDone) then 
			if ( this.CurButton == "no") then 
				this.fnDone(nil) 
				return 
			end			
			this.fnDone(IFEditbox_fnGetString(this.box.input))
		end 
	end 
end

function gPopup_Prompt_fnInput_GeneralUp(this, bFromAI)
    gDefault_Input_GeneralUp(this, bFromAI)
end

function gPopup_Prompt_fnInput_GeneralDown(this, bFromAI)
    gDefault_Input_GeneralDown(this, bFromAI)
end

Popup_Prompt = NewPopup {
    ScreenRelativeX = 0.5,
    ScreenRelativeY = 0.5,
    height = 220,
    width = 440,
    ButtonHeightHint = 70,
    ZPos = 50,
    title = NewIFText {
        font = gPopupTextFont,
        textw = 410,
        texth = 160,
        y2 = -100,
        flashy = 0
    },
    buttons = NewIFContainer {
        y = 40
    },
    box = NewIFContainer {
        ScreenRelativeX = 0.5,
        ScreenRelativeY = 0,
        y = 80,
        input = NewEditbox {
            width = 600,
            height = 100,
            font = "gamefont_medium",
            string = "500",
            MaxLen = 2000,
            MaxChars = 2000,
            bKeepsFocus = 1
        }
    },
    fnSetMode = gPopup_YesNo_fnSetMode,

    fnActivate = gPopup_Prompt_fnActivate,

    Input_Accept = function(this, r1)
        gPopup_Prompt_fnInput_Accept(this, r1)
    end,

    Input_GeneralUp = gPopup_Prompt_fnInput_GeneralUp,

    Input_GeneralDown = gPopup_Prompt_fnInput_GeneralDown,

    Input_Back = function(this)
		-- Blank on purpose 
    end,
		--[[
		Keys that are handled in the ifs scripts:
		8: Backspace 
		9:  Tab 
		10: Newline 
		13: Carriage Return 
		27: Esc 
		32: Space 
		43: * 
		44: , 
		45: - 
		61: = 
		95: _ (underscore) 
		-59: F1 
		-211: Delete 
	]]--
    Input_KeyDown = function(this, iKey)
		if((iKey == 10) or (iKey == 13)) then
			-- handle enter 
			this.CurButton = "yes"
			gPopup_Prompt_fnInput_Accept(this, nil)
			return 
		elseif ( iKey == 27 ) then 
			-- handle ESC 
			this.CurButton = "no"
			gPopup_Prompt_fnInput_Accept(this, nil)
			return 
		end 
		IFEditbox_fnAddChar( this.box.input, iKey)
    end
}

AddVerticalButtons(Popup_Prompt.buttons, Vertical_YesNoButtons_layout)
Popup_Prompt.buttons.x2  = Popup_Prompt.buttons.x
CreatePopupInC(Popup_Prompt, "Popup_Prompt")
Popup_Prompt = DoPostDelete(Popup_Prompt)
