/*
	____                       _ __
   /  _/___  _________ _____  (_) /___  __
   / // __ \/ ___/ __ `/ __ \/ / __/ / / /
 _/ // / / (__  ) /_/ / / / / / /_/ /_/ /
/___/_/ /_/____/\__,_/_/ /_/_/\__/\__, /
								 /____/
			____        ____
		   / __ )____ _/ / /___  ____  ____  _____
		  / __  / __ `/ / / __ \/ __ \/ __ \/ ___/
		 / /_/ / /_/ / / / /_/ / /_/ / / / (__  )
		/_____/\__,_/_/_/\____/\____/_/ /_/____/

								   _____            __
								  / ___/__  _______/ /____  ____ ___
								  \__ \/ / / / ___/ __/ _ \/ __ `__ \
								 ___/ / /_/ (__  ) /_/  __/ / / / / /
								/____/\__, /____/\__/\___/_/ /_/ /_/
									 /____/

- Description

  The filterscript allow players to get balloons, change it and control it.

- Author, help, includes

  Allan Jader (CyNiC)
  Author of the GetXYInFrontOfPlayer [float calculation help]
  RyDeR,Kalcor and De[M]oN [MapAndreas include]


- Note

  You can change how much you want the filterscript, leaving the credit to creator.

*/

#include    "mapandreas"

#define ON_PLAYER 0
#define ON_balloon 1


enum ballooninfo
{
	Float:bPos[3],
	Float:bCameraDistance,
	Float:bSpeed,
	bObjectID,
	fObjectID[2],
	oAttachedSlot,
	bCameraMode,
	bTimer,
	bTimerCount,
	bool:bPaused
};

enum { dialog_information }

new balloon[MAX_PLAYERS][ballooninfo];

new ObjectOwner[MAX_OBJECTS];

static const balloontype[7] =
{
	19332,
	19333,
	19334,
	19335,
	19336,
	19337,
	19338
};

static Float:gVerticalSpeed = 5.0;
static Float:gHorizontalSpeed = 10.0;

public OnGameModeInit()
{
	for(new i = 0, j = GetMaxPlayers(); i < j; i++)
	{
		if(IsPlayerConnected(i) && !IsPlayerNPC(i)) CallLocalFunction("OnPlayerConnect", "d", i);
	}
	
	#if defined baloon_OnGameModeInit
		return baloon_OnGameModeInit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif

#define OnGameModeInit baloon_OnGameModeInit
#if defined baloon_OnGameModeInit
	forward baloon_OnGameModeInit();
#endif

public OnGameModeExit()
{
	for(new i = 0, j = GetMaxPlayers(); i < j; i++)
	{
		if(IsPlayerConnected(i) && !IsPlayerNPC(i)) CallLocalFunction("OnPlayerDisconnect", "dd", i, 0);
	}
	
	#if defined baloon_OnGameModeExit
		return baloon_OnGameModeExit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeExit
	#undef OnGameModeExit
#else
	#define _ALS_OnGameModeExit
#endif

#define OnGameModeExit baloon_OnGameModeExit
#if defined baloon_OnGameModeExit
	forward baloon_OnGameModeExit();
#endif


public OnPlayerConnect(playerid)
{
	balloon[playerid][bTimer] = -1;
	balloon[playerid][bObjectID] = INVALID_OBJECT_ID;
	balloon[playerid][fObjectID][0] = INVALID_OBJECT_ID;
	balloon[playerid][fObjectID][1] = INVALID_OBJECT_ID;
	balloon[playerid][bCameraMode] = 0;
	
	#if defined baloon_OnPlayerConnect
		return baloon_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect baloon_OnPlayerConnect
#if defined baloon_OnPlayerConnect
	forward baloon_OnPlayerConnect(playerid);
#endif

public OnPlayerDisconnect(playerid, reason)
{
	if(IsValidObject(balloon[playerid][bObjectID]))
	{
		if(balloon[playerid][bTimer] != -1) KillTimer(balloon[playerid][bTimer]);
		ObjectOwner[balloon[playerid][bObjectID]] = -1;
		DestroyObject(balloon[playerid][bObjectID]);
		DestroyObject(balloon[playerid][fObjectID][0]);
		DestroyObject(balloon[playerid][fObjectID][1]);
		balloon[playerid][bObjectID] = INVALID_OBJECT_ID;
		balloon[playerid][fObjectID][0] = INVALID_OBJECT_ID;
		balloon[playerid][fObjectID][1] = INVALID_OBJECT_ID;
		balloon[playerid][bTimer] = -1;
		balloon[playerid][bTimerCount] = 0;
	}
	
	#if defined baloon_OnPlayerDisconnect
		return baloon_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect baloon_OnPlayerDisconnect
#if defined baloon_OnPlayerDisconnect
	forward baloon_OnPlayerDisconnect(playerid, reason);
#endif

CMD:balon(playerid, params[])
{
	new param[20];
	if(sscanf(params, "s[20]", param)) return SendClientMessage(playerid, 0xFF4040AA, "SYNTAX: /balloon [ get | color (colorid) | vspeed | hspeed | cameramode ]");
	
	if(strfind(param, "get", true) != -1)
	{
		if(AddPlayerBalloon(playerid, balloontype[random(sizeof balloontype)], false))
		{
			ShowPlayerDialog(playerid, dialog_information, DIALOG_STYLE_MSGBOX, "{E6CC1A}Information", "{FFFFFF}Controls:\n\n{BEE916}'ENTER' start/pause control\n\n'Y' move to up\n\n'N' move to down\n\n'W' to move forward\n\n'S' to move backward\n\n'C' to decrease the speed", "Close", "");
			return true;
		}
		return SendClientMessage(playerid, 0xFF4040AA, "The server has the maximum of objects possible.");
	}
	else if(strfind(param, "color", true) != -1)
	{
		new value, str[64];
		if(sscanf(params, "s[20]i", param, value)) return SendClientMessage(playerid, 0xFF4040AA, "SYNTAX: /balloon color [1 - 7]");
		else if(!IsValidObject(balloon[playerid][bObjectID])) return SendClientMessage(playerid, 0xFF4040AA, "You do not have a balloon.");

		if(AddPlayerBalloon(playerid, balloontype[value - 1], true))
		{
			format(str, 64, "The {FFFFFF}balloon type{FF4040} was changed for %d.", value);
			SendClientMessage(playerid, 0xFF4040AA, str);
			return true;
		}
		return SendClientMessage(playerid, 0xFF4040AA, "The server has the maximum of objects possible.");
	}
	else if(strfind(param, "vspeed", true) != -1)
	{
		new Float:value, str[64];
		if(sscanf(params, "s[20]f", param, value)) SendClientMessage(playerid, 0xFF4040AA, "SYNTAX: /balloon vspeed (speed)");
		else if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, 0xFF4040AA, "This command is exclusive for admins.");

		gVerticalSpeed = value;
		format(str, 64, "The {FFFFFF}vertical{FF4040} balloon speed was changed for %.1f.", gVerticalSpeed);
		SendClientMessage(playerid, 0xFF4040AA, str);
		return true;
	}
	else if(strfind(param, "hspeed", true) != -1)
	{
		new Float:value, str[64];
		if(sscanf(params, "s[20]f", param, value)) return SendClientMessage(playerid, 0xFF4040AA, "SYNTAX: /balloon vspeed (speed)");
		else if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, 0xFF4040AA, "This command is exclusive for admins.");

		gHorizontalSpeed = value;
		format(str, 64, "The {FFFFFF}horizontal{FF4040} balloon speed was changed for %.1f.", gHorizontalSpeed);
		SendClientMessage(playerid, 0xFF4040AA, str);
		return true;
	}
	else if(strfind(param, "cameramode", true) != -1)
	{
		new value, str[64];
		if(sscanf(params, "s[20]i", param, value)) return SendClientMessage(playerid, 0xFF4040AA, "SYNTAX: /balloon cameramode [1-2]");
		new cammode[2][13] = { "\"ON PLAYER\"", "\"ON balloon\"" };

		balloon[playerid][bCameraMode] = value - 1;
		if(value == 1) SetCameraBehindPlayer(playerid);
		format(str, 64, "The {FFFFFF}camera mode{FF4040} was changed for %s.", cammode[value - 1]);
		SendClientMessage(playerid, 0xFF4040AA, str);
		return true;
	}
	return SendClientMessage(playerid, 0xFF4040AA, "SYNTAX: /balloon [ get | color (colorid) | vspeed | hspeed | cameramode ]");
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(IsNearOfBalloon(playerid))
	{
		if(newkeys & KEY_SECONDARY_ATTACK && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			if(balloon[playerid][bPaused])
			{
				SetPlayerArmedWeapon(playerid, 0);
				SetPlayerAttachedObject(playerid, GetEmptyAttachedSlot(playerid), 19087, 6, 0.490910, -0.251698, 1.521623, 11.095133, 14.952476, 349.793426, 0.684850, 0.684850, 0.684850);
				ApplyAnimation(playerid, "POOL", "POOL_Idle_Stance", 4.1, 1, 1, 1, 1, 1);
				balloon[playerid][bTimer] = SetTimerEx("CheckPlayerKeys", 500, true, "d", playerid);
				balloon[playerid][bPaused] = false;
				balloon[playerid][bCameraDistance] = 80.0;
				return true;
			}
			else
			{
				StopObject(balloon[playerid][bObjectID]);
				ClearAnimations(playerid);
				SetCameraBehindPlayer(playerid);
				RemovePlayerAttachedObject(playerid, balloon[playerid][oAttachedSlot]);
				KillTimer(balloon[playerid][bTimer]);
				balloon[playerid][bTimer] = -1;
				balloon[playerid][bPaused] = true;
				return true;
			}
		}

		if(newkeys & KEY_CROUCH) SetSlowSpeed(playerid);

		if(!balloon[playerid][bPaused])
		{
			CheckPlayerKeys(playerid);
			UpdateCamera(playerid);
		}
	}
	
	#if defined baloon_OnPlayerKeyStateChange
		return baloon_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange baloon_OnPlayerKeyStateChange
#if defined baloon_OnPlayerKeyStateChange
	forward baloon_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

public OnObjectMoved(objectid)
{
	if(ObjectOwner[objectid] != -1)
	{
		if(objectid == balloon[ObjectOwner[objectid]][bObjectID])
		{
			StopObject(objectid);//To avoid wrong moviments(try remove this to see what happens)
		}
	}
	
	#if defined baloon_OnObjectMoved
		return baloon_OnObjectMoved(objectid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnObjectMoved
	#undef OnObjectMoved
#else
	#define _ALS_OnObjectMoved
#endif

#define OnObjectMoved baloon_OnObjectMoved
#if defined baloon_OnObjectMoved
	forward baloon_OnObjectMoved(objectid);
#endif

function CheckPlayerKeys(playerid)
{
	new key[3];

	GetPlayerKeys(playerid, key[0], key[1], key[2]);
	ApplyAnimation(playerid, "POOL", "POOL_Idle_Stance", 4.1, 1, 1, 1, 1, 1);
	UpdateCamera(playerid);

	if(!IsNearOfBalloon(playerid))
	{
		StopObject(balloon[playerid][bObjectID]);
		ClearAnimations(playerid);
		SetCameraBehindPlayer(playerid);
		KillTimer(balloon[playerid][bTimer]);
		balloon[playerid][bTimer] = -1;
		balloon[playerid][bTimerCount] = 0;
		RemovePlayerAttachedObject(playerid, balloon[playerid][oAttachedSlot]);
		return true;
	}

	switch(key[1])
	{
		case -128: //forward
		{
			new Float:Angle;

			GetPlayerFacingAngle(playerid, Angle);
			balloon[playerid][bPos][0] += (35.0 * floatsin(-Angle, degrees));
			balloon[playerid][bPos][1] += (35.0 * floatcos(-Angle, degrees));

			if(key[0] != KEY_CROUCH) SetSpeed(playerid, gHorizontalSpeed);
			else SetSlowSpeed(playerid);

			#if defined _MapAndreas_Included

			new Float:ZPos;

			if(GetPointZPos(balloon[playerid][bPos][0], balloon[playerid][bPos][1], ZPos))
			{
				if(ZPos > balloon[playerid][bPos][2]) balloon[playerid][bPos][2] = floatadd(ZPos, 0.5);
			}
			else
			{
				if(balloon[playerid][bPos][2] < 0.0)
				{
					balloon[playerid][bPos][2] = 0.0;
				}
			}

			#else

			if(balloon[playerid][bPos][2] < 0.0)
			{
				balloon[playerid][bPos][2] = 0.0;
			}

			#endif

			StopObject(balloon[playerid][bObjectID]);
			MoveObject(balloon[playerid][bObjectID], balloon[playerid][bPos][0], balloon[playerid][bPos][1], balloon[playerid][bPos][2], balloon[playerid][bSpeed], 0.0, 0.0, 0.0);
			return true;
		}
		case 128: //backward
		{
			new Float:Angle;

			GetPlayerFacingAngle(playerid, Angle);
			balloon[playerid][bPos][0] -= (35.0 * floatsin(-Angle, degrees));
			balloon[playerid][bPos][1] -= (35.0 * floatcos(-Angle, degrees));

			if(key[0] != KEY_CROUCH) SetSpeed(playerid, gHorizontalSpeed);
			else SetSlowSpeed(playerid);

			#if defined _MapAndreas_Included

			new Float:ZPos;

			if(GetPointZPos(balloon[playerid][bPos][0], balloon[playerid][bPos][1], ZPos))
			{
				if(ZPos > balloon[playerid][bPos][2]) balloon[playerid][bPos][2] = floatadd(ZPos, 0.5);
			}
			else
			{
				if(balloon[playerid][bPos][2] < 0.0)
				{
					balloon[playerid][bPos][2] = 0.0;
				}
			}

			#else

			if(balloon[playerid][bPos][2] < 0.0)
			{
				balloon[playerid][bPos][2] = 0.0;
			}

			#endif

			StopObject(balloon[playerid][bObjectID]);
			MoveObject(balloon[playerid][bObjectID], balloon[playerid][bPos][0], balloon[playerid][bPos][1], balloon[playerid][bPos][2], balloon[playerid][bSpeed], 0.0, 0.0, 0.0);
			return true;
		}
	}
	switch(key[0])
	{
		case KEY_YES: //up
		{
			new Float:Angle;

			GetPlayerFacingAngle(playerid, Angle);
			GetObjectPos(balloon[playerid][bObjectID], balloon[playerid][bPos][0], balloon[playerid][bPos][1], balloon[playerid][bPos][2]);
			balloon[playerid][bPos][2] = floatadd(balloon[playerid][bPos][2], 50.0);

			if(key[0] != KEY_CROUCH) SetSpeed(playerid, gVerticalSpeed);
			else SetSlowSpeed(playerid);
			StopObject(balloon[playerid][bObjectID]);
			MoveObject(balloon[playerid][bObjectID], balloon[playerid][bPos][0], balloon[playerid][bPos][1], balloon[playerid][bPos][2], balloon[playerid][bSpeed], 0.0, 0.0, 0.0);
		}
		case KEY_NO: //down
		{
			new Float:Angle;

			GetPlayerFacingAngle(playerid, Angle);
			GetObjectPos(balloon[playerid][bObjectID], balloon[playerid][bPos][0], balloon[playerid][bPos][1], balloon[playerid][bPos][2]);
			balloon[playerid][bPos][2] = floatsub(balloon[playerid][bPos][2], 50.0);

			if(key[0] != KEY_CROUCH) SetSpeed(playerid, gVerticalSpeed);
			else SetSlowSpeed(playerid);

			#if defined _MapAndreas_Included

			new Float:ZPos;

			if(GetPointZPos(balloon[playerid][bPos][0], balloon[playerid][bPos][1], ZPos))
			{
				if(ZPos > balloon[playerid][bPos][2]) balloon[playerid][bPos][2] = floatadd(ZPos, 0.5);
			}
			else
			{
				if(balloon[playerid][bPos][2] < 0.0)
				{
					balloon[playerid][bPos][2] = 0.0;
				}
			}

			#else

			if(balloon[playerid][bPos][2] < 0.0)
			{
				balloon[playerid][bPos][2] = 0.0;
			}

			#endif

			StopObject(balloon[playerid][bObjectID]);
			MoveObject(balloon[playerid][bObjectID], balloon[playerid][bPos][0], balloon[playerid][bPos][1], balloon[playerid][bPos][2], balloon[playerid][bSpeed], 0.0, 0.0, 0.0);
			return true;
		}
		case KEY_CROUCH: balloon[playerid][bCameraDistance] = 20.0;
	}
	if(key[2] != 0)
	{
		new Float:Angle;

		GetPlayerFacingAngle(playerid, Angle);
		balloon[playerid][bPos][0] += (35.0 * floatsin(-Angle, degrees));
		balloon[playerid][bPos][1] += (35.0 * floatcos(-Angle, degrees));

		if(key[0] != KEY_CROUCH) SetSpeed(playerid, gHorizontalSpeed);
		else SetSlowSpeed(playerid);

		#if defined _MapAndreas_Included

		new Float:ZPos;

		if(GetPointZPos(balloon[playerid][bPos][0], balloon[playerid][bPos][1], ZPos))
		{
			if(ZPos > balloon[playerid][bPos][2]) balloon[playerid][bPos][2] = floatadd(ZPos, 0.5);
		}
		else
		{
			if(balloon[playerid][bPos][2] < 0.0)
			{
				balloon[playerid][bPos][2] = 0.0;
			}
		}

		#else

		if(balloon[playerid][bPos][2] < 0.0)
		{
			balloon[playerid][bPos][2] = 0.0;
		}

		#endif

		StopObject(balloon[playerid][bObjectID]);
		MoveObject(balloon[playerid][bObjectID], balloon[playerid][bPos][0], balloon[playerid][bPos][1], balloon[playerid][bPos][2], balloon[playerid][bSpeed], 0.0, 0.0, 0.0);
		return true;
	}
	return true;
}

UpdateCamera(playerid)
{
	if(balloon[playerid][bCameraMode] == ON_balloon)
	{
		if(balloon[playerid][bTimerCount] == 3)
		{
			new Float:LookAt[3], Float:Pos[3];

			GetPlayerPos(playerid, LookAt[0], LookAt[1], LookAt[2]);
			GetXYInBackOfObject(balloon[playerid][bObjectID], playerid, Pos[0], Pos[1], balloon[playerid][bCameraDistance]);
			balloon[playerid][bTimerCount] = 0;

			SetPlayerCameraPos(playerid, Pos[0], Pos[1], floatadd(LookAt[2], 15.0));
			SetPlayerCameraLookAt(playerid, LookAt[0], LookAt[1], LookAt[2]);
			return true;
		}
		balloon[playerid][bTimerCount]++;
	}
	return true;
}

AddPlayerBalloon(playerid, type, bool:changecolor)
{
	for(new i = 0, Float:Pos[3]; i < MAX_OBJECTS; i++)
	{
		if(!IsValidObject(i))
		{
			if(IsValidObject(balloon[playerid][bObjectID]))
			{
				if(balloon[playerid][bTimer] != -1) KillTimer(balloon[playerid][bTimer]);
				DestroyObject(balloon[playerid][bObjectID]);
				DestroyObject(balloon[playerid][fObjectID][0]);
				DestroyObject(balloon[playerid][fObjectID][1]);
				balloon[playerid][bObjectID] = INVALID_OBJECT_ID;
				balloon[playerid][fObjectID][0] = INVALID_OBJECT_ID;
				balloon[playerid][fObjectID][1] = INVALID_OBJECT_ID;
				balloon[playerid][bPaused] = true;
				balloon[playerid][bTimerCount] = 0;
				balloon[playerid][bCameraDistance] = 80.0;
				if(changecolor) balloon[playerid][bObjectID] = CreateObject(type, balloon[playerid][bPos][0], balloon[playerid][bPos][1], balloon[playerid][bPos][2], 0.0, 0.0, 0.0);
				else
				{
					GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
					balloon[playerid][bPos][0] = Pos[0];
					balloon[playerid][bPos][1] = Pos[1];
					balloon[playerid][bPos][2] = floatsub(Pos[2], 0.5);
					balloon[playerid][bObjectID] = CreateObject(type, balloon[playerid][bPos][0], balloon[playerid][bPos][1], balloon[playerid][bPos][2], 0.0, 0.0, 0.0);
				}
				balloon[playerid][fObjectID][0] = CreateObject(18702, 0.0, 0.0, -50.0, 0.0, 0.0, 0.0);
				balloon[playerid][fObjectID][1] = CreateObject(18702, 0.0, 0.0, -50.0, 0.0, 0.0, 0.0);
				AttachObjectToObject(balloon[playerid][fObjectID][0], balloon[playerid][bObjectID], 0.3, 0.0, 1.5, 0.0, 360.0, 0.0, 0);
				AttachObjectToObject(balloon[playerid][fObjectID][1], balloon[playerid][bObjectID], -0.3, 0.0, 1.5, 0.0, 360.0, 0.0, 0);
				ObjectOwner[balloon[playerid][bObjectID]] = playerid;
				return true;
			}
			GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
			balloon[playerid][bPos][0] = Pos[0];
			balloon[playerid][bPos][1] = Pos[1];
			balloon[playerid][bPos][2] = floatsub(Pos[2], 0.5);
			balloon[playerid][bObjectID] = CreateObject(type, balloon[playerid][bPos][0], balloon[playerid][bPos][1], balloon[playerid][bPos][2], 0.0, 0.0, 0.0);
			balloon[playerid][fObjectID][0] = CreateObject(18702, 0.0, 0.0, -50.0, 0.0, 0.0, 0.0);
			balloon[playerid][fObjectID][1] = CreateObject(18702, 0.0, 0.0, -50.0, 0.0, 0.0, 0.0);
			balloon[playerid][bPaused] = true;
			balloon[playerid][bTimerCount] = 0;
			balloon[playerid][bCameraDistance] = 80.0;
			ObjectOwner[balloon[playerid][bObjectID]] = playerid;
			AttachObjectToObject(balloon[playerid][fObjectID][0], balloon[playerid][bObjectID], 0.3, 0.0, 1.5, 0.0, 360.0, 0.0, 0);
			AttachObjectToObject(balloon[playerid][fObjectID][1], balloon[playerid][bObjectID], -0.3, 0.0, 1.5, 0.0, 360.0, 0.0, 0);
			PreloadAnimLib(playerid, "POOL");
			PreloadAnimLib(playerid, "PED");
			SetCameraBehindPlayer(playerid);
			return true;
		}
	}
	return false;
}

IsNearOfBalloon(playerid)
{
	if(!IsValidObject(balloon[playerid][bObjectID])) return false;

	new Float:Pos[3];

	GetObjectPos(balloon[playerid][bObjectID], Pos[0], Pos[1], Pos[2]);
	return IsPlayerInRangeOfPoint(playerid, 4.0, Pos[0], Pos[1], Pos[2]);
}

GetXYInBackOfObject(objectid, playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetObjectPos(objectid, x, y, a);
	GetPlayerFacingAngle(playerid, a);

	x -= (distance * floatsin(-a, degrees));
	y -= (distance * floatcos(-a, degrees));
}

SetSlowSpeed(playerid)
{
	balloon[playerid][bSpeed] = 2.0;
	balloon[playerid][bCameraDistance] = 15.0;
}

SetSpeed(playerid, Float:Speed)
{
	balloon[playerid][bSpeed] = Speed;
	balloon[playerid][bCameraDistance] = 80.0;
}

PreloadAnimLib(playerid, animlib[])
{
	ApplyAnimation(playerid, animlib, "null", 0.0, 0, 0, 0, 0, 0);
}

GetEmptyAttachedSlot(playerid)
{
	for(new i = 0; i < MAX_PLAYER_ATTACHED_OBJECTS; i++)
	{
		if(!IsPlayerAttachedObjectSlotUsed(playerid, i))
		{
			balloon[playerid][oAttachedSlot] = i;
			return i;
		}
	}
	balloon[playerid][oAttachedSlot] = -1;
	return -1;
}
