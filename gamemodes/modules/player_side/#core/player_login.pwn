//==============================================================================//
/*
	* Module: player_login.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
loadingLogin(playerid)
{
	TogglePlayerSpectating(playerid, true);
	ResetVariables(playerid, true);

	InterpolateCameraPos(playerid, 1039.624511, -1955.488037, 227.646926, 1479.973632, -2255.286376, 50.983421, 15000);
	InterpolateCameraLookAt(playerid, 1043.405029, -1958.182128, 225.789596, 1475.610107, -2252.845214, 50.968055, 1000);

	InfoMessage(playerid, "Welcome to Solvine Deathmatch. Your account was found successfully.");
	InfoMessage(playerid, "You have 60 seconds to login before being automaticly kicked.");

	new dialog[512];
	format(dialog, sizeof(dialog), "\
		"SERVER"> "WHITE"Welcome back '%s' on Solvine Deathmatch!\n\
		"SERVER"__________________________________________\n\n\
		"SERVER"> "WHITE"Your account: "GREEN"found!\n\n\
		"SERVER"> "WHITE"Enter: "GREEN"password!\n\
		"SERVER"__________________________________________", GetName(playerid));
	ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, ""SERVER"Solvine Deathmatch > "WHITE"Login", dialog, "LOGIN", "KICK");
	
	SetTimerEx("AutoKick", 60 * 1000, false, "i", playerid);
	return 1;
}
//==============================================================================//
function AutoKick(playerid) 
{
	if(LoggedIn[playerid]) return 1;
	onPlayerKicked(playerid, ">AC<", "60 seconds pass, you are being automaticly kicked.");
	return 1;
}
//==============================================================================//
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		//======================================================================//
		case DIALOG_LOGIN:
		{
			if(!response) return onPlayerKicked(playerid, ">AC<", "Refused to enter password.");
			if(response)
			{
				new dialog[512];
				format(dialog, sizeof(dialog), "\
					"SERVER"> "WHITE"Welcome back '%s' on Solvine Deathmatch!\n\
					"SERVER"__________________________________________\n\n\
					"SERVER"> "WHITE"Your account: "GREEN"found!\n\n\
					"SERVER"> "WHITE"Enter: "GREEN"password!\n\
					"SERVER"__________________________________________", GetName(playerid));
				
				new password[24], pw[65];
				if(sscanf(inputtext, "s[24]", password)) return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, ""SERVER"Solvine Deathmatch > "WHITE"Login", dialog, "LOGIN", "KICK");
				if(strlen(password) < 6 || strlen(password) > 24) return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, ""SERVER"Solvine Deathmatch > "WHITE"Login", dialog, "LOGIN", "KICK");

				SHA256_PassHash(password, "", pw, 65);
				LoggedIn[playerid] = true;

				if(strcmp(pw, PI[playerid][pPassword]) == 0)
				{
					new query[96];
					mysql_format(DB, query, sizeof(query), "SELECT * FROM "USER_DB" WHERE `pName`='%s' LIMIT 1", GetName(playerid));
					mysql_tquery(DB, query, "onPlayerLogin", "d", playerid);
				}
				else 
				{
					LoginTries[playerid]++;
					if(LoginTries[playerid] < 5)
					{
						InfoMessage(playerid, "Wrong password! ( %d / 5 )", LoginTries[playerid]);
						ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, ""SERVER"Solvine Deathmatch > "WHITE"Login", dialog, "LOGIN", "KICK");
					}
					else
					{
						onPlayerKicked(playerid, ">AC<", "Wrong password! ( 5 / 5 )");
					}
				}
			}
			return 1;
		}
		//======================================================================//
		case ADMIN_LOGIN:
		{
			if(!response) return onPlayerKicked(playerid, ">AC<", "Refused to enter admin PIN code.");
			if(response)
			{
				new code;
				if(sscanf(inputtext, "i", code)) return 
					ShowPlayerDialog(playerid, ADMIN_LOGIN, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Admin Login", "\
						"SERVER"> "WHITE"You are an admin on this server.\n\
						"SERVER"__________________________________________\n\n\
						"SERVER"> "WHITE"Please, enter your Admin PIN Code.\n\n\
						"SERVER"> "WHITE"You have one try to enter pin code.\n\
						"SERVER"__________________________________________\n\n\
						", "ENTER", "KICK");
				if(code != PI[playerid][pAdminCode]) return onPlayerKicked(playerid, ">AC<", "Wrong admin PIN code.");

				AC_SetMoney(playerid, PI[playerid][pMoney]);
				SetPlayerScore(playerid, PI[playerid][pKills]);

				ClearChat(playerid, 20);
				TogglePlayerSpectating(playerid, false);
				new str[84];
				format(str, sizeof(str), "[ > ] "WHITE"Admin %s has just logged in back to server.", GetName(playerid));
				SendClientMessageToAll(COL_GREEN, str);

				#if USE_DISCORD == true
					new string[96];
					format(string, sizeof(string), ">>> Admin %s(%d) has just logged in back to server.", GetName(playerid), playerid);
					DCC_SendChannelMessage(DiscordInfo[log_in_log_out], string);
				#endif				
			}
			return 1;
		}
		//======================================================================//
	}
	
	#if defined login_OnDialogResponse
		return login_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnDialogResponse
	#undef OnDialogResponse
#else
	#define _ALS_OnDialogResponse
#endif

#define OnDialogResponse login_OnDialogResponse
#if defined login_OnDialogResponse
	forward login_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif
//==============================================================================//
function onPlayerLogin(playerid)
{
	if(cache_num_rows() > 0)
	{
		//=======================================//

		// ---------------- // Info
		cache_get_value_int(0, "pID", PI[playerid][pID]);
		cache_get_value(0, "pName", PI[playerid][pName], 24);
		cache_get_value(0, "pIP", PI[playerid][pIP], 15);
		cache_get_value(0, "pPassword", PI[playerid][pPassword], 65);
		cache_get_value(0, "pRegDate", PI[playerid][pRegDate], 24);
		cache_get_value(0, "pLastLogin", PI[playerid][pLastLogin], 24);
		cache_get_value_int(0, "pHours", PI[playerid][pHours]);
		cache_get_value_int(0, "pMinutes", PI[playerid][pMinutes]);

		// ---------------- // 
		cache_get_value_int(0, "pAdmin", PI[playerid][pAdmin]);
		cache_get_value_int(0, "pAdminCode", PI[playerid][pAdminCode]);
		cache_get_value_bool(0, "pPremium", PI[playerid][pPremium]);
		cache_get_value_int(0, "pPremiumHours", PI[playerid][pPremiumHours]);
		cache_get_value_int(0, "pJail", PI[playerid][pJail]);
		cache_get_value(0, "pJailReason", PI[playerid][pJailReason], 16);
		cache_get_value_int(0, "pMute", PI[playerid][pMute]);
		cache_get_value(0, "pMuteReason", PI[playerid][pMuteReason], 16);
		cache_get_value_int(0, "pWarn", PI[playerid][pWarn]);

		// ---------------- // Main
		cache_get_value_int(0, "pSkinID", PI[playerid][pSkinID]);
		cache_get_value_int(0, "pKills", PI[playerid][pKills]);
		cache_get_value_int(0, "pDeaths", PI[playerid][pDeaths]);
		cache_get_value_int(0, "pMaxKS", PI[playerid][pMaxKS]);
		cache_get_value_int(0, "pMoney", PI[playerid][pMoney]);
		cache_get_value_int(0, "pDayKills", PI[playerid][pDayKills]);
		cache_get_value_int(0, "pDayDeaths", PI[playerid][pDayDeaths]);
		cache_get_value_int(0, "pDayWins", PI[playerid][pDayWins]);
		cache_get_value_int(0, "pMonthKills", PI[playerid][pMonthKills]);
		cache_get_value_int(0, "pMonthDeaths", PI[playerid][pMonthDeaths]);
		cache_get_value_int(0, "pMonthWins", PI[playerid][pMonthWins]);

		// ---------------- // Rank
		cache_get_value_int(0, "pRank", PI[playerid][pRank]);
		cache_get_value_int(0, "pArenaKills", PI[playerid][pArenaKills]);
		cache_get_value_int(0, "pArenaDeaths", PI[playerid][pArenaDeaths]);
		cache_get_value_int(0, "pDuelWins", PI[playerid][pDuelWins]);
		cache_get_value_int(0, "pDuelDefeats", PI[playerid][pDuelDefeats]);
		cache_get_value_int(0, "pVersusWins", PI[playerid][pVersusWins]);
		cache_get_value_int(0, "pVersusDefeats", PI[playerid][pVersusDefeats]);

		//=======================================//
	}

	new query[96];
	PI[playerid][pOnline] = true;
	strmid(PI[playerid][pIP], GetPlayerIP(playerid), 0, strlen(GetPlayerIP(playerid)));
	mysql_format(DB, query, sizeof(query), "UPDATE "USER_DB" SET `pOnline`=1, `pIP`='%s' WHERE `pID`=%d", PI[playerid][pIP], PI[playerid][pID]);
	mysql_tquery(DB, query);

	//=======================================//

	FirstSpawn[playerid] = true;
	Log(login_log, INFO, "Login > SQLID (%d) > Player (%s) > IP (%s)", PI[playerid][pID], GetName(playerid), GetPlayerIP(playerid));

	//=======================================//

	if(isNameScriptDefined(GetName(playerid)))
/*	{
		if(PI[playerid][pAdmin] == 1)
		{
			AdminInfo[playerid][adminLevel] = 3;
			PI[playerid][pAdmin] = 3;
			PI[playerid][pAdminCode] = 1;

			mysql_format(DB, query, sizeof(query), "INSERT INTO "ADMIN_DB" (`adminName`,`adminLevel`) \
				VALUES ('%s', '3')",
				GetName(playerid));
			mysql_tquery(DB, query, "mySQL_MakeAdmin", "d", playerid);

			mysql_format(DB, query, sizeof(query), "UPDATE "USER_DB" SET `pAdmin`=3, `pAdminCode`=1 WHERE `pID`=%d", PI[playerid][pID]);
			mysql_tquery(DB, query);
		}
	}

	//=======================================//

	if(PI[playerid][pAdmin] > 1)
	{
		mysql_format(DB, query, sizeof(query), "SELECT * FROM "ADMIN_DB" WHERE `adminName`='%e' LIMIT 1", GetName(playerid));
		mysql_tquery(DB, query, "mySQL_LoadAdmin", "i", playerid);

		ShowPlayerDialog(playerid, ADMIN_LOGIN, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Admin Login", "\
			"SERVER"> "WHITE"You are an admin on this server.\n\
			"SERVER"__________________________________________\n\n\
			"SERVER"> "WHITE"Please, enter your Admin PIN Code.\n\n\
			"SERVER"> "WHITE"You have one try to enter pin code.\n\
			"SERVER"__________________________________________\n\n\
			", "ENTER", "KICK");
	}
	else*/
	{
		AC_SetMoney(playerid, PI[playerid][pMoney]);
		SetPlayerScore(playerid, PI[playerid][pKills]);

		ClearChat(playerid, 20);
		TogglePlayerSpectating(playerid, false);
		new str[84];
		format(str, sizeof(str), "[ > ] "WHITE"%s has just logged in back to server.", GetName(playerid));
		SendClientMessageToAll(COL_GREEN, str);

		#if USE_DISCORD == true
			new string[96];
			format(string, sizeof(string), ">>> Player %s(%d) has just logged in back to server.", GetName(playerid), playerid);
			DCC_SendChannelMessage(DiscordInfo[log_in_log_out], string);
		#endif
	}

	//=======================================//
	return 1;
}
//==============================================================================//
