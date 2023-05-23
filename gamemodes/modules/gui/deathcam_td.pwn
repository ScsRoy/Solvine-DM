//==============================================================================//
/*
	* Module: deathcam_td.pwn
	* Author: Sule
	* Date: 17.04.2020
*/
//==============================================================================//
createDeathCamTD()
{
	deathCamTD[0] = TextDrawCreate(0.000000, 0.000000, "box");
	TextDrawLetterSize(deathCamTD[0], 0.000000, 10.849996);
	TextDrawTextSize(deathCamTD[0], 640.000000, 0.000000);
	TextDrawAlignment(deathCamTD[0], 1);
	TextDrawColor(deathCamTD[0], -1);
	TextDrawUseBox(deathCamTD[0], 1);
	TextDrawBoxColor(deathCamTD[0], 170);
	TextDrawSetShadow(deathCamTD[0], 0);
	TextDrawBackgroundColor(deathCamTD[0], 255);
	TextDrawFont(deathCamTD[0], 1);
	TextDrawSetProportional(deathCamTD[0], 1);

	deathCamTD[1] = TextDrawCreate(0.000000, 351.555633, "box");
	TextDrawLetterSize(deathCamTD[1], 0.000000, 10.849996);
	TextDrawTextSize(deathCamTD[1], 640.000000, 0.000000);
	TextDrawAlignment(deathCamTD[1], 1);
	TextDrawColor(deathCamTD[1], -1);
	TextDrawUseBox(deathCamTD[1], 1);
	TextDrawBoxColor(deathCamTD[1], 170);
	TextDrawSetShadow(deathCamTD[1], 0);
	TextDrawBackgroundColor(deathCamTD[1], 255);
	TextDrawFont(deathCamTD[1], 1);
	TextDrawSetProportional(deathCamTD[1], 1);

	deathCamTD[2] = TextDrawCreate(320.000000, 27.199989, "death_cam");
	TextDrawLetterSize(deathCamTD[2], 0.400000, 1.600000);
	TextDrawAlignment(deathCamTD[2], 2);
	TextDrawColor(deathCamTD[2], -1819551489);
	TextDrawSetShadow(deathCamTD[2], 0);
	TextDrawBackgroundColor(deathCamTD[2], 255);
	TextDrawFont(deathCamTD[2], 3);
	TextDrawSetProportional(deathCamTD[2], 1);

	deathCamTD[3] = TextDrawCreate(20.000000, 358.000000, "LD_SPAC:white");
	TextDrawTextSize(deathCamTD[3], 1.000000, 80.000000);
	TextDrawAlignment(deathCamTD[3], 1);
	TextDrawColor(deathCamTD[3], -1819551489);
	TextDrawSetShadow(deathCamTD[3], 0);
	TextDrawBackgroundColor(deathCamTD[3], 255);
	TextDrawFont(deathCamTD[3], 4);
	TextDrawSetProportional(deathCamTD[3], 0);

	deathCamTD[4] = TextDrawCreate(220.000000, 358.000000, "LD_SPAC:white");
	TextDrawTextSize(deathCamTD[4], 1.000000, 80.000000);
	TextDrawAlignment(deathCamTD[4], 1);
	TextDrawColor(deathCamTD[4], -1819551489);
	TextDrawSetShadow(deathCamTD[4], 0);
	TextDrawBackgroundColor(deathCamTD[4], 255);
	TextDrawFont(deathCamTD[4], 4);
	TextDrawSetProportional(deathCamTD[4], 0);

	deathCamTD[5] = TextDrawCreate(420.000000, 358.000000, "LD_SPAC:white");
	TextDrawTextSize(deathCamTD[5], 1.000000, 80.000000);
	TextDrawAlignment(deathCamTD[5], 1);
	TextDrawColor(deathCamTD[5], -1819551489);
	TextDrawSetShadow(deathCamTD[5], 0);
	TextDrawBackgroundColor(deathCamTD[5], 255);
	TextDrawFont(deathCamTD[5], 4);
	TextDrawSetProportional(deathCamTD[5], 0);

	deathCamTD[6] = TextDrawCreate(620.000000, 358.000000, "LD_SPAC:white");
	TextDrawTextSize(deathCamTD[6], 1.000000, 80.000000);
	TextDrawAlignment(deathCamTD[6], 1);
	TextDrawColor(deathCamTD[6], -1819551489);
	TextDrawSetShadow(deathCamTD[6], 0);
	TextDrawBackgroundColor(deathCamTD[6], 255);
	TextDrawFont(deathCamTD[6], 4);
	TextDrawSetProportional(deathCamTD[6], 0);

	deathCamTD[7] = TextDrawCreate(35.300048, 374.022308, "");
	TextDrawTextSize(deathCamTD[7], 50.000000, 50.000000);
	TextDrawAlignment(deathCamTD[7], 1);
	TextDrawColor(deathCamTD[7], -1);
	TextDrawSetShadow(deathCamTD[7], 0);
	TextDrawBackgroundColor(deathCamTD[7], 1);
	TextDrawFont(deathCamTD[7], 5);
	TextDrawSetProportional(deathCamTD[7], 0);
	TextDrawSetPreviewModel(deathCamTD[7], 1240);
	TextDrawSetPreviewRot(deathCamTD[7], 0.000000, 0.000000, 0.000000, 1.000000);
	return 1;
}
//=======================================//
destroyDeathCamTD()
{
	for(new i = 0; i < 8; i++)
		TextDrawDestroy(deathCamTD[i]);
	return 1;
}
//==============================================================================//
createDeathCamPTD(playerid)
{
	deathCamPTD[playerid][0] = CreatePlayerTextDraw(playerid, 320.000000, 40.100074, "RESPAWN_IN~n~3~n~2~n~1");
	PlayerTextDrawLetterSize(playerid, deathCamPTD[playerid][0], 0.264499, 1.207998);
	PlayerTextDrawAlignment(playerid, deathCamPTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, deathCamPTD[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, deathCamPTD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, deathCamPTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, deathCamPTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, deathCamPTD[playerid][0], 1);

	deathCamPTD[playerid][1] = CreatePlayerTextDraw(playerid, 100.000000, 377.700469, "HP:_100.0");
	PlayerTextDrawLetterSize(playerid, deathCamPTD[playerid][1], 0.227999, 1.015110);
	PlayerTextDrawAlignment(playerid, deathCamPTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, deathCamPTD[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, deathCamPTD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, deathCamPTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, deathCamPTD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, deathCamPTD[playerid][1], 1);

	deathCamPTD[playerid][2] = CreatePlayerTextDraw(playerid, 100.000000, 405.500335, "Armour:_100.0");
	PlayerTextDrawLetterSize(playerid, deathCamPTD[playerid][2], 0.227999, 1.015110);
	PlayerTextDrawAlignment(playerid, deathCamPTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, deathCamPTD[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, deathCamPTD[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, deathCamPTD[playerid][2], 255);
	PlayerTextDrawFont(playerid, deathCamPTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, deathCamPTD[playerid][2], 1);

	deathCamPTD[playerid][3] = CreatePlayerTextDraw(playerid, 320.000000, 375.000000, "PLAYER:~n~just_Sucoo~n~~n~RANK:~n~Beginner");
	PlayerTextDrawLetterSize(playerid, deathCamPTD[playerid][3], 0.227999, 1.015110);
	PlayerTextDrawAlignment(playerid, deathCamPTD[playerid][3], 2);
	PlayerTextDrawColor(playerid, deathCamPTD[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, deathCamPTD[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, deathCamPTD[playerid][3], 255);
	PlayerTextDrawFont(playerid, deathCamPTD[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, deathCamPTD[playerid][3], 1);

	deathCamPTD[playerid][4] = CreatePlayerTextDraw(playerid, 435.000000, 357.711395, "");
	PlayerTextDrawTextSize(playerid, deathCamPTD[playerid][4], 90.000000, 90.000000);
	PlayerTextDrawAlignment(playerid, deathCamPTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, deathCamPTD[playerid][4], 255);
	PlayerTextDrawSetShadow(playerid, deathCamPTD[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, deathCamPTD[playerid][4], 1);
	PlayerTextDrawFont(playerid, deathCamPTD[playerid][4], 5);
	PlayerTextDrawSetProportional(playerid, deathCamPTD[playerid][4], 0);
	PlayerTextDrawSetPreviewModel(playerid, deathCamPTD[playerid][4], 353);
	PlayerTextDrawSetPreviewRot(playerid, deathCamPTD[playerid][4], 0.000000, 0.000000, 0.000000, 1.604068);

	deathCamPTD[playerid][5] = CreatePlayerTextDraw(playerid, 560.000000, 375.000000, "WEAPON:~n~Smg~n~~n~SESSION:~n~10K_/_20D_/_0.5r");
	PlayerTextDrawLetterSize(playerid, deathCamPTD[playerid][5], 0.227999, 1.015110);
	PlayerTextDrawAlignment(playerid, deathCamPTD[playerid][5], 2);
	PlayerTextDrawColor(playerid, deathCamPTD[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, deathCamPTD[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, deathCamPTD[playerid][5], 255);
	PlayerTextDrawFont(playerid, deathCamPTD[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, deathCamPTD[playerid][5], 1);

	deathCamHP[playerid] = CreatePlayerProgressBar(playerid, 101.000000, 389.000000, 100.000000, 2.500000, COL_SERVER);
	deathCamArmour[playerid] = CreatePlayerProgressBar(playerid, 101.000000, 417.000000, 100.000000, 2.500000, COL_WHITE);
	return 1;
}
//=======================================//
destroyDeathCamPTD(playerid)
{
	for(new i = 0; i < 6; i++)
		PlayerTextDrawDestroy(playerid, deathCamPTD[playerid][i]);

	DestroyPlayerProgressBar(playerid, deathCamHP[playerid]);
	DestroyPlayerProgressBar(playerid, deathCamArmour[playerid]);
	return 1;
}
//==============================================================================//
controlDeathCamTD(playerid, bool:show)
{
	if(show)
	{
		if(deathCamTDShown[playerid]) return 0;

		createDeathCamPTD(playerid);
		for(new i = 0; i < 8; i++)
			TextDrawShowForPlayer(playerid, deathCamTD[i]);
		for(new i = 0; i < 6; i++)
			PlayerTextDrawShow(playerid, deathCamPTD[playerid][i]);

		ShowPlayerProgressBar(playerid, deathCamHP[playerid]);
		ShowPlayerProgressBar(playerid, deathCamArmour[playerid]);
	}
	else 
	{
		for(new i = 0; i < 8; i++)
			TextDrawHideForPlayer(playerid, deathCamTD[i]);
		for(new i = 0; i < 6; i++)
			PlayerTextDrawHide(playerid, deathCamPTD[playerid][i]);

		HidePlayerProgressBar(playerid, deathCamHP[playerid]);
		HidePlayerProgressBar(playerid, deathCamArmour[playerid]);
		destroyDeathCamPTD(playerid);
	}
	deathCamTDShown[playerid] = show;
	return 1;
}
//==============================================================================//