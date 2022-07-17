------------------------------------------------------------------
-- uop recovered source
-- by Anakain
------------------------------------------------------------------
-- missionlist.lua (Zerted UOP recovery )
-- 
--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--
-- WIP (BAD_AL)

-- List of missions presented to the user for IA/MP/splitscreen/etc.
-- This list is kept in alphabetical order (in English, anyhow).
--
-- Each entry should be in the following form:
-- { -- starts a table entry
-- mapluafile = "END1", -- base name of map, w/o attacking side, no ".lua" either
--
--   OPTIONAL parts, depending on which era(s) are available for this map:
-- era_g = 1, -- [OPTIONAL] Put this in the table if there is a "g" version of the map
-- era_c = 1, -- [OPTIONAL] Put this in the table if there is a "c" version of the map
--
--   OPTIONAL parts, depending in which mode(s) are available for this map:
-- mode_con_c = 1, -- [OPTIONAL] The "_con" version of this map exists, in CLONEWARS
-- mode_con_g = 1, -- [OPTIONAL] The "_con" version of this map exists, in GCW
-- mode_ctf_c = 1, -- [OPTIONAL] The "_ctf" version of this map exists, in CLONEWARS
-- mode_ctf_g = 1, -- [OPTIONAL] The "_ctf" version of this map exists, in GCW
--   [Ditto for the other modes]
--
--
-- }, -- ends a table entry
--
-- Below, things are in one-entry-per-line string.format to make it easier to
-- comment in/out maps by commenting in/out a single line

sp_missionselect_listbox_contents = custom_GetSPMissionList()

mp_missionselect_listbox_contents = custom_GetMPMissionList()


-- Singleplayer campaigns. Each of these tables has a set of
-- string.sub-tables, one string.sub-table per mission. These are run through in
-- order. Note: there is a math.max of 255 missions in a campaign. Todo:
-- add in listings for VOs, backgrounds, etc.
--
-- Optional params per line:
-- side = 2, -- forces the user to team 2 (defender). If omitted, team 1 (attacker) is forced
-- intromovie = "", --movie played before yoda
-- outtromovie = "", --movie played after yoda, before mission
-- exitmovie = "", --movie played after mission is done (and you win)
-- [More will be coming, which refer to text to print, voiceover, etc.]

SPCampaign1 = {
    {
        mapluafile = "geo1c_c",
        side = 1,
        showstr = "ifs.sp.campaign1.mission1name",
        description = "ifs.sp.campaign1.mission1descr",
--          bDimmed = 1,
    },
    
    {
        mapluafile = "spa2c_c",
        side = 1,
        showstr = "ifs.sp.campaign1.mission2name",
        description = "ifs.sp.campaign1.mission1descr",
--          bDimmed = 1,
    },
    
    {
        mapluafile = "myg1c_c",
        side = 1,
        showstr = "ifs.sp.campaign1.mission6name",
        description = "ifs.sp.campaign1.mission3descr",
        
--          bDimmed = 1,
    },

    {
        mapluafile = "fel1c_c",
        side = 1,
        showstr = "ifs.sp.campaign1.mission4name",
        description = "ifs.sp.campaign1.mission2descr",
        
--          bDimmed = 1,
    },
    
    {
        mapluafile = "spa3c_c",
        side = 1,
        showstr = "ifs.sp.campaign1.mission5name",
        description = "ifs.sp.campaign1.mission1descr",
--          bDimmed = 1,
    },
    
    {
        mapluafile = "kas2c_c",
        side = 1,
        showstr = "ifs.sp.campaign1.mission7name",
        description = "ifs.sp.campaign1.mission4descr",
        
--          bDimmed = 1,
    },

    {
        mapluafile = "uta1c_c",
        side = 1,
        showstr = "ifs.sp.campaign1.mission3name",
        description = "ifs.sp.campaign1.mission2descr",
        
--          bDimmed = 1,
    },

    {
        mapluafile = "cor1c_c",
        side = 1,
        showstr = "ifs.sp.campaign1.mission8name",
        description = "ifs.sp.campaign1.mission5descr",
--          bDimmed = 1,
    },

    {
        mapluafile = "nab2g_c",
        side = 1,
        showstr = "ifs.sp.campaign1.mission9name",
        description = "ifs.sp.campaign1.mission6descr",
--          bDimmed = 1,
    },
    
    {
        mapluafile = "spa4g_c",
        side = 1,
        showstr = "ifs.sp.campaign1.mission10name",
        description = "ifs.sp.campaign1.mission1descr",
--          bDimmed = 1,
    },
    
    {
        mapluafile = "mus1c_c",
        side = 1,
        showstr = "ifs.sp.campaign1.mission11name",
        description = "ifs.sp.campaign1.mission7descr",
--          bDimmed = 1,
    },

-- SPA5 is no more - NM 6/24/05    
--     {
--         mapluafile = "spa5g_c",
--         side = 1,
--         showstr = "ifs.sp.campaign1.mission12name",
--         description = "ifs.sp.campaign1.mission1descr",
-- --          bDimmed = 1,
--     },
    
    {
        mapluafile = "kam1c_c",
        side = 1,
        showstr = "ifs.sp.campaign1.mission13name",
        description = "ifs.sp.campaign1.mission8descr",
--          bDimmed = 1,
    },
    
    {
        mapluafile = "dea1g_c",
        side = 1,
        showstr = "ifs.sp.campaign1.mission14name",
        description = "ifs.sp.campaign1.mission9descr",
--          bDimmed = 1,
    },
    
    {
        mapluafile = "pol1g_c",
        side = 1,
        showstr = "ifs.sp.campaign1.mission15name",
        description = "ifs.sp.campaign1.mission9descr",
--          bDimmed = 1,
    },
    
    
    {
        mapluafile = "tan1g_c",
        side = 1,
        showstr = "ifs.sp.campaign1.mission16name",
        description = "ifs.sp.campaign1.mission10descr",
--          bDimmed = 1,
    },
    
    {
        mapluafile = "spa1g_c",
        side = 1,
        showstr = "ifs.sp.campaign1.mission17name",
        description = "ifs.sp.campaign1.mission1descr",
--          bDimmed = 1,
    },
    
    {
        mapluafile = "yav1g_c",
        side = 1,
        showstr = "ifs.sp.campaign1.mission18name",
        description = "ifs.sp.campaign1.mission10descr",
--          bDimmed = 1,
    },
    
    {
        mapluafile = "hot1g_c",
        side = 1,
        showstr = "ifs.sp.campaign1.mission19name",
        description = "ifs.sp.campaign1.mission10descr",
--          bDimmed = 1,
    },
} -- end of Campaign 1

-- List of maps usable in attract mode. These should be the raw lua
-- filenames (without ".lua"), and one per line, so we can turn them
-- on/off easily. Historical missions could go in here if desired.

attract_mode_maps = {
    "cor1c_con",
    "cor1c_ctf",
    "cor1g_con",
    "cor1g_ctf",
    "dag1g_con",
    "dea1c_con",
    "dea1g_con",
    "dea1g_1flag",
    "end1g_con",
    "end1g_hunt",
    "fel1c_con",
    "fel1c_1flag",
    "fel1g_con",
    "fel1g_1flag",
    "geo1c_con",
    "hot1g_con",
    "kam1c_con",
    "kas2c_con",
    "kas2g_con",
    "mus1c_con",
    "mus1g_con",
    "myg1c_con",
    "myg1g_con",
    "nab2c_con",
    "nab2g_con",
    "pol1c_con",
    "pol1g_con",
--    "spa1g_con", -- no more spa _con
--    "spa2c_con", -- no more spa _con
    "spa3c_ass",
--    "spa4g_con", -- no more spa _con
    "spa6c_ass",
    "tan1c_con",
    "tan1c_1flag",
    "tan1g_con",
    "tan1g_1flag",
    "tat2c_con",
    "tat2c_ctf",
    "tat2g_con",
    "tat2g_ctf",
    "tat3c_con",
    "tat3g_con",
    "uta1c_con",
    "uta1g_con",
    "yav1c_con",
    "  yav1c_1flag",
    "yav1g_con",
    "yav1g_1flag",
}

ifs_era_vbutton_layout = {
    --  yTop = -70,
    xWidth = 350,
    width = 350,
    xSpacing = 10,
    ySpacing = 5,
    font = "gamefont_medium",
    --[[buttonlist = { 
        { tag = "c", string = "common.era.cw", },
        { tag = "g", string = "common.era.gcw", },
    },]]
	buttonlist = custom_GetEraButtonList(),
    title = "ifs.sp.pick_era",
    -- rotY = 35,
}

-- These are a list of map mode suffixes. They're concatanated onto
-- "mode_" when expanding, etc.
gMapEras = custom_GetGMapEras()
--[[{
    { key = "era_c", showstr = "common.era.cw",  subst = "c", 
        Team1Name = "common.sides.rep.name", Team2Name = "common.sides.cis.name",
        icon1 = "cis_icon", icon2 = "rep_icon",
    },
    { key = "era_g", showstr = "common.era.gcw", subst = "g",
        Team1Name = "common.sides.all.name", Team2Name = "common.sides.imp.name",
        icon1 = "imp_icon", icon2 = "all_icon",
    },
}]]

-- These are a list of map mode suffixes. They're concatanated onto
-- "mode_" when expanding, etc.
gMapModes = custom_GetGMapModes()
--[[{
	{
		key = "mode_con", showstr = "modename.name.con", 
		descstr = "modename.description.con", subst = "con",
		icon = "mode_icon_con",
	},
	{
		key = "mode_ctf", showstr = "modename.name.ctf",
		descstr = "modename.description.ctf", subst = "ctf",
		icon = "mode_icon_2ctf",
	},
	{
		key = "mode_1flag", showstr = "modename.name.1flag",
		descstr = "modename.description.1flag", subst = "1flag",
		icon = "mode_icon_ctf",
	},
	{
		key = "mode_tdm", showstr = "modename.name.tdm",
		descstr = "modename.description.tdm", subst = "tdm",
		icon = "mode_icon_tdm",
	},
	--     {
	--         key = "mode_obj", showstr = "modename.name.obj",
	--         descstr = "modename.description.obj", subst = "obj",
	--         icon = "mode_icon_obj",
	--     },
	{
		key = "mode_hunt", showstr = "modename.name.hunt",
		descstr = "modename.description.hunt", subst = "hunt",
		icon = "mode_icon_hunt",
	},
	{
		key = "mode_assault", showstr = "modename.name.assault",
		descstr = "modename.description.assault", subst = "ass",
		icon = "mode_icon_ass",
	},
	{
		key = "mode_eli", showstr = "modename.name.assault",
		descstr = "modename.description.elimination", subst = "eli",
		icon = "mode_icon_ass",
	},
	{
		key = "mode_xl", showstr = "modename.name.xl",
		descstr = "modename.description.xl", subst = "xl",
		icon = "mode_icon_XL",
	},
}]]

gAllMapsStr = "_all_maps_"
gDelAllMapsStr = "_remove_all_"
gAllModesStr = "_all_modes_"
gAllErasStr = "_all_eras_"

function missionlist_mapsorthelper(a, b)
	local Name1, Name2
	Name1 = missionlist_GetLocalizedMapName(a.mapluafile)
	Name2 = missionlist_GetLocalizedMapName(b.mapluafile)
	Name1 = ScriptCB_ununicode(Name1)
	Name2 = ScriptCB_ununicode(Name2)

	return Name1 < Name2
end

-- Expands the maplist from a bunch of modes to a flatter list.
-- If bForMP is true, it expands the MP list. If false, it expands
-- the SP list. 
function missionlist_ExpandMaplist(bForMP)
    print("missionlist_ExpandMapList()")

    if (not gSortedMaplist) then --else 63
        --table.sort(sp_missionselect_listbox_contents, missionlist_mapsorthelper)
        --table.sort(mp_missionselect_listbox_contents, missionlist_mapsorthelper)
		--[[
		local i, j, k, v, Num
		local SourceList
		if (bForMP) then
			SourceList = mp_missionselect_listbox_contents
		else
			SourceList = sp_missionselect_listbox_contents
		end

		-- Blank dest list for starters
		missionselect_listbox_contents = {}

		local expand_maps_for_pc = false
		if (expand_maps_for_pc) then
			if (gPlatformStr == "PC") then
				local FilterList = gMapModes
				Num = 1 -- where next entry in missionselect_listbox_contents will go
				for i = 1, table.getn(SourceList) do
					for j = 1, table.getn(FilterList) do
						local Tag = FilterList[j].key
						if (SourceList[i][Tag]) then
							-- Start with blank row
							missionselect_listbox_contents[Num] = {}
							-- Copy all items in this table row
							for k, v in SourceList[i] do
								missionselect_listbox_contents[Num][k] = v
								--                  print(" Copying ", k, missionselect_listbox_contents[Num][k])
							end
							-- But, we want to rename it in the process, adding in the mapname
							missionselect_listbox_contents[Num].mapluafile =
								string.format(SourceList[i].mapluafile, "%s", FilterList[j].subst)
							--              print("Added luafile ", missionselect_listbox_contents[Num].mapluafile)

							Num = Num + 1 -- move on in output list
						end -- SourceList[i].Tag exists
					end -- k loop over filters
				end -- i loop over input maps
				return
			end
		end]]
		
		if ( __mp_n_limit__ ~= nil ) then --else 29
			local r1 =  table.getn(mp_missionselect_listbox_contents) - __mp_n_limit__ 
			
			while 0 < r1 do
				local r2 = table.getn(mp_missionselect_listbox_contents) 
				table.remove( mp_missionselect_listbox_contents, r2)
				r1 = r1 - 1
			end
		end
		--lbl 29
		if __sp_n_limit__ ~= nil then --else 51
			local r1 = table.getn(sp_missionselect_listbox_contents) - __sp_n_limit__
			
			while 0 < r1 do
				local r2 = table.getn(sp_missionselect_listbox_contents) 
				table.remove( sp_missionselect_listbox_contents, r2)
				r1 = r1 - 1
			end
		end 
		--lbl 51
		table.sort(sp_missionselect_listbox_contents, missionlist_mapsorthelper)
		table.sort(mp_missionselect_listbox_contents, missionlist_mapsorthelper)
		
		gSortedMaplist = 1
	end 
	--lbl 63
	
	local r1, r2, r3, r4, r5, SourceList = nil
	
	if bForMP == true then
		SourceList = mp_missionselect_listbox_contents
	else
		SourceList = sp_missionselect_listbox_contents
	end
	
	missionselect_listbox_contents = {}
	
    for i = 1, table.getn(SourceList) do
        if (SourceList[i].mapluafile ~= gAllMapsStr) then
            -- Copy row
            missionselect_listbox_contents[i] = SourceList[i]
            missionselect_listbox_contents[i].bIsWildcard = nil
        end -- Mapluafile is not our magic constant
        -- for multiple selection
        missionselect_listbox_contents[i].bSelected = nil
    end -- i loop over input maps
    -- print("++++bSelected clear")
    -- remove "all maps" because we have "select all" button
    -- missionselect_listbox_contents[table.getn(SourceList) + 1] = { mapluafile = gAllMapsStr, bIsWildcard = 1,}

    -- TODO: alphabetize the list now?
end


-- From a maplist abbreviation (the mapluafile entry from one row of
-- the missionselect_listbox_contents array), returns a table as to
-- which modes are available. Table format is like this:
-- {
--   { showstr = "modename.name.con"}, 
-- }
function missionlist_ExpandModelist(abbrev)
    local i,j,k,Num
    local ret = {}
    Num = 1

    -- Path 1 - if "all maps" is selected, then expand it to be a list
    -- of all modes on all maps
    if(abbrev == gAllMapsStr) then
        local Added = {}
        for i=1, table.getn(missionselect_listbox_contents) do
            for j=1, table.getn(gMapModes) do
                local Tag = gMapModes[j].key
                                for k=1, table.getn(gMapEras) do
                                    local Tag2 = Tag .. "_" .. gMapEras[k].subst

                                    if((missionselect_listbox_contents[i][Tag2]) and (not Added[Tag])) then
                    ret[Num] = gMapModes[j]
                    ret[Num].bIsWildcard = nil
                    Num = Num + 1
                    Added[Tag] = 1 -- note we added this modetype
                                    end -- mode exists on this map, not added yet.
                                end -- k loop over all possible eras
            end -- j loop over modes
        end -- i loop over maps

        -- Assume that there will be > 1 mode when all the maps are expanded
        ret[Num] = { showstr = "modename.name._all_modes_", bIsWildcard = 1, descstr = "modename.description._all_modes_", }
        Num = Num + 1
    else
        -- Path 2 - need to count modes for a particular map
        for i=1, table.getn(missionselect_listbox_contents) do
            if(missionselect_listbox_contents[i].mapluafile == abbrev) then
                local Count = 0
                -- Path 2a - count # of modes available
                            local Added = {}
                for j=1, table.getn(gMapModes) do
                    local Tag = gMapModes[j].key
                                        for k=1, table.getn(gMapEras) do
                                            local Tag2 = Tag .. "_" .. gMapEras[k].subst
                                            if((missionselect_listbox_contents[i][Tag2]) and (not Added[Tag])) then
                        Count = Count + 1
                                                Added[Tag] = 1
                                            end
                                        end -- k loop over possible eras
                end -- j loop counting # of modes

                -- Now, add the modes for real
                                Added = {}
                for j=1, table.getn(gMapModes) do
                    local Tag = gMapModes[j].key
                                        for k=1, table.getn(gMapEras) do
                                            local Tag2 = Tag .. "_" .. gMapEras[k].subst
                                            if((missionselect_listbox_contents[i][Tag2]) and (not Added[Tag])) then
                        ret[Num] = gMapModes[j]
                        ret[Num].bIsWildcard = nil
                        Num = Num + 1
                                                Added[Tag] = 1
                                            end -- mode exists on this map
                                        end -- k loop over eras
                end -- j loop on modes

                -- Put "All modes" at bottom of list if multiple modes.
                if(Count > 1) then
                    ret[Num] = { showstr = "modename.name._all_modes_", bIsWildcard = 1, descstr = "modename.description._all_modes_", }
                    Num = Num + 1
                end
            end -- abbrev matched
        end -- i loop over all maps
    end

    return ret
end

-- From a maplist abbreviation (the mapluafile entry from one row of
-- the missionselect_listbox_contents array), returns a table as to
-- which modes are available. Table format is like this:
-- {
--   { showstr = "modename.name.con"}, 
-- }
--
-- If ModeEntry is nil, it does no filtering. However, if ModeEntry
-- is non-nil, it myst be a row from gMapModes, and the list of eras
-- is filtered by the li
function missionlist_ExpandEralist(abbrev, ModeEntry)
    local i,j,Num
    local ret = {}
    Num = 1

    -- Path 1 - if "all maps" is selected, then expand it to be a list
    -- of all modes on all maps
    if(abbrev == gAllMapsStr) then
        local Added = {}
        for i=1, table.getn(missionselect_listbox_contents) do
            for j=1, table.getn(gMapEras) do
                local Key = gMapEras[j].key
                if((missionselect_listbox_contents[i][Key]) and (not Added[Key])) then
                    ret[Num] = gMapEras[j]
                    ret[Num].bIsWildcard = nil
                    Num = Num + 1
                    Added[Key] = 1 -- note we added this modetype
                end -- mode exists on this map, not added yet.
            end -- j loop over modes
        end -- i loop over maps

        -- Assume that multiple modes will be on all maps
        ret[Num] = { showstr = "common.era._all_eras_", bIsWildcard = 1,}
        Num = Num + 1
    else
        -- Path 2 - need to count modes for a particular map
        for i=1, table.getn(missionselect_listbox_contents) do
            if(missionselect_listbox_contents[i].mapluafile == abbrev) then
                local Count = 0
                -- Path 2a - count # of eras available

                            -- If no mode restriction, then use old path
                            if((not ModeEntry) or (ModeEntry.bIsWildcard)) then
                for j=1, table.getn(gMapEras) do
                    local Key = gMapEras[j].key
                    if(missionselect_listbox_contents[i][Key]) then
                        Count = Count + 1
                    end
                end -- j loop counting # of modes
                            else
                                -- Mode restriction is in place. Filter list to only include
                                -- maps with this mode in place.
                for j=1, table.getn(gMapEras) do
                    local Key = ModeEntry.key .. "_" .. gMapEras[j].subst
                    if(missionselect_listbox_contents[i][Key]) then
                        Count = Count + 1
                    end
                end -- j loop counting # of modes
                            end

                -- Now, add the eras for real
                            -- If no mode restriction, then use old path
                            if((not ModeEntry) or (ModeEntry.bIsWildcard)) then
                for j=1, table.getn(gMapEras) do
                    local Key = gMapEras[j].key
                    if(missionselect_listbox_contents[i][Key]) then
                        ret[Num] = gMapEras[j]
                        ret[Num].bIsWildcard = nil
                        Num = Num + 1
                    end -- mode exists on this map
                end -- j loop on modes

                -- Put "All eras" at bottom of list if multiple eras.
                if(Count > 1) then
                    ret[Num] = { showstr = "common.era._all_eras_", bIsWildcard = 1, }
                    Num = Num + 1
                end
                            else
                                -- Mode restriction is in place. Filter list to only include
                                -- maps with this mode in place.
                for j=1, table.getn(gMapEras) do
                    local Key = ModeEntry.key .. "_" .. gMapEras[j].subst
                    if(missionselect_listbox_contents[i][Key]) then
                        ret[Num] = gMapEras[j]
                        ret[Num].bIsWildcard = nil
                        Num = Num + 1
                    end -- mode exists on this map
                end -- j loop on modes
                            end


            end -- abbrev matched
        end -- i loop over all maps
    end

    return ret
end

-- Tables for cached mapname lookups. The key for each entry will
-- be the 'abbrev' passed into missionlist_GetLocalizedMapName(abbrev)
-- if present.
gMapName0Table = {}
gMapName1Table = {}
gMapName2Table = {}

-- API
-- ShowUStr, iSource = missionlist_GetLocalizedName("tat3a")
--
-- Given an abbreviation (e.g. "tat3a"), returns a localized unicode
-- string that should be shown. Also returns an index of where that
-- string came from:
-- 0: localize database
-- 1: addon map w/ English-only string
-- 2: fallback (abbrev upconverted to Unicode)
function missionlist_GetLocalizedMapName(abbrev)
    -- Look in cached lookups first
    local CacheUStr

    CacheUStr = gMapName0Table[abbrev]
    if(CacheUStr) then
        --      print("gMapName0Table["..abbrev.."] found")
        return CacheUStr, 0
    end

    CacheUStr = gMapName1Table[abbrev]
    if(CacheUStr) then
        --      print("gMapName1Table["..abbrev.."] found")
        return CacheUStr, 1
    end

    CacheUStr = gMapName2Table[abbrev]
    if(CacheUStr) then
        --      print("gMapName2Table["..abbrev.."] found")
        return CacheUStr, 2
    end

    if(abbrev == gAllMapsStr) then
        return ScriptCB_getlocalizestr("mapname.name._all_maps_"), -1
    end

    if(abbrev == gDelAllMapsStr) then
        return ScriptCB_getlocalizestr("mapname.name._remove_all_"), -1
    end

    ------- Not cached. Do lookup, stick it in cache

    local i,j,l,l2
    l = string.len(abbrev)
    l2 = l

    -- Split string at the '_', if present
    for i = 1,(l-1) do
        if(string.sub(abbrev, i, i) == "_") then
            l2 = i
        end
    end

    -- Pass #1: try and find it in localize DB
    for i = 0,(l2-1) do
        local TrimmedStr = string.sub(abbrev, 1, l2 - i)
        local DisplayUStr = ScriptCB_getlocalizestr("mapname.name."..TrimmedStr, 1) -- 2nd param: return nil if not found
        if(DisplayUStr) then
            --          print("Got left name!",string.sub(abbrev,l2+1))
            local ModeUStr = ScriptCB_getlocalizestr("modename." .. string.sub(abbrev,l2+1), 1)
            if(ModeUStr) then
                local SpaceUStr = ScriptCB_tounicode(" ")
                local ShowUStr = ScriptCB_usprintf("common.pctspcts", DisplayUStr, SpaceUStr)
                ShowUStr = ScriptCB_usprintf("common.pctspcts", ShowUStr, ModeUStr)
                
                gMapName0Table[abbrev] = ShowUStr
                return ShowUStr, 0
            else
                gMapName0Table[abbrev] = DisplayUStr
                return DisplayUStr, 0
            end
        end
    end -- i loop over shortened strings

    -- Pass #2, try and find it in current missionlist
    if(missionselect_listbox_contents) then
        for i = 0,1 do
            local TrimmedStr = string.upper(string.sub(abbrev, 1, l - i))
            for j = 1,table.getn(missionselect_listbox_contents) do
                if(TrimmedStr == string.upper(missionselect_listbox_contents[j].mapluafile)) then
                    local DisplayUStr
                    local Entry = missionselect_listbox_contents[j]
                    local CurLang = ScriptCB_GetLanguage()
                    if(CurLang == "uk_english") then
                        CurLang = "english"
                    end
                    local Tag = "showstr_" .. CurLang
                    --                      print("Checking tag ", Tag , Entry.Tag, Entry[Tag], Entry.showstr)
                    if(Entry[Tag]) then
                        DisplayUStr = ScriptCB_tounicode(Entry[Tag])
                    elseif (Entry.showstr) then
                        DisplayUStr = ScriptCB_tounicode(Entry.showstr)
                    else
                        DisplayUStr = ScriptCB_tounicode(Entry.mapluafile)
                    end

                    gMapName1Table[abbrev] = DisplayUStr
                    return DisplayUStr, 1
                end
            end -- j loop over missionselect_listbox_contents
        end -- i loop over trimming suffixes
    end

    -- Final fallback: show what was received
    local DisplayUStr = ScriptCB_tounicode(abbrev)
    gMapName2Table[abbrev] = DisplayUStr
    return DisplayUStr, 2
end

-- Given an row from the missionlist table, returns a string which is
-- the basename for the movie
function missionlist_fnGetMovieName(Selection)
    local movieName = nil
    local movieFile = nil

    if(not Selection) then
		print("missionlist_fnGetMovieName(): emergency bailout")
        return movieName, movieFile -- emergency bailout
    end

    --movieName = movieFile.dnldable
    if(Selection.dnldable) then
		print("missionlist_fnGetMovieName(): Downloadable Map")
        movieFile = movieName
    end
	

	movieName = Selection.movieName
	if( not movieName) then 
	else 
	end 
	
	movieFile = Selection.movieFile
	if( not movieFile) then 
	else 
	end 


    return movieName, movieFile
end

-- Tables for cached map description lookups. The key for each entry
-- will be the 'abbrev' passed into
-- missionlist_GetLocalizedMapName(abbrev) if present.

gMapDescr0Table = {}
gMapDescr1Table = {}
gMapDescr2Table = {}

-- API
-- ShowUStr, iSource = missionlist_GetLocalizedName("tat3a")
--
-- Given an abbreviation (e.g. "tat3a"), returns a localized unicode
-- string that should be shown. Also returns an index of where that
-- string came from:
-- 0: localize database
-- 1: addon map w/ English-only string
-- 2: fallback (abbrev upconverted to Unicode)
function missionlist_GetLocalizedMapDescr(abbrev)
    -- Look in cached lookups first
    local CacheUStr

    CacheUStr = gMapDescr0Table[abbrev]
    if(CacheUStr) then
        --      print("gMapDescr0Table["..abbrev.."] found")
        return CacheUStr, 0
    end

    CacheUStr = gMapDescr1Table[abbrev]
    if(CacheUStr) then
        --      print("gMapDescr1Table["..abbrev.."] found")
        return CacheUStr, 1
    end

    CacheUStr = gMapDescr2Table[abbrev]
    if(CacheUStr) then
        --      print("gMapDescr2Table["..abbrev.."] found")
        return CacheUStr, 2
    end

    if(abbrev == gAllMapsStr) then
        return ScriptCB_getlocalizestr("mapname.description._all_maps_"), -1
    end

    if(abbrev == gDelAllMapsStr) then
        return ScriptCB_getlocalizestr("mapname.description._remove_all_"), -1
    end

    ------- Not cached. Do lookup, stick it in cache

    local i,j,l,l2
    l = string.len(abbrev)
    l2 = l

    -- Split string at the '_', if present
    for i = 1,(l-1) do
        if(string.sub(abbrev, i, i) == "_") then
            l2 = i
        end
    end

    -- Pass #1: try and find it in localize DB
    for i = 0,(l2-1) do
        local TrimmedStr = string.sub(abbrev, 1, l2 - i)
        local DisplayUStr = ScriptCB_getlocalizestr("mapname.description."..TrimmedStr, 1) -- 2nd param: return nil if not found
        if(DisplayUStr) then
            --          print("Got left name!",string.sub(abbrev,l2+1))
            local ModeUStr = ScriptCB_getlocalizestr("modename." .. string.sub(abbrev,l2+1), 1)
            if(ModeUStr) then
                local SpaceUStr = ScriptCB_tounicode(" ")
                local ShowUStr = ScriptCB_usprintf("common.pctspcts", DisplayUStr, SpaceUStr)
                ShowUStr = ScriptCB_usprintf("common.pctspcts", ShowUStr, ModeUStr)
                
                gMapDescr0Table[abbrev] = ShowUStr
                return ShowUStr, 0
            else
                gMapDescr0Table[abbrev] = DisplayUStr
                return DisplayUStr, 0
            end
        end
    end -- i loop over shortened strings

    -- Pass #2, try and find it in current missionlist
    if(missionselect_listbox_contents) then
        for i = 0,1 do
            local TrimmedStr = string.upper(string.sub(abbrev, 1, l - i))
            for j = 1,table.getn(missionselect_listbox_contents) do
                if(TrimmedStr == string.upper(missionselect_listbox_contents[j].mapluafile)) then
                    local DisplayUStr
                    local Entry = missionselect_listbox_contents[j]
                    local CurLang = ScriptCB_GetLanguage()
                    if(CurLang == "uk_english") then
                        CurLang = "english"
                    end
                    local Tag = "showstr_" .. CurLang
                    --                      print("Checking tag ", Tag , Entry.Tag, Entry[Tag], Entry.showstr)
                    if(Entry[Tag]) then
                        DisplayUStr = ScriptCB_tounicode(Entry[Tag])
                    elseif (Entry.showstr) then
                        DisplayUStr = ScriptCB_tounicode(Entry.showstr)
                    else
                        DisplayUStr = ScriptCB_tounicode(Entry.mapluafile)
                    end

                    gMapDescr1Table[abbrev] = DisplayUStr
                    return DisplayUStr, 1
                end
            end -- j loop over missionselect_listbox_contents
        end -- i loop over trimming suffixes
    end

    -- Final fallback: show what was received
    local DisplayUStr = ScriptCB_tounicode(abbrev)
    gMapDescr2Table[abbrev] = DisplayUStr
    return DisplayUStr, 2
end

--[[ repeat function? Given an row from the missionlist table, returns a string which is
-- the basename for the movie
function missionlist_fnGetMovieName(Selection)
    local movieName = nil
    local movieFile = nil

    if(not Selection) then
        return movieName, movieFile -- emergency bailout
    end

    movieName = Selection.mapluafile
    if(Selection.dnldable) then
        movieFile = movieName
    end

    -- HACK - only use first 4 chars of moviename. This may need to
    -- change eventually. (Trim off everything after first %s, I
    -- suspect)
    movieName = string.sub(movieName,1,4)
    if(movieName == "TEST") then
        movieName = nil
    end

    return movieName, movieFile
end]] 

-- Takes a map luafile (e.g. "end1g_con") and returns the row from gMapModes
-- that's appropriate for that map. Returns nil if the mode isn't found
function missionlist_GetMapMode(abbrev)
    local i,j,l,l2
    l = string.len(abbrev)
    l2 = 0

    -- Split string at the '_', if present
    for i = 1,(l-1) do
        if(string.sub(abbrev, i, i) == "_") then
            l2 = i
        end
    end

    local CheckMode = string.sub(abbrev, l2+1)
    for i = 1, table.getn(gMapModes) do
        if(gMapModes[i].subst == CheckMode) then
            return gMapModes[i]
        end     
    end

    return nil -- not found
end

-- Takes a map luafile (e.g. "end1g_con") and returns the row from gMapEras
-- that's appropriate for that map. Returns nil if the mode isn't found
function missionlist_GetMapEra(abbrev)
    local i,j,l,l2
    l = string.len(abbrev)
    l2 = l

    -- Split string at the '_', if present
    for i = 1,(l-1) do
        if(string.sub(abbrev, i, i) == "_") then
            l2 = i
        end
    end

    local CheckChar = string.sub(abbrev, l2-1, l2-1)
    for i = 1, table.getn(gMapEras) do
        if(gMapEras[i].subst == CheckChar) then
            return gMapEras[i]
        end     
    end

    return nil -- not found
end

--[[ Fill in some items that differ per-platform
if (gPlatformStr == "PS2") then
    SPCampaign1[1].outtromovie = "tutorial01cw"
    SPCampaign1[1].outtromovie_left = 50
    SPCampaign1[1].outtromovie_top = 60
    SPCampaign1[1].outtromovie_width = 400
    SPCampaign1[1].outtromovie_height = 336
    SPCampaign1[1].outtromovielocalized = 1

    --     SPCampaign2[1].outtromovie = "tutorial01gcw"
    --     SPCampaign2[1].outtromovie_left = 50
    --     SPCampaign2[1].outtromovie_top = 60
    --     SPCampaign2[1].outtromovie_width = 400
    --     SPCampaign2[1].outtromovie_height = 336
    --     SPCampaign2[1].outtromovielocalized = 1
elseif (gPlatformStr == "XBox") then
    SPCampaign1[1].outtromovie = "tutorial01cw"
    SPCampaign1[1].outtromovie_left = 90
    SPCampaign1[1].outtromovie_top = 60
    SPCampaign1[1].outtromovie_width = 460
    SPCampaign1[1].outtromovie_height = 350
    SPCampaign1[1].outtromovielocalized = 1

    --     SPCampaign2[1].outtromovie = "tutorial01gcw"
    --     SPCampaign2[1].outtromovie_left = 90
    --     SPCampaign2[1].outtromovie_top = 60
    --     SPCampaign2[1].outtromovie_width = 460
    --     SPCampaign2[1].outtromovie_height = 350
    --     SPCampaign2[1].outtromovielocalized = 1
elseif (gPlatformStr == "PC") then]]
    -- Zap out all 'unlockable' flags
    local i
    for i=1,table.getn(SPCampaign1) do
        SPCampaign1[i].unlockable = nil
    end

    --     for i=1,table.getn(SPCampaign2) do
    --         SPCampaign2[i].unlockable = nil
    --     end
--end

