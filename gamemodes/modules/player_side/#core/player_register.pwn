//==============================================================================//
/*
	* Module: player_register.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
loadingRegister(playerid)
{
	TogglePlayerSpectating(playerid, true);
	ResetVariables(playerid, true);

	InterpolateCameraPos(playerid, 1039.624511, -1955.488037, 227.646926, 1479.973632, -2255.286376, 50.983421, 15000);
	InterpolateCameraLookAt(playerid, 1043.405029, -1958.182128, 225.789596, 1475.610107, -2252.845214, 50.968055, 1000);

	InfoMessage(playerid, "Welcome to Solvine Deathmatch You dont have account on this server.");
	InfoMessage(playerid, "You need to register to play on our server.");

	setupRegisterDialog(playerid);
	return 1;
}
//==============================================================================//
setupRegisterDialog(playerid)
{
	new str[72], dialog[512+128];
	format(str, sizeof(str), ""SERVER"> "WHITE"Nickname\t"SERVER"[ %s ]\n", GetName(playerid));
	strcat(dialog, str);
	strcat(dialog, ""SERVER"> "WHITE"\n");

	if(RegisterPW[playerid]) format(str, sizeof(str), ""SERVER"> "WHITE"Password\t"SERVER"[ %s ]\n", RegisterPass[playerid]);
	else format(str, sizeof(str), ""SERVER"> "WHITE"Password\t"SERVER"[ Enter Password ]\n");
	strcat(dialog, str);

	if(RegisterSex[playerid]) format(str, sizeof(str), ""SERVER"> "WHITE"Sex\t"SERVER"[ %s ]\n", (PI[playerid][pSex] ? "Male" : "Female" ));
	else format(str, sizeof(str), ""SERVER"> "WHITE"Sex\t"SERVER"[ Choose Sex ]\n");
	strcat(dialog, str);

	strcat(dialog, ""SERVER"> "WHITE"\n"SERVER"> "WHITE"\n"SERVER"> "WHITE"\n"SERVER"> "WHITE"\n");
	strcat(dialog, ""SERVER"> "WHITE"Finish Registration\t"SERVER"[ > ]");

	ShowPlayerDialog(playerid, REGISTER_LIST, DIALOG_STYLE_TABLIST, ""SERVER"Solvine Deathmatch > "WHITE"Welcome.", dialog, "NEXT", "KICK");
	return 1;
}
//==============================================================================//
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		//======================================================================//
		case REGISTER_LIST:
		{
			if(!response) 
			{
				onPlayerKicked(playerid, "Solvine Deathmatch", "Failed registration.");
			}
			if(response)
			{
				switch(listitem)
				{
					case 2:
					{
						new dialog[512];
						format(dialog, sizeof(dialog), "\
							"SERVER"> "WHITE"Welcome '%s' on Solvine Deathmatch !\n\
							"SERVER"__________________________________________\n\
							"SERVER"> "WHITE"Your account: "RED"wasnt found!\n\
							"SERVER"> "WHITE"Enter: "GREEN"password!\n\
							"SERVER"> "WHITE"Length: "GREEN"6 - 24!\n\
							"SERVER"__________________________________________", GetName(playerid));

						ShowPlayerDialog(playerid, REGISTER_PW, DIALOG_STYLE_PASSWORD, ""SERVER"Solvine Deathmatch > "WHITE"Welcome", dialog, "ENTER", "KICK");
					}
					case 3:
					{
						new dialog[512];
						format(dialog, sizeof(dialog), "\
							"SERVER"> "WHITE"Welcome '%s' on Solvine Deathmatch !\n\
							"SERVER"__________________________________________\n\
							"SERVER"> "WHITE"Your account: "RED"wasnt found!\n\
							"SERVER"> "WHITE"Choose: "GREEN"sex!\n\
							"SERVER"__________________________________________", GetName(playerid));

						ShowPlayerDialog(playerid, REGISTER_SEX, DIALOG_STYLE_MSGBOX, ""SERVER"Solvine Deathmatch > "WHITE"Welcome", dialog, "MALE", "FEMALE");
					}
					case 8:
					{
						if(!RegisterPW[playerid] || !RegisterSex[playerid])
						{
							new dialog[256];
							strcat(dialog, "__________________________________________\n");
							if(!RegisterPW[playerid])
							{
								strcat(dialog, ""RED"> "WHITE"You didnt enter password.\n");
							}
							if(!RegisterSex[playerid])
							{
								strcat(dialog, ""RED"> "WHITE"You didnt choose sex.\n");
							}
							strcat(dialog, "__________________________________________");
							ShowPlayerDialog(playerid, REGISTER_FAILED, DIALOG_STYLE_MSGBOX, ""RED"Solvine Deathmatch > "WHITE"Welcome", dialog, "OKAY", "");
						}
						else
						{
							PI[playerid][pSkinID] = 23;
							LoggedIn[playerid] = true;

							new query[256];
							mysql_format(DB, query, sizeof(query), "INSERT INTO "USER_DB" SET \
								`pName`='%s', `pPassword`='%s', `pSex`=%d, `pRegDate`=NOW(), `pLastLogin`=NOW(), `pSkinID`=23, `pIP`='%s'", GetName(playerid), PI[playerid][pPassword], PI[playerid][pSex], GetPlayerIP(playerid));
							mysql_tquery(DB, query, "onPlayerRegister", "d", playerid);	
						}
					}
					default:
					{
						setupRegisterDialog(playerid);
					}
				}
			}
			return 1;
		}
		//======================================================================//
		case REGISTER_PW:
		{
			if(!response) return onPlayerKicked(playerid, ">AC<", "Failed registration.");
			if(response)
			{
				new dialog[512];
				format(dialog, sizeof(dialog), "\
					"SERVER"> "WHITE"Welcome '%s' on Solvine Deathmatch!\n\
					"SERVER"__________________________________________\n\
					"SERVER"> "WHITE"Your account: "RED"wasnt found!\n\
					"SERVER"> "WHITE"Enter: "GREEN"password!\n\
					"SERVER"> "WHITE"Length: "GREEN"6 - 24!\n\
					"SERVER"__________________________________________", GetName(playerid));

				new password[24];
				if(sscanf(inputtext, "s[24]", password)) return ShowPlayerDialog(playerid, REGISTER_PW, DIALOG_STYLE_PASSWORD, ""SERVER"Solvine Deathmatch > "WHITE"Welcome", dialog, "ENTER", "KICK");
				if(strlen(inputtext) < 6 || strlen(inputtext) > 24) return ShowPlayerDialog(playerid, REGISTER_PW, DIALOG_STYLE_PASSWORD, ""SERVER"Solvine Deathmatch > "WHITE"Welcome", dialog, "ENTER", "KICK");

				SHA256_PassHash(password, "", PI[playerid][pPassword], 65);
				strmid(RegisterPass[playerid], password, 0, strlen(password)+1);

				ClearChat(playerid, 20);
				RegisterPW[playerid] = true;
				InfoMessage(playerid, "You successfully entered password! Your password: '%s'", password);
				setupRegisterDialog(playerid);
			}
			return 1;
		}
		//======================================================================//
		case REGISTER_SEX:
		{
			if(response)
			{
				PI[playerid][pSex] = SEX_MALE;
				PI[playerid][pSkinID] = 20;

				ClearChat(playerid, 20);
				RegisterSex[playerid] = true;
				InfoMessage(playerid, "You successfully choose sex! Your sex: 'Male'");
				setupRegisterDialog(playerid);
			}
			if(!response)
			{
				PI[playerid][pSex] = SEX_FEMALE;
				PI[playerid][pSkinID] = 12;

				ClearChat(playerid, 20);
				RegisterSex[playerid] = true;
				InfoMessage(playerid, "You successfully choose sex! Your sex: 'Female'");
				setupRegisterDialog(playerid);
			}
			return 1;
		}
		//======================================================================//
		case REGISTER_FAILED:
		{
			setupRegisterDialog(playerid);
			return 1;
		} 
		//======================================================================//
	}
	
	#if defined register_OnDialogResponse
		return register_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnDialogResponse
	#undef OnDialogResponse
#else
	#define _ALS_OnDialogResponse
#endif

#define OnDialogResponse register_OnDialogResponse
#if defined register_OnDialogResponse
	forward register_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif
//==============================================================================//
function onPlayerRegister(playerid)
{
	PI[playerid][pID] = cache_insert_id();

	//=======================================//

	if(cache_num_rows() > 0)
	{
		cache_get_value_int(0, "pID", PI[playerid][pID]);
		cache_get_value(0, "pName", PI[playerid][pName], 24);
		cache_get_value(0, "pIP", PI[playerid][pIP], 65);
		cache_get_value(0, "pPassword", PI[playerid][pPassword], 65);
		cache_get_value(0, "pRegDate", PI[playerid][pRegDate], 24);
		cache_get_value(0, "pLastLogin", PI[playerid][pLastLogin], 24);
		
		cache_get_value_int(0, "pSkinID", PI[playerid][pSkinID]);
	}

	PI[playerid][pOnline] = true;
	mySQL_UpdatePlayerCustomVal(playerid, "pOnline", PI[playerid][pOnline]);

	ServerInfo[serverUsers]++;
	mySQL_UpdateServerCustomVal("serverUsers", ServerInfo[serverUsers]);

	//=======================================//

	FirstSpawn[playerid] = true;
	TogglePlayerSpectating(playerid, false);
	new str[84];
	format(str, sizeof(str), "[ > ] "WHITE"%s has just registred on server.", GetName(playerid));
	SendClientMessageToAll(COL_GREEN, str);

	#if USE_DISCORD == true
		new string[96];
		format(string, sizeof(string), ">>> Player %s(%d) has just registred on server.", GetName(playerid), playerid);
		DCC_SendChannelMessage(DiscordInfo[log_in_log_out], string);
	#endif

	//=======================================//
	return 1;
}
//==============================================================================//
