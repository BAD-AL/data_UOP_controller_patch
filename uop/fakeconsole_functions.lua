--
-- Created by [RDH]Zerted
-- August 10, 2008
--
-- These functions are mainly designed to be used by the FakeConsole commands
--

-------------------------------------------------------------------------------
--var to know that these functions have been read in
__fakeconsole_functions__ = 1

--vars for toggled commands
--1 means command is on
ff_autoBalance = 0
ff_blindJumps = 0
ff_heroSPRules = 0
ff_heroSPScript = 0
ff_chooseSides = 0
ff_menuSounds = 1
ff_displayTeamPoints = 0
ff_aiSpawn1 = 1
ff_aiSpawn2 = 1
ff_cpCapture = 1
ff_lockVehicles = 0
ff_tumbleRecovery = 0
ff_immuneToMines = 0
ff_fleeLikeHeros = 0
ff_hangerWalkthrough = 0
ff_hangerShootThrough = 0
ff_addedJetPacks = 0
ff_awardEffectsOn = 1
ff_forceViewOn = 0
ff_removedPointLimits = 0
ff_allowVictory = 1

--vars added to a server's name when using certain commands
local FF_ServerName = "v1.3: "
local FF_Crashes_ServerName = "Crashes: "

--function vars
OldMissionVictory = nil

-------------------------------------------------------------------------------

--
---- Description ----
-- Adds a command to the FakeConsole table
-- Note: You cannot just call this function anytime to add a command, it must
--			be called while the list is being populated for display
--
---- Parameters ----
-- show        - String to display in the command list
-- description - A description of the command.  Will be generated off of 'show' if value is nil
-- command     - Function to run when this command is clicked
-- now         - Function which describes if this command should be added to the list.  Returns a true value if should be added to the list
--
---- Returns ----
-- (nothing)
--
function ff_AddCommand( show, description, command, now )
	--check input
	if show == nil then
		print("fakeconsole_functions: AddCommand: Show is nil")
		return
	elseif description == nil then
		--removes all spaces from the show string and prevent 'empty' names
		local name = string.gsub(show, " ", "")
		if name == "" then
			name = "blank"
		end
		
		description = "mods.fakeconsole.description." .. name
	end

	--check to see if command is valid at this current time
	if now ~= nil then
		if not now() then
			print("fakeconsole_functions: AddCommand: Not adding command: ", show)
			return	--don't add this command to the list
		end
	end

	--add the given command into FakeConsole's table of commands
	table.insert( gConsoleCmdList, {ShowStr=show, info=description, run=command,} )
end

--
---- Description ----
-- Attempts to run the given FakeConsole command
--
---- Parameters ----
-- name - The name of the FakeConsole to run
--
---- Returns ----
-- (nothing)
--
function ff_DoCommand( name )
	--check input
	if name == nil then return end
	if gConsoleCmdList == nil then ff_rebuildFakeConsoleList() end	--build the list
	if gConsoleCmdList == nil then return end	--list build failed, no commands to run, so nothing we can do...

	--find the given name in the table
	local i
	for i=1,table.getn(gConsoleCmdList) do
	
		--find the command to run
		if gConsoleCmdList[i].ShowStr == name then
			
			--make sure the command is runnable
			if gConsoleCmdList[i].run == nil then
				print("ff_DoCommand(): The FakeConsole command has no function to run:", name or "[Nil]")
				return
			end

			--let people know that this server may not act normal
			--	it is important to know if someone may be cheating in a MP game
			ff_serverDidFCCmd()

			--execute the custom FC command
			gConsoleCmdList[i].run()
			return
		end
	end

	print("ff_DoCommand(): Unable to find FakeConsole command:", name or "[Nil]")
end

--
---- Description ----
-- Prompts the user for a value
-- Note: This is only designed to be used from the ifs_fakeconsole screen
--			Need to change the SetVis() inorder to use this else where
--
---- Parameters ----
-- title  - The text to display to the user
-- follow - The function to call with the result of the prompt
-- this   - The current screen (should be ifs_fakeconsole)
--
---- Returns ----
-- (nothing, calls the follow function)
--
function ff_AskUser( title, follow, this )
	--set the continuation function
	Popup_Prompt.fnDone = function( value )
		--close the popup
		IFObj_fnSetVis(this.listbox,1)
		Popup_Prompt:fnActivate(nil)
		Popup_Prompt.fnDone = nil
				
		--follow through to the modder's continuation function
		if follow then
			follow( value )
		end
	end
	
	--hide the FC list
	IFObj_fnSetVis(this.listbox,nil)
	
	--activate the popup
	Popup_Prompt:fnActivate(1)
	
	--set the popup's text
	gPopup_fnSetTitleStr(Popup_Prompt, title or "[No Title]")
end

--
---- Description ----
-- Changes the AI damage threshold to the given value for all alive units on teams 1 and 2
--
---- Parameters ----
-- value - the new AI damage threshold.  0.4 means the AI can take at most 40% of a unit's max health
--
---- Returns ----
-- (nothing)
--
function ff_changeAIDamageThreshold( value )
	--check input
	if value == nil then return end
	local teams = {1, 2}

	--
	local miniFun = function( player, unit, property, value, teams )
		if (unit == nil) or (value == nil) then return end	--check input

		SetAIDamageThreshold(unit, value)
	end

	uf_applyFunctionOnTeamUnits( miniFun, nil, value, teams )
end

--
---- Description ----
-- Adds unlimited jet packs to all unit classes
--
---- Parameters ----
-- (none)
--
---- Returns ----
-- (nothing)
--
function ff_CommandAddJetPacks()
	--adds a jet pack to all units
	ff_addedJetPacks = 1

	local properties = {
		--ControlSpeed = "jet 1.85 1.85 2.00"
		{ name = "ControlSpeed", value = "jet 10.85 1.85 2.00"},
		{ name = "JetJump", 		value = "8.0" },
		{ name = "JetPush", 		value = "8.0" },
		{ name = "JetAcceleration", value = "20.0" },
		{ name = "JetEffect", 		value = "" },
		{ name = "JetType", 		value = "hover" },
		{ name = "JetFuelRechangeRate", value = "1" },
		{ name = "JetFuelCost", 	value = "0.0" },
		{ name = "JetFuelInitialCost", value = "0.0" },
		{ name = "JetFuelMinBorder", value = "0.0" },
	}
	uf_changeClassProperties( uf_classes, properties )
end

--
---- Description ----
-- Greatly increases all unit classes' strafting and backwards jump distances
--
---- Parameters ----
-- (none)
--
---- Returns ----
-- (nothing)
--
function ff_CommandSuperJump()
	--causes units to jump far backwards and to the sides
	local properties = {
	    { name = "JumpFowardSpeedFactor", value = "8" },
	    { name = "JumpStrafeSpeedFactor", value = "7" },
	}
	uf_changeClassProperties( uf_classes, properties )
end

--
---- Description ----
-- Removes the graphical and sound effects you get from power ups/buffs (except the posion buff)
--
---- Parameters ----
-- (none)
--
---- Returns ----
-- (nothing)
--
function ff_CommandRemoveAwardEffects()
	--removes the buff graphical effects by blanking them out
	ff_awardEffectsOn = 0

	local properties = {
	    { name = "BuffHealthEffect",  value = "" },
	    { name = "BuffOffenseEffect", value = "" },
	    { name = "BuffDefenseEffect", value = "" },
	}
	uf_changeClassProperties( uf_classes, properties )
end

--
---- Description ----
-- Greatly increases/decreases the amount of points earned/lost for unit activities
--
---- Parameters ----
-- (none)
--
---- Returns ----
-- (nothing)
--
function ff_CommandExtremePoints()
	--make it easier to get points (usefull to reach locked units)
	local Player_Stats_Points = {
		{ point_gain =   5  },			--//	PS_GLB_KILL_AI_PLAYER = 0,
		{ point_gain =   5  },			--//	PS_GLB_KILL_HUMAN_PLAYER,
		{ point_gain =   5  },			--//	PS_GLB_KILL_HUMAN_PLAYER_AI_OFF,
		{ point_gain =   0  },			--//	PS_GLB_KILL_SUICIDE,
		{ point_gain =  -10  },			--//	PS_GLB_KILL_TEAMMATE,
		{ point_gain =   30  },			--//	PS_GLB_VEHICLE_KILL_INFANTRY_VS_VEHICLE,
		{ point_gain =   20  },			--//	PS_GLB_VEHICLE_KILL_LIGHT_VS_HEAVY,
		{ point_gain =   10  },			--//	PS_GLB_VEHICLE_KILL_LIGHT_VS_MEDIUM,
		{ point_gain =   10  },			--//	PS_GLB_VEHICLE_KILL_HEAVY_VS_LIGHT,
		{ point_gain =   10  },			--//	PS_GLB_VEHICLE_KILL_HEAVY_VS_MEDIUM,
		{ point_gain =   10  },			--//	PS_GLB_VEHICLE_KILL_MEDIUM_VS_LIGHT,
		{ point_gain =   10  },			--//	PS_GLB_VEHICLE_KILL_MEDIUM_VS_HEAVY,
		{ point_gain =   95  },			--//	PS_GLB_VEHICLE_KILL_ATAT,
		{ point_gain =  -95  },			--//	PS_GLB_VEHICLE_KILL_EMPTY,
		{ point_gain =   80  },			--//	PS_GLB_HEAL,
		{ point_gain =   80  },			--//	PS_GLB_REPAIR,
		{ point_gain =   50  },			--//	PS_GLB_SNIPER_ACCURACY,
		{ point_gain =  -40  },			--//	PS_GLB_HEAVY_WEAPON_MULTI_KILL,
		{ point_gain =   50  },			--//	PS_GLB_RAMPAGE,
		{ point_gain =   30  },			--//	PS_GLB_HEAD_SHOT,
		{ point_gain =   50  },			--//	PS_GLB_KILL_HERO,
		{ point_gain =   50  },			--//	PS_CON_CAPTURE_CP,
		{ point_gain =   20  },			--//	PS_CON_ASSIST_CAPTURE_CP,
		{ point_gain =   20  },			--//	PS_CON_KILL_ENEMY_CAPTURING_CP,
		{ point_gain =   20  },			--//	PS_CON_DEFEND_CP,
		{ point_gain =   10  },			--//	PS_CON_KING_HILL,
		{ point_gain =   10  },			--//	PS_CAP_PICKUP_FLAG,
		{ point_gain =   20  },			--//	PS_CAP_DEFEND_FLAG,
		{ point_gain =   50  },			--//	PS_CAP_CAPTURE_FLAG,
		{ point_gain =   30  },			--//	PS_CAP_DEFEND_FLAG_CARRIER,
		{ point_gain =   30  },			--//	PS_CAP_KILL_ENEMY_FLAG_CARRIER,
		{ point_gain =  -95  },			--//	PS_CAP_KILL_ALLY_FLAG_CARRIER,
										--//	// assault
		{ point_gain =   95  },			--//	PS_ASS_DESTROY_ASSAULT_OBJ,
										--//	// escort
		{ point_gain =   25  },			--//	PS_ESC_DEFEND,
										--//	// defend
		{ point_gain =   25  },			--//	PS_DEF_DEFEND,
	}
	
	--save the new points
	ScriptCB_SetPlayerStatsPoints( Player_Stats_Points )
end

--
---- Description ----
-- Sets the max map height to 2000
--
---- Parameters ----
-- (none)
--
---- Returns ----
-- (nothing)
--
function ff_CommandSuperHighFlying()
    --attempts to set the max flying height really high
    SetMaxFlyHeight(2000)
    SetMaxPlayerFlyHeight(2000)
end

--
---- Description ----
-- Greatly increases the endurance regen for all unit classes
--
---- Parameters ----
-- (none)
--
---- Returns ----
-- (nothing)
--
function ff_CommandCrazyEnduranceRegen()
	--sets a high energy regen
	local properties = {
	    { name = "EnergyRestore", 	value = "1986" },
	    { name = "EnergyRestoreIdle", value = "1986" },
	}
	uf_changeClassProperties( uf_classes, properties )
end

--
---- Description ----
-- Gives all alive units a slow health regen
--
---- Parameters ----
-- (none)
--
---- Returns ----
-- (nothing)
--
function ff_CommandSlowHealthRegen()
	--sets a slow health regen rate
	ff_healthRegen( 20 )
end

--
---- Description ----
-- Prevents all unit classes from capturing CPs
--
---- Parameters ----
-- (none)
--
---- Returns ----
-- (nothing)
--
function ff_CommandDenyCPCapture()
	--prevents all unit classes from capturing CPs
	ff_cpCapture = 0

	local properties = {
	    { name = "CapturePosts", value = "0" },
	}
	uf_changeClassProperties( uf_classes, properties )
end

--
---- Description ----
-- Sets the reinforcement counts of teams 1 and 2 to unlimited (-1)
--
---- Parameters ----
-- (none)
--
---- Returns ----
-- (nothing)
--
function ff_CommandUnlimitedReinforcements()
	--set team 1's and 2's reinforcement count to unlimited
	SetReinforcementCount(1,-1)
	SetReinforcementCount(2,-1)
end

--
---- Description ----
-- Sets the team points for both teams 1 and 2 to an extremely low number
--	(to simulate the ability to earn an unlimited amount of team points)
--
---- Parameters ----
-- (none)
--
---- Returns ----
-- (nothing)
--
function ff_CommandUnlimitedTeamPoints()
    --sets the team points to an extremely low value
	SetTeamPoints(1, -1234567890)
	SetTeamPoints(2, -1234567890)
end

--
---- Description ----
-- Prevents currently alive units from taking any AI damage
--
---- Parameters ----
-- (none)
--
---- Returns ----
-- (nothing)
--
function ff_CommandNoAIUnitDamage()
    --prevents units from taking AI damage when unit's health is at or below 100%
    ff_changeAIDamageThreshold( 1 )
end

--
---- Description ----
-- Sets the unit's health regen to the given value
-- Does so on all units from teams 1 and 2
--
--
---- Parameters ----
-- rate     - the new health regen value
-- aiOrHuman - "ai" to only apply health to bots, "human" to only apply health to humans, nil to apply health to all units
--
---- Returns ----
-- (nothing)
--
function ff_healthRegen( rate, aiOrHuman )
	uf_changeObjectProperty( "AddHealth", rate, aiOrHuman )
end

--
---- Description ----
-- Removes the 'crashes' marker from the server's name
--
---- Parameters ----
-- (none)
--
---- Returns ----
-- (nothing)
--
function ff_serverDoesNotCrash()
	uf_removeFromServerName( FF_Crashes_ServerName )
end

--
---- Description ----
-- Adds a 'crashes' marker to the server's name
--
---- Parameters ----
-- (none)
--
---- Returns ----
-- (nothing)
--
function ff_serverDoesCrash()
	--make sure its only added once
	ff_serverDoesNotCrash()
	uf_addToServerName( FF_Crashes_ServerName )
end

--
---- Description ----
-- Removes the 'FakeConsole marker' from the server's name
--
---- Parameters ----
-- (none)
--
---- Returns ----
-- (nothing)
--
function ff_serverClearFCCmd()
	uf_removeFromServerName( FF_ServerName )
end


--
---- Description ----
-- Adds the 'FakeConsole marker' from the server's name
--
---- Parameters ----
-- (none)
--
---- Returns ----
-- (nothing)
--
function ff_serverDidFCCmd()
	--make sure its only added once
	ff_serverClearFCCmd()
	uf_addToServerName( FF_ServerName )
end

--
---- Description ----
-- Converts the FakeConsole selection into its localized index string
--
---- Parameters ----
-- The name of the FakeConsole command to convert
--
---- Returns ----
-- A the localization key for the given command's name
--
function ff_localizeCommand( command )	if command == nil then return "error" end	--check input

	local name = string.gsub(command, " ", "")
	if name == "" then
		name = "blank"
	end
	
	return "mods.fakeconsole." .. name
end

--
---- Description ----
-- Prevents calls to the real MissionVictory(), thus preventing a map from ending
--
---- Parameters ----
-- (none)
--
---- Returns ----
-- (nothing)
--
function ff_CommandPreventVictory()
	--check state
	if not MissionVictory then print("ff_CommandPreventVictory(): WARNING: Could not find MissionVictory()") return end
	
	--update the FakeConsole enable/disable var
	ff_allowVictory = 0
	
	--store the old function
	OldMissionVictory = MissionVictory
	OldMissionDefeat = MissionDefeat
	
	--create the new function
	MissionVictory = function( teams )
		print("ff_CommandPreventVictory(): Captured a MissinVictory() call")
	end	
	MissionDefeat = function( teams )
		print("ff_CommandPreventVictory(): Captured a MissionDefeat() call")
	end	
end

--
---- Description ----
-- Allows calls to the real MissionVictory(), thus allowing a map to end
--
---- Parameters ----
-- (none)
--
---- Returns ----
-- (nothing)
--
function ff_CommandAllowVictory()
	--check state
	if not OldMissionVictory then print("ff_CommandAllowVictory(): WARNING: Could not find OldMissionVictory()") return end
	
	--restore the old/real function
	MissionVictory = OldMissionVictory
	MissionDefeat = OldMissionDefeat
	OldMissionVictory = nil
	OldMissionDefeat = nil
	
	--update the FakeConsole enable/disable var
	ff_allowVictory = 1
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--
---- Description ----
-- Builds the main FakeConsole table
--
---- Parameters ----
-- (none)
--
---- Returns ----
-- (nothing)
-- The FakeConsole table is gConsoleCmdList
--
function ff_rebuildFakeConsoleList()
		gConsoleCmdList = {}

		ScriptCB_GetConsoleCmds() -- puts contents in gConsoleCmdList
		table.insert( gConsoleCmdList, {ShowStr=""} )	--seperate the real commands from the other ones
		
		--by [RDH]Zerted, support custom FC commands from modders
		if SupportsCustomFCCommands and AddFCCommands ~= nil then
			print("ff_rebuildFakeConsoleList(): Adding in modder's custom commands...")
			ff_AddCommand( "[Custom Map Commands]", nil, nil, nil)
			
			AddFCCommands()

			ff_AddCommand( "", nil, nil, nil)
			print("ff_rebuildFakeConsoleList(): Finished adding in modder's custom commands.")
		end
		
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
		--Commands which will not be included:
		--table.insert( gConsoleCmdList, {ShowStr="Down Jump"} )				--fails, freezes the game
		--table.insert( gConsoleCmdList, {ShowStr="Show All Units in MiniMap"} )--taken out to prevent hacking, doesn't work yet anyway
		--table.insert( gConsoleCmdList, {ShowStr="Deny Flag Pickup"} )			--not possible, don't know flag spawn points
		--table.insert( gConsoleCmdList, {ShowStr="Allow Flag Pickup"} )		--not possible, don't know flag spawn points
		--table.insert( gConsoleCmdList, {ShowStr="Allow Own Flag Pickup"} )	--not possible, don't know flag spawn points
		--table.insert( gConsoleCmdList, {ShowStr="Deny Own Flag Pickup"} )		--not possible, don't know flag spawn points

		--Change to toggles:
        --toggle -> ""/""
        
        --TODO add crashing to server name when do a crashing command
        --TODO determine if can remove the shields in DeathStar
        --TODO get hanger shield blocking/firing working again
        --TODO add the cheatBox to MP map selection screen to add additional maps
        --TODO add the cheatBox to MP map selection screen to set [RDH]Zerted's default map settings
        --TODO add support for custom mod map commands
        --TODO add support for commands based on the current map ID
        --TODO extract changes to another file so ifs_fakeconsole.lua can be modded by others

		--TODO make sure any hacking buttons, like Booting, are hidden/disabled
		
		--not sure if these commands crash in MP
		--table.insert( gConsoleCmdList, {ShowStr="[Test Working]"} )
		--table.insert( gConsoleCmdList, {ShowStr="AI Spawning - Stream"} )		--test, undetectable results
		--table.insert( gConsoleCmdList, {ShowStr="AI Spawning - 15 sec"} )		--test, undetectable results
		--table.insert( gConsoleCmdList, {ShowStr="AI Spawning - Instant"} )	--test, undetectable results
		--table.insert( gConsoleCmdList, {ShowStr="Far Collision"} )			--test, undetectable results
		--table.insert( gConsoleCmdList, {ShowStr="Average Collision"} )		--test, undetectable results
		--table.insert( gConsoleCmdList, {ShowStr="Near Collision"} )			--test, undetectable results
		--table.insert( gConsoleCmdList, {ShowStr="Historical Rules"} )			--test in MP, undetectable results
		--table.insert( gConsoleCmdList, {ShowStr="Historical Rules On"} )		--test in MP, undetectable results
		--table.insert( gConsoleCmdList, {ShowStr="Historical Rules Off"} )		--test in MP, undetectable results
		--table.insert( gConsoleCmdList, {ShowStr="Ground Flyer Map On"} )		--test, unknown result
		--table.insert( gConsoleCmdList, {ShowStr="Ground Flyer Map Off"} )		--test, unknown result
		--table.insert( gConsoleCmdList, {ShowStr="MoveCameraToEntity 2"} )		--test, unknown result
		--table.insert( gConsoleCmdList, {ShowStr="Spectator Mode"} )			--test, unknown result
		--table.insert( gConsoleCmdList, {ShowStr="Spectator Mode 1"} )			--test, unknown result
		--table.insert( gConsoleCmdList, {ShowStr="Disable Players"} )			--didn't work
		--table.insert( gConsoleCmdList, {ShowStr="Hide Health Bars"} )			--didn't work
		--table.insert( gConsoleCmdList, {ShowStr="Make Available For All"} )	--doesn't really make sense in the context of player units
		--table.insert( gConsoleCmdList, {ShowStr="Leave On Map When Dead"} )	--won't work as the object itself gets removed, so the map marker gets removed too?
		--table.insert( gConsoleCmdList, {ShowStr="Land Anywhere"} )			--failed, these are not the correct region names for the retail space maps?
		--table.insert( gConsoleCmdList, {ShowStr="Large AI Vehicle Notice Area"} )	--test, undetectable results
		--table.insert( gConsoleCmdList, {ShowStr="Usual AI Vehicle Notice Area"} )	--test, undetectable results
		--table.insert( gConsoleCmdList, {ShowStr="Small AI Vehicle Notice Area"} )	--test, undetectable results
		--table.insert( gConsoleCmdList, {ShowStr="No AI Vehicle Notice Area"} )	--test, undetectable results
		--table.insert( gConsoleCmdList, {ShowStr="No AI View"} )				--test, undetectable results
		--table.insert( gConsoleCmdList, {ShowStr="Far AI View"} )				--test, undetectable results
		--table.insert( gConsoleCmdList, {ShowStr="Short AI View"} )			--test, undetectable results
		--table.insert( gConsoleCmdList, {ShowStr="Normal AI View"} )			--test, undetectable results
		--table.insert( gConsoleCmdList, {ShowStr="Fall Health"} )				--failed, didn't give you any extra health
		--table.insert( gConsoleCmdList, {ShowStr="Hide Timers"} )		     	--test
		--table.insert( gConsoleCmdList, {ShowStr="Clear All Bonuses"} )	    --failed, check code to see if can make work
		--table.insert( gConsoleCmdList, {ShowStr="Near Collision"} )			--test
		--table.insert( gConsoleCmdList, {ShowStr="Near Collision"} )			--test
		--table.insert( gConsoleCmdList, {ShowStr="Near Collision"} )			--test
		--table.insert( gConsoleCmdList, {ShowStr="Near Collision"} )			--test
		--table.insert( gConsoleCmdList, {ShowStr=""} )

		--test these in a public server
		--table.insert( gConsoleCmdList, {ShowStr="[Test Online Crashing]"} )
		--table.insert( gConsoleCmdList, {ShowStr=""} )

		--don't display thses options in multiplayer servers
		--if not ScriptCB_InMultiplayer() then
		--table.insert( gConsoleCmdList, {ShowStr="12345678901234567890123456"} ) --used for string length testing
		--end
		
		--elseif Selection.ShowStr == "Clear All Bonuses" then
		--    --'clears' the bonuses for teams 1 and 2
		--    ActivateBonus(1, "team_bonus_None")
		--    ActivateBonus(2, "team_bonus_None")
		--elseif Selection.ShowStr == "Hide Timers" then
		--    --hide the displayed timer, if any
		--    ShowTimer(nil)
		    
		--    --Note: this just removes the timers from the hud, it doesn't stop them
		--    --attempts to clear the defeat timer for both teams
		--    SetDefeatTimer(nil, 1)
		--    SetDefeatTimer(nil, 2)

		--    --attempts to clear the mission timer for both teams
		--    SetMissionTimer(nil, 1)
		--    SetMissionTimer(nil, 2)

		--    --attempts to clear the victory timer for both teams
		--    SetVictoryTimer(nil, 1)
		--    SetVictoryTimer(nil, 2)
		--elseif Selection.ShowStr == "Fall Health" then
        --    local properties = {
        --        { name = "CollisionScale", value = "-25.0 -25.0 -25.0" },
        --    }
		--	fc_changeClassProperties( classes, properties )
		--elseif Selection.ShowStr == "Large AI Vehicle Notice Area" then
		--	SetAIVehicleNotifyRadius( 500 )
		--elseif Selection.ShowStr == "Usual AI Vehicle Notice Area" then
		--	SetAIVehicleNotifyRadius( 85 )
		--elseif Selection.ShowStr == "Small AI Vehicle Notice Area" then
		--	SetAIVehicleNotifyRadius( 40 )
		--elseif Selection.ShowStr == "No AI Vehicles" then
		--	SetAIVehicleNotifyRadius( 0 )
		--elseif Selection.ShowStr == "No AI View" then
		--	SetAIViewMultiplier( 0.0 )
		--elseif Selection.ShowStr == "Far AI View" then
		--	SetAIViewMultiplier( 10 )
		--elseif Selection.ShowStr == "Short AI View" then
		--	SetAIViewMultiplier( 0.1 )
		--elseif Selection.ShowStr == "Normal AI View" then
		--	SetAIViewMultiplier( 1.0 )
		--elseif Selection.ShowStr == "Far Collision" then
		--    --attempts to set the max collision distance to far from the objects
		--    SetMaxCollisionDistance(3000)
		--elseif Selection.ShowStr == "Average Collision" then
		--    --attempts to set the max collision distance to an average from the objects
		--    SetMaxCollisionDistance(1500)
		--elseif Selection.ShowStr == "Near Collision" then
		--    --attempts to set the max collision distance to close to the objects
		--    SetMaxCollisionDistance(5)
		--elseif Selection.ShowStr == "Land Anywhere" then
		--  --attempt to remove the landing regions in space maps so you can land anywhere
		--  print("Deactivating regions...")
		--	DeactivateRegion("all-CP1Con")
		--	DeactivateRegion("imp-CP1Con")
		--	DeactivateRegion("rep-CP1Con")
		--	DeactivateRegion("cis-CP1Con")

		--  print("Removing regions...")
		--	RemoveRegion("all-CP1Con")
		--	RemoveRegion("imp-CP1Con")
		--	RemoveRegion("rep-CP1Con")
		--	RemoveRegion("cis-CP1Con")
		--elseif Selection.ShowStr == "Disable Players" then
		--	fc_changeObjectProperty( "DisableTime", 10 )
		--elseif Selection.ShowStr == "Hide Health Bars" then
		--	fc_changeObjectProperty( "HideHealthBar", 0 )
		--elseif Selection.ShowStr == "Make Available For All" then
		--	fc_changeObjectProperty( "AvailableForAnyTeam", 0 )
		--elseif Selection.ShowStr == "Leave On Map When Dead" then
		--	fc_changeObjectProperty( "RemoveFromMapWhenDead", 1 )
		--elseif Selection.ShowStr == "Historical Rules" then
			--SetHistorical()
		--elseif Selection.ShowStr == "Historical Rules On" then
			--SetHistorical(1)
		--elseif Selection.ShowStr == "Historical Rules Off" then
			--SetHistorical(nil)
		--elseif Selection.ShowStr == "Ground Flyer Map On" then
			--SetGroundFlyerMap(1)
		--elseif Selection.ShowStr == "Ground Flyer Map Off" then
			--SetGroundFlyerMap(0)
		--elseif Selection.ShowStr == "MoveCameraToEntity 2" then
			--MoveCameraToEntity(2)
		--elseif Selection.ShowStr == "Spectator Mode" then
			--ScriptCB_SetSpectatorMode( 0, nil )
		--elseif Selection.ShowStr == "Spectator Mode 1" then
			--ScriptCB_SetSpectatorMode( 0, 1 )
		--elseif Selection.ShowStr == "Clear Bleed Rates" then
		    --attempts to clear the bleed rates for both teams
		    --Note: doesn't work, SetBleedRate() only deals with the HUD flashing, not the rate timer itself
            --SetBleedRate( 1, 0.0 )
            --SetBleedRate( 2, 0.0 )
		--elseif Selection.ShowStr == "Show All Units in MiniMap" then
			--attemps to show all units on the mini map
			--	for all teams?
			--	for team 1?
			--Note: deosn't work, need to experiment more
			--ShowAllUnitsOnMinimap(1)
		--elseif Selection.ShowStr == "" then
		--elseif Selection.ShowStr == "" then
		--elseif Selection.ShowStr == "AI Spawning - Stream" then
		    --SetSpawnDelay(1.0, .25)
		--elseif Selection.ShowStr == "AI Spawning - 15 sec" then
            --SetSpawnDelay(15.0, 1.0)
		--elseif Selection.ShowStr == "AI Spawning - Instant" then
    		--SetSpawnDelay(0.25, 1.0)
		--elseif Selection.ShowStr == "" then
		--elseif Selection.ShowStr == "" then
		--elseif Selection.ShowStr == "" then
		--elseif Selection.ShowStr == "" then

--[[
ScriptCB_Unpause(this.Viewport)
SetDefenderSnipeRange(170)
SetDenseEnvironment("True")
SetDenseEnvironment("false")
SetGroundFlyerMap(1);
SetAIDifficulty(3, -5, "medium")
		
ODF unit parameter:  
CollisionInflict
CollisionScale

CollisionThreshold
CollisionScale
CollisionInflict		

ScriptCB_SetHistoricalRulesOn(1)
ScriptCB_SetHistoricalRulesOn(nil)

ScriptCB_ShowLoadDisplay(false)
ScriptCB_ShowLoadDisplay(true)

ScriptCB_MakeFakeProfiles(FakeNames[1], FakeNames[2])
ScriptCB_MakeFakeProfiles(FakeNames[1], FakeNames[2], FakeNames[3], FakeNames[4])

SetSpawnDelay(1.0, 0.25)
SetSpawnDelay(10.0, 0.25)
SetSpawnDelay(11.2, 1.1)
SetSpawnDelay(15.0, 0.25)
SetSpawnDelayTeam(0.0, 0.0, BODYGUARDS)
SetSpawnDelayTeam(1.0, 0.5, AMS)
SetSpawnDelayTeam(1.0, 0.5, ATT)
SetSpawnDelayTeam(1.0, 0.5, BOS)
SetSpawnDelayTeam(1.0, 0.5, DEF)
SetSpawnDelayTeam(1.0, 1.0, DEF)
SetSpawnDelayTeam(10.0, 0.5, AMB)
SetSpawnDelayTeam(10.0, 0.5, DEF)
SetSpawnDelayTeam(10.0, 0.5, GAR)
SetSpawnDelayTeam(12.0, 3, FILL)
SetSpawnDelayTeam(14.0, 3, DEF)
SetSpawnDelayTeam(2.0, 0.5, ATT)
SetSpawnDelayTeam(5.0, 3, DEF)
SetSpawnDelayTeam(7.0, 4.0, DEF)
SetSpawnDelayTeam(9.5, 3.5, DEF)
SetSpawnDelayTeam(9.5, 7.5, DEF)

Remove the 'out of bounds' kill zones
--]]
------------------------------------------------------------------------------
------------------------------------------------------------------------------

		ff_AddCommand( "[Utility]", nil, nil, nil)
		
		--works, closes the FakeConsole screen
		ff_AddCommand( "Exit Screen", nil, function()
			ScriptCB_SndPlaySound("shell_menu_exit");
			ScriptCB_PopScreen()
		end, nil)

		--works, closes the FakeConsole screen
		ff_AddCommand( "Code Console", nil, function()
			local temp = function( value )
				if not value then return end

				--convert the user's input into a funtion
				local userFunction = loadstring( value )

				--attempt to run the user's funtion
				local result = pcall( userFunction )
				--print("ifs_fakeconsole: Code Console: The result of the function is: ", result)
			end
			
			ff_AskUser( "Please enter some Lua code to run.  Remember, it must be a function.", temp, ifs_fakeconsole )
		end, nil)
		
		--untested, should only shows up for people looking at the server list, not those already ingame
		ff_AddCommand( "Change Server Name", nil, function()
			local temp = function( value )
				if not value then return end
				if value == "" then return end	--don't let people use blank server names, I don't know what this will do to the server managers
				
				ScriptCB_SetGameName( value )
			end
			
			ff_AskUser( "Please enter a new name for this server", temp, ifs_fakeconsole )
		end, nil)
		
		--works, only shows up for people looking at the server list, not those already ingame
		ff_AddCommand( "Clear Crashes From Server Name", nil, function()
			ff_serverDoesNotCrash()
		end, nil)
		
		
		--
		ff_AddCommand( "", nil, nil, nil)
		
---------------------------------------
		--these commands run a sequence of other commands
		ff_AddCommand( "[Command Groups]", nil, nil, nil)

		--works
		ff_AddCommand( "Common Commands", nil, function()
			ff_CommandAddJetPacks()
			ff_CommandSuperJump()
			ff_CommandRemoveAwardEffects()
			ff_CommandExtremePoints()
			ff_CommandSuperHighFlying()
			ff_CommandCrazyEnduranceRegen()
			ff_CommandSlowHealthRegen()
		end, nil)
	
		--works
		ff_AddCommand( "Unending Map", nil, function()
			ff_CommandDenyCPCapture()
			ff_CommandUnlimitedReinforcements()
			ff_CommandUnlimitedTeamPoints()
			ff_CommandNoAIUnitDamage()
			ff_CommandPreventVictory()
		end, nil)

		--
		ff_AddCommand( "", nil, nil, nil)
---------------------------------------

		--these commands don't crash in MP
		ff_AddCommand( "[Do Not Crash]", nil, nil, nil)

		--works, SP version of the mp_lobby button
	    --causes the AI on player 0's enemy team to follow him
		ff_AddCommand( "Enemy AI Follow", nil, function()
			--get player 0's team number
			local team = GetCharacterTeam( 0 )

			--determine the other team
			team = uf_GetOtherTeam( team )
			if team == nil then return end

            --tell the AI to follow him
			AddAIGoal(team, "follow", 100, 0)
		end, function()
			return not ScriptCB_InNetGame()
		end)

		--test, SP version of the mp_lobby button
    	--causes the AI on the player 0's team to follow him
		ff_AddCommand( "Friendly AI Follow", nil, function()
			--get player 0's team number
			local team = GetCharacterTeam( 0 )

            --tell the AI to follow him
			AddAIGoal(team, "follow", 100, 0)
		end,
		function()
			return not ScriptCB_InNetGame()
		end)

		--works, SP version of the mp_lobby button
		--attempts to teleport all enemy AI units to player 0's location
		ff_AddCommand( "Enemy AI Teleport", nil, function()
			local toPlayer = GetCharacterUnit( 0 )
			local team = GetCharacterTeam( 0 )
			if toPlayer == nil then return end
			
			--determine the other team
			team = uf_GetOtherTeam( team )
			if team == nil then return end

			--teleports player to toPlayer
			local miniFun = function( player, unit, toPlayer, value )
				if (unit == nil) or (toPlayer == nil) then return end	--check input

				local to = GetEntityMatrix( toPlayer )
				SetEntityMatrix( unit, to )
			end

			uf_applyFunctionOnTeamUnits( miniFun, toPlayer, value, {team} )
		end,
		function()
			return not ScriptCB_InNetGame()
		end)

		--works, SP version of the mp_lobby button
		--attempts to teleport all friendly AI units to player 0's location
		ff_AddCommand( "Friendly AI Teleport", nil, function()
			local toPlayer = GetCharacterUnit( 0 )
			local team = GetCharacterTeam( 0 )
			if toPlayer == nil then return end

			--teleports player to toPlayer
			local miniFun = function( player, unit, toPlayer, value )
				if (unit == nil) or (toPlayer == nil) then return end	--check input

				local to = GetEntityMatrix( toPlayer )
				SetEntityMatrix( unit, to )
			end

			uf_applyFunctionOnTeamUnits( miniFun, toPlayer, value, {team} )
		end,
		function()
			return not ScriptCB_InNetGame()
		end)

		--
		ff_AddCommand( "", nil, nil, nil)

		--works
		--attempts to allow all units to enter vehicles
		ff_AddCommand( "Unlock Vehicles", nil, function()
			ff_lockVehicles = 0
            local properties = {
                { name = "NoEnterVehicles", value = "0" },
            }
			uf_changeClassProperties( uf_classes, properties )
		end, function()
			return ff_lockVehicles == 1
		end)

		--works
		--attempts to prevent all units from entering vehicles
		ff_AddCommand( "Lock Vehicles", nil, function()
			ff_lockVehicles = 1
            local properties = {
                { name = "NoEnterVehicles", value = "1" },
            }
			uf_changeClassProperties( uf_classes, properties )
		end, function()
			return ff_lockVehicles ~= 1
		end)

		--works, test if your screen only
		--attempts to force players into using 3rd person
		ff_AddCommand( "Force 3rd View", nil, function()
            ff_forceViewOn = 1
            local properties = {
                { name = "ForceMode", value = 1 },
            }
			uf_changeClassProperties( uf_classes, properties )
		end, function()
			return ff_forceViewOn ~= 1
		end)

		--works, test if your screen only
		--attempts to all players to use either 1st or 3rd person views
		ff_AddCommand( "Force No Views", nil, function()
            ff_forceViewOn = 0

            local properties = {
                { name = "ForceMode", value = 0 },
            }
			uf_changeClassProperties( uf_classes, properties )
		end, function()
			return ff_forceViewOn == 1
		end)

		--works
		--prevents all unit classes from capturing CPs
 		--Note: MP players see CPs as being captured, but the 'ownership rate' never goes down
 		ff_AddCommand( "Deny CP Capture", nil, function()
			ff_CommandDenyCPCapture()
		end, function()
			return ff_cpCapture == 1
		end)

		--works
		--allows all unit classes to capture CPs
		ff_AddCommand( "Allow CP Capture", nil, function()
            ff_cpCapture = 1
			local properties = {
			    { name = "CapturePosts", value = "1" },
			}
			uf_changeClassProperties( uf_classes, properties )
		end, function()
			return ff_cpCapture ~= 1
		end)

		--works
		--makes all units able to trigger mines
		ff_AddCommand( "Not Immune To Mines", nil, function()
			ff_immuneToMines = 0
		    local properties = {
                { name = "ImmuneToMines", value = "0" },
            }
			uf_changeClassProperties( uf_classes, properties )
		end, function()
			return ff_immuneToMines == 1
		end)

		--works
		--prevents all units from triggering mines
		--Note: MP players still see mine explosions
		ff_AddCommand( "Immune To Mines", nil, function()
			ff_immuneToMines = 1
            local properties = {
                { name = "ImmuneToMines", value = "1" },
            }
			uf_changeClassProperties( uf_classes, properties )
		end, function()
			return ff_immuneToMines ~= 1
		end)

		--
		ff_AddCommand( "", nil, nil, nil)


		--works
		--Note: if already on a team, then can't change team
		--make all human players only join team 1
		ff_AddCommand( "Force Humans Onto Team 1", nil, function()
			ForceHumansOntoTeam1(1)
		end, nil)

		--works, at least for AI, not sure about human players
		--attempts to prevent all units from recovering from tumbles
		ff_AddCommand( "Disable Tumble Recovery", nil, function()
			ff_tumbleRecovery = 0
            local properties = {
                { name = "RecoverFromTumble", value = "0" },
            }
			uf_changeClassProperties( uf_classes, properties )
		end, function()
			return ff_tumbleRecovery == 1
		end)

		--works, at least for AI, not sure about human players
		--attempts to allow all units to recover from tumbles
		ff_AddCommand( "Enable Tumble Recovery", nil, function()
			ff_tumbleRecovery = 1
            local properties = {
                { name = "RecoverFromTumble", value = "1" },
            }
			uf_changeClassProperties( uf_classes, properties )
		end, function()
			return ff_tumbleRecovery ~= 1
		end)

		--works
		--allows players to pass through the hanger shields
		ff_AddCommand( "Walkthrough Hanger Shields", nil, function()
		    ff_hangerWalkthrough = 1
			local properties = {
				{ name = "SoldierCollision", value = "CLEAR" }, 	--
				--{ name = "SoldierCollision", value = "NONE" },    --
				--{ name = "SoldierCollision", value = "" },        --
			}
		
			local shields = {
			    --space hanger shields
				"all_cap_rebelcruiser_shield",
				"cis_fedcruiser_shield_blue",
				"rep_assultship_shield_red",
				"imp_cap_stardestroyer_shield",
				
				--pol hanger shields
				"pol1_prop_health_shield",
				"pol1_prop_hanger_shield",
				"pol1_prop_cavern_shield",
				"Pol_prop_shield",
			}
			uf_changeClassProperties( shields, properties )
		end, function()
			return ff_hangerWalkthrough ~= 1
		end)

		--[[--failed
		--prevents players from moving through the hanger shields
		ff_AddCommand( "Blocking Hanger Shields", nil, function()
			ff_hangerWalkthrough = 0
			--Note: this is not working yet
			-------------------------------
			--tried:
			--failed: SetClassProperty("all_cap_rebelcruiser_shield", "SoldierCollision", "")
			--failed: SetClassProperty("all_cap_rebelcruiser_shield", "SoldierCollision", "all_cap_rebelcruiser_shield")
			--failed: SetClassProperty("all_cap_rebelcruiser_shield", "SoldierCollision", "all_cap_rebelcruiser_shield.msh")
			--failed: SetClassProperty("all_cap_rebelcruiser_shield", "SoldierCollision", "geometryname")
			--failed: SetClassProperty("all_cap_rebelcruiser_shield", "SoldierCollision", "GEOMETRYNAME")
			--failed: SetClassProperty("imp_cap_stardestroyer_shield", "SoldierCollision", "collision1")

			--failed, shield is an EntityProp not an Object
			--KillObject("IMP_CAP_STARDESTROYER_SHIELD")
			--RespawnObject("IMP_CAP_STARDESTROYER_SHIELD")
			-------------------------------

			--SetClassProperty("all_cap_rebelcruiser_shield", "SoldierCollision", "GeometryName")
			--SetClassProperty("cis_fedcruiser_shield_blue", "SoldierCollision", "GeometryName1")
			--SetClassProperty("rep_assultship_shield_red", "SoldierCollision", "GeometryName2")
			--SetClassProperty("imp_cap_stardestroyer_shield", "SoldierCollision", "COLLISION1")

			--SetClassProperty("pol1_prop_health_shield", "SoldierCollision", "")
			--SetClassProperty("pol1_prop_hanger_shield", "SoldierCollision", "")
			--SetClassProperty("pol1_prop_cavern_shield", "SoldierCollision", "")
			--SetClassProperty("Pol_prop_shield", "SoldierCollision", "")
			
			--SetClassProperty("all_cap_rebelcruiser_shield", "SoldierCollision", "GeometryName")
			--SetClassProperty("cis_fedcruiser_shield_blue", "SoldierCollision", "GeometryName")
			--SetClassProperty("rep_assultship_shield_red", "SoldierCollision", "GeometryName")
			SetClassProperty("imp_cap_stardestroyer_shield", "SoldierCollision", "imp_cap_stardestroyer_shield")
			
			local location = GetEntityMatrix("IMP_CAP_STARDESTROYER_SHIELD")
			DeleteEntity("IMP_CAP_STARDESTROYER_SHIELD")
			CreateEntity("imp_cap_stardestroyer_shield", location, "IMP_CAP_STARDESTROYER_SHIELD")

			--CreateEntity("com_item_holocron", Holocron1Spawn, "holodisk") --spawns the disk
			--DeleteEntity("IMP_CAP_STARDESTROYER_SHIELD")
		end, function()
			return ff_hangerWalkthrough == 1
		end)--]]

		--works
		--allows anything to fire through the hanger shields
		ff_AddCommand( "Hanger Shields Allow Fire", nil, function()
		    ff_hangerShootThrough = 1
			local properties = {
				{ name = "OrdnanceCollision", value = "CLEAR" },
			}
		
			local shields = {
			    --space hanger shields
				"all_cap_rebelcruiser_shield",
				"cis_fedcruiser_shield_blue",
				"rep_assultship_shield_red",
				"imp_cap_stardestroyer_shield",

				--pol hanger shields
				"pol1_prop_health_shield",
				"pol1_prop_hanger_shield",
				"pol1_prop_cavern_shield",
				"Pol_prop_shield",
			}
			uf_changeClassProperties( shields, properties )
		end, function()
			return ff_hangerShootThrough ~= 1
		end)

		--[[--failed
		--prevent fire from passing through the hanger shields
		ff_AddCommand( "Hanger Shields Stop Fire", nil, function()
			ff_hangerShootThrough = 0
			--Note: this doesn't work yet

			local properties = {
				{ name = "OrdnanceCollision", value = "" },
				--{ name = "OrdnanceCollision", value = "none" },
			}
		
			local shields = {
			    --space hanger shields
				"all_cap_rebelcruiser_shield",
				"cis_fedcruiser_shield_blue",
				"rep_assultship_shield_red",
				"imp_cap_stardestroyer_shield",

				--pol hanger shields
				"pol1_prop_health_shield",
				"pol1_prop_hanger_shield",
				"pol1_prop_cavern_shield",
				"Pol_prop_shield",
			}
			uf_changeClassProperties( shields, properties )
		end, function()
			return ff_hangerShootThrough == 1
		end)--]]

		--
		ff_AddCommand( "", nil, nil, nil)

		--works
		--Note: other MP players see flying players as falling, but they really aren't and can shoot from this view
		--adds a jet pack to all units
		ff_AddCommand( "Add JetPacks", nil, function()
			ff_CommandAddJetPacks()
		end, function() return ff_addedJetPacks ~= 1 end)

		--works in SP, untested in MP, supposed to make you jump like a Jedi
		ff_AddCommand("Jedi Jumps", nil, function()
			local properties = {
				{ name = "ControlSpeed", value = "jet 2.0 1,25 1.25"},
				{ name = "JetJump", 		value = "10.0" },
				{ name = "JetPush", 		value = "0.0" },
				{ name = "JetAcceleration", value = "10.0" },
				{ name = "JetEffect", 		value = "" },
				{ name = "JetFuelRechangeRate", value = "0.0" },
				{ name = "JetFuelCost", 	value = "0.0" },
				{ name = "JetFuelInitialCost", value = "0.0" },
				{ name = "JetFuelMinBorder", value = "0.0" },
				{ name = "JetShowHud", 	value = "0" },
				{ name = "JetEnergyDrain", 	value = "40" },
			}
			uf_changeClassProperties( uf_classes, properties )
		end, nil )

		--works
		--causes units to jump far backwards and to the sides
		ff_AddCommand( "Super Jump", nil, function()
			ff_CommandSuperJump()
		end, nil)
		
		--works
		--sets about the normal jump values
		ff_AddCommand( "Normal Jump", nil, function()
			local properties = {
			    { name = "JumpHeight", 		value = "1.78" },
			    { name = "JumpFowardSpeedFactor", value = "1.3" },
			    { name = "JumpStrafeSpeedFactor", value = "1.0" },
			}
			uf_changeClassProperties( uf_classes, properties )
		end, nil)
		
		--
		ff_AddCommand( "", nil, nil, nil)
		
		--works
		--need to checkout rolling/jumping
		--decrease all default speeds
		ff_AddCommand( "Low Speeds", nil, function()
			local properties = {
			    { name = "ControlSpeed", value = "stand 0.50 0.50 0.50" },
			    { name = "ControlSpeed", value = "crouch 0.35 0.30 0.25" },
			    { name = "ControlSpeed", value = "sprint 0.75 0.25 0.18" },
			    { name = "ControlSpeed", value = "roll 0.01 0.01 0.18" },
			    { name = "ControlSpeed", value = "tumble 0.00 0.00 0.05" },
			}

			--make the changes
			uf_changeClassProperties( uf_classes, properties )
		end, nil)
		
		--works
		--set speed to mormal values
		ff_AddCommand( "Normal Speeds", nil, function()
			local properties = {
   			    { name = "ControlSpeed", value = "stand 1.00 1.00 1.00" },
			    { name = "ControlSpeed", value = "crouch 0.70 0.60 0.50" },
			    { name = "ControlSpeed", value = "sprint 1.50 0.50 0.35" },
			    { name = "ControlSpeed", value = "roll 0.02 0.02 0.35" },
			    { name = "ControlSpeed", value = "tumble 0.00 0.00 0.10" },
			}
			uf_changeClassProperties( uf_classes, properties )
		end, nil)
		
		--works
		--need to checkout rolling/jumping
		--increase all default speeds
		ff_AddCommand( "High Speeds", nil, function()
			local properties = {
			    { name = "ControlSpeed", value = "stand 2.00 2.00 2.00" },
			    { name = "ControlSpeed", value = "crouch 1.40 1.20 1.00" },
			    { name = "ControlSpeed", value = "sprint 3.00 1.00 0.70" },
			    { name = "ControlSpeed", value = "roll 0.04 0.04 0.70" },
			    { name = "ControlSpeed", value = "tumble 0.00 0.00 0.20" },
			}

			--make the changes
			uf_changeClassProperties( uf_classes, properties )
		end, nil)
		
		--works
		--sets the amount of endurance used for sprinting
		ff_AddCommand( "Sprint Energy Usage", nil, function()
			local temp = function( rate )
				if not rate then return end
				local properties = {
				    { name = "EnergyDrainSprint", 	value = rate },
				}
				uf_changeClassProperties( uf_classes, properties )
			end
			
			ff_AskUser( "Please enter the amount of endurance to use while sprinting (energy units per second)", temp, ifs_fakeconsole )
		end, nil)

		--works
		--give units full control over movement
		ff_AddCommand( "Full Control", nil, function()
			local properties = {
   			    { name = "ControlSpeed", value = "stand 1.00 1.00 1.00" },
			    { name = "ControlSpeed", value = "crouch 1.00 1.00 1.00" },
   			    { name = "ControlSpeed", value = "prone 1.00 1.00 1.00" },
			    { name = "ControlSpeed", value = "sprint 1.00 1.00 1.00" },
   			    { name = "ControlSpeed", value = "jet 1.00 1.00 1.00" },
			    { name = "ControlSpeed", value = "roll 1.00 1.00 1.00" },
			    { name = "ControlSpeed", value = "tumble 1.00 1.00 1.00" },
			}
			uf_changeClassProperties( uf_classes, properties )
		end, nil)

		--works
		--give units high movement control values
		ff_AddCommand( "High Control", nil, function()
			local properties = {
   			    { name = "ControlSpeed", value = "stand 1.00 1.00 1.00" },
			    { name = "ControlSpeed", value = "crouch 1.25 1.25 1.25" },
   			    { name = "ControlSpeed", value = "prone 0.30 0.20 0.50" },
			    { name = "ControlSpeed", value = "sprint 2.50 2.50 2.50" },
   			    { name = "ControlSpeed", value = "jet 1.75 1.75 1.75" },
			    { name = "ControlSpeed", value = "roll 0.50 0.50 1.35" },
			    { name = "ControlSpeed", value = "tumble 1.00 1.00 1.00" },
			}
			uf_changeClassProperties( uf_classes, properties )
		end, nil)

		--works
		--give units standard movement control values
		ff_AddCommand( "Normal Control", nil, function()
			local properties = {
   			    { name = "ControlSpeed", value = "stand 1.00 1.00 1.00" },
			    { name = "ControlSpeed", value = "crouch 0.70 0.60 1.00" },
   			    { name = "ControlSpeed", value = "prone 0.30 0.20 0.50" },
			    { name = "ControlSpeed", value = "sprint 2.50 0.50 0.50" },
   			    { name = "ControlSpeed", value = "jet 1.50 1.25 1.25" },
			    { name = "ControlSpeed", value = "roll 0.02 0.02 0.35" },
			    { name = "ControlSpeed", value = "tumble 0.00 0.00 0.10" },
			}
			uf_changeClassProperties( uf_classes, properties )
		end, nil)

		--works
		--give units poor movement control values
		ff_AddCommand( "Poor Control", nil, function()
			local properties = {
   			    { name = "ControlSpeed", value = "stand 0.50 0.50 0.50" },
			    { name = "ControlSpeed", value = "crouch 0.35 0.30 0.50" },
   			    { name = "ControlSpeed", value = "prone 0.15 0.10 0.25" },
			    { name = "ControlSpeed", value = "sprint 1.25 0.25 0.25" },
   			    { name = "ControlSpeed", value = "jet 0.75 0.62 0.62" },
			    { name = "ControlSpeed", value = "roll 0.01 0.01 0.17" },
			    { name = "ControlSpeed", value = "tumble 0.00 0.00 0.05" },
			}
			uf_changeClassProperties( uf_classes, properties )
		end, nil)
		
		--
		ff_AddCommand( "", nil, nil, nil)
		
		--works
		--sets a user prompted health regen rate for the AI bots
		ff_AddCommand( "Health Regen - AI", nil, function()
			local temp = function( value )
				if not value then return end
				ff_healthRegen( value, "ai" )
			end
			
			ff_AskUser( "Please enter a health regeneration rate (health units per second).  Negative rates cause damage", temp, ifs_fakeconsole )
		end, nil)

		--works
		--sets a user prompted health regen rate
		ff_AddCommand( "Health Regen - All", nil, function()
			local temp = function( value )
				if not value then return end
				ff_healthRegen( value, nil )
			end
			
			ff_AskUser( "Please enter a health regeneration rate (health units per second).  Negative rates cause damage", temp, ifs_fakeconsole )
		end, nil)

		--works
		--sets a user prompted health regen rate for all the human players
		ff_AddCommand( "Health Regen - Humans", nil, function()
			local temp = function( value )
				if not value then return end
				ff_healthRegen( value, "human" )
			end
			
			ff_AskUser( "Please enter a health regeneration rate (health units per second).  Negative rates cause damage", temp, ifs_fakeconsole )
		end, nil)

		--works
		--sets the amount of endurace to regen while the unit is active
		ff_AddCommand( "Endurance Regen", nil, function()
			local temp = function( rate )
				if not rate then return end
				local properties = {
				    { name = "EnergyRestore", 	value = rate },
				}
				uf_changeClassProperties( uf_classes, properties )
			end
			
			ff_AskUser( "Please enter an endurance regeneration rate (energy units per second)", temp, ifs_fakeconsole )
		end, nil)
		
		--works
		--sets the amount of endurance to regen when the unit is idle
		ff_AddCommand( "Idle Endurance Regen", nil, function()
			local temp = function( rate )
				if not rate then return end
				local properties = {
				    { name = "EnergyRestoreIdle", 	value = rate },
				}
				uf_changeClassProperties( uf_classes, properties )
			end
			
			ff_AskUser( "Please enter an idle endurance regeneration rate (energy units per second)", temp, ifs_fakeconsole )
		end, nil)
		
		--
		ff_AddCommand( "", nil, nil, nil)
		
		--works
		--sets no players cannot get any more points
		ff_AddCommand( "No Points", nil, function()
			local Player_Stats_Points = {
				{ point_gain =  0  },			--//	PS_GLB_KILL_AI_PLAYER = 0,
				{ point_gain =  0  },			--//	PS_GLB_KILL_HUMAN_PLAYER,
				{ point_gain =  0  },			--//	PS_GLB_KILL_HUMAN_PLAYER_AI_OFF,
				{ point_gain =  0  },			--//	PS_GLB_KILL_SUICIDE,
				{ point_gain =  0  },			--//	PS_GLB_KILL_TEAMMATE,
				{ point_gain =  0  },			--//	PS_GLB_VEHICLE_KILL_INFANTRY_VS_VEHICLE,
				{ point_gain =  0  },			--//	PS_GLB_VEHICLE_KILL_LIGHT_VS_HEAVY,
				{ point_gain =  0  },			--//	PS_GLB_VEHICLE_KILL_LIGHT_VS_MEDIUM,
				{ point_gain =  0  },			--//	PS_GLB_VEHICLE_KILL_HEAVY_VS_LIGHT,
				{ point_gain =  0  },			--//	PS_GLB_VEHICLE_KILL_HEAVY_VS_MEDIUM,
				{ point_gain =  0  },			--//	PS_GLB_VEHICLE_KILL_MEDIUM_VS_LIGHT,
				{ point_gain =  0  },			--//	PS_GLB_VEHICLE_KILL_MEDIUM_VS_HEAVY,
				{ point_gain =  0  },			--//	PS_GLB_VEHICLE_KILL_ATAT,
				{ point_gain =  0  },			--//	PS_GLB_VEHICLE_KILL_EMPTY,
				{ point_gain =  0  },			--//	PS_GLB_HEAL,
				{ point_gain =  0  },			--//	PS_GLB_REPAIR,
				{ point_gain =  0  },			--//	PS_GLB_SNIPER_ACCURACY,
				{ point_gain =  0  },			--//	PS_GLB_HEAVY_WEAPON_MULTI_KILL,
				{ point_gain =  0  },			--//	PS_GLB_RAMPAGE,
				{ point_gain =  0  },			--//	PS_GLB_HEAD_SHOT,
				{ point_gain =  0  },			--//	PS_GLB_KILL_HERO,
				{ point_gain =  0  },			--//	PS_CON_CAPTURE_CP,
				{ point_gain =  0  },			--//	PS_CON_ASSIST_CAPTURE_CP,
				{ point_gain =  0  },			--//	PS_CON_KILL_ENEMY_CAPTURING_CP,
				{ point_gain =  0  },			--//	PS_CON_DEFEND_CP,
				{ point_gain =  0  },			--//	PS_CON_KING_HILL,
				{ point_gain =  0  },			--//	PS_CAP_PICKUP_FLAG,
				{ point_gain =  0  },			--//	PS_CAP_DEFEND_FLAG,
				{ point_gain =  0  },			--//	PS_CAP_CAPTURE_FLAG,
				{ point_gain =  0  },			--//	PS_CAP_DEFEND_FLAG_CARRIER,
				{ point_gain =  0  },			--//	PS_CAP_KILL_ENEMY_FLAG_CARRIER,
				{ point_gain =  0  },			--//	PS_CAP_KILL_ALLY_FLAG_CARRIER,
				{ point_gain =  0  },			--//	PS_ASS_DESTROY_ASSAULT_OBJ,
				{ point_gain =  0  },			--//	PS_ESC_DEFEND,
				{ point_gain =  0  },			--//	PS_DEF_DEFEND,
			}

			--save the new points
			ScriptCB_SetPlayerStatsPoints( Player_Stats_Points )
		end, nil)
		
		--works
		--return game to default point values
		ff_AddCommand( "Normal Points", nil, function()
			local Player_Stats_Points = {
				{ point_gain =   1  },			--//	PS_GLB_KILL_AI_PLAYER = 0,
				{ point_gain =   2  },			--//	PS_GLB_KILL_HUMAN_PLAYER,
				{ point_gain =   1  },			--//	PS_GLB_KILL_HUMAN_PLAYER_AI_OFF,
				{ point_gain =  -1  },			--//	PS_GLB_KILL_SUICIDE,
				{ point_gain =  -2  },			--//	PS_GLB_KILL_TEAMMATE,
				{ point_gain =   3  },			--//	PS_GLB_VEHICLE_KILL_INFANTRY_VS_VEHICLE,
				{ point_gain =   2  },			--//	PS_GLB_VEHICLE_KILL_LIGHT_VS_HEAVY,
				{ point_gain =   1  },			--//	PS_GLB_VEHICLE_KILL_LIGHT_VS_MEDIUM,
				{ point_gain =   1  },			--//	PS_GLB_VEHICLE_KILL_HEAVY_VS_LIGHT,
				{ point_gain =   1  },			--//	PS_GLB_VEHICLE_KILL_HEAVY_VS_MEDIUM,
				{ point_gain =   1  },			--//	PS_GLB_VEHICLE_KILL_MEDIUM_VS_LIGHT,
				{ point_gain =   1  },			--//	PS_GLB_VEHICLE_KILL_MEDIUM_VS_HEAVY,
				{ point_gain =  10  },			--//	PS_GLB_VEHICLE_KILL_ATAT,
				{ point_gain =   1  },			--//	PS_GLB_VEHICLE_KILL_EMPTY,
				{ point_gain =   1  },			--//	PS_GLB_HEAL,
				{ point_gain =   1  },			--//	PS_GLB_REPAIR,
				{ point_gain =   1  },			--//	PS_GLB_SNIPER_ACCURACY,
				{ point_gain =   1  },			--//	PS_GLB_HEAVY_WEAPON_MULTI_KILL,
				{ point_gain =   1  },			--//	PS_GLB_RAMPAGE,
				{ point_gain =   1  },			--//	PS_GLB_HEAD_SHOT,
				{ point_gain =   5  },			--//	PS_GLB_KILL_HERO,
				{ point_gain =   5  },			--//	PS_CON_CAPTURE_CP,
				{ point_gain =   2  },			--//	PS_CON_ASSIST_CAPTURE_CP,
				{ point_gain =   2  },			--//	PS_CON_KILL_ENEMY_CAPTURING_CP,
				{ point_gain =   2  },			--//	PS_CON_DEFEND_CP,
				{ point_gain =   1  },			--//	PS_CON_KING_HILL,
				{ point_gain =   1  },			--//	PS_CAP_PICKUP_FLAG,
				{ point_gain =   2  },			--//	PS_CAP_DEFEND_FLAG,
				{ point_gain =  10  },			--//	PS_CAP_CAPTURE_FLAG,
				{ point_gain =   2  },			--//	PS_CAP_DEFEND_FLAG_CARRIER,
				{ point_gain =   2  },			--//	PS_CAP_KILL_ENEMY_FLAG_CARRIER,
				{ point_gain = -12  },			--//	PS_CAP_KILL_ALLY_FLAG_CARRIER,
												--//	// assault
				{ point_gain =  10  },			--//	PS_ASS_DESTROY_ASSAULT_OBJ,
												--//	// escort
				{ point_gain =   2  },			--//	PS_ESC_DEFEND,
												--//	// defend
				{ point_gain =   2  },			--//	PS_DEF_DEFEND,
			}
	
			--save the new points
			ScriptCB_SetPlayerStatsPoints( Player_Stats_Points )
		end, nil)
		
		--works
		--make it easier to get points (usefull to reach locked units)
		ff_AddCommand( "Extreme Points", nil, function()
			ff_CommandExtremePoints()
		end, nil)
		
		--
		ff_AddCommand( "", nil, nil, nil)
		
		--test
		--works, but only for fall damage?
		ff_AddCommand( "Fall Damage", nil, function()
			local temp = function( rate )
				if not rate then return end
				local properties = {
				  --{ name = "CollisionScale", value = "50.0 50.0 50.0" },
					{ name = "CollisionScale", value = rate.." "..rate.." "..rate },
				}
				uf_changeClassProperties( uf_classes, properties )
			end
			
			ff_AskUser("Please enter the fall damage's collision scale", temp, ifs_fakeconsole )
		end, nil)
		
		--works, test in damage and death regions, stops water damage, but not fall damage
		--a rate of 0.5 prevents units from taking AI damage when unit's health is at or below 50%
		--a rate of 0 means the unit can be damaged down to 0% of its health
		ff_AddCommand( "AI Damage Threshold", nil, function()
			local temp = function( rate )
				if not rate then return end
			    ff_changeAIDamageThreshold( rate )
			end
			
			ff_AskUser("Please enter the AI damage threshold (range from 0 to 1, default is 0)", temp, ifs_fakeconsole )
		end, nil)
		
		--works
		--attepmts to prevent the AI on team 1 from spawning
		ff_AddCommand( "Disallow AI Spawn 1", nil, function()
		    ff_aiSpawn1 = 0
		    AllowAISpawn( 1, false )
		end, function()
			return ff_aiSpawn1 == 1
		end)

		--works
	    --attepmts to allow the AI on team 1 to spawn
		ff_AddCommand( "Allow AI Spawn 1", nil, function()
		    ff_aiSpawn1 = 1
		    AllowAISpawn( 1, true )
		end, function()
			return ff_aiSpawn1 ~= 1
		end)

		--works
		--attepmts to prevent the AI on team 1 from spawning
		ff_AddCommand( "Disallow AI Spawn 2", nil, function()
		    ff_aiSpawn2 = 0
		    AllowAISpawn( 2, false )
		end, function()
			return ff_aiSpawn2 == 1
		end)

		--works
		--attepmts to allow the AI on team 2 to spaw
		ff_AddCommand( "Allow AI Spawn 2", nil, function()
		    ff_aiSpawn2 = 1
		    AllowAISpawn( 2, true )
		end, function()
			return ff_aiSpawn2 ~= 1
		end)

		--works
		--prevent players from picking sides
		--Note: seems to work in MP but really doesn't.  You can choose your side, but the server will override your choice.
		ff_AddCommand( "Team Auto-assign On", nil, function()
			ff_chooseSides = 0
			ScriptCB_SetCanSwitchSides(false)
		end, function()
			return ff_chooseSides == 1
		end)

		--works
		--allow player to pick sides
		--Note: seems to work in MP but really doesn't.  You can choose your side, but the server will override your choice.
		ff_AddCommand( "Team Auto-assign Off", nil, function()
			ff_chooseSides = 1
			ScriptCB_SetCanSwitchSides(true)
		end, function()
			return ff_chooseSides ~= 1
		end)

		--
		ff_AddCommand( "", nil, nil, nil)

		--works
		--clears all AI goals
		ff_AddCommand( "AI Goals Clear", nil, function()
		    ClearAIGoals(1)
		    ClearAIGoals(2)
		end, nil)

		--works
		--add the AI goal conquest to both teams 1 and 2
		ff_AddCommand( "AI Goals Conquest", nil, function()
			AddAIGoal(1, "conquest", 1000)
			AddAIGoal(2, "conquest", 1000)
		end, nil)

		--works
		--add the AI goal deathmatch to both teams 1 and 2
		ff_AddCommand( "AI Goals Deathmatch", nil, function()
			AddAIGoal(1, "deathmatch", 1000)
			AddAIGoal(2, "deathmatch", 1000)
		end, nil)

		--
		ff_AddCommand( "", nil, nil, nil)

		--works
		--kills all units on teams 1 and 2
		ff_AddCommand( "Kill All Units", nil, function()
		    uf_killUnits( {1}, true )	--kills all AI units on team 1
		    uf_killUnits( {2}, true )	--kills all AI units on team 2
		    uf_killUnits( {1}, false )	--kills all units on team 1
		    uf_killUnits( {2}, false )	--kills all units on team 1
		end, nil)

		--works
		--kills all AI units on team 1
		ff_AddCommand( "Kill All AI on Team 1", nil, function()
		    uf_killUnits( {1}, true )
		end, nil)

		--works
		--kills all AI units on team 2
		ff_AddCommand( "Kill All AI on Team 2", nil, function()
		    uf_killUnits( {2}, true )
		end, nil)

		--works
		--kills all units on team 1
		ff_AddCommand( "Kill All Humans On Team 1", nil, function()
		    uf_killUnits( {1}, false )
		end, nil)

		--works
		--attempts to kill all units on team 1
		ff_AddCommand( "Kill All Humans On Team 2", nil, function()
		    uf_killUnits( {2}, false )
		end, nil)

		--
		ff_AddCommand( "", nil, nil, nil)

		--works
		--prompts to change the number of bots allowed to spawn in the game
		ff_AddCommand( "Number Of Bots", nil, function()
			local temp = function( rate )
				if not rate then return end
			    ScriptCB_SetNumBots( rate )
			end

			ff_AskUser("Please enter the max amount of bots allowed ingame", temp, ifs_fakeconsole )
		end, nil)

		--works
		--Note: causes jumpyness in MP
		ff_AddCommand( "Map Ceiling", nil, function()
		local temp = function( rate )
				if not rate then return end
			    SetMaxFlyHeight( rate )
				SetMaxPlayerFlyHeight( rate )
			end

			ff_AskUser("Please enter the hight of the map", temp, ifs_fakeconsole )
		end, nil)

		--works
		--Note: causes jumpyness in MP
		ff_AddCommand( "Map Floor", nil, function()
		local temp = function( rate )
				if not rate then return end
			    SetMinFlyHeight( rate )
				SetMinPlayerFlyHeight( rate )
			end

			ff_AskUser("Please enter the lowest 'level' of the map (negative values preferred)", temp, ifs_fakeconsole )
		end, nil)

		--
		ff_AddCommand( "", nil, nil, nil)

		--works
		--allow a player to spawn as the hero for team 1
		ff_AddCommand( "Unlock Hero for Team 1", nil, function()
		    UnlockHeroForTeam(1)
		end, nil)

		--works
		--allow a player to spawn as the hero for team 2
		ff_AddCommand( "Unlock Hero for Team 2", nil, function()
		    UnlockHeroForTeam(2)
		end, nil)

		--works, unknown result
		--disable SP hero rules, not sure what this is
		ff_AddCommand( "Heros SP Rules Off", nil, function()
			ff_heroSPRules = 0
			DisableSPHeroRules()
		end, function()
			return ff_heroSPRules == 1
		end)
		
		--works, unknown result
		--enable SP hero rules, not sure what this is
		ff_AddCommand( "Hero SP Rules On", nil, function()
			ff_heroSPRules = 1
			EnableSPHeroRules()
		end, function()
			return ff_heroSPRules ~= 1
		end)

		--works, unknown result
		--disable SP scripted heros, not sure that this is
		ff_AddCommand( "Heros SP Scripted Off", nil, function()
			ff_heroSPScript = 0
			DisableSPScriptedHeroes()
		end, function()
			return ff_heroSPScript == 1
		end)

		--works, unknown result
		--enable SP scripted heros, not sure what this is
		ff_AddCommand( "Heros SP Scripted On", nil, function()
			ff_heroSPScript = 1
			EnableSPScriptedHeroes()
		end, function()
			return ff_heroSPScript ~= 1
		end)

		--
		ff_AddCommand( "", nil, nil, nil)
		
		--works
		--changes the reinforcement count of team 1
		ff_AddCommand( "Set Reinforcements 1", nil, function()
			local temp = function( rate )
				if not rate then return end
				SetReinforcementCount(1, rate )
			end
		
			ff_AskUser("Please enter the new reinforcement count for team 1", temp, ifs_fakeconsole )
		end, nil)

		--works
		--changes the reinforcement count of team 2
		ff_AddCommand( "Set Reinforcements 2", nil, function()
			local temp = function( rate )
				if not rate then return end
				SetReinforcementCount(2, rate )
			end
		
			ff_AskUser("Please enter the new reinforcement count for team 2", temp, ifs_fakeconsole )
		end, nil)

		--works
		--changes the team points of team 1
		ff_AddCommand( "Set Team Points 1", nil, function()
			local temp = function( rate )
				if not rate then return end
				SetTeamPoints(1, rate )
			end
		
			ff_AskUser("Please enter the new team points for team 1", temp, ifs_fakeconsole )
		end, nil)

		--works
		--changes the team points of team 2
		ff_AddCommand( "Set Team Points 2", nil, function()
			local temp = function( rate )
				if not rate then return end
				SetTeamPoints(2, rate )
			end
		
			ff_AskUser("Please enter the new team points for team 2", temp, ifs_fakeconsole )
		end, nil)
		
		--works, not exactly sure what it does
		--think it changes the amount of allowed spawned units on team 1
		ff_AddCommand( "Add Units to Team 1", nil, function()
			local temp = function( rate )
				if not rate then return end
				SetUnitCount(1, GetUnitCount(1) + rate)
			end
			
			ff_AskUser("Please enter the amount of units to add to team 1 (negative numbers allowed)", temp, ifs_fakeconsole )
		end, nil)

		--works, not exactly sure what it does
		--think it changes the amount of allowed spawned units on team 2
		ff_AddCommand( "Add Units to Team 2", nil, function()
			local temp = function( rate )
				if not rate then return end
				SetUnitCount(2, GetUnitCount(2) + rate)
			end
			
			ff_AskUser("Please enter the amount of units to add to team 1 (negative numbers allowed)", temp, ifs_fakeconsole )
		end, nil)

		--
		ff_AddCommand( "", nil, nil, nil)

		--works
	    --makes blaster weapons do more damage
		ff_AddCommand( "Bonus 1 Enhanced Blasters", nil, function()
		    ActivateBonus(1, "team_bonus_advanced_blasters")
		end, nil)

		--works
	    --adds a health regen for all units on team 1
		ff_AddCommand( "Bonus 1 Bacta Tanks", nil, function()
		    ActivateBonus(1, "team_bonus_bacta_tanks")
		end, nil)

		--works
	    --increases the health of all units on team 1
		ff_AddCommand( "Bonus 1 Combat Shielding", nil, function()
		    ActivateBonus(1, "team_bonus_combat_shielding")
		end, nil)

		--works
	    --adds a energy regen for all units on team 1
		ff_AddCommand( "Bonus 1 Energy Boost", nil, function()
		    ActivateBonus(1, "team_bonus_energy_boost")
		end, nil)

		--works
	    --adds extra reinforcements to team 1
		ff_AddCommand( "Bonus 1 Garrison", nil, function()
		    ActivateBonus(1, "team_bonus_garrison")
		end, nil)

		--works, test with no hero defined
	    --unlocks the hero for team 1
		ff_AddCommand( "Bonus 1 Leader", nil, function()
		    ActivateBonus(1, "team_bonus_leader")
		end, nil)

		--works
	    --causes the vehicles of team 2 to spawn damaged
		ff_AddCommand( "Bonus 1 Sabotage", nil, function()
		    ActivateBonus(1, "team_bonus_sabotage")
		end, nil)

		--works
	    --makes blaster weapons do more damage
		ff_AddCommand( "Bonus 2 Enhanced Blasters", nil, function()
		    ActivateBonus(2, "team_bonus_advanced_blasters")
		end, nil)

		--works
	    --adds a health regen for all units on team 2
		ff_AddCommand( "Bonus 2 Bacta Tanks", nil, function()
		    ActivateBonus(2, "team_bonus_bacta_tanks")
		end, nil)

		--works
	    --increases the health of all units on team 2
		ff_AddCommand( "Bonus 2 Combat Shielding", nil, function()
		    ActivateBonus(2, "team_bonus_combat_shielding")
		end, nil)

		--works
	    --adds a energy regen for all units on team 2
		ff_AddCommand( "Bonus 2 Energy Boost", nil, function()
		    ActivateBonus(2, "team_bonus_energy_boost")
		end, nil)

		--works
	    --adds extra reinforcements to team 2
		ff_AddCommand( "Bonus 2 Garrison", nil, function()
		    ActivateBonus(2, "team_bonus_garrison")
		end, nil)

		--works, test with no hero defined
	    --unlocks the hero for team 2
		ff_AddCommand( "Bonus 2 Leader", nil, function()
		    ActivateBonus(2, "team_bonus_leader")
		end, nil)

		--works
	    --causes the vehicles of team 1 to spawn damaged
		ff_AddCommand( "Bonus 2 Sabotage", nil, function()
		    ActivateBonus(2, "team_bonus_sabotage")
		end, nil)

		--
		ff_AddCommand( "", nil, nil, nil)

		--
		--these commands only work for your screen, they do not effect anyone else
		ff_AddCommand( "[Your Screen Only]", nil, nil, nil)

		--works
		--changes the units' field of view
		ff_AddCommand( "Change Field Of View", nil, function()
			local temp = function( rate )
				if not rate then return end
		        local properties = {
		            { name = "FirstPersonFOV", value = rate },
		            { name = "ThirdPersonFOV", value = rate },
		        }
				uf_changeClassProperties( uf_classes, properties )
			end
			
			ff_AskUser("Please enter the new 'field of view' angle", temp, ifs_fakeconsole )
		end, nil)

		--works
		--turns off the gui 'click' sounds?
		ff_AddCommand( "Menu Sounds Off", nil, function()
			ff_menuSounds = 0
			ScriptCB_SoundDisable()
		end, function()
			return ff_menuSounds == 1
		end)

		--works
		--turns on the gui 'click' sounds?
		ff_AddCommand( "Menu Sounds On", nil, function()
			ff_menuSounds = 1
			ScriptCB_SoundEnable()
		end, function()
			return ff_menuSounds ~= 1
		end)

		--works
		--causes units to die normally
		ff_AddCommand( "No Flee Just Die", nil, function()
            ff_fleeLikeHeros = 0
		    local properties = {
                { name = "FleeLikeAHero", value = "0" },
            }
			uf_changeClassProperties( uf_classes, properties )
		end, function()
			return ff_fleeLikeHeros == 1
		end)

		--works
		--causes units to die like heros
		ff_AddCommand( "Flee Like Heros", nil, function()
			ff_fleeLikeHeros = 1
		    local properties = {
                { name = "FleeLikeAHero", value = "1" },
            }
			uf_changeClassProperties( uf_classes, properties )
		end, function()
			return ff_fleeLikeHeros ~= 1
		end)

		--works
		--removes the required points to spawn as the unit
		ff_AddCommand( "Remove Point Limits", nil, function()
			ff_removedPointLimiets = 1
            local properties = {
                { name = "PointsToUnlock", value = "0" },
            }
			uf_changeClassProperties( uf_classes, properties )
		end, function()
			return ff_removedPointLimits ~= 1
		end)

		--works
		--removes the buff graphical effects by blanking them out
		ff_AddCommand( "Remove Award Effects", nil, function()
			ff_CommandRemoveAwardEffects()
		end, function()
			return ff_awardEffectsOn == 1
		end)

		--works
		--restores the retail buff graphical effects
		ff_AddCommand( "Restore Award Effects", nil, function()
			ff_awardEffectsOn = 1
			local properties = {
			    { name = "BuffHealthEffect",  value = "com_sfx_buffed_regen" },
			    { name = "BuffOffenseEffect", value = "com_sfx_buffed_offense" },
			    { name = "BuffDefenseEffect", value = "com_sfx_buffed_defense" },
			}
			uf_changeClassProperties( uf_classes, properties )
		end, function()
			return ff_awardEffectsOn ~= 1
		end)

		--works
		--attempts to hide the mini map
		ff_AddCommand( "Disable Small MiniMap", nil, function()
            DisableSmallMapMiniMap()
		end, nil)

		--
		ff_AddCommand( "", nil, nil, nil)


		--these are mostly left over, and slightly untested commands from the first FakeConsole mod
		ff_AddCommand( "[Old Commands]", nil, nil, nil)

		--works
		--makes team 1 win the round
		ff_AddCommand( "Victory - Team 1", nil, function()
			MissionVictory(1)
		end, function() return ff_allowVictory == 1 end)

		--works
		--makes team 2 win the round
		ff_AddCommand( "Victory - Team 2", nil, function()
			MissionVictory(2)
		end, function() return ff_allowVictory == 1 end)

		--works
		--makes both teams 1 and 2 win the round
		ff_AddCommand( "Victory - Teams 1+2", nil, function()
			MissionVictory( {1, 2} )
		end, function() return ff_allowVictory == 1 end)

		--untested
		--makes calls to MissionVictory() be ignored
		ff_AddCommand( "Prevent Victory", nil, function()
			ff_CommandPreventVictory()
		end, function() return ff_allowVictory == 1 end)

		--untested
		--allows calls to MissionVictory()
		ff_AddCommand( "Allow Victory", nil, function()
			ff_CommandAllowVictory()
		end, function() return ff_allowVictory ~= 1 end)


		--works
		--disable AI AutoBalance
		ff_AddCommand( "AI AutoBalance Off", nil, function()
			ff_autoBalance = 0
		    DisableAIAutoBalance()
		end, function()
			return ff_autoBalance == 1
		end)

		--works
		--enable AI AutoBalance
		ff_AddCommand( "AI AutoBalance On", nil, function()
			ff_autoBalance = 1
		    EnableAIAutoBalance()
		end, function()
			return ff_autoBalance ~= 1
		end)

		--works
		--prevent AI form doing blind jet jumps
		ff_AddCommand( "AI BlindJetJumps Off", nil, function()
			ff_blindJumps = 0
			SetAllowBlindJetJumps(0)
		end, function()
			return ff_blindJumps == 1
		end)

		--works
		--allow AI to do blind jet jumps
		ff_AddCommand( "AI BlindJetJumps On", nil, function()
			ff_blindJumps = 1
			SetAllowBlindJetJumps(1)
		end, function()
			return ff_blindJumps ~= 1
		end)

		--
		ff_AddCommand( "", nil, nil, nil)
		
		--works
		--changes hud for normal play
		ff_AddCommand( "FlagGamePlayType None", nil, function()
			SetFlagGameplayType("none")
		end, nil)

		--works
		--changes hud for 1-flag mode
		ff_AddCommand( "FlagGamePlayType 1-Flag", nil, function()
			SetFlagGameplayType("1flag")
		end, nil)

		--works
		--changes hud for 2-flag mode
		ff_AddCommand( "FlagGamePlayType 2-Flag", nil, function()
			SetFlagGameplayType("2flag")
		end, nil)

		--works
		--changes hud for campaign mode
		ff_AddCommand( "FlagGamePlayType Campaign", nil, function()
			SetFlagGameplayType("campaign")
		end, nil)

		--
		ff_AddCommand( "", nil, nil, nil)

		--works
		--don't display team points for both teams 1 and 2
		ff_AddCommand( "Hide Team Points", nil, function()
			ff_displayTeamPoints = 0
			ShowTeamPoints(1, false)
			ShowTeamPoints(2, false)
		end, function()
			return ff_displayTeamPoints == 1
		end)

		--works
		--display team points for both teams 1 and 2
		ff_AddCommand( "Display team Points", nil, function()
			ff_displayTeamPoints = 1
			ShowTeamPoints(1, true)
			ShowTeamPoints(2, true)
		end, function()
			return ff_displayTeamPoints ~= 1
		end)

		--
		ff_AddCommand( "", nil, nil, nil)

		--works, but not sure what exactly it does
		--configures the game rules for MP (online, multiplayer) play
		ff_AddCommand( "Game Rules - MP", nil, function()
            ScriptCB_SetGameRules("mp")
		end, nil)

		--works, but not sure what exactly it does
		--configures the game rules for campaign play
		ff_AddCommand( "Game Rules - Campaign", nil, function()
            ScriptCB_SetGameRules("campaign")
		end, nil)

		--works, but not sure what exactly it does
		--configures the game rules for metagame (Galactic Conquest) play
		ff_AddCommand( "Game Rules - MetaGame", nil, function()
            ScriptCB_SetGameRules("metagame")
		end, nil)

		--works, but not sure what exactly it does
		--configures the game rules for instant action (single player, SP) play
		ff_AddCommand( "Game Rules - InstantAction", nil, function()
            ScriptCB_SetGameRules("instantaction")
		end, nil)

		--
		ff_AddCommand( "", nil, nil, nil)
		
		--works
		--move players from teams 1 and 2 to team 1
		ff_AddCommand( "Teams 1+2 to Team 1", nil, function()
			uf_moveToTeam({1, 2}, 1)
		end, nil)

		--works
		--move players from teams 1 and 2 to team 2
		ff_AddCommand( "Teams 1+2 to Team 2", nil, function()
			uf_moveToTeam({1, 2}, 2)
		end, nil)

		--works
		--move players from teams 1 and 2 to team 3
		ff_AddCommand( "Teams 1+2 to Team 3", nil, function()
			uf_moveToTeam({1, 2}, 3)
		end, nil)

		--
		ff_AddCommand( "", nil, nil, nil)

		--works
		--set teams 1 and 2 as friends
		ff_AddCommand( "Friends Team 1<>2", nil, function()
			SetTeamAsFriend(1, 2)
			SetTeamAsFriend(2, 1)
		end, nil)

		--works
		ff_AddCommand( "Friends Team 1<>3, 2<>3", nil, function()
			--set teams 1 and 3 as friends
			SetTeamAsFriend(1, 3)
			SetTeamAsFriend(3, 1)
			
			--set teams 2 and 3 as friends
			SetTeamAsFriend(2, 3)
			SetTeamAsFriend(3, 2)
		end, nil)

		--works
		--set teams 1, 2, and 3 to be friends of themselves
		ff_AddCommand( "Friends Team 1<>1, 2<>2, 3<>3", nil, function()
			SetTeamAsFriend(1, 1)
			SetTeamAsFriend(2, 2)
			SetTeamAsFriend(3, 3)
		end, nil)

		--works
		--set teams 1 and 2 as enemies
		ff_AddCommand( "Enemies Team 1<>2", nil, function()
		    SetTeamAsEnemy(1, 2)
		    SetTeamAsEnemy(2, 1)
		end, nil)

		--works
		ff_AddCommand( "Enemies Team 1<>3, 2<>3", nil, function()
			--set teams 1 and 3 as enemies
		    SetTeamAsEnemy(1, 3)
		    SetTeamAsEnemy(3, 1)

			--set teams 2 and 3 as enemies
		    SetTeamAsEnemy(2, 3)
		    SetTeamAsEnemy(3, 2)
		end, nil)

		--works
		--set teams 1, 2 and 3 to be Enemies of themselves
		ff_AddCommand( "Enemies Team 1<>1, 2<>2, 3<>3", nil, function()
			SetTeamAsEnemy(1, 1)
			SetTeamAsEnemy(2, 2)
			SetTeamAsEnemy(3, 3)
		end, nil)

		--
		ff_AddCommand( "", nil, nil, nil)
		
		--works
		--not sure what this is
		ff_AddCommand( "Snap Map Camera", nil, function()
			SnapMapCamera()
		end, nil)

		--works, but doesn't print out camera position
		--attempts to output the map's camera position to the error log
		ff_AddCommand( "Print Map Camera Position?", nil, function()
			local x, y, z = GetMapCameraPosition()
			print( "FakeConsole: Map Camera Position: X:", x )
			print( "FakeConsole: Map Camera Position: Y:", y )
			print( "FakeConsole: Map Camera Position: Z:", z )
		end, nil)

		--testing, don't really know what this does
		ff_AddCommand( "Unlock Campaign Unlockables?", nil, function()
			ScriptCB_UnlockUnlockable(0)
			ScriptCB_UnlockUnlockable(1)
			ScriptCB_UnlockUnlockable(2)
			ScriptCB_UnlockUnlockable(3)
			ScriptCB_UnlockUnlockable(4)
			ScriptCB_UnlockUnlockable(5)
			ScriptCB_UnlockUnlockable(6)
			ScriptCB_UnlockUnlockable(7)
			ScriptCB_UnlockUnlockable(8)
			ScriptCB_UnlockUnlockable(9)
			ScriptCB_UnlockUnlockable(10)
		end, nil)

		--
		ff_AddCommand( "", nil, nil, nil)

		--
		ff_AddCommand( "[Information]", nil, nil, nil)

		--test
		ff_AddCommand( "Print Globals", nil, function()
			uf_print(_G, false, 0)
		end, nil)

		--test
		ff_AddCommand( "Print Globals Nested", nil, function()
			uf_print(_G, true, 0)
		end, nil)


		--
		ff_AddCommand( "", nil, nil, nil)

		--these commands cause crashes in MP
		ff_AddCommand( "[Online Crashing]", nil, nil, nil)

		--works
		--adds an autoturret to the all the CPs of team 1
		ff_AddCommand( "Bonus 1 Auto Turrets", nil, function()
			--let players know not to join this server
			ff_serverDoesCrash()

		    ActivateBonus(1, "team_bonus_autoturrets")
		end, nil)

		--works
		--increases the ammo count for all units on team 1
		ff_AddCommand( "Bonus 1 Supplies", nil, function()
			--let players know not to join this server
			ff_serverDoesCrash()
			
		    ActivateBonus(2, "team_bonus_supplies")
		end, nil)

		--works
		ff_AddCommand( "Bonus 2 Auto Turrets", nil, function()
			--let players know not to join this server
			ff_serverDoesCrash()

			ActivateBonus(2, "team_bonus_autoturrets")
		end, nil)

		--works
		ff_AddCommand( "Bonus 2 Supplies", nil, function()
			--let players know not to join this server
			ff_serverDoesCrash()

			ActivateBonus(2, "team_bonus_supplies")
		end, nil)

		--
		ff_AddCommand( "", nil, nil, nil)

		--works
		--prevent jumping
		ff_AddCommand( "No Jump", nil, function()
			--let players know not to join this server
			ff_serverDoesCrash()
			
			local properties = {
			    { name = "JumpHeight", 		value = "0" },
			    { name = "JumpFowardSpeedFactor", value = "0" },
			    { name = "JumpStrafeSpeedFactor", value = "0" },
			}
			uf_changeClassProperties( uf_classes, properties )
		end, nil)

		--works
		--causes units to jump really high
		ff_AddCommand( "High Jump", nil, function()
			--let players know not to join this server
			ff_serverDoesCrash()
			
			local properties = {
			    { name = "JumpHeight", 		value = "15.8" },
			    { name = "JumpFowardSpeedFactor", value = "8" },
			}
			uf_changeClassProperties( uf_classes, properties )
		end, nil)

		--works
		--prevents units with JetPacks from flying?
		ff_AddCommand( "Remove JetPacks", nil, function()
			--let players know not to join this server
			ff_serverDoesCrash()
			ff_addedJetPacks = 0

			local properties = {
				{ name = "ControlSpeed", value = "jet 0.01 0.01 0.01"},
			    { name = "JetJump", 		value = "0.1" },
			    { name = "JetPush", 		value = "0" },
			    { name = "JetAcceleration", value = "0" },
			    --{ name = "JetEffect", 		value = "0" },
			    { name = "JetType", 		value = "hover" },
			    { name = "JetFuelRechangeRate", value = "0" },
			    { name = "JetFuelCost", 	value = "50" },
			    { name = "JetFuelInitialCost", value = "50" },
			    { name = "JetFuelMinBorder", value = "50" },
			    
			    --{ name = "JetJump", 		value = "0.0" },
			    --{ name = "JetPush", 		value = "0.0" },
			    --{ name = "JetAcceleration", value = "0.0" },
			    --{ name = "JetEffect", 		value = "" },
			    --{ name = "JetType", 		value = "hover" },
			    --{ name = "JetFuelRechangeRate", value = "0.0" },
			    --{ name = "JetFuelCost", 	value = "10" },
			    --{ name = "JetFuelInitialCost", value = "10" },
			    --{ name = "JetFuelMinBorder", value = "0.0" },
			}
			uf_changeClassProperties( uf_classes, properties )
		end, function() return ff_addedJetPacks == 1 end)

		--works
		--attempts to set the weapon #'s ammo to unlimited
		ff_AddCommand( "Unlimited Ammo", nil, function()
			local temp = function( rate )
				if not rate then return end
		
				--let players know not to join this server
				ff_serverDoesCrash()
				
				local properties = {
				    { name = "WeaponAmmo"..rate,  value = "0" },
				}
				uf_changeClassProperties( uf_classes, properties )
			end
			
			ff_AskUser("Please enter the slot (1-8) of the weapon which should have unlimited ammo", temp, ifs_fakeconsole )
		end, nil)
---------------------------------------
---------------------------------------
--[[

--these commands still need discriptions:

AddCommand( "Bonus 1 Bacta Tanks", nil, function()
AddCommand( "Bonus 1 Bacta Tanks", nil, function()
AddCommand( "Bonus 1 Combat Shielding", nil, function()
AddCommand( "Bonus 1 Energy Boost", nil, function()
AddCommand( "Bonus 1 Garrison", nil, function()
AddCommand( "Bonus 1 Leader", nil, function()
AddCommand( "Bonus 1 Sabotage", nil, function()
AddCommand( "Bonus 2 Bacta Tanks", nil, function()
AddCommand( "Bonus 2 Bacta Tanks", nil, function()
AddCommand( "Bonus 2 Combat Shielding", nil, function()
AddCommand( "Bonus 2 Energy Boost", nil, function()
AddCommand( "Bonus 2 Garrison", nil, function()
AddCommand( "Bonus 2 Leader", nil, function()
AddCommand( "Bonus 2 Sabotage", nil, function()

---------------------------------------
--Templates:

		--
		ff_AddCommand( "", nil, nil, nil)

		--works
		ff_AddCommand( "", nil, function()

		end, nil)

		--works
		ff_AddCommand( "", nil, function()

		end, function()
			return
		end)
--]]
		
		
		
--[[	Popup Research:

		--
		ff_AddCommand( "Display Popup", nil, function()
		
			--{{
			--Popup_YesNo_Large.bBackVis = nil
			Popup_YesNo_Large.CurButton = "no" -- default
			Popup_YesNo_Large.fnDone = function( but )
				print("Zerted: Leaving custom popup:", but)
				IFObj_fnSetVis(this.listbox,1)
				Popup_YesNo_Large:fnActivate(nil)
				Popup_YesNo_Large.fnDone = nil
			end
			IFObj_fnSetVis(this.listbox,nil)
			Popup_YesNo_Large:fnActivate(1)
			gPopup_fnSetTitleStr(Popup_YesNo_Large, "Do you like me?")
			--}}
			
			--Popup_Prompt.bBackVis = nil
			Popup_Prompt.fnDone = function( value )
				value = value or "[value was nil]"
				print("ifs_fakeconsole: Leaving custom popup: ".. value)
				IFObj_fnSetVis(this.listbox,1)
				Popup_Prompt:fnActivate(nil)
				Popup_Prompt.fnDone = nil
			end

			IFObj_fnSetVis(this.listbox,nil)
			Popup_Prompt:fnActivate(1)
			gPopup_fnSetTitleStr(Popup_Prompt, "Please type something")

			--{{
			Popup_YesNo.CurButton = "no"
			Popup_YesNo.fnDone = function( but ) print("Zerted: Leaving custom popup") end
			Popup_YesNo.fnOnSuccess = function( but ) end
			Popup_YesNo:fnActivate(1)
			Popup_fnSetTitleStr(Popup_YesNo,"Testing Popups")
			--}}
			
			--IFObj_fnSetVis(Popup_YesNo, 1)
			--gPopup_YesNo_fnActivate(this,vis)
			--{{
			ifelm_shellscreen_fnPlaySound(this.exitSound)
			-- Shell is active. Must prompt before backing out of screen
			ifs_mp_lobby_fnShowHideItems(this,nil)
			
			Popup_YesNo.CurButton = "no" -- default
			Popup_YesNo.fnDone = ifs_mp_lobby_fnLeavePopupDone
			Popup_YesNo:fnActivate(1)
			if(this.bAmHost) then
				gPopup_fnSetTitleStr(Popup_YesNo,"ifs.onlinelobby.cancelsession")
			else
				gPopup_fnSetTitleStr(Popup_YesNo,"ifs.onlinelobby.leavesession")
			end
			ifs_mp_lobby_fnShowHideItems(this, nil)--}}
		end, nil)
--]]		
		
--done inserting FC commands into the list
--TODO call a method to allow modders to add in their own commands
-------------------------------------------------------------------------------
end

