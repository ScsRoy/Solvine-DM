//==============================================================================//
/*
	* Module: session_td.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
createSessionTD()
{
	sessionTD[0] = TextDrawCreate(566.500244, 376.644531, "box");
	TextDrawLetterSize(sessionTD[0], 0.000000, 1.027999);
	TextDrawTextSize(sessionTD[0], 630.649658, 0.000000);
	TextDrawAlignment(sessionTD[0], 1);
	TextDrawColor(sessionTD[0], -1);
	TextDrawUseBox(sessionTD[0], 1);
	TextDrawBoxColor(sessionTD[0], 170);
	TextDrawSetShadow(sessionTD[0], 0);
	TextDrawBackgroundColor(sessionTD[0], 255);
	TextDrawFont(sessionTD[0], 1);
	TextDrawSetProportional(sessionTD[0], 1);

	sessionTD[1] = TextDrawCreate(567.000000, 367.236755, "Time");
	TextDrawLetterSize(sessionTD[1], 0.378399, 1.039999);
	TextDrawAlignment(sessionTD[1], 1);
	TextDrawColor(sessionTD[1], -1819551489);
	TextDrawSetShadow(sessionTD[1], 0);
	TextDrawSetOutline(sessionTD[1], 1);
	TextDrawBackgroundColor(sessionTD[1], 255);
	TextDrawFont(sessionTD[1], 0);
	TextDrawSetProportional(sessionTD[1], 1);
	return 1;
}
//=======================================//
destroySessionTD()
{
	TextDrawDestroy(sessionTD[0]);
	TextDrawDestroy(sessionTD[1]);
	return 1;
}
//==============================================================================//
createSessionPTD(playerid)
{
	sessionPTD[playerid] = CreatePlayerTextDraw(playerid, 569.000000, 377.697418, "01:02:03");
	PlayerTextDrawLetterSize(playerid, sessionPTD[playerid], 0.270000, 0.883598);
	PlayerTextDrawTextSize(playerid, sessionPTD[playerid], 634.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, sessionPTD[playerid], 1);
	PlayerTextDrawColor(playerid, sessionPTD[playerid], -1);
	PlayerTextDrawUseBox(playerid, sessionPTD[playerid], 1);
	PlayerTextDrawBoxColor(playerid, sessionPTD[playerid], 0);
	PlayerTextDrawSetShadow(playerid, sessionPTD[playerid], -182);
	PlayerTextDrawBackgroundColor(playerid, sessionPTD[playerid], 255);
	PlayerTextDrawFont(playerid, sessionPTD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, sessionPTD[playerid], 1);
	return 1;
}
//=======================================//
destroySessionPTD(playerid)
{
	PlayerTextDrawDestroy(playerid, sessionPTD[playerid]);
	return 1;
}
//==============================================================================//
controlSessionTD(playerid, bool:show)
{
	if(show)
	{
		if(sessionTDShown[playerid]) return 0;
		createSessionPTD(playerid);
		TextDrawShowForPlayer(playerid, sessionTD[0]);
		TextDrawShowForPlayer(playerid, sessionTD[1]);
		PlayerTextDrawShow(playerid, sessionPTD[playerid]);

		setupSessionTD(playerid);
	}
	else 
	{
		TextDrawHideForPlayer(playerid, sessionTD[0]);
		TextDrawHideForPlayer(playerid, sessionTD[1]);
		PlayerTextDrawHide(playerid, sessionPTD[playerid]);
		destroySessionPTD(playerid);
	}
	sessionTDShown[playerid] = show;
	return 1;
}
//==============================================================================//
setupSessionTD(playerid)
{
	new string[72];
	format(string, sizeof(string), "%02d:%02d:%02d", SessionInfo[playerid][sessionHours], SessionInfo[playerid][sessionMinutes], SessionInfo[playerid][sessionSeconds]);
	PlayerTextDrawSetString(playerid, sessionPTD[playerid], string);
	return 1;
}
//==============================================================================//