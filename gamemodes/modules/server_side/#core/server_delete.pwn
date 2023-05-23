//==============================================================================//
/*
	* Module: server_delete.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		//======================================================================//
		case SERVER_DELETE:
		{
			if(!response) return 1;
			if(response)
			{
				switch(listitem)
				{
					case 0://DM Arena
					{
						ShowPlayerDialog(playerid, DELETE_ARENA, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Arena [Delete]", ""ORANGE"> "WHITE"Please, enter ID of arena you want to delete:", "ENTER", "CANCEL");
					}
					case 1://Rank
					{
						ShowPlayerDialog(playerid, DELETE_RANK, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Rank [Delete]", ""SERVER"> "WHITE"Please, enter ID of rank you want to delete:", "ENTER", "CANCEL");
					}
				}
			}
		}
		//======================================================================//
		case DELETE_ARENA:
		{
			if(!response) return 1;
			if(response)
			{
				new id;
				if(sscanf(inputtext, "i", id)) return ShowPlayerDialog(playerid, DELETE_ARENA, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Arena [Delete]", ""ORANGE"> "WHITE"Please, enter ID of arena you want to delete:", "ENTER", "CANCEL");
				if(!Iter_Contains(ArenaList, id)) return ErrorMessage(playerid, "Wrong ID.");

				static query[72];
				Iter_Remove(ArenaList, id);
				mysql_format(DB, query, sizeof(query), "DELETE FROM "ARENA_DB" WHERE `arenaID`=%d", ArenaInfo[id][arenaID]);
				mysql_tquery(DB, query);

				InfoMessage(playerid, "You have successfully deleted arena. (%d)", id);
				Log(delete_log, INFO, "ArenaID (%d) > Admin (%s) > IP (%s)", id, GetName(playerid), GetPlayerIP(playerid));
			}
			return 1;
		}
		//======================================================================//
		case DELETE_RANK:
		{
			if(!response) return 1;
			if(response)
			{
				new id;
				if(sscanf(inputtext, "i", id)) return ShowPlayerDialog(playerid, DELETE_RANK, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Rank [Delete]", ""SERVER"> "WHITE"Please, enter ID of rank you want to delete:", "ENTER", "CANCEL");
				if(!Iter_Contains(RankList, id)) return ErrorMessage(playerid, "Wrong ID.");

				static query[72];
				Iter_Remove(RankList, id);
				mysql_format(DB, query, sizeof(query), "DELETE FROM "RANK_DB" WHERE `rankID`=%d", RankInfo[id][rankID]);
				mysql_tquery(DB, query);

				InfoMessage(playerid, "You have successfully deleted rank. (%d)", id);
				Log(delete_log, INFO, "RankID (%d) > Admin (%s) > IP (%s)", id, GetName(playerid), GetPlayerIP(playerid));
			}
			return 1;
		}
		//======================================================================//
	}
	
	#if defined delete_OnDialogResponse
		return delete_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnDialogResponse
	#undef OnDialogResponse
#else
	#define _ALS_OnDialogResponse
#endif

#define OnDialogResponse delete_OnDialogResponse
#if defined delete_OnDialogResponse
	forward delete_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif
//==============================================================================//
