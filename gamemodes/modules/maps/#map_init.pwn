//==============================================================================//
/*
	* Module: #map_init.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
public OnGameModeInit()
{
	createMapJail();
	createSpawnMap();
	//createMapHallOfFame();
	createMapLeaderboard();
	createMapScreenshare();
	
	#if defined map_OnGameModeInit
		return map_OnGameModeInit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif

#define OnGameModeInit map_OnGameModeInit
#if defined map_OnGameModeInit
	forward map_OnGameModeInit();
#endif
//==============================================================================//
public OnPlayerConnect(playerid)
{
	removeMapLeaderboard(playerid);
	
	#if defined map_OnPlayerConnect
		return map_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect map_OnPlayerConnect
#if defined map_OnPlayerConnect
	forward map_OnPlayerConnect(playerid);
#endif
//==============================================================================//