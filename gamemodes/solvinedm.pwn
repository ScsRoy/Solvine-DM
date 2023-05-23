//================================== [ Info ] ==================================//
/*
	//////////////////////////
*/
//================================ [ Settings ] ================================//

#define 	IN_DEVELOPMENT			true
#define 	IN_LOCAL				true
#define 	USE_MAPS				true
#define 	USE_DISCORD             false
#define 	USE_AC 					true 

//============================== [ Include List ] ==============================//

#include 	<a_samp>

#undef 	MAX_PLAYERS
const 	MAX_PLAYERS = 100;

#include 	<a_mysql>
#include 	<streamer>
#include 	<sscanf2>
#include 	<Pawn.CMD>
#include    <log-plugin>

//#include 	<foreach>
#include 	<weapon-config>
#include 	<newsamp>
#include 	<progress2>
#include 	<timestamp>

#if USE_DISCORD == true
	#include 	<discord-connector>
#endif

//============================== [ Modules List ] ==============================//

#include 	"modules\core\colors.pwn"
#include 	"modules\core\definitions.pwn" 	
#include 	"modules\core\variables.pwn"	
#include 	"modules\core\enums.pwn"

#include 	"modules\core\weapons.pwn"
//#include 	"modules\core\animated_td.pwn"
#include 	"modules\core\alt_chat.pwn"

#include 	"modules\core\script_init.pwn"
#include 	"modules\core\mysql_tables.pwn"
#include 	"modules\core\functions.pwn"
#include 	"modules\core\callbacks.pwn"
#include 	"modules\core\global_timers.pwn"
#include    "modules\core\antivpn.pwn"

//==============================================================================//

#include 	"modules\gui\#gui_init.pwn"

#include 	"modules\gui\alert_td.pwn"
#include 	"modules\gui\arena_td.pwn"
#include 	"modules\gui\ingame_td.pwn"
#include 	"modules\gui\session_td.pwn"
#include 	"modules\gui\versus_td.pwn"
#include 	"modules\gui\deathcam_td.pwn"
#include 	"modules\gui\whitelist_td.pwn"

//==============================================================================//

#if USE_MAPS == true
	#include "modules\maps\#map_init.pwn"

	#include "modules\maps\jail.pwn"
	//#include "modules\maps\hall_of_fame.pwn"
	#include "modules\maps\leaderboard.pwn"
	#include "modules\maps\screenshare.pwn"
    #include "modules\maps\spawn.pwn"
#endif

//=============================== [ ServerSide ] ===============================//

#include 	"modules\server_side\#core\#server_functions.pwn"
#include 	"modules\server_side\#core\#server_callbacks.pwn"
#include 	"modules\server_side\#core\server_create.pwn"
#include 	"modules\server_side\#core\server_delete.pwn"

//=======================================//

#if USE_AC == true

#endif

//=======================================//

#if USE_DISCORD == true
	#include 	"modules\server_side\discord\discord_functions.pwn"
	#include 	"modules\server_side\discord\discord_callbacks.pwn"
#endif

//=============================== [ PlayerSide ] ===============================//

#include 	"modules\player_side\#core\#player_saving.pwn"
//#include 	"modules\player_side\#core\player_whitelist.pwn"
#include 	"modules\player_side\#core\player_register.pwn"
#include 	"modules\player_side\#core\player_login.pwn"
#include 	"modules\player_side\#core\player_functions.pwn"

//=======================================//

#include 	"modules\player_side\admin\admin_functions.pwn"
#include 	"modules\player_side\admin\admin_callbacks.pwn"
#include 	"modules\player_side\admin\admin_commands.pwn"

//=======================================//

#include 	"modules\player_side\premium\premium_functions.pwn"
#include 	"modules\player_side\premium\premium_callbacks.pwn"
#include 	"modules\player_side\premium\premium_commands.pwn"

//=======================================//

#include 	"modules\player_side\rank\rank_functions.pwn"
#include 	"modules\player_side\rank\rank_callbacks.pwn"

//=======================================//

#include 	"modules\player_side\arena\arena_functions.pwn"
#include 	"modules\player_side\arena\arena_callbacks.pwn"

//=======================================//

#include 	"modules\player_side\duel\duel_functions.pwn"
#include 	"modules\player_side\duel\duel_callbacks.pwn"

//=======================================//

#include 	"modules\player_side\versus\versus_functions.pwn"
#include 	"modules\player_side\versus\versus_callbacks.pwn"

//==============================================================================//

#include 	"modules\other\#help.pwn"
#include 	"modules\other\settings.pwn"
#include 	"modules\other\top10.pwn"
#include 	"modules\other\commands.pwn"
#include 	"modules\other\private_message.pwn"
#include 	"modules\other\report.pwn"
#include 	"modules\other\deathmatcher.pwn"
#include 	"modules\other\record.pwn"
#include 	"modules\other\cbug.pwn"
#include 	"modules\other\anims.pwn"
#include 	"modules\other\fame.pwn"
// #include 	"modules\other\baloon.pwn"

//==============================================================================//

#include 	"modules\core\script_exit.pwn"
new DMActor,
	HelpActor,
	DuelActor,
	DlActor,
	VersusActor;

//==============================================================================//
main() 
{
	if(MAX_PLAYERS != GetMaxPlayers())
	{
		printf("MAX_PLAYERS (%d) must be same as 'maxplayers' (%d) in server.cfg", MAX_PLAYERS, GetMaxPlayers());
	}

	print(" ");
	print("=======================================");
	print(" ");
	print("> >: // Sol-Vine Deathmatch //");
	print("> "FORUM"");
	print("> "FB"");
	print(" ");
	print("> Owner: \t\t\t"OWNER"");
	print("> Co-Owner: \t\t\t"DIRECTOR"");
	print("> Developer: \t\t\t"SCRIPTER"");
	print("> Maper: \t\t\t"MAPER"");
	print(" ");
	print("> Language: \t\t\t"LANGUAGE"");
	print("> Version: \t\t\t"V_MOD"");
	print("> Last update: \t\t\t"ZADNJI_UP"");
	print("> Project started: \t\t"PROJECT_STARTED"");
	print(" ");
	printf("> Gamemode loaded in: \t\t%dms", GetTickCount()-GMLoading);
	print(" ");
	print("=======================================");

	GMLoading = gettime();
	return 1;
}
//==============================================================================//
public OnGameModeInit()
{
	DMActor = CreateDynamicActor(294, 778.9506, 2569.3298, 1389.4153, 40);
    CreateDynamic3DTextLabel("Bobbys", -1, 778.9506, 2569.3298, 1389.4153, 40);
    HelpActor = CreateDynamicActor(294, 791.9820, 2569.1760, 1389.4153, 40);
    CreateDynamic3DTextLabel("None", -1, 791.9820, 2569.1760, 1389.4153, 40);
    DuelActor = CreateDynamicActor(294, 792.1537, 2585.4741, 1389.4153, 40);
    CreateDynamic3DTextLabel("None", -1, 792.1537, 2585.4741, 1389.4153, 40);
	VersusActor = CreateDynamicActor(294, 778.7620, 2585.2839, 1389.4153, 40);
    CreateDynamic3DTextLabel("None", -1, 778.7620, 2585.2839, 1389.4153, 40);
    CreateDynamic3DTextLabel("{FFFFFF}>< Sol-Vine DeathMatch ><\n Founders/Owners: {1C77DE}Bobbys\n{FFFFFF}Version: {1C77DE}BETA TEST{FFFFFF}", -1, 786.4402,2577.5664,1388.3241, 40);
	return 1;
}
//==============================================================================//
public OnPlayerConnect(playerid)
{

	return 1;
}
//==============================================================================//
public OnPlayerDisconnect(playerid, reason)
{

	return 1;
}

//==============================================================================//
public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags) 
{
	
	return 1;
}
//==============================================================================//
public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{

	return 1;
}
//==============================================================================//
public OnPlayerSpawn(playerid)
{

	return 1;
}
//==============================================================================//
public OnPlayerDeath(playerid, killerid, reason)
{

	return 1;
}
//==============================================================================//
public OnPlayerText(playerid, text[])
{

	return 0;
}
//==============================================================================//
public OnPlayerUpdate(playerid)
{

	return 1;
}
//==============================================================================//
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{

	return 1;
}
//==============================================================================//
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{

	return 0;
}
//==============================================================================//
public OnPlayerGiveDamageDynamicActor(playerid, actorid, Float:amount, weaponid, bodypart)
{
	if(actorid == DMActor)
	{
	    callcmd::DMlist(playerid);
	}
	if(actorid == HelpActor)
	{
	    callcmd::help(playerid);
	}
	if(actorid == DlActor)
	{
	    callcmd::duel(playerid);
	}
	if(actorid == VersusActor)
	{
	    callcmd::versus(playerid);
	}
	if(actorid == DuelActor)
	{
	    callcmd::stats(playerid);
	}
	return 1;
}
//==============================================================================//
public OnPlayerHideCursor(playerid, hovercolor)
{

	return 1;
}
//==============================================================================//
public OnPlayerPause(playerid)
{

	return 1;
}
//==============================================================================//
#if USE_DISCORD == true
public DCC_OnMessageCreate(DCC_Message:message)
{

	return 1;
}
#endif
//==============================================================================//
public OnPlayerDamage(&playerid, &Float:amount, &issuerid, &weapon, &bodypart)
{

	return 1;
}
//==============================================================================//
