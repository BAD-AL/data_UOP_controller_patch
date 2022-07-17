--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- Screen for Instant Action options

-- Internal set of pages:
-- this.iColumn == 0   -> general game options
-- this.iColumn == 1   -> [reserved for host options]
-- this.iColumn == 2   -> Edit Playlist button at bottom
-- this.iColumn == 3   -> Launch Game button at bottom
-- this.iColumn == 4   -> Set Password button at bottom (if this.bCanEditPass is true)

-- Tags for the various items in the listboxes. Note: this is what is
-- passed in as the 'Data' parameter to ifs_instant_options_PopulateItem.

function ifs_instant_options_SetOptionGroup(group, button)
	for key,value in pairs(ifs_io_listtags) do
		IFObj_fnSetVis(ifs_instant_options.screens[key], nil)
	end
	
	IFObj_fnSetVis(ifs_instant_options.screens[group], 1)
	
	ifs_io_PageName = group
	
	-- old code
   ifs_io_nexttags = ifs_io_listtags[group]
   ifs_instant_options.tab_button = button
end

ifs_io_nexttags = nil

ifs_io_listtags = {
   global      = ifs_io_listtags_global,
   host        = ifs_io_listtags_host,
   hero        = ifs_io_listtags_hero,
   conquest    = ifs_io_listtags_conquest,
   ctf         = ifs_io_listtags_ctf,
   elimination = ifs_io_listtags_elimination,
   hunt        = ifs_io_listtags_hunt,
   assault     = ifs_io_listtags_assault,
}

ifs_instant_options_listtags_noheroes = {
    "numbots",
    "aidifficulty",
--    "dm_mult", -- Fix for 5107 - no DM maps anymore - NM 7/21/05
    "con_mult",
    "ctf_score",
    "heroes_onoff",
}

-- Has no hero_unlock_2 field, no respawn_val field
ifs_instant_options_listtags_A = {
    "numbots",
    "aidifficulty",
    "dm_mult",
    "con_mult",
    "ctf_score",
    "heroes_onoff",
    "hero_unlock_1",
    "hero_assign",
    "hero_unlockfor",
    "hero_respawn",
}

-- Has hero_unlock_2 field, no respawn_val field
ifs_instant_options_listtags_B = {
    "numbots",
    "aidifficulty",
    "dm_mult",
    "con_mult",
    "ctf_score",
    "heroes_onoff",
    "hero_unlock_1",
    "hero_unlock_2",
    "hero_assign",
    "hero_unlockfor",
    "hero_respawn",
}

-- Has no hero_unlock_2 field, respawn_val field
ifs_instant_options_listtags_C = {
    "numbots",
    "aidifficulty",
    "dm_mult",
    "con_mult",
    "ctf_score",
    "heroes_onoff",
    "hero_unlock_1",
    "hero_assign",
    "hero_unlockfor",
    "hero_respawn",
    "hero_respawn_val",
}


ifs_instant_options_listtags_all = {
    "numbots",
    "aidifficulty",
    "dm_mult",
    "con_mult",
    "ctf_score",
	"heroes_onoff",
    "hero_unlock_1",
    "hero_unlock_2",
    "hero_assign",
    "hero_unlockfor",
    "hero_respawn",
    "hero_respawn_val",
}

-- attempt at new stuff

ifs_io_PageName = "global"

local HEROPoints = {low = 1, high = 50, increment = 1, default = 10}
local HEROTimer = {low = 0, high = 120, increment = 5, default = 60}
-- mult = reinforcements
local CONMult = {low = 1, high = 1000, increment = 25} -- inc 10
local CONTimer = {low = 0, high = 60, increment = 5} -- off, then 5 to 60
local CTFScore = {low = 1, high = 100, increment = 5}
local CTFTimer = {low = 0, high = 60, increment = 5} -- off, then 5 to 60
--local ELIMult = {low = 50, high = 300}
--local ELITimer = {low = 0, high = 300}
local HUNScore = {low = 1, high = 1000, increment = 25} -- inc 5
local HUNTimer = {low = 0, high = 60, increment = 5} -- off, then 5 to 60
local ASSScore = {low = 1, high = 1000, increment = 25}  -- inc 5

local gOffString = ScriptCB_getlocalizestr("common.off")
local gAlwaysString = ScriptCB_getlocalizestr("common.always")
local gNeverString = ScriptCB_getlocalizestr("common.never")
local gDisableString = ScriptCB_getlocalizestr("ifs.mp.createopts.vote0")

function ifs_io_changeRadioButtonFunc(buttongroup, btnNum)
	-- 'buttongroup' is the button group (radiobuttons[key])
	local this = ifs_instant_options
	local form = this.screens[ifs_io_PageName].form
	for key, element in pairs(form.elements) do
		if ( type(element) == "table" ) then
			if ( element.tag == buttongroup.tag ) then
				form.elements[element.tag].selValue = btnNum
				ifs_io_changeFunc(form, element)
				Form_SetValues(form)
			end
		end
	end
end

function ifs_io_changeFunc(form, element)

	local this = ifs_instant_options

	--ifs_instant_options_fnSetHelptext(this, element.tag)

	-- global options
	if(element.tag == "numbots") then -- round, clamp and apply to others if need be
		local oldNumBots = this.GamePrefs.iNumBots
		element.selValue = RoundTo(element.selValue, 1)
        this.GamePrefs.iNumBots = Clamp(math.floor(element.selValue), 0, this.GamePrefs.iMaxBots)
        element.selValue = this.GamePrefs.iNumBots 
        -- apply to others
		if ( oldNumBots ~= this.GamePrefs.iNumBots ) then
			this.GamePrefs.iCONNumBots = this.GamePrefs.iNumBots
			this.GamePrefs.iCTFNumBots = this.GamePrefs.iNumBots
			--this.GamePrefs.iELINumBots = this.GamePrefs.iNumBots
			this.GamePrefs.iASSNumBots = this.GamePrefs.iNumBots
		end
    elseif (element.tag == "aidifficulty") then
        -- Toggle between 2 and 3 only - why?
        this.GamePrefs.iDifficulty = element.selValue + 1
        
    -- host options	
	elseif(element.tag == "dedicated") then
		if(element.selValue == 1 and (not this.GamePrefs.bIsDedicated)) then
			this.GamePrefs.bIsDedicated = not this.GamePrefs.bIsDedicated
		elseif(element.selValue == 2 and this.GamePrefs.bIsDedicated) then
			this.GamePrefs.bIsDedicated = not this.GamePrefs.bIsDedicated
		end
	elseif(element.tag == "playlistorder") then
		if(element.selValue == 1 and this.GamePrefs.bRandomizePlaylist) then
			this.GamePrefs.bRandomizePlaylist = not this.GamePrefs.bRandomizePlaylist
		elseif(element.selValue == 2 and (not this.GamePrefs.bIsDedicated)) then
			this.GamePrefs.bRandomizePlaylist = not this.GamePrefs.bRandomizePlaylist
		end
	elseif(element.tag == "players") then
		element.selValue = RoundTo(element.selValue, 1)
		element.selValue = Clamp(element.selValue, this.iMinPlayers, this.GamePrefs.iMaxPlayers)
		this.GamePrefs.iNumPlayers = element.selValue
		-- update num players to start to reflect any changes
		form.elements["startcnt"].maxValue = this.GamePrefs.iNumPlayers 
		ifs_io_changeFunc(form, form.elements["startcnt"])
	elseif(element.tag == "warmup") then
		-- increments of 5
		element.selValue = RoundTo(element.selValue, 5)
		element.selValue = Clamp(element.selValue, this.GamePrefs.iWarmUpMin, this.GamePrefs.iWarmUpMax)
		this.GamePrefs.iWarmUp = element.selValue
	elseif(element.tag == "vote") then
		-- increment of 5
		element.selValue = RoundTo(element.selValue, 5)
		element.selValue = Clamp(element.selValue, this.GamePrefs.iVoteMin, this.GamePrefs.iVoteMax)
		this.GamePrefs.iVote = element.selValue
		if(this.GamePrefs.iVote == 0) then
			element.sliderString = gDisableString
		else
			element.sliderString = nil
		end
	elseif(element.tag == "teamdmg") then
		if(element.selValue == 2) then 
			this.GamePrefs.iTeamDmg = 0
		else
			this.GamePrefs.iTeamDmg = 1
		end
	elseif(element.tag == "shownames") then
		if(element.selValue == 1 and (not this.GamePrefs.bShowNames)) then
			this.GamePrefs.bShowNames = not this.GamePrefs.bShowNames
		elseif(element.selValue == 2 and this.GamePrefs.bShowNames) then
			this.GamePrefs.bShowNames = not this.GamePrefs.bShowNames
		end
	elseif(element.tag == "autoassign") then
		if(element.selValue == 1 and (not this.GamePrefs.bAutoAssignTeams)) then
			this.GamePrefs.bAutoAssignTeams = not this.GamePrefs.bAutoAssignTeams
		elseif(element.selValue == 2 and this.GamePrefs.bAutoAssignTeams) then
			this.GamePrefs.bAutoAssignTeams = not this.GamePrefs.bAutoAssignTeams
		end
	elseif(element.tag == "startcnt") then
		-- take into account inumplayers!
		element.maxValue = this.GamePrefs.iNumPlayers
		element.selValue = RoundTo(element.selValue, 1)
		element.selValue = Clamp(element.selValue, 0, this.GamePrefs.iNumPlayers)
		this.GamePrefs.iStartCnt = element.selValue
 	elseif(element.tag == "playerawards") then
		if(element.selValue == 1 and (not this.GamePrefs.bIsPlayerAwardsEnabled)) then
			this.GamePrefs.bIsPlayerAwardsEnabled = not this.GamePrefs.bIsPlayerAwardsEnabled
		elseif(element.selValue == 2 and this.GamePrefs.bIsPlayerAwardsEnabled) then
			this.GamePrefs.bIsPlayerAwardsEnabled = not this.GamePrefs.bIsPlayerAwardsEnabled
		end
      
    -- hero options
   	elseif(element.tag == "heroes_onoff") then
   		if(element.selValue == 1) then
   			if (not this.GamePrefs.bHeroesEnabled) then
   				this.GamePrefs.bHeroesEnabled = not this.GamePrefs.bHeroesEnabled 
   			end
   		elseif(this.GamePrefs.bHeroesEnabled) then
   			this.GamePrefs.bHeroesEnabled = not this.GamePrefs.bHeroesEnabled 
   		end
		if(this.GamePrefs.bHeroesEnabled) then
			-- show all others
			for key, value in pairs(form.elements) do	
				if(key ~= element.tag and type(value) == "table") then
					form.elements[key].hidden = nil
				end
			end
			if(form.elements["hero_unlock_1"].selValue == 1) then
				form.elements["hero_unlock_2_timer"].hidden = true
			else
				form.elements["hero_unlock_2_points"].hidden = true
			end
        else
			-- hide all others
			for key, value in pairs(form.elements) do	
				if(key ~= element.tag and type(value) == "table") then
					form.elements[key].hidden = true
				end
			end
		end
		Form_ShowHideElements(form)
	elseif(element.tag == "hero_respawn_val") then
		-- values of heroRespawnVal: -1 = never, 0 = always, otherwise up to 120 = normal timer
		-- values of slider - 0 = always, 1-120 = normal, 121 = never
		element.selValue = RoundTo(element.selValue, 1)
		element.selValue = Clamp(element.selValue, 0, 121)
		if(element.selValue == 121) then  -- never
			this.HeroPrefs.iHeroRespawnVal = -1
			element.sliderString = gNeverString
		elseif(element.selValue == 0) then -- always
			this.HeroPrefs.iHeroRespawnVal = 0
			element.sliderString = gAlwaysString
		else -- 0 to 120 are valid
			-- FIXME print seconds!
			element.sliderString = nil
			this.HeroPrefs.iHeroRespawnVal = element.selValue
		end
	elseif(element.tag == "hero_assign") then
		if(element.selValue == 1) then
			this.HeroPrefs.iHeroPlayer = 1
		elseif(element.selValue == 2) then
			this.HeroPrefs.iHeroPlayer = 4
		else
			this.HeroPrefs.iHeroPlayer = 7
		end
	elseif(element.tag == "hero_unlock_1") then -- type of unlock - points or timer
		-- 3 and 5 are the only valid values
		if(element.selValue == 1) then
			if(this.HeroPrefs.iHeroUnlock ~= 3) then -- reset to default value
				form.elements["hero_unlock_2_points"].selValue = HEROPoints.default
				ifs_io_changeFunc(form, form.elements["hero_unlock_2_points"])
				form.elements["hero_assign"].selValue = 1 -- automatically go back to "Best", by request
				ifs_io_changeFunc(form, form.elements["hero_assign"])
				form.elements["hero_unlock_2_points"].hidden = nil
				form.elements["hero_unlock_2_timer"].hidden = true
				Form_ShowHideElements(form)
			end
			this.HeroPrefs.iHeroUnlock = 3
		else
			if(this.HeroPrefs.iHeroUnlock ~= 5) then -- reset to default value
				form.elements["hero_unlock_2_timer"].selValue = HEROTimer.default
				ifs_io_changeFunc(form, form.elements["hero_unlock_2_timer"])
				form.elements["hero_assign"].selValue = 7 -- automatically go back to "Random", by request
				ifs_io_changeFunc(form, form.elements["hero_assign"])
				form.elements["hero_unlock_2_points"].hidden = true
				form.elements["hero_unlock_2_timer"].hidden = nil
				Form_ShowHideElements(form)
			end
			this.HeroPrefs.iHeroUnlock = 5
		end
  	elseif(element.tag == "hero_unlock_2_points") then
		element.selValue = RoundTo(element.selValue, HEROPoints.increment)
		this.HeroPrefs.iHeroUnlockVal = Clamp(math.floor(element.selValue), HEROPoints.low, HEROPoints.high)
        element.selValue = this.HeroPrefs.iHeroUnlockVal
	elseif(element.tag == "hero_unlock_2_timer") then
		element.selValue = RoundTo(element.selValue, HEROTimer.increment)
		this.HeroPrefs.iHeroUnlockVal = Clamp(math.floor(element.selValue), HEROTimer.low, HEROTimer.high)
        element.selValue = this.HeroPrefs.iHeroUnlockVal
		if(element.selValue == 0) then
			element.sliderString = gAlwaysString
		else
			element.sliderString = nil
		end
	-- conquest opts
	elseif(element.tag == "con_numbots") then
		element.selValue = RoundTo(element.selValue, 1)
		this.GamePrefs.iCONNumBots = Clamp(math.floor(element.selValue), 0, this.GamePrefs.iMaxBots)
        element.selValue = this.GamePrefs.iCONNumBots
	elseif(element.tag == "con_mult") then
		element.selValue = RoundTo(element.selValue, CONMult.increment)
		this.GamePrefs.iCONMult = Clamp(math.floor(element.selValue), CONMult.low, CONMult.high)
        element.selValue = this.GamePrefs.iCONMult
	elseif(element.tag == "con_timer") then
		element.selValue = RoundTo(element.selValue, CONTimer.increment)
		this.GamePrefs.iCONTimer = Clamp(math.floor(element.selValue), CONTimer.low, CONTimer.high)
		-- ghetto "OFF"
		element.sliderString = nil
		if(this.GamePrefs.iCONTimer < 2.5) then
			this.GamePrefs.iCONTimer = 0
			-- and set string
			element.sliderString = gOffString
		elseif(this.GamePrefs.iCONTimer < 5) then
			this.GamePrefs.iCONTimer = 5
		end
        element.selValue = this.GamePrefs.iCONTimer

    -- ctf opts
	elseif(element.tag == "ctf_numbots") then
		element.selValue = RoundTo(element.selValue, 1)
		this.GamePrefs.iCTFNumBots = Clamp(math.floor(element.selValue), 0, this.GamePrefs.iMaxBots)
        element.selValue = this.GamePrefs.iCTFNumBots
	elseif(element.tag == "ctf_score") then
		element.selValue = RoundTo(element.selValue, CTFScore.increment)
		this.GamePrefs.iCTFScore = Clamp(math.floor(element.selValue), CTFScore.low, CTFScore.high)
        element.selValue = this.GamePrefs.iCTFScore
	elseif(element.tag == "ctf_timer") then
		element.selValue = RoundTo(element.selValue, CTFTimer.increment)
		this.GamePrefs.iCTFTimer = Clamp(math.floor(element.selValue), CTFTimer.low, CTFTimer.high)
		-- ghetto "OFF"
		element.sliderString = nil
		if(this.GamePrefs.iCTFTimer < 2.5) then
			this.GamePrefs.iCTFTimer = 0
			-- and set string
			element.sliderString = gOffString
		elseif(this.GamePrefs.iCTFTimer < 5) then
			this.GamePrefs.iCTFTimer = 5
		end
        element.selValue = this.GamePrefs.iCTFTimer

    -- hunt opts
	elseif(element.tag == "hun_timer") then -- round and clamp
		element.selValue = RoundTo(element.selValue, HUNTimer.increment)
		this.GamePrefs.iHUNTimer = Clamp(math.floor(element.selValue), HUNTimer.low, HUNTimer.high)
		-- ghetto "OFF"
		element.sliderString = nil
		if(this.GamePrefs.iHUNTimer < 2.5) then
			this.GamePrefs.iHUNTimer = 0
			-- and set string
			element.sliderString = gOffString
		elseif(this.GamePrefs.iHUNTimer < 5) then
			this.GamePrefs.iHUNTimer = 5
		end
        element.selValue = this.GamePrefs.iHUNTimer
	elseif(element.tag == "hun_score") then -- round and clamp
		element.selValue = RoundTo(element.selValue, HUNScore.increment)
		this.GamePrefs.iHUNTScoreLimit = Clamp(math.floor(element.selValue), HUNScore.low, HUNScore.high)
        element.selValue = this.GamePrefs.iHUNTScoreLimit
    
    -- assault opts
	elseif(element.tag == "ass_numbots") then -- round and clamp
		element.selValue = RoundTo(element.selValue, 1)
		this.GamePrefs.iASSNumBots = Clamp(math.floor(element.selValue), 0, this.GamePrefs.iMaxBots)
        element.selValue = this.GamePrefs.iASSNumBots 
	elseif(element.tag == "ass_score") then -- round and clamp
		element.selValue = RoundTo(element.selValue, ASSScore.increment)
		this.GamePrefs.iASSScoreLimit = Clamp(math.floor(element.selValue), ASSScore.low, ASSScore.high)
        element.selValue = this.GamePrefs.iASSScoreLimit
	end
end

function ifs_io_GetRealValueFor(form, tag)

	local this = ifs_instant_options

	local val = nil
	local mySliderString = nil
	
	-- global options
	if(tag == "numbots") then
		val = this.GamePrefs.iNumBots
    elseif (tag == "aidifficulty") then
        -- Toggle between 2 and 3 only - why?
        val = this.GamePrefs.iDifficulty - 1
        
    -- host options	
	elseif(tag == "dedicated") then
		if(this.GamePrefs.bIsDedicated) then
			val = 1
		else
			val = 2
		end
	elseif(tag == "playlistorder") then
		if(this.GamePrefs.bRandomizePlaylist) then
			val = 2
		else
			val = 1
		end
	elseif(tag == "players") then
		-- remember, for this we must set max ALSO!!
		form.elements[tag].maxValue = this.GamePrefs.iMaxPlayers
		if(this.GamePrefs.iNumPlayers > this.GamePrefs.iMaxPlayers) then
			this.GamePrefs.iNumPlayers = this.GamePrefs.iMaxPlayers
		end
		val = this.GamePrefs.iNumPlayers
	elseif(tag == "warmup") then
		-- increments of 5
	    val = this.GamePrefs.iWarmUp
	elseif(tag == "vote") then
		-- increment of 5
		val = this.GamePrefs.iVote
		if(this.GamePrefs.iVote == 0) then
			mySliderString = gDisableString
		end
	elseif(tag == "teamdmg") then
		if(this.GamePrefs.iTeamDmg < 1) then -- 1 or 0
			val = 2
		else
			val = 1
		end
	elseif(tag == "shownames") then
	    if(this.GamePrefs.bShowNames) then
            val = 1
        else
            val = 2
        end
	elseif(tag == "autoassign") then
		if(this.GamePrefs.bAutoAssignTeams) then
			val = 1
		else
			val = 2
		end
	elseif(tag == "startcnt") then
		-- take into account inumplayers!
		form.elements[tag].maxValue = this.GamePrefs.iNumPlayers
		if(this.GamePrefs.iStartCnt > this.GamePrefs.iNumPlayers) then
			this.GamePrefs.iStartCnt = this.GamePrefs.iNumPlayers
		end
		val = this.GamePrefs.iStartCnt 
	elseif(tag == "playerawards") then
		if(this.GamePrefs.bIsPlayerAwardsEnabled) then
            val = 1
        else
            val = 2
        end
		
    -- hero options
   	elseif(tag == "heroes_onoff") then
		if(this.GamePrefs.bHeroesEnabled) then
			val = 1
			-- show all others
			for key, value in pairs(form.elements) do	
				if(key ~= tag and type(value) == "table") then
					form.elements[key].hidden = nil
				end
			end
        else
			val = 2
			-- hide all others
			for key, value in pairs(form.elements) do	
				if(key ~= tag and type(value) == "table") then
					form.elements[key].hidden = true
				end
			end
		end
	elseif(tag == "hero_assign") then
		-- only 1, 4, 7 are valid
		if(this.HeroPrefs.iHeroPlayer == 1) then
			val = 1
		elseif(this.HeroPrefs.iHeroPlayer == 4) then
			val = 2
		else --this.HeroPrefs.iHeroPlayer == 7
			val = 3
		end
	elseif(tag == "hero_respawn_val") then
		-- values of heroRespawnVal: -1 = never, 0 = always, otherwise up to 120 = normal timer
		-- values of slider - 0 = always, 1-120 = normal, 121 = never
		if(this.HeroPrefs.iHeroRespawnVal == -1) then  -- never
			val = 121
			mySliderString = gNeverString
		elseif(this.HeroPrefs.iHeroRespawnVal == 0) then -- always
			val = this.HeroPrefs.iHeroRespawnVal
			mySliderString = gAlwaysString
		else -- 0 to 120 are valid
			-- FIXME print seconds!
			val = this.HeroPrefs.iHeroRespawnVal
		end
	elseif(tag == "hero_unlock_1") then -- type of unlock - points or timer
		-- 3 and 5 are the only valid values
		if(not form.elements[tag].hidden) then
			if(this.HeroPrefs.iHeroUnlock == 3) then
				val = 1
				form.elements["hero_unlock_2_points"].hidden = nil
				form.elements["hero_unlock_2_timer"].hidden = true
			else
				val = 2
				form.elements["hero_unlock_2_points"].hidden = true
				form.elements["hero_unlock_2_timer"].hidden = nil
			end
		end
	elseif(tag == "hero_unlock_2_points") then
		if(not form.elements[tag].hidden) then
			val = this.HeroPrefs.iHeroUnlockVal
		end
	elseif(tag == "hero_unlock_2_timer") then
		if(not form.elements[tag].hidden) then
			val = this.HeroPrefs.iHeroUnlockVal
		end		
		if(val == 0) then
			mySliderString = gAlwaysString
		end
		    
    -- conquest opts
	elseif(tag == "con_numbots") then
		val = this.GamePrefs.iCONNumBots
	elseif(tag == "con_mult") then
		val = this.GamePrefs.iCONMult
	elseif(tag == "con_timer") then
		val = this.GamePrefs.iCONTimer
		if(val < 5) then
			mySliderString = gOffString
		end
    
    -- ctf opts
	elseif(tag == "ctf_numbots") then
		val = this.GamePrefs.iCTFNumBots
	elseif(tag == "ctf_score") then
		val = this.GamePrefs.iCTFScore
	elseif(tag == "ctf_timer") then
		val = this.GamePrefs.iCTFTimer
		if(val < 5) then
			mySliderString = gOffString
		end
   
    -- hunt opts
	elseif(tag == "hun_timer") then
		val = this.GamePrefs.iHUNTimer
		if(val < 5) then
			mySliderString = gOffString
		end
	elseif(tag == "hun_score") then
		val = this.GamePrefs.iHUNTScoreLimit
    
    -- assault opts
	elseif(tag == "ass_numbots") then
		val = this.GamePrefs.iASSNumBots
	elseif(tag == "ass_score") then
		val = this.GamePrefs.iASSScoreLimit
	end	
	
	if(val) then
		form.elements[tag].selValue = val
		
		if(mySliderString) then
			form.elements[tag].sliderString = mySliderString
		else
			form.elements[tag].sliderString = nil
		end
	end
end

function ifs_io_GetLayoutFor(tagsList, screen)
	local layout = {
		yTop = 60, --25,
		yHeight = 20,--40,
		ySpacing  = 0,
		UseYSpacing = 1,
		xSpacing = 20,
		
		--title = tagsList.title,
		
		width = 500,
		font = "gamefont_tiny",--small",
		flashy = 0,
    
		elements = {},
    }
    
	local NUM_ITEMS = table.getn(tagsList.tags)
    
    -- loop through the tags and get the button layout for them
    for i = 1,NUM_ITEMS do
		if(tagsList.tags[i] ~= "title") then
			layout.elements[i] = ifs_io_GetElementLayoutFor(tagsList.tags[i], screen)
		end
    end
    
    return layout
end

function ifs_io_GetElementLayoutFor(tagName, screen)

	-- heh
	local this = screen

	local myTitle = ""
	local myFnChanged = ifs_io_changeRadioButtonFunc
	local mySelValue = 1
	local myControl = "radio"
	local myValues = {"common.on", "common.off"}
	local myMin = nil
	local myMax = nil
	local mySliderMult = 1
	local mySliderString = nil
		
	local myHidden = nil
	
	-- global opts
	if(tagName == "numbots") then
		myTitle = "ifs.mp.createopts.numbots"
		myControl = "slider"
		mySelValue = 0 --this.GamePrefs.iNumBots
		myMin = 0
		myMax = this.GamePrefs.iMaxBots
	elseif(tagName == "aidifficulty") then
		myTitle = "ifs.mp.createopts.difficulty"
		mySelValue = this.GamePrefs.iDifficulty - 1
		myControl = "dropdown"
		myValues = {"ifs.difficulty.medium", "ifs.difficulty.hard" }

	-- host opts	
	elseif(tagName == "dedicated") then
		myTitle = "ifs.mp.createopts.dedicated"
		if(this.GamePrefs.bIsDedicated) then
			mySelValue = 1
		else
			mySelValue = 2
		end
	elseif(tagName == "playlistorder") then
		myTitle = "ifs.mp.createopts.playlistorder"
		myValues = {"ifs.missionselect.inorder", "ifs.missionselect.random"}
		if(this.GamePrefs.bRandomizePlaylist) then
			mySelValue = 2
		else
			mySelValue = 1
		end
	elseif(tagName == "players") then
		myTitle = "ifs.mp.createopts.maxplayers"
		myControl = "slider"
		myMin = this.iMinPlayers -- not in GamePrefs?
		myMax = this.GamePrefs.iMaxPlayers
		mySelValue = this.GamePrefs.iNumPlayers
	elseif(tagName == "warmup") then
		-- increments of 5
	    myTitle = "ifs.mp.createopts.warmup"
	    myControl = "slider"
	    mySelVal = 0 --this.GamePrefs.iWarmUp
	    myMin = this.GamePrefs.iWarmUpMin
	    myMax = this.GamePrefs.iWarmUpMax
	elseif(tagName == "vote") then
		-- increment of 5
		myTitle = "ifs.mp.createopts.vote"
		myControl = "slider"
		mySelVal = 0 --this.GamePrefs.iVote
		myMin = this.GamePrefs.iVoteMin
		myMax = this.GamePrefs.iVoteMax
	elseif(tagName == "teamdmg") then
		myTitle = "ifs.mp.createopts.teamdamage"
		if(this.GamePrefs.iTeamDmg < 1) then -- 1 or 0
			mySelVal = 2
		else
			mySelVal = 1
		end
	elseif(tagName == "shownames") then
		myTitle = "ifs.mp.createopts.shownames"
	    if(this.GamePrefs.bShowNames) then
            mySelVal = 1
        else
            mySelVal = 2
        end
	elseif(tagName == "autoassign") then
		myTitle = "ifs.mp.createopts.autoassign"
		myValues = {"ifs.mp.createopts.autoassign_on", "ifs.mp.createopts.autoassign_off"}
		mySelVal = 0 --this.GamePrefs.bAutoAssignTeams
	elseif(tagName == "startcnt") then
	    myTitle = "ifs.mp.createopts.startcnt"
	    myControl = "slider"
	    mySelVal = 0 --this.GamePrefs.iStartCnt
	    myMin = 0
	    myMax = this.GamePrefs.iNumPlayers
	elseif(tagName == "playerawards") then
		myTitle = "ifs.mp.createopts.playerawards"
		if(this.GamePrefs.bIsPlayerAwardsEnabled) then
            mySelVal = 1
        else
            mySelVal = 2
        end
	
	-- hero opts
	elseif(tagName == "heroes_onoff") then
		myTitle = "ifs.mp.createopts.heroes"
		if(this.GamePrefs.bHeroesEnabled) then
			mySelValue = 1
        else
			mySelValue = 2
		end
	elseif(tagName == "hero_assign") then
		-- only 1, 4, 7 are valid
		myTitle = "ifs.mp.heroopts.heroplayer"
		myControl = "dropdown"
		mySelValue = 1 --this.HeroPrefs.iHeroPlayer 
		myValues = {"ifs.mp.heroopts.heroplayer1", "ifs.mp.heroopts.heroplayer4", "ifs.mp.heroopts.heroplayer7"}
	elseif(tagName == "hero_respawn_val") then
		-- values of heroRespawnVal: -1 = never, 0 = always, otherwise up to 120 = normal timer
		-- values of slider - 0 = always, 1-120 = normal, 121 = never
		myTitle = "ifs.mp.heroopts.herorespawn"
		myControl = "slider"
		mySelValue = 0 --this.HeroPrefs.iHeroRespawnVal
		myMin = -1
		myMax = 121
	elseif(tagName == "hero_unlock_1") then
		-- 3 and 5 are the only valid values
		myTitle = "ifs.mp.heroopts.herounlock"
		mySelVal = 1 --this.HeroPrefs.iHeroUnlock
		myValues = {"ifs.mp.heroopts.herounlock3", "ifs.mp.heroopts.herounlock5"}
	elseif(tagName == "hero_unlock_2_points") then
		myTitle = "ifs.mp.createopts.points"
		myControl = "slider"
		mySelValue = 0 --this.HeroPrefs.iHeroUnlockVal
		myMin = HEROPoints.low
		myMax = HEROPoints.high
	elseif(tagName == "hero_unlock_2_timer") then
		myTitle = "ifs.mp.create.opt.timer"
		myControl = "slider"
		mySelValue = 0 --this.HeroPrefs.iHeroUnlockVal
		myMin = HEROTimer.low
		myMax = HEROTimer.high

	-- conquest opts
	elseif(tagName == "con_numbots") then
		myTitle = "ifs.mp.createopts.numbots"
		myControl = "slider"
		mySelValue = 0 --this.GamePrefs.iCONNumBots
		myMin = 0
		myMax = this.GamePrefs.iMaxBots
	elseif(tagName == "con_mult") then
		myTitle = "ifs.mp.create.opt.reinforcements"	
		myControl = "slider"
		mySelValue = 0 --this.GamePrefs.iCONMult
		myMin = CONMult.low
		myMax = CONMult.high
	elseif(tagName == "con_timer") then
		myTitle = "ifs.mp.create.opt.timer"
		myControl = "slider"
		mySelValue = 0 --this.GamePrefs.iCONTimer
		myMin = CONTimer.low
		myMax = CONTimer.high
	
	-- ctf opts
	elseif(tagName == "ctf_numbots") then
		myTitle = "ifs.mp.createopts.numbots"
		myControl = "slider"
		mySelValue = 0 --this.GamePrefs.iCTFNumBots
		myMin = 0
		myMax = this.GamePrefs.iMaxBots
	elseif(tagName == "ctf_score") then
		myTitle = "ifs.mp.create.opt.ctf"
		myControl = "slider"
		mySelValue = 0 --this.GamePrefs.iCTFScore
		myMin = CTFScore.low
		myMax = CTFScore.high
	elseif(tagName == "ctf_timer") then
		myTitle = "ifs.mp.create.opt.timer"
		myControl = "slider"
		mySelValue = 0 --this.GamePrefs.iCTFTimer
		myMin = CTFTimer.low
		myMax = CTFTimer.high
	
	-- elimination opts
	--elseif(tagName == "eli_numbots") then
	--elseif(tagName == "eli_mult") then
	--elseif(tagName == "eli_timer") then

	-- hunt opts
	elseif(tagName == "hun_timer") then
		myTitle = "ifs.mp.create.opt.timer"
		myControl = "slider"
		mySelValue = 0 --this.GamePrefs.iHUNTimer
		myMin = HUNTimer.low
		myMax = HUNTimer.high
	elseif(tagName == "hun_score") then
		myTitle = "ifs.mp.create.opt.scorelimit"
		myControl = "slider"
		mySelValue = 0 --this.GamePrefs.iHUNTScoreLimit
		myMin = HUNScore.low
		myMax = HUNScore.high
		
	-- assault opts
	elseif(tagName == "ass_numbots") then
		myTitle = "ifs.mp.createopts.numbots"
		myControl = "slider"
		mySelValue = 0 --this.GamePrefs.iASSNumBots
		myMin = 0
		myMax = this.GamePrefs.iMaxBots
	elseif(tagName == "ass_score") then
		myTitle = "ifs.mp.create.opt.scorelimit"
		myControl = "slider"
		mySelValue = 0 --this.GamePrefs.iASSScoreLimit
		myMin = ASSScore.low
		myMax = ASSScore.high
	end -- end bigass if()
	
	-- fix callback
	if(myControl ~= "radio") then
		myFnChanged = ifs_io_changeFunc
	end
	
	
	local toReturn = {
		tag = tagName,
		hidden = myHidden,
		title = myTitle,
		fnChanged = myFnChanged,
		selValue = mySelValue,
		control = myControl,
		minValue = myMin,
		maxValue = myMax,
		values = myValues,
		sliderMultiplier = mySliderMult,
		sliderString = mySliderString,
	}
	
	return toReturn
end

-- end attempt

-- Helper function. Given a layout (x,y,width, height), returns a
-- fully-built item.
function ifs_instant_options_CreateItem(layout)
    -- Make a coordinate system pegged to the top-left of where the cursor would go.
    local Temp = NewIFContainer { 
        x = layout.x - 0.5 * layout.width, 
        y = layout.y,
    }

    Temp.textitem = NewIFText { 
        x = 10,
        y = layout.height * -0.5 + 2,
        halign = "left", valign = "vcenter",
        font = ifs_instant_options_layout.FontStr,
        textw = layout.width - 20, texth = layout.height,
        startdelay=math.random()*0.5, nocreatebackground=1, 
    }

    return Temp
end

-- Helper function. For a destination item (previously created w/
-- CreateItem), fills it in with appropriate values given a Tag, which
-- may be nil (==blank it) Note: the Tag is an entry out of
-- ifs_instant_options_listtags.
function ifs_instant_options_PopulateItem(Dest, Tag, bSelected, iColorR, iColorG, iColorB, fAlpha)
    -- Well, no, it's technically not. But, acting like it makes things
    -- more consistent
    local this = ifs_instant_options
    local ShowStr = Tag
    local ShowUStr = nil

    local OnStr = ScriptCB_getlocalizestr("common.on")
    local OffStr = ScriptCB_getlocalizestr("common.off")

    if(Tag == "numbots") then
       ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.numbots",
                    ScriptCB_tounicode(string.format("%d",this.GamePrefs.iNumBots)))
    elseif (Tag == "aidifficulty") then
        local EasyStr = ScriptCB_getlocalizestr("ifs.difficulty.easy")
        local MediumStr = ScriptCB_getlocalizestr("ifs.difficulty.medium")
        local HardStr = ScriptCB_getlocalizestr("ifs.difficulty.hard")
        if(this.GamePrefs.iDifficulty==1) then
            ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.difficulty",EasyStr)
        elseif (this.GamePrefs.iDifficulty==2) then
            ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.difficulty",MediumStr)
        else
            ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.difficulty",HardStr)
        end
    elseif (Tag == "dm_mult") then
        ShowUStr = ScriptCB_usprintf("ifs.mp.create.opt.dm",
                                                                 ScriptCB_tounicode(string.format("%d",this.GamePrefs.iDMMult)))
    elseif(Tag == "con_numbots") then
       ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.numbots",
                    ScriptCB_tounicode(string.format("%d",this.GamePrefs.iCONNumBots)))
    elseif (Tag == "con_mult") then
        ShowUStr = ScriptCB_usprintf("ifs.mp.create.opt.reinforcements",
                         ScriptCB_tounicode(string.format("%d",this.GamePrefs.iCONMult)))
    elseif (Tag == "con_timer") then
       local time
       if ( this.GamePrefs.iCONTimer and this.GamePrefs.iCONTimer == 0 ) then
          time = ScriptCB_getlocalizestr("ifs.mp.create.opt.off")
       else
          time = ScriptCB_tounicode(string.format("%d",this.GamePrefs.iCONTimer))
       end
       ShowUStr = ScriptCB_usprintf("ifs.mp.create.opt.timer", time)
    elseif(Tag == "ctf_numbots") then
       ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.numbots",
                    ScriptCB_tounicode(string.format("%d",this.GamePrefs.iCTFNumBots)))
    elseif (Tag == "ctf_score") then
        ShowUStr = ScriptCB_usprintf("ifs.mp.create.opt.ctf",
                                                                 ScriptCB_tounicode(string.format("%d",this.GamePrefs.iCTFScore)))
    elseif (Tag == "ctf_timer") then
       local time
       if ( this.GamePrefs.iCTFTimer == 0 ) then
          time = ScriptCB_getlocalizestr("ifs.mp.create.opt.off")
       else
          time = ScriptCB_tounicode(string.format("%d",this.GamePrefs.iCTFTimer))
       end
       ShowUStr = ScriptCB_usprintf("ifs.mp.create.opt.timer", time)
    elseif(Tag == "eli_numbots") then
       ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.numbots",
                    ScriptCB_tounicode(string.format("%d",this.GamePrefs.iELINumBots)))
    elseif (Tag == "eli_mult") then
       ShowUStr = ScriptCB_usprintf("ifs.mp.create.opt.reinforcements",
                    ScriptCB_tounicode(string.format("%d",this.GamePrefs.iELIMult)))
    elseif (Tag == "eli_timer") then
       local time
       if ( this.GamePrefs.iELITimer == 0 ) then
          time = ScriptCB_getlocalizestr("ifs.mp.create.opt.off")
       else
          time = ScriptCB_tounicode(string.format("%d",this.GamePrefs.iELITimer))
       end
       ShowUStr = ScriptCB_usprintf("ifs.mp.create.opt.timer", time)
    elseif (Tag == "hun_timer") then
       local time
       if ( this.GamePrefs.iHUNTimer == 0 ) then
          time = ScriptCB_getlocalizestr("ifs.mp.create.opt.off")
       else
          time = ScriptCB_tounicode(string.format("%d",this.GamePrefs.iHUNTimer))
       end
       ShowUStr = ScriptCB_usprintf("ifs.mp.create.opt.timer", time)
	elseif (Tag == "hun_score") then
	   ShowUStr = ScriptCB_usprintf("ifs.mp.create.opt.scorelimit", 
					ScriptCB_tounicode(string.format("%d", this.GamePrefs.iHUNTScoreLimit)))		--TODO: LOCALIZE THIS CRAPOLA!!!!!!Q!
    elseif(Tag == "ass_numbots") then
       ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.numbots",
                    ScriptCB_tounicode(string.format("%d",this.GamePrefs.iASSNumBots)))
	elseif(Tag == "ass_score") then
		ShowUStr = ScriptCB_usprintf("ifs.mp.create.opt.scorelimit",
                    ScriptCB_tounicode(string.format("%d",this.GamePrefs.iASSScoreLimit)))
    elseif (Tag == "heroes_onoff") then
        if(this.GamePrefs.bHeroesEnabled) then
            ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.heroes",
                                                                     ScriptCB_getlocalizestr("common.on"))
        else
            ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.heroes",
                                                                     ScriptCB_getlocalizestr("common.off"))
        end
        --          IFText_fnSetString(Dest.textitem,"")
    elseif (Tag == "hero_unlock_1") then
       if ( this.GamePrefs.bHeroesEnabled ) then
          if(this.HeroPrefs.iHeroUnlock == 1) then
         ShowStr = "ifs.mp.heroopts.herounlock1"
         --              this.buttons.herounlockval.hidden = 1
          elseif (this.HeroPrefs.iHeroUnlock == 2) then
         ShowStr = "ifs.mp.heroopts.herounlock2"
          elseif (this.HeroPrefs.iHeroUnlock == 3) then
         ShowStr = "ifs.mp.heroopts.herounlock3"
          elseif (this.HeroPrefs.iHeroUnlock == 4) then
         ShowStr = "ifs.mp.heroopts.herounlock4"
          elseif (this.HeroPrefs.iHeroUnlock == 5) then
         ShowStr = "ifs.mp.heroopts.herounlock5"
          elseif (this.HeroPrefs.iHeroUnlock == 6) then
         ShowStr = "ifs.mp.heroopts.herounlock6"
          end
       else
          ShowStr = ""
       end
    elseif (Tag == "hero_unlock_2") then
       if ( this.GamePrefs.bHeroesEnabled ) then
          if(this.HeroPrefs.iHeroUnlock == 1) then
         ShowStr = ""
          elseif (this.HeroPrefs.iHeroUnlock == 2) then
         ShowUStr = ScriptCB_usprintf("ifs.mp.heroopts.reinforcements",
                          ScriptCB_tounicode(string.format("%d",this.HeroPrefs.iHeroUnlockVal)))
          elseif (this.HeroPrefs.iHeroUnlock == 3) then
         ShowUStr = ScriptCB_usprintf("ifs.mp.heroopts.numpoints",
                          ScriptCB_tounicode(string.format("%d",this.HeroPrefs.iHeroUnlockVal)))
          elseif (this.HeroPrefs.iHeroUnlock == 4) then
         ShowUStr = ScriptCB_usprintf("ifs.mp.heroopts.numkills",
                          ScriptCB_tounicode(string.format("%d",this.HeroPrefs.iHeroUnlockVal)))
          elseif (this.HeroPrefs.iHeroUnlock == 5) then
         ShowUStr = ScriptCB_usprintf("ifs.mp.heroopts.numseconds",
                          ScriptCB_tounicode(string.format("%d",this.HeroPrefs.iHeroUnlockVal)))
          elseif (this.HeroPrefs.iHeroUnlock == 6) then
         ShowUStr = ScriptCB_usprintf("ifs.mp.heroopts.numcaptures",
                          ScriptCB_tounicode(string.format("%d",this.HeroPrefs.iHeroUnlockVal)))
          end
       else
          ShowStr = ""
       end
    elseif (Tag == "hero_assign") then
       if ( this.GamePrefs.bHeroesEnabled ) then
          if(this.HeroPrefs.iHeroPlayer == 1) then
         ShowStr = "ifs.mp.heroopts.heroplayer1"
          elseif (this.HeroPrefs.iHeroPlayer == 2) then
         ShowStr = "ifs.mp.heroopts.heroplayer2"
          elseif (this.HeroPrefs.iHeroPlayer == 3) then
         ShowStr = "ifs.mp.heroopts.heroplayer3"
          elseif (this.HeroPrefs.iHeroPlayer == 4) then
         ShowStr = "ifs.mp.heroopts.heroplayer4"
          elseif (this.HeroPrefs.iHeroPlayer == 5) then
         ShowStr = "ifs.mp.heroopts.heroplayer5"
          elseif (this.HeroPrefs.iHeroPlayer == 6) then
         ShowStr = "ifs.mp.heroopts.heroplayer6"
          elseif (this.HeroPrefs.iHeroPlayer == 7) then
         ShowStr = "ifs.mp.heroopts.heroplayer7"
          elseif (this.HeroPrefs.iHeroPlayer == 8) then
         ShowStr = "ifs.mp.heroopts.heroplayer8"
          end
       else
          ShowStr = ""
       end
    elseif (Tag == "hero_unlockfor") then
        if(this.HeroPrefs.iHeroTeam == 1) then
            ShowStr = "ifs.mp.heroopts.heroteam1"
        elseif (this.HeroPrefs.iHeroTeam == 2) then
            ShowStr = "ifs.mp.heroopts.heroteam2"
        elseif (this.HeroPrefs.iHeroTeam == 3) then
            ShowStr = "ifs.mp.heroopts.heroteam3"
        elseif (this.HeroPrefs.iHeroTeam == 4) then
            ShowStr = "ifs.mp.heroopts.heroteam4"
        end
    elseif (Tag == "hero_respawn") then
        if(this.HeroPrefs.iHeroRespawn == 1) then
            ShowStr = "ifs.mp.heroopts.herorespawn1"
        elseif (this.HeroPrefs.iHeroRespawn == 2) then
            ShowStr = "ifs.mp.heroopts.herorespawn2"
        end
    elseif (Tag == "hero_respawn_val") then
       if ( this.GamePrefs.bHeroesEnabled ) then
	  local timer = this.HeroPrefs.iHeroRespawnVal

	  local value
	  if ( timer < 0 ) then
	     value = ScriptCB_getlocalizestr("common.never")
	  elseif ( timer == 0 ) then
	     value = ScriptCB_getlocalizestr("common.always")
	  else
	     value = ScriptCB_tounicode( string.format("%d", timer) )
	  end

	  local unit
	  if ( timer < 1 ) then
	     unit = ScriptCB_tounicode("")
	  elseif ( timer == 1 ) then
	     unit = ScriptCB_getlocalizestr("ifs.mp.heroopts.second")
	  else
	     unit = ScriptCB_getlocalizestr("ifs.mp.heroopts.seconds")
	  end
	  
          ShowUStr = ScriptCB_usprintf("ifs.mp.heroopts.respawntimer", value, unit)
       else
          ShowStr = ""
       end

        -- Host options tags
    elseif (Tag == "playlistorder") then
       local order
       if ( this.GamePrefs.bRandomizePlaylist ) then
          order = ScriptCB_getlocalizestr("ifs.missionselect.random")
       else
          order = ScriptCB_getlocalizestr("ifs.missionselect.inorder")
       end
       ShowUStr = ScriptCB_usprintf( "ifs.missionselect.playlistorder", order )
    elseif (Tag == "dedicated") then
        if(this.GamePrefs.bIsDedicated) then
            ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.dedicated",OnStr)
        else
            ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.dedicated",OffStr)
        end
    elseif (Tag == "playerawards") then
        if(this.GamePrefs.bIsPlayerAwardsEnabled) then
            ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.playerawards",OnStr)
        else
            ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.playerawards",OffStr)
        end
    elseif (Tag == "players") then
        ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.maxplayers",
                                                                 ScriptCB_tounicode(string.format("%d",this.GamePrefs.iNumPlayers)))
    elseif (Tag == "warmup") then
        ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.warmup",
                                                                 ScriptCB_tounicode(string.format("%d",this.GamePrefs.iWarmUp)))
    elseif (Tag == "vote") then
        if( this.GamePrefs.iVote == 0 ) then
            ShowStr = "ifs.mp.createopts.vote0"
        else
            ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.vote",
                                                                     ScriptCB_tounicode(string.format("%d",this.GamePrefs.iVote)))
        end
    elseif (Tag == "bots") then
        ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.numbots",
                                                                 ScriptCB_tounicode(string.format("%d",this.GamePrefs.iNumBots)))
    elseif (Tag == "teamdmg") then

       if(this.GamePrefs.iTeamDmg < 1) then
            ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.teamdamage",OffStr)
        else
            ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.teamdamage",OnStr)
        end
    elseif (Tag == "autoaim") then
        if(this.GamePrefs.iAutoAim < 1) then
            ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.autoaim",OffStr)
        else
            ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.autoaim",OnStr)
        end
    elseif (Tag == "shownames") then
        if(this.GamePrefs.bShowNames) then
            ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.shownames",OnStr)
        else
            ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.shownames",OffStr)
        end
    elseif (Tag == "autoassign") then
        if(this.GamePrefs.bAutoAssignTeams) then
            ShowStr = "ifs.mp.createopts.autoassign_on"
        else
            ShowStr = "ifs.mp.createopts.autoassign_off"
        end
    elseif (Tag == "startcnt") then
        ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.startcnt",
                                                                 ScriptCB_tounicode(string.format("%d",this.GamePrefs.iStartCnt)))
    elseif (Tag == "voicemode") then
        local disabled    = ScriptCB_getlocalizestr("ifs.mp.voicechat.mode.disabled")
        local peerToPeer  = ScriptCB_getlocalizestr("ifs.mp.voicechat.mode.peertopeer")
        local peerRelay   = ScriptCB_getlocalizestr("ifs.mp.voicechat.mode.peerrelay")
        local serverRelay = ScriptCB_getlocalizestr("ifs.mp.voicechat.mode.serverrelay")
        if     (this.GamePrefs.iVoiceMode == 1) then
            ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.voicemode", disabled)
        elseif (this.GamePrefs.iVoiceMode == 2) then
            ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.voicemode", peerToPeer)
        elseif (this.GamePrefs.iVoiceMode == 3) then
            ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.voicemode", peerRelay)
        elseif (this.GamePrefs.iVoiceMode == 4) then
            ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.voicemode", serverRelay)
        else
            ShowUStr = ScriptCB_usprintf("ifs.mp.createopts.voicemode", "Invalid!")
        end
    elseif (Tag == "pubpriv") then
        if(this.GamePrefs.bIsPrivate) then
            ShowStr = "ifs.mp.createopts.pubpriv_priv"
        else
            ShowStr = "ifs.mp.createopts.pubpriv_pub"
        end
    elseif (not Tag) then
        ShowStr = "" -- reduce glyphcache usage
    else
        IFText_fnSetString(Dest.textitem,Tag)
    end

    if (ShowUStr) then
        IFText_fnSetUString(Dest.textitem,ShowUStr)
    elseif (ShowStr) then
        IFText_fnSetString(Dest.textitem,ShowStr)
    end

    if ( Tag ) then
       IFObj_fnSetColor(Dest.textitem, iColorR, iColorG, iColorB)
       IFObj_fnSetAlpha(Dest.textitem, fAlpha)
    end

    IFObj_fnSetVis(Dest.textitem,Tag)
end

ifs_instant_options_layout = {
    showcount = 10,
--  yTop = -130 + 13, -- auto-calc'd now
    yHeight = 20,
    ySpacing  = 0,
--  width = 260,
    x = 0,
    slider = 1,
    CreateFn = ifs_instant_options_CreateItem,
    PopulateFn = ifs_instant_options_PopulateItem,
}

-- Callback function from VK - returns 2 values, whether the current
-- string is allowed to be entered, and a localize database key string
-- as to why it's not acceptable.
function ifs_instant_options_fnIsAcceptable()
    --  print("ifs_mp_gameopts_fnIsAcceptable()")
    return 1,""
end

-- Callback function when the virtual keyboard is done
function ifs_instant_options_fnKeyboardDone()
    --  print("ifs_mp_gameopts_fnKeyboardDone()")
    local this = ifs_instant_options
    this.GamePrefs.PasswordStr = ScriptCB_ununicode(ifs_vkeyboard.CurString)
    ScriptCB_PopScreen()
    --  vkeyboard_specs.fnDone = nil -- clear our registration there
end

-- Clamps a value between a min & max value. Returns the updated value
function Clamp(Val, Min, Max)
    if(Val < Min) then
        return Min
    elseif (Val > Max) then
        return Max
    else
        return Val -- value is sane
    end
end

-- Rounds a value to the nearest Increment - returns the updated value
function RoundTo(Val, Increment)
	local mult = math.floor(Val / Increment)
	local leastMultiple = mult * Increment
	local greatestMultiple = leastMultiple + Increment
	if((Val - leastMultiple) < (greatestMultiple - Val)) then
		return leastMultiple
	end
	return greatestMultiple
end


-- Adjusts one item (specified in the Tag) by the specified Adjust value.
-- iAdjust will be < 0 if going left, > 0 if going right. +1/-1 if going
-- a short distance, +10/-10 if going a big distance
function ifs_instant_options_fnAdjustItem(this, Tag, iAdjust)
--  print("ifs_instant_options_fnAdjustItem, tag = ", Tag)

    if(Tag == "numbots") then
        this.GamePrefs.iNumBots = Clamp(this.GamePrefs.iNumBots + iAdjust, 0, this.GamePrefs.iMaxBots)
    if ( iAdjust ~= 0 ) then
       this.GamePrefs.iCONNumBots = this.GamePrefs.iNumBots
       this.GamePrefs.iCTFNumBots = this.GamePrefs.iNumBots
       this.GamePrefs.iELINumBots = this.GamePrefs.iNumBots
       this.GamePrefs.iASSNumBots = this.GamePrefs.iNumBots
    end
    elseif (Tag == "aidifficulty") then
        -- Toggle between 2 & 3 for now.
        this.GamePrefs.iDifficulty = 5 - this.GamePrefs.iDifficulty
        print("Diff "..this.GamePrefs.iDifficulty)
--      this.GamePrefs.iDifficulty = Clamp(this.GamePrefs.iDifficulty + iAdjust, 2, 3)
    elseif (Tag == "dm_mult") then
        this.GamePrefs.iDMMult = Clamp(this.GamePrefs.iDMMult + 5 * iAdjust, 10, 1000)
    elseif(Tag == "con_numbots") then
        this.GamePrefs.iCONNumBots = Clamp(this.GamePrefs.iCONNumBots + iAdjust, 0, this.GamePrefs.iMaxBots)
    elseif (Tag == "con_mult") then
        this.GamePrefs.iCONMult = Clamp(this.GamePrefs.iCONMult + 10 * iAdjust, 10, 500)
    elseif (Tag == "con_timer") then
        this.GamePrefs.iCONTimer = Clamp(this.GamePrefs.iCONTimer + 5 * iAdjust, 0, 60)
    elseif(Tag == "ctf_numbots") then
        this.GamePrefs.iCTFNumBots = Clamp(this.GamePrefs.iCTFNumBots + iAdjust, 0, this.GamePrefs.iMaxBots)
    elseif (Tag == "ctf_score") then
        this.GamePrefs.iCTFScore = Clamp(this.GamePrefs.iCTFScore + iAdjust, 1, 15)
    elseif (Tag == "ctf_timer") then
        this.GamePrefs.iCTFTimer = Clamp(this.GamePrefs.iCTFTimer + 5 * iAdjust, 0, 60)
    elseif(Tag == "eli_numbots") then
        this.GamePrefs.iELINumBots = Clamp(this.GamePrefs.iELINumBots + iAdjust, 0, this.GamePrefs.iMaxBots)
    elseif (Tag == "eli_mult") then
        this.GamePrefs.iELIMult = Clamp(this.GamePrefs.iELIMult + 10 * iAdjust, 10, 500)
    elseif (Tag == "eli_timer") then
        this.GamePrefs.iELITimer = Clamp(this.GamePrefs.iELITimer + 5 * iAdjust, 0, 60)
    elseif (Tag == "hun_timer") then
        this.GamePrefs.iHUNTimer = Clamp(this.GamePrefs.iHUNTimer + 5 * iAdjust, 5, 60)
	elseif (Tag == "hun_score") then
		this.GamePrefs.iHUNTScoreLimit = Clamp(this.GamePrefs.iHUNTScoreLimit + 10 * iAdjust, 10, 1000)
    elseif(Tag == "ass_numbots") then
        this.GamePrefs.iASSNumBots = Clamp(this.GamePrefs.iASSNumBots + iAdjust, 0, this.GamePrefs.iMaxBots)
	elseif(Tag == "ass_score") then
		this.GamePrefs.iASSScoreLimit = Clamp(this.GamePrefs.iASSScoreLimit + 10*iAdjust, 50, 1000)
    elseif (Tag == "heroes_onoff") then
        this.GamePrefs.bHeroesEnabled = not this.GamePrefs.bHeroesEnabled
    elseif (Tag == "hero_unlock_1") then
       if ( this.HeroPrefs.iHeroUnlock == 3 ) then
      this.HeroPrefs.iHeroUnlock = 5
       else
      this.HeroPrefs.iHeroUnlock = 3
       end
    elseif (Tag == "hero_unlock_2") then
        this.HeroPrefs.iHeroUnlockVal = Clamp(this.HeroPrefs.iHeroUnlockVal + iAdjust, 1, 120)
    elseif (Tag == "hero_assign") then
       if ( this.HeroPrefs.iHeroPlayer == 1 ) then
      if ( iAdjust > 0 ) then
         this.HeroPrefs.iHeroPlayer = 4
      end
       elseif (this.HeroPrefs.iHeroPlayer == 4 ) then
      if ( iAdjust > 0 ) then
         this.HeroPrefs.iHeroPlayer = 7
      else
         this.HeroPrefs.iHeroPlayer = 1
      end
       else
      if ( iAdjust < 0 ) then
         this.HeroPrefs.iHeroPlayer = 4
      end
       end       
    elseif (Tag == "hero_unlockfor") then
        this.HeroPrefs.iHeroTeam = Clamp(this.HeroPrefs.iHeroTeam + iAdjust, 1, 4)
    elseif (Tag == "hero_respawn") then
        -- toggle values between 1 and 2
        this.HeroPrefs.iHeroRespawn = 3 - this.HeroPrefs.iHeroRespawn
    elseif (Tag == "hero_respawn_val") then
       --we want this to range from 0,1,2,...,119,120,-1
       local value = this.HeroPrefs.iHeroRespawnVal
       if ( value == -1 ) then
	  value = 121
       end

       value = Clamp(value + iAdjust, 0, 121)

       if ( value == 121 ) then
	  this.HeroPrefs.iHeroRespawnVal = -1
       else
	  this.HeroPrefs.iHeroRespawnVal = value
       end

	  -- Host options tags
    elseif (Tag == "playlistorder") then
       this.GamePrefs.bRandomizePlaylist = not this.GamePrefs.bRandomizePlaylist
    elseif (Tag == "dedicated") then
        this.GamePrefs.bIsDedicated = not this.GamePrefs.bIsDedicated
        -- refresh dependent items
        ifs_instant_options_fnAdjustItem(this, "players", 0)
        ifs_instant_options_fnAdjustItem(this, "numbots", 0)
        ifs_instant_options_fnAdjustItem(this, "voicemode", 0)
	elseif (Tag == "playerawards") then
		this.GamePrefs.bIsPlayerAwardsEnabled = not this.GamePrefs.bIsPlayerAwardsEnabled
			
    elseif (Tag == "players") then
        if(this.GamePrefs.bIsDedicated) then
            this.GamePrefs.iNumPlayers = Clamp(this.GamePrefs.iNumPlayers + iAdjust, this.iMinPlayers, this.GamePrefs.iMaxDedicatedPlayers)
        else
            this.GamePrefs.iNumPlayers = Clamp(this.GamePrefs.iNumPlayers + iAdjust, this.iMinPlayers, this.GamePrefs.iMaxPlayers)
        end

        -- Also ensure this is clamped
        this.GamePrefs.iStartCnt = Clamp(this.GamePrefs.iStartCnt, 0, this.GamePrefs.iNumPlayers)
    elseif (Tag == "warmup") then
        this.GamePrefs.iWarmUp = Clamp(this.GamePrefs.iWarmUp + 5 * iAdjust, this.GamePrefs.iWarmUpMin,this.GamePrefs.iWarmUpMax)
    elseif (Tag == "vote") then
        this.GamePrefs.iVote = Clamp(this.GamePrefs.iVote + 5 * iAdjust, this.GamePrefs.iVoteMin, this.GamePrefs.iVoteMax)
--  elseif (Tag == "bots") then
    elseif (Tag == "teamdmg") then
        this.GamePrefs.iTeamDmg = 100 - this.GamePrefs.iTeamDmg
    elseif (Tag == "autoaim") then
        this.GamePrefs.iAutoAim = 100 - this.GamePrefs.iAutoAim
    elseif (Tag == "shownames") then
        this.GamePrefs.bShowNames = not this.GamePrefs.bShowNames
--  elseif (Tag == "hero") then
    elseif (Tag == "autoassign") then
        this.GamePrefs.bAutoAssignTeams = not this.GamePrefs.bAutoAssignTeams
--  elseif (Tag == "difficulty") then
    elseif (Tag == "startcnt") then
        this.GamePrefs.iStartCnt = Clamp(this.GamePrefs.iStartCnt + iAdjust, 0, this.GamePrefs.iNumPlayers)
    elseif (Tag == "voicemode") then
        local modeMax
        if (this.GamePrefs.bIsDedicated) then
            modeMax = this.GamePrefs.iVoiceModeDedicatedMax
        else
            modeMax = this.GamePrefs.iVoiceModeMax
        end
        this.GamePrefs.iVoiceMode = Clamp(this.GamePrefs.iVoiceMode + iAdjust, 
            this.GamePrefs.iVoiceModeMin, modeMax)
    elseif (Tag == "pubpriv") then
        this.GamePrefs.bIsPrivate = not this.GamePrefs.bIsPrivate
    end
end

-- Fills the helptext box with info based on what is currently selected
function ifs_instant_options_fnSetHelptext(this, Tag)

	-- new code - from forms
	if(Tag) then
		if(Tag == "hero_unlock_2_points" or Tag == "hero_unlock_2_timer") then
			Tag = "hero_unlock_2" -- yay it's a hack!
		end
       local NewKey = string.format("ifs.mp.createopts.helptext.%s", Tag)
       IFText_fnSetString(this.InfoboxBot.Text,NewKey)
	else
	   IFText_fnSetString(this.InfoboxBot.Text,"")
	end

	-- old code - from listbox
    --local CurTag = this.CurTags[ifs_instant_options_layout.SelectedIdx]
    --if ( CurTag ) then
    --   local NewKey = string.format("ifs.mp.createopts.helptext.%s", CurTag)
    --   IFText_fnSetString(this.InfoboxBot.Text,NewKey)
    --end
end

-- Shows one of a set of listboxes depending on various heroes options
function ifs_instant_options_fnSetListboxContents(this)
    local NewTags

--     if (this.iColumn == 0) then
--         -- Game options listbox
--         if(not this.GamePrefs.bHeroesEnabled) then
--             NewTags = ifs_instant_options_listtags_noheroes
--         else
--             if((this.HeroPrefs.iHeroUnlock == 1) and (this.HeroPrefs.iHeroRespawn == 1)) then
--                 -- No unlock val, no hero val
--                 NewTags = ifs_instant_options_listtags_A
--             elseif ((this.HeroPrefs.iHeroUnlock ~= 1) and (this.HeroPrefs.iHeroRespawn == 1)) then
--                 -- Yes unlock val, no hero val
--                 NewTags = ifs_instant_options_listtags_B
--             elseif ((this.HeroPrefs.iHeroUnlock == 1) and (this.HeroPrefs.iHeroRespawn ~= 1)) then
--                 -- No unlock val, yes hero val
--                 NewTags = ifs_instant_options_listtags_C
--             else
--                 NewTags = ifs_instant_options_listtags_all
--             end
--         end
--     elseif (this.iColumn == 1) then
--         if(gOnlineServiceStr == "LAN") then
--             NewTags =   ifs_instant_options_listtags_host_LAN 
--         else
--             NewTags =   ifs_instant_options_listtags_host 
--         end
--     end

   if ( ifs_io_nexttags == ifs_io_listtags_hero and not this.GamePrefs.bHeroesEnabled ) then
      NewTags = ifs_io_listtags_hero_no_heroes.tags
   elseif ( ifs_io_nexttags == ifs_io_listtags_host and gOnlineServiceStr == "XLive" ) then
      NewTags = ifs_io_listtags_host_xlive.tags
   else
      NewTags = ifs_io_nexttags.tags
   end

    local bListboxChanged
    if(NewTags and (this.CurTags ~= NewTags)) then
        -- Bit of a UI hack -- if we're changing the list, and we were on the last
        -- item, try and re-center it so that people see what just got
        -- added. Listmanager will clamp us to valid values if this pushes it
        -- out of bounds
        if(ifs_instant_options_layout.SelectedIdx >=
             (ifs_instant_options_layout.FirstShownIdx + ifs_instant_options_layout.showcount - 2)) then
            ifs_instant_options_layout.FirstShownIdx = ifs_instant_options_layout.FirstShownIdx
                +   math.floor(ifs_instant_options_layout.showcount * 0.5)          
        end

        this.CurTags = NewTags
        bListboxChanged = 1
    end

    IFText_fnSetString(this.listbox.titleBarElement, ifs_io_nexttags.title)
    assert(NewTags)
    ifs_instant_options_layout.CursorIdx = ifs_instant_options_layout.SelectedIdx
    ListManager_fnFillContents(this.listbox,NewTags,ifs_instant_options_layout)
    ListManager_fnSetFocus(this.listbox)
--     IFObj_fnSetAlpha(this.modegroup, 1.0)

-- no longer used
--    if(bListboxChanged) then
--       ifs_instant_options_fnSetHelptext(this)
--    end

--     if((this.iColumn == 0) or (this.iColumn == 1)) then
--         assert(NewTags)
--         ifs_instant_options_layout.CursorIdx = ifs_instant_options_layout.SelectedIdx
--         ListManager_fnFillContents(this.listbox,NewTags,ifs_instant_options_layout)
--         ListManager_fnSetFocus(this.listbox)
--         IFObj_fnSetAlpha(this.modegroup, 1.0)
--         this.iLastColumn = this.iColumn

--         -- Items in listbox might have changed. Update helptext
--         if(bListboxChanged) then
--             ifs_instant_options_fnSetHelptext(this)
--         end

--         if(this.iColumn == 0) then
--             IFText_fnSetString(this.modegroup.helpstr,"ifs.mp.create.host_opt")
--             IFText_fnSetString(this.listbox.titleBarElement, "ifs.mp.create.title")
--                         gHelptext_fnMoveIcon(this.modegroup)
--         else
--             IFText_fnSetString(this.modegroup.helpstr,"ifs.mp.create.title")
--             IFText_fnSetString(this.listbox.titleBarElement, "ifs.mp.create.host_opt")
--                         gHelptext_fnMoveIcon(this.modegroup)
--         end
--     else
--         ifs_instant_options_layout.CursorIdx = nil
--         ListManager_fnFillContents(this.listbox,NewTags,ifs_instant_options_layout)
--         ListManager_fnSetFocus(nil)
--         IFObj_fnSetAlpha(this.modegroup, 0.5)
--     end

--     gIconButton_fnSelect(this.PlaylistContainer, (this.iColumn == 2))
--     gIconButton_fnSelect(this.LaunchContainer, (this.iColumn == 3))
--     gIconButton_fnSelect(this.PasswordContainer, (this.iColumn == 4))

end

local option_bg_texture = nil
if(gPlatformStr == "PC") then
	option_bg_texture = "single_player_option"
end

ifs_instant_options = NewIFShellScreen {
	bg_texture = option_bg_texture,
--  movieIntro      = nil,
--  movieBackground = nil,
    music           = "shell_soundtrack",
    bNohelptext_backPC = 1,
    
--  modegroup = NewHelptext {
--     ScreenRelativeX = 1.0, -- right
--     ScreenRelativeY = 1.0, -- bot
--     y = -40,
--     x = 0,
--     bRightJustify = 1,
--     buttonicon = "btnmisc2",
--     string = "ifs.vkeyboard.mode",
--  },

   Helptext_Password = NewHelptext {
      ScreenRelativeX = 0.0,
      ScreenRelativeY = 1.0,
      y = -40,
      x = 0,
--       bRightJustify = 1,
      buttonicon = "btnmisc",
      string = "ifs.mp.createopts.setpassword",
   },

    -- On entry, fill the strings with items
    Enter = function(this, bFwd)
    
    	for key,value in pairs(ifs_io_listtags) do
			Form_ShowHideElements(this.screens[key].form)
		end
    
		-- clear help text
		ifs_instant_options_fnSetHelptext(this, nil)		
    
        gIFShellScreenTemplate_fnEnter(this, bFwd)
--      gHelptext_fnMoveIcon(this.modegroup)
        gHelptext_fnMoveIcon(this.Helptext_Password)

		if(gPlatformStr == "PC") then
			-- set pc profile & title version text
			UpdatePCTitleText(this)
		
			if( ifs_main.option_mp ) then
				ifelem_tabmanager_SelectTabGroup(this, 1, 1, nil, 1)
				ifelem_tabmanager_SetSelected(this, gPCMainTabsLayout, "_tab_multi")
				ifelem_tabmanager_SetSelected(this, gPCMultiPlayerTabsLayout, "_tab_create", 1)
				ifelem_tabmanager_SetSelected(this, gPCMultiPlayerSettingsTabsLayout, this.tab_button, 3)
				if( ScriptCB_IsLoggedIn() ) then
					ifelem_tabmanager_SetDimmed( this, gPCMultiPlayerTabsLayout, "_tab_friends", nil, 1 )
					ifelem_tabmanager_SetDimmed( this, gPCMultiPlayerTabsLayout, "_tab_leaderboard", nil, 1 )
				else
					ifelem_tabmanager_SetDimmed( this, gPCMultiPlayerTabsLayout, "_tab_friends", 1, 1 )
					ifelem_tabmanager_SetDimmed( this, gPCMultiPlayerTabsLayout, "_tab_leaderboard", 1, 1 )
				end				
				
				-- enable host option button
				ifs_missionselect_pcMulti_fnShowHostOptionButton(this)
				--if( this.option_buttons and this.option_buttons.host_btn ) then
				--	this.option_buttons.host_btn.bDimmed = nil
				--	IFObj_fnSetAlpha(this.option_buttons.host_btn,1)
				--	IFObj_fnSetAlpha(this.option_buttons.host_btn.label,1)
				--end
			else
				ifelem_tabmanager_SelectTabGroup(this, 1, nil, 1, 1)
				ifelem_tabmanager_SetSelected(this, gPCMainTabsLayout, "_tab_single")
				ifelem_tabmanager_SetSelected(this, gPCSinglePlayerTabsLayout, "_tab_instant", 2)			
				ifelem_tabmanager_SetSelected(this, gPCMultiPlayerSettingsTabsLayout, this.tab_button, 3)
				
				-- dim host option button
				ifs_missionselect_pcMulti_fnShowHostOptionButton(this, false)
				--if( this.option_buttons and this.option_buttons.host_btn ) then
				--	this.option_buttons.host_btn.bDimmed = 1
				--	IFObj_fnSetAlpha(this.option_buttons.host_btn,0.2)
				--	IFObj_fnSetAlpha(this.option_buttons.host_btn.label,0.2)
				--end
			end			
		end
		
        if(bFwd) then
            this.iColumn = 0
            this.iLastColumn = 0
        end

        this:set_defaults()

		-- the new code
		for key,value in pairs(ifs_io_listtags) do
			local form = this.screens[key].form
			for key2, value2 in pairs(ifs_io_listtags[key].tags) do
				ifs_io_GetRealValueFor(form, value2)
				Form_SetValues(form)
				Form_UpdateAllElements(form)
				Form_ShowHideElements(form)
			end
		end

		-- the old code
		ifs_instant_options_fnSetListboxContents(this)

        local w,h = ScriptCB_GetSafeScreenInfo()
        -- Determine if we support passwords, then use that to reposition bottom
        -- buttons
        if(ifs_missionselect.bForMP) then
					this.bCanEditPass = ((ScriptCB_GetOnlineService() == "GameSpy") and (gPlatformStr ~= "PC"))
        else
            this.bCanEditPass = nil -- SP can never set passwords. Unless you're REALLY paranoid.
        end

--      if(this.bCanEditPass) then
--          IFObj_fnSetPos(this.PlaylistContainer, w * 1 / 6)
--          IFObj_fnSetPos(this.LaunchContainer, w * 3/6)
--          IFObj_fnSetPos(this.PasswordContainer, w * 5/6)
--      else
--          IFObj_fnSetPos(this.PlaylistContainer, w * 0.33333)
--          IFObj_fnSetPos(this.LaunchContainer, w * 0.66667)
--          -- PasswordContainer is hidden in SP, no need to reposition.
--      end

        -- And, show/hide some 
--      IFObj_fnSetVis(this.modegroup,ifs_missionselect.bForMP) -- hide
--      IFObj_fnSetVis(this.PasswordContainer,this.bCanEditPass)
        IFObj_fnSetVis(this.Helptext_Password, this.bCanEditPass)
		if(gPlatformStr ~= "PC") then
			IFObj_fnSetVis(this.Helptext_Accept, nil)
		else
	        IFObj_fnSetVis(this.Helptext_Password, nil)
		end
    end,

    Exit = function(this, bFwd)
   		for key,value in pairs(ifs_io_listtags) do
			local form = this.screens[key].form
			Form_CloseDropboxes(form)
		end

	    this:push_prefs()
	   end,

	Input_Accept = function(this)
		if(gPlatformStr == "PC") then
            if( ifs_main and ifs_main.option_mp ) then
				if( ( ifelem_tabmanager_HandleInputAccept(this, gPCMainTabsLayout) or
					ifelem_tabmanager_HandleInputAccept(this, gPCMultiPlayerTabsLayout, 1) or
					ifelem_tabmanager_HandleInputAccept(this, gPCMultiPlayerSettingsTabsLayout, 3) ) ) then
                    return
                end
            else
				if( ( ifelem_tabmanager_HandleInputAccept(this, gPCMainTabsLayout) or
					ifelem_tabmanager_HandleInputAccept(this, gPCSinglePlayerTabsLayout, 2) or
					ifelem_tabmanager_HandleInputAccept(this, gPCMultiPlayerSettingsTabsLayout, 3) ) ) then
                    return
                end
            end         
            
			-- process the form's input
			if(Form_InputAccept(this.screens[ifs_io_PageName].form, this) == true) then
				return
			end
			--ifs_missionselect_pcMulti_fnClickOptionButtons( this )
		end		
	end,
	
--     Input_Accept = function(this)
--         -- Always push prefs to game. We might go from listbox ->
--         -- edit playlist (pop screen) -> launch game.
--         ScriptCB_SetNetGameDefaults(this.GamePrefs) 
--         ScriptCB_SetNetHeroDefaults(this.HeroPrefs)

--         ScriptCB_SetDedicated(this.bDedicated)

--         if ((this.iColumn == 0) or (this.iColumn == 1)) then
--             this.iLastColumn = this.iColumn -- store which column we were on.
--             this.iColumn = 3 -- go to Launch game button
--             ifs_instant_options_fnSetListboxContents(this)
--         elseif (this.iColumn == 2) then
--             -- Selected 'edit playlist'. Take them back.
--             ScriptCB_PopScreen()
--         elseif (this.iColumn == 3) then
--             -- Selected 'launch'. Do so.
--             ifs_missionselect_fnLaunch(ifs_missionselect)
--         elseif (this.iColumn == 4) then -- edit password
--             if(this.GamePrefs.PasswordStr) then
--                 ifs_vkeyboard.CurString = ScriptCB_tounicode(this.GamePrefs.PasswordStr)
--             else
--                 ifs_vkeyboard.CurString = ScriptCB_tounicode("")
--             end

--             ifs_vkeyboard.bCursorOnLetters = 1 -- start cursor in top-left
--             vkeyboard_specs.bPasswordMode = 1

--             IFText_fnSetString(ifs_vkeyboard.title,"ifs.vkeyboard.title_password")
--             vkeyboard_specs.fnDone = ifs_instant_options_fnKeyboardDone
--             vkeyboard_specs.fnIsOk = ifs_instant_options_fnIsAcceptable
            
--             local w,h = ScriptCB_GetSafeScreenInfo() -- of the usable screen
--             vkeyboard_specs.MaxWidth = (w * 0.5)
--             vkeyboard_specs.MaxLen = 16
--             ifs_movietrans_PushScreen(ifs_vkeyboard)
--         end

--     end,
    Input_Back = function(this)
-- 		    this:push_prefs()
		    ScriptCB_PopScreen()
		 end,

    Input_Misc = function(this)
            if ( this.bCanEditPass ) then
               if(this.GamePrefs.PasswordStr) then
                  ifs_vkeyboard.CurString = ScriptCB_tounicode(this.GamePrefs.PasswordStr)
               else
                  ifs_vkeyboard.CurString = ScriptCB_tounicode("")
               end

               ifs_vkeyboard.bCursorOnLetters = 1 -- start cursor in top-left
               vkeyboard_specs.bPasswordMode = 1

               IFText_fnSetString(ifs_vkeyboard.title,"ifs.vkeyboard.title_password")
               vkeyboard_specs.fnDone = ifs_instant_options_fnKeyboardDone
               vkeyboard_specs.fnIsOk = ifs_instant_options_fnIsAcceptable
               
               local w,h = ScriptCB_GetSafeScreenInfo() -- of the usable screen
               vkeyboard_specs.MaxWidth = (w * 0.5)
               vkeyboard_specs.MaxLen = 16
               ifs_movietrans_PushScreen(ifs_vkeyboard)
            end
	 end,

    Input_GeneralUp = function(this)
             local CurListbox = ListManager_fnGetFocus()
             if(CurListbox) then
                ListManager_fnNavUp(CurListbox)
--                ifs_instant_options_fnSetHelptext(this)
             end
              end,

    Input_GeneralDown = function(this)
               local CurListbox = ListManager_fnGetFocus()
               if(CurListbox) then
                  ListManager_fnNavDown(CurListbox)
--                  ifs_instant_options_fnSetHelptext(this)
               end
            end,

    Input_GeneralLeft = function(this)
               local CurItem = this.CurTags[ifs_instant_options_layout.SelectedIdx]
               ifs_instant_options_fnAdjustItem(this, CurItem, -1)
               ifs_instant_options_fnSetListboxContents(this)
               ifelm_shellscreen_fnPlaySound("shell_select_change")
            end,

    Input_GeneralRight = function(this)
                local CurItem = this.CurTags[ifs_instant_options_layout.SelectedIdx]
                ifs_instant_options_fnAdjustItem(this, CurItem, 1)
                ifs_instant_options_fnSetListboxContents(this)
                ifelm_shellscreen_fnPlaySound("shell_select_change")
             end,

    Input_LTrigger = function(this)
            local CurItem = this.CurTags[ifs_instant_options_layout.SelectedIdx]
            if(gPlatformStr == "PC") then
				ifs_instant_options_fnAdjustItem(this, CurItem, 10)
			else
				ifs_instant_options_fnAdjustItem(this, CurItem, -10)
			end
            ifs_instant_options_fnSetListboxContents(this)
            ifelm_shellscreen_fnPlaySound("shell_select_change")
             end,

    Input_RTrigger = function(this)
            local CurItem = this.CurTags[ifs_instant_options_layout.SelectedIdx]
            if(gPlatformStr == "PC") then
				ifs_instant_options_fnAdjustItem(this, CurItem, -10)
			else
				ifs_instant_options_fnAdjustItem(this, CurItem, 10)
			end
            ifs_instant_options_fnSetListboxContents(this)
            ifelm_shellscreen_fnPlaySound("shell_select_change")
             end,

    Update = function(this, fDt)
        -- Call base class functionality
        gIFShellScreenTemplate_fnUpdate(this, fDt)
        
        local tag = Form_GetMouseOverTag(ifs_instant_options.screens[ifs_io_PageName].form)
        if(tag) then
			ifs_instant_options_fnSetHelptext(this, tag)
		else
			ifs_instant_options_fnSetHelptext(this, nil)
		end
--         if (this.iColumn == 2) then
--             gIconButton_fnHilight(this.PlaylistContainer, fDt)
--         elseif (this.iColumn == 3) then
--             gIconButton_fnHilight(this.LaunchContainer, fDt)
--         elseif (this.iColumn == 4) then
--             gIconButton_fnHilight(this.PasswordContainer, fDt)
--         end
    end,


    set_defaults = function(this)
		      -- Read all the params as a table now - NM 5/2/05
		      this.HeroPrefs = ScriptCB_GetNetHeroDefaults()
					this.GamePrefs = this.GamePrefs or {}
					-- GetNetGameDefaults loses passwordstr, so cache value.
					local EntryPass = this.GamePrefs.PasswordStr
		      this.GamePrefs = ScriptCB_GetNetGameDefaults()
		      this.GamePrefs.PasswordStr = EntryPass

		      this.iMinPlayers = math.max(2, ScriptCB_GetNumCameras()) -- cache this
		      this.GamePrefs.iWarmUpMax = 120
		      this.GamePrefs.iWarmUpMin = 0
		      this.GamePrefs.iVoteMax = 75
		      this.GamePrefs.iVoteMin = 0

		      if(not this.bEverEntered) then
			 this.bEverEntered = 1
			 -- not used afact--cbb 08/21/05
-- 			 this.EntryDedicated = this.bDedicated
			 this.GamePrefs.iNumBots = math.min(this.GamePrefs.iNumBots, this.GamePrefs.iMaxBots)
			 this.GamePrefs.PasswordStr = nil -- none
		      end

		      local max_players = this.GamePrefs.iMaxPlayers
		      if ( this.GamePrefs.bIsDedicated ) then
			 max_players = this.GamePrefs.iMaxDedicatedPlayers
		      end
		      this.GamePrefs.iNumPlayers = math.min(this.GamePrefs.iNumPlayers, max_players)
		      this.GamePrefs.iNumPlayers = math.max(this.GamePrefs.iNumPlayers, this.iMinPlayers)

		      this.GamePrefs.iDMMult = this.GamePrefs.iDMMult or 100
		      this.GamePrefs.iCONNumBots = this.GamePrefs.iCONNumBots or this.GamePrefs.iNumBots
		      this.GamePrefs.iCONMult = this.GamePrefs.iCONMult or 100
		      this.GamePrefs.iCONTimer = this.GamePrefs.iCONTimer or 60
		      this.GamePrefs.iCTFNumBots = this.GamePrefs.iCTFNumBots or this.GamePrefs.iNumBots
		      this.GamePrefs.iCTFScore = this.GamePrefs.iCTFScore or 5
		      this.GamePrefs.iCTFTimer = this.GamePrefs.iCTFTimer or 60
		      this.GamePrefs.iELINumBots = this.GamePrefs.iELINumBots or this.GamePrefs.iNumBots
		      this.GamePrefs.iELIMult = this.GamePrefs.iELIMult or 100
		      this.GamePrefs.iELITimer = this.GamePrefs.iELITimer or 60
		      this.GamePrefs.iHUNTimer = this.GamePrefs.iHUNTimer or 5
		      this.GamePrefs.iHUNTScoreLimit = this.GamePrefs.iHUNTScoreLimit or 50
		      this.GamePrefs.iASSNumBots = this.GamePrefs.iASSNumBots or this.GamePrefs.iNumBots

              this.GamePrefs.iASSScoreLimit = this.GamePrefs.iASSScoreLimit or 180
		   end,

    push_prefs = function(this)
		    -- Always push prefs to game. We might go from listbox ->
		    -- edit playlist (pop screen) -> launch game.
		    ScriptCB_SetNetGameDefaults(this.GamePrefs) 
		    
		    this.HeroPrefs.iHeroTeam = 3 -- allow both teams (open separately) 
		    ScriptCB_SetNetHeroDefaults(this.HeroPrefs)

		    ScriptCB_SetDedicated(this.GamePrefs.bIsDedicated)
		 end,
 }

function ifs_instant_options_fnResetDefaults()
--    local this = ifs_instant_options
--    this::set_defaults()
--    this::push_prefs()
   ifs_instant_options.set_defaults(ifs_instant_options)
   ifs_instant_options.push_prefs(ifs_instant_options)
end

function ifs_instant_options_GetRandomizePlaylist()
   return ifs_instant_options.GamePrefs.bRandomizePlaylist
end

function ifs_instant_options_fnBuildScreen( this ) 
    if(gPlatformStr == "PC") then
        -- Add tabs to screen
--      ifelem_tabmanager_Create(this, gPCSinglePlayerTabsLayout)

		-- add pc profile & title version text
		AddPCTitleText( this )
		
		-- add option buttons
		ifs_missionselect_pcMulti_fnAddOptionButtons( this )
		
		-- add tabs
		ifelem_tabmanager_Create(this, gPCMainTabsLayout, gPCMultiPlayerTabsLayout, gPCSinglePlayerTabsLayout, gPCMultiPlayerSettingsTabsLayout)
    end

    local w,h = ScriptCB_GetSafeScreenInfo()

    -- Don't use all of the screen for the listbox
--     local BottomIconsHeight = 64
    local BotBoxHeight = 65
    local YPadding = 120 -- amount of space to reserve for titlebar, helptext, whitespace, etc

    -- Get usable screen area for listbox
    h = h - BotBoxHeight - YPadding

    -- Calc height of listbox row, use that to figure out how many rows will fit.
    ifs_instant_options_layout.FontStr = "gamefont_small"
    ifs_instant_options_layout.iFontHeight = ScriptCB_GetFontHeight(ifs_instant_options_layout.FontStr)
    ifs_instant_options_layout.yHeight = 2 * (ifs_instant_options_layout.iFontHeight + 2)

    local RowHeight = ifs_instant_options_layout.yHeight + ifs_instant_options_layout.ySpacing
    ifs_instant_options_layout.showcount = math.floor(h / RowHeight)

    local listWidth = w * 0.85
    local ListboxHeight = ifs_instant_options_layout.showcount * RowHeight + 30
	
	local screen_relative_x = 0.5
	local screen_relative_y = 0
	
	if(gPlatformStr == "PC") then    
		listWidth = w * 0.8
		screen_relative_x =0.63
		screen_relative_y =0.1
	end
	
    this.listbox = NewButtonWindow { 
        ZPos = 200, 
        ScreenRelativeX = screen_relative_x, -- center
        ScreenRelativeY = screen_relative_y, -- top
        y = ListboxHeight * 0.5 + 30,
        width = listWidth,
        height = ListboxHeight,
        titleText = "common.mp.options"
    }
    ifs_instant_options_layout.width = listWidth - 40
    ifs_instant_options_layout.x = 0

    ListManager_fnInitList(this.listbox,ifs_instant_options_layout)

	-- no more listbox...
	IFObj_fnSetVis(this.listbox, 0)

		local InfoBoxTextW = w - 20
		local InfoBoxTextX = -w/2 + 10
		if(gPlatformStr == "PC") then
			InfoBoxTextW = (w - 20) * 0.75
			InfoBoxTextX = -w/2 + 80
		end

    this.InfoboxBot = NewIFContainer { 
        ScreenRelativeX = screen_relative_x, -- left side of screen
        ScreenRelativeY = screen_relative_y, -- top
        x = 0,
        y = ListboxHeight + (BotBoxHeight * 0.5) + 5, -- Below listbox

        --bg = NewIFImage {
        --    ZPos = 240,
	    --    x = -w/2, 
        --    localpos_l = 4,
        --    localpos_r = w - 8,
        --    localpos_b = BotBoxHeight,
        --    texture = "white_rect",
        --    ColorR = 128,
        --    ColorG = 128,
        --    ColorB = 128,
        --    alpha = 0.5,
        --},

        Text = NewIFText { 
            x = InfoBoxTextX,
            y = BotBoxHeight * 0.25 - 10,
            halign = "left", valign = "top",
            font = this.listboxfont, 
            textw = InfoBoxTextW, texth = BotBoxHeight,
            startdelay=math.random()*0.5, nocreatebackground=1, 
        },
    }

--     this.PlaylistContainer = NewIconButton { 
--         ScreenRelativeX = 0, -- left side of screen (repositioned on this:Enter())
--         ScreenRelativeY = 0, -- top
--         x = 0,
--         y = ListboxHeight + BotBoxHeight + 40 + (BottomIconsHeight * 0.5), -- Below main listboxes
--         texture = "mapselect_icon_sessionoptions",
--         textw = w * 0.333 - 10,
--         font = "gamefont_medium",
--         string = "ifs.onlinelobby.editplaylist",
--     }

--     this.LaunchContainer = NewIconButton { 
--         ScreenRelativeX = 0, -- left side of screen (repositioned on this:Enter())
--         ScreenRelativeY = 0, -- top
--         x = 0,
--         y = ListboxHeight + BotBoxHeight + 40 + (BottomIconsHeight * 0.5), -- Below main listboxes
--         texture = "mapselect_icon_launch",
--         textw = w * 0.3333 - 10,
--         font = "gamefont_medium",
--         string = "ifs.onlinelobby.launch",
--     }

--     this.PasswordContainer = NewIconButton { 
--         ScreenRelativeX = 0, -- left side of screen (repositioned on this:Enter())
--         ScreenRelativeY = 0, -- top
--         x = 0,
--         y = ListboxHeight + BotBoxHeight + 40 + (BottomIconsHeight * 0.5), -- Below main listboxes
--         texture = "mapselect_icon_launch",
--         textw = w * 0.3333 - 10,
--         font = "gamefont_medium",
--         string = "ifs.mp.createopts.setpassword",
--     }

	-- need default values to get min/max
	ifs_instant_options.set_defaults(this)

	this.screens = NewIFContainer {
						ScreenRelativeX = 0.5,
						ScreenRelativeY = 0,
						x = 100,
						y = 50,
					}

	for key,value in pairs(ifs_io_listtags) do
		this.screens[key] = NewIFContainer {}
		Form_CreateVertical(this.screens[key], ifs_io_GetLayoutFor(ifs_io_listtags[key], this))
		IFObj_fnSetVis(this.screens[key], nil)
	end
end

ifs_instant_options_fnBuildScreen( ifs_instant_options )
ifs_instant_options_fnBuildScreen = nil

AddIFScreen(ifs_instant_options,"ifs_instant_options")
