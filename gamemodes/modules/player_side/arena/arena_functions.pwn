//==============================================================================//
/*
	* Module: arena_functions.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
function mySQL_LoadArenas()
{
	new rows;
	cache_get_row_count(rows);

	for(new id = 0; id < rows; id++) 
	{
		mySQL_LoadArena(id);
	}
	printf("> mySQL // DM arenas successfully loaded. Total: %d.", rows);
	return 1;
}
//=======================================//
function mySQL_LoadArena(row)
{
	new id = Iter_Free(ArenaList);
	if(id == -1) return printf("> mySQL // There is failure in loading DM arena. Limit exceeded.");

	cache_get_value_int(row, "arenaID", ArenaInfo[id][arenaID]);
	cache_get_value(row, "arenaName", ArenaInfo[id][arenaName], 24);
	cache_get_value_int(row, "arenaWeapon1", ArenaInfo[id][arenaWeapon1]);
	cache_get_value_int(row, "arenaWeapon2", ArenaInfo[id][arenaWeapon2]);
	cache_get_value_int(row, "arenaWeapon3", ArenaInfo[id][arenaWeapon3]);

	cache_get_value_int(row, "arenaIntID", ArenaInfo[id][arenaIntID]);
	cache_get_value_int(row, "arenaVWID", ArenaInfo[id][arenaVWID]);
	new str[16];
	for(new i = 0; i < MAX_ARENA_POS; i++)
	{
		format(str, sizeof(str), "arenaX_%d", i);
		cache_get_value_name_float(row, str, ArenaInfo[id][arenaX][i]);
		format(str, sizeof(str), "arenaY_%d", i);
		cache_get_value_name_float(row, str, ArenaInfo[id][arenaY][i]);
		format(str, sizeof(str), "arenaZ_%d", i);
		cache_get_value_name_float(row, str, ArenaInfo[id][arenaZ][i]);
		format(str, sizeof(str), "arenaA_%d", i);
		cache_get_value_name_float(row, str, ArenaInfo[id][arenaA][i]);
	}

	cache_get_value_int(row, "arenaKSRecord", ArenaInfo[id][arenaKSRecord]);
	cache_get_value(row, "arenaKSRecorder", ArenaInfo[id][arenaKSRecorder], 24);
	cache_get_value_int(row, "arenaKillsRecord", ArenaInfo[id][arenaKillsRecord]);
	cache_get_value(row, "arenaKillsRecorder", ArenaInfo[id][arenaKillsRecorder], 24);

	cache_get_value_bool(row, "arenaLocked", ArenaInfo[id][arenaLocked]);
	Iter_Add(ArenaList, id);
	return 1;
}
//==============================================================================//
function mySQL_UpdateArenaPos(id, slot)
{
	static query[192], str1[16], str2[16], str3[16], str4[16];
	format(str1, sizeof(str1), "arenaX_%d", slot);
	format(str2, sizeof(str2), "arenaY_%d", slot);
	format(str3, sizeof(str3), "arenaZ_%d", slot);
	format(str4, sizeof(str4), "arenaA_%d", slot);

	mysql_format(DB, query, sizeof(query), "UPDATE "ARENA_DB" SET `%s`=%f, `%s`=%f, `%s`=%f, `%s`=%f WHERE `arenaID`=%d", 
		str1, ArenaInfo[id][arenaX][slot], str2, ArenaInfo[id][arenaY][slot], str3, ArenaInfo[id][arenaZ][slot], str4, ArenaInfo[id][arenaA][slot], id);
	mysql_tquery(DB, query);
	return 1;
}
//=======================================//
function mySQL_UpdateArenaCustomVal(id, field[], val)
{
	static query[72];
	mysql_format(DB, query, sizeof(query), "UPDATE "ARENA_DB" SET `%s`=%d WHERE `arenaID`=%d", field, val, ArenaInfo[id][arenaID]);
	mysql_tquery(DB, query);
	return 1;
}
//=======================================//
function mySQL_UpdateArenaCustomStr(id, field[], str[])
{
	static query[96];
	mysql_format(DB, query, sizeof(query), "UPDATE "ARENA_DB" SET `%s`='%s' WHERE `arenaID`=%d", field, str, ArenaInfo[id][arenaID]);
	mysql_tquery(DB, query);
	return 1;
}
//=======================================//
getArenaName(id)
{
	new name[24];
	if(!Iter_Contains(ArenaList, id)) name = "n/a";
	else strmid(name, ArenaInfo[id][arenaName], 0, strlen(ArenaInfo[id][arenaName])); 
	return name;
}
//==============================================================================//
enterArena(playerid, id)
{
	ServerInfo[arenaPlayers]++;
	updatePlayers3D();
	
	new slot = random(MAX_ARENA_POS);
	SetPlayerPos(playerid, ArenaInfo[id][arenaX][slot], ArenaInfo[id][arenaY][slot], ArenaInfo[id][arenaZ][slot]);
	SetPlayerFacingAngle(playerid, ArenaInfo[id][arenaA][slot]);
	SetPlayerInterior(playerid, ArenaInfo[id][arenaIntID]);
	SetPlayerVirtualWorld(playerid, ArenaInfo[id][arenaVWID]);

	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid, ArenaInfo[id][arenaWeapon1], 500);
	GivePlayerWeapon(playerid, ArenaInfo[id][arenaWeapon2], 500);
	GivePlayerWeapon(playerid, ArenaInfo[id][arenaWeapon3], 500);
	SetPlayerHealth(playerid, 100.0);
	SetPlayerArmour(playerid, 100.0);

	InLobby[playerid] = false;
	EnteredArena[playerid] = id;
	ArenaInfo[id][arenaOnline]++;

	resetSession(playerid);
	SessionInfo[id][sessionArenaID] = id;
	controlSessionTD(playerid, true);
	setupInGameTD(playerid);
	InfoMessage(playerid, "You have successfully entered arena %s. (%d)", ArenaInfo[id][arenaName], id);
	return 1;
}
//=======================================//
leaveArena(playerid)
{
	new id = EnteredArena[playerid];
	if(id == -1) return 0;
	ServerInfo[arenaPlayers]--;
	updatePlayers3D();

	InLobby[playerid] = true;
	EnteredArena[playerid] = -1;
	ArenaInfo[id][arenaOnline]--;
	
	ResetPlayerWeapons(playerid);
	resetSession(playerid);
	controlSessionTD(playerid, false);
	setupInGameTD(playerid);
	InfoMessage(playerid, "You have successfully left arena %s. (%d)", ArenaInfo[id][arenaName], id);

	SetPlayerVirtualWorld(playerid, 0);
	PostaviSpawn(playerid);
	SpawnPlayer(playerid);
	return 1;
}
//=======================================//
respawnPlayerInArena(playerid)
{
	controlDeathCamTD(playerid, false);
	controlInGameTD(playerid, true);
	TogglePlayerSpectating(playerid, false);
	return 1;
}
//=======================================//
setupArenaTD(playerid, id)
{
	if(!Iter_Contains(ArenaList, id))
	{
		controlArenaTD(playerid, false);
		return 1;
	}

	new string[128];
	format(string, sizeof(string), "%s~n~Online: %d / 10", ArenaInfo[id][arenaName], ArenaInfo[id][arenaOnline]);
	PlayerTextDrawSetString(playerid, arenaPTD[playerid][0], string);

	format(string, sizeof(string), "%s~n~%s~n~%s", WeaponInfo[ArenaInfo[id][arenaWeapon1]][wName], WeaponInfo[ArenaInfo[id][arenaWeapon2]][wName], WeaponInfo[ArenaInfo[id][arenaWeapon3]][wName]);
	PlayerTextDrawSetString(playerid, arenaPTD[playerid][1], string);

	format(string, sizeof(string), "%s ~n~%d streak ~n~%s ~n~%d kills", ArenaInfo[id][arenaKSRecorder], ArenaInfo[id][arenaKSRecord], ArenaInfo[id][arenaKillsRecorder], ArenaInfo[id][arenaKillsRecord]);
	PlayerTextDrawSetString(playerid, arenaPTD[playerid][2], string);

	ChosenArena[playerid] = id;
	return 1;
}
//=======================================//
resetSession(playerid)
{
	SessionInfo[playerid][sessionKills] = 0;
	SessionInfo[playerid][sessionDeaths] = 0;
	SessionInfo[playerid][sessionKS] = 0;

	SessionInfo[playerid][sessionHours] = 0;
	SessionInfo[playerid][sessionMinutes] = 0;
	SessionInfo[playerid][sessionSeconds] = 0;
	return 1;
}
//=======================================//
function arenaKickAFK(playerid) 
{
	if(!IsPlayerPaused(playerid)) return 1;

	leaveArena(playerid);
	InfoMessage(playerid, "You have been idle in DM arena for 20 seconds. You have been automaticly teleported to lobby.");
	return 1;
}
//=======================================//
function deathCam(playerid, killerid, time)
{
	if(IsPlayerConnected(killerid) && EnteredArena[killerid] == EnteredArena[playerid] && time > 0)
	{
		time--;
		new str[72], Float:HP, Float:Armour, weapon = GetPlayerWeapon(killerid);
		GetPlayerHealth(killerid, HP);
		GetPlayerArmour(killerid, Armour);

		switch(time)
		{
			case 3: PlayerTextDrawSetString(playerid, deathCamPTD[playerid][0], "RESPAWN IN~n~3");
			case 2: PlayerTextDrawSetString(playerid, deathCamPTD[playerid][0], "RESPAWN IN~n~3~n~2");
			case 1: PlayerTextDrawSetString(playerid, deathCamPTD[playerid][0], "RESPAWN IN~n~3~n~2~n~1");
		}
		format(str, sizeof(str), "HP: %.1f", HP);
		PlayerTextDrawSetString(playerid, deathCamPTD[playerid][1], str);
		format(str, sizeof(str), "Armour: %.1f", Armour);
		PlayerTextDrawSetString(playerid, deathCamPTD[playerid][2], str);
		format(str, sizeof(str), "PLAYER:~n~%s~n~_~n~RANK:~n~%s", GetName(killerid), getRankName(PI[killerid][pRank]));
		PlayerTextDrawSetString(playerid, deathCamPTD[playerid][3], str);
		PlayerTextDrawHide(playerid, deathCamPTD[playerid][4]);
		PlayerTextDrawSetPreviewModel(playerid, deathCamPTD[playerid][4], (WeaponInfo[weapon][wModel] == 0 ? 18631 : WeaponInfo[weapon][wModel]));
		PlayerTextDrawShow(playerid, deathCamPTD[playerid][4]);
		format(str, sizeof(str), "WEAPON:~n~%s~n~_~n~SESSION:~n~%dK_/_%dD_/_%.1fr", WeaponInfo[weapon][wName], SessionInfo[killerid][sessionKills], SessionInfo[killerid][sessionDeaths], floatdiv(SessionInfo[killerid][sessionKills], SessionInfo[killerid][sessionDeaths]));
		PlayerTextDrawSetString(playerid, deathCamPTD[playerid][5], str);

		SetPlayerProgressBarValue(playerid, deathCamHP[playerid], HP);
		SetPlayerProgressBarValue(playerid, deathCamArmour[playerid], Armour);

		SessionTimer[playerid] = SetTimerEx("deathCam", 1000, false, "iii", playerid, killerid, time);
	}
	else
	{
		SessionInfo[playerid][sessionDC] = false;
		AC_KillTimer(SessionTimer[playerid]);
		respawnPlayerInArena(playerid);
	}
	return 1;
}
//==============================================================================//
CMD:DM(playerid, params[])
{
	if(!ServerInfo[serverArena]) return ErrorMessage(playerid, "Owner locked DM arenas. Please try again later.");
	if(!InLobby[playerid]) return ErrorMessage(playerid, "You have to be in lobby to use this command. (/lobby)");

	new id = 0;
	if(sscanf(params, "i", id))
	{
		if(!Iter_Contains(ArenaList, id)) return ErrorMessage(playerid, "Wrong Arena ID.");
		
		controlArenaTD(playerid, true);
		setupArenaTD(playerid, id);
	}
	else
	{
		if(!Iter_Contains(ArenaList, id)) return ErrorMessage(playerid, "Wrong Arena ID.");
		if(ArenaInfo[id][arenaLocked]) return ErrorMessage(playerid, "That arena is locked by admin.");
		if(ArenaInfo[id][arenaOnline] >= 10 && !PI[playerid][pPremium]) return ErrorMessage(playerid, "That arena is full. (%d / 10)", ArenaInfo[id][arenaOnline]);

		enterArena(playerid, id);
	}
	return 1;
}
//=======================================//
CMD:DMlist(playerid)
{
	new dialog[512], string[72], x = 0;
	foreach(new i:ArenaList)
	{
		format(string, sizeof(string), ""ORANGE"[%d] "WHITE"%s\t[ %s ]\n", i, ArenaInfo[i][arenaName], (ArenaInfo[i][arenaLocked] ? "LOCK" : "UNLOCKED"));
		strcat(dialog, string);
		x++;
	}
	if(x == 0) return ErrorMessage(playerid, "Currently, there is no created DM arenas.");
	ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_TABLIST, ""ORANGE"SOLVINE:DM > "WHITE"Arena list", dialog, "OKAY", "");
	return 1;
}
//==============================================================================//
