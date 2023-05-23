//==============================================================================//
/*
	* Module: ingame_td.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
//==============================================================================//
createInGamePTD(playerid)
{
/*	inGamePTD[playerid][0] = CreatePlayerTextDraw(playerid, 513.333312, 314.288970, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, inGamePTD[playerid][0], 67.000000, 70.000000);
	PlayerTextDrawAlignment(playerid, inGamePTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, inGamePTD[playerid][0], 170);
	PlayerTextDrawSetShadow(playerid, inGamePTD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, inGamePTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, inGamePTD[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, inGamePTD[playerid][0], 0);

	inGamePTD[playerid][1] = CreatePlayerTextDraw(playerid, 513.333557, 314.288909, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, inGamePTD[playerid][1], 2.000000, 70.000000);
	PlayerTextDrawAlignment(playerid, inGamePTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, inGamePTD[playerid][1], -176078166);
	PlayerTextDrawSetShadow(playerid, inGamePTD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, inGamePTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, inGamePTD[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, inGamePTD[playerid][1], 0);

	inGamePTD[playerid][2] = CreatePlayerTextDraw(playerid, 578.666809, 314.288848, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, inGamePTD[playerid][2], 2.000000, 70.000000);
	PlayerTextDrawAlignment(playerid, inGamePTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, inGamePTD[playerid][2], -176078166);
	PlayerTextDrawSetShadow(playerid, inGamePTD[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, inGamePTD[playerid][2], 255);
	PlayerTextDrawFont(playerid, inGamePTD[playerid][2], 4);
	PlayerTextDrawSetProportional(playerid, inGamePTD[playerid][2], 0);

	inGamePTD[playerid][3] = CreatePlayerTextDraw(playerid, 518.333312, 317.192596, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, inGamePTD[playerid][3], 56.000000, 13.000000);
	PlayerTextDrawAlignment(playerid, inGamePTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, inGamePTD[playerid][3], -176078166);
	PlayerTextDrawSetShadow(playerid, inGamePTD[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, inGamePTD[playerid][3], 255);
	PlayerTextDrawFont(playerid, inGamePTD[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, inGamePTD[playerid][3], 0);

	inGamePTD[playerid][4] = CreatePlayerTextDraw(playerid, 518.333251, 333.785247, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, inGamePTD[playerid][4], 56.000000, 13.000000);
	PlayerTextDrawAlignment(playerid, inGamePTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, inGamePTD[playerid][4], -176078166);
	PlayerTextDrawSetShadow(playerid, inGamePTD[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, inGamePTD[playerid][4], 255);
	PlayerTextDrawFont(playerid, inGamePTD[playerid][4], 4);
	PlayerTextDrawSetProportional(playerid, inGamePTD[playerid][4], 0);

	inGamePTD[playerid][5] = CreatePlayerTextDraw(playerid, 518.333190, 350.377960, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, inGamePTD[playerid][5], 56.000000, 13.000000);
	PlayerTextDrawAlignment(playerid, inGamePTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, inGamePTD[playerid][5], -176078166);
	PlayerTextDrawSetShadow(playerid, inGamePTD[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, inGamePTD[playerid][5], 255);
	PlayerTextDrawFont(playerid, inGamePTD[playerid][5], 4);
	PlayerTextDrawSetProportional(playerid, inGamePTD[playerid][5], 0);

	inGamePTD[playerid][6] = CreatePlayerTextDraw(playerid, 518.333190, 367.385437, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, inGamePTD[playerid][6], 56.000000, 13.000000);
	PlayerTextDrawAlignment(playerid, inGamePTD[playerid][6], 1);
	PlayerTextDrawColor(playerid, inGamePTD[playerid][6], -176078166);
	PlayerTextDrawSetShadow(playerid, inGamePTD[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, inGamePTD[playerid][6], 255);
	PlayerTextDrawFont(playerid, inGamePTD[playerid][6], 4);
	PlayerTextDrawSetProportional(playerid, inGamePTD[playerid][6], 0);

	inGamePTD[playerid][7] = CreatePlayerTextDraw(playerid, 519.999877, 318.177764, "KILLS:");
	PlayerTextDrawLetterSize(playerid, inGamePTD[playerid][7], 0.141333, 1.010962);
	PlayerTextDrawAlignment(playerid, inGamePTD[playerid][7], 1);
	PlayerTextDrawColor(playerid, inGamePTD[playerid][7], 255);
	PlayerTextDrawSetShadow(playerid, inGamePTD[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, inGamePTD[playerid][7], 255);
	PlayerTextDrawFont(playerid, inGamePTD[playerid][7], 2);
	PlayerTextDrawSetProportional(playerid, inGamePTD[playerid][7], 1);

	inGamePTD[playerid][8] = CreatePlayerTextDraw(playerid, 541.999572, 318.177764, "0");
	PlayerTextDrawLetterSize(playerid, inGamePTD[playerid][8], 0.141333, 1.010962);
	PlayerTextDrawAlignment(playerid, inGamePTD[playerid][8], 1);
	PlayerTextDrawColor(playerid, inGamePTD[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, inGamePTD[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, inGamePTD[playerid][8], 255);
	PlayerTextDrawFont(playerid, inGamePTD[playerid][8], 2);
	PlayerTextDrawSetProportional(playerid, inGamePTD[playerid][8], 1);

	inGamePTD[playerid][9] = CreatePlayerTextDraw(playerid, 519.999938, 334.355560, "DEATHS:");
	PlayerTextDrawLetterSize(playerid, inGamePTD[playerid][9], 0.141333, 1.010962);
	PlayerTextDrawAlignment(playerid, inGamePTD[playerid][9], 1);
	PlayerTextDrawColor(playerid, inGamePTD[playerid][9], 255);
	PlayerTextDrawSetShadow(playerid, inGamePTD[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, inGamePTD[playerid][9], 255);
	PlayerTextDrawFont(playerid, inGamePTD[playerid][9], 2);
	PlayerTextDrawSetProportional(playerid, inGamePTD[playerid][9], 1);

	inGamePTD[playerid][10] = CreatePlayerTextDraw(playerid, 549.332885, 334.770385, "0");
	PlayerTextDrawLetterSize(playerid, inGamePTD[playerid][10], 0.141333, 1.010962);
	PlayerTextDrawAlignment(playerid, inGamePTD[playerid][10], 1);
	PlayerTextDrawColor(playerid, inGamePTD[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, inGamePTD[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, inGamePTD[playerid][10], 255);
	PlayerTextDrawFont(playerid, inGamePTD[playerid][10], 2);
	PlayerTextDrawSetProportional(playerid, inGamePTD[playerid][10], 1);

	inGamePTD[playerid][11] = CreatePlayerTextDraw(playerid, 520.666625, 351.363006, "SPREE:");
	PlayerTextDrawLetterSize(playerid, inGamePTD[playerid][11], 0.141333, 1.010962);
	PlayerTextDrawAlignment(playerid, inGamePTD[playerid][11], 1);
	PlayerTextDrawColor(playerid, inGamePTD[playerid][11], 255);
	PlayerTextDrawSetShadow(playerid, inGamePTD[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, inGamePTD[playerid][11], 255);
	PlayerTextDrawFont(playerid, inGamePTD[playerid][11], 2);
	PlayerTextDrawSetProportional(playerid, inGamePTD[playerid][11], 1);

	inGamePTD[playerid][12] = CreatePlayerTextDraw(playerid, 540.999511, 351.362915, "0");
	PlayerTextDrawLetterSize(playerid, inGamePTD[playerid][12], 0.141333, 1.010962);
	PlayerTextDrawAlignment(playerid, inGamePTD[playerid][12], 1);
	PlayerTextDrawColor(playerid, inGamePTD[playerid][12], -1);
	PlayerTextDrawSetShadow(playerid, inGamePTD[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, inGamePTD[playerid][12], 255);
	PlayerTextDrawFont(playerid, inGamePTD[playerid][12], 2);
	PlayerTextDrawSetProportional(playerid, inGamePTD[playerid][12], 1);

	inGamePTD[playerid][13] = CreatePlayerTextDraw(playerid, 521.000000, 367.955627, "RATIO");
	PlayerTextDrawLetterSize(playerid, inGamePTD[playerid][13], 0.141333, 1.010962);
	PlayerTextDrawAlignment(playerid, inGamePTD[playerid][13], 1);
	PlayerTextDrawColor(playerid, inGamePTD[playerid][13], 255);
	PlayerTextDrawSetShadow(playerid, inGamePTD[playerid][13], 0);
	PlayerTextDrawBackgroundColor(playerid, inGamePTD[playerid][13], 255);
	PlayerTextDrawFont(playerid, inGamePTD[playerid][13], 2);
	PlayerTextDrawSetProportional(playerid, inGamePTD[playerid][13], 1);

	inGamePTD[playerid][14] = CreatePlayerTextDraw(playerid, 539.666198, 367.955596, "0");
	PlayerTextDrawLetterSize(playerid, inGamePTD[playerid][14], 0.141333, 1.010962);
	PlayerTextDrawAlignment(playerid, inGamePTD[playerid][14], 1);
	PlayerTextDrawColor(playerid, inGamePTD[playerid][14], -1);
	PlayerTextDrawSetShadow(playerid, inGamePTD[playerid][14], 0);
	PlayerTextDrawBackgroundColor(playerid, inGamePTD[playerid][14], 255);
	PlayerTextDrawFont(playerid, inGamePTD[playerid][14], 2);
	PlayerTextDrawSetProportional(playerid, inGamePTD[playerid][14], 1);

	inGamePTD[playerid][15] = CreatePlayerTextDraw(playerid, 274.333374, 429.348144, "");
	PlayerTextDrawLetterSize(playerid, inGamePTD[playerid][15], 0.290333, 1.131259);
	PlayerTextDrawAlignment(playerid, inGamePTD[playerid][15], 1);
	PlayerTextDrawColor(playerid, inGamePTD[playerid][15], -176078166);
	PlayerTextDrawSetShadow(playerid, inGamePTD[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, inGamePTD[playerid][15], 1);
	PlayerTextDrawBackgroundColor(playerid, inGamePTD[playerid][15], 255);
	PlayerTextDrawFont(playerid, inGamePTD[playerid][15], 2);
	PlayerTextDrawSetProportional(playerid, inGamePTD[playerid][15], 1);

	inGamePTD[playerid][16] = CreatePlayerTextDraw(playerid, 558.666442, 22.014823, "Solvine DM");
	PlayerTextDrawLetterSize(playerid, inGamePTD[playerid][16], 0.290333, 1.131259);
	PlayerTextDrawAlignment(playerid, inGamePTD[playerid][16], 1);
	PlayerTextDrawColor(playerid, inGamePTD[playerid][16], -176078166);
	PlayerTextDrawSetShadow(playerid, inGamePTD[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, inGamePTD[playerid][16], 1);
	PlayerTextDrawBackgroundColor(playerid, inGamePTD[playerid][16], 255);
	PlayerTextDrawFont(playerid, inGamePTD[playerid][16], 2);
	PlayerTextDrawSetProportional(playerid, inGamePTD[playerid][16], 1);*/

	inGamePTD[playerid][17] = CreatePlayerTextDraw(playerid, 553.666381, 31.970378, "DEATHMATCH_SERVER");
	PlayerTextDrawLetterSize(playerid, inGamePTD[playerid][17], 0.093666, 0.699852);
	PlayerTextDrawAlignment(playerid, inGamePTD[playerid][17], 1);
	PlayerTextDrawColor(playerid, inGamePTD[playerid][17], -1);
	PlayerTextDrawSetShadow(playerid, inGamePTD[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, inGamePTD[playerid][17], 1);
	PlayerTextDrawBackgroundColor(playerid, inGamePTD[playerid][17], 255);
	PlayerTextDrawFont(playerid, inGamePTD[playerid][17], 2);
	PlayerTextDrawSetProportional(playerid, inGamePTD[playerid][17], 1);
	return 1;
}
//=======================================//
destroyInGamePTD(playerid)
{
	PlayerTextDrawDestroy(playerid, inGamePTD[playerid][0]);
	PlayerTextDrawDestroy(playerid, inGamePTD[playerid][1]);
	PlayerTextDrawDestroy(playerid, inGamePTD[playerid][2]);
	PlayerTextDrawDestroy(playerid, inGamePTD[playerid][3]);
	PlayerTextDrawDestroy(playerid, inGamePTD[playerid][4]);
	PlayerTextDrawDestroy(playerid, inGamePTD[playerid][5]);
	PlayerTextDrawDestroy(playerid, inGamePTD[playerid][6]);
	PlayerTextDrawDestroy(playerid, inGamePTD[playerid][7]);
	PlayerTextDrawDestroy(playerid, inGamePTD[playerid][8]);
	PlayerTextDrawDestroy(playerid, inGamePTD[playerid][9]);
	PlayerTextDrawDestroy(playerid, inGamePTD[playerid][10]);
	PlayerTextDrawDestroy(playerid, inGamePTD[playerid][11]);
	PlayerTextDrawDestroy(playerid, inGamePTD[playerid][12]);
	PlayerTextDrawDestroy(playerid, inGamePTD[playerid][13]);
	PlayerTextDrawDestroy(playerid, inGamePTD[playerid][14]);
	PlayerTextDrawDestroy(playerid, inGamePTD[playerid][15]);
	PlayerTextDrawDestroy(playerid, inGamePTD[playerid][16]);
	PlayerTextDrawDestroy(playerid, inGamePTD[playerid][17]);
	return 1;
}
//==============================================================================//
controlInGameTD(playerid, bool:show)
{
	if(show)
	{
		for(new i = 0; i < 18; i++) PlayerTextDrawShow(playerid, inGamePTD[playerid][i]);

		setupInGameTD(playerid);
	}
	else
	{
		for(new i = 0; i < 18; i++) PlayerTextDrawHide(playerid, inGamePTD[playerid][i]);
	}
	inGameTDShown[playerid] = show;
	return 1;
}
//==============================================================================//
//==============================================================================//
setupInGameTD(playerid)
{
	if(EnteredArena[playerid] != -1)
	{
		new string[24];
		format(string, sizeof(string), "%s", getArenaName(EnteredArena[playerid]));
		PlayerTextDrawSetString(playerid, inGamePTD[playerid][0], string);

		format(string, sizeof(string), "~g~~h~%d", SessionInfo[playerid][sessionKills]);
		PlayerTextDrawSetString(playerid, inGamePTD[playerid][8], string);
		format(string, sizeof(string), "~b~%d", SessionInfo[playerid][sessionDeaths]);
		PlayerTextDrawSetString(playerid, inGamePTD[playerid][10], string);
		if(SessionInfo[playerid][sessionDeaths] > 0)
		{
			format(string, sizeof(string), "~b~~h~~h~%0.1f", floatdiv(SessionInfo[playerid][sessionKills], SessionInfo[playerid][sessionDeaths]));
			PlayerTextDrawSetString(playerid, inGamePTD[playerid][14], string);
		}
		else
		{
			PlayerTextDrawSetString(playerid, inGamePTD[playerid][14], "~b~~h~~h~0");
		}

		format(string, sizeof(string), "~p~~h~%d", SessionInfo[playerid][sessionKS]);
		PlayerTextDrawSetString(playerid, inGamePTD[playerid][12], string);
	}
	else
	{

		new string[24];
		format(string, sizeof(string), "~g~~h~%d", PI[playerid][pKills]);
		PlayerTextDrawSetString(playerid, inGamePTD[playerid][8], string);
		format(string, sizeof(string), "~b~%d", PI[playerid][pDeaths]);
		PlayerTextDrawSetString(playerid, inGamePTD[playerid][10], string);
		if(PI[playerid][pDeaths] > 0)
		{
			format(string, sizeof(string), "~b~~h~~h~%0.1f", floatdiv(PI[playerid][pKills], PI[playerid][pDeaths]));
			PlayerTextDrawSetString(playerid, inGamePTD[playerid][14], string);
		}
		else
		{
			PlayerTextDrawSetString(playerid, inGamePTD[playerid][14], "~b~~h~~h~0");
		}
		format(string, sizeof(string), "~p~~h~%d", KS[playerid]);
		PlayerTextDrawSetString(playerid, inGamePTD[playerid][12], string);
	}
	SetPlayerScore(playerid, PI[playerid][pKills]);
	return 1;
}
//==============================================================================//
