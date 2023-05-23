//==============================================================================//
/*
	* Module: premium_callbacks.pwn
	* Author: Sule
	* Date: 22.04.2020
*/
//==============================================================================//
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		//======================================================================//
		case PREMIUM_OBJECT:
		{
			if(!response) return 1;
			if(response)
			{
				switch(listitem)
				{
					case 0://Skini sve objekte
					{
						RemovePlayerAttachedObject(playerid, 0); 
						RemovePlayerAttachedObject(playerid, 1);
						RemovePlayerAttachedObject(playerid, 2);
						RemovePlayerAttachedObject(playerid, 3);
						RemovePlayerAttachedObject(playerid, 4);
						RemovePlayerAttachedObject(playerid, 5);
						RemovePlayerAttachedObject(playerid, 6);
						RemovePlayerAttachedObject(playerid, 7);
						RemovePlayerAttachedObject(playerid, 8); 
						RemovePlayerAttachedObject(playerid, 9);
						RemovePlayerAttachedObject(playerid, 10);

						PremiumMessage(playerid, "You removed all objects you had attached on you.");
					}	
					case 1://Papagaj 
					{
						PremiumMessage(playerid, "You successfully attached 'parrot' on yourself.");
						SetPlayerAttachedObject(playerid,1,19078,1,0.320722,-0.067912,-0.165151,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000); // papagaj
					}
					case 2://Baklja 
					{
						PremiumMessage(playerid, "You successfully attached 'torch' on yourself.");
						SetPlayerAttachedObject(playerid, 2, 3461, 6, 0.069429, 0.032604, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000); // tikitorch01_lvs - baklja
					}
					case 3://Kurac
					{
						PremiumMessage(playerid, "You successfully attached 'dick' on yourself.");
						SetPlayerAttachedObject(playerid, 4, 19086, 8, -0.049768, -0.014062, -0.108385, 87.458297, 263.478149, 184.123764, 0.622413, 1.041609, 1.012785); // ChainsawDildo1 - kurac
					}
					case 4://Dolar
					{
						PremiumMessage(playerid, "You successfully attached 'dollar' on yourself.");
						SetPlayerAttachedObject(playerid, 5, 1274, 1, 0.806575, 0.052928, 0.013146, 0.000000, 87.540878, 0.000000, 1.000000, 1.000000, 1.000000); // bigdollar - dolar
					}
					case 5://Potkovica
					{
						PremiumMessage(playerid, "You successfully attached 'horsehoe' on yourself.");
						SetPlayerAttachedObject(playerid, 6, 954, 1, 0.954922, 0.030687, 0.000000, 0.000000, 268.403228, 0.000000, 1.000000, 1.000000, 1.000000); // cj_horse_Shoe - potkovica
					}
					case 6://Drvo
					{
						PremiumMessage(playerid, "You successfully attached 'tree' on yourself.");
						SetPlayerAttachedObject(playerid, 7, 674, 1, -1.193789, 0.051014, 0.099190, 0.000000, 90.430030, 0.000000, 1.000000, 1.000000, 1.000000); // sm_des_josh_lrg1 - drvo
					}
					case 7://Vodokotlic
					{
						PremiumMessage(playerid, "You successfully attached 'cistern' on yourself.");
						SetPlayerAttachedObject(playerid, 8, 1211, 1, 0.916536, 0.012704, -0.003792, 0.000000, 89.479736, 0.000000, 1.000000, 1.000000, 1.000000); // fire_hydrant - vodokotlic
					}
					case 8://Tabla
					{
						PremiumMessage(playerid, "You successfully attached 'board' on yourself.");
						SetPlayerAttachedObject(playerid, 9, 1233, 6, 0.085374, 0.030156, 1.154913, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000); // noparkingsign1 - tabla
					}
					case 9://Nilski konj 
					{
						PremiumMessage(playerid, "You successfully attached 'hippo' on yourself.");
						SetPlayerAttachedObject(playerid, 8, 1371, 1, 0.177012, 0.000000, -0.008047, 0.000000, 89.795104, 182.353408, 1.000000, 1.000000, 1.000000); // CJ_HIPPO_BIN - nilski
					}
				}
			}
			return 1;
		}
		//======================================================================//
		case PREMIUM_COLOR:
		{
			if(!response) return 1;
			if(response)
			{
				if(strlen(inputtext) < 8) return ShowPlayerDialog(playerid, PREMIUM_COLOR, DIALOG_STYLE_INPUT, ""GREEN"Solvine Deathmatch > "WHITE"Premium [Color]", ""GREEN"> "WHITE"Please, insert the hex color in RRGGBBAA format\n"GREEN"> "WHITE"FF0000FF / 1278CCFF / CC1212FF", "ENTER", "CANCEL");

				new color;
				if(inputtext[0] == '0' && inputtext[1] == 'x') color = HexToInt(inputtext[2]);
				if(inputtext[0] == '#') color = HexToInt(inputtext[1]);
		        else color = HexToInt(inputtext);

		        SetPlayerColor(playerid, color);

		        PremiumMessage(playerid, "You successfully changed your color. (%s)", inputtext);
			}
			return 1;
		}
		//======================================================================//
	}

	#if defined vip_OnDialogResponse
		return vip_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnDialogResponse
	#undef OnDialogResponse
#else
	#define _ALS_OnDialogResponse
#endif

#define OnDialogResponse vip_OnDialogResponse
#if defined vip_OnDialogResponse
	forward vip_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif
//==============================================================================//
public OnPlayerDisconnect(playerid, reason)
{
	// ---------------- //
	
	if(TempVehicle[playerid] != -1) 
	{ 
		DestroyVehicle(TempVehicle[playerid]);
		TempVehicle[playerid] = -1; 
	}
	
	// ---------------- //	

	#if defined vip_OnPlayerDisconnect
		return vip_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect vip_OnPlayerDisconnect
#if defined vip_OnPlayerDisconnect
	forward vip_OnPlayerDisconnect(playerid, reason);
#endif
//==============================================================================//
