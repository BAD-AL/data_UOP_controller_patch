--by [RDH]Zerted
print("ifs_era_handler - Entered")

-- List of missions presented to the user for IA/MP/splitscreen/etc.
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
-- }, -- ends a table entry
--
-- Below, things are in one-entry-per-line string.format to make it easier to
-- comment in/out maps by commenting in/out a single line


--------------------------------------------------------------------------------
-- Edit these tables to add custom game modes
--------------------------------------------------------------------------------
	local movieNameVar = "preview-loop"
	local movieFileVar = "MOVIES\\pre-movie"

	custom_sp_missionselect_listbox_contents = {
		-- In the below list, the first '%s' will be replaced by the era,
		-- and the second will be replaced by the multiplayer variant name
		-- (the part after "mode_")
	--  { mapluafile = "TEST1%s",   era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, },
		{ mapluafile = "cor1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_c_c = 1,   mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1, mode_eli_g = 1},
		{ mapluafile = "dag1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1,},
		{ mapluafile = "dea1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_c_g = 1,   mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1,},
		{ mapluafile = "end1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1,                            mode_con_g = 1, mode_hunt_g = 1, mode_1flag_g = 1, },
		{ mapluafile = "fel1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_c_c = 1,   mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1,},
		{ mapluafile = "geo1%s_%s", movieFile = movieFileVar, movieName = movieNameVar,            era_c = 1, mode_c_c = 1,   mode_con_c = 1, mode_ctf_c = 1, mode_hunt_c = 1, mode_xl_c = 1},
		{ mapluafile = "hot1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1,            mode_c_g = 1,   mode_con_g = 1, mode_1flag_g = 1, mode_hunt_g = 1, mode_xl_g = 1,1},
		{ mapluafile = "kam1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_c_c = 1,   mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1,},
		{ mapluafile = "kas2%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_c_c = 1,   mode_con_c = 1, mode_con_g = 1, mode_hunt_c = 1,  mode_ctf_c = 1, mode_ctf_g = 1, mode_xl_c = 1, mode_xl_g = 1,},
		{ mapluafile = "mus1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_c_c = 1,   mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1,},
		{ mapluafile = "myg1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_c_c = 1,   mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1,},
		{ mapluafile = "nab2%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_c_g = 1,   mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1, mode_hunt_c = 1,},
		{ mapluafile = "pol1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_c_g = 1,   mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1,},
		{ mapluafile = "spa1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1,            mode_c_g = 1,   mode_assault_g = 1, mode_1flag_g = 1,},
		{ mapluafile = "spa3%s_%s", movieFile = movieFileVar, movieName = movieNameVar,            era_c = 1, mode_c_c = 1,   mode_assault_c = 1, mode_1flag_c = 1,},
		{ mapluafile = "spa6%s_%s", movieFile = movieFileVar, movieName = movieNameVar,            era_c = 1, mode_assault_c = 1, mode_1flag_c = 1, },
		{ mapluafile = "spa7%s_%s", movieFile = movieFileVar, movieName = movieNameVar,            era_c = 1, mode_assault_c = 1, mode_1flag_c = 1, },
		{ mapluafile = "spa8%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1,            mode_assault_g = 1, mode_1flag_g = 1,},
		{ mapluafile = "spa9%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1,            mode_assault_g = 1, mode_1flag_g = 1,},
		{ mapluafile = "tan1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_c_g = 1,   mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1,},
		{ mapluafile = "tat2%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1, mode_hunt_g = 1, mode_eli_g = 1,},
		{ mapluafile = "tat3%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1,},
		{ mapluafile = "uta1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_c_c = 1,   mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1,},
		{ mapluafile = "yav1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_c_g = 1,   mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1,},
	    { mapluafile = "spa2%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_c = 1,            mode_c_c = 1, },
	    { mapluafile = "spa4%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1,            mode_c_g = 1, },
	}

	--Note: the MP map filter list is directly based off of this table (see missionselect_listbox_contents in ifs_mp_sessionlist)
	custom_mp_missionselect_listbox_contents = {
		-- In the below list, the first '%s' will be replaced by the era,
		-- and the second will be replaced by the multiplayer variant name
		-- (the part after "mode_")
	--  { mapluafile = "TEST1%s",   era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1,},
		{ mapluafile = "cor1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1,},
		{ mapluafile = "dag1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1,},
		{ mapluafile = "dea1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1, },
		{ mapluafile = "end1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1,                            mode_con_g = 1, mode_hunt_g = 1, mode_1flag_g = 1, },
		{ mapluafile = "fel1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1,},
		{ mapluafile = "geo1%s_%s", movieFile = movieFileVar, movieName = movieNameVar,            era_c = 1, mode_con_c = 1, mode_ctf_c = 1, mode_hunt_c = 1,},
		{ mapluafile = "hot1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1,            mode_con_g = 1, mode_1flag_g = 1, mode_hunt_g = 1,},
		{ mapluafile = "kam1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1,},
		{ mapluafile = "kas2%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, mode_hunt_c = 1, mode_ctf_c = 1, mode_ctf_g = 1,},
		{ mapluafile = "mus1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1,},
		{ mapluafile = "myg1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1,},
		{ mapluafile = "nab2%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1,mode_ctf_c = 1, mode_ctf_g = 1, mode_hunt_c = 1,},
		{ mapluafile = "pol1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1,},
		{ mapluafile = "spa1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1,            mode_assault_g = 1, mode_1flag_g = 1,},
		{ mapluafile = "spa3%s_%s", movieFile = movieFileVar, movieName = movieNameVar,            era_c = 1, mode_assault_c = 1, mode_1flag_c = 1,},
		{ mapluafile = "spa6%s_%s", movieFile = movieFileVar, movieName = movieNameVar,            era_c = 1, mode_assault_c = 1, mode_1flag_c = 1,},
		{ mapluafile = "spa7%s_%s", movieFile = movieFileVar, movieName = movieNameVar,            era_c = 1, mode_assault_c = 1, mode_1flag_c = 1,},
		{ mapluafile = "spa8%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1,            mode_assault_g = 1, mode_1flag_g = 1,},
		{ mapluafile = "spa9%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1,            mode_assault_g = 1, mode_1flag_g = 1,},
		{ mapluafile = "tan1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1,},
		{ mapluafile = "tat2%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1, mode_hunt_g = 1, mode_eli_g = 1,},
		{ mapluafile = "tat3%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1,},
		{ mapluafile = "uta1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1,},
		{ mapluafile = "yav1%s_%s", movieFile = movieFileVar, movieName = movieNameVar, era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1,},
	}


	-- Holds the list of map mode suffixes. They're concatanated onto
	-- "mode_" when expanding, etc.
	--Note: This table is autogenerated based off of custom_gModes
	custom_gMapModes = nil


	--Game modes in this table get converted to the following table with 'XXX' being
	-- replaced with the id's value.  Also, the default template can be overridden by
	-- providing a key/value pair for each overridden element:
	--	{
	--		key = "mode_XXX", showstr = "modename.name.XXX",
	--		descstr = "modename.description.XXX", subst = "XXX",
	--		icon = "mode_icon_XXX",
	--	},
	--Note: the converted table is stored in custom_gMapModes
	custom_gModes =	{
		{ id = "con", string="ifs.mp.leaderboard.conquest", },
		{ id = "ctf",   string="ifs.mp.leaderboard.CTF2", icon="mode_icon_2ctf", },
		{ id = "1flag", string="ifs.mp.leaderboard.CTF1", icon="mode_icon_ctf", },
		{ id = "ass", showstr="modename.name.spa-assault", descstr="modename.description.assault", key="mode_assault"  },
	  --{ id = "ass", showstr="modename.name.assault", descstr="modename.description.assault" },
	  --{ id = "assault", showstr="modename.name.assault", },
		{ id = "hunt", },
		{ id = "eli", showstr="modename.name.hero-assault", descstr="modename.description.elimination", string="modename.name.hero-assault" },
		{ id = "tdm", string="ifs.mp.leaderboard.teamdm", },
		{ id = "xl", },
		{ id = "obj", string="ifs.mp.leaderboard.objective", },
		{ id = "c", },
		{ id = "uber", },
		{ id = "bf1", },
		{ id = "holo", },
		{ id = "ord66", },
		{ id = "dm", },
		{ id = "space", },
		{ id = "c1", },
		{ id = "c2", },
		{ id = "c3", },
		{ id = "c4", },
		{ id = "hctf", },
		{ id = "vhcon", icon = "mode_icon_vehicle", },
		{ id = "vhtdm", icon = "mode_icon_vehicle", },
		{ id = "vhctf", icon = "mode_icon_vehicle", },
		{ id = "avh", },
		{ id = "lms", },
		{ id = "vh", icon = "mode_icon_vehicle", },
		{ id = "race", },
		{ id = "koh", },
		{ id = "tdf", },
		{ id = "surv", icon = "mode_icon_survival", },
		{ id = "rpg", },
		{ id = "wav", },
		{ id = "ctrl", icon = "mode_icon_control", },
		{ id = "seige", icon = "mode_icon_siege", },
		{ id = "siege", },
		{ id = "jhu", },
		{ id = "wea", },
		{ id = "ins", },
	}

	--Game modes in this table get converted to the following table with 'XXX' being
	-- replaced with the id's value.  Also, the default template can be overridden by
	-- providing a key/value pair for each overridden element:
	-- { string = "modename.name.XXX",	subst = "XXX",  icon = "mode_icon_XXX", },
	--Note: the converted table is stored in custom_mpsessionlist_gamemodelist_contents
	--Note: the first element of the table is hard codded inside the getter method
	custom_gModeList = custom_gModes

	--Server list game mode filters
	--Note: This table is automatically generated based off of custom_gModeList
	custom_mpsessionlist_gamemodelist_contents = nil


	--Game modes in this table get converted to the following table with 'XXX' being
	-- replaced with the id's value.  Also, the default template can be overridden by
	-- providing a key/value pair for each overridden element:
	-- { string = "modename.name.XXX",	key = "XXX", },
	--Note: the converted table is stored in custom_gBattleModes
	custom_gBattleModeList = custom_gModes

	--Galatic Conquest's Battle Mode game mode list
	--Note: This table is automatically generated based off of custom_gBattleModeList
	custom_gBattleModes = nil


--------------------------------------------------------------------------------
-- Random variables
--------------------------------------------------------------------------------
	
	custom_UnknownName1 = "mods.era.error.name1"
	custom_UnknownName2 = "mods.era.error.name2"
	custom_UnknownEraIcon1 = "imp_icon"
	custom_UnknownEraIcon2 = "imp_icon"
	custom_UnknownSideChar = "g"

	--TODO use these to wrap around any extra checkboxes
	custom_max_eras = 5
	custom_max_modes = 14 --12 fits in the container, but using 14.  14 stops right before overlapping with the era checkboxes

	--spacing between game mode checkbox containers
	custom_checkbox_spacing = 18

	--distance down for the starting location of the era checkboxes
	custom_location_era_y = 353


--------------------------------------------------------------------------------
-- Edit these tables to add custom eras
--------------------------------------------------------------------------------

	--Eras in this table get converted to the following table with 'X' being
	-- replaced with the id's value.  Also, the default template can be overridden by
	-- providing a key/value pair for each overridden element:
	--	{
	--		key = "era_X", showstr = "common.era.X", subst = "X"
	--      Team1Name = "common.sides.X.name", Team2Name="common.sides.X.name",
	--		icon1 = "X_icon", icon2 = "X_icon",
	--	},
	--Note: the converted table is stored in custom_gMapEras
	--Note: Team1Name, Team2Name, and icon1 might not be supported for custom eras... ask [RDH]Zerted for more details
	custom_gEras = {
		{ id = "c", showstr = "common.era.cw", Team1Name = "common.sides.rep.name", Team2Name = "common.sides.cis.name", icon1 = "cis_icon", icon2 = "rep_icon", },
		{ id = "g", showstr = "common.era.gcw", Team1Name = "common.sides.all.name", Team2Name = "common.sides.imp.name", icon1 = "imp_icon", icon2 = "all_icon", },
		{ id = "k", icon2 = "kotor_icon", },
		{ id = "n", icon2 = "newrep_icon", },
		{ id = "y", icon2 = "yuz_icon", },

		{ id = "a", icon2 = "bfx_cw_icon", },
		{ id = "b", icon2 = "bfx_gcw_icon", },
		{ id = "d", icon2 = "newsithwars_icon"},
		{ id = "e", icon2 = "earth_icon", },
		{ id = "f", icon2 = "front_icon", },
		{ id = "h", icon2 = "halo_icon"},
		{ id = "i", },
		{ id = "j", },
		{ id = "l", icon2 = "lego_icon", },
		{ id = "m", icon2 = "imp_icon", },
		{ id = "o", icon2 = "oldsith_icon", },
		{ id = "p", icon2 = "rep_icon", },
		{ id = "q", icon2 = "all_icon", },
		{ id = "r", icon2 = "rvb_icon", },
		{ id = "s", icon2 = "rebirth_icon", },
		{ id = "t", icon2 = "toys_icon", },
		{ id = "u", },
		{ id = "v", },
		{ id = "w", icon2 = "wacky_icon", },
		{ id = "x", icon2 = "exGCW_icon", },
		{ id = "z", },
		{ id = "1", icon2 = "cis_icon", },
		{ id = "2", icon2 = "imp_icon", },
	}

	-- These are a list of map era suffixes. They're concatanated onto
	-- "era_" when expanding, etc.?
	--Note: This table is automatically generated based off of custom_gEras
	custom_gMapEras = nil


	--Eras in this table get converted to the following table with 'X' being
	-- replaced with the id's value.  Also, the default template can be overridden by
	-- providing a key/value pair for each overridden element:
	-- { tag = "X",	string = "common.era.X", },
	--Note: the converted table is stored in custom_buttons
	--Note: 'subst' is mapped to 'tag' if 'tag' is nil
	--Note: 'showstr' is mapped to 'string' if 'string' is nil
	custom_gEraButtons = custom_gEras

	--Note: This table is automatically generated based off of custom_gEraButtons
	custom_buttons = nil


	--Eras in this table get converted to the following table with 'X' being
	-- replaced with the id's value.  Also, the default template can be overridden by
	-- providing a key/value pair for each overridden element:
	-- { key = "Selection.era_X",	char = "X", },
	--Note: the converted table is stored in custom_eras
	--Note: 'key' cannot be automatically overridden as its used in a different table with a different format
	custom_gEraSelection = custom_gEras

	--Note: This table is automatically generated based off of custom_gEraButtons
	custom_eras = nil
		
	--
	--
	--
	function custom_BuildEraList( this )
		local era_boxes = {
		  	--{ era =, key =, tag =, box =, bool =, SaveBox =, SetBool =,
		  	--{ era = "", key = "era_", tag = "check_era", box = this.Era__box, bool = this.bEra_, SaveBox = function(b) this.Era__box = b end, SetBool = function(b) this.bEra_ = b end, },

			--Note: only the first 5 (number in custom_max_eras) checkboxes will be displayed when multiple maps are selected
			{ era = "c", key = "era_c", tag = "check_era3", box = this.Era_C_box, bool = this.bEra_CloneWar, SaveBox = function(b) this.Era_C_box = b end, SetBool = function(b) this.bEra_CloneWar = b end, },
			{ era = "g", key = "era_g", tag = "check_era7", box = this.Era_G_box, bool = this.bEra_Galactic, SaveBox = function(b) this.Era_G_box = b end, SetBool = function(b) this.bEra_Galactic = b end, },
			{ era = "k", key = "era_k", tag = "check_era11", box = this.Era_K_box, bool = this.bEra_K, SaveBox = function(b) this.Era_K_box = b end, SetBool = function(b) this.bEra_K = b end, },
			{ era = "1", key = "era_1", tag = "check_era27", box = this.Era_1_box, bool = this.bEra_1, SaveBox = function(b) this.Era_1_box = b end, SetBool = function(b) this.bEra_1 = b end, },
			{ era = "2", key = "era_2", tag = "check_era28", box = this.Era_2_box, bool = this.bEra_2, SaveBox = function(b) this.Era_2_box = b end, SetBool = function(b) this.bEra_2 = b end, },

			{ era = "a", key = "era_a", tag = "check_era1", box = this.Era_A_box, bool = this.bEra_A, SaveBox = function(b) this.Era_A_box = b end, SetBool = function(b) this.bEra_A = b end, },
			{ era = "b", key = "era_b", tag = "check_era2", box = this.Era_B_box, bool = this.bEra_B, SaveBox = function(b) this.Era_B_box = b end, SetBool = function(b) this.bEra_B = b end, },
			{ era = "d", key = "era_d", tag = "check_era4", box = this.Era_D_box, bool = this.bEra_D, SaveBox = function(b) this.Era_D_box = b end, SetBool = function(b) this.bEra_D = b end, },
			{ era = "e", key = "era_e", tag = "check_era5", box = this.Era_E_box, bool = this.bEra_E, SaveBox = function(b) this.Era_E_box = b end, SetBool = function(b) this.bEra_E = b end, },
			{ era = "f", key = "era_f", tag = "check_era6", box = this.Era_F_box, bool = this.bEra_F, SaveBox = function(b) this.Era_F_box = b end, SetBool = function(b) this.bEra_F = b end, },
			{ era = "h", key = "era_h", tag = "check_era8", box = this.Era_H_box, bool = this.bEra_H, SaveBox = function(b) this.Era_H_box = b end, SetBool = function(b) this.bEra_H = b end, },
			{ era = "i", key = "era_i", tag = "check_era9", box = this.Era_I_box, bool = this.bEra_I, SaveBox = function(b) this.Era_I_box = b end, SetBool = function(b) this.bEra_I = b end, },
			{ era = "j", key = "era_j", tag = "check_era10", box = this.Era_J_box, bool = this.bEra_J, SaveBox = function(b) this.Era_J_box = b end, SetBool = function(b) this.bEra_J = b end, },
			{ era = "l", key = "era_l", tag = "check_era12", box = this.Era_L_box, bool = this.bEra_L, SaveBox = function(b) this.Era_L_box = b end, SetBool = function(b) this.bEra_L = b end, },
			{ era = "m", key = "era_m", tag = "check_era13", box = this.Era_M_box, bool = this.bEra_M, SaveBox = function(b) this.Era_M_box = b end, SetBool = function(b) this.bEra_M = b end, },
			{ era = "n", key = "era_n", tag = "check_era14", box = this.Era_N_box, bool = this.bEra_N, SaveBox = function(b) this.Era_N_box = b end, SetBool = function(b) this.bEra_N = b end, },
			{ era = "o", key = "era_o", tag = "check_era15", box = this.Era_O_box, bool = this.bEra_O, SaveBox = function(b) this.Era_O_box = b end, SetBool = function(b) this.bEra_O = b end, },
			{ era = "p", key = "era_p", tag = "check_era16", box = this.Era_P_box, bool = this.bEra_P, SaveBox = function(b) this.Era_P_box = b end, SetBool = function(b) this.bEra_P = b end, },
			{ era = "q", key = "era_q", tag = "check_era17", box = this.Era_Q_box, bool = this.bEra_Q, SaveBox = function(b) this.Era_Q_box = b end, SetBool = function(b) this.bEra_Q = b end, },
			{ era = "r", key = "era_r", tag = "check_era18", box = this.Era_R_box, bool = this.bEra_R, SaveBox = function(b) this.Era_R_box = b end, SetBool = function(b) this.bEra_R = b end, },
			{ era = "s", key = "era_s", tag = "check_era19", box = this.Era_S_box, bool = this.bEra_S, SaveBox = function(b) this.Era_S_box = b end, SetBool = function(b) this.bEra_S = b end, },
			{ era = "t", key = "era_t", tag = "check_era20", box = this.Era_T_box, bool = this.bEra_T, SaveBox = function(b) this.Era_T_box = b end, SetBool = function(b) this.bEra_T = b end, },
			{ era = "u", key = "era_u", tag = "check_era21", box = this.Era_U_box, bool = this.bEra_U, SaveBox = function(b) this.Era_U_box = b end, SetBool = function(b) this.bEra_U = b end, },
			{ era = "v", key = "era_v", tag = "check_era22", box = this.Era_V_box, bool = this.bEra_V, SaveBox = function(b) this.Era_V_box = b end, SetBool = function(b) this.bEra_V = b end, },
			{ era = "w", key = "era_w", tag = "check_era23", box = this.Era_W_box, bool = this.bEra_W, SaveBox = function(b) this.Era_W_box = b end, SetBool = function(b) this.bEra_W = b end, },
			{ era = "x", key = "era_x", tag = "check_era24", box = this.Era_X_box, bool = this.bEra_X, SaveBox = function(b) this.Era_X_box = b end, SetBool = function(b) this.bEra_X = b end, },
			{ era = "y", key = "era_y", tag = "check_era25", box = this.Era_Y_box, bool = this.bEra_Y, SaveBox = function(b) this.Era_Y_box = b end, SetBool = function(b) this.bEra_Y = b end, },
			{ era = "z", key = "era_z", tag = "check_era26", box = this.Era_Z_box, bool = this.bEra_Z, SaveBox = function(b) this.Era_Z_box = b end, SetBool = function(b) this.bEra_Z = b end, },
		}

		return era_boxes
	end
	
	
--------------------------------------------------------------------------------
-- Getters
--------------------------------------------------------------------------------
	
	--
	-- Gets the list of SP missions
	--
	function custom_GetSPMissionList()
		--print("custom_GetSPMissionList()")
	    return custom_sp_missionselect_listbox_contents
	end

	--
	-- Gets the list of MP missions
	--
	function custom_GetMPMissionList()
		--print("custom_GetMPMissionList()")
	    return custom_mp_missionselect_listbox_contents
	end
	
	--
	-- Generates the era button list if it is nil, but only once
	-- Note: this method might not even be ever called
	--
	function custom_BuildSelectionEraList( Selection )
		--print("custom_BuildSelectionEraList()")
				
		--if the era table hasn't been build yet, build it
		if custom_eras == nil then
			--print("custom_BuildSelectionEraList(): Building era selection table")
			
			--make sure we have something to build off of
			if custom_gEraSelection == nil then
				print("custom_BuildSelectionEraList(): Era ids are nil!")
				print("custom_BuildSelectionEraList(): Cannot build era selection table.  Expect further errors!")
				return {}
			end
			
			--for each era id, build a templated era
			custom_eras = {}
			local template = nil
		    for i=1,table.getn(custom_gEraSelection) do
		    	template = {}
		    	template.key = ("Selection.era_"..custom_gEraSelection[i].id)
		    	template.string = custom_gEraSelection[i].char	or (""..custom_gEraSelection[i].id)
		    	
		    	--save this new game mode
		    	table.insert(custom_eras, template)
		    	--print("custom_BuildSelectionEraList(): Generated era selection: " .. custom_eras[i].tag, "Known eras selections: " .. table.getn(custom_eras))
		    end
			
			--free up a bit of memory
			custom_gEraSelection = nil
			print("custom_BuildSelectionEraList(): Finished building era selection table", "Known eras selections: " .. table.getn(custom_eras))
		end
				
		return custom_eras	
	end
	
	--
	--
	-- Generates the era button list if it is nil, but only once
	--
	function custom_GetEraButtonList()
		--print("custom_EraButtonList()")
				
		--if the era table hasn't been build yet, build it
		if custom_buttons == nil then
			--print("custom_EraButtonList(): Building era button table")
			
			--make sure we have something to build off of
			if custom_gEraButtons == nil then
				print("custom_EraButtonList(): Era ids are nil!")
				print("custom_EraButtonList(): Cannot build era buttons.  Expect further errors!")
				return {}
			end
			
			--for each era id, build a templated era
			custom_buttons = {}
			local template = nil
		    for i=1,table.getn(custom_gEraButtons) do
		    	template = {}
		    	template.tag = custom_gEraButtons[i].tag 	   or custom_gEraButtons[i].subst	or (""..custom_gEraButtons[i].id)
		    	template.string = custom_gEraButtons[i].string or custom_gEraButtons[i].showstr	or ("common.era."..custom_gEraButtons[i].id)
		    	
		    	--save this new game mode
		    	table.insert(custom_buttons, template)
		    	--print("custom_EraButtonList(): Generated era button: " .. custom_buttons[i].tag, "Known eras buttons: " .. table.getn(custom_buttons))
		    end
			
			--free up a bit of memory
			custom_gEraButtons = nil
			print("custom_EraButtonList(): Finished building era button table", "Known eras buttons: " .. table.getn(custom_buttons))
		end
				
		return custom_buttons
	end
	
	--
	-- Gets the list of eras
	-- Generates the era list if it is nil, but only once
	--
	function custom_GetGMapEras()
		--print("custom_GetGMapEras()")
		
		--if the era table hasn't been build yet, build it
		if custom_gMapEras == nil then
			--print("custom_GetGMapEras(): Building era table")
			
			--make sure we have something to build off of
			if custom_gEras == nil then
				print("custom_GetGMapEras(): Era ids are nil!")
				print("custom_GetGMapEras(): Cannot build eras.  Expect further errors!")
				return {}
			end
			
			--for each era id, build a templated era
			custom_gMapEras = {}
			local template = nil
		    for i=1,table.getn(custom_gEras) do
		    	template = {}
		    	template.key = 		custom_gEras[i].key 	 or ("era_"..custom_gEras[i].id)
		    	template.showstr = 	custom_gEras[i].showstr or ("common.era."..custom_gEras[i].id)
		    	template.subst = 	custom_gEras[i].subst 	 or (""..custom_gEras[i].id)
		    	template.Team1Name = 	custom_gEras[i].Team1Name 	 or ("common.sides.".. custom_gEras[i].id ..".name")
		    	template.Team2Name = 	custom_gEras[i].Team2Name 	 or ("common.sides.".. custom_gEras[i].id ..".name")
		    	template.icon1 = 	custom_gEras[i].icon1 	 or (custom_gEras[i].id .."_icon")
		    	template.icon2 = 	custom_gEras[i].icon2 	 or (custom_gEras[i].id .."_icon")
		    	
		    	--save this new game mode
		    	table.insert(custom_gMapEras, template)
		    	--print("custom_GetGMapEras(): Generated era: " .. custom_gMapEras[i].subst, "Known eras: " .. table.getn(custom_gMapEras))
		    end
			
			--free up a bit of memory
			custom_gEras = nil
			print("custom_GetGMapEras(): Finished building era table", "Known eras: " .. table.getn(custom_gMapEras))
		end
				
	    return custom_gMapEras
	end
	
	--
	-- Gets the list of modes
	-- Generates the game mode list if it is nil, but only once
	--
	function custom_GetGMapModes()
		--print("custom_GetGMapModes()")
		
		--if the game mode table hasn't been build, build it
		if custom_gMapModes == nil then
			--print("custom_GetGMapModes(): Building game mode table")
			
			--make sure we have something to build off of
			if custom_gModes == nil then
				print("custom_GetGMapModes(): Game mode ids are nil!")
				print("custom_GetGMapModes(): Cannot build game modes.  Expect further errors!")
				return {}
			end
			
			--for each game mode id, build a templated game mode
			custom_gMapModes = {}
			local template = nil
		    for i=1,table.getn(custom_gModes) do
		    	template = {}
		    	template.key = 		custom_gModes[i].key 	 or ("mode_"..custom_gModes[i].id)
		    	template.showstr = 	custom_gModes[i].showstr or ("modename.name."..custom_gModes[i].id)
		    	template.descstr = 	custom_gModes[i].descstr or ("modename.description."..custom_gModes[i].id)
		    	template.subst = 	custom_gModes[i].subst 	 or (""..custom_gModes[i].id)
		    	template.icon = 	custom_gModes[i].icon 	 or ("mode_icon_"..custom_gModes[i].id)
		    	
		    	--save this new game mode
		    	table.insert(custom_gMapModes, template)
		    	--print("custom_GetGMapModes(): Generated game mode: " .. custom_gModes[i].id, "Known Modes: " .. table.getn(custom_gMapModes))
		    end
			
			--free up a bit of memory
			custom_gModes = nil
			print("custom_GetGMapModes(): Finished building game mode table", "Known Modes: " .. table.getn(custom_gMapModes))
		end
		
	    return custom_gMapModes
	end

	
	--
	-- Generates the game modes for use when picking the Galatic Conquest mode to fight in
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
	
	--
	-- Returns the icon1 texture, icon2 texture, icon1 visibility, icon2 visibility of the given side character
	--
	function custom_GetSideCharIconInfo( char )
		print("custom_GetSideCharIconInfo()")
	    local icon1_texture = custom_UnknownEraIcon1
	    local icon2_texture = custom_UnknownEraIcon2
	    local icon1_vis = nil
	    local icon2_vis = nil
	    local eras = custom_GetGMapEras()
	    
	    for i=1,table.getn(eras) do
	    	--look for the given era
	    	if eras[i].subst == char then
			    icon1_texture = eras[i].icon1
			    icon2_texture =	eras[i].icon2
			    icon1_vis = 1
			    icon2_vis = 1
				return icon1_texture, icon2_texture, icon1_vis, icon2_vis
	    	end
	    end

		--unknown side char
		return icon1_texture, icon2_texture, icon1_vis, icon2_vis
	end
	
	--
	-- Gets the second icon for the given era
	--
	function custom_GetIcon2FromEra( era )
		if (not era) then return custom_UnknownEraIcon2 end
		local eras = custom_GetGMapEras()
		
		--for each known era,
		for i=1,table.getn(eras) do
			--find the given era
			if eras[i].subst == era then
				return eras[i].icon2
			end
		end
		
		--unknown era
		return custom_UnknownEraIcon2
	end
	
	--
	-- Gets the display string for the given era
	--
	function custom_GetShowStringFromEra( era )
		if (not era) then return custom_UnknownName1 end
		local eras = custom_GetGMapEras()

		--for each known era,
		for i=1,table.getn(eras) do
			--find the given era
			if eras[i].subst == era then
				return eras[i].showstr
			end
		end
		
		--unknown era
		return custom_UnknownName1
	end
	
	--
	-- Returns the Team1 name, Team2 name, and Side character for the era with the given side character
	--
	function custom_GetTeamNamesFromEra( char )
		print("custom_GetTeamNamesFromEra()")
		local Team1Name = custom_UnknownName1
		local Team2Name = custom_UnknownName2
		local SideChar = custom_UnknownSideChar
		local eras = custom_GetGMapEras()

		for i=1,table.getn(eras) do
		   	--look for the given era
		   	if eras[i].subst == char then
				Team1Name = eras[i].Team1Name
				Team2Name =	eras[i].Team2Name
				SideChar = eras[i].subst
				return SideChar, Team1Name, Team2Name
		   	end
		end

		--unknown side char
		return SideChar, Team1Name, Team2Name
	end

	--
	--
	--Note: this method might not even be ever called
	--
	function custom_GetSides( Selection )
		print("custom_GetSides()")
		local bMultipleSides
		local LastSideChar = nil
		local i
		local eras = custom_BuildSelectionEraList( Selection )
		
		for i=1,table.getn(eras) do
		    if eras[i].key then
				bMultipleSides = (LastSideChar ~= nil)
				LastSideChar = eras[i].char
		    end
		end
		
		return bMultipleSides,LastSideChar
	end


	--
	-- Gets the mpsessionlist_gamemodelist_contents
	-- Generates the list if it is nil, but only once
	--
	function custom_GetMPGameModeList()
		--print("custom_GetMPGameModeList()")

		--if the game mode list table hasn't been build, build it
		if custom_mpsessionlist_gamemodelist_contents == nil then
			--print("custom_GetMPGameModeList(): Building game mode list table")

			--make sure we have something to build off of
			if custom_gModeList == nil then
				print("custom_GetMPGameModeList(): Game mode list ids are nil!")
				print("custom_GetMPGameModeList(): Cannot build game mode list.  Expect further errors!")
				return {}
			end

			--for each game mode id, build a templated game mode
			local template = nil
			custom_mpsessionlist_gamemodelist_contents = {}
		    for i=1,table.getn(custom_gModeList) do
		    	template = {}
		    	template.string = 	custom_gModeList[i].string		or ("modename.name."..custom_gModeList[i].id)
		    	template.subst = 	custom_gModeList[i].subst		or (""..custom_gModeList[i].id)
		    	template.icon = 	custom_gModeList[i].icon		or ("mode_icon_"..custom_gModeList[i].id)

		    	--save this new game mode
		    	table.insert(custom_mpsessionlist_gamemodelist_contents, template)
		    	--print("custom_GetMPGameModeList(): Generated game mode listing for: " .. custom_gModeList[i].id, "List Length: " .. table.getn(custom_mpsessionlist_gamemodelist_contents))
		    end

			--add in the element to display all game modes and make sure its the first element
			template = { string = "ifs.gsprofile.all", subst = "ifs.gsprofile.all", icon = nil, }
	    	table.insert(custom_mpsessionlist_gamemodelist_contents, 1, template)
	    	--print("custom_GetMPGameModeList(): Generated game mode listing for displaying all game modes", "List Length: " .. table.getn(custom_mpsessionlist_gamemodelist_contents))

			--free up a bit of memory
			custom_gModeList = nil
			print("custom_GetMPGameModeList(): Finished building game mode list table", "List Length: " .. table.getn(custom_mpsessionlist_gamemodelist_contents))
		end

		return custom_mpsessionlist_gamemodelist_contents
	end
	
	--
	-- Helps provide support to allow modders to override a game mode's name, description, and icon
	-- Used by the game mode checkboxes
	--
	function custom_UpdateGameModeFields( box, map, key, reset )
		--check input
		if not box then return end
		if (not map) and (reset ~= true) then return end
		if not key then return end

		local name = nil
		local icon = nil
		local about = nil
	
		--get the default values
		name = box.text.orgString
		icon = box.text.orgTexture
		
		--check for custom values
		if reset ~= true then
			if map.change ~= nil then
				if map.change[key] ~= nil then
					name = map.change[key].name or name
					icon = map.change[key].icon or icon
					about = map.change[key].about or about
				end
			end
		end
		
		--make the changes
		IFText_fnSetString( box.text, name )
		IFImage_fnSetTexture( box.icon, icon )
	end
	
	
	--
	-- Helps provide support to allow modders to override an era's name and icon
	-- Used by the era checkboxes
	--
	function custom_UpdateEraFields( box, map, key, reset )
		--check input
		if not box then return end
		if (not map) and (reset ~= true) then return end
		if not key then return end
		
		local name = nil
		local icon2 = nil
		
		--get the default values
		name = box.Text_Era.orgString
		icon2 = box.Icon2_Era.orgTexture
		
		--check for custom values
		if reset ~= true then
			if map.change ~= nil then
				if map.change[key] ~= nil then
					name = map.change[key].name or name
					icon2 = map.change[key].icon2 or icon2
				end
			end
		end
	
		--make the changes
		IFText_fnSetString( box.Text_Era, name )
		IFImage_fnSetTexture( box.Icon2_Era, icon2 )
	end
	
	--
	-- Helps provide support to allow modders to override a game mode's description
	--
	function custom_GetGameModeDescription( map, mode )
		--check input
		if not map then return "[No Map]" end
		if not mode then return "[No Mode]" end
		
		local key = mode.key
		local description = nil
		
		--get the default value
		description = mode.descstr
		
		--check for custom values
		if map.change ~= nil then
			if map.change[key] ~= nil then
				description = map.change[key].about or description
			end
		end
		
		return description
	end
	
	--
	-- Helps provide support to allow modders to override an era's and game mode's name
	-- Used by the info box to displayed the correct info of a PlayList map
	--
	function custom_getCustomEraAndModeNames( map )
		--check input
		if not map then return nil, nil end
		
		--get the tables
		local mode = missionlist_GetMapMode(map.Map)
		local era = missionlist_GetMapEra(map.Map)
		
		--get the default values
		local mName = ScriptCB_getlocalizestr(mode.showstr)
		local eName = era.showstr
		local modeUString = true
		--custom_printTable( mode )
		--custom_printTable( era )
		--custom_printTable( map )
		
		--check for custom values
		if map.change ~= nil then
			--check for custom eras
			if map.change[era.key] ~= nil then
				eName = map.change[era.key].name or eName
			end
			
			--check for custom modes
			if map.change[mode.key] ~= nil then
				mName = map.change[mode.key].name or mName
				modeUString = false
			end
		end
		
		return eName, mName, modeUString
	end

	--
	-- Helps provide support to allow modders to override an era's and game mode's icon
	-- Used by the PlayList to display the map's corrent icons 
	--
	function custom_GetCustomEraAndModeIcons( data )
		--check input
		if not data then return end
		
		--get the tables
		local mode = missionlist_GetMapMode(data.Map) or {}
		local era = missionlist_GetMapEra(data.Map) or {}
		local map = data
		
		--get the default values
		local mIcon = mode.icon
		local eIcon = era.icon2
		
		--check for custom values
		if map.change ~= nil then
			--check for custom eras
			if map.change[era.key] ~= nil then
				eIcon = map.change[era.key].icon2 or eIcon
			end
			
			--check for custom modes
			if map.change[mode.key] ~= nil then
				mIcon = map.change[mode.key].icon or mIcon
			end
		end
		
		return eIcon, mIcon
	end

--------------------------------------------------------------------------------
-- Utility functions
--------------------------------------------------------------------------------

	--
	-- Click an era or mode checkbox
	--
	function custom_ClickCheckButtons( this )
		--print("custom_ClickCheckButtons()")
		local i
		local era_boxes = custom_BuildEraList( this )
		
		--update the era checkbox
		for i=1,table.getn(era_boxes) do
		    if this.CurButton == era_boxes[i].tag then
				print("Checkbox for " .. era_boxes[i].tag .. " clicked")
		        if era_boxes[i].bool then
		            era_boxes[i].SetBool( nil )
					IFImage_fnSetTexture(era_boxes[i].box.Check_Era,"check_no")
		        else
		            era_boxes[i].SetBool( 1 )
					IFImage_fnSetTexture(era_boxes[i].box.Check_Era,"check_yes")
		        end
		        
		        --only one button can be current at a time
		        --  we found that button, so we are finished here
		        return
		    end
		end
		
		--current button wasn't for the era boxes, so look among the game mode boxes
		local i
		for i = 1, table.getn( this.mode_checkbox ) do
			if( this.CurButton == "check_mode"..i ) then
				if( this.mode_checkbox[i].bChecked ) then
					this.mode_checkbox[i].bChecked = nil
					IFImage_fnSetTexture(this.mode_checkbox[i].checkbox,"check_no")
				else
					this.mode_checkbox[i].bChecked = 1
					IFImage_fnSetTexture(this.mode_checkbox[i].checkbox,"check_yes")
				end
			end
		end
	end
	

	--
	-- Show/Hide the game mode checkboxes depending on if the selected maps support the game modes
	--
	function custom_ShowHideGameModesMulti( this )
		local i, j
	
		--for each know map,
		for i = 1, table.getn(missionselect_listbox_contents) do
	
		    --if the map is selected, then
			if( missionselect_listbox_contents[i].bSelected ) then
	
			    --get the list of game mode for this selected map
				local MapSelection = missionselect_listbox_contents[i]
				local MissionselectModes = missionlist_ExpandModelist(MapSelection.mapluafile)
	
				--for each game mode this map has,
				for j = 1, table.getn(MissionselectModes) do
	
				    --for each possible game mode,
					for k = 1, table.getn(this.mode_checkbox) do
	
					    --if this map has one of the known game modes,
						if this.mode_checkbox[k].key == MissionselectModes[j].key then
	
						    --display the game mode
							custom_UpdateGameModeFields( this.mode_checkbox[k], nil, this.mode_checkbox[k].key, true )	--added by [RDH]Zerted
							IFObj_fnSetVis(this.mode_checkbox[k], 1)
						end
					end
				end
			end
		end
	end
	
	--
	-- Show/Hide the game mode checkboxes depending on if the selected map supports that game mode
	--
	function custom_ShowHideGameModes( this )
		local i, j
		local number = ifs_missionselect_pcMulti_fnGetNumSelectedMaps( this )
		if( number > 1 ) then
			ifs_missionselect_pcMulti_fnShowHideGameModesMulti( this )
		else
	
			--for each game mode checkbox,
			for i = 1, table.getn(this.mode_checkbox) do
	
				--hide it
				IFObj_fnSetVis(this.mode_checkbox[i], nil)
	
				--for each game mode the selected map has,
				for j = 1, table.getn(gMissionselectModes) do
	
					--if the game mode is included in the selected map, make its checkbox visible
					if this.mode_checkbox[i].key == gMissionselectModes[j].key then

						--support for true custom game modes, added by [RDH]Zerted
						local box = this.mode_checkbox[i]
						local map = missionselect_listbox_contents[ifs_mspc_MapList_layout.SelectedIdx]
						local key = box.key
						local reset = false
						custom_UpdateGameModeFields( box, map, key, reset )	--added by [RDH]Zerted
	
						--print(" missionselect_listbox_contents[ifs_mspc_MapList_layout.SelectedIdx].mapluafile = ", missionlist_GetLocalizedMapName( missionselect_listbox_contents[ifs_mspc_MapList_layout.SelectedIdx].mapluafile ) )
						IFObj_fnSetVis(this.mode_checkbox[i], 1)
					end
				end
			end
		end
	
		-- reset position
		number = 0
		for i = 1, table.getn(this.mode_checkbox) do
			if( IFObj_fnGetVis(this.mode_checkbox[i] ) ) then
				-- reset position
				--by [RDH]Zerted, changed from 25 to 20 to custom_checkbox_spacing for smaller spaces between checkboxes
				IFObj_fnSetPos(this.mode_checkbox[i], this.mode_checkbox[i].x, this.mode_checkbox[1].y + custom_checkbox_spacing * number )
	
				--hide game modes that spill over into other display sections
				if number >= custom_max_modes then
						IFObj_fnSetVis(this.mode_checkbox[i], nil)
						print("custom_ShowHideGameModes(): Hiding game mode: ", this.mode_checkbox[i].key)
				end
	
				number = number + 1
			end
		end
	end
	
	--
	-- Show/Hide the era checkboxes depending on if the selected map supports that era
	--
	function custom_ShowHideEra( this )
		--print("custom_ShowHideEra()")
		local era_boxes = custom_BuildEraList( this )
		
		if( ifs_missionselect_pcMulti_fnGetNumSelectedMaps(this) > 1 ) then
		
		    --hide all the eras
	   		for i=1,table.getn(era_boxes) do
				IFObj_fnSetVis(era_boxes[i].box,nil)
			end
		
			--determine the amount of eras that can be displayed
		    local amount = table.getn(era_boxes)
		    if amount > custom_max_eras then
		    	amount = custom_max_eras
		    end

		    --if more then one map is selected, show all many eras as possible
			local i
	   		for i=1,amount do
				--support for true custom eras, added by [RDH]Zerted
				local box = era_boxes[i].box
				local map = nil
				local key = era_boxes[i].key
				local reset = true
				custom_UpdateEraFields( box, map, key, reset )
	   		
				IFObj_fnSetVis(era_boxes[i].box,1)
			end
			
		else
		    local i
		    local j
		    local k

		    --hide all the eras
	   		for i=1,table.getn(era_boxes) do
				IFObj_fnSetVis(era_boxes[i].box,nil)
			end
			
			--only show the eras that the selected map has
			for k=1,table.getn(gMissionselectEras) do
				local EraSelection = gMissionselectEras[k]

				if(not EraSelection.bIsWildcard) then
					local DisplayUStr = ScriptCB_getlocalizestr(EraSelection.showstr)

			   		for j=1,table.getn(era_boxes) do
			   		
			   		    if EraSelection.key == era_boxes[j].key then
							--support for true custom eras, added by [RDH]Zerted
							local box = era_boxes[j].box
							local map = missionselect_listbox_contents[ifs_mspc_MapList_layout.SelectedIdx]
							local key = era_boxes[j].key
							local reset = false
							custom_UpdateEraFields( box, map, key, reset )

			   		        --map has this era, so display its box
							IFObj_fnSetVis(era_boxes[j].box,1)
							--break
			   		    end
					end--end for(era_boxes)
				end
			end --end for(gMissionselectEras)
		end
		
		--make sure the visible era boxes are evenly spaced
		local container_x = 322
		local custom_y_offset_1 = 16
		
		local era_vis = 0
		local first_box = nil
		for i=1,table.getn(era_boxes) do
		   if IFObj_fnGetVis(era_boxes[i].box) then
				IFObj_fnSetPos( era_boxes[i].box, era_boxes[i].box.x, (custom_y_offset_1 * era_vis) + custom_location_era_y )
				--print("era_vis="..era_vis..", y="..(custom_y_offset_1 * era_vis) + container_y..", box="..era_boxes[i].key)
		        era_vis = era_vis + 1
		    end
		end
	end
	
	--
	-- Initilize the game modes and era checkboxes
	--
	function custom_InitModeEra( this )
		--print("custom_InitModeEra()")
		local era_boxes = custom_BuildEraList( this )

		-- init gamemodes, uncheck all
		local i
		for i = 1, table.getn( this.mode_checkbox ) do
			this.mode_checkbox[i].bChecked = nil
			IFImage_fnSetTexture(this.mode_checkbox[i].checkbox,"check_no")
		end

		-- init eras, unchecked all
		for i=1,table.getn(era_boxes) do
			era_boxes[i].bool = nil
			IFImage_fnSetTexture(era_boxes[i].Check_Era,"check_no")
		end
	end
	
	--
	-- Begins the sequence to add a map to the playlist
	--
	function custom_AddMapNew( this )
		print("custom_AddMapNew()")
		local era_boxes = custom_BuildEraList( this )
		local i
		local j
		
		--for each possible mission,
		for i = 1, table.getn(missionselect_listbox_contents) do
			--Note: there really should only be one selected mission?
			if( missionselect_listbox_contents[i].bSelected ) then
			
			    --get the selected map and mode
				local MapSelection = missionselect_listbox_contents[i]
				local ModeSelection = gMissionselectModes[ifs_mspc_ModeList_layout.SelectedIdx]

				--display what has been selected
				custom_printTable( MapSelection )
				custom_printTable( ModeSelection )
				
				--if the map has a mission and the mission's era box is visible, add the mission?
				for j=1,table.getn(era_boxes) do
				    if era_boxes[j].bool and IFObj_fnGetVis(era_boxes[j].box) then
						ifs_missionselect_pcMulti_fnAddMap1(this, MapSelection, ModeSelection, era_boxes[j].key)
				    end
				end
			end
		end

		ListManager_fnFillContents(this.PlayListbox,gPickedMapList,ifs_mspc_PlayList_layout)
	end
	
	--
	-- Create the era check boxes
	--
	function custom_AddEraBoxes( this )
		--print("custom_AddEraBoxes()")
		
		local ColumnWidthR = 220
		local TopBoxHeight = 30 -- enough for two lines of text

		local icon_x = 27 + 2--9
		local icon_y = 18 + 2 + 1
		local icon_height = 18 - 2 - 2
		local icon_era_offset_y = 45

		local era_text_offset_x = 50
		local era_text_offset_y = 15

		local era_check_offset_x = 10
		local era_check_offset_y = 22
		local era_zpos = 180

		local era_hotspot_width = 150
		
		local custom_halign = "left"
		local custom_valign = "vcenter"
		local custom_font = "gamefont_super_tiny"
		local custom_texture = "check_no"
		local custom_ScreenRelativeX = 0	--left side of screen
		local custom_ScreenRelativeY = 0	--top
		local custom_eighty = 80

		--Note: need to create all the checkboxes on top of each other, as the
		--	SetPos function only seems ot offset the container and not directly movie it
		local custom_y_offset_1 = 0--7	--for container?
		local custom_y_offset_2 = 0--14--11	--for check box?
		local custom_y_offset_3 = 0--14--11	--for text?
		local custom_icon_offset_1 = 0--14

		--local container_y = 335 --now custom_location_era_y
		local container_x = 322		
		
		local era_boxes = custom_BuildEraList( this )

		--make the era check boxes
		local i
		for i=1,table.getn(era_boxes) do
		    --create the container
		    era_boxes[i].box = NewIFContainer {
				ScreenRelativeX = custom_ScreenRelativeX,
				ScreenRelativeY = custom_ScreenRelativeY,
				x = container_x,
				y = (custom_y_offset_1 * (i-1)) + custom_location_era_y, -- top-justify against left box
				ZPos = era_zpos,

				Check_Era = NewIFImage {
					x = era_check_offset_x,
					y = era_check_offset_y + (custom_y_offset_2 * (i-1)),
					texture = custom_texture,
					localpos_l = 1,
					localpos_t = 1,
					localpos_r = 14,
					localpos_b = 14,
					AutoHotspot = 1,
					tag = era_boxes[i].tag,
					bIsFlashObj = 1,
					flash_alpha = 1.0,
					hotspot_width = era_hotspot_width,
				},

				Text_Era = NewIFText {
					x = era_text_offset_x,
					y = era_text_offset_y + (custom_y_offset_3 * (i-1)),
					halign = custom_halign,
					valign = custom_valign,
					font = custom_font,
					textw = ColumnWidthR - custom_eighty,
					texth = TopBoxHeight,
					startdelay=math.random()*0.5,
					nocreatebackground=1,
					orgString = custom_GetShowStringFromEra( era_boxes[i].era ), --for easier custom era name support, added by [RDH]Zerted
					string = custom_GetShowStringFromEra( era_boxes[i].era ),
				},

				Icon2_Era = NewIFImage {
					localpos_l = icon_x,
					localpos_r = icon_x + icon_height,
					localpos_t = (custom_icon_offset_1 * (i-1)) + icon_y,
					localpos_b = (custom_icon_offset_1 * (i-1)) + icon_y + icon_height,
					orgTexture = custom_GetIcon2FromEra( era_boxes[i].era ), --for easier custom era icon support, added by [RDH]Zerted
					texture = custom_GetIcon2FromEra( era_boxes[i].era ),
				}
			}
			
			--make sure to save the container
			era_boxes[i].SaveBox( era_boxes[i].box )
			--print("tag="..era_boxes[i].tag..", y="..era_boxes[i].box.y..", era="..era_boxes[i].era)
		end

		--print("custom_AddEraBoxes(): Returning")
	end
	
	--
	-- Changes the movie file and attempt to start it
	--
	function custom_CheckChangeMovies( this, fDt )
		this.movieTime = this.movieTime - fDt
		if( this.movieName and this.movieTime<=0 ) then
			--print("")
			print("custom_CheckChangeMovies(): Update(): Time to change movies")

			ifs_missionselect_pcMulti_ChangeMovieFile(this.movieFile)
    		--ifelem_shellscreen_fnStartMovie(this.movieName,
			--								-1,--nil,--1,
			--								nil,
			--								nil, --2,--1,--nil,
			--								this.movieX,--375,
			--								this.movieY,--22,
			--								this.movieW,--150,
			--								this.movieH--150
			--								)
			ifelem_shellscreen_fnStartMovie(this.movieName,1, nil, true)
		    this.movieName = nil;

			--print("custom_CheckChangeMovies(): Update(): Finished changing movies")
			--print("custom_CheckChangeMovies(): Fixing mouse...")
			ScriptCB_EnableCursor(nil)
			ScriptCB_EnableCursor(1)
			--print("custom_CheckChangeMovies(): Mouse fixed")
			--print("")
		end
	
--[[	Old code for movie's tied with the map name
		this.movieTime = this.movieTime - fDt
		if( this.movieName and this.movieTime<=0 ) then
			print("")
			print("custom_CheckChangeMovies(): Update(): Time to change movies")

			ifs_missionselect_pcMulti_ChangeMovieFile(this.movieFile)
    		ifelem_shellscreen_fnStartMovie(this.movieName.."fly",
											-1,--nil,--1,
											nil,
											nil, --2,--1,--nil,
											this.movieX,--375,
											this.movieY,--22,
											this.movieW,--150,
											this.movieH--150
											)
											--[-[
			ifelem_shellscreen_fnStartMovie(movieName.."fly",
											loop,
											nextMovieName,
											fullscreen,
											left,
											top,
											width,
											height
											)
											--]-]
		    this.movieName = nil;

			print("custom_CheckChangeMovies(): Update(): Finished changing movies")
			print("custom_CheckChangeMovies(): Fixing mouse...")
			ScriptCB_EnableCursor(nil)
			ScriptCB_EnableCursor(1)
			print("custom_CheckChangeMovies(): Mouse fixed")
			print("")
		end
--]]
		
	    --[[
   		--time to change movies?
		this.movieTime = this.movieTime - fDt
		if( this.movieName and this.movieTime<=0 ) then
			print("play movie", this.movieName, " ", this.movieX, ",", this.movieY, " ", this.movieW, "x", this.movieH);
			ifs_missionselect_ChangeMovieFile(this.movieFile)
    		ifelem_shellscreen_fnStartMovie(this.movieName.."fly", 1, nil, nil, this.movieX,this.movieY,this.movieW,this.movieH)
		    this.movieName = nil;
		end
	    --]]
	end
	
	--
	--
	--
	function custom_AddCheatBox( this )
		-- cheat bits
		local cheatBoxY = 400
		local cheatBoxX = 30
		local cheatBoxW = 121
		local cheatBoxH = 77

		this.cheatOutput = NewIFText {
				x = cheatBoxX-28,
				y = cheatBoxY+40,
				halign = "left", valign = "vcenter",
				font = "gamefont_small",
				textw = 120, texth = 90,
				font = "gamefont_tiny",
				nocreatebackground=1,
				string = "",
		}

		this.cheatBox = NewEditbox {
				ScreenRelativeX = 0,
				ScreenRelativeY = 0,
				y = cheatBoxY,
				x = cheatBoxX,

				width = cheatBoxW,
				height = cheatBoxH,
				font = "gamefont_tiny",
				--		string = "Player 1",
				MaxLen = nil,
				MaxChars = 60,
				bKeepsFocus = nil,
				bSilentAndInvisible = 1,
				bClearOnHilightChange = 1,
				noChangeSound = 1,
				bIsTheCheatBox = 1,
		}
		
		--[[Note: this is more of the flyby movie border than a border for the cheat box
		this.cheatBorder = NewButtonWindow {
			ZPos = 250,
			ScreenRelativeX = 0, -- left side of screen
			ScreenRelativeY = 0, -- top
			x = 57,
			y = 420,
			width = 160,
			height = 160,
			--titleText = "ifs.missionselect.playlist",
			font = "gamefont_small"
		}]]
	end
	
	--
	-- Processes custom cheat commands
	--
	function custom_ExtraCheats( code )
		print("custom_ExtraCheats(): Given code: "..code)
		--TODO come up with other shell 'cheat' ideas
		--hide movies
		--reset map colors
		--full screen movies
		--change era and game mode displays?
	
	    if( string.find(code, "name: ") ) then
			--change the user's ingame net name
			local name = string.gsub(code, "name: ", "")
			ScriptCB_SetNetLoginName(ScriptCB_tounicode(name))
			print("Set Name To '" .. name .."'")
			return "Set Name To '" .. name .."'"
	    elseif string.find(code, "print: ") then
			local output = string.gsub(code, "print: ", "")

			print(output)
			return output
		end

		print("custom_ExtraCheats(): Code not handled ")
		return nil
	end
	
--------------------------------------------------------------------------------
-- Setters
--------------------------------------------------------------------------------

	--
	-- Sets the movie positions for the given screen
	--
	function custom_SetMovieLocation( this )
	    print("custom_SetMovieLocation()")
		local wScreen,hScreen,vScreen,widescreen = ScriptCB_GetScreenInfo()
		--this.backImg.localpos_r = wScreen*widescreen
		--this.backImg.localpos_b = hScreen
		--this.backImg.uvs_b = vScreen

		--calc the position of the movie preview window
		--this.movieW = 510.0
		--this.movieH = 400.0
		--this.movieX = wScreen - 600.0
		--this.movieY = hScreen - this.movieH + 100.0
		this.movieW = 150
		this.movieH = 150
		this.movieX = 375
		this.movieY = 22
	end

	--
	--
	--
	function custom_SetEraBooleans( this, bool )
		local era_boxes = custom_BuildEraList( this )
		local i
		
		--for each era, set its bool to the given bool
		for i=1,table.getn(era_boxes) do
			era_boxes[i].SetBool( bool )
		end
	end

	--
	-- Sets the SP mission list
	--
	function custom_SetSPMissionList( list )
	    custom_sp_missionselect_listbox_contents = list
	end

	--
	-- Sets the MP mission list
	--
	function custom_SetMPMissionList( list )
	    custom_mp_missionselect_listbox_contents = list
	end

--------------------------------------------------------------------------------
-- Completely new functions
--------------------------------------------------------------------------------

	--
	-- Outputs the given lua table.  Attempts formating of any mapluafiles for crash-proof outputting
	--
	function custom_printTable( data )
		if (not data) then return end	--must have something to print
		print("custom_printTable():", data)
	
		--for each pair in the table, 
		local map = ""
		for k,v in pairs(data) do
			
			--make sure not to print nil values
			if k == nil then
				if v == nil then
					print("Both the key and value are nil")
				else
					print("The key is nil, the value is:", v)
				end
			else
				if v == nil then
					print("The value is nil, the key is:", k)
				else
					if k ~= "mapluafile" then
						print("The key, value is:", k,v)
					else
						map = string.format(v, "<A>", "<B>")
						print("The key is " .. k .. ", the formated value is:", map)
					end
				end
			end
		end
		print("custom_printTable(): Returning")
 	end

-------------------------------------------------------------------------------
-- The following functions deal addnig support for custom Galatic Conquest
-------------------------------------------------------------------------------
 
 function custom_GetGCButtonList()
 	print("custom_GetGCButtonList()")
	return {
		{ tag = "1", string = "ifs.meta.Configs.1", },
		{ tag = "2", string = "ifs.meta.Configs.2", },
		{ tag = "3", string = "ifs.meta.Configs.3", },
		{ tag = "4", string = "ifs.meta.Configs.4", },
		-- no splitscreen on PC
		{ tag = "custom", string = "ifs.meta.Configs.custom", }, --re-enabled, by [RDH]Zerted
		{ tag = "load", string = "ifs.meta.load.btnload", },
	}
end

function custom_PressedGCButton( tag )
 	print("custom_PressedGCButton()")
 	
	--if we didn't handle this, return false
	return false
end

-------------------------------------------------------------------------------
-- 
-------------------------------------------------------------------------------


--[[
Found stuff that may be useful


 -- Pass #1: try and find it in localize DB
    for i = 0,(l2-1) do
        local TrimmedStr = string.sub(abbrev, 1, l2 - i)
        local DisplayUStr = ScriptCB_getlocalizestr("mapname.name."..TrimmedStr, 1) -- 2nd param: return nil if not found
        if(DisplayUStr) then
            print("Got left name!",string.sub(abbrev,l2+1))
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


--]]

print("ifs_era_handler - Exited")
