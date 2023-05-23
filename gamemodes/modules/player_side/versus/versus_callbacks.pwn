//==============================================================================//
/*
	* Module: versus_callbacks.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
versusCheck() 
{
	if(Iter_Count(VersusList) > 0)
	{
		foreach(new playerid:VersusList)
		{
			if(!VersusActive[playerid])
			{
				new days, hours, minutes, seconds;
				ConvertTime(gettime() - VersusTime[playerid], days, hours, minutes, seconds);

				new str[12];
				format(str, sizeof(str), "%02d:%02d:%02d", hours, minutes, seconds);
				PlayerTextDrawSetString(playerid, versusPTD[playerid], str);

				if(Iter_Count(VersusList) > 1)
				{
					new opponent = Iter_Random(VersusList);
					if(opponent != playerid && !VersusActive[opponent])
						onVersusMatchFound(playerid, opponent);
				}
			}
		}
	}
	return 1;
}
//==============================================================================//
public OnPlayerDeath(playerid, killerid, reason)
{
	if(killerid != INVALID_PLAYER_ID)
		if(VersusActive[playerid] && VersusActive[killerid])
			if(VersusOpponent[playerid] == killerid && VersusOpponent[killerid] == playerid)
				onVersusMatchFinish(playerid, killerid);

	#if defined versus_OnPlayerDeath
		return versus_OnPlayerDeath(playerid, killerid, reason);
	#endif
}
#if defined _ALS_OnPlayerDeath
	#undef OnPlayerDeath
#else
	#define _ALS_OnPlayerDeath
#endif

#define OnPlayerDeath versus_OnPlayerDeath
#if defined versus_OnPlayerDeath
	forward versus_OnPlayerDeath(playerid, killerid, reason);
#endif
//==============================================================================//
public OnPlayerDisconnect(playerid, reason)
{
	if(InVersus[playerid])
		onPlayerLeaveVersus(playerid);

	#if defined versus_OnPlayerDisconnect
		return versus_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect versus_OnPlayerDisconnect
#if defined versus_OnPlayerDisconnect
	forward versus_OnPlayerDisconnect(playerid, reason);
#endif
//==============================================================================//