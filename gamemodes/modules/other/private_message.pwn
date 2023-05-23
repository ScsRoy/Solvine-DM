//==============================================================================//
/*
	* Module: private_message.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
CMD:togpm(playerid, params[])
{
	if(PMEnabled[playerid] == true)
	{
		PMEnabled[playerid] = false;
		InfoMessage(playerid, "You have successfully "RED"disabled"WHITE" private messages.");
	}
	else 
	{
		PMEnabled[playerid] = true;
		InfoMessage(playerid, "You have successfully "GREEN"enabled"WHITE" private messages.");
	}
	return 1;
}
//==============================================================================//
CMD:pm(playerid, params[])
{ 
	if(PI[playerid][pMute] != 0) return ErrorMessage(playerid, "You can not use this command while you are muted.");
	if(!PMEnabled[playerid]) return ErrorMessage(playerid, "You have disabled private messages.");
	new id, msg[72];
	if(sscanf(params, "us[72]", id, msg)) return UsageMessage(playerid, "pm [ID/Ime] [Text]");
	if(id == INVALID_PLAYER_ID || id == playerid) return ErrorMessage(playerid, "Wrong ID.");
	if(!Spawned[id]) return ErrorMessage(playerid, "That player is not spawned.");
	if(!PMEnabled[id]) return ErrorMessage(playerid, "That player has disabled private messages.");

	SendClientMessageEx(id, COL_RED, "PM // "WHITE"Received"RED" // "WHITE"%s(%d)"RED" // "WHITE"%s", GetName(playerid), playerid, msg);
	SendClientMessageEx(playerid, COL_RED, "PM // "WHITE"Sent"RED" // "WHITE"%s(%d)"RED" // "WHITE"%s", GetName(id), id, msg);

	LastPM[playerid] = id;
	LastPM[id] = playerid;
	PMPregled(playerid, msg, id);
	return 1;
}
//=======================================//
CMD:r(playerid, params[])
{
	if(PI[playerid][pMute] != 0) return ErrorMessage(playerid, "You can not use this command while you are muted.");
	if(!PMEnabled[playerid]) return ErrorMessage(playerid, "You have disabled private messages.");
	if(LastPM[playerid] == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	new id = LastPM[playerid], msg[72];
	if(sscanf(params, "s[72]", msg)) return UsageMessage(playerid, "r [Text]");
	if(!PMEnabled[id]) return ErrorMessage(playerid, "That player has disabled private messages.");

	SendClientMessageEx(id, COL_RED, "PM // "WHITE"Received"RED" // "WHITE"%s(%d)"RED" // "WHITE"%s", GetName(playerid), playerid, msg);
	SendClientMessageEx(playerid, COL_RED, "PM // "WHITE"Sent"RED" // "WHITE"%s(%d)"RED" // "WHITE"%s", GetName(id), id, msg);

	LastPM[playerid] = id;
	LastPM[id] = playerid;
	PMPregled(playerid, msg, id);
	return 1;
}
//==============================================================================//
PMPregled(playerid, text[], id)
{ 
	new str[160];
	format(str, sizeof(str), "~b~~h~(PM)~w~ %s -> %s:~b~~h~ %s", GetName(playerid), GetName(id), text);
	foreach(new i:Player)
	{
		if(Spawned[i])
		{
			if(WarnChat[i] && PMPreview[i] && PI[i][pAdmin] == 3)
			{
				if(!isAltChatToggled(i)) toggleAltChat(i);
				sendAltChatMessage(i, str);
			}
		}
	}
	Log(pm_log, INFO, "%s --> %s: %s", GetName(playerid), GetName(id), text);
	return 1;
}
//==============================================================================//