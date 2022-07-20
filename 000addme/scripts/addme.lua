print("Start 000/addme.script")

if(printf == nil) then 
    function printf (...) print(string.format(unpack(arg))) end
end 

if( tprint == nil ) then 
    function getn(v)
        local v_type = type(v);
        if v_type == "table" then
            return table.getn(v);
        elseif v_type == "string" then
            return string.len(v);
        else
            return;
        end
    end

    function string.starts(str, Start)
        return string.sub(str, 1, getn(Start)) == Start;
    end

    function tprint(t, indent)
        if not indent then indent = 1, print(tostring(t) .. " {") end
        if t then
            for key,value in pairs(t) do
                if not string.starts(tostring(key), "__") then
                    local formatting = string.rep("    ", indent) .. tostring(key) .. "= ";
                    if value and type(value) == "table" then
                        print(formatting .. --[[tostring(value) ..]] " {")
                        tprint(value, indent+1);
                    else
                        if(type(value) == "string") then 
                            --print(formatting .."'" .. tostring(value) .."'" ..",")
                            printf("%s'%s',",formatting, tostring(value))
                        else 
                            print(formatting .. tostring(value) ..",")
                        end 
                    end
                end
            end
            print(string.rep("    ", indent - 1) .. "},")
        end
    end
end

---

-- functionality to add strings 
if( modStringTable == nil ) then
	modStringTable = {} -- table to hold custom strings 
	
	-- function to add custom strings  
	function addModString(stringId, content)
		modStringTable[stringId] = ScriptCB_tounicode(content)
	end 

	if oldScriptCB_getlocalizestr == nil then 
		-- Overwrite 'ScriptCB_getlocalizestr()' to first check for the strings we added
		print("redefine: ScriptCB_getlocalizestr() ")

		oldScriptCB_getlocalizestr = ScriptCB_getlocalizestr
		ScriptCB_getlocalizestr = function (...)
			local stringId = " "
			if( table.getn(arg) > 0 ) then 
				stringId = arg[1]
			end
			if( modStringTable[stringId] ~= nil) then -- first check 'our' strings
				retVal = modStringTable[stringId]
			else 
				retVal = oldScriptCB_getlocalizestr( unpack(arg) )
			end 
			return retVal 
		end
	end 
end
-- Force 'IFText_fnSetString' to use strings from our 'modStringTable' too 
if ( oldIFText_fnSetString == nil )then 
    oldIFText_fnSetString = IFText_fnSetString
    IFText_fnSetString = function(...)
        if( table.getn(arg) > 1 and modStringTable[arg[2]] ~= nil ) then 
            arg[2] = modStringTable[arg[2]]
            IFText_fnSetUString(unpack(arg))
            return 
        end 
        oldIFText_fnSetString(unpack(arg))
    end 
end 

addModString("ifs.console.action","Instant Action (alt)")
-- 
-------------------------------------------------------------------------------------------
--function RedefineExpandMissionList() 
    print("RedefineExpandMissionList: Gonna Do the files")
    print("RedefineExpandMissionList: Did the Files")

    -- Expands the maplist from a bunch of modes to a flatter list.
    -- If bForMP is true, it expands the MP list. If false, it expands
    -- the SP list. 
    missionlist_ExpandMaplist = function (bForMP)
        print("missionlist_ExpandMaplist: calling re-defined version")
        if(not gSortedMaplist) then
            table.sort(sp_missionselect_listbox_contents, missionlist_mapsorthelper) 
            table.sort(mp_missionselect_listbox_contents, missionlist_mapsorthelper) 
            gSortedMaplist = 1
        end

        local i,j,k,v,Num
        local SourceList
        if(bForMP) then
            SourceList = mp_missionselect_listbox_contents
        else
            SourceList = sp_missionselect_listbox_contents
        end

        -- Blank dest list for starters
        missionselect_listbox_contents = {}

        local expand_maps_for_pc = false
        if( expand_maps_for_pc ) then
            if(gPlatformStr == "PC") then
                local FilterList = gMapModes
            Num = 1 -- where next entry in missionselect_listbox_contents will go
            for i = 1,table.getn(SourceList) do
                    for j = 1,table.getn(FilterList) do
                        local Tag = FilterList[j].key
                        if(SourceList[i][Tag]) then
                            -- Start with blank row
                            missionselect_listbox_contents[Num] = {}
                            -- Copy all items in this table row
                            for k,v in SourceList[i] do
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
        end

        for i = 1,table.getn(SourceList) do
            if(SourceList[i].mapluafile ~= gAllMapsStr) then
                -- Copy row
                missionselect_listbox_contents[i] = SourceList[i]
                missionselect_listbox_contents[i].bIsWildcard = nil
            end -- Mapluafile is not our magic constant
            -- for multiple selection
            missionselect_listbox_contents[i].bSelected = nil
        end -- i loop over input maps
        --print("++++bSelected clear")
        --remove "all maps" because we have "select all" button -- add it back in! -BAD_AL
        missionselect_listbox_contents[table.getn(SourceList) + 1] = { mapluafile = gAllMapsStr, bIsWildcard = 1,}

        -- TODO: alphabetize the list now?
    end

----- ADD uop eras & modes--------------------------------------------------------------------------------------
print("Add UOP Eras and Game Modes: Start")
uopMapEras = {
    { Team2Name= 'common.sides.cis.name', key= 'era_c', icon2= 'rep_icon', subst= 'c', showstr= 'common.era.cw', icon1= 'cis_icon', Team1Name= 'common.sides.rep.name', },
    { Team2Name= 'common.sides.imp.name', key= 'era_g', icon2= 'all_icon', subst= 'g', showstr= 'common.era.gcw', icon1= 'imp_icon', Team1Name= 'common.sides.all.name', },
    { Team2Name= 'common.sides.k.name', key= 'era_k', icon2= 'kotor_icon', subst= 'k', showstr= 'common.era.k', icon1= 'k_icon', Team1Name= 'common.sides.k.name', },
    { Team2Name= 'common.sides.n.name', key= 'era_n', icon2= 'newrep_icon', subst= 'n', showstr= 'common.era.n', icon1= 'n_icon', Team1Name= 'common.sides.n.name', },
    { Team2Name= 'common.sides.y.name', key= 'era_y', icon2= 'yuz_icon', subst= 'y', showstr= 'common.era.y', icon1= 'y_icon', Team1Name= 'common.sides.y.name', },
    { Team2Name= 'common.sides.a.name', key= 'era_a', icon2= 'bfx_cw_icon', subst= 'a', showstr= 'common.era.a', icon1= 'a_icon', Team1Name= 'common.sides.a.name', },
    { Team2Name= 'common.sides.b.name', key= 'era_b', icon2= 'bfx_gcw_icon', subst= 'b', showstr= 'common.era.b', icon1= 'b_icon', Team1Name= 'common.sides.b.name', },
    { Team2Name= 'common.sides.d.name', key= 'era_d', icon2= 'newsithwars_icon', subst= 'd', showstr= 'common.era.d', icon1= 'd_icon', Team1Name= 'common.sides.d.name', },
    { Team2Name= 'common.sides.e.name', key= 'era_e', icon2= 'earth_icon', subst= 'e', showstr= 'common.era.e', icon1= 'e_icon', Team1Name= 'common.sides.e.name', },
    { Team2Name= 'common.sides.f.name', key= 'era_f', icon2= 'front_icon', subst= 'f', showstr= 'common.era.f', icon1= 'f_icon', Team1Name= 'common.sides.f.name', },
    { Team2Name= 'common.sides.h.name', key= 'era_h', icon2= 'halo_icon', subst= 'h', showstr= 'common.era.h', icon1= 'h_icon', Team1Name= 'common.sides.h.name', },
    { Team2Name= 'common.sides.i.name', key= 'era_i', icon2= 'i_icon', subst= 'i', showstr= 'common.era.i', icon1= 'i_icon', Team1Name= 'common.sides.i.name', },
    { Team2Name= 'common.sides.j.name', key= 'era_j', icon2= 'j_icon', subst= 'j', showstr= 'common.era.j', icon1= 'j_icon', Team1Name= 'common.sides.j.name', },
    { Team2Name= 'common.sides.l.name', key= 'era_l', icon2= 'lego_icon', subst= 'l', showstr= 'common.era.l', icon1= 'l_icon', Team1Name= 'common.sides.l.name', },
    { Team2Name= 'common.sides.m.name', key= 'era_m', icon2= 'imp_icon', subst= 'm', showstr= 'common.era.m', icon1= 'm_icon', Team1Name= 'common.sides.m.name', },
    { Team2Name= 'common.sides.o.name', key= 'era_o', icon2= 'oldsith_icon', subst= 'o', showstr= 'common.era.o', icon1= 'o_icon', Team1Name= 'common.sides.o.name', },
    { Team2Name= 'common.sides.p.name', key= 'era_p', icon2= 'rep_icon', subst= 'p', showstr= 'common.era.p', icon1= 'p_icon', Team1Name= 'common.sides.p.name', },
    { Team2Name= 'common.sides.q.name', key= 'era_q', icon2= 'all_icon', subst= 'q', showstr= 'common.era.q', icon1= 'q_icon', Team1Name= 'common.sides.q.name', },
    { Team2Name= 'common.sides.r.name', key= 'era_r', icon2= 'rvb_icon', subst= 'r', showstr= 'common.era.r', icon1= 'r_icon', Team1Name= 'common.sides.r.name', },
    { Team2Name= 'common.sides.s.name', key= 'era_s', icon2= 'rebirth_icon', subst= 's', showstr= 'common.era.s', icon1= 's_icon', Team1Name= 'common.sides.s.name', },
    { Team2Name= 'common.sides.t.name', key= 'era_t', icon2= 'toys_icon', subst= 't', showstr= 'common.era.t', icon1= 't_icon', Team1Name= 'common.sides.t.name', },
    { Team2Name= 'common.sides.u.name', key= 'era_u', icon2= 'u_icon', subst= 'u', showstr= 'common.era.u', icon1= 'u_icon', Team1Name= 'common.sides.u.name', },
    { Team2Name= 'common.sides.v.name', key= 'era_v', icon2= 'v_icon', subst= 'v', showstr= 'common.era.v', icon1= 'v_icon', Team1Name= 'common.sides.v.name', },
    { Team2Name= 'common.sides.w.name', key= 'era_w', icon2= 'wacky_icon', subst= 'w', showstr= 'common.era.w', icon1= 'w_icon', Team1Name= 'common.sides.w.name', },
    { Team2Name= 'common.sides.x.name', key= 'era_x', icon2= 'exGCW_icon', subst= 'x', showstr= 'common.era.x', icon1= 'x_icon', Team1Name= 'common.sides.x.name', },
    { Team2Name= 'common.sides.z.name', key= 'era_z', icon2= 'z_icon', subst= 'z', showstr= 'common.era.z', icon1= 'z_icon', Team1Name= 'common.sides.z.name', },
    { Team2Name= 'common.sides.1.name', key= 'era_1', icon2= 'cis_icon', subst= '1', showstr= 'common.era.1', icon1= '1_icon', Team1Name= 'common.sides.1.name', },
    { Team2Name= 'common.sides.2.name', key= 'era_2', icon2= 'imp_icon', subst= '2', showstr= 'common.era.2', icon1= '2_icon', Team1Name= 'common.sides.2.name', },
}



uopMapModes = {
    { key= 'mode_con', subst= 'con', showstr= 'modename.name.con', descstr= 'modename.description.con', icon= 'mode_icon_con', },
    { key= 'mode_ctf', subst= 'ctf', showstr= 'modename.name.ctf', descstr= 'modename.description.ctf', icon= 'mode_icon_2ctf', },
    { key= 'mode_1flag', subst= '1flag', showstr= 'modename.name.1flag', descstr= 'modename.description.1flag', icon= 'mode_icon_ctf', },
    { key= 'mode_assault', subst= 'ass', showstr= 'modename.name.spa-assault', descstr= 'modename.description.assault', icon= 'mode_icon_ass', },
    { key= 'mode_hunt', subst= 'hunt', showstr= 'modename.name.hunt', descstr= 'modename.description.hunt', icon= 'mode_icon_hunt', },
    { key= 'mode_eli', subst= 'eli', showstr= 'modename.name.hero-assault', descstr= 'modename.description.elimination', icon= 'mode_icon_eli', },
    { key= 'mode_tdm', subst= 'tdm', showstr= 'modename.name.tdm', descstr= 'modename.description.tdm', icon= 'mode_icon_tdm', },
    { key= 'mode_xl', subst= 'xl', showstr= 'modename.name.xl', descstr= 'modename.description.xl', icon= 'mode_icon_xl', },
    { key= 'mode_obj', subst= 'obj', showstr= 'modename.name.obj', descstr= 'modename.description.obj', icon= 'mode_icon_obj', },
    { key= 'mode_c', subst= 'c', showstr= 'modename.name.c', descstr= 'modename.description.c', icon= 'mode_icon_c', },
    { key= 'mode_uber', subst= 'uber', showstr= 'modename.name.uber', descstr= 'modename.description.uber', icon= 'mode_icon_uber', },
    { key= 'mode_bf1', subst= 'bf1', showstr= 'modename.name.bf1', descstr= 'modename.description.bf1', icon= 'mode_icon_bf1', },
    { key= 'mode_holo', subst= 'holo', showstr= 'modename.name.holo', descstr= 'modename.description.holo', icon= 'mode_icon_holo', },
    { key= 'mode_ord66', subst= 'ord66', showstr= 'modename.name.ord66', descstr= 'modename.description.ord66', icon= 'mode_icon_ord66', },
    { key= 'mode_dm', subst= 'dm', showstr= 'modename.name.dm', descstr= 'modename.description.dm', icon= 'mode_icon_dm', },
    { key= 'mode_space', subst= 'space', showstr= 'modename.name.space', descstr= 'modename.description.space', icon= 'mode_icon_space', },
    { key= 'mode_c1', subst= 'c1', showstr= 'modename.name.c1', descstr= 'modename.description.c1', icon= 'mode_icon_c1', },
    { key= 'mode_c2', subst= 'c2', showstr= 'modename.name.c2', descstr= 'modename.description.c2', icon= 'mode_icon_c2', },
    { key= 'mode_c3', subst= 'c3', showstr= 'modename.name.c3', descstr= 'modename.description.c3', icon= 'mode_icon_c3', },
    { key= 'mode_c4', subst= 'c4', showstr= 'modename.name.c4', descstr= 'modename.description.c4', icon= 'mode_icon_c4', },
    { key= 'mode_hctf', subst= 'hctf', showstr= 'modename.name.hctf', descstr= 'modename.description.hctf', icon= 'mode_icon_hctf', },
    { key= 'mode_vhcon', subst= 'vhcon', showstr= 'modename.name.vhcon', descstr= 'modename.description.vhcon', icon= 'mode_icon_vehicle', },
    { key= 'mode_vhtdm', subst= 'vhtdm', showstr= 'modename.name.vhtdm', descstr= 'modename.description.vhtdm', icon= 'mode_icon_vehicle', },
    { key= 'mode_vhctf', subst= 'vhctf', showstr= 'modename.name.vhctf', descstr= 'modename.description.vhctf', icon= 'mode_icon_vehicle', },
    { key= 'mode_avh', subst= 'avh', showstr= 'modename.name.avh', descstr= 'modename.description.avh', icon= 'mode_icon_avh', },
    { key= 'mode_lms', subst= 'lms', showstr= 'modename.name.lms', descstr= 'modename.description.lms', icon= 'mode_icon_lms', },
    { key= 'mode_vh', subst= 'vh', showstr= 'modename.name.vh', descstr= 'modename.description.vh', icon= 'mode_icon_vehicle', },
    { key= 'mode_race', subst= 'race', showstr= 'modename.name.race', descstr= 'modename.description.race', icon= 'mode_icon_race', },
    { key= 'mode_koh', subst= 'koh', showstr= 'modename.name.koh', descstr= 'modename.description.koh', icon= 'mode_icon_koh', },
    { key= 'mode_tdf', subst= 'tdf', showstr= 'modename.name.tdf', descstr= 'modename.description.tdf', icon= 'mode_icon_tdf', },
    { key= 'mode_surv', subst= 'surv', showstr= 'modename.name.surv', descstr= 'modename.description.surv', icon= 'mode_icon_survival', },
    { key= 'mode_rpg', subst= 'rpg', showstr= 'modename.name.rpg', descstr= 'modename.description.rpg', icon= 'mode_icon_rpg', },
    { key= 'mode_wav', subst= 'wav', showstr= 'modename.name.wav', descstr= 'modename.description.wav', icon= 'mode_icon_wav', },
    { key= 'mode_ctrl', subst= 'ctrl', showstr= 'modename.name.ctrl', descstr= 'modename.description.ctrl', icon= 'mode_icon_control', },
    { key= 'mode_seige', subst= 'seige', showstr= 'modename.name.seige', descstr= 'modename.description.seige', icon= 'mode_icon_siege', },
    { key= 'mode_siege', subst= 'siege', showstr= 'modename.name.siege', descstr= 'modename.description.siege', icon= 'mode_icon_siege', },
    { key= 'mode_jhu', subst= 'jhu', showstr= 'modename.name.jhu', descstr= 'modename.description.jhu', icon= 'mode_icon_jhu', },
    { key= 'mode_wea', subst= 'wea', showstr= 'modename.name.wea', descstr= 'modename.description.wea', icon= 'mode_icon_wea', },
    { key= 'mode_ins', subst= 'ins', showstr= 'modename.name.ins', descstr= 'modename.description.ins', icon= 'mode_icon_ins', },
}

function uop_AddEra(entry)
    if( entry.key ~= nil and entry.showstr ~= nil and entry.subst ~= nil and 
         entry.Team1Name ~= nil and entry.Team2Name ~= nil  ) then 
        ---------- check if it's already present ----------
        for key,value in gMapEras do -- check if entry is already present 
            if( value.key == entry.key) then
                print("uop_AddEra(): Era with key '".. value.key .. "' is already present.")
                return 
            end
        end
        if(entry.icon1 == nil) then
            print("uop_AddEra: Warning, adding era without property 'icon1'")
        end
        ---------------------------------------------------
        table.insert( gMapEras, entry )
        print("uop_AddEra(): added Era: ")
    else 
        print("uop_AddEra: Error adding Era. Must specify properties [key, showstr, subst, Team1Name, Team2Name ]\n" .. 
            "Use 'uop_PrintEras()' to see format of existing eras.")
    end 
end 
function uop_AddGameMode(entry)
    if( entry.key ~= nil and entry.showstr ~= nil and entry.descstr ~= nil and entry.subst ~= nil ) then 
        ---------- check if it's already present ----------
        for key,value in gMapModes do
            if( value.key == entry.key) then
                print("uop_AddGameMode(): Mode with key '".. value.key .. "' is already present.")
                return 
            end
        end
        if(entry.icon == nil) then
            print("uop_AddGameMode: Warning, adding game mode without property 'icon'")
        end
        ---------------------------------------------------
        table.insert( gMapModes, entry )
        print("uop_AddGameMode(): added Era: ")
    else 
        print("uop_AddGameMode: Error adding Game mode. Must specify [key, showstr, descstr, subst]\n" ..
            "Use 'uop_PrintGameModes()' to see format of existing Game mode entries.")
    end 
end 

if( custom_GetSPMissionList  == nil ) then -- will be nil if the game doesn't have the 1.3 un-official patch
    print("UOP 1.3 not detected, define a bunch of stuff")
    local i = 1 
    local limit = table.getn(uopMapEras)
    while i < limit do 
        uop_AddEra(uopMapEras[i])
        i = i + 1
    end

    i = 1 
    limit = table.getn(uopMapModes)
    while i < limit do 
        uop_AddGameMode(uopMapModes[i])
        i = i + 1
    end
    print("Add UOP Eras and Game Modes: End")


    -------------------------------- Custom GC support START --------------------------------------------------------------
    --Galatic Conquest's Battle Mode game mode list
    --Note: This table is automatically generated based off of custom_gBattleModeList
    custom_gBattleModes = nil
    custom_gBattleModeList = gMapModes -- in UOP "custom_gBattleModeList = custom_gModes"; but here we'll just use gMapModes

    --
    -- Generates the game modes for use when picking the Galatic Conquest mode to fight in (from ifs_era_handler)
    --
    function custom_GetFreeformBattleModeList()
        --print("custom_GetFreeformBattleModeList()")
        
        --if the battle mode table hasn't been build, build it
        if custom_gBattleModes == nil then
            --print("custom_GetFreeformBattleModeList(): Building game mode table")
            
            --make sure we have something to build off of
            if custom_gBattleModeList == nil then
                print("custom_GetFreeformBattleModeList(): Game mode ids are nil!")
                print("custom_GetFreeformBattleModeList(): Cannot build game modes.  Expect further errors!")
                return {}
            end
            
            --for each game mode id, build a templated game mode
            custom_gBattleModes = {}
            local template = nil
            for i=1,table.getn(custom_gBattleModeList) do
                template = {}
                template.string = 	custom_gBattleModeList[i].showstr or ("modename.name."..custom_gBattleModeList[i].id)
                template.tag = 		custom_gBattleModeList[i].subst	  or (""..custom_gBattleModeList[i].id)
                
                --save this new game mode
                table.insert(custom_gBattleModes, template)
                --print("custom_GetFreeformBattleModeList(): Generated game mode: " .. custom_gBattleModeList[i].id, "Known Modes: " .. table.getn(custom_gBattleModes))
            end
            
            --free up a bit of memory
            custom_gModes = nil
            print("custom_GetFreeformBattleModeList(): Finished building freeform battle mode list", "Known Modes: " .. table.getn(custom_gBattleModes))
        end
        
        return custom_gBattleModes
    end

    function custom_GetGCButtonList()
        print("custom_GetGCButtonList()")
    return {
        { tag = "1", string = "ifs.meta.Configs.1", },
        { tag = "2", string = "ifs.meta.Configs.2", },
        { tag = "3", string = "ifs.meta.Configs.3", },
        { tag = "4", string = "ifs.meta.Configs.4", },
        -- no splitscreen on PC
        { tag = "campaign", string = "ifs.sp.campaign1.title", },
        { tag = "custom", string = "ifs.meta.Configs.custom", }, --re-enabled, by [RDH]Zerted
        { tag = "load", string = "ifs.meta.load.btnload", },
    }
    end

    function custom_PressedGCButton( tag )
        print("custom_PressedGCButton()")
        
    --if we didn't handle this, return false
    return false
    end

    -- check for 0 to 1000, 
    local limit = 1000 
    local scriptName = ""
    for i = 0, limit, 1 do 
        scriptName = "custom_gc_" .. i
        if (scriptName == "custom_gc_10") then 
            --  skip custom_gc_10, because that was a special one 
            --  from zerted that loaded more custom_gc lvls
        elseif ScriptCB_IsFileExist(scriptName .. ".lvl") == 0 then
            -- print("shell_interface: No " .. scriptName .. ".lvl")
        else
            print("shell_interface: Found " .. scriptName .. ".lvl")
            ReadDataFile(scriptName .. ".lvl")
            ScriptCB_DoFile(scriptName)
        end
    end

    local  oldScriptCB_PushScreen = ScriptCB_PushScreen
    ScriptCB_PushScreen = function(screenName)
        local screenToPush = screenName 
        if( screenToPush == "ifs_freeform_battle_mode") then
            screenToPush = "ifs_freeform_battle_mode_replacement"
        --elseif(screenToPush == "ifs_sp_campaign") then
        --    screenToPush = "ifs_sp_campaign_console"
        end
        print("ScriptCB_PushScreen: push " .. screenToPush)
        oldScriptCB_PushScreen(screenToPush)
    end
else
    local  oldScriptCB_PushScreen = ScriptCB_PushScreen
    ScriptCB_PushScreen = function(screenName)
        local screenToPush = screenName 
        print("ScriptCB_PushScreen: push " .. screenToPush)
        oldScriptCB_PushScreen(screenToPush)
    end
end
-------------------------------- Custom GC support END --------------------------------------------------------------

------------------- add easier keyboard/controller support for ifs_login -------------------
print("ifs_login.Input_KeyDown : " .. tostring(ifs_login.Input_KeyDown))

local old_ifs_login_keydown = ifs_login.Input_KeyDown

ifs_login.Input_KeyDown = function(this, iKey)
    print("ifs_login.Input_Keydown iKey= " .. tostring(iKey))
    if (iKey == 32) then  -- spacebar
        old_ifs_login_keydown(this,13) -- make 'space' act like 'enter'
    else
        old_ifs_login_keydown(this,iKey)
    end
end

local old_ifs_sp_campaign_keydown = ifs_sp_campaign.Input_Keydown
ifs_sp_campaign.Input_KeyDown = function(this, iKey)
    print("ifs_sp_campaign.Input_Keydown iKey= " .. tostring(iKey))
    if (iKey == 32) then  -- spacebar
        this:Input_Accept()
    elseif ( old_ifs_sp_campaign_keydown ~= nil) then
        old_ifs_sp_campaign_keydown(this,iKey)
    end
end
--------------------------------------------------------------
--[[
B			66	The B key.
Back		8	The BACKSPACE key.
Escape		27	The ESC key.
Enter       13  The Enter key
Spacebar    32
PageUp		33	The PAGE UP key.
PageDown	34	The PAGE DOWN key.
]]
function gInput_KeyDown(this, iKey)  -- (reminder for better keyboard support with the default keyboard layout)
    print("gInput_KeyDown: " .. iKey)
    if(iKey == 27 or iKey == 8 or iKey == 66) then
        this.Input_Back(this)
    elseif(iKey == 13 or iKey == 32) then
        this.Input_Accept(this)
    elseif(iKey == 33) then
        this.Input_LTrigger(this)
    elseif(iKey == 34) then
        this.Input_RTrigger(this)
    end
end
----- Redefine the accept handler for 'ifs_sp_campaign'----
print("Plumb in the Console instant action screen (hijack 'spacetraining' button )")
-- take over the 'spacetraining' button
--IFText_fnSetString(ifs_sp_campaign.buttons.spacetraining.label, "GC, InstantAction (ALT)")  -- set new text on spacetraining button
IFText_fnSetString(ifs_sp_campaign.buttons.spacetraining.label, "InstantAction (ALT)")  -- set new text on spacetraining button

-- handle spacetraining button press
ifs_sp_campaign.old_Input_Accept = ifs_sp_campaign.Input_Accept
        
ifs_sp_campaign.Input_Accept = function(this)
    print("ifs_sp_campaign.Input_Accept: ".. tostring(this.CurButton))
    if(this.CurButton == "spacetraining") then
        print("Push: ifs_missionselect_console")
        ifelm_shellscreen_fnPlaySound(this.acceptSound)
        ScreenToPush = ifs_missionselect_console
        ifs_movietrans_PushScreen(ScreenToPush)
    else
        ifs_sp_campaign.old_Input_Accept(this)
    end
end

-- not doing these anymore 
--ScriptCB_DoFile("ifs_freeform_battle_mode_replacement")
--ScriptCB_DoFile("ifs_sp_campaign_console")
--ScriptCB_DoFile("ifs_sp_console")
ScriptCB_DoFile("ifs_missionselect_console")

function simpleTableToString(the_table)
    local retVal = ""
    print("simpleTableToString: the_table type = ".. type(the_table))
    tprint(the_table)
    for k,v in pairs(the_table) do
        if(type(v) ~= "table") then
            retVal = retVal .. string.format("%s: %s, ", k,v)
        else
            retVal = retVal .. string.format("%s: 'table', ", k)
        end
    end
    return retVal
end

if( movePlanet == nil ) then 
    -- let's not overwrite this if it's already been defined 
    function movePlanet(this,x,y)
            -- code taken from ifs_freeform_main.UpdateNextPlanet
            print("movePlanet ScreenName:" .. tostring(this.ScreenName))
            -- get the joystick magnitude
            local magnitude = x * x + y * y
            print(string.format("movePlanet x: %d y: %d magnitude: %d", x, y, magnitude))
            
            -- if controller move was registered
            --if this.movePressed then
            --    print("movePlanet: controller move was registered")
            --	-- if released...
            --	if magnitude < 0.01 then
            --		-- clear moved
            --        print("movePlanet: clear movePressed")
            --		this.movePressed = nil
            --	end
            --    print("doing nothing")
            --else
                print("movePlanet magnitude: " .. magnitude)
                -- if pushed sufficiently...
                if magnitude > 0.4096 then
                    print("movePlanet trying the move")
                    -- register moved
                    this.movePressed = true
                
                    -- normalize the direction
                    local scale = math.sqrt(magnitude)
                    x = x / scale
                    y = -y / scale
                    
                    print("movePlanet this.planetSelected: ".. tostring(this.planetSelected))
                    print("movePlanet ifs_freeform_main.planetSelected: ".. tostring(ifs_freeform_main.planetSelected))

                    -- get the starting planet's screen position
                    local x0, y0 = GetScreenPosition(this.planetSelected)
                    print( string.format("Starting planet: %s x: %d y: %d", tostring(this.planetSelected), x0, y0))
                    -- for each planet...
                    local bestscore = 0
                    for index, planet in ipairs(this.planetDestination[this.planetSelected]) do
                        -- if no fleet is selected, or the destination does not have a friendly fleet...
                        if not this.fleetSelected or this.planetFleet[planet] ~= this.playerTeam then
                            -- get the planet's screen position
                            local x1, y1 = GetScreenPosition(planet)
                            print( string.format("Candidate planet: %s x: %d y: %d", planet, x1, y1))
                            
                            -- get the normalized direction
                            local dx = x1 - x0
                            local dy = y1 - y0
                            print( string.format("1 : normalized direction:  dx: %d dy: %d", dx, dy))
                            local scale = math.sqrt(dx * dx + dy * dy)
                            dx = dx / scale
                            dy = dy / scale
                            print( string.format("2: normalized direction:  dx: %d dy: %d", dx, dy))
                            
                            -- get the direction score
                            local score = x * dx + y * dy
                            print(string.format("movePlanet check the best score: %d, planet: %s ", score, tostring(planet) ))
                            -- update the best planet
                            if bestscore < score then
                                bestscore = score
                                this.planetNext = planet
                            end
                        end
                    end
                    print(string.format("movePlanet next planet: %s ", tostring(this.nextPlanet) ))
                end
            --end
    end

    ifs_freeform_fleet.Input_DPadUp = function(this, joystick)
        movePlanet(ifs_freeform_main,0,1)
    end

    ifs_freeform_fleet.Input_DPadDown = function(this, joystick)
        movePlanet(ifs_freeform_main,0,-1)
    end

    ifs_freeform_fleet.Input_DPadLeft = function(this, joystick)
        movePlanet(ifs_freeform_main,-1,0)
    end

    ifs_freeform_fleet.Input_DPadRight = function(this, joystick)
        movePlanet(ifs_freeform_main,1,0)
    end


    ifs_freeform_fleet.Input_GeneralUp = function(this, joystick)
        movePlanet(ifs_freeform_main,0,1)
    end

    ifs_freeform_fleet.Input_GeneralDown = function(this, joystick)
        movePlanet(ifs_freeform_main,0,-1)
    end

    ifs_freeform_fleet.Input_GeneralLeft = function(this, joystick)
        movePlanet(ifs_freeform_main,-1,0)
    end

    ifs_freeform_fleet.Input_GeneralRight = function(this, joystick)
        movePlanet(ifs_freeform_main,1,0)
    end
end -- if(movePlanet == nil)

print("End 000/addme.script")
