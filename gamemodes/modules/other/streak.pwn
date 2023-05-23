//==============================================================================//
/*
	* Module: streak.pwn
	* Author: Sule
	* Date: 05.05.2020.
*/
//==============================================================================//
public OnPlayerDeath(playerid, killerid, reason)
{
	KS[playerid] = 0;
	setupInGameTD(playerid);

	if(killerid != INVALID_PLAYER_ID)
	{
		KS[killerid]++;
		setupInGameTD(playerid);
	
		if(KS[killerid] > PI[killerid][pMaxKS])
		{
			PI[killerid][pMaxKS] = KS[killerid];
			mySQL_UpdatePlayerCustomVal(killerid, "pMaxKS", PI[killerid][pMaxKS]);

			InfoMessage(killerid, "You have successfully break your own streak record.");
			InfoMessage(killerid, "Your new record is %d.", KS[killerid]);
		}

		switch(KS[killerid])
		{
			case 2:
			{
				new Float:armour; GetPlayerArmour(killerid, armour);
				SetPlayerArmour(killerid, armour+25);
				GameTextForPlayer(killerid, "DOUBLE KILL", 3000, 4);

				new str[96];
				format(str, sizeof(str), "Solvine Deathmatch // "WHITE"Player {%06x}%s"WHITE" is on %d killing spree.", GetPlayerColor(killerid) >>> 8, GetName(killerid), KS[killerid]);
				SendClientMessageToAll(GetPlayerColor(killerid), str);
			}
			case 3:
			{
				new Float:armour; GetPlayerArmour(killerid, armour);
				SetPlayerArmour(killerid, armour+50);
				GameTextForPlayer(killerid, "TRIPLE KILL", 3000, 4);

				new str[96];
				format(str, sizeof(str), "Solvine Deathmatch // "WHITE"Player {%06x}%s"WHITE" is on %d killing spree.", GetPlayerColor(killerid) >>> 8, GetName(killerid), KS[killerid]);
				SendClientMessageToAll(GetPlayerColor(killerid), str);
			}
			case 4:
			{
				GameTextForPlayer(killerid, "QUADRA KILL", 3000, 4);

				new str[96];
				format(str, sizeof(str), "Solvine Deathmatch // "WHITE"Player {%06x}%s"WHITE" is on %d killing spree.", GetPlayerColor(killerid) >>> 8, GetName(killerid), KS[killerid]);
				SendClientMessageToAll(GetPlayerColor(killerid), str);
			}
			case 5:
			{
				new Float:armour; GetPlayerArmour(killerid, armour);
				SetPlayerArmour(killerid, armour+75);
				GameTextForPlayer(killerid, "RAMPAGE", 3000, 4);

				new str[96];
				format(str, sizeof(str), "Solvine Deathmatch // "WHITE"Player {%06x}%s"WHITE" is on %d killing spree.", GetPlayerColor(killerid) >>> 8, GetName(killerid), KS[killerid]);
				SendClientMessageToAll(GetPlayerColor(killerid), str);
			}
			case 7:
			{
				GameTextForPlayer(killerid, "UNSTOPABBLE", 3000, 4);

				new str[96];
				format(str, sizeof(str), "Solvine Deathmatch // "WHITE"Player {%06x}%s"WHITE" is on %d killing spree.", GetPlayerColor(killerid) >>> 8, GetName(killerid), KS[killerid]);
				SendClientMessageToAll(GetPlayerColor(killerid), str);
			}
			case 9:
			{
				GameTextForPlayer(killerid, "SAVAGE", 3000, 4);

				new str[96];
				format(str, sizeof(str), "Solvine Deathmatch // "WHITE"Player {%06x}%s"WHITE" is on %d killing spree.", GetPlayerColor(killerid) >>> 8, GetName(killerid), KS[killerid]);
				SendClientMessageToAll(GetPlayerColor(killerid), str);
			}
			case 10:
			{
				new Float:armour; GetPlayerArmour(killerid, armour);
				SetPlayerArmour(killerid, armour+100);
			}
			case 11:
			{
				GameTextForPlayer(killerid, "IMMORTAL", 3000, 4);

				new str[96];
				format(str, sizeof(str), "Solvine Deathmatch // "WHITE"Player {%06x}%s"WHITE" is on %d killing spree.", GetPlayerColor(killerid) >>> 8, GetName(killerid), KS[killerid]);
				SendClientMessageToAll(GetPlayerColor(killerid), str);
			}
			case 13:
			{
				GameTextForPlayer(killerid, "GODLIKE", 3000, 4);

				new str[96];
				format(str, sizeof(str), "Solvine Deathmatch // "WHITE"Player {%06x}%s"WHITE" is on %d killing spree.", GetPlayerColor(killerid) >>> 8, GetName(killerid), KS[killerid]);
				SendClientMessageToAll(GetPlayerColor(killerid), str);
			}
			case 15:
			{
				GameTextForPlayer(killerid, "ANNIHILATION", 3000, 4);

				new str[96];
				format(str, sizeof(str), "Solvine Deathmatch // "WHITE"Player {%06x}%s"WHITE" is on %d killing spree.", GetPlayerColor(killerid) >>> 8, GetName(killerid), KS[killerid]);
				SendClientMessageToAll(GetPlayerColor(killerid), str);
			}
		}
		if(KS[killerid] > 15 && KS[killerid] % 10 == 0)
		{
			new Float:armour; GetPlayerArmour(killerid, armour);
			SetPlayerArmour(killerid, armour+100);
			AC_GiveMoney(killerid, 100 * KS[killerid]);

			new str[96];
			format(str, sizeof(str), "Solvine Deathmatch // "WHITE"Player {%06x}%s"WHITE" is on %d killing spree.", GetPlayerColor(killerid) >>> 8, GetName(killerid), KS[killerid]);
			SendClientMessageToAll(GetPlayerColor(killerid), str);
		}
		if(KS[playerid] > 2) 
		{
			new str[128];
			format(str, sizeof(str), "Solvine Deathmatch // "WHITE"Player {%06x}%s"WHITE" just ended %s's %d killing spree.", GetPlayerColor(playerid) >>> 8, GetName(killerid), GetName(playerid), KS[playerid]);
			SendClientMessageToAll(GetPlayerColor(playerid), str);
		}
	}

	#if defined streak_OnPlayerDeath
		return streak_OnPlayerDeath(playerid, killerid, reason);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDeath
	#undef OnPlayerDeath
#else
	#define _ALS_OnPlayerDeath
#endif

#define OnPlayerDeath streak_OnPlayerDeath
#if defined streak_OnPlayerDeath
	forward streak_OnPlayerDeath(playerid, killerid, reason);
#endif
//==============================================================================//
