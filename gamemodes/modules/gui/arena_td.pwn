//==============================================================================//
/*
	* Module: arena_td.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
createArenaTD()
{
	arenaTD[0] = TextDrawCreate(272.000030, 399.955444, "box");
	TextDrawLetterSize(arenaTD[0], 0.000000, 4.240988);
	TextDrawTextSize(arenaTD[0], 368.000000, 0.000000);
	TextDrawAlignment(arenaTD[0], 1);
	TextDrawColor(arenaTD[0], -1);
	TextDrawUseBox(arenaTD[0], 1);
	TextDrawBoxColor(arenaTD[0], 170);
	TextDrawSetShadow(arenaTD[0], 0);
	TextDrawBackgroundColor(arenaTD[0], 255);
	TextDrawFont(arenaTD[0], 1);
	TextDrawSetProportional(arenaTD[0], 1);

	arenaTD[1] = TextDrawCreate(377.000030, 399.877624, "box");
	TextDrawLetterSize(arenaTD[1], 0.000000, 4.250984);
	TextDrawTextSize(arenaTD[1], 452.571533, 0.000000);
	TextDrawAlignment(arenaTD[1], 1);
	TextDrawColor(arenaTD[1], -1);
	TextDrawUseBox(arenaTD[1], 1);
	TextDrawBoxColor(arenaTD[1], 170);
	TextDrawSetShadow(arenaTD[1], 0);
	TextDrawBackgroundColor(arenaTD[1], 255);
	TextDrawFont(arenaTD[1], 1);
	TextDrawSetProportional(arenaTD[1], 1);

	arenaTD[2] = TextDrawCreate(186.799987, 399.999816, "box");
	TextDrawLetterSize(arenaTD[2], 0.000000, 4.250984);
	TextDrawTextSize(arenaTD[2], 262.609619, 0.000000);
	TextDrawAlignment(arenaTD[2], 1);
	TextDrawColor(arenaTD[2], -1);
	TextDrawUseBox(arenaTD[2], 1);
	TextDrawBoxColor(arenaTD[2], 170);
	TextDrawSetShadow(arenaTD[2], 0);
	TextDrawBackgroundColor(arenaTD[2], 255);
	TextDrawFont(arenaTD[2], 1);
	TextDrawSetProportional(arenaTD[2], 1);

	arenaTD[3] = TextDrawCreate(320.000000, 391.738250, "Choose_arena");
	TextDrawLetterSize(arenaTD[3], 0.378399, 1.039999);
	TextDrawAlignment(arenaTD[3], 2);
	TextDrawColor(arenaTD[3], COL_SERVER);
	TextDrawSetShadow(arenaTD[3], 0);
	TextDrawSetOutline(arenaTD[3], 1);
	TextDrawBackgroundColor(arenaTD[3], 255);
	TextDrawFont(arenaTD[3], 0);
	TextDrawSetProportional(arenaTD[3], 1);

	arenaTD[4] = TextDrawCreate(272.000000, 425.666687, "LD_SPAC:white");
	TextDrawTextSize(arenaTD[4], 96.000000, 13.000000);
	TextDrawAlignment(arenaTD[4], 1);
	TextDrawColor(arenaTD[4], -1819551574);
	TextDrawSetShadow(arenaTD[4], 0);
	TextDrawBackgroundColor(arenaTD[4], 255);
	TextDrawFont(arenaTD[4], 4);
	TextDrawSetProportional(arenaTD[4], 0);

	arenaTD[5] = TextDrawCreate(320.000000, 428.500030, "JOIN_ARENA");
	TextDrawLetterSize(arenaTD[5], 0.219999, 0.800000);
	TextDrawTextSize(arenaTD[5], 13.000000, 94.000000);
	TextDrawAlignment(arenaTD[5], 2);
	TextDrawColor(arenaTD[5], -1);
	TextDrawUseBox(arenaTD[5], 1);
	TextDrawBoxColor(arenaTD[5], 0);
	TextDrawSetShadow(arenaTD[5], -182);
	TextDrawBackgroundColor(arenaTD[5], 255);
	TextDrawFont(arenaTD[5], 1);
	TextDrawSetProportional(arenaTD[5], 1);
	TextDrawSetSelectable(arenaTD[5], true);

	arenaTD[6] = TextDrawCreate(380.000000, 391.738250, "Weapons");
	TextDrawLetterSize(arenaTD[6], 0.378399, 1.039999);
	TextDrawAlignment(arenaTD[6], 1);
	TextDrawColor(arenaTD[6], COL_SERVER);
	TextDrawSetShadow(arenaTD[6], 0);
	TextDrawSetOutline(arenaTD[6], 1);
	TextDrawBackgroundColor(arenaTD[6], 255);
	TextDrawFont(arenaTD[6], 0);
	TextDrawSetProportional(arenaTD[6], 1);

	arenaTD[7] = TextDrawCreate(260.000000, 391.738250, "Recorders");
	TextDrawLetterSize(arenaTD[7], 0.378399, 1.039999);
	TextDrawAlignment(arenaTD[7], 3);
	TextDrawColor(arenaTD[7], COL_SERVER);
	TextDrawSetShadow(arenaTD[7], 0);
	TextDrawSetOutline(arenaTD[7], 1);
	TextDrawBackgroundColor(arenaTD[7], 255);
	TextDrawFont(arenaTD[7], 0);
	TextDrawSetProportional(arenaTD[7], 1);

	arenaTD[8] = TextDrawCreate(269.700012, 386.299987, "");
	TextDrawTextSize(arenaTD[8], 14.000000, 22.000000);
	TextDrawAlignment(arenaTD[8], 1);
	TextDrawColor(arenaTD[8], -1);
	TextDrawSetShadow(arenaTD[8], 0);
	TextDrawBackgroundColor(arenaTD[8], 1);
	TextDrawFont(arenaTD[8], 5);
	TextDrawSetProportional(arenaTD[8], 0);
	TextDrawSetSelectable(arenaTD[8], true);
	TextDrawSetPreviewModel(arenaTD[8], 1318);
	TextDrawSetPreviewRot(arenaTD[8], 0.000000, 270.000000, 90.000000, 1.000000);

	arenaTD[9] = TextDrawCreate(355.600006, 386.299987, "");
	TextDrawTextSize(arenaTD[9], 14.000000, 22.000000);
	TextDrawAlignment(arenaTD[9], 1);
	TextDrawColor(arenaTD[9], -1);
	TextDrawSetShadow(arenaTD[9], 0);
	TextDrawBackgroundColor(arenaTD[9], 1);
	TextDrawFont(arenaTD[9], 5);
	TextDrawSetProportional(arenaTD[9], 0);
	TextDrawSetSelectable(arenaTD[9], true);
	TextDrawSetPreviewModel(arenaTD[9], 1318);
	TextDrawSetPreviewRot(arenaTD[9], 0.000000, 90.000000, 90.000000, 1.000000);
	return 1;
}
//=======================================//
destroyArenaTD()
{
	TextDrawDestroy(arenaTD[0]);
	TextDrawDestroy(arenaTD[1]);
	TextDrawDestroy(arenaTD[2]);
	TextDrawDestroy(arenaTD[3]);
	TextDrawDestroy(arenaTD[4]);
	TextDrawDestroy(arenaTD[5]);
	TextDrawDestroy(arenaTD[6]);
	TextDrawDestroy(arenaTD[7]);
	TextDrawDestroy(arenaTD[8]);
	return 1;
}
//==============================================================================//
createArenaPTD(playerid)
{
	arenaPTD[playerid][0] = CreatePlayerTextDraw(playerid, 320.000000, 404.000000, "ArenaName~n~Online:_0_/_10");
	PlayerTextDrawLetterSize(playerid, arenaPTD[playerid][0], 0.219999, 0.800000);
	PlayerTextDrawTextSize(playerid, arenaPTD[playerid][0], 0.000000, 632.000000);
	PlayerTextDrawAlignment(playerid, arenaPTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, arenaPTD[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, arenaPTD[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, arenaPTD[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, arenaPTD[playerid][0], -182);
	PlayerTextDrawBackgroundColor(playerid, arenaPTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, arenaPTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, arenaPTD[playerid][0], 1);

	arenaPTD[playerid][1] = CreatePlayerTextDraw(playerid, 380.000000, 404.000000, "Deagle_~n~M4~n~Sawnoff");
	PlayerTextDrawLetterSize(playerid, arenaPTD[playerid][1], 0.219999, 0.800000);
	PlayerTextDrawTextSize(playerid, arenaPTD[playerid][1], 692.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, arenaPTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, arenaPTD[playerid][1], -1);
	PlayerTextDrawUseBox(playerid, arenaPTD[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, arenaPTD[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, arenaPTD[playerid][1], -182);
	PlayerTextDrawBackgroundColor(playerid, arenaPTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, arenaPTD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, arenaPTD[playerid][1], 1);

	arenaPTD[playerid][2] = CreatePlayerTextDraw(playerid, 260.000000, 404.000000, "Player_Name_1_~n~_48_streak_~n~Player_Name_2_~n~40_kills");
	PlayerTextDrawLetterSize(playerid, arenaPTD[playerid][2], 0.219999, 0.800000);
	PlayerTextDrawTextSize(playerid, arenaPTD[playerid][2], 572.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, arenaPTD[playerid][2], 3);
	PlayerTextDrawColor(playerid, arenaPTD[playerid][2], -1);
	PlayerTextDrawUseBox(playerid, arenaPTD[playerid][2], 1);
	PlayerTextDrawBoxColor(playerid, arenaPTD[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, arenaPTD[playerid][2], -182);
	PlayerTextDrawBackgroundColor(playerid, arenaPTD[playerid][2], 255);
	PlayerTextDrawFont(playerid, arenaPTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, arenaPTD[playerid][2], 1);
	return 1;
}
//=======================================//
destroyArenaPTD(playerid)
{
	PlayerTextDrawDestroy(playerid, arenaPTD[playerid][0]);
	PlayerTextDrawDestroy(playerid, arenaPTD[playerid][1]);
	PlayerTextDrawDestroy(playerid, arenaPTD[playerid][2]);
	return 1;
}
//==============================================================================//
controlArenaTD(playerid, bool:show)
{
	if(show)
	{
		if(arenaTDShown[playerid]) return 0;
		
		createArenaPTD(playerid);
		for(new i = 0; i < 10; i++) TextDrawShowForPlayer(playerid, arenaTD[i]);
		for(new i = 0; i < 3; i++) PlayerTextDrawShow(playerid, arenaPTD[playerid][i]);

		SelectTextDraw(playerid, COL_SERVER);
	}
	else 
	{
		for(new i = 0; i < 10; i++) TextDrawHideForPlayer(playerid, arenaTD[i]);
		for(new i = 0; i < 3; i++) PlayerTextDrawHide(playerid, arenaPTD[playerid][i]);
		destroyArenaPTD(playerid);

		CancelSelectTextDraw(playerid);
	}
	arenaTDShown[playerid] = show;
	return 1;
}
//==============================================================================//