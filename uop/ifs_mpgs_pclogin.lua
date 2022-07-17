-- ifs_mpgs_pclogin.lua
-- Zerted 1.3 uop (r130)
--
-- Recovered with the help of SWBF2CodeHelper 
-- verified decompile (BAD_AL)
--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- Functions for the Gamespy login screen

-- This is so fundamentally different from the XLive flow that the two
-- are split off.
if ScriptCB_GetOnlineService() == "Galaxy" then
	--Decompiled with SWBF2CodeHelper
	ScriptCB_DoFile("ifs_mpgs_galaxylogin")
	ScriptCB_DoFile("ifs_mp_leaderboard")
	ScriptCB_DoFile("ifs_mp_leaderboarddetails")
	ScriptCB_DoFile("ifs_mpgs_friends")

	sp_missionselect_listbox_contents = {
		-- In the below list, the first '%s' will be replaced by the era,
		-- and the second will be replaced by the multiplayer variant name
		-- (the part after "mode_")
	--    { mapluafile = "TEST1%s",   era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1,},
	--    { mapluafile = "bes2%s_%s", era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, },
		{ mapluafile = "cor1%s_%s", era_g = 1, era_c = 1, mode_c_c   = 1, mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "dag1%s_%s", era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "dea1%s_%s", era_g = 1, era_c = 1, mode_c_g   = 1, mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "end1%s_%s", era_g = 1,                            mode_con_g = 1, mode_hunt_g = 1, mode_1flag_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "fel1%s_%s", era_g = 1, era_c = 1, mode_c_c   = 1, mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "geo1%s_%s",            era_c = 1, mode_c_c   = 1, mode_con_c = 1, mode_ctf_c = 1, mode_hunt_c = 1, mode_xl_c = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "hot1%s_%s", era_g = 1,            mode_c_g   = 1, mode_con_g = 1, mode_1flag_g = 1, mode_hunt_g = 1, mode_xl_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "kam1%s_%s", era_g = 1, era_c = 1, mode_c_c   = 1, mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "kas2%s_%s", era_g = 1, era_c = 1, mode_c_c   = 1, mode_con_c = 1, mode_con_g = 1, mode_hunt_c = 1,  mode_ctf_c = 1, mode_ctf_g = 1, mode_xl_c = 1, mode_xl_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "mus1%s_%s", era_g = 1, era_c = 1, mode_c_c   = 1, mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "myg1%s_%s", era_g = 1, era_c = 1, mode_c_c   = 1, mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "nab2%s_%s", era_g = 1, era_c = 1, mode_c_g   = 1, mode_con_c = 1, mode_con_g = 1,mode_ctf_c = 1, mode_ctf_g = 1, mode_hunt_c = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "pol1%s_%s", era_g = 1, era_c = 1, mode_c_g   = 1, mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
	--    { mapluafile = "rhn2%s_%s", era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, },
		{ mapluafile = "spa1%s_%s", era_g = 1,            mode_c_g   = 1, mode_assault_g = 1, mode_1flag_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
	    { mapluafile = "spa2%s_%s",            era_c = 1, mode_c_c =1,    movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "spa3%s_%s",            era_c = 1, mode_c_c =1,    mode_assault_c = 1, mode_1flag_c = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "spa4%s_%s", era_g = 1,            mode_c_g =1,    movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "spa6%s_%s",            era_c = 1, mode_assault_c = 1, mode_1flag_c = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "spa7%s_%s",            era_c = 1, mode_assault_c = 1, mode_1flag_c = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "spa8%s_%s", era_g = 1,            mode_assault_g = 1, mode_1flag_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "spa9%s_%s", era_g = 1,            mode_assault_g = 1, mode_1flag_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "tan1%s_%s", era_g = 1, era_c = 1, mode_c_g = 1,   mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "tat2%s_%s", era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1, mode_hunt_g = 1, mode_eli_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "tat3%s_%s", era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "uta1%s_%s", era_g = 1, era_c = 1, mode_c_c = 1,   mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "yav1%s_%s", era_g = 1, era_c = 1, mode_c_g = 1,   mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		--{ mapluafile = "kor1%s_%s", era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, },
		--{ mapluafile = "sal1%s_%s", era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, },
		--{ mapluafile = "spa3%s_%s", era_g = 1,            mode_con_c = 1, mode_con_g = 1, },
		--{ mapluafile = "spa4%s_%s", era_g = 1,            mode_con_c = 1, mode_con_g = 1, },
	}

	mp_missionselect_listbox_contents = {
		-- In the below list, the first '%s' will be replaced by the era,
		-- and the second will be replaced by the multiplayer variant name
		-- (the part after "mode_")
	--    { mapluafile = "TEST1%s",   era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1,},
	--    { mapluafile = "bes2%s_%s", era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, },
		{ mapluafile = "cor1%s_%s", era_g = 1, era_c = 1, mode_c_c   = 1, mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "dag1%s_%s", era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "dea1%s_%s", era_g = 1, era_c = 1, mode_c_g   = 1, mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "end1%s_%s", era_g = 1,                            mode_con_g = 1, mode_hunt_g = 1, mode_1flag_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "fel1%s_%s", era_g = 1, era_c = 1, mode_c_c   = 1, mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "geo1%s_%s",            era_c = 1, mode_c_c   = 1, mode_con_c = 1, mode_ctf_c = 1, mode_hunt_c = 1, mode_xl_c = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "hot1%s_%s", era_g = 1,            mode_c_g   = 1, mode_con_g = 1, mode_1flag_g = 1, mode_hunt_g = 1, mode_xl_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "kam1%s_%s", era_g = 1, era_c = 1, mode_c_c   = 1, mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "kas2%s_%s", era_g = 1, era_c = 1, mode_c_c   = 1, mode_con_c = 1, mode_con_g = 1, mode_hunt_c = 1,  mode_ctf_c = 1, mode_ctf_g = 1, mode_xl_c = 1, mode_xl_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "mus1%s_%s", era_g = 1, era_c = 1, mode_c_c   = 1, mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "myg1%s_%s", era_g = 1, era_c = 1, mode_c_c   = 1, mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "nab2%s_%s", era_g = 1, era_c = 1, mode_c_g   = 1, mode_con_c = 1, mode_con_g = 1,mode_ctf_c = 1, mode_ctf_g = 1, mode_hunt_c = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "pol1%s_%s", era_g = 1, era_c = 1, mode_c_g   = 1, mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
	--    { mapluafile = "rhn2%s_%s", era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, },
		{ mapluafile = "spa1%s_%s", era_g = 1,            mode_c_g   = 1, mode_assault_g = 1, mode_1flag_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
	    { mapluafile = "spa2%s_%s",            era_c = 1, mode_c_c =1,    movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "spa3%s_%s",            era_c = 1, mode_c_c =1,    mode_assault_c = 1, mode_1flag_c = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "spa4%s_%s", era_g = 1,            mode_c_g =1,    movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "spa6%s_%s",            era_c = 1, mode_assault_c = 1, mode_1flag_c = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "spa7%s_%s",            era_c = 1, mode_assault_c = 1, mode_1flag_c = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "spa8%s_%s", era_g = 1,            mode_assault_g = 1, mode_1flag_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "spa9%s_%s", era_g = 1,            mode_assault_g = 1, mode_1flag_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "tan1%s_%s", era_g = 1, era_c = 1, mode_c_g = 1,   mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "tat2%s_%s", era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, mode_ctf_c = 1, mode_ctf_g = 1, mode_hunt_g = 1, mode_eli_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "tat3%s_%s", era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "uta1%s_%s", era_g = 1, era_c = 1, mode_c_c = 1,   mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		{ mapluafile = "yav1%s_%s", era_g = 1, era_c = 1, mode_c_g = 1,   mode_con_c = 1, mode_con_g = 1, mode_1flag_c = 1, mode_1flag_g = 1, movieFile= "movies\\pre-movie", movieName= "preview-loop",},
		--{ mapluafile = "kor1%s_%s", era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, },
		--{ mapluafile = "sal1%s_%s", era_g = 1, era_c = 1, mode_con_c = 1, mode_con_g = 1, },
		--{ mapluafile = "spa3%s_%s", era_g = 1,            mode_con_c = 1, mode_con_g = 1, },
		--{ mapluafile = "spa4%s_%s", era_g = 1,            mode_con_c = 1, mode_con_g = 1, },
	}

else

local AutoLoginRadioButtons = nil

ifs_mpgs_login_vbutton_layout = {
	yHeight = 40,
	ySpacing  = 0,
	width = 350,
	font = "gamefont_medium",
	LeftJustify = 1,
	buttonlist = {
		-- Title is for the left column, string the value on the right,
		-- which is filled in via code later
		{ tag = "nick",  title = "ifs.gsprofile.nick",     string = "",},
		{ tag = "email", title = "ifs.gsprofile.email",    string = "" },
		{ tag = "pass",  title = "ifs.gsprofile.password", string = "", yAdd = 50},
		{ tag = "prompt",  title = "ifs.gsprofile.autologin", string = "" , },
		--{ tag = "save",  title = "ifs.gsprofile.saveinprofile", string = "" , },
		--{ tag = "login", title = "", string = "ifs.gsprofile.login" },
		--{ tag = "create", title = "", string = "ifs.gsprofile.create" },
--		{ tag = "nologin", title = "", string = "ifs.gsprofile.nologin"},
	},
	nocreatebackground = 1,
	noflashycenter=1,
	bNoDefaultSizing = 1,
}


-- Callbacks from the busy popup

-- Returns -1, 0, or 1, depending on error, busy, or success
function ifs_mpgs_login_fnCheckDone()
--	local this = ifs_mpgs_login
	return ScriptCB_IsLoginDone()
end

function ifs_mpgs_login_fnOnSuccess()
	local this = ifs_mpgs_login
--	print("Closing busy popup due to success")
	Popup_Busy:fnActivate(nil)
	-- Fixme! Go to XLive choice instead
	--ifs_movietrans_PushScreen(ifs_mp_main)
	--print("+++++1")
	
	--read stats rank
	ScriptCB_SearchStatsRank()
	
	ScriptCB_SetIFScreen( "ifs_mp_sessionlist" )
end

function ifs_mpgs_fnPostPassMismatch()
	local this = ifs_mpgs_login
	ifs_mpgs_login_fnSetPieceVis(this, nil, 1, nil) -- fade to listbox/buttons
end

function ifs_mpgs_login_fnOnFail()
	local this = ifs_mpgs_login
--	print("Closing busy popup due to fail")
	Popup_Busy:fnActivate(nil)
--	print("Error in logging on!\n")
	this.iPromptType = 0 -- back to prompt mode
	ifs_mpgs_login_fnSetPieceVis(this, nil, 1, nil) -- fade to listbox/buttons

	ScriptCB_SetGSProfileInfo(this.NickStr,this.EmailStr,this.PasswordStr,this.iSaveType,this.iPromptType)
	ifs_mpgs_fnUpdateButtonText(this)
-- 	local ErrorLevel,ErrorMessage = ScriptCB_QueryNetError("login")
-- 	ScriptCB_OpenErrorBox(ErrorLevel,ErrorMessage)
end

-- User hit cancel. Do what they want.
function ifs_mpgs_login_fnOnCancel()
	local this = ifs_mpgs_login

	ifelm_shellscreen_fnPlaySound(this.cancelSound)
	-- Stop logging in.
	ScriptCB_CancelLogin()

	-- Get rid of popup, turn this screen back on
--	print("Closing busy popup due to cancel")
	Popup_Busy:fnActivate(nil)
	ifs_mpgs_login_fnSetPieceVis(this, nil, 1, nil) -- fade to listbox/buttons
end

-- Callbacks from the "Create an account?" popup. If bResult is true,
-- they selected 'yes'
function ifs_mpgs_fnAskedCreateDone(bResult)
	local this = ifs_mpgs_login
	if(not bResult) then
		--ScriptCB_SetIFScreen("ifs_mp_main")
		--print("+++++2")
		ScriptCB_SetIFScreen( "ifs_mp_sessionlist" )
	else
		ifs_mpgs_login_fnSetPieceVis(this,nil,1,nil) -- fade in info
	end
end

-- Callbacks from the "This will send sensitive info?" popup. If
-- bResult is true, they selected 'yes'
function ifs_mpgs_fnSensitiveInfoDone(bResult)
	local this = ifs_mpgs_login
	ifs_mpgs_login_fnSetPieceVis(this,nil,1,nil) -- fade in info

	if(bResult) then
		if(ScriptCB_IsCurProfileDirty()) then
			--					print("Fading out to save...")
			ifs_mpgs_login_fnSetPieceVis(this, nil, nil, nil) -- fade out all\
			--Popup_LoadSave:fnActivate(1)
			--ScriptCB_StartSaveProfile()
			ifs_mpgs_login_StartSaveProfile()
		else
			-- Fix for BF2 bug 13997 - ensure we're in GS mode before
			-- calling GS functions - NM 9/20/05
			ScriptCB_SetConnectType("wan")
			ifs_mpgs_login_fnStartLogin(this,this.CurButton == "create")
		end
	end
end

function ifs_mpgs_login_fnPostKeyboard(this)
	-- Push strings thru to game
	ScriptCB_SetGSProfileInfo(this.NickStr,this.EmailStr,this.PasswordStr,this.iSaveType, this.iPromptType)
	ScriptCB_PopScreen() -- back to this screen, ifs_mpgs_login
end

-- Callback function when the virtual keyboard is done
function ifs_mpgs_login_fnKeyboardDone_Nick()
	local this = ifs_mpgs_login
	this.NickStr = ScriptCB_ununicode(ifs_vkeyboard.CurString)
	ifs_mpgs_login_fnPostKeyboard(this)
end

function ifs_mpgs_login_fnEmailIsAcceptable()
	local this = ifs_mpgs_login
	this.EmailStr = ScriptCB_ununicode(ifs_vkeyboard.CurString)

	-- Check if this is a valid email address.
	local bValidEmail = nil
	local iAtSign = strfind(this.EmailStr,"@",1,1)
	if(iAtSign) then
		local iDot = strfind(this.EmailStr,".",iAtSign+1,1)
		if(iDot) then
			bValidEmail = (string.len(this.EmailStr) - iDot) > 1
		end
	end

	if(not bValidEmail) then
		this.EmailStr = ""
	end

	return bValidEmail,"ifs.gsprofile.bademail"
end


-- Callback function when the virtual keyboard is done
function ifs_mpgs_login_fnKeyboardDone_Email()
	local this = ifs_mpgs_login

	this.EmailStr = ScriptCB_ununicode(ifs_vkeyboard.CurString)

	if(not gFinalBuild) then
		local iAtSign = strfind(this.EmailStr,"@",1,1)
		if(not iAtSign) then
			this.EmailStr = this.EmailStr .. "@pandemicstudios.com"
		end
	end

	-- Check if this is a valid email address.
	local bValidEmail = nil
	local iAtSign = strfind(this.EmailStr,"@",1,1)
	if(iAtSign) then
		local iDot = strfind(this.EmailStr,".",iAtSign+1,1)
		if(iDot) then
			bValidEmail = (string.len(this.EmailStr) - iDot) > 1
		end
	end

--	print("bValidEmail =", bValidEmail)
	if(bValidEmail) then
		ifs_mpgs_login_fnPostKeyboard(this)
	else
	end
end

-- Callback function when the virtual keyboard is done
function ifs_mpgs_login_fnKeyboardDone_Pass()
	local this = ifs_mpgs_login
	this.PasswordStr = ScriptCB_ununicode(ifs_vkeyboard.CurString)
	vkeyboard_specs.bPasswordMode = nil
	ifs_mpgs_login_fnPostKeyboard(this)
end

-- Helper function, sets all the button text to what the current values
-- say they should be.
function ifs_mpgs_fnUpdateButtonText(this)
--	this.NickStr,this.EmailStr,this.PasswordStr
	
	IFEditbox_fnSetString(this.nickedit, this.NickStr)

	if(string.len(this.EmailStr) >= 40) then 
		IFEditbox_fnSetScale(this.emailedit,0.75,1)
	else
		IFEditbox_fnSetScale(this.emailedit,1,1)
	end
	IFEditbox_fnSetString(this.emailedit, this.EmailStr)
	IFEditbox_fnSetString(this.passedit, this.PasswordStr)

	-- set the checkboxes correctly for saving nick/email/pass
	if(string.sub(this.iSaveType, 1, 1) == "1") then
		IFImage_fnSetTexture(this.toggleSaveNick,"check_yes")
	else
		IFImage_fnSetTexture(this.toggleSaveNick,"check_no")
	end

	if(string.sub(this.iSaveType, 2, 2) == "1") then
		IFImage_fnSetTexture(this.toggleSaveEmail,"check_yes")
	else
		IFImage_fnSetTexture(this.toggleSaveEmail,"check_no")
	end

	if(string.sub(this.iSaveType, 3, 3) == "1") then
		IFImage_fnSetTexture(this.toggleSavePass,"check_yes")
	else
		IFImage_fnSetTexture(this.toggleSavePass,"check_no")
	end

	-- set autologin button visibility
	if(IFObj_fnGetVis(this.buttons)) then
		if((this.iPromptType == 0) and 
			(not ifs_opt_mp_fnLoginInfoLooksOk(this.NickStr,this.EmailStr,this.PasswordStr))) then
			IFObj_fnSetVis(this.buttonlabels.prompt, nil)
			IFObj_fnSetVis(this.radiobuttons, nil)
		else
			IFObj_fnSetVis(this.buttonlabels.prompt, 1)
			IFObj_fnSetVis(this.radiobuttons, 1)
		end
	end


-- 	IFText_fnSetFont(this.buttons.nick.label,this.UseFont)
-- 	if(string.len(this.NickStr) < 1) then
-- 		RoundIFButtonLabel_fnSetString(this.buttons.nick,"ifs.gsprofile.notspecified")
-- 	else
-- 		if(string.len(this.NickStr) > 15) then
-- 			IFText_fnSetFont(this.buttons.nick.label,this.UseFont)
-- 		end
-- 		RoundIFButtonLabel_fnSetString(this.buttons.nick,this.NickStr)
-- 	end

-- 	IFText_fnSetFont(this.buttons.email.label,this.UseFont)
-- 	if(string.len(this.EmailStr) < 1) then
-- 		RoundIFButtonLabel_fnSetString(this.buttons.email,"ifs.gsprofile.notspecified")
-- 	else
-- 		if(string.len(this.EmailStr) > 15) then
-- 			IFText_fnSetFont(this.buttons.email.label,"gamefont_tiny")
-- 		end
-- 		RoundIFButtonLabel_fnSetString(this.buttons.email,this.EmailStr)
-- 	end

-- 	if(string.len(this.PasswordStr) < 1) then
-- 		RoundIFButtonLabel_fnSetString(this.buttons.pass,"ifs.gsprofile.notspecified")
-- 	else
-- 		local ShowStr = string.rep("*", string.len(this.PasswordStr))	
-- 		RoundIFButtonLabel_fnSetString(this.buttons.pass,ShowStr)
-- 	end

	--RoundIFButtonLabel_fnSetString(this.buttons.save,this.iSaveType)

 	--if(this.iSaveType == 0) then
 	--	RoundIFButtonLabel_fnSetString(this.buttons.save,"ifs.gsprofile.none")
 	--elseif (this.iSaveType == 1) then
 	--	RoundIFButtonLabel_fnSetString(this.buttons.save,"ifs.gsprofile.nopassword")
 	--else
 	--	RoundIFButtonLabel_fnSetString(this.buttons.save,"ifs.gsprofile.all")
 	--end

	-- radio buttons now!
 	--if(this.iPromptType == 0) then
 	--	RoundIFButtonLabel_fnSetString(this.buttons.prompt,"ifs.gsprofile.prompt")
 	--elseif (this.iPromptType == 1) then
 	--	RoundIFButtonLabel_fnSetString(this.buttons.prompt,"common.always")
 	--else
 	--	RoundIFButtonLabel_fnSetString(this.buttons.prompt,"common.never")
 	--end

end


function ifs_mpgs_login_fnStartLogin(this, bCreateMode)

--	print("Starting login...")

	ifelm_shellscreen_fnPlaySound(this.acceptSound)
	ScriptCB_StartLogin(this.NickStr,this.EmailStr,this.PasswordStr,bCreateMode)
	this.bStartedLogin = 1
	
	ifs_mpgs_login_fnSetPieceVis(this, nil, nil, nil) -- fade to blank for busy popup
	
	Popup_Busy.fnCheckDone = ifs_mpgs_login_fnCheckDone
	Popup_Busy.fnOnSuccess =  ifs_mpgs_login_fnOnSuccess
	Popup_Busy.fnOnFail =  ifs_mpgs_login_fnOnFail
	Popup_Busy.fnOnCancel =  ifs_mpgs_login_fnOnCancel
	Popup_Busy.bNoCancel = nil -- allow cancel button
	Popup_Busy.fTimeout = 30 -- seconds
	if(bCreateMode) then
		IFText_fnSetString(Popup_Busy.title,"common.mp.creating_gsid")
	else
		IFText_fnSetString(Popup_Busy.title,"common.mp.loggingin_gsid")
	end
--	print("Busy popup should be up!")
	Popup_Busy:fnActivate(1)
end

-- Callback (from C++) -- saving is done. Do something.
--function ifs_mpgs_login_fnSaveProfileDone(this)
--	print("Save profile is done...")
--	Popup_LoadSave:fnActivate(nil)

--	ifs_mpgs_login_fnSetPieceVis(this, nil, 1, nil) -- fade to listbox/buttons
--	ifs_mpgs_login_fnStartLogin(this)
--end

function ifs_mpgs_login_fnMustSpecifyOk()
	local this = ifs_mpgs_login
	ifs_mpgs_login_fnSetPieceVis(this, nil, 1, nil) -- fade in all
end

-- Helper function: turns pieces on/off as requested
function ifs_mpgs_login_fnSetPieceVis(this,bImmediate,bShowEntries)

--	print("mpgs login_fnSetPieceVis(..",bImmediate,bShowEntries)

	local bLoggedIn = ScriptCB_IsLoggedIn()

	IFObj_fnSetVis(this.buttonlabels, bShowEntries and not bLoggedIn)
	IFObj_fnSetVis(this.buttons, bShowEntries and not bLoggedIn)
	IFObj_fnSetVis(this.nickedit, bShowEntries and not bLoggedIn)
	IFObj_fnSetVis(this.emailedit, bShowEntries and not bLoggedIn)
	IFObj_fnSetVis(this.passedit, bShowEntries and not bLoggedIn)
	IFObj_fnSetVis(this.radiobuttons, bShowEntries and not bLoggedIn)
	IFObj_fnSetVis(this.LoginAsTextA, bShowEntries and bLoggedIn)
	IFObj_fnSetVis(this.LoginAsTextB, bShowEntries and bLoggedIn)
	IFObj_fnSetVis(this.LogoutButton, bShowEntries and bLoggedIn)

	IFObj_fnSetVis(this.Helptext_Accept, bShowEntries and not bLoggedIn)
	IFObj_fnSetVis(this.Helptext_Create, bShowEntries and not bLoggedIn)
	
	IFObj_fnSetVis(this.toggleSaveNick, bShowEntries and not bLoggedIn)
	IFObj_fnSetVis(this.toggleSaveEmail, bShowEntries and not bLoggedIn)
	IFObj_fnSetVis(this.toggleSavePass, bShowEntries and not bLoggedIn)
	IFObj_fnSetVis(this.saveLabel, bShowEntries and not bLoggedIn)

	-- Always turn these off.
	IFObj_fnSetVis(this.buttons.nick, nil)
	IFObj_fnSetVis(this.buttons.email, nil)
	IFObj_fnSetVis(this.buttons.pass, nil)
	IFObj_fnSetVis(this.buttons.prompt, nil)

	-- Store latest state
	this.bShowEntries = bShowEntries
end


----------------------------------------------------------------------------------------
-- save the profile in slot 1
----------------------------------------------------------------------------------------

function ifs_mpgs_login_StartSaveProfile()
--	print("ifs_mpgs_login_StartSaveProfile")
	
	ifs_saveop.doOp = "SaveProfile"
	ifs_saveop.OnSuccess = ifs_mpgs_login_SaveProfileSuccess
	ifs_saveop.OnCancel = ifs_mpgs_login_SaveProfileCancel
	ifs_saveop.saveName = ScriptCB_GetCurrentProfileName()
	ifs_saveop.saveProfileNum = 1
	ifs_movietrans_PushScreen(ifs_saveop)
end

function ifs_mpgs_login_SaveProfileSuccess()
--	print("ifs_mpgs_login_SaveProfileSuccess")
	local this = ifs_mpgs_login
	this.bReturningFromSave = 1
	ScriptCB_PopScreen()
--	ScriptCB_PopScreen("ifs_mpgs_login")
end

function ifs_mpgs_login_SaveProfileCancel()
--	print("ifs_mpgs_login_SaveProfileCancel")
	local this = ifs_mpgs_login
	this.bReturningFromSave = 1
	ScriptCB_PopScreen()
end

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

-- callback for radio buttons
function AutoLoginCallback(buttongroup, num)

	local this = ifs_mpgs_login  --ha!

	--ifelm_shellscreen_fnPlaySound(this.acceptSound)
	local oldPromptType = this.iPromptType
	this.iPromptType = 1 - (num - 1) -- clamp to 1 or zero, and invert - hehe

	-- Only 'yes' if the parameters look valid
	if((this.iPromptType == 1) and
		 (not ifs_opt_mp_fnLoginInfoLooksOk(this.NickStr,this.EmailStr,this.PasswordStr))) then
		this.iPromptType = 0 -- skip to never
	end
	
	if(oldPromptType ~= this.iPromptType) then
		ScriptCB_SetGSProfileInfo(this.NickStr,this.EmailStr,this.PasswordStr,this.iSaveType,this.iPromptType)
		ifs_mpgs_fnUpdateButtonText(this)
	end
	
	if( ScriptCB_IsLoggedIn() ) then
		ScriptCB_CancelLogin()
	end
	
	return 1+(1-this.iPromptType)
end

local AutoLoginRadioButtonLayout = 
{
	callback = AutoLoginCallback,
	spacing = 60,
	font = "gamefont_medium",
	strings = {"common.yes", "common.no"},
}

ifs_mpgs_login = NewIFShellScreen {

--  	title = NewIFText {
--  		string = "ifs.pickacct.account",
--  		font = "gamefont_large",
--  		textw = 460,
--  		y = 30,
--  		ScreenRelativeX = 0.5, -- center
--  		ScreenRelativeY = 0, -- top
-- 	},

	bg_texture = "iface_bg_1",
	movieIntro      = nil,
	movieBackground = nil,
	enable_autologin = nil,
	bNohelptext_backPC = 1,

--	Gamespy_Icon = NewIFImage {
--		ScreenRelativeX = 1.0, -- right
--		ScreenRelativeY = 0.05, -- top
--		texture = "gamespy_logo_256x64",
--		localpos_l = -256,
--		localpos_t = 0,
--		localpos_r = 0,
--		localpos_b = 64,
--	},

	Helptext_Gamespy = NewIFText {
		ScreenRelativeX = 0.5, -- center
		ScreenRelativeY = 1.0, -- bottom
		y = -95, -- just above bottom of screen
		font = "gamefont_small",
		textw = 460,
		texth = 75,
		valign = "vcenter",
		string = "ifs.gsprofile.howtomanage",
		nocreatebackground = 1,
	},

	-- Note: this ScreenRelativeX is used to determine the size of
	-- the sliders
	buttonlabels = NewIFContainer {
		ScreenRelativeX = 0.2, -- right-justified to this
		ScreenRelativeY = 0.5,
	},

	buttons = NewIFContainer {
		ScreenRelativeX = 0.215, -- text left-justified within this
		ScreenRelativeY = 0.5,
	},

	bStartedList = nil,
	
	Enter = function(this, bFwd)
		
		-- set pc profile & title version text
		UpdatePCTitleText(this)

		-- unselect the Accept and Create buttons if they were selected last time we left the screen
		if(this.Helptext_Accept) then
			IFButton_fnSelect(this.Helptext_Accept, false, false)
		end

		if(this.Helptext_Create) then
			IFButton_fnSelect(this.Helptext_Create, false, false)
		end

		-- tabs	
		if( ifs_main ) then
			ifs_main.option_mp = 1		-- set to multiplayer 
		end
		ifelem_tabmanager_SetSelected(this, gPCMainTabsLayout, "_tab_multi")
		ifelem_tabmanager_SetSelected(this, gPCMultiPlayerTabsLayout, "_tab_gamespy", 1)

		-- Fix for BF2 bug 13997 - ensure we're in GS mode before
		-- calling GS functions - NM 9/20/05
		ScriptCB_SetConnectType("wan")

		if( ScriptCB_IsLoggedIn() ) then
			print("mpgs_login Enter : Already logged in")
--			ScriptCB_SetIFScreen( "ifs_mp_sessionlist" )
			ifelem_tabmanager_SetDimmed( this, gPCMultiPlayerTabsLayout, "_tab_friends", nil, 1 )
			ifelem_tabmanager_SetDimmed( this, gPCMultiPlayerTabsLayout, "_tab_leaderboard", nil, 1 )

-- 			IFText_fnSetString( this.LoginAsText1, "ifs.mp.join.login_as" )
 			local NickStr, EmailStr, PasswordStr, iSaveType, iPromptType = ScriptCB_GetGSProfileInfo()
			if(ScriptCB_GetLoginName) then
				NickStr = ScriptCB_GetLoginName()
			else
				NickStr = "Get latest executable!"
			end
--			NickStr = "ImaMadteamkillinmachineyo"
 			IFText_fnSetString( this.LoginAsTextB, NickStr )
 			IFText_fnSetString( this.LoginAsText2, NickStr )
		else
			print("mpgs_login Enter : not logged in")
			ifelem_tabmanager_SetDimmed( this, gPCMultiPlayerTabsLayout, "_tab_friends", 1, 1 )
			ifelem_tabmanager_SetDimmed( this, gPCMultiPlayerTabsLayout, "_tab_leaderboard", 1, 1 )
 			IFObj_fnSetVis( this.LoginAsText1, nil )
 			IFObj_fnSetVis( this.LoginAsText2, nil )
		end
		-- dimm tabs for PC Demo
		ifs_DimTabsPCDemo(this)			

		gIFShellScreenTemplate_fnEnter(this, bFwd) -- Call base class

		ifs_mpgs_login_fnSetPieceVis(this,1,1) -- force on by default

		-- Added chunk for error handling...
		if(not bFwd) then
			local ErrorLevel,ErrorMessage = ScriptCB_GetError()
			if(ErrorLevel >= 8) then -- session or login error, must keep going further
				ScriptCB_CancelLogin()
				if(ErrorLevel > 8) then
					ScriptCB_PopScreen()
				end
			else
				-- In-session error that requires leaving it. We know we're
				-- out of it now, can do things normally.
				ScriptCB_ClearError()
			end
		end

		-- returning from a profile save? (also returning from a cancel save)
		if(this.bReturningFromSave) then			
--			print("ifs_mpgs_login.Enter bReturningFromSave")
			this.bReturningFromSave = nil
			--start the login process
			ifs_mpgs_login_fnSetPieceVis(this, nil, nil, nil) -- fade out all			
			-- Fix for BF2 bug 13997 - ensure we're in GS mode before
			-- calling GS functions - NM 9/20/05
			ScriptCB_SetConnectType("wan")
			ifs_mpgs_login_fnStartLogin(this,this.CurButton == "create")
			return
		end		

		if(bFwd) then
			this.NickStr,this.EmailStr,this.PasswordStr,this.iSaveType,this.iPromptType = ScriptCB_GetGSProfileInfo()
			-- Only show 'always' if the parameters look valid
			if((this.iPromptType == 1) and
				 (not ifs_opt_mp_fnLoginInfoLooksOk(this.NickStr,this.EmailStr,this.PasswordStr))) then
				this.iPromptType = 0 -- fallback to 'prompt'
			end

			local CmdNickStr,CmdEmailStr,CmdPassStr = ScriptCB_GetCmdlineLogin()
			CmdNickStr = CmdNickStr or ""
			CmdEmailStr = CmdEmailStr or ""
			CmdPassStr = CmdPassStr or ""
			if((string.len(CmdNickStr) > 1) and
				 (string.len(CmdEmailStr) > 1) and
					 (string.len(CmdPassStr) > 1)) then
				this.NickStr = CmdNickStr
				this.EmailStr = CmdEmailStr
				this.PasswordStr = CmdPassStr
				ifs_mpgs_fnSensitiveInfoDone(1) -- start a login
				ifs_mpgs_fnUpdateButtonText(this)
				return -- wait for login to finish before jumping on.
			end

			-- set to search host mode
			ScriptCB_SetAmHost(nil)
			--ScriptCB_SetHostLimit(100)
			ScriptCB_SetDedicated(nil)
			ifs_missionselect.bForMP = 1

			if(ScriptCB_InNetGame()) then
				--ifs_movietrans_PushScreen(ifs_mp_main)
				--print("+++++4")
				ScriptCB_SetIFScreen( "ifs_mp_sessionlist" )
			else
				if (this.iPromptType == 2) then 
					-- never login is their pref
					--ifs_movietrans_PushScreen(ifs_mp_main)
					-- only 
					if( this.enable_autologin ) then
						this.enable_autologin = nil
						--print("+++++5")
						ScriptCB_SetIFScreen( "ifs_mp_sessionlist" )
					end
				elseif (this.iPromptType == 1) then
					if( this.enable_autologin ) then
						this.enable_autologin = nil
						-- logout if already logged in
						if( ScriptCB_IsLoggedIn() ) then
							ScriptCB_CancelLogin()
						end
						
						-- always login is their pref
						ifs_mpgs_fnSensitiveInfoDone(1)
					end
				else
					if (string.len(this.NickStr) < 1) then
						-- Need to ask them if they want to 
						-- Default nickname: what they punched in at the login screen.
						-- Default nickname: what they punched in at the login screen.
						-- [But, we must sanitize the first character to fit GS regs]
						local LoginStr = ScriptCB_ununicode(ScriptCB_GetCurrentProfileName())
						local len = string.len(LoginStr)
						local FirstChar = string.sub(LoginStr, 1,1)
						local Rest = ""
						if(len > 1) then
							Rest = string.sub(LoginStr, -(len-1))
						end

						if((FirstChar == "@") or (FirstChar == "+") or (FirstChar == ":") or (FirstChar == "#")) then
							FirstChar = "_" -- replace first char with legal value.
						end

						if(this.iSaveType == 0) then -- save: none
							this.NickStr = ""
						else
							this.NickStr = FirstChar .. Rest -- reconstruct string
						end
						
						--Popup_YesNo_Large.CurButton = "yes" -- default
						--Popup_YesNo_Large.fnDone = ifs_mpgs_fnAskedCreateDone
						--Popup_YesNo_Large:fnActivate(1)
						--gPopup_fnSetTitleStr(Popup_YesNo_Large,"ifs.gsprofile.askcreate")
						ifs_mpgs_login_fnSetPieceVis(this,1,nil,nil) -- force off by default
						
						-- on PC, we are going to do away with the popup and simply act as if the user clicked Yes every time
						-- Mike Z
						ifs_mpgs_fnAskedCreateDone(true)
					end
				end
			end
		end

		ifs_mpgs_fnUpdateButtonText(this)
		
		-- setup auto-login radio buttons
		if(AutoLoginRadioButtons) then
			ifelem_SelectRadioButton(AutoLoginRadioButtons, 1+(1-this.iPromptType), true)
		end
	end,

 	Exit = function(this, bFwd)
 		--if(bFwd) then 			-- Going to a subscreen
 		if(1) then 			-- Going to a subscreen

		else
			-- Backing out to parent screen. Shutdown XLive stuff
			if(this.bStartedLogin) then
				print( "exit gamespy login here" )
				ScriptCB_CancelLogin()
				this.bStartedLogin = nil
			end
			-- Always reset NetLoginName to what was in profile, as we might
			-- have changed it to the selected user's gamertag as part of a
			-- login
			--local Selection = ifs_login_listbox_contents[ifs_login_listbox_layout.SelectedIdx]
			--ScriptCB_SetNetLoginName(Selection.showstr)
			ScriptCB_SetNetLoginName(ScriptCB_GetCurrentProfileName())
		end
	end,

	-- Not possible on this screen
	Input_GeneralLeft = function(this)
  end,
	Input_GeneralRight = function(this)
  end,

	Input_Accept = function(this)
		-- If the tab manager handled this event, then we're done
		if((gPlatformStr == "PC") and 
		   ( ifelem_tabmanager_HandleInputAccept(this, gPCMainTabsLayout) or
		     ifelem_tabmanager_HandleInputAccept(this, gPCMultiPlayerTabsLayout, 1) ) ) then
			return
		end

		-- If base class handled this work, then we're done
		if(gShellScreen_fnDefaultInputAccept(this)) then
			return
		end

		-- if it was radio buttons, similarly done
		if(ifelem_HandleRadioButtonInputAccept(this)) then
			return
		end

		-- Always copy out editbox strings before we get to code below

		this.NickStr = IFEditbox_fnGetString(this.nickedit)
		this.EmailStr = IFEditbox_fnGetString(this.emailedit)
		this.PasswordStr = IFEditbox_fnGetString(this.passedit)
		ScriptCB_SetGSProfileInfo(this.NickStr,this.EmailStr,this.PasswordStr,this.iSaveType,this.iPromptType)

-- 		if(this.CurButton == "nick") then
-- 			ifelm_shellscreen_fnPlaySound(this.acceptSound)
-- 			ifs_vkeyboard.CurString = ScriptCB_tounicode(this.NickStr)
-- 			IFText_fnSetString(ifs_vkeyboard.title,"ifs.vkeyboard.title_nick")
-- 			ifs_movietrans_PushScreen(ifs_vkeyboard)
-- 			vkeyboard_specs.MaxLen = 20
-- 			vkeyboard_specs.MaxWidth = 450
-- 			vkeyboard_specs.bGamespyMode = 1
-- 			ifs_vkeyboard.bCursorOnLetters = 1 -- start cursor in top-left
-- 			vkeyboard_specs.fnDone = ifs_mpgs_login_fnKeyboardDone_Nick
-- 			vkeyboard_specs.fnIsOk = ifs_login_fnIsAcceptable
-- 		elseif (this.CurButton == "email") then
-- 			ifelm_shellscreen_fnPlaySound(this.acceptSound)
-- 			vkeyboard_specs.MaxLen = 50
-- 			vkeyboard_specs.MaxWidth = 650
-- 			vkeyboard_specs.bGamespyMode = 1
-- 			ifs_vkeyboard.bCursorOnLetters = 1 -- start cursor in top-left
-- 			ifs_vkeyboard.CurString = ScriptCB_tounicode(this.EmailStr)
-- 			IFText_fnSetString(ifs_vkeyboard.title,"ifs.vkeyboard.title_email")
-- 			ifs_movietrans_PushScreen(ifs_vkeyboard)
-- 			vkeyboard_specs.fnDone = ifs_mpgs_login_fnKeyboardDone_Email
-- 			vkeyboard_specs.fnIsOk = ifs_mpgs_login_fnEmailIsAcceptable
-- 		elseif (this.CurButton == "pass") then
-- 			ifelm_shellscreen_fnPlaySound(this.acceptSound)
-- 			ifs_vkeyboard.CurString = ScriptCB_tounicode(this.PasswordStr)
-- 			vkeyboard_specs.MaxLen = 30
-- 			vkeyboard_specs.MaxWidth = 450
-- 			vkeyboard_specs.bGamespyMode = 1
-- 			vkeyboard_specs.bPasswordMode = 1
-- 			ifs_vkeyboard.bCursorOnLetters = 1 -- start cursor in top-left
-- 			IFText_fnSetString(ifs_vkeyboard.title,"ifs.vkeyboard.title_password")
-- 			ifs_movietrans_PushScreen(ifs_vkeyboard)
-- 			vkeyboard_specs.fnDone = ifs_mpgs_login_fnKeyboardDone_Pass
-- 			vkeyboard_specs.fnIsOk = ifs_login_fnIsAcceptable
--		else

		-- toggle saving nickname
		if (this.CurButton == "saveNick") then
			ifelm_shellscreen_fnPlaySound(this.acceptSound)

			local newSaveType = 1
			if(string.sub(this.iSaveType, 1, 1) == "1") then
				newSaveType = 0
			end
			
			this.iSaveType = newSaveType..string.sub(this.iSaveType, 2, 3)

			ScriptCB_SetGSProfileInfo(this.NickStr,this.EmailStr,this.PasswordStr,this.iSaveType,this.iPromptType)
			ifs_mpgs_fnUpdateButtonText(this)
			
		-- toggle saving email
		elseif (this.CurButton == "saveEmail") then
			ifelm_shellscreen_fnPlaySound(this.acceptSound)

			local newSaveType = 1
			if(string.sub(this.iSaveType, 2, 2) == "1") then
				newSaveType = 0
			end
			
			this.iSaveType = string.sub(this.iSaveType, 1, 1)..newSaveType..string.sub(this.iSaveType, 3, 3)

			ScriptCB_SetGSProfileInfo(this.NickStr,this.EmailStr,this.PasswordStr,this.iSaveType,this.iPromptType)
			ifs_mpgs_fnUpdateButtonText(this)

		-- toggle saving password
		elseif (this.CurButton == "savePass") then
			ifelm_shellscreen_fnPlaySound(this.acceptSound)

			local newSaveType = 1
			if(string.sub(this.iSaveType, 3, 3) == "1") then
				newSaveType = 0
			end
			
			this.iSaveType = string.sub(this.iSaveType, 1, 2)..newSaveType

			ScriptCB_SetGSProfileInfo(this.NickStr,this.EmailStr,this.PasswordStr,this.iSaveType,this.iPromptType)
			ifs_mpgs_fnUpdateButtonText(this)

		--elseif (this.CurButton == "save") then
		--	ifelm_shellscreen_fnPlaySound(this.acceptSound)
		--	--this.iSaveType = this.iSaveType + 1
		--	--if(this.iSaveType > 2) then
		--	--	this.iSaveType = 0
		--	--end

		--	ScriptCB_SetGSProfileInfo(this.NickStr,this.EmailStr,this.PasswordStr,this.iSaveType,this.iPromptType)
		--	ifs_mpgs_fnUpdateButtonText(this)
			
		elseif ((this.CurButton == "login") or (this.CurButton == "create")) then
			ifelm_shellscreen_fnPlaySound(this.acceptSound)

			-- unselect the Create button, in case...since it used to remain selected
			if(this.Helptext_Create) then
				IFButton_fnSelect(this.Helptext_Create, false, false)
			end

			if( ScriptCB_IsLoggedIn() ) then
				ScriptCB_CancelLogin()
			end

			if((string.len(this.NickStr) < 1) or (string.len(this.EmailStr) < 1) or (string.len(this.PasswordStr) < 1)) then

				ifs_mpgs_login_fnSetPieceVis(this,nil,nil) -- fade out entries
				Popup_Ok.fnDone = ifs_mpgs_login_fnMustSpecifyOk
				Popup_Ok:fnActivate(1)
				gPopup_fnSetTitleStr(Popup_Ok, "ifs.gsprofile.mustspecify")
				return
			end

			local bLooksOk, ExplainStr = ScriptCB_IsLegalGamespyString(this.NickStr,this.EmailStr,this.PasswordStr)
			if (not bLooksOk) then
				ifs_mpgs_login_fnSetPieceVis(this,nil,nil) -- fade out entries
				Popup_Ok.fnDone = ifs_mpgs_login_fnMustSpecifyOk
				Popup_Ok:fnActivate(1)
				gPopup_fnSetTitleStr(Popup_Ok, ExplainStr)
			else
				-- No sensitive info warning on PC, so just act like they hit 'ok' to it.
				ifs_mpgs_fnSensitiveInfoDone(1)
			end -- valid profile

		elseif (this.CurButton == "nologin") then
			ifelm_shellscreen_fnPlaySound(this.acceptSound)
			--ifs_movietrans_PushScreen(ifs_mp_main)

			if( ScriptCB_IsLoggedIn() ) then
				ScriptCB_CancelLogin()
			end
			--print("+++++6")
			ScriptCB_SetIFScreen( "ifs_mp_sessionlist" )
		elseif (this.CurButton == "_logout") then
			ScriptCB_CancelLogin()
			ifs_mpgs_login_fnSetPieceVis(this, nil, 1, nil) -- fade to listbox/buttons
		end

	end,

	Input_Back = function(this)
		if(this.bPasswordState) then
			this.bPasswordState = nil
			this.CurPassword = ""
			ifs_mpgs_login_fnSetPieceVis(this, nil, 1, nil) -- fade to listbox/buttons
		else
			if(gPlatformStr == "PC") then			
				ScriptCB_PopScreen("ifs_main") -- default action
			else
				ScriptCB_PopScreen() -- default action
			end
		end
	end,

	Input_KeyDown = function(this, iKey)
		if(gCurEditbox) then
			if((iKey == 10) or (iKey == 13)) then -- handle Enter different
				-- by doing nothing
			elseif (iKey == 9) then
				-- Handle tab key
				if(gCurEditbox) then
					IFEditbox_fnHilight(gCurEditbox, nil)
				end
				if(gCurEditbox == this.nickedit) then
					gCurEditbox = this.emailedit
				elseif (gCurEditbox == this.emailedit) then
					gCurEditbox = this.passedit
				elseif (gCurEditbox == this.passedit) then
					gCurEditbox = this.nickedit
				end
				if(gCurEditbox) then
					IFEditbox_fnHilight(gCurEditbox, 1)
				end
			elseif( ( iKey == 44 ) and ( gCurEditbox == this.nickedit ) ) then
				-- not allow ',' in nickname
			else
				IFEditbox_fnAddChar(gCurEditbox, iKey)

				if (gCurEditbox == this.emailedit) then
					this.EmailStr = IFEditbox_fnGetString(this.emailedit)
					if(string.len(this.EmailStr) >= 40) then 
						IFEditbox_fnSetScale(this.emailedit,0.75,1)
					else
						IFEditbox_fnSetScale(this.emailedit,1,1)
					end
					IFEditbox_fnSetString(this.emailedit, this.EmailStr)
				end
			end
			
			-- copy out the text, duh, why weren't we doing this before?  Validate AutoLogin as soon as text entered
			this.NickStr = IFEditbox_fnGetString(this.nickedit)
			this.EmailStr = IFEditbox_fnGetString(this.emailedit)
			this.PasswordStr = IFEditbox_fnGetString(this.passedit)
			ScriptCB_SetGSProfileInfo(this.NickStr,this.EmailStr,this.PasswordStr,this.iSaveType,this.iPromptType)
			-- set the visibility of the AutoLogin buttons
			ifs_mpgs_fnUpdateButtonText(this)
		end -- end if gCurEditBox
	end,

	-- Override default handler.
 	fnPostError = function(this,bUserHitYes,ErrorLevel,ErrorMessage)
-- 		print("MPGS Login fnPostError(..,",bUserHitYes,ErrorLevel)
		if(this.bStartedLogin) then
			ScriptCB_CancelLogin()
			ScriptCB_ClearError()
			this.bStartedLogin = nil
			ifs_mpgs_login_fnSetPieceVis(this,nil,1,nil) -- fade in info
			Popup_Busy:fnActivate(nil) -- in case it was up
		end

		if(ErrorLevel >= 9) then -- cable errors
			ScriptCB_PopScreen()
		end
 	end,

	fnSaveProfileDone = ifs_mpgs_login_fnSaveProfileDone,
}

function ifs_mpgs_login_fnBuildScreen(this)
	local ScreenW,ScreenH = ScriptCB_GetSafeScreenInfo() -- of the usable screen

	-- add pc profile & title version text
	AddPCTitleText( this )

	this.UseFont = "gamefont_medium"

	ifs_mpgs_login_vbutton_layout.width = ScreenW * (1.0 - this.buttons.ScreenRelativeX)

	AddVerticalText(this.buttonlabels,ifs_mpgs_login_vbutton_layout)
	this.CurButton = AddVerticalButtons(this.buttons,ifs_mpgs_login_vbutton_layout)

	-- +20 is to fix bug 9176 - NM 8/25/04. [Goes into "safe" zone]
	local LabelWidth = ScreenW * (this.buttonlabels.ScreenRelativeX) + 20

	local k,v
	for k,v in ifs_mpgs_login_vbutton_layout.buttonlist do
		local Tag = v.tag

		this.buttonlabels[Tag].textw = LabelWidth
		this.buttonlabels[Tag].x = -LabelWidth
		this.buttonlabels[Tag].halign = "right"
		this.buttonlabels[Tag].texth = this.buttonlabels[Tag].texth + 10
		this.buttonlabels[Tag].y = this.buttonlabels[Tag].y - 5 -- account for +10 one line up

		this.buttons[Tag].label.texth = this.buttons[Tag].label.texth + 10
		this.buttons[Tag].y = this.buttons[Tag].y - 5

		if(bNeedToShrink) then
			this.buttonlabels[Tag].font = "gamefont_tiny"
			this.buttons[Tag].label.font = "gamefont_tiny"
		end
	end

	this.buttonlabels.prompt.y = this.buttonlabels.prompt.y - 12

	-- Hide the static texts, create editboxes in their place (more
	-- PC-friendly)
	IFObj_fnSetVis(this.buttons.nick, nil)
	IFObj_fnSetVis(this.buttons.email, nil)
	IFObj_fnSetVis(this.buttons.pass, nil)
	local EditBoxW = ifs_mpgs_login_vbutton_layout.width - 100
	this.nickedit = NewEditbox {
		bKeepsFocus = 1,
		bStickyFocus = 1,
		ScreenRelativeX = this.buttons.ScreenRelativeX, -- text left-justified within this
		ScreenRelativeY = this.buttons.ScreenRelativeY,
		y = this.buttons.nick.y + 5,
		width = EditBoxW,
		height = ifs_mpgs_login_vbutton_layout.yHeight - 8,
		font = "gamefont_small",
		--		string = "Player 1",
--		MaxLen = EditBoxW,
		MaxChars = 30, -- from #define GP_NICK_LEN 31 - NM 9/13/05
	}
	this.nickedit.x = EditBoxW * 0.5

	this.emailedit = NewEditbox {
		bKeepsFocus = 1,
		bStickyFocus = 1,
		ScreenRelativeX = this.buttons.ScreenRelativeX, -- text left-justified within this
		ScreenRelativeY = this.buttons.ScreenRelativeY,
		y = this.buttons.email.y + 7,
		width = EditBoxW,
		height = ifs_mpgs_login_vbutton_layout.yHeight - 8,
		font = "gamefont_tiny",
		--		string = "Player 1",
--		MaxLen = EditBoxW,
		MaxChars = 50, -- from #define GP_EMAIL_LEN 51 - NM 9/13/05
	}
	this.emailedit.x = EditBoxW * 0.5

	this.passedit = NewEditbox {
		bKeepsFocus = 1,
		bStickyFocus = 1,
		ScreenRelativeX = this.buttons.ScreenRelativeX, -- text left-justified within this
		ScreenRelativeY = this.buttons.ScreenRelativeY,
		y = this.buttons.pass.y + 7,
		width = EditBoxW,
		height = ifs_mpgs_login_vbutton_layout.yHeight - 8,
		font = "gamefont_tiny",
		--		string = "Player 1",
--		MaxLen = EditBoxW,
		MaxChars = 30, -- from #define GP_PASSWORD_LEN 31 - NM 9/13/05
		bPasswordMode = 1,
	}
	this.passedit.x = EditBoxW * 0.5

	-- Add tabs to screen
	ifelem_tabmanager_Create(this, gPCMainTabsLayout, gPCMultiPlayerTabsLayout)

	-- login as text	
	this.LoginAsTextA = NewIFText {
		string = "ifs.mp.join.login_as",
		font = "gamefont_large",
		textw = 200,
		halign = "hcenter",
		ScreenRelativeX = 0.5, -- center
		ScreenRelativeY = 0.5, -- center
		nocreatebackground = 1,
	}
	
	this.LoginAsTextB = NewIFText {
		font = "gamefont_large",
		y = 20,
		textw = 500, -- Fix for 14378 - need to be able to show a LONG string in here
		halign = "hcenter",
		ScreenRelativeX = 0.5, -- center
		ScreenRelativeY = 0.5, -- center
		nocreatebackground = 1,
	}

	local BackButtonW = 155
	local BackButtonH = 25
	this.LogoutButton = NewPCIFButton -- NewRoundIFButton
	{
		ScreenRelativeX = 1.0,
		ScreenRelativeY = 1.0,
		x = -BackButtonW * 0.5,
		btnw = BackButtonW, -- made wider to fix 9173 - NM 8/25/04
		btnh = BackButtonH,
		font = "gamefont_small",
		--ColorR = 189, ColorG = 208, ColorB = 242,
		tag = "_logout",
	}
	RoundIFButtonLabel_fnSetString( this.LogoutButton, "common.mp.signout" )

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
		tag = "create",
	}
	RoundIFButtonLabel_fnSetString( this.Helptext_Create, "ifs.gsprofile.create" )
	
	this.Helptext_Accept = NewPCIFButton -- NewRoundIFButton			
	{
		ScreenRelativeX = 1.0,
		ScreenRelativeY = 1.0,
		x = -BackButtonW * 0.5,
		btnw = BackButtonW, -- made wider to fix 9173 - NM 8/25/04
		btnh = BackButtonH,
		font = "gamefont_small",
		--ColorR = 189, ColorG = 208, ColorB = 242,
		tag = "login",
	}
	RoundIFButtonLabel_fnSetString( this.Helptext_Accept, "ifs.gsprofile.login" )

	
	-- add gamespy logo & login
	ifs_mp_sessionlist_fnAddGamespyLogin( this )
	
	local aw,ah = ScriptCB_GetScreenInfo()
	
	local btnX = aw * this.buttons.ScreenRelativeX
	local btnY = ah * this.buttons.ScreenRelativeY + this.buttons.prompt.y + 11
	
	-- add autologin radio buttons and keep them around
	AutoLoginRadioButtons = ifelem_AddRadioButtonGroup(this, btnX, btnY, AutoLoginRadioButtonLayout)
	
	-- checkboxes to save edit fields
	this.toggleSaveNick = NewIFImage {
		ScreenRelativeX = this.buttons.ScreenRelativeX, -- text left-justified within this
		ScreenRelativeY = this.buttons.ScreenRelativeY,
		y = this.buttons.nick.y,
		x = EditBoxW + 7,

		bKeepsFocus = 1,

		texture = "check_yes",
		localpos_l = 1, localpos_t = 1,
		localpos_r = 14, localpos_b = 14,
		AutoHotspot = 1, tag = "saveNick",
		bIsFlashObj = 1, flash_alpha = 1.0,
	}
	this.toggleSaveEmail = NewIFImage {
		ScreenRelativeX = this.buttons.ScreenRelativeX, -- text left-justified within this
		ScreenRelativeY = this.buttons.ScreenRelativeY,
		y = this.buttons.email.y,
		x = EditBoxW + 7,

		texture = "check_yes",
		localpos_l = 1, localpos_t = 1,
		localpos_r = 14, localpos_b = 14,
		AutoHotspot = 1, tag = "saveEmail",
		bIsFlashObj = 1, flash_alpha = 1.0,
	}
	this.toggleSavePass = NewIFImage {
		ScreenRelativeX = this.buttons.ScreenRelativeX, -- text left-justified within this
		ScreenRelativeY = this.buttons.ScreenRelativeY,
		y = this.buttons.pass.y,
		x = EditBoxW + 7,

		texture = "check_yes",
		localpos_l = 1, localpos_t = 1,
		localpos_r = 14, localpos_b = 14,
		AutoHotspot = 1, tag = "savePass",
		bIsFlashObj = 1, flash_alpha = 1.0,
	}

	this.saveLabel = NewIFText {
		tag = "saveLabel",
		ScreenRelativeX = this.buttons.ScreenRelativeX, -- text left-justified within this
		ScreenRelativeY = this.buttons.ScreenRelativeY,
		y = this.buttons.nick.y - 40,
		x = EditBoxW,
		
		halign = "left",
		
		nocreatebackground = 1,
		font = "gamefont_medium",
		string = "ifs.gsprofile.saveinprofile",
	}

end

ifs_mpgs_login_fnBuildScreen(ifs_mpgs_login)
ifs_mpgs_login_fnBuildScreen = nil


AddIFScreen(ifs_mpgs_login,"ifs_mpgs_login")

end

