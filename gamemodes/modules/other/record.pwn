//==============================================================================//
/*
	* Module: record.pwn
	* Author: Sule
	* Date: 20.04.2020
*/
//==============================================================================//
checkRecord()
{
	if(ServerInfo[onlinePlayers] > ServerInfo[serverDailyRecord])
	{
		ServerInfo[serverDailyRecord] = ServerInfo[onlinePlayers];

		new str[128];
		format(str, sizeof(str), "RECORD: "WHITE"New daily record. (%d)", ServerInfo[serverDailyRecord]);
		SendClientMessageToAll(COL_SERVER, str);
		#if USE_DISCORD == true
			format(str, sizeof(str), "> New daily record. **%d**.", ServerInfo[serverDailyRecord]);
			DCC_SendChannelMessage(DiscordInfo[log_in_log_out], str);
		#endif
	}
	if(ServerInfo[onlinePlayers] > ServerInfo[serverRecord])
	{
		ServerInfo[serverRecord] = ServerInfo[onlinePlayers];
		mySQL_UpdateServerCustomVal("serverRecord", ServerInfo[serverRecord]);

		new str[128];
		format(str, sizeof(str), "RECORD: "WHITE"New server record. (%d)", ServerInfo[serverRecord]);
		SendClientMessageToAll(COL_SERVER, str);
		#if USE_DISCORD == true
			format(str, sizeof(str), "> New server record. **%d**.", ServerInfo[serverRecord]);
			DCC_SendChannelMessage(DiscordInfo[log_in_log_out], str);
		#endif
	}
	return 1;
}
//==============================================================================//