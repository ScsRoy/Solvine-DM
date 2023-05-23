//==============================================================================//
/*
	* Module: admin_callbacks.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		//======================================================================//
		case HELP_A1:
		{
			if(!response)
			{
				if(PI[playerid][pAdmin] < 2) return ErrorMessage(playerid, "You can not not continue.");
				ShowAdminHelp(playerid, 2);
			}
			if(response) return 1;
			return 1;
		}
		//=======================================//
		case HELP_A2:
		{
			if(!response)
			{
				if(PI[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You can not not continue.");
				ShowAdminHelp(playerid, 3);
			}
			if(response)
			{
				ShowAdminHelp(playerid, 1);
			}
			return 1;
		}
		//=======================================//
		case HELP_A3:
		{
			if(!response) return 1;
			if(response)
			{
				ShowAdminHelp(playerid, 2);
			}
			return 1;
		}
		//======================================================================//
		case ADMIN_CHAT:
		{
			if(!response) return 1;
			if(response)
			{
				switch(listitem)
				{
					case 0://Warn Chat
					{
						if(WarnChat[playerid])
						{
							AMessage(playerid, "You have successfully "RED"disabled"WHITE" Warn-Chat visibility.");
							WarnChat[playerid] = false;

							toggleAltChat(playerid, false);
						}
						else
						{
							AMessage(playerid, "You have successfully "GREEN"enabled"WHITE" Warn-Chat visibility.");
							WarnChat[playerid] = true;

							toggleAltChat(playerid, true);
						}
					}
					case 1://AC Pregled
					{
						if(ACPreview[playerid])
						{
							AMessage(playerid, "You have successfully "RED"disabled"WHITE" anticheat visibility.");
							ACPreview[playerid] = false;
						}
						else
						{
							AMessage(playerid, "You have successfully "GREEN"enabled"WHITE" anticheat visibility.");
							ACPreview[playerid] = true;
						}
					}
					case 2://Admin Pregled
					{
						if(PI[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not allowed to use this command.");

						if(AdminPreview[playerid])
						{
							AMessage(playerid, "You have successfully "RED"disabled"WHITE" admin-spy visibility.");
							AdminPreview[playerid] = false;
						}
						else
						{
							AMessage(playerid, "You have successfully "GREEN"enabled"WHITE" admin-spy visibility.");
							AdminPreview[playerid] = true;
						}
					}
					case 3://Private Message
					{
						if(PI[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not allowed to use this command.");
						
						if(PMPreview[playerid])
						{
							AMessage(playerid, "You have successfully "RED"disabled"WHITE" pm-spy visibility.");
							PMPreview[playerid] = false;
						}
						else
						{
							AMessage(playerid, "You have successfully "GREEN"enabled"WHITE" pm-spy visibility.");
							PMPreview[playerid] = true;
						}
					}
				}
			}
			return 1;
		}
		//======================================================================//
		/*case ADMIN_CLICK:
		{
			if(!response) return 1;
			if(response)
			{
				new id = ClickedID[playerid];
				switch(listitem)
				{
					case 0://PM
					{
						ShowPlayerDialog(playerid, ADMIN_PM, DIALOG_STYLE_INPUT, ""SERVER"Indo:DM > "WHITE"Panel [PM]", ""SERVER"> "WHITE"Unesite poruku koju zelite poslati igracu...", "ENTER", "CANCEL");
					}
					case 1://Kick
					{
						ShowPlayerDialog(playerid, ADMIN_KICK, DIALOG_STYLE_INPUT, ""SERVER"Indo:DM > "WHITE"Panel [Kick]", ""SERVER"> "WHITE"Unesite razlog zbog kojeg zelite kikovati igraca...", "ENTER", "CANCEL");
					}
					case 2://Goto
					{
						new params[8];
						format(params, sizeof(params), "%d", id);
						callcmd::goto(playerid, params);
					}
					case 3://Slap
					{
						new params[8];
						format(params, sizeof(params), "%d", id);
						callcmd::slap(playerid, params);
					}
					case 4://Freeze
					{
						ShowPlayerDialog(playerid, ADMIN_FREEZE, DIALOG_STYLE_MSGBOX, ""SERVER"Indo:DM > "WHITE"Panel [Freeze]", ""SERVER"> "WHITE"Da li zelite freezovati ili unfreezovati igraca...", "FREEZE", "UNFREEZE");
					}
					case 5://Spectate
					{
						new params[8];
						format(params, sizeof(params), "%d", id);
						callcmd::spec(playerid, params);
					}
					case 6://Mute
					{
						ShowPlayerDialog(playerid, ADMIN_MUTE, DIALOG_STYLE_INPUT, ""SERVER"Indo:DM > "WHITE"Panel [Mute]", ""SERVER"> "WHITE"Unesite vrijeme i razlog zbog kojeg zelite mutirati igraca...", "ENTER", "UNMUTE");
					}
					case 7://Ban
					{
						ShowPlayerDialog(playerid, ADMIN_BAN, DIALOG_STYLE_INPUT, ""SERVER"Indo:DM > "WHITE"Panel [Ban]", ""SERVER"> "WHITE"Unesite razlog zbog kojeg zelite banovati igraca...", "ENTER", "CANCEL");
					}
					case 8://Spawn
					{
						new params[8];
						format(params, sizeof(params), "%d", id);
						callcmd::spawn(playerid, params);
					}
					case 9://Jail
					{
						ShowPlayerDialog(playerid, ADMIN_JAIL, DIALOG_STYLE_INPUT, ""SERVER"Indo:DM > "WHITE"Panel [Jail]", ""SERVER"> "WHITE"Unesite vrijeme i razlog zbog kojeg zelite jailovati igraca...", "ENTER", "CANCEL");
					}
					case 10://Isolate
					{
						AMessage(playerid, "Trenutno ova komanda nije u funkciji!");
					}
					case 11://Warn
					{
						ShowPlayerDialog(playerid, ADMIN_WARN, DIALOG_STYLE_INPUT, ""SERVER"Indo:DM > "WHITE"Panel [Warn]", ""SERVER"> "WHITE"Unesite razlog zbog kojeg zelite upozoriti igraca...", "ENTER", "CANCEL");
					}
					case 12://Get
					{
						new params[8];
						format(params, sizeof(params), "%d", id);
						callcmd::get(playerid, params);
					}
					case 13://Kill
					{
						new params[8];
						format(params, sizeof(params), "%d", id);
						callcmd::kill(playerid, params);
					}
					case 14://Explode
					{
						new params[8];
						format(params, sizeof(params), "%d", id);
						callcmd::explode(playerid, params);
					}
				}
			}
			return 1;
		}
		//======================================================================//
		case ADMIN_PM:
		{
			if(!response) return 1;
			if(response)
			{
				new msg[72], id = ClickedID[playerid];
				if(sscanf(inputtext, "s[72]", msg)) return ShowPlayerDialog(playerid, ADMIN_PM, DIALOG_STYLE_INPUT, ""SERVER"Indo:DM > "WHITE"Panel [PM]", ""SERVER"> "WHITE"Unesite poruku koju zelite poslati igracu...", "ENTER", "CANCEL");

				new params[72+2];
				format(params, sizeof(params), "%d %s", id, msg);
				callcmd::amsg(playerid, params);
			}
			return 1;
		}
		//=======================================//
		case ADMIN_KICK:
		{
			if(!response) return 1;
			if(response)
			{
				new reason[32], id = ClickedID[playerid];
				if(sscanf(inputtext, "s[32]", reason)) return ShowPlayerDialog(playerid, ADMIN_KICK, DIALOG_STYLE_INPUT, ""SERVER"Indo:DM > "WHITE"Panel [Kick]", ""SERVER"> "WHITE"Unesite razlog zbog kojeg zelite kikovati igraca...", "ENTER", "CANCEL");

				new params[32+2];
				format(params, sizeof(params), "%d %s", id, reason);
				callcmd::kick(playerid, params);
			}
			return 1;
		}
		//=======================================//
		case ADMIN_FREEZE:
		{
			if(!response)
			{
				new id = ClickedID[playerid], params[32+2];
				format(params, sizeof(params), "%d", id);
				callcmd::unfreeze(playerid, params);
			}
			if(response)
			{
				new id = ClickedID[playerid], params[32+2];
				format(params, sizeof(params), "%d", id);
				callcmd::freeze(playerid, params);
			}
			return 1;
		}
		//=======================================//
		case ADMIN_MUTE:
		{
			if(!response)
			{
				new id = ClickedID[playerid], params[32+2];
				format(params, sizeof(params), "%d", id);
				callcmd::unmute(playerid, params);
			}
			if(response)
			{
				new reason[32], time, id = ClickedID[playerid];
				if(sscanf(inputtext, "is[32]", time, reason)) return ShowPlayerDialog(playerid, ADMIN_MUTE, DIALOG_STYLE_INPUT, ""SERVER"Indo:DM > "WHITE"Panel [Mute]", ""SERVER"> "WHITE"Unesite vrijeme i razlog zbog kojeg zelite mutirati igraca...", "ENTER", "UNMUTE");

				new params[32+2];
				format(params, sizeof(params), "%d %d %s", id, time, reason);
				callcmd::mute(playerid, params);
			}
			return 1;
		}
		//=======================================//
		case ADMIN_BAN:
		{
			if(!response) return 1;
			if(response)
			{
				new reason[32], id = ClickedID[playerid];
				if(sscanf(inputtext, "s[32]", reason)) return ShowPlayerDialog(playerid, ADMIN_BAN, DIALOG_STYLE_INPUT, ""SERVER"Indo:DM > "WHITE"Panel [Ban]", ""SERVER"> "WHITE"Unesite razlog zbog kojeg zelite banovati igraca...", "ENTER", "CANCEL");

				new params[32+2];
				format(params, sizeof(params), "%d %s", id, reason);
				callcmd::ban(playerid, params);
			}
			return 1;
		}
		//=======================================//
		case ADMIN_JAIL:
		{
			if(!response) return 1;
			if(response)
			{
				new reason[32], time, id = ClickedID[playerid];
				if(sscanf(inputtext, "is[32]", time, reason)) return ShowPlayerDialog(playerid, ADMIN_JAIL, DIALOG_STYLE_INPUT, ""SERVER"Indo:DM > "WHITE"Panel [Jail]", ""SERVER"> "WHITE"Unesite vrijeme i razlog zbog kojeg zelite jailovati igraca...", "ENTER", "CANCEL");

				new params[32+2];
				format(params, sizeof(params), "%d %d %s", id, time, reason);
				callcmd::jail(playerid, params);
			}
			return 1;
		}
		//=======================================//
		case ADMIN_WARN:
		{
			if(!response) return 1;
			if(response)
			{
				new reason[32], id = ClickedID[playerid];
				if(sscanf(inputtext, "s[32]", reason)) return ShowPlayerDialog(playerid, ADMIN_WARN, DIALOG_STYLE_INPUT, ""SERVER"Indo:DM > "WHITE"Panel [Warn]", ""SERVER"> "WHITE"Unesite razlog zbog kojeg zelite upozoriti igraca...", "ENTER", "CANCEL");

				new params[32+2];
				format(params, sizeof(params), "%d %s", id, reason);
				callcmd::warn(playerid, params);
			}
			return 1;
		}*/
		//======================================================================//
	}
	
	#if defined admin_OnDialogResponse
		return admin_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnDialogResponse
	#undef OnDialogResponse
#else
	#define _ALS_OnDialogResponse
#endif

#define OnDialogResponse admin_OnDialogResponse
#if defined admin_OnDialogResponse
	forward admin_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif
//==============================================================================//
public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		if(vehicleid == TempVehicle[playerid]) 
		{
			InfoMessage(playerid, "Vehicle ID '%d' is destroyed.", TempVehicle[playerid]);
			DestroyVehicle(TempVehicle[playerid]);
			TempVehicle[playerid] = -1; 
		}
	}
	
	#if defined admin_OnPlayerExitVehicle
		return admin_OnPlayerExitVehicle(playerid, vehicleid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerExitVehicle
	#undef OnPlayerExitVehicle
#else
	#define _ALS_OnPlayerExitVehicle
#endif

#define OnPlayerExitVehicle admin_OnPlayerExitVehicle
#if defined admin_OnPlayerExitVehicle
	forward admin_OnPlayerExitVehicle(playerid, vehicleid);
#endif
//==============================================================================//
public OnPlayerDisconnect(playerid, reason)
{
	// ---------------- //

	AdminInfo[playerid][adminOnline] = false;

	new query[96];
	mysql_format(DB, query, sizeof(query), "UPDATE "ADMIN_DB" SET `adminLastLogin`=NOW(), `adminOnline`=0 WHERE `adminID`=%d", AdminInfo[playerid][adminID]);
	mysql_tquery(DB, query);

	// ---------------- //
	
	#if defined admin_OnPlayerDisconnect
		return admin_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect admin_OnPlayerDisconnect
#if defined admin_OnPlayerDisconnect
	forward admin_OnPlayerDisconnect(playerid, reason);
#endif
//==============================================================================//
public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(PI[playerid][pAdmin] == 3) 
	{ 
		SetPlayerPosFindZ(playerid, fX, fY, fZ);
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
	}
	
	#if defined admin_OnPlayerClickMap
		return admin_OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerClickMap
	#undef OnPlayerClickMap
#else
	#define _ALS_OnPlayerClickMap
#endif

#define OnPlayerClickMap admin_OnPlayerClickMap
#if defined admin_OnPlayerClickMap
	forward admin_OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ);
#endif
//==============================================================================//
/*public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if(playerid == clickedplayerid && PI[playerid][pAdmin] > 0)
	{
		new params[8];
		format(params, sizeof(params), "%d", PI[playerid][pAdminCode]);
		callcmd::aduty(playerid, params);
		return 1;
	}
	if(AdminDuty[playerid])
	{
		ClickedID[playerid] = clickedplayerid;
		ShowPlayerDialog(playerid, ADMIN_CLICK, DIALOG_STYLE_TABLIST_HEADERS, ""SERVER"Indo:DM > "WHITE"Panel [Click]", "\
			"SERVER"> "WHITE"Komanda\t"SERVER"Level\n\
			"SERVER"> "WHITE"PM\t"SERVER"[ A1 ]\n\
			"SERVER"> "WHITE"Kick\t"SERVER"[ A1 ]\n\
			"SERVER"> "WHITE"Goto\t"SERVER"[ A1 ]\n\
			"SERVER"> "WHITE"Slap\t"SERVER"[ A1 ]\n\
			"SERVER"> "WHITE"(Un)Freeze\t"SERVER"[ A1 ]\n\
			"SERVER"> "WHITE"Spectate\t"SERVER"[ A1 ]\n\
			"SERVER"> "WHITE"(Un)Mute\t"SERVER"[ A2 / A1 ]\n\
			"SERVER"> "WHITE"Ban\t"SERVER"[ A2 ]\n\
			"SERVER"> "WHITE"Spawn\t"SERVER"[ A2 ]\n\
			"SERVER"> "WHITE"Jail\t"SERVER"[ A2 ]\n\
			"SERVER"> "WHITE"(Un)Isolate\t"SERVER"[ / ]\n\
			"SERVER"> "WHITE"Warn\t"SERVER"[ A2 ]\n\
			"SERVER"> "WHITE"Get\t"SERVER"[ A2 ]\n\
			"SERVER"> "WHITE"Kill\t"SERVER"[ A3 ]\n\
			"SERVER"> "WHITE"Explode\t"SERVER"[ A4 ]\n\
			", "CHOOSE", "CANCEL");

		AMessage(playerid, "Otvorili ste 'Admin-Panel' za igraca '%s'", GetName(clickedplayerid));
	}
	
	#if defined admin_OnPlayerClickPlayer
		return admin_OnPlayerClickPlayer(playerid, clickedplayerid, source);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerClickPlayer
	#undef OnPlayerClickPlayer
#else
	#define _ALS_OnPlayerClickPlayer
#endif

#define OnPlayerClickPlayer admin_OnPlayerClickPlayer
#if defined admin_OnPlayerClickPlayer
	forward admin_OnPlayerClickPlayer(playerid, clickedplayerid, source);
#endif*/
//==============================================================================//
