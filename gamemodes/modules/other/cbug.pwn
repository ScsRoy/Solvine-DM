
//==============================================================================//

/*	* Module: file.pwn
	* Author: Sule
	* Date: date */

//==============================================================================//

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(!CBugAllowed[playerid] && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		if((newkeys & KEY_FIRE)) CBugTime[playerid] = GetTickCount();
		else if((oldkeys & KEY_FIRE) && ((newkeys & KEY_CROUCH) || (newkeys & KEY_ACTION)) && (GetTickCount () - CBugTime[playerid]) < 1200)
		{
			onPlayerCBug(playerid);
		}
	}


	#if defined cbug_OnPlayerKeyStateChange
		return cbug_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange cbug_OnPlayerKeyStateChange
#if defined cbug_OnPlayerKeyStateChange
	forward cbug_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif
//==============================================================================//
onPlayerCBug(playerid)
{
	new w, a;
	GetPlayerWeaponData(playerid, 0, w, a);

	ClearAnimations(playerid, 1);
	ApplyAnimation(playerid, "PED", "IDLE_stance", 4.1, 1, 0, 0, 0, 0, 1);
	FreezeSyncData(playerid, true);
	GivePlayerWeapon(playerid, w, 0);

	// ---------------- //

	CBugWarns[playerid]++;

	GameTextForPlayer(playerid, "~r~~h~DON'T C-BUG!", 3000, 4);
/*	if(CBugWarns[playerid] < 3)
	{
		//SendClientMessageEx(playerid, COL_RED, "C-Bug // "WHITE"You got a warn for C-Bugging, if you keep doing that you will be kicked. (%d / 3)", CBugWarns[playerid]);
		GameTextForPlayer(playerid, "~r~~h~DON'T C-BUG!", 3000, 4);
	}
	else //if(CBugWarns[playerid] >= 3)
	{ 
		GameTextForPlayer(playerid, "~r~~h~DON'T C-BUG!", 3000, 4);
		//onPlayerKicked(playerid, "Mexico-AC", "C-Bugging (3 / 3)"); 
	}*/

	// ---------------- //

	SetTimerEx("cBugPunishment", 1000, false, "ii", playerid, GetPlayerWeapon(playerid));
	return 1;
}
//=======================================//
function cBugPunishment(playerid, weapon)
{
	FreezeSyncData(playerid, false);
	ClearAnimations(playerid, 1);
	GivePlayerWeapon(playerid, weapon, 0);
	return 1;
}
//==============================================================================//
toggleCBug(playerid, bool:toggle)
{
	return CBugAllowed[playerid] = toggle;
}
//==============================================================================//