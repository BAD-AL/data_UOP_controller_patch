------------------------------------------------------------------
-- uop recovered source
-- by Anakain
------------------------------------------------------------------

--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- Generalized mission select screen. Done to unify the varions
-- screens 

-- Well, until someone decided to fork things for the PC. - NM 11/3/04


-- Internal set of pages:
-- this.iPage == 0   -> 2-column mode (this.bOnLeft is a flag for listbox, this.bOnButtons)
-- this.iPage == 1   -> Pick era buttons
-- 
-- Flow goes 0 -> 1 -> 2 -> 0 for maps w/ 4 luas, or 0 -> 2 -> 0 for
-- maps w/ only 1 lua

-- The built-up list of maps is put in gPickedMaplist, which has
-- entries in the following form:
--
-- gPickedMapList = {
--   { Map = "nab1c", Side = 1, SideChar = "r" },
--   { ... }
-- }

local USING_NEW_PC_SHELL = 1

function ifs_missionselect_fnUsingNewShell( this )
	ifs_missionselect_pcMulti_fnUsingNewShell(this)
end

-- Pull in list of missions.
--ScriptCB_DoFile("missionlist")

-- Helper function. Given a layout (x,y,width, height), returns a
-- fully-built item.
function MissionSelectListboxL_CreateItem(layout)
	return pcMissionSelectListboxL_CreateItem(layout)
end

-- Helper function. Given a layout (x,y,width, height), returns a
-- fully-built item.
function MissionSelectListboxR_CreateItem(layout)
	return pcMissionSelectListboxR_CreateItem(layout)
end

-- Helper function. For a destination item (previously created w/
-- CreateItem), fills it in with data, which may be nil (==blank it)
function MissionSelectListboxL_PopulateItem(Dest,Data)
	pcMissionSelectListboxL_PopulateItem(Dest, Data)
end

-- Helper function. For a destination item (previously created w/
-- CreateItem), fills it in with data, which may be nil (==blank it)
function MissionSelectListboxR_PopulateItem(Dest,Data)
	pcMissionSelectListboxR_PopulateItem(Dest, Data)
end

missionselect_name_listboxL_layout = {
	showcount = 10,
--	yTop = -130 + 13, -- auto-calc'd now
	yHeight = 23,
	ySpacing  = 0,
--	width = 260,
	x = 0,
	slider = 1,
	CreateFn = MissionSelectListboxL_CreateItem,
	PopulateFn = MissionSelectListboxL_PopulateItem,
}

missionselect_name_listboxR_layout = {
	showcount = 7,
--	yTop = -130 + 13, -- auto-calc'd now
	yHeight = 26,
	ySpacing  = 0,
--	width = 260,
	x = 0,
	slider = 1,
	CreateFn = MissionSelectListboxR_CreateItem,
	PopulateFn = MissionSelectListboxR_PopulateItem,
}

function ifs_missionselect_fnShowHideListboxes(this,bShowThem)
	ifs_missionselect_pcMulti_fnShowHideListboxes(this, bShowThem)
end

function ifs_missionselect_fnFullPopupDone()
	ifs_missionselect_pcMulti_fnFullPopupDone()
end


-- Flips map order
function ifs_missionselect_fnToggleOrder(this)
	ifs_missionselect_pcMulti_fnToggleOrder(this)
end

-- Sets up the map preview based on the current selection
function ifs_missionselect_fnSetMapPreview(this)
	ifs_missionselect_pcMulti_fnSetMapPreview(this)
end

-- Helper function, manages the state of the 'Delete' button
function ifs_missionselect_fnUpdateDelButton(this)
	ifs_missionselect_pcMulti_fnUpdateDelButton(this)
end

-- Sets the current button to the specified table (which can be nil)
function ifs_missionselect_fnSetCurButton(this,tNewButton,ButtonStr)
--	print("ifs_missionselect_fnSetCurButton(..,", tNewButton,ButtonStr)
	-- Always deselect old button if set
	if(gCurHiliteButton) then
		IFButton_fnSelect(gCurHiliteButton,nil)
	end

	if(tNewButton) then
		this.CurButton = ButtonStr
		this.bOnButtons = 1
		gCurHiliteButton = tNewButton
		IFButton_fnSelect(gCurHiliteButton,1)
		missionselect_name_listboxR_layout.CursorIdx = nil
		missionselect_name_listboxL_layout.CursorIdx = nil
		--ListManager_fnFillContents(this.listboxR,gPickedMapList,missionselect_name_listboxR_layout)
		--ListManager_fnFillContents(this.listboxL,missionselect_listbox_contents,missionselect_name_listboxL_layout)
	else
		this.bOnButtons = nil
		gCurHiliteButton = nil
	end

--	print("fnSetCurButton, New=",tNewButton," Cur=",this.CurButton)
end

-- Sets up the screen for the specified page
function ifs_missionselect_fnSetPage(this,iNewPage)
	ifs_missionselect_pcMulti_fnSetPage(this, iNewPage)
end

-- Adds the currently selected map to the maplist.
function ifs_missionselect_fnAddMap(this)
	ifs_missionselect_pcMulti_fnAddMap(this)
end

-- Utility function - based on the .hidden flag in buttons (already
-- created), shows/hides buttons. Adjusts spacing too. Returns tag of
-- first selectable button.
function ifs_missionselect_fnShowHideItems(dest,layout)
	return ifs_missionselect_pcMulti_fnShowHideItems(dest, layout)
end

-- Tthe side selection is implicit in the selection here, except for
-- the maps that only have one side, and you have to go back around
-- and handle them as special cases. 
function ifs_missionselect_fnSetMapAndTeam(this,Selection,Team1Str,Team2Str)
	ifs_missionselect_pcMulti_fnSetMapAndTeam(this, Selection, Team1Str, Team2Str)
end

function ifs_missionselect_fnFlipLeftRight(this)
	ifelm_shellscreen_fnPlaySound(this.selectSound)
	this.bOnLeft = not this.bOnLeft

	if(this.bOnLeft) then
		missionselect_name_listboxR_layout.CursorIdx = nil
		--ListManager_fnFillContents(this.listboxR,gPickedMapList,missionselect_name_listboxR_layout)
		missionselect_name_listboxL_layout.CursorIdx = missionselect_name_listboxL_layout.SelectedIdx
		--ListManager_fnFillContents(this.listboxL,missionselect_listbox_contents,missionselect_name_listboxL_layout)
	else
		-- On the right side
		missionselect_name_listboxL_layout.CursorIdx = nil
		--ListManager_fnFillContents(this.listboxL,missionselect_listbox_contents,missionselect_name_listboxL_layout)
		missionselect_name_listboxR_layout.CursorIdx = missionselect_name_listboxR_layout.SelectedIdx
		--ListManager_fnFillContents(this.listboxR,gPickedMapList,missionselect_name_listboxR_layout)
	end
--	ifs_missionselect_fnSetMapPreview(this)
	ifs_missionselect_fnUpdateDelButton(this)
end

-- Helper function - returns a bool as to whether the selection has
-- multiple sides, and also the char of the last (only?) side noticed.
function ifs_missionselect_fnGetSides(Selection)
	return ifs_missionselect_pcMulti_fnGetSides(Selection)
end

function ifs_missionselect_fnLaunch(this)
	if(table.getn(gPickedMapList) > 0) then
		this.SelectedMap = 1
		ScriptCB_SetMissionNames(gPickedMapList,this.bRandomOrder)
		this.fnDone()
	else
		ifelm_shellscreen_fnPlaySound(this.errorSound)
	end
end

-- pass the name of the downloadable content movie file to open it, or nil to open
-- the normal DVD flythrough movie file.
function ifs_missionselect_ChangeMovieFile(movieFile)
	ifs_missionselect_pcMulti_ChangeMovieFile(movieFile, true)	
end

ifs_missionselect = NewIFShellScreen {
	nologo = 1,
	--bg_texture = "iface_bgmeta_space",
	movieBackground = "shell_main", 
	bNohelptext_backPC = 1,
	
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

	fnDone = nil, -- Callback function to do something when the user is done
	-- Sub-mode for full/era switch is on.
	EraMode = nil,
	
	Enter = function(this, bFwd)
	
		-- hide cheat bit
		IFObj_fnSetVis( this.cheatOutput, nil )
		
		-- tabs	
		if(gPlatformStr == "PC") then
			
			-- clear multiplayer flag
			if( ifs_main ) then
				ifs_main.option_mp = nil
			end
			
			-- dim host option button
			ifs_missionselect_pcMulti_fnShowHostOptionButton(this, true)
			--if( this.option_buttons and this.option_buttons.host_btn ) then
			--	this.option_buttons.host_btn.bDimmed = 1
			--	IFObj_fnSetAlpha(this.option_buttons.host_btn,0.2)
			--	IFObj_fnSetAlpha(this.option_buttons.host_btn.label,0.2)
			--end
			
			-- using new shell
			ifs_missionselect_fnUsingNewShell( this )
			
			-- set pc profile & title version text
			UpdatePCTitleText(this)
			
			ifelem_tabmanager_SetSelected(this, gPCMainTabsLayout, "_tab_single")
			ifelem_tabmanager_SetSelected(this, gPCSinglePlayerTabsLayout, "_tab_instant", 1)
			ifelem_tabmanager_SetSelected(this, gPCMultiPlayerSettingsTabsLayout, "_opt_playlist", 2)

			-- single player settings
			ifs_sp.bForSplitScreen = nil
			ScriptCB_SetSplitscreen( nil )
			ScriptCB_CancelLogin()
			ScriptCB_CloseNetShell(1)
			ScriptCB_SetInNetGame( nil )

			if(bFwd) then
				ifs_missionselect.fnDone = ifs_instant_fnSelectDone
				ifs_missionselect.fnCancel = ifs_instant_fnSelectCancel
				ifs_missionselect.bForMP = nil
				ScriptCB_SetGameRules("instantaction")
			end
		end

		gIFShellScreenTemplate_fnEnter(this, bFwd) -- call base class

		-- stop the current movie
		ifelem_shellscreen_fnStopMovie()
				
		if(this.bForMP == 1) then
--			print("Moving stuff down for multiplayer PC")
			
			-- Sets the position. Pass nil for either arg to use current value instead
			--IFObj_fnSetPos(this.listboxL,this.listboxL.x,200,this.listboxL.z)
			--IFObj_fnSetPos(this.listboxR,this.listboxR.x,200,this.listboxR.z)
		end		

		-- init double click
		this.bDoubleClicked = nil

		-- Determine how many missions can be queued.
		this.iMaxMissions = ScriptCB_GetMaxMissionQueue()

		-- Added chunk for error handling...
		if(not bFwd) then
			local ErrorLevel,ErrorMessage = ScriptCB_GetError()
			if(ErrorLevel >= 6) then -- session or login error, must keep going further
				ScriptCB_PopScreen()
			end
		end

		if(bFwd) then
			this.bForMp = false
			missionlist_ExpandMaplist(false) -- TODO: filter era/mode here
			--gPickedMapList = {}
			this.movieTime = 0.5

			--RoundIFButtonLabel_fnSetString(this.LaunchButton,"ifs.onlinelobby.launch")
--			gIFShellScreenTemplate_fnMoveClickableButton(this.LaunchButton,this.LaunchButton.label,0)
	
			this.iPage = 2
			ifs_missionselect_fnSetPage(this,0) -- default internal mode.
			this.buttons.fStartAlpha = 0
			this.buttons.fEndAlpha = 0
			IFObj_fnSetAlpha(this.buttons,0)
			ifs_missionselect_fnToggleOrder(this)
			ifs_missionselect_fnToggleOrder(this)

			--IFObj_fnSetAlpha(this.Helptext_Delete,0.25)
			IFButton_fnSelect(this.OrderButton,nil)
			--IFButton_fnSelect(this.LaunchButton,nil)

			this.SelectedMap = nil -- clear this
			--gPickedMapList = {} -- clear this also.
			missionselect_name_listboxR_layout.FirstShownIdx = 1
			missionselect_name_listboxR_layout.SelectedIdx = 1
			missionselect_name_listboxR_layout.CursorIdx = nil
			--ListManager_fnFillContents(this.listboxR,gPickedMapList,missionselect_name_listboxR_layout)

			-- Reset listboxL, show it. [Remember, Lua starts at 1!]
			missionselect_name_listboxL_layout.FirstShownIdx = 1
			missionselect_name_listboxL_layout.SelectedIdx = 1
			missionselect_name_listboxL_layout.CursorIdx = 1
			--ListManager_fnFillContents(this.listboxL,missionselect_listbox_contents,missionselect_name_listboxL_layout)

			ifs_missionselect_fnSetMapPreview(this)

			ifs_missionselect_fnSetCurButton(this,nil)

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

			-- Hack - if just 1 map, fake a button press thru to second part
			if(table.getn(missionselect_listbox_contents) == 1) then
				this:Input_Accept()
			end
		else
			ScriptCB_PopScreen()
		end
		
		-- hide some old stuff
		IFObj_fnSetVis( this.AddDelContainer, nil )
		--IFObj_fnSetVis( this.listboxR, nil )
		--IFObj_fnSetVis( this.listboxL, nil )
		IFObj_fnSetVis( this.OrderButton, nil )
		
		-- init Mode and Era checkbox
		-- ifs_missionselect_pcMulti_fnInitModeEra( this )		
	end,

	Exit = function(this, bFwd)
		if(not bFwd) then
			ifs_missionselect_fnSetPage(this,0) -- default internal mode.
			this.SelectedMap = nil -- clear this
		end
		-- stop the current movie
		ifelem_shellscreen_fnStopMovie()
	end,
	
	Update = function(this, fDt)
		-- Call base class functionality
		gIFShellScreenTemplate_fnUpdate(this, fDt)
		
		--time to change movies?
		custom_CheckChangeMovies(this, fDt)
		
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
		if(gCurEditbox) then
			if(gCurEditbox == this.cheatBox) then
				if((iKey == 10) or (iKey == 13)) then -- handle Enter differently
					local str = IFEditbox_fnGetString(gCurEditbox)
					local retVal = nil
					
					-- special case - campaign list
					if(str == "456123") then
						retVal = "cheats.levels_on"
						ifelm_shellscreen_fnPlaySound(this.acceptSound)
						if(ifs_sp_campaign) then
							ifs_sp_campaign.showCampaignList = true
						end
					else
						retVal = custom_ExtraCheats(str)
						if not retVal then
							retVal = ScriptCB_MrMrsEval(str)
						end
					end
					
					for t=1,200 do
						IFEditbox_fnAddChar(gCurEditbox, 8)	-- backspace
					end
					if(retVal ~= nil) then
						IFText_fnSetString(this.cheatOutput, retVal)
						IFObj_fnSetVis( this.cheatOutput, 1 )
					else
						IFObj_fnSetVis( this.cheatOutput, nil )
					end
				else
					IFEditbox_fnAddChar(gCurEditbox, iKey)
					IFObj_fnSetVis( this.cheatOutput, nil )
				end
			end -- if cheatBox
		end -- if gCurEditBox
	end, --end of Input_KeyDown

	Input_Accept = function(this)
   		-- If the tab manager handled this event, then we're done
		if( (gPlatformStr == "PC") and 
			( ifelem_tabmanager_HandleInputAccept(this, gPCMainTabsLayout) or
			  ifelem_tabmanager_HandleInputAccept(this, gPCSinglePlayerTabsLayout, 1) ) or
			  ifelem_tabmanager_HandleInputAccept(this, gPCMultiPlayerSettingsTabsLayout, 2) ) then
				return
			end

	
		-- If base class handled this work, then we're done
		if(gShellScreen_fnDefaultInputAccept(this, 1 )) then
			return
		end
		
		-- if click on map list
		ifs_missionselect_pcMulti_fnClickMapList( this )

		if(gMouseListBox) then
			--if( gMouseListBox == this.ModeListbox ) then
			if( gMouseListBox == this.MapListbox ) then
				--this.bClicked = 1
				if( ( gMouseListBox.Layout.SelectedIdx == gMouseListBox.Layout.CursorIdx ) and 
					( this.lastDoubleClickTime ) and 
					( ScriptCB_GetMissionTime()<this.lastDoubleClickTime+0.4 ) ) then
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
			if( gMouseListBox.Layout.SelectedIdx == gMouseListBox.Layout.CursorIdx and this.lastDoubleClickTime and ScriptCB_GetMissionTime()<this.lastDoubleClickTime+0.4) then
--				print("doing shortcut")
				this.lastDoubleClickTime = nil
				--if( gMouseListBox == this.listboxL ) then
				--	this.CurButton = "_add"
				--else
				--	this.CurButton = "_del"
				--end
			else
				this.lastDoubleClickTime = ScriptCB_GetMissionTime()
				gMouseListBox.Layout.SelectedIdx = gMouseListBox.Layout.CursorIdx
				ListManager_fnFillContents(gMouseListBox,gMouseListBox.Contents,gMouseListBox.Layout)
				
				--start to play the movie
				ifs_missionselect_fnSetMapPreview(this)
				
				return 1 -- note we did all the work
			end
		end

		ifs_missionselect_pcMulti_fnClickCheckButtons( this )
		ifs_missionselect_pcMulti_fnClickMapButtons( this )

		-- input accept for option buttons
		ifs_missionselect_pcMulti_fnClickOptionButtons( this )

		if(this.CurButton == "_del") then
			local Count = table.getn(gPickedMapList)
			if(Count > 0) then
				local i
				local j = 1
				local NewList = {}
				for i=1,Count do
					if(i ~= missionselect_name_listboxR_layout.SelectedIdx) then
						NewList[j] = gPickedMapList[i]
						j = j + 1
					end
				end

				gPickedMapList = NewList
				--ListManager_fnAutoscroll(this.listboxR,gPickedMapList,missionselect_name_listboxR_layout)
				--ListManager_fnFillContents(this.listboxR,gPickedMapList,missionselect_name_listboxR_layout)
			end
		end -- "_del" special processing
		
	

		local Selection = missionselect_listbox_contents[missionselect_name_listboxL_layout.SelectedIdx]
		local bPC = (gPlatformStr == "PC")
		if(this.iPage == 0) then -- first sub-part

			if(this.CurButton == "Order") then
				ifs_missionselect_fnToggleOrder(this)
				ifelm_shellscreen_fnPlaySound(this.acceptSound)
			elseif (this.CurButton == "Launch") then
				ifelm_shellscreen_fnPlaySound(this.acceptSound)
				ifs_missionselect_fnLaunch(this)
			elseif (((not bPC) and (this.bOnLeft)) or (bPC and (this.CurButton == "_add"))) then
				ifelm_shellscreen_fnPlaySound(this.acceptSound)

--				print("List full check:",table.getn(gPickedMapList) , this.iMaxMissions)
				if(table.getn(gPickedMapList) < this.iMaxMissions) then
					local bMultipleSides
					local LastSideChar
					bMultipleSides,LastSideChar = ifs_missionselect_fnGetSides(Selection)

					if(bMultipleSides) then
						ifs_missionselect_fnSetPage(this,1)
					else
						-- Only 1 side. Add it directly.
						local EntryButton = this.CurButton
						this.AttackerChar = LastSideChar
						this.CurButton = LastSideChar
						ifs_missionselect_fnAddMap(this)
						this.CurButton = EntryButton
					end
				else
					-- Mission list is full. Notify the user
					ifs_missionselect_fnShowHideListboxes(this,nil)
					Popup_Ok.fnDone = ifs_missionselect_fnFullPopupDone
					Popup_Ok:fnActivate(1)
					gPopup_fnSetTitleStr(Popup_Ok, "ifs.missionselect.listfull")
				end

			else
				-- must be on right listbox
				if this.CurButton then
				   -- don't play sound unless you're on a button
				   ifelm_shellscreen_fnPlaySound(this.acceptSound)
				end
				this.bOnButtons = 1
				missionselect_name_listboxR_layout.CursorIdx = nil
				--ListManager_fnFillContents(this.listboxR,gPickedMapList,missionselect_name_listboxR_layout)
			end -- on right
		elseif (this.iPage == 1) then -- Second sub-part
			ifelm_shellscreen_fnPlaySound(this.acceptSound)
			this.AttackerChar = this.CurButton -- store for later

			-- Side select is ingame now - NM 4/5/04
			ifs_missionselect_fnAddMap(this)
--			ifs_missionselect_fnSetPage(this,2)
		elseif (this.iPage == 2) then -- Second sub-part
			ifelm_shellscreen_fnPlaySound(this.acceptSound)

			ifs_missionselect_fnAddMap(this)

--			this.fnDone()
		end -- done with sub-parts
--		print("Input_Accept Bot, CurButton = ", this.CurButton)
	end, -- end of Input_Accept

	Input_Back = function(this)
		-- Hack - if just 1 map, then can't go back to the listboxL
		if(table.getn(missionselect_listbox_contents) == 1) then
			this.EraMode = nil
		end

		if(this.iPage == 0) then -- first sub-part
			ScriptCB_PopScreen()
			if(this.fnCancel) then
				this.fnCancel()
			else
				ScriptCB_PopScreen() -- default: just go back 2 screens.
			end
		elseif (this.iPage == 1) then
			ifelm_shellscreen_fnPlaySound(this.exitSound)
			ifs_missionselect_fnSetPage(this,0)
		end
	end,

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
						missionselect_name_listboxR_layout.SelectedIdx = math.min(missionselect_name_listboxR_layout.FirstShownIdx + missionselect_name_listboxR_layout.showcount - 1, table.getn(gPickedMapList))
						if(missionselect_name_listboxR_layout.SelectedIdx < 1) then
							missionselect_name_listboxR_layout.SelectedIdx = 1
						end
						missionselect_name_listboxR_layout.CursorIdx = missionselect_name_listboxR_layout.SelectedIdx
						--ListManager_fnFillContents(this.listboxR,gPickedMapList,missionselect_name_listboxR_layout)
					else
					end

				else
					-- Not on buttons
					if(missionselect_name_listboxR_layout.SelectedIdx == 1) then
						missionselect_name_listboxR_layout.CursorIdx = nil
						--ListManager_fnFillContents(this.listboxR,gPickedMapList,missionselect_name_listboxR_layout)
						ifelm_shellscreen_fnPlaySound(this.selectSound)
					else
						-- on right
					end
				end
			end
--			ifs_missionselect_fnSetMapPreview(this)
		elseif (this.iPage == 1) then
			gDefault_Input_GeneralUp(this)
		end -- page == 0
		ifs_missionselect_fnUpdateDelButton(this)
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
						missionselect_name_listboxR_layout.SelectedIdx = missionselect_name_listboxR_layout.FirstShownIdx
						
						missionselect_name_listboxR_layout.CursorIdx = missionselect_name_listboxR_layout.SelectedIdx
						--ListManager_fnFillContents(this.listboxR,gPickedMapList,missionselect_name_listboxR_layout)
					end
				else
					-- Not on buttons
					if(missionselect_name_listboxR_layout.SelectedIdx >= table.getn(gPickedMapList)) then
						missionselect_name_listboxR_layout.CursorIdx = nil
						--ListManager_fnFillContents(this.listboxR,gPickedMapList,missionselect_name_listboxR_layout)
						ifelm_shellscreen_fnPlaySound(this.selectSound)
					else
					end
				end -- not on buttons
			end
--			ifs_missionselect_fnSetMapPreview(this)
		elseif (this.iPage == 1) then
			gDefault_Input_GeneralDown(this)
		end
		ifs_missionselect_fnUpdateDelButton(this)
	end,

	Input_LTrigger = function(this)
		if(this.iPage == 0) then -- First sub-part
			--if(this.bOnLeft) then
			--	ListManager_fnPageUp(this.listboxL,missionselect_listbox_contents,missionselect_name_listboxL_layout)
			--else
			--	ListManager_fnPageUp(this.listboxR,gPickedMapList,missionselect_name_listboxR_layout)
			--end
--			ifs_missionselect_fnSetMapPreview(this)
		end
	end,

	Input_RTrigger = function(this)
		if(this.iPage == 0) then -- First sub-part
			--if(this.bOnLeft) then
			--	ListManager_fnPageDown(this.listboxL,missionselect_listbox_contents,missionselect_name_listboxL_layout)
			--else
			--	ListManager_fnPageDown(this.listboxR,gPickedMapList,missionselect_name_listboxR_layout)
			--end
--			ifs_missionselect_fnSetMapPreview(this)
		end
	end,

	Input_GeneralLeft = function(this)
		if(this.iPage == 0) then
			ifs_missionselect_fnFlipLeftRight(this)
		end
	end,

	Input_GeneralRight = function(this)
		if(this.iPage == 0) then
			ifs_missionselect_fnFlipLeftRight(this)
		end
	end,

	RepaintListbox = function(this)
	end,
	UpdateButtons = function(this) 
	end,
	UpdateUI = function(this)
	end,
	fnClearButtonHilight = function(this)
	end,
}

gPickedMapList = {}

function ifs_missionselect_fnBuildScreen(this)
	local w,h = ScriptCB_GetSafeScreenInfo() -- of the usable screen

	-- add pc profile & title version text
	AddPCTitleText( this )

	gPickedMapList = {}
	
	if(USING_NEW_PC_SHELL) then
		new_shell_offset_x = 240		
	end


	missionselect_name_listboxL_layout.width = (w * 0.48) - 35
	missionselect_name_listboxR_layout.width = (w * 0.48) - 35

	local ListEntryHeightL = (missionselect_name_listboxL_layout.yHeight + missionselect_name_listboxL_layout.ySpacing)
	local ListEntryHeightR = (missionselect_name_listboxR_layout.yHeight + missionselect_name_listboxR_layout.ySpacing)

	missionselect_name_listboxL_layout.showcount = math.min(16,math.max(4, math.floor((h - 160) / ListEntryHeightL)))
	missionselect_name_listboxR_layout.showcount = missionselect_name_listboxL_layout.showcount - 2

	local ListHeightR = missionselect_name_listboxR_layout.showcount * ListEntryHeightR + 30
	local ListHeightL = missionselect_name_listboxL_layout.showcount * ListEntryHeightL + 30

--	this.listboxL = NewButtonWindow { 
--		ZPos = 200, 
--		x = missionselect_name_listboxL_layout.width * 0.5 + 30 - w*0.5, y = 0,
--		ScreenRelativeX = 0.5, -- center of screen
--		ScreenRelativeY = 0.5, -- middle, vertically
--		width = missionselect_name_listboxL_layout.width + 35,
--		height = ListHeightL,
--		rotY = 35,
--		titleText = "ifs.missionselect.available"
--	}

--	this.listboxR = NewButtonWindow { 
--		ZPos = 200, 
--		x = -(missionselect_name_listboxR_layout.width * 0.5+30) + w*0.5, 
--		y = - ( ListHeightL - ListHeightR)/2,
--		ScreenRelativeX = 0.5, -- center of screen
--		ScreenRelativeY = 0.5, -- middle, vertically
--		width = missionselect_name_listboxR_layout.width + 35,
--		height = ListHeightR,
--		rotY = -35,
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
		--rotY = this.listboxR.rotY,
		--x = this.listboxR.x + 23,
		--y = this.listboxR.height / 2 + 11,
		--btnw = this.listboxR.width,
		btnh = ScriptCB_GetFontHeight("gamefont_small"),
		font = "gamefont_small", 
		tag = "Order",
		string = "ifs.missionselect.inorder",
	}

--	this.LaunchButton = NewRoundIFButton {
--		ScreenRelativeX = 0.5,
--		ScreenRelativeY = 1.0,
--		rotY = -35,
--		y = (ListHeightR * 0.5) -( ListHeightL - ListHeightR)/2 + (MapRadius * 1.5) + 10,
--		y = -15,
--		btnw = w * 0.44, btnh = MapRadius, font = "gamefont_medium",
--		nocreatebackground = 1,
--	}
--	this.LaunchButton.label.halign = "hcenter"
--	this.LaunchButton.label.valign = "vcenter"
--	this.LaunchButton.label.ColorR = 255
--	this.LaunchButton.label.ColorG = 255
--	this.LaunchButton.label.ColorB = 0--255
--	this.LaunchButton.font = nil
--	this.LaunchButton.label.bHotspot = 1
--	this.LaunchButton.label.fHotspotW = this.LaunchButton.btnw
--	this.LaunchButton.label.fHotspotH = this.LaunchButton.btnh
--	this.LaunchButton.tag = "Launch"
	
	
	--size the background
	custom_SetMovieLocation(this)
	
	-- local wScreen,hScreen,vScreen,widescreen = ScriptCB_GetScreenInfo()
-- -- 	this.backImg.localpos_r = wScreen*widescreen
-- -- 	this.backImg.localpos_b = hScreen
-- -- 	this.backImg.uvs_b = vScreen
	-- -- calc the position of the movie preview window
	-- this.movieW = 510.0
	-- this.movieH = 400.0
	-- this.movieX = wScreen - 600.0
	-- this.movieY = hScreen - this.movieH + 100.0 

	-- Also, add buttons
	--this.CurButton = AddVerticalButtons(this.buttons,ifs_era_vbutton_layout)
	
--	ListManager_fnInitList(this.listboxL,missionselect_name_listboxL_layout)
--	ListManager_fnInitList(this.listboxR,missionselect_name_listboxR_layout)

	local AddDelButtonW = 40
	local AddDelButtonYSpace = 5
	local AddDelButtonH = 20

	this.AddDelContainer =	NewIFContainer {
		ScreenRelativeX = 0.5, -- center
		ScreenRelativeY = 0.5, -- bottom
		y = 0, -- just above bottom
		x = 0 + new_shell_offset_x,

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
	
	custom_SetEraBooleans(this, nil)
	-- this.bEra_CloneWar = 1
	-- this.bEra_Galactic = 1
	
	
	this.iLastClickTime = nil
	this.bDoubleClicked = nil
	
	-- Now, do the boxes above and below the columns
	local ColumnWidthL = 145
	local ColumnWidthC = 200	
	local ColumnWidthR = 200
	local TopBoxHeight = 30 -- enough for two lines of text
	local infobox_offset_x = -38
	local infobox_offset_y = 50 + 5
	
	local ListHeightC = 170
	
	local ColumnWidthOption = 245
	local ColumnHightOption = 210
	this.InfoboxOptions = NewIFContainer { 
		ScreenRelativeX = 0, -- left side of screen
		ScreenRelativeY = 0, -- top
		x = 510 + new_shell_offset_x,
		y = infobox_offset_y, -- top-justify against left box

		bg = NewIFImage {
			ZPos = 240, 
			localpos_l = 4,
			localpos_r = ColumnWidthOption - 2,
			localpos_b = TopBoxHeight,
			texture = "white_rect",
			ColorR = 128,
			ColorG = 128,
			ColorB = 128,
		},

		Text1 = NewIFText { 
			x = 10,
			y = 5,
			halign = "left", valign = "vcenter",
			font = "gamefont_small", 
			textw = ColumnWidthR, texth = TopBoxHeight,
			startdelay=math.random()*0.5, nocreatebackground=1, 
			ColorR = 0,
			ColorG = 0,
			ColorB = 0,
			string = "ifs.mp.create.options",
		},
	}
	
	this.OptionListbox = NewButtonWindow { 
		ZPos = 200, 
		ScreenRelativeX = 0, -- left side of screen
		ScreenRelativeY = 0, -- top
		x = 123 + this.InfoboxOptions.x + new_shell_offset_x,
		y = 130 + this.InfoboxOptions.y + 5,
		width = ColumnWidthOption - 6,
		height = ColumnHightOption,
	}
			

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
--	
--	this.HostOptionListbox = NewButtonWindow { 
--		ZPos = 200, 
--		ScreenRelativeX = 0, -- left side of screen
--		ScreenRelativeY = 0, -- top
--		x = 123 + this.InfoboxHostOptions.x,
--		y = 130 + this.InfoboxHostOptions.y + 5,
--		width = ColumnWidthOption - 6,
--		height = ColumnHightOption,
--	}		
	
	local era_text_offset_x = 26
	local era_text_offset_y = 15

	local era_check_offset_x = 7
	local era_check_offset_y = 22

	local listbox_l_offset_y = 240
	local listbox_l_offset_x = 28
	local listbox_c_offset_x = listbox_l_offset_x + ColumnWidthL
	local listbox_r_offset_x = listbox_l_offset_x + ColumnWidthL + ColumnWidthC
		
	ifs_mspc_MapList_layout.width = ColumnWidthL - 24
	ifs_mspc_ModeList_layout.width = ColumnWidthC
	ifs_mspc_PlayList_layout.width = ColumnWidthR - 24
	
--	-- Create our listboxes
--	ListManager_fnInitList(this.MapListbox,ifs_mspc_MapList_layout)
--	ListManager_fnInitList(this.ModeListbox,ifs_mspc_ModeList_layout)
--	ListManager_fnInitList(this.PlayListbox,ifs_mspc_PlayList_layout)
--	print( "finish playlist" )
	
	-- move button position
	local launch_button_y = 15
--	this.Helptext_Back.y = launch_button_y
	--this.LaunchButton.y = launch_button_y

	if(gPlatformStr == "PC") then
		-- Add tabs to screen
		ifelem_tabmanager_Create(this, gPCMainTabsLayout, gPCSinglePlayerTabsLayout, gPCMultiPlayerSettingsTabsLayout)
	end	
	
	-- add option buttons
	ifs_missionselect_pcMulti_fnAddOptionButtons( this, false )
	
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
	
	custom_AddCheatBox(this)
	-- cheat bits
	-- local cheatBoxY = 400
	-- local cheatBoxX = 30
	-- local cheatBoxW = 121
	-- local cheatBoxH = 77

	-- this.cheatOutput = NewIFText { 
			-- x = cheatBoxX-28,
			-- y = cheatBoxY+40,
			-- halign = "left", valign = "vcenter",
			-- font = "gamefont_small", 
			-- textw = 120, texth = 90,
			-- font = "gamefont_tiny",
			-- nocreatebackground=1, 
			-- string = "",
	-- }
	
	-- this.cheatBox = NewEditbox {
			-- ScreenRelativeX = 0, 
			-- ScreenRelativeY = 0, 
			-- y = cheatBoxY,
			-- x = cheatBoxX,

			-- width = cheatBoxW,
			-- height = cheatBoxH,
			-- font = "gamefont_tiny",
			-- --		string = "Player 1",
			-- MaxLen = nil,
			-- MaxChars = 60,
			-- bKeepsFocus = nil,
			-- bSilentAndInvisible = 1,
			-- bClearOnHilightChange = 1,
			-- noChangeSound = 1,
			-- bIsTheCheatBox = 1,
	-- }
end

ifs_missionselect_fnBuildScreen(ifs_missionselect)
ifs_missionselect_fnBuildScreen = nil -- dump out of memory to save

AddIFScreen(ifs_missionselect,"ifs_missionselect")