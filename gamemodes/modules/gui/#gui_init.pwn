//==============================================================================//
/*
	* Module: #gui_init.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
public OnGameModeInit()
{
	// ---------------- //

	createAlertTD();
	createArenaTD();
	createSessionTD();
	createVersusTD();
	createDeathCamTD();
	createWhitelistTD();

	// ---------------- //

	animTD = TextDrawCreate(320.000000, 383.566833, "RMB~w~ - TO STOP ANIMATION.");
	TextDrawLetterSize(animTD, 0.205500, 1.074999);
	TextDrawTextSize(animTD, 0.000000, 142.000000);
	TextDrawAlignment(animTD, 2);
	TextDrawColor(animTD, COL_SERVER);
	TextDrawUseBox(animTD, 1);
	TextDrawBoxColor(animTD, 0);
	TextDrawSetShadow(animTD, 0);
	TextDrawSetOutline(animTD, 1);
	TextDrawBackgroundColor(animTD, 255);
	TextDrawFont(animTD, 1);
	TextDrawSetProportional(animTD, 1);
	TextDrawSetShadow(animTD, 0);

	// ---------------- //

	hitMarkerTD = TextDrawCreate(339.001159, 174.299041, "X");
	TextDrawLetterSize(hitMarkerTD, 0.323666, 0.973406);
	TextDrawAlignment(hitMarkerTD, 2);
	TextDrawColor(hitMarkerTD, -1341453313);
	TextDrawSetShadow(hitMarkerTD, 1);
	TextDrawBackgroundColor(hitMarkerTD, 255);
	TextDrawFont(hitMarkerTD, 1);
	TextDrawSetProportional(hitMarkerTD, 1);

	// ---------------- //
	
	#if defined gui_OnGameModeInit
		return gui_OnGameModeInit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif

#define OnGameModeInit gui_OnGameModeInit
#if defined gui_OnGameModeInit
	forward gui_OnGameModeInit();
#endif
//==============================================================================//
public OnGameModeExit()
{
	destroyAlertTD();
	destroyArenaTD();
	destroySessionTD();
	destroyVersusTD();
	destroyDeathCamTD();
	destroyWhitelistTD();
	
	#if defined gui_OnGameModeExit
		return gui_OnGameModeExit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeExit
	#undef OnGameModeExit
#else
	#define _ALS_OnGameModeExit
#endif

#define OnGameModeExit gui_OnGameModeExit
#if defined gui_OnGameModeExit
	forward gui_OnGameModeExit();
#endif
//==============================================================================//
public OnPlayerConnect(playerid)
{
	// ---------------- //

	createInGamePTD(playerid);

	// ---------------- //

	createAltChat(playerid);

	// ---------------- //

	CountDownTD[0] = CreatePlayerTextDraw(playerid, 270.000000, 140.000000, "LD_BEAT:chit");
	PlayerTextDrawLetterSize(playerid, CountDownTD[0], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, CountDownTD[0], 100.000000, 100.000000);
	PlayerTextDrawAlignment(playerid, CountDownTD[0], 1);
	PlayerTextDrawColor(playerid, CountDownTD[0], -55508737);
	PlayerTextDrawSetShadow(playerid, CountDownTD[0], 0);
	PlayerTextDrawSetOutline(playerid, CountDownTD[0], 0);
	PlayerTextDrawBackgroundColor(playerid, CountDownTD[0], 255);
	PlayerTextDrawFont(playerid, CountDownTD[0], 4);
	PlayerTextDrawSetProportional(playerid, CountDownTD[0], 0);
	PlayerTextDrawSetShadow(playerid, CountDownTD[0], 0);

	CountDownTD[1] = CreatePlayerTextDraw(playerid, 320.000000, 165.766662, "2");
	PlayerTextDrawLetterSize(playerid, CountDownTD[1], 0.963500, 5.035832);
	PlayerTextDrawAlignment(playerid, CountDownTD[1], 2);
	PlayerTextDrawColor(playerid, CountDownTD[1], -1);
	PlayerTextDrawSetShadow(playerid, CountDownTD[1], 0);
	PlayerTextDrawSetOutline(playerid, CountDownTD[1], 1);
	PlayerTextDrawBackgroundColor(playerid, CountDownTD[1], 255);
	PlayerTextDrawFont(playerid, CountDownTD[1], 3);
	PlayerTextDrawSetProportional(playerid, CountDownTD[1], 1);
	PlayerTextDrawSetShadow(playerid, CountDownTD[1], 0);

	// ---------------- //
	
	#if defined gui_OnPlayerConnect
		return gui_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect gui_OnPlayerConnect
#if defined gui_OnPlayerConnect
	forward gui_OnPlayerConnect(playerid);
#endif
//==============================================================================//
public OnPlayerDisconnect(playerid, reason)
{
	// ---------------- //

	destroyInGamePTD(playerid);

	// ---------------- //

	destroyAltChat(playerid);

	// ---------------- //

	PlayerTextDrawDestroy(playerid, CountDownTD[0]);
	PlayerTextDrawDestroy(playerid, CountDownTD[1]);

	// ---------------- //
	
	#if defined gui_OnPlayerDisconnect
		return gui_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect gui_OnPlayerDisconnect
#if defined gui_OnPlayerDisconnect
	forward gui_OnPlayerDisconnect(playerid, reason);
#endif
//==============================================================================//
