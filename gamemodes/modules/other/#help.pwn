//==============================================================================//
/*
	* Module: #help.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
CMD:help(playerid)
{
	new str[72];
	format(str, sizeof(str), "~r~~h~(HELP)~w~ Player %s has just used command. ~r~~h~(/help)", GetName(playerid));
	foreach(new i:Player)
	{
		if(Spawned[i])
		{
			if(WarnChat[i] && PI[i][pAdmin] == 1)
			{
				if(!isAltChatToggled(i)) toggleAltChat(i);
				sendAltChatMessage(i, str);
			}
		}
	}
	showHelpList(playerid, 1);

	return 1;
}
//==============================================================================//
showHelpList(playerid, page)
{
	switch(page)
	{
		case 1:
		{
			ShowPlayerDialog(playerid, HELP_PG1, DIALOG_STYLE_LIST, ""SERVER"Solvine:Deathmatch > "WHITE"Help [Page 1]", "\
				"SERVER"> "WHITE"DM Arena - "GRAY"Help with DM arena.\n\
				"SERVER"> "WHITE"Discord - "GRAY"Help with discord.\n\
				"SERVER"> "WHITE"Duel - "GRAY"Help with duel.\n\
				"SERVER"> "WHITE"PM - "GRAY"Help with private messages.\n\
				"SERVER"> "WHITE"Report - "GRAY"Help with report system.\n\
				"SERVER"> "WHITE"Rank - "GRAY"Help with rank system.\n\
				"SERVER"> "WHITE"Versus - "GRAY"Help with versus event.\n\
				"SERVER"> "WHITE"Other 1 - "GRAY"Some other commands [1]\n\
				"SERVER"> "WHITE"Other 2 - "GRAY"Some other commands [2]\n\
				"SERVER"> "WHITE"Admin - "GRAY"Help with admin commands.\n\
				"RED"> "WHITE"Previous page < < <\n\
				"RED"> "WHITE"Next page > > >\n\
				", "CHOOSE", "CANCEL");
		}
	}
	return 1;
}
//==============================================================================//
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		//======================================================================//
		case HELP_PG1:
		{
			if(!response) return 1;
			if(response)
			{
				switch(listitem)
				{
					case 0://DM
					{
						ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_LIST, ""SERVER"Solvine:Deathmatch > "WHITE"Help [DM]", "\
							"SERVER"> "WHITE"/dm - "GRAY"Use to join DM arena.\n\
							"SERVER"> "WHITE"/dmlist - "GRAY"Use to see every areana created.\n\
							", "OKAY", "");
					}
					case 1://Discord
					{
						ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_LIST, ""SERVER"Solvine:Deathmatch > "WHITE"Help [Discord]", "\
							"SERVER"> "WHITE"/discord - "GRAY"Description\n\
							", "OKAY", "");
					}
					case 2://Duel
					{
						ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_LIST, ""SERVER"Solvine:Deathmatch > "WHITE"Help [Duel]", "\
							"SERVER"> "WHITE"/duel - "GRAY"Description\n\
							", "OKAY", "");
					}
					case 3://PM
					{
						ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_LIST, ""SERVER"Solvine:Deathmatch > "WHITE"Help [PM]", "\
							"SERVER"> "WHITE"/togpm - "GRAY"Description\n\
							"SERVER"> "WHITE"/pm - "GRAY"Description\n\
							"SERVER"> "WHITE"/r - "GRAY"Description\n\
							", "OKAY", "");
					}
					case 4://Report
					{
						ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_LIST, ""SERVER"Solvine:Deathmatch > "WHITE"Help [Report]", "\
							"SERVER"> "WHITE"/report - "GRAY"Description\n\
							"SERVER"> "WHITE"/reportlist - "GRAY"Description\n\
							", "OKAY", "");
					}
					case 5://Rank
					{
						ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_LIST, ""SERVER"Solvine:Deathmatch > "WHITE"Help [Rank]", "\
							"SERVER"> "WHITE"/ranklist - "WHITE"Description\n\
							"SERVER"> "WHITE"1 DM Arena kill - "GREEN"+1.0 point\n\
							"SERVER"> "WHITE"1 DM Arena death - "RED"-0.5 point\n\
							"SERVER"> "WHITE"1 duel win - "GREEN"+1.0 point\n\
							"SERVER"> "WHITE"1 duel defeat - "RED"-0.5 point\n\
							"SERVER"> "WHITE"1 versus win - "GREEN"+1.0 point\n\
							"SERVER"> "WHITE"1 DoTD defeat - "RED"-2.5 point\n\
							"SERVER"> "WHITE"1 DoTM win - "GREEN"+5.0 point\n\
							", "OKAY", "");
					}
					case 6://Verus
					{
						ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_LIST, ""SERVER"Solvine:Deathmatch > "WHITE"Help [Versus]", "\
							"SERVER"> "WHITE"/versus - "GRAY"Description\n\
							"SERVER"> "WHITE"/versuslist - "GRAY"Description\n\
							", "OKAY", "");
					}
					case 7://Other 1
					{
						ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_LIST, ""SERVER"Solvine:Deathmatch > "WHITE"Help [Other 1]", "\
							"SERVER"> "WHITE"/uptime - "GRAY"Description\n\
							"SERVER"> "WHITE"/forum - "GRAY"Description\n\
							"SERVER"> "WHITE"/update - "GRAY"Description\n\
							"SERVER"> "WHITE"/credits - "GRAY"Description\n\
							"SERVER"> "WHITE"/rules - "GRAY"Description\n\
							"SERVER"> "WHITE"/bug - "GRAY"Description\n\
							", "OKAY", "");
					}
					case 8://Other 2
					{
						ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_LIST, ""SERVER"Solvine:Deathmatch > "WHITE"Help [Other 2]", "\
							"SERVER"> "WHITE"/lastseen - "GRAY"Description\n\
							"SERVER"> "WHITE"/id - "GRAY"Description\n\
							"SERVER"> "WHITE"/fps - "GRAY"Description\n\
							"SERVER"> "WHITE"/pl - "GRAY"Description\n\
							"SERVER"> "WHITE"/admins - "GRAY"Description\n\
							"SERVER"> "WHITE"/lobby - "GRAY"Description\n\
							"SERVER"> "WHITE"/leaderboard - "GRAY"Description\n\
							"SERVER"> "WHITE"/changecolor - "GRAY"Description\n\
							"SERVER"> "WHITE"/skin - "GRAY"Description\n\
							"SERVER"> "WHITE"/toghud - "GRAY"Description\n\
							"SERVER"> "WHITE"/stats - "GRAY"Description\n\
							", "OKAY", "");
					}
					case 9:// Admin
					{
						if(PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
						ShowAdminHelp(playerid, 1);
					}
					case 10:// >>
					{ 
						InfoMessage(playerid, "You cant go to right anymore.");
					}
					case 11:// <<
					{
						InfoMessage(playerid, "You cant go to left anymore.");
					}
				}
			}
			return 1;
		}
		//======================================================================//
		case HELP_PG2:
		{
			if(!response) return 1;
			if(response)
			{

			}
			return 1;
		}
		//======================================================================//
	}
	
	#if defined help_OnDialogResponse
		return help_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnDialogResponse
	#undef OnDialogResponse
#else
	#define _ALS_OnDialogResponse
#endif

#define OnDialogResponse help_OnDialogResponse
#if defined help_OnDialogResponse
	forward help_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif
//==============================================================================//
