--
-- Created by [RDH]Zerted
-- August 10, 2008 - October 30th, 2008
--

__thisMapsCode__ = nil
__thisMapsMode__ = nil

--taking over AddUnitClass, so can figure out the map's unit classes
if AddUnitClass then
	--store the original function
	print("utility_functions2: Listening on AddUnitClass() calls")
	RetailAddUnitClass = AddUnitClass
	
	--make the new function
	AddUnitClass = function(...)
		local team = arg[1]
		local type1 = arg[2]
		local type2 = arg[3]
		local type3 = arg[4]
	
		--try to learn new classes, so the FakeConsole works on all untis in the map
		if type1 ~= nil and type1 ~= "" then
			uf_updateClassIndex( type1 )
		end
		
		--handles adding the hero from setup_teams?
		if team ~= nil and type1 == nil and type2 == nil and type3 == nil then
			print("utility_functions2: AddUnitClass(): Think found a hero added through SetupTeams.  Please tell [RDH]Zerted which map this is.  Thanks.")
			uf_updateClassIndex( team[1] )
		end
		
		--foward the call to the original function
		RetailAddUnitClass( unpack(arg) )
	end
else
	print("utility_functions2: WARNING: Cannot listen on AddUnitClass()")
end

--taking over SetHeroClass, so can figure out the map's unit classes
if SetHeroClass then
	--store the original function
	print("utility_functions2: Listening on SetHeroClass() calls")
	RetailSetHeroClass = SetHeroClass
	
	--make the new function
	SetHeroClass = function(...)
		local team = arg[1]
		local type1 = arg[2]
		
		--try to learn new classes, so the FakeConsole works on all untis in the map
		if type1 ~= nil and type1 ~= "" then
			uf_updateClassIndex( type1 )
		end
		
		--foward the call to the original function
		RetailSetHeroClass( unpack(arg) )
	end
else
	print("utility_functions2: WARNING: Cannot listen on SetHeroClass()")
end

--taking over ReadDataFile, so can figure out what map this is
if ReadDataFile then
	--store the original function
	print("utility_functions2: Listening on ReadDataFile() calls")
	RetailReadDataFile = ReadDataFile
	
	--make the new function
	ReadDataFile = function(...)
		--only care about the first 2 arguments
		local file = arg[1]	--we are hoping that this is the map's lvl file
		local layer = arg[2]	--we are hoping this is the game mode/layer configuration that is being loaded
		
		--if theres no file, then why even bother calling this function?
		if not file then
			--foward the call to the original function
			RetailReadDataFile( unpack(arg) )
			return
		end
		
		--if theres no layer, then this isn't the call we want
		if not layer then
			--foward the call to the original function
			RetailReadDataFile( unpack(arg) )
			return
		end
		
		--get the location of the \\
		local before, after = string.find( file, "\\" )
		if before == nil then
			--foward the call to the original function
			RetailReadDataFile( unpack(arg) )
			return
		elseif before-3 < 1 then
			--there are less then 3 characters before the \\
			--foward the call to the original function
			RetailReadDataFile( unpack(arg) )
			return
		end

		--get the 3 chars before the \\
		local folder = string.sub( file, before-3, before-1 ) or "[oops 1]"
		folder = string.lower(folder)
		--print("utility_functions2: ReadDataFile(): Folder: ", folder or "[Oops]")
		
		--get the 3 chars after the \\
		local lvlFile = string.sub( file, after+1, after+3 ) or "[oops 2]"
		lvlFile = string.lower(lvlFile)
		--print("utility_functions2: ReadDataFile(): lvlFile: ", lvlFile or "[Oops]")

		--if they match, then in the format: XXX\\XXX
		--thats enough for me to assume this is the correct call (it may not be, but I can't be exact)
		if folder == lvlFile then
			__thisMapsCode__ = string.lower(lvlFile)
			__thisMapsMode__ = string.lower(layer)
			print("utility_functions2: ReadDataFile(): This map's code, mode: ", __thisMapsCode__ or "[Oops]", __thisMapsMode__ or "[Oops]")
		end
		
		--always foward the call to the original function
		RetailReadDataFile( unpack(arg) )
	end
else
	print("utility_functions2: WARNING: Cannot listen on ReadDataFile()")
end

-------------
--variables--
-------------

--var to know that these functions have been read in
__utility_functions__ = 1

--
-- A listing of all the known units playable in SWBF2
--
uf_classes = {--[[
	--rebel units
	"all_inf_engineer",
	"all_inf_engineer_fleet",
	"all_inf_engineer_jungle",
	"all_inf_engineer_snow",
	"all_inf_fleet_soldier",
	"all_inf_marine",
	"all_inf_officer",
	"all_inf_officer_jungle",
	"all_inf_officer_snow",
	"all_inf_pilot",
	"all_inf_rifleman",
	"all_inf_rifleman_desert",
	"all_inf_rifleman_fleet",
	"all_inf_rifleman_jungle",
	"all_inf_rifleman_snow",
	"all_inf_rifleman_urban",
	"all_inf_rocketeer",
	"all_inf_rocketeer_fleet",
	"all_inf_rocketeer_jungle",
	"all_inf_rocketeer_snow",
	"all_inf_sniper",
	"all_inf_sniper_fleet",
	"all_inf_sniper_jungle",
	"all_inf_sniper_snow",
	"all_inf_wookiee",
	"all_inf_wookiee_snow",

	--cis units
	"cis_inf_droideka",
	"cis_inf_engineer",
	"cis_inf_marine",
	"cis_inf_officer",
	"cis_inf_officer_hunt",
	"cis_inf_pilot",
	"cis_inf_rifleman",
	"cis_inf_rocketeer",
	"cis_inf_sniper",

	--imperial units
	"imp_inf_dark_trooper",
	"imp_inf_dark_trooper_hunt",
	"imp_inf_darthvader",
	"imp_inf_engineer",
	"imp_inf_engineer_snow",
	"imp_inf_marine",
	"imp_inf_officer",
	"imp_inf_officer_gray",
	"imp_inf_officer_hunt",
	"imp_inf_officer_snow",
	"imp_inf_pilot",
	"imp_inf_pilot_atat",
	"imp_inf_pilot_atst",
	"imp_inf_pilot_tie",
	"imp_inf_rifleman",
	"imp_inf_rifleman_desert",
	"imp_inf_rifleman_snow",
	"imp_inf_rocketeer",
	"imp_inf_rocketeer_snow",
	"imp_inf_sniper",
	"imp_inf_sniper_snow",

	--republic units
	"rep_inf_ep2_engineer",
	"rep_inf_ep2_jettrooper",
	"rep_inf_ep2_jettrooper_rifleman",
	"rep_inf_ep2_jettrooper_sniper",
	"rep_inf_ep2_jettrooper_training",
	"rep_inf_ep2_marine",
	"rep_inf_ep2_officer",
	"rep_inf_ep2_officer_training",
	"rep_inf_ep2_pilot",
	"rep_inf_ep2_rifleman",
	"rep_inf_ep2_rocketeer",
	"rep_inf_ep2_rocketeer_chaingun",
	"rep_inf_ep2_sniper",
	"rep_inf_ep3_engineer",
	"rep_inf_ep3_jettrooper",
	"rep_inf_ep3_marine",
	"rep_inf_ep3_officer",
	"rep_inf_ep3_pilot",
	"rep_inf_ep3_rifleman",
	"rep_inf_ep3_rifleman_space",
	"rep_inf_ep3_rocketeer",
	"rep_inf_ep3_sniper",
	"rep_inf_ep3_sniper_felucia",
	"rep_inf_ep3_space_pilot",

	--Jedi
	"rep_hero_obiwan",
	"rep_hero_anakin",
	"rep_hero_cloakedanakin",
	"rep_hero_macewindu",
	"rep_hero_yoda",
	"rep_hero_aalya",
	"rep_hero_kiyadimundi",

	"cis_hero_countdooku",
	"cis_hero_darthmaul",
	"cis_hero_grievous",
	"cis_hero_jangofett",

	"all_hero_luke_jedi",
	"all_hero_luke_pilot",
	"all_hero_luke_storm",
	"all_hero_hansolo_storm",
	"all_hero_hansolo_tat",
	"all_hero_leia",
	"all_hero_chewbacca",

	"imp_hero_emperor",
	"imp_hero_darthvader",
	"imp_hero_bobafett",

	--Hunt, Campaign, and Other units
	"tat_inf_jawa",
	"tat_inf_tuskenhunter",
	"tat_inf_tuskenraider",

	"ewk_inf_scout",
	"ewk_inf_repair",
	"ewk_inf_trooper",

	"gam_inf_gamorreanguard",

	"gar_inf_defender",
	"gar_inf_naboo_queen",
	"gar_inf_soldier",
	"gar_inf_temple_soldier",
	"gar_inf_temple_vanguard",
	"gar_inf_vanguard",

	"gen_inf_geonosian",
	"geo_inf_acklay",
	"geo_inf_agro_geonosian",

	"gun_inf_soldier",
	"gun_inf_rider",
	"gun_inf_defender",

	"jed_knight_01",
	"jed_knight_02",
	"jed_knight_03",
	"jed_knight_04",
	"jed_master_01",
	"jed_master_02",
	"jed_master_03",
	"jed_runner",
	"jed_sith_01",

	"snw_inf_wampa",

	"wok_inf_mechanic",
	"wok_inf_rocketeer",
	"wok_inf_warrior",
--]]}

function if_removeUnknownClasses()
	--TODO
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--functions
-----------

--
---- Description ----
-- Calls the given function with a table argument of the ingame players
--
---- Parameters ----
-- A function to handle the table of ingame players
--
-- The format of the table is as follows:
-- table = {
--  { indexstr = "1", namestr = "Alpha"},
--  { indexstr = "2", namestr = "Bravo"},
--  { indexstr = "3", namestr = "Player 1"},
--  { indexstr = "4", namestr = "LastJoinedPlayer"},
-- }
--
---- Returns ----
-- (nothing)
--
function uf_processPlayers( fun )
	--does nothing if given nothing
	if not fun then return end
	
	--if the ifs_mp_lobby hasn't been loaded, then can't do anything yet
	if ifs_mp_lobby == nil then
		print("utility_functions2: uf_processPlayers(): ifs_mp_lobby has yet to be loaded.  Please try again later")
		return
	end

	--store the function so the mp_lobby knows what to do
	__TempProcessPlayersFunction__ = fun
	
	--attempt to go into the player list screen
	--Note: the screen will automatically handle everything else since it sees __TempProcessPlayersFunction__ is not nil
	ScriptCB_PushScreen(ifs_mp_lobby.ScreenName)
end

--
---- Description ----
-- Adds the given class to the table of known classes (uf_classes) if the given class it not already known
--
---- Parameters ----
-- class - The class to add to the know classes
--
function uf_updateClassIndex( class )
	if class == nil or class == "" then return end
	
	--no need to add the given class if its already included
	if uf_isKnownClass( class ) ~= false then
		print("uf_updateClassIndex(): Already know class:", class or "[nil]")
		return
	end
	
	--table add the given class to the table of known classes
	table.insert( uf_classes, class)
	print("uf_updateClassIndex(): Added class:", class or "[nil]")
end

--
---- Description ----
-- Searches for the given class in the uf_classes table and returns its index if found
--
---- Parameters ----
-- class - The class to search for in the uf_classes table
--
---- Returns ----
-- The index of the given class in the uf_classes table, else false if the given class isn't in the table
--
function uf_isKnownClass( class )
	if class == nil or class == "" then return end
	
	--for each given class
	local cIndex
	for cIndex = 1, table.getn(uf_classes) do
	
		--if we found the given class in the table of known classes, return the class' table index
		if uf_classes[cIndex] == class then
			return cIndex
		end
    end--end class loop
    
    return false
end

--[[
--
----Note
-- This method is not called
-- This method has yet to be tested
-- This method is no longer needed since we started listening toAddUnitClass and SetHeroClass
--
---- Description ----
-- 
--
---- Parameters ----
-- (none)
--
---- Returns ----
-- (nothing)
--
function uf_removeUnknownClasses()
	local known_classes = {}

	--for each given class
	local cIndex
	for cIndex = 1, table.getn(uf_classes) do
	
		--if the game knows the class, then store it
		if FindEntityClass(class[cIndex]) ~= FindEntityClass("Zerted hopes no one names a class like this") then
			table.insert( known_classes, uf_classes[cIndex] )
		end

    end--end class loop
    
    --overwrite the old class list with the known class list
    print("uf_removeUnknownClasses(): old list, new list: ", table.getn(uf_classes), table.getn(known_classes))
    uf_classes = known_classes
end
--]]

--
---- Description ----
-- Given a table of classes, change their property values for the given properties
--
---- Parameters ----
-- class    - a table of classes whose properties will be changed
-- property - a table of name/value pairs of properties to be changed
--
---- Returns ----
-- (nothing)
--
---- Example usage ----
--		--make the standard g era engineers jump high and have a high endurance regen
--		local classes = { "all_inf_engineer", "imp_inf_engineer", }
--		local properties = { {name = "JumpHeight", value = "15"}, {name = "EnergyRestore", value = "10"}, }
--		uf_changeClassProperties( classes, properties )
--
function uf_changeClassProperties( class, property )

	--for each given class
	local cIndex
	for cIndex = 1, table.getn(class) do
	    --print( "uf_changeClassProperties(): Class Index, Name:", cIndex, class[cIndex] )

	    --for each given property
	    local pIndex
	    for pIndex = 1, table.getn(property) do
		    --print( "uf_changeClassProperties(): Property Index, Name, Value:", pIndex, property[pIndex].name, property[pIndex].value )

	        --change it if the class really exists
	        if FindEntityClass(class[cIndex]) ~= FindEntityClass("Zerted hopes no one names a class like this") then
		        SetClassProperty( class[cIndex], property[pIndex].name, property[pIndex].value )
	        end--end FindEntityClass
		end--end property loop
    end--end class loop
end--end uf_ChangeClassProperties()

--
---- Description ----
-- Applies the given function to all the units of the given teams
--
---- Parameters ----
--cont      - the continuation function to call.  Should take 3 parameters: unit, property, value
--property  - value to be passed on to the given cont function
--value     - value to be passed on to the given cont function
--teams     - a table of numbers which represent team numbers 
--aiOrHuman - "ai" to only process AI bots, "human" to only process human players, nil to process both bots and humans
--
---- Returns ----
-- (nothing)
--
function uf_applyFunctionOnTeamUnits( cont, property, value, teams, aiOrHuman )
	if cont == nil then return end	--if have nothing to do, then do nothing

	--the teams whos units will have the given function applied to them
	local teams = teams or {1, 2}

	--for each team,
	local team
	for team = 1, table.getn(teams) do

		--get the team's size
	    local size = GetTeamSize( teams[team] )

	    --for each team member,
	    local m
	    for m = 0, size-1 do

	        --get a team member's unit
	        local player = GetTeamMember(teams[team], m)
	        local type = IsCharacterHuman(player)
			if (type and (aiOrHuman == "ai")) or ((not type) and (aiOrHuman == "human")) then
				--player is not the correct type
			else
				local unit = GetCharacterUnit(player)
				print( "uf_applyFunctionOnTeamUnits(): Team, Unit:", team, m ) 
	            cont(player, unit, property, value)
			end

		end
	end
end

--
---- Description --
-- Changes the given property to the given value for all units
-- Does so on all units from teams 1 and 2
--
---- Parameters ----
-- property  - The name of the property to change
-- value     - The new value of the given property
-- aiOrHuman - "ai" to only apply property to bots, "human" to only apply property to humans, nil to apply property to all units
--
---- Returns ----
-- (nothing)
--
function uf_changeObjectProperty( property, value, aiOrHuman )
	--changes the given property on the given unit to the given value
	local miniFun = function( player, unit, property, value )
		if (unit == nil) or (property == nil) or (value == nil) then return end	--can't can't handle nils
		SetProperty( unit, property, value )
	end

	uf_applyFunctionOnTeamUnits( miniFun, property, value, {1,2}, aiOrHuman )
end



--------------------------------------------------------------------------------

--
---- Description ----
-- Returns the 'oppsite' of the given team
--
---- Parameters ----
-- team - The team of who's oppsite team will be returned
--
---- Returns ----
-- The team number of the team oppsite the given team
--
function uf_GetOtherTeam( team )
	if team == 1 then
	    team = 2
	elseif team == 2 then
	    team = 1
	else
		team = team or "[team was nil]"
		print("utility_functions: uf_GetOtherTeam(): Unknown team: ", team)
		return nil	--the character is not on a normal team
	end
	
	return team
end

--
---- Description ----
-- Changes spawned units from the given teams to the given team.
--
---- Parameters ----
-- teams - a table of teams to 'move' to the give team
-- team  - the team the given teams will be 'moved' to
--
---- Returns ----
-- (nothing)
--
function uf_moveToTeam( teams, team )
    --check input
    if not teams then return end
    if not team then return end

	--
	local miniFun = function( player, unit, property, value, teams )
		if (unit == nil) or (value == nil) then return end	--SetProperty can't handle nils
		--change the unit's team
		SetProperty(unit, "Team", value)
		SetProperty(unit, "PerceivedTeam", value )
	end

	uf_applyFunctionOnTeamUnits( miniFun, nil, team, teams )
end--end of uf_moveToTeams()

--
---- Description ----
--  Kills the units on the given teams
--
---- Parameters ----
-- teams - a table of teams whose units should be killed
-- ai    - true to kill only AI units, false to kill only human units
--
---- Returns ----
-- (nothing)
--
function uf_killUnits( teams, ai )
	--check input
	if teams == nil then return end
	if ai == nil then return end

	--
	local miniFun = function( player, unit, property, ai, teams )
		if (player == nil) or (unit == nil) or (ai == nil) then return end	--check input

		--determine the player type (ai or human)
		--local isAi = true
		--if IsCharacterHuman(player) then
		--	isAi = false
		--end
		local isAi = not IsCharacterHuman(player)

		--if is the correct type, kill it
		if (isAi == ai) then
			KillObject( unit )
		end
	end

	uf_applyFunctionOnTeamUnits( miniFun, nil, ai, teams )
end

--
---- Description ----
-- Adds the given string to the beginning of the server's name
--
---- Parameters ----
-- The string to which the server's name will be appended
--
---- Returns ----
-- (nothing)
--
function uf_addToServerName( add )
	if (add == nil) then return end

	local name = add .. ScriptCB_GetGameName()
	ScriptCB_SetGameName( name )
end

--
---- Description ----
-- Removes all instances of the given string from the server's name
--
---- Parameters ----
-- The string to remove from the server's name
--
---- Returns ----
-- (nothing)
--
function uf_removeFromServerName( remove )
	if (remove == nil) then return end	--check input

	local name = ScriptCB_GetGameName()
	name = string.gsub(name, remove, "")
	ScriptCB_SetGameName( name )
end

--------------------------------------------------------------------------------

--
---- Description ----
-- Attempts to display the contents of the given table
-- WARNING: tables with nested tables pointing back at themselves or a parent table will cause this function to enter a recursive, infinite loop
--
---- Parameters ----
-- data   - the table to display
-- nested - true if should attempt to display any nested tables (tables inside of tables etc...)
-- depth  - the current nested level
--
---- Returns ----
-- (nothing)
--
function uf_print( data, nested, depth )
	if (not data) then return end	--must have something to print
	if (not type) then return end	--must have something to print
	if depth == 0 then
		print(depth..": uf_print(): Starting: ", data, type, nested, depth)
	end

	--for each pair in the given table, 
	for key,value in pairs(data) do

		--check for nils
		if key == nil and value == nil then
			print(depth..": uf_print(): Both the key and value are nil")
		elseif key == nil then
			print(depth..": uf_print(): Nil key, but value is:", value)
		elseif value == nil then
			print(depth..": uf_print(): Nil value, but key is:", key)
		else
			--have no nils (but a continue keyword would have been nice...)
			
			--display the key, value pair if possible
			if key ~= "mapluafile" then
				--normal display
				print(depth..": Key, Value: ", key, value)
			else
				--have to format map lua file values to prevent crash when outputting the value
				local map = string.format(value, "<A>", "<B>")
				print(depth..": Key, Formated Value: ", key, map)
			end
	
			--if nested, search deeper, but don't recurse into the global table or our starting table
			if nested and key ~= "_G" and key ~= data then
			
				--the developers didn't include type(), so have to use this hack to determine if the value represents a table
				local result = pcall(function(array)
					table.getn(array)
				end, value)
				
				--can only process tables
				if result then
					uf_print(value, nested, depth+1)
				end
			end
		end
	end
	
	if depth == 0 then
		print(depth..": uf_print(): Finished: ", data, nested, depth)
	else
		print()
	end
end

