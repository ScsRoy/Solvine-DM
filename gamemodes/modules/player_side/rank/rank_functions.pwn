//==============================================================================//
/*
	* Module: rank_functions.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
function mySQL_LoadRanks()
{
	new rows;
	cache_get_row_count(rows);

	for(new id = 0; id < rows; id++) 
	{
		mySQL_LoadRank(id);
	}

	createRank(0, "Newbie", 100, 1000);
	createRank(1, "Trainee", 500, 5000);
	createRank(2, "Average", 1000, 10000);
	createRank(3, "Master", 10000, 100000);
	createRank(4, "Legend", 50000, 500000);
	createRank(5, "God", 100000, 1000000);

	printf("> mySQL // Ranks successfully loaded. Total: %d.", rows);
	return 1;
}
//=======================================//
function mySQL_LoadRank(row)
{
	new id = Iter_Free(RankList);
	if(id == -1) return printf("> mySQL // There is failure in loading rank. Limit exceeded.");

	cache_get_value_int(row, "rankID", RankInfo[id][rankID]);
	cache_get_value(row, "rankName", RankInfo[id][rankName], 24);
	cache_get_value_int(row, "rankPoint", RankInfo[id][rankPoint]);
	cache_get_value_int(row, "rankReward", RankInfo[id][rankReward]);

	Iter_Add(RankList, id);
	return 1;
}
//=======================================//
createRank(id, name[], point, reward)
{
	if(Iter_Contains(RankList, id)) return 0;
	new free = Iter_Free(RankList);
	if(free != id)
		id = free;

	RankInfo[id][rankID] = id;
	strmid(RankInfo[id][rankName], name, 0, strlen(name));
	RankInfo[id][rankPoint] = point;
	RankInfo[id][rankReward] = reward;

	static query[160];
	mysql_format(DB, query, sizeof(query), "INSERT INTO "RANK_DB" SET `rankID`=%d, `rankName`='%s', `rankPoint`=%d, `rankReward`=%d", id, name, point, reward);
	mysql_tquery(DB, query);

	Iter_Add(RankList, id);
	printf("> mySQL // Created new rank (%d).", id);
	return 1;
}
//==============================================================================//
getRankName(id)
{
	new name[24];
	if(!Iter_Contains(RankList, id)) strmid(name, "Solvine DM", 0, strlen("Solvine DM"));
	else strmid(name, RankInfo[id][rankName], 0, strlen(RankInfo[id][rankName]));
	return name;
}
//=======================================//
checkRankPoint(playerid)
{
	new Float:points = calculateRankPoints(playerid);

	mysql_tquery(DB, "SELECT `rankID`, `rankPoint` FROM "RANK_DB" ORDER BY `rankPoint` DESC", "onPlayerCheckRankPoints", "if", playerid, points);
	return 1;
}
//=======================================//
function onPlayerCheckRankPoints(playerid, Float:points)
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		new id, rank_points;
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name_int(i, "rankID", id);
			cache_get_value_name_int(i, "rankPoint", rank_points);
			if(points >= rank_points && PI[playerid][pRank] != id)
			{
				onPlayerRankUp(playerid, id);
				break;
			}

			if(PI[playerid][pRank] == id && points < rank_points)
			{
				onPlayerRankDown(playerid, id);
				break;
			}
		}
	}
	return 1;
}
//=======================================//
onPlayerRankUp(playerid, rank)
{
	new string[72], dialog[256];
	strcat(dialog, ""SERVER"________________________________\n\n");
	format(string, sizeof(string), ""SERVER"> "WHITE"Congratulations %s on rank up.\n\n", GetName(playerid));
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Your new rank is %s\n\n", RankInfo[rank][rankName]);
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Your reward for that is %d$.\n\n", RankInfo[rank][rankReward]);
	strcat(dialog, string);
	strcat(dialog, ""SERVER"________________________________\n\n");

	PI[playerid][pRank] = rank;
	mySQL_UpdatePlayerCustomVal(playerid, "pRank", rank);

	ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_MSGBOX, ""SERVER"Solvine Deathmatch > "WHITE"Rank UP", dialog, "OKAY", "");
	AC_GiveMoney(playerid, RankInfo[rank][rankReward]);
	return 1;
}
//=======================================//
onPlayerRankDown(playerid, rank)
{
	new string[72], dialog[256];
	strcat(dialog, ""SERVER"________________________________\n\n");
	format(string, sizeof(string), ""SERVER"> "WHITE"Sorry %s, but you have just rank down.\n\n", GetName(playerid));
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Your new rank is %s\n\n", RankInfo[rank][rankName]);
	strcat(dialog, string);
	strcat(dialog, ""SERVER"________________________________\n\n");

	PI[playerid][pRank] = rank;
	mySQL_UpdatePlayerCustomVal(playerid, "pRank", rank);

	ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_MSGBOX, ""SERVER"Solvine Deathmatch > "WHITE"Rank DOWN", dialog, "OKAY", "");
	AC_GiveMoney(playerid, -RankInfo[rank][rankReward]);
	return 1;
}
//=======================================//
CMD:ranklist(playerid)
{
	new dialog[256], string[72], x = 0;
	foreach(new i:RankList)
	{
		format(string, sizeof(string), ""SERVER"[%d] "WHITE"%s\t[ %d ]\n", x+1, RankInfo[i][rankName], RankInfo[i][rankPoint]);
		strcat(dialog, string);
		x++;
	}
	if(x == 0) return ErrorMessage(playerid, "Currently, there is no created DM arenas.");
	ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_TABLIST, ""SERVER"Solvine Deathmatch > "WHITE"Arena list", dialog, "OKAY", "");
	return 1;
}
//==============================================================================//
