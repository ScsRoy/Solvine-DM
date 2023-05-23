//==============================================================================//
/*
	* Module: alert_td.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
createAlertTD()
{
	alertTD[0] = TextDrawCreate(0.000000, 0.000000, "LD_SPAC:white");
	TextDrawTextSize(alertTD[0], 640.000000, 450.000000);
	TextDrawAlignment(alertTD[0], 1);
	TextDrawColor(alertTD[0], 168430335);
	TextDrawSetShadow(alertTD[0], 0);
	TextDrawBackgroundColor(alertTD[0], 255);
	TextDrawFont(alertTD[0], 4);
	TextDrawSetProportional(alertTD[0], 0);

	alertTD[1] = TextDrawCreate(320.000000, 150.000000, "alert");
	TextDrawLetterSize(alertTD[1], 1.237998, 4.437333);
	TextDrawTextSize(alertTD[1], 0.000000, 10.000000);
	TextDrawAlignment(alertTD[1], 2);
	TextDrawColor(alertTD[1], COL_SERVER);
	TextDrawSetShadow(alertTD[1], 0);
	TextDrawSetOutline(alertTD[1], 1);
	TextDrawBackgroundColor(alertTD[1], 255);
	TextDrawFont(alertTD[1], 3);
	TextDrawSetProportional(alertTD[1], 1);

	alertTD[2] = TextDrawCreate(200.000000, 190.000000, "LD_SPAC:white");
	TextDrawTextSize(alertTD[2], 240.000000, 1.309998);
	TextDrawAlignment(alertTD[2], 1);
	TextDrawColor(alertTD[2], -1);
	TextDrawSetShadow(alertTD[2], 0);
	TextDrawBackgroundColor(alertTD[2], 255);
	TextDrawFont(alertTD[2], 4);
	TextDrawSetProportional(alertTD[2], 0);

	alertTD[3] = TextDrawCreate(180.000000, 273.000000, "LD_SPAC:white");
	TextDrawTextSize(alertTD[3], 280.000000, 1.309998);
	TextDrawAlignment(alertTD[3], 1);
	TextDrawColor(alertTD[3], -1);
	TextDrawSetShadow(alertTD[3], 0);
	TextDrawBackgroundColor(alertTD[3], 255);
	TextDrawFont(alertTD[3], 4);
	TextDrawSetProportional(alertTD[3], 0);

	alertTD[4] = TextDrawCreate(320.000000, 276.000000, "Ako mislite da je doslo do greske,~n~SS ekran (F8), te se zalite na:~n~~w~discord.gg/UuGHpkQpxn");
	TextDrawLetterSize(alertTD[4], 0.244001, 1.210000);
	TextDrawTextSize(alertTD[4], 0.000000, 240.000000);
	TextDrawAlignment(alertTD[4], 2);
	TextDrawColor(alertTD[4], COL_SERVER);
	TextDrawUseBox(alertTD[4], 1);
	TextDrawBoxColor(alertTD[4], 0);
	TextDrawSetShadow(alertTD[4], 0);
	TextDrawSetOutline(alertTD[4], 1);
	TextDrawBackgroundColor(alertTD[4], 255);
	TextDrawFont(alertTD[4], 1);
	TextDrawSetProportional(alertTD[4], 1);
}
//=======================================//
destroyAlertTD()
{
	for(new i = 0 ; i < 5; i++) TextDrawDestroy(alertTD[i]);
	return 1;
}
//==============================================================================//
createAlertPTD(playerid)
{
	alertPTD = CreatePlayerTextDraw(playerid, 320.000000, 193.000000, "...");
	PlayerTextDrawLetterSize(playerid, alertPTD, 0.244001, 1.210000);
	PlayerTextDrawAlignment(playerid, alertPTD, 2);
	PlayerTextDrawColor(playerid, alertPTD, -1);
	PlayerTextDrawSetShadow(playerid, alertPTD, 0);
	PlayerTextDrawSetOutline(playerid, alertPTD, 1);
	PlayerTextDrawBackgroundColor(playerid, alertPTD, 255);
	PlayerTextDrawFont(playerid, alertPTD, 1);
	PlayerTextDrawSetProportional(playerid, alertPTD, 1);
	return 1;
}
//=======================================//
destroyAlertPTD(playerid)
{
	PlayerTextDrawDestroy(playerid, alertPTD);
	return 1;
}
//==============================================================================//
controlAlertTD(playerid, bool:show)
{
	if(show)
	{
		if(alertTDShown[playerid]) return 0;

		createAlertPTD(playerid);
		for(new i = 0; i < 5; i++) TextDrawShowForPlayer(playerid, alertTD[i]);
		PlayerTextDrawShow(playerid, alertPTD);
	}
	else 
	{
		for(new i = 0; i < 5; i++) TextDrawHideForPlayer(playerid, alertTD[i]);
		PlayerTextDrawHide(playerid, alertPTD);
		destroyAlertPTD(playerid);
	}
	return 1;
}
//==============================================================================//