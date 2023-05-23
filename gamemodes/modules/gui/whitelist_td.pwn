//==============================================================================//
/*
	* Module: whitelist_td.pwn
	* Author: Sule
	* Date: 05.05.2020
*/
//==============================================================================//
createWhitelistTD()
{
	whitelistTD[0] = TextDrawCreate(270.000000, 310.000000, "LD_SPAC:white");
	TextDrawTextSize(whitelistTD[0], 100.000000, 45.000000);
	TextDrawAlignment(whitelistTD[0], 1);
	TextDrawColor(whitelistTD[0], 170);
	TextDrawSetShadow(whitelistTD[0], 0);
	TextDrawBackgroundColor(whitelistTD[0], 255);
	TextDrawFont(whitelistTD[0], 4);
	TextDrawSetProportional(whitelistTD[0], 0);

	whitelistTD[1] = TextDrawCreate(372.500000, 310.000000, "LD_SPAC:white");
	TextDrawTextSize(whitelistTD[1], 100.000000, 45.000000);
	TextDrawAlignment(whitelistTD[1], 1);
	TextDrawColor(whitelistTD[1], 170);
	TextDrawSetShadow(whitelistTD[1], 0);
	TextDrawBackgroundColor(whitelistTD[1], 255);
	TextDrawFont(whitelistTD[1], 4);
	TextDrawSetProportional(whitelistTD[1], 0);

	whitelistTD[2] = TextDrawCreate(167.500000, 310.000000, "LD_SPAC:white");
	TextDrawTextSize(whitelistTD[2], 100.000000, 45.000000);
	TextDrawAlignment(whitelistTD[2], 1);
	TextDrawColor(whitelistTD[2], 170);
	TextDrawSetShadow(whitelistTD[2], 0);
	TextDrawBackgroundColor(whitelistTD[2], 255);
	TextDrawFont(whitelistTD[2], 4);
	TextDrawSetProportional(whitelistTD[2], 0);

	whitelistTD[3] = TextDrawCreate(320.000000, 304.000000, "Status");
	TextDrawLetterSize(whitelistTD[3], 0.378399, 1.039999);
	TextDrawAlignment(whitelistTD[3], 2);
	TextDrawColor(whitelistTD[3], -1819551489);
	TextDrawSetShadow(whitelistTD[3], 0);
	TextDrawSetOutline(whitelistTD[3], 1);
	TextDrawBackgroundColor(whitelistTD[3], 255);
	TextDrawFont(whitelistTD[3], 0);
	TextDrawSetProportional(whitelistTD[3], 1);

	whitelistTD[4] = TextDrawCreate(320.000000, 320.000000, "Whitelisted:~n~~p~~h~320~n~Whitelisted:~n~~p~~h~320~n~");
	TextDrawLetterSize(whitelistTD[4], 0.219999, 0.800000);
	TextDrawTextSize(whitelistTD[4], 0.000000, 572.000000);
	TextDrawAlignment(whitelistTD[4], 2);
	TextDrawColor(whitelistTD[4], -1);
	TextDrawUseBox(whitelistTD[4], 1);
	TextDrawBoxColor(whitelistTD[4], 0);
	TextDrawSetShadow(whitelistTD[4], 0);
	TextDrawBackgroundColor(whitelistTD[4], 255);
	TextDrawFont(whitelistTD[4], 1);
	TextDrawSetProportional(whitelistTD[4], 1);

	whitelistTD[5] = TextDrawCreate(380.000000, 304.000000, "Join");
	TextDrawLetterSize(whitelistTD[5], 0.378399, 1.039999);
	TextDrawAlignment(whitelistTD[5], 1);
	TextDrawColor(whitelistTD[5], -1819551489);
	TextDrawSetShadow(whitelistTD[5], 0);
	TextDrawSetOutline(whitelistTD[5], 1);
	TextDrawBackgroundColor(whitelistTD[5], 255);
	TextDrawFont(whitelistTD[5], 0);
	TextDrawSetProportional(whitelistTD[5], 1);

	whitelistTD[6] = TextDrawCreate(260.000000, 304.000000, "Exit");
	TextDrawLetterSize(whitelistTD[6], 0.378399, 1.039999);
	TextDrawAlignment(whitelistTD[6], 3);
	TextDrawColor(whitelistTD[6], -1819551489);
	TextDrawSetShadow(whitelistTD[6], 0);
	TextDrawSetOutline(whitelistTD[6], 1);
	TextDrawBackgroundColor(whitelistTD[6], 255);
	TextDrawFont(whitelistTD[6], 0);
	TextDrawSetProportional(whitelistTD[6], 1);

	whitelistTD[7] = TextDrawCreate(380.000000, 320.000000, "Use_this_option_to_sign~n~up_for_whitelist.");
	TextDrawLetterSize(whitelistTD[7], 0.219999, 0.800000);
	TextDrawTextSize(whitelistTD[7], 692.000000, 0.000000);
	TextDrawAlignment(whitelistTD[7], 1);
	TextDrawColor(whitelistTD[7], -1);
	TextDrawUseBox(whitelistTD[7], 1);
	TextDrawBoxColor(whitelistTD[7], 0);
	TextDrawSetShadow(whitelistTD[7], 0);
	TextDrawBackgroundColor(whitelistTD[7], 255);
	TextDrawFont(whitelistTD[7], 1);
	TextDrawSetProportional(whitelistTD[7], 1);

	whitelistTD[8] = TextDrawCreate(260.000000, 320.000000, "Use_this_option_to_exit_~n~server_now.");
	TextDrawLetterSize(whitelistTD[8], 0.219999, 0.800000);
	TextDrawTextSize(whitelistTD[8], 572.000000, 0.000000);
	TextDrawAlignment(whitelistTD[8], 3);
	TextDrawColor(whitelistTD[8], -1);
	TextDrawUseBox(whitelistTD[8], 1);
	TextDrawBoxColor(whitelistTD[8], 0);
	TextDrawSetShadow(whitelistTD[8], 0);
	TextDrawBackgroundColor(whitelistTD[8], 255);
	TextDrawFont(whitelistTD[8], 1);
	TextDrawSetProportional(whitelistTD[8], 1);

	whitelistTD[9] = TextDrawCreate(374.200012, 339.800018, "LD_SPAC:white");
	TextDrawTextSize(whitelistTD[9], 96.000000, 13.000000);
	TextDrawAlignment(whitelistTD[9], 1);
	TextDrawColor(whitelistTD[9], -1819551489);
	TextDrawSetShadow(whitelistTD[9], 0);
	TextDrawBackgroundColor(whitelistTD[9], 255);
	TextDrawFont(whitelistTD[9], 4);
	TextDrawSetProportional(whitelistTD[9], 0);

	whitelistTD[10] = TextDrawCreate(169.499969, 339.800018, "LD_SPAC:white");
	TextDrawTextSize(whitelistTD[10], 96.000000, 13.000000);
	TextDrawAlignment(whitelistTD[10], 1);
	TextDrawColor(whitelistTD[10], -1819551489);
	TextDrawSetShadow(whitelistTD[10], 0);
	TextDrawBackgroundColor(whitelistTD[10], 255);
	TextDrawFont(whitelistTD[10], 4);
	TextDrawSetProportional(whitelistTD[10], 0);

	whitelistTD[11] = TextDrawCreate(422.300048, 342.688842, "JOIN_US_NOW");
	TextDrawLetterSize(whitelistTD[11], 0.219999, 0.800000);
	TextDrawTextSize(whitelistTD[11], 13.000000, 90.000000);
	TextDrawAlignment(whitelistTD[11], 2);
	TextDrawColor(whitelistTD[11], -1);
	TextDrawUseBox(whitelistTD[11], 1);
	TextDrawBoxColor(whitelistTD[11], 65280);
	TextDrawSetShadow(whitelistTD[11], 0);
	TextDrawBackgroundColor(whitelistTD[11], 255);
	TextDrawFont(whitelistTD[11], 1);
	TextDrawSetProportional(whitelistTD[11], 1);
	TextDrawSetSelectable(whitelistTD[11], true);

	whitelistTD[12] = TextDrawCreate(217.399841, 342.688842, "EXIT_NOW");
	TextDrawLetterSize(whitelistTD[12], 0.219999, 0.800000);
	TextDrawTextSize(whitelistTD[12], 13.000000, 90.000000);
	TextDrawAlignment(whitelistTD[12], 2);
	TextDrawColor(whitelistTD[12], -1);
	TextDrawUseBox(whitelistTD[12], 1);
	TextDrawBoxColor(whitelistTD[12], 0);
	TextDrawSetShadow(whitelistTD[12], 0);
	TextDrawBackgroundColor(whitelistTD[12], 255);
	TextDrawFont(whitelistTD[12], 1);
	TextDrawSetProportional(whitelistTD[12], 1);
	TextDrawSetSelectable(whitelistTD[12], true);
	return 1;
}
//=======================================//
destroyWhitelistTD()
{
	for(new i = 0; i < 13; i++)
		TextDrawDestroy(whitelistTD[i]);
	return 1;
}
//==============================================================================//
/*controlWhitelistTD(playerid, bool:show)
{
	if(show)
	{
		for(new i = 0; i < 13; i++)
			TextDrawShowForPlayer(playerid, whitelistTD[i]);

		SelectTextDraw(playerid, COL_SERVER);
	}
	else 
	{
		for(new i = 0; i < 13; i++)
			TextDrawHideForPlayer(playerid, whitelistTD[i]);
		
		CancelSelectTextDraw(playerid);
	}
	whitelistTDShown[playerid] = show;
	return 1;
}*/
//==============================================================================//