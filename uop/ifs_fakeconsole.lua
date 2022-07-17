------------------------------------------------------------------
-- uop recovered source
-- by Anakain
------------------------------------------------------------------

-- ifs_fakeconsole.lua (zerted  PC v1.3 r129 patch )
-- verified decompile by cbadal 
--
--  'ff_rebuildFakeConsoleList()' is defined in fakeconsole_functions.lua
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- Multiplayer game name screen.

-- Helper function. Given a layout (x,y,width, height), returns a
-- fully-built item.
function Fakeconsole_Listbox_CreateItem(layout)

	local insidewidth = layout.width - 20;
	-- Make a coordinate system pegged to the top-left of where the cursor would go.
	local Temp = NewIFContainer {
		x = layout.x - 0.5 * insidewidth, y=layout.y + 2,
		bInertPos = 1,
	}
	local FontHeight = fakeconsole_listbox_layout.fontheight
	Temp.showstr = NewIFText{
		x = 10, y = FontHeight * -0.5, textw = insidewidth, texth = layout.height,
		halign = "left", valign = "vcenter",
		font = fakeconsole_listbox_layout.font,
		ColorR= 255, ColorG = 255, ColorB = 255,
		style = "normal",
		nocreatebackground=1,
		inert_all = 1,
	}
	Temp.run = nil 
	Temp.info = nil 

	return Temp
end

-- Helper function. For a destination item (previously created w/
-- CreateItem), fills it in with data, which may be nil (==blank it)
function Fakeconsole_Listbox_PopulateItem(Dest, Data, bSelected, iColorR, iColorG, iColorB, fAlpha)
	if(Data) then
		-- Contents to show. Do so.
		if(gBlankListbox) then
			IFText_fnSetString(Dest.showstr,"") -- reduce glyphcache usage
		else
			IFText_fnSetString(Dest.showstr,Data.ShowStr)
		end

		IFObj_fnSetColor(Dest.showstr, iColorR, iColorG, iColorB)
		IFObj_fnSetAlpha(Dest.showstr, fAlpha)
	end

	IFObj_fnSetVis(Dest,Data) -- Show if there are contents	
end

fakeconsole_listbox_layout = {
	-- Height is calculated from yHeight, Spacing, showcount.
	yHeight = 22,
	ySpacing  = 0,
	showcount = 19,
	font = gListboxItemFont,

 	width = 320,
	x = 0,
	slider = 1,
	CreateFn = Fakeconsole_Listbox_CreateItem,
	PopulateFn = Fakeconsole_Listbox_PopulateItem,
}

gConsoleCmdList = {}

ifs_fakeconsole = NewIFShellScreen {
	nologo = 1,
	bNohelptext_backPC = 1,
	bDimBackdrop = 1,
	Enter = function(this, bFwd)
		gConsoleCmdList = {}
		
		-- MUST do this after AddIFScreen! This is done here, and not in
		-- Enter to make the memory footprint more consistent.
		fakeconsole_listbox_layout.FirstShownIdx = 1
		fakeconsole_listbox_layout.SelectedIdx = 1
		fakeconsole_listbox_layout.CursorIdx = 1
		ScriptCB_SndPlaySound("shell_menu_enter")
		--ScriptCB_GetConsoleCmds() -- puts contents in gConsoleCmdList
		ff_rebuildFakeConsoleList()

		ListManager_fnFillContents(ifs_fakeconsole.listbox,gConsoleCmdList,fakeconsole_listbox_layout)
	end,

	Exit = function(this, bFwd)
		gBlankListbox = 1
		ListManager_fnFillContents(ifs_fakeconsole.listbox,gConsoleCmdList,fakeconsole_listbox_layout)
		gBlankListbox = nil
	end,
	
	-- Accept button bumps the page
	Input_Accept = function(this)
		if(gMouseListBoxSlider) then
			ListManager_fnScrollbarClick(gMouseListBoxSlider)
			return
		end
		if(gMouseListBox) then
			ScriptCB_SndPlaySound("shell_select_change")
			gMouseListBox.Layout.SelectedIdx = gMouseListBox.Layout.CursorIdx
			ListManager_fnFillContents(gMouseListBox,gMouseListBox.Contents,gMouseListBox.Layout)
--			return
		end

		if(this.CurButton == "_back") then -- Make PC work better - NM 8/5/04
			this:Input_Back()
			return
		end

		local Selection = gConsoleCmdList[fakeconsole_listbox_layout.SelectedIdx]
		ScriptCB_SndPlaySound("shell_menu_enter");
		
		local r2 = fakeconsole_listbox_layout.CursorIdx
		local r3 = fakeconsole_listbox_layout.FirstShownIdx
		local r4 = r2 - r3 
		r4 = r4 +1 
		
		IFObj_fnSetColor(this.listbox[r4].showstr, 255,0,255)
		if ( Selection.run ) then 
			print("ifs_fakeconsole: Is runnable:", Selection.ShowStr, Selection.run)
			ff_serverDidFCCmd()
			Selection.run()
			IFObj_fnSetColor(this.listbox[r4].showstr,0,255,255)
		else 
			ScriptCB_DoConsoleCmd(Selection.ShowStr)
		end 
		--ScriptCB_PopScreen()
	end,
	
	Input_KeyDown = function( this, iKey ) 
		if (iKey  == 27 ) then  -- handle Escape 
			this:Input_Back()
		end 
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
	end, 
	
	Update = function(this, fDt ) 
		-- Yes; I'm aware this code looks really ugly.
		-- But it is functionally the same as the luac -l listing 
		--  -cbadal 
		local r2 = gConsoleCmdList
		local r3 = fakeconsole_listbox_layout.SelectedIdx
		r2 = r2[r3]
		if ( not  r2 ) then 
			return 
		end 
		r3 = this.lastDescribedCommand
		if ( r3 == fakeconsole_listbox_layout.SelectedIdx ) then 
			return 
		end 
		r3 = fakeconsole_listbox_layout
		r3 = r3.SelectedIdx
		this.lastDescribedCommand = r3 
		r3 = r2.ShowStr 
		if ( r3 == "" ) then 
			r2.info = "" 
		end 
		r3 = r2.info 
		if ( not r3  ) then 
			r3 = "Note: No known description"
		end 
		
		IFText_fnSetString(this.description,r3, this.description.case) 
	end, 

	--Back button quits this screen
	Input_Back = function(this)
		ScriptCB_SndPlaySound("shell_menu_exit");
		ScriptCB_PopScreen()
	end,

	Input_GeneralUp = function(this)
		ListManager_fnNavUp(this.listbox,gConsoleCmdList,fakeconsole_listbox_layout)
	end,
	Input_GeneralDown = function(this)
		ListManager_fnNavDown(this.listbox,gConsoleCmdList,fakeconsole_listbox_layout)
	end,

	Input_LTrigger = function(this)
		ListManager_fnPageUp(this.listbox,gConsoleCmdList,fakeconsole_listbox_layout)
	end,
	Input_RTrigger = function(this)
		ListManager_fnPageDown(this.listbox,gConsoleCmdList,fakeconsole_listbox_layout)
	end,

	-- No L/R functionality possible on this screen (gotta have stubs
	-- here, or the base class will override)
	Input_GeneralLeft = function(this)
	end,
	Input_GeneralRight = function(this)
	end,
}

function ifs_fakeconsole_fnBuildScreen(this)
	fakeconsole_listbox_layout.fontheight = ScriptCB_GetFontHeight(fakeconsole_listbox_layout.font)
	fakeconsole_listbox_layout.yHeight = fakeconsole_listbox_layout.fontheight

	this.listbox = NewButtonWindow {
		ZPos = 200, x = 0, y = 0,
		ScreenRelativeY = 0.47999998927116, -- center
		ScreenRelativeX = 0.30000001192093, -- middle of screen

		width = fakeconsole_listbox_layout.width + 35,
		height = fakeconsole_listbox_layout.showcount * (fakeconsole_listbox_layout.yHeight + fakeconsole_listbox_layout.ySpacing) + 30,
	}
	this.description = NewIFText{
		ZPos = 200, x = 0, y = 0,
		halign = "left", 
		font = "gamefont_small",
		nocreatebackground=1,
		ScreenRelativeY = 0.40000000596046, 
		ScreenRelativeX = 0.62000000476837, 
		width = (this.listbox.width * 2 / 3) -2 ,
		
		height = this.listbox.height ,
		textw = this.listbox.width * 2 / 3 - 2,
		texth = this.listbox.height,
		ColorR= 255, ColorG = 255, ColorB = 255,		
		string =""
	}
	ListManager_fnInitList(this.listbox,fakeconsole_listbox_layout)
end

-- Set up listbox

ifs_fakeconsole_fnBuildScreen(ifs_fakeconsole)
ifs_fakeconsole_fnBuildScreen = nil

AddIFScreen(ifs_fakeconsole,"ifs_fakeconsole")
ifs_fakeconsole = DoPostDelete(ifs_fakeconsole)
