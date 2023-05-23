//==============================================================================//
/*
	* Module: duel_functions.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
sendDuelMessage(id, msg[])
{
	foreach(new i:Player)
	{
		if(InDuelID[i] == id)
		{
			SendClientMessageEx(i, COL_ORANGE, "DUEL // "WHITE"%s", msg);
		}
	}
	return 1;
}
//=======================================//
setupDuelDialog(playerid, id)
{
	new dialog[1024], string[72];
	// ---------------- //
	format(string, sizeof(string), ""ORANGE"> "WHITE"Weapon [1]\t%s\n", WeaponInfo[ DuelInfo[id][duelWeapon][0] ][wName]);
	strcat(dialog, string);
	format(string, sizeof(string), ""ORANGE"> "WHITE"Weapon [2]\t%s\n", WeaponInfo[ DuelInfo[id][duelWeapon][1] ][wName]);
	strcat(dialog, string);
	format(string, sizeof(string), ""ORANGE"> "WHITE"Weapon [3]\t%s\n", WeaponInfo[ DuelInfo[id][duelWeapon][2] ][wName]);
	strcat(dialog, string);
	format(string, sizeof(string), ""ORANGE"> "WHITE"Health\t%.2f\n", DuelInfo[id][duelHP]);
	strcat(dialog, string);
	format(string, sizeof(string), ""ORANGE"> "WHITE"Armour\t%.2f\n", DuelInfo[id][duelArmour]);
	strcat(dialog, string);
	format(string, sizeof(string), ""ORANGE"> "WHITE"C-Bug\t%s\n", (DuelInfo[id][duelCBug] ? ""GREEN"Enabled" : ""RED"Disabled"));
	strcat(dialog, string);
	format(string, sizeof(string), ""ORANGE"> "WHITE"Arena\t%s\n", getArenaName(DuelInfo[id][duelArenaID]));
	strcat(dialog, string);
	format(string, sizeof(string), ""ORANGE"> "WHITE"Lineup\t%s\n", getDuelTypeName(id));
	strcat(dialog, string);

	// ---------------- //
	if(DuelInfo[id][duelLineup] < 2) strcat(dialog, ""ORANGE"> "WHITE"Teammate [1]\tLocked\n");
	else
	{
		if(DuelInfo[id][duelTeam][1] == INVALID_PLAYER_ID) strcat(dialog, ""ORANGE"> "WHITE"Teammate [1]\tInvite Player\n");
		else
		{
			format(string, sizeof(string), ""ORANGE"> "WHITE"Teammate [1]\t%s\n", GetName(DuelInfo[id][duelTeam][1]));
			strcat(dialog, string);
		}
	}
	if(DuelInfo[id][duelLineup] < 3) strcat(dialog, ""ORANGE"> "WHITE"Teammate [2]\tLocked\n");
	else
	{
		if(DuelInfo[id][duelTeam][2] == INVALID_PLAYER_ID) strcat(dialog, ""ORANGE"> "WHITE"Teammate [2]\tInvite Player\n");
		else
		{
			format(string, sizeof(string), ""ORANGE"> "WHITE"Teammate [2]\t%s\n", GetName(DuelInfo[id][duelTeam][2]));
			strcat(dialog, string);
		}
	}

	// ---------------- //
	if(DuelInfo[id][duelOpponent][0] == INVALID_PLAYER_ID) strcat(dialog, ""ORANGE"> "WHITE"Opponent [1]\tInvite Player\n");
	else
	{
		format(string, sizeof(string), ""ORANGE"> "WHITE"Opponent [1]\t%s\n", GetName(DuelInfo[id][duelOpponent][0]));
		strcat(dialog, string);
	}

	if(DuelInfo[id][duelLineup] < 2) strcat(dialog, ""ORANGE"> "WHITE"Opponent [2]\tLocked\n");
	else
	{
		if(DuelInfo[id][duelOpponent][1] == INVALID_PLAYER_ID) strcat(dialog, ""ORANGE"> "WHITE"Opponent [2]\tInvite Player\n");
		else
		{
			format(string, sizeof(string), ""ORANGE"> "WHITE"Opponent [2]\t%s\n", GetName(DuelInfo[id][duelOpponent][1]));
			strcat(dialog, string);
		}
	}
	if(DuelInfo[id][duelLineup] < 3) strcat(dialog, ""ORANGE"> "WHITE"Opponent [3]\tLocked\n");
	else
	{
		if(DuelInfo[id][duelOpponent][2] == INVALID_PLAYER_ID) strcat(dialog, ""ORANGE"> "WHITE"Opponent [3]\tInvite Player\n");
		else
		{
			format(string, sizeof(string), ""ORANGE"> "WHITE"Opponent [3]\t%s\n", GetName(DuelInfo[id][duelOpponent][2]));
			strcat(dialog, string);
		}
	}

	// ---------------- //
	strcat(dialog, ""ORANGE"> "WHITE"Reset duel setup\n");
	format(string, sizeof(string), ""ORANGE"> "WHITE"Start duel\t%s", (isDuelSetupValid(id) ? ""GREEN"Available" : ""RED"Unavailable"));
	strcat(dialog, string);

	ShowPlayerDialog(playerid, DUEL_SETUP, DIALOG_STYLE_TABLIST, ""ORANGE"Solvine Deathmatch > "WHITE"Duel Setup", dialog, "CHOOSE", "CANCEL");
	return 1;
}
//=======================================//
destroyDuel(id)
{
	foreach(new i:Player)
	{
		if(InDuelID[i] == id) 
		{
			InDuelID[i] = -1;
		}
	}	

	DuelInfo[id][duelWeapon][0] = 0;
	DuelInfo[id][duelWeapon][1] = 0;
	DuelInfo[id][duelWeapon][2] = 0;
	DuelInfo[id][duelHP] = 100.0;
	DuelInfo[id][duelArmour] = 100.0;
	DuelInfo[id][duelCBug] = false;
	DuelInfo[id][duelArenaID] = -1;
	DuelInfo[id][duelLineup] = 1;
	DuelInfo[id][duelTeam][0] = INVALID_PLAYER_ID;
	DuelInfo[id][duelTeam][1] = INVALID_PLAYER_ID;
	DuelInfo[id][duelTeam][2] = INVALID_PLAYER_ID;
	DuelInfo[id][duelOpponent][0] = INVALID_PLAYER_ID;
	DuelInfo[id][duelOpponent][1] = INVALID_PLAYER_ID;
	DuelInfo[id][duelOpponent][2] = INVALID_PLAYER_ID;

	DuelInfo[id][duelTeam1] = 0;
	DuelInfo[id][duelTeam2] = 0;
	DuelInfo[id][duelPlayers] = 0;
	DuelInfo[id][duelStarted] = false;

	Iter_Remove(DuelList, id);
	return 1;
}
//=======================================//
resetDuel(id)
{
	DuelInfo[id][duelWeapon][0] = 0;
	DuelInfo[id][duelWeapon][1] = 0;
	DuelInfo[id][duelWeapon][2] = 0;
	DuelInfo[id][duelHP] = 100.0;
	DuelInfo[id][duelArmour] = 100.0;
	DuelInfo[id][duelCBug] = false;
	DuelInfo[id][duelArenaID] = -1;
	DuelInfo[id][duelLineup] = 1;
	DuelInfo[id][duelTeam][0] = INVALID_PLAYER_ID;
	DuelInfo[id][duelTeam][1] = INVALID_PLAYER_ID;
	DuelInfo[id][duelTeam][2] = INVALID_PLAYER_ID;
	DuelInfo[id][duelOpponent][0] = INVALID_PLAYER_ID;
	DuelInfo[id][duelOpponent][1] = INVALID_PLAYER_ID;
	DuelInfo[id][duelOpponent][2] = INVALID_PLAYER_ID;

	DuelInfo[id][duelTeam1] = 0;
	DuelInfo[id][duelTeam2] = 0;
	DuelInfo[id][duelPlayers] = 0;
	DuelInfo[id][duelStarted] = false;
	return 1;
}
//=======================================//
getDuelTypeName(id)
{
	new name[4];
	switch(DuelInfo[id][duelLineup])
	{
		case 1: name = "1v1";
		case 2: name = "2v2";
		case 3: name = "3v3";
		default: name = "n/a";
	}
	return name;
}
//=======================================//
isDuelSetupValid(id)
{
	if(DuelInfo[id][duelWeapon][0] == 0 && DuelInfo[id][duelWeapon][1] == 0 && DuelInfo[id][duelWeapon][2] == 0) return false;
	if(DuelInfo[id][duelArenaID] == -1) return false;

	if(DuelInfo[id][duelOpponent][0] == INVALID_PLAYER_ID) return false;
	if(DuelInfo[id][duelLineup] == 2)
	{
		if(DuelInfo[id][duelTeam][0] == INVALID_PLAYER_ID || DuelInfo[id][duelOpponent][1] == INVALID_PLAYER_ID) return false;
	}
	if(DuelInfo[id][duelLineup] == 3)
	{
		if(DuelInfo[id][duelTeam][1] == INVALID_PLAYER_ID || DuelInfo[id][duelOpponent][2] == INVALID_PLAYER_ID) return false;
	}
	return true;
}
//==============================================================================//
finishDuelSetup(duel)
{
	DuelInfo[duel][duelPlayers] = 1;

	invitePlayerToDuel(duel, DuelInfo[duel][duelTeam][1]);
	invitePlayerToDuel(duel, DuelInfo[duel][duelTeam][2]);
	invitePlayerToDuel(duel, DuelInfo[duel][duelOpponent][0]);
	invitePlayerToDuel(duel, DuelInfo[duel][duelOpponent][1]);
	invitePlayerToDuel(duel, DuelInfo[duel][duelOpponent][2]);
	return 1;
}
//=======================================//
invitePlayerToDuel(duel, id)
{
	if(id == INVALID_PLAYER_ID) return 0;

	new str[72], dialog[512];
	new opp1 = DuelInfo[duel][duelOpponent][0], 
		opp2 = DuelInfo[duel][duelOpponent][1], 
		opp3 = DuelInfo[duel][duelOpponent][2], 
		team1 = DuelInfo[duel][duelTeam][0], 
		team2 = DuelInfo[duel][duelTeam][1],
		team3 = DuelInfo[duel][duelTeam][2];

	strcat(dialog, ""ORANGE"____________________________________\n");
	format(str, sizeof(str), ""ORANGE"> "WHITE"New duel invite\t%s\n", GetName(team1));
	strcat(dialog, str);
	format(str, sizeof(str), ""ORANGE"> "WHITE"Weapons\t\t%s / %s / %s\n", WeaponInfo[ DuelInfo[duel][duelWeapon][0] ][wName], WeaponInfo[ DuelInfo[duel][duelWeapon][1] ][wName], WeaponInfo[ DuelInfo[duel][duelWeapon][2] ][wName]);
	strcat(dialog, str);
	format(str, sizeof(str), ""ORANGE"> "WHITE"HP / Armour\t\t%f / %f\n", DuelInfo[duel][duelHP], DuelInfo[duel][duelArmour]);
	strcat(dialog, str);
	format(str, sizeof(str), ""ORANGE"> "WHITE"C-Bug\t\t%s\n", (DuelInfo[duel][duelCBug] ? ""GREEN"Yes" : ""RED"No"));
	strcat(dialog, str);
	format(str, sizeof(str), ""ORANGE"> "WHITE"Arena\t\t%s\n", ArenaInfo[ DuelInfo[duel][duelArenaID] ][arenaName]);
	strcat(dialog, str);
	strcat(dialog, ""ORANGE"____________________________________\n");
	strcat(dialog, ""ORANGE"> Team 1\n");
	format(str, sizeof(str), ""ORANGE"> "WHITE"%s\n", GetName(team1));
	strcat(dialog, str);
	if(team2 != INVALID_PLAYER_ID)
	{
		format(str, sizeof(str), ""ORANGE"> "WHITE"%s\n", GetName(team2));
		strcat(dialog, str);
	}
	if(team3 != INVALID_PLAYER_ID)
	{
		format(str, sizeof(str), ""ORANGE"> "WHITE"%s\n", GetName(team3));
		strcat(dialog, str);
	}

	strcat(dialog, ""ORANGE"____________________________________\n");
	strcat(dialog, ""ORANGE"> Team 2\n");
	format(str, sizeof(str), ""ORANGE"> "WHITE"%s\n", GetName(opp1));
	strcat(dialog, str);
	if(opp2 != INVALID_PLAYER_ID)
	{
		format(str, sizeof(str), ""ORANGE"> "WHITE"%s\n", GetName(opp2));
		strcat(dialog, str);
	}
	if(opp3 != INVALID_PLAYER_ID)
	{
		format(str, sizeof(str), ""ORANGE"> "WHITE"%s\n", GetName(opp3));
		strcat(dialog, str);
	}
	strcat(dialog, ""ORANGE"____________________________________\n");
	strcat(dialog, ""ORANGE"> You have 30 seconds to accept or refuse this invite.");

	DuelInviteID[id] = duel;
	DuelInviteTimer[id] = SetTimerEx("onDuelInviteExpire", 30 * 1000, false, "ii", duel, id);
	
	ShowPlayerDialog(id, DUEL_INVITE, DIALOG_STYLE_MSGBOX, ""ORANGE"Solvine Deathmatch > "WHITE"Duel Invite", dialog, "ACCEPT", "REJECT");
	return 1;
}
//=======================================//
function onDuelInviteExpire(duel, id)
{
	AC_KillTimer(DuelInviteTimer[id]);

	new str[96];
	format(str, sizeof(str), "Player %s did not accept duel invite this time. (time expire)", GetName(id));
	sendDuelMessage(duel, str);

	destroyDuel(duel);
	return 1;
}
//==============================================================================//
startDuel(id)
{
	new opp1 = DuelInfo[id][duelOpponent][0], 
		opp2 = DuelInfo[id][duelOpponent][1], 
		opp3 = DuelInfo[id][duelOpponent][2], 
		team1 = DuelInfo[id][duelTeam][0], 
		team2 = DuelInfo[id][duelTeam][1],
		team3 = DuelInfo[id][duelTeam][2];

	// ---------------- //
	setupDuelPlayer(team1, id, 0);
	SetPlayerTeam(team1, 1);
	if(team2 != INVALID_PLAYER_ID) 
	{
		setupDuelPlayer(team2, id, 1);
		SetPlayerColor(team2, GetPlayerColor(team1));
		SetPlayerTeam(team2, 1);
	}
	if(team3 != INVALID_PLAYER_ID) 
	{
		setupDuelPlayer(team3, id, 2);
		SetPlayerColor(team3, GetPlayerColor(team1));
		SetPlayerTeam(team3, 1);
	}
	// ---------------- //
	setupDuelPlayer(opp1, id, 3);
	SetPlayerTeam(opp1, 2);
	if(opp2 != INVALID_PLAYER_ID) 
	{
		setupDuelPlayer(opp2, id, 4);
		SetPlayerColor(opp2, GetPlayerColor(opp1));
		SetPlayerTeam(opp2, 2);
	}
	if(opp3 != INVALID_PLAYER_ID) 
	{
		setupDuelPlayer(opp3, id, 5);
		SetPlayerColor(opp3, GetPlayerColor(opp1));
		SetPlayerTeam(opp3, 2);
	}

	ServerInfo[duelPlayers] += DuelInfo[id][duelLineup] * 2;
	updatePlayers3D();

	// ---------------- //
	DuelInfo[id][duelStarted] = true;
	return 1;
}
//=======================================//
setupDuelPlayer(playerid, duel, slot)
{
	if(DuelInfo[duel][duelCBug])
		toggleCBug(playerid, true);

	new arena = DuelInfo[duel][duelArenaID];	
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid, DuelInfo[duel][duelWeapon][0], 100);
	GivePlayerWeapon(playerid, DuelInfo[duel][duelWeapon][1], 100);
	GivePlayerWeapon(playerid, DuelInfo[duel][duelWeapon][2], 100);
	SetPlayerHealth(playerid, DuelInfo[duel][duelHP]);
	SetPlayerArmour(playerid, DuelInfo[duel][duelArmour]);
	TeleportPlayer(playerid, "Duel", ArenaInfo[arena][arenaX][slot], ArenaInfo[arena][arenaY][slot], ArenaInfo[arena][arenaZ][slot], ArenaInfo[arena][arenaA][slot], ArenaInfo[arena][arenaIntID], duel+512);

	InLobby[playerid] = false;
	DuelMessage(playerid, "You have just teleported to %s(%d) duel arena. Duel is starting soon.", ArenaInfo[arena][arenaName], arena);
	return 1;
}
//==============================================================================//
giveDuelWin(id1, id2, id3)
{
	PI[id1][pDuelWins]++;
	mySQL_UpdatePlayerCustomVal(id1, "pDuelWins", PI[id1][pDuelWins]);
	checkRankPoint(id1);
	SetPlayerColor(id1, PlayerColors[id1 % sizeof PlayerColors]);

	if(id2 != INVALID_PLAYER_ID)
	{
		PI[id2][pDuelWins]++;
		mySQL_UpdatePlayerCustomVal(id2, "pDuelWins", PI[id2][pDuelWins]);
		checkRankPoint(id2);
		SetPlayerColor(id2, PlayerColors[id2 % sizeof PlayerColors]);
	}

	if(id3 != INVALID_PLAYER_ID)
	{
		PI[id3][pDuelWins]++;
		mySQL_UpdatePlayerCustomVal(id3, "pDuelWins", PI[id3][pDuelWins]);
		checkRankPoint(id3);
		SetPlayerColor(id3, PlayerColors[id3 % sizeof PlayerColors]);
	}
	checkBestDuelPlayer();
	return 1;
}
//=======================================//
giveDuelDefeat(id1, id2, id3)
{
	PI[id1][pDuelDefeats]++;
	mySQL_UpdatePlayerCustomVal(id1, "pDuelDefeats", PI[id1][pDuelDefeats]);
	checkRankPoint(id1);
	SetPlayerColor(id1, PlayerColors[id1 % sizeof PlayerColors]);

	if(id2 != INVALID_PLAYER_ID)
	{
		PI[id2][pDuelDefeats]++;
		mySQL_UpdatePlayerCustomVal(id2, "pDuelDefeats", PI[id2][pDuelDefeats]);
		checkRankPoint(id2);
		SetPlayerColor(id2, PlayerColors[id2 % sizeof PlayerColors]);
	}

	if(id3 != INVALID_PLAYER_ID)
	{
		PI[id3][pDuelDefeats]++;
		mySQL_UpdatePlayerCustomVal(id3, "pDuelDefeats", PI[id3][pDuelDefeats]);
		checkRankPoint(id3);
		SetPlayerColor(id3, PlayerColors[id3 % sizeof PlayerColors]);
	}
	return 1;
}
//=======================================//
leaveDuel(playerid)
{
	InDuelID[playerid] = -1;
	InLobby[playerid] = true;
	ResetPlayerWeapons(playerid);

	PostaviSpawn(playerid);
	SpawnPlayer(playerid);
	return 1;
}
//=======================================//
onPlayerLeaveDuel(playerid, id)
{
	new string[96];
	format(string, sizeof(string), "Player, %s(%d), in your duel match has left.", GetName(playerid), playerid);
	sendDuelMessage(id, string);

	if(DuelInfo[id][duelTeam][0] == playerid || DuelInfo[id][duelTeam][1] == playerid || DuelInfo[id][duelTeam][2] == playerid) DuelInfo[id][duelTeam2]++;
	if(DuelInfo[id][duelOpponent][0] == playerid || DuelInfo[id][duelOpponent][1] == playerid || DuelInfo[id][duelOpponent][2] == playerid) DuelInfo[id][duelTeam1]++;

	if(DuelInfo[id][duelTeam1] == DuelInfo[id][duelLineup])
	{
		Iter_Remove(DuelList, id);
		if(DuelInfo[id][duelLineup] == 1)
		{
			format(string, sizeof(string), "1v1 DUEL // "GREEN"%s (win)"WHITE" vs %s"WHITE" finished.", GetName(DuelInfo[id][duelTeam][0]), GetName(DuelInfo[id][duelOpponent][0]));
			SendClientMessageToAll(COL_ORANGE, string);

			#if USE_DISCORD == true
				format(string, sizeof(string), ">>> 1v1 duel has finished. **%s** vs %s", GetName(DuelInfo[id][duelTeam][0]), GetName(DuelInfo[id][duelOpponent][0]));
				DCC_SendChannelMessage(DiscordInfo[event_logs], string);
			#endif
		}
		else if(DuelInfo[id][duelLineup] == 2)
		{
			format(string, sizeof(string), "2v2 DUEL // "GREEN"%s-%s (win)"WHITE" vs %s-%s"WHITE" finished.", GetName(DuelInfo[id][duelTeam][0]), GetName(DuelInfo[id][duelTeam][1]), GetName(DuelInfo[id][duelOpponent][0]), GetName(DuelInfo[id][duelOpponent][1]));
			SendClientMessageToAll(COL_ORANGE, string);

			#if USE_DISCORD == true
				format(string, sizeof(string), ">>> 2v2 duel has finished. **%s-%s** vs %s-%s", GetName(DuelInfo[id][duelTeam][0]), GetName(DuelInfo[id][duelTeam][1]), GetName(DuelInfo[id][duelOpponent][0]), GetName(DuelInfo[id][duelOpponent][1]));
				DCC_SendChannelMessage(DiscordInfo[event_logs], string);
			#endif
		}
		else if(DuelInfo[id][duelLineup] == 3)
		{
			format(string, sizeof(string), "3v3 DUEL // "GREEN"%s-%s-%s (win)"WHITE" vs %s-%s-%s"WHITE" finished.", GetName(DuelInfo[id][duelTeam][0]), GetName(DuelInfo[id][duelTeam][1]), GetName(DuelInfo[id][duelTeam][2]), GetName(DuelInfo[id][duelOpponent][0]), GetName(DuelInfo[id][duelOpponent][1]), GetName(DuelInfo[id][duelOpponent][2]));
			SendClientMessageToAll(COL_ORANGE, string);

			#if USE_DISCORD == true
				format(string, sizeof(string), ">>> 3v3 duel has finished. **%s-%s-%s** vs %s-%s-%s", GetName(DuelInfo[id][duelTeam][0]), GetName(DuelInfo[id][duelTeam][1]), GetName(DuelInfo[id][duelTeam][2]), GetName(DuelInfo[id][duelOpponent][0]), GetName(DuelInfo[id][duelOpponent][1]), GetName(DuelInfo[id][duelOpponent][2]));
				DCC_SendChannelMessage(DiscordInfo[event_logs], string);
			#endif
		}
		giveDuelWin(DuelInfo[id][duelTeam][0], DuelInfo[id][duelTeam][1], DuelInfo[id][duelTeam][2]);
		giveDuelDefeat(DuelInfo[id][duelOpponent][0], DuelInfo[id][duelOpponent][1], DuelInfo[id][duelOpponent][2]);

		ServerInfo[duelPlayers] -= DuelInfo[id][duelLineup] * 2;
		updatePlayers3D();

		foreach(new i:Player)
			if(InDuelID[i] == id)
				leaveDuel(i);
	}
	else if(DuelInfo[id][duelTeam2] == DuelInfo[id][duelLineup])
	{
		Iter_Remove(DuelList, id);
		if(DuelInfo[id][duelLineup] == 1)
		{
			format(string, sizeof(string), "1v1 DUEL // "WHITE"%s vs "GREEN"%s (win)"WHITE" finished.", GetName(DuelInfo[id][duelTeam][0]), GetName(DuelInfo[id][duelOpponent][0]));
			SendClientMessageToAll(COL_ORANGE, string);

			#if USE_DISCORD == true
				format(string, sizeof(string), ">>> 1v1 duel has finished. %s vs **%s**", GetName(DuelInfo[id][duelTeam][0]), GetName(DuelInfo[id][duelOpponent][0]));
				DCC_SendChannelMessage(DiscordInfo[event_logs], string);
			#endif
		}
		else if(DuelInfo[id][duelLineup] == 2)
		{
			format(string, sizeof(string), "2v2 DUEL // "WHITE"%s-%s vs "GREEN"%s-%s (win)"WHITE" finished.", GetName(DuelInfo[id][duelTeam][0]), GetName(DuelInfo[id][duelTeam][1]), GetName(DuelInfo[id][duelOpponent][0]), GetName(DuelInfo[id][duelOpponent][1]));
			SendClientMessageToAll(COL_ORANGE, string);

			#if USE_DISCORD == true
				format(string, sizeof(string), ">>> 2v2 duel has finished. %s-%s vs **%s-%s**", GetName(DuelInfo[id][duelTeam][0]), GetName(DuelInfo[id][duelTeam][1]), GetName(DuelInfo[id][duelOpponent][0]), GetName(DuelInfo[id][duelOpponent][1]));
				DCC_SendChannelMessage(DiscordInfo[event_logs], string);
			#endif
		}
		else if(DuelInfo[id][duelLineup] == 3)
		{
			format(string, sizeof(string), "3v3 DUEL // "WHITE"%s-%s-%s vs "GREEN"%s-%s-%s (win)"WHITE" finished.", GetName(DuelInfo[id][duelTeam][0]), GetName(DuelInfo[id][duelTeam][1]), GetName(DuelInfo[id][duelTeam][2]), GetName(DuelInfo[id][duelOpponent][0]), GetName(DuelInfo[id][duelOpponent][1]), GetName(DuelInfo[id][duelOpponent][2]));
			SendClientMessageToAll(COL_ORANGE, string);

			#if USE_DISCORD == true
				format(string, sizeof(string), ">>> 3v3 duel has finished. %s-%s-%s vs **%s-%s-%s**", GetName(DuelInfo[id][duelTeam][0]), GetName(DuelInfo[id][duelTeam][1]), GetName(DuelInfo[id][duelTeam][2]), GetName(DuelInfo[id][duelOpponent][0]), GetName(DuelInfo[id][duelOpponent][1]), GetName(DuelInfo[id][duelOpponent][2]));
				DCC_SendChannelMessage(DiscordInfo[event_logs], string);
			#endif
		}

		giveDuelWin(DuelInfo[id][duelOpponent][0], DuelInfo[id][duelOpponent][1], DuelInfo[id][duelOpponent][2]);
		giveDuelDefeat(DuelInfo[id][duelTeam][0], DuelInfo[id][duelTeam][1], DuelInfo[id][duelTeam][2]);

		ServerInfo[duelPlayers] -= DuelInfo[id][duelLineup] * 2;
		updatePlayers3D();

		foreach(new i:Player)
			if(InDuelID[i] == id)
				leaveDuel(i);
	}

	leaveDuel(playerid);
	return 1;
}
//==============================================================================//
CMD:duel(playerid)
{
	if(!ServerInfo[serverArena]) return ErrorMessage(playerid, "Owner locked DM arenas. Please try again later.");
	if(!InLobby[playerid]) return ErrorMessage(playerid, "You have to be in lobby to use this command. (/lobby)");
	new id = Iter_Free(DuelList);
	if(id == -1) return ErrorMessage(playerid, "Duel lobby is full. Wait before creating new one.");

	resetDuel(id);
	Iter_Add(DuelList, id);
	DuelInfo[id][duelTeam][0] = playerid;
	InDuelID[playerid] = id;
	setupDuelDialog(playerid, id);

	DuelMessage(playerid, "You have just started preparing for duel.");
	return 1;
}
//==============================================================================//
