//==============================================================================//
/*
	* Module: anims.pwn
	* Author: Sule
	* Date: 23.04.2020
*/
//==============================================================================//
new anim_libs[134][13] = 
{
	"AIRPORT",      "ATTRACTORS",   "BAR",          "BASEBALL",     "BD_FIRE",
	"BEACH",        "BENCHPRESS",   "BF_INJECTION", "BIKE_DBZ",     "BIKED",
	"BIKEH",        "BIKELEAP",     "BIKES",        "BIKEV",        "BLOWJOBZ",
	"BMX",          "BOMBER",       "BOX",          "BSKTBALL",     "BUDDY",
	"BUS",          "CAMERA",       "CAR",          "CAR_CHAT",     "CARRY",
	"CASINO",       "CHAINSAW",     "CHOPPA",       "CLOTHES",      "COACH",
	"COLT45",       "COP_AMBIENT",  "COP_DVBYZ",    "CRACK",        "CRIB",
	"DAM_JUMP",     "DANCING",      "DEALER",       "DILDO",        "DODGE",
	"DOZER",        "DRIVEBYS",     "FAT",          "FIGHT_B",      "FIGHT_C",
	"FIGHT_D",      "FIGHT_E",      "FINALE",       "FINALE2",      "FLAME",
	"FLOWERS",      "FOOD",         "FREEWEIGHTS",  "GANGS",        "GFUNK",
	"GHANDS",       "GHETTO_DB",    "GOGGLES",      "GRAFFITI",     "GRAVEYARD",
	"GRENADE",      "GYMNASIUM",    "HAIRCUTS",     "HEIST9",       "INT_HOUSE",
	"INT_OFFICE",   "INT_SHOP",     "JST_BUISNESS", "KART",         "KISSING",
	"KNIFE",        "LAPDAN1",      "LAPDAN2",      "LAPDAN3",      "LOWRIDER",
	"MD_CHASE",     "MD_END",       "MEDIC",        "MISC",         "MTB",
	"MUSCULAR",     "NEVADA",       "ON_LOOKERS",   "OTB",          "PARACHUTE",
	"PARK",         "PAULNMAC",     "PED",          "PLAYER_DVBYS", "PLAYIDLES",
	"POLICE",       "POOL",         "POOR",         "PYTHON",       "QUAD",
	"QUAD_DBZ",     "RAPPING",      "RIFLE",        "RIOT",         "ROB_BANK",
	"ROCKET",       "RUNNINGMAN",   "RUSTLER",      "RYDER",        "SCRATCHING",
	"SEX",          "SHAMAL",       "SHOP",         "SHOTGUN",      "SILENCED",
	"SKATE",        "SMOKING",      "SNIPER",       "SNM",          "SPRAYCAN",
	"STRIP",        "SUNBATHE",     "SWAT",         "SWEET",        "SWIM",
	"SWORD",        "TANK",         "TATTOOS",      "TEC",          "TRAIN",
	"TRUCK",        "UZI",          "VAN",          "VENDING",      "VORTEX",
	"WAYFARER",     "WEAPONS",      "WOP",          "WUZI"
};
//=====================================//
PreloadAnimations(playerid)
{
	for(new i = 0; i < sizeof(anim_libs); i++) 
	{
		ApplyAnimation(playerid, anim_libs[i], "null", 4.0, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}
//=====================================//
AC_ApplyAnimation(playerid, lib[], name[], Float:fDelta, loop, lockx, locky, freeze, time, forcesync = 0)
{
	ApplyAnimation(playerid, lib, name, Float:fDelta, loop, lockx, locky, freeze, time, forcesync);
	ApplyAnimation(playerid, lib, name, Float:fDelta, loop, lockx, locky, freeze, time, forcesync);
	ApplyAnimation(playerid, lib, name, Float:fDelta, loop, lockx, locky, freeze, time, forcesync);
	ApplyAnimation(playerid, lib, name, Float:fDelta, loop, lockx, locky, freeze, time, forcesync);

	TextDrawHideForPlayer(playerid, animTD);
	return 1;
}
//==============================================================================//
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(IsKeyJustDown(KEY_HANDBRAKE, newkeys, oldkeys) && AnimLooping[playerid]) 
	{
		StopLoopingAnim(playerid);
		return 1;
	}
	
	#if defined anims_OnPlayerKeyStateChange
		return anims_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange anims_OnPlayerKeyStateChange
#if defined anims_OnPlayerKeyStateChange
	forward anims_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif
//==============================================================================//
IsKeyJustDown(key, newkeys, oldkeys)
{
	if((newkeys & key) && !(oldkeys & key)) return 1;
	return 0;
}
//=====================================//
OnePlayAnim(playerid, lib[], name[], Float:speed, looping, lockx, locky, lockz, lp)
{
	if(AnimLooping[playerid] == 1) TextDrawShowForPlayer(playerid, animTD);
	return AC_ApplyAnimation(playerid, lib, name, speed, looping, lockx, locky, lockz, lp, 1);
}
//=====================================//
LoopingAnim(playerid, lib[], name[], Float:speed, looping, lockx, locky, lockz, lp)
{
	if(AnimLooping[playerid] == 1) TextDrawShowForPlayer(playerid, animTD);
	AnimLooping[playerid] = 1;
	TextDrawShowForPlayer(playerid, animTD);
	return AC_ApplyAnimation(playerid, lib, name, speed, looping, lockx, locky, lockz, lp, 1);
}
//=====================================//
StopLoopingAnim(playerid)
{
	AnimLooping[playerid] = 0;
	TextDrawHideForPlayer(playerid, animTD);
	AC_ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
}
//==============================================================================//
CMD:animations(playerid) 
{
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	ShowPlayerDialog(playerid, SHOW_ONLY, DIALOG_STYLE_MSGBOX, ""GREEN"M:DM // "WHITE"Animacije", "\
		"GREEN"________________________________________"WHITE"________________________________________\n\
		"GREEN"> "WHITE"/clearanim - /drunk - /crossarms - /lay - /wave - slapass - slapped - crack\n\
		"GREEN"> "WHITE"/fuckit - /fucku - /piss - /fwalk - /palmbitch - /dealer - /dealstance - /pee\n\
		"GREEN"> "WHITE"/stand - /scratch - /surrender - /sit - /dance - /cross - /jiggy - /chat - /sup\n\
		"GREEN"> "WHITE"/strip - wank - /sexy - /bj - /kiss\n\
		"GREEN"________________________________________"WHITE"________________________________________\n\
		", "UREDU", "");
	return 1;
}
alias:animations("anims");
//=====================================//
CMD:clearanim(playerid)
{ 
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations.");
	AC_ApplyAnimation(playerid, "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0, 1);
	return 1;
}
//==============================================================================//
CMD:drunk(playerid)
{ 
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations.");
	LoopingAnim(playerid, "PED", "WALK_DRUNK",4.1,1,1,1,1,1);
	return 1;
}
//=====================================//
CMD:crossarms(playerid)
{ 
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations.");
	LoopingAnim(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1); // Arms crossed
	return 1;
}
//=====================================//
CMD:lay(playerid)
{ 
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations.");
	LoopingAnim(playerid, "SUNBATHE", "Lay_Bac_in",3.0,0,1,1,1,0);
	return 1;
}
//=====================================//
CMD:wave(playerid)
{ 
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations.");
	LoopingAnim(playerid, "ON_LOOKERS", "wave_loop", 4.0, 1, 0, 0, 0, 0); // Wave 
	return 1;
}
//=====================================//
CMD:slapass(playerid)
{ 
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations.");
	OnePlayAnim(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0); // Ass Slapping
	return 1;
}
//=====================================//
CMD:slapped(playerid)
{
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations."); 
	AC_ApplyAnimation(playerid, "SWEET", "ho_ass_slapped",4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}
//=====================================//
CMD:crack(playerid)
{ 
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations.");
	LoopingAnim(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0); // Dieing of Crack 
	return 1;
}
//=====================================//
CMD:fuckit(playerid)
{ 
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations.");
	OnePlayAnim(playerid, "RYDER", "RYD_Beckon_03",4.1,0,0,0,0,0);
	return 1;
}
//=====================================//
CMD:fucku(playerid)
{ 
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations.");
	OnePlayAnim(playerid, "PED", "fucku",4.0,0,0,0,0,0);
	return 1;
}
//=====================================//
CMD:piss(playerid)
{ 
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations.");
	LoopingAnim(playerid, "PAULNMAC", "Piss_in", 3.0, 0, 0, 0, 0, 0);
	return 1;
}
//=====================================//
CMD:fwalk(playerid)
{ 
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations.");
	LoopingAnim(playerid, "PED", "WOMAN_walksexy",4.1,1,1,1,1,1);
	return 1;
}
//=====================================//
CMD:palmbitch(playerid)	 
{ 
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations."); 
	AC_ApplyAnimation(playerid, "MISC", "bitchslap",4.1, 0, 1, 1, 1, 1, 1);
	return 1; 
}
//=====================================//
CMD:dealer(playerid)
{
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations."); 
	AC_ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.1, 0, 1, 1, 1, 1, 1); // Deal Drugs
	return 1;
}
//=====================================//
CMD:dealstance(playerid)
{
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations."); 
	AC_ApplyAnimation(playerid, "DEALER", "DEALER_IDLE",4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}
//=====================================//
CMD:pee(playerid)
{
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations."); 
	SetPlayerSpecialAction(playerid, 68);
	return 1;
}
//=====================================//
CMD:stand(playerid)
{
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations."); 
	AC_ApplyAnimation(playerid, "WUZI", "Wuzi_stand_loop", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}
//=====================================//
CMD:scratch(playerid)
{
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations."); 
	AC_ApplyAnimation(playerid, "MISC", "Scratchballs_01", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}
//=====================================//
CMD:surrender(playerid)
{
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations."); 
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_HANDSUP);
	return 1;
}
//==============================================================================//
CMD:sit(playerid, params[])
{ 
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations.");
	if(sscanf(params, "d", params[0])) return UsageMessage(playerid, "sit [1-5]");
	switch(params[0])
	{
		case 1: AC_ApplyAnimation(playerid, "BEACH", "bather",4.1, 0, 1, 1, 1, 1, 1);
		case 2: AC_ApplyAnimation(playerid, "BEACH", "Lay_Bac_Loop",4.1, 0, 1, 1, 1, 1, 1);
		case 3: AC_ApplyAnimation(playerid, "BEACH", "ParkSit_W_loop",4.1, 0, 1, 1, 1, 1, 1);
		case 4: AC_ApplyAnimation(playerid, "BEACH", "SitnWait_loop_W",4.1, 0, 1, 1, 1, 1, 1);
		case 5: AC_ApplyAnimation(playerid, "BEACH", "SitnWait_loop_W",4.1, 0, 1, 1, 1, 1, 1);
		case 6: AC_ApplyAnimation(playerid, "BEACH", "ParkSit_M_loop", 4.1, 0, 1, 1, 1, 1, 1);
		default: return UsageMessage(playerid, "sit [1-5]");
	}
	return 1;
}
//=====================================//
CMD:dance(playerid, params[])
{ 
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations."); 
	if(sscanf(params, "i", params[0])) return UsageMessage(playerid, "dance [1-4]");
	switch(params[0])
	{
		case 1: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE1);
		case 2: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE2);
		case 3: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE3);
		case 4: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE4);
		default: UsageMessage(playerid, "dance [1-4]"); 	
	}
	return 1;
}
//=====================================//
CMD:cross(playerid, params[])
{
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations."); 
	if(sscanf(params, "d", params[0])) return UsageMessage(playerid, "cross [1-5]");
	switch(params[0])
	{
		case 1: AC_ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.1, 0, 1, 1, 1, 1, 1);
		case 2: AC_ApplyAnimation(playerid, "DEALER", "DEALER_IDLE", 4.1, 0, 1, 1, 1, 1, 1);
		case 3: AC_ApplyAnimation(playerid, "DEALER", "DEALER_IDLE_01", 4.1, 0, 1, 1, 1, 1, 1);
		case 4: AC_ApplyAnimation(playerid, "GRAVEYARD", "mrnM_loop",4.1, 0, 1, 1, 1, 1, 1);
		case 5: AC_ApplyAnimation(playerid, "GRAVEYARD", "prst_loopa",4.1, 0, 1, 1, 1, 1, 1);
		default: return UsageMessage(playerid, "cross [1-5]");
	}
	return 1;
}
//=====================================//
CMD:jiggy(playerid, params[])
{
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations."); 
	if(sscanf(params, "d", params[0])) return UsageMessage(playerid, "jiggy [1-10]");
	switch(params[0])
	{
		case 1: AC_ApplyAnimation(playerid, "DANCING", "DAN_Down_A",4.1, 0, 1, 1, 1, 1, 1);
		case 2: AC_ApplyAnimation(playerid, "DANCING", "DAN_Left_A",4.1, 0, 1, 1, 1, 1, 1);
		case 3: AC_ApplyAnimation(playerid, "DANCING", "DAN_Loop_A",4.1, 0, 1, 1, 1, 1, 1);
		case 4: AC_ApplyAnimation(playerid, "DANCING", "DAN_Right_A",4.1, 0, 1, 1, 1, 1, 1);
		case 5: AC_ApplyAnimation(playerid, "DANCING", "DAN_Up_A",4.1, 0, 1, 1, 1, 1, 1);
		case 6: AC_ApplyAnimation(playerid, "DANCING", "dnce_M_a",4.1, 0, 1, 1, 1, 1, 1);
		case 7: AC_ApplyAnimation(playerid, "DANCING", "dnce_M_b",4.1, 0, 1, 1, 1, 1, 1);
		case 8: AC_ApplyAnimation(playerid, "DANCING", "dnce_M_c",4.1, 0, 1, 1, 1, 1, 1);
		case 9: AC_ApplyAnimation(playerid, "DANCING", "dnce_M_c",4.1, 0, 1, 1, 1, 1, 1);
		case 10: AC_ApplyAnimation(playerid, "DANCING", "dnce_M_d",4.1, 0, 1, 1, 1, 1, 1);
		default: return UsageMessage(playerid, "jiggy [1-10]");
	}
	return 1;
}
//=====================================//
CMD:chat(playerid, params[])
{ 
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations.");
	if(sscanf(params, "i", params[0])) return UsageMessage(playerid, "chat [1-2]");
	switch(params[0])
	{
		case 1: AC_ApplyAnimation(playerid, "PED", "IDLE_CHAT",4.1, 0, 1, 1, 1, 1, 1);
		case 2: AC_ApplyAnimation(playerid, "MISC", "Idle_Chat_02",4.1, 0, 1, 1, 1, 1, 1); 
		default: UsageMessage(playerid, "chat [1-2]");
	}
	return 1;
}
//=====================================//
CMD:sup(playerid, params[])
{ 
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations.");
	if(sscanf(params, "i", params[0])) return UsageMessage(playerid, "sup [1-3]");
	switch(params[0])
	{
		case 1: AC_ApplyAnimation(playerid, "GANGS", "hndshkba",4.1, 0, 1, 1, 1, 1, 1); 
		case 2: AC_ApplyAnimation(playerid, "GANGS", "hndshkda",4.1, 0, 1, 1, 1, 1, 1);
		case 3: AC_ApplyAnimation(playerid, "GANGS", "hndshkfa_swt",4.1, 0, 1, 1, 1, 1, 1);
		default: UsageMessage(playerid, "sup [1-3]");
	}
	return 1;
}
//=====================================//
CMD:strip(playerid, params[])
{ 
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations.");
	if(sscanf(params, "i", params[0])) return UsageMessage(playerid, "strip [1-7]");
	switch(params[0])
	{
		case 1: AC_ApplyAnimation(playerid, "STRIP", "strip_A", 4.1, 0, 1, 1, 1, 1, 1 ); 
		case 2: AC_ApplyAnimation(playerid, "STRIP", "strip_B", 4.1, 0, 1, 1, 1, 1, 1 ); 
		case 3: AC_ApplyAnimation(playerid, "STRIP", "strip_C", 4.1, 0, 1, 1, 1, 1, 1 ); 
		case 4: AC_ApplyAnimation(playerid, "STRIP", "strip_D", 4.1, 0, 1, 1, 1, 1, 1 ); 
		case 5: AC_ApplyAnimation(playerid, "STRIP", "strip_E", 4.1, 0, 1, 1, 1, 1, 1 ); 
		case 6: AC_ApplyAnimation(playerid, "STRIP", "strip_F", 4.1, 0, 1, 1, 1, 1, 1 ); 
		case 7: AC_ApplyAnimation(playerid, "STRIP", "strip_G", 4.1, 0, 1, 1, 1, 1, 1 ); 
		default: UsageMessage(playerid, "strip [1-7]");
	}
	return 1;
}
//=====================================//
CMD:wank(playerid, params[])
{ 
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations.");
	if(sscanf(params, "i", params[0])) return UsageMessage(playerid, "wank [1-2]");
	switch(params[0])
	{
		case 1: AC_ApplyAnimation(playerid, "PAULNMAC", "wank_in",4.1, 0, 1, 1, 1, 1, 1);
		case 2: AC_ApplyAnimation(playerid, "PAULNMAC", "wank_loop",4.1, 0, 1, 1, 1, 1, 1);
		default: UsageMessage(playerid, "wank [1-2]");
	}
	return 1;
}
//=====================================//
CMD:sexy(playerid, params[])
{ 
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations.");
	if(sscanf(params, "i", params[0])) return UsageMessage(playerid, "sexy [1-8]");
	switch(params[0])
	{
		case 1: AC_ApplyAnimation(playerid, "SNM", "SPANKING_IDLEW",4.1, 0, 1, 1, 1, 1, 1);
		case 2: AC_ApplyAnimation(playerid, "SNM", "SPANKING_IDLEP",4.1, 0, 1, 1, 1, 1, 1);
		case 3: AC_ApplyAnimation(playerid, "SNM", "SPANKINGW",4.1, 0, 1, 1, 1, 1, 1);
		case 4: AC_ApplyAnimation(playerid, "SNM", "SPANKINGP",4.1, 0, 1, 1, 1, 1, 1);
		case 5: AC_ApplyAnimation(playerid, "SNM", "SPANKEDW",4.1, 0, 1, 1, 1, 1, 1);
		case 6: AC_ApplyAnimation(playerid, "SNM", "SPANKEDP",4.1, 0, 1, 1, 1, 1, 1);
		case 7: AC_ApplyAnimation(playerid, "SNM", "SPANKING_ENDW",4.1, 0, 1, 1, 1, 1, 1);
		case 8: AC_ApplyAnimation(playerid, "SNM", "SPANKING_ENDP",4.1, 0, 1, 1, 1, 1, 1);
		default: UsageMessage(playerid, "sexy [1-8]");
	}
	return 1;
}
//=====================================//
CMD:bj(playerid, params[])
{ 
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations.");
	if(sscanf(params, "i", params[0])) return UsageMessage(playerid, "bj [1-4]");
	switch(params[0])
	{
		case 1: AC_ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_START_P",4.1, 0, 1, 1, 1, 1, 1);
		case 2: AC_ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_START_W",4.1, 0, 1, 1, 1, 1, 1);
		case 3: AC_ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_P",4.1, 0, 1, 1, 1, 1, 1);
		case 4: AC_ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_W",4.1, 0, 1, 1, 1, 1, 1);
		default: UsageMessage(playerid, "bj [1-4]");
	}
	return 1;
}
//=====================================//
CMD:kiss(playerid, params[])
{ 
	if(!PI[playerid][pPremium] && PI[playerid][pAdmin] < 1) return ErrorMessage(playerid, "You are not allowed to use this command.");
	if(!InLobby[playerid] && !InFreeroam[playerid]) return ErrorMessage(playerid, "You have to be in lobby or freeroam to use this command.");
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return ErrorMessage(playerid, "You have to be outside vehicle to use animations.");
	if(sscanf(params, "i", params[0])) return UsageMessage(playerid, "kiss [1-6]");
	switch(params[0])
	{
		case 1: LoopingAnim(playerid, "KISSING", "Grlfrd_Kiss_01", 4.0, 0, 1, 1, 1, 0);
		case 2: LoopingAnim(playerid, "KISSING", "Grlfrd_Kiss_02", 4.0, 0, 1, 1, 1, 0);
		case 3: LoopingAnim(playerid, "KISSING", "Grlfrd_Kiss_03", 4.0, 0, 1, 1, 1, 0);
		case 4: LoopingAnim(playerid, "KISSING", "Playa_Kiss_01", 4.0, 0, 1, 1, 1, 0);
		case 5: LoopingAnim(playerid, "KISSING", "Playa_Kiss_02", 4.0, 0, 1, 1, 1, 0);
		case 6: LoopingAnim(playerid, "KISSING", "Playa_Kiss_03", 4.0, 0, 1, 1, 1, 0);
		default: UsageMessage(playerid, "kiss [1-6]");
	}
	return 1;
}
//==============================================================================//