//==============================================================================//
/*
	* Module: versus_td.pwn
	* Author: Sule
	* Date: 15.04.2020
*/
//==============================================================================//
createVersusTD()
{
	versusTD[0] = TextDrawCreate(498.800445, 109.188751, "box");
	TextDrawLetterSize(versusTD[0], -0.004999, 1.319998);
	TextDrawTextSize(versusTD[0], 607.000000, 0.000000);
	TextDrawAlignment(versusTD[0], 1);
	TextDrawColor(versusTD[0], -1);
	TextDrawUseBox(versusTD[0], 1);
	TextDrawBoxColor(versusTD[0], 170);
	TextDrawSetShadow(versusTD[0], 0);
	TextDrawBackgroundColor(versusTD[0], 255);
	TextDrawFont(versusTD[0], 1);
	TextDrawSetProportional(versusTD[0], 1);

	versusTD[1] = TextDrawCreate(501.500000, 100.066604, "Versus_lobby");
	TextDrawLetterSize(versusTD[1], 0.378399, 1.039999);
	TextDrawAlignment(versusTD[1], 1);
	TextDrawColor(versusTD[1], -1819551489);
	TextDrawSetShadow(versusTD[1], 0);
	TextDrawSetOutline(versusTD[1], 1);
	TextDrawBackgroundColor(versusTD[1], 255);
	TextDrawFont(versusTD[1], 0);
	TextDrawSetProportional(versusTD[1], 1);

	versusTD[2] = TextDrawCreate(501.500000, 111.000000, "AK-47");
	TextDrawLetterSize(versusTD[2], 0.230996, 0.934221);
	TextDrawAlignment(versusTD[2], 1);
	TextDrawColor(versusTD[2], -1);
	TextDrawSetShadow(versusTD[2], 0);
	TextDrawBackgroundColor(versusTD[2], 255);
	TextDrawFont(versusTD[2], 1);
	TextDrawSetProportional(versusTD[2], 1);
	return 1;
}
//=======================================//
destroyVersusTD()
{
	TextDrawDestroy(versusTD[0]);
	TextDrawDestroy(versusTD[1]);
	TextDrawDestroy(versusTD[2]);
	return 1;
}
//==============================================================================//
createVersusPTD(playerid)
{
	versusPTD[playerid] = CreatePlayerTextDraw(playerid, 606.000000, 111.000000, "00:00");
	PlayerTextDrawLetterSize(playerid, versusPTD[playerid], 0.230996, 0.934221);
	PlayerTextDrawAlignment(playerid, versusPTD[playerid], 3);
	PlayerTextDrawColor(playerid, versusPTD[playerid], -1);
	PlayerTextDrawSetShadow(playerid, versusPTD[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, versusPTD[playerid], 255);
	PlayerTextDrawFont(playerid, versusPTD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, versusPTD[playerid], 1);
	return 1;
}
//=======================================//
destroyVersusPTD(playerid)
{
	PlayerTextDrawDestroy(playerid, versusPTD[playerid]);
	return 1;
}
//==============================================================================//
controlVersusTD(playerid, bool:show)
{
	if(show)
	{
		if(versusTDShown[playerid]) return 0;
		createVersusPTD(playerid);

		TextDrawShowForPlayer(playerid, versusTD[0]);
		TextDrawShowForPlayer(playerid, versusTD[1]);
		TextDrawShowForPlayer(playerid, versusTD[2]);
		PlayerTextDrawShow(playerid, versusPTD[playerid]);
	}
	else 
	{
		TextDrawHideForPlayer(playerid, versusTD[0]);
		TextDrawHideForPlayer(playerid, versusTD[1]);
		TextDrawHideForPlayer(playerid, versusTD[2]);
		PlayerTextDrawHide(playerid, versusPTD[playerid]);

		destroyVersusPTD(playerid);
	}
	versusTDShown[playerid] = show;
	return 1;
}
//==============================================================================//