//==============================================================================//
/*
	* Module: discord_functions.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
CMD:ts3(playerid)
{
	ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_MSGBOX, ""SERVER"Solvine Deathmatch > "WHITE"TeamSpeak", "\
		"SERVER"> "WHITE"Explanation for Discord - SAMP communication\n\
		"SERVER"__________________________________________________________________________________\n\
		"SERVER"[ 1 ] "WHITE"Join our TeamSpeak server\n\
		"SERVER"[ 2 ] "WHITE"You can find IP adress on:\n\
		"SERVER"[ 2.1 ] "WHITE"FB Page - Solvine Deathmatch\n\
		"SERVER"[ 2.2 ] "WHITE"Forum - COMING:SOON\n\
		"SERVER"[ 3 ] "WHITE"In category 'SAMP' you can find all channels you can interact\n\
		"SERVER"[ 4 ] "WHITE"Read all channel topics to find out what you can do in what channel\n\
		"SERVER"[ 4 ] "WHITE"Enjoy playing on Solvine Deathmatch\n\
		"SERVER"__________________________________________________________________________________\n\
		", "OKAY", "");
	return 1;
}
//==============================================================================//
function mySQL_DiscordKillsTop3()
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		DCC_SendChannelMessage(DiscordInfo[commands], "> [R] PLAYER > KILLS > LAST ONLINE");
		new name[24], lastlogin[24], value;
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name(i, "pName", name, 24);
			cache_get_value_name(i, "pLastLogin", lastlogin, 24);
			cache_get_value_name_int(i, "pKills", value);

			new string[72];
			format(string, sizeof(string), "**[%d]** %s > **%d** > %s", i+1, name, value, lastlogin);
			DCC_SendChannelMessage(DiscordInfo[commands], string);
		}
	}
	return 1;
}
//=======================================//
function mySQL_DiscordDeathsTop3()
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		DCC_SendChannelMessage(DiscordInfo[commands], "> [R] PLAYER > DEATHS > LAST ONLINE");
		new name[24], lastlogin[24], value;
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name(i, "pName", name, 24);
			cache_get_value_name(i, "pLastLogin", lastlogin, 24);
			cache_get_value_name_int(i, "pDeaths", value);

			new string[72];
			format(string, sizeof(string), "**[%d]** %s > **%d** > %s", i+1, name, value, lastlogin);
			DCC_SendChannelMessage(DiscordInfo[commands], string);
		}
	}
	return 1;
}
//==============================================================================//
function mySQL_DiscordDuelWinsTop3()
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		DCC_SendChannelMessage(DiscordInfo[commands], "> [R] PLAYER > DUEL WINS > LAST ONLINE");
		new name[24], lastlogin[24], value;
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name(i, "pName", name, 24);
			cache_get_value_name(i, "pLastLogin", lastlogin, 24);
			cache_get_value_name_int(i, "pDuelWins", value);

			new string[72];
			format(string, sizeof(string), "**[%d]** %s > **%d** > %s", i+1, name, value, lastlogin);
			DCC_SendChannelMessage(DiscordInfo[commands], string);
		}
	}
	return 1;
}
//=======================================//
function mySQL_DiscordDuelDefeatsTop3()
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		DCC_SendChannelMessage(DiscordInfo[commands], "> [R] PLAYER > DUEL DEFEATS > LAST ONLINE");
		new name[24], lastlogin[24], value;
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name(i, "pName", name, 24);
			cache_get_value_name(i, "pLastLogin", lastlogin, 24);
			cache_get_value_name_int(i, "pDuelDeafets", value);

			new string[72];
			format(string, sizeof(string), "**[%d]** %s > **%d** > %s", i+1, name, value, lastlogin);
			DCC_SendChannelMessage(DiscordInfo[commands], string);
		}
	}
	return 1;
}
//==============================================================================//
function mySQL_DiscordVersusWinsTop3()
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		DCC_SendChannelMessage(DiscordInfo[commands], "> [R] PLAYER > VERSUS WINS > LAST ONLINE");
		new name[24], lastlogin[24], value;
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name(i, "pName", name, 24);
			cache_get_value_name(i, "pLastLogin", lastlogin, 24);
			cache_get_value_name_int(i, "pVersusWins", value);

			new string[72];
			format(string, sizeof(string), "**[%d]** %s > **%d** > %s", i+1, name, value, lastlogin);
			DCC_SendChannelMessage(DiscordInfo[commands], string);
		}
	}
	return 1;
}
//=======================================//
function mySQL_DiscordVersusDefeatsTop3()
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		DCC_SendChannelMessage(DiscordInfo[commands], "> [R] PLAYER > VERSUS DEFEATS > LAST ONLINE");
		new name[24], lastlogin[24], value;
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name(i, "pName", name, 24);
			cache_get_value_name(i, "pLastLogin", lastlogin, 24);
			cache_get_value_name_int(i, "pVersusDefeats", value);

			new string[72];
			format(string, sizeof(string), "**[%d]** %s > **%d** > %s", i+1, name, value, lastlogin);
			DCC_SendChannelMessage(DiscordInfo[commands], string);
		}
	}
	return 1;
}
//==============================================================================//
function mySQL_DiscordArenaKillsTop3()
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		DCC_SendChannelMessage(DiscordInfo[commands], "> [R] PLAYER > ARENA KILLS > LAST ONLINE");
		new name[24], lastlogin[24], value;
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name(i, "pName", name, 24);
			cache_get_value_name(i, "pLastLogin", lastlogin, 24);
			cache_get_value_name_int(i, "pArenaKills", value);

			new string[72];
			format(string, sizeof(string), "**[%d]** %s > **%d** > %s", i+1, name, value, lastlogin);
			DCC_SendChannelMessage(DiscordInfo[commands], string);
		}
	}
	return 1;
}
//=======================================//
function mySQL_DiscordArenaDeathsTop3()
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		DCC_SendChannelMessage(DiscordInfo[commands], "> [R] PLAYER > ARENA DEATHS > LAST ONLINE");
		new name[24], lastlogin[24], value;
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name(i, "pName", name, 24);
			cache_get_value_name(i, "pLastLogin", lastlogin, 24);
			cache_get_value_name_int(i, "pArenaDeaths", value);

			new string[72];
			format(string, sizeof(string), "**[%d]** %s > **%d** > %s", i+1, name, value, lastlogin);
			DCC_SendChannelMessage(DiscordInfo[commands], string);
		}
	}
	return 1;
}
//==============================================================================//
function mySQL_DiscordDayWinsTop3()
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		DCC_SendChannelMessage(DiscordInfo[commands], "> [R] PLAYER > DoTD WINS > LAST ONLINE");
		new name[24], lastlogin[24], value;
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name(i, "pName", name, 24);
			cache_get_value_name(i, "pLastLogin", lastlogin, 24);
			cache_get_value_name_int(i, "pDayWins", value);

			new string[72];
			format(string, sizeof(string), "**[%d]** %s > **%d** > %s", i+1, name, value, lastlogin);
			DCC_SendChannelMessage(DiscordInfo[commands], string);
		}
	}
	return 1;
}
//=======================================//
function mySQL_DiscordDayKillsTop3()
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		DCC_SendChannelMessage(DiscordInfo[commands], "> [R] PLAYER > DoTD KILLS > LAST ONLINE");
		new name[24], lastlogin[24], value;
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name(i, "pName", name, 24);
			cache_get_value_name(i, "pLastLogin", lastlogin, 24);
			cache_get_value_name_int(i, "pDayKills", value);

			new string[72];
			format(string, sizeof(string), "**[%d]** %s > **%d** > %s", i+1, name, value, lastlogin);
			DCC_SendChannelMessage(DiscordInfo[commands], string);
		}
	}
	return 1;
}
//==============================================================================//
function mySQL_DiscordMonthWinsTop3()
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		DCC_SendChannelMessage(DiscordInfo[commands], "> [R] PLAYER > DoTM WINS > LAST ONLINE");
		new name[24], lastlogin[24], value;
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name(i, "pName", name, 24);
			cache_get_value_name(i, "pLastLogin", lastlogin, 24);
			cache_get_value_name_int(i, "pMonthWins", value);

			new string[72];
			format(string, sizeof(string), "**[%d]** %s > **%d** > %s", i+1, name, value, lastlogin);
			DCC_SendChannelMessage(DiscordInfo[commands], string);
		}
	}
	return 1;
}
//=======================================//
function mySQL_DiscordMonthKillsTop3()
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		DCC_SendChannelMessage(DiscordInfo[commands], "> [R] PLAYER > DoTM KILLS > LAST ONLINE");
		new name[24], lastlogin[24], value;
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name(i, "pName", name, 24);
			cache_get_value_name(i, "pLastLogin", lastlogin, 24);
			cache_get_value_name_int(i, "pMonthKills", value);

			new string[72];
			format(string, sizeof(string), "**[%d]** %s > **%d** > %s", i+1, name, value, lastlogin);
			DCC_SendChannelMessage(DiscordInfo[commands], string);
		}
	}
	return 1;
}
//==============================================================================//
