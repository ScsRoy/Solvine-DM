//==============================================================================//
/*
	* Module: global_timers.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
function fastTimer() 
{
	
	fast_timer = SetTimer("fastTimer", 250, false);
	return 1;
}
//==============================================================================//
function oneSecond() 
{
	foreach(new playerid:Player)
	{
		if(Spawned[playerid])
		{
			//=======================================//

			if(PI[playerid][pMute] > 0)
			{
				PI[playerid][pMute]--;
				if(PI[playerid][pMute] == 0)
				{
					InfoMessage(playerid, "Your mute time has ended. You can type now.");
					PI[playerid][pMuteReason] = 0;

					mySQL_UnMutePlayer(playerid);
				}
			}
			if(PI[playerid][pJail] > 0)
			{
				PI[playerid][pJail]--;
				if(PI[playerid][pJail] == 0)
				{
					mySQL_UnJailPlayer(playerid);
					PostaviSpawn(playerid);
					SpawnPlayer(playerid);
					InfoMessage(playerid, "Your jail time has ended. You can play freely now.");
				}
			}

			//=======================================//

			if(EnteredArena[playerid] != -1)
			{
				SessionInfo[playerid][sessionSeconds]++;
				if(SessionInfo[playerid][sessionSeconds] >= 60)
				{
					SessionInfo[playerid][sessionSeconds] = 0;
					SessionInfo[playerid][sessionMinutes]++;
					if(SessionInfo[playerid][sessionMinutes] >= 60)
					{
						SessionInfo[playerid][sessionMinutes] = 0;
						SessionInfo[playerid][sessionHours]++;
					}
				}
				setupSessionTD(playerid);
			}

			//=======================================//
		}
		
		if(Spectate[playerid] != INVALID_PLAYER_ID)
		{
			new spec = Spectate[playerid];
			if(IsPlayerConnected(spec)) 
			{
				TogglePlayerSpectating(playerid, true);
				if(PI[playerid][pAdmin] >= 1)
				{
					if(IsPlayerInAnyVehicle(spec)) 
					{ 
						PlayerSpectateVehicle(playerid, GetPlayerVehicleID(spec));
					}
					else 
					{
						PlayerSpectatePlayer(playerid, spec);
					}
					SetPlayerInterior(playerid, GetPlayerInterior(spec));
					SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(spec));
				}
			}
		}	
	}
	versusCheck();

	one_second = SetTimer("oneSecond", 1000, false);
	return 1;
}
//==============================================================================//
function oneMinute() 
{
	//=======================================//
	
	new hours, minutes, seconds;
	gettime(hours, minutes, seconds);

	if(minutes == 0)
	{
		new str[98];
		format(str, sizeof(str), "Solvine Deathmatch // "WHITE"It is %02d:00. Enjoy playing on Solvine Deathmatch.", hours);
		SendClientMessageToAll(COL_SERVER, str);

		if(hours == 0)
		{	
			new year, month, day;
			getdate(year, month, day);

			checkDeathMatcherOfDay();
			if(day == 1)
				checkDeathMatcherOfMonth();

			ServerInfo[serverDailyRecord] = 0;
			checkRecord();
		}
	}

	//=======================================//

	checkServerHostname();
	
	//=======================================//

	foreach(new playerid:Player)
	{
		if(Spawned[playerid])
		{
			// ---------------- //

			PI[playerid][pMinutes]++;
			mySQL_UpdatePlayerCustomVal(playerid, "pMinutes", PI[playerid][pMinutes]);

			if(PI[playerid][pMinutes] >= 60)
			{
				static query[96];
				PI[playerid][pMinutes] = 0;
				PI[playerid][pHours]++;

				if(PI[playerid][pPremiumHours] > 0)
				{
					PI[playerid][pPremiumHours]--;
					if(PI[playerid][pPremiumHours] == 0)
					{
						PI[playerid][pPremium] = false;
						InfoMessage(playerid, "Your premium has been disabled automatically after 400h played hours.");
					}
					mysql_format(DB, query, sizeof(query), "UPDATE "USER_DB" SET `pPremium`=%d, `pPremiumHours`=%d WHERE `pID`=%d", PI[playerid][pPremium], PI[playerid][pPremiumHours], PI[playerid][pID]);
					mysql_tquery(DB, query);
				}

				mysql_format(DB, query, sizeof(query), "UPDATE "USER_DB" SET `pMinutes`=0, `pHours`=%d WHERE `pID`=%d", PI[playerid][pHours], PI[playerid][pID]);
				mysql_tquery(DB, query);
			}

			// ---------------- //

			if(PI[playerid][pAdmin] > 0)
			{
				static query[96];
				AdminInfo[playerid][adminMinutes]++;
				mySQL_UpdateAdminCustomVal(playerid, "adminMinutes", AdminInfo[playerid][adminMinutes]);
				if(AdminInfo[playerid][adminMinutes] >= 60)
				{
					AdminInfo[playerid][adminMinutes] = 0;
					AdminInfo[playerid][adminHours]++;
					mysql_format(DB, query, sizeof(query), "UPDATE "ADMIN_DB" SET `adminHours`=%d, `adminMinutes`=0 WHERE `adminID`=%d", AdminInfo[playerid][adminHours], AdminInfo[playerid][adminID]);
					mysql_tquery(DB, query);
				}
			}

			// ---------------- //
		}
	}

	//=======================================//
	
	one_minute = SetTimer("oneMinute", 60 * 1000, false);
	return 1;
}
//==============================================================================//
