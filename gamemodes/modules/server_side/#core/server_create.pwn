//==============================================================================//
/*
	* Module: server_create.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		//======================================================================//
		case SERVER_CREATE:
		{
			switch(listitem)
			{
				case 0://DM Arena
				{
					ShowPlayerDialog(playerid, CREATE_ARENA, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Arena [Create]", ""ORANGE"> "WHITE"Please, enter name of new arena:", "ENTER", "CANCEL");
				}
				case 1://Rank
				{
					ShowPlayerDialog(playerid, CREATE_RANK, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Rank [Create]", ""SERVER"> "WHITE"Please, enter name of new rank:", "ENTER", "CANCEL");
				}
			}
		}
		//======================================================================//
	}
	
	#if defined create_OnDialogResponse
		return create_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnDialogResponse
	#undef OnDialogResponse
#else
	#define _ALS_OnDialogResponse
#endif

#define OnDialogResponse create_OnDialogResponse
#if defined create_OnDialogResponse
	forward create_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif
//==============================================================================//
