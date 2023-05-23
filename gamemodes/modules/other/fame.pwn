//==============================================================================//
/*
	* Module: fame_functions.pwn
	* Author: Sule
	* Date: 24.04.2020.
*/
//==============================================================================//
// { 1948.51331, 1980.73779, 1003.9853, 0.000, } NOT USED
// { 1962.46826, 1980.73779, 1003.9853, 0.000, } NOT USED
// { 1976.38428, 1980.73779, 1003.9853, 0.000, } NOT USED
// { 1995.14246, 1980.73779, 1003.9853, 0.000, } NOT USED
// { 2009.03369, 1980.73779, 1003.9853, 0.000, } NOT USED
// { 2022.90515, 1980.73779, 1003.9853, 0.000, } NOT USED
// { 2022.90515, 2019.26379, 1003.9853, 180.0, } NOT USED
// { 2009.03369, 2019.26379, 1003.9853, 180.0, } NOT USED
// { 1995.14246, 2019.26379, 1003.9853, 180.0, } NOT USED
// { 1976.38428, 2019.26379, 1003.9853, 180.0, } NOT USED
// { 1962.46826, 2019.26379, 1003.9853, 180.0, } NOT USED
// { 1948.51331, 2019.26379, 1003.9853, 180.0, } NOT USED
//==============================================================================//
function mySQL_LoadFames()
{
	new rows;
	cache_get_row_count(rows);

	for(new id = 0; id < rows; id++) 
	{
		mySQL_LoadFame(id);
	}
	/*createFame(0, "Suleee", "\
		"SERVER"> "WHITE"Developer\n\
		", 289, 1948.51331, 1980.73779, 1003.9853, 0.000);*/
		
	/*createFame(0, "Tvrdisic", "\
		"SERVER"> "WHITE"Vlasnik\n\
		", 229, 1962.46826, 1980.73779, 1003.9853, 0.000);*/

	printf("> mySQL // Fames successfully loaded. Total: %d.", rows);
	return 1;
}
//=======================================//
function mySQL_LoadFame(row)
{
	new id = Iter_Free(FameList);
	if(id == -1) return printf("> mySQL // There is failure in loading fames. Limit exceeded.");

	cache_get_value_int(row, "fameID", FameInfo[id][fameID]);
	cache_get_value(row, "fameName", FameInfo[id][fameName], 24);
	cache_get_value(row, "fameDescription", FameInfo[id][fameDescription], MAX_DESCRIPTION);
	cache_get_value_int(row, "fameSkin", FameInfo[id][fameSkin]);

	cache_get_value_name_float(row, "fameX", FameInfo[id][fameX]);
	cache_get_value_name_float(row, "fameY", FameInfo[id][fameY]);
	cache_get_value_name_float(row, "fameZ", FameInfo[id][fameZ]);
	cache_get_value_name_float(row, "fameA", FameInfo[id][fameA]);

	CreateFAME(id);
	Iter_Add(FameList, id);
	return 1;
}
//==============================================================================//
stock createFame(id, name[], description[], skin, Float:x, Float:y, Float:z, Float:a)
{
	if(Iter_Contains(FameList, id)) return 0;
	new free = Iter_Free(FameList);
	if(free != id)
		id = free;

	FameInfo[id][fameID] = id;
	strmid(FameInfo[id][fameName], name, 0, strlen(name));
	strmid(FameInfo[id][fameDescription], description, 0, strlen(description));
	FameInfo[id][fameSkin] = skin;
	FameInfo[id][fameX] = x;
	FameInfo[id][fameY] = y;
	FameInfo[id][fameZ] = z;
	FameInfo[id][fameA] = a;

	static query[384];
	mysql_format(DB, query, sizeof(query), "INSERT INTO "FAME_DB" SET `fameID`=%d, `fameName`='%s', `fameDescription`='%s', `fameSkin`=%d, `fameX`=%f, `fameY`=%f, `fameZ`=%f, `fameA`=%f", id, name, description, skin, x, y, z, a);
	mysql_tquery(DB, query);

	CreateFAME(id);
	Iter_Add(FameList, id);
	printf("> mySQL // Created new fame (%d).", id);
	return 1;
}
//==============================================================================//
CreateFAME(id)
{
	new string[96];
	format(string, sizeof(string), "#%d // "WHITE"%s\n"SERVER"More info // "WHITE"/fame %d", id, FameInfo[id][fameName], id);
	Fame3D[id] = CreateDynamic3DTextLabel(string, COL_SERVER, FameInfo[id][fameX], FameInfo[id][fameY], FameInfo[id][fameZ], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	FameActor[id] = CreateDynamicActor(FameInfo[id][fameSkin], FameInfo[id][fameX], FameInfo[id][fameY], FameInfo[id][fameZ], FameInfo[id][fameA], 1, 100, -1 ,-1);
	return 1;
}
//==============================================================================//
CMD:fame(playerid, params[])
{
	new id;
	if(sscanf(params, "i", id)) return UsageMessage(playerid, "fame [ID]");
	if(!Iter_Contains(FameList, id)) return ErrorMessage(playerid, "Wrong ID.");

	new dialog[512], title[48];
	format(dialog, sizeof(dialog), "\
		"SERVER"_________________________"WHITE"_________________________\n\
		%s\n\
		"SERVER"_________________________"WHITE"_________________________\n\
		", FameInfo[id][fameDescription]);
	format(title, sizeof(title), ""SERVER"M:DM > "WHITE"%s", FameInfo[id][fameName]);

	ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_MSGBOX, title, dialog, "OKAY", "");
	return 1;
}
//==============================================================================//