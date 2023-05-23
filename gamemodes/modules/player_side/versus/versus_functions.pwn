//==============================================================================//
/*
	* Module: versus_functions.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
CMD:versus(playerid)
{
	if(!ServerInfo[serverArena]) return ErrorMessage(playerid, "Owner locked DM arenas. Please try again later.");
	if(!InLobby[playerid]) return ErrorMessage(playerid, "You have to be in lobby to use this command. (/lobby)");
	if(ServerInfo[versusPlayers] >= 10 && !PI[playerid][pPremium]) return ErrorMessage(playerid, "Versus is full (%d / 10)", ServerInfo[versusPlayers]);

	ServerInfo[versusPlayers]++;
	updatePlayers3D();
	Iter_Add(VersusList, playerid);

	ResetPlayerWeapons(playerid);
	controlVersusTD(playerid, true);

	InLobby[playerid] = false;
	InVersus[playerid] = true;
	VersusActive[playerid] = false;
	VersusTime[playerid] = gettime();
	TeleportPlayer(playerid, "Versus Lobby", -1392.6107, 681.2277, 3.0703, 213.7058, 0, VERSUS_VW-1);

	VersusMessage(playerid, "You have successfully teleported to versus lobby, please wait until server find you opponent");
	return 1;
}
//=======================================//
CMD:versuslist(playerid)
{
	new dialog[512], string[64], x = 0;
	format(string, sizeof(string), ""ORANGE"[W] "WHITE"%s\n", WeaponInfo[ ServerInfo[versusWeapon] ][wName]);
	strcat(dialog, string);
	foreach(new i:VersusList)
	{
		format(string, sizeof(string), ""ORANGE"[%d] "WHITE"%s\n", i, GetName(i));
		strcat(dialog, string);
		x++;
	}	
	if(x == 0) return ErrorMessage(playerid, "Currently, there is no one in versus lobby.");
	ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_TABLIST, ""ORANGE"Solvine Deathmatch > "WHITE"Arena list", dialog, "OKAY", "");
	return 1;
}
//==============================================================================//
sendVersusMessage(msg[])
{
	foreach(new i:VersusList)
		SendClientMessageEx(i, COL_PINK, "VERSUS // "WHITE"%s", msg);
	return 1;
}
//=======================================//
onVersusMatchFound(id1, id2)
{
	new string[96];
	format(string, sizeof(string), "%s vs %s", GetName(id1), GetName(id2));

	VersusActive[id1] = true; 
	VersusOpponent[id1] = id2;
	controlVersusTD(id1, false);
	SetPlayerHealth(id1, 100.0);
	SetPlayerArmour(id1, 100.0);
	GivePlayerWeapon(id1, ServerInfo[versusWeapon], 500);
	TeleportPlayer(id1, string, -1392.6107, 681.2277, 3.0703, 213.7058, 0, VERSUS_VW+id1);
	VersusMessage(id1, "You are successfuly chosen for versus match with %s.", GetName(id2));

	VersusActive[id2] = true;
	VersusOpponent[id2] = id1;
	controlVersusTD(id2, false);
	SetPlayerHealth(id2, 100.0);
	SetPlayerArmour(id2, 100.0);
	GivePlayerWeapon(id2, ServerInfo[versusWeapon], 500);
	TeleportPlayer(id2, string, -1377.5746, 661.0917, 3.0703, 36.3874, 0, VERSUS_VW+id1);
	VersusMessage(id2, "You are successfuly chosen for versus match with %s.", GetName(id1));
	return 1;
}
//=======================================//
onVersusMatchFinish(playerid, killerid)
{
	PI[playerid][pVersusDefeats]++;
	mySQL_UpdatePlayerCustomVal(playerid, "pVersusDefeats", PI[playerid][pVersusDefeats]);
	checkRankPoint(playerid);
	PostaviSpawn(playerid);
	SpawnPlayer(playerid);

	PI[killerid][pVersusWins]++;
	mySQL_UpdatePlayerCustomVal(killerid, "pVersusWins", PI[killerid][pVersusWins]);
	checkRankPoint(killerid);
	VersusOpponent[killerid] = INVALID_PLAYER_ID;
	VersusActive[killerid] = false;
	VersusTime[killerid] = gettime();
	controlVersusTD(killerid, true);
	ResetPlayerWeapons(killerid);
	TeleportPlayer(killerid, "Versus Lobby", -1392.6107, 681.2277, 3.0703, 213.7058, 0, VERSUS_VW-1);

	checkBestVersusPlayer();

	new string[96];
	format(string, sizeof(string), "Player %s(%d) has won versus match against %s(%d).", GetName(killerid), killerid, GetName(playerid), playerid);
	sendVersusMessage(string);

	#if USE_DISCORD == true
		format(string, sizeof(string), ">>> Versus match finished. **%s** vs %s", GetName(killerid), GetName(playerid));
		DCC_SendChannelMessage(DiscordInfo[event_logs], string);
	#endif
	return 1;
}
//=======================================//
onPlayerLeaveVersus(playerid)
{
	if(VersusActive[playerid])
	{
		new opponent = VersusOpponent[playerid];
		if(VersusOpponent[opponent] == playerid)
			onVersusMatchFinish(playerid, opponent);
	}
	ServerInfo[versusPlayers]--;
	updatePlayers3D();
	Iter_Remove(VersusList, playerid);

	ResetPlayerWeapons(playerid);
	if(versusTDShown[playerid]) controlVersusTD(playerid, false);

	InLobby[playerid] = true;
	InVersus[playerid] = false;
	VersusOpponent[playerid] = INVALID_PLAYER_ID;
	VersusActive[playerid] = false;
	VersusTime[playerid] = gettime();

	PostaviSpawn(playerid);
	SpawnPlayer(playerid);
	return 1;
}
//==============================================================================//
