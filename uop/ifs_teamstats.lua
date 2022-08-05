--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- Multiplayer game name screen.

-- Helper function. Given a layout (x,y,width, height), returns a
-- fully-built item.
function Teamstats_Listbox_CreateItem(layout)
	--print ("Teamstats_Listbox_CreateItem")
	local insidewidth = layout.width - 10;
	-- Make a coordinate system pegged to the top-left of where the cursor would go.
	local Temp = NewIFContainer {
		x = layout.x - 0.5 * insidewidth, y=layout.y + 1,
		bInertPos = 1,
	}

	local Font = teamstats_listbox_layoutL.font
	local FontHeight = teamstats_listbox_layoutL.fontheight
	local WidthPer = insidewidth * 0.125
	teamstats_listbox_layoutL.NameWidth = (insidewidth - WidthPer * 4) + 5 -- pixels we let name use

	Temp.labelstr = NewIFText {
		HScale = 0.8,
		VScale = 1,
		x = 2, y = FontHeight * -0.5 - 5, textw = insidewidth, -- Need full width, will manuall clamp later
		valign = "vcenter", texth = layout.height,
		clip = "character",
		halign = "left", font = Font,
		ColorR= 255, ColorG = 255, ColorB = 255,
		style = "normal",
		bInertPos = 1,
		nocreatebackground = 1,
		startdelay = math.random() * 0.25,
		inert_all = 1,
	}

	Temp.val1str = NewIFText{
		HScale = 0.8,
		VScale = 1,
		x = insidewidth - WidthPer * 4, y = FontHeight * -0.5 - 5,
		valign = "vcenter", texth = layout.height, -- ScriptCB_GetFontHeight("gamefont_tiny"),
		textw = WidthPer, halign = "right", font = Font,
		ColorR= 255, ColorG = 255, ColorB = 255,
		style = "normal",
		bInertPos = 1,
		nocreatebackground = 1,
		startdelay = math.random() * 0.25,
		inert_all = 1,
	}
	Temp.val2str = NewIFText{
		HScale = 0.8,
		VScale = 1,
		x = insidewidth - WidthPer * 3, y = FontHeight * -0.5 - 5, 
		valign = "vcenter", texth = layout.height, -- ScriptCB_GetFontHeight("gamefont_tiny"),
		textw = WidthPer, halign = "right", font = Font,
		ColorR= 255, ColorG = 255, ColorB = 255,
		style = "normal",
		bInertPos = 1,
		nocreatebackground = 1,
		startdelay = math.random() * 0.25,
		inert_all = 1,
	}
	Temp.val3str = NewIFText{ 
		HScale = 0.8,
		VScale = 1,
		x = insidewidth - WidthPer * 2, y = FontHeight * -0.5 - 5,
		valign = "vcenter", texth = layout.height, -- ScriptCB_GetFontHeight("gamefont_tiny"),
		textw = WidthPer, halign = "right", font = Font,
		ColorR= 255, ColorG = 255, ColorB = 255,
		style = "normal",
		bInertPos = 1,
		nocreatebackground = 1,
		startdelay = math.random() * 0.25,
		inert_all = 1,
	}
	Temp.val4str = NewIFText{ 
		HScale = 0.8,
		VScale = 1,
		x = insidewidth - WidthPer * 1, y = FontHeight * -0.5 - 5,
		valign = "vcenter", texth = layout.height, -- ScriptCB_GetFontHeight("gamefont_tiny"),
		textw = WidthPer, halign = "right", font = Font,
		ColorR= 255, ColorG = 255, ColorB = 255,
		style = "normal",
		bInertPos = 1,
		nocreatebackground = 1,
		startdelay = math.random() * 0.25,
		inert_all = 1,
	}
	return Temp
end

-- Helper function. For a destination item (previously created w/
-- CreateItem), fills it in with data, which may be nil (==blank it)
function Teamstats_Listbox_PopulateItem(Dest,Data)
	if(Data) then
		-- force the name into word clipping
--		IFText_fnSetTextBreak(Dest.labelstr,"none")
		-- Contents to show. Do so.
		local NameUStr = Data.labelustr
		IFText_fnSetString(Dest.val1str,Data.val1str)
		IFText_fnSetString(Dest.val2str,Data.val2str)
		IFText_fnSetString(Dest.val3str,Data.val3str)
		IFText_fnSetString(Dest.val4str,Data.val4str)

--		NameUStr = ScriptCB_tounicode("WWWWWWWWWWWWWWM")
-- 		IFText_fnSetString(Dest.val1str,"1111")
-- 		IFText_fnSetString(Dest.val2str,"2222")
-- 		IFText_fnSetString(Dest.val3str,"3333")
		
		-- Shrink font horizontally on name until it fits. This will make super-long
		-- XLive gamertags work even after they shoved in an extra column since BF1

		local TextHScale = 1.0
		IFText_fnSetScale(Dest.labelstr, TextHScale, 1.0)
		IFText_fnSetUString(Dest.labelstr,NameUStr)
		local fLeft, fTop, fRight, fBot = IFText_fnGetDisplayRect(Dest.labelstr)
		local TextW = fRight - fLeft
		-- Initial guess at scale: a very close fit
		TextHScale = math.min(1.0, teamstats_listbox_layoutL.NameWidth / TextW)
--		print("Initial TextHScale = ", TextHScale)
		repeat
			IFText_fnSetScale(Dest.labelstr, TextHScale, 1.0)
			IFText_fnSetUString(Dest.labelstr,NameUStr)
			fLeft, fTop, fRight, fBot = IFText_fnGetDisplayRect(Dest.labelstr)
			TextW = fRight - fLeft
			TextHScale = TextHScale * 0.95 -- shrink over time
--			print("Shrunk TextHScale to ", TextHScale)
		until (TextW < teamstats_listbox_layoutL.NameWidth)

		if(Data.ColorR) then
			IFObj_fnSetColor(Dest.labelstr,Data.ColorR,Data.ColorG,Data.ColorB)
			IFObj_fnSetColor(Dest.val1str,Data.ColorR,Data.ColorG,Data.ColorB)
			IFObj_fnSetColor(Dest.val2str,Data.ColorR,Data.ColorG,Data.ColorB)
			IFObj_fnSetColor(Dest.val3str,Data.ColorR,Data.ColorG,Data.ColorB)
			IFObj_fnSetColor(Dest.val4str,Data.ColorR,Data.ColorG,Data.ColorB)
		end
		
		-- set points to yellow
		IFObj_fnSetColor(Dest.val1str,255,255,0)
	end

	IFObj_fnSetVis(Dest,Data) -- Show if there are contents
	
	-- if the cpp == -1, then don't show this entry (its padding)
	if(Data and Data.val3str == "-1") then
		IFObj_fnSetVis(Dest,nil)
	end
	
end

-- Helper function. Given a layout (x,y,width, height), returns a
-- fully-built item.
function Teamstats_AwardsListbox_CreateItem(layout)
	--print ("Teamstats_AwardsListbox_CreateItem")
	local insidewidth = layout.width - 10;
	-- Make a coordinate system pegged to the top-left of where the cursor would go.
	local Temp = NewIFContainer {
		x = layout.x - 0.5 * insidewidth, y=layout.y + 1,
		bInertPos = 1,
	}

	local Font = teamstats_awardsListbox_layoutL.font
	local FontHeight = teamstats_awardsListbox_layoutL.fontheight
	local WidthPer = insidewidth * 0.125
	teamstats_awardsListbox_layoutL.NameWidth = 0.5 * insidewidth - 5  -- pixels we let name use

	Temp.labelustr = NewIFText {
		HScale = 0.8,
		VScale = 1,
		x = 2, y = FontHeight * -0.5, textw = insidewidth, -- Need full width, will manually clamp later
		valign = "vcenter", texth = layout.height,
		clip = "character",
		halign = "left", font = Font,
		ColorR= 255, ColorG = 255, ColorB = 255,
		style = "normal",
		bInertPos = 1,
		nocreatebackground = 1,
		startdelay = math.random() * 0.25,
		inert_all = 1,
	}

	Temp.contentsustr = NewIFText{
		HScale = 0.8,
		VScale = 1,
		--x = insidewidth - WidthPer * 4, y = FontHeight * -0.5,
		x = 0, y = FontHeight * -0.5,
		valign = "vcenter", texth = layout.height, -- ScriptCB_GetFontHeight("gamefont_tiny"),
		textw = insidewidth, halign = "right", font = Font,
		ColorR= 255, ColorG = 255, ColorB = 255,
		style = "normal",
		bInertPos = 1,
		nocreatebackground = 1,
		startdelay = math.random() * 0.25,
		inert_all = 1,
	}
	return Temp
end

-- Helper function. For a destination item (previously created w/
-- CreateItem), fills it in with data, which may be nil (==blank it)
function Teamstats_AwardsListbox_PopulateItem(Dest,Data)
	--print ("Teamstats_AwardsListbox_PopulateItem")

	if (Data) then
		-- force the name into word clipping
--		IFText_fnSetTextBreak(Dest.labelustr,"none")
		-- Contents to show. Do so.
		local NameUStr = Data.labelustr
		--IFText_fnSetUString(Dest.contentsustr,Data.contentsustr)
		ifs_careerstats_fnShrinkToFit(Dest.contentsustr, Data.contentsustr, teamstats_awardsListbox_layoutL.NameWidth)

		-- Shrink font horizontally on name until it fits. This will make super-long
		-- XLive gamertags work even after they shoved in an extra column since BF1

		local TextHScale = 1.0
		IFText_fnSetScale(Dest.labelustr, TextHScale, 1.0)
		IFText_fnSetUString(Dest.labelustr,NameUStr)
		local fLeft, fTop, fRight, fBot = IFText_fnGetDisplayRect(Dest.labelustr)
		local TextW = fRight - fLeft
		-- Initial guess at scale: a very close fit
		TextHScale = math.min(1.0, teamstats_awardsListbox_layoutL.NameWidth / TextW)
--		print("Initial TextHScale = ", TextHScale)
		repeat
			IFText_fnSetScale(Dest.labelustr, TextHScale, 1.0)
			IFText_fnSetUString(Dest.labelustr,NameUStr)
			fLeft, fTop, fRight, fBot = IFText_fnGetDisplayRect(Dest.labelustr)
			TextW = fRight - fLeft
			TextHScale = TextHScale * 0.95 -- shrink over time
--			print("Shrunk TextHScale to ", TextHScale)
		until (TextW < teamstats_awardsListbox_layoutL.NameWidth)

		if(Data.ColorR) then
			IFObj_fnSetColor(Dest.labelustr,Data.ColorR,Data.ColorG,Data.ColorB)
			IFObj_fnSetColor(Dest.contentsustr,Data.ColorR,Data.ColorG,Data.ColorB)
		end
		
		-- set points to yellow
		IFObj_fnSetColor(Dest.contentsustr,255,255,0)
	end

	IFObj_fnSetVis(Dest,Data) -- Show if there are contents
	
	-- if the cpp == -1, then don't show this entry (its padding)
	--if(Data and Data.val3str == "-1") then
	--	IFObj_fnSetVis(Dest,nil)
	--end
	
end



teamstats_listbox_layoutL = {
--	showcount = 20, -- filled in from code later
	yTop = -63,
	yHeight = 26,
	ySpacing = -6,
-- 	width = 430, -- filled in from code later
	x = 0,
--	slider = 1,
	font = "gamefont_tiny",
	CreateFn = Teamstats_Listbox_CreateItem,
	PopulateFn = Teamstats_Listbox_PopulateItem,
}

teamstats_listbox_layoutR = {
--	showcount = 20, -- filled in from code later
	yTop = -63,
	yHeight = 26,
	ySpacing = -6,
-- 	width = 430, -- filled in from code later
	x = 0,
--	slider = 1,
	font = "gamefont_tiny",
	CreateFn = Teamstats_Listbox_CreateItem,
	PopulateFn = Teamstats_Listbox_PopulateItem,
}

teamstats_awardsListbox_layoutL = {
	yHeight = 15,
	ySpacing = 1,
	x = 0,
	font = "gamefont_tiny",
	CreateFn = Teamstats_AwardsListbox_CreateItem,
	PopulateFn = Teamstats_AwardsListbox_PopulateItem,
}

teamstats_awardsListbox_layoutR = {
	yHeight = 15,
	ySpacing = 1,
	x = 0,
	font = "gamefont_tiny",
	CreateFn = Teamstats_AwardsListbox_CreateItem,
	PopulateFn = Teamstats_AwardsListbox_PopulateItem,
}

function ifs_teamstats_fnFillContents(this)
	-- Reset listbox, show it. [Remember, Lua starts at 1!]
	local playerIdxL,playerIdxR
	playerIdxR = ScriptCB_GetTeamstats(1)
	playerIdxL = ScriptCB_GetTeamstats(0)
	if(this.SetCursorToPlayer) then
		if(playerIdxL >= 0) then
			this.bCursorOnLeft = 1
			teamstats_listbox_layoutL.CursorIdx = playerIdxL + 1
			teamstats_listbox_layoutL.SelectedIdx = playerIdxL + 1
			teamstats_listbox_layoutL.FirstShownIdx = math.max(playerIdxL-4,1)
			teamstats_listbox_layoutR.CursorIdx = nil
			teamstats_listbox_layoutR.SelectedIdx = playerIdxL + 1
			teamstats_listbox_layoutR.FirstShownIdx = math.max(playerIdxL-4,1)
		end
		if(playerIdxR >= 0) then
			this.bCursorOnLeft = nil
			teamstats_listbox_layoutL.CursorIdx = nil
			teamstats_listbox_layoutL.SelectedIdx = playerIdxR + 1
			teamstats_listbox_layoutL.FirstShownIdx = math.max(playerIdxR-4,1)
			teamstats_listbox_layoutR.CursorIdx = playerIdxR + 1
			teamstats_listbox_layoutR.SelectedIdx = playerIdxR + 1
			teamstats_listbox_layoutR.FirstShownIdx = math.max(playerIdxR-4,1)
		end
	end
	teamstats_awardsListbox_layoutL.CursorIdx = nil
	teamstats_awardsListbox_layoutR.CursorIdx = nil
	
	ListManager_fnFillContents(this.LeftList,teamstats_listbox_contentsL,teamstats_listbox_layoutL)
	ScriptCB_GetTeamstats(1)
	ListManager_fnFillContents(this.RightList,teamstats_listbox_contentsR,teamstats_listbox_layoutR)
	ScriptCB_GetAwardStats(0)
	ListManager_fnFillContents(this.awardsLeftList,teamstats_awardsListbox_contentsL,teamstats_awardsListbox_layoutL)
	ScriptCB_GetAwardStats(1)
	ListManager_fnFillContents(this.awardsRightList,teamstats_awardsListbox_contentsR,teamstats_awardsListbox_layoutR)
end

-- Helper function, blanks out the onscreen contents. Used to keep the
-- glyphcache from overloading.
function ifs_teamstats_fnBlankContents(this)
	local i,Max

	local BlankUStr = ScriptCB_tounicode("")

	Max = table.getn(teamstats_listbox_contentsL)
	for i=1,Max do
		teamstats_listbox_contentsL[i].labelustr = BlankUStr
		teamstats_listbox_contentsL[i].val1str = ""
		teamstats_listbox_contentsL[i].val2str = ""
		teamstats_listbox_contentsL[i].val3str = ""
		teamstats_listbox_contentsL[i].val4str = ""
	end

	Max = table.getn(teamstats_listbox_contentsR)
	for i=1,Max do
		teamstats_listbox_contentsR[i].labelustr = BlankUStr
		teamstats_listbox_contentsR[i].val1str = ""
		teamstats_listbox_contentsR[i].val2str = ""
		teamstats_listbox_contentsR[i].val3str = ""
		teamstats_listbox_contentsR[i].val4str = ""
	end
	if ( teamstats_awardsListbox_contentsL ) then
		Max = table.getn(teamstats_awardsListbox_contentsL)
		for i=1,Max do
			teamstats_awardsListbox_contentsL[i].labelustr = BlankUStr
			teamstats_awardsListbox_contentsL[i].contentsustr = ""
		end
	else
		print ("ifs_teamstats_fnBlankContents: teamstats_awardsListbox_contentsL == nil")
	end

	if ( teamstats_awardsListbox_contentsR ) then
		Max = table.getn(teamstats_awardsListbox_contentsR)
		for i=1,Max do
			teamstats_awardsListbox_contentsR[i].labelustr = BlankUStr
			teamstats_awardsListbox_contentsR[i].contentsustr = ""
		end
	else
		print ("ifs_teamstats_fnBlankContents: teamstats_awardsListbox_contentsR == nil")
	end

	-- Repaint
	ListManager_fnFillContents(this.LeftList,teamstats_listbox_contentsL,teamstats_listbox_layoutL)
	ListManager_fnFillContents(this.RightList,teamstats_listbox_contentsR,teamstats_listbox_layoutR)
	ListManager_fnFillContents(this.awardsLeftList,teamstats_awardsListbox_contentsL,teamstats_awardsListbox_layoutL)
	ListManager_fnFillContents(this.awardsRightList,teamstats_awardsListbox_contentsR,teamstats_awardsListbox_layoutR)
end

teamstats_listbox_contents = {}

teamstats_listbox_contentsL = {
	-- Filled in from C++
	-- Stubbed to show the string.format it wants.
--	{ labelustr = "Player 1", contentsustr = "5"},
-- **OR**
--	{ labelustr = " Favorite Vehicle", contentsustr = "AT-ST"}, 
}

teamstats_listbox_contentsR = {
	-- Filled in from C++
	-- Stubbed to show the string.format it wants.
--	{ labelustr = "Player 1", contentsustr = "5"},
-- **OR**
--	{ labelustr = " Favorite Vehicle", contentsustr = "AT-ST"}, 
}

teamstats_awardsListbox_contentsL = {}
teamstats_awardsListbox_contentsR = {}

function ifs_teamstats_fnFlipLeftRight(this)
	this.bCursorOnLeft = not this.bCursorOnLeft

	-- Flip the selections/cursor positions
	if(this.bCursorOnLeft) then
		-- Was just on the right, now on left
		local Pos = teamstats_listbox_layoutR.SelectedIdx

		-- make sure the position isn't off the bottom of the listbox
		Pos = ScriptCB_TeamStatsValidatePos( 0, Pos );
		
		teamstats_listbox_layoutL.CursorIdx = Pos
		teamstats_listbox_layoutR.CursorIdx = nil
		teamstats_listbox_layoutL.SelectedIdx = Pos
		teamstats_listbox_layoutR.SelectedIdx = Pos

		ListManager_fnFillContents(this.LeftList,teamstats_listbox_contentsL,teamstats_listbox_layoutL)
		ListManager_fnFillContents(this.RightList,teamstats_listbox_contentsR,teamstats_listbox_layoutR)
		-- Just move cursor on side that's now dim
		ListManager_fnMoveCursor(this.RightList,teamstats_listbox_layoutR)
	else
		-- Was just on the left, now on right
		local Pos = teamstats_listbox_layoutL.SelectedIdx

		-- make sure the position isn't off the bottom of the listbox
		Pos = ScriptCB_TeamStatsValidatePos( 1, Pos );
		
		teamstats_listbox_layoutR.CursorIdx = Pos
		teamstats_listbox_layoutL.CursorIdx = nil
		teamstats_listbox_layoutR.SelectedIdx = Pos
		teamstats_listbox_layoutL.SelectedIdx = Pos

		ListManager_fnFillContents(this.LeftList,teamstats_listbox_contentsL,teamstats_listbox_layoutL)
		ListManager_fnFillContents(this.RightList,teamstats_listbox_contentsR,teamstats_listbox_layoutR)
		-- Just move cursor on side that's now dim
		ListManager_fnMoveCursor(this.LeftList,teamstats_listbox_layoutL)
	end
end

--validate the cursor position (make sure we're not on a null entry)
function ifs_teamstats_fnValidateCursor(this)
	local Pos = teamstats_listbox_layoutL.SelectedIdx
	if(this.bCursorOnLeft) then
		Pos = ScriptCB_TeamStatsValidatePos( 0, Pos );
	else
		Pos = ScriptCB_TeamStatsValidatePos( 1, teamstats_listbox_layoutR.SelectedIdx );
	end
	
	--set the cursor to the validated position
	teamstats_listbox_layoutL.SelectedIdx = Pos
	teamstats_listbox_layoutR.SelectedIdx = Pos

	if(this.bCursorOnLeft) then		
		teamstats_listbox_layoutL.CursorIdx = Pos
		teamstats_listbox_layoutR.CursorIdx = nil
	else
		teamstats_listbox_layoutL.CursorIdx = nil
		teamstats_listbox_layoutR.CursorIdx = Pos
	end
	ListManager_fnMoveCursor(this.LeftList,teamstats_listbox_layoutL)
	ListManager_fnMoveCursor(this.RightList,teamstats_listbox_layoutR)
end

-- turn the selected item gSelectedTextColor (currently blue)
function ifs_teamstats_fnUpdateTeamSelection(this)
	--print ("ifs_teamstats_fnUpdateTeamSelection")
	if (this.bCursorOnLeft) then
		local cursorIdx = teamstats_listbox_layoutL.CursorIdx
		local firstShownIdx = teamstats_listbox_layoutL.FirstShownIdx
		if ( cursorIdx and gSelectedTextColor ) then
			--if ( not this.LeftList[cursorIdx] ) then
			--	print ("not this.LeftList[cursorIdx]", cursorIdx, teamstats_listbox_layoutL.SelectedIdx, teamstats_listbox_layoutR.FirstShownIdx)
			--else print ("this.leftlist[cursoridx]")
			--end
			
			IFObj_fnSetColor(this.LeftList[cursorIdx-firstShownIdx+1].labelstr, gSelectedTextColor[1], gSelectedTextColor[2], gSelectedTextColor[3])
		end
	else
		local cursorIdx = teamstats_listbox_layoutR.CursorIdx
		local firstShownIdx = teamstats_listbox_layoutR.FirstShownIdx
		if ( cursorIdx and gSelectedTextColor ) then
			--if ( not this.RightList[cursorIdx] ) then
			--	print ("not this.RightList[cursorIdx]", cursorIdx)
			--else print ("this.RightList[cursoridx]") end
			IFObj_fnSetColor(this.RightList[cursorIdx-firstShownIdx+1].labelstr, gSelectedTextColor[1], gSelectedTextColor[2], gSelectedTextColor[3])
		end
	end
end

ifs_teamstats = NewIFShellScreen {
	nologo = 1,
	fMAX_IDLE_TIME = 30.0,
	fCurIdleTime = 0,
	movieIntro      = nil, -- played before the screen is displayed
	movieBackground = nil, -- played while the screen is displayed
	bAcceptIsSelect = 1,
	bNohelptext_back = 1, -- We use PS2-Square/XBox-X to exit this screen.

--	title = NewIFText {
--		string = "ifs.stats.teamstatstitle",
--		font = "gamefont_large",
--		y = 0,
--		textw = 460, -- center on screen. Fixme: do real centering!
--		ScreenRelativeX = 0.5, -- center
--		ScreenRelativeY = 0, -- top
--		ColorR= 255, ColorG = 255, ColorB = 255, -- Something that's readable!
--	},

	titleTeamStats = NewIFText {
		string = "ifs.stats.teamstatstitle",
		font = "gamefont_medium",
		ScreenRelativeX = 0.5,
		ScreenRelativeY = 0.017,
		textw = 150,
		ColorR= gTitleTextColor[1], ColorG = gTitleTextColor[2], ColorB = gTitleTextColor[3], -- Something that's readable!
		style = "normal",
		--nocreatebackground = 1,
		halign = "hcenter",
		bgleft = "bf2_buttons_topleft",
		bgmid = "bf2_buttons_title_center",
		bgright = "bf2_buttons_topright",
		bg_width = 460, 
	},
	
	titleAwards = NewIFText {
		string = "ifs.stats.awards",
		font = "gamefont_medium",
		ScreenRelativeX = 0.5,
		ScreenRelativeY = 0.637,
		textw = 350,
		ColorR= gTitleTextColor[1], ColorG = gTitleTextColor[2], ColorB = gTitleTextColor[3], -- Something that's readable!
		style = "normal",
		--nocreatebackground = 1,
		halign = "hcenter",
		bgleft = "bf2_buttons_topleft",
		bgmid = "bf2_buttons_title_center",
		bgright = "bf2_buttons_topright",
		bg_width = 460, 
	},
	
	bgTexture = NewIFImage { 
		ZPos = 250,
		ScreenRelativeX = 0,
		ScreenRelativeY = 0,
		UseSafezone = 0,
		texture = "statsscreens_bg", 
		localpos_l = 0,
		localpos_t = 0,
		-- Size, UVs aren't fully specified here, but in NewIFShellScreen()
	},


	bCursorOnLeft = 1,

	Enter = function(this, bFwd)
		gIFShellScreenTemplate_fnEnter(this, bFwd) -- call default enter function

		-- if we're in MP and the client never received stats, just skip the stats and go
		-- back to the shell now
		if(not ScriptCB_ClientGotStats()) then
			ScriptCB_QuitFromStats()
			ScriptCB_SndPlaySound("shell_menu_exit");
			return
		end

		if(this.Helptext_Accept ~= nil) then
			IFText_fnSetString(this.Helptext_Accept.helpstr,"ifs.stats.personalstatstitle")
			gHelptext_fnMoveIcon(this.Helptext_Accept)
		end

		if(bFwd) then
			-- Horrible hack -- We need the memory on the PS2 for the stats,
			-- and the only way to get that now is to kick some screens out of
			-- memory.
			if(gPlatformStr == "PS2") then
--				ifs_pausemenu = nil -- die if we ever exit out of here.
				ifs_opt_controller = nil -- we need memory, NOW
				ifs_mp_lobby = nil -- we need memory, NOW			
				ifs_sideselect = nil
				ifs_charselect = nil
				ifs_mapselect = nil
				ifs_readyselect = nil
				ifs_fakeconsole = nil
			end
			this.bCursorOnLeft = 1
			teamstats_listbox_layoutL.FirstShownIdx = 1
			teamstats_listbox_layoutR.FirstShownIdx = 1
			teamstats_listbox_layoutL.SelectedIdx = 1
			teamstats_listbox_layoutR.SelectedIdx = 1
			teamstats_listbox_layoutL.CursorIdx = 1
			teamstats_listbox_layoutR.CursorIdx = nil
			
			this.SetCursorToPlayer = 1
		end
		ifs_teamstats_fnFillContents(this)
		this.SetCursorToPlayer = nil
		ifs_teamstats_fnUpdateTeamSelection(this)
		
		this.fCurIdleTime = this.fMAX_IDLE_TIME

		if(gE3Build) then
			if(ScriptCB_GetAmHost()) then
				gE3StatsTimeout = 15
			else
				gE3StatsTimeout = 20
			end
		else
			gE3StatsTimeout = 0 -- can quit right away
		end
		
		if(gPlatformStr == "PC") then --quickee hack for PC
			gE3StatsTimeout = 0 
		end

		if((ScriptCB_InNetGame()) and (ScriptCB_GetGameRules() == "metagame") and (ScriptCB_GetAmHost())) then
			this.fCurIdleTime = 0
			gE3StatsTimeout = 0
		end
	end,

	Exit = function(this, bFwd)
		-- Reduce lua memory, glyphcache usage
		ifs_teamstats_fnBlankContents(this)
		teamstats_listbox_contents = nil
		teamstats_listbox_contentsL = nil
		teamstats_listbox_contentsR = nil
		teamstats_awardsListbox_contents = nil
		teamstats_awardsListbox_contentsL = nil
		teamstats_awardsListbox_contentsR = nil
	end,

	-- Accept button bumps the page
	Input_Accept = function(this)

		if(this.bCursorOnLeft) then
			ifs_personalstats.fTeam = 1
			ifs_personalstats.fIdx = teamstats_listbox_layoutL.SelectedIdx
		else
			ifs_personalstats.fTeam = 2
			ifs_personalstats.fIdx = teamstats_listbox_layoutR.SelectedIdx
		end
        ifs_movietrans_PushScreen(ifs_personalstats)
		ScriptCB_SndPlaySound("shell_menu_enter");
		this.fCurIdleTime = this.fMAX_IDLE_TIME 
	end,

	-- Misc ( == PS2-Square/XBox-X) button quits stats
	Input_Misc = function(this)
		if(ScriptCB_CanClientLeaveStats()) then
			this.fCurIdleTime = this.fMAX_IDLE_TIME 
			if(not gE3StatsTimeout or gE3StatsTimeout < 0) then
				ScriptCB_QuitFromStats()
				ScriptCB_SndPlaySound("shell_menu_exit");
			end
		end
	end,

	--Back button quits stats
	Input_Back = function(this)
		this.fCurIdleTime = this.fMAX_IDLE_TIME 
		--ScriptCB_PopScreen()
		--ScriptCB_SndPlaySound("shell_menu_exit");
	end,

	-- No U/D/L/R functionality possible on this screen (gotta have stubs
	-- here, or the base class will override)

	Input_GeneralUp = function(this)
		this.fCurIdleTime = this.fMAX_IDLE_TIME 
		ListManager_fnNavUp(this.LeftList,teamstats_listbox_contentsL,teamstats_listbox_layoutL)
		ListManager_fnNavUp(this.RightList,teamstats_listbox_contentsR,teamstats_listbox_layoutR)
		ifs_teamstats_fnUpdateTeamSelection(this)
		ifs_teamstats_fnValidateCursor(this)
	end,
	Input_GeneralDown = function(this)
		this.fCurIdleTime = this.fMAX_IDLE_TIME 
		ListManager_fnNavDown(this.LeftList,teamstats_listbox_contentsL,teamstats_listbox_layoutL)
		ListManager_fnNavDown(this.RightList,teamstats_listbox_contentsR,teamstats_listbox_layoutR)
		--validate the cursor position (make sure we're not on a null entry)
		ifs_teamstats_fnValidateCursor(this)
		ifs_teamstats_fnUpdateTeamSelection(this)
	end,

	Input_LTrigger = function(this)
		this.fCurIdleTime = this.fMAX_IDLE_TIME 
		ListManager_fnPageUp(this.LeftList,teamstats_listbox_contentsL,teamstats_listbox_layoutL)
		ListManager_fnPageUp(this.RightList,teamstats_listbox_contentsR,teamstats_listbox_layoutR)
		ifs_teamstats_fnUpdateTeamSelection(this)
		ifs_teamstats_fnValidateCursor(this)
	end,
	Input_RTrigger = function(this)
		this.fCurIdleTime = this.fMAX_IDLE_TIME 
		ListManager_fnPageDown(this.LeftList,teamstats_listbox_contentsL,teamstats_listbox_layoutL)
		ListManager_fnPageDown(this.RightList,teamstats_listbox_contentsR,teamstats_listbox_layoutR)
		--validate the cursor position (make sure we're not on a null entry)
		ifs_teamstats_fnValidateCursor(this)
		ifs_teamstats_fnUpdateTeamSelection(this)
	end,

	Input_GeneralLeft = function(this)
		this.fCurIdleTime = this.fMAX_IDLE_TIME 
		ifs_teamstats_fnFlipLeftRight(this)
		ScriptCB_SndPlaySound("shell_select_change");
		ifs_teamstats_fnUpdateTeamSelection(this)
		ifs_teamstats_fnValidateCursor(this)
	end,
	Input_GeneralRight = function(this)
		this.fCurIdleTime = this.fMAX_IDLE_TIME 
		ifs_teamstats_fnFlipLeftRight(this)
		ScriptCB_SndPlaySound("shell_select_change");
		ifs_teamstats_fnUpdateTeamSelection(this)
		ifs_teamstats_fnValidateCursor(this)
	end,

	Update = function(this, fDt)
		-- Call default base class's update function (make button bounce)
		gIFShellScreenTemplate_fnUpdate(this,fDt)

		-- If the host is busy, then wait on this screen
		if(fDt > 0.5) then
			fDt = 0.5 -- clamp this to sane values
		end

		if(ScriptCB_CanClientLeaveStats()) then
			gE3StatsTimeout = 0 -- allow quit now
			if(this.Helptext_Done) then
				IFObj_fnSetVis(this.Helptext_Done, 1) -- show helptext
			end
		else
			gE3StatsTimeout = 1 -- keep clients from leaving
			if(this.Helptext_Done) then
				IFObj_fnSetVis(this.Helptext_Done, nil) -- hide helptext
			end
		end

		if(gE3StatsTimeout) then
			gE3StatsTimeout = gE3StatsTimeout - fDt
		end

		-- if we've been sitting here for a while, bail to the teaser screen
		this.fCurIdleTime = this.fCurIdleTime - fDt
		if((this.fCurIdleTime < 0) and (not gE3StatsTimeout or gE3StatsTimeout < 0)) then
			this.fCurIdleTime = 100
			ScriptCB_QuitFromStats()
			ScriptCB_SndPlaySound("shell_menu_exit");
		end
 	end,


	-- Callback (from C++) to repaint the listbox with the current contents
	-- in the global teamstats_listbox_contents
	RepaintListbox = function(this, bOnLeft)
		--print ("RepaintListbox")
  		if(bOnLeft ) then
			teamstats_listbox_layoutR.CursorIdx = nil
		else
			teamstats_listbox_layoutL.CursorIdx = nil
		end
		ListManager_fnFillContents(this.LeftList,teamstats_listbox_contentsL,teamstats_listbox_layoutL)
		ListManager_fnFillContents(this.RightList,teamstats_listbox_contentsR,teamstats_listbox_layoutR)
		ListManager_fnFillContents(this.awardsLeftList,teamstats_awardsListbox_contentsL,teamstats_awardsListbox_layoutL)
		ListManager_fnFillContents(this.awardsRightList,teamstats_awardsListbox_contentsR,teamstats_awardsListbox_layoutR)
	 end,	

}

-- Helper function, sets up parts of this screen that need any
-- programmatic work (i.e. scaling to screensize)
function ifs_teamstats_fnBuildScreen(this)
	-- Ask game for screen size, fill in values
	local r, b, v, widescreen = ScriptCB_GetScreenInfo()
	this.bgTexture.localpos_l = 0
	this.bgTexture.localpos_t = 0
	this.bgTexture.localpos_r = r*widescreen
	this.bgTexture.localpos_b = b
	this.bgTexture.uvs_b = v

	--if(this.Helptext_Back) then
	--	IFText_fnSetString(this.Helptext_Back.helpstr,"ifs.stats.back")
	--end

	if(gPlatformStr ~= "PC") then
		this.Helptext_Done = NewHelptext {
			ScreenRelativeX = 0.0, -- left
			ScreenRelativeY = 1.0, -- bottom
			y = -15, -- just above bottom
			x = 0,
			buttonicon = "btnmisc",
			string = "ifs.stats.done",
		}
	end

	-- Inset slightly from fulls screen size
	local w,h = ScriptCB_GetSafeScreenInfo()
--	w = w * 0.95
	--h = h * 0.82

	this.listbox = NewButtonWindow { ZPos = 200, x=0, y = 0,
		ScreenRelativeX = 0.5, -- center
		ScreenRelativeY = 0.345, -- top part of screen
		width = w,
		height = h * 0.54,
	}

	-- Cut width in half for 2-column layout, make containers to drop them into
	w = w * 0.5
	this.LeftList = NewIFContainer {
		ScreenRelativeX = 0.5,
		ScreenRelativeY = 0.32,
		x =-w * 0.5
	}
	this.RightList = NewIFContainer {
		ScreenRelativeX = 0.5,
		ScreenRelativeY = 0.32,
		x = w * 0.5
	}

	-- awards
	this.awardsListbox = NewButtonWindow { ZPos = 200, x=0, y = 0,
		ScreenRelativeX = 0.5, -- center
		ScreenRelativeY = 0.805, -- bottom part of screen
		width = w * 2,
		height = h * 0.22,
	}
	
	this.awardsLeftList = NewIFContainer {
		ScreenRelativeX = 0.5,
		ScreenRelativeY = 0.805,
		x =-w * 0.5
	}

	this.awardsRightList = NewIFContainer {
		ScreenRelativeX = 0.5,
		ScreenRelativeY = 0.805,
		x = w * 0.5
	}

	local offset_x = 0.062
	local offset_w = 0.120

	this.LeftList.ColumnHeader1 = NewIFImage {
		x = w * (offset_x + 0*offset_w), y = h * -0.22,
		texture = "points", -- .tga assumed
		localpos_r = w*0.07, localpos_b = h*0.04,
		inert = 1,
	}
	this.LeftList.ColumnHeader2 = NewIFImage {
		x = w * (offset_x + 1*offset_w), y = h * -0.22,
		texture = "stats_kills", -- .tga assumed
		localpos_r = w*0.07, localpos_b = h*0.04,
		inert = 1,
	}
	this.LeftList.ColumnHeader3 = NewIFImage {
		x = w * (offset_x + 2*offset_w), y = h * -0.22,
		texture = "stats_deaths", -- .tga assumed
		localpos_r = w*0.07, localpos_b = h*0.04,
		inert = 1,
	}
	this.LeftList.ColumnHeader4 = NewIFImage {
		x = w * (offset_x + 3*offset_w), y = h * -0.22,
		texture = "stats_flags", -- .tga assumed
		localpos_r = w*0.07, localpos_b = h*0.04,
		inert = 1,
	}
	this.LeftList.TeamIcon = NewIFImage {
		x = -w * 0.3, y = h * -0.22,
		texture = "stats_cpp", -- .tga assumed
		localpos_r = w*0.07, localpos_b = h*0.04,
		inert = 1,
	}

	this.RightList.ColumnHeader1 = NewIFImage {
		x = w * (offset_x + 0*offset_w), y = h * -0.22,
		texture = "points", -- .tga assumed
		localpos_r = w*0.07, localpos_b = h*0.04,
		inert = 1,
	}
	this.RightList.ColumnHeader2 = NewIFImage {
		x = w * (offset_x + 1*offset_w), y = h * -0.22,
		texture = "stats_kills", -- .tga assumed
		localpos_r = w*0.07, localpos_b = h*0.04,
		inert = 1,
	}
	this.RightList.ColumnHeader3 = NewIFImage {
		x = w * (offset_x + 2*offset_w), y = h * -0.22,
		texture = "stats_deaths", -- .tga assumed
		localpos_r = w*0.07, localpos_b = h*0.04,
		inert = 1,
	}
	this.RightList.ColumnHeader4 = NewIFImage {
		x = w * (offset_x + 3*offset_w), y = h * -0.22,
		texture = "stats_flags", -- .tga assumed
		localpos_r = w*0.07, localpos_b = h*0.04,
		inert = 1,
	}
	this.RightList.TeamIcon = NewIFImage {
		x = - w * 0.3, y = h * -0.22,
		texture = "stats_cpp", -- .tga assumed
		localpos_r = w*0.07, localpos_b = h*0.04,
		inert = 1,
	}
	
	-- set the team icon textures
	local team1 = ScriptCB_TeamStatsGetTeam1();
	if(team1 == 1) then -- aliance
		this.LeftList.TeamIcon.texture = "all_icon"
		this.RightList.TeamIcon.texture = "imp_icon"
	elseif(team1 == 2) then
		this.LeftList.TeamIcon.texture = "imp_icon"
		this.RightList.TeamIcon.texture = "all_icon"
	elseif(team1 == 3) then
		this.LeftList.TeamIcon.texture = "rep_icon"
		this.RightList.TeamIcon.texture = "cis_icon"
	else
		this.LeftList.TeamIcon.texture = "cis_icon"
		this.RightList.TeamIcon.texture = "rep_icon"
	end
	
	this.titleTeamStats.bg_width = w*2 * 0.945
	this.titleTeamStats.bgoffsetx = w * -0.009
	this.titleTeamStats.bgexpandy = 6
	this.titleAwards.bg_width = w*2 * 0.945
	this.titleAwards.bgoffsetx = w * -0.009
	this.titleAwards.bgexpandy = 6

	teamstats_listbox_layoutL.fontheight = ScriptCB_GetFontHeight(teamstats_listbox_layoutL.font)
	teamstats_listbox_layoutL.yHeight = math.max(26,teamstats_listbox_layoutL.fontheight)
	teamstats_listbox_layoutR.fontheight = ScriptCB_GetFontHeight(teamstats_listbox_layoutR.font)
	teamstats_listbox_layoutR.yHeight = math.max(26,teamstats_listbox_layoutR.fontheight)

	teamstats_listbox_layoutL.width = w
	teamstats_listbox_layoutR.width = teamstats_listbox_layoutL.width
	teamstats_listbox_layoutL.showcount = math.floor(this.listbox.height / (teamstats_listbox_layoutL.yHeight + teamstats_listbox_layoutL.ySpacing)) - 2
	teamstats_listbox_layoutR.showcount = teamstats_listbox_layoutL.showcount

	teamstats_awardsListbox_layoutL.fontheight = ScriptCB_GetFontHeight(teamstats_awardsListbox_layoutL.font)
	teamstats_awardsListbox_layoutL.yHeight = math.max(18,teamstats_awardsListbox_layoutL.fontheight)
	teamstats_awardsListbox_layoutR.fontheight = ScriptCB_GetFontHeight(teamstats_awardsListbox_layoutR.font)
	teamstats_awardsListbox_layoutR.yHeight = math.max(18,teamstats_awardsListbox_layoutR.fontheight)

	teamstats_awardsListbox_layoutL.width = w
	teamstats_awardsListbox_layoutR.width = teamstats_awardsListbox_layoutL.width
	teamstats_awardsListbox_layoutL.showcount = 4 --math.floor(this.awardsListbox.height / (teamstats_awardsListbox_layoutL.yHeight + teamstats_awardsListbox_layoutL.ySpacing)) - 1
	teamstats_awardsListbox_layoutR.showcount = 4 --teamstats_awardsListbox_layoutL.showcount

	ListManager_fnInitList(ifs_teamstats.LeftList,teamstats_listbox_layoutL)
	ListManager_fnInitList(ifs_teamstats.RightList,teamstats_listbox_layoutR)
	ListManager_fnInitList(ifs_teamstats.awardsLeftList,teamstats_awardsListbox_layoutL)
	ListManager_fnInitList(ifs_teamstats.awardsRightList,teamstats_awardsListbox_layoutR)
end


ifs_teamstats_fnBuildScreen(ifs_teamstats) -- programatic chunks
ifs_teamstats_fnBuildScreen = nil

AddIFScreen(ifs_teamstats,"ifs_teamstats")
ifs_teamstats = DoPostDelete(ifs_teamstats)
