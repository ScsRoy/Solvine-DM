//==============================================================================//
/*
	* Module: top10.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
CMD:top10(playerid)
{
	ShowPlayerDialog(playerid, TOP10_LIST, DIALOG_STYLE_LIST, ""SERVER"Solvine Deathmatch > "WHITE"Top 10 > List", "\
		"SERVER"> "WHITE"Kills\n\
		"SERVER"> "WHITE"Deaths\n\
		"SERVER"> "WHITE"Max KS\n\
		"SERVER"> "WHITE"Duel Wins\n\
		"SERVER"> "WHITE"Versus Wins\n\
		"SERVER"> "WHITE"Arena Kills\n\
		"SERVER"> "WHITE"DoTD Wins\n\
		"SERVER"> "WHITE"DoTD Kills (currently on)\n\
		"SERVER"> "WHITE"DoTM Wins\n\
		"SERVER"> "WHITE"DoTM Kills (currently on)\n\
		", "NEXT", "CANCEL");
	return 1;
}
//==============================================================================//
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		//======================================================================//
		case TOP10_LIST:
		{
			if(!response) return 1;
			if(response)
			{
				switch(listitem)
				{
					case 0://Ubistva
					{
						mysql_tquery(DB, "SELECT `pKills`, `pLastLogin`, `pName` FROM "USER_DB" ORDER BY `pKills` DESC LIMIT 10", "mySQL_KillTop10", "i", playerid);
					}
					case 1://Smrti
					{
						mysql_tquery(DB, "SELECT `pDeaths`, `pLastLogin`, `pName` FROM "USER_DB" ORDER BY `pDeaths` DESC LIMIT 10", "mySQL_DeathTop10", "i", playerid);
					}
					case 2://Streak
					{
						mysql_tquery(DB, "SELECT `pMaxKS`, `pLastLogin`, `pName` FROM "USER_DB" ORDER BY `pMaxKS` DESC LIMIT 10", "mySQL_StreakTop10", "i", playerid);
					}
					case 3://Duel Wins
					{
						mysql_tquery(DB, "SELECT `pDuelWins`, `pLastLogin`, `pName` FROM "USER_DB" ORDER BY `pDuelWins` DESC LIMIT 10", "mySQL_DuelTop10", "i", playerid);
					}
					case 4://Versus wins
					{
						mysql_tquery(DB, "SELECT `pVersusWins`, `pLastLogin`, `pName` FROM "USER_DB" ORDER BY `pVersusWins` DESC LIMIT 10", "mySQL_VersusTop10", "i", playerid);
					}
					case 5://Arena kills
					{
						mysql_tquery(DB, "SELECT `pArenaKills`, `pLastLogin`, `pName` FROM "USER_DB" ORDER BY `pArenaKills` DESC LIMIT 10", "mySQL_ArenaTop10", "i", playerid);
					}
					case 6://DoTD Wins
					{
						mysql_tquery(DB, "SELECT `pDayWins`, `pLastLogin`, `pName` FROM "USER_DB" ORDER BY `pDayWins` DESC LIMIT 10", "mySQL_DailyWinsTop10", "i", playerid);
					}
					case 7://DoTD kills
					{
						mysql_tquery(DB, "SELECT `pDayKills`, `pLastLogin`, `pName` FROM "USER_DB" ORDER BY `pDayKills` DESC LIMIT 10", "mySQL_DailyTop10", "i", playerid);
					}
					case 8://DoTM Wins
					{
						mysql_tquery(DB, "SELECT `pMonthWins`, `pLastLogin`, `pName` FROM "USER_DB" ORDER BY `pMonthWins` DESC LIMIT 10", "mySQL_MonthlyTop10", "i", playerid);
					}
					case 9://
					{
						mysql_tquery(DB, "SELECT `pMonthKills`, `pLastLogin`, `pName` FROM "USER_DB" ORDER BY `pMonthKills` DESC LIMIT 10", "mySQL_MonthlyTop10", "i", playerid);
					}
				}
			}
			return 1;
		}
		//======================================================================//
	}
	
	#if defined top10_OnDialogResponse
		return top10_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnDialogResponse
	#undef OnDialogResponse
#else
	#define _ALS_OnDialogResponse
#endif

#define OnDialogResponse top10_OnDialogResponse
#if defined top10_OnDialogResponse
	forward top10_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif
//==============================================================================//
function mySQL_KillTop10(playerid)
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		new name[24], lastlogin[24], kills, string[64], dialog[768];
		strcat(dialog, ""WHITE"Rank\t"WHITE"Name\t"WHITE"Kills\t"WHITE"Last Online\n");
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name(i, "pName", name, 24);
			cache_get_value_name(i, "pLastLogin", lastlogin, 24);
			cache_get_value_name_int(i, "pKills", kills);

			format(string, sizeof(string), ""SERVER"[%d]\t"WHITE"%s\t%d\t%s\n", i+1, name, kills, lastlogin);
			strcat(dialog, string);
		}

		ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_TABLIST_HEADERS, ""SERVER"Solvine Deathmatch > "WHITE"Top 10 > Kills", dialog, "OKAY", "");
	}
	return 1;
}
//=======================================//
function mySQL_DeathTop10(playerid)
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		new name[24], lastlogin[24], deaths, string[64], dialog[768];
		strcat(dialog, ""WHITE"Rank\t"WHITE"Name\t"WHITE"Deaths\t"WHITE"Last Online\n");
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name(i, "pName", name, 24);
			cache_get_value_name(i, "pLastLogin", lastlogin, 24);
			cache_get_value_name_int(i, "pDeaths", deaths);

			format(string, sizeof(string), ""SERVER"[%d]\t"WHITE"%s\t%d\t%s\n", i+1, name, deaths, lastlogin);
			strcat(dialog, string);
		}

		ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_TABLIST_HEADERS, ""SERVER"Solvine Deathmatch > "WHITE"Top 10 > Deaths", dialog, "OKAY", "");
	}
	return 1;
}
//=======================================//
function mySQL_StreakTop10(playerid)
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		new name[24], lastlogin[24], streak, string[64], dialog[768];
		strcat(dialog, ""WHITE"Rank\t"WHITE"Name\t"WHITE"Streak\t"WHITE"Last Online\n");
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name(i, "pName", name, 24);
			cache_get_value_name(i, "pLastLogin", lastlogin, 24);
			cache_get_value_name_int(i, "pMaxKS", streak);

			format(string, sizeof(string), ""SERVER"[%d]\t"WHITE"%s\t%d\t%s\n", i+1, name, streak, lastlogin);
			strcat(dialog, string);
		}

		ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_TABLIST_HEADERS, ""SERVER"Solvine Deathmatch > "WHITE"Top 10  > Max KS", dialog, "OKAY", "");
	}
	return 1;
}
//==============================================================================//
function mySQL_DuelTop10(playerid)
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		new name[24], lastlogin[24], duel, string[64], dialog[768];
		strcat(dialog, ""WHITE"Rank\t"WHITE"Name\t"WHITE"Duel Wins\t"WHITE"Last Online\n");
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name(i, "pName", name, 24);
			cache_get_value_name(i, "pLastLogin", lastlogin, 24);
			cache_get_value_name_int(i, "pDuelWins", duel);

			format(string, sizeof(string), ""SERVER"[%d]\t"WHITE"%s\t%d\t%s\n", i+1, name, duel, lastlogin);
			strcat(dialog, string);
		}

		ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_TABLIST_HEADERS, ""SERVER"Solvine Deathmatch > "WHITE"Top 10  > Duel Wins", dialog, "OKAY", "");
	}
	return 1;
}
//=======================================//
function mySQL_VersusTop10(playerid)
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		new name[24], lastlogin[24], versus, string[64], dialog[768];
		strcat(dialog, ""WHITE"Rank\t"WHITE"Name\t"WHITE"Versus Wins\t"WHITE"Last Online\n");
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name(i, "pName", name, 24);
			cache_get_value_name(i, "pLastLogin", lastlogin, 24);
			cache_get_value_name_int(i, "pVersusWins", versus);

			format(string, sizeof(string), ""SERVER"[%d]\t"WHITE"%s\t%d\t%s\n", i+1, name, versus, lastlogin);
			strcat(dialog, string);
		}

		ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_TABLIST_HEADERS, ""SERVER"Solvine Deathmatch > "WHITE"Top 10  > Versus Wins", dialog, "OKAY", "");
	}
	return 1;
}
//=======================================//
function mySQL_ArenaTop10(playerid)
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		new name[24], lastlogin[24], arena, string[64], dialog[768];
		strcat(dialog, ""WHITE"Rank\t"WHITE"Name\t"WHITE"Arena Kills\t"WHITE"Last Online\n");
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name(i, "pName", name, 24);
			cache_get_value_name(i, "pLastLogin", lastlogin, 24);
			cache_get_value_name_int(i, "pArenaKills", arena);

			format(string, sizeof(string), ""SERVER"[%d]\t"WHITE"%s\t%d\t%s\n", i+1, name, arena, lastlogin);
			strcat(dialog, string);
		}

		ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_TABLIST_HEADERS, ""SERVER"Solvine Deathmatch > "WHITE"Top 10  > Arena Kills", dialog, "OKAY", "");
	}
	return 1;
}
//==============================================================================//
function mySQL_DailyWinsTop10(playerid)
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		new name[24], lastlogin[24], wins, string[64], dialog[768];
		strcat(dialog, ""WHITE"Rank\t"WHITE"Name\t"WHITE"DoTD Wins\t"WHITE"Last Online\n");
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name(i, "pName", name, 24);
			cache_get_value_name(i, "pLastLogin", lastlogin, 24);
			cache_get_value_name_int(i, "pDayWins", wins);

			format(string, sizeof(string), ""SERVER"[%d]\t"WHITE"%s\t%d\t%s\n", i+1, name, wins, lastlogin);
			strcat(dialog, string);
		}

		ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_TABLIST_HEADERS, ""SERVER"Solvine Deathmatch > "WHITE"Top 10  > DoTD Wins", dialog, "OKAY", "");
	}
	return 1;
}
//=======================================//
function mySQL_DailyTop10(playerid)
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		new name[24], lastlogin[24], kills, string[64], dialog[768];
		strcat(dialog, ""WHITE"Rank\t"WHITE"Name\t"WHITE"DoTD Kills\t"WHITE"Last Online\n");
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name(i, "pName", name, 24);
			cache_get_value_name(i, "pLastLogin", lastlogin, 24);
			cache_get_value_name_int(i, "pDayKills", kills);

			format(string, sizeof(string), ""SERVER"[%d]\t"WHITE"%s\t%d\t%s\n", i+1, name, kills, lastlogin);
			strcat(dialog, string);
		}

		ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_TABLIST_HEADERS, ""SERVER"Solvine Deathmatch > "WHITE"Top 10  > DoTD Kills", dialog, "OKAY", "");
	}
	return 1;
}
//==============================================================================//
function mySQL_MonthlyWinsTop10(playerid)
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		new name[24], lastlogin[24], wins, string[64], dialog[768];
		strcat(dialog, ""WHITE"Rank\t"WHITE"Name\t"WHITE"DoTM Wins\t"WHITE"Last Online\n");
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name(i, "pName", name, 24);
			cache_get_value_name(i, "pLastLogin", lastlogin, 24);
			cache_get_value_name_int(i, "pMonthWins", wins);

			format(string, sizeof(string), ""SERVER"[%d]\t"WHITE"%s\t%d\t%s\n", i+1, name, wins, lastlogin);
			strcat(dialog, string);
		}

		ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_TABLIST_HEADERS, ""SERVER"Solvine Deathmatch > "WHITE"Top 10  > DoTM Wins", dialog, "OKAY", "");
	}
	return 1;
}
//=======================================//
function mySQL_MonthlyTop10(playerid)
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		new name[24], lastlogin[24], kills, string[64], dialog[768];
		strcat(dialog, ""WHITE"Rank\t"WHITE"Name\t"WHITE"DoTM Kills\t"WHITE"Last Online\n");
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name(i, "pName", name, 24);
			cache_get_value_name(i, "pLastLogin", lastlogin, 24);
			cache_get_value_name_int(i, "pMonthKills", kills);

			format(string, sizeof(string), ""SERVER"[%d]\t"WHITE"%s\t%d\t%s\n", i+1, name, kills, lastlogin);
			strcat(dialog, string);
		}

		ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_TABLIST_HEADERS, ""SERVER"Solvine Deathmatch > "WHITE"Top 10  > DoTM Kills", dialog, "OKAY", "");
	}
	return 1;
}
//==============================================================================//
checkLobbyTop5()
{
	mysql_tquery(DB, "SELECT `pName`, `pSkinID`, `pKills`, `pLastLogin` FROM "USER_DB" ORDER BY `pKills` DESC LIMIT 5 ", "mySQL_Top5Killers", "");
	return 1;
}
//=======================================//
function mySQL_Top5Killers()
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		new name[24], skin, kills, lastlogin[24], string[96];
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name(i, "pName", name, 24);
			cache_get_value_name_int(i, "pSkinID", skin);
			cache_get_value_name_int(i, "pKills", kills);
			cache_get_value_name(i, "pLastLogin", lastlogin, 24);

			format(string, sizeof(string), "#%d // "WHITE"%s"SERVER" // %d\n"WHITE"%s", i+1, name, kills, lastlogin);
			UpdateDynamic3DTextLabelText(Server3D[i], COL_SERVER, string);

			if(IsValidDynamicActor(ServerActor[i])) 
				DestroyDynamicActor(ServerActor[i]);
			ServerActor[i] = CreateDynamicActor(skin, LobbyTop5[i][0], LobbyTop5[i][1], LobbyTop5[i][2], LobbyTop5[i][3]);
		}
	} 
	return 1;
}
//==============================================================================//
checkBestDuelPlayer()
{
	mysql_tquery(DB, "SELECT `pName`, `pSkinID`, `pDuelWins`, `pLastLogin` FROM "USER_DB" ORDER BY `pDuelWins` DESC LIMIT 1", "mySQL_BestDuelPlayer", "");
	return 1;
}
//=======================================//
function mySQL_BestDuelPlayer()
{
	if(cache_num_rows() > 0)
	{
		new name[24], skin, wins, lastlogin[24], string[96];

		cache_get_value_name(0, "pName", name, 24);
		cache_get_value_name_int(0, "pSkinID", skin);
		cache_get_value_name_int(0, "pDuelWins", wins);
		cache_get_value_name(0, "pLastLogin", lastlogin, 24);

		format(string, sizeof(string), "#1 Duel Player // "WHITE"%s"SERVER" // %d\n"WHITE"%s", name, wins, lastlogin);
		UpdateDynamic3DTextLabelText(Server3D[5], COL_SERVER, string);

		if(IsValidDynamicActor(ServerActor[5]))
			DestroyDynamicActor(ServerActor[5]);
		ServerActor[5] = CreateDynamicActor(skin, BestDuel[0], BestDuel[1], BestDuel[2], BestDuel[3]);
	}
	return 1;
}
//==============================================================================//
checkBestVersusPlayer()
{
	mysql_tquery(DB, "SELECT `pName`, `pSkinID`, `pVersusWins`, `pLastLogin` FROM "USER_DB" ORDER BY `pVersusWins` DESC LIMIT 1", "mySQL_BestVersusPlayer", "");
	return 1;
}
//=======================================//
function mySQL_BestVersusPlayer()
{
	if(cache_num_rows() > 0)
	{
		new name[24], skin, wins, lastlogin[24], string[96];

		cache_get_value_name(0, "pName", name, 24);
		cache_get_value_name_int(0, "pSkinID", skin);
		cache_get_value_name_int(0, "pVersusWins", wins);
		cache_get_value_name(0, "pLastLogin", lastlogin, 24);

		format(string, sizeof(string), "#1 Versus Player // "WHITE"%s"SERVER" // %d\n"WHITE"%s", name, wins, lastlogin);
		UpdateDynamic3DTextLabelText(Server3D[6], COL_SERVER, string);

		if(IsValidDynamicActor(ServerActor[6]))
			DestroyDynamicActor(ServerActor[6]);
		ServerActor[6] = CreateDynamicActor(skin, BestVersus[0], BestVersus[1], BestVersus[2], BestVersus[3]);
	}
	return 1;
}
//==============================================================================//
