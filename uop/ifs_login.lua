------------------------------------------------------------------
-- uop recovered source
-- by Anakain
------------------------------------------------------------------
--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- Helper function. Given a layout (x,y,width, height), returns a
-- fully-built item.


function ifs_login_PatchAvailableOK()
end

function ifs_login_listbox_CreateItem(layout)
	-- Make a coordinate system pegged to the top-left of where the cursor would go.
	local Temp = NewIFContainer { x = layout.x - 0.5 * layout.width, y=layout.y}
	Temp.NameStr = NewIFText{ x = 10, y = -7, halign = "left", font = "gamefont_tiny", textw = 250, nocreatebackground = 1, startdelay=math.random()*0.5, }
	return Temp
end

-- Helper function. For a destination item (previously created w/
-- CreateItem), fills it in with data, which may be nil (==blank it)
function ifs_login_listbox_PopulateItem(Dest,Data)
	if(Data) then
		-- Show this entry
		IFText_fnSetUString(Dest.NameStr,Data.showstr)
		IFObj_fnSetVis(Dest.NameStr,1)
	else
		-- Blank this entry
		IFText_fnSetString(Dest.NameStr,"")
		IFObj_fnSetVis(Dest.NameStr,nil)
	end
end


ifs_login_listbox_contents = {
}

loginshowcount = 5
ifs_login_listbox_layout = {	
	showcount = 5,
	yHeight = 20,
	ySpacing  = 0,
	width = 260,
	x = 0,
	hilight_offset_y = -3,
	slider = 1,
--	bgwindow =1,
--	dropdown = 1,
	CreateFn = ifs_login_listbox_CreateItem,
	PopulateFn = ifs_login_listbox_PopulateItem,
	
}

function ifs_login_diff_listbox_PopulateItem(Dest,Data)
	if(Data) then
		-- Show this entry
		IFText_fnSetString(Dest.NameStr,Data.showstr)
		IFObj_fnSetVis(Dest.NameStr,1)
	else
		-- Blank this entry
		IFText_fnSetString(Dest.NameStr,"")
		IFObj_fnSetVis(Dest.NameStr,nil)
	end
end

ifs_login_diff_listbox_contents = {
--	{ showstr = "ifs.difficulty.easy" },
	{ showstr = "ifs.difficulty.medium" },
	{ showstr = "ifs.difficulty.hard" },
}

ifs_login_diff_listbox_layout = {	
	showcount = table.getn(ifs_login_diff_listbox_contents),
	yHeight = 20,
	ySpacing  = 0,
	width = 260,
	x = 0,
	hilight_offset_y = -3,
--	slider = 1,
	CreateFn = ifs_login_listbox_CreateItem,
	PopulateFn = ifs_login_diff_listbox_PopulateItem,	
}

function ifs_login_fnQuitPopupDone(bResult)

	if(bResult) then
		ScriptCB_QuitToWindows()
	end
end

-- Sets the hilight on the listbox, create button given a hilight
function ifs_login_SetHilight(this,aListIndex)
	if(gE3Build or aListIndex) then
		-- Deactivate 'create' button, if applicable.
		if(gCurHiliteButton) then
			IFButton_fnSelect(gCurHiliteButton,nil) -- Deactivate old button
			gCurHiliteButton = nil
			this.CurButton = nil
--			print("Zapping cur button w/ hilight ",aListIndex)
		end
	else
		-- Not in listindex. Focus is on the create buttons
	end

	ifs_login_listbox_layout.SelectedIdx = aListIndex
	ifs_login_listbox_layout.CursorIdx = aListIndex
	ListManager_fnFillContents(this.listbox,ifs_login_listbox_contents,ifs_login_listbox_layout)
	IFObj_fnSetVis(this.Helptext_Delete, table.getn(ifs_login_listbox_contents) > 0)
end

function ifs_login_fnNotUniqueOk()
	-- Re-enable parts of vkeyboard we disabled
--	IFObj_fnSetVis(ifs_vkeyboard.title,1)
	IFObj_fnSetVis(ifs_vkeyboard.deletegroup,1)
	IFObj_fnSetVis(ifs_vkeyboard.modegroup,1)
--	IFObj_fnSetVis(ifs_vkeyboard.Helptext_Accept2,1)
	IFObj_fnSetVis(ifs_vkeyboard.buttons,1)
end

-- Callback function from VK - returns 2 values, whether the current
-- string is allowed to be entered, and a localize database key string
-- as to why it's not acceptable.
function ifs_login_fnIsAcceptable()
	return (string.len(ifs_vkeyboard.CurString) > 2),"ifs.vkeyboard.tooshort"
end

function ifs_login_fnDifficultyDone()
	-- reenter ifs_login, but go right to SaveAndExit
	ifs_login.SaveAndExit = 1
	ifs_difficulty.LogoutOnCancel = nil
	ScriptCB_PopScreen() -- back to this screen, ifs_login
end

-- Callback function when the virtual keyboard is done
function ifs_login_fnKeyboardDone()
	if(string.len(ifs_vkeyboard.CurString) > 2) then
--		local UCurString = ifs_vkeyboard.CurString

		local CurString = ScriptCB_ununicode(ifs_vkeyboard.CurString)
		local LastByte
		repeat
			local l = string.len(CurString)
			LastByte = string.byte(string.sub(CurString,-1))
			if(LastByte == 32) then
				CurString = string.sub(CurString, 1, l - 1)
--				print("Truncating last char...")
			end
		until (LastByte ~= 32)

		local UCurString = ScriptCB_tounicode(CurString)
		if(ScriptCB_IsUniqueLoginName(UCurString)) then
			ScriptCB_AddProfile(UCurString)
            -- sound changed mix configuration, we'll have to reopen the 
            -- movie and music
            if (ScriptCB_GetMixConfigChanged()) then
                ifs_opt_sound_closeShellSound() 
                ifs_opt_sound_restoreShellSound()
            end
			
			gSelection = {}
			gSelection.showstr = UCurString
			--			RoundIFButtonLabel_fnSetUString(ifs_login.buttons["dropdown"], ScriptCB_UnicodeStrCat( ScriptCB_tounicode("CURRENT PROFILE:")  ,UCurString ) ) 
			
			ifs_vkeyboard.CurString = "" -- clear
			vkeyboard_specs.fnDone = nil -- clear our registration there
			
			--ifs_difficulty.fnDone = ifs_login_fnDifficultyDone
			--ifs_difficulty.LogoutOnCancel = 1
			--ifs_movietrans_PushScreen(ifs_difficulty)
			
			-- set difficult
			local diff_id = ifs_login_diff_listbox_layout.SelectedIdx + 1
--			print("select difficulty id = ", diff_id)
			ScriptCB_SetDifficulty(diff_id, true)
			ifs_login_fnDifficultyDone()
			
			gSelection.showstr = UCurString
		else
			-- Hide chunks of vkeyboard
			--			IFObj_fnSetVis(ifs_vkeyboard.title,nil)
			IFObj_fnSetVis(ifs_vkeyboard.deletegroup,nil)
			IFObj_fnSetVis(ifs_vkeyboard.modegroup,nil)
			--			IFObj_fnSetVis(ifs_vkeyboard.Helptext_Accept2,nil)
			IFObj_fnSetVis(ifs_vkeyboard.buttons,nil)

			Popup_Ok.fnDone = ifs_login_fnNotUniqueOk
			Popup_Ok:fnActivate(1)
			gPopup_fnSetTitleStr(Popup_Ok, "ifs.Profile.dupname")
		end
	end
end

-- Helper function: turns pieces on/off as requested
function ifs_login_fnSetPieceVis(this,bNormalVis)
	
	if( gButtonMode == 1) then 
		IFObj_fnSetVis(this.listbox,nil)
	else
--		print("OK, Show the listbox")
		IFObj_fnSetVis(this.listbox,bNormalVis)
	end
	
	if(bNormalVis) then
		ifs_login_fnRegetListbox(this)
		if(this.ListFull) then
			IFObj_fnSetVis(this.Helptext_Create,nil)
		end
	end

end

function ifs_login_fnRegetListbox(this)
	-- Reset listbox, show it. [Remember, Lua starts at 1!]
	local MaxCount = ScriptCB_GetLoginList("ifs_login_listbox_contents")
	local ListCount = table.getn(ifs_login_listbox_contents)

	this.ListFull = (ListCount >= MaxCount)

	ifs_login_listbox_layout.FirstShownIdx = 1 -- top
	if(ListCount > 0) then
		-- Auto-select first item
---		ifs_login_SetHilight(this,1)
	else
		-- Auto-select 'create' button
		ifs_login_SetHilight(this,nil)
	end
	ListManager_fnFillContents(this.listbox,ifs_login_listbox_contents,ifs_login_listbox_layout)
	IFObj_fnSetVis(this.Helptext_Delete, table.getn(ifs_login_listbox_contents) > 0)
end

----------------------------------------------------------------------------------------
-- switch between the two visible modes of this screen (select-from-list and create)
----------------------------------------------------------------------------------------

-- pass true to go to create mode, nil to list mode
function ifs_login_SetCreateVis(create)
	local this = ifs_login
	
	-- remember our mode
	this.bCreateMode = create

	-- show these for create mode	
	IFObj_fnSetVis(this.NewBox, create)
	IFObj_fnSetVis(this.Helptext_Back, create)
	IFObj_fnSetVis(this.diff_button, create)
	IFObj_fnSetVis(this.select_diff, create)

	-- show these for list mode
	IFObj_fnSetVis(this.listbox, not create)
	IFObj_fnSetVis(this.Helptext_Create, not create)
--	IFObj_fnSetVis(this.Helptext_Rename, not create)
	-- Fix for 13557 - hide delete button if no saved profiles - NM 9/15/05
	IFObj_fnSetVis(this.Helptext_Delete, not create and table.getn(ifs_login_listbox_contents) > 0)
	IFObj_fnSetVis(this.profile_button, not create)
	IFObj_fnSetVis(this.select_profile, not create)	
		
	if(create) then
		gCurEditbox = this.NewBox.nameedit
		IFEditbox_fnHilight(gCurEditbox, 1)
		this.iEnterCount = 0

		-- init difficulty		
		ifs_login_diff_listbox_layout.SelectedIdx = 1
		RoundIFButtonLabel_fnSetString( this.diff_button, ifs_login_diff_listbox_contents[ifs_login_diff_listbox_layout.SelectedIdx].showstr )
	else
		gCurEditbox = nil
		this.iEnterCount = 0
	end
end




----------------------------------------------------------------------------------------
-- load the profile list.  this is just the preop, since that refreshes the file list.
----------------------------------------------------------------------------------------

function ifs_login_StartLoadFileList()
--	print("ifs_login_StartLoadFileList")
	
	ifs_saveop.doOp = "LoadFileList"
	ifs_saveop.OnSuccess = ifs_login_LoadFileListSuccess
	ifs_saveop.OnCancel = ifs_login_LoadFileListCancel
	ifs_movietrans_PushScreen(ifs_saveop);

end

function ifs_login_LoadFileListSuccess()
	-- good, continue
--	print("ifs_login_LoadFileListSuccess")
	
	-- pop ifs_saveop, reenter ifs_login
	ifs_login.EnterDoNothing = 1
	ScriptCB_PopScreen()

end

function ifs_login_LoadFileListCancel()
	-- ok, continue
--	print("ifs_login_LoadFileListCancel")
	-- need one of these
	ScriptCB_PopScreen()
	
	-- pop ifs_saveop, reenter ifs_login
	ifs_login.EnterDoNothing = 1
	ScriptCB_PopScreen()

end

----------------------------------------------------------------------------------------
-- load two profiles
----------------------------------------------------------------------------------------

gPrevMixConfig = nil
gPrevEffects   = nil

function ifs_login_StartLoadProfile(profile1,profile2)
--	print("ifs_login_StartLoadProfile")

	-- Always cancel Gamespy login - BF2 bug #14078.
	ScriptCB_SetConnectType("wan")
	ScriptCB_CancelLogin()

	ifs_saveop.doOp = "LoadProfile"
	ifs_saveop.OnSuccess = ifs_login_LoadProfileSuccess
	ifs_saveop.OnCancel = ifs_login_LoadProfileCancel
	ifs_saveop.profile1 = profile1
	ifs_saveop.profile2 = profile2
    
	gPrevMixConfig = ScriptCB_GetMixConfig()
	gPrevEffects   = ScriptCB_EffectsEnabled()
    
	ifs_movietrans_PushScreen(ifs_saveop)
end

function ifs_login_LoadProfileSuccess()
--	print("ifs_login_LoadProfileSuccess")
	-- pop ifs_saveop, reenter ifs_login but then save and exit
	
	-- sound changed mix configuration, we'll have to reopen the 
	-- movie and music
	if (ScriptCB_GetMixConfigChanged()) then
		ifs_opt_sound_closeShellSound() 
		ifs_opt_sound_restoreShellSound()
	end
	
	ifs_login.SaveAndExit = 1
	ScriptCB_PopScreen()
end

function ifs_login_LoadProfileCancel()
--	print("ifs_login_LoadProfileCancel")
	-- pop ifs_saveop, reenter ifs_login and idle
	ifs_login.EnterDoNothing = 1
	ScriptCB_PopScreen()
end

----------------------------------------------------------------------------------------
-- delete a profile
----------------------------------------------------------------------------------------

function ifs_login_fnDeletePopupDone(bResult)
	local this = ifs_login
	if(bResult) then
--		print("ifs_login_fnDeletePopupDone(true)")
		-- User does want to delete
		--local Selection = ifs_login_listbox_contents[ifs_login_listbox_layout.SelectedIdx]
		
		if(ifs_login_listbox_layout.SelectedIdx) then
			ScriptCB_Logout()
			
			local gSelection = ifs_login_listbox_contents[ifs_login_listbox_layout.SelectedIdx]

			ifs_saveop.doOp = "DeleteProfile"
			ifs_saveop.OnSuccess = ifs_login_DeleteProfileSuccess
			ifs_saveop.OnCancel = ifs_login_DeleteProfileCancel
			ifs_saveop.profile1 = gSelection.showstr
			ifs_saveop.saveName = gSelection.showstr
			ifs_movietrans_PushScreen(ifs_saveop)
		end
		
	else
--		print("ifs_login_fnDeletePopupDone(false)")
		-- User hit no. Back to normal screen
		ifs_login_SetCreateVis(nil)
	end
end

function ifs_login_DeleteProfileSuccess()
--	print("ifs_login_DeleteProfileSuccess")
	Popup_LoadSave2:fnActivate(nil)	
	-- pop ifs_saveop, reenter ifs_login
	ScriptCB_PopScreen()
end

function ifs_login_DeleteProfileCancel()
--	print("ifs_login_DeleteProfileCancel")
	Popup_LoadSave2:fnActivate(nil)	
	-- pop ifs_saveop, reenter ifs_login
	ScriptCB_PopScreen()
end


----------------------------------------------------------------------------------------
-- when we're done with this screen, save any dirty profiles and push to ifs_main
----------------------------------------------------------------------------------------

function ifs_login_SaveAndExit()
--	print("ifs_login_SaveAndExit")
	local this = ifs_login
	
	ifs_saveop.doOp = "SaveProfile"
	ifs_saveop.OnSuccess = ifs_login_SaveProfileSuccess
	ifs_saveop.OnCancel = ifs_login_SaveProfileCancel
	ifs_saveop.saveName = ScriptCB_GetCurrentProfileName()
	ifs_saveop.saveProfileNum = 1
	ifs_movietrans_PushScreen(ifs_saveop)	

	-- we need this, otherwise we call ifs_login.Enter(nil) twice.  why?  i dunno.  because lua is ghetto.
	this.EnterDoNothing = 1
end

function ifs_login_SaveProfileSuccess()
--	print("ifs_login_SaveProfileSuccess")
	-- exit once we reenter
	ifs_login.EnterThenExit = 1	
	ScriptCB_PopScreen()
end

function ifs_login_SaveProfileCancel()
--	print("ifs_login_SaveProfileCancel")
	-- exit once we reenter
	ifs_login.EnterThenExit = 1	
	ScriptCB_PopScreen()
end



----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

-- this is called when the login process is done
-- takes the place of what used to be _PushScreen("ifs_main")
function ifs_login_Done()
	print("ifs_login_Done")
	-- we should have an exit callback set
	if(ifs_login.fnDone) then
		ifs_login.fnDone()
	else
		-- error
		print("ERROR login exit function (ifs_login.fnDone) not set")
	end
end


function ifs_login_EnterInterface(this)
	local function original_ifs_login_EnterInterface( this )
		if( table.getn(ifs_login_listbox_contents) > 0 ) then
	--		print("enter with profile")

			-- set to last played profile
			local last_profile = ifs_login_listbox_layout.SelectedIdx
			
			if( ScriptCB_IsPlayerLoggedIn() ) then
				local profile_name = ScriptCB_GetCurrentProfileName()
				local i
				for i = 1, table.getn(ifs_login_listbox_contents) do
					if( ifs_login_listbox_contents[i].showstr == profile_name ) then
						last_profile = i
						ifs_login_listbox_layout.SelectedIdx = i
						break
					end
				end
			end

			RoundIFButtonLabel_fnSetUString( this.profile_button, ifs_login_listbox_contents[last_profile].showstr )
			IFObj_fnSetVis(this.listbox,nil)
			IFObj_fnSetVis(this.diff_listbox,nil)
		else
	--		print("enter with no profile")
			-- set to create mode
			ifs_login_SetCreateVis(1)
			-- no "cancel" button if you don't have any profiles
			IFObj_fnSetVis(this.Helptext_Back, table.getn(ifs_login_listbox_contents) > 0)
			-- Fix for 13324 - if no profiles in list, blank out listbox - NM 9/12/05
			RoundIFButtonLabel_fnSetString( this.profile_button, "")
		end
	end
	
	if __ADDDOWNLOADABLECONTENT_COUNT__ >= __max_missions__ then
		
		Popup_Ok.fnDone = original_ifs_login_EnterInterface(this)
		Popup_Ok:fnActivate(1)
		
		warn = ScriptCB_usprintf("mods.mission.warn", ScriptCB_tounicode(string.format("%d >= %d", __ADDDOWNLOADABLECONTENT_COUNT__, __max_missions__)))
		
		gPopup_fnSetTitleUStr(Popup_Ok, warn)
	
	else
		original_ifs_login_EnterInterface(this)
	end
	
end

function ifs_login_fnShowProfileDropbox( this, enable )	
	IFObj_fnSetVis(this.listbox, enable)
	this.bProfileDropBoxesOpen = enable
end

function ifs_login_fnShowDiffDropbox( this, enable )	
	IFObj_fnSetVis(this.diff_listbox, enable)
	this.bDiffDropBoxesOpen = enable
end

function ifs_login_fnClickDropDownButtons( this )
	--print( "this.bSourceDropBoxesOpen =", this.bSourceDropBoxesOpen )
	--print( "this.CurButton =", this.CurButton )
	
	if( gMouseListBoxSlider ) then
		-- do nothing if click on slider bar
	elseif( this.bProfileDropBoxesOpen ) then
		--print( "gMouseListBox =", gMouseListBox )
		--print( "this.listbox =", this.listbox )
		if( gMouseListBox == this.listbox ) then
			if( ifs_login_listbox_layout.CursorIdx ) then
				ifs_login_listbox_layout.SelectedIdx = ifs_login_listbox_layout.CursorIdx
			end
--			print( "ifs_login_listbox_layout.SelectedIdx = ", ifs_login_listbox_layout.SelectedIdx )
		end
		ifs_login_fnShowProfileDropbox( this, nil )
		if( ifs_login_listbox_layout.SelectedIdx ) then
			RoundIFButtonLabel_fnSetUString( this.profile_button, ifs_login_listbox_contents[ifs_login_listbox_layout.SelectedIdx].showstr )		
		end
		if this.bCreateMode then
			-- restore diff button
			IFObj_fnSetVis(this.diff_button, 1)
			IFObj_fnSetVis(this.select_diff, 1)
		end
	elseif( this.bDiffDropBoxesOpen ) then
		if( gMouseListBox == this.diff_listbox ) then
			if( ifs_login_diff_listbox_layout.CursorIdx ) then
				ifs_login_diff_listbox_layout.SelectedIdx = ifs_login_diff_listbox_layout.CursorIdx
			end
--			print( "ifs_login_diff_listbox_layout.SelectedIdx = ", ifs_login_diff_listbox_layout.SelectedIdx )
		end
		ifs_login_fnShowDiffDropbox( this, nil )
		if( ifs_login_diff_listbox_layout.SelectedIdx ) then
			RoundIFButtonLabel_fnSetString( this.diff_button, ifs_login_diff_listbox_contents[ifs_login_diff_listbox_layout.SelectedIdx].showstr )		
		end	
	else
		-- open the drop box
		if( this.CurButton == "_profile_dropdown" ) then
			ifs_login_fnShowProfileDropbox( this, 1 )
			if this.bCreateMode then
				-- hide diff button
				IFObj_fnSetVis(this.diff_button, nil)
				IFObj_fnSetVis(this.select_diff, nil)
			end
		elseif( this.CurButton == "_diff_dropdown" ) then
			ifs_login_fnShowDiffDropbox( this, 1 )
		end
	end

	ifs_login_listbox_layout.LastSelectedIdx = ifs_login_listbox_layout.SelectedIdx or ifs_login_listbox_layout.LastSelectedIdx
end

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--local movie_background = "shell_main"
local image_background = "profile_manager"
--if( gPCBetaBuild ) then
--if(1) then
--	movie_background = nil
--	image_background = "iface_bg_2"
--end

ifs_login = NewIFShellScreen {
	bNohelptext = 1, -- we have our own
	bNohelptext_backPC = 1,
	movieIntro      = nil,         -- played before the screen is displayed
	movieBackground = nil, --movie_background, -- WAS "ifs_start", -- played while the screen is displayed
	music           = "shell_soundtrack",
    enterSound      = "",
    bg_texture = image_background,

--	title = NewIFText {
--		string = "ifs.profile.selection",
--		font = "gamefont_large",
--		y = 10,
--		textw = 460, -- center on screen. Fixme: do real centering!
--		ScreenRelativeX = 0.5, -- center
--		ScreenRelativeY = 0, -- top
--		nocreatebackground = 1, 
--	},

	Enter = function(this, bFwd)
		gIFShellScreenTemplate_fnEnter(this, bFwd) -- always call base class
--		print("ifs_login.Enter(",bFwd,")")

   		-- set pc profile & title version text
		UpdatePCTitleText(this)

		-- unselect the Accept button if it was selected last time we left the screen
		if(this.Helptext_Accept) then
			IFButton_fnSelect(this.Helptext_Accept, false, false)
		end
		if(this.Helptext_Delete) then
			IFButton_fnSelect(this.Helptext_Delete, false, false)
		end
		if(this.Helptext_Back) then
			IFButton_fnSelect(this.Helptext_Back, false, false)
		end
		if(this.Helptext_Create) then
			IFButton_fnSelect(this.Helptext_Create, false, false)
		end


		if( ScriptCB_IsPlayerLoggedIn() ) then
			ifelem_tabmanager_SelectTabGroup(this, 1, nil)
			ifelem_tabmanager_SetSelected(this, gPCMainTabsLayout, "_tab_profile")
		else
			ifelem_tabmanager_SelectTabGroup(this, nil, true)
			ifelem_tabmanager_SetSelected(this, gPCMinimizeQuitTabsLayout, nil, 1)
		end

		-- dimm tabs for PC Demo
		ifs_DimTabsPCDemo(this)

		-- allow mouse input
		this.listbox.bHidden = nil
		
		ifs_login_SetCreateVis(nil)

		-- done vis formatting stuff
		------------------------------

		-- do nothing if already logged in 
		if( this.TabsEnter and ScriptCB_IsPlayerLoggedIn() ) then
			this.TabsEnter = nil
			return
		end
		
		-- should we jump forward (this is the result of SaveAndExit)
		if(this.EnterThenExit) then
--			print("ifs_login.Enter: EnterThenExit")
			this.bGoToSP = 1
			this.EnterThenExit = nil
			ifs_login_Done()
			return
		end
		
		-- should we jump right to saveandexit?
		if(this.SaveAndExit) then
--			print("ifs_login.Enter: SaveAndExit")
			this.SaveAndExit = nil
			ifs_login_SaveAndExit()
		end

		-- init difficult dropdown listbox
		ListManager_fnFillContents(this.diff_listbox,ifs_login_diff_listbox_contents,ifs_login_diff_listbox_layout)
		IFObj_fnSetVis(this.Helptext_Delete, table.getn(ifs_login_listbox_contents) > 0)

--print("+++++1")
		-- set difficult
		local diff_id = ScriptCB_GetDifficulty() - 1
		if( diff_id < 1 ) then
			diff_id = 1
		end
--		print("select difficulty id = ", diff_id)
		ifs_login_diff_listbox_layout.SelectedIdx = diff_id
		RoundIFButtonLabel_fnSetString( this.diff_button, ifs_login_diff_listbox_contents[diff_id].showstr )
		IFObj_fnSetVis(this.diff_listbox,nil)
		
		-- returning from loadfilelist?
		if(this.EnterDoNothing) then
--			print("ifs_login.EnterDoNothing, return")
			this.EnterDoNothing = nil
			-- show this screen
			ifs_login_fnSetPieceVis(this, 1)

			-- print("Platform, count = ",gPlatformStr,table.getn(ifs_login_listbox_contents))

			-- If there's a name on the commandline, try and log that player in
			-- immediately
			local CmdNickStr,CmdEmailStr,CmdPassStr = ScriptCB_GetCmdlineLogin()
			if(CmdNickStr and (string.len(CmdNickStr) > 0)) then
				local i
				for i=1,table.getn(ifs_login_listbox_contents) do
					local TheirStr = ScriptCB_ununicode(ifs_login_listbox_contents[i].showstr)
					if(TheirStr == CmdNickStr) then
						ifs_login_listbox_layout.SelectedIdx = i
						ifs_login_listbox_layout.CursorIdx = i
						this.CurButton = "_accept"
						ListManager_fnFillContents(this.listbox,ifs_login_listbox_contents,ifs_login_listbox_layout)
						this.iForceLoginTime = 2
						this.iForceLoginIdx = i
--						
--print("+++++2")
						return
					end
				end

			end

			IFEditbox_fnSetUString(this.NewBox.nameedit, ScriptCB_GetUniqueLoginName())

			ifs_login_EnterInterface( this )
--print("+++++3")

			return
		end


		-- if we got here its because we've come from another screen, either forwards or
		-- backwards.  all internal looping (load/save/delete) should be handled by now.
		------------------------------
		-- is the player logged in?

		local CurPlayerIdx = ScriptCB_IsPlayerLoggedIn()		
		if(CurPlayerIdx) then
---			print("ifs_login.Enter already logged in.  go to SaveAndExit.")
			-- make sure that we always log out before coming backwards
			if(not bFwd) then
				print("ERROR: didn't log out before backing into ifs_login")
				assert(false)
			end
			
			-- if we're in the historical or metagame, we don't want to save here since
			-- we'll save when we get into the main screen.
			-- also don't save for netgame
			if(ScriptCB_IsMetagameStateSaved() or 
				 ScriptCB_IsCampaignStateSaved() or
					 ScriptCB_GetInTrainingMission() or
					 ScriptCB_InNetGame()) then
				ifs_login_Done()
--print("+++++4")				
				return
			end
			
			-- save it
			ifs_login_SaveAndExit()
--print("+++++5")			
			return
		end


		-------------------------------
		-- load the profile list

		ifs_login_StartLoadFileList()

		-- done enter
		---------------		
	end,

 	Exit = function(this, bFwd)
		if(not bFwd) then
			--ScriptCB_Logout()
			
			-- if we're going backwards from here, and the skiptontgui flag is set,
			-- its possible that while in NTGUI they switched mem cards, so the profile
			-- isn't there anymore, so the autoload failed, and the skip stopped here.  now
			-- they want to back out from here without completing the skip, so we need to
			-- clear the skip flag.
			ScriptCB_ResetSkipToNTGUI()
						
		end
		
		-- no more mouse input
		this.listbox.bHidden = 1
	end,

	Update = function(this, fDt)
		-- Call base class functionality
		gIFShellScreenTemplate_fnUpdate(this, fDt)

		if(this.iForceLoginTime) then
			this.iForceLoginTime = this.iForceLoginTime - 1
			if(this.iForceLoginTime <= 0) then
				this.iForceLoginTime = nil
--				print("Forcing login...")
				ifs_login_StartLoadProfile(ifs_login_listbox_contents[this.iForceLoginIdx].showstr,nil)
			end
		end

		if(ScriptCB_CheckForPatch) then
			local oldPatchStatus = iPatchStatus
			iPatchStatus = ScriptCB_CheckForPatch(2)
			if(iPatchStatus ~= oldPatchStatus) then
				if(iPatchStatus == 2) then
					Popup_Ok_Large.fnDone = ifs_login_PatchAvailableOK
					Popup_Ok_Large:fnActivate(1)
					gPopup_fnSetTitleStr(Popup_Ok_Large, "ifs.patch.available")
				end
			end
		end
	end,

	-- Override for the general back function, as we want to do nothing
	-- when this happens on this screen.
	Input_Back = function(this)
		if(this.bCreateMode) then
			ifs_login_SetCreateVis(nil)
			this.CurButton = ""
		else
			Popup_YesNo.CurButton = "no" -- default
			Popup_YesNo.fnDone = ifs_login_fnQuitPopupDone
			Popup_YesNo:fnActivate(1)
			gPopup_fnSetTitleStr(Popup_YesNo, "ifs.main.askquit")
		end
	end,

	Input_GeneralUp = function(this)
		-- If base class handled this work, then we're done
		if(gShellScreen_fnDefaultInputUp(this)) then
			return
		end

		if(gButtonMode == 1) then
			gDefault_Input_GeneralUp(this) -- do default behavior
		else
				ListManager_fnNavUp(this.listbox,ifs_login_listbox_contents,ifs_login_listbox_layout)
		end
	end,

	Input_LTrigger = function(this)
		if(gCurEditbox) then
			return
		end
		if(not gCurHiliteButton) then
			ListManager_fnPageUp(this.listbox,ifs_login_listbox_contents,ifs_login_listbox_layout)
		end
	end,

	Input_GeneralDown = function(this)
		-- If base class handled this work, then we're done
		if(gShellScreen_fnDefaultInputDown(this)) then
			return
		end

		if(gButtonMode == 1) then
			gDefault_Input_GeneralDown(this) -- do default behavior
		else
			ListManager_fnNavDown(this.listbox,ifs_login_listbox_contents,ifs_login_listbox_layout)
		end
	end,

	Input_RTrigger = function(this)
		if(gCurEditbox) then
			return
		end
		if(not gCurHiliteButton) then
			ListManager_fnPageDown(this.listbox,ifs_login_listbox_contents,ifs_login_listbox_layout)
		end
	end,

	-- Not possible on this screen
	Input_GeneralLeft = function(this)
  end,
	Input_GeneralRight = function(this)
  end,

	bStartedCreate = nil,
  Input_Accept = function(this)
--									 print("ifs_login, Input_Accept. CurButton = ", this.CurButton)
   		-- If the tab manager handled this event, then we're done
   		if(ifelem_tabmanager_HandleInputAccept(this, gPCMainTabsLayout)
   			or ifelem_tabmanager_HandleInputAccept(this, gPCMinimizeQuitTabsLayout, 1)) then
   			return
   		end
  
		-- click profile dropdown box
		ifs_login_fnClickDropDownButtons( this )
  
		-- If base class handled this work, then we're done
		if(gShellScreen_fnDefaultInputAccept(this)) then
			if(gMouseListBox) then
				if( gMouseListBox.Layout.SelectedIdx == gMouseListBox.Layout.CursorIdx and this.lastDoubleClickTime and ScriptCB_GetMissionTime()<this.lastDoubleClickTime+0.4) then
					this.lastDoubleClickTime = nil
					this.CurButton = "_accept"
				else
					this.lastDoubleClickTime = ScriptCB_GetMissionTime()
					if(gMouseListBox.Layout.CursorIdx) then
						gMouseListBox.Layout.SelectedIdx = gMouseListBox.Layout.CursorIdx
					end

					gMouseListBox.Layout.SelectedIdx = gMouseListBox.Layout.SelectedIdx or ifs_login_listbox_layout.LastSelectedIdx

					return 1 -- note we did all the work
				end
			else
				return
			end
		end

		if (this.CurButton == "_delete") then
			if(ifs_login_listbox_layout.SelectedIdx) then
				local gSelection = ifs_login_listbox_contents[ifs_login_listbox_layout.SelectedIdx]
				if( gSelection ) then
					ScriptCB_SndPlaySound("shell_menu_enter")
					Popup_YesNo.CurButton = "no" -- default
					Popup_YesNo.fnDone = ifs_login_fnDeletePopupDone
--					ifs_login_fnSetPieceVis(this, nil)
					Popup_YesNo:fnActivate(1)
					gPopup_fnSetTitleStr(Popup_YesNo, "ifs.Profile.confirm_delete")
				end
			end
		elseif (this.CurButton == "_rename") then
			-- rename the profile
			
		elseif (this.CurButton == "_create") then
			-- switch to create mode
			ifs_login_SetCreateVis(1)
		
		elseif (this.CurButton == "_accept") then --the only way to load a profile on the pc
			if gCurEditbox then
				local EnteredStr = IFEditbox_fnGetString(this.NewBox.nameedit)
				local trim = nil
				if(EnteredStr) then
					trim = ScriptCB_TrimLoginName(EnteredStr)
					EnteredStr = trim
				end
				if((not EnteredStr) or (string.len(EnteredStr) < 1)) then
					ScriptCB_SndPlaySound("shell_menu_error")
				else
					ifs_vkeyboard.CurString = ScriptCB_tounicode(EnteredStr)
					ifs_login_fnKeyboardDone()
				end
				ifs_login_SetCreateVis(nil)
				-- log out of Gamespy if logged in - fix #14078
				if( ScriptCB_IsLoggedIn() ) then
					ScriptCB_CancelLogin()
				end

			elseif (ifs_login_listbox_layout.SelectedIdx) then
				local gSelection = ifs_login_listbox_contents[ifs_login_listbox_layout.SelectedIdx]
				if(gSelection) then
--					print("***load a profile on the pc:",gSelection.showstr)
					ScriptCB_SndPlaySound("shell_menu_enter")

					-- log out of Gamespy if logged in - fix #14078
					if( ScriptCB_IsLoggedIn() ) then
						ScriptCB_CancelLogin()
					end

					ifs_login_StartLoadProfile(gSelection.showstr,nil)
				else
--					print("Yeah, you need to make a pop-up here")	
				end
			end
		else
			if(gButtonMode == 1) then
			
			else 
-- 				if(gOverSlider) then
					
-- 				elseif ( gMouseListBox ) then
-- 					print("They are trying to select something from the list")
-- 					gButtonMode = 1 
-- 					gSelection = ifs_login_listbox_contents[ifs_login_listbox_layout.SelectedIdx]
-- 					ShowHideVerticalButtons(this.buttons,ifslogin_vbutton_layout,0)
-- 					RoundIFButtonLabel_fnSetUString(this.buttons["dropdown"], ScriptCB_UnicodeStrCat( ScriptCB_tounicode("CURRENT PROFILE:")  ,gSelection.showstr) ) 
-- 					ifs_login_fnSetPieceVis(this, 1)	
-- 				else
-- 					print("They aren't over a list box and clicked the mouse button")
-- 					ShowHideVerticalButtons(this.buttons,ifslogin_vbutton_layout,0)
-- 					gButtonMode = 1
-- 					ifs_login_fnSetPieceVis(this, 1)	
-- 				end
			end
		end
	end,


	Input_KeyDown = function(this, iKey)

		if(gCurEditbox) then
			--print("Key = ", iKey)
			-- is this key allowed?
			local badchars = { 47, 92, 58, 42, 63, 34, 60, 62, 124, 44, }
							-- '/' '\' ':' '*' '?' '"' '<' '>' '|'  ','
			local n = table.getn(badchars)
			for i=1,n do
				if(badchars[i] == iKey) then
					ScriptCB_SndPlaySound("shell_menu_error")
					return
				end
			end
			
			
			if(iKey == 10 or iKey == 13) then -- handle Enter different
				this.iEnterCount = this.iEnterCount + 1
--				print("Doing enter accept", this.iEnterCount)
				-- Greg Johnson wants the second 'Enter' press to go forward. NM 9/20/05
				-- But, Jim overruled that. Back to 1 enter - NM 9/28/05
				if(this.iEnterCount >= 1) then
					-- press 'Enter'
					this.CurButton = "_accept"
					this:Input_Accept()
				end
			elseif( iKey == 27 ) then
				-- press 'Escape'
				this.CurButton = "_back"
				this:Input_Accept()				
			else
				IFEditbox_fnAddChar(gCurEditbox, iKey)
			end
		else
			if(iKey == 10 or iKey == 13) then -- handle Enter different
				this.CurButton = "_accept"
				this:Input_Accept()
			elseif iKey == -211 then
				this.CurButton = "_delete"
				this:Input_Accept()
			end
		end
	end,

	-- Pull in utility functions
	fnLoadProfilesDone = ifs_login_fnLoadProfilesDone,
	fnLoadFileListDone = ifs_login_fnLoadFileListDone,
	fnSaveProfileDone = ifs_login_fnSaveProfileDone,
	fnDeleteProfileDone = ifs_login_fnDeleteProfileDone,
}

function ifs_login_fnBuildScreen(this)
	local w,h = ScriptCB_GetSafeScreenInfo() -- of the usable screen
	local aw,ah = ScriptCB_GetScreenInfo()

	-- add pc profile & title version text
	AddPCTitleText( this )
	
	local action_h = h * 0.06
	
    local BackButtonW = 150
    local BackButtonH = 25
    
	this.Helptext_Create = NewPCIFButton -- NewRoundIFButton				
	{
		ScreenRelativeX = 0.5,
		ScreenRelativeY = 1.0,
		--x = -BackButtonW * 0.5,
		--y = -action_h,
		btnw = BackButtonW, -- made wider to fix 9173 - NM 8/25/04
		btnh = BackButtonH,
		font = "gamefont_small",
		--ColorR = 189, ColorG = 208, ColorB = 242,
		tag = "_create",
	}
	RoundIFButtonLabel_fnSetString( this.Helptext_Create, "ifs.profile.create" )
	
	this.Helptext_Accept = NewPCIFButton -- NewRoundIFButton			
	{
		ScreenRelativeX = 1.0,
		ScreenRelativeY = 1.0,
		x = -BackButtonW * 0.5,
		btnw = BackButtonW, -- made wider to fix 9173 - NM 8/25/04
		btnh = BackButtonH,
		font = "gamefont_small",
		--ColorR = 189, ColorG = 208, ColorB = 242,
		tag = "_accept",
	}
	RoundIFButtonLabel_fnSetString( this.Helptext_Accept, "common.accept" )

	this.Helptext_Delete = NewPCIFButton -- NewRoundIFButton
	{
		ScreenRelativeX = 0.0,
		ScreenRelativeY = 1.0,
		x = BackButtonW * 0.5,
		btnw = BackButtonW, -- made wider to fix 9173 - NM 8/25/04
		btnh = BackButtonH,
		font = "gamefont_small",
		--ColorR = 189, ColorG = 208, ColorB = 242,
		tag = "_delete",
	}
	RoundIFButtonLabel_fnSetString( this.Helptext_Delete, "ifs.profile.delete" )
	
	this.Helptext_Back = NewPCIFButton -- NewRoundIFButton
	{
		ScreenRelativeX = 0.0,
		ScreenRelativeY = 1.0,
		x = BackButtonW * 0.5,
		btnw = BackButtonW, -- made wider to fix 9173 - NM 8/25/04
		btnh = BackButtonH,
		font = "gamefont_small",
		--ColorR = 189, ColorG = 208, ColorB = 242,
		tag = "_back",
	}
	RoundIFButtonLabel_fnSetString( this.Helptext_Back, "common.cancel" )
	
--	this.Helptext_Rename = NewPCIFButton
--	{
--		ScreenRelativeX = 0.0,
--		ScreenRelativeY = 1.0,
--		x = BackButtonW * 0.5,
--		y = -action_h,
--		btnw = BackButtonW, -- made wider to fix 9173 - NM 8/25/04
--		btnh = 25,
--		font = "gamefont_small",
--		ColorR = 189, ColorG = 208, ColorB = 242,
--		tag = "_rename",
--		nocreatebackground=1,
--	}
--	RoundIFButtonLabel_fnSetString( this.Helptext_Rename, "ifs.profile.rename" )
	
	local input_box_y = 220
	local diff_box_y = 320
	local dropdown_width = 300	

	this.ProfileBox = NewButtonWindow 
	{ ZPos = 210, x=0, y = 0,
		ScreenRelativeX = 0.5, -- center
		ScreenRelativeY = 0.5, 
		width = 400,
		height = 300,
		titleText = "ifs.Main.profiles",
		--rotY = -35,
	}

	this.select_profile = NewIFText { 
		ScreenRelativeX = 0.5,
		ScreenRelativeY = 0,
		x = -140,
		y = input_box_y - 30,
		halign = "left",
		valign = "vcenter",
		font = "gamefont_tiny", 
		textw = 300,
		texth = 10,
		string = "ifs.Profile.title",
		nocreatebackground=1, 
	}

	this.profile_button = NewPCDropDownButton {
		ScreenRelativeX = 0.5,
		ScreenRelativeY = 0,
		y = input_box_y,
		x = 3,
		btnw = dropdown_width, -- made wider to fix 9173 - NM 8/25/04
		btnh = ScriptCB_GetFontHeight("gamefont_medium"),
		font = "gamefont_medium",
		tag = "_profile_dropdown",
		string = "",
	}
			
	this.listbox = NewButtonWindow 
	{ ZPos = 200, x=0, y = input_box_y + 70,
		ScreenRelativeX = 0.5, -- center
		ScreenRelativeY = 0, 
		bg_texture = "border_dropdown",
		width = ifs_login_listbox_layout.width + 35,
		height = ifs_login_listbox_layout.showcount * (ifs_login_listbox_layout.yHeight + ifs_login_listbox_layout.ySpacing) + 20,
		--titleText = "ifs.profile.selection",
		--rotY = -35,
	}

	ListManager_fnInitList(this.listbox,ifs_login_listbox_layout)

	this.select_diff = NewIFText { 
		ScreenRelativeX = 0.5,
		ScreenRelativeY = 0,
		x = -140,
		y = diff_box_y - 30,
		halign = "left",
		valign = "vcenter",
		font = "gamefont_tiny", 
		textw = 300,
		texth = 10,
		string = "ifs.difficulty.title",
		nocreatebackground=1, 
	}

	this.diff_button = NewPCDropDownButton {
		ScreenRelativeX = 0.5,
		ScreenRelativeY = 0,
		y = diff_box_y,
		x = 3,
		btnw = dropdown_width, -- made wider to fix 9173 - NM 8/25/04
		btnh = ScriptCB_GetFontHeight("gamefont_medium"),
		font = "gamefont_medium",
		tag = "_diff_dropdown",
		string = "",
	}

	this.diff_listbox = NewButtonWindow 
	{ ZPos = 200, x=0, y = diff_box_y + 40,
		ScreenRelativeX = 0.5, -- center
		ScreenRelativeY = 0, 
		bg_texture = "border_dropdown",
		width = ifs_login_diff_listbox_layout.width + 35,
		height = ifs_login_diff_listbox_layout.showcount * (ifs_login_diff_listbox_layout.yHeight + ifs_login_diff_listbox_layout.ySpacing) + 20,
		--titleText = "ifs.profile.selection",
		--rotY = -35,
	}
	ListManager_fnInitList(this.diff_listbox,ifs_login_diff_listbox_layout)
	ListManager_fnFillContents(this.diff_listbox,ifs_login_diff_listbox_contents,ifs_login_diff_listbox_layout)

	local EditBoxW = 300
	
	this.NewBox = NewIFContainer
	{
		ScreenRelativeX = 0.5, -- center
		ScreenRelativeY = 0, -- center
		y = input_box_y,
		--rotY = 35,

		nameedit = NewEditbox {
			width = EditBoxW,
			height = 40,
			font = "gamefont_medium",
			--		string = "Player 1",
			MaxLen = EditBoxW - 30,
			MaxChars = 15,
			bKeepsFocus = 1,
		},
	}

	-- Add tabs to screen
	ifelem_tabmanager_Create(this, gPCMainTabsLayout, gPCMinimizeQuitTabsLayout)

--	this.NewBox.btn.x = EditBoxW * -0.5
end


ifs_login_fnBuildScreen( ifs_login )
ifs_login_fnBuildScreen = nil

AddIFScreen(ifs_login,"ifs_login")
