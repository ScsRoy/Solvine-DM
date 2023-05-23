//==============================================================================//
/*
	* Module: callbacks.pwn
	* Author: Sule >< Remake from Roy.
	* Date: 12.04.2020
*/
//==============================================================================//
public OnRconLoginAttempt(ip[], password[], success)
{
	new ip1[16], string[128];
	foreach(new i:Player)
	{
		GetPlayerIp(i, ip1, sizeof(ip1));
		if(!strcmp(ip, ip1, true))
		{
			if(success)
			{
				if(isNameScriptDefined(GetName(i)))
				{
					ShowPlayerDialog(i, RCON_LOGIN, DIALOG_STYLE_INPUT, ""SERVER"U // "WHITE"RCON PIN", ""SERVER"- "WHITE"Da bi mogli da koristite RCON admina, morate da ukucate sigurnosni RCON PIN\n"SERVER"- "WHITE"Molimo vas da kod unesete taj ispod.", "UNESI", "KICK");
				}
				else
				{
					format(string, sizeof(string), "RCON // Pemain %s memiliki akses untuk RCON (SUCCESS)", GetName(i));
					sendMessageToOwner(string);

					onPlayerKicked(i, ">AC<", "Pokusaj hakovanja RCON.");

					Log(rcon_log, INFO, "Pokusaj hakovanja RCON-a > SQLID (%d) > Igrac (%s) > IP (%s)", PI[i][pID], GetName(i), GetPlayerIP(i));
				}
			}
			else
			{
				if(!isNameScriptDefined(GetName(i)))
				{
					format(string, sizeof(string), "RCON // Igrac %s memiliki akses untuk RCON.", GetName(i));
					sendMessageToOwner(string);

					onPlayerKicked(i, ">AC<", "Mencoba menggunakan RCON.");

					Log(rcon_log, INFO, "Mencoba menggunakan RCON-a > SQLID (%d) > Igrac (%s) > IP (%s)", PI[i][pID], GetName(i), GetPlayerIP(i));
				}
			}
			break;
		}
	}
	#if defined cb_OnRconLoginAttempt
		return cb_OnRconLoginAttempt(ip, password, success);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnRconLoginAttempt
	#undef OnRconLoginAttempt
#else
	#define _ALS_OnRconLoginAttempt
#endif

#define OnRconLoginAttempt cb_OnRconLoginAttempt
#if defined cb_OnRconLoginAttempt
	forward cb_OnRconLoginAttempt(ip[], password[], success);
#endif
//==============================================================================//
public OnPlayerConnect(playerid)
{
	// ---------------- //

	ClearChat(playerid, 20);
	InfoMessage(playerid, "Server is loading. Please wait.");

	ResetVariables(playerid, false);
	TogglePlayerSpectating(playerid, true);
	PreloadAnimations(playerid);

	// ---------------- //

	ServerInfo[onlinePlayers]++;
	updatePlayers3D();
	checkRecord();

	// ---------------- //
	#if defined cb_OnPlayerConnect
		return cb_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect cb_OnPlayerConnect
#if defined cb_OnPlayerConnect
	forward cb_OnPlayerConnect(playerid);
#endif
//==============================================================================//
public OnPlayerDisconnect(playerid, reason)
{
	new name[14];
	switch(reason)
	{
		case 0: name = "Timeout/Crash";
		case 1: name = "Quit";
		case 2: name = "Kick/Ban";
	}

	static query[96];
	mysql_format(DB, query, sizeof(query), "UPDATE "USER_DB" SET `pLastLogin`=NOW() WHERE `pID`=%d", PI[playerid][pLastLogin]);
	mysql_tquery(DB, query);

	new str[96];
	format(str, sizeof(str), "[ < ] "WHITE"%s has just disconnected out of server. (%s)", GetName(playerid), name);
	SendClientMessageToAll(COL_RED, str);

	#if USE_DISCORD == true
		if(PI[playerid][pAdmin] > 0)
		{
			format(str, sizeof(str), ">>> Admin %s(%d) has just disconnected out of server.", GetName(playerid), playerid);
			DCC_SendChannelMessage(DiscordInfo[log_in_log_out], str);
		}
		else
		{
			format(str, sizeof(str), ">>> Player %s(%d) has just disconnected out of server.", GetName(playerid), playerid);
			DCC_SendChannelMessage(DiscordInfo[log_in_log_out], str);
		}
	#endif

	ServerInfo[onlinePlayers]--;
	updatePlayers3D();

	#if defined cb_OnPlayerDisconnect
		return cb_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect cb_OnPlayerDisconnect
#if defined cb_OnPlayerDisconnect
	forward cb_OnPlayerDisconnect(playerid, reason);
#endif
//==============================================================================//
public OnPlayerRequestClass(playerid, classid)
{
	PostaviSpawn(playerid);
	SpawnPlayer(playerid);
	#if defined cb_OnPlayerRequestClass
		return cb_OnPlayerRequestClass(playerid, classid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerRequestClass
	#undef OnPlayerRequestClass
#else
	#define _ALS_OnPlayerRequestClass
#endif

#define OnPlayerRequestClass cb_OnPlayerRequestClass
#if defined cb_OnPlayerRequestClass
	forward cb_OnPlayerRequestClass(playerid, classid);
#endif
//==============================================================================//
public OnPlayerSpawn(playerid)
{
	if(FirstSpawn[playerid])
	{
		ServerInfo[serverPoseta]++;
		mySQL_UpdateServerCustomVal("serverPoseta", ServerInfo[serverPoseta]);

		InLobby[playerid] = true;
		FirstSpawn[playerid] = false;

		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerInterior(playerid, 0);
		SetCameraBehindPlayer(playerid);
		SetPlayerScore(playerid, PI[playerid][pKills]);
		SetPlayerColor(playerid, PlayerColors[playerid % sizeof PlayerColors]);
		SetPlayerHealth(playerid, 999999.0);
		SetPlayerArmour(playerid, 999999.0);
		toggleCBug(playerid, false);

		ClearChat(playerid, 20);
		controlInGameTD(playerid, true);
		InfoMessage(playerid, "Welcome  %s to Sol-Vine Deathmatch", GetName(playerid));
		GivePlayerWeapon(playerid, 24, 999999);
	}
	else
	{
		if(EnteredArena[playerid] != -1)
		{
			if(SessionInfo[playerid][sessionDC])
			{
				new killerid = SessionInfo[playerid][sessionKiller];
				if(IsPlayerConnected(killerid) && EnteredArena[killerid] == EnteredArena[playerid])
				{
					TogglePlayerSpectating(playerid, true);
					SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(killerid));
					SetPlayerInterior(playerid, GetPlayerInterior(killerid));
					PlayerSpectatePlayer(playerid, killerid);

					controlInGameTD(playerid, false);
					controlDeathCamTD(playerid, true);

					new str[72], Float:HP, Float:Armour, weapon = GetPlayerWeapon(killerid);
					GetPlayerHealth(killerid, HP);
					GetPlayerArmour(killerid, Armour);

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

					SessionTimer[playerid] = SetTimerEx("deathCam", 1000, false, "iii", playerid, killerid, 4);
				}
				else
				{
					respawnPlayerInArena(playerid);
				}
			}
			else
			{
				new id = EnteredArena[playerid];
				SetPlayerVirtualWorld(playerid, ArenaInfo[id][arenaVWID]);
				SetPlayerInterior(playerid, ArenaInfo[id][arenaIntID]);
				SetCameraBehindPlayer(playerid);

				SetPlayerHealth(playerid, 100.0);
				SetPlayerArmour(playerid, 100.0);
				GivePlayerWeapon(playerid, ArenaInfo[id][arenaWeapon1], 50);
				GivePlayerWeapon(playerid, ArenaInfo[id][arenaWeapon2], 50);
				GivePlayerWeapon(playerid, ArenaInfo[id][arenaWeapon3], 50);

				InfoMessage(playerid, "You have successfully respawned in arena %s. (%d)", ArenaInfo[id][arenaName], id);
			}
		}
		else if(InVersus[playerid])
		{
			SetPlayerVirtualWorld(playerid, VERSUS_VW-1);
			SetPlayerInterior(playerid, 0);
			SetCameraBehindPlayer(playerid);
			ResetPlayerWeapons(playerid);

			VersusOpponent[playerid] = INVALID_PLAYER_ID;
			VersusActive[playerid] = false;
			VersusTime[playerid] = gettime();
			controlVersusTD(playerid, true);

			VersusMessage(playerid, "You have successfully respawned in versus lobby.");
		}
		else if(Screenshare[playerid] != INVALID_PLAYER_ID)
		{
			new id = Screenshare[playerid];
			SetPlayerVirtualWorld(playerid, id+1);
			SetPlayerInterior(playerid, 0);
			SetCameraBehindPlayer(playerid);
			ResetPlayerWeapons(playerid);
			InLobby[playerid] = false;

			if(PI[playerid][pAdmin] == 0)
				TogglePlayerControllable(playerid, false);

		}
		else
		{
			InLobby[playerid] = true;

			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerInterior(playerid, 0);
			SetCameraBehindPlayer(playerid);
			SetPlayerScore(playerid, PI[playerid][pKills]);
			SetPlayerColor(playerid, PlayerColors[playerid % sizeof PlayerColors]);
			SetPlayerHealth(playerid, 100.0);
			SetPlayerArmour(playerid, 100.0);
			toggleCBug(playerid, false);

			InfoMessage(playerid, "You have successfully respawned in lobby.");
		}
	}
	SetPlayerTeam(playerid, NO_TEAM);
	Spawned[playerid] = true;
	#if defined cb_OnPlayerSpawn
		return cb_OnPlayerSpawn(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerSpawn
	#undef OnPlayerSpawn
#else
	#define _ALS_OnPlayerSpawn
#endif

#define OnPlayerSpawn cb_OnPlayerSpawn
#if defined cb_OnPlayerSpawn
	forward cb_OnPlayerSpawn(playerid);
#endif
//==============================================================================//
public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
	if(result == -1)
	{
		ErrorMessage( playerid, "Command that you typed doesn't exist. (/help)");
		return 0;
	}
	else
	{
		if(PI[playerid][pAdmin] > 5) CMDTime[playerid] = gettime()+0;
		else if(PI[playerid][pAdmin] > 1) CMDTime[playerid] = gettime()+1;
		else CMDTime[playerid] = gettime()+3;
	}
	#if defined cb_OnPlayerCmdPerformed
		return cb_OnPlayerCmdPerformed(playerid, cmd, params, result, flags);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerCmdPerformed
	#undef OnPlayerCommandPerformed
#else
	#define _ALS_OnPlayerCmdPerformed
#endif

#define OnPlayerCommandPerformed cb_OnPlayerCmdPerformed
#if defined cb_OnPlayerCmdPerformed
	forward cb_OnPlayerCmdPerformed(playerid, cmd[], params[], result, flags);
#endif
//==============================================================================//
public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
	if(!Spawned[playerid])
	{
		ACToPlayer(playerid, "You have to be spawned to use commands.");
		return 0;
	}
	if(CMDTime[playerid] > gettime())
	{
		ACToPlayer(playerid, "Slow down a little with command spawn.");
		return 0;
	}
	#if defined cb_OnPlayerCommandReceived
		return cb_OnPlayerCommandReceived(playerid, cmd, params, flags);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerCommandReceived
	#undef OnPlayerCommandReceived
#else
	#define _ALS_OnPlayerCommandReceived
#endif

#define OnPlayerCommandReceived cb_OnPlayerCommandReceived
#if defined cb_OnPlayerCommandReceived
	forward cb_OnPlayerCommandReceived(playerid, cmd[], params[], flags);
#endif
//==============================================================================//
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		//======================================================================//
		case RCON_LOGIN:
		{
			if(!response)
			{
				onPlayerKicked(playerid, ">AC<", "Pokusaj hakovanja RCON.");

				Log(rcon_log, INFO, "Neuspjeli RCON Login. > SQLID (%d) > Igrac (%s) > IP (%s)", PI[playerid][pID], GetName(playerid), GetPlayerIP(playerid));
				return 1;
			}
			if(response)
			{
				new broj, string[128];
				if(sscanf(inputtext, "i", broj)) return ShowPlayerDialog(playerid, RCON_LOGIN, DIALOG_STYLE_INPUT, ""SERVER"U // "WHITE"RCON PIN", ""SERVER"- "WHITE"Da bi mogli da koristite RCON admina, morate da ukucate sigurnosni RCON PIN\n"SERVER"- "WHITE"Molimo vas da kod unesete taj ispod.", "UNESI", "KICK");
				if(broj != RCON_PIN) return ShowPlayerDialog(playerid, RCON_LOGIN, DIALOG_STYLE_INPUT, ""SERVER"U // "WHITE"RCON PIN", ""SERVER"- "WHITE"Da bi mogli da koristite RCON admina, morate da ukucate sigurnosni RCON PIN\n"SERVER"- "WHITE"Molimo vas da kod unesete taj ispod.", "UNESI", "KICK");

				InfoMessage(playerid, "Uspjesno si se ulogovao kao RCON administrator.");

				format(string, sizeof(string), "RCON // Igrac '%s' se ulogovao kao RCON admin.", GetName(playerid));
				sendMessageToOwner(string);

				Log(rcon_log, INFO, "Uspjesan RCON Login. > SQLID (%d) > Igrac (%s) > IP (%s)", PI[playerid][pID], GetName(playerid), GetPlayerIP(playerid));
			}
			return 1;
		}
		//======================================================================//
		/*case JOIN_DIALOG:
		{
			if(!response) return 1;
			if(response)
			{
				switch(listitem)
				{
					case 0://Arena
					{
						callcmd::dm(playerid, " ");
					}
					case 1://Duel
					{
						callcmd::duel(playerid);
					}
					case 2://Versus
					{
						callcmd::versus(playerid);
					}
				}

			}
			return 1;
		}*/
		//======================================================================//

	}
	#if defined cb_OnDialogResponse
		return cb_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnDialogResponse
	#undef OnDialogResponse
#else
	#define _ALS_OnDialogResponse
#endif

#define OnDialogResponse cb_OnDialogResponse
#if defined cb_OnDialogResponse
	forward cb_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif
//==============================================================================//
public OnPlayerText(playerid, text[])
{
	//=======================================//

	if(!Spawned[playerid])
	{
		ACToPlayer(playerid, "You have to be spawned to use chat.");
		return 0;
	}
	if(PI[playerid][pMute] != 0)
	{
		new str[72];
		format(str, sizeof(str), "You are muted, you can not write in chat. (%ds)", PI[playerid][pMute]);
		ACToPlayer(playerid, str);
		return 0;
	}
	if(ChatTime[playerid] > gettime())
	{
		ACToPlayer(playerid, "Slow down a little with command spawn.");
		return 0;
	}

	//=======================================//

	new string[128];
	stringToLower(text);
	if(PI[playerid][pAdmin] > 0)
		format(string, sizeof(string), "A%d // %s(%d): "WHITE"%s", PI[playerid][pAdmin], GetName(playerid), playerid, text);
	else
		format(string, sizeof(string), "%s // %s(%d): "WHITE"%s", getRankName(PI[playerid][pRank]), GetName(playerid), playerid, text);

	SendClientMessageToAll(GetPlayerColor(playerid), string);

	ChatTime[playerid] = gettime()+1;

	//=======================================//
	#if defined cb_OnPlayerText
		return cb_OnPlayerText(playerid, text);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnPlayerText
	#undef OnPlayerText
#else
	#define _ALS_OnPlayerText
#endif

#define OnPlayerText cb_OnPlayerText
#if defined cb_OnPlayerText
	forward cb_OnPlayerText(playerid, text[]);
#endif
//==============================================================================//
//====================================================================//
public OnPlayerDeath(playerid, killerid, reason)
{
	Spawned[playerid] = false;
	if(killerid != INVALID_PLAYER_ID)
	{
		PI[killerid][pKills]++;
		mySQL_UpdatePlayerCustomVal(killerid, "pKills", PI[killerid][pKills]);
		setupInGameTD(killerid);

		checkLobbyTop5();
	}

	PI[playerid][pDeaths]++;
	mySQL_UpdatePlayerCustomVal(playerid, "pDeaths", PI[playerid][pDeaths]);
	setupInGameTD(playerid);

	PostaviSpawn(playerid);
	SpawnPlayer(playerid);
	SendDeathMessage(killerid, playerid, reason);
	#if defined cb_OnPlayerDeath
		return cb_OnPlayerDeath(playerid, killerid, reason);
	#endif
}
#if defined _ALS_OnPlayerDeath
	#undef OnPlayerDeath
#else
	#define _ALS_OnPlayerDeath
#endif

#define OnPlayerDeath cb_OnPlayerDeath
#if defined cb_OnPlayerDeath
	forward cb_OnPlayerDeath(playerid, killerid, reason);
#endif
//==============================================================================//
public OnPlayerHideCursor(playerid, hovercolor)
{
	if(arenaTDShown[playerid])
	{
		controlArenaTD(playerid, false);
	}
	#if defined cb_OnPlayerHideCursor
		return cb_OnPlayerHideCursor(playerid, hovercolor);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerHideCursor
	#undef OnPlayerHideCursor
#else
	#define _ALS_OnPlayerHideCursor
#endif

#define OnPlayerHideCursor cb_OnPlayerHideCursor
#if defined cb_OnPlayerHideCursor
	forward cb_OnPlayerHideCursor(playerid, hovercolor);
#endif
//==============================================================================//
public OnPlayerPause(playerid)
{
	AFKTime[playerid] = gettime();
	AFKTimer[playerid] = SetTimerEx("AFK", 1000, false, "i", playerid);
	#if defined cb_OnPlayerPause
		return cb_OnPlayerPause(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerPause
	#undef OnPlayerPause
#else
	#define _ALS_OnPlayerPause
#endif

#define OnPlayerPause cb_OnPlayerPause
#if defined cb_OnPlayerPause
	forward cb_OnPlayerPause(playerid);
#endif
//==============================================================================//
public OnPlayerDamage(&playerid, &Float:amount, &issuerid, &weapon, &bodypart)
{
	if(InLobby[playerid]) return 0;

	new string[48];
	format(string, sizeof(string), ""WHITE"-%.2f"RED" by %s", amount, GetName(issuerid));
	SetPlayerChatBubble(playerid, string, -1, 10.0, 2000);
	
	TextDrawShowForPlayer(issuerid, hitMarkerTD);
	SetTimerEx("hitMarkerRemove", 200, false, "i", issuerid);

	#if defined cb_OnPlayerDamage
		return cb_OnPlayerDamage(playerid, Float:amount, issuerid, weapon, bodypart);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDamage
	#undef OnPlayerDamage
#else
	#define _ALS_OnPlayerDamage
#endif

#define OnPlayerDamage cb_OnPlayerDamage
#if defined cb_OnPlayerDamage
	forward cb_OnPlayerDamage(&playerid, &Float:amount, &issuerid, &weapon, &bodypart);
#endif
//==============================================================================//
public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	if(PickupGTC[playerid] > gettime()) return 0;

	// ---------------- //
	if(pickupid == ServerPickup[0])//Online
	{
		new dialog[192];
		format(dialog, sizeof(dialog), "\
			"SERVER"Lobby\t"WHITE"Online\n\
			"SERVER"> "WHITE"Arena\t[ %d ]\n\
			"SERVER"> "WHITE"Duel\t[ %d ]\n\
			"SERVER"> "WHITE"Versus\t[ %d ]\n\n\
			"SERVER"> "WHITE"All\t[ %d ]\n\
			", ServerInfo[arenaPlayers], ServerInfo[duelPlayers], ServerInfo[versusPlayers], ServerInfo[onlinePlayers]);

		ShowPlayerDialog(playerid, JOIN_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, ""SERVER"M:DM > "WHITE"Join", dialog, "JOIN", "CANCEL");
		PickupGTC[playerid] = gettime() + 5;
	}
	// ---------------- //
	else if(pickupid == ServerPickup[1])//Server Stats
	{
		showServerStats(playerid);
		PickupGTC[playerid] = gettime() + 5;
	}
	// ---------------- //
	else if(pickupid == ServerPickup[2])//Enter leaderboard
	{
		InFreeroam[playerid] = false;
		InLobby[playerid] = true;
		TeleportPlayer(playerid, "Leaderboard", 1385.9164, -38.2271, 1000.9553, 269.6595, 0, 0);

		InfoMessage(playerid, "You have just been teleported to leaderboard room. Use pickup to go back to freeroam.");
		PickupGTC[playerid] = gettime() + 3;
	}
	else if(pickupid == ServerPickup[3])//Exit freeroam
	{
		InFreeroam[playerid] = false;
		InLobby[playerid] = true;
		new rand = random(sizeof(RandomSpawn));
		TeleportPlayer(playerid, "Lobby", RandomSpawn[rand][0], RandomSpawn[rand][1], RandomSpawn[rand][2], 357.7274, 0, 0);
		InfoMessage(playerid, "You have just been teleported to lobby.");
		PickupGTC[playerid] = gettime() + 3;
	}
	// ---------------- //
	else if(pickupid == ServerPickup[4])//Enter jail
	{
		TeleportPlayer(playerid, "Jail",  195.3580, 1422.5947, 551.2960, 176.6190, 0, 0);

		InfoMessage(playerid, "You have just been teleported to jail. Use pickup to go back to lobby.");
		PickupGTC[playerid] = gettime() + 3;
	}
	else if(pickupid == ServerPickup[5])//Exit jail
	{
		new rand = random(sizeof(RandomSpawn));
		TeleportPlayer(playerid, "Lobby", RandomSpawn[rand][0], RandomSpawn[rand][1], RandomSpawn[rand][2], 357.7274, 0, 0);

		InfoMessage(playerid, "You have just been teleported to lobby.");
		PickupGTC[playerid] = gettime() + 3;
	}
	// ---------------- //
	else if(pickupid == ServerPickup[6])//Enter freeroam
	{

		InFreeroam[playerid] = true;
		InLobby[playerid] = false;

		TeleportPlayer(playerid, "Freeroam", 785.6559, 2588.4158, 1388.3412, 355.8239, 0, 0);
		InfoMessage(playerid, "You have successfully teleported to freeroam. Use /lobby or pickup to come back.");
		PickupGTC[playerid] = gettime() + 3;
	}
	else if(pickupid == ServerPickup[7])//Exit leaderboard
	{
		InFreeroam[playerid] = true;
		InLobby[playerid] = false;
		TeleportPlayer(playerid, "Freeroam", 1030.1868, 1028.2849, 12.8566, 0.0, 0, 0);
		InfoMessage(playerid, "You have successfully backed to freeroam. Use /lobby or pickup to come back.");
		PickupGTC[playerid] = gettime() + 3;
	}

	// ---------------- //

	#if defined cb_OnPlayerPickUpDynamicPickup
		return cb_OnPlayerPickUpDynamicPickup(playerid, pickupid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerPickUpDynPickup
	#undef OnPlayerPickUpDynamicPickup
#else
	#define _ALS_OnPlayerPickUpDynPickup
#endif

#define OnPlayerPickUpDynamicPickup cb_OnPlayerPickUpDynamicPickup
#if defined cb_OnPlayerPickUpDynamicPickup
	forward cb_OnPlayerPickUpDynamicPickup(playerid, pickupid);
#endif


//==============================================================================//
