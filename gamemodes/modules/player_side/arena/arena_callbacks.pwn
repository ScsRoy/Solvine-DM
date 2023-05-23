//==============================================================================//
/*
	* Module: arena_callbacks.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		//======================================================================//
		case CREATE_ARENA:
		{
			if(!response) return 1;
			if(response)
			{
				new id = Iter_Free(ArenaList);
				if(id == -1) 
				{
					ErrorMessage(playerid, "Limit of arenas reached, please contact developer!");
					#if USE_DISCORD == true
						DCC_SendChannelMessage(DiscordInfo[owner_log], ">>> Limit reached > ARENA!");
					#endif
					return 1;
				}
				new name[24];
				if(sscanf(inputtext, "s[24]", name)) return ShowPlayerDialog(playerid, CREATE_ARENA, DIALOG_STYLE_INPUT, ""ORANGE"SOLVINE:DM > "WHITE"Arena [Create]", ""ORANGE"> "WHITE"Please, enter name of new arena:", "ENTER", "CANCEL");

				new query[128];
				Iter_Add(ArenaList, id);
				ArenaInfo[id][arenaID] = id;
				strmid(ArenaInfo[id][arenaName], name, 0, strlen(name));
				ArenaInfo[id][arenaIntID] = GetPlayerInterior(playerid);
				ArenaInfo[id][arenaVWID] = GetPlayerVirtualWorld(playerid);
				mysql_format(DB, query, sizeof(query), "INSERT INTO "ARENA_DB" SET `arenaID`=%d, `arenaName`='%s', `arenaIntID`=%d, `arenaVWID`=%d", id, name, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid)	);
				mysql_tquery(DB, query);

				CreatingArena[playerid] = id;
				InfoMessage(playerid, "You have successfully entered name for new arena. (%s)", name);
				ShowPlayerDialog(playerid, ARENA_WEAPONS, DIALOG_STYLE_INPUT, ""ORANGE"SOLVINE:DM > "WHITE"Arena [Create]", ""ORANGE"> "WHITE"Now, please enter 3 WeaponID for new arena:", "ENTER", "");
			}
			return 1;
		}
		//======================================================================//
		case ARENA_WEAPONS:
		{
			if(!response || response)
			{
				new id = CreatingArena[playerid], weap1, weap2, weap3;
				if(sscanf(inputtext, "iii", weap1, weap2, weap3)) return ShowPlayerDialog(playerid, ARENA_WEAPONS, DIALOG_STYLE_INPUT, ""ORANGE"SOLVINE:DM > "WHITE"Arena [Create]", ""ORANGE"> "WHITE"Now, please enter 3 WeaponID for new arena:", "ENTER", "");
				if(!IsValidWeapon(weap1)) return ShowPlayerDialog(playerid, ARENA_WEAPONS, DIALOG_STYLE_INPUT, ""ORANGE"SOLVINE:DM > "WHITE"Arena [Create]", ""ORANGE"> "WHITE"Now, please enter 3 WeaponID for new arena:", "ENTER", "");
				if(!IsValidWeapon(weap2)) return ShowPlayerDialog(playerid, ARENA_WEAPONS, DIALOG_STYLE_INPUT, ""ORANGE"SOLVINE:DM > "WHITE"Arena [Create]", ""ORANGE"> "WHITE"Now, please enter 3 WeaponID for new arena:", "ENTER", "");
				if(!IsValidWeapon(weap3)) return ShowPlayerDialog(playerid, ARENA_WEAPONS, DIALOG_STYLE_INPUT, ""ORANGE"SOLVINE:DM > "WHITE"Arena [Create]", ""ORANGE"> "WHITE"Now, please enter 3 WeaponID for new arena:", "ENTER", "");
			
				new query[128];
				ArenaInfo[id][arenaWeapon1] = weap1;
				ArenaInfo[id][arenaWeapon2] = weap2;
				ArenaInfo[id][arenaWeapon3] = weap3;
				mysql_format(DB, query, sizeof(query), "UPDATE "ARENA_DB" SET `arenaWeapon1`=%d, `arenaWeapon2`=%d, `arenaWeapon3`=%d WHERE `arenaID`=%d", weap1, weap2, weap3, id);
				mysql_tquery(DB, query);

				CreatingStep[playerid] = 0;
				InfoMessage(playerid, "You have successfully entered 3 weapons for new arena. (%d, %d, %d)", weap1, weap2, weap3);
				InfoMessage(playerid, "Now go on spawn point (1) and press ~k~~PED_FIREWEAPON~ to create one of spawn points.");
			}
			return 1;
		}
		//======================================================================//
	}
	
	#if defined arena_OnDialogResponse
		return arena_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnDialogResponse
	#undef OnDialogResponse
#else
	#define _ALS_OnDialogResponse
#endif

#define OnDialogResponse arena_OnDialogResponse
#if defined arena_OnDialogResponse
	forward arena_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif
//==============================================================================//
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_FIRE))
	{
		if(CreatingArena[playerid] != -1 && CreatingStep[playerid] != -1)
		{
			if(IsPlayerInAnyVehicle(playerid)) return ErrorMessage(playerid, "You have to be outside vehicle to create spawn point.");

			new arena = CreatingArena[playerid], 
				slot = CreatingStep[playerid],
				Float:X,
				Float:Y,
				Float:Z,
				Float:A;

			GetPlayerPos(playerid, X, Y, Z);
			GetPlayerFacingAngle(playerid, A);

			ArenaInfo[arena][arenaX][slot] = X;
			ArenaInfo[arena][arenaY][slot] = Y;
			ArenaInfo[arena][arenaZ][slot] = Z;
			ArenaInfo[arena][arenaA][slot] = A;
			mySQL_UpdateArenaPos(arena, slot);

			if(CreatingStep[playerid] == MAX_ARENA_POS-1)
			{
				InfoMessage(playerid, "You have successfully created new spawn point. (%d / %d)", MAX_ARENA_POS, MAX_ARENA_POS);
				InfoMessage(playerid, "You are finished creating new arena.");

				new query[160];
				ArenaInfo[arena][arenaKSRecord] = 0;
				strmid(ArenaInfo[arena][arenaKSRecorder], "None", 0, strlen("None"));
				ArenaInfo[arena][arenaKillsRecord] = 0;
				strmid(ArenaInfo[arena][arenaKillsRecorder], "None", 0, strlen("None"));

				mysql_format(DB, query, sizeof(query), "UPDATE "ARENA_DB" SET `arenaKSRecord`=0, `arenaKSRecorder`='None', `arenaKillsRecord`=0, `arenaKillsRecorder`='None' WHERE `arenaID`=%d", arena);
				mysql_tquery(DB, query);

				CreatingArena[playerid] = -1;
				CreatingStep[playerid] = -1;
				return 1;
			}
			else
			{
				InfoMessage(playerid, "You have successfully created new spawn point. (%d / %d)", CreatingStep[playerid]+1, MAX_ARENA_POS);
				InfoMessage(playerid, "Now go on spawn point (%d) and press ~k~~PED_FIREWEAPON~ to create one of spawn points.", CreatingStep[playerid]+2);
			}

			CreatingStep[playerid]++;
		}
	}
	
	#if defined arena_OnPlayerKeyStateChange
		return arena_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange arena_OnPlayerKeyStateChange
#if defined arena_OnPlayerKeyStateChange
	forward arena_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif
//==============================================================================//
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(arenaTDShown[playerid])
	{
		//======================================================================//
		if(clickedid == arenaTD[8])//Previous
		{
			if(ChosenArena[playerid] == 0) return ErrorMessage(playerid, "You cant go to left anymore.");
			if(!Iter_Contains(ArenaList, ChosenArena[playerid]-1)) return ErrorMessage(playerid, "You cant go to left anymore.");
			ChosenArena[playerid]--;

			setupArenaTD(playerid, ChosenArena[playerid]);
			return 1;
		}
		//======================================================================//
		else if(clickedid == arenaTD[9])//Next
		{
			if(ChosenArena[playerid] == MAX_ARENA-1) return ErrorMessage(playerid, "You cant go to right anymore.");
			if(!Iter_Contains(ArenaList, ChosenArena[playerid]+1)) return ErrorMessage(playerid, "You cant go to right anymore.");
			ChosenArena[playerid]++;

			setupArenaTD(playerid, ChosenArena[playerid]);
			return 1;
		}
		//======================================================================//
		else if(clickedid == arenaTD[5])//Join
		{
			new id = ChosenArena[playerid];
			if(ArenaInfo[id][arenaLocked]) return ErrorMessage(playerid, "This arena is locked by admin.");
			if(ArenaInfo[id][arenaOnline] >= 10 && !PI[playerid][pPremium]) return ErrorMessage(playerid, "That arena is full. (%d / 10)", ArenaInfo[id][arenaOnline]);

			controlArenaTD(playerid, false);
			enterArena(playerid, id);
			return 1;
		}
		//======================================================================//
	}
	
	#if defined arena_OnPlayerClickTextDraw
		return arena_OnPlayerClickTextDraw(playerid, clickedid);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnPlayerClickTextDraw
	#undef OnPlayerClickTextDraw
#else
	#define _ALS_OnPlayerClickTextDraw
#endif

#define OnPlayerClickTextDraw arena_OnPlayerClickTextDraw
#if defined arena_OnPlayerClickTextDraw
	forward arena_OnPlayerClickTextDraw(playerid, Text:clickedid);
#endif
//==============================================================================//
public OnPlayerDeath(playerid, killerid, reason)
{
	if(EnteredArena[playerid] != -1)
	{
		new id = EnteredArena[playerid];
		SessionInfo[playerid][sessionDeaths]++;
		SessionInfo[playerid][sessionKS] = 0;
		setupInGameTD(playerid);

		PI[playerid][pArenaDeaths]++;
		mySQL_UpdatePlayerCustomVal(playerid, "pArenaDeaths", PI[playerid][pArenaDeaths]);
		checkRankPoint(playerid);

		if(killerid != INVALID_PLAYER_ID)
		{
			if(EnteredArena[killerid] == id)
			{
				SessionInfo[playerid][sessionDC] = true;
				SessionInfo[playerid][sessionKiller] = killerid;

				SessionInfo[killerid][sessionKills]++;
				SessionInfo[killerid][sessionKS]++;
				setupInGameTD(killerid);

				if(SessionInfo[killerid][sessionKS] > ArenaInfo[id][arenaKSRecord])
				{
					ArenaInfo[id][arenaKSRecord] = SessionInfo[killerid][sessionKS];
					mySQL_UpdateArenaCustomVal(id, "arenaKSRecord", ArenaInfo[id][arenaKSRecord]);

					strmid(ArenaInfo[id][arenaKSRecorder], GetName(killerid), 0, strlen(GetName(killerid)));
					mySQL_UpdateArenaCustomStr(id, "arenaKSRecorder", ArenaInfo[id][arenaKSRecorder]);

					new str[128];
					format(str, sizeof(str), "SOLVINE:DM // "WHITE"New record - Arena %s(%d) - KS (%d - %s)", ArenaInfo[id][arenaName], id, SessionInfo[killerid][sessionKS], GetName(killerid));
					SendClientMessageToAll(COL_SERVER, str);
				}

				if(SessionInfo[killerid][sessionKills] > ArenaInfo[id][arenaKillsRecord])
				{
					ArenaInfo[id][arenaKillsRecord] = SessionInfo[killerid][sessionKills];
					mySQL_UpdateArenaCustomVal(id, "arenaKillsRecord", ArenaInfo[id][arenaKillsRecord]);

					strmid(ArenaInfo[id][arenaKillsRecorder], GetName(killerid), 0, strlen(GetName(killerid)));
					mySQL_UpdateArenaCustomStr(id, "arenaKillsRecorder", ArenaInfo[id][arenaKillsRecorder]);
					
					new str[128];
					format(str, sizeof(str), "SOLVINE:DM // "WHITE"New record - Arena %s(%d) - Kills (%d - %s)", ArenaInfo[id][arenaName], id, SessionInfo[killerid][sessionKills], GetName(killerid));
					SendClientMessageToAll(COL_SERVER, str);
				}

				PI[killerid][pArenaKills]++;
				mySQL_UpdatePlayerCustomVal(killerid, "pArenaKills", PI[killerid][pArenaKills]);
				checkRankPoint(killerid);
			}
		}
	}
	#if defined arena_OnPlayerDeath
		return arena_OnPlayerDeath(playerid, killerid, reason);
	#endif
}
#if defined _ALS_OnPlayerDeath
	#undef OnPlayerDeath
#else
	#define _ALS_OnPlayerDeath
#endif

#define OnPlayerDeath arena_OnPlayerDeath
#if defined arena_OnPlayerDeath
	forward arena_OnPlayerDeath(playerid, killerid, reason);
#endif
//==============================================================================//
public OnPlayerDisconnect(playerid, reason)
{
	if(EnteredArena[playerid] != -1)
		leaveArena(playerid);
	
	#if defined arena_OnPlayerDisconnect
		return arena_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect arena_OnPlayerDisconnect
#if defined arena_OnPlayerDisconnect
	forward arena_OnPlayerDisconnect(playerid, reason);
#endif
//==============================================================================//
public OnPlayerPause(playerid)
{
	if(EnteredArena[playerid] != -1)
		SetTimerEx("arenaKickAFK", 20000, false, "i", playerid);
	
	#if defined arena_OnPlayerPause
		return arena_OnPlayerPause(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerPause
	#undef OnPlayerPause
#else
	#define _ALS_OnPlayerPause
#endif

#define OnPlayerPause arena_OnPlayerPause
#if defined arena_OnPlayerPause
	forward arena_OnPlayerPause(playerid);
#endif
//==============================================================================//