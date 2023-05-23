//==============================================================================//
/*
	* Module: alt_chat.pwn
	* Author: Xunder
	* Date: 12.04.2020
*/
//==============================================================================//
#if !defined MAX_LINES
	#define MAX_LINES 10
#endif
//==============================================================================//
new PlayerText: AltChatTD_Player[MAX_LINES],
	AltChatTD_Text[MAX_PLAYERS][MAX_LINES][128];

//==============================================================================//
sendAltChatMessage(playerid, message[]) 
{
	if(!WarnChat[playerid]) 
		return 0;

	for(new i = 0; i < MAX_LINES; i ++) 
	{
		if(i == MAX_LINES - 1) 
		{
			strmid(AltChatTD_Text[playerid][i], message, 0, 128);
			break;
		}
		strmid(AltChatTD_Text[playerid][i], AltChatTD_Text[playerid][i + 1], 0, 128);
	}

	for(new i = 0; i < MAX_LINES; i ++) 
	{
		PlayerTextDrawSetString(playerid, AltChatTD_Player[i], AltChatTD_Text[playerid][i]);
	}
	return 1;
}
//==============================================================================//
createAltChat(playerid) 
{
	new Float:AltChat_posY = 210.000;

	for(new i = 0; i < MAX_LINES; i ++) 
	{
		AltChatTD_Player[i] = CreatePlayerTextDraw(playerid, 23.000, AltChat_posY, " ");
		PlayerTextDrawLetterSize(playerid, AltChatTD_Player[i], 0.19, 0.85);
		PlayerTextDrawAlignment(playerid, AltChatTD_Player[i], 1);
		PlayerTextDrawColor(playerid, AltChatTD_Player[i], -1);
		PlayerTextDrawSetOutline(playerid, AltChatTD_Player[i], 1);
		PlayerTextDrawBackgroundColor(playerid, AltChatTD_Player[i], 255);
		PlayerTextDrawFont(playerid, AltChatTD_Player[i], 1);
		PlayerTextDrawSetProportional(playerid, AltChatTD_Player[i], 1);

		AltChat_posY += (221.026733 - 210.000);
	}

	WarnChat[playerid] = false;
	clearAltChat(playerid);
	return 1;
}
//==============================================================================//
destroyAltChat(playerid) 
{
	for(new i = 0; i < MAX_LINES; i ++) 
	{
		PlayerTextDrawDestroy(playerid, AltChatTD_Player[i]);
	}
	WarnChat[playerid] = false;
	return 1;
}
//==============================================================================//
toggleAltChat(playerid, bool:toggle = true) 
{
	if(toggle) 
	{
		for(new i = 0; i < MAX_LINES; i ++) 
		{
			PlayerTextDrawShow(playerid, AltChatTD_Player[i]);
		}
	}
	else 
	{
		for(new i = 0; i < MAX_LINES; i ++) 
		{
			PlayerTextDrawHide(playerid, AltChatTD_Player[i]);
		}
	}
	WarnChat[playerid] = toggle;
	return 1;
}
//==============================================================================//
clearAltChat(playerid)
{
	for(new i = 0; i < MAX_LINES; i++)
	{
		sendAltChatMessage(playerid, " "); 
	}
	return 1;
}
//==============================================================================//
isAltChatToggled(playerid) 
{
	if(WarnChat[playerid]) return 1;
	return 0;
}
//==============================================================================//
