//==============================================================================//
/*
	* Module: #player_saving.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
public OnPlayerConnect(playerid)
{
	// ---------------- //

	ClearChat(playerid, 20);
	//InfoMessage(playerid, "Checking your whitelist status...");
	static query[96], Cache:result;
	/*mysql_format(DB, query, sizeof(query), "SELECT * FROM "WL_DB" WHERE `wlName`='%s' OR `wlIP`='%s' LIMIT 1", GetName(playerid), GetPlayerIP(playerid));
	result = mysql_query(DB, query);

	if(cache_num_rows() > 0)
	{
		new id, name[24], ip[16], email[48], discord[32], code[5], status, admin[24];
		cache_get_value_int(0, "wlID", id);
		cache_get_value(0, "wlName", name, 24); 
		cache_get_value(0, "wlIP", ip, 16); 
		cache_get_value(0, "wlEmail", email, 48); 
		cache_get_value(0, "wlDiscord", discord, 32); 
		cache_get_value(0, "wlDiscriminator", code, 5); 
		cache_get_value_int(0, "wlStatus", status);
		cache_get_value(0, "wlAdmin", admin, 24); 

		switch(status)
		{
			case WL_PENDING:
			{
				new dialog[512];
				format(dialog, sizeof(dialog), "\
					"SERVER"> "WHITE"Your whitelist request status: "SERVER"PENDING\n\
					"SERVER"__________________________________________________\n\n\
					"SERVER"> "WHITE"WL ID: %04d\n\
					"SERVER"> "WHITE"Name: %s\n\
					"SERVER"> "WHITE"IP: %s\n\
					"SERVER"> "WHITE"Email: %s\n\
					"SERVER"> "WHITE"Discord: %s#%s\n\
					"SERVER"__________________________________________________\n\n\
					", id, name, ip, email, discord, code);

				//ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_MSGBOX, ""SERVER"M:DM > "WHITE"Whitelist", dialog, "OKAY", "");
				SetTimerEx("kickPlayer", 250, false, "i", playerid);
				return 1;
			}
			case WL_REFUSED:
			{
				new dialog[512];
				format(dialog, sizeof(dialog), "\
					"SERVER"> "WHITE"Your whitelist request status: "SERVER"REFUSED\n\
					"SERVER"__________________________________________________\n\n\
					"SERVER"> "WHITE"WL ID: %04d\n\
					"SERVER"> "WHITE"Name: %s\n\
					"SERVER"> "WHITE"IP: %s\n\
					"SERVER"> "WHITE"Email: %s\n\
					"SERVER"> "WHITE"Discord: %s#%s\n\
					"SERVER"> "WHITE"Admin: %s\n\
					"SERVER"__________________________________________________\n\n\
					", id, name, ip, email, discord, code, admin);

				//ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_MSGBOX, ""SERVER"M:DM > "WHITE"Whitelist", dialog, "OKAY", "");
				SetTimerEx("kickPlayer", 250, false, "i", playerid);
				return 1;
			}
			case WL_ACCEPTED:
			{
				//setDiscordNickname(id);
				//InfoMessage(playerid, "Your whitelist request status: "SERVER"ACCEPTED");
				//InfoMessage(playerid, "WL ID: "SERVER"%04d // "WHITE"Name: "SERVER"%s", id, name);
				//InfoMessage(playerid, "Email: "SERVER"%s // "WHITE"Admin: "SERVER"%s", email, admin);
			}
		}
	}
	else
	{
		if(!ServerInfo[serverWL])
		{
			ClearChat(playerid, 20);
			SetPlayerColor(playerid, COL_BLACK);
			onPlayerKicked(playerid, "Mexico-AC", "Whitelist is disabled.");
		}
		else
		{
			TogglePlayerSpectating(playerid, true);
			//loadingWhitelist(playerid);
		}
		return 1;
	}*/
	//cache_delete(result);

	// ---------------- //

	InfoMessage(playerid, "Checking your ban status...");
	mysql_format(DB, query, sizeof(query), "SELECT * FROM "BAN_DB" WHERE `banIP`='%e' LIMIT 1", GetPlayerIP(playerid));
	result = mysql_query(DB, query);

	if(cache_num_rows() > 0)
	{
		new name[24], ip[16], admin[24], reason[24], date[24], time;
		cache_get_value(0, "banName", name, 24);
		cache_get_value(0, "banIP", ip, 16);
		cache_get_value(0, "banAdmin", admin, 24);
		cache_get_value(0, "banReason", reason, 24);
		cache_get_value(0, "banDate", date, 24);
		cache_get_value_int(0, "banTime", time);

		if(time == 0)
		{
			new dialog[512];
			format(dialog, sizeof(dialog), "\
				"SERVER"> "WHITE"Your account %s and your IP address are banned from Solvine Deathmatch.\n\
				"SERVER"> "WHITE"Admin: %s\n\
				"SERVER"> "WHITE"Your ban reason: %s\n\
				"SERVER"> "WHITE"Ban date: %s\n\
				"SERVER"__________________________________________________\n\n\
				"SERVER"> "WHITE"Our forum: "SERVER""FORUM"\n\
				", name, admin, reason, date);
			ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_MSGBOX, ""SERVER"M:DM > "WHITE"You are banned.", dialog, "OKAY", "");

			ClearChat(playerid, 20);
			SetTimerEx("kickPlayer", 250, false, "i", playerid);
			return 1;
		}
		else
		{
			if(gettime() > time)
			{
				InfoMessage(playerid, "Your temporarily banned account %s expired.", name);
				InfoMessage(playerid, "Please do not violate our server rules anymore.");
				InfoMessage(playerid, "Admin: %s", admin);
				InfoMessage(playerid, "Your ban reason: %s", reason);
				InfoMessage(playerid, "Ban date: %s", date);
				InfoMessage(playerid, "Forum: "SERVER"%s");

				mysql_format(DB, query, sizeof(query), "DELETE FROM "BAN_DB" WHERE `banName`='%s'", GetName(playerid));
				mysql_tquery(DB, query);
			}
			else
			{
				new year, month, day, hours, minutes, seconds;
				TimestampToDate(time, year, month, day, hours, minutes, seconds, 2);

				new dialog[512];
				format(dialog, sizeof(dialog), "\
					"SERVER"> "WHITE"Your account %s and your IP address are temporarily banned.\n\
					"SERVER"> "WHITE"Admin: %s\n\
					"SERVER"> "WHITE"Your ban reason: %s\n\
					"SERVER"> "WHITE"Ban date: %s\n\
					"SERVER"> "WHITE"Ban expire: %d-%02d-%02d %02d:%02d:%02d\n\
					"SERVER"__________________________________________________\n\n\
					"SERVER"> "WHITE"Our forum: "SERVER""FORUM"\n\
					", name, admin, reason, date, year, month, day, hours, minutes, seconds);
				ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_MSGBOX, ""SERVER"M:DM > "WHITE"You are banned.", dialog, "OKAY", "");

				ClearChat(playerid, 20);
				SetTimerEx("kickPlayer", 250, false, "i", playerid);
				return 1;
			}
		}
	}

	cache_delete(result);

	// ---------------- //

	InfoMessage(playerid, "Checking your account status...");
	mysql_format(DB, query, sizeof(query), "SELECT `pPassword` FROM "USER_DB" WHERE `pName`='%e' LIMIT 1", GetName(playerid));
	result = mysql_query(DB, query);

	if(cache_num_rows() > 0)
	{
		cache_get_value(0, "pPassword", PI[playerid][pPassword], 65);

		TogglePlayerSpectating(playerid, true);
		loadingLogin(playerid);
	}
	else
	{
		if(ServerInfo[serverRegistration] == false)
		{
			ClearChat(playerid, 20);
			SetPlayerColor(playerid, COL_BLACK);
			onPlayerKicked(playerid, ">AC<", "Registration is disabled.");
			return 1;
		}
		else
		{
			TogglePlayerSpectating(playerid, true);
			loadingRegister(playerid);
		}
	}
	cache_delete(result);

	// ---------------- //
	
	#if defined saving_OnPlayerConnect
		return saving_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect saving_OnPlayerConnect
#if defined saving_OnPlayerConnect
	forward saving_OnPlayerConnect(playerid);
#endif
//==============================================================================//
