//==============================================================================//
/*
	* Module: rank_callbacks.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		//======================================================================//
		case CREATE_RANK:
		{
			if(!response) return 1;
			if(response)
			{
				new id = Iter_Free(RankList);
				if(id == -1) 
				{
					ErrorMessage(playerid, "Limit of rank reached, please contact developer.");
					#if USE_DISCORD == true
						DCC_SendChannelMessage(DiscordInfo[owner_log], ">>> Limit reached > RANK.");
					#endif
					return 1;
				}
				new name[24];
				if(sscanf(inputtext, "s[24]", name)) return ShowPlayerDialog(playerid, CREATE_RANK, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Rank [Create]", ""SERVER"> "WHITE"Please, enter name of new rank:", "ENTER", "CANCEL");

				new query[96];
				Iter_Add(RankList, id);
				RankInfo[id][rankID] = id;
				strmid(RankInfo[id][rankName], name, 0, strlen(name));
				mysql_format(DB, query, sizeof(query), "INSERT INTO "RANK_DB" SET `rankID`=%d, `rankName`='%s'", id, name);
				mysql_tquery(DB, query);

				CreatingID[playerid] = id;
				InfoMessage(playerid, "You have successfully entered name for new rank. (%s)", name);
				ShowPlayerDialog(playerid, RANK_INFO, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Rank [Create]", ""SERVER"> "WHITE"Please, enter rank breaking point and reward when you reach this rank:", "ENTER", "");
			} 
			return 1;
		}
		//======================================================================//
		case RANK_INFO:
		{
			if(!response || response)
			{
				new id = CreatingID[playerid], point, reward;
				if(sscanf(inputtext, "ii", point, reward)) return ShowPlayerDialog(playerid, RANK_INFO, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Rank [Create]", ""SERVER"> "WHITE"Please, enter rank breaking point and reward when you reach this rank:", "ENTER", "");
				if(point < 1) return ShowPlayerDialog(playerid, RANK_INFO, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Rank [Create]", ""SERVER"> "WHITE"Please, enter rank breaking point and reward when you reach this rank:", "ENTER", "");
				if(reward < 1) return ShowPlayerDialog(playerid, RANK_INFO, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch> "WHITE"Rank [Create]", ""SERVER"> "WHITE"Please, enter rank breaking point and reward when you reach this rank:", "ENTER", "");

				static query[96];
				RankInfo[id][rankPoint] = point;
				RankInfo[id][rankReward] = reward;
				mysql_format(DB, query, sizeof(query), "UPDATE "RANK_DB" SET `rankPoint`=%d, `rankReward`=%d WHERE `rankID`=%d", point, reward, id);
				mysql_tquery(DB, query);

				CreatingID[playerid] = -1;
				InfoMessage(playerid, "You have successfully entered point (%d) and reward (%d) for new rank.", point, reward);
				InfoMessage(playerid, "You are finished creating new rank. (%d)", id);
			}
			return 1;
		}
		//======================================================================//
	}
	
	#if defined rank_OnDialogResponse
		return rank_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnDialogResponse
	#undef OnDialogResponse
#else
	#define _ALS_OnDialogResponse
#endif

#define OnDialogResponse rank_OnDialogResponse
#if defined rank_OnDialogResponse
	forward rank_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif
//==============================================================================//
