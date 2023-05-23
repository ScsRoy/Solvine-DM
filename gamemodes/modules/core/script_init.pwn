//==============================================================================//
/*
	* Module: script_init.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
public OnGameModeInit()
{
	GMLoading = GetTickCount();
	//==========================================================================//

	mysql_log(ALL);

	my_Option = mysql_init_options();  

	mysql_set_option(my_Option, AUTO_RECONNECT, true);  
	mysql_set_option(my_Option, MULTI_STATEMENTS, false);  
	mysql_set_option(my_Option, POOL_SIZE, 2);  
	mysql_set_option(my_Option, SERVER_PORT, 3306);  

	DB = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB, my_Option);  
	if(DB == MYSQL_INVALID_HANDLE || mysql_errno(DB) != 0) 
	{
		print("> mySQL // Cant connect to MySQL database. Exiting..."); 
		SendRconCommand("exit"); 
		return 1;
	}
	print("> mySQL // Successfully connected to MySQL."); 

	//=======================================//
	register_log = CreateLog("logs/registers", false);
	login_log = CreateLog("logs/logins", false);
	rcon_log = CreateLog("logs/rcon", false);
	kick_log = CreateLog("logs/kicks", false);
	ban_log = CreateLog("logs/bans", false);
	chat_log = CreateLog("logs/chat", false);
	kills_log = CreateLog("logs/kills", false);
	admin_log = CreateLog("logs/admin_cmd", false);
	make_remove_log = CreateLog("logs/make_remove", false);
	save_location_log = CreateLog("logs/save_locations", false);
	admin_hacking_log = CreateLog("logs/admin_hacking", false);
	ac_log = CreateLog("logs/ac_detections", false);
	server_control_log = CreateLog("logs/server_control", false);
	create_log = CreateLog("logs/create", false);
	delete_log = CreateLog("logs/delete", false);
	bug_log = CreateLog("logs/bugs", false);
	pm_log = CreateLog("logs/pm", false);
	rename_log = CreateLog("logs/rename", false);
	gamemode_log = CreateLog("logs/gamemode", false);
	report_log = CreateLog("logs/report", false);
	owner_msg_log = CreateLog("logs/owner", false);
	whitelist_log = CreateLog("logs/whitelist", false);

	//=======================================//

	#if USE_DISCORD == true
		if (_:DiscordInfo[server_id] == 0) 
			DiscordInfo[server_id] = DCC_FindGuildById("698888029821206579"); // server

		if (_:DiscordInfo[bot_id] == 0) 
			DiscordInfo[bot_id] = DCC_FindUserById("686484573705601048"); // bot

		if (_:DiscordInfo[log_in_log_out] == 0) 
			DiscordInfo[log_in_log_out] = DCC_FindChannelById("700848385191575562"); // log in out

		if (_:DiscordInfo[commands] == 0)
			DiscordInfo[commands] = DCC_FindChannelById("700848457178546278"); // cmd

		if (_:DiscordInfo[event_logs] == 0)
			DiscordInfo[event_logs] = DCC_FindChannelById("700848553207136303"); // events

		if (_:DiscordInfo[staff_log] == 0)
			DiscordInfo[staff_log] = DCC_FindChannelById("700848687785574421"); // stsaff log

		if (_:DiscordInfo[owner_log] == 0)
			DiscordInfo[owner_log] = DCC_FindChannelById("700848737249132554"); // owner log

		if (_:DiscordInfo[whitelist] == 0)
			DiscordInfo[whitelist] = DCC_FindChannelById("707261462548316210"); // whitelist

		DCC_SetBotActivity("Playing on: "IP"");
		DCC_SendChannelMessage(DiscordInfo[owner_log], ">>> Server successfully started...");
	#endif

	//=======================================//

	SetGameModeText(V_MOD);
	SendRconCommand("mapname "MAP"");
	SendRconCommand("language "LANGUAGE"");
	SendRconCommand("weburl "FORUM"");
	SendRconCommand("rcon_password "RCON_PASS"");

	#if IN_DEVELOPMENT == true && IN_LOCAL == false
		SendRconCommand("password "DEV_PW"");
	#endif

	EnableStuntBonusForAll(0);
	DisableInteriorEnterExits(); 
	
	//==========================================================================//

	for(new i = 0; i < MAX_REPORT; i++)
	{
		clearReport(i);
	}	

	//=======================================//

	Server3D[0] = CreateDynamic3DTextLabel(" ", COL_SERVER, LobbyTop5[0][0], LobbyTop5[0][1], LobbyTop5[0][2], 20.0);
	Server3D[1] = CreateDynamic3DTextLabel(" ", COL_SERVER, LobbyTop5[1][0], LobbyTop5[1][1], LobbyTop5[1][2], 20.0);
	Server3D[2] = CreateDynamic3DTextLabel(" ", COL_SERVER, LobbyTop5[2][0], LobbyTop5[2][1], LobbyTop5[2][2], 20.0);
	Server3D[3] = CreateDynamic3DTextLabel(" ", COL_SERVER, LobbyTop5[3][0], LobbyTop5[3][1], LobbyTop5[3][2], 20.0);
	Server3D[4] = CreateDynamic3DTextLabel(" ", COL_SERVER, LobbyTop5[4][0], LobbyTop5[4][1], LobbyTop5[4][2], 20.0);

	// ---------------- //

	Server3D[5] = CreateDynamic3DTextLabel(" ", COL_SERVER, BestDuel[0], BestDuel[1], BestDuel[2], 20.0);

	Server3D[6] = CreateDynamic3DTextLabel(" ", COL_SERVER, BestVersus[0], BestVersus[1], BestVersus[2], 20.0);

	// ---------------- //

	Server3D[7] = CreateDynamic3DTextLabel(" ", COL_SERVER, BestDaily[0], BestDaily[1], BestDaily[2], 20.0);

	Server3D[8] = CreateDynamic3DTextLabel(" ", COL_SERVER, BestMonthly[0], BestMonthly[1], BestMonthly[2], 20.0);

	// ---------------- //

	Server3D[9] = CreateDynamic3DTextLabel("(( Solvine Deathmatch ))\n"SERVER"Online // "WHITE"0\n"SERVER"Arena // "WHITE"0\n"SERVER"Duel // "WHITE"0\n"SERVER"Versus // "WHITE"0\n", COL_SERVER, 1767.1519, -1343.6935, 15.7598, 50.0);
	CreateDynamic3DTextLabel("(( Online ))\n(( "WHITE"Use this pickup to see online stats"SERVER" ))", COL_SERVER, 1052.9657, 961.5324, -41.7163, 50.0);
	ServerPickup[0] = CreateDynamicPickup(1314, 23, 1052.9657, 961.5324, -41.7163, 0, 0);

	CreateDynamic3DTextLabel("(( WELCOME TO Solvine Deathmatch ))\n(( "WHITE"Community Owner: "OWNER""SERVER" ))\n(( "WHITE"Community Developer: "SCRIPTER""SERVER" ))", COL_SERVER, 1769.5482, -1369.8124, 15.7578, 50.0);
	CreateDynamic3DTextLabel("(( Server Stats ))\n(( "WHITE"Use this pickup to see server stats"SERVER" ))", COL_SERVER, 1065.6975, 968.1109, -40.1463, 50.0);
	ServerPickup[1] = CreateDynamicPickup(1239, 23, 1065.6975, 968.1109, -40.1463, 0, 0);

	// ---------------- //
	
	CreateDynamic3DTextLabel("(( Leaderboard room ))\n(( "WHITE"Use this pickup to enter leaderboard room"SERVER" ))", COL_SERVER, 1046.7523, 1008.8837, 10.9453, 50.0);
	ServerPickup[2] = CreateDynamicPickup(1318, 23,  1046.7523, 1008.8837, 10.9453, 0, 0);
	
	CreateDynamic3DTextLabel("(( Exit Freeroam ))\n(( "WHITE"Use this pickup to exit leaderboard room"SERVER" ))", COL_SERVER, 1036.7358, 1017.5568, 10.9453, 50.0);
	ServerPickup[3] = CreateDynamicPickup(1318, 23, 1036.7358, 1017.5568, 10.9453, 0, 0);

	// ---------------- //
	
	CreateDynamic3DTextLabel("(( Exit leaderboard ))\n(( "WHITE"Use this pickup to go back to freeroam"SERVER" ))", COL_SERVER, 1387.1743, -33.6944, 1000.6537, 50.0);
	ServerPickup[7] = CreateDynamicPickup(1318, 23, 1387.1743, -33.6944, 1000.6537, 0, 0);

	// ---------------- //

	//=======================================//

	fast_timer = SetTimer("fastTimer", 250, false);
	one_second = SetTimer("oneSecond", 1000, false);
	one_minute = SetTimer("oneMinute", 60 * 1000, false);

	//=======================================//

	new years, months, days, hours, minutes, seconds;
	getdate(years, months, days);
	gettime(hours, minutes, seconds);
	Log(gamemode_log, INFO, "Server successfuly started", days, months, years, hours, minutes, seconds);

	//==========================================================================//
	
	#if defined script_OnGameModeInit
		return script_OnGameModeInit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif

#define OnGameModeInit script_OnGameModeInit
#if defined script_OnGameModeInit
	forward script_OnGameModeInit();
#endif
//==============================================================================//
