------------------------------------------------------------------
-- uop recovered source
-- by Anakain & BAD_AL 
------------------------------------------------------------------

--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- Generalized mission select screen. Done to unify the varions
-- screens 

-- Well, until someone decided to fork things for the PC. - NM 11/3/04

local USING_NEW_PC_SHELL = 1

function ifs_missionselect_pcMulti_fnUsingNewShell( this )
	if( USING_NEW_PC_SHELL ) then
		-- hide option list box	
		IFObj_fnSetVis( this.OptionListbox, nil )
--		IFObj_fnSetVis( this.InfoboxHostOptions, nil )
--		IFObj_fnSetVis( this.HostOptionListbox, nil )		
		if this == ifs_missionselect then 
			IFObj_fnSetVis( this.InfoboxOptions, nil )
		end
	end
end

gPCMultiPlayerSettingsTabsLayout = {
	font = "gamefont_small",
	{ tag = "_opt_playlist", string = "ifs.instantoptions.buttons.title", },
	{ tag = "_opt_global", string = "ifs.instantoptions.buttons.global", },
	{ tag = "_opt_host", string = "ifs.instantoptions.buttons.host", },
	{ tag = "_opt_hero", string = "ifs.instantoptions.buttons.hero", },
	{ tag = "_opt_conquest", string = "ifs.mp.leaderboard.conquest", },
	{ tag = "_opt_ctf", string = "ifs.instantoptions.buttons.CTF", },
	{ tag = "_opt_assault", string = "modename.name.assault", },
	{ tag = "_opt_hunt", string = "ifs.instantoptions.buttons.hunt", },
}

local setting_width = 170
local setting_x_pos = 100
local setting_y_pos = 120
local setting_y_offset = 50
local setting_y_offset1 = 30

if(gUsingControllerExe) then 
	-- with the 'controller' augmented exe, the mission select ui is a bit off.
	-- reduce the widht of the option buttons so they don't go over the list boxes.
	setting_width = 110
end

function ifs_missionselect_pcMulti_fnChangeSettingTabsLayout( this )
	local i
	for i = 1, table.getn( gPCMultiPlayerSettingsTabsLayout ) do
		gPCMultiPlayerSettingsTabsLayout[i].callback = ifs_missionselect_pcMulti_fnClickOptionButtons
		gPCMultiPlayerSettingsTabsLayout[i].width = setting_width
		gPCMultiPlayerSettingsTabsLayout[i].xPos = setting_x_pos
		gPCMultiPlayerSettingsTabsLayout[i].yPos = setting_y_pos
		if( i > 1 ) then
			gPCMultiPlayerSettingsTabsLayout[i].yPos = setting_y_pos + setting_y_offset + (i - 2) * setting_y_offset1
		end
	end
end

function ifs_missionselect_pcMulti_fnAddOptionButtons( this )
	if( USING_NEW_PC_SHELL ) then
		local option_buttons_offset_y = 30
		local option_buttons_offset_y1 = 20
		local option_buttons_width = 150
		local option_buttons_height = ScriptCB_GetFontHeight("gamefont_medium")
		
		this.option_buttons =	NewIFContainer
		{
			ScreenRelativeX = 0,
			ScreenRelativeY = 0,
			x = 60,
			y = 90,
			
--			playlist_btn = NewPCIFButton -- NewRoundIFButton
--			{
--				y = 0,
--				btnw = option_buttons_width, -- made wider to fix 9173 - NM 8/25/04
--				btnh = option_buttons_height,
--				font = "gamefont_small",
--				tag = "_opt_playlist",
--				string = "ifs.missionselect.playlist",
--			}, -- end of btn

			setting = NewIFText { 
				x = -80,
				y = 20,
				halign = "left",
				valign = "vcenter",
				font = "gamefont_tiny", 
				textw = option_buttons_width + 100, 
				texth = option_buttons_height,
				string = "ifs.mp.create.settings",
				nocreatebackground=1, 
			},

--			global_btn = NewPCIFButton -- NewRoundIFButton
--			{
--				y = option_buttons_offset_y1 + option_buttons_offset_y,
--				btnw = option_buttons_width, -- made wider to fix 9173 - NM 8/25/04
--				btnh = option_buttons_height,
--				font = "gamefont_small",
--				tag = "_opt_global",
--				string = "ifs.instantoptions.buttons.global",
--			}, -- end of btn

--			host_btn = NewPCIFButton -- NewRoundIFButton
--			{
--				y = option_buttons_offset_y1 + option_buttons_offset_y * 2,
--				btnw = option_buttons_width, -- made wider to fix 9173 - NM 8/25/04
--				btnh = option_buttons_height,
--				font = "gamefont_small",
--				tag = "_opt_host",
--				string = "ifs.instantoptions.buttons.host",
--			}, -- end of btn

--			hero_btn = NewPCIFButton -- NewRoundIFButton
--			{
--				y = option_buttons_offset_y1 + option_buttons_offset_y * 3,
--				btnw = option_buttons_width, -- made wider to fix 9173 - NM 8/25/04
--				btnh = option_buttons_height,
--				font = "gamefont_small",
--				tag = "_opt_hero",
--				string = "ifs.instantoptions.buttons.hero",
--			}, -- end of btn

--			conquest_btn = NewPCIFButton -- NewRoundIFButton
--			{
--				y = option_buttons_offset_y1 + option_buttons_offset_y * 4,
--				btnw = option_buttons_width, -- made wider to fix 9173 - NM 8/25/04
--				btnh = option_buttons_height,
--				font = "gamefont_small",
--				tag = "_opt_conquest",
--				string = "ifs.mp.leaderboard.conquest",
--			}, -- end of btn

--			ctf_btn = NewPCIFButton -- NewRoundIFButton
--			{
--				y = option_buttons_offset_y1 + option_buttons_offset_y * 5,
--				btnw = option_buttons_width, -- made wider to fix 9173 - NM 8/25/04
--				btnh = option_buttons_height,
--				font = "gamefont_small",
--				tag = "_opt_ctf",
--				string = "ifs.instantoptions.buttons.CTF",
--			}, -- end of btn

--			assault_btn = NewPCIFButton -- NewRoundIFButton
--			{
--				y = option_buttons_offset_y1 + option_buttons_offset_y * 6,
--				btnw = option_buttons_width, -- made wider to fix 9173 - NM 8/25/04
--				btnh = option_buttons_height,
--				font = "gamefont_small",
--				tag = "_opt_assault",
--				string = "modename.name.assault"
--			}, -- end of btn

--			hunt_btn = NewPCIFButton -- NewRoundIFButton
--			{
--				y = option_buttons_offset_y1 + option_buttons_offset_y * 7,
--				btnw = option_buttons_width, -- made wider to fix 9173 - NM 8/25/04
--				btnh = option_buttons_height,
--				font = "gamefont_small",
--				tag = "_opt_hunt",
--				string = "ifs.instantoptions.buttons.hunt",
--			}, -- end of btn			
		}		
		
	end
end

function ifs_missionselect_pcMulti_fnShowHostOptionButton( this, bHideButton )
--	if(this.option_buttons == nil or this.option_buttons.host_btn == nil) then
--		return
--	end
	
	local option_buttons_offset_y = 30
	local option_buttons_offset_y1 = 20
	local option_buttons_width = 150
	local option_buttons_height = ScriptCB_GetFontHeight("gamefont_medium")
	
	local tab_number = 2
	if( this == ifs_instant_options ) then
		tab_number = 3
	end
	
	if(bHideButton == nil) then
		--IFObj_fnSetPos(this.option_buttons.host_btn,this.option_buttons.host_btn.x,option_buttons_offset_y1 + option_buttons_offset_y * 2)
		--IFObj_fnSetPos(this.option_buttons.hero_btn,this.option_buttons.hero_btn.x,option_buttons_offset_y1 + option_buttons_offset_y * 3)
		--IFObj_fnSetPos(this.option_buttons.conquest_btn,this.option_buttons.conquest_btn.x,option_buttons_offset_y1 + option_buttons_offset_y * 4)
		--IFObj_fnSetPos(this.option_buttons.ctf_btn,this.option_buttons.ctf_btn.x,option_buttons_offset_y1 + option_buttons_offset_y * 5)
		--IFObj_fnSetPos(this.option_buttons.assault_btn,this.option_buttons.assault_btn.x,option_buttons_offset_y1 + option_buttons_offset_y * 6)
		--IFObj_fnSetPos(this.option_buttons.hunt_btn,this.option_buttons.hunt_btn.x,option_buttons_offset_y1 + option_buttons_offset_y * 7)
				
		--this.option_buttons.host_btn.bDimmed = nil
		--IFObj_fnSetAlpha(this.option_buttons.host_btn,1)
		--IFObj_fnSetAlpha(this.option_buttons.host_btn.label,1)
		ifelem_tabmanager_SetPos( this, gPCMultiPlayerSettingsTabsLayout, "_opt_hero", tab_number, nil, setting_y_pos + setting_y_offset + (2) * setting_y_offset1  )
		ifelem_tabmanager_SetPos( this, gPCMultiPlayerSettingsTabsLayout, "_opt_conquest", tab_number, nil, setting_y_pos + setting_y_offset + (3) * setting_y_offset1  )
		ifelem_tabmanager_SetPos( this, gPCMultiPlayerSettingsTabsLayout, "_opt_ctf", tab_number, nil, setting_y_pos + setting_y_offset + (4) * setting_y_offset1  )
		ifelem_tabmanager_SetPos( this, gPCMultiPlayerSettingsTabsLayout, "_opt_assault", tab_number, nil, setting_y_pos + setting_y_offset + (5) * setting_y_offset1  )
		ifelem_tabmanager_SetPos( this, gPCMultiPlayerSettingsTabsLayout, "_opt_hunt", tab_number, nil, setting_y_pos + setting_y_offset + (6) * setting_y_offset1  )
		
		ifelem_tabmanager_SetVisable( this, gPCMultiPlayerSettingsTabsLayout, "_opt_host", 1, tab_number )
	else
		--IFObj_fnSetPos(this.option_buttons.hero_btn,this.option_buttons.hero_btn.x,option_buttons_offset_y1 + option_buttons_offset_y * 2)
		--IFObj_fnSetPos(this.option_buttons.conquest_btn,this.option_buttons.conquest_btn.x,option_buttons_offset_y1 + option_buttons_offset_y * 3)
		--IFObj_fnSetPos(this.option_buttons.ctf_btn,this.option_buttons.ctf_btn.x,option_buttons_offset_y1 + option_buttons_offset_y * 4)
		--IFObj_fnSetPos(this.option_buttons.assault_btn,this.option_buttons.assault_btn.x,option_buttons_offset_y1 + option_buttons_offset_y * 5)
		--IFObj_fnSetPos(this.option_buttons.hunt_btn,this.option_buttons.hunt_btn.x,option_buttons_offset_y1 + option_buttons_offset_y * 6)
		--IFObj_fnSetPos(this.option_buttons.host_btn,this.option_buttons.host_btn.x,option_buttons_offset_y1 + option_buttons_offset_y * 7)
		
		--this.option_buttons.host_btn.bDimmed = 1
		--IFObj_fnSetAlpha(this.option_buttons.host_btn,0)
		--IFObj_fnSetAlpha(this.option_buttons.host_btn.label,0)
		--this.option_buttons.host_btn.y = option_buttons_offset_y1 + option_buttons_offset_y * 2
		ifelem_tabmanager_SetPos( this, gPCMultiPlayerSettingsTabsLayout, "_opt_hero", tab_number, nil, setting_y_pos + setting_y_offset + (1) * setting_y_offset1  )
		ifelem_tabmanager_SetPos( this, gPCMultiPlayerSettingsTabsLayout, "_opt_conquest", tab_number, nil, setting_y_pos + setting_y_offset + (2) * setting_y_offset1  )
		ifelem_tabmanager_SetPos( this, gPCMultiPlayerSettingsTabsLayout, "_opt_ctf", tab_number, nil, setting_y_pos + setting_y_offset + (3) * setting_y_offset1  )
		ifelem_tabmanager_SetPos( this, gPCMultiPlayerSettingsTabsLayout, "_opt_assault", tab_number, nil, setting_y_pos + setting_y_offset + (4) * setting_y_offset1  )
		ifelem_tabmanager_SetPos( this, gPCMultiPlayerSettingsTabsLayout, "_opt_hunt", tab_number, nil, setting_y_pos + setting_y_offset + (5) * setting_y_offset1  )
		
		ifelem_tabmanager_SetVisable( this, gPCMultiPlayerSettingsTabsLayout, "_opt_host", nil, tab_number )
	end
end

function ifs_missionselect_pcMulti_fnClickCheckButtons( this )
	custom_ClickCheckButtons(this)
end

function ifs_missionselect_pcMulti_fnSetMapListColor(Dest, Data, bSelected)
	local iColor = 128
	local r4, r5 = nil
	local red = Data.red		--r6
	local green = Data.green	--r7
	local blue = Data.blue		--r8
	
	if ScriptCB_IsFileExist(__v13patchSettings_noColors__) == 0 then
	else
		red = nil
		green = nil
		blue = nil
	end

	
	if((ifs_missionselect_pcMulti.iColumn == 0) or (bSelected)) then
		iColor = 255
	end
	
	if Data.isModLevel == 1 then
		r4 = 128
		r5 = 0
	end
	
	if( Data.bSelected ) then
		local r9 = 200
		local r10 = 0
		local r11 = 0
		IFObj_fnSetColor(Dest.map, r9, r10, r11 )
	else
		local r9 = red or 255
		local r10 = green or r4 or iColor
		local r11 = blue or r5 or iColor
		IFObj_fnSetColor(Dest.map, r9, r10, r11)
		
	end
end

function ifs_missionselect_pcMulti_fnClickMapList( this )
	if( gMouseListBox ) then
	
		local listbox = nil
		local listbox_contents = nil		
		if( gMouseListBox == this.MapListbox ) then
			listbox = this.MapListbox
			listbox_contents = missionselect_listbox_contents
		elseif( gMouseListBox == this.PlayListbox ) then
			listbox = this.PlayListbox
			listbox_contents = gPickedMapList
		end
		
		if( listbox and listbox_contents ) then
			--print( "gMouseListBox.Layout.CursorIdx = ", gMouseListBox.Layout.CursorIdx )
			--print( "gMouseListBox.Layout.SelectedIdx = ", gMouseListBox.Layout.SelectedIdx )
			if( this.bShift ) then
				local index_1 = gMouseListBox.Layout.SelectedIdx
				local index_2 = gMouseListBox.Layout.CursorIdx
				if( gMouseListBox.Layout.CursorIdx < gMouseListBox.Layout.SelectedIdx ) then
					index_1 = gMouseListBox.Layout.CursorIdx
					index_2 = gMouseListBox.Layout.SelectedIdx				
				end
				-- index_1 <= index_2
				local i
				for i = index_1, index_2 do
					listbox_contents[i].bSelected = 1
					local show_index = i + 1 - ( gMouseListBox.Layout.FirstShownIdx or 0 )
					ifs_missionselect_pcMulti_fnSetMapListColor( listbox[show_index], listbox_contents[i], nil )
				end
				return
			elseif( not this.bCtrl ) then
				-- clear all selected
				ifs_missionselect_pcMulti_fnMapListSelect( this, listbox, listbox_contents, gMouseListBox.Layout, 1, nil )
			end
			
			local index = gMouseListBox.Layout.CursorIdx
			local show_index = index + 1 - ( gMouseListBox.Layout.FirstShownIdx or 0 )
			if( listbox_contents[index].bSelected ) then
				listbox_contents[index].bSelected = nil
			else
				listbox_contents[index].bSelected = 1
			end
			ifs_missionselect_pcMulti_fnSetMapListColor( listbox[show_index], listbox_contents[index], nil )
			
			if(listbox == this.MapListbox) then
				-- update mode&era list
				ifs_missionselect_pcMulti_fnShowHideGameModes( this )
				ifs_missionselect_pcMulti_fnShowHideEra( this )				
			end
		end
	end
end

function ifs_missionselect_pcMulti_fnMapListSelect( this, listbox, listbox_contents, layout, bIsAll, bSelected )
	if( bIsAll ) then	
		-- select all maps
		local i
		for i = 1, table.getn(listbox_contents) do
			listbox_contents[i].bSelected = bSelected
			
			-- set color to selected items
			local show_index = i + 1 - ( layout.FirstShownIdx or 0 )
			if( ( i >= layout.FirstShownIdx ) and
				( i <= ( layout.FirstShownIdx + layout.showcount - 1 ) ) ) then
				ifs_missionselect_pcMulti_fnSetMapListColor( listbox[show_index], listbox_contents[i], nil )
			end
		end		
	end
end

function ifs_missionselect_pcMulti_fnUpdateKeyboard( this )
	this.bShift, this.bCtrl = ScriptCB_GetKeyboardPCFlags()
--	if( this.bShift ) then
--		--print( "this.bShift = ", this.bShift )
--	elseif( this.bCtrl ) then
--		--print( "this.bCtrl = ", this.bCtrl )
--	end
end

function ifs_missionselect_pcMulti_fnDeleteAllPopupDone(bResult)
	local this = Popup_YesNo.this_screen
	if( this ) then
		if(bResult) then
			ifs_missionselect_pcMulti_fnDeleteMapNew( this, 1 )
		end
	end
	Popup_YesNo:fnActivate(nil)
end

function ifs_missionselect_pcMulti_fnClickMapButtons( this )
	-- map buttons
	if(this.CurButton == "_map_add") then
		ifs_missionselect_pcMulti_fnAddMapNew( this )
	elseif(this.CurButton == "_map_remove") then
		ifs_missionselect_pcMulti_fnDeleteMapNew( this, nil )
	elseif(this.CurButton == "_map_remove_all") then
		-- prompt if there are items
		if( table.getn(gPickedMapList) > 0 ) then
			-- Prompt to create new account
			Popup_YesNo.CurButton = "no" -- default
			Popup_YesNo.fnDone = ifs_missionselect_pcMulti_fnDeleteAllPopupDone
			Popup_YesNo.this_screen = this
			Popup_YesNo:fnActivate(1)
			gPopup_fnSetTitleStr(Popup_YesNo, "mapname.name.remove_popup")
		end
	elseif(this.CurButton == "_up_btn") then
		ifs_missionselect_pcMulti_fnPlayListChangeOrder( this, 1 )
	elseif(this.CurButton == "_down_btn") then
		ifs_missionselect_pcMulti_fnPlayListChangeOrder( this, nil )
	elseif(this.CurButton == "_select_all") then
		ifs_missionselect_pcMulti_fnMapListSelect( this, this.MapListbox, missionselect_listbox_contents, ifs_mspc_MapList_layout, 1, 1 )
		ifs_missionselect_pcMulti_fnShowHideGameModes( this )
		ifs_missionselect_pcMulti_fnShowHideEra( this )
	end
end

function ifs_missionselect_pcMulti_fnClickOptionButtons( this )
	if( USING_NEW_PC_SHELL ) then
		print( "this.CurButton =", this.CurButton )
		local cur_button = nil
		if(this.CurButton == "_opt_playlist") then
			if( ifs_main and ifs_main.option_mp ) then
				-- multiplayer
				if( this ~= ifs_missionselect_pcMulti ) then
					ScriptCB_SetIFScreen( "ifs_missionselect_pcMulti" )
				end
			else
				-- single player
				if( this ~= ifs_missionselect ) then
					ScriptCB_SetIFScreen( "ifs_missionselect" )
				end			
			end
		elseif(this.CurButton == "_opt_global") then
			cur_button = ifs_ioo_OptionButton_layout.buttonlist[1].tag
		elseif(this.CurButton == "_opt_host") then
			cur_button = ifs_ioo_OptionButton_layout.buttonlist[2].tag
		elseif(this.CurButton == "_opt_hero") then
			cur_button = ifs_ioo_OptionButton_layout.buttonlist[3].tag
		elseif(this.CurButton == "_opt_conquest") then
			cur_button = ifs_ioo_OptionButton_layout.buttonlist[4].tag
		elseif(this.CurButton == "_opt_ctf") then
			cur_button = ifs_ioo_OptionButton_layout.buttonlist[5].tag
		elseif(this.CurButton == "_opt_hunt") then
			cur_button = ifs_ioo_OptionButton_layout.buttonlist[6].tag
		elseif(this.CurButton == "_opt_assault") then
			cur_button = ifs_ioo_OptionButton_layout.buttonlist[7].tag
		end
		
		print( "cur_button =", cur_button )
		-- go to option screen
		if( cur_button ) then
			ifs_instant_options_SetOptionGroup( cur_button, this.CurButton )
			ifelm_shellscreen_fnPlaySound(this.acceptSound)
			--ifs_movietrans_PushScreen(ifs_instant_options)		
			ScriptCB_SetIFScreen( "ifs_instant_options" )
		end
	end
end

-- Callback function when the virtual keyboard is done
function ifs_pc_mp_fnKeyboardDone()
	if(string.len(ifs_vkeyboard.CurString) > 1) then

		-- Hack! Netcode should be unicoded
		ScriptCB_SetGameName(ScriptCB_ununicode(ifs_vkeyboard.CurString))
		ifs_vkeyboard.CurString = "" -- clear
		--ifs_missionselect.bForMP = 1
		--ScriptCB_SetMetagameRulesOn(nil) -- for ingame
		ScriptCB_PopScreen()
		vkeyboard_specs.fnDone = nil -- clear our registration there
	else
	end
end

-- Helper function. Given a layout (x,y,width, height), returns a
-- fully-built item.
function pcMissionSelectListboxL_CreateItem(layout)
	-- Make a coordinate system pegged to the top-left of where the cursor would go.
	local Temp = NewIFContainer { 
		x = layout.x - 0.5 * layout.width, 
		y = layout.y,
	}

	local HAlign = "left"
	local XPos = 5
	local WidthAdj = -5

	Temp.map = NewIFText { 
		x = XPos,
		y = layout.height * -0.5 + 2,
		halign = HAlign, valign = "vcenter",
		font = "gamefont_tiny", 
		textw = layout.width + WidthAdj, texth = layout.height,
		startdelay=math.random()*0.5, nocreatebackground=1, 
	}

	return Temp
end

-- Helper function. Given a layout (x,y,width, height), returns a
-- fully-built item.
function pcMissionSelectListboxR_CreateItem(layout)
	-- Make a coordinate system pegged to the top-left of where the cursor would go.
	local Temp = NewIFContainer { 
		x = layout.x - 0.5 * layout.width, 
		y = layout.y,
	}

	local HAlign = "left"
	local XPos = 5
	local WidthAdj = -5

	Temp.map = NewIFText { 
		x = XPos,
		y = layout.height * -0.5 + 2,
		halign = HAlign, valign = "vcenter",
		font = "gamefont_tiny", 
		textw = layout.width + WidthAdj, texth = layout.height,
		startdelay=math.random()*0.5, 
		nocreatebackground=1, 
	}
	
	-- the icon
	local iconSize = layout.height * 0.65
	Temp.icon1 = NewIFImage {
 		ZPos = 0, 
 		x = layout.width - iconSize * 1.3, 
 		y = -4,
 		localpos_l = 0, localpos_t = 0,
 		localpos_r = iconSize, localpos_b = iconSize,
		texture = custom_UnknownEraIcon1,
	}
	Temp.icon2 = NewIFImage {
 		ZPos = 0, 
 		x = layout.width - iconSize * 2.5,
 		y = -4,
 		localpos_l = 0, localpos_t = 0,
 		localpos_r = iconSize, localpos_b = iconSize,
		texture = custom_UnknownEraIcon2,
	}	

	return Temp
end

-- Helper function. For a destination item (previously created w/
-- CreateItem), fills it in with data, which may be nil (==blank it)
function pcMissionSelectListboxL_PopulateItem(Dest,Data)
	if(Data) then
		-- Show the data
		local DisplayUStr,iSource = missionlist_GetLocalizedMapName(Data.mapluafile)
		IFText_fnSetUString(Dest.map,DisplayUStr)
	end

	IFObj_fnSetVis(Dest.map,Data)

end

-- Helper function. For a destination item (previously created w/
-- CreateItem), fills it in with data, which may be nil (==blank it)
function pcMissionSelectListboxR_PopulateItem(Dest,Data)
	if(Data) then
		-- Update contents
		local DisplayUStr,iSource = missionlist_GetLocalizedMapName(Data.Map)
		IFText_fnSetUString(Dest.map,DisplayUStr)
	
		local r4, r5, r6, r7 = custom_GetSideCharIconInfo(Data.SideChar)
		IFImage_fnSetTexture(Dest.icon1,r4)
		IFImage_fnSetTexture(Dest.icon2,r5)
		IFObj_fnSetVis(Dest.icon1,r6)
		IFObj_fnSetVis(Dest.icon2,r7)
		
		-- set the icon texture
		-- if (Data.SideChar == "g") then
			-- IFImage_fnSetTexture(Dest.icon1,"imp_icon")
			-- IFImage_fnSetTexture(Dest.icon2,"all_icon")
			-- IFObj_fnSetVis(Dest.icon2,1)
		-- elseif (Data.SideChar == "c") then
			-- IFImage_fnSetTexture(Dest.icon1,"rep_icon")
			-- IFImage_fnSetTexture(Dest.icon2,"cis_icon")
			-- IFObj_fnSetVis(Dest.icon1,1)
			-- IFObj_fnSetVis(Dest.icon2,1)
		-- else
			-- IFObj_fnSetVis(Dest.icon1,nil)
			-- IFObj_fnSetVis(Dest.icon2,nil)
		-- end
	end

	-- Turn on/off depending on whether data's there or not
	IFObj_fnSetVis(Dest,Data)
end

pc_missionselect_name_listboxL_layout = {
	showcount = 2,
--	yTop = -130 + 13, -- auto-calc'd now
	yHeight = 26,
	ySpacing  = 0,
--	width = 260,
	x = 0,
	slider = 1,
	CreateFn = pcMissionSelectListboxL_CreateItem,
	PopulateFn = pcMissionSelectListboxL_PopulateItem,
}

pc_missionselect_name_listboxR_layout = {
	showcount = 2,
--	yTop = -130 + 13, -- auto-calc'd now
	yHeight = 26,
	ySpacing  = 0,
--	width = 260,
	x = 0,
	slider = 1,
	CreateFn = pcMissionSelectListboxR_CreateItem,
	PopulateFn = pcMissionSelectListboxR_PopulateItem,
}

function ifs_missionselect_pcMulti_fnShowHideListboxes(this,bShowThem)
	local A1,A2
	local fAnimTime = 0.3

	if(bShowThem) then
		A1 = 0
		A2 = 1
		this.AddDelContainer.add.bHidden = 1
		this.AddDelContainer.del.bHidden = 1
	else
		A1 = 1
		A2 = 0
		this.AddDelContainer.add.bHidden = nil
		this.AddDelContainer.del.bHidden = nil
	end

	AnimationMgr_AddAnimation(this.AddDelContainer, { fStartAlpha = A1, fEndAlpha = A2,})

--	AnimationMgr_AddAnimation(this.listboxL, { fStartAlpha = A1, fEndAlpha = A2,})
--	AnimationMgr_AddAnimation(this.listboxR, { fStartAlpha = A1, fEndAlpha = A2,})
end

function ifs_missionselect_pcMulti_fnFullPopupDone()
	local this = ifs_missionselect_pcMulti
	ifs_missionselect_pcMulti_fnShowHideListboxes(this,1)
end


-- Flips map order
function ifs_missionselect_pcMulti_fnToggleOrder(this)
	this.bRandomOrder = not this.bRandomOrder
	if(this.bRandomOrder) then
		RoundIFButtonLabel_fnSetString(this.OrderButton,"ifs.missionselect.random")
	else
		RoundIFButtonLabel_fnSetString(this.OrderButton,"ifs.missionselect.inorder")
	end
end

-- Sets up the map preview based on the current selection
function ifs_missionselect_pcMulti_fnSetMapPreview(this)
--	print("ifs_missionselect_pcMulti_fnSetMapPreview")
	local movieName = nil
	local movieFile = nil
	local idx = nil
	
	for i = 1, table.getn(missionselect_listbox_contents), 1 do
		if missionselect_listbox_contents[i].bSelected then
			idx = i
		end
	end
	
	--lbl 16
	if idx == nil then
		idx = 1
		print("ifs_missionselect_pcMulti_fnSetMapPreview(): Defaulting index to 1")
	end
	local r4 = missionselect_listbox_contents[idx]
	movieName, movieFile = missionlist_fnGetMovieName(r4)
	
	--local num = pc_missionselect_name_listboxL_layout.SelectedIdx or 1

	--local Selection = missionselect_listbox_contents[num]
	--movieName, movieFile = missionlist_fnGetMovieName(Selection)

	if (movieName) then
		--ifelem_shellscreen_fnStartMovie(movieName.."fly", nil, this.movieX,this.movieY,this.movieW,this.movieH)
		this.movieName = movieName
		this.movieTime = 0.5
		this.movieFile = movieFile
		
		print("ifs_missionselect_pcMulti_fnSetMapPreview(): Stored movie name, file: ", movieName, movieFile)
	else
		ifelem_shellscreen_fnStopMovie()		
	end
	IFObj_fnSetVis(this.Map,nil)
end

-- Helper function, manages the state of the 'Delete' button
function ifs_missionselect_pcMulti_fnUpdateDelButton(this)
	local bShouldBeOn = (this.iPage == 0) and (not this.bOnLeft) and (not this.bOnButtons) and (table.getn(gPickedMapList) > 0)
	
	bShouldBeOn = nil

end

-- Sets the current button to the specified table (which can be nil)
function ifs_missionselect_pcMulti_fnSetCurButton(this,tNewButton,ButtonStr)

	-- Always deselect old button if set
	if(gCurHiliteButton) then
		IFButton_fnSelect(gCurHiliteButton,nil)
	end

	if(tNewButton) then
		this.CurButton = ButtonStr
		this.bOnButtons = 1
		gCurHiliteButton = tNewButton
		IFButton_fnSelect(gCurHiliteButton,1)
		pc_missionselect_name_listboxR_layout.CursorIdx = nil
		pc_missionselect_name_listboxL_layout.CursorIdx = nil
--		ListManager_fnFillContents(this.listboxR,gPickedMapList,pc_missionselect_name_listboxR_layout)
--		ListManager_fnFillContents(this.listboxL,missionselect_listbox_contents,pc_missionselect_name_listboxL_layout)
	else
		this.bOnButtons = nil
		gCurHiliteButton = nil
	end
end

-- Sets up the screen for the specified page
function ifs_missionselect_pcMulti_fnSetPage(this,iNewPage)
	-- Early exit if changing to same page
	if(this.iPage == iNewPage) then
		return
	end
	local iLastPage = this.iPage

	-- Page 2 isn't allowed anymore - NM 4/5/04
	assert(iNewPage ~= 2)

	-- Turn off items as appropriate when leaving a page
	if(iLastPage == 0) then
		-- Listboxes will always be off on the other pages
--		AnimationMgr_AddAnimation(this.listboxL, { fStartAlpha = 1, fEndAlpha = 0.0,})
--		AnimationMgr_AddAnimation(this.listboxR, { fStartAlpha = 1, fEndAlpha = 0.5,})
--		this.listboxL.bHidden = 1
--		this.listboxR.bHidden = 1
		this.OrderButton.bHidden = 1

		if( this ~= ifs_missionselect  ) then 
	--		this.LaunchButton.bHidden = 1
	--		this.LanButton.bHidden = 1
	--		this.EditGameName.bHidden = 1
	--		this.EditPass.bHidden = 1
			this.EditContainer.bHidden = 1
			this.EditPwdContainer.bHidden = 1
	--		this.OptionButton.bHidden = 1
		end 
		
		AnimationMgr_AddAnimation(this.Map, { fStartAlpha = 1, fEndAlpha = 0.5,})
		AnimationMgr_AddAnimation(this.OrderButton, { fStartAlpha = 1, fEndAlpha = 0,})
		
--		AnimationMgr_AddAnimation(this.LaunchButton, { fStartAlpha = 1, fEndAlpha = 0,})
--		AnimationMgr_AddAnimation(this.LanButton, { fStartAlpha = 1, fEndAlpha = 0,})
--		AnimationMgr_AddAnimation(this.EditGameName, { fStartAlpha = 1, fEndAlpha = 0,})
--		AnimationMgr_AddAnimation(this.EditPass, { fStartAlpha = 1, fEndAlpha = 0,})
		if ( this ~= ifs_missionselect ) then 
			AnimationMgr_AddAnimation(this.EditContainer, { fStartAlpha = 1, fEndAlpha = 0,})
			AnimationMgr_AddAnimation(this.EditPwdContainer, { fStartAlpha = 1, fEndAlpha = 0,})
	--		AnimationMgr_AddAnimation(this.OptionButton, { fStartAlpha = 1, fEndAlpha = 0,})
		end 
		this.AddDelContainer.add.bHidden = 1
		this.AddDelContainer.del.bHidden = 1
		AnimationMgr_AddAnimation(this.AddDelContainer, { fStartAlpha = 1, fEndAlpha = 0,})

		-- Also, update title
--		AnimationMgr_AddAnimation(this.titleL, { fStartAlpha = 1, fEndAlpha = 0,})
--		AnimationMgr_AddAnimation(this.titleR, { fStartAlpha = 1, fEndAlpha = 0,})
	elseif (iLastPage == 1) then
		-- Fade off buttons if they won't be on anymore
		if(iNewPage == 0) then
			AnimationMgr_AddAnimation(this.buttons, { fStartAlpha = 1, fEndAlpha = 0,})
			this.buttons.bHidden = 1
		end
	elseif (iLastPage == 2) then
		-- Fade off buttons if they won't be on anymore
		if(iNewPage == 0) then
			AnimationMgr_AddAnimation(this.buttons, { fStartAlpha = 1, fEndAlpha = 0,})
			this.buttons.bHidden = 1
		end
	end

	-- Set the new page
	this.iPage = iNewPage

	-- Turn off items as appropriate when leaving a page
	if(iNewPage == 0) then
		-- Listboxes will always be on for this page
--		AnimationMgr_AddAnimation(this.listboxL, { fStartAlpha = 0, fEndAlpha = 1,})
--		AnimationMgr_AddAnimation(this.listboxR, { fStartAlpha = 0.5, fEndAlpha = 1,})
--		this.listboxL.bHidden = nil
--		this.listboxR.bHidden = nil
		AnimationMgr_AddAnimation(this.Map, { fStartAlpha = 0, fEndAlpha = 1,})
		AnimationMgr_AddAnimation(this.OrderButton, { fStartAlpha = 0, fEndAlpha = 1,})
--		AnimationMgr_AddAnimation(this.LaunchButton, { fStartAlpha = 0, fEndAlpha = 1,})
--		AnimationMgr_AddAnimation(this.LanButton, { fStartAlpha = 0, fEndAlpha = 1,})
--		AnimationMgr_AddAnimation(this.EditGameName, { fStartAlpha = 0, fEndAlpha = 1,})
--		AnimationMgr_AddAnimation(this.EditPass, { fStartAlpha = 0, fEndAlpha = 1,})
		if ( this ~= ifs_missionselect ) then 
			AnimationMgr_AddAnimation(this.EditContainer, { fStartAlpha = 0, fEndAlpha = 1,})
			AnimationMgr_AddAnimation(this.EditPwdContainer, { fStartAlpha = 0, fEndAlpha = 1,})		
		end 
--		AnimationMgr_AddAnimation(this.OptionButton, { fStartAlpha = 0, fEndAlpha = 1,})
		-- Also, update title
--		AnimationMgr_AddAnimation(this.titleL, { fStartAlpha = 0, fEndAlpha = 1,})
--		AnimationMgr_AddAnimation(this.titleR, { fStartAlpha = 0, fEndAlpha = 1,})
		this.OrderButton.bHidden = nil
--		this.LaunchButton.bHidden = nil
--		this.LanButton.bHidden = 1
--		this.EditGameName.bHidden = nil
--		this.EditPass.bHidden = nil
		
		if ( this ~= ifs_missionselect ) then 
			this.EditContainer.bHidden = nil
			this.EditPwdContainer.bHidden = nil
	--		this.OptionButton.bHidden = nil
		end 

		this.AddDelContainer.add.bHidden = nil
		this.AddDelContainer.del.bHidden = nil
		AnimationMgr_AddAnimation(this.AddDelContainer, { fStartAlpha = 0, fEndAlpha = 1,})

		this.bOnButtons = nil
		this.AttackerChar = nil
	elseif (iNewPage == 1) then
		-- Turn on buttons if they weren't on before
		if(iLastPage == 0) then
			AnimationMgr_AddAnimation(this.buttons, { fStartAlpha = 0, fEndAlpha = 1,})
			this.buttons.bHidden = nil
			-- also set the title bar of the era buttons to the mission name
			-- it probably ain't gonna fit for other languages
			if(gLangStr == "english") then
				local MapNameUStr = missionlist_GetLocalizedMapName(missionselect_listbox_contents[pc_missionselect_name_listboxL_layout.SelectedIdx].mapluafile)
				IFText_fnSetUString(this.buttons._titlebar_,MapNameUStr)
			end
		end
--		this.listboxL.bHidden = 1
--		this.listboxR.bHidden = 1
		this.OrderButton.bHidden = 1
--		this.LaunchButton.bHidden = 1
--		this.LanButton.bHidden = 1
--		this.EditGameName.bHidden = 1
--		this.EditPass.bHidden = 1
		
		if ( this ~= ifs_missionselect ) then 
			this.EditContainer.bHidden = 1
			this.EditPwdContainer.bHidden = 1		
	--		this.OptionButton.bHidden = 1
		end

		SetCurButton("c")

	elseif (iNewPage == 2) then
		-- Turn on buttons if they weren't on before
		if(iLastPage == 0) then
			AnimationMgr_AddAnimation(this.buttons, { fStartAlpha = 0, fEndAlpha = 1,})
			this.buttons.bHidden = nil
		end
--		this.listboxL.bHidden = 1
--		this.listboxR.bHidden = 1
		this.OrderButton.bHidden = 1
--		this.LaunchButton.bHidden = 1
--		this.LanButton.bHidden = 1
--		this.EditGameName.bHidden = 1
--		this.EditPass.bHidden = 1
		if ( this ~= ifs_missionselect ) then 
			this.EditContainer.bHidden = 1
			this.EditPwdContainer.bHidden = 1		
	--		this.OptionButton.bHidden = 1
		end 
	end

	if ( this ~= ifs_missionselect ) then 
		ifs_missionselect_pcMulti_fnUpdateDelButton(this)
	else 
		ifs_missionselect_fnUpdateDelButton(this)
	end 
end

-- Adds the currently selected map to the maplist.
function ifs_missionselect_pcMulti_fnAddMap(this)
	print("Zerted: ifs_missionselect_pcMulti_fnAddMap(): IS THIS EVEN EVER CALLED?")
	print("Zerted: ifs_missionselect_pcMulti_fnAddMap(): CRASHING THE GAME SO WE KNOW WE GOT HERE!")
	print(nil)
	
	--[[
	local Selection = missionselect_listbox_contents[pc_missionselect_name_listboxL_layout.SelectedIdx]
	local Team1Name
	local Team2Name

	-- Turn era into side character
	if(this.CurButton == "c") then
		this.SideChar = "c"
		Team1Name = "common.sides.rep.name"
		Team2Name = "common.sides.cis.name"
	else
		this.SideChar = "g"
		Team1Name = "common.sides.all.name"
		Team2Name = "common.sides.imp.name"
	end

	ifs_missionselect_pcMulti_fnSetMapAndTeam(this,Selection,Team1Name,Team2Name)
	this.Team1Name = ScriptCB_getlocalizestr(Team1Name)
	this.Team2Name = ScriptCB_getlocalizestr(Team2Name)

	ifs_missionselect_pcMulti_fnSetPage(this,0)
	]]
	
end

-- Utility function - based on the .hidden flag in buttons (already
-- created), shows/hides buttons. Adjusts spacing too. Returns tag of
-- first selectable button.
function ifs_missionselect_pcMulti_fnShowHideItems(dest,layout)
	local xWidth = layout.xWidth or 40
	local xSpacing = layout.xSpacing or 10
	local height = layout.height or 40
	local Font = layout.font or "gamefont_small"
	local yTop = layout.yTop or 0

	local i
	local Count = table.getn(layout.buttonlist)
	local TagOfFirst = nil

	-- Figure out how many are actually visible
	local ShowCount = 0
	for i = 1,Count do
		local label = layout.buttonlist[i].tag
		if(not dest[label].hidden) then
			ShowCount = ShowCount + 1
		end
	end

	local xLeft = ((ShowCount - 1) * (xWidth + xSpacing)) * -0.5

	for i = 1,Count do
		local label = layout.buttonlist[i].tag
		local label2 = layout.buttonlist[i].tag .. "_image"
		IFObj_fnSetVis(dest[label], not dest[label].hidden)
		IFObj_fnSetVis(dest[label2], not dest[label].hidden)

		dest[label].bHidden = dest[label].hidden
		dest[label2].bHidden = dest[label].hidden

		if(not dest[label].hidden) then
			-- not hidden. Show it
			TagOfFirst = TagOfFirst or label -- note which was the first

			IFObj_fnSetVis(dest[label], 1)
			IFObj_fnSetPos(dest[label], xLeft, yTop + 20)
			IFObj_fnSetVis(dest[label2], 1)
			IFObj_fnSetPos(dest[label2], xLeft, 0)

		 xLeft = xLeft + xWidth + xSpacing
		end -- showing this one
	end

	return ShowCount,TagOfFirst
end

-- Tthe side selection is implicit in the selection here, except for
-- the maps that only have one side, and you have to go back around
-- and handle them as special cases. 
function ifs_missionselect_pcMulti_fnSetMapAndTeam(this,Selection,Team1Str,Team2Str)

	print("Zerted: ifs_missionselect_pcMulti_fnSetMapAndTeam(): IS THIS EVEN EVER CALLED?")
	print("Zerted: ifs_missionselect_pcMulti_fnSetMapAndTeam(): CRASHING THE GAME SO WE KNOW WE GOT HERE!")
	print(nil)
	
	--[[local SelectedMap = string.format(Selection.mapluafile, this.SideChar, "con")
	local Side = 1 -- 1 or 2

	local Idx = table.getn(gPickedMapList) + 1
	gPickedMapList[Idx] = {
		Map = SelectedMap,
		mapluafile = Selection.mapluafile,
		dnldable = Selection.dnldable,
		Side = Side,
		SideChar = this.SideChar,
		Team1 = Team1Str,
		Team2 = Team2Str,
	}

	pc_missionselect_name_listboxR_layout.FirstShownIdx = pc_missionselect_name_listboxR_layout.FirstShownIdx or 1
	pc_missionselect_name_listboxR_layout.SelectedIdx = pc_missionselect_name_listboxR_layout.SelectedIdx or 1
	pc_missionselect_name_listboxR_layout.CursorIdx = nil

--	ListManager_fnFillContents(this.listboxR,gPickedMapList,pc_missionselect_name_listboxR_layout)
	-- Hack - refresh the left column next to get the cursor back.
--	ListManager_fnFillContents(this.listboxL,missionselect_listbox_contents,pc_missionselect_name_listboxL_layout)
]]
end

function ifs_missionselect_pcMulti_fnFlipLeftRight(this)
	ifelm_shellscreen_fnPlaySound(this.selectSound)
	this.bOnLeft = not this.bOnLeft

	if(this.bOnLeft) then
		pc_missionselect_name_listboxR_layout.CursorIdx = nil
--		ListManager_fnFillContents(this.listboxR,gPickedMapList,pc_missionselect_name_listboxR_layout)
		pc_missionselect_name_listboxL_layout.CursorIdx = pc_missionselect_name_listboxL_layout.SelectedIdx
--		ListManager_fnFillContents(this.listboxL,missionselect_listbox_contents,pc_missionselect_name_listboxL_layout)
	else
		-- On the right side
		pc_missionselect_name_listboxL_layout.CursorIdx = nil
--		ListManager_fnFillContents(this.listboxL,missionselect_listbox_contents,pc_missionselect_name_listboxL_layout)
		pc_missionselect_name_listboxR_layout.CursorIdx = pc_missionselect_name_listboxR_layout.SelectedIdx
--		ListManager_fnFillContents(this.listboxR,gPickedMapList,pc_missionselect_name_listboxR_layout)
	end
--	ifs_missionselect_pcMulti_fnSetMapPreview(this)
	ifs_missionselect_pcMulti_fnUpdateDelButton(this)
end

-- Helper function - returns a bool as to whether the selection has
-- multiple sides, and also the char of the last (only?) side noticed.
function ifs_missionselect_pcMulti_fnGetSides(Selection)

	print("Zerted: ifs_missionselect_pcMulti_fnGetSides(): IS THIS EVEN EVER CALLED?")
	return custom_GetSides(Selection)
	--[[local bMultipleSides
	local LastSideChar = nil
	
	if(Selection.era_g) then
		bMultipleSides = (LastSideChar ~= nil)
		LastSideChar = "g"
	end
	if(Selection.era_c) then
		bMultipleSides = (LastSideChar ~= nil)
		LastSideChar = "c"
	end

	return bMultipleSides,LastSideChar]]
end

function ifs_missionselect_pcMulti_fnLaunch(this)
	if(table.getn(gPickedMapList) > 0) then
	
		
		this.SelectedMap = 1
		ScriptCB_SetMissionNames(gPickedMapList,this.bRandomOrder)
		local password = IFEditbox_fnGetString(this.EditPwdContainer.EditPass)

		-- Fix so that passwords can work on games
		this.GamePrefs = ScriptCB_GetNetGameDefaults()
		this.GamePrefs.PasswordStr = password
		ScriptCB_SetNetGameDefaults(this.GamePrefs)

		--ScriptCB_SetNetGameDefaults(ifs_mp_gameopts.iNumPlayers,ifs_mp_gameopts.iWarmUp,ifs_mp_gameopts.iVote,ifs_mp_gameopts.iNumBots,ifs_mp_gameopts.iTeamDmg,ifs_mp_gameopts.iAutoAim,ifs_mp_gameopts.bIsPrivate,ifs_mp_gameopts.bShowNames,ifs_mp_gameopts.bAutoAssignTeams,ifs_mp_gameopts.iStartCnt,ifs_mp_gameopts.bHeroesEnabled,ifs_mp_gameopts.iDifficulty,password)
-- 		ScriptCB_SetNetGameDefaults( ifs_mp_gameopts.Prefs )
-- 		ScriptCB_SetDedicated(ifs_mp_gameopts.bDedicated)
		
		-- set hero options
-- 		ScriptCB_SetNetHeroDefaults( ifs_mp_heroopts.Prefs )
		
		ScriptCB_SetGameName(IFEditbox_fnGetString(this.EditContainer.EditGameName))
		
--		if(this.bLan) then
--			gOnlineServiceStr = "LAN"
--			ScriptCB_SetConnectType("lan")
--		else
--			gOnlineServiceStr = "GameSpy"
--		end
		
		if(this.bDedicated) then
			ifs_movietrans_PushScreen(ifs_mp_lobbyds)
		else
			ifs_mp_gameopts.bAutoLaunch = 1
--			print("Calling BeginLobby" )
			ScriptCB_BeginLobby()
		end
	else
		ifelm_shellscreen_fnPlaySound(this.errorSound)
	end
end

-- pass the name of the downloadable content movie file to open it, or nil to open
-- the normal DVD flythrough movie file.
function ifs_missionselect_pcMulti_ChangeMovieFile(movieFile, isMissionselect)
--	print("ifs_missionselect_pcMulti_ChangeMovieFile(",movieFile,")")

	if(not movieFile ) then 
		print("ifs_missionselect_pcMulti_ChangeMovieFile(): MovieFile is nil")
	else 
		print("ifs_missionselect_pcMulti_ChangeMovieFile(): MovieFile:", file) -- looks like defect. -BAD_AL 
	end 
	
	local this = nil
	if isMissionselect then
		this = ifs_missionselect
	else
		this = ifs_missionselect_pcMulti
	end
	
	-- don't change anything if its the same file
	if(movieFile == this.lastMovieFile) then
		print("ifs_missionselect_pcMulti_ChangeMovieFile(): Same as last movie")
		return
	end
	-- remember this for next time
	this.lastMovieFile = movieFile
	print("ifs_missionselect_pcMulti_ChangeMovieFile(): Closed any open movie")
	
	-- close the last one
	ScriptCB_CloseMovie()
	
	-- set the DC directory, so we can find the correct movie file
	--ScriptCB_SetDCMap(movieFile)
	
	if not movieFile then
		return
	end
	
	
	-- open the new one
	-- local dcPrefix = "dc:"
	 local pal = ""
	-- if(not movieFile) then
		-- dcPrefix = ""
		-- movieFile = "fly"
	-- end
	if (ScriptCB_IsPAL() == 1) then
		pal = "pal"
	end	
	-- downloadable pal looks like:     "dc:movies\\RHN3pal.mvs"
	-- downloadable content looks like: "dc:movies\\RHN3.mvs"
	-- normal pal looks like this:      "movies\\flypal.mvs"
	-- normal looks like this:          "movies\\fly.mvs"
	local fullpath = movieFile .. pal .. ".mvs"
	print("ifs_missionselect_pcMulti_ChangeMovieFile(): Opening movie:", fullpath)
	
	ScriptCB_OpenMovie(fullpath, "")
	
	print("ifs_missionselect_pcMulti_ChangeMovieFile(): Finished opening movie")
	
end

function ifs_missionselect_pcMulti_fnSourceButtonUpdate( this )
	if( this.source_value == 1 ) then	
		ScriptCB_SetConnectType("wan")
		gOnlineServiceStr = ScriptCB_GetOnlineService()
		RoundIFButtonLabel_fnSetString( this.source_button, "ifs.mp.join.internet" )
	elseif( this.source_value == 2 ) then
		ScriptCB_SetConnectType( "lan" )
		gOnlineServiceStr = "LAN"
		-- Whine like crazy
		ScriptCB_SetNoticeNoCable(1)
		RoundIFButtonLabel_fnSetString( this.source_button, "ifs.mp.join.lan" )
	elseif( this.source_value == 3 ) then
		ScriptCB_SetConnectType("direct")
		gOnlineServiceStr = "Direct"
		RoundIFButtonLabel_fnSetString( this.source_button, "ifs.mp.join.direct_con" )
	else
		RoundIFButtonLabel_fnSetString( this.source_button, "common.none" )
	end
end

function ifs_missionselect_pcMulti_fnGetNumSelectedMaps( this )
	local i
	local number = 0
	for i = 1, table.getn(missionselect_listbox_contents) do
		if( missionselect_listbox_contents[i].bSelected ) then
			number = number + 1
		end
	end
	return number
end

function ifs_missionselect_pcMulti_fnShowHideGameModesMulti( this )

	custom_ShowHideGameModesMulti(this)
	
	-- local i, j
	-- for i = 1, table.getn(missionselect_listbox_contents) do
		-- if( missionselect_listbox_contents[i].bSelected ) then
			-- local MapSelection = missionselect_listbox_contents[i]
			-- local MissionselectModes = missionlist_ExpandModelist(MapSelection.mapluafile)
			-- for j = 1, table.getn(MissionselectModes) do
				-- for k = 1, table.getn(this.mode_checkbox) do
					-- if( ( this.mode_checkbox[k].key == MissionselectModes[j].key ) or 
						-- ( (this.mode_checkbox[k].key == "mode_assault") and (MissionselectModes[j].key == "mode_eli") ) )then
						-- IFObj_fnSetVis(this.mode_checkbox[k], 1)
					-- end
				-- end
			-- end
		-- end
	-- end
end

function ifs_missionselect_pcMulti_fnShowHideGameModes( this )
	
	custom_ShowHideGameModes(this)
	
	-- local i, j
	-- local number = ifs_missionselect_pcMulti_fnGetNumSelectedMaps( this )
	-- if( number > 1 ) then
		-- ifs_missionselect_pcMulti_fnShowHideGameModesMulti( this )
	-- else
		-- for i = 1, table.getn(this.mode_checkbox) do
			-- IFObj_fnSetVis(this.mode_checkbox[i], nil)
			-- for j = 1, table.getn(gMissionselectModes) do
				-- if( ( this.mode_checkbox[i].key == gMissionselectModes[j].key ) or 
					-- ( (this.mode_checkbox[i].key == "mode_assault") and (gMissionselectModes[j].key == "mode_eli") ) )then
					-- -- make "mode_eli" equal to "mode_assault" for mos eisley
					-- --print(" missionselect_listbox_contents[ifs_mspc_MapList_layout.SelectedIdx].mapluafile = ", missionlist_GetLocalizedMapName( missionselect_listbox_contents[ifs_mspc_MapList_layout.SelectedIdx].mapluafile ) )
					-- IFObj_fnSetVis(this.mode_checkbox[i], 1)
				-- end
			-- end
		-- end
	-- end
	
	-- -- reset position
	-- number = 0
	-- for i = 1, table.getn(this.mode_checkbox) do
		-- if( IFObj_fnGetVis(this.mode_checkbox[i] ) ) then
			-- -- reset position
			-- IFObj_fnSetPos(this.mode_checkbox[i], this.mode_checkbox[i].x, this.mode_checkbox[1].y + 25 * number )			
			-- number = number + 1
		-- end
	-- end	
end

function ifs_missionselect_pcMulti_fnShowHideEra( this )

	custom_ShowHideEra(this)
	
	-- if( ifs_missionselect_pcMulti_fnGetNumSelectedMaps( this ) > 1 ) then
		-- IFObj_fnSetVis(this.Era_C_box,1)
		-- IFObj_fnSetVis(this.Era_G_box,1)
	-- else
		-- IFObj_fnSetVis(this.Era_C_box,nil)
		-- IFObj_fnSetVis(this.Era_G_box,nil)
		-- for i = 1,table.getn(gMissionselectEras) do
			-- local EraSelection = gMissionselectEras[i]
			-- if(not EraSelection.bIsWildcard) then
				-- local DisplayUStr = ScriptCB_getlocalizestr(EraSelection.showstr)
				-- print( "EraSelection.subst = ", EraSelection.subst, EraSelection.key )
				-- --if( ( EraSelection.subst == "c" ) or ( EraSelection.subst == "C" ) ) then
				-- if( ( EraSelection.key == "era_c" ) ) then
					-- --print( "it's true! EraSelection.key = ", EraSelection.key )
					-- IFObj_fnSetVis(this.Era_C_box,1)
				-- else
					-- IFObj_fnSetVis(this.Era_G_box,1)
				-- end
			-- end
		-- end	
	-- end
	
	-- -- reset position
	-- if( IFObj_fnGetVis(this.Era_C_box) ) then
		-- IFObj_fnSetPos(this.Era_G_box, this.Era_G_box.x, this.Era_C_box.y + 15)
	-- else
		-- IFObj_fnSetPos(this.Era_G_box, this.Era_G_box.x, this.Era_C_box.y - 22)
	-- end
end

function ifs_missionselect_pcMulti_fnInitModeEra( this )
	
	custom_InitModeEra(this)
	-- only first one is checked
	-- init gamemode
	-- local i
	-- for i = 1, table.getn( this.mode_checkbox ) do
		-- if( i == 1 ) then
			-- this.mode_checkbox[i].bChecked = 1
			-- IFImage_fnSetTexture(this.mode_checkbox[i].checkbox,"check_yes")		
		-- else
			-- this.mode_checkbox[i].bChecked = nil
			-- IFImage_fnSetTexture(this.mode_checkbox[i].checkbox,"check_no")
		-- end
	-- end
	
	-- -- init era
	-- this.bEra_CloneWar = 1
	-- IFImage_fnSetTexture(this.Era_C_box.Check_Era,"check_yes")
	-- this.bEra_Galactic = nil
	-- IFImage_fnSetTexture(this.Era_G_box.Check_Era,"check_no")
end

function ifs_missionselect_pcMulti_fnUpdateLists( this )

	-- get modelist 
	if( not( this.iMap == ifs_mspc_MapList_layout.SelectedIdx ) ) then
		this.iMap = ifs_mspc_MapList_layout.SelectedIdx
				
		--print( "+++mission modes changed! ifs_mspc_MapList_layout.SelectedIdx =", ifs_mspc_MapList_layout.SelectedIdx )
		local MapSelection = missionselect_listbox_contents[ifs_mspc_MapList_layout.SelectedIdx]
		gMissionselectModes = missionlist_ExpandModelist(MapSelection.mapluafile)
		local NumModes = table.getn(gMissionselectModes)
		if( ifs_mspc_ModeList_layout.SelectedIdx and ( ifs_mspc_ModeList_layout.SelectedIdx > NumModes ) ) then
			ifs_mspc_ModeList_layout.SelectedIdx = 1 -- back to top of list
		end
		-- mode listbox
		ifs_mspc_ModeList_layout.SelectedIdx = 1
		ifs_mspc_ModeList_layout.CursorIdx = nil
--		ListManager_fnFillContents(this.ModeListbox, gMissionselectModes, ifs_mspc_ModeList_layout)
		ifs_missionselect_pcMulti_fnShowHideGameModes( this )
		-- era
		gMissionselectEras = missionlist_ExpandEralist(MapSelection.mapluafile)
		local NumEras = table.getn(gMissionselectEras)
		ifs_missionselect_pcMulti_fnShowHideEra( this )
	end

	-- add new map if double click on modelist
	if( this.bDoubleClicked ) then
		this.bDoubleClicked = nil
		this.iLastClickTime = nil
		print("DoubleClicked ")
		if( gMouseListBox == this.MapListbox  ) then
			-- if double click on a item, add to playlist
			ifs_missionselect_pcMulti_fnAddMapNew( this )
		elseif( gMouseListBox == this.ModeListbox  ) then
			-- if double click on a item, add to playlist
			ifs_missionselect_pcMulti_fnAddMapNew( this )
		elseif ( gMouseListBox == this.OptionListbox ) then
			print(" change options: ")
			ifs_missionselect_pcMulti_fnChangeOptions( this, nil )
--		elseif ( gMouseListBox == this.HostOptionListbox ) then
--			print(" change host options: ")
--			ifs_missionselect_pcMulti_fnChangeHostOptions( this, nil )
		end		
	end

	-- change information
	if( gMouseListBox ) then
		if( gMouseListBox == this.MapListbox ) then
--			IFObj_fnSetVis( this.InfoboxTL.Text1, nil )
--			IFObj_fnSetVis( this.InfoboxTL.Text2, 1 )
--			IFText_fnSetString( this.InfoboxTL.Text2, "ifs.missionselect.selectplanet" )
		elseif( gMouseListBox == this.ModeListbox ) then
--			IFObj_fnSetVis( this.InfoboxTL.Text1, 1 )
			-- Show the data
			local MapSelection = missionselect_listbox_contents[ifs_mspc_MapList_layout.SelectedIdx]
			local DisplayUStr,iSource = missionlist_GetLocalizedMapName(MapSelection.mapluafile)
--			IFText_fnSetUString( this.InfoboxTL.Text1, DisplayUStr )

--			IFObj_fnSetVis( this.InfoboxTL.Text2, 1 )
--			IFText_fnSetString( this.InfoboxTL.Text2, "ifs.missionselect.selectmode" )			
		elseif( gMouseListBox == this.PlayListbox ) then
			if( table.getn( gPickedMapList ) > 0 ) then
				local MapSelection = gPickedMapList[ifs_mspc_PlayList_layout.SelectedIdx]
				local DisplayUStr,iSource = missionlist_GetLocalizedMapName(MapSelection.Map)
				local MapMode = missionlist_GetMapMode(MapSelection.Map)
				if( MapMode ) then				
					local ModeUStr = ScriptCB_getlocalizestr(MapMode.showstr)
					local SpacesUStr = ScriptCB_tounicode("    ")
					DisplayUStr = ScriptCB_usprintf("common.pctspcts", DisplayUStr, SpacesUStr)
					DisplayUStr = ScriptCB_usprintf("common.pctspcts", DisplayUStr, ModeUStr)				
--					IFText_fnSetUString( this.InfoboxTL.Text1, DisplayUStr )
--					IFObj_fnSetVis( this.InfoboxTL.Text1, 1 )				
				else
--					IFText_fnSetUString( this.InfoboxTL.Text1, DisplayUStr )
--					IFObj_fnSetVis( this.InfoboxTL.Text1, 1 )									
				end

				local EraSelection = missionlist_GetMapEra(MapSelection.Map)
--				if( EraSelection ) then
--					IFText_fnSetString(this.InfoboxTL.Text2, EraSelection.showstr)
--					IFObj_fnSetVis( this.InfoboxTL.Text2, 1 )
--				else
--					IFObj_fnSetVis( this.InfoboxTL.Text2, nil )
--				end				
			end
		end		
	end
	
	-- update playlist count
	local playlist_num = table.getn( gPickedMapList )
	if( not( this.playlist_count == playlist_num ) ) then
		local ListUStr = ScriptCB_getlocalizestr( "ifs.missionselect.playlist" )
		local NumberUStr = ScriptCB_tounicode( string.format("   %d/%d", playlist_num, this.iMaxMissions ) )			
		local DisplayUStr = ScriptCB_usprintf("common.pctspcts", ListUStr, NumberUStr)
--		IFText_fnSetUString( this.InfoboxTR.Text1, DisplayUStr )
--		IFObj_fnSetVis( this.InfoboxTR.Text1, 1 )
		this.playlist_count = playlist_num
	end
	
	-- update infobox bottom
	if(gMouseListBox) then
		if( gMouseListBox == this.MapListbox ) then
			local DisplayUStr = ""
			local iSource = 0
			local MapSelection = nil
			if( ifs_mspc_MapList_layout.CursorIdx ) then
				MapSelection = missionselect_listbox_contents[ifs_mspc_MapList_layout.CursorIdx]
				DisplayUStr,iSource = missionlist_GetLocalizedMapDescr(MapSelection.mapluafile)
			end			
			IFText_fnSetUString(this.InfoboxBot.Text1, DisplayUStr)
			IFText_fnSetString(this.InfoboxBot.Text2, "")
			IFText_fnSetString(this.InfoboxBot.Text3, "")			
		elseif( gMouseListBox == this.ModeListbox ) then
			local DisplayUStr = ""
			if( ifs_mspc_ModeList_layout.CursorIdx ) then
				local ModeSelection = gMissionselectModes[ifs_mspc_ModeList_layout.CursorIdx]
				DisplayUStr = ModeSelection.descstr
			end
			IFText_fnSetString(this.InfoboxBot.Text1, DisplayUStr)
			IFText_fnSetString(this.InfoboxBot.Text2, "")
			IFText_fnSetString(this.InfoboxBot.Text3, "")
		elseif( gMouseListBox == this.PlayListbox ) then
			if( ifs_mspc_PlayList_layout.CursorIdx ) then
				local MapSelection = gPickedMapList[ifs_mspc_PlayList_layout.CursorIdx]
				local DisplayUStr,iSource = missionlist_GetLocalizedMapName(MapSelection.Map)
				local EraSelection, MapMode, r7 = custom_getCustomEraAndModeNames(MapSelection)
				IFText_fnSetUString(this.InfoboxBot.Text1, DisplayUStr)
				
				--local MapMode = missionlist_GetMapMode(MapSelection.Map)
				if( MapMode ) then
				
					if r7 == true then
						IFText_fnSetUString(this.InfoboxBot.Text2, MapMode)
					else
						IFText_fnSetString(this.InfoboxBot.Text2, MapMode)
					end
				end
				--local EraSelection = missionlist_GetMapEra(MapSelection.Map)
				if( EraSelection ) then
					IFText_fnSetString(this.InfoboxBot.Text3, EraSelection)
				end				
			else
				IFText_fnSetString(this.InfoboxBot.Text1, "")
				IFText_fnSetString(this.InfoboxBot.Text2, "")
				IFText_fnSetString(this.InfoboxBot.Text3, "")
			end
--		elseif( ( gMouseListBox == this.OptionListbox ) or ( gMouseListBox == this.HostOptionListbox ) ) then
--			if( gMouseListBox.Layout.CursorIdx ) then
--				IFText_fnSetString(this.InfoboxBot.Text1, gMouseListBox.Contents[gMouseListBox.Layout.CursorIdx].desc)
--				IFText_fnSetString(this.InfoboxBot.Text2, "")
--				IFText_fnSetString(this.InfoboxBot.Text3, "")			
--			else
--				IFText_fnSetString(this.InfoboxBot.Text1, "")
--				IFText_fnSetString(this.InfoboxBot.Text2, "")
--				IFText_fnSetString(this.InfoboxBot.Text3, "")
--			end
		end
	end	
	
	-- update checkbox
	if( gMouseOverImage ) then
		for i = 1, table.getn( this.mode_checkbox ) do
			if( gMouseOverImage.tag == "check_mode"..i ) then
			
				local r5 = missionselect_listbox_contents[ifs_mspc_MapList_layout.SelectedIdx]
				local r6 = custom_GetGameModeDescription(r5, mode_list[i])
				
				IFText_fnSetString(this.InfoboxBot.Text1, r6)
				IFText_fnSetString(this.InfoboxBot.Text2, "")
				IFText_fnSetString(this.InfoboxBot.Text3, "")			
			end
		end
	end
end

-- Helper function: clears the playlist
function ifs_missionselect_pcMulti_fnClearPlaylist(this)
	gPickedMapList = {
		{ Map = gDelAllMapsStr, bIsRemoveAll = 1, },
	}
end

-- Helper function: given a map, mode & era, none of which are
-- wildcards, adds the map to the list.
function ifs_missionselect_pcMulti_fnAddMap4(this, MapSelection, ModeSelection, EraSelection)
	-- Map & mode must not be a wildcard to get here.
	assert(not MapSelection.bIsWildcard)
	assert(not ModeSelection.bIsWildcard)
	
--	print("Add Map4")
	
	-- if not have this era, return
	if( not EraSelection ) then
		return
	end
		
	assert(not EraSelection.bIsWildcard)

	local Idx = table.getn(gPickedMapList) + 1

	-- If playlist is full, notify the user, don't add it.
	if(Idx > (this.iMaxMissions)) then
		--ifs_missionselect_fnShowHideListboxes(this,nil)
		Popup_Ok.fnDone = nil -- ifs_missionselect_fnFullPopupDone
		Popup_Ok:fnActivate(1)
		gPopup_fnSetTitleStr(Popup_Ok, "ifs.missionselect.listfull")
		return
	end

	local NewMapfile = string.format(MapSelection.mapluafile, EraSelection.subst, ModeSelection.subst)
	print("Adding map: ", NewMapfile, " idx: ", Idx)
	gPickedMapList[Idx] = { 
		Map = NewMapfile,
		mapluafile = NewMapfile,
		dnldable = MapSelection.dnldable,
		mapluafile = MapSelection.mapluafile,
		Side = 1,
		SideChar = EraSelection.tag,
		Team1 = EraSelection.Team1Name,
		Team2 = EraSelection.Team2Name,
		change = MapSelection.change,
	}

	-- Auto-scroll playlist cursor to last item.
	local Count = table.getn(gPickedMapList)
	ifs_mspc_PlayList_layout.SelectedIdx = Count

end

-- Helper function: given a map, mode & era, expands the era(s)
-- and adds the map based on that.
function ifs_missionselect_pcMulti_fnAddMap3(this, MapSelection, ModeSelection, Era)
	-- Map & mode must not be a wildcard to get here.
	assert(not MapSelection.bIsWildcard)
	assert(not ModeSelection.bIsWildcard)

	--print("Add Map3")
	
	-- find the era
	gMissionselectEras = missionlist_ExpandEralist(MapSelection.mapluafile)
	local NumEras = table.getn(gMissionselectEras)
	local EraSelection = nil
    for i = 1, NumEras do
		EraSelection = gMissionselectEras[i]
		if(not EraSelection.bIsWildcard) then			
			if( Era == "all" ) then
				ifs_missionselect_pcMulti_fnAddMap4(this, MapSelection, ModeSelection, EraSelection)
			elseif( EraSelection.key == Era ) then
				ifs_missionselect_pcMulti_fnAddMap4(this, MapSelection, ModeSelection, EraSelection)
				break
			end
		end
	end
end

function ifs_missionselect_pcMulti_fnGetEraSubst( Era )
	local subst = nil
	local i
	
	for i = 1,table.getn(gMapEras) do
		
		if gMapEras[i].key == Era then 
			print( "gMapEras[i].key =", gMapEras[i].key, " Era =", Era, " subst =", gMapEras[i].subst)
			subst = gMapEras[i].subst
			break
		end
	end
	
	return subst
end

-- Helper function: given a map, mode & era, expands the mode(s)
-- and adds maps based on that.
function ifs_missionselect_pcMulti_fnAddMap2(this, MapSelection, ModeSelection, Era)
	-- Map must not be a wildcard to get here.
	assert(not MapSelection.bIsWildcard)

--	print("Add Map2")

if( nil ) then
	local subst = ifs_missionselect_pcMulti_fnGetEraSubst( Era )
	if(ModeSelection.bIsWildcard) then
		-- Add all maps with given params
		local i
		for i = 1,table.getn(gMissionselectModes) do
			local ModeSelection2 = gMissionselectModes[i]
			if(not ModeSelection2.bIsWildcard) then
				-- Ensure this map supports this mode before adding.				
				local Key = ModeSelection2.key .. "_" .. subst
				if(MapSelection[Key]) then
					ifs_missionselect_pcMulti_fnAddMap3(this, MapSelection, ModeSelection2, Era)
				end
			end
		end
	else
		-- Not adding all maps. Call child function, if mode exists on this map
		local Key = ModeSelection.key .. "_" .. subst
		if(MapSelection[Key]) then
			ifs_missionselect_pcMulti_fnAddMap3(this, MapSelection, ModeSelection, Era)
		end
	end
else
	local subst = ifs_missionselect_pcMulti_fnGetEraSubst( Era )
	gMissionselectModes = missionlist_ExpandModelist(MapSelection.mapluafile)
	local i
	for i = 1,table.getn(gMissionselectModes) do
		local ModeSelection2 = gMissionselectModes[i]
		if(not ModeSelection2.bIsWildcard) then
			local j
			for j = 1, table.getn( this.mode_checkbox ) do
				--print( "this.mode_checkbox[j].bChecked =", this.mode_checkbox[j].bChecked )
				--print( "this.mode_checkbox[j].key =", this.mode_checkbox[j].key )
				--print( "ModeSelection2.key = ", ModeSelection2.key )
				if( this.mode_checkbox[j].bChecked ) then
					if( ( ModeSelection2.key == this.mode_checkbox[j].key ) or
						( (ModeSelection2.key == "mode_eli" ) and (this.mode_checkbox[j].key == "mode_assault") ) ) then
						-- make "mode_eli" equal to "mode_assault" for mos eisley and maybe apply to other possibly levels(downloadable content)
						-- Ensure this map supports this mode before adding.			
						local Key = ModeSelection2.key .. "_" .. subst
						if(MapSelection[Key]) then
							ifs_missionselect_pcMulti_fnAddMap3(this, MapSelection, ModeSelection2, Era)
						end
						--print( "Key =", Key )
						--print( "MapSelection[Key] = ", MapSelection[Key] )					
					end
				end
			end
		end		
	end	
end

end

-- Helper function: given a map, mode & era, expands the map(s)
-- and adds maps based on that.
function ifs_missionselect_pcMulti_fnAddMap1(this, MapSelection, ModeSelection, Era)
--	print("Add Map1")
	if(MapSelection.bIsWildcard) then
		-- Add all maps with given params
		local i
		for i = 1,table.getn(missionselect_listbox_contents) do
				local MapSelection2 = missionselect_listbox_contents[i]
				if(not MapSelection2.bIsWildcard) then
					ifs_missionselect_pcMulti_fnAddMap2(this, MapSelection2, ModeSelection, Era)
				end
			end
	else
		-- Not adding all maps. Call child function
		ifs_missionselect_pcMulti_fnAddMap2(this, MapSelection, ModeSelection, Era)
	end
end

function ifs_missionselect_pcMulti_fnAddMapNew(this)
	custom_AddMapNew(this)
	
	-- local i
	-- for i = 1, table.getn(missionselect_listbox_contents) do
		-- if( missionselect_listbox_contents[i].bSelected ) then
			-- local MapSelection = missionselect_listbox_contents[i]
			-- local ModeSelection = gMissionselectModes[ifs_mspc_ModeList_layout.SelectedIdx]

			-- -- Call helper functions to expand things as necessary
			-- print( "bEra_CloneWar = ", this.bEra_CloneWar, " bEra_Galactic = ", this.bEra_Galactic )
			-- local clonewar_visable = IFObj_fnGetVis( this.Era_C_box )
			-- local galactic_visable = IFObj_fnGetVis( this.Era_G_box )
			-- print( "clonewar_visable = ", clonewar_visable, " galactic_visable = ", galactic_visable )
			
			-- if( ( this.bEra_CloneWar and clonewar_visable ) and 
				-- ( this.bEra_Galactic and galactic_visable ) ) then
				-- -- add all eras
				-- ifs_missionselect_pcMulti_fnAddMap1(this, MapSelection, ModeSelection, "era_c")
				-- ifs_missionselect_pcMulti_fnAddMap1(this, MapSelection, ModeSelection, "era_g")
			-- elseif( this.bEra_CloneWar and clonewar_visable ) then
				-- ifs_missionselect_pcMulti_fnAddMap1(this, MapSelection, ModeSelection, "era_c")
			-- elseif( this.bEra_Galactic and galactic_visable ) then
				-- ifs_missionselect_pcMulti_fnAddMap1(this, MapSelection, ModeSelection, "era_g")
			-- end
		-- end
	-- end
	
	-- ListManager_fnFillContents(this.PlayListbox,gPickedMapList,ifs_mspc_PlayList_layout)
end

function ifs_missionselect_pcMulti_fnDeleteMapNew( this, delete_all )
	local Count = table.getn(gPickedMapList)
	if(Count > 0) then
		if( delete_all ) then
			local maplist = {}
			gPickedMapList = maplist
			ifs_mspc_PlayList_layout.SelectedIdx = nil
			ifs_mspc_PlayList_layout.CursorIdx = nil
		else
			local i
			local j = 1
			local NewList = {}
			for i=1,Count do
				--if(i ~= ifs_mspc_PlayList_layout.SelectedIdx) then
				if( not gPickedMapList[i].bSelected ) then
					NewList[j] = gPickedMapList[i]
					j = j + 1
				end
			end
			gPickedMapList = NewList
			
			if( table.getn(gPickedMapList) == 0 ) then
				ifs_mspc_PlayList_layout.SelectedIdx = nil
				ifs_mspc_PlayList_layout.CursorIdx = nil
			end
		end
	end

	--refresh maplist
	ListManager_fnFillContents(this.PlayListbox,gPickedMapList,ifs_mspc_PlayList_layout)
end

function ifs_missionselect_pcMulti_fnPlayListChangeOrder( this, move_up )
	local Count = table.getn(gPickedMapList)	
	if(Count > 0) then
		local i = ifs_mspc_PlayList_layout.SelectedIdx
		if( ( i > 0 ) and ( i <= Count ) ) then
			local j = nil
			if( move_up ) then
				-- move up
				j = i - 1
			else 
				-- move down
				j = i + 1
			end
			
			-- switch if it is a valid target
			if( ( j > 0 ) and ( j <= Count ) ) then				
				local list_item = gPickedMapList[i]
				gPickedMapList[i] = gPickedMapList[j]
				gPickedMapList[j] = list_item
				ifs_mspc_PlayList_layout.SelectedIdx = j
				ifs_mspc_PlayList_layout.CursorIdx = j
			end
		end
	end
	
	--refresh maplist
	ListManager_fnFillContents(this.PlayListbox,gPickedMapList,ifs_mspc_PlayList_layout)		
end

-- nil:double click, 1: left, 2: right
function ifs_missionselect_pcMulti_fnChangeOptions( this, mode )
	if ( gMouseListBox == this.OptionListbox ) then
		local idx = ifs_mspc_OptionList_layout.SelectedIdx
		if( idx ) then
			local Selection = gOptionList[idx]
			if( Selection.tag == "bots" ) then				
				if( mode == nil ) then
					ifs_mp_gameopts.Prefs.iNumBots = ifs_mp_gameopts.Prefs.iNumBots + 1					
				elseif( mode == 1 ) then
					ifs_mp_gameopts.Prefs.iNumBots = ifs_mp_gameopts.Prefs.iNumBots - 1
				end
				local bot_max = 0
				if(ifs_mp_gameopts.bDedicated) then
					bot_max = ifs_mp_gameopts.Prefs.iMaxDedicatedBots
				else
					bot_max = ifs_mp_gameopts.Prefs.iMaxBots
				end
				if( ifs_mp_gameopts.Prefs.iNumBots > bot_max ) then
					ifs_mp_gameopts.Prefs.iNumBots  = 0
				elseif( ifs_mp_gameopts.Prefs.iNumBots < 0 ) then
					ifs_mp_gameopts.Prefs.iNumBots  = bot_max
				end
			elseif( Selection.tag == "difficulty" ) then
				if( mode == nil ) then
					ifs_mp_gameopts.Prefs.iDifficulty = ifs_mp_gameopts.Prefs.iDifficulty + 1
				else
					ifs_mp_gameopts.Prefs.iDifficulty = ifs_mp_gameopts.Prefs.iDifficulty - 1
				end
				if( ifs_mp_gameopts.Prefs.iDifficulty > 3 ) then
					ifs_mp_gameopts.Prefs.iDifficulty = 1
				elseif( ifs_mp_gameopts.Prefs.iDifficulty < 0 ) then
					ifs_mp_gameopts.Prefs.iDifficulty = 3
				end
			elseif( Selection.tag == "hero" ) then
				ifs_mp_gameopts.Prefs.bHeroesEnabled = not ifs_mp_gameopts.Prefs.bHeroesEnabled
				-- refresh following hero options
				ifs_mspc_OptionList_PopulateItem( this.OptionListbox[idx+1], gOptionList[idx+1] )
				ifs_mspc_OptionList_PopulateItem( this.OptionListbox[idx+2], gOptionList[idx+2] )
				ifs_mspc_OptionList_PopulateItem( this.OptionListbox[idx+3], gOptionList[idx+3] )
				ifs_mspc_OptionList_PopulateItem( this.OptionListbox[idx+4], gOptionList[idx+4] )
				ifs_mspc_OptionList_PopulateItem( this.OptionListbox[idx+5], gOptionList[idx+5] )
			elseif( Selection.tag == "hero_unlock" ) then
				if( ifs_mp_gameopts.Prefs.bHeroesEnabled ) then
					if( mode == nil ) then
						ifs_mp_heroopts.Prefs.iHeroUnlock = ifs_mp_heroopts.Prefs.iHeroUnlock + 1
					else
						ifs_mp_heroopts.Prefs.iHeroUnlock = ifs_mp_heroopts.Prefs.iHeroUnlock - 1
					end
					if(ifs_mp_heroopts.Prefs.iHeroUnlock > 6) then
						ifs_mp_heroopts.Prefs.iHeroUnlock = 1
					elseif(ifs_mp_heroopts.Prefs.iHeroUnlock < 1) then
						ifs_mp_heroopts.Prefs.iHeroUnlock = 6
					end
					if(ifs_mp_heroopts.Prefs.iHeroUnlock == 1) then
					elseif(ifs_mp_heroopts.Prefs.iHeroUnlock == 2) then
						ifs_mp_heroopts.Prefs.iHeroUnlockVal = math.max(1,ifs_mp_heroopts.Prefs.iHeroUnlockVal)
						ifs_mp_heroopts.Prefs.iHeroUnlockVal = math.min(99,ifs_mp_heroopts.Prefs.iHeroUnlockVal)
					else
						ifs_mp_heroopts.Prefs.iHeroUnlockVal = math.max(1,ifs_mp_heroopts.Prefs.iHeroUnlockVal)
						ifs_mp_heroopts.Prefs.iHeroUnlockVal = math.min(500,ifs_mp_heroopts.Prefs.iHeroUnlockVal)
					end
					ifs_mspc_OptionList_PopulateItem( this.OptionListbox[idx+1], gOptionList[idx+1] )
				end				
			elseif( Selection.tag == "hero_unval" ) then
				if( ( ifs_mp_gameopts.Prefs.bHeroesEnabled ) and ( ifs_mp_heroopts.Prefs.iHeroUnlock ~= 1 ) ) then
					if( mode == nil ) then
						ifs_mp_heroopts.Prefs.iHeroUnlockVal = ifs_mp_heroopts.Prefs.iHeroUnlockVal + 1
					else
						ifs_mp_heroopts.Prefs.iHeroUnlockVal = ifs_mp_heroopts.Prefs.iHeroUnlockVal - 1
					end
					local max_val = 0					
					if( ifs_mp_heroopts.Prefs.iHeroUnlock == 2 ) then
						max_val = 99
					else
						max_val = 500
					end
					if(ifs_mp_heroopts.Prefs.iHeroUnlockVal > max_val) then
						ifs_mp_heroopts.Prefs.iHeroUnlockVal = 1
					elseif(ifs_mp_heroopts.Prefs.iHeroUnlockVal < 1) then
						ifs_mp_heroopts.Prefs.iHeroUnlockVal = max_val
					end
				end			
			elseif( Selection.tag == "hero_team" ) then
				if( ifs_mp_gameopts.Prefs.bHeroesEnabled ) then
					if( mode == nil ) then
						ifs_mp_heroopts.Prefs.iHeroTeam = ifs_mp_heroopts.Prefs.iHeroTeam + 1
					else
						ifs_mp_heroopts.Prefs.iHeroTeam = ifs_mp_heroopts.Prefs.iHeroTeam - 1
					end
					if(ifs_mp_heroopts.Prefs.iHeroTeam > 4) then
						ifs_mp_heroopts.Prefs.iHeroTeam = 1
					elseif(ifs_mp_heroopts.Prefs.iHeroTeam < 1) then
						ifs_mp_heroopts.Prefs.iHeroTeam = 4
					end
					local val_max = 0
					if(ifs_mp_heroopts.Prefs.iHeroTeam == 4) then
						val_max = 8
					else
						val_max = 7
					end
					ifs_mp_heroopts.Prefs.iHeroPlayer = math.min( val_max, ifs_mp_heroopts.Prefs.iHeroPlayer )
					ifs_mspc_OptionList_PopulateItem( this.OptionListbox[idx+1], gOptionList[idx+1] )
				end
			elseif( Selection.tag == "hero_player" ) then
				if( ifs_mp_gameopts.Prefs.bHeroesEnabled ) then
					if( mode == nil ) then
						ifs_mp_heroopts.Prefs.iHeroPlayer = ifs_mp_heroopts.Prefs.iHeroPlayer + 1
					else
						ifs_mp_heroopts.Prefs.iHeroPlayer = ifs_mp_heroopts.Prefs.iHeroPlayer - 1
					end
					local val_max = 0
					if(ifs_mp_heroopts.Prefs.iHeroTeam == 4) then
						val_max = 8
					else
						val_max = 7
					end
					if(ifs_mp_heroopts.Prefs.iHeroPlayer > val_max) then
						ifs_mp_heroopts.Prefs.iHeroPlayer = 1
					elseif(ifs_mp_heroopts.Prefs.iHeroPlayer < 1) then
						ifs_mp_heroopts.Prefs.iHeroPlayer = val_max
					end
				end
			elseif( Selection.tag == "hero_respawn" ) then
				if( ifs_mp_gameopts.Prefs.bHeroesEnabled ) then
					if( ifs_mp_heroopts.Prefs.iHeroRespawn == 1 ) then
						ifs_mp_heroopts.Prefs.iHeroRespawn = 2	
					else
						if( mode == nil ) then
							ifs_mp_heroopts.Prefs.iHeroRespawnVal = ifs_mp_heroopts.Prefs.iHeroRespawnVal + 10
						else
							ifs_mp_heroopts.Prefs.iHeroRespawnVal = ifs_mp_heroopts.Prefs.iHeroRespawnVal - 10
						end
						if( ( ifs_mp_heroopts.Prefs.iHeroRespawnVal > 500 ) or 
							( ifs_mp_heroopts.Prefs.iHeroRespawnVal < 0 ) )then
							ifs_mp_heroopts.Prefs.iHeroRespawn = 1
							ifs_mp_heroopts.Prefs.iHeroRespawnVal = 0
						end					
					end
				end
			end			
			ifs_mspc_OptionList_PopulateItem( this.OptionListbox[idx], gOptionList[idx] )
		end		
	end
end

-- nil:double click, 1: left, 2: right
function ifs_missionselect_pcMulti_fnChangeHostOptions( this, mode )
	
	-- not used anymore
	if( 1 ) then
		return
	end
	
	-- if ( gMouseListBox == this.HostOptionListbox ) then
		-- local idx = ifs_mspc_HostOptionList_layout.SelectedIdx
		-- if( idx ) then
			-- local Selection = gHostOptionList[idx]
			-- if( Selection.tag == "dedicated" ) then
				-- ifs_mp_gameopts.bDedicated = not ifs_mp_gameopts.bDedicated
				-- if(ifs_mp_gameopts.bDedicated) then
					-- ifs_mp_gameopts.Prefs.iNumPlayers = math.min(ifs_mp_gameopts.Prefs.iNumPlayers,ifs_mp_gameopts.Prefs.iMaxDedicatedPlayers)
					-- ifs_mp_gameopts.Prefs.iNumBots = math.min(ifs_mp_gameopts.Prefs.iNumBots,ifs_mp_gameopts.Prefs.iMaxDedicatedBots)
				-- else
					-- ifs_mp_gameopts.Prefs.iNumPlayers = math.min(ifs_mp_gameopts.Prefs.iNumPlayers,ifs_mp_gameopts.Prefs.iMaxPlayers)
					-- ifs_mp_gameopts.Prefs.iNumBots = math.min(ifs_mp_gameopts.Prefs.iNumBots,ifs_mp_gameopts.Prefs.iMaxBots)
				-- end
			-- elseif( Selection.tag == "players" ) then
				-- if( mode == nil ) then
					-- ifs_mp_gameopts.Prefs.iNumPlayers = ifs_mp_gameopts.Prefs.iNumPlayers + 1
				-- elseif( mode == 1 ) then
					-- ifs_mp_gameopts.Prefs.iNumPlayers = ifs_mp_gameopts.Prefs.iNumPlayers - 1
				-- end
				-- local player_max = 0
				-- local player_min = math.max(2, ScriptCB_GetNumCameras())
				-- if( ifs_mp_gameopts.bDedicated ) then
					-- player_max = ifs_mp_gameopts.Prefs.iMaxDedicatedPlayers
				-- else
					-- player_max = ifs_mp_gameopts.Prefs.iMaxPlayers
				-- end
				-- if( ifs_mp_gameopts.Prefs.iNumPlayers > player_max ) then
					-- ifs_mp_gameopts.Prefs.iNumPlayers = player_min
				-- elseif( ifs_mp_gameopts.Prefs.iNumPlayers < player_min ) then
					-- ifs_mp_gameopts.Prefs.iNumPlayers = player_max
				-- end				
			-- elseif( Selection.tag == "autoassign" ) then
				-- ifs_mp_gameopts.Prefs.bAutoAssignTeams = not ifs_mp_gameopts.Prefs.bAutoAssignTeams
			-- elseif( Selection.tag == "tracking" ) then
				-- ifs_mp_gameopts.Prefs.iAutoAim = 100 - ifs_mp_gameopts.Prefs.iAutoAim
			-- elseif( Selection.tag == "shownames" ) then
				-- ifs_mp_gameopts.Prefs.bShowNames = not ifs_mp_gameopts.Prefs.bShowNames
			-- elseif( Selection.tag == "warmup" ) then
				-- if( mode == nil ) then
					-- ifs_mp_gameopts.Prefs.iWarmUp = ifs_mp_gameopts.Prefs.iWarmUp + 10
				-- else
					-- ifs_mp_gameopts.Prefs.iWarmUp = ifs_mp_gameopts.Prefs.iWarmUp - 10
				-- end
				-- if(ifs_mp_gameopts.Prefs.iWarmUp < ifs_mp_gameopts.Prefs.iWarmUpMin) then
					-- ifs_mp_gameopts.Prefs.iWarmUp = ifs_mp_gameopts.Prefs.iWarmUpMax
				-- elseif(ifs_mp_gameopts.Prefs.iWarmUp > ifs_mp_gameopts.Prefs.iWarmUpMax) then
					-- ifs_mp_gameopts.Prefs.iWarmUp = ifs_mp_gameopts.Prefs.iWarmUpMin
				-- end
			-- elseif( Selection.tag == "vote" ) then
				-- if( mode == nil ) then
					-- ifs_mp_gameopts.Prefs.iVote = ifs_mp_gameopts.Prefs.iVote + 25
				-- else
					-- ifs_mp_gameopts.Prefs.iVote = ifs_mp_gameopts.Prefs.iVote - 25
				-- end
				-- if( ifs_mp_gameopts.Prefs.iVote > ifs_mp_gameopts.Prefs.iVoteMax ) then
					-- ifs_mp_gameopts.Prefs.iVote = ifs_mp_gameopts.Prefs.iVoteMin
				-- elseif( ifs_mp_gameopts.Prefs.iVote < ifs_mp_gameopts.Prefs.iVoteMin ) then
					-- ifs_mp_gameopts.Prefs.iVote = ifs_mp_gameopts.Prefs.iVoteMax
				-- end			
			-- elseif( Selection.tag == "startcnt" ) then
				-- if( mode == nil ) then
					-- ifs_mp_gameopts.Prefs.iStartCnt = ifs_mp_gameopts.Prefs.iStartCnt + 1
				-- else
					-- ifs_mp_gameopts.Prefs.iStartCnt = ifs_mp_gameopts.Prefs.iStartCnt - 1
				-- end
				-- if( ifs_mp_gameopts.Prefs.iStartCnt > ifs_mp_gameopts.Prefs.iNumPlayers ) then
					-- ifs_mp_gameopts.Prefs.iStartCnt = 0
				-- elseif( ifs_mp_gameopts.Prefs.iStartCnt < 0 ) then
					-- ifs_mp_gameopts.Prefs.iStartCnt = ifs_mp_gameopts.Prefs.iNumPlayers
				-- end				
			-- elseif( Selection.tag == "teamdmg" ) then
				-- ifs_mp_gameopts.Prefs.iTeamDmg = 100 - ifs_mp_gameopts.Prefs.iTeamDmg
			-- elseif( Selection.tag == "voicemode" ) then
				-- if( mode == nil ) then
					-- ifs_mp_gameopts.Prefs.iVoiceMode = ifs_mp_gameopts.Prefs.iVoiceMode + 1
				-- else
					-- ifs_mp_gameopts.Prefs.iVoiceMode = ifs_mp_gameopts.Prefs.iVoiceMode - 1
				-- end
				-- if (ifs_mp_gameopts.Prefs.iVoiceMode < ifs_mp_gameopts.Prefs.iVoiceModeMin) then
					-- ifs_mp_gameopts.Prefs.iVoiceMode = ifs_mp_gameopts.Prefs.iVoiceModeMax
				-- elseif (ifs_mp_gameopts.Prefs.iVoiceMode > ifs_mp_gameopts.Prefs.iVoiceModeMax) then
					-- ifs_mp_gameopts.Prefs.iVoiceMode = ifs_mp_gameopts.Prefs.iVoiceModeMin
				-- end				
			-- end			
			-- ifs_mspc_HostOptionList_PopulateItem( this.HostOptionListbox[idx], gHostOptionList[idx] )
		-- end		
	-- end
end

ifs_missionselect_pcMulti = NewIFShellScreen {
	nologo = 1,
	--bg_texture = "iface_bgmeta_space",
	movieIntro      = nil,
	--movieBackground = nil,
	bNohelptext_backPC = 1,
	movieBackground = "shell_main", 
	
--	-- background image.  we need to make our own since we want to hide it when the movie is visible
--	backImg = NewIFImage { 
--		ScreenRelativeX = 0,
--		ScreenRelativeY = 0,
--		UseSafezone = 0,
--		ZPos = 254, -- behind all. except the movie.
--		texture = "his_brief_BG", 
--		localpos_l = 0,
--		localpos_t = 0,
--		inert = 1, -- Delete this out of lua once created (we'll never touch it again)
--	},

	buttons = NewIFContainer {
		ScreenRelativeX = 0.5, -- center
		ScreenRelativeY = 0.6, -- top
--		y = 20, -- go slightly down from center
	},

	fnDone = nil, -- Callback function to do something when the user is done
	-- Sub-mode for full/era switch is on.
	EraMode = nil,
	
	Enter = function(this, bFwd)
		-- using new pc shell
		ifs_missionselect_pcMulti_fnUsingNewShell( this )
		
		-- set pc profile & title version text
		UpdatePCTitleText(this)

		-- hide dropbox
		ListManager_fnFillContents(this.source_listbox,sourcelist_content,sourcelist_layout)
		ifs_mp_sessionlist_fnShowSourceDropbox( this, nil )
		
--		IFObj_fnSetVis( this.InfoboxTL, nil )
--		IFObj_fnSetVis( this.InfoboxTR, nil )
		
		-- tabs	
		if(gPlatformStr == "PC") then
			ifelem_tabmanager_SetSelected(this, gPCMainTabsLayout, "_tab_multi")
			ifelem_tabmanager_SetSelected(this, gPCMultiPlayerTabsLayout, "_tab_create", 1)
			ifelem_tabmanager_SetSelected(this, gPCMultiPlayerSettingsTabsLayout, "_opt_playlist", 2)
			if( ScriptCB_IsLoggedIn() ) then
				ifelem_tabmanager_SetDimmed( this, gPCMultiPlayerTabsLayout, "_tab_friends", nil, 1 )
				ifelem_tabmanager_SetDimmed( this, gPCMultiPlayerTabsLayout, "_tab_leaderboard", nil, 1 )
			else
				ifelem_tabmanager_SetDimmed( this, gPCMultiPlayerTabsLayout, "_tab_friends", 1, 1 )
				ifelem_tabmanager_SetDimmed( this, gPCMultiPlayerTabsLayout, "_tab_leaderboard", 1, 1 )
			end
		end

		gIFShellScreenTemplate_fnEnter(this, bFwd) -- call base class

		-- right align the launch button	
--		gIFShellScreenTemplate_fnMoveClickableButton(this.LaunchButton,this.LaunchButton.label,0)

		-- set game source mode
		ifs_missionselect_pcMulti_fnSourceButtonUpdate( this )
	
		-- set profile name
		local ShowUStr = ScriptCB_usprintf( "ifs.mp.join.profile_name", ScriptCB_GetCurrentProfileName() )
		IFText_fnSetUString( this.ProfileNameText, ShowUStr )
		IFObj_fnSetVis(this.ProfileNameText, nil)

		-- set gamespy login name
		if( ScriptCB_IsLoggedIn() ) then
			IFText_fnSetString( this.LoginAsText1, "ifs.mp.join.login_as" )
			local NickStr, EmailStr, PasswordStr, iSaveType, iPromptType = ScriptCB_GetGSProfileInfo()
			if(ScriptCB_GetLoginName) then
				NickStr = ScriptCB_GetLoginName()
			else
				NickStr = "Get latest executable!"
			end
			IFText_fnSetString( this.LoginAsText2, NickStr )
			IFObj_fnSetVis( this.LoginAsText2, 1 )
		else
			IFText_fnSetString( this.LoginAsText1, "ifs.mp.join.notlogin" )
			IFObj_fnSetVis( this.LoginAsText2, nil )
		end		

		-- update maplists
		this.iColumn = 0 -- default: leftmost column on screen a
		
		-- init double click
		this.bDoubleClicked = nil

		-- host game
		ScriptCB_SetAmHost(1)
		
		-- stop the current movie
		ifelem_shellscreen_fnStopMovie()

		-- Determine how many missions can be queued.
		this.playlist_count = nil
		this.iMaxMissions = ScriptCB_GetMaxMissionQueue()
		
		print("ifs_missionselect_pcMulti: iMaxMissions:", this.iMaxMissions)
		
		-- Added chunk for error handling...
		if(not bFwd) then
			local ErrorLevel,ErrorMessage = ScriptCB_GetError()
			if(ErrorLevel >= 6) then -- session or login error, must keep going further
				ScriptCB_PopScreen()
			end
		end

		if(bFwd) then
			this.bForMp = true
			
			--gPickedMapList = {}
			missionlist_ExpandMaplist(true) -- TODO: filter era/mode here
			this.movieTime = 0.5

			-- set un-selected to all items in map list
			ifs_missionselect_pcMulti_fnMapListSelect( this, this.PlayListbox, gPickedMapList, ifs_mspc_PlayList_layout, 1, nil )
			
			-- set the default game name to player profile name
			local game_name = ScriptCB_GetCurrentProfileNetName()			
			ScriptCB_SetGameName(ScriptCB_ununicode(game_name))
			IFEditbox_fnSetUString(this.EditContainer.EditGameName, game_name)
			print( "set default game_name:", game_name, ScriptCB_ununicode(game_name) )

			print("In the forward enter function of multimission select")
			--ifs_mp_gameopts_fnSetupDefaults(ifs_mp_gameopts)
			-- get default game options
			if( not ifs_mp_gameopts.Prefs ) then
				ifs_mp_gameopts_fnSetupDefaults( ifs_mp_gameopts )
			end

			-- get default hero options
			if( not ifs_mp_heroopts.Prefs ) then
				ifs_mp_heroopts_fnSetupDefaults( ifs_mp_heroopts )
			end			
			
			this.iPage = 2
			ifs_missionselect_pcMulti_fnSetPage(this,0) -- default internal mode.
			this.buttons.fStartAlpha = 0
			this.buttons.fEndAlpha = 0
			IFObj_fnSetAlpha(this.buttons,0)
			ifs_missionselect_pcMulti_fnToggleOrder(this)
			ifs_missionselect_pcMulti_fnToggleOrder(this)

			--IFObj_fnSetAlpha(this.Helptext_Delete,0.25)
			IFButton_fnSelect(this.OrderButton,nil)
--			IFButton_fnSelect(this.LaunchButton,nil)
--			IFButton_fnSelect(this.LanButton,nil)
--			IFButton_fnSelect(this.EditGameName,nil)
--			IFButton_fnSelect(this.EditPass,nil)
--			IFButton_fnSelect(this.OptionButton,nil)
			

			this.SelectedMap = nil -- clear this
			--gPickedMapList = {} -- clear this also.
			pc_missionselect_name_listboxR_layout.FirstShownIdx = 1
			pc_missionselect_name_listboxR_layout.SelectedIdx = 1
			pc_missionselect_name_listboxR_layout.CursorIdx = nil
--			ListManager_fnFillContents(this.listboxR,gPickedMapList,pc_missionselect_name_listboxR_layout)

			-- Reset listboxL, show it. [Remember, Lua starts at 1!]
			pc_missionselect_name_listboxL_layout.FirstShownIdx = 1
			pc_missionselect_name_listboxL_layout.SelectedIdx = 1
			pc_missionselect_name_listboxL_layout.CursorIdx = 1
--			ListManager_fnFillContents(this.listboxL,missionselect_listbox_contents,pc_missionselect_name_listboxL_layout)

			ifs_missionselect_pcMulti_fnSetMapPreview(this)

			ifs_missionselect_pcMulti_fnSetCurButton(this,nil)

			-- Determine how many missions can be queued.
			this.iMaxMissions = ScriptCB_GetMaxMissionQueue()

			-- map listbox
			ifs_mspc_MapList_layout.CursorIdx = ifs_mspc_MapList_layout.SelectedIdx
			ListManager_fnFillContents(this.MapListbox,missionselect_listbox_contents,ifs_mspc_MapList_layout)
			ListManager_fnSetFocus(this.MapListbox)
			ifs_missionselect_pcMulti_fnUpdateLists( this )
			
			-- refresh playlist
			if( table.getn(gPickedMapList) == 0 ) then
				ifs_mspc_PlayList_layout.SelectedIdx = nil
				ifs_mspc_PlayList_layout.CursorIdx = nil				
			end
			ListManager_fnFillContents(this.PlayListbox,gPickedMapList,ifs_mspc_PlayList_layout)
			
			-- Option list
			if( table.getn(gOptionList) == 0 ) then
				ifs_mspc_OptionList_layout.SelectedIdx = nil
				ifs_mspc_OptionList_layout.CursorIdx = nil				
			end
			ListManager_fnFillContents(this.OptionListbox,gOptionList,ifs_mspc_OptionList_layout)		

			-- Host Option list
--			if( table.getn(gHostOptionList) == 0 ) then
--				ifs_mspc_HostOptionList_layout.SelectedIdx = nil
--				ifs_mspc_HostOptionList_layout.CursorIdx = nil				
--			end
--			ListManager_fnFillContents(this.HostOptionListbox,gHostOptionList,ifs_mspc_HostOptionList_layout)		

			-- Hack - if just 1 map, fake a button press thru to second part
			if(table.getn(missionselect_listbox_contents) == 1) then
				this:Input_Accept()
			end
		else
			this.EraMode = nil
			ifs_missionselect_pcMulti_fnSetPage(this,0) -- default internal mode.
			AnimationMgr_AddAnimation(this.buttons, { fStartAlpha = 0, fEndAlpha = 0,})
			this.buttons.bHidden = 1
		end
		
--		IFObj_fnSetVis( this.ModeListbox, nil )
		
		-- hide some old stuff
		IFObj_fnSetVis( this.AddDelContainer, nil )
--		IFObj_fnSetVis( this.listboxR, nil )
--		IFObj_fnSetVis( this.listboxL, nil )
		IFObj_fnSetVis( this.OrderButton, nil )
		
		-- init Mode and Era checkbox
		-- ifs_missionselect_pcMulti_fnInitModeEra( this )
	end,

	Exit = function(this, bFwd)
		if(not bFwd) then
			ifs_missionselect_pcMulti_fnSetPage(this,0) -- default internal mode.
			this.SelectedMap = nil -- clear this
		end
		if(gCurHiliteButton) then
			IFButton_fnSelect(gCurHiliteButton,nil)
		end
		-- stop the current movie
		ifelem_shellscreen_fnStopMovie()
		
	end,
	
	Update = function(this, fDt)
		-- Call base class functionality
		gIFShellScreenTemplate_fnUpdate(this, fDt)
		
		--time to change movies?
		custom_CheckChangeMovies(this, fDt)
		-- this.movieTime = this.movieTime - fDt
		-- if( this.movieName and this.movieTime<=0 ) then
			-- ifs_missionselect_pcMulti_ChangeMovieFile(this.movieFile)
    		-- ifelem_shellscreen_fnStartMovie(this.movieName.."fly", 1, nil, nil, this.movieX,this.movieY,this.movieW,this.movieH)
		    -- this.movieName = nil;
		-- end
		
		if( ifs_mp_gameopts.bAutoLaunch ) then
			ScriptCB_UpdateLobby(nil)
	
			print("Autolaunching...")
			ScriptCB_LaunchLobby()
		end

		-- animate the left/right arrows?
		IFObj_UpdateBlinkyAnim(this.AddDelContainer.add,
													 IFObj_fnTestHotSpot(this.AddDelContainer.add),0.4,1,0.4,0.2)
		IFObj_UpdateBlinkyAnim(this.AddDelContainer.del,
													 IFObj_fnTestHotSpot(this.AddDelContainer.del),0.4,1,0.4,0.2)
													 
		-- update listboxes if there are any changes
		ifs_missionselect_pcMulti_fnUpdateLists( this )
		
		-- press shift/ctrl key
		ifs_missionselect_pcMulti_fnUpdateKeyboard( this )		
	end,
	
	Input_KeyDown = function(this, iKey)
		print("ifs_missionselect_pcMulti.InputKeyDown iKey =", iKey)
		if(gCurEditbox) then
			
			if gCurEditbox == this.cheatBox then
				if iKey == 10 or iKey == 13 then
					local str = IFEditbox_fnGetString(gCurEditbox)
					local r3 = nil
					r3 = custom_ExtraCheats(str)
					if not r3 then
						r3 = ScriptCB_MrMrsEval(str)
					end
					
					for i = 1, 200, 1 do
						IFEditbox_fnAddChar(gCurEditbox, 8)
					end
					
					if r3 ~= nil then
						IFText_fnSetString(this.cheatOutput, r3)
						IFObj_fnSetVis(this.cheatOutput, 1)
					else
						IFObj_fnSetVis(this.cheatOutput, nil)
					end
				else
					IFEditbox_fnAddChar(gCurEditbox, iKey)
					IFObj_fnSetVis(this.cheatOutput, nil)
				end
				return
			end
		
			if(iKey == 10) then -- handle Enter different
				-- by doing nothing
			elseif (iKey == 9) then
				-- Handle tab key
				if(gCurEditbox) then
					IFEditbox_fnHilight(gCurEditbox, nil)
				end
				if(gCurEditbox == this.EditContainer.EditGameName) then
					gCurEditbox = this.EditPwdContainer.EditPass
				elseif (gCurEditbox == this.EditPwdContainer.EditPass) then
					gCurEditbox = this.EditContainer.EditGameName
				end
				if(gCurEditbox) then
					IFEditbox_fnHilight(gCurEditbox, 1)
				end
			else
				IFEditbox_fnAddChar(gCurEditbox, iKey)
			end
		end
	end,

	Input_Accept = function(this)
   		-- If the tab manager handled this event, then we're done
   		if((gPlatformStr == "PC") and
		   ( ifelem_tabmanager_HandleInputAccept(this, gPCMainTabsLayout) or
		     ifelem_tabmanager_HandleInputAccept(this, gPCMultiPlayerTabsLayout, 1) or 
		     ifelem_tabmanager_HandleInputAccept(this, gPCMultiPlayerSettingsTabsLayout, 2) ) ) then
   			return
   		end
   
   		-- If base class handled this work, then we're done
   		if(gShellScreen_fnDefaultInputAccept(this,1)) then
   			return
   		end

		-- input accept for source buttons
		ifs_missionselect_pcMulti_fnClickSourceButtons( this )

		-- if click on map list
		ifs_missionselect_pcMulti_fnClickMapList( this )

		if(gMouseListBox) then
			--if( ( gMouseListBox == this.ModeListbox ) or
			--	( gMouseListBox == this.OptionListbox ) ) then
			if( ( gMouseListBox == this.MapListbox ) ) then
				if( ( gMouseListBox.Layout.SelectedIdx == gMouseListBox.Layout.CursorIdx ) and 
					( this.lastDoubleClickTime ) and 
					( ScriptCB_GetMissionTime()<this.lastDoubleClickTime+0.4 ) ) then
					print( "+++1111 DoubleClicked " )
					-- double clicked
					this.iLastClickTime = nil
					this.bDoubleClicked = 1
				else
					-- single clicked
					this.iLastClickTime = ScriptCB_GetMissionTime()
					gMouseListBox.Layout.SelectedIdx = gMouseListBox.Layout.CursorIdx
				end				
			end
			
			--ScriptCB_SndPlaySound("shell_select_change")
--			if( gMouseListBox.Layout.SelectedIdx == gMouseListBox.Layout.CursorIdx )then
			if( gMouseListBox.Layout.SelectedIdx == gMouseListBox.Layout.CursorIdx and this.lastDoubleClickTime and ScriptCB_GetMissionTime()<this.lastDoubleClickTime+0.4) then
				this.lastDoubleClickTime = nil
--				if(gMouseListBox == this.listboxL) then
--					this.CurButton = "_add"
--				else
--					this.CurButton = "_del"
--				end
			else
				this.lastDoubleClickTime = ScriptCB_GetMissionTime()
				gMouseListBox.Layout.SelectedIdx = gMouseListBox.Layout.CursorIdx
				ListManager_fnFillContents(gMouseListBox,gMouseListBox.Contents,gMouseListBox.Layout)
				
				--start to play the movie
				ifs_missionselect_pcMulti_fnSetMapPreview(this)
				
				return 1 -- note we did all the work
			end
		end

		ifs_missionselect_pcMulti_fnClickCheckButtons( this )
		ifs_missionselect_pcMulti_fnClickMapButtons( this )
		
		-- input accept for option buttons
		ifs_missionselect_pcMulti_fnClickOptionButtons( this )
		
--		if(this.CurButton == "_del") then
--			local Count = table.getn(gPickedMapList)
--			if(Count > 0) then
--				local i
--				local j = 1
--				local NewList = {}
--				for i=1,Count do
--					if(i ~= pc_missionselect_name_listboxR_layout.SelectedIdx) then
--						NewList[j] = gPickedMapList[i]
--						j = j + 1
--					end
--				end
--
--				gPickedMapList = NewList
--				ListManager_fnAutoscroll(this.listboxR,gPickedMapList,pc_missionselect_name_listboxR_layout)
--				ListManager_fnFillContents(this.listboxR,gPickedMapList,pc_missionselect_name_listboxR_layout)
--			end
--			return
--		end -- "_del" special processing

		local Selection = missionselect_listbox_contents[pc_missionselect_name_listboxL_layout.SelectedIdx]
		local bPC = (gPlatformStr == "PC")

		if(this.iPage == 0) then -- first sub-part

			if(this.CurButton == "cancel" ) then
				this:Input_Back()
				return
			end
			
			print("this.CurButton=",this.CurButton)
			if(this.CurButton == "Option") then
				ifs_movietrans_PushScreen(ifs_mp_gameopts)	
			elseif (this.CurButton == "" ) then
				--do nothing, say nothing, get Kryten!
			elseif(this.CurButton == "Order") then
				ifs_missionselect_pcMulti_fnToggleOrder(this)
				ifelm_shellscreen_fnPlaySound(this.acceptSound)
			elseif (this.CurButton == "Launch") then				
				-- clean session list if launch a game
				-- because session might opened when we first enter the tabs
				ScriptCB_CancelSessionList()
				
				ifelm_shellscreen_fnPlaySound(this.acceptSound)
				ifs_missionselect_pcMulti_fnLaunch(this)
				this.bLan = nil
--			elseif (this.CurButton == "LaunchLan") then
--				ifelm_shellscreen_fnPlaySound(this.acceptSound)
--				this.bLan = 1
--				ifs_missionselect_pcMulti_fnLaunch(this)
--			elseif (this.CurButton == "EditGameName") then
----------------------Hack
--				ifs_vkeyboard.CurString = ScriptCB_GetCurrentProfileNetName()
--				ifs_vkeyboard.bCursorOnAccept = 1 -- start cursor on Accept
--				IFText_fnSetString(ifs_vkeyboard.title,"ifs.vkeyboard.title_gamename")
--				vkeyboard_specs.fnDone = ifs_pc_mp_fnKeyboardDone
--				vkeyboard_specs.fnIsOk = ifs_login_fnIsAcceptable -- reuse this
--				local w,h = ScriptCB_GetSafeScreenInfo() -- of the usable screen
--				ifs_movietrans_PushScreen(ifs_vkeyboard)
-----------------------			
			elseif (((not bPC) and (this.bOnLeft)) or (bPC and (this.CurButton == "_add"))) then
			
				print("@@@@@@@@@@@@@   @@@@  I think your on the left and adding a map")
				ifelm_shellscreen_fnPlaySound(this.acceptSound)
				if(table.getn(gPickedMapList) < this.iMaxMissions) then
					local bMultipleSides
					local LastSideChar
					bMultipleSides,LastSideChar = ifs_missionselect_pcMulti_fnGetSides(Selection)

					if(bMultipleSides) then
						ifs_missionselect_pcMulti_fnSetPage(this,1)
					else
						-- Only 1 side. Add it directly.
						local EntryButton = this.CurButton
						this.AttackerChar = LastSideChar
						this.CurButton = LastSideChar
						ifs_missionselect_pcMulti_fnAddMap(this)
						this.CurButton = EntryButton
					end
				else
					-- Mission list is full. Notify the user
					ifs_missionselect_pcMulti_fnShowHideListboxes(this,nil)
					Popup_Ok.fnDone = ifs_missionselect_pcMulti_fnFullPopupDone
					Popup_Ok:fnActivate(1)
					gPopup_fnSetTitleStr(Popup_Ok, "ifs.missionselect.listfull")
				end
--			elseif (this.CurButton == "_source") then
--				print( "+++CurButton = _source" )
--				this.source_value = this.source_value + 1	
--				if( this.source_value > this.source_value_max ) then
--					this.source_value = 1
--				end
--				ifs_missionselect_pcMulti_fnSourceButtonUpdate( this )
			else
				-- must be on right listbox
				if this.CurButton then
				   -- don't play sound unless you're on a button
				   ifelm_shellscreen_fnPlaySound(this.acceptSound)
				end
				this.bOnButtons = 1
				pc_missionselect_name_listboxR_layout.CursorIdx = nil
--				ListManager_fnFillContents(this.listboxR,gPickedMapList,pc_missionselect_name_listboxR_layout)
			end -- on right
		elseif (this.iPage == 1) then -- Second sub-part
			ifelm_shellscreen_fnPlaySound(this.acceptSound)
			this.AttackerChar = this.CurButton -- store for later

			-- Side select is ingame now - NM 4/5/04
			ifs_missionselect_pcMulti_fnAddMap(this)
--			ifs_missionselect_pcMulti_fnSetPage(this,2)
		elseif (this.iPage == 2) then -- Second sub-part
			ifelm_shellscreen_fnPlaySound(this.acceptSound)

			ifs_missionselect_pcMulti_fnAddMap(this)

--			this.fnDone()
		end -- done with sub-parts
		
	end, -- end of Input_Accept

	Input_Back = function(this)
		-- Hack - if just 1 map, then can't go back to the listboxL
		if(table.getn(missionselect_listbox_contents) == 1) then
			this.EraMode = nil
		end

		if(this.iPage == 0) then -- first sub-part
			if(gPlatformStr == "PC") then			
				ScriptCB_PopScreen("ifs_main") -- default action
			else				
				ScriptCB_PopScreen()
			end
			if(this.fnCancel) then
				this.fnCancel()
			--else
			--	ScriptCB_PopScreen() -- default: just go back 2 screens.
			end
		elseif (this.iPage == 1) then
			ifelm_shellscreen_fnPlaySound(this.exitSound)
			ifs_missionselect_pcMulti_fnSetPage(this,0)
		end
	end,
	
	-- Delete a map from selected list. Done by creating a new list, copying
	-- everything but the selected one over, swapping lists.
--	Input_Misc = function(this)
--		if((this.iPage == 0) and (not this.bOnLeft) and (not this.bOnButtons)) then
--			local Count = table.getn(gPickedMapList)
--			if(Count > 0) then
--				local i
--				local j = 1
--				local NewList = {}
--				for i=1,Count do
--					if(i ~= pc_missionselect_name_listboxR_layout.SelectedIdx) then
--						NewList[j] = gPickedMapList[i]
--						j = j + 1
--					end
--				end
--
--				gPickedMapList = NewList
--
--				ListManager_fnAutoscroll(this.listboxR,gPickedMapList,pc_missionselect_name_listboxR_layout)
--				ListManager_fnFillContents(this.listboxR,gPickedMapList,pc_missionselect_name_listboxR_layout)
--
--				--if(table.getn(NewList) < 1) then
--				--	AnimationMgr_AddAnimation(this.Helptext_Delete, { fStartAlpha = 1, fEndAlpha = 0.25,})
--				--end
--					--ifs_missionselect_pcMulti_fnSetMapPreview(this)
--			end -- count > 0 
--		end -- page, column valid
--	end,

	Input_GeneralUp = function(this)
		-- If base class handled this work, then we're done
		if(gShellScreen_fnDefaultInputUp(this)) then
			return
		end

		if(this.iPage == 0) then -- First sub-part
			if(this.bOnLeft) then
				-- In listbox
			else
				-- on the right
				if(this.bOnButtons) then
					ifelm_shellscreen_fnPlaySound(this.selectSound)
					if(this.CurButton == "Order") then
						ifs_missionselect_pcMulti_fnSetCurButton(this,nil)
						pc_missionselect_name_listboxR_layout.SelectedIdx = math.min(pc_missionselect_name_listboxR_layout.FirstShownIdx + pc_missionselect_name_listboxR_layout.showcount - 1, table.getn(gPickedMapList))
						if(pc_missionselect_name_listboxR_layout.SelectedIdx < 1) then
							pc_missionselect_name_listboxR_layout.SelectedIdx = 1
						end
						pc_missionselect_name_listboxR_layout.CursorIdx = pc_missionselect_name_listboxR_layout.SelectedIdx
--						ListManager_fnFillContents(this.listboxR,gPickedMapList,pc_missionselect_name_listboxR_layout)
					else
					end

				else
					-- Not on buttons
					if(pc_missionselect_name_listboxR_layout.SelectedIdx == 1) then
						pc_missionselect_name_listboxR_layout.CursorIdx = nil
--						ListManager_fnFillContents(this.listboxR,gPickedMapList,pc_missionselect_name_listboxR_layout)
						ifelm_shellscreen_fnPlaySound(this.selectSound)
					else
						-- on right
					end
				end
			end
--			ifs_missionselect_pcMulti_fnSetMapPreview(this)
		elseif (this.iPage == 1) then
			gDefault_Input_GeneralUp(this)
		end -- page == 0
		ifs_missionselect_pcMulti_fnUpdateDelButton(this)
	end,

	Input_GeneralDown = function(this)
		-- If base class handled this work, then we're done
		if(gShellScreen_fnDefaultInputDown(this)) then
			return
		end
		if(this.iPage == 0) then -- First sub-part
			if(this.bOnLeft) then
			else
				-- on the right
				if(this.bOnButtons) then
					ifelm_shellscreen_fnPlaySound(this.selectSound)
					if(this.CurButton == "Order") then
					else
						ifs_missionselect_pcMulti_fnSetCurButton(this,nil)
						pc_missionselect_name_listboxR_layout.SelectedIdx = pc_missionselect_name_listboxR_layout.FirstShownIdx
						
						pc_missionselect_name_listboxR_layout.CursorIdx = pc_missionselect_name_listboxR_layout.SelectedIdx
--						ListManager_fnFillContents(this.listboxR,gPickedMapList,pc_missionselect_name_listboxR_layout)
					end
				else
					-- Not on buttons
					if(pc_missionselect_name_listboxR_layout.SelectedIdx >= table.getn(gPickedMapList)) then
						pc_missionselect_name_listboxR_layout.CursorIdx = nil
--						ListManager_fnFillContents(this.listboxR,gPickedMapList,pc_missionselect_name_listboxR_layout)
						ifelm_shellscreen_fnPlaySound(this.selectSound)
					else
					end
				end -- not on buttons
			end
--			ifs_missionselect_pcMulti_fnSetMapPreview(this)
		elseif (this.iPage == 1) then
			gDefault_Input_GeneralDown(this)
		end
		ifs_missionselect_pcMulti_fnUpdateDelButton(this)
	end,

	Input_LTrigger = function(this)
		if(this.iPage == 0) then -- First sub-part
--			if(this.bOnLeft) then
--				ListManager_fnPageUp(this.listboxL,missionselect_listbox_contents,pc_missionselect_name_listboxL_layout)
--			else
--				ListManager_fnPageUp(this.listboxR,gPickedMapList,pc_missionselect_name_listboxR_layout)
--			end
--			ifs_missionselect_pcMulti_fnSetMapPreview(this)
		end
	end,

	Input_RTrigger = function(this)
		if(this.iPage == 0) then -- First sub-part
--			if(this.bOnLeft) then
--				ListManager_fnPageDown(this.listboxL,missionselect_listbox_contents,pc_missionselect_name_listboxL_layout)
--			else
--				ListManager_fnPageDown(this.listboxR,gPickedMapList,pc_missionselect_name_listboxR_layout)
--			end
--			ifs_missionselect_pcMulti_fnSetMapPreview(this)
		end
	end,

	Input_GeneralLeft = function(this)
		-- change options
		if( gMouseListBox and ( gMouseListBox.Layout.SelectedIdx == gMouseListBox.Layout.CursorIdx ) ) then
			if( gMouseListBox == this.OptionListbox  ) then				
				ifs_missionselect_pcMulti_fnChangeOptions( this, 1 )
--			elseif( gMouseListBox == this.HostOptionListbox  ) then
--				ifs_missionselect_pcMulti_fnChangeHostOptions( this, 1 )
			end
		end
		
		if(this.iPage == 0) then
			ifs_missionselect_pcMulti_fnFlipLeftRight(this)
		end
	end,

	Input_GeneralRight = function(this)
		-- change options
		if( gMouseListBox and ( gMouseListBox.Layout.SelectedIdx == gMouseListBox.Layout.CursorIdx ) ) then
			if( gMouseListBox == this.OptionListbox  ) then				
				ifs_missionselect_pcMulti_fnChangeOptions( this, nil )
--			elseif( gMouseListBox == this.HostOptionListbox  ) then
--				ifs_missionselect_pcMulti_fnChangeHostOptions( this, nil )
			end
		end
	
		if(this.iPage == 0) then
			ifs_missionselect_pcMulti_fnFlipLeftRight(this)
		end
	end,

	RepaintListbox = function(this, bOnLeft)
	end,	
	UpdateButtons = function(this) 
	end,
	UpdateUI = function(this)
	end,
	fnClearButtonHilight = function(this)
	end,
}

--------------------------------------------------------
--------------------------------------------------------
-- Helper function. Given a layout (x,y,width, height), returns a
-- fully-built item.
local list_item_offset_x = 6
function ifs_mspc_MapList_CreateItem(layout)
	-- Make a coordinate system pegged to the top-left of where the cursor would go.
	local Temp = NewIFContainer { 
		x = layout.x - 0.5 * layout.width, 
		y = layout.y - 4,
	}

	Temp.map = NewIFText { 
		x = list_item_offset_x,
		y = layout.height * -0.5 + 5,
		halign = "left", valign = "vcenter",
		font = "gamefont_tiny",
		textw = layout.width - 5, texth = layout.height,
		startdelay=math.random()*0.5, nocreatebackground=1, 
	}

	return Temp
end

-- Helper function. For a destination item (previously created w/
-- CreateItem), fills it in with data, which may be nil (==blank it)
function ifs_mspc_MapList_PopulateItem(Dest, Data, bSelected)
	if(Data) then
		ifs_missionselect_pcMulti_fnSetMapListColor(Dest, Data, bSelected)

		-- Show the data
		local DisplayUStr,iSource = missionlist_GetLocalizedMapName(Data.mapluafile)

		IFText_fnSetUString(Dest.map,DisplayUStr)
	end

	IFObj_fnSetVis(Dest.map,Data)
end

ifs_mspc_MapList_layout = {
	showcount = 22,
--	yTop = -150, -- auto-calc'd now
	yHeight = 20,
	ySpacing = -5,
--	width = 260,
--	x = 0,
	slider = 1,
	CreateFn = ifs_mspc_MapList_CreateItem,
	PopulateFn = ifs_mspc_MapList_PopulateItem,
}

-- Helper function. Given a layout (x,y,width, height), returns a
-- fully-built item.
function ifs_mspc_ModeList_CreateItem(layout)
	-- Make a coordinate system pegged to the top-left of where the cursor would go.
	local Temp = NewIFContainer { 
		x = layout.x - 0.5 * layout.width, 
		y = layout.y,
	}

	Temp.mode = NewIFText { 
		x = list_item_offset_x,
		y = layout.height * -0.5 + 5,
		halign = "left", valign = "vcenter",
		font = "gamefont_tiny",
		textw = layout.width - 5, texth = layout.height,
		startdelay=math.random()*0.5, nocreatebackground=1, 
	}

	local IconHeight = layout.height * 0.75

	Temp.icon = NewIFImage {
		ZPos = 240, 
		localpos_l = layout.width - 5 - IconHeight,
		localpos_r = layout.width - 5,
		localpos_t = (IconHeight * -0.5) + 3,
		localpos_b = (IconHeight * 0.5) + 3,
	}

	return Temp
end

-- Helper function. For a destination item (previously created w/
-- CreateItem), fills it in with data, which may be nil (==blank it)
function ifs_mspc_ModeList_PopulateItem(Dest, Data, bSelected)
	local bShowIcon = Data and (Data.icon)

	if(Data) then
		local iColor = 255
		if((ifs_missionselect.iColumn == 1) or
			 (bSelected and (ifs_missionselect_pcMulti.iColumn >= 1))) then
			iColor = 255
		end
		IFObj_fnSetColor(Dest.mode, iColor, iColor, iColor)

		local DisplayUStr = ScriptCB_getlocalizestr(Data.showstr)

		-- If Data.icon exists, set the texture on it.
		if(bShowIcon) then
			IFImage_fnSetTexture(Dest.icon, Data.icon)
		end

		-- Show the data
		IFText_fnSetUString(Dest.mode, DisplayUStr)
	end

	IFObj_fnSetVis(Dest.mode,Data)
	IFObj_fnSetVis(Dest.icon,bShowIcon)
end

ifs_mspc_ModeList_layout = {
	showcount = 10,
--	yTop = -150, -- auto-calc'd now
	yHeight = 20,
	ySpacing = -5,
	width = 180,
	x = 0,
	y = 0,
	slider = nil,
	CreateFn = ifs_mspc_ModeList_CreateItem,
	PopulateFn = ifs_mspc_ModeList_PopulateItem,
}

-- Helper function. Given a layout (x,y,width, height), returns a
-- fully-built item.
function ifs_mspc_PlayList_CreateItem(layout)
	-- Make a coordinate system pegged to the top-left of where the cursor would go.
	local Temp = NewIFContainer { 
		x = layout.x - 0.5 * layout.width, 
		y = layout.y,
	}

	local HAlign = "left"
--	local XPos = 3
	local WidthAdj = -5

	Temp.map = NewIFText { 
		x = list_item_offset_x,
		y = layout.height * -0.5 + 1,
		halign = "left", valign = "vcenter",
		font = "gamefont_tiny",
		textw = layout.width + WidthAdj, texth = layout.height,
		startdelay=math.random()*0.5, 
		nocreatebackground=1, 
	}

	local IconHeight = layout.height * 0.65

	Temp.icon = NewIFImage {
		ZPos = 240, 
		localpos_l = layout.width - 5 - IconHeight,
		localpos_r = layout.width - 5,
		localpos_t = (IconHeight * -0.5),
		localpos_b = (IconHeight * 0.5),
	}

--	Temp.icon1 = NewIFImage {
--		ZPos = 240, 
--		localpos_l = layout.width - 3 - IconHeight - 3 - IconHeight - 5 - IconHeight,
--		localpos_r = layout.width - 3 - IconHeight - 3 - IconHeight - 5,
--		localpos_t = (IconHeight * -0.5),
--		localpos_b = (IconHeight * 0.5),
--		ColorR = 240,
--		ColorG = 32,
--		ColorB = 32,
--	}

	Temp.icon2 = NewIFImage {
		ZPos = 240, 
		localpos_l = layout.width - 3 - IconHeight - 5 - IconHeight,
		localpos_r = layout.width - 3 - IconHeight - 5,
		localpos_t = (IconHeight * -0.5),
		localpos_b = (IconHeight * 0.5),
--		ColorR = 32,
--		ColorG = 240,
--		ColorB = 32,
	}

	return Temp
end

-- Helper function. For a destination item (previously created w/
-- CreateItem), fills it in with data, which may be nil (==blank it)
function ifs_mspc_PlayList_PopulateItem(Dest, Data, bSelected)
	local bShowIcon = Data
	local bShowIcon1 = Data

	if(Data) then
		ifs_missionselect_pcMulti_fnSetMapListColor(Dest, Data, bSelected)

		local DisplayUStr,iSource = missionlist_GetLocalizedMapName(Data.Map)
		IFText_fnSetUString(Dest.map,DisplayUStr)
		local MapEraIcon, MapModeIcon = custom_GetCustomEraAndModeIcons(Data)
		
		--local MapMode = missionlist_GetMapMode(Data.Map)
		if MapModeIcon then
			IFImage_fnSetTexture(Dest.icon, MapModeIcon)
		else
			bShowIcon = nil
		end

		--local MapEra = missionlist_GetMapEra(Data.Map)
		if MapEraIcon then
			--IFImage_fnSetTexture(Dest.icon1, MapEra.icon1)
			IFImage_fnSetTexture(Dest.icon2, MapEraIcon)
		else
			bShowIcon1 = nil
		end
		
	end

	-- Turn on/off depending on whether data's there or not
	IFObj_fnSetVis(Dest.map,Data)
	IFObj_fnSetVis(Dest.icon,bShowIcon)
	--IFObj_fnSetVis(Dest.icon1,bShowIcon1)
	IFObj_fnSetVis(Dest.icon2,bShowIcon1)
end

ifs_mspc_PlayList_layout = {
	showcount = 22,
--	yTop = -150, -- auto-calc'd now
	yHeight = 20,
	ySpacing = -5,
--	width = 260,
	x = 0,
	slider = 1,
	CreateFn = ifs_mspc_PlayList_CreateItem,
	PopulateFn = ifs_mspc_PlayList_PopulateItem,
}

-- Helper function. Given a layout (x,y,width, height), returns a
-- fully-built item.
function ifs_mspc_OptionList_CreateItem(layout)
	-- Make a coordinate system pegged to the top-left of where the cursor would go.
	local Temp = NewIFContainer { 
		x = layout.x - 0.5 * layout.width, 
		y = layout.y,
	}

	Temp.opt_text = NewIFText { 
		x = 3,
		y = layout.height * -0.5 + 5,
		halign = "left", valign = "vcenter",
		font = "gamefont_tiny",
		textw = layout.width - 5, texth = layout.height,
		startdelay=math.random()*0.5, nocreatebackground=1, 
	}

	return Temp
end

-- Helper function. For a destination item (previously created w/
-- CreateItem), fills it in with data, which may be nil (==blank it)
function ifs_mspc_OptionList_PopulateItem(Dest, Data, bSelected)
	if(Data) then
		local iColor = 255
		local iColor1 = 100
		IFObj_fnSetColor(Dest.opt_text, iColor, iColor, iColor)
		
		-- Show the data
		local DisplayUStr = nil
		
		-- interpolate options
		if( Data.tag == "bots" ) then
			DisplayUStr = ScriptCB_usprintf( Data.prompt,  ScriptCB_tounicode(string.format("%d", ifs_mp_gameopts.Prefs.iNumBots)))
		elseif( Data.tag == "difficulty" ) then
			local diff_str = nil
			if(ifs_mp_gameopts.Prefs.iDifficulty == 1) then
				diff_str = ScriptCB_getlocalizestr("ifs.difficulty.easy")
			elseif(ifs_mp_gameopts.Prefs.iDifficulty == 2) then
				diff_str = ScriptCB_getlocalizestr("ifs.difficulty.medium")
			else
				diff_str = ScriptCB_getlocalizestr("ifs.difficulty.hard")
			end
			DisplayUStr = ScriptCB_usprintf( Data.prompt, diff_str )
		elseif( Data.tag == "dm" ) then
			DisplayUStr = ScriptCB_usprintf( Data.prompt,  ScriptCB_tounicode(string.format("%d", 100)))
		elseif( Data.tag == "con" ) then
			DisplayUStr = ScriptCB_usprintf( Data.prompt,  ScriptCB_tounicode(string.format("%d", 100)))
		elseif( Data.tag == "ctf" ) then
			DisplayUStr = ScriptCB_usprintf( Data.prompt,  ScriptCB_tounicode(string.format("%d", 3)))
		elseif( Data.tag == "bonus" ) then
			DisplayUStr = ScriptCB_usprintf( Data.prompt,  ScriptCB_tounicode("ON"))
		elseif( Data.tag == "hero" ) then			
			if(ifs_mp_gameopts.Prefs.bHeroesEnabled) then
				DisplayUStr = ScriptCB_getlocalizestr( "ifs.mp.createopts.heroenable" )
			else
				DisplayUStr = ScriptCB_getlocalizestr( "ifs.mp.createopts.herodisable" )
			end
		elseif( Data.tag == "hero_unlock" ) then
			DisplayUStr = ScriptCB_getlocalizestr( string.format( "ifs.mp.heroopts.herounlock%d", ifs_mp_heroopts.Prefs.iHeroUnlock ) )
			if( not ifs_mp_gameopts.Prefs.bHeroesEnabled ) then
				IFObj_fnSetColor(Dest.opt_text, iColor1, iColor1, iColor1)
			end
		elseif( Data.tag == "hero_unval" ) then
			local num_str = ScriptCB_tounicode(string.format("%d",ifs_mp_heroopts.Prefs.iHeroUnlockVal))
			if( ifs_mp_heroopts.Prefs.iHeroUnlock == 1 ) then
				DisplayUStr = ""	
			elseif( ifs_mp_heroopts.Prefs.iHeroUnlock == 2 ) then
				DisplayUStr = ScriptCB_usprintf("ifs.mp.heroopts.reinforcements", num_str)
			elseif( ifs_mp_heroopts.Prefs.iHeroUnlock == 3 ) then
				DisplayUStr = ScriptCB_usprintf("ifs.mp.heroopts.numpoints", num_str)
			elseif( ifs_mp_heroopts.Prefs.iHeroUnlock == 4 ) then
				DisplayUStr = ScriptCB_usprintf("ifs.mp.heroopts.numkills", num_str)
			elseif( ifs_mp_heroopts.Prefs.iHeroUnlock == 5 ) then
				DisplayUStr = ScriptCB_usprintf("ifs.mp.heroopts.numseconds", num_str)
			elseif( ifs_mp_heroopts.Prefs.iHeroUnlock == 6 ) then
				DisplayUStr = ScriptCB_usprintf("ifs.mp.heroopts.numcaptures", num_str)
			end
			if( not ifs_mp_gameopts.Prefs.bHeroesEnabled ) then
				IFObj_fnSetColor(Dest.opt_text, iColor1, iColor1, iColor1)
			end
		elseif( Data.tag == "hero_team" ) then
			DisplayUStr = ScriptCB_getlocalizestr( string.format( "ifs.mp.heroopts.heroteam%d", ifs_mp_heroopts.Prefs.iHeroTeam ) )
			if( not ifs_mp_gameopts.Prefs.bHeroesEnabled ) then
				IFObj_fnSetColor(Dest.opt_text, iColor1, iColor1, iColor1)
			end
		elseif( Data.tag == "hero_player" ) then
			DisplayUStr = ScriptCB_getlocalizestr( string.format( "ifs.mp.heroopts.heroplayer%d", ifs_mp_heroopts.Prefs.iHeroPlayer ) )
			if( not ifs_mp_gameopts.Prefs.bHeroesEnabled ) then
				IFObj_fnSetColor(Dest.opt_text, iColor1, iColor1, iColor1)
			end
		elseif( Data.tag == "hero_respawn" ) then
			if( ifs_mp_heroopts.Prefs.iHeroRespawn == 1 ) then
				DisplayUStr = ScriptCB_getlocalizestr( "ifs.mp.heroopts.herorespawn1" )
			elseif( ifs_mp_heroopts.Prefs.iHeroRespawn == 2 ) then
				DisplayUStr = ScriptCB_usprintf( Data.prompt,  ScriptCB_tounicode(string.format("%d", ifs_mp_heroopts.Prefs.iHeroRespawnVal)))
			end
			if( not ifs_mp_gameopts.Prefs.bHeroesEnabled ) then
				IFObj_fnSetColor(Dest.opt_text, iColor1, iColor1, iColor1)
			end
		end

		IFText_fnSetUString(Dest.opt_text,DisplayUStr)
	end

	IFObj_fnSetVis(Dest.opt_text,Data)
end

ifs_mspc_OptionList_layout = {
	showcount = 13,
--	yTop = -150, -- auto-calc'd now
	yHeight = 20,
	ySpacing = -5,
--	width = 260,
--	x = 0,
	slider = 1,
	CreateFn = ifs_mspc_OptionList_CreateItem,
	PopulateFn = ifs_mspc_OptionList_PopulateItem,
}

-- Helper function. Given a layout (x,y,width, height), returns a
-- fully-built item.
function ifs_mspc_HostOptionList_CreateItem(layout)
	-- Make a coordinate system pegged to the top-left of where the cursor would go.
	local Temp = NewIFContainer { 
		x = layout.x - 0.5 * layout.width, 
		y = layout.y,
	}

	Temp.opt_text = NewIFText { 
		x = 3,
		y = layout.height * -0.5 + 5,
		halign = "left", valign = "vcenter",
		font = "gamefont_tiny",
		textw = layout.width - 5, texth = layout.height,
		startdelay=math.random()*0.5, nocreatebackground=1, 
	}

	return Temp
end

-- Helper function. For a destination item (previously created w/
-- CreateItem), fills it in with data, which may be nil (==blank it)
function ifs_mspc_HostOptionList_PopulateItem(Dest, Data, bSelected)
	if(Data) then
		local iColor = 255
		IFObj_fnSetColor(Dest.opt_text, iColor, iColor, iColor)

		-- Show the data
		local DisplayUStr = nil
		
		-- interpolate options
		if( Data.tag == "dedicated" ) then
			local on_str = nil
			if( ifs_mp_gameopts.bDedicated ) then
				on_str = ScriptCB_getlocalizestr("common.on")
			else
				on_str = ScriptCB_getlocalizestr("common.off")
			end
			DisplayUStr = ScriptCB_usprintf( Data.prompt,  on_str )
		elseif( Data.tag == "players" ) then
			DisplayUStr = ScriptCB_usprintf( Data.prompt,  ScriptCB_tounicode(string.format("%d", ifs_mp_gameopts.Prefs.iNumPlayers)))
		elseif( Data.tag == "autoassign" ) then
			if(ifs_mp_gameopts.Prefs.bAutoAssignTeams) then
				DisplayUStr =  ScriptCB_getlocalizestr( "ifs.mp.createopts.autoassign_on" )
			else
				DisplayUStr =  ScriptCB_getlocalizestr( "ifs.mp.createopts.autoassign_off" )
			end
		elseif( Data.tag == "tracking" ) then
			local on_str = nil
			if( ifs_mp_gameopts.Prefs.iAutoAim < 1 ) then
				on_str = ScriptCB_getlocalizestr("common.off")
			else
				on_str = ScriptCB_getlocalizestr("common.on")
			end			
			DisplayUStr = ScriptCB_usprintf( Data.prompt,  on_str )
		elseif( Data.tag == "shownames" ) then
			local on_str = nil
			if( ifs_mp_gameopts.Prefs.bShowNames ) then
				on_str = ScriptCB_getlocalizestr("common.on")
			else
				on_str = ScriptCB_getlocalizestr("common.off")
			end			
			DisplayUStr = ScriptCB_usprintf( Data.prompt,  on_str )
		elseif( Data.tag == "warmup" ) then
			DisplayUStr = ScriptCB_usprintf( Data.prompt,  ScriptCB_tounicode(string.format("%d", ifs_mp_gameopts.Prefs.iWarmUp)))
		elseif( Data.tag == "vote" ) then
			if( ifs_mp_gameopts.Prefs.iVote == 0 ) then
				DisplayUStr = ScriptCB_getlocalizestr( "ifs.mp.createopts.vote0" )
			else			
				DisplayUStr = ScriptCB_usprintf( Data.prompt,  ScriptCB_tounicode(string.format("%d", ifs_mp_gameopts.Prefs.iVote)))
			end
		elseif( Data.tag == "spawn" ) then
			DisplayUStr = ScriptCB_tounicode( "Spawn Invincibility: 2 sec" )
		elseif( Data.tag == "startcnt" ) then
			DisplayUStr = ScriptCB_usprintf( Data.prompt,  ScriptCB_tounicode(string.format("%d", ifs_mp_gameopts.Prefs.iStartCnt)))
		elseif( Data.tag == "teamdmg" ) then
			local on_str = nil
			if( ifs_mp_gameopts.Prefs.iTeamDmg < 1 ) then			
				on_str = ScriptCB_getlocalizestr("common.off")
			else
				on_str = ScriptCB_getlocalizestr("common.on")
			end			
			DisplayUStr = ScriptCB_usprintf( Data.prompt,  on_str )
		elseif( Data.tag == "voicemode" ) then
			local on_str = nil
			if( ifs_mp_gameopts.Prefs.iVoiceMode == 1 ) then
				on_str = ScriptCB_getlocalizestr("ifs.mp.voicechat.mode.disabled")
			elseif( ifs_mp_gameopts.Prefs.iVoiceMode == 2 ) then
				on_str = ScriptCB_getlocalizestr("ifs.mp.voicechat.mode.peertopeer")
			elseif( ifs_mp_gameopts.Prefs.iVoiceMode == 3 ) then
				on_str = ScriptCB_getlocalizestr("ifs.mp.voicechat.mode.peerrelay")
			elseif( ifs_mp_gameopts.Prefs.iVoiceMode == 4 ) then
				on_str = ScriptCB_getlocalizestr("ifs.mp.voicechat.mode.serverrelay")
			else
				on_str = ScriptCB_tounicode("Invalid!")
			end			
			DisplayUStr = ScriptCB_usprintf( Data.prompt,  on_str )
		end
		
		IFText_fnSetUString(Dest.opt_text,DisplayUStr)
	end

	IFObj_fnSetVis(Dest.opt_text,Data)
end

ifs_mspc_HostOptionList_layout = {
	showcount = 13,
--	yTop = -150, -- auto-calc'd now
	yHeight = 20,
	ySpacing = -5,
--	width = 260,
--	x = 0,
	slider = 1,
	CreateFn = ifs_mspc_HostOptionList_CreateItem,
	PopulateFn = ifs_mspc_HostOptionList_PopulateItem,
}

gOptionList = {
	{ tag = "bots",			desc = "ifs.mp.createopts.helptext.numbots",		prompt = "ifs.mp.createopts.numbots", },
	{ tag = "difficulty",	desc = "ifs.mp.createopts.helptext.aidifficulty",	prompt = "ifs.mp.create.opt.ai", },	
	{ tag = "dm",			desc = "ifs.mp.createopts.helptext.dm_mult",		prompt = "ifs.mp.create.opt.dm", },
	{ tag = "con",			desc = "ifs.mp.createopts.helptext.con_mult",		prompt = "ifs.mp.create.opt.con", },
	{ tag = "ctf",			desc = "ifs.mp.createopts.helptext.ctf_score",		prompt = "ifs.mp.create.opt.ctf", },
	{ tag = "bonus",		desc = "ifs.mp.createopts.helptext.bonus_onoff",	prompt = "ifs.mp.create.opt.bonus", },
	{ tag = "hero",			desc = "ifs.mp.createopts.helptext.heroes_onoff",	prompt = "ifs.mp.createopts.heroes", },
	
	{ tag = "hero_unlock",	desc = "ifs.mp.createopts.helptext.hero_unlock_1",	prompt = "ifs.mp.heroopts.herounlock1", },
	{ tag = "hero_unval",	desc = "ifs.mp.createopts.helptext.hero_unlock_2",	prompt = "ifs.mp.heroopts.reinforcements", },
	
	{ tag = "hero_team",	desc = "ifs.mp.createopts.helptext.hero_unlockfor",	prompt = "ifs.mp.heroopts.heroteam1", },
	{ tag = "hero_player",	desc = "ifs.mp.createopts.helptext.hero_assign",	prompt = "ifs.mp.heroopts.heroplayer1", },
	{ tag = "hero_respawn",	desc = "ifs.mp.createopts.helptext.hero_respawn",	prompt = "ifs.mp.create.opt.hero_spawn", },
}

gHostOptionList = {
	{ tag = "dedicated",	desc = "ifs.mp.createopts.helptext.dedicated",		prompt = "ifs.mp.createopts.dedicated" },	
	{ tag = "players",		desc = "ifs.mp.createopts.helptext.players",		prompt = "ifs.mp.createopts.maxplayers", },
	{ tag = "autoassign",	desc = "ifs.mp.createopts.helptext.autoassign",		prompt = "ifs.mp.createopts.autoassign_on", },
	{ tag = "tracking",		desc = "ifs.mp.createopts.helptext.autoaim",		prompt = "ifs.mp.createopts.autoaim", },	
	{ tag = "shownames",	desc = "ifs.mp.createopts.helptext.shownames",		prompt = "ifs.mp.createopts.shownames", },
	{ tag = "warmup",		desc = "ifs.mp.createopts.helptext.warmup",			prompt = "ifs.mp.createopts.warmup", },		
	{ tag = "vote",			desc = "ifs.mp.createopts.helptext.vote",			prompt = "ifs.mp.createopts.vote", },
	{ tag = "spawn",		desc = "ifs.mp.createopts.helptext.spawn_invinc",	prompt = "ifs.mp.createopts.vote", },
	{ tag = "startcnt",		desc = "ifs.mp.createopts.helptext.startcnt",		prompt = "ifs.mp.createopts.startcnt", },
	{ tag = "teamdmg",		desc = "ifs.mp.createopts.helptext.teamdmg",		prompt = "ifs.mp.createopts.teamdamage", },	
	{ tag = "voicemode",	desc = "ifs.mp.createopts.helptext.voicemode",		prompt = "ifs.mp.createopts.voicemode", },	
}

function ifs_missionselect_pcMulti_fnSetGameOptions( )
-- 	if( ifs_mp_gameopts.Prefs ) then
-- 		ScriptCB_SetNetGameDefaults(ifs_mp_gameopts.Prefs) 

-- 		ScriptCB_SetDedicated(ifs_mp_gameopts.bDedicated)
-- 		ScriptCB_SetCanSwitchSides( not ifs_mp_gameopts.Prefs.bAutoAssignTeams )
-- 	end
end

--------------------------------------------------------
--------------------------------------------------------

gPickedMapList = {}

function ifs_missionselect_pcMulti_fnClickSourceButtons( this )
	--print( "this.bSourceDropBoxesOpen =", this.bSourceDropBoxesOpen )
	--print( "this.CurButton =", this.CurButton )
	
	if( this.bSourceDropBoxesOpen ) then
		--print( "gMouseListBox =", gMouseListBox )
		--print( "this.source_listbox =", this.source_listbox )
		if( gMouseListBox == this.source_listbox ) then
			if( sourcelist_layout.CursorIdx ) then
				this.source_value = sourcelist_layout.CursorIdx
			end
			print( "this.source_value = ", this.source_value )
			ifs_missionselect_pcMulti_fnSourceButtonUpdate( this )		
		end
		ifs_mp_sessionlist_fnShowSourceDropbox( this, nil )		
	else
		-- open the drop box
		if( this.CurButton == "_source" ) then
			ifs_mp_sessionlist_fnShowSourceDropbox( this, 1 )
		end
	end
end

function ifs_missionselect_pcMulti_fnAddInfoBox(this)
	local new_shell_offset_x = 240
	local text_width = 575
	
	this.InfoboxBot = NewIFContainer { 
		ScreenRelativeX = 0, -- left side of screen
		ScreenRelativeY = 0, -- top
		x = -82 + new_shell_offset_x,
		y = 520,

		-- infolistbox
		InfoListbox = NewButtonWindow { 
			ZPos = 200, 
			x = 294,
			y = 20,
			alpha = 0,
			width = 598,
			height = 55,
	--		titleText = "ifs.missionselect.available"
		},
		
		Text1 = NewIFText { 
			x = 3,
			y = 0,
			halign = "left", valign = "top",
			font = "gamefont_tiny", 
			textw = text_width, 
			texth = 80,
			startdelay=math.random()*0.5, 
			nocreatebackground=1,
			string = "",
		},

		Text2 = NewIFText { 
			x = 3,
			y = 15,
			halign = "left", valign = "top",
			font = "gamefont_tiny", 
			textw = text_width, 
			texth = 80,
			startdelay=math.random()*0.5, 
			nocreatebackground=1,
			string = "",
		},

		Text3 = NewIFText { 
			x = 3,
			y = 30,
			halign = "left", valign = "top",
			font = "gamefont_tiny", 
			textw = text_width, 
			texth = 80,
			startdelay=math.random()*0.5, 
			nocreatebackground=1,
			string = "",
		},		
	}
	
end

function ifs_missionselect_pcMulti_fnAddListboxes(this)
	-- Now, do the boxes above and below the columns
	local ColumnWidthL = 170
	local ColumnWidthC = 200	
	local ColumnWidthR = 220
	local ListHeightC = 170
	
	local listbox_l_offset_y = 240
	local listbox_l_offset_x = 28
	local listbox_c_offset_x = listbox_l_offset_x + ColumnWidthL
	local listbox_r_offset_x = listbox_l_offset_x + ColumnWidthL + ColumnWidthC

	local ColumnWidthOption = 245
	local ColumnHightOption = 210

	local infobox_offset_y = 50 + 5

	local new_shell_offset_x = 240
	
	local maplist_height = 356
	-- map listbox
	this.MapListbox = NewButtonWindow { 
		ZPos = 200, 
		ScreenRelativeX = 0, -- left side of screen
		ScreenRelativeY = 0, -- top
		x = listbox_l_offset_x + new_shell_offset_x - 30,
		y = listbox_l_offset_y + 43,
		width = ColumnWidthL,
		height = maplist_height,
		titleText = "ifs.controls.General.map",
		font = "gamefont_small"
	}

	this.ModeListbox = NewButtonWindow { 
		ZPos = 200, 
		ScreenRelativeX = 0, -- left side of screen
		ScreenRelativeY = 0, -- top
		x = 210 + new_shell_offset_x - 23,
		y = 165 + 25 + 28,
		width = ColumnWidthC,
		height = ListHeightC + 60,
		titleText = "ifs.missionselect.selectmode",
		font = "gamefont_small"
	}

	this.EraListbox = NewButtonWindow { 
		ZPos = 200, 
		ScreenRelativeX = 0, -- left side of screen
		ScreenRelativeY = 0, -- top
		x = 210 + new_shell_offset_x - 23,
		y = 165 + 182 + 37 + 29,
		width = ColumnWidthC,
		height = ListHeightC - 16 - 60,
		titleText = "ifs.missionselect.selectera",
		font = "gamefont_small"
	}

	this.PlayListbox = NewButtonWindow { 
		ZPos = 200, 
		ScreenRelativeX = 0, -- left side of screen
		ScreenRelativeY = 0, -- top
		x = 401 + new_shell_offset_x,
		y = listbox_l_offset_y + 43,
		width = ColumnWidthR,
		height = maplist_height,
		titleText = "ifs.missionselect.playlist",
		font = "gamefont_small"
	}

	this.OptionListbox = NewButtonWindow { 
		ZPos = 200, 
		ScreenRelativeX = 0, -- left side of screen
		ScreenRelativeY = 0, -- top
		x = 123 + 510,
		y = 130 + infobox_offset_y + 5,
		width = ColumnWidthOption - 6,
		height = ColumnHightOption,
	}		

--	this.HostOptionListbox = NewButtonWindow { 
--		ZPos = 200, 
--		ScreenRelativeX = 0, -- left side of screen
--		ScreenRelativeY = 0, -- top
--		x = 123 + this.InfoboxHostOptions.x,
--		y = 130 + this.InfoboxHostOptions.y + 5,
--		width = ColumnWidthOption - 6,
--		height = ColumnHightOption,
--	}		

	ifs_mspc_MapList_layout.width = ColumnWidthL - 24
	ifs_mspc_ModeList_layout.width = ColumnWidthC
	ifs_mspc_PlayList_layout.width = ColumnWidthR - 24
	ifs_mspc_OptionList_layout.width = ColumnWidthOption - 6 - 24
	ifs_mspc_HostOptionList_layout.width = ColumnWidthOption - 6 - 24
	
	-- Create our listboxes
	ListManager_fnInitList(this.MapListbox,ifs_mspc_MapList_layout)
--	ListManager_fnInitList(this.ModeListbox,ifs_mspc_ModeList_layout)
	ListManager_fnInitList(this.PlayListbox,ifs_mspc_PlayList_layout)
	ListManager_fnInitList(this.OptionListbox,ifs_mspc_OptionList_layout)
--	ListManager_fnInitList(this.HostOptionListbox,ifs_mspc_HostOptionList_layout)
end

function ifs_missionselect_pcMulti_fnAddEraBoxes(this)
	custom_AddEraBoxes(this)
	--[[
	-- Now, do the boxes above and below the columns
	local ColumnWidthL = 170
	local ColumnWidthC = 200	
	local ColumnWidthR = 220
	local ListHeightC = 170
	local TopBoxHeight = 30 -- enough for two lines of text
	local infobox_offset_y = 50 + 5
	local infobox_offset_x = -38

	local new_shell_offset_x = 240
	
	local	icon_x = 9
	local	icon_y = 18
	local	icon_height = 18
	local	icon_era_offset_y = 45	

	local era_text_offset_x = 50
	local era_text_offset_y = 15

	local era_check_offset_x = 10
	local era_check_offset_y = 22
	local era_zpos = 180
	
	local era_hotspot_width = 150
	
	-- era: clone war
	this.Era_C_box = NewIFContainer { 		
		ScreenRelativeX = 0, -- left side of screen
		ScreenRelativeY = 0, -- top
		x = ColumnWidthL + infobox_offset_x + new_shell_offset_x - 50,
		y = infobox_offset_y + ListHeightC + TopBoxHeight + icon_era_offset_y, -- top-justify against left box
		ZPos = era_zpos, 
		
		Check_Era = NewIFImage {
--			ZPos = 0, 
			x = era_check_offset_x, y = era_check_offset_y - 2,
			texture = "check_yes",
			localpos_l = 1, localpos_t = 1,
			localpos_r = 14, localpos_b = 14,
			AutoHotspot = 1, tag = "check_era1",
			bIsFlashObj = 1, flash_alpha = 1.0,
			hotspot_width = era_hotspot_width,
		},

		Text_Era = NewIFText { 
			x = era_text_offset_x,
			y = era_text_offset_y,
			halign = "left", valign = "vcenter",
			font = "gamefont_super_tiny", 
			textw = ColumnWidthR - 80, texth = TopBoxHeight,
			startdelay=math.random()*0.5, nocreatebackground=1, 
			string = "common.era.cw",
		},
		
--		Icon1_Era = NewIFImage {
--			ZPos = 240, 
--			localpos_l = icon_x,
--			localpos_r = icon_x + icon_height,
--			localpos_t = icon_y,
--			localpos_b = icon_y + icon_height,
--			ColorR = 240,
--			ColorG = 32,
--			ColorB = 32,
--			texture = "cis_icon", 
--		},
		
		Icon2_Era = NewIFImage {
--			ZPos = 240, 
			localpos_l = icon_x + icon_height,
			localpos_r = icon_x + 2 * icon_height,
			localpos_t = icon_y,
			localpos_b = icon_y + icon_height,
--			ColorR = 32,
--			ColorG = 240,
--			ColorB = 32,
			texture = "rep_icon", 
		}
	}

	this.Era_G_box = NewIFContainer { 
		ScreenRelativeX = 0, -- left side of screen
		ScreenRelativeY = 0, -- top
		x = ColumnWidthL + infobox_offset_x + new_shell_offset_x - 50,
		y = infobox_offset_y + ListHeightC + TopBoxHeight + 13 + icon_era_offset_y, -- top-justify against left box
		ZPos = era_zpos, 
		
		Check_Era = NewIFImage {
--			ZPos = 0, 
			x = era_check_offset_x, y = era_check_offset_y + 20,
			texture = "check_yes",
			localpos_l = 1, localpos_t = 1,
			localpos_r = 14, localpos_b = 14,
			AutoHotspot = 1, tag = "check_era2",
			bIsFlashObj = 1, flash_alpha = 1.0,
			hotspot_width = era_hotspot_width,
		},

		Text_Era = NewIFText { 
			x = era_text_offset_x,
			y = era_text_offset_y + 20,
			halign = "left", valign = "vcenter",
			font = "gamefont_super_tiny", 
			textw = ColumnWidthR - 80, texth = TopBoxHeight,
			startdelay=math.random()*0.5, nocreatebackground=1, 
			string = "common.era.gcw",
		},

--		Icon1_Era = NewIFImage {
--			ZPos = 240, 
--			localpos_l = icon_x,
--			localpos_r = icon_x + icon_height,
--			localpos_t = icon_y + icon_height + 5,
--			localpos_b = icon_y + 2 * icon_height + 5,
--			ColorR = 240,
--			ColorG = 32,
--			ColorB = 32,
--			texture = "imp_icon", 
--		},
		
		Icon2_Era = NewIFImage {
--			ZPos = 240, 
			localpos_l = icon_x + icon_height,
			localpos_r = icon_x + 2 * icon_height,
			localpos_t = icon_y + icon_height + 5,
			localpos_b = icon_y + 2 * icon_height + 5,
--			ColorR = 32,
--			ColorG = 240,
--			ColorB = 32,
			texture = "all_icon", 
		}		
	}--]]
end

mode_list = custom_GetGMapModes()
-- {
	-- {
		-- key = "mode_con", showstr = "modename.name.con", 
		-- descstr = "modename.description.con", subst = "con",
		-- icon = "mode_icon_con",
	-- },
	-- {
		-- key = "mode_ctf", showstr = "modename.name.ctf",
		-- descstr = "modename.description.ctf", subst = "ctf",
		-- icon = "mode_icon_2ctf",
	-- },
	-- {
		-- key = "mode_1flag", showstr = "modename.name.1flag",
		-- descstr = "modename.description.1flag", subst = "1flag",
		-- icon = "mode_icon_ctf",
	-- },
	-- {
		-- key = "mode_assault", showstr = "modename.name.assault",
		-- descstr = "modename.description.assault", subst = "ass",
		-- icon = "mode_icon_ass",
	-- },
	-- {
		-- key = "mode_hunt", showstr = "modename.name.hunt",
		-- descstr = "modename.description.hunt", subst = "hunt",
		-- icon = "mode_icon_hunt",
	-- },		
-- }

function ifs_missionselect_pcMulti_fnAddModeBoxes(this)

	-- Now, do the boxes above and below the columns
	local ColumnWidthL = 170
	local ColumnWidthC = 200	
	local ColumnWidthR = 220
	local ListHeightC = 170
	local TopBoxHeight = 30 -- enough for two lines of text
	local infobox_offset_y = 50 + 5
	local infobox_offset_x = -38

	local new_shell_offset_x = 240
	
	local	icon_x = 27
	local	icon_y = 18
	local	icon_height = 18
	local	icon_era_offset_y = 45	

	local era_text_offset_x = 32 + icon_height
	local era_text_offset_y = 12

	local era_check_offset_x = 10
	local era_check_offset_y = 19
	
	-- if( this == ifs_missionselect ) then
		-- mode_list[6] = 
		-- {
			-- key = "mode_xl", showstr = "modename.name.xl",
			-- descstr = "modename.description.xl", subst = "xl",
			-- icon = "mode_icon_XL",
		-- }
	-- end
	
	this.mode_checkbox = NewIFContainer { --container for all the backgrounds
		ScreenRelativeX = 0, -- left side of screen
		ScreenRelativeY = 0, -- top
		x = ColumnWidthL + infobox_offset_x + new_shell_offset_x - 50,
		y = infobox_offset_y + ListHeightC + TopBoxHeight + icon_era_offset_y - 225, -- top-justify against left box
		ZPos = 180, 
	}
	
	local i
	local Count = table.getn(mode_list)
	for i = 1,Count do
		this.mode_checkbox[i] = NewIFContainer { 		
			--ScreenRelativeX = 0, -- left side of screen
			--ScreenRelativeY = 0, -- top
			--x = ColumnWidthL + infobox_offset_x + new_shell_offset_x - 50,
			y = i * 20, -- top-justify against left box
			--ZPos = 0,
			bChecked = nil,
			key = mode_list[i].key,
			
			checkbox = NewIFImage {
				--ZPos = 0, 
				x = era_check_offset_x, y = era_check_offset_y,
				texture = "check_no",
				localpos_l = 1, localpos_t = 1,
				localpos_r = 14, localpos_b = 14,
				AutoHotspot = 1, tag = "check_mode" .. i,
				bIsFlashObj = 1, flash_alpha = 1.0,
				hotspot_width = 100,
			},

			text= NewIFText { 
				x = era_text_offset_x,
				y = era_text_offset_y,
				halign = "left", valign = "vcenter",
				font = "gamefont_super_tiny", 
				textw = ColumnWidthR - 80, texth = TopBoxHeight,
				startdelay=math.random()*0.5, nocreatebackground=1, 
				orgString = mode_list[i].showstr,
				string = mode_list[i].showstr,
			},
			
			icon = NewIFImage {
				--ZPos = 240, 
				localpos_l = icon_x + 2,
				localpos_r = icon_x + icon_height - 2,
				localpos_t = icon_y + 2,
				localpos_b = icon_y + icon_height - 2,
				--ColorR = 240,
				--ColorG = 32,
				--ColorB = 32,
				orgTexture = mode_list[i].icon, 
				texture = mode_list[i].icon, 
			},			
		}
	end
end

function ifs_missionselect_pcMulti_fnAddMapButtons(this)
	
	local map_buttons_offset_y = 25
	local up_btn_width = 20
	local new_shell_offset_x = 240
	
	local BackButtonH = ScriptCB_GetFontHeight("gamefont_medium")

	this.map_buttons =	NewIFContainer
	{
		ScreenRelativeX = 0,
		ScreenRelativeY = 0,
		x = 375 + new_shell_offset_x,
		y = 450,

		select_btn = NewPCIFButton
		{
			x = -375,
			y = map_buttons_offset_y,
			btnw = 150, -- made wider to fix 9173 - NM 8/25/04
			btnh = BackButtonH,
			font = "gamefont_small",
			string = "ifs.mp.create.selectall",
			tag = "_select_all",
		}, -- end of btn
		
		add_btn = NewPCIFButton
		{
			x = -185,
			y = map_buttons_offset_y,
			btnw = 150, -- made wider to fix 9173 - NM 8/25/04
			btnh = BackButtonH,
			font = "gamefont_small",
			string = "ifs.mp.create.addmaps",
			tag = "_map_add",
			--hotspot_y = 16,
			--hotspot_width = 168,
		}, -- end of btn

		launch_btn = NewPCIFButton -- NewRoundIFButton
		{
			x = -185,
			y = map_buttons_offset_y * 2,
			btnw = 150, -- made wider to fix 9173 - NM 8/25/04
			btnh = BackButtonH,
			font = "gamefont_small",
			string = "ifs.onlinelobby.launchsession",
			tag = "Launch",
			--hotspot_y = 16,
			--hotspot_width = 168,
		}, -- end of btn
		
		remove_btn = NewPCIFButton -- NewRoundIFButton
		{
			y = map_buttons_offset_y,
			btnw = 130, -- made wider to fix 9173 - NM 8/25/04
			btnh = BackButtonH,
			font = "gamefont_small",
			string = "ifs.mp.create.remove",
			tag = "_map_remove",			
		}, -- end of btn

		up_btn = NewIFImage {
			x = 80, y = map_buttons_offset_y - 10,
			texture = "window_arrow_solo",
			localpos_l = 0, localpos_t = 0,
			localpos_r = up_btn_width, localpos_b = up_btn_width,
			AutoHotspot = 1, tag = "_up_btn",
			bIsFlashObj = 1, flash_alpha = 1.0,
		},

		down_btn = NewIFImage {
			x = 105, y = map_buttons_offset_y - 10,
			texture = "window_arrow_solo",
			localpos_l = 0, localpos_t = up_btn_width,
			localpos_r = up_btn_width, localpos_b = 0,
			AutoHotspot = 1, tag = "_down_btn",
			bIsFlashObj = 1, flash_alpha = 1.0,
		},

		remove_all_btn = NewPCIFButton -- NewRoundIFButton
		{
			x = 30,
			y = map_buttons_offset_y * 2,
			btnw = 190, -- made wider to fix 9173 - NM 8/25/04
			btnh = BackButtonH,
			font = "gamefont_small",
			string = "ifs.mp.create.remove_all",
			tag = "_map_remove_all",
		}, -- end of btn		
	}
	--this.map_buttons.add_btn.label.halign = "hcenter"
	this.map_buttons.remove_btn.label.halign = "hcenter"
	this.map_buttons.remove_all_btn.label.halign = "hcenter"
	--RoundIFButtonLabel_fnSetString( this.map_buttons.add_btn, "ifs.mp.create.add" )
	--RoundIFButtonLabel_fnSetString( this.map_buttons.add_btn, "Add Maps Add Maps Add Maps" )
	--RoundIFButtonLabel_fnSetString( this.map_buttons.remove_btn, "ifs.mp.create.remove" )
	--RoundIFButtonLabel_fnSetString( this.map_buttons.remove_all_btn, "ifs.mp.create.remove_all" )
end

function ifs_missionselect_pcMulti_fnBuildScreen(this)
	local w,h = ScriptCB_GetSafeScreenInfo() -- of the usable screen
	
	-- add pc profile & title version text
	AddPCTitleText( this )
	
	gPickedMapList = {}

	local ListEntryHeight = (pc_missionselect_name_listboxL_layout.yHeight + pc_missionselect_name_listboxL_layout.ySpacing)	
	
	pc_missionselect_name_listboxL_layout.width = (w * 0.48) - 35
	pc_missionselect_name_listboxR_layout.width = (w * 0.48) - 35

	
	pc_missionselect_name_listboxL_layout.showcount = 3 --math.min(16,math.max(4, math.floor((h - 160) / ListEntryHeight)))
	pc_missionselect_name_listboxR_layout.showcount = 3
	
--	pc_missionselect_name_listboxL_layout.showcount = math.min(16,math.max(4, math.floor((h - 160) / ListEntryHeight)))
--	pc_missionselect_name_listboxR_layout.showcount = pc_missionselect_name_listboxL_layout.showcount - 2

	local ListHeightR = pc_missionselect_name_listboxR_layout.showcount * ListEntryHeight + 30
	local ListHeightL = pc_missionselect_name_listboxL_layout.showcount * ListEntryHeight + 30

	-- set gamespy icon's position
	local 	gamespy_icon_y = 30
	local	login_as_y = 0
	local	login_as_x = 0
	
	-- new shell offset
	local new_shell_offset_x = 0
	if(USING_NEW_PC_SHELL) then
		new_shell_offset_x = 240
		
		gamespy_icon_y = 567
		
		login_as_x = -35
		login_as_y = 505
	end

	local	player_name_y = 2
	-- player name text	
	this.ProfileNameText = NewIFText {
		string = "ifs.mp.join.profile_name",
		font = "gamefont_small",
		y = player_name_y,
		textw = 400,
		halign = "right",
		ScreenRelativeX = 0, -- center
		ScreenRelativeY = 0, -- top
		nocreatebackground = 1,
	}
		
	local	source_y = 30
	
	if( not USING_NEW_PC_SHELL ) then
		-- source text	
		this.SourceText = NewIFText {
			string = "ifs.mp.join.source",
			font = "gamefont_small",
			y = source_y,
			textw = 200,
			halign = "right",
			ScreenRelativeX = -0.22, -- center
			ScreenRelativeY = 0, -- top
			nocreatebackground = 1,
		}
	end

	--local ListHeightL = ListHeightR -- * 1.5

--	this.listboxL = NewButtonWindow { 
--		ZPos = 200, 
--		x = pc_missionselect_name_listboxL_layout.width * 0.5 + 30 - w*0.5, 
--		y = 230,
--		ScreenRelativeX = 0.5, -- center of screen
--		ScreenRelativeY = 0.5, -- middle, vertically
--		width = pc_missionselect_name_listboxL_layout.width + 35,
--		height = ListHeightL,
--		rotY = 0,
--		titleText = "ifs.missionselect.available"
--	}

--	this.listboxR = NewButtonWindow { 
--		ZPos = 200, 
--		x = -(pc_missionselect_name_listboxR_layout.width * 0.5+30) + w*0.5, 
--		y = 230,
--		ScreenRelativeX = 0.5, -- center of screen
--		ScreenRelativeY = 0.5, -- middle, vertically
--		width = pc_missionselect_name_listboxR_layout.width + 35,
--		height = ListHeightR,
--		rotY = 0,
--		titleText = "ifs.missionselect.selected"
--	}

	this.buttons = NewIFContainer {
		ScreenRelativeX = 0.25,
		ScreenRelativeY = 0.5,
	}

	local MapRadius = 50
	
	-- this isn't actually shown anymore...
	this.Map = NewIFMapPreview {
		ScreenRelativeX = 0.0,
		ScreenRelativeY = 0.0,
		x = w * 0.5, y = 35 + ListHeightR + MapRadius,
		width = MapRadius,
	}
	
	this.OrderButton = NewClickableIFButton {
		ScreenRelativeX = 0.5,
		ScreenRelativeY = 0.5,
--		rotY = this.listboxR.rotY,
--		x = this.listboxR.x + 23,
--		y = this.listboxR.height / 2 - 19,
--		btnw = this.listboxR.width,
		btnh = ScriptCB_GetFontHeight("gamefont_small"),
		font = "gamefont_small", 
		tag = "Order",
		string = "ifs.missionselect.inorder",
	}

--	this.LaunchButton = NewClickableIFButton {
--		ScreenRelativeX = 1.0,
--		ScreenRelativeY = 1.0,
--		x = -670,
--		y = -75,
--		btnw = 150, -- bumped from 100->150 NM 8/25/04 for bug 9174
--		btnh = 2 * ScriptCB_GetFontHeight("gamefont_medium"),
--		font = "gamefont_medium", 
--		tag = "Launch",
--		--nocreatebackground = 1,
--		string = "ifs.onlinelobby.launchsession",
--		--string = "Launch Session",
--		halign = "hcenter",
--		bStyleTabbed = 1,
--		bg_width = 100,
--	}

--	this.OptionButton = NewRoundIFButton 
--	{
--		ScreenRelativeX = 0.1,
--		ScreenRelativeY = 0.9,
--		rotY = 0,
--		y = -15,
--		btnw = w * 0.44,
--		btnh = ScriptCB_GetFontHeight("gamefont_tiny"),
--		font = "gamefont_tiny",
--		nocreatebackground = 1,
--	}
--	--this.OptionButton.x =  -- 1 - half of btnw's 36% of screen
--	this.OptionButton.label.halign = "hcenter"
--	this.OptionButton.label.valign = "vcenter"
--	this.OptionButton.label.ColorR = 255
--	this.OptionButton.label.ColorG = 255
--	this.OptionButton.label.ColorB = 255
--	this.OptionButton.font = nil
--	this.OptionButton.label.bHotspot = 1
--	this.OptionButton.label.fHotspotW = this.OptionButton.btnw
--	this.OptionButton.label.fHotspotH = this.OptionButton.btnh
--	this.OptionButton.tag = "Option"
--	RoundIFButtonLabel_fnSetString(this.OptionButton,"ifs.missionselect.serveroptions")
	
	local EditBoxW = w * 0.47
	local TextFont = "gamefont_small"
	local EditBoxFont = "gamefont_small"
	local EditBoxH = ScriptCB_GetFontHeight(EditBoxFont) + 2
	
	local egt = "ifs.mp.sessionlist.gamename"
	-- this is dodgy
	if(gLangStr == "spanish") then
		egt = "ifs.mp.create.entername"
	end

	this.EditContainer = NewIFContainer {
		ScreenRelativeX = 0.84,
		ScreenRelativeY = 0.032,
		rotY = 0,
		y = 0,		
		
		EditGameText = NewIFText {
			halign = "right", valign = "vcenter",
			x = -EditBoxW * 1.45,
			y = 12,
			font = TextFont, 
			textw = EditBoxW, texth = EditBoxH,
			flashy = 0,
			string = "ifs.mp.create.session_name",
		},
		EditGameName = NewEditbox {			
			width = EditBoxW - 50,
			height = EditBoxH,
			y = EditBoxH + 5,
			font = EditBoxFont,
			MaxChars = 20,
			MaxLen = EditBoxW - 40,
		},
	}

	this.EditPwdContainer = NewIFContainer {
		ScreenRelativeX = 0.84,
		ScreenRelativeY = 0.07,
		rotY = 0,
		y = 0,
		EditPassText = NewIFText {
			x = -EditBoxW * 1.45,
			y =  12,
			halign = "right", valign = "vcenter",
			font = TextFont, 
			textw = EditBoxW, texth = EditBoxH,
			flashy = 0,
			string = "ifs.gsprofile.password",
		},
		EditPass = NewEditbox {
			width = EditBoxW - 50,
			height = EditBoxH,
			y = EditBoxH + 5,
			font = EditBoxFont,
			MaxChars = 10,
			bPasswordMode = 1,
			MaxLen = EditBoxW - 40,
		},
	}
	
	--this.EditContainer.EditGameName.x = EditBoxW * 0.5
	--this.EditContainer.EditPass.x = EditBoxW * 0.25
	
	--size the background
	-- local wScreen,hScreen,vScreen,widescreen = ScriptCB_GetScreenInfo()
-- -- 	this.backImg.localpos_r = wScreen*widescreen
-- -- 	this.backImg.localpos_b = hScreen
-- -- 	this.backImg.uvs_b = vScreen
	-- -- calc the position of the movie preview window
	-- this.movieW = 510.0
	-- this.movieH = 400.0
	-- this.movieX = wScreen - 600.0
	-- this.movieY = hScreen - this.movieH + 100.0 
	
	custom_SetMovieLocation(this)
	
	-- Also, add buttons
	--this.CurButton = AddVerticalButtons(this.buttons,ifs_era_vbutton_layout)

--	ListManager_fnInitList(this.listboxL,pc_missionselect_name_listboxL_layout)
--	ListManager_fnInitList(this.listboxR,pc_missionselect_name_listboxR_layout)

	local AddDelButtonW = 40
	local AddDelButtonYSpace = 5
	local AddDelButtonH = 20

	this.AddDelContainer =	NewIFContainer {
		ScreenRelativeX = 0.5, -- center
		ScreenRelativeY = 0.5, -- center
		y = 0,
		x = 0,

		--add the left/right arrows
		add = NewIFImage 
		{
			y = -(AddDelButtonH + AddDelButtonYSpace),
			x = 1,
			btnw = AddDelButtonW, 
			btnh = AddDelButtonH,
			tag = "_add",
			localpos_l = -AddDelButtonW/2, localpos_t = -AddDelButtonH/2,
			localpos_r =  AddDelButtonW/2, localpos_b =  AddDelButtonH/2,
			texture = "small_arrow",
		},
		del = NewIFImage 
		{
			y = (AddDelButtonH + AddDelButtonYSpace),
			x = 0,
			btnw = AddDelButtonW, 
			btnh = AddDelButtonH,
			tag = "_del",
			localpos_l =  AddDelButtonW/2, localpos_t = -AddDelButtonH/2,
			localpos_r = -AddDelButtonW/2, localpos_b =  AddDelButtonH/2,
			texture = "small_arrow",
		},
	} -- end of button container
	this.AddDelContainer.add.bHotspot = 1
	this.AddDelContainer.add.fHotspotW = AddDelButtonW
	this.AddDelContainer.add.fHotspotH = AddDelButtonH + 8
	this.AddDelContainer.add.fHotspotX = -AddDelButtonW/2
	this.AddDelContainer.add.fHotspotY = -AddDelButtonH/2 - 4
	this.AddDelContainer.del.bHotspot = 1
	this.AddDelContainer.del.fHotspotW = AddDelButtonW
	this.AddDelContainer.del.fHotspotH = AddDelButtonH + 8
	this.AddDelContainer.del.fHotspotX = -AddDelButtonW/2
	this.AddDelContainer.del.fHotspotY = -AddDelButtonH/2 - 4

	---------------------------------------------------
	this.iColumn = 0
	this.iMap = 0
	-- this.bEra_CloneWar = 1
	-- this.bEra_Galactic = 1
	
	custom_SetEraBooleans(this, nil)
	
	this.iLastClickTime = nil
	this.bDoubleClicked = nil

	-- Now, do the boxes above and below the columns
	local ColumnWidthL = 170
	local ColumnWidthC = 200	
	local ColumnWidthR = 220
	local TopBoxHeight = 30 -- enough for two lines of text
	local infobox_offset_x = -38
	local infobox_offset_y = 50 + 5
	
	local ListHeightC = 170
	
--	this.InfoboxTL = NewIFContainer { 
--		ScreenRelativeX = 0, -- left side of screen
--		ScreenRelativeY = 0, -- top
--		x = infobox_offset_x + new_shell_offset_x,
--		y = infobox_offset_y, -- top-justify against left box
--
--		bg = NewIFImage {
--			ZPos = 240, 
--			localpos_l = 4,
--			localpos_r = ColumnWidthL + ColumnWidthC + 2,
--			localpos_b = TopBoxHeight,
--			texture = "white_rect",
--			ColorR = 128,
--			ColorG = 128,
--			ColorB = 128,
--		},
--
--		Text1 = NewIFText { 
--			x = 10,
--			y = TopBoxHeight * 0.25 - 10,
--			halign = "left", valign = "top",
--			font = "gamefont_small", 
--			textw = ColumnWidthL + ColumnWidthC, texth = TopBoxHeight * 0.5,
--			startdelay=math.random()*0.5, nocreatebackground=1, 
--			ColorR = 0,
--			ColorG = 0,
--			ColorB = 0,
--			string = "",
--		},
--
--		Text2 = NewIFText { 
--			x = 10,
--			y = TopBoxHeight * 0.75 - 10,
--			halign = "left", valign = "top",
--			font = "gamefont_small", 
--			textw = ColumnWidthL + ColumnWidthC, texth = TopBoxHeight * 0.5,
--			startdelay=math.random()*0.5, nocreatebackground=1, 
--			ColorR = 0,
--			ColorG = 0,
--			ColorB = 0,
--			string = "ifs.missionselect.selectplanet",
--		},
--	}

--	this.InfoboxTR = NewIFContainer { 
--		ScreenRelativeX = 0, -- left side of screen
--		ScreenRelativeY = 0, -- top
--		x = ColumnWidthL + ColumnWidthC + infobox_offset_x + new_shell_offset_x,
--		y = infobox_offset_y, -- top-justify against left box
--
--		bg = NewIFImage {
--			ZPos = 240, 
--			localpos_l = 4,
--			localpos_r = ColumnWidthR + 3,
--			localpos_b = TopBoxHeight,
--			texture = "white_rect",
--			ColorR = 128,
--			ColorG = 128,
--			ColorB = 128,
--		},
--
--		Text1 = NewIFText { 
--			x = 10,
--			y = 5,
--			halign = "left", valign = "vcenter",
--			font = "gamefont_small", 
--			textw = ColumnWidthR, texth = TopBoxHeight,
--			startdelay=math.random()*0.5, nocreatebackground=1, 
--			ColorR = 0,
--			ColorG = 0,
--			ColorB = 0,
--			string = "ifs.missionselect.playlist",
--		},
--	}

	local ColumnWidthOption = 245
	local ColumnHightOption = 210
--	this.InfoboxOptions = NewIFContainer { 
--		ScreenRelativeX = 0, -- left side of screen
--		ScreenRelativeY = 0, -- top
--		x = 510,
--		y = infobox_offset_y, -- top-justify against left box
--
--		bg = NewIFImage {
--			ZPos = 240, 
--			localpos_l = 4,
--			localpos_r = ColumnWidthOption - 2,
--			localpos_b = TopBoxHeight,
--			texture = "white_rect",
--			ColorR = 128,
--			ColorG = 128,
--			ColorB = 128,
--		},
--
--		Text1 = NewIFText { 
--			x = 10,
--			y = 5,
--			halign = "left", valign = "vcenter",
--			font = "gamefont_small", 
--			textw = ColumnWidthR, texth = TopBoxHeight,
--			startdelay=math.random()*0.5, nocreatebackground=1, 
--			ColorR = 0,
--			ColorG = 0,
--			ColorB = 0,
--			string = "ifs.mp.create.options",
--		},
--	}

--	this.InfoboxHostOptions = NewIFContainer { 
--		ScreenRelativeX = 0, -- left side of screen
--		ScreenRelativeY = 0, -- top
--		x = 510,
--		y = 298, -- top-justify against left box
--
--		bg = NewIFImage {
--			ZPos = 240, 
--			localpos_l = 4,
--			localpos_r = ColumnWidthOption - 2,
--			localpos_b = TopBoxHeight,
--			texture = "white_rect",
--			ColorR = 128,
--			ColorG = 128,
--			ColorB = 128,
--		},
--
--		Text1 = NewIFText { 
--			x = 10,
--			y = 5,
--			halign = "left", valign = "vcenter",
--			font = "gamefont_small", 
--			textw = ColumnWidthR, texth = TopBoxHeight,
--			startdelay=math.random()*0.5, nocreatebackground=1, 
--			ColorR = 0,
--			ColorG = 0,
--			ColorB = 0,
--			string = "ifs.mp.create.host_opt",
--		},
--	}

	local era_text_offset_x = 26
	local era_text_offset_y = 15

	local era_check_offset_x = 7
	local era_check_offset_y = 22
	
--	this.Erabox = NewIFContainer { 
--		ScreenRelativeX = 0, -- left side of screen
--		ScreenRelativeY = 0, -- top
--		x = ColumnWidthL + infobox_offset_x + new_shell_offset_x - 50,
--		y = infobox_offset_y + ListHeightC + TopBoxHeight + 20, -- top-justify against left box
--
--		bg = NewIFImage {
--			ZPos = 240, 
--			localpos_l = 4,
--			localpos_r = ColumnWidthC + 4,
--			localpos_b = 150,
--			texture = "white_rect",
--			ColorR = 128,
--			ColorG = 128,
--			ColorB = 128,
--		},
--
--		Text1 = NewIFText { 
--			x = 10,
--			y = 0,
--			halign = "left", valign = "vcenter",
--			font = "gamefont_small", 
--			textw = ColumnWidthR, texth = TopBoxHeight,
--			startdelay=math.random()*0.5, nocreatebackground=1, 
--			ColorR = 0,
--			ColorG = 0,
--			ColorB = 0,
--			string = "ifs.missionselect.selectera",
--		},
--	}
			
	-- move button position
	local launch_button_y = 15
	if( not USING_NEW_PC_SHELL ) then
		this.Helptext_Back.y = launch_button_y
	end
--	this.LaunchButton.y = launch_button_y
--	this.OptionButton.y = launch_button_y
	
	-- change tabs layout for setting
	ifs_missionselect_pcMulti_fnChangeSettingTabsLayout( this )
	
	if(gPlatformStr == "PC") then
		-- Add tabs to screen
		ifelem_tabmanager_Create(this, gPCMainTabsLayout, gPCMultiPlayerTabsLayout, gPCMultiPlayerSettingsTabsLayout)
	end
	
	-- add option buttons
	ifs_missionselect_pcMulti_fnAddOptionButtons( this )
	
	-- add source listbox
	ifs_mp_sessionlist_fnAddSourceList( this )
	
	-- add infobox
	ifs_missionselect_pcMulti_fnAddInfoBox( this )
	
	-- add listboxes
	ifs_missionselect_pcMulti_fnAddListboxes( this )
	
	-- add era boxes
	ifs_missionselect_pcMulti_fnAddEraBoxes(this)
	
	-- add map buttons
	ifs_missionselect_pcMulti_fnAddMapButtons(this)
	
	-- add mode boxes
	ifs_missionselect_pcMulti_fnAddModeBoxes( this )
	
	-- add gamespy logo & login
	ifs_mp_sessionlist_fnAddGamespyLogin( this )
	
	custom_AddCheatBox(this)
end

ifs_missionselect_pcMulti_fnBuildScreen(ifs_missionselect_pcMulti)
ifs_missionselect_pcMulti_fnBuildScreen = nil -- dump out of memory to save

AddIFScreen(ifs_missionselect_pcMulti,"ifs_missionselect_pcMulti")

print("Lets go Brandon! Why no movie?")