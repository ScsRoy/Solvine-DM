//==============================================================================//
/*
	* Module: premium_commands.pwn
	* Author: Sule
	* Date: 22.04.2020
*/
//==============================================================================//
CMD:premium(playerid)
{
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");

	showPremiumHelp(playerid);
	return 1;
}
alias:premium("ph");
//==============================================================================//
CMD:pc(playerid, params[])
{
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new text[64];
	if(sscanf(params, "s[64]", text)) return UsageMessage(playerid, "pc [Text]");
	new string[96];

	format(string, sizeof(string), "%s: "GREEN"%s", GetName(playerid), text);
	foreach(new i:Player)
		if(PI[i][pPremium] || PI[playerid][pAdmin] > 0)
			SendClientMessageEx(playerid, COL_GREEN, "PC | "WHITE"%s: "GREEN"%s", GetName(playerid), text);
	return 1;
}
//==============================================================================//
CMD:weather(playerid, params[])
{
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");

	new weather;
	if(sscanf(params, "i", weather))
	{
		UsageMessage(playerid, "weataher [Weather]");
		SendClientMessage(playerid, COL_ORANGE, "[Weather] "WHITE"1 - Sun // 2 - Rain // 3 - Storm // 4 - Foggy // 5 - Sandstorm"); 
	}
	if(weather < 1 || weather > 5) return ErrorMessage(playerid, "Weather can not be bigger then 5 or lower then 1.");
	switch(weather) 
	{
		case 1: 
		{
			SetPlayerWeather(playerid, 6); 
			PremiumMessage(playerid, "You have successfully changed your weather to 'sunny'. (%d)", GetName(playerid), weather);
		}
		case 2: 
		{
			SetPlayerWeather(playerid, 16); 
			PremiumMessage(playerid, "You have successfully changed your weather to 'rain'. (%d)", GetName(playerid), weather);
		}
		case 3: 
		{
			SetPlayerWeather(playerid, 8); 
			PremiumMessage(playerid, "You have successfully changed your weather to 'storm'. (%d)", GetName(playerid), weather);
		}
		case 4: 
		{
			SetPlayerWeather(playerid, 9); 
			PremiumMessage(playerid, "You have successfully changed your weather to 'foggy'. (%d)", GetName(playerid), weather);
		}
		case 5: 
		{
			SetPlayerWeather(playerid, 19); 
			PremiumMessage(playerid, "You have successfully changed your weather to 'sandstorm'. (%d)", GetName(playerid), weather);
		}
	}
	return 1;
}
//=======================================//
CMD:time(playerid, params[])
{
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new hour, minute;
	if(sscanf(params, "ii", hour, minute)) return UsageMessage(playerid, "time [Hours] [Minutes]");
	if(hour < 0 || hour > 23) return ErrorMessage(playerid, "Hours can not be bigger then 23 or lower then 0.");
	if(minute < 0 || minute > 59) return ErrorMessage(playerid, "Minutes can not be bigger then 59 or lower then 0.");

	SetPlayerTime(playerid, hour, minute);
	PremiumMessage(playerid, "You have successfully changed your time to %02d:%02d.", hour, minute);
	return 1;
}
//==============================================================================//
CMD:freeroamlist(playerid)
{
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	new dialog[256], str[64], x = 0;

	foreach(new i:Player)
	{
		if(InFreeroam[i])
		{
			format(str, sizeof(str), ""GREEN"> "WHITE"%s (%d)\n", GetName(i), i);
			strcat(dialog, str);
			x++;
		}
	}
	if(x == 0) return ErrorMessage(playerid, "Currently, there is no one in freeroam.");
	ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_LIST, ""SERVER"Solvine Deathmatch > "WHITE"Freeroam", dialog, "OKAY", "");

	return 1;
}
//==============================================================================//
CMD:vehicle(playerid, params[])
{
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in freeroam to use this command.");
	if(IsPlayerInAnyVehicle(playerid)) return ErrorMessage(playerid, "You have to be outside vehicle to spawn vehicle.");

	if(TempVehicle[playerid] == -1)
	{
		new model[32], color1, color2;
		if(sscanf(params, "s[32]ii", model, color1, color2)) return UsageMessage(playerid, "vehicle [Model] [Color 1] [Color 2]");
		if(color1 < 0 || color2 < 0 || color1 > 255 || color2 > 255) return ErrorMessage(playerid, "Color can not be bigger than 255 or smaller than 1.");

		new veh;
		if(IsNumeric(model)) veh = strval(model);
		else veh = GetModelVehicle(model);
		if(veh < 400 || veh > 611) return ErrorMessage(playerid, "Vehicle ID can not be bigger than 611 or smaller than 400.");

		new Float:X, Float:Y, Float:Z, Float:A;
		GetPlayerPos(playerid, X, Y, Z);
		GetPlayerFacingAngle(playerid, A);

		TempVehicle[playerid] = CreateVehicle(veh, X, Y, Z, A, color1, color2, 1200, 0);
		LinkVehicleToInterior(TempVehicle[playerid], GetPlayerInterior(playerid));
		SetVehicleVirtualWorld(TempVehicle[playerid], GetPlayerVirtualWorld(playerid));

		PutPlayerInVehicle(playerid, TempVehicle[playerid], 0);
		InfoMessage(playerid, "Vehicle ID '%d' is created. Model: %d", TempVehicle[playerid], ImeVozila[veh-400]);
	}
	else
	{
		InfoMessage(playerid, "Vehicle ID '%d' is destroyed.", TempVehicle[playerid]);
		DestroyVehicle(TempVehicle[playerid]);
		TempVehicle[playerid] = -1;
	}
	return 1;
}
alias:vehicle("veh");
//==============================================================================//
CMD:attach(playerid)
{
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");

	ShowPlayerDialog(playerid, PREMIUM_OBJECT, DIALOG_STYLE_LIST, ""GREEN"Solvine Deathmatch "WHITE"Premium [Attachment]", "\
		"GREEN"> "WHITE"Remove all object\n\
		"GREEN"> "WHITE"Parrot\n\
		"GREEN"> "WHITE"Torch\n\
		"GREEN"> "WHITE"Dick\n\
		"GREEN"> "WHITE"Dollar\n\
		"GREEN"> "WHITE"Horsehoe\n\
		"GREEN"> "WHITE"Tree\n\
		"GREEN"> "WHITE"Cistern\n\
		"GREEN"> "WHITE"Board\n\
		"GREEN"> "WHITE"Hippo\n\
		", "CHOOSE", "CANCEL");
	return 1;
}
//==============================================================================//
CMD:color(playerid)
{
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");

	ShowPlayerDialog(playerid, PREMIUM_COLOR, DIALOG_STYLE_INPUT, ""GREEN"Solvine Deathmatch > "WHITE"Premium [Color]", ""GREEN"> "WHITE"Please, insert the hex color in RRGGBBAA format\n"GREEN"> "WHITE"FF0000FF / 1278CCFF / CC1212FF", "ENTER", "CANCEL");
	return 1;
}
//==============================================================================//
