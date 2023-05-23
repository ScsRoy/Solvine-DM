//==============================================================================//
/*
	* Module: whitelist.pwn
	* Author: Sule
	* Date: 05.05.2020
*/
//==============================================================================//
loadingWhitelist(playerid)
{
	ClearChat(playerid, 20);
	TogglePlayerSpectating(playerid, true);

	InterpolateCameraPos(playerid, 1039.624511, -1955.488037, 227.646926, 1479.973632, -2255.286376, 50.983421, 15000);
	InterpolateCameraLookAt(playerid, 1043.405029, -1958.182128, 225.789596, 1475.610107, -2252.845214, 50.968055, 1000);

	InfoMessage(playerid, "Welcome to Solvine Deathmatch. You are not on whitelist for this server.");
	InfoMessage(playerid, "First you need send request for whitelist.");

	new string[72];
	format(string, sizeof(string), "Whitelisted:~n~~p~~h~~h~%d~n~Online:~n~~p~~h~~h~%d", ServerInfo[serverWhitelisted], ServerInfo[onlinePlayers]);
	TextDrawSetString(whitelistTD[4], string);
	controlWhitelistTD(playerid, true);
	return 1;
}
//=======================================//
getWhitelistStatus(type)
{
	new name[24];
	switch(type)
	{
		case WL_PENDING: name = "PENDING";
		case WL_ACCEPTED: name = "ACCEPTED";
		case WL_REFUSED: name = "REFUSED";
	}
	return name;
}
//=======================================//
setDiscordNickname(id)
{
	#if USE_DISCORD == true
		static query[96], Cache:result;
		mysql_format(DB, query, sizeof(query), "SELECT `wlName`, `wlDiscord`, `wlDiscriminator` FROM "WL_DB" WHERE `wlID`=%d", id);
		result = mysql_query(DB, query);
		if(cache_num_rows() > 0)
		{
			new name[24], discord[32], code[5], DCC_User:user;
			cache_get_value_name(0, "wlName", name, 24);
			cache_get_value_name(0, "wlDiscord", discord, 32);
			cache_get_value_name(0, "wlDiscriminator", code, 5);

			user = DCC_FindUserByName(discord, code);
			if(user != DCC_INVALID_USER)
			{
				DCC_SetGuildMemberNickname(DiscordInfo[server_id], user, name);
			}
			else sendMessageToOwner("WL // Can not change user nickname on discord. (INVALID USER)");
		}
		else sendMessageToOwner("WL // Can not change user nickname on discord. (DB ERROR)");
		cache_delete(result);
	#endif
	return 1;
}
//==============================================================================//
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(whitelistTDShown[playerid])
	{
		//======================================================================//
		if(clickedid == whitelistTD[11])//Join
		{
			controlWhitelistTD(playerid, false);

			ShowPlayerDialog(playerid, WL_NAME, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Whitelist [Name]", "\
				"SERVER"__________________________________________________\n\
				"SERVER"> "WHITE"Do you want to keep your nickname?\n\
				"SERVER"> "WHITE"You can change your nickname later in settings\n\
				"SERVER"> "WHITE"To keep your nickname just press 'NEXT'\n\
				"SERVER"__________________________________________________\n\
				", "NEXT", "KICK");
			return 1;
		}
		//======================================================================//
		else if(clickedid == whitelistTD[12])//Exit
		{
			controlWhitelistTD(playerid, false);

			ClearChat(playerid, 20);
			SetPlayerColor(playerid, COL_BLACK);
			onPlayerKicked(playerid, ">AC<", "Refused to sing up for whitelist.");
			return 1;
		}
		//======================================================================//
	}
	#if defined wl_OnPlayerClickTextDraw
		return wl_OnPlayerClickTextDraw(playerid, clickedid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerClickTextDraw
	#undef OnPlayerClickTextDraw
#else
	#define _ALS_OnPlayerClickTextDraw
#endif

#define OnPlayerClickTextDraw wl_OnPlayerClickTextDraw
#if defined wl_OnPlayerClickTextDraw
	forward wl_OnPlayerClickTextDraw(playerid, Text:clickedid);
#endif
//==============================================================================//
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		//======================================================================//
		case WL_NAME:
		{
			if(!response)
			{
				controlWhitelistTD(playerid, false);

				ClearChat(playerid, 20);
				SetPlayerColor(playerid, COL_BLACK);
				onPlayerKicked(playerid, ">AC<", "Refused to sing up for whitelist.");
				return 1;
			}
			if(response)
			{
				new name[24];
				if(sscanf(inputtext, "s[24]", name))
				{
					strmid(WLInfo[playerid][wlName], GetName(playerid), 0, strlen(GetName(playerid)));
				}
				else
				{
					if(SetPlayerName(playerid, name) == -1)
					{
						ShowPlayerDialog(playerid, WL_NAME, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Whitelist [Name]", "\
							"SERVER"__________________________________________________\n\
							"SERVER"> "WHITE"Do you want to keep your nickname?\n\
							"SERVER"> "WHITE"You can change your nickname later in settings\n\
							"SERVER"> "WHITE"To keep your nickname just press 'NEXT'\n\
							"SERVER"__________________________________________________\n\
							", "NEXT", "KICK");
						return 1;
					}
					strmid(WLInfo[playerid][wlName], name, 0, strlen(name));
				}
				strmid(WLInfo[playerid][wlIP], GetPlayerIP(playerid), 0, strlen(GetPlayerIP(playerid)));

				ClearChat(playerid, 20);
				InfoMessage(playerid, "You have successfully entered your server nickname. (%s)", name);
				ShowPlayerDialog(playerid, WL_MAIL, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Whitelist [E-Mail]", "\
					"SERVER"__________________________________________________\n\
					"SERVER"> "WHITE"You had just chosen your nickname\n\
					"SERVER"> "WHITE"Now, please enter your VALID e-mail\n\
					"SERVER"> "WHITE"You CAN NOT change your email later\n\
					"SERVER"__________________________________________________\n\
					", "NEXT", "KICK");
			}
			return 1;
		}
		//======================================================================//
		case WL_MAIL:
		{
			if(!response)
			{
				controlWhitelistTD(playerid, false);

				ClearChat(playerid, 20);
				SetPlayerColor(playerid, COL_BLACK);
				onPlayerKicked(playerid, ">AC<", "Refused to sing up for whitelist.");
				return 1;
			}
			if(response)
			{
				new mail[48];
				if(sscanf(inputtext, "s[48]", mail))
				{
					ShowPlayerDialog(playerid, WL_MAIL, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Whitelist [E-Mail]", "\
						"SERVER"__________________________________________________\n\
						"SERVER"> "WHITE"You had just chosen your nickname\n\
						"SERVER"> "WHITE"Now, please enter your VALID e-mail\n\
						"SERVER"> "WHITE"You CAN NOT change your email later\n\
						"SERVER"__________________________________________________\n\
						", "NEXT", "KICK");
					return 1;
				}
				if(!IsValidEmail(mail))
				{
					ShowPlayerDialog(playerid, WL_MAIL, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Whitelist [E-Mail]", "\
						"SERVER"__________________________________________________\n\
						"SERVER"> "WHITE"You had just chosen your nickname\n\
						"SERVER"> "WHITE"Now, please enter your VALID e-mail\n\
						"SERVER"> "WHITE"You CAN NOT change your email later\n\
						"SERVER"__________________________________________________\n\
						", "NEXT", "KICK");
					return 1;
				}
				strmid(WLInfo[playerid][wlEmail], mail, 0, strlen(mail));

				InfoMessage(playerid, "You have successfully entered your e-mail. (%s)", mail);
				ShowPlayerDialog(playerid, WL_DISCORD, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Whitelist [Discord Username]", "\
					"SERVER"__________________________________________________\n\
					"SERVER"> "WHITE"You had just entered your e-mail\n\
					"SERVER"> "WHITE"Now, please enter your VALID discord username including your discriminator\n\
					"SERVER"> "WHITE"You CAN NOT change your discord username later\n\
					"SERVER"> "WHITE"You have to be joined on our discord: discord.gg/ \n\
					"SERVER"> "WHITE"For exapmle: "SERVER"Jose#1234\n\
					"SERVER"__________________________________________________\n\
					", "NEXT", "KICK");
			}
			return 1;
		}
		//======================================================================//
		case WL_DISCORD:
		{
			if(!response)
			{
				controlWhitelistTD(playerid, false);

				ClearChat(playerid, 20);
				SetPlayerColor(playerid, COL_BLACK);
				onPlayerKicked(playerid, ">AC<", "Refused to sing up for whitelist.");
				return 1;
			}
			if(response)
			{
				new name[48], code[8];
				if(sscanf(inputtext, "p<#>s[48]s[8]", name, code))
				{
					ShowPlayerDialog(playerid, WL_DISCORD, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Whitelist [Discord Username]", "\
						"SERVER"__________________________________________________\n\
						"SERVER"> "WHITE"You had just entered your e-mail\n\
						"SERVER"> "WHITE"Now, please enter your VALID discord username including your discriminator\n\
						"SERVER"> "WHITE"You CAN NOT change your discord username later\n\
						"SERVER"> "WHITE"You have to be joined on our discord: discord.gg/ \n\
						"SERVER"> "WHITE"For exapmle: "SERVER"Jose#1234\n\
						"SERVER"__________________________________________________\n\
						", "NEXT", "KICK");
					return 1;
				}

				#if USE_DISCORD == true
					new DCC_User:user = DCC_FindUserByName(name, code);
					if(user == DCC_INVALID_USER)
					{
						ShowPlayerDialog(playerid, WL_DISCORD, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Whitelist [Discord Username]", "\
							"SERVER"__________________________________________________\n\
							"SERVER"> "WHITE"You had just entered your e-mail\n\
							"SERVER"> "WHITE"Now, please enter your VALID discord username including your discriminator\n\
							"SERVER"> "WHITE"You CAN NOT change your discord username later\n\
							"SERVER"> "WHITE"You have to be joined on our discord: discord.gg/ \n\
							"SERVER"> "WHITE"For exapmle: "SERVER"Jose#1234\n\
							"SERVER"__________________________________________________\n\
							", "NEXT", "KICK");
						return 1;
					}
					else
					{
						strmid(WLInfo[playerid][wlDiscord], name, 0, strlen(name));
						strmid(WLInfo[playerid][wlDiscriminator], code, 0, strlen(code));

						static query[256];
						mysql_format(DB, query, sizeof(query), "INSERT INTO "WL_DB" SET `wlName`='%s', `wlIP`='%s', `wlEmail`='%s', `wlDiscord`='%s', `wlDiscriminator`='%s',  `wlStatus`=1", WLInfo[playerid][wlName], WLInfo[playerid][wlIP], WLInfo[playerid][wlEmail], name, code);
						mysql_tquery(DB, query, "onWhitelistSingUp", "d", playerid);
					}
				#else
					strmid(WLInfo[playerid][wlDiscord], name, 0, strlen(name));
					strmid(WLInfo[playerid][wlDiscriminator], code, 0, strlen(code));
						
					static query[256];
					mysql_format(DB, query, sizeof(query), "INSERT INTO "WL_DB" SET `wlName`='%s', `wlIP`='%s', `wlEmail`='%s', `wlDiscord`='%s', `wlDiscriminator`='%s', `wlStatus`=1", WLInfo[playerid][wlName], WLInfo[playerid][wlIP], WLInfo[playerid][wlEmail], name, code);
					mysql_tquery(DB, query, "onWhitelistSingUp", "d", playerid);L
				#endif

				InfoMessage(playerid, "You have successfully entered your server discord username. (%s#%s)", name, code);

				new str[192];
				ClearChat(playerid, 20);
				TogglePlayerSpectating(playerid, true);
				controlAlertTD(playerid, true);

				format(str, sizeof(str), "ID: %04d~n~Name: %s~n~IP: %s~n~E-Mail: %s~n~Dicord username: %s#%s~n~Status: PENDING", WLInfo[playerid][wlID], WLInfo[playerid][wlName], WLInfo[playerid][wlIP], WLInfo[playerid][wlDiscord], WLInfo[playerid][wlDiscriminator]);
				PlayerTextDrawSetString(playerid, alertPTD, str);
				SetTimerEx("kickPlayer", 250, false, "i", playerid);

				Log(whitelist_log, INFO, "Whitelist request > User (%04d - %s)", WLInfo[playerid][wlID], GetName(playerid));

				format(str, sizeof(str), ">>> New whitelist request. (%s)", GetName(playerid));
				DCC_SendChannelMessage(DiscordInfo[whitelist], str);

				format(str, sizeof(str), "WL // New whitelist request. (%04d - %s)", WLInfo[playerid][wlID], GetName(playerid));
				sendMessageToOwner(str);
			}
			return 1;
		}
		//======================================================================//

	}
	#if defined wl_OnDialogResponse
		return wl_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnDialogResponse
	#undef OnDialogResponse
#else
	#define _ALS_OnDialogResponse
#endif

#define OnDialogResponse wl_OnDialogResponse
#if defined wl_OnDialogResponse
	forward wl_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif
//==============================================================================//
function onWhitelistSingUp(playerid)
{
	WLInfo[playerid][wlID] = cache_insert_id();
	return 1;
}
//==============================================================================//
