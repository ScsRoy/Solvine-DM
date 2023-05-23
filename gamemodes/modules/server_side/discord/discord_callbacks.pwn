//==============================================================================//
/*
	* Module: discord_callbacks.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
public DCC_OnMessageCreate(DCC_Message:message)
{
	new DCC_Channel:channel, channel_name[100 + 1];
	DCC_GetMessageChannel(DCC_Message:message, channel);
	if(!DCC_GetChannelName(channel, channel_name)) return 0; // invalid channel

	new DCC_User:author, user_name[32 + 1];
	DCC_GetMessageAuthor(message, author);
	if(!DCC_GetUserName(author, user_name)) return 0; // invalid user
	DCC_GetGuildMemberNickname(DiscordInfo[server_id], author, user_name, sizeof(user_name));
	if(strcmp(user_name, "") == 0)
		DCC_GetUserName(author, user_name);

	new text[256];
	DCC_GetMessageContent(message, text, sizeof(text));

	//==========================================================================//
	if(channel == DiscordInfo[commands])
	{
		if(author == DiscordInfo[bot_id]) return 0;//M:DM Bot

		//=======================================//
		if(strcmp(text, "!top3 kills") == 0)
		{
			mysql_tquery(DB, "SELECT `pKills`, `pLastLogin`, `pName` FROM "USER_DB" ORDER BY `pKills` DESC LIMIT 3", "mySQL_DiscordKillsTop3", "");
		}
		//=======================================//
		else if(strcmp(text, "!top3 deaths") == 0)
		{
			mysql_tquery(DB, "SELECT `pDeaths`, `pLastLogin`, `pName` FROM "USER_DB" ORDER BY `pDeaths` DESC LIMIT 3", "mySQL_DiscordDeathsTop3", "");
		}
		//=======================================//
		else if(strcmp(text, "!top3 duelwins") == 0)
		{
			mysql_tquery(DB, "SELECT `pDuelWins`, `pLastLogin`, `pName` FROM "USER_DB" ORDER BY `pDuelWins` DESC LIMIT 3", "mySQL_DiscordDuelWinsTop3", "");
		}
		//=======================================//
		else if(strcmp(text, "!top3 dueldefeats") == 0)
		{
			mysql_tquery(DB, "SELECT `pDuelDefeats`, `pLastLogin`, `pName` FROM "USER_DB" ORDER BY `pDuelDefeats` DESC LIMIT 3", "mySQL_DiscordDuelDefeatsTop3", "");
		}
		//=======================================//
		else if(strcmp(text, "!top3 versuswins") == 0)
		{
			mysql_tquery(DB, "SELECT `pVersusWins`, `pLastLogin`, `pName` FROM "USER_DB" ORDER BY `pVersusWins` DESC LIMIT 3", "mySQL_DiscordVersusWinsTop3", "");
		}
		//=======================================//
		else if(strcmp(text, "!top3 versusdefeats") == 0)
		{
			mysql_tquery(DB, "SELECT `pVersusDefeats`, `pLastLogin`, `pName` FROM "USER_DB" ORDER BY `pVersusDefeats` DESC LIMIT 3", "mySQL_DiscordVersusDefeatsTop3", "");
		}
		//=======================================//
		else if(strcmp(text, "!top3 arenakills") == 0)
		{
			mysql_tquery(DB, "SELECT `pArenaKills`, `pLastLogin`, `pName` FROM "USER_DB" ORDER BY `pArenaKills` DESC LIMIT 3", "mySQL_DiscordArenaKillsTop3", "");
		}
		//=======================================//
		else if(strcmp(text, "!top3 arenadeaths") == 0)
		{
			mysql_tquery(DB, "SELECT `pArenaDeaths`, `pLastLogin`, `pName` FROM "USER_DB" ORDER BY `pArenaDeaths` DESC LIMIT 3", "mySQL_DiscordArenaDeathsTop3", "");
		}
		//=======================================//
		else if(strcmp(text, "!top3 daywins") == 0)
		{
			mysql_tquery(DB, "SELECT `pDayWins`, `pLastLogin`, `pName` FROM "USER_DB" ORDER BY `pDayWins` DESC LIMIT 3", "mySQL_DiscordDayWinsTop3", "");
		}
		//=======================================//
		else if(strcmp(text, "!top3 daykills") == 0)
		{
			mysql_tquery(DB, "SELECT `pDayKills`, `pLastLogin`, `pName` FROM "USER_DB" ORDER BY `pDayKills` DESC LIMIT 3", "mySQL_DiscordDayKillsTop3", "");
		}
		//=======================================//
		else if(strcmp(text, "!top3 monthwins") == 0)
		{
			mysql_tquery(DB, "SELECT `pMonthWins`, `pLastLogin`, `pName` FROM "USER_DB" ORDER BY `pMonthWins` DESC LIMIT 3", "mySQL_DiscordMonthWinsTop3", "");
		}
		//=======================================//
		else if(strcmp(text, "!top3 monthkills") == 0)
		{
			mysql_tquery(DB, "SELECT `pMonthKills`, `pLastLogin`, `pName` FROM "USER_DB" ORDER BY `pMonthKills` DESC LIMIT ", "mySQL_DiscordMonthKillsTop3", "");
		}
		//======================================================================//
		else if(strcmp(text, "!online") == 0)
		{
			if(ServerInfo[onlinePlayers] == 0)
			{
				DCC_SendChannelMessage(DiscordInfo[commands], ">>> Currently there is no players online.");
			}
			else
			{
				new string[48];
				foreach(new i:Player)
				{
					format(string, sizeof(string), "**%s (%d)**", GetName(i), i);
					DCC_SendChannelMessage(DiscordInfo[commands], string);
				}
			}
		}
		//=======================================//
		else if(strcmp(text, "!record") == 0)
		{
			new string[72];
			format(string, sizeof(string), ">>> Server record: **%d**", ServerInfo[serverRecord]);
			DCC_SendChannelMessage(DiscordInfo[commands], string);
		}
		//=======================================//
		else if(strcmp(text, "!uptime") == 0)
		{
			new days, hours, minutes, seconds, string[96];
			ConvertTime(gettime() - GMLoading, days, hours, minutes, seconds);

			if(days) format(string, sizeof(string), ">>> Server uptime since last restart **'%02d:%02d:%02d:%02d'**",  days, hours, minutes, seconds);
			else if(hours) format(string, sizeof(string), ">>> Server uptime since last restart **'%02d:%02d:%02d'**", hours, minutes, seconds);
			else if(minutes) format(string, sizeof(string), ">>> Server uptime since last restart **'%02d:%02d'**", minutes, seconds);
			else format(string, sizeof(string), ">>> Server uptime since last restart **'%02d'**", seconds);

			DCC_SendChannelMessage(DiscordInfo[commands], string);
		}
		return 1;
	}
	//==========================================================================//

	#if defined discord_DCC_OnMessageCreate
		return discord_DCC_OnMessageCreate(DCC_Message:message);
	#else
		return 1;
	#endif
}
#if defined _ALS_DCC_OnMessageCreate
	#undef DCC_OnMessageCreate
#else
	#define _ALS_DCC_OnMessageCreate
#endif

#define DCC_OnMessageCreate discord_DCC_OnMessageCreate
#if defined discord_DCC_OnMessageCreate
	forward discord_DCC_OnMessageCreate(DCC_Message:message);
#endif
//==============================================================================//