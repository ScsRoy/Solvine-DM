//==============================================================================//
/*
	* Module: deathmatcher.pwn
	* Author: Sule
	* Date: 18.04.2020
*/
//==============================================================================//
public OnPlayerDeath(playerid, killerid, reason)
{
	static query[96];
	PI[playerid][pDayDeaths]++;
	PI[playerid][pMonthDeaths]++;
	mysql_format(DB, query, sizeof(query), "UPDATE "USER_DB" SET `pDayDeaths`=%d, `pMonthDeaths`=%d WHERE `pID`=%d", PI[playerid][pDayDeaths], PI[playerid][pMonthDeaths], PI[playerid][pID]);
	mysql_tquery(DB, query);

	if(killerid != INVALID_PLAYER_ID)
	{
		PI[killerid][pDayKills]++;
		PI[killerid][pMonthKills]++;
		mysql_format(DB, query, sizeof(query), "UPDATE "USER_DB" SET `pDayKills`=%d, `pMonthKills`=%d WHERE `pID`=%d", PI[killerid][pDayKills], PI[killerid][pMonthKills], PI[killerid][pID]);
		mysql_tquery(DB, query);

		// ---------------- //

		if(PI[killerid][pDayKills] > ServerInfo[dayKills])
		{
			ServerInfo[dayID] = PI[killerid][pID];
			ServerInfo[dayKills] = PI[killerid][pDayKills];
			mysql_format(DB, query, sizeof(query), "UPDATE "SERVER_DB" SET `dayID`=%d, `dayKills`=%d", ServerInfo[dayID], ServerInfo[dayKills]);
			mysql_tquery(DB, query);

			updateLobbyDeathMatcher(TYPE_DAY);
		}

		// ---------------- //

		if(PI[killerid][pMonthKills] > ServerInfo[monthKills])
		{
			ServerInfo[monthID] = PI[killerid][pID];
			ServerInfo[monthKills] = PI[killerid][pMonthKills];
			mysql_format(DB, query, sizeof(query), "UPDATE "SERVER_DB" SET `monthID`=%d, `monthKills`=%d", ServerInfo[monthID], ServerInfo[monthKills]);
			mysql_tquery(DB, query);

			updateLobbyDeathMatcher(TYPE_MONTH);
		}

		// ---------------- //
	}
	#if defined dm_OnPlayerDeath
		return dm_OnPlayerDeath(playerid, killerid, reason);
	#endif
}
#if defined _ALS_OnPlayerDeath
	#undef OnPlayerDeath
#else
	#define _ALS_OnPlayerDeath
#endif

#define OnPlayerDeath dm_OnPlayerDeath
#if defined dm_OnPlayerDeath
	forward dm_OnPlayerDeath(playerid, killerid, reason);
#endif
//==============================================================================//
updateLobbyDeathMatcher(type)
{
	switch(type)
	{
		case TYPE_DAY:
		{
			static query[96], Cache:result, id, name[24], skin, lastlogin[24], string[84];
			mysql_format(DB, query, sizeof(query), "SELECT `pID`, `pName`, `pSkinID`, `pLastLogin` FROM "USER_DB" WHERE `pID`=%d", ServerInfo[dayID]);
			result = mysql_query(DB, query);
			if(cache_num_rows() > 0) 
			{
				cache_get_value_name_int(0, "pID", id);
				cache_get_value_name(0, "pName", name, 24);
				cache_get_value_name_int(0, "pSkinID", skin);
				cache_get_value_name(0, "pLastLogin", lastlogin, 24);

				format(string, sizeof(string), "#%04d // "WHITE"%s"SERVER" // %d\n"WHITE"%s", id, name, ServerInfo[dayKills], lastlogin);
				UpdateDynamic3DTextLabelText(Server3D[7], COL_SERVER, string);

				if(IsValidDynamicActor(ServerActor[7]))
					DestroyDynamicActor(ServerActor[7]);
				ServerActor[7] = CreateDynamicActor(skin, BestDaily[0], BestDaily[1], BestDaily[2], BestDaily[3]);
			}
			else sendMessageToOwner("DMoD // Could not find DeathMatcher of Day. Contact developer.");
			cache_delete(result);
		}
		case TYPE_MONTH:
		{
			static query[96], Cache:result, id, name[24], skin, lastlogin[24], string[84];
			mysql_format(DB, query, sizeof(query), "SELECT `pID`, `pName`, `pSkinID`, `pLastLogin` FROM "USER_DB" WHERE `pID`=%d", ServerInfo[monthID]);
			result = mysql_query(DB, query);
			if(cache_num_rows() > 0) 
			{
				cache_get_value_name_int(0, "pID", id);
				cache_get_value_name(0, "pName", name, 24);
				cache_get_value_name_int(0, "pSkinID", skin);
				cache_get_value_name(0, "pLastLogin", lastlogin, 24);

				format(string, sizeof(string), "#%04d // "WHITE"%s"SERVER" // %d\n"WHITE"%s", id, name, ServerInfo[monthKills], lastlogin);
				UpdateDynamic3DTextLabelText(Server3D[8], COL_SERVER, string);

				if(IsValidDynamicActor(ServerActor[8]))
					DestroyDynamicActor(ServerActor[8]);
				ServerActor[8] = CreateDynamicActor(skin, BestMonthly[0], BestMonthly[1], BestMonthly[2], BestMonthly[3]);
			}
			else sendMessageToOwner("DMoM // Could not find DeathMatcher of Month. Contact developer.");
			cache_delete(result);
		}
	}
	return 1;
}
//==============================================================================//
checkDeathMatcherOfDay()
{
	static query[96];
	mysql_format(DB, query, sizeof(query), "SELECT `pID`, `pName`, `pDayKills`, `pDayDeaths`, `pDayWins` FROM "USER_DB" WHERE `pID`=%d", ServerInfo[dayID]);
	mysql_tquery(DB, query, "mySQL_checkDeathMatcherOfDay");

	ServerInfo[dayID] = 1;
	ServerInfo[dayKills] = 0;
	mysql_tquery(DB, "UPDATE "SERVER_DB" SET `dayID`=1, `dayKills`=0");
	updateLobbyDeathMatcher(TYPE_DAY);
	return 1;
}
//=======================================//
checkDeathMatcherOfMonth()
{
	static query[128];
	mysql_format(DB, query, sizeof(query), "SELECT `pID`, `pName`, `pMonthKills`, `pMonthDeaths`, `pMonthWins` FROM "USER_DB" WHERE `pID`=%d", ServerInfo[monthID]);
	mysql_tquery(DB, query, "mySQL_checkDeathMatcherOfMonth");

	ServerInfo[monthID] = 1;
	ServerInfo[monthKills] = 0;
	mysql_tquery(DB, "UPDATE "SERVER_DB" SET `monthID`=1, `monthKills`=0");
	updateLobbyDeathMatcher(TYPE_MONTH);
	return 1;
}
//==============================================================================//
function mySQL_checkDeathMatcherOfDay()
{
	if(cache_num_rows() == 0) return sendMessageToOwner("DMoD // Could not find DeathMatcher of Day. Contact developer.");
	new id, name[24], kills, deaths, wins, query[64];
	cache_get_value_name_int(0, "pID", id);
	cache_get_value_name(0, "pName", name, 24);
	cache_get_value_name_int(0, "pDayKills", kills);
	cache_get_value_name_int(0, "pDayDeaths", deaths);
	cache_get_value_name_int(0, "pDayWins", wins);

	wins++;
	mysql_format(DB, query, sizeof(query), "UPDATE "USER_DB" SET `pDayWins`=%d WHERE `pID`=%d", wins, id);
	mysql_tquery(DB, query);

	new winner = GetPlayerIdFromName(name);
	if(winner != INVALID_PLAYER_ID)
	{
		PI[winner][pDayWins]++;
		InfoMessage(winner, "Congratulations on your new DeathMatcher of Day win.");
	}

	foreach(new i:Player)
	{
		InfoMessage(i, "We have new DeathMatcher of Day winner. (%s)", name);
		InfoMessage(i, "Thats his %d. DeathMatcher of Day win. (%dK / %dD / %.2fr)", wins, kills, deaths, floatdiv(kills, deaths));

		PI[i][pDayKills] = 0;
		PI[i][pDayDeaths] = 0;
	}
	#if USE_DISCORD == true
		new string[128];
		format(string, sizeof(string), ">>> %s is new DeathMeatcher of Day winner. That is his %d. win in this category.", name, wins);
		DCC_SendChannelMessage(DiscordInfo[event_logs], string);
	#endif

	mysql_tquery(DB, "UPDATE "USER_DB" SET `pDayKills`=0, `pDayDeaths`=0");
	return 1;
}
//=======================================//
function mySQL_checkDeathMatcherOfMonth()
{
	if(cache_num_rows() == 0) return sendMessageToOwner("DMoM // Could not find DeathMatcher of Month. Contact developer.");
	new id, name[24], kills, deaths, wins, query[96];
	cache_get_value_name_int(0, "pID", id);
	cache_get_value_name(0, "pName", name, 24);
	cache_get_value_name_int(0, "pMonthKills", kills);
	cache_get_value_name_int(0, "pMonthDeaths", deaths);
	cache_get_value_name_int(0, "pMonthWins", wins);

	wins++;
	mysql_format(DB, query, sizeof(query), "UPDATE "USER_DB" SET `pMonthWins`=%d WHERE `pID`=%d", wins, id);
	mysql_tquery(DB, query);

	new winner = GetPlayerIdFromName(name);
	if(winner != INVALID_PLAYER_ID)
	{
		PI[winner][pMonthWins]++;
		InfoMessage(winner, "Congratulations on your new DeathMatcher of Month win.");
	}

	foreach(new i:Player)
	{
		InfoMessage(i, "We have new DeathMatcher of Month winner. (%s)", name);
		InfoMessage(i, "Thats his %d. DeathMatcher of Month win. (%dK / %dD / %.2fr)", wins, kills, deaths, floatdiv(kills, deaths));

		PI[i][pMonthKills] = 0;
		PI[i][pMonthDeaths] = 0;
	}
	#if USE_DISCORD == true
		new string[128];
		format(string, sizeof(string), ">>> %s is new DeathMeatcher of Day winner. That is his %d. win in this category.", name, wins);
		DCC_SendChannelMessage(DiscordInfo[event_logs], string);
	#endif

	mysql_tquery(DB, "UPDATE "USER_DB" SET `pMonthKills`=0, `pMonthDeaths`=0");
	return 1;
}
//==============================================================================//
CMD:testday()
{
	checkDeathMatcherOfDay();

	return 1;
}
//==============================================================================//
CMD:testmonth()
{
	checkDeathMatcherOfMonth();

	return 1;
}
//==============================================================================//