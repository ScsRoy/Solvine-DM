//==============================================================================//
/*
	* Module: #server_callbacks.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		//======================================================================//
		case SERVER_MENU:
		{
			if(!response) return 1;
			if(response)
			{
				switch(listitem)
				{
					case 0://Statistika
					{
						showServerStats(playerid);
					}
					case 1://Upravljanje
					{
						showControlMenu(playerid);
					}
					case 2://RCON
					{
						if(PI[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not allowed to use this option. [RCON]");

						showRconMenu(playerid);
					}
					case 3://Napravi
					{
						ShowPlayerDialog(playerid, SERVER_CREATE, DIALOG_STYLE_LIST, ""SERVER"Solvine Deathmatch > "WHITE"Create", "\
							"SERVER"> "WHITE"DM Arena\n\
							"SERVER"> "WHITE"Rank\n\
							", "NEXT" , "CANCEL");
					}
					case 4://Izbrisi
					{
						ShowPlayerDialog(playerid, SERVER_DELETE, DIALOG_STYLE_LIST, ""SERVER"Solvine Deathmatch > "WHITE"Delete", "\
							"SERVER"> "WHITE"DM Arena\n\
							"SERVER"> "WHITE"Rank\n\
							", "NEXT" , "CANCEL");
					}
					case 5://GR
					{
						if(PI[playerid][pAdmin] < 3) return ErrorMessage(playerid, "You are not allowed to use this option. [RCON]");

						ShowPlayerDialog(playerid, SERVER_GR, DIALOG_STYLE_MSGBOX, ""SERVER"Solvine Deathmatch > "WHITE"Global Restart", ""SERVER"> "WHITE"Are you sure you want to do global restart?", "YES", "NO");
					}
				}
			}
		}
		//======================================================================//
		case SERVER_CONTROL:
		{
			if(!response) return 1;
			if(response)
			{
				switch(listitem)
				{
					case 0://Register
					{
						if(ServerInfo[serverRegistration])
						{
							ServerInfo[serverRegistration] = false;
							InfoMessage(playerid, "You successfully "RED"disabled"WHITE" registrations.");
						}
						else
						{
							ServerInfo[serverRegistration] = true;
							InfoMessage(playerid, "You successfully "GREEN"enabled"WHITE" registrations.");
						}
						showControlMenu(playerid);
						mySQL_UpdateServerCustomVal("serverRegistration", ServerInfo[serverRegistration]);

						Log(server_control_log, INFO, "Registration (%d) > Owner (%s) > IP (%s)", ServerInfo[serverRegistration], GetName(playerid), GetPlayerIP(playerid));
					}
					case 1://Whitelist
					{
						if(ServerInfo[serverWL])
						{
							ServerInfo[serverWL] = false;
							InfoMessage(playerid, "You successfully "RED"disabled"WHITE" singing up for whitelist.");
						}
						else
						{
							ServerInfo[serverWL] = true;
							InfoMessage(playerid, "You successfully "GREEN"enabled"WHITE" singing up for whitelist.");
						}
						showControlMenu(playerid);
						mySQL_UpdateServerCustomVal("serverWL", ServerInfo[serverWL]);

						Log(server_control_log, INFO, "Whitelist (%d) > Owner (%s) > IP (%s)", ServerInfo[serverWL], GetName(playerid), GetPlayerIP(playerid));
					}
					case 2://Name 1
					{
						ShowPlayerDialog(playerid, SERVER_CONTROL_NAME1, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Control [Name 1]", ""SERVER"> "WHITE"Unesite jedno od dva imena servera...", "ENTER", "CANCEL");
					}
					case 3://Name 2
					{
						ShowPlayerDialog(playerid, SERVER_CONTROL_NAME2, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Control [Name 2]", ""SERVER"> "WHITE"Unesite jedno od dva imena servera...", "ENTER", "CANCEL");
					}
					case 4://Arena
					{
						if(ServerInfo[serverArena])
						{
							ServerInfo[serverArena] = false;
							InfoMessage(playerid, "You successfully "RED"disabled"WHITE" arenas (/dm).");
						}
						else
						{
							ServerInfo[serverArena] = true;
							InfoMessage(playerid, "You successfully "GREEN"enabled"WHITE" arenas (/dm).");
						}
						showControlMenu(playerid);
						mySQL_UpdateServerCustomVal("serverArena", ServerInfo[serverArena]);

						Log(server_control_log, INFO, "Arenas (%d) > Owner (%s) > IP (%s)", ServerInfo[serverArena], GetName(playerid), GetPlayerIP(playerid));
					}
					case 5://Duel
					{
						if(ServerInfo[serverDuel])
						{
							ServerInfo[serverDuel] = false;
							InfoMessage(playerid, "You successfully "RED"disabled"WHITE" duel lobby. (/duel).");
						}
						else
						{
							ServerInfo[serverDuel] = true;
							InfoMessage(playerid, "You successfully "GREEN"enabled"WHITE" duel lobby. (/duel).");
						}
						showControlMenu(playerid);
						mySQL_UpdateServerCustomVal("serverDuel", ServerInfo[serverDuel]);

						Log(server_control_log, INFO, "Duel (%d) > Owner (%s) > IP (%s)", ServerInfo[serverDuel], GetName(playerid), GetPlayerIP(playerid));
					}
					case 6://Versus
					{
						if(ServerInfo[serverVersus])
						{
							ServerInfo[serverVersus] = false;
							InfoMessage(playerid, "You successfully "RED"disabled"WHITE" versus lobby (/versus).");
						}
						else
						{
							ServerInfo[serverVersus] = true;
							InfoMessage(playerid, "You successfully "GREEN"enabled"WHITE" versus lobby (/versus).");
						}
						showControlMenu(playerid);
						mySQL_UpdateServerCustomVal("serverVersus", ServerInfo[serverVersus]);

						Log(server_control_log, INFO, "Versus (%d) > Owner (%s) > IP (%s)", ServerInfo[serverVersus], GetName(playerid), GetPlayerIP(playerid));
					}
					case 7://Versus Weapon
					{
						ShowPlayerDialog(playerid, SERVER_VERSUS, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Control [Versus Weapon]", ""SERVER"> "WHITE"Enter Weapon ID for versus duels:", "ENTER", "CANCEL");
					}
					case 8://Versus
					{
						if(ServerInfo[serverFreeroam])
						{
							ServerInfo[serverFreeroam] = false;
							InfoMessage(playerid, "You successfully "RED"disabled"WHITE" freeroam.");
						}
						else
						{
							ServerInfo[serverFreeroam] = true;
							InfoMessage(playerid, "You successfully "GREEN"enabled"WHITE" freeroam.");
						}
						showControlMenu(playerid);
						mySQL_UpdateServerCustomVal("serverFreeroam", ServerInfo[serverFreeroam]);

						Log(server_control_log, INFO, "Freeroam (%d) > Owner (%s) > IP (%s)", ServerInfo[serverFreeroam], GetName(playerid), GetPlayerIP(playerid));
					}
				}
			}
			return 1;
		}
		//=======================================//
		case SERVER_CONTROL_NAME1:
		{
			if(!response) return showControlMenu(playerid);
			if(response)
			{
				new name[72];
				if(sscanf(inputtext, "s[72]", name)) return ShowPlayerDialog(playerid, SERVER_CONTROL_NAME1, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Control [Name 1]", ""SERVER"> "WHITE"Unesite jedno od dva imena servera...", "ENTER", "CANCEL");

				strmid(ServerInfo[serverName1], name, 0, strlen(name));
				mySQL_UpdateServerCustomStr("serverName1", ServerInfo[serverName1]);

				showControlMenu(playerid);
				InfoMessage(playerid, "You successfully change server name [1] into '%s'", name);

				Log(server_control_log, INFO, "Name [1] (%s) > Owner (%s) > IP (%s)", name, GetName(playerid), GetPlayerIP(playerid));
			}
			return 1;
		}
		//=======================================//
		case SERVER_CONTROL_NAME2:
		{
			if(!response) return showControlMenu(playerid);
			if(response)
			{
				new name[72];
				if(sscanf(inputtext, "s[72]", name)) return ShowPlayerDialog(playerid, SERVER_CONTROL_NAME2, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Control [Name 2]", ""SERVER"> "WHITE"Unesite jedno od dva imena servera...", "ENTER", "CANCEL");

				strmid(ServerInfo[serverName2], name, 0, strlen(name));
				mySQL_UpdateServerCustomStr("serverName2", ServerInfo[serverName2]);

				showControlMenu(playerid);
				InfoMessage(playerid, "You successfully change server name [2] into '%s'", name);

				Log(server_control_log, INFO, "Name [2] (%s) > Owner (%s) > IP (%s)", name, GetName(playerid), GetPlayerIP(playerid));
			}
			return 1;
		}
		//=======================================//
		case SERVER_VERSUS:
		{
			if(!response) return showControlMenu(playerid);
			if(response)
			{
				new weapon;
				if(sscanf(inputtext, "i", weapon)) return ShowPlayerDialog(playerid, SERVER_VERSUS, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"Control [Versus Weapon]", ""SERVER"> "WHITE"Enter Weapon ID for versus duels:", "ENTER", "CANCEL");
				if(!IsValidWeapon(weapon)) return ErrorMessage(playerid, "Wrong weapon ID.");

				ServerInfo[versusWeapon] = weapon;
				mySQL_UpdateServerCustomVal("versusWeapon", ServerInfo[versusWeapon]);

				new str[24];
				format(str, sizeof(str), "%s", WeaponInfo[weapon][wName]);
				TextDrawSetString(versusTD[2], str);

				showControlMenu(playerid);
				InfoMessage(playerid, "You successfully changed versus weapon into '%s'", WeaponInfo[weapon][wName]);

				Log(server_control_log, INFO, "Versus Weapon (%d) > Owner (%s) > IP (%s)", weapon, GetName(playerid), GetPlayerIP(playerid));
			}
			return 1;
		}
		//======================================================================//
		case SERVER_RCON:
		{
			if(!response) return 1;
			if(response)
			{
				switch(listitem)
				{
					case 0://Change map
					{
						ShowPlayerDialog(playerid, RCON_MAP, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch  > "WHITE"RCON Map", ""SERVER"> "WHITE"Please enter new map name:", "ENTER", "CANCEL");
					}
					case 1://Change web
					{
						ShowPlayerDialog(playerid, RCON_WEB, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"RCON Web", ""SERVER"> "WHITE"Please enter new web url:", "ENTER", "CANCEL");
					}
					case 2://Unlock
					{
						ShowPlayerDialog(playerid, RCON_UNLOCK, DIALOG_STYLE_MSGBOX, ""SERVER"Solvine Deathmatch > "WHITE"RCON Unlock", ""SERVER"> "WHITE"Are you sure that you want to unlock server?", "UNLOCK", "CANCEL");
					}
					case 3://Lock
					{
						ShowPlayerDialog(playerid, RCON_LOCK, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"RCON Lock", ""SERVER"> "WHITE"Please enter new password for locking server:", "ENTER", "CANCEL");
					}
					case 4://Change rcon
					{
						ShowPlayerDialog(playerid, RCON_PW, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"RCON PW", ""SERVER"> "WHITE"Please enter new RCON PW for server:", "ENTER", "CANCEL");
					}
					case 5://RR
					{
						ShowPlayerDialog(playerid, RCON_RR, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"RCON Restart", ""SERVER"> "WHITE"Please enter reason for restarting server:", "UNLOCK", "CANCEL");
					}
					case 6://Stop
					{
						ShowPlayerDialog(playerid, RCON_OFF, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"RCON Stop", ""SERVER"> "WHITE"Please enter reason for stoping server;", "UNLOCK", "CANCEL");
					}
				}
			}
			return 1;
		}
		//=======================================//
		case RCON_MAP:
		{
			if(!response) return showRconMenu(playerid);
			if(response)
			{
				new map[32], str[128];
				if(sscanf(inputtext, "s[32]", map)) return ShowPlayerDialog(playerid, RCON_MAP, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"RCON Map", ""SERVER"> "WHITE"Please enter new map name:", "ENTER", "CANCEL");
				if(strlen(map) > 32) return ShowPlayerDialog(playerid, RCON_MAP, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"RCON Map", ""SERVER"> "WHITE"Please enter new map name:", "ENTER", "CANCEL");

				format(str, sizeof(str), "mapname %s", map);
				SendRconCommand(str);
				format(str, sizeof(str), "Owner '%s' successfully changed map name into '%s'.", GetName(playerid), map);
				// sendMessageToAdmin(str);

				Log(rcon_log, INFO, "New map name (%s) > Owner (%s) > IP (%s)", GetName(playerid), GetPlayerIP(playerid));
			}
			return 1;
		}
		//=======================================//
		case RCON_WEB:
		{
			if(!response) return showRconMenu(playerid);
			if(response)
			{
				new url[36], str[72];
				if(sscanf(inputtext, "s[36]", url)) return ShowPlayerDialog(playerid, RCON_WEB, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"RCON Web", ""SERVER"> "WHITE"Please enter new web url:", "ENTER", "CANCEL");
				if(strlen(url) > 36) return ShowPlayerDialog(playerid, RCON_WEB, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"RCON Web", ""SERVER"> "WHITE"Please enter new web url:", "ENTER", "CANCEL");

				format(str, sizeof(str), "weburl %s", url);
				SendRconCommand(str);
				format(str, sizeof(str), "Owner '%s' successfully changed web url into '%s'.", GetName(playerid), url);
				// sendMessageToAdmin(str);

				Log(rcon_log, INFO, "New web-url (%s) > Owner (%s) > IP (%s)", GetName(playerid), GetPlayerIP(playerid));
			}
			return 1;
		}
		//=======================================//
		case RCON_UNLOCK:
		{
			if(!response) return showRconMenu(playerid);
			if(response)
			{
				new str[72];
				SendRconCommand("password 0");
				format(str, sizeof(str), "Owner '%s' successfully unlocked server.", GetName(playerid));
				sendMessageToAdmin(str);

				Log(rcon_log, INFO, "UNLOCK > Owner (%s) > IP (%s)", GetName(playerid), GetPlayerIP(playerid));
			}
			return 1;
		}
		//=======================================//
		case RCON_LOCK:
		{
			if(!response) return showRconMenu(playerid);
			if(response)
			{
				new pw[24], str[128];
				if(sscanf(inputtext, "s[24]", pw)) return ShowPlayerDialog(playerid, RCON_LOCK, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"RCON Lock", ""SERVER"> "WHITE"Please enter new password for locking server:", "ENTER", "CANCEL");
				if(strlen(pw) > 24) return ShowPlayerDialog(playerid, RCON_LOCK, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"RCON Lock", ""SERVER"> "WHITE"Please enter new password for locking server:", "ENTER", "CANCEL");

				format(str, sizeof(str), "password %s", pw);
				SendRconCommand(str);
				format(str, sizeof(str), "Owner '%s' successfully locked server.", GetName(playerid));
				sendMessageToAdmin(str);

				foreach(new i:Player)
				{
					if(PI[i][pAdmin] < 1)
					{
						onPlayerKicked(i, GetName(playerid), "Locking server...");
					}
				}

				Log(rcon_log, INFO, "LOCK > New password (%s) > Owner (%s) > IP (%s)", pw, GetName(playerid), GetPlayerIP(playerid));
			}
			return 1;
		}
		//=======================================//
		case RCON_PW:
		{
			if(!response) return showRconMenu(playerid);
			if(response)
			{
				new pw[36], str[128];
				if(sscanf(inputtext, "s[36]", pw)) return ShowPlayerDialog(playerid, RCON_PW, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"RCON PW", ""SERVER"> "WHITE"Please enter new RCON PW for server:", "ENTER", "CANCEL");
				if(strlen(pw) > 36) return ShowPlayerDialog(playerid, RCON_PW, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"RCON PW", ""SERVER"> "WHITE"Please enter new RCON PW for server:", "ENTER", "CANCEL");

				format(str, sizeof(str), "rcon_password %s", pw);
				SendRconCommand(str);
				format(str, sizeof(str), "Owner '%s' successfully change RCON PW.", GetName(playerid));
				sendMessageToAdmin(str);

				Log(rcon_log, INFO, "Novi RCON password (%s) > Owner (%s) > IP (%s)", pw, GetName(playerid), GetPlayerIP(playerid));
			}
			return 1;
		}
		//=======================================//
		case RCON_RR:
		{
			if(!response) return showRconMenu(playerid);
			if(response)
			{
				new reason[24], str[36];
				if(sscanf(inputtext, "s[24]", reason)) return ShowPlayerDialog(playerid, RCON_RR, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"RCON Restart", ""SERVER"> "WHITE"Please enter reason for restarting server:", "UNLOCK", "CANCEL");
				if(strlen(reason) > 24) return ShowPlayerDialog(playerid, RCON_RR, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"RCON Restart", ""SERVER"> "WHITE"Please enter reason for restarting server:", "UNLOCK", "CANCEL");

				format(str, sizeof(str), "Restart (%s)", reason);
				foreach(new i:Player)
				{
					onPlayerKicked(i, GetName(playerid), str);
				}
				SetTimer("restartGamemode", 10000, false);

				Log(rcon_log, INFO, "GMX > Reason (%s) > Owner (%s) > IP (%s)", reason, GetName(playerid), GetPlayerIP(playerid));
			}
			return 1;
		}
		//=======================================//
		case RCON_OFF:
		{
			if(!response) return showRconMenu(playerid);
			if(response)
			{
				new reason[24], str[128];
				if(sscanf(inputtext, "s[24]", reason)) return ShowPlayerDialog(playerid, RCON_OFF, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"RCON Stop", ""SERVER"> "WHITE"Please enter reason for stoping server;", "UNLOCK", "CANCEL");
				if(strlen(reason) > 24) return ShowPlayerDialog(playerid, RCON_OFF, DIALOG_STYLE_INPUT, ""SERVER"Solvine Deathmatch > "WHITE"RCON Stop", ""SERVER"> "WHITE"Please enter reason for stoping server;", "UNLOCK", "CANCEL");

				format(str, sizeof(str), "ShutDown (%s)", reason);
				foreach(new i:Player)
				{
					onPlayerKicked(i, GetName(playerid), str);
				}
				SetTimer("exitGamemode", 10000, false);

				Log(rcon_log, INFO, "EXIT > Reason (%s) > Owner (%s) > IP (%s)", reason, GetName(playerid), GetPlayerIP(playerid));
			}
			return 1;
		}
		//======================================================================//
		case SERVER_GR:
		{
			if(!response)
			{
				InfoMessage(playerid, "You refused to do global restart.");
				showServerMenu(playerid);
				return 1;
			}
			if(response)
			{
				globalRestart(playerid);
			}
			return 1;
		}
		//======================================================================//
	}
	
	#if defined server_OnDialogResponse
		return server_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnDialogResponse
	#undef OnDialogResponse
#else
	#define _ALS_OnDialogResponse
#endif

#define OnDialogResponse server_OnDialogResponse
#if defined server_OnDialogResponse
	forward server_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif
//==============================================================================//
