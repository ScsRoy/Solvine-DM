//==============================================================================//
/*
	* Module: #server_functions.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
function mySQL_LoadServerInfo() 
{
	if(cache_num_rows() > 0) 
	{ 
		cache_get_value_int(0, "serverPoseta", ServerInfo[serverPoseta]);
		cache_get_value_int(0, "serverRecord", ServerInfo[serverRecord]);
		cache_get_value_int(0, "serverUpozorenih", ServerInfo[serverUpozorenih]);
		cache_get_value_int(0, "serverKikovanih", ServerInfo[serverKikovanih]);
		cache_get_value_int(0, "serverBanovanih", ServerInfo[serverBanovanih]);
		cache_get_value_int(0, "serverUsers", ServerInfo[serverUsers]);
		cache_get_value_int(0, "serverWhitelisted", ServerInfo[serverWhitelisted]);

		cache_get_value_bool(0, "serverRegistration", ServerInfo[serverRegistration]);
		cache_get_value_bool(0, "serverWL", ServerInfo[serverWL]);
		cache_get_value(0, "serverName1", ServerInfo[serverName1], 72);
		cache_get_value(0, "serverName2", ServerInfo[serverName2], 72);
		cache_get_value_bool(0, "serverArena", ServerInfo[serverArena]);
		cache_get_value_bool(0, "serverDuel", ServerInfo[serverDuel]);
		cache_get_value_bool(0, "serverVersus", ServerInfo[serverVersus]);
		cache_get_value_int(0, "versusWeapon", ServerInfo[versusWeapon]);
		cache_get_value_bool(0, "serverFreeroam", ServerInfo[serverFreeroam]);

		cache_get_value_int(0, "dayID", ServerInfo[dayID]);
		cache_get_value_int(0, "dayKills", ServerInfo[dayKills]);
		cache_get_value_int(0, "monthID", ServerInfo[monthID]);
		cache_get_value_int(0, "monthKills", ServerInfo[monthKills]);

		print("> mySQL // Server informations successfully loaded.");
	}
	else
	{
		ServerInfo[serverRegistration] = true;
		ServerInfo[serverWL] = true;
		strmid(ServerInfo[serverName1], "[Solvine Deathmatch] Solvine Deathmatch", 0, strlen("[Solvine Deathmatch] Solvine Deathmatch"));
		strmid(ServerInfo[serverName2], "[Solvine Deathmatch] Solvine Deathmatch", 0, strlen("[Solvine Deathmatch] Solvine Deathmatch"));
		mysql_tquery(DB, "INSERT INTO "SERVER_DB" SET `serverRegistration`=1, `serverWL`=1, `serverName1`='[Solvine Deathmatch] Solvine Deathmatch', `serverName2`='[Solvine Deathmatch] Solvine'");

		print("> mySQL // Server informations didnt load. Creating new one.");
	}
	new str[84];
	format(str, sizeof(str), "hostname %s", ServerInfo[serverName1]);
	SendRconCommand(str);
	StatsInfo = 1;

	format(str, sizeof(str), "%s", WeaponInfo[ ServerInfo[versusWeapon] ][wName]);
	TextDrawSetString(versusTD[2], str);
	
	checkLobbyTop5();
	checkBestDuelPlayer();
	checkBestVersusPlayer();
	updateLobbyDeathMatcher(TYPE_DAY);
	updateLobbyDeathMatcher(TYPE_MONTH);
	return 1;
}	
//=======================================//
function mySQL_UpdateServerCustomVal(field[], value)
{
	new query[72];
	mysql_format(DB, query, sizeof(query), "UPDATE "SERVER_DB" SET `%s`=%d", field, value);
	mysql_tquery(DB, query);
	return 1;
}
//=======================================//
function mySQL_UpdateServerCustomStr(field[], str[])
{
	new query[128];
	mysql_format(DB, query, sizeof(query), "UPDATE "SERVER_DB" SET `%s`='%s'", field, str);
	mysql_tquery(DB, query);
	return 1;
}
//==============================================================================//
showServerMenu(playerid)
{
	ShowPlayerDialog(playerid, SERVER_MENU, DIALOG_STYLE_LIST, ""SERVER"Solvine Deathmatch > "WHITE"Menu", "\
		"SERVER"> "WHITE"Server statistic\n\
		"SERVER"> "WHITE"Control server\n\
		"SERVER"> "WHITE"RCON control\n\
		"SERVER"> "WHITE"Create\n\
		"SERVER"> "WHITE"Delete\n\
		"SERVER"> "WHITE"GR\
		", "CHOOSE", "CANCEL");
	return 1;
}
//==============================================================================//
showServerStats(playerid)
{
	new str[96], dialog[512];
	format(str, sizeof(str), ""SERVER"> "WHITE"Visits\t"SERVER"[ %d ]\n", ServerInfo[serverPoseta]);
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"Online\t"SERVER"[ %d ]\n", ServerInfo[onlinePlayers]);
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"Record\t"SERVER"[ %d ]\n", ServerInfo[serverRecord]);
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"Daily record\t"SERVER"[ %d ]\n", ServerInfo[serverDailyRecord]);
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"Warned\t"SERVER"[ %d ]\n", ServerInfo[serverUpozorenih]);
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"Kicked\t"SERVER"[ %d ]\n", ServerInfo[serverKikovanih]);
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"Banned\t"SERVER"[ %d ]\n", ServerInfo[serverBanovanih]);
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"Users\t"SERVER"[ %d ]\n", ServerInfo[serverUsers]);
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"Whitelisted\t"SERVER"[ %d ]\n", ServerInfo[serverWhitelisted]);
	strcat(dialog, str);

	ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_TABLIST, ""SERVER"Solvine Deathmatch > "WHITE"Server Stats", dialog, "OKAY", "");
	return 1;
}
//=======================================//
showControlMenu(playerid)
{
	new str[96], dialog[1024];
	format(str, sizeof(str), ""SERVER"> "WHITE"Registration\t"SERVER"[%s]\n", ((ServerInfo[serverRegistration]) ? ("ON") : ("OFF")));
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"Whitelist\t"SERVER"[%s]\n", ((ServerInfo[serverWL]) ? ("ON") : ("OFF")));
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"Name 1\t"SERVER"[%s]\n", ServerInfo[serverName1]);
	strcat(dialog, str); 
	format(str, sizeof(str), ""SERVER"> "WHITE"Name 2\t"SERVER"[%s]\n", ServerInfo[serverName2]);
	strcat(dialog, str); 
	format(str, sizeof(str), ""SERVER"> "WHITE"Arena\t"SERVER"[%s]\n", ((ServerInfo[serverArena]) ? ("ON") : ("OFF")));
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"Duel\t"SERVER"[%s]\n", ((ServerInfo[serverDuel]) ? ("ON") : ("OFF")));
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"Versus\t"SERVER"[%s]\n", ((ServerInfo[serverVersus]) ? ("ON") : ("OFF")));
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"Versus Weapon\t"SERVER"[%s]\n", WeaponInfo[ ServerInfo[versusWeapon] ][wName]);
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"Freeroam\t"SERVER"[%s]\n", ((ServerInfo[serverFreeroam]) ? ("ON") : ("OFF")));
	strcat(dialog, str);
	// format(str, sizeof(str), ""SERVER"> "WHITE"Date Event\t"SERVER"[%s]\n", ((DateInfo[dateExist]) ? ("ON") : ("OFF")));
	// strcat(dialog, str); 
	// format(str, sizeof(str), ""SERVER"> "WHITE"Notice\t"SERVER"[%s]\n", ((NoticeInfo[noticeExist]) ? ("ON") : ("OFF")));
	// strcat(dialog, str); 

	ShowPlayerDialog(playerid, SERVER_CONTROL, DIALOG_STYLE_TABLIST, ""SERVER"Solvine Deathmatch > "WHITE"Server Control", dialog, "CHOOSE", "CANCEL");
	return 1;
}
//=======================================//
showRconMenu(playerid)
{
	ShowPlayerDialog(playerid, SERVER_RCON, DIALOG_STYLE_LIST, ""SERVER"Solvine Deathmatch > "WHITE"RCON Control", "\
		"SERVER"> "WHITE"Change map\n\
		"SERVER"> "WHITE"Change web\n\
		"SERVER"> "WHITE"Unlock\n\
		"SERVER"> "WHITE"Lock\n\
		"SERVER"> "WHITE"Change RCON PW\n\
		"SERVER"> "WHITE"Restart\n\
		"SERVER"> "WHITE"Stop\n\
		", "CHOOSE", "CANCEL");

	return 1;
}
//==============================================================================//
checkServerHostname()
{
	switch(StatsInfo)
	{
		case 0:
		{
			new str[84];
			format(str, sizeof(str), "hostname %s", ServerInfo[serverName1]);
			SendRconCommand(str);
			StatsInfo = 1;
		}
		case 1:
		{
			new str[84];
			format(str, sizeof(str), "hostname %s", ServerInfo[serverName2]);
			SendRconCommand(str);
			StatsInfo = 0;
		}
	}
	return 1;
}
//==============================================================================//
updatePlayers3D()
{
	new string[160];
	format(string, sizeof(string), "(( Solvine Deathmatch ))\n"SERVER"Online // "WHITE"%d\n"SERVER"Arena // "WHITE"%d\n"SERVER"Duel // "WHITE"%d\n"SERVER"Versus // "WHITE"%d\n", ServerInfo[onlinePlayers], ServerInfo[arenaPlayers], ServerInfo[duelPlayers], ServerInfo[versusPlayers]);
	UpdateDynamic3DTextLabelText(Server3D[9], COL_SERVER, string);
}
//==============================================================================//
function restartGamemode() 
{
	SendRconCommand("gmx");
	return 1;
}
//=======================================//
function exitGamemode() 
{
	SendRconCommand("exit");
	return 1;
}
//==============================================================================//
globalRestart(playerid)
{
	mysql_tquery(DB, "UPDATE "USER_DB" SET `pJail`=0, `pJailReason`='None', `pMute`=0, `pMuteReason`='None', `pWarn`=0, \
		`pKills`=0, `pDeaths`=0, `pMaxKS`=0, `pMoney`=0, \
		`pDayKills`=0, `pDayDeaths`=0, `pDayWins`=0, `pMonthKills`=0, `pMonthDeaths`=0, `pMonthWins`=0, \
		`pRank`=-1, `pArenaKills`=0, `pArenaDeaths`=0, `pDuelWins`=0, `pDuelDefeats`=0, `pVersusWins`=0, `pVersusDefeats`=0");

	mysql_tquery(DB, "TRUNCATE "BAN_DB"");
	mysql_tquery(DB, "UPDATE "SERVER_DB" SET `serverPoseta`=0, `serverRecord`=0, `serverUpozorenih`=0, `serverKikovanih`=0, `serverBanovanih`=0, \
		`dayID`=1, `dayKills`=0, `monthKills`=0, `monthID`=1");

	mysql_tquery(DB, "UPDATE "ARENA_DB" SET `arenaKSRecord`=0, `arenaKSRecorder`='None', `arenaKillsRecord`=0, `arenaKillsRecorder`='None'");

	mysql_tquery(DB, "UPDATE "ADMIN_DB" SET `adminCMD`=0, `adminBan`=0, `adminUnban`=0, `adminWarn`=0, `adminUnwarn`=0, `adminKick`=0, `adminJail`=0, `adminUnjail`=0, `adminSpec`=0, `adminMinutes`=0");

	updateLobbyDeathMatcher(TYPE_DAY);
	updateLobbyDeathMatcher(TYPE_MONTH);
	checkBestVersusPlayer();
	checkBestDuelPlayer();
	checkLobbyTop5();

	foreach(new i:Player)
		if(playerid != i)
			onPlayerKicked(i, GetName(playerid), "GLOBAL RESTART");

	InfoMessage(playerid, "You did global restart, users deleted, records, etc");
	return 1;
}
//==============================================================================//
