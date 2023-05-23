//==============================================================================//
/*
	* Module: premium_functions.pwn
	* Author: Sule
	* Date: 22.04.2020
*/
//==============================================================================//
showPremiumHelp(playerid)
{
	ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_MSGBOX, ""GREEN"Solvine Deathmatch > "WHITE"VIP Panel", "\
		"GREEN"____________________________"WHITE"____________________________\n\n\
		"GREEN"> "WHITE"PREMIUM PANEL\n\n\
		\
		"GREEN"> "WHITE"/premium [/ph] - description\n\
		"GREEN"> "WHITE"/pc - description\n\
		"GREEN"> "WHITE"/weather - description\n\
		"GREEN"> "WHITE"/time - description\n\
		"GREEN"> "WHITE"/freeroamlist - description\n\
		"GREEN"> "WHITE"/vehicle - description\n\
		"GREEN"> "WHITE"/attach - description\n\
		"GREEN"> "WHITE"/color - description\n\
		"GREEN"> "WHITE"/animations - description\n\n\
		"GREEN"> "WHITE"Access to freeroam\n\
		"GREEN"> "WHITE"Bonus points on DoTD & DoTM wins\n\
		"GREEN"> "WHITE"Available slot in all arenas\n\
		"GREEN"____________________________"WHITE"____________________________\n\
		", "OKAY", "");


	return 1;
}
//==============================================================================//
HexToInt(string[]) //DracoBlue
{
	if (string[0] == 0) return 0;
	new i, cur=1, res = 0;
	for (i=strlen(string);i>0;i--) 
	{
		if (string[i-1]<58) res=res+cur*(string[i-1]-48); else res=res+cur*(string[i-1]-65+10);
		cur=cur*16;
	}
	return res;
}
//==============================================================================//
