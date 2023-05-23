//==============================================================================//
/*
	* Module: script_exit.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
public OnGameModeExit()
{
	//==========================================================================//

	new years, months, days, hours, minutes, seconds, string[64];
	ConvertTime(gettime() - GMLoading, days, hours, minutes, seconds);

	if(days) format(string, sizeof(string), "%02d:%02d:%02d:%02d", days, hours, minutes, seconds);
	else if(hours) format(string, sizeof(string), "%02d:%02d:%02d", hours, minutes, seconds);
	else if(minutes) format(string, sizeof(string), "%02d:%02d", minutes, seconds);
	else format(string, sizeof(string), "%02d", (seconds < 10 ? "0" : ""), seconds);

	getdate(years, months, days);
	gettime(hours, minutes, seconds);

	Log(gamemode_log, INFO, "Server shutdown > Uptime %s", days, months, years, hours, minutes, seconds, string);
	printf("Server shutdown > %02d.%02d.%d > %02d:%02d:%02d > Uptime %s", days, months, years, hours, minutes, seconds, string);
	
	#if USE_DISCORD == true
		new str[72];
		format(str, sizeof(str), ">>> Server shutdown > Uptime %s", string);
		DCC_SendChannelMessage(DiscordInfo[owner_log], str);
	#endif

	//==========================================================================//

	DestroyLog(register_log);
	DestroyLog(login_log);
	DestroyLog(rcon_log);
	DestroyLog(kick_log);
	DestroyLog(ban_log);
	DestroyLog(chat_log);
	DestroyLog(kills_log);
	DestroyLog(admin_log);
	DestroyLog(make_remove_log);
	DestroyLog(save_location_log);
	DestroyLog(admin_hacking_log);
	DestroyLog(ac_log);
	DestroyLog(server_control_log);
	DestroyLog(create_log);
	DestroyLog(delete_log);
	DestroyLog(bug_log);
	DestroyLog(pm_log);
	DestroyLog(rename_log);
	DestroyLog(gamemode_log);
	DestroyLog(report_log);
	DestroyLog(owner_msg_log);
	DestroyLog(whitelist_log);

	//==========================================================================//

	AC_KillTimer(fast_timer);
	AC_KillTimer(one_second);
	AC_KillTimer(one_minute);

	//==========================================================================//

	#if defined script_OnGameModeExit
		return script_OnGameModeExit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeExit
	#undef OnGameModeExit
#else
	#define _ALS_OnGameModeExit
#endif

#define OnGameModeExit script_OnGameModeExit
#if defined script_OnGameModeExit
	forward script_OnGameModeExit();
#endif
//==============================================================================//