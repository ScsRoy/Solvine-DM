//==============================================================================//
/*
	* Module: commands.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
CMD:uptime(playerid)
{
	new days, hours, minutes, seconds;
	ConvertTime(gettime() - GMLoading, days, hours, minutes, seconds);

	if(days) InfoMessage(playerid, "Server uptime since last restart > '%02d:%02d:%02d:%02d'",  days, hours,  minutes, seconds);
	else if(hours) InfoMessage(playerid, "Server uptime since last restart > '%02d:%02d:%02d'",  hours, minutes, seconds);
	else if(minutes) InfoMessage(playerid, "Server uptime since last restart > '%02d:%02d'", minutes, seconds);
	else InfoMessage(playerid, "Server uptime since last restart > '%02d'", seconds);
	return 1;
}
//=======================================//
CMD:forum(playerid)
{
	ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_MSGBOX, ""SERVER"Solvine Deathmatch > "WHITE"Forum", "\
		"SERVER"> "WHITE"Solvine DM forum\n\
		"SERVER"_______________________________________________\n\
		"SERVER"> "WHITE"Link to our forum:\n\
		"SERVER"> "WHITE"coming:soon\n\
		"SERVER"> "WHITE"Visit our forum and register\n\
		"SERVER"> "WHITE"First of all, read rules of the forum\n\
		"SERVER"_______________________________________________\n\
		"SERVER"> "WHITE"Some of rules are:\n\
		"SERVER"> "WHITE"Rule 1\n\
		"SERVER"> "WHITE"Rule 2\n\
		"SERVER"> "WHITE"Rule 3\n\
		"SERVER"> "WHITE"Rule 4\n\
		"SERVER"_______________________________________________\n\
		"SERVER"> "WHITE"Forum created by: "SERVER"@n / a\n\
		"SERVER"_______________________________________________\n\
		", "OKAY", "");
	return 1;
}
//=======================================//
CMD:update(playerid)
{
	ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_MSGBOX, ""SERVER"Solvine Deathmatch > "WHITE"Update", "\
		"SERVER"> "WHITE"List of all changes on last update\n\
		"SERVER"> "WHITE"Currently playing on - "V_MOD"\n\
		"SERVER"> "WHITE"Last update - "ZADNJI_UP"\n\
		"SERVER"> "WHITE"Project started - "PROJECT_STARTED"\n\
		"SERVER"________________________________________\n\
		"GREEN"[ + ] "WHITE"Grand opening\n\
		"SERVER"________________________________________\n\
		"GREEN"[ + ] "WHITE"Added to script\n\
		"RED"[ - ] "WHITE"Removed from script\n\
		"GRAY"[ * ] "WHITE"Changed / fixed bugs\n\
		"SERVER"________________________________________\n\
		", "OKAY", "");
	return 1;
}
//=======================================//
CMD:credits(playerid)
{
	ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_MSGBOX, ""SERVER"Solvine Deathmatch > "WHITE"Credits", "\
		"SERVER"> "WHITE"I apologize in advance if I forgot anyone\n\
		"SERVER"_______________________________________________________\n\
		"SERVER"> "WHITE"Nexius - Nex-AC aka Solvine-AC\n\
		"SERVER"> "WHITE"forum.sa-mp.com - some functions\n\
		"SERVER"> "WHITE"Xunder - Alternative Chat\n\
		"SERVER"_______________________________________________________\n\
		"SERVER"> "WHITE"YourShadow - plugin (Pawn.CMD / Pawn.RakNet)\n\
		"SERVER"> "WHITE"Zeex - plugin (Crash Detect)\n\
		"SERVER"> "WHITE"maddinat0r - plugin (log-plugin / discord-connector)\n\
		"SERVER"> "WHITE"pBlueG - plugin (mysql)\n\
		"SERVER"> "WHITE"Emmet_ - plugin (sscanf)\n\
		"SERVER"> "WHITE"Incognito - plugin (streamer)\n\
		"SERVER"> "WHITE"Slice - plugin (SKY plugin)\n\
		"SERVER"_______________________________________________________\n\
		"SERVER"> "WHITE"GM created by: "SERVER"@Luyn\n\
		"SERVER"_______________________________________________________\n\
		", "OKAY", "");
	return 1;
}
//=======================================//
CMD:rules(playerid)
{
	ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_MSGBOX, ""SERVER"Solvine Deathmatch > "WHITE"Rules", "\
		"SERVER"> "WHITE"Rules of SAMP server\n\
		"SERVER"_______________________________________________________\n\
		"SERVER"[ 1 ] "WHITE"Rule 1\n\
		"SERVER"[ 2 ] "WHITE"Rule 2\n\
		"SERVER"[ 3 ] "WHITE"Rule 3\n\
		"SERVER"[ 4 ] "WHITE"Rule 4\n\
		"SERVER"[ 5 ] "WHITE"Rule 5\n\
		"SERVER"[ 6 ] "WHITE"Rule 6\n\
		"SERVER"_______________________________________________________\n\
		"SERVER"> "WHITE"GM created by: "SERVER"@Suleee\n\
		"SERVER"_______________________________________________________\n\
		", "OKAY", "");
	return 1;
}
//=======================================//
CMD:bug(playerid, params[])
{
	new bug[64], string[192];
	if(sscanf(params, "s[64]", bug)) return UsageMessage(playerid, "bug [Description]");
	if(strlen(bug) > 64) return ErrorMessage(playerid, "Description can not be longer than 64 characters.");

	Log(bug_log, INFO, "Player (%s) > Description (%s)", GetName(playerid), bug);

	#if USE_DISCORD == true
		format(string, sizeof(string), ">>> Player %s(%d) has reported bug.", GetName(playerid), playerid);
		DCC_SendChannelMessage(DiscordInfo[owner_log], string);
		format(string, sizeof(string), ">>> Description > %s.", bug);
		DCC_SendChannelMessage(DiscordInfo[owner_log], string);
	#endif

	format(string, sizeof(string), "BUG // Player %s has reported an bug.", GetName(playerid));
	sendMessageToOwner(string);
	format(string, sizeof(string), "DESCRIPTION // %s.", bug);
	sendMessageToOwner(string);

	SendClientMessage(playerid, COL_SERVER, "BUG // "WHITE"Thank you for reporting bug, you can expect a reward when developer fix bug.");
	return 1;
}
//==============================================================================//
CMD:lastseen(playerid, params[])
{
	new name[MAX_PLAYER_NAME];
	if(sscanf(params, "s[24]", name)) return UsageMessage(playerid, "lastseen [Nickname]");

	new id = GetPlayerIdFromName(name);
	if(IsPlayerConnected(id))
	{
		InfoMessage(playerid, "Player %s(%d) is currently online.", GetName(id), id);
	}
	else
	{
		new query[84], Cache:result;
		mysql_format(DB, query, sizeof(query), "SELECT `pLastLogin` FROM "USER_DB" WHERE `pName`='%s' LIMIT 1", name);
		result = mysql_query(DB, query);
		if(cache_num_rows() > 0)
		{
			new lastlogin[24];
			cache_get_value_name(0, "pLastLogin", lastlogin, 24);

			InfoMessage(playerid, "Player %s is last seen on %s.", name, lastlogin);
		}
		else
		{
			InfoMessage(playerid, "There is no player with that username in database.");
		}

		cache_delete(result);
	}
	return 1;
}
//=======================================//
CMD:id(playerid, params[])
{
	new name[MAX_PLAYER_NAME], x;
	if(sscanf(params, "s[24]", name)) return UsageMessage(playerid, "id [Nickname]");

	InfoMessage(playerid, "Searched result for nickname: %s", name);
	foreach(new i:Player) 
	{
		if(Spawned[i])
		{
			if(strfind(GetName(i), name, true) != -1)
			{
				x++;
				InfoMessage(playerid, "%i > %s [ID: %i]", x, GetName(i), i);
			}
		}
	}

	if(x == 0) return ErrorMessage(playerid, "Currently, there is no online players with that nickname.");
	return 1;
}
alias:id("getid");
//=======================================//
CMD:fps(playerid, params[])
{
	new id;
	if(sscanf(params, "u", id)) return UsageMessage(playerid, "fps [ID/Nick]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(id == playerid) return ErrorMessage(playerid, "Wrong ID.");

	InfoMessage(playerid, "Player: %s // FPS: %d", GetName(id), FPS[id]);
	return 1;
}
//=======================================//
CMD:pl(playerid, params[])
{
	new id;
	if(sscanf(params, "u", id)) return UsageMessage(playerid, "fps [ID/Nick]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(id == playerid) return ErrorMessage(playerid, "Wrong ID.");

	InfoMessage(playerid, "Player: %s // Packet Loss: %.1f", GetName(id), PL[id]);
	return 1;
}
//=======================================//
CMD:admins(playerid)
{
	new str[128], dialog[512], x = 0;
	foreach(new i:Player) 
	{
		if(Spawned[i])
		{
			if(PI[i][pAdmin] > 0)
			{
				format(str, sizeof(str), ""SERVER"[%d] "WHITE"%s(%d)\tLevel %d\n", x+1, GetName(i), i, PI[i][pAdmin]);
				strcat(dialog, str);
				x++;
			}
		}
	}
	if(x == 0) return ErrorMessage(playerid, "Currently, there is no online admins.");
	ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_TABLIST, ""SERVER"Solvine Deathmatch> "WHITE"Online admins", dialog, "OKAY", "");
	return 1;
}
//==============================================================================//
CMD:lobby(playerid)
{
	if(InFreeroam[playerid] && TempVehicle[playerid] != -1)
	{
		DestroyVehicle(TempVehicle[playerid]);
		TempVehicle[playerid] = -1; 
	}

	SpawnEx(playerid);
	return 1;
}
//=======================================//
CMD:changecolor(playerid)
{
	new rand = random(sizeof(PlayerColors));
	SetPlayerColor(playerid, PlayerColors[rand]);

	InfoMessage(playerid, "You have successfully changed your color.");
	SendClientMessage(playerid, GetPlayerColor(playerid), "Solvine Deathmatch // "WHITE"Example to see your new color.");
	return 1;
}
//=======================================//
CMD:skin(playerid, params[])
{
	new skin;
	if(sscanf(params, "i", skin)) return UsageMessage(playerid, "skin [SkinID]");
	if(skin < 1 || skin > 311) return ErrorMessage(playerid, "Skin can no be be bigger than 311 or smaller than 1.");
	if(skin == 1 || skin == 2 || skin == 74 || skin == 86 || skin == 149 || (skin >= 265 && skin <= 272))
	{
		ErrorMessage(playerid, "This skin is not allowed. (%d)", skin);
		return 1;
	}

	PI[playerid][pSkinID] = skin;
	mySQL_UpdatePlayerCustomVal(playerid, "pSkinID", skin);
	SetPlayerSkin(playerid, skin);

	InfoMessage(playerid, "You have successfully changed you skin to %d.", skin);
	return 1;
}
//=======================================//
CMD:toghud(playerid)
{
	if(inGameTDShown[playerid])
	{
		controlInGameTD(playerid, false);
		InfoMessage(playerid, "You have successfully "RED"toggled off"WHITE" hud.");
	}
	else
	{
		controlInGameTD(playerid, true);
		InfoMessage(playerid, "You have successfully "GREEN"toggled on"WHITE" hud.");
	}
	return 1;
}
//=======================================//
CMD:stats(playerid)
{
	if(!InLobby[playerid]) return ErrorMessage(playerid, "You have to be in lobby to use this command.");

	showStats(playerid, playerid);
	return 1;
}
//==============================================================================//
