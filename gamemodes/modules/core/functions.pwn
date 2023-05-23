//==============================================================================//
/*
	* Module: functions.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
bool:isNameScriptDefined(name[])
{
	if(!strcmp(name, "Steven") || !strcmp(name, "")) return true;
	return false;
}
//=======================================//
ACToPlayer(playerid, text[]) 
{
	new str[160];
	format(str, sizeof(str), "(( "WHITE">AC<"ANTICHEAT" - "WHITE"%s"ANTICHEAT" ))", text);
	SendClientMessage(playerid, COL_ANTICHEAT, str);  
	return 1;
}
//=======================================//
/*ACToAll(text[]) 
{
	new str[160];
	format(str, sizeof(str), "(( "WHITE"Sol-Vine-AC"ANTICHEAT" - "WHITE"%s"ANTICHEAT" ))", text);
	SendClientMessageToAll(COL_ANTICHEAT, str);  
	return 1;
}*/
//=======================================//
AC_KillTimer(timerid) 
{
	if(timerid == -1) return 1;
	return KillTimer(timerid);
}
//==============================================================================//
AC_GiveMoney(playerid, value)
{
	PI[playerid][pMoney] += value;
	mySQL_UpdatePlayerCustomVal(playerid, "pMoney", PI[playerid][pMoney]);
	GivePlayerMoney(playerid, value);
	return 1;
}
//=======================================//
AC_SetMoney(playerid, value)
{
	PI[playerid][pMoney] = value;
	mySQL_UpdatePlayerCustomVal(playerid, "pMoney", PI[playerid][pMoney]);

	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, value);
	return 1;	
}
//==============================================================================//
onPlayerKicked(playerid, admin[], reason[])
{
	SpawnEx(playerid);
	
	// ---------------- //

	new day, month, year, hours, minutes, seconds, string[256];
	gettime(hours, minutes, seconds);
	getdate(year, month, day);

	ClearChat(playerid, 20);
	TogglePlayerSpectating(playerid, true);
	controlInGameTD(playerid, false);
	if(sessionTDShown[playerid]) controlSessionTD(playerid, false);
	controlAlertTD(playerid, true);

	format(string, sizeof(string), "You are kicked from Sol-Vine DM!~n~Nickname: %s~n~Date: %d.%d.%d.~n~Time: %d:%d:%d~n~IP: %s~n~Admin: %s~n~Reason: %s", GetName(playerid), day, month, year, hours, minutes, seconds, GetPlayerIP(playerid), admin, reason);
	PlayerTextDrawSetString(playerid, alertPTD, string);

	Log(kick_log, INFO, "SQLID (%d) > Player (%s) > IP (%s) > Admin (%s) > Reason (%s)", PI[playerid][pID], GetName(playerid), GetPlayerIP(playerid), admin, reason);

	#if USE_DISCORD == true
		format(string, sizeof(string), ">>> Kick > Player: %s > IP: %s > Admin: %s", GetName(playerid), GetPlayerIP(playerid), admin, reason);
		DCC_SendChannelMessage(DiscordInfo[staff_log], string);
	#endif

	ServerInfo[serverKikovanih]++;
	mySQL_UpdateServerCustomVal("serverKikovanih", ServerInfo[serverKikovanih]);
	SetTimerEx("kickPlayer", 250, false, "i", playerid);
	return 1;
}
//=======================================//
onPlayerBanned(playerid, ip[], admin[], reason[], days)
{
	SpawnEx(playerid);
	
	// ---------------- //

	static day, month, year, hours, minutes, seconds, string[192], query[192], timestamp;
	gettime(hours, minutes, seconds);
	getdate(year, month, day);

	ClearChat(playerid, 20);
	TogglePlayerSpectating(playerid, true);
	controlInGameTD(playerid, false);
	if(sessionTDShown[playerid]) controlSessionTD(playerid, false);
	controlAlertTD(playerid, true);

	if(days == 0)
	{
		timestamp = 0;
		format(string, sizeof(string), "You are banned from Sol-Vine DM.~n~Nickname: %s~n~IP: %s~n~Admin: %s~n~Reason: %s~n~Time: %d-%02d-%02d %02d:%02d:%02d", GetName(playerid), ip, admin, reason, year, month, day, hours, minutes, seconds);
		PlayerTextDrawSetString(playerid, alertPTD, string);
	}
	else
	{
		timestamp = gettime() + (days * (60 * 60 * 24));
		format(string, sizeof(string), "You are temporarily banned from Sol-Vine DM.~n~Nickname: %s~n~IP: %s~n~Admin: %s~n~Reason: %s~n~Days banned: %d~n~Time: %d-%02d-%02d %02d:%02d:%02d", GetName(playerid), ip, admin, reason, days, year, month, day, hours, minutes, seconds);
		PlayerTextDrawSetString(playerid, alertPTD, string);
	}

	Log(ban_log, INFO, "SQLID (%d) > Player (%s) > IP (%s) > Admin (%s) > Reason (%s)", PI[playerid][pID], GetName(playerid), ip, admin, reason);

	#if USE_DISCORD == true
		format(string, sizeof(string), ">>> Ban > Player: %s > IP: %s > Admin: %s > Reason: %s", GetName(playerid), ip, admin, reason);
		DCC_SendChannelMessage(DiscordInfo[staff_log], string);
	#endif

	mysql_format(DB, query, sizeof(query), "INSERT INTO "BAN_DB" (`banName`, `banIP`, `banAdmin`, `banReason`, `banDate`, `banTime`) VALUES ('%s', '%s', '%s', '%s', NOW(), '%d')", GetName(playerid), ip, admin, reason, timestamp);
	mysql_tquery(DB, query);
	
	ServerInfo[serverBanovanih]++;
	mySQL_UpdateServerCustomVal("serverBanovanih", ServerInfo[serverBanovanih]);
	SetTimerEx("kickPlayer", 250, false, "i", playerid);
	return 1;
}
//=======================================//
function kickPlayer(playerid)
{ 
	return Kick(playerid);
}
//==============================================================================//
function CountDown(id, seconds)
{
	if(seconds > 0)
	{
		new string[4];
		seconds--;
		format(string, sizeof(string), "%d", seconds);
		if(seconds == 0)
		{
			PlayerTextDrawHide(id, CountDownTD[0]);
			PlayerTextDrawColor(id, CountDownTD[0], COL_GREEN);
			PlayerTextDrawShow(id, CountDownTD[0]);

			PlayerTextDrawShow(id, CountDownTD[1]);
			PlayerTextDrawSetString(id, CountDownTD[1], "go");
			TogglePlayerControllable(id, true);
		}
		else if(seconds == 1 || seconds == 2)
		{
			PlayerTextDrawHide(id, CountDownTD[0]);
			PlayerTextDrawColor(id, CountDownTD[0], COL_ORANGE);
			PlayerTextDrawShow(id, CountDownTD[0]);

			PlayerTextDrawShow(id, CountDownTD[1]);
			PlayerTextDrawSetString(id, CountDownTD[1], string);
		}
		else
		{
			PlayerTextDrawHide(id, CountDownTD[0]);
			PlayerTextDrawColor(id, CountDownTD[0], COL_RED);
			PlayerTextDrawShow(id, CountDownTD[0]);

			PlayerTextDrawShow(id, CountDownTD[1]);
			PlayerTextDrawSetString(id, CountDownTD[1], string);
		}

		SetTimerEx("CountDown", 1000, false, "ii", id, seconds);
		return 1;
	}
	else
	{
		PlayerTextDrawHide(id, CountDownTD[0]);
		PlayerTextDrawHide(id, CountDownTD[1]);
	}
	return 1;
}
//=======================================//
CountDownForAll(seconds)
{
	foreach(new i:Player)
	{
		TogglePlayerControllable(i, false);
		CountDown(i, seconds);
	}
	return 1;
}
//==============================================================================//
ConvertTime(time, &days, &hours, &minutes, &seconds)
{
	seconds = time % 60;
	time = time / 60;
	minutes = time % 60;
	time = time / 60;
	hours = time % 24;
	time = time / 24;
	days = time;
}
//==============================================================================//
SendClientMessageEx(playerid, color, const str[], {Float,_}:...) 
{
	static
		args,
		start,
		end,
		string[144];
		
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if(args > 12)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

		for (end = start + (args - 12); end > start; end -= 4)
		{
			#emit LREF.pri end
			#emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string
		#emit PUSH.C args
		#emit SYSREQ.C format

		SendClientMessage(playerid, color, string);

		#emit LCTRL 5
		#emit SCTRL 4
		#emit RETN
	}
	return SendClientMessage(playerid, color, str);
}
//==============================================================================//
GetName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	return name;
}
//=======================================//
GetPlayerIP(playerid)
{
	new ip[24];
	GetPlayerIp(playerid, ip, sizeof(ip));
	return ip;
}
//=======================================//
/*bool:IsValidEmail(const email[])
{
	new at_pos = strfind(email, "@", true);
	if(at_pos >= 1)
	{
		new offset = (at_pos + 1), dot_pos = strfind(email, ".", true, offset);
		if(dot_pos > offset)
		{
			return true;
		}
	}
	return false;
}*/
//=======================================//
IsNumeric(const string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}
//=======================================//
stringToLower(s[])
{
    for(new i = 0; s[i] != EOS; i++)
        s[i] = ((s[i] > 31) && (s[i] < 59)) ? (s[i]) : (tolower(s[i]));
}
//=======================================//
GetModelVehicle(vname[])
{
	for(new i = 0; i < 211; i++)
	{
		if(strfind(ImeVozila[i], vname, true) != -1) return i + 400;
	}
	return -1;
}
//=======================================//
GetPlayerIdFromName(playername[]) 
{
	foreach(new i:Player) 
		if(Spawned[i])
			if(strcmp(GetName(i), playername, true, strlen(playername)) == 0)
				return i;
	return INVALID_PLAYER_ID;
}
//=======================================//
getMonthName()
{
	new temp, month, name[24];
	getdate(temp, month, temp);
	switch(month)
	{
        case 1:  name = "January";
        case 2:  name = "February";
        case 3:  name = "March";
        case 4:  name = "April";
        case 5:  name = "May";
        case 6:  name = "June";
        case 7:  name = "July";
        case 8:  name = "August";
        case 9:  name = "September";
        case 10: name = "October";
        case 11: name = "November";
        case 12: name = "December";
	}
	return name;
}
//==============================================================================//
function TeleportPlayer(playerid, name[], Float:X, Float:Y, Float:Z, Float:A, intID, vwID)
{
	new str[48];
	if(!IsPlayerInAnyVehicle(playerid))
	{
		SetPlayerInterior(playerid, intID);
		SetPlayerVirtualWorld(playerid, vwID);
		SetPlayerPos(playerid, X, Y, Z);
		SetPlayerFacingAngle(playerid, A);
	}
	else
	{
		LinkVehicleToInterior(GetPlayerVehicleID(playerid), intID);
		SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), vwID);
		SetVehiclePos(GetPlayerVehicleID(playerid), X, Y, Z);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), A);
	}
	format(str, sizeof(str), "~b~%s", name);
	GameTextForPlayer(playerid, str, 4500, 4);
	TogglePlayerControllable(playerid, false);
	SetCameraBehindPlayer(playerid);
	SetTimerEx("SlobodnoSada", 2500, false, "i", playerid);
	return 1;
}
//=======================================//
function SlobodnoSada(playerid)
{
	GameTextForPlayer(playerid, "~b~Loaded...", 2500, 4);
	TogglePlayerControllable(playerid, true);
	return 1;
}
//==============================================================================//
function AFK(playerid)
{
	if(IsPlayerPaused(playerid))
	{
		new days, hours, minutes, seconds, string[24];
		ConvertTime(gettime() - AFKTime[playerid], days, hours, minutes, seconds);
		format(string, sizeof(string), "// %02d:%02d:%02d:%02d //", days, hours, minutes, seconds);
		SetPlayerChatBubble(playerid, string, COL_SERVER, 20.0, 1000);

		AFKTimer[playerid] = SetTimerEx("AFK", 1000, false, "i", playerid);
	}
	else
	{
		AC_KillTimer(AFKTimer[playerid]);
	}
	return 1;
}
//==============================================================================//
Float:calculateRankPoints(playerid)
{
	new Float:points = 0.0;
	points += PI[playerid][pArenaKills] * 1.0;
	points -= PI[playerid][pArenaDeaths] * 0.5;

	points += PI[playerid][pDuelWins] * 1.0;
	points -= PI[playerid][pDuelDefeats] * 0.5;

	points += PI[playerid][pVersusWins] * 1.0;
	points -= PI[playerid][pVersusDefeats] * 0.5;

	if(PI[playerid][pPremium])
	{
		points += PI[playerid][pDayWins] * 2.5;
		points += PI[playerid][pMonthWins] * 5.0;
	}
	else
	{
		points += PI[playerid][pDayWins] * 4.0;
		points += PI[playerid][pMonthWins] * 8.0;
	}
	return points;
}
//==============================================================================//
function hitMarkerRemove(playerid)
{
	return TextDrawHideForPlayer(playerid, hitMarkerTD);
}
//==============================================================================//
