//==============================================================================//
/*
	* Module: settings.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
CMD:settings(playerid)
{
	ShowPlayerDialog(playerid, SETTINGS_LIST, DIALOG_STYLE_TABLIST, ""SERVER"Solvine Deathmatch > "WHITE"Settings", "\
		"SERVER"> "WHITE"Change Nickname\t"SERVER"[50000$]\n\
		"SERVER"> "WHITE"Change PW\t"SERVER"[0$]\n\
		", "NEXT", "CANCEL");

	return 1;
}
//==============================================================================//
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		//======================================================================//
		case SETTINGS_LIST:
		{
			if(!response) return 1;
			if(response)
			{
				switch(listitem)
				{
					case 0://Change Nickname
					{
						if(PI[playerid][pMoney] < 50000) return ErrorMessage(playerid, "You do not have enough money. (50.000$)");

						ShowPlayerDialog(playerid, SETTINGS_NICK, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Settings [Nickname]", "\
							"SERVER"> "WHITE"Please, enter your new nickname.\n\
							"SERVER"> "WHITE"Afterwards you will use that nickname to login on our server.\n\
							", "CHANGE", "CANCEL");
					}
					case 1://Change PW
					{
						ShowPlayerDialog(playerid, SETTINGS_PW, DIALOG_STYLE_PASSWORD, ""SERVER"Solvine Deathmatch > "WHITE"Settings [PW]", "\
							"SERVER"> "WHITE"Please, enter your new password.\n\
							"SERVER"> "WHITE"Afterwards you will use your new password to login.\n\
							"SERVER"> "WHITE"Length: "GREEN"6-24\n\
							", "CHANGE", "CANCEL");
					}
				}
			}
			return 1;
		}
		//======================================================================//
		case SETTINGS_NICK:
		{
			if(!response) return 1;
			if(response)
			{
				new name[24];
				if(sscanf(inputtext, "s[24]", name)) return 
					ShowPlayerDialog(playerid, SETTINGS_NICK, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Settings [Nickname]", "\
						"SERVER"> "WHITE"Please, enter your new nickname.\n\
						"SERVER"> "WHITE"Afterwards you will use that nickname to login on our server.\n\
						", "CHANGE", "CANCEL");

				new query[84], Cache:result;
				mysql_format(DB, query, sizeof(query), "SELECT `pID` FROM "USER_DB" WHERE `pName`='%s'", name);
				result = mysql_query(DB, query);
				if(cache_num_rows() > 0)
				{
					cache_delete(result);
					ErrorMessage(playerid, "There is already player with that nickname in database.");
					return 1;
				}
				cache_delete(result);

				AC_GiveMoney(playerid, -50000);
				mySQL_RenamePlayer(playerid, name);

				ClearChat(playerid, 20);
				InfoMessage(playerid, "You have successfully changed your nickname.");
				InfoMessage(playerid, "Your new nickname: %s", name);
			}
			return 1;
		}
		//======================================================================//
		case SETTINGS_PW:
		{
			if(!response) return 1;
			if(response)
			{
				new password[24];
				if(sscanf(inputtext, "s[24]", password)) return 
					ShowPlayerDialog(playerid, SETTINGS_PW, DIALOG_STYLE_PASSWORD, ""SERVER"Solvine Deathmatch > "WHITE"Settings [PW]", "\
						"SERVER"> "WHITE"Please, enter your new password.\n\
						"SERVER"> "WHITE"Afterwards you will use your new password to login.\n\
						"SERVER"> "WHITE"Length: "GREEN"6-24\n\
						", "CHANGE", "CANCEL");
				if(strlen(password) < 6 || strlen(password) > 24) return 
					ShowPlayerDialog(playerid, SETTINGS_PW, DIALOG_STYLE_PASSWORD, ""SERVER"Solvine Deathmatch > "WHITE"Settings [PW]", "\
						"SERVER"> "WHITE"Please, enter your new password.\n\
						"SERVER"> "WHITE"Afterwards you will use your new password to login.\n\
						"SERVER"> "WHITE"Length: "GREEN"6-24\n\
						", "CHANGE", "CANCEL");

				static query[160];
				SHA256_PassHash(password, "", PI[playerid][pPassword], 65);
				mysql_format(DB, query, sizeof(query), "UPDATE "USER_DB" SET `pPassword`='%s' WHERE `pID`=%d", PI[playerid][pPassword], PI[playerid][pID]);
				mysql_tquery(DB, query);

				ClearChat(playerid, 20);
				InfoMessage(playerid, "You have successfully changed your password.");
				InfoMessage(playerid, "Your new password: %s", password);
				InfoMessage(playerid, "Use [F8] to save screenshoot of your new password.");
			}
			return 1;
		}
		//======================================================================//
	}
	
	#if defined settings_OnDialogResponse
		return settings_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnDialogResponse
	#undef OnDialogResponse
#else
	#define _ALS_OnDialogResponse
#endif

#define OnDialogResponse settings_OnDialogResponse
#if defined settings_OnDialogResponse
	forward settings_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif
//==============================================================================//
