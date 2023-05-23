//==============================================================================//
/*
	* Module: admin_functions.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
function mySQL_LoadAdmin(playerid)
{
	if(cache_num_rows() > 0) 
	{
		cache_get_value_int(0, "adminID", AdminInfo[playerid][adminID]);
		cache_get_value(0, "adminName", AdminInfo[playerid][adminName], MAX_PLAYER_NAME);
		cache_get_value_int(0, "adminLevel", AdminInfo[playerid][adminLevel]);

		cache_get_value_int(0, "adminCMD", AdminInfo[playerid][adminCMD]);
		cache_get_value_int(0, "adminBan", AdminInfo[playerid][adminBan]);
		cache_get_value_int(0, "adminUnban", AdminInfo[playerid][adminUnban]);
		cache_get_value_int(0, "adminWarn", AdminInfo[playerid][adminWarn]);
		cache_get_value_int(0, "adminUnwarn", AdminInfo[playerid][adminUnwarn]);
		cache_get_value_int(0, "adminKick", AdminInfo[playerid][adminKick]);
		cache_get_value_int(0, "adminJail", AdminInfo[playerid][adminJail]);
		cache_get_value_int(0, "adminUnjail", AdminInfo[playerid][adminUnjail]);
		cache_get_value_int(0, "adminSpec", AdminInfo[playerid][adminSpec]);

		cache_get_value_int(0, "adminHours", AdminInfo[playerid][adminHours]);
		cache_get_value_int(0, "adminMinutes", AdminInfo[playerid][adminMinutes]);
		cache_get_value(0, "adminLastLogin", AdminInfo[playerid][adminLastLogin], 24);
		cache_get_value_bool(0, "adminOnline", AdminInfo[playerid][adminOnline]);

		AdminInfo[playerid][adminOnline] = true;
		mySQL_UpdateAdminCustomVal(playerid, "adminOnline", AdminInfo[playerid][adminOnline]);
	}
	else
	{
		PI[playerid][pAdmin] = 0;
		PI[playerid][pAdminCode] = 0;
		new str[160];
		mysql_format(DB, str, sizeof(str), "UPDATE "USER_DB" SET `pAdmin`=%d, `pAdminCode`=%d WHERE `pID`=%d", PI[playerid][pAdmin], PI[playerid][pAdminCode], PI[playerid][pID]);
		mysql_tquery(DB, str);
		mySQL_DeleteAdmin(GetName(playerid));

		format(str, sizeof(str), "CONNECT // Admin '%s' does not exist in DB! His admin role is removed.", GetName(playerid));
		sendMessageToOwner(str);

		Log(admin_hacking_log, INFO, "Attempt to hack admin rank > SQLID (%d) > Player (%s) > IP (%s)", PI[playerid][pID], GetName(playerid), GetPlayerIP(playerid));
	}
	return 1;
}
//=======================================//
function mySQL_MakeAdmin(playerid)
{
	AdminInfo[playerid][adminID] = cache_insert_id();
	return 1;
}
//=======================================//
function mySQL_DeleteAdmin(nick[])
{
	new query[72];
	mysql_format(DB, query, sizeof(query), "DELETE FROM "ADMIN_DB" WHERE `adminName`='%s'", nick);
	mysql_tquery(DB, query);
	return 1;
}
//=======================================//
function mySQL_UpdateAdminCustomVal(i, field[], value)
{
	new query[72];
	mysql_format(DB, query, sizeof(query), "UPDATE "ADMIN_DB" SET `%s`=%d WHERE `adminID`=%d", field, value, AdminInfo[i][adminID]);
	mysql_tquery(DB, query);
	return 1;
}
//=======================================//
function mySQL_UpdateAdminCustomStr(i, field[], str[])
{
	new query[96];
	mysql_format(DB, query, sizeof(query), "UPDATE "ADMIN_DB" SET `%s`='%s' WHERE `adminID`=%d", field, str, AdminInfo[i][adminID]);
	mysql_tquery(DB, query);
	return 1;
}
//=======================================//
function ShowAdminList(playerid)
{
	new rows, dialog[3400], str[128], name[24], level, bool:isOnline, lastLogin[24];
	cache_get_row_count(rows);

	if(rows)
	{
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name_int(i, "adminLevel", level);
			cache_get_value_name_bool(i, "adminOnline", isOnline);
			cache_get_value_name(i, "adminName", name, 24);
			cache_get_value_name(i, "adminLastLogin", lastLogin, 24);

			if(!isOnline)
			{
				format(str, sizeof(str), ""SERVER"[%d] "WHITE" %s\tLevel %d\t"RED"Offline"WHITE" (%s)\n", i+1, name, level, lastLogin);
				strcat(dialog, str);
			}
			else
			{
				format(str, sizeof(str), ""SERVER"[%d] "WHITE" %s\tLevel %d\t"GREEN"Online\n", i+1, name, level);
				strcat(dialog, str);
			}
		}
		ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_TABLIST, ""SERVER"Solvine Deathmatch > "WHITE"Admin list", dialog, "OKAY", "");
	}
	else ErrorMessage(playerid, "There are not any admins on list.");
	return 1;
}
//==============================================================================//
ShowAdminStats(playerid, id) 
{
	new dialog[768], str[64];
	strdel(dialog, 0, sizeof(dialog));
	strcat(dialog, ""SERVER"________________________________\n");
	format(str, sizeof(str),""SERVER"> "WHITE"Admin: '%s'\n\n", GetName(id));
	strcat(dialog, str);
	format(str, sizeof(str),""SERVER"> "WHITE"Admin level: '%d'\n\n", PI[id][pAdmin]);
	strcat(dialog, str);

	format(str, sizeof(str), ""SERVER"> "WHITE"Admin commands: '%d'\n", AdminInfo[id][adminCMD]);
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"Banned: '%d'\n", AdminInfo[id][adminBan]);
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"Unbanned: '%d'\n", AdminInfo[id][adminUnban]);
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"Warns: '%d'\n", AdminInfo[id][adminWarn]);
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"Unwarns: '%d'\n", AdminInfo[id][adminUnwarn]);
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"Kicked: '%d'\n", AdminInfo[id][adminKick]);
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"Jailed: '%d'\n", AdminInfo[id][adminJail]);
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"Unjailed: '%d'\n", AdminInfo[id][adminUnjail]);
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"Spectated: '%d'\n", AdminInfo[id][adminSpec]);
	strcat(dialog, str);

	format(str, sizeof(str), ""SERVER"> "WHITE"Online time: '%dh:%dmin'\n", AdminInfo[id][adminHours], AdminInfo[id][adminMinutes]);
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"Last Login: '%s'\n", PI[id][pLastLogin]);
	strcat(dialog, str);

	strcat(dialog, ""SERVER"________________________________");
	ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_MSGBOX, ""SERVER"Solvine Deathmatch > "WHITE"Admin stats", dialog, "OKAY", "");
	return 1;
}
//=======================================//
AdminChatDialog(playerid)
{
	new dialog[256], str[64];
	format(str, sizeof(str), ""SERVER"> "WHITE"Alternative Chat\t"SERVER"[ %s ]\t[ A1 ]\n", ((WarnChat[playerid]) ? ("ON") : ("OFF")));
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"AC Pregled\t"SERVER"[ %s ]\t[ A1 ]\n", ((ACPreview[playerid]) ? ("ON") : ("OFF")));
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"Admin Pregled\t"SERVER"[ %s ]\t[ A3 ]\n", ((AdminPreview[playerid]) ? ("ON") : ("OFF")));
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"> "WHITE"PM Pregled\t"SERVER"[ %s ]\t[ A3 ]\n", ((PMPreview[playerid]) ? ("ON") : ("OFF")));
	strcat(dialog, str);

	ShowPlayerDialog(playerid, ADMIN_CHAT, DIALOG_STYLE_TABLIST, ""SERVER"Solvine Deathmatch > "WHITE"Admin Chat", dialog, "CHOOSE", "CANCEL");
}
//==============================================================================//
ShowAdminHelp(playerid, page)
{
	switch(page)
	{
		//=======================================//
		case 1:
		{
			ShowPlayerDialog(playerid, HELP_A1, DIALOG_STYLE_MSGBOX, ""SERVER"Solvine Deathmatch > "WHITE"Admin Panel", "\
				"SERVER"____________________________"WHITE"____________________________\n\n\
				"SERVER"> "WHITE"ADMIN LEVEL 1 Panel \t\t[ GAME ADMIN ]\n\n\
				\
				"SERVER"> "WHITE"/ahelp [/ah | /adminhelp] - description\n\
				"SERVER"> "WHITE"/asay - description\n\
				"SERVER"> "WHITE"/a - description\n\
				"SERVER"> "WHITE"/cc - description\n\
				"SERVER"> "WHITE"/weapons - description\n\
				"SERVER"> "WHITE"/ip - description\n\
				"SERVER"> "WHITE"/get [/gethere] - description\n\
				"SERVER"> "WHITE"/slap - odescription\n\
				"SERVER"> "WHITE"/freeze - description\n\
				"SERVER"> "WHITE"/unfreeze - description\n\
				"SERVER"> "WHITE"/mute - description\n\
				"SERVER"> "WHITE"/unmute - description\n\
				"SERVER"> "WHITE"/spec - description\n\
				"SERVER"> "WHITE"/specoff - description\n\
				"SERVER"> "WHITE"/jail - description\n\
				"SERVER"> "WHITE"/unjail - description\n\
				"SERVER"> "WHITE"/kick - description\n\
				"SERVER"> "WHITE"/check - description\n\
				"SERVER"> "WHITE"/alias - description\n\
				"SERVER"> "WHITE"/screenshare - description\n\
				"SERVER"> "WHITE"/ssclear - description\n\
				"SERVER"> "WHITE"/achat - description\n\
				"SERVER"> "WHITE"/reportlist - description\n\
\
				"SERVER"____________________________"WHITE"____________________________\n\
				", "CANCEL", "NEXT");
		}
		//=======================================//
		case 2:
		{
			ShowPlayerDialog(playerid, HELP_A2, DIALOG_STYLE_MSGBOX, ""SERVER"Solvine Deathmatch > "WHITE"Admin Panel", "\
				"SERVER"____________________________"WHITE"____________________________\n\n\
				"SERVER"> "WHITE"ADMIN LEVEL 2 Panel \t\t[ GENERAL ADMIN ]\n\n\
				\
				"SERVER"> "WHITE"/announce - description\n\
				"SERVER"> "WHITE"/kill - description\n\
				"SERVER"> "WHITE"/count - description\n\
				"SERVER"> "WHITE"/count2 - description\n\
				"SERVER"> "WHITE"/crash - description\n\
				"SERVER"> "WHITE"/giveweapon [/givegun | /gg] - description\n\
				"SERVER"> "WHITE"/prdni - description\n\
				"SERVER"> "WHITE"/spawn - description\n\
				"SERVER"> "WHITE"/dmkick - description\n\
				"SERVER"> "WHITE"/sethp - description\n\
				"SERVER"> "WHITE"/setarmour - description\n\
				"SERVER"> "WHITE"/explode - description\n\
				"SERVER"> "WHITE"/ban - description\n\
				"SERVER"> "WHITE"/offban - description\n\
				"SERVER"> "WHITE"/tempban - description\n\
				"SERVER"> "WHITE"/unban - description\n\
				"SERVER"> "WHITE"/baninfo - description\n\
				"SERVER"> "WHITE"/warn - description\n\
				"SERVER"> "WHITE"/unwarn - description\n\
				"SERVER"> "WHITE"/muted - description\n\
				"SERVER"> "WHITE"/jailed - description\n\
				"SERVER"> "WHITE"/warned - description\n\
\
				"SERVER"____________________________"WHITE"____________________________\n\
				", "PREVIOUS", "NEXT");
		}
		//=======================================//
		case 3:
		{
			ShowPlayerDialog(playerid, HELP_A3, DIALOG_STYLE_MSGBOX, ""SERVER"Solvine Deathmatch > "WHITE"Admin Panel", "\
				"SERVER"____________________________"WHITE"____________________________\n\n\
				"SERVER"> "WHITE"ADMIN LEVEL 3 Panel \t\t[ OWNER ]\n\n\
				\
				"SERVER"> "WHITE"/jetpack [/jp] - description\n\
				"SERVER"> "WHITE"/up - description\n\
				"SERVER"> "WHITE"/down - description\n\
				"SERVER"> "WHITE"/setint - description\n\
				"SERVER"> "WHITE"/setvw - description\n\
				"SERVER"> "WHITE"/gotopos [/portloc | /gotox] - description\n\
				"SERVER"> "WHITE"/god - description\n\
				"SERVER"> "WHITE"/alladmins - description\n\
				"SERVER"> "WHITE"/changename - description\n\
				"SERVER"> "WHITE"/coordinates [/location] - description\n\
				"SERVER"> "WHITE"/checkadmin - description\n\
				"SERVER"> "WHITE"/setacode - description\n\
				"SERVER"> "WHITE"/make - description\n\
				"SERVER"> "WHITE"/deleteacc - description\n\
				"SERVER"> "WHITE"/arenalock - description\n\
				"SERVER"> "WHITE"/server - description\n\
				\
				"SERVER"> "WHITE"Map Teleport - description\n\
				"SERVER"> "WHITE"Speed-Boost - description\n\
				"SERVER"> "WHITE"Jump-Boost - description\n\
				"SERVER"____________________________"WHITE"____________________________\n\
				", "PREVIOUS", "CANCEL");
		}
		//=======================================//
	}
	return 1;
}
//==============================================================================//
sendMessageToOwner(string[]) 
{
	foreach(new i:Player) 
		if(Spawned[i])
			if(PI[i][pAdmin] >= 3) 
				SendClientMessage(i, COL_SERVER, string); 

	Log(owner_msg_log, INFO, string);
	return 1;
}
//=======================================//
sendMessageToAdmin(string[]) 
{
	new str[160];
	format(str, sizeof(str), "ADMIN ONLY: "WHITE"%s", string);
	foreach(new i:Player) 
		if(Spawned[i])
			if(PI[i][pAdmin] >= 1) 
				SendClientMessage(i, COL_SERVER, str); 
	return 1;
}
//=======================================//
APregled(playerid, cmd[])
{
	new str[160]; 
	AdminInfo[playerid][adminCMD]++;
	mySQL_UpdateAdminCustomVal(playerid, "adminCMD", AdminInfo[playerid][adminCMD]);

	format(str, sizeof(str), "~p~~h~(AH)~w~ Admin: ~p~~h~%s~w~ // CMD: ~p~~h~%s", GetName(playerid), cmd);
	foreach(new i:Player)
	{
		if(Spawned[i])
		{
			if(WarnChat[i] && AdminPreview[i] && PI[i][pAdmin] == 3)
			{
				if(!isAltChatToggled(i)) toggleAltChat(i);
				sendAltChatMessage(i, str);
			}
		}
	}

	Log(admin_log, INFO, "Admin (%s) > CMD (%s)", GetName(playerid), cmd);
	return 1;
}
//=======================================//
GetAdminRankName(playerid)
{
	new name[16];
	switch(PI[playerid][pAdmin])
	{
		case 1: name = "Game Admin";
		case 2: name = "General Admin";
		case 3: name = "Community Owner";
		default: name = "None";
	}
	return name;
}
//==============================================================================//
function mySQL_CheckAlias(playerid, name[])
{
	if(cache_num_rows() == 0) return ErrorMessage(playerid, "There is no player with that name in database.");
	new ip[16], query[72];
	cache_get_value_name(0, "pIP", ip, 16);
	mysql_format(DB, query, sizeof(query), "SELECT `pID`, `pName` FROM "USER_DB" WHERE `pIP`='%s'", ip);
	mysql_tquery(DB, query, "mySQL_CheckAliasIP", "iss", playerid, ip, name);
	return 1;
}
//=======================================//
function mySQL_CheckAliasIP(playerid, ip[], searched_name[])
{
	if(cache_num_rows() == 0) return ErrorMessage(playerid, "There is no player with that IP in database.");
	new id, name[24], str[72], dialog[256];

	format(str, sizeof(str), ""SERVER"[ Name ] "WHITE"%s\n", searched_name);
	strcat(dialog, str);
	format(str, sizeof(str), ""SERVER"[ IP ] "WHITE"%s\n", ip);
	strcat(dialog, str);
	for(new i = 0; i < cache_num_rows(); i++) 
	{
		cache_get_value_name_int(i, "pID", id);
		cache_get_value_name(i, "pName", name, 24);

		format(str, sizeof(str), ""SERVER"[ %d ] "WHITE"%s\n", id, name);
		strcat(dialog, str);
	}
	ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_LIST, ""SERVER"Solvine Deathmatch > "WHITE"Alias", dialog, "OKAY", "");
	return 1;
}
//==============================================================================//
function GodUpdate(playerid)
{
	if(GodMode[playerid])
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			new Float:HP;
			GetVehicleHealth(GetPlayerVehicleID(playerid), HP);
			if(HP < 999.0)
			{
				RepairVehicle(GetPlayerVehicleID(playerid));
				SetVehicleHealth(GetPlayerVehicleID(playerid), 1000.0);
			}
		}
		SetPlayerHealth(playerid, 100.0);
		SetPlayerArmour(playerid, 100.0);
				
		GodTimer[playerid] = SetTimerEx("GodUpdate", 250, false, "d", playerid);
	}
	else
	{
		AC_KillTimer(GodTimer[playerid]);
	}
	return 1;
}
//==============================================================================//
