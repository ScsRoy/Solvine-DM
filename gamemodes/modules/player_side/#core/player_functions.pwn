//==============================================================================//
/*
	* Module: player_functions.pwn
	* Author: Sule Remake From Roy
	* Date: 12.04.2020
*/
//==============================================================================//
ResetVariables(playerid, bool:included)
{
	if(included)
	{
		PI[playerid][pOnline] = false;
		PI[playerid][pHours] = 0;
		PI[playerid][pMinutes] = 0;

		PI[playerid][pAdmin] = 0;
		PI[playerid][pAdminCode] = 0;
		PI[playerid][pPremium] = false;
		PI[playerid][pPremiumHours] = 0;
		PI[playerid][pJail] = 0;
		strmid(PI[playerid][pJailReason], "None", 0, strlen("None"));
		PI[playerid][pMute] = 0;
		strmid(PI[playerid][pMuteReason], "None", 0, strlen("None"));
		PI[playerid][pWarn] = 0;

		PI[playerid][pSkinID] = 23;
		PI[playerid][pKills] = 0;
		PI[playerid][pDeaths] = 0;
		PI[playerid][pMaxKS] = 0;
		PI[playerid][pMoney] = 0;
		PI[playerid][pDayKills] = 0;
		PI[playerid][pDayDeaths] = 0;
		PI[playerid][pDayWins] = 0;
		PI[playerid][pMonthKills] = 0;
		PI[playerid][pMonthDeaths] = 0;
		PI[playerid][pMonthWins] = 0;

		PI[playerid][pRank] = -1;
		PI[playerid][pArenaKills] = 0;
		PI[playerid][pArenaDeaths] = 0;
		PI[playerid][pDuelWins] = 0;
		PI[playerid][pDuelDefeats] = 0;
		PI[playerid][pVersusWins] = 0;
		PI[playerid][pVersusDefeats] = 0;
	}

	// ---------------- // Register
	RegisterPW[playerid] = false;
	RegisterSex[playerid] = false;

	// ---------------- // Main
	LoggedIn[playerid] = false;
	FirstSpawn[playerid] = false;
	Spawned[playerid] = false;
	LoginTries[playerid] = 0;
	KS[playerid] = 0;
	InLobby[playerid] = true;
	InFreeroam[playerid] = false;

	// ---------------- // Admin
	WarnChat[playerid] = true;
	AdminPreview[playerid] = true;
	PMPreview[playerid] = true;
	ACPreview[playerid] = true;
	GodMode[playerid] = false;
	GodTimer[playerid] = -1;
	TempVehicle[playerid] = -1;
	Spectate[playerid] = INVALID_PLAYER_ID;
	Screenshare[playerid] = INVALID_PLAYER_ID;

	// ---------------- // Creating
	CreatingStep[playerid] = -1;
	CreatingID[playerid] = -1;
	CreatingArena[playerid] = -1;

	EnteredArena[playerid] = -1;

	ChosenArena[playerid] = -1;

	// ---------------- // PM
	PMEnabled[playerid] = true;
	LastPM[playerid] = INVALID_PLAYER_ID;

	// ---------------- // CBug
	CBugAllowed[playerid] = false;
	CBugWarns[playerid] = 0;

	// ---------------- // Session
	resetSession(playerid);
	AC_KillTimer(SessionTimer[playerid]);

	// ---------------- // Duel
	InDuelID[playerid] = -1;

	// ---------------- // Verus
	InVersus[playerid] = false;
	VersusActive[playerid] = false;
	VersusOpponent[playerid] = INVALID_PLAYER_ID;
	VersusTime[playerid] = 0;
	
	// ---------------- // TD
	alertTDShown[playerid] = false;
	inGameTDShown[playerid] = false;
	arenaTDShown[playerid] = false;
	sessionTDShown[playerid] = false;
	versusTDShown[playerid] = false;
	deathCamTDShown[playerid] = false;

	return 1;
}
//==============================================================================//
function mySQL_DeletePlayerAccount(nick[])
{
	static query[84];
	mysql_format(DB, query, sizeof(query), "DELETE FROM "USER_DB" WHERE `pName`='%s' LIMIT 1", nick);
	mysql_tquery(DB, query);
	return 1;
}
//=======================================//
function mySQL_UpdatePlayerCustomVal(i, field[], value)
{
	static query[72];
	mysql_format(DB, query, sizeof(query), "UPDATE "USER_DB" SET `%s`=%d WHERE `pID`=%d", field, value, PI[i][pID]);
	mysql_tquery(DB, query);
	return 1;
}
//=======================================//
function mySQL_UpdatePlayerCustomStr(i, field[], str[])
{
	static query[96];
	mysql_format(DB, query, sizeof(query), "UPDATE "USER_DB" SET `%s`='%s' WHERE `pID`=%d", field, str, PI[i][pID]);
	mysql_tquery(DB, query);
	return 1;
}
//=======================================//
function mySQL_UpdatePlayerCustomFloat(i, field[], Float:val)
{
	static query[96];
	mysql_format(DB, query, sizeof(query), "UPDATE "USER_DB" SET `%s`=%f WHERE `pID`=%d", field, val, PI[i][pID]);
	mysql_tquery(DB, query);
	return 1;
}
//==============================================================================//
function mySQL_JailPlayer(id, time, reason[], bool:update)
{
	PI[id][pJail] = time;
	strmid(PI[id][pJailReason], reason, 0, strlen(reason));

	ResetPlayerWeapons(id);
	new rand = random(sizeof(RandomJail));
	TeleportPlayer(id, "Jail", RandomJail[rand][0], RandomJail[rand][1], RandomJail[rand][2], 0.0, 1, id+2);

	if(update)
	{
		static query[96];
		mysql_format(DB, query, sizeof(query), "UPDATE "USER_DB" SET `pJail`=%d, `pJailReason`='%s' WHERE `pID`=%d", PI[id][pJail], PI[id][pJailReason], PI[id][pID]);
		mysql_tquery(DB, query);
	}
	return 1;
}
//=======================================//
function mySQL_UnJailPlayer(id)
{
	PI[id][pJail] = 0;
	strmid(PI[id][pJailReason], "None", 0, strlen("None"));

	PostaviSpawn(id);
	SpawnPlayer(id);

	new query[96];
	mysql_format(DB, query, sizeof(query), "UPDATE "USER_DB" SET `pJail`=0, `pJailReason`='None' WHERE `pID`=%d", PI[id][pID]);
	mysql_tquery(DB, query);
	return 1;
}
//==============================================================================//
function mySQL_MutePlayer(id, time, reason[])
{
	PI[id][pMute] = time*60;
	strmid(PI[id][pMuteReason], reason, 0, strlen(reason));

	static query[96];
	mysql_format(DB, query, sizeof(query), "UPDATE "USER_DB" SET `pMute`=%d, `pMuteReason`='%s' WHERE `pID`=%d", PI[id][pMute], PI[id][pMuteReason], PI[id][pID]);
	mysql_tquery(DB, query);
	return 1;
}
//=======================================//
function mySQL_UnMutePlayer(id)
{
	PI[id][pMute] = 0;
	strmid(PI[id][pMuteReason], "None", 0, strlen("None"));

	static query[96];
	mysql_format(DB, query, sizeof(query), "UPDATE "USER_DB" SET `pMute`=%d, `pMuteReason`='%s' WHERE `pID`=%d", PI[id][pMute], PI[id][pMuteReason], PI[id][pID]);
	mysql_tquery(DB, query);
	return 1;
}
//==============================================================================//
function mySQL_RenamePlayer(id, newname[])
{
	//=======================================//

	if(PI[id][pAdmin] > 0)
	{
		strmid(AdminInfo[id][adminName], newname, 0, strlen(newname), MAX_PLAYER_NAME);
		mySQL_UpdateAdminCustomStr(id, "adminName", AdminInfo[id][adminName]);
	}

	static query[128];
	mysql_format(DB, query, sizeof(query), "UPDATE "WL_DB" SET `wlName`='%s' WHERE `wlName`='%s'", newname, GetName(id));
	mysql_tquery(DB, query);

	//=======================================//

	mySQL_UpdatePlayerCustomStr(id, "pName", newname);

	return 1;
}
//==============================================================================//
showStats(playerid, id)
{
	new dialog[1024 + 512], string[72], year, month, day, hours, minutes, seconds;
	getdate(year, month, day);
	gettime(hours, minutes, seconds);

	strcat(dialog, ""SERVER"________________________________________________________________________\n");
	format(string, sizeof(string), ""SERVER"> "WHITE"Current date\t\t%d-%02d-%02d %02d:%02d:%02d\n", year, month, day, hours, minutes, seconds);
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Register date\t%s\n", PI[id][pRegDate]);
	strcat(dialog, string);

	strcat(dialog, ""SERVER"____________________________________\n");
	strcat(dialog, ""SERVER"OVERALL\n");
	format(string, sizeof(string), ""SERVER"> "WHITE"User ID\t\t%d\n", PI[id][pID]);
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"FPS\t\t\t%d\n", FPS[id]);
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Ping\t\t\t%d\n", Ping[id]);
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Packet Loss\t%.1f\n", PL[id]);
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Skin\t\t\t%d\n", PI[id][pSkinID]);
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Premium\t\t%s (%d)\n", (PI[id][pPremium] ? "ON" : "OFF"), PI[id][pPremiumHours]);
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Online time\t\t%02d:%02d\n", PI[id][pHours], PI[id][pMinutes]);
	strcat(dialog, string);
	strcat(dialog, ""SERVER"____________________________________\n");
	strcat(dialog, ""SERVER"ALL-TIME\n");
	format(string, sizeof(string), ""SERVER"> "WHITE"Kills\t\t\t%d\n", PI[id][pKills]);
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Deaths\t\t%d\n", PI[id][pDeaths]);
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Ratio\t\t\t%.1f\n", floatdiv(PI[playerid][pKills], PI[playerid][pDeaths]));
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Max KS\t\t%d\n", PI[id][pMaxKS]);
	strcat(dialog, string);
	strcat(dialog, ""SERVER"____________________________________\n");
	strcat(dialog, ""SERVER"RANK CALCULATIONS\n");
	format(string, sizeof(string), ""SERVER"> "WHITE"Arena Kills\t\t%d\n", PI[id][pArenaKills]);
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Arena Deaths\t\t%d\n", PI[id][pArenaDeaths]);
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Duel Wins\t\t%d\n", PI[id][pDuelWins]);
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Duel Defeats\t\t%d\n", PI[id][pDuelDefeats]);
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Versus Wins\t\t%d\n", PI[id][pVersusWins]);
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Versus Defeats\t%d\n", PI[id][pVersusDefeats]);
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Points\t\t%.2f\n", calculateRankPoints(id));
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Rank\t\t\t%s\n", getRankName(PI[id][pRank]));
	strcat(dialog, string);
	strcat(dialog, ""SERVER"____________________________________\n");
	strcat(dialog, ""SERVER"DAILY STATISTIC\n");
	format(string, sizeof(string), ""SERVER"> "WHITE"Today's Kills\t\t%d\n", PI[id][pDayKills]);
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Today's Deaths\t%d\n", PI[id][pDayDeaths]);
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Today's Ratio\t%.1f\n", floatdiv(PI[playerid][pDayKills], PI[playerid][pDayDeaths]));
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Total DoTD wins\t%d\n", PI[id][pDayWins]);
	strcat(dialog, string);
	strcat(dialog, ""SERVER"____________________________________\n");
	strcat(dialog, ""SERVER"MONTHLY STATISTIC\n");
	format(string, sizeof(string), ""SERVER"> "WHITE"%s's Kills\t\t%d\n", getMonthName(), PI[id][pMonthKills]);
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"%s's Deaths\t%d\n", getMonthName(), PI[id][pMonthDeaths]);
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"%s's Ratio\t\t%.1f\n", getMonthName(), floatdiv(PI[playerid][pMonthKills], PI[playerid][pMonthDeaths]));
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Total DoTM wins\t%d\n", PI[id][pMonthWins]);
	strcat(dialog, string);
	strcat(dialog, ""SERVER"________________________________________________________________________\n");

	new title[48];
	format(title, sizeof(title), ""SERVER"> "WHITE"Stats (%s)", GetName(id));
	ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_MSGBOX, title, dialog, "OKAY", "");
	return 1;
}
//==============================================================================//
SpawnEx(playerid)
{
	if(EnteredArena[playerid] != -1)
	{
		leaveArena(playerid);
		GivePlayerWeapon(playerid, 24, 50);
	}
	else if(InDuelID[playerid] != -1)
	{
		onPlayerLeaveDuel(playerid, InDuelID[playerid]);
		GivePlayerWeapon(playerid, 24, 50);
	}
	else if(InVersus[playerid])
	{
		onPlayerLeaveVersus(playerid);
		GivePlayerWeapon(playerid, 24, 50);
	}
	else if(InFreeroam[playerid])
	{
		InFreeroam[playerid] = false;
		InLobby[playerid] = true;
		new rand = random(sizeof(RandomSpawn));
		TeleportPlayer(playerid, "Lobby", RandomSpawn[rand][0], RandomSpawn[rand][1], RandomSpawn[rand][2], 357.7274, 0, 0);
		GivePlayerWeapon(playerid, 24, 50);
	}
	else if(Screenshare[playerid] != INVALID_PLAYER_ID)
	{
		PostaviSpawn(playerid);
		SpawnPlayer(playerid);
	}
	else
	{
		InLobby[playerid] = true;
		new rand = random(sizeof(RandomSpawn));
		TeleportPlayer(playerid, "Lobby", RandomSpawn[rand][0], RandomSpawn[rand][1], RandomSpawn[rand][2], 357.7274, 0, 0);
		GivePlayerWeapon(playerid, 24, 50);
	}
	return 1;
}
//==============================================================================//
PostaviSpawn(playerid)
{
	if(EnteredArena[playerid] != -1)
	{
		new id = EnteredArena[playerid], slot = random(MAX_ARENA_POS);
		SetSpawnInfo(playerid, 0, PI[playerid][pSkinID], ArenaInfo[id][arenaX][slot], ArenaInfo[id][arenaY][slot], ArenaInfo[id][arenaZ][slot], ArenaInfo[id][arenaA][slot], 0,0, 0,0, 0,0);
	}
	else if(InVersus[playerid])
	{
		SetSpawnInfo(playerid, 0, PI[playerid][pSkinID], -1392.6107, 681.2277, 3.0703, 213.7058, 0,0, 0,0, 0,0);
	}
	else if(InFreeroam[playerid])
	{
		SetSpawnInfo(playerid, 0, PI[playerid][pSkinID], 1030.1868, 1028.2849, 12.8566, 0.0, 0,0, 0,0, 0,0);
	}
	else if(Screenshare[playerid] != INVALID_PLAYER_ID)
	{
		SetSpawnInfo(playerid, 0, PI[playerid][pSkinID], -1382.5164, -314.0941, 25.4375, 33.0151, 0,0, 0,0, 0,0);
	}
	else
	{
		GivePlayerWeapon(playerid, 24, 50);
		new rand = random(sizeof(RandomSpawn));
		SetSpawnInfo(playerid, 0, PI[playerid][pSkinID], RandomSpawn[rand][0], RandomSpawn[rand][1], RandomSpawn[rand][2], 357.7274, 0,0, 0,0, 0,0);
	}
	return 1;
}
//==============================================================================//