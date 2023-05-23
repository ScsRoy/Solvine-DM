//==============================================================================//
/*
	* Module: admin_commands.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
CMD:ahelp(playerid)
{
	if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");

	ShowAdminHelp(playerid, PI[playerid][pAdmin]);
	return 1;
}
alias:ahelp("ah", "adminhelp");
//==============================================================================//A1 	[Game Admin]
CMD:asay(playerid, params[])
{
	if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new msg[128], str[128];
	if(sscanf(params, "s[128]", msg)) return UsageMessage(playerid, "asay [Text]");
	if(strlen(msg) > 128) return ErrorMessage(playerid, "Text can not be longer than 128 characters.");

	format(str, sizeof(str), "A | "WHITE"Admin "SERVER"%s:"WHITE" %s", GetName(playerid), msg);
	SendClientMessageToAll(COL_SERVER, str);
	return 1;
}
//=======================================//
CMD:a(playerid, params[])
{
	if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new text[128], str[192];
	if(sscanf(params, "s[128]", text)) return UsageMessage(playerid, "a [Text]");
	if(strlen(text) > 128) return ErrorMessage(playerid, "Text can not be longer than 128 characters.");

	format(str, sizeof(str), "%s | "SERVER"%s:"WHITE" %s", GetAdminRankName(playerid), GetName(playerid), text);
	sendMessageToAdmin(str);
	return 1;
}
//=======================================//
CMD:cc(playerid)
{
	if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(gettime() < ClearChatTimer) return ErrorMessage(playerid, "Chat can be claered every 10 seconds.");
	ClearChatTimer = gettime()+10;

	for(new i = 0; i < 25; i++) SendClientMessageToAll(-1, " ");
	SendClientMessageToAll(COL_SERVER, "Solvine Deathmatch // "WHITE"Staff Team has cleared chat.");
	SendClientMessageToAll(COL_SERVER, "Solvine Deathmatch // "WHITE"Cleared !");

	APregled(playerid, "CC");
	return 1;
}
//=======================================//
CMD:weapons(playerid, params[])
{
	if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id;
	if(sscanf(params, "u", id)) return UsageMessage(playerid, "weapons [ID/Nick]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	new str[64], dialog[512], weapon, bullets;

	strcat(dialog, ""WHITE"Slot / Weapon\t"SERVER"Ammo\n");
	for(new slot = 0; slot < 13; slot++)
	{
		GetPlayerWeaponData(playerid, slot, weapon, bullets);
		format(str, sizeof(str), ""SERVER"[%d]\t"WHITE"%s\t"SERVER"%d\n", slot, WeaponInfo[weapon][wName], bullets);
		strcat(dialog, str);
	}
	ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_TABLIST, ""SERVER"Solvine Deathmatch > "WHITE"Weapons", dialog, "OKAY", "");

	APregled(playerid, "WEAPONS");
	return 1;
}
//=======================================//
CMD:ip(playerid, params[])
{
	if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id;
	if(sscanf(params, "u", id)) return UsageMessage(playerid, "ip [ID/Nick]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return ErrorMessage(playerid, "You can not do that to admin bigger level.");

	AMessage(playerid, "Player "SERVER"%s"WHITE" | IP: %s  ", GetName(id), GetPlayerIP(id));

	APregled(playerid, "IP");
	return 1;
}
//=======================================//
CMD:get(playerid, params[])
{
	if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id, Float:X, Float:Y, Float:Z;
	if(sscanf(params, "u", id)) return UsageMessage(playerid, "get [ID/Nick]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return ErrorMessage(playerid, "You can not do that to admin bigger level.");

	GetPlayerPos(playerid, X, Y, Z);
	SetPlayerPos(id, X+1, Y+1, Z);
	SetPlayerInterior(id, GetPlayerInterior(playerid));
	SetPlayerVirtualWorld(id, GetPlayerVirtualWorld(playerid));

	AMessage(id, "Admin "SERVER"%s"WHITE" has teleported you to him.", GetName(playerid));
	AMessage(playerid, "You teleported "SERVER"%s"WHITE" to yourself.", GetName(id));

	APregled(playerid, "GET");
	return 1;
}
alias:get("gethere");
//=======================================//
CMD:slap(playerid, params[])
{
	if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id, Float:X, Float:Y, Float:Z;
	if(sscanf(params,"u", id)) return UsageMessage(playerid, "slap [ID/Nick]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return ErrorMessage(playerid, "You can not do that to admin bigger level.");

	GetPlayerPos(id, X, Y, Z);
	SetPlayerPos(id, X, Y, Z+5);

	AMessage(id, "Admin "SERVER"%s"WHITE" has slapped you.", GetName(playerid));
	AMessage(playerid, "Player "SERVER"%s"WHITE" is successfully slapped.", GetName(id));

	APregled(playerid, "SLAP");
	return 1;
}
//=======================================//
CMD:freeze(playerid, params[])
{
	if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id;
	if(sscanf(params, "u", id)) return UsageMessage(playerid, "freeze [ID/Nick]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return ErrorMessage(playerid, "You can not do that to admin bigger level.");

	TogglePlayerControllable(id, false);
	AMessage(id, "Admin "SERVER"%s"WHITE" has frozen you.", GetName(playerid));
	AMessage(playerid, "Player "SERVER"%s"WHITE" is successfully frozen.", GetName(id));

	APregled(playerid, "FREEZE");
	return 1;
}
//=======================================//
CMD:unfreeze(playerid, params[])
{
	if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id;
	if(sscanf(params, "u", id)) return UsageMessage(playerid, "unfreeze [ID/Nick]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return ErrorMessage(playerid, "You can not do that to admin bigger level.");

	TogglePlayerControllable(id, true);
	AMessage(id, "Admin "SERVER"%s"WHITE" has unfrozen you.", GetName(playerid));
	AMessage(playerid, "Player "SERVER"%s"WHITE" is successfully unfrozen.", GetName(id));

	APregled(playerid, "UNFREEZE");
	return 1;
}
//=======================================//
CMD:mute(playerid, params[])
{
	if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id, vrijeme, reason[16];
	if(sscanf(params, "uis[16]", id, vrijeme, reason)) return UsageMessage(playerid, "mute [ID/Nick] [Vrijeme] [Reason]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return ErrorMessage(playerid, "You can not do that to admin bigger level.");
	if(vrijeme < 1 || vrijeme > 999) return ErrorMessage(playerid, "Time can not be smaller than 1 or bigger than 999.");

	mySQL_MutePlayer(id, vrijeme, reason);

	AMessage(id, "Admin "SERVER"%s"WHITE" has muted you on %dm.", GetName(playerid), vrijeme);
	AMessage(id, "Reason: "SERVER"%s.", reason);

	AMessage(playerid, "Player "SERVER"%s"WHITE" is successfully muted on %dmin", GetName(id), vrijeme);
	AMessage(playerid, "Reason: "SERVER"%s.", reason);

	APregled(playerid, "MUTE");
	return 1;
}
//=======================================//
CMD:unmute(playerid, params[])
{
	if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id;
	if(sscanf(params, "u", id)) return UsageMessage(playerid, "unmute [ID/Nick]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(!PI[playerid][pMute]) return ErrorMessage(playerid, "That player is not muted.");

	mySQL_UnMutePlayer(id);

	AMessage(id, "Admin "SERVER"%s"WHITE" has unmuted you.", GetName(playerid));
	AMessage(playerid, "Player "SERVER"%s"WHITE" is successfully unmuted.", GetName(id));

	APregled(playerid, "UNMUTE");
	return 1;
}
//=======================================//
CMD:spec(playerid, params[])
{
	if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");

	new id;
	if(sscanf(params, "u", id)) return UsageMessage(playerid, "spec [ID/Nick]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(id == playerid) return ErrorMessage(playerid, "Wrong ID.");
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return ErrorMessage(playerid, "You can not do that to admin bigger level.");
	Spectate[playerid] = id;

	if(Spectate[playerid] != INVALID_PLAYER_ID)
	{
		GetPlayerPos(playerid, SpecX[playerid], SpecY[playerid], SpecZ[playerid]);
		GetPlayerFacingAngle(playerid, SpecA[playerid]);
		SpecVW[playerid] = GetPlayerVirtualWorld(playerid);
		SpecInt[playerid] = GetPlayerInterior(playerid);
	}
	Spectate[playerid] = id;

	AdminInfo[playerid][adminSpec]++;
	mySQL_UpdateAdminCustomVal(playerid, "adminSpec", AdminInfo[playerid][adminSpec]);

	AMessage(playerid, "You started spectating "SERVER"%s", GetName(id));
	AMessage(playerid, "/specoff to Out from spectate");

	APregled(playerid, "SPEC");
	return 1;
}
//=======================================//
CMD:specoff(playerid, params[])
{
	if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(Spectate[playerid] == INVALID_PLAYER_ID) return ErrorMessage(playerid, "You are not spectating anyone.");
	Spectate[playerid] = INVALID_PLAYER_ID;

	TogglePlayerSpectating(playerid, false);
	TogglePlayerControllable(playerid, true);
	SetPlayerPos(playerid, SpecX[playerid], SpecY[playerid], SpecZ[playerid]);
	SetPlayerFacingAngle(playerid, SpecA[playerid]);
	SetPlayerInterior(playerid, SpecInt[playerid]);
	SetPlayerVirtualWorld(playerid, SpecVW[playerid]);

	AMessage(playerid, "You have finished spectating.");
	APregled(playerid, "SPECOFF");
	return 1;
}
//=======================================//
CMD:jail(playerid, params[])
{
	if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id, vrijeme, reason[16];
	if(sscanf(params, "uis[16]", id, vrijeme, reason)) return UsageMessage(playerid, "jail [ID/Nick] [Vrijeme] [Reason]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return ErrorMessage(playerid, "You can not do that to admin bigger level.");
	if(vrijeme < 1 || vrijeme > 999) return ErrorMessage(playerid, "Time can not be smaller than 1 or bigger than 999.");

	mySQL_JailPlayer(id,  vrijeme * 60, reason, true);

	AMessage(id, "Admin "SERVER"%s"WHITE" has put you in jail for %dm.", GetName(playerid), vrijeme);
	AMessage(id, "Reason: "SERVER"%s.", reason);

	AMessage(playerid, "Player "SERVER"%s"WHITE" is successfully put in jail for %dm.", GetName(id), vrijeme);
	AMessage(playerid, "Reason: "SERVER"%s.", reason);

	AdminInfo[playerid][adminJail]++;
	mySQL_UpdateAdminCustomVal(playerid, "adminJail", AdminInfo[playerid][adminJail]);
	APregled(playerid, "JAIL");
	return 1;
}
//=======================================//
CMD:unjail(playerid, params[])
{
	if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id;
	if(sscanf(params, "u", id)) return UsageMessage(playerid, "unjail [ID/Nick]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return ErrorMessage(playerid, "You can not do that to admin bigger level.");
	if(!PI[id][pJail]) return ErrorMessage(playerid, "That player is not jailed.");

	mySQL_UnJailPlayer(id);

	AMessage(id, "Admin "SERVER"%s"WHITE" has unjailed you.", GetName(playerid));
	AMessage(playerid, "Player "SERVER"%s"WHITE" is successfully unjailed.", GetName(id));

	AdminInfo[playerid][adminUnjail]++;
	mySQL_UpdateAdminCustomVal(playerid, "adminUnjail", AdminInfo[playerid][adminUnjail]);
	APregled(playerid, "UNJAIL");
	return 1;
}
//=======================================//
CMD:kick(playerid, params[])
{
	if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id, reason[32], str[128];
	if(sscanf(params, "us[32]", id, reason)) return UsageMessage(playerid, "kick [ID/Nick] [Reason]");
	if(id == playerid) return ErrorMessage(playerid, "You can not kick yourself.");
	if(strlen(reason) < 1 || strlen(reason) > 32) return ErrorMessage(playerid, "Reason can not be longer then 32 characters.");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return ErrorMessage(playerid, "You can not do that to admin bigger level.");

	AMessage(playerid, "You have successfully kicked "SERVER"%s"WHITE" | Reason: "SERVER"%s.", GetName(id), reason);

	format(str, sizeof(str), "(( "WHITE"Admin "SERVER"%s"WHITE" has kicked player "SERVER"%s ))", GetName(playerid), GetName(id));
	SendClientMessageToAll(COL_SERVER, str);
	format(str, sizeof(str), "(( "WHITE"Reason: "SERVER"%s ))", reason);
	SendClientMessageToAll(COL_SERVER, str);

	onPlayerKicked(id, GetName(playerid), reason);

	APregled(playerid, "KICK");
	return 1;
}
//=======================================//
CMD:check(playerid, params[])
{
	if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id;
	if(sscanf(params, "u", id)) return UsageMessage(playerid, "check [ID/Nick]");

	showStats(playerid, id);
	APregled(playerid, "CHECK");
	return 1;
}
//=======================================//
CMD:alias(playerid, params[])
{
	if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new name[24];
	if(sscanf(params, "s[24]", name)) return UsageMessage(playerid, "alias [Name]");
	new query[72];
	mysql_format(DB, query, sizeof(query), "SELECT `pIP` FROM "USER_DB" WHERE `pName`='%s'", name);
	mysql_tquery(DB, query, "mySQL_CheckAlias", "is", playerid, name);
	APregled(playerid, "ALIAS");
	return 1;
}
//=======================================//
CMD:screenshare(playerid, params[])
{
	if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id;
	new i;
	if(sscanf(params, "u", id)) return UsageMessage(playerid, "screenshare [ID/Nick]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	
	SetPlayerPos(i, -1382.6997,-313.8120,25.4375);

	ClearChat(id, 20);
	AMessage(id, "Admin %s has just teleported you at screenshare room.", GetName(playerid));
	AMessage(id, "That means that you have 60 seconds to give him AnyDesk or TeamViewer access.");
	AMessage(id, "Otherwise, you are getting banned for suspicious being cheater.");

	AMessage(playerid, "You have just asked %s for AnyDesk or TeamViewer access.", GetName(id));
	AMessage(playerid, "You have all rights to ban him if he refuse to give you access.");

	APregled(playerid, "SCREENSHARE");
	return 1;
}
//=======================================//
CMD:ssclear(playerid, params[])
{
	if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id;
	if(sscanf(params, "u", id)) return UsageMessage(playerid, "screenshare [ID/Nick]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(id == playerid) return ErrorMessage(playerid, "Wrong ID.");
	if(Screenshare[id] == INVALID_PLAYER_ID) return ErrorMessage(playerid, "That player is not on screensharing.");

	Screenshare[playerid] = INVALID_PLAYER_ID;
	Screenshare[id] = INVALID_PLAYER_ID;

	SpawnEx(playerid);
	SpawnEx(id);

	APregled(playerid, "SSCLEAR");
	return 1;
}
//=======================================//
CMD:reportlist(playerid)
{
	if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");

	new dialog[1024], string[84], x = 0;
	foreach(new i:ReportList)
	{
		format(string, sizeof(string), ""SERVER"[%d] "WHITE"%s -> %s\t"SERVER"%s\n", i, ReportInfo[i][reportName], ReportInfo[i][reportPlayer], getReportReasonName(i));
		strcat(dialog, string);
		x++;
	}
	if(x == 0) return ErrorMessage(playerid, "Currently, there is no reported players.");
	ShowPlayerDialog(playerid, REPORT_LIST, DIALOG_STYLE_TABLIST, ""SERVER"Solvine Deathmatch > "WHITE"List of reports", dialog, "CHOOSE", "CANCEL");
	return 1;
}
//=======================================//
CMD:achat(playerid)
{
	if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");

	AdminChatDialog(playerid);
	return 1;
}
//==============================================================================//A2 	[General Admin]
CMD:announce(playerid, params[])
{
	if(PI[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new text[64];
	if(sscanf(params, "s[64]", text)) return UsageMessage(playerid, "announce [Text]");
	GameTextForAll(text, 6000, 3);

	APregled(playerid, "ANNOUNCE");
	return 1;
}
//=======================================//
CMD:kill(playerid, params[])
{
	if(PI[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id;
	if(sscanf(params, "u", id)) return UsageMessage(playerid, "kill [ID/Nick]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return ErrorMessage(playerid, "You can not do that to admin bigger level.");

	SetPlayerHealth(id, 0);
	AMessage(id, "Admin "SERVER"%s"WHITE" has killed you.", GetName(playerid));
	AMessage(playerid, "Player "SERVER"%s"WHITE" is successfully killed.", GetName(id));

	APregled(playerid, "KILL");
	return 1;
}
//=======================================//
CMD:count(playerid, params[])
{
	if(PI[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new seconds;
	if(sscanf(params, "i", seconds)) return UsageMessage(playerid, "count [Seconds]");

	CountDownForAll(seconds);
	AMessage(playerid, "Countdown has started. Seconds: %ds", seconds);

	APregled(playerid, "COUNT");
	return 1;
}
//=======================================//
CMD:count2(playerid, params[])
{
	if(PI[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id1, id2, seconds;
	if(sscanf(params, "uui", id1, id2, seconds)) return UsageMessage(playerid, "count [ID/Nick] [ID/Nick] [Seconds]");
	if(id1 == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(id2 == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(id1 == id2) return ErrorMessage(playerid, "You can not type same IDs.");

	CountDown(id1, seconds);
	CountDown(id2, seconds);

	AMessage(id1, "Admin "SERVER"%s"WHITE" has started countdown. (%ds)", GetName(playerid), seconds);
	AMessage(id2, "Admin "SERVER"%s"WHITE" has started countdown. (%ds)", GetName(playerid), seconds);
	AMessage(playerid, "You just started countdown (%ds) for "SERVER"%s / %s", seconds, GetName(id1), GetName(id2));

	APregled(playerid, "COUNT2");
	return 1;
}
//=======================================//
CMD:crash(playerid, params[])
{
	if(PI[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id;
	if(sscanf(params, "u", id)) return UsageMessage(playerid, "crash [ID/Nick]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");

	PlayerPlaySound(id, 5555, 0.0, 0.0, 0.0);

	AMessage(playerid, "Player "SERVER"%s"WHITE" is successfully crashed.", GetName(id));

	APregled(playerid, "CRASH");
	return 1;
}
//=======================================//
CMD:giveweapon(playerid, params[])
{
	if(PI[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id, gun, ammo;
	if(sscanf(params, "uii", id, gun, ammo)) return UsageMessage(playerid, "giveweapon [ID/Nick] [Weapon ID] [Ammo]");
	if(gun < 1 || gun > 46) return ErrorMessage(playerid, "Wrong WeaponID.");
	if(ammo < 1 || ammo > 2000) return ErrorMessage(playerid, "Ammo can not be bigger then 2000 or lower then 1.");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return ErrorMessage(playerid, "You can not do that to admin bigger level.");

	GivePlayerWeapon(id, gun, ammo);
	AMessage(id, "Admin "SERVER"%s"WHITE" has given you %s.", GetName(playerid), WeaponInfo[gun][wName]);
	AMessage(playerid, "You gave "SERVER"%s"WHITE" weapon %s.", GetName(id), WeaponInfo[gun][wName]);

	APregled(playerid, "GIVEWEAPON");
	return 1;
}
alias:giveweapon("givegun", "gg");
//=======================================//
CMD:prdni(playerid, params[])
{
	if(PI[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id, str[128];
	if(sscanf(params, "u", id)) return UsageMessage(playerid, "prdni [ID/Nick]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");

	format(str, sizeof(str), "* %s farted and stammered the server.", GetName(id));
	SendClientMessageToAll(COL_SERVER, str);
	return 1;
}
//=======================================//
CMD:spawn(playerid, params[])
{
	if(PI[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id;
	if(sscanf(params, "u", id)) return UsageMessage(playerid, "spawn [ID/Nick]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return ErrorMessage(playerid, "You can not do that to admin bigger level.");

	SpawnEx(id);

	AMessage(id, "Admin "SERVER"%s"WHITE" has teleported you to lobby.", GetName(playerid));
	AMessage(playerid, "Player "SERVER"%s"WHITE" is successfuly teleported to lobby.", GetName(id));
	APregled(playerid, "SPAWN");
	return 1;
}
//=======================================//
CMD:DMkick(playerid, params[])
{
	if(PI[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id;
	if(sscanf(params, "u", id)) return UsageMessage(playerid, "dmkick [ID/Nick]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return ErrorMessage(playerid, "You can not do that to admin bigger level.");
	if(EnteredArena[id] == -1) return ErrorMessage(playerid, "That player is not in DM.");

	leaveArena(id);

	AMessage(id, "Admin "SERVER"%s"WHITE" has kicked you from DM arena.", GetName(playerid));
	AMessage(playerid, "Player "SERVER"%s"WHITE" is kicked from DM arena.", GetName(id));
	APregled(playerid, "DMKICK");
	return 1;
}
//=======================================//
CMD:sethp(playerid, params[])
{
	if(PI[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id, hp;
	if(sscanf(params, "ui", id, hp)) return UsageMessage(playerid, "sethp [ID/Nick] [HP]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return ErrorMessage(playerid, "You can not do that to admin bigger level.");

	SetPlayerHealth(id, hp);
	AMessage(id, "Admin "SERVER"%s"WHITE" has set your HP on %d.", GetName(playerid), hp);
	AMessage(playerid, "Player "SERVER"%s"WHITE"'s HP is set on %d", GetName(id), hp);

	APregled(playerid, "SETHP");
	return 1;
}
//=======================================//
CMD:setarmour(playerid, params[])
{
	if(PI[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id, armour;
	if(sscanf(params, "ui", id, armour)) return UsageMessage(playerid, "setarmour [ID/Nick] [Armour]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return ErrorMessage(playerid, "You can not do that to admin bigger level.");

	SetPlayerArmour(id, armour);
	AMessage(id, "Admin "SERVER"%s"WHITE" has set your armour on %d.", GetName(playerid), armour);
	AMessage(playerid, "Player "SERVER"%s"WHITE"'s armour is set on %d", GetName(id), armour);

	APregled(playerid, "SETARMOUR");
	return 1;
}
//=======================================//
CMD:explode(playerid, params[])
{
	if(PI[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id;
	if(sscanf(params, "u", id)) return UsageMessage(playerid, "explode [ID/Nick]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return ErrorMessage(playerid, "You can not do that to admin bigger level.");

	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(id, X, Y, Z);
	CreateExplosion(X, Y, Z, 7, 2.00);
	PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);

	AMessage(id, "Admin "SERVER"%s"WHITE" has exploded you.", GetName(playerid));
	AMessage(playerid, "Player "SERVER"%s"WHITE" is successfully exploded.", GetName(id));

	APregled(playerid, "EXPLODE");
	return 1;
}
//=======================================//
CMD:ban(playerid, params[])
{
	if(PI[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id, reason[24], str[128];
	if(sscanf(params,"us[24]", id, reason)) return UsageMessage(playerid, "ban [ID/Nick] [Reason]");
	if(strlen(reason) > 24) return ErrorMessage(playerid, "Reason can not be longer than 24 letters.");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(PI[playerid][pAdmin] < 2 && PI[id][pAdmin] > 1) return ErrorMessage(playerid, "You can not ban other members of staff team.");
	if(isNameScriptDefined(GetName(id))) return callcmd::ban(id, GetName(playerid));

	new query[64], Cache:result;
	mysql_format(DB, query, sizeof(query), "SELECT * FROM "BAN_DB" WHERE `banName`='%s'", GetName(id));
	result = mysql_query(DB, query);
	if(cache_num_rows() > 0) 
	{
		cache_delete(result);
		ErrorMessage(playerid, "Player is already banned.");
		return 1;
	}
	cache_delete(result);

	onPlayerBanned(id, GetPlayerIP(id), GetName(playerid), reason, 0);

	format(str, sizeof(str), "(( "WHITE"Admin "SERVER"%s"WHITE" has banned "SERVER"%s ))", GetName(playerid), GetName(id));
	SendClientMessageToAll(COL_SERVER, str);
	format(str, sizeof(str), "(( "WHITE"Reason: "SERVER"%s ))", reason);
	SendClientMessageToAll(COL_SERVER, str);

	AdminInfo[playerid][adminBan]++;
	mySQL_UpdateAdminCustomVal(playerid, "adminBan", AdminInfo[playerid][adminBan]);

	APregled(playerid, "BAN");
	return 1;
}
//=======================================//
CMD:offban(playerid, params[])
{
	if(PI[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new name[24], reason[24], days;
	if(sscanf(params,"s[24]s[24]i", name, reason, days)) return UsageMessage(playerid, "ban [Nick] [Reason] [Days]");
	if(strlen(reason) > 24) return ErrorMessage(playerid, "Reason can not be longer than 24 letters.");
	if(days < 0 || days > 365) return ErrorMessage(playerid, "Days can not be lower than 0 or bigger then 365.");
	if(IsPlayerConnected(GetPlayerIdFromName(name))) return ErrorMessage(playerid, "You can not use /offban on online player.");

	new query[192], Cache:result, id, ip[16], timestamp;
	mysql_format(DB, query, sizeof(query), "SELECT `pID`, `pIP` FROM "USER_DB" WHERE `pName`='%s' LIMIT 1", name);
	result = mysql_query(DB, query);
	if(cache_num_rows() == 0) 
	{
		cache_delete(result);
		ErrorMessage(playerid, "There is no player with that name is database.");
		return 1;
	}
	cache_get_value_name_int(0, "pID", id);
	cache_get_value_name(0, "pIP", ip, 16);
	cache_delete(result);

	mysql_format(DB, query, sizeof(query), "SELECT `banName` FROM "BAN_DB" WHERE `banName`='%s'", name);
	result = mysql_query(DB, query);
	if(cache_num_rows() != 0)
	{
		cache_delete(result);
		ErrorMessage(playerid, "Player with that name is already banned.");
		return 1;
	}
	cache_delete(result);

	new str[128];
	if(days == 0)
	{
		format(str, sizeof(str), "(( "WHITE"Admin "SERVER"%s"WHITE" has offline banned "SERVER"%s ))", GetName(playerid), name);
		SendClientMessageToAll(COL_SERVER, str);
		format(str, sizeof(str), "(( "WHITE"Reason: "SERVER"%s ))", reason);
		SendClientMessageToAll(COL_SERVER, str);

		timestamp = 0;
	}
	else
	{
		format(str, sizeof(str), "(( "WHITE"Admin "SERVER"%s"WHITE" has temporarily offline banned "SERVER"%s ))", GetName(playerid), name);
		SendClientMessageToAll(COL_SERVER, str);
		format(str, sizeof(str), "(( "WHITE"Days: "SERVER"%d // "WHITE"Reason: "SERVER"%s ))", days, reason);
		SendClientMessageToAll(COL_SERVER, str);

		timestamp = gettime() + (days * (60 * 60 * 24));
	}

	Log(ban_log, INFO, "SQLID (%d) > Player (%s) > IP (%s) > Admin (%s) > Reason (%s)", id, name, ip, GetName(playerid), reason);

	#if USE_DISCORD == true
		format(str, sizeof(str), ">>> Ban > Player: %s > IP: %s > Admin: %s > Reason: %s", name, ip, GetName(playerid), reason);
		DCC_SendChannelMessage(DiscordInfo[staff_log], str);
	#endif

	mysql_format(DB, query, sizeof(query), "INSERT INTO "BAN_DB" (`banName`, `banIP`, `banAdmin`, `banReason`, `banDate`, `banTime`) VALUES ('%s', '%s', '%s', '%s', NOW(), '%d')", name, ip, GetName(playerid), reason, timestamp);
	mysql_tquery(DB, query);

	ServerInfo[serverBanovanih]++;
	mySQL_UpdateServerCustomVal("serverBanovanih", ServerInfo[serverBanovanih]);

	AdminInfo[playerid][adminBan]++;
	mySQL_UpdateAdminCustomVal(playerid, "adminBan", AdminInfo[playerid][adminBan]);

	APregled(playerid, "OFFBAN");
	return 1;
}
//=======================================//
CMD:tempban(playerid, params[])
{
	if(PI[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id, days, reason[24], str[128];
	if(sscanf(params,"uis[24]", id, days, reason)) return UsageMessage(playerid, "tempban [ID/Nick] [Days] [Reason]");
	if(strlen(reason) > 24) return ErrorMessage(playerid, "Reason can not be longer than 24 letters.");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(days < 1 || days > 365) return ErrorMessage(playerid, "Days can not be lower than 1 or bigger then 365.");
	if(PI[playerid][pAdmin] < 2 && PI[id][pAdmin] > 1) return ErrorMessage(playerid, "You can not ban other members of staff team.");
	if(isNameScriptDefined(GetName(id))) return callcmd::ban(id, GetName(playerid));

	onPlayerBanned(id, GetPlayerIP(id), GetName(playerid), reason, days);

	format(str, sizeof(str), "(( "WHITE"Admin "SERVER"%s"WHITE" has temporarily banned "SERVER"%s ))", GetName(playerid), GetName(id));
	SendClientMessageToAll(COL_SERVER, str);
	format(str, sizeof(str), "(( "WHITE"Days: "SERVER"%d // "WHITE"Reason: "SERVER"%s ))", days, reason);
	SendClientMessageToAll(COL_SERVER, str);

	AdminInfo[playerid][adminBan]++;
	mySQL_UpdateAdminCustomVal(playerid, "adminBan", AdminInfo[playerid][adminBan]);

	APregled(playerid, "TEMPBAN");
	return 1;
}
//=======================================//
CMD:unban(playerid, params[])
{
	if(PI[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new name[MAX_PLAYER_NAME];
	if(sscanf(params, "s[32]", name)) return UsageMessage(playerid, "unban [Name]");

	new query[96], Cache:result;
	mysql_format(DB, query, sizeof(query), "SELECT `banName` FROM "BAN_DB" WHERE `banName`='%s'", name);
	result = mysql_query(DB, query);
	if(cache_num_rows() == 0) 
	{
		cache_delete(result);
		ErrorMessage(playerid, "Player with that name is not banned.");
		return 1;
	}
	cache_delete(result);

	mysql_format(DB, query, sizeof(query), "DELETE FROM "BAN_DB" WHERE `banName`='%s'", name);
	mysql_tquery(DB, query);

	ServerInfo[serverBanovanih]--;
	mySQL_UpdateServerCustomVal("serverBanovanih", ServerInfo[serverBanovanih]);

	AdminInfo[playerid][adminUnban]++;
	mySQL_UpdateAdminCustomVal(playerid, "adminUnban", AdminInfo[playerid][adminUnban]);

	AMessage(playerid, "You successfuly banned player "SERVER"%s", name);
	APregled(playerid, "UNBAN");
	return 1;
}
//=======================================//
CMD:baninfo(playerid, params[])
{
	if(PI[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new name[MAX_PLAYER_NAME];
	if(sscanf(params, "s[32]", name)) return UsageMessage(playerid, "unban [Name]");

	new query[128], Cache:result;
	mysql_format(DB, query, sizeof(query), "SELECT * FROM "BAN_DB" WHERE `banName`='%s'", name);
	result = mysql_query(DB, query);
	if(cache_num_rows() == 0) 
	{
		cache_delete(result);
		ErrorMessage(playerid, "Player with that name is not banned.");
		return 1;
	}

	new ip[16], admin[24], reason[24], date[24], time;
	cache_get_value(0, "banName", name, 24);
	cache_get_value(0, "banIP", ip, 16);
	cache_get_value(0, "banAdmin", admin, 24);
	cache_get_value(0, "banReason", reason, 24);
	cache_get_value(0, "banDate", date, 24);
	cache_get_value_int(0, "banTime", time);

	cache_delete(result);

	new dialog[256];
	if(time == 0)
	{
		format(dialog, sizeof(dialog), "\
			"SERVER"> "WHITE"Information about permament ban\n\
			"SERVER"> "WHITE"Account: %s\n\
			"SERVER"> "WHITE"IP: %s\n\
			"SERVER"> "WHITE"Admin: %s\n\
			"SERVER"> "WHITE"Ban reason: %s\n\
			"SERVER"> "WHITE"Ban date: %s\n\
			", name, ip, admin, reason, date);
	}
	else
	{
		new year, month, day, hours, minutes, seconds;
		TimestampToDate(time, year, month, day, hours, minutes, seconds, 2);

		format(dialog, sizeof(dialog), "\
			"SERVER"> "WHITE"Information about temporarily ban\n\
			"SERVER"> "WHITE"Account: %s\n\
			"SERVER"> "WHITE"IP: %s\n\
			"SERVER"> "WHITE"Admin: %s\n\
			"SERVER"> "WHITE"Ban reason: %s\n\
			"SERVER"> "WHITE"Ban date: %s\n\
			"SERVER"> "WHITE"Ban expire: %d-%02d-%02d %02d:%02d:%02d\n\
			", name, ip, admin, reason, date, year, month, day, hours, minutes, seconds);
	}
	ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_MSGBOX, ""SERVER"Solvine Deathmatch > "WHITE"Ban inforamation", dialog, "OKAY", "");
	return 1;
}
//=======================================//
CMD:warn(playerid, params[])
{
	if(PI[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id, reason[48], str[128];
	if(sscanf(params, "us[48]", id, reason)) return UsageMessage(playerid, "warn [ID/Nick] [Reason]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return ErrorMessage(playerid, "You can not do that to admin bigger level.");

	PI[id][pWarn]++;
	mySQL_UpdatePlayerCustomVal(playerid, "pWarn", PI[id][pWarn]);

	AMessage(id, "Admin "SERVER"%s"WHITE" has given you warn "SERVER"%d/%d.", GetName(playerid), PI[id][pWarn], MAX_WARN);
	AMessage(id, "Reason: "SERVER"%s.", reason);

	AMessage(playerid, "You give "SERVER"%s"WHITE" a warn "SERVER"%d/%d.", GetName(id), PI[id][pWarn], MAX_WARN);
	AMessage(playerid, "Reason: "SERVER"%s.", reason);

	if(PI[id][pWarn] >= MAX_WARN)
	{
		onPlayerBanned(id, GetPlayerIP(id), GetName(playerid), reason, 0);

		format(str, sizeof(str), "(( "WHITE"Admin "SERVER"%s"WHITE" has banned "SERVER"%s ))", GetName(playerid), GetName(id));
		SendClientMessageToAll(COL_SERVER, str);
		format(str, sizeof(str), "(( "WHITE"Reason: "SERVER"%s ))", reason);
		SendClientMessageToAll(COL_SERVER, str);
	}
	else if(PI[id][pWarn] == 1)
	{
		ServerInfo[serverUpozorenih]++;
		mySQL_UpdateServerCustomVal("serverUpozorenih", ServerInfo[serverUpozorenih]);
	}

	AdminInfo[playerid][adminWarn]++;
	mySQL_UpdateAdminCustomVal(playerid, "adminWarn", AdminInfo[playerid][adminWarn]);
	APregled(playerid, "WARN");
	return 1;
}
//=======================================//
CMD:unwarn(playerid, params[])
{
	if(PI[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id;
	if(sscanf(params, "u", id)) return UsageMessage(playerid, "unwarn [ID/Nick]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(PI[id][pWarn] <= 0) return ErrorMessage(playerid, "Player do not have any warning.");
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return ErrorMessage(playerid, "You can not do that to admin bigger level.");

	if(PI[id][pWarn] == 1)
	{
		ServerInfo[serverUpozorenih]--;
		mySQL_UpdateServerCustomVal("serverUpozorenih", ServerInfo[serverUpozorenih]);
	}

	PI[id][pWarn]--;
	mySQL_UpdatePlayerCustomVal(id, "pWarn", PI[id][pWarn]);

	AMessage(id, "Admin "SERVER"%s"WHITE" has unwarned! Warn: %d/%d", GetName(playerid), PI[id][pWarn], MAX_WARN);
	AMessage(playerid, "Player "SERVER"%s"WHITE" is successfuly unwarned! Warn: %d/%d", GetName(id), PI[id][pWarn], MAX_WARN);

	AdminInfo[playerid][adminUnwarn]++;
	mySQL_UpdateAdminCustomVal(playerid, "adminUnwarn", AdminInfo[playerid][adminUnwarn]);
	APregled(playerid, "UNWARN");
	return 1;
}
//=======================================//
CMD:muted(playerid)
{
	if(PI[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new str[72], dialog[512], x = 0;
	foreach(new i:Player)
	{
		if(Spawned[i])
		{
			if(PI[i][pMute] != 0)
			{
				format(str, sizeof(str), ""SERVER"[%d] "WHITE"%s\tTime: %d\n", x+1, GetName(i), PI[i][pMute]);
				strcat(dialog, str);
				x++;
			}
		}
	}
	if(x == 0) return ErrorMessage(playerid, "Currently, there is no muted player online.");
	ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_TABLIST, ""SERVER"Solvine Deathmatch > "WHITE"Muted", dialog, "OKAY", "");

	APregled(playerid, "MUTED");
	return 1;
}
//=======================================//
CMD:jailed(playerid)
{
	if(PI[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new str[72], dialog[512], x = 0;
	foreach(new i:Player)
	{
		if(Spawned[i])
		{
			format(str, sizeof(str), ""SERVER"[%d] "WHITE"%s\tTime: %d\n", x+1, GetName(i), PI[i][pJail]);
			strcat(dialog, str);
			x++;
		}
	}
	if(x == 0) return ErrorMessage(playerid, "Currently, there is no jailed player online.");
	ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_TABLIST, ""SERVER"Solvine Deathmatch > "WHITE"Jailed", dialog, "OKAY", "");

	APregled(playerid, "JAILED");
	return 1;
}
//=======================================//
CMD:warned(playerid)
{
	if(PI[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new str[72], dialog[512], x = 0;
	foreach(new i:Player)
	{
		if(Spawned[i])
		{
			if(PI[i][pWarn] > 0)
			{
				format(str, sizeof(str), ""SERVER"[%d] "WHITE"%s\tWarn: %d / %d\n", x+1, GetName(i), PI[i][pWarn], MAX_WARN);
				strcat(dialog, str);
				x++;
			}
		}
	}
	if(x == 0) return ErrorMessage(playerid, "Currently, there is no warned player online.");
	ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_TABLIST, ""SERVER"Solvine Deathmatch > "WHITE"Warned", dialog, "OKAY", "");

	APregled(playerid, "WARNED");
	return 1;
}
//==============================================================================//A3 	[Owner]
CMD:jetpack(playerid, params[])
{
	if(PI[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
	{
		new Float:X, Float: Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		SetPlayerPos(playerid, X, Y, Z+2);
		AMessage(playerid, "You destroyed your jetpack.");
	}
	else
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
		AMessage(playerid, "You successfully took a jetpack.");
	}
	APregled(playerid, "JETPACK");
	return 1;
}
alias:jetpack("jp");
//=======================================//
CMD:up(playerid, params[])
{
	if(PI[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	SetPlayerPos(playerid, X, Y, Z+2.5);

	APregled(playerid, "UP");
	return 1;
}
//=======================================//
CMD:down(playerid, params[])
{
	if(PI[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	SetPlayerPos(playerid, X, Y, Z-2.5);

	APregled(playerid, "DOWN");
	return 1;
}
//=======================================//
CMD:setint(playerid, params[])
{
	if(PI[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id, intid;
	if(sscanf(params, "ui", id, intid)) return UsageMessage(playerid, "setint [ID/Nick] [IntID] ");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return ErrorMessage(playerid, "You can not do that to admin bigger level.");

	SetPlayerInterior(id, intid);
	AMessage(id, "Admin "SERVER"%s"WHITE" has set your Interior ID on %d.", GetName(playerid), intid);
	AMessage(playerid, "Player "SERVER"%s"WHITE"'s Interior ID is set on %d", GetName(id), intid);

	APregled(playerid, "SETINT");
	return 1;
}
//=======================================//
CMD:setvw(playerid, params[])
{
	if(PI[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id, vwid;
	if(sscanf(params, "ui", id, vwid)) return UsageMessage(playerid, "setvw [ID/Nick] [VW ID]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return ErrorMessage(playerid, "You can not do that to admin bigger level.");

	SetPlayerVirtualWorld(id, vwid);
	AMessage(id, "Admin "SERVER"%s"WHITE" has set your VW ID on %d.", GetName(playerid), vwid);
	AMessage(playerid, "Player "SERVER"%s"WHITE"'s VW ID is set on %d", GetName(id), vwid);

	APregled(playerid, "SETVW");
	return 1;
}
//=======================================//
CMD:gotopos(playerid, params[])
{
	if(PI[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new Float:X, Float:Y, Float:Z, int;
	if(sscanf(params, "ifff", int, X, Y, Z)) return UsageMessage(playerid, "gotopos [IntID] [X] [Y] [Z]");

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	{
		SetPlayerPos(playerid, X, Y, Z);
		SetPlayerInterior(playerid, int);
	}
	else
	{
		SetVehiclePos(GetPlayerVehicleID(playerid), X, Y, Z);
		LinkVehicleToInterior(GetPlayerVehicleID(playerid), int);
	}
	AMessage(playerid, "You teleported on coordinates: X: %.3f | Y: %.3f | Z: %.3f | IntID: %d", X, Y, Z ,int);

	APregled(playerid, "GOTOPOS");
	return 1;
}
alias:gotopos("portloc", "gotox");
//=======================================//
CMD:god(playerid)
{
	if(PI[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(GodMode[playerid])
	{
		GodMode[playerid] = false;
		AC_KillTimer(GodTimer[playerid]);
	}
	else
	{
		GodMode[playerid] = true;
		GodTimer[playerid] = SetTimerEx("GodUpdate", 250, false, "d", playerid);
	}
	return 1;
}
//=======================================//
CMD:alladmins(playerid)
{
	if(PI[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not allowed to use this command.");

	mysql_tquery(DB, "SELECT `adminName`, `adminLevel`, `adminLastLogin`, `adminOnline` FROM "ADMIN_DB" WHERE `adminLevel` > '0'", "ShowAdminList", "i", playerid );

	APregled(playerid, "ALLADMINS");
	return 1;
}
//=======================================//
CMD:changename(playerid, params[])
{
	if(PI[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id, name[MAX_PLAYER_NAME];
	if(sscanf(params, "us[24]", id, name)) return UsageMessage(playerid, "changename [ID/Nick] [New name]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return ErrorMessage(playerid, "You can not do that to admin bigger level.");

	new query[84], Cache:result;
	mysql_format(DB, query, sizeof(query), "SELECT `pID` FROM `user` WHERE `pName`='%s'", name);
	result = mysql_query(DB, query);
	if(cache_num_rows() > 0)
	{
		cache_delete(result);
		ErrorMessage(playerid, "There is already player with that name in DB.");
		return 1;
	}
	cache_delete(result);

	mySQL_RenamePlayer(id, name);

	new str[128];
	AMessage(id, "Admin "SERVER"%s"WHITE" has change you nickname to %s.", GetName(playerid), name);
	AMessage(playerid, "Player "SERVER"%s"WHITE"'s nickname is changed to %s.", GetName(id), name);
	
	format(str, sizeof(str), "Your new nickname '%s'... Please login with that nickname...", name);
	onPlayerKicked(id, GetName(playerid), str);

	Log(rename_log, INFO, "Admin (%s) > %s --> %s", GetName(playerid), GetName(id), name);

	APregled(playerid, "CHANGENAME");
	return 1;
}
//=======================================//
CMD:coordinates(playerid, params[])
{
	if(PI[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new Float:X, Float:Y, Float:Z, Float:A;
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, A);

	AMessage(playerid, "Your current coordinates: %.2f %.2f %.2f %.2f.", X, Y, Z, A);
	return 1;
}
alias:coordinates("location");
//=======================================//
CMD:checkadmin(playerid, params[])
{
	if(PI[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id;
	if(sscanf(params, "u", id)) return UsageMessage(playerid, "checkadmin [ID/Nick]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(PI[playerid][pAdmin] < PI[id][pAdmin]) return ErrorMessage(playerid, "You can not do that to admin bigger level.");

	ShowAdminStats(playerid, id);

	APregled(playerid, "CHECKADMIn");
	return 1;
}
//=======================================//
CMD:setacode(playerid, params[])
{
	if(PI[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id, code;
	if(sscanf(params, "ui", id, code)) return UsageMessage(playerid, "setacode [ID/Nick] [Code]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(code == 0) return ErrorMessage(playerid, "Admin Code can not be zero.");
	if(PI[id][pAdmin] < 1) return ErrorMessage(playerid, "That player is not admin.");

	PI[id][pAdminCode] = code;
	mySQL_UpdatePlayerCustomVal(id, "pAdminCode", PI[id][pAdminCode]);

	AMessage(id, "Admin "SERVER"%s"WHITE" has changed your admin code on %d.", GetName(playerid), code);
	AMessage(playerid, "Admin "SERVER"%s"WHITE"'s code is changed on %d.", GetName(id), code);

	APregled(playerid, "SETACODE");
	return 1;
}
//=======================================//
CMD:make(playerid, params[])
{
	if(PI[playerid][pAdmin] < 0) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new action[16];
	if(sscanf(params, "s[16]", action))
	{
		UsageMessage(playerid, "make [Option]");
		SendClientMessage(playerid, COL_ORANGE, "[Option]"WHITE" admin | premium");
		return 1;
	}

	//==========================================================================//
	if(strfind(action, "admin", true) != -1)
	{
		new id, level, dialog[256];
		if(sscanf(params, "s[16]ui", action, id, level)) return UsageMessage(playerid, "make admin [ID/Nick] [Level]");
		if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
		if(level < 0 || level > 3) return ErrorMessage(playerid, "Level can not be bigger than 3 and smaller than 0.");

		if(level == 0)
		{
			if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "This player is not an admin.");

			new query[84];
			SetPlayerSkin(id, PI[id][pSkinID]);
			PI[id][pAdmin] = 0;
			PI[id][pAdminCode] = 0;
			mysql_format(DB, query, sizeof(query), "UPDATE "USER_DB" SET `pAdmin`=%d, `pAdminCode`=%d WHERE `pID`=%d", PI[id][pAdmin], PI[id][pAdminCode], PI[id][pID]);
			mysql_tquery(DB, query);

			AMessage(id, "Owner "SERVER"%s"WHITE" has removed your admin role.", GetName(playerid));
			AMessage(playerid, "Admin "SERVER"%s"WHITE" is removed from his admin role.", GetName(id));

			mySQL_DeleteAdmin(GetName(id));

			Log(make_remove_log, INFO, "REMOVE (ADMIN) > Player (%s) > Admin (%s) > IP (%s)", GetName(id), GetName(playerid), GetPlayerIP(playerid));
		}
		else
		{
			new code, query[128];
			if(PI[id][pAdmin] == 0)
			{
				code = randomEx(1000, 9999);

				AdminInfo[id][adminLevel] = level;
				PI[id][pAdmin] = level;
				PI[id][pAdminCode] = code;

				mysql_format(DB, query, sizeof(query), "INSERT INTO "ADMIN_DB" (`adminName`, `adminLevel`) \
					VALUES ('%s', '%d')",
					GetName(id),
					level);
				mysql_tquery(DB, query, "mySQL_MakeAdmin", "d", id);

				mysql_format(DB, query, sizeof(query), "UPDATE "USER_DB" SET `pAdmin`=%d, `pAdminCode`=%d WHERE `pID`=%d", level, code, PI[id][pID]);
				mysql_tquery(DB, query);
			}
			else
			{
				code = PI[id][pAdminCode];
				PI[id][pAdmin] = level;
				AdminInfo[id][adminLevel] = level;
				mySQL_UpdatePlayerCustomVal(id, "pAdmin", PI[id][pAdmin]);
				mySQL_UpdateAdminCustomVal(id, "adminLevel", AdminInfo[id][adminLevel]);
			}

			format(dialog, sizeof(dialog), "\
				"SERVER"> "WHITE"Congratulations!\n\
				"SERVER"> "WHITE"You become a Solvine Deathmatch admin (%d).\n\
				"SERVER"> "WHITE"Owner: %s\n\n\
				"SERVER"> "WHITE"Your admin code: %d\n\
				", level, GetName(playerid), code);
			ShowPlayerDialog(id, SHOW_ONLY, DIALOG_STYLE_MSGBOX, ""SERVER"Solvine Deathmatch > "WHITE"Promotion", dialog, "OKAY", "");

			AMessage(playerid, "You have successfully promoted "SERVER"%s"WHITE" to admin level %d.", GetName(id), level);

			Log(make_remove_log, INFO, "MAKE (ADMIN) > Player (%s) > Admin (%s) > IP (%s)", GetName(id), GetName(playerid), GetPlayerIP(playerid));
		}
		APregled(playerid, "MAKE > ADMIN");
	}
	//==========================================================================//
	else if(strfind(action, "premium", true) != -1)
	{
		new id, level;
		if(sscanf(params, "s[16]ui", action, id, level)) return UsageMessage(playerid, "make premium [ID/Nick] [0-1]");
		if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
		if(level < 0 || level > 1) return ErrorMessage(playerid, "Level can not be bigger than 1 and smaller than 0.");

		if(level == 0)
		{
			if(!PI[id][pPremium]) return ErrorMessage(playerid, "That player does not have premium enabled.");

			static query[96];
			PI[id][pPremium] = false;
			PI[id][pPremiumHours] = 0;
			mysql_format(DB, query, sizeof(query), "UPDATE "USER_DB" SET `pPremium`=0, `pPremiumHours`=0 WHERE `pID`=%d", PI[id][pID]);
			mysql_tquery(DB, query);

			AMessage(id, "Owner "SERVER"%s"WHITE" has disabled your premium.", GetName(playerid));
			AMessage(playerid, "You disabled "SERVER"%s's"WHITE" premium.", GetName(id));

			Log(make_remove_log, INFO, "REMOVE (PREMIUM) > Player (%s) > Premium (%s) > IP (%s)", GetName(id), GetName(playerid), GetPlayerIP(playerid));
		}
		else
		{
			if(PI[id][pPremium]) return ErrorMessage(playerid, "That player has already premium enabled.");

			static query[96];
			PI[id][pPremium] = true;
			PI[id][pPremiumHours] = 400;
			mysql_format(DB, query, sizeof(query), "UPDATE "USER_DB" SET `pPremium`=1, `pPremiumHours`=400 WHERE `pID`=%d", PI[id][pID]);
			mysql_tquery(DB, query);

			AMessage(id, "Owner "SERVER"%s"WHITE" has enabled your premium.", GetName(playerid));
			AMessage(playerid, "You enabled "SERVER"%s's"WHITE" premium.", GetName(id));

			Log(make_remove_log, INFO, "MAKE (PREMIUM) > Player (%s) > Premium (%s) > IP (%s)", GetName(id), GetName(playerid), GetPlayerIP(playerid));
		}
	}
	//==========================================================================//
	else
	{
		UsageMessage(playerid, "make [Option]");
		SendClientMessage(playerid, COL_ORANGE, "[Option]"WHITE" admin | premium");
		return 1;
	}
	//==========================================================================//
	return 1;
}
//=======================================//
CMD:deleteacc(playerid, params[])
{
	if(PI[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new name[24];
	if(sscanf(params, "s[24]", name)) return UsageMessage(playerid, "deleteacc [Nickname]");

	mySQL_DeletePlayerAccount(name);
	if(IsPlayerConnected(GetPlayerIdFromName(name)))
	{
		new id = GetPlayerIdFromName(name);
		onPlayerKicked(id, GetName(playerid), "Account deleted");

		mySQL_DeletePlayerAccount(name);
	}
	else
	{
		mySQL_DeletePlayerAccount(name);
	}
	AMessage(playerid, "Account named %s is successfully deleted from database.", name);
	return 1;
}
//=======================================//
CMD:arenalock(playerid, params[])
{
	if(PI[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new id;
	if(sscanf(params, "i", id)) return UsageMessage(playerid, "arenalock [Arena ID]");
	if(!Iter_Contains(ArenaList, id)) return ErrorMessage(playerid, "Wrong Arena ID.");

	if(ArenaInfo[id][arenaLocked])
	{
		ArenaInfo[id][arenaLocked] = false;
		mySQL_UpdateArenaCustomVal(id, "arenaLocked", ArenaInfo[id][arenaLocked]);

		InfoMessage(playerid, "You have successfully "GREEN"unlocked"WHITE" %s. (%d)", ArenaInfo[id][arenaName], id);
	}
	else
	{
		ArenaInfo[id][arenaLocked] = true;
		mySQL_UpdateArenaCustomVal(id, "arenaLocked", ArenaInfo[id][arenaLocked]);

		InfoMessage(playerid, "You have successfully "RED"locked"WHITE" %s. (%d)", ArenaInfo[id][arenaName], id);
	}
	return 1;
}
//=======================================//
CMD:server(playerid)
{
	if(PI[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not allowed to use this command.");
	
	showServerMenu(playerid);
	return 1;
}
//=======================================//
CMD:whitelist(playerid, params[])
{
	if(PI[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new action[9];
	if(sscanf(params, "s[9]", action)) 
	{
		UsageMessage(playerid, "whitelist [Option]");
		SendClientMessage(playerid, COL_ORANGE, "[Option] "WHITE"pending / refused / accepted / info / change");
		return 1;
	}
	if(strfind(action, "pending", true) != -1)
	{
		new Cache:result;
		result = mysql_query(DB, "SELECT * FROM "WL_DB" WHERE `wlStatus`=1");

		new rows = cache_num_rows();
		if(rows > 0)
		{
			new dialog[1024], str[72], id, nickname[24], discord[32], code[5];
			strcat(dialog, ""WHITE"WL ID\t"SERVER"Nickname\t"WHITE"Discord\n");
			for(new i = 0; i < rows; i++)
			{
				cache_get_value_name_int(i, "wlID", id);
				cache_get_value_name(i, "wlName", nickname);
				cache_get_value_name(i, "wlDiscord", discord);
				cache_get_value_name(i, "wlDiscriminator", code);
				format(str, sizeof(str), ""SERVER"[ %04d ]\t"WHITE"[ %s ]\t"SERVER"[ %s-%s ]\n", id, nickname, discord, code);
				strcat(dialog, str);
			}
			ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_TABLIST_HEADERS, ""SERVER"Solvine Deathmatch > "WHITE"WL > Pending", dialog, "OKAY", "");
		}
		else ErrorMessage(playerid, "Currently, there is no one with pending request.");

		cache_delete(result);
	}
	else if(strfind(action, "refused", true) != -1)
	{
		new Cache:result;
		result = mysql_query(DB, "SELECT * FROM "WL_DB" WHERE `wlStatus`=3");

		new rows = cache_num_rows();
		if(rows > 0)
		{
			new dialog[1024], str[72], id, nickname[24], discord[32], code[5];
			strcat(dialog, ""WHITE"WL ID\t"SERVER"Nickname\t"WHITE"Discord\n");
			for(new i = 0; i < rows; i++)
			{
				cache_get_value_name_int(i, "wlID", id);
				cache_get_value_name(i, "wlName", nickname);
				cache_get_value_name(i, "wlDiscord", discord);
				cache_get_value_name(i, "wlDiscriminator", code);
				format(str, sizeof(str), ""SERVER"[ %04d ]\t"WHITE"[ %s ]\t"SERVER"[ %s-%s ]\n", id, nickname, discord, code);
				strcat(dialog, str);
			}
			ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_TABLIST_HEADERS, ""SERVER"Solvine Deathmatch > "WHITE"WL > Refused", dialog, "OKAY", "");
		}
		else ErrorMessage(playerid, "Currently, there is no one with refused request.");

		cache_delete(result);
	}
	else if(strfind(action, "accepted", true) != -1)
	{
		new Cache:result;
		result = mysql_query(DB, "SELECT * FROM "WL_DB" WHERE `wlStatus`=2");

		new rows = cache_num_rows();
		if(rows > 0)
		{
			new dialog[1024], str[72], id, nickname[24], discord[32], code[5];
			strcat(dialog, ""WHITE"WL ID\t"SERVER"Nickname\t"WHITE"Discord\n");
			for(new i = 0; i < rows; i++)
			{
				cache_get_value_name_int(i, "wlID", id);
				cache_get_value_name(i, "wlName", nickname);
				cache_get_value_name(i, "wlDiscord", discord);
				cache_get_value_name(i, "wlDiscriminator", code);
				format(str, sizeof(str), ""SERVER"[ %04d ]\t"WHITE"[ %s ]\t"SERVER"[ %s-%s ]\n", id, nickname, discord, code);
				strcat(dialog, str);
			}
			ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_TABLIST_HEADERS, ""SERVER"Solvine Deathmatch > "WHITE"WL > Accepted", dialog, "OKAY", "");
		}
		else ErrorMessage(playerid, "Currently, there is no one accepted on whitelist.");

		cache_delete(result);
	}
	else if(strfind(action, "change", true) != -1)
	{
		new id, change[7];
		if(sscanf(params, "s[8]is[7]", action, id, change))
		{
			UsageMessage(playerid, "whitelist change [ID] [Option]");
			SendClientMessage(playerid, COL_ORANGE, "[Option] "WHITE"accept / refuse");
			return 1;
		}

		if(strfind(change, "accept", true) != -1)
		{
			static query[128];
			mysql_format(DB, query, sizeof(query), "UPDATE "WL_DB" SET `wlStatus`=2, `wlAdmin`='%s' WHERE `wlID`=%d", GetName(playerid), id);
			mysql_tquery(DB, query);

			ServerInfo[serverWhitelisted]++;
			mySQL_UpdateServerCustomVal("serverWhitelisted", ServerInfo[serverWhitelisted]);

			Log(whitelist_log, INFO, "Whitelist accepted > Admin (%s) > User (%04d)", GetName(playerid), id);

			//setDiscordNickname(id);
			AMessage(playerid, "You have successfully accepted whitelist request. (%d)", id);
		}
		else if(strfind(change, "refuse", true) != -1)
		{
			static query[128];
			mysql_format(DB, query, sizeof(query), "UPDATE "WL_DB" SET `wlStatus`=3, `wlAdmin`='%s' WHERE `wlID`=%d", GetName(playerid), id);
			mysql_tquery(DB, query);

			ServerInfo[serverWhitelisted]--;
			mySQL_UpdateServerCustomVal("serverWhitelisted", ServerInfo[serverWhitelisted]);

			Log(whitelist_log, INFO, "Whitelist refused > Admin (%s) > User (%04d)", GetName(playerid), id);

			AMessage(playerid, "You have successfully refused whitelist request. (%d)", id);
		}
	}
	else if(strfind(action, "info", true) != -1)
	{
		new id;
		if(sscanf(params, "s[8]i", action, id)) return UsageMessage(playerid, "whitelist info [ID]");

		static query[128], Cache:result;
		mysql_format(DB, query, sizeof(query), "SELECT * FROM "WL_DB" WHERE `wlID`=%d", id);
		result = mysql_query(DB, query);

		new name[24], ip[16], mail[48], discord[32], code[5], status, admin[24];
		if(cache_num_rows() > 0)
		{
			cache_get_value(0, "wlName", name, 24); 
			cache_get_value(0, "wlIP", ip, 16); 
			cache_get_value(0, "wlEmail", mail, 48); 
			cache_get_value(0, "wlDiscord", discord, 32); 
			cache_get_value(0, "wlDiscriminator", code, 5); 
			cache_get_value_int(0, "wlStatus", status);
			cache_get_value(0, "wlAdmin", admin, 24); 

			new str[72], dialog[384];
			format(str, sizeof(str), ""SERVER"> "WHITE"ID\t[ %04d ]\n", id);
			strcat(dialog, str);
			format(str, sizeof(str), ""SERVER"> "WHITE"Name\t[ %s ]\n", name);
			strcat(dialog, str);
			format(str, sizeof(str), ""SERVER"> "WHITE"IP\t[ %s ]\n", ip);
			strcat(dialog, str);
			format(str, sizeof(str), ""SERVER"> "WHITE"E-Mail\t[ %s ]\n", mail);
			strcat(dialog, str);
			format(str, sizeof(str), ""SERVER"> "WHITE"Discord username\t[ %s#%s ]\n", discord, code);
			strcat(dialog, str);
			//format(str, sizeof(str), ""SERVER"> "WHITE"Status\t[ %s ]\n", getWhitelistStatus(status));
			//strcat(dialog, str);
			format(str, sizeof(str), ""SERVER"> "WHITE"Admin\t[ %s ]\n", admin);
			strcat(dialog, str);
			ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_TABLIST, ""SERVER"Solvine Deathmatch > "WHITE"WL Info", dialog, "OKAY", "");
		}
		else ErrorMessage(playerid, "Wrong ID.");

		cache_delete(result);
	}
	return 1;
}
//==============================================================================//
