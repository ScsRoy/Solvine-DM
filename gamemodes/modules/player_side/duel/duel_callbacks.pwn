//==============================================================================//
/*
	* Module: duel_callbacks.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		//======================================================================//
		case DUEL_SETUP:
		{
			if(!response)
			{
				destroyDuel(InDuelID[playerid]);
				InDuelID[playerid] = -1;
				DuelMessage(playerid, "You have just canceled duel setup.");
				return 1;
			}
			if(response)
			{
				switch(listitem)
				{
					case 0://Weapon 1
					{
						ShowPlayerDialog(playerid, DUEL_WEAPON1, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [Weapon 1]", ""ORANGE"> "WHITE"Please, enter Weapon ID, for weapon slot [1] to your duel setup:", "ENTER", "CANCEL");
					}
					case 1://Weapon 2
					{
						ShowPlayerDialog(playerid, DUEL_WEAPON2, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [Weapon 2]", ""ORANGE"> "WHITE"Please, enter Weapon ID, for weapon slot [2] to your duel setup:", "ENTER", "CANCEL");
					}
					case 2://Weapon 3
					{
						ShowPlayerDialog(playerid, DUEL_WEAPON3, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [Weapon 3]", ""ORANGE"> "WHITE"Please, enter Weapon ID, for weapon slot [3] to your duel setup:", "ENTER", "CANCEL");
					}
					case 3://HP
					{
						ShowPlayerDialog(playerid, DUEL_HP, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [HP]", ""ORANGE"> "WHITE"Please, enter starting HP for your duel setup:", "ENTER", "CANCEL");
					}
					case 4://Armour
					{
						ShowPlayerDialog(playerid, DUEL_ARMOUR, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [Armour]", ""ORANGE"> "WHITE"Please, enter starting armour for your duel setup:", "ENTER", "CANCEL");
					}
					case 5://CBug
					{
						new id = InDuelID[playerid];
						if(DuelInfo[id][duelCBug])
						{
							DuelInfo[id][duelCBug] = false;
							DuelMessage(playerid, "You have disabled C-Bug for your duel setup.");
						}
						else
						{
							DuelInfo[id][duelCBug] = true;
							DuelMessage(playerid, "You have enabled C-Bug for your duel setup.");
						}
						setupDuelDialog(playerid, id);
					}
					case 6://Arena
					{
						new str[72], dialog[512], x = 0;
						foreach(new i:ArenaList)
						{
							format(str, sizeof(str), ""ORANGE"> "WHITE"%s\n", ArenaInfo[i][arenaName]);
							strcat(dialog, str);
							x++;
						}
						if(x == 0) return ErrorMessage(playerid, "Currently, there is no created arena. .");

						ShowPlayerDialog(playerid, DUEL_ARENA, DIALOG_STYLE_LIST, ""ORANGE"Solvine Deathmatch > "WHITE"Choose arena", dialog, "CHOOSE", "CANCEL");
					}
					case 7://Lineup
					{
						new id = InDuelID[playerid];
						if(DuelInfo[id][duelLineup] == 1)
						{
							DuelInfo[id][duelLineup] = 2;
							DuelMessage(playerid, "You have changed your lineup to 2v2 for your duel setup.");
						}
						else if(DuelInfo[id][duelLineup] == 2)
						{
							DuelInfo[id][duelLineup] = 3;
							DuelMessage(playerid, "You have changed your lineup to 3v3 for your duel setup.");
						}
						else if(DuelInfo[id][duelLineup] == 3)
						{
							DuelInfo[id][duelTeam][1] = INVALID_PLAYER_ID;
							DuelInfo[id][duelTeam][2] = INVALID_PLAYER_ID;
							DuelInfo[id][duelOpponent][1] = INVALID_PLAYER_ID;
							DuelInfo[id][duelOpponent][2] = INVALID_PLAYER_ID;

							DuelInfo[id][duelLineup] = 1;
							DuelMessage(playerid, "You have changed your lineup to 1v1 for your duel setup.");
						}
						setupDuelDialog(playerid, id);
					}
					case 8://Teammate 1
					{
						new id = InDuelID[playerid];
						if(DuelInfo[id][duelLineup] < 2)
						{
							ErrorMessage(playerid, "This slot is locked, first change your lineup settings.");
							setupDuelDialog(playerid, id);
							return 1;
						}
						if(DuelInfo[id][duelTeam][1] != INVALID_PLAYER_ID)
						{
							ErrorMessage(playerid, "There is already player on this slot, reset your duel than try again.");
							setupDuelDialog(playerid, id);
							return 1;
						}

						ShowPlayerDialog(playerid, DUEL_TEAMMATE1, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [Teammate 1]", ""ORANGE"> "WHITE"Please, enter ID for your teammate [1] for your duel setup:", "ENTER", "CANCEL");
					}
					case 9://Teammate 2
					{
						new id = InDuelID[playerid];
						if(DuelInfo[id][duelLineup] < 3)
						{
							ErrorMessage(playerid, "This slot is locked, first change your lineup settings.");
							setupDuelDialog(playerid, id);
							return 1;
						}
						if(DuelInfo[id][duelTeam][2] != INVALID_PLAYER_ID)
						{
							ErrorMessage(playerid, "There is already player on this slot, reset your duel than try again.");
							setupDuelDialog(playerid, id);
							return 1;
						}

						ShowPlayerDialog(playerid, DUEL_TEAMMATE2, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [Teammate 2]", ""ORANGE"> "WHITE"Please, enter ID for your teammate [2] for your duel setup:", "ENTER", "CANCEL");
					}
					case 10://Opponent 1
					{
						new id = InDuelID[playerid];
						if(DuelInfo[id][duelOpponent][0] != INVALID_PLAYER_ID)
						{
							ErrorMessage(playerid, "There is already player on this slot, reset your duel than try again.");
							setupDuelDialog(playerid, id);
							return 1;
						}

						ShowPlayerDialog(playerid, DUEL_OPPONENT1, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [Opponent 1]", ""ORANGE"> "WHITE"Please, enter ID of your opponent [1] for your duel setup:", "ENTER", "CANCEL");
					}
					case 11://Opponent 2
					{
						new id = InDuelID[playerid];
						if(DuelInfo[id][duelLineup] < 2)
						{
							ErrorMessage(playerid, "This slot is locked, first change your lineup settings.");
							setupDuelDialog(playerid, id);
							return 1;
						}
						if(DuelInfo[id][duelOpponent][1] != INVALID_PLAYER_ID)
						{
							ErrorMessage(playerid, "There is already player on this slot, reset your duel than try again.");
							setupDuelDialog(playerid, id);
							return 1;
						}

						ShowPlayerDialog(playerid, DUEL_OPPONENT2, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [Opponent 2]", ""ORANGE"> "WHITE"Please, enter ID of your opponent [2] for your duel setup:", "ENTER", "CANCEL");
					}
					case 12://Opponent 3
					{
						new id = InDuelID[playerid];
						if(DuelInfo[id][duelLineup] < 3)
						{
							ErrorMessage(playerid, "This slot is locked, first change your lineup settings.");
							setupDuelDialog(playerid, id);
							return 1;
						}
						if(DuelInfo[id][duelOpponent][2] != INVALID_PLAYER_ID)
						{
							ErrorMessage(playerid, "There is already player on this slot, reset your duel than try again.");
							setupDuelDialog(playerid, id);
							return 1;
						}

						ShowPlayerDialog(playerid, DUEL_OPPONENT3, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [Opponent 3]", ""ORANGE"> "WHITE"Please, enter ID of your opponent [3] for your duel setup:", "ENTER", "CANCEL");
					}
					case 13://Reset
					{
						new id = InDuelID[playerid];

						resetDuel(id);
						DuelInfo[id][duelTeam][0] = playerid;
						setupDuelDialog(playerid, id);
					}
					case 14://Start
					{
						new duel = InDuelID[playerid];
						if(!isDuelSetupValid(duel))
						{
							ErrorMessage(playerid, "Duel setup is not finished. Pleasy finish your duel setup first.");
							setupDuelDialog(playerid, duel);
							return 1;
						}
		
						finishDuelSetup(duel);
						DuelMessage(playerid, "You have successfuly finished your duel setup. Waiting for players to accept.");
					}
				}
			}
			return 1;
		}
		//======================================================================//
		case DUEL_WEAPON1:
		{
			if(!response) return setupDuelDialog(playerid, InDuelID[playerid]);
			if(response)
			{
				new weapon;
				if(sscanf(inputtext, "i", weapon)) return ShowPlayerDialog(playerid, DUEL_WEAPON1, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [Weapon 1]", ""ORANGE"> "WHITE"Please, enter Weapon ID, for weapon slot [1] to your duel setup:", "ENTER", "CANCEL");
				if(!IsValidWeapon(weapon)) return ShowPlayerDialog(playerid, DUEL_WEAPON1, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [Weapon 1]", ""ORANGE"> "WHITE"Please, enter Weapon ID, for weapon slot [1] to your duel setup:", "ENTER", "CANCEL");

				new id = InDuelID[playerid];
				DuelInfo[id][duelWeapon][0] = weapon;
				setupDuelDialog(playerid, InDuelID[playerid]);
				DuelMessage(playerid, "You have successfully set weapon 1 to %s for your duel setup.", WeaponInfo[weapon][wName]);
			}
			return 1;
		}
		//======================================================================//
		case DUEL_WEAPON2:
		{
			if(!response) return setupDuelDialog(playerid, InDuelID[playerid]);
			if(response)
			{
				new weapon;
				if(sscanf(inputtext, "i", weapon)) return ShowPlayerDialog(playerid, DUEL_WEAPON2, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [Weapon 2]", ""ORANGE"> "WHITE"Please, enter Weapon ID, for weapon slot [2] to your duel setup:", "ENTER", "CANCEL");
				if(!IsValidWeapon(weapon)) return ShowPlayerDialog(playerid, DUEL_WEAPON2, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [Weapon 2]", ""ORANGE"> "WHITE"Please, enter Weapon ID, for weapon slot [2] to your duel setup:", "ENTER", "CANCEL");

				new id = InDuelID[playerid];
				DuelInfo[id][duelWeapon][1] = weapon;
				setupDuelDialog(playerid, InDuelID[playerid]);
				DuelMessage(playerid, "You have successfully set weapon 2 to %s for your duel setup.", WeaponInfo[weapon][wName]);
			}
			return 1;
		}
		//======================================================================//
		case DUEL_WEAPON3:
		{
			if(!response) return setupDuelDialog(playerid, InDuelID[playerid]);
			if(response)
			{
				new weapon;
				if(sscanf(inputtext, "i", weapon)) return ShowPlayerDialog(playerid, DUEL_WEAPON3, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [Weapon 3]", ""ORANGE"> "WHITE"Please, enter Weapon ID, for weapon slot [3] to your duel setup:", "ENTER", "CANCEL");
				if(!IsValidWeapon(weapon)) return ShowPlayerDialog(playerid, DUEL_WEAPON3, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [Weapon 3]", ""ORANGE"> "WHITE"Please, enter Weapon ID, for weapon slot [3] to your duel setup:", "ENTER", "CANCEL");

				new id = InDuelID[playerid];
				DuelInfo[id][duelWeapon][2] = weapon;
				setupDuelDialog(playerid, InDuelID[playerid]);
				DuelMessage(playerid, "You have successfully set weapon 3 to %s for your duel setup.", WeaponInfo[weapon][wName]);
			}
			return 1;
		}
		//======================================================================//
		case DUEL_HP:
		{
			if(!response) return setupDuelDialog(playerid, InDuelID[playerid]);
			if(response)
			{
				new Float:HP;
				if(sscanf(inputtext, "f", HP)) return ShowPlayerDialog(playerid, DUEL_HP, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [HP]", ""ORANGE"> "WHITE"Please, enter starting HP for your duel setup:", "ENTER", "CANCEL");
				if(HP < 1 || HP > 100) return ShowPlayerDialog(playerid, DUEL_HP, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [HP]", ""ORANGE"> "WHITE"Please, enter starting HP for your duel setup:", "ENTER", "CANCEL");

				new id = InDuelID[playerid];
				DuelInfo[id][duelHP] = HP;
				setupDuelDialog(playerid, InDuelID[playerid]);
				DuelMessage(playerid, "You have successfully set starting HP to %.2f for your duel setup.", HP);
			}
			return 1;
		}
		//======================================================================//
		case DUEL_ARMOUR:
		{
			if(!response) return setupDuelDialog(playerid, InDuelID[playerid]);
			if(response)
			{
				new Float:armour;
				if(sscanf(inputtext, "f", armour)) return ShowPlayerDialog(playerid, DUEL_ARMOUR, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [Armour]", ""ORANGE"> "WHITE"Please, enter starting armour for your duel setup:", "ENTER", "CANCEL");
				if(armour < 1 || armour > 100) return ShowPlayerDialog(playerid, DUEL_ARMOUR, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [Armour]", ""ORANGE"> "WHITE"Please, enter starting armour for your duel setup:", "ENTER", "CANCEL");

				new id = InDuelID[playerid];
				DuelInfo[id][duelArmour] = armour;
				setupDuelDialog(playerid, InDuelID[playerid]);
				DuelMessage(playerid, "You have successfully set starting armour to %.2f for your duel setup.", armour);
			}
			return 1;
		}
		//======================================================================//
		case DUEL_ARENA:
		{
			if(!response) return setupDuelDialog(playerid, InDuelID[playerid]);
			if(response)
			{
				new duel = InDuelID[playerid], 
					id = 0,
					arena = -1;
				foreach(new i:ArenaList)
				{
					arena = i;
					if(id == listitem) break;
					id++;
				}
				if(arena == -1) return ErrorMessage(playerid, "Something went wrong, contact developer.");

				DuelInfo[duel][duelArenaID] = arena;
				setupDuelDialog(playerid, duel);
				DuelMessage(playerid, "You have successfully changed you duel arena. (%s)", ArenaInfo[arena][arenaName]);
			}
			return 1;
		}
		//======================================================================//
		case DUEL_TEAMMATE1:
		{
			if(!response) return setupDuelDialog(playerid, InDuelID[playerid]);
			if(response)
			{
				new id; 
				if(sscanf(inputtext, "u", id)) return ShowPlayerDialog(playerid, DUEL_TEAMMATE1, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [Teammate 1]", ""ORANGE"> "WHITE"Please, enter ID for your teammate [1] for your duel setup:", "ENTER", "CANCEL");
				if(id == INVALID_PLAYER_ID || id == playerid)
				{
					ErrorMessage(playerid, "Wrong ID.");
					setupDuelDialog(playerid, InDuelID[playerid]);
					return 1;
				}
				if(!Spawned[id])
				{
					ErrorMessage(playerid, "Player %s not spawned.", GetName(id));
					setupDuelDialog(playerid, InDuelID[playerid]);
					return 1;
				}
				if(!InLobby[id]) 
				{
					ErrorMessage(playerid, "Player %s not in lobby.", GetName(id));
					setupDuelDialog(playerid, InDuelID[playerid]);
					return 1;
				}

				new duel = InDuelID[playerid];
				DuelInfo[duel][duelTeam][1] = id;

				setupDuelDialog(playerid, InDuelID[playerid]);
				DuelMessage(playerid, "You have successfully choose %s (slot 1) for your duel teammate.", GetName(id));
			}
			return 1;
		}
		//======================================================================//
		case DUEL_TEAMMATE2:
		{
			if(!response) return setupDuelDialog(playerid, InDuelID[playerid]);
			if(response)
			{
				new id; 
				if(sscanf(inputtext, "u", id)) return ShowPlayerDialog(playerid, DUEL_TEAMMATE2, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [Teammate 2]", ""ORANGE"> "WHITE"Please, enter ID for your teammate [2] for your duel setup:", "ENTER", "CANCEL");
				if(id == INVALID_PLAYER_ID || id == playerid)
				{
					ErrorMessage(playerid, "Wrong ID.");
					setupDuelDialog(playerid, InDuelID[playerid]);
					return 1;
				}
				if(!Spawned[id])
				{
					ErrorMessage(playerid, "Player %s not spawned.", GetName(id));
					setupDuelDialog(playerid, InDuelID[playerid]);
					return 1;
				}
				if(!InLobby[id]) 
				{
					ErrorMessage(playerid, "Player %s not in lobby.", GetName(id));
					setupDuelDialog(playerid, InDuelID[playerid]);
					return 1;
				}

				new duel = InDuelID[playerid];
				DuelInfo[duel][duelTeam][2] = id;

				setupDuelDialog(playerid, InDuelID[playerid]);
				DuelMessage(playerid, "You have successfully choose %s (slot 2) for your duel teammate.", GetName(id));
			}
			return 1;
		}
		//======================================================================//
		case DUEL_OPPONENT1:
		{
			if(!response) return setupDuelDialog(playerid, InDuelID[playerid]);
			if(response)
			{
				new id; 
				if(sscanf(inputtext, "u", id)) return ShowPlayerDialog(playerid, DUEL_OPPONENT1, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [Opponent 1]", ""ORANGE"> "WHITE"Please, enter ID of your opponent [1] for your duel setup:", "ENTER", "CANCEL");
				if(id == INVALID_PLAYER_ID || id == playerid)
				{
					ErrorMessage(playerid, "Wrong ID.");
					setupDuelDialog(playerid, InDuelID[playerid]);
					return 1;
				}
				if(!Spawned[id])
				{
					ErrorMessage(playerid, "Player %s not spawned.", GetName(id));
					setupDuelDialog(playerid, InDuelID[playerid]);
					return 1;
				}
				if(!InLobby[id]) 
				{
					ErrorMessage(playerid, "Player %s not in lobby.", GetName(id));
					setupDuelDialog(playerid, InDuelID[playerid]);
					return 1;
				}

				new duel = InDuelID[playerid];
				DuelInfo[duel][duelOpponent][0] = id;

				setupDuelDialog(playerid, InDuelID[playerid]);
				DuelMessage(playerid, "You have successfully choose %s (slot 1) for your duel opponent.", GetName(id));
			}
			return 1;
		}
		//======================================================================//
		case DUEL_OPPONENT2:
		{
			if(!response) return setupDuelDialog(playerid, InDuelID[playerid]);
			if(response)
			{
				new id; 
				if(sscanf(inputtext, "u", id)) return ShowPlayerDialog(playerid, DUEL_OPPONENT2, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [Opponent 2]", ""ORANGE"> "WHITE"Please, enter ID of your opponent [2] for your duel setup:", "ENTER", "CANCEL");
				if(id == INVALID_PLAYER_ID || id == playerid)
				{
					ErrorMessage(playerid, "Wrong ID.");
					setupDuelDialog(playerid, InDuelID[playerid]);
					return 1;
				}
				if(!Spawned[id])
				{
					ErrorMessage(playerid, "Player %s not spawned.", GetName(id));
					setupDuelDialog(playerid, InDuelID[playerid]);
					return 1;
				}
				if(!InLobby[id]) 
				{
					ErrorMessage(playerid, "Player %s not in lobby.", GetName(id));
					setupDuelDialog(playerid, InDuelID[playerid]);
					return 1;
				}

				new duel = InDuelID[playerid];
				DuelInfo[duel][duelOpponent][1] = id;

				setupDuelDialog(playerid, InDuelID[playerid]);
				DuelMessage(playerid, "You have successfully choose %s (slot 2) for your duel opponent.", GetName(id));
			}
			return 1;
		}
		//======================================================================//
		case DUEL_OPPONENT3:
		{
			if(!response) return setupDuelDialog(playerid, InDuelID[playerid]);
			if(response)
			{
				new id; 
				if(sscanf(inputtext, "u", id)) return ShowPlayerDialog(playerid, DUEL_OPPONENT3, DIALOG_STYLE_INPUT, ""ORANGE"Solvine Deathmatch > "WHITE"Duel [Opponent 3]", ""ORANGE"> "WHITE"Please, enter ID of your opponent [3] for your duel setup:", "ENTER", "CANCEL");
				if(id == INVALID_PLAYER_ID || id == playerid)
				{
					ErrorMessage(playerid, "Wrong ID.");
					setupDuelDialog(playerid, InDuelID[playerid]);
					return 1;
				}
				if(!Spawned[id])
				{
					ErrorMessage(playerid, "Player %s not spawned.", GetName(id));
					setupDuelDialog(playerid, InDuelID[playerid]);
					return 1;
				}
				if(!InLobby[id]) 
				{
					ErrorMessage(playerid, "Player %s not in lobby.", GetName(id));
					setupDuelDialog(playerid, InDuelID[playerid]);
					return 1;
				}

				new duel = InDuelID[playerid];
				DuelInfo[duel][duelOpponent][2] = id;

				setupDuelDialog(playerid, InDuelID[playerid]);
				DuelMessage(playerid, "You have successfully choose %s (slot 3) for your duel opponent.", GetName(id));
			}
			return 1;
		}
		//======================================================================//
		case DUEL_INVITE:
		{
			if(!response)
			{
				new duel = DuelInviteID[playerid];
				AC_KillTimer(DuelInviteTimer[playerid]);

				new str[96];
				format(str, sizeof(str), "Player %s did not accept duel invite this time. (reject)", GetName(playerid));
				sendDuelMessage(duel, str);

				destroyDuel(duel);
			}
			if(response)
			{
				new duel = DuelInviteID[playerid];
				AC_KillTimer(DuelInviteTimer[playerid]);

				new str[96];
				format(str, sizeof(str), "Player %s accepted duel invite. Waiting for other players.", GetName(playerid));
				sendDuelMessage(duel, str);

				InDuelID[playerid] = duel;
				DuelInfo[duel][duelPlayers]++;

				if(DuelInfo[duel][duelPlayers] == DuelInfo[duel][duelLineup] * 2)
				{
					sendDuelMessage(duel, "All players accepted have accepted duel invite.");
					startDuel(duel);
				}
			}
			return 1;
		}
		//======================================================================//
	}
	
	#if defined duel_OnDialogResponse
		return duel_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnDialogResponse
	#undef OnDialogResponse
#else
	#define _ALS_OnDialogResponse
#endif

#define OnDialogResponse duel_OnDialogResponse
#if defined duel_OnDialogResponse
	forward duel_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif
//==============================================================================//
public OnPlayerDeath(playerid, killerid, reason)
{
	if(InDuelID[playerid] != -1)
	{
		new id = InDuelID[playerid];
		if(DuelInfo[id][duelStarted])
		{
			new string[96];
			if(killerid != INVALID_PLAYER_ID)
			{
				format(string, sizeof(string), "Player, %s(%d), in your duel match has just died. He is killed by %s(%d).", GetName(playerid), playerid, GetName(killerid), killerid);
				sendDuelMessage(id, string);
			}
			else
			{
				format(string, sizeof(string), "Player, %s(%d), in your duel match has just died.", GetName(playerid), playerid);
				sendDuelMessage(id, string);
			}

			if(DuelInfo[id][duelTeam][0] == playerid || DuelInfo[id][duelTeam][1] == playerid || DuelInfo[id][duelTeam][2] == playerid) DuelInfo[id][duelTeam2]++;
			if(DuelInfo[id][duelOpponent][0] == playerid || DuelInfo[id][duelOpponent][1] == playerid || DuelInfo[id][duelOpponent][2] == playerid) DuelInfo[id][duelTeam1]++;

			if(DuelInfo[id][duelTeam1] == DuelInfo[id][duelLineup])
			{
				Iter_Remove(DuelList, id);
				if(DuelInfo[id][duelLineup] == 1)
				{
					format(string, sizeof(string), "1v1 DUEL // "GREEN"%s (win)"WHITE" vs %s finished.", GetName(DuelInfo[id][duelTeam][0]), GetName(DuelInfo[id][duelOpponent][0]));
					SendClientMessageToAll(COL_ORANGE, string);

					#if USE_DISCORD == true
						format(string, sizeof(string), ">>> 1v1 duel has finished. **%s** vs %s", GetName(DuelInfo[id][duelTeam][0]), GetName(DuelInfo[id][duelOpponent][0]));
						DCC_SendChannelMessage(DiscordInfo[event_logs], string);
					#endif
				}
				else if(DuelInfo[id][duelLineup] == 2)
				{
					format(string, sizeof(string), "2v2 DUEL // "GREEN"%s-%s (win)"WHITE" vs %s-%s finished.", GetName(DuelInfo[id][duelTeam][0]), GetName(DuelInfo[id][duelTeam][1]), GetName(DuelInfo[id][duelOpponent][0]), GetName(DuelInfo[id][duelOpponent][1]));
					SendClientMessageToAll(COL_ORANGE, string);

					#if USE_DISCORD == true
						format(string, sizeof(string), ">>> 2v2 duel has finished. **%s-%s** vs %s-%s", GetName(DuelInfo[id][duelTeam][0]), GetName(DuelInfo[id][duelTeam][1]), GetName(DuelInfo[id][duelOpponent][0]), GetName(DuelInfo[id][duelOpponent][1]));
						DCC_SendChannelMessage(DiscordInfo[event_logs], string);
					#endif
				}
				else if(DuelInfo[id][duelLineup] == 3)
				{
					format(string, sizeof(string), "3v3 DUEL // "GREEN"%s-%s-%s (win)"WHITE" vs %s-%s-%s finished.", GetName(DuelInfo[id][duelTeam][0]), GetName(DuelInfo[id][duelTeam][1]), GetName(DuelInfo[id][duelTeam][2]), GetName(DuelInfo[id][duelOpponent][0]), GetName(DuelInfo[id][duelOpponent][1]), GetName(DuelInfo[id][duelOpponent][2]));
					SendClientMessageToAll(COL_ORANGE, string);

					#if USE_DISCORD == true
						format(string, sizeof(string), ">>> 3v3 duel has finished. **%s-%s-%s** vs %s-%s-%s", GetName(DuelInfo[id][duelTeam][0]), GetName(DuelInfo[id][duelTeam][1]), GetName(DuelInfo[id][duelTeam][2]), GetName(DuelInfo[id][duelOpponent][0]), GetName(DuelInfo[id][duelOpponent][1]), GetName(DuelInfo[id][duelOpponent][2]));
						DCC_SendChannelMessage(DiscordInfo[event_logs], string);
					#endif
				}

				giveDuelWin(DuelInfo[id][duelTeam][0], DuelInfo[id][duelTeam][1], DuelInfo[id][duelTeam][2]);
				giveDuelDefeat(DuelInfo[id][duelOpponent][0], DuelInfo[id][duelOpponent][1], DuelInfo[id][duelOpponent][2]);

				ServerInfo[duelPlayers] -= DuelInfo[id][duelLineup] * 2;
				updatePlayers3D();

				foreach(new i:Player)
					if(InDuelID[i] == id)
						leaveDuel(i);
			}
			else if(DuelInfo[id][duelTeam2] == DuelInfo[id][duelLineup])
			{
				Iter_Remove(DuelList, id);
				if(DuelInfo[id][duelLineup] == 1)
				{
					format(string, sizeof(string), "1v1 DUEL // "WHITE"%s vs "GREEN"%s (win)"WHITE" finished.", GetName(DuelInfo[id][duelTeam][0]), GetName(DuelInfo[id][duelOpponent][0]));
					SendClientMessageToAll(COL_ORANGE, string);

					#if USE_DISCORD == true
						format(string, sizeof(string), ">>> 1v1 duel has finished. %s vs **%s**", GetName(DuelInfo[id][duelTeam][0]), GetName(DuelInfo[id][duelOpponent][0]));
						DCC_SendChannelMessage(DiscordInfo[event_logs], string);
					#endif
				}
				else if(DuelInfo[id][duelLineup] == 2)
				{
					format(string, sizeof(string), "2v2 DUEL // "WHITE"%s-%s vs "GREEN"%s-%s (win)"WHITE" finished.", GetName(DuelInfo[id][duelTeam][0]), GetName(DuelInfo[id][duelTeam][1]), GetName(DuelInfo[id][duelOpponent][0]), GetName(DuelInfo[id][duelOpponent][1]));
					SendClientMessageToAll(COL_ORANGE, string);

					#if USE_DISCORD == true
						format(string, sizeof(string), ">>> 2v2 duel has finished. %s-%s vs **%s-%s**", GetName(DuelInfo[id][duelTeam][0]), GetName(DuelInfo[id][duelTeam][1]), GetName(DuelInfo[id][duelOpponent][0]), GetName(DuelInfo[id][duelOpponent][1]));
						DCC_SendChannelMessage(DiscordInfo[event_logs], string);
					#endif
				}
				else if(DuelInfo[id][duelLineup] == 3)
				{
					format(string, sizeof(string), "3v3 DUEL // "WHITE"%s-%s-%s vs "GREEN"%s-%s-%s (win)"WHITE" finished.", GetName(DuelInfo[id][duelTeam][0]), GetName(DuelInfo[id][duelTeam][1]), GetName(DuelInfo[id][duelTeam][2]), GetName(DuelInfo[id][duelOpponent][0]), GetName(DuelInfo[id][duelOpponent][1]), GetName(DuelInfo[id][duelOpponent][2]));
					SendClientMessageToAll(COL_ORANGE, string);

					#if USE_DISCORD == true
						format(string, sizeof(string), ">>> 3v3 duel has finished. %s-%s-%s vs **%s-%s-%s**", GetName(DuelInfo[id][duelTeam][0]), GetName(DuelInfo[id][duelTeam][1]), GetName(DuelInfo[id][duelTeam][2]), GetName(DuelInfo[id][duelOpponent][0]), GetName(DuelInfo[id][duelOpponent][1]), GetName(DuelInfo[id][duelOpponent][2]));
						DCC_SendChannelMessage(DiscordInfo[event_logs], string);
					#endif
				}

				giveDuelWin(DuelInfo[id][duelOpponent][0], DuelInfo[id][duelOpponent][1], DuelInfo[id][duelOpponent][2]);
				giveDuelDefeat(DuelInfo[id][duelTeam][0], DuelInfo[id][duelTeam][1], DuelInfo[id][duelTeam][2]);

				ServerInfo[duelPlayers] -= DuelInfo[id][duelLineup] * 2;
				updatePlayers3D();

				foreach(new i:Player)
					if(InDuelID[i] == id)
						leaveDuel(i);
			}

			leaveDuel(playerid);
		}
	}
	#if defined duel_OnPlayerDeath
		return duel_OnPlayerDeath(playerid, killerid, reason);
	#endif
}
#if defined _ALS_OnPlayerDeath
	#undef OnPlayerDeath
#else
	#define _ALS_OnPlayerDeath
#endif

#define OnPlayerDeath duel_OnPlayerDeath
#if defined duel_OnPlayerDeath
	forward duel_OnPlayerDeath(playerid, killerid, reason);
#endif
//==============================================================================//
public OnPlayerDisconnect(playerid, reason)
{
	if(InDuelID[playerid] != -1)
	{
		onPlayerLeaveDuel(playerid, InDuelID[playerid]);
	}

	#if defined duel_OnPlayerDisconnect
		return duel_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect duel_OnPlayerDisconnect
#if defined duel_OnPlayerDisconnect
	forward duel_OnPlayerDisconnect(playerid, reason);
#endif
//==============================================================================//
