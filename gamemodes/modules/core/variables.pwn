//==============================================================================//
/*
	* Module: variables.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
new ImeVozila[212][20] =
{
	"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel",
	"Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
	"Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
	"Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection",
	"Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus",
	"Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie",
	"Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral",
	"Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder",
	"Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", "Berkley's RC Van",
	"Skimmer", "PCJ-600", "Faggio", "Division", "RC Baron", "RC Raider", "Glendale",
	"Oceanic","Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy",
	"Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX",
	"Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper",
	"Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking",
	"Blista Compact", "Police Maverick", "Boxvillde", "Benson", "Mesa", "RC Goblin",
	"Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher", "Super GT",
	"Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt",
	"Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra",
	"FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune",
	"Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer",
	"Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortefx", "Vincent",
	"Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo",
	"Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite",
	"Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratum",
	"Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
	"Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper",
	"Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400",
	"News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
	"Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car",
	"Police Car", "Police Car", "Police Ranger", "Picador", "S.W.A.T", "Alpha",
	"Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs", "Boxville",
	"Tiller", "Utility Trailer"
};
//==============================================================================//
new Float:RandomSpawn[18][4]=
{
	{ 777.4438,2577.3901,1388.3441,263.1091 },
	{ 777.4438,2577.3901,1388.3441,263.1091 },
	{ 777.4438,2577.3901,1388.3441,263.1091 },
	{ 777.4438,2577.3901,1388.3441,263.1091 },
	{ 777.4438,2577.3901,1388.3441,263.1091 },
	{ 777.4438,2577.3901,1388.3441,263.1091 },
	{ 777.4438,2577.3901,1388.3441,263.1091 },
	{ 777.4438,2577.3901,1388.3441,263.1091 },
	{ 777.4438,2577.3901,1388.3441,263.1091 },
	{ 777.4438,2577.3901,1388.3441,263.1091 },
	{ 777.4438,2577.3901,1388.3441,263.1091 },
	{ 777.4438,2577.3901,1388.3441,263.1091 },
	{ 777.4438,2577.3901,1388.3441,263.1091 },
	{ 777.4438,2577.3901,1388.3441,263.10919 },
	{ 777.4438,2577.3901,1388.3441,263.1091 },
	{ 777.4438,2577.3901,1388.3441,263.1091 },
	{ 777.4438,2577.3901,1388.3441,263.1091 },
	{ 777.4438,2577.3901,1388.3441,263.1091 }
};
new Float:RandomJail[18][4]=
{
	{ 205.5992, 1422.0607, 555.2059, 90.0000 },
	{ 205.5773, 1417.3547, 555.2059, 90.0000 },
	{ 205.4806, 1413.9348, 555.2059, 90.0000 },
	{ 205.0997, 1409.6476, 555.2059, 90.0000 },
	{ 205.1935, 1405.7209, 555.2059, 90.0000 },
	{ 205.5229, 1401.9105, 555.2059, 90.0000 },
	{ 205.5482, 1397.7076, 555.2059, 90.0000 },
	{ 205.5077, 1394.0930, 555.2059, 90.0000 },
	{ 205.1872, 1389.6825, 555.2059, 90.0000 },
	{ 205.6698, 1421.6434, 551.2960, 90.0000 },
	{ 205.6938, 1417.1031, 551.2960, 90.0000 },
	{ 205.7582, 1413.6224, 551.2960, 90.0000 },
	{ 205.7404, 1409.7777, 551.2960, 90.0000 },
	{ 205.3468, 1405.7737, 551.2960, 90.0000 },
	{ 205.7301, 1401.4211, 551.2960, 90.0000 },
	{ 205.5218, 1397.7760, 551.2960, 90.0000 },
	{ 205.3615, 1393.8834, 551.2960, 90.0000 },
	{ 205.2211, 1389.7588, 551.2960, 90.0000 }
};
//==============================================================================//
new PlayerColors[] = 
{
	0xFF8C13FF, 0xC715FFFF, 0x20B2AAFF, 0xDC143CFF, 0x6495EDFF, 
	0xf0e68cFF, 0x778899FF, 0xFF1493FF, 0xF4A460FF, 0xEE82EEFF,
	0xFFD720FF, 0x8b4513FF, 0x4949A0FF, 0x148b8bFF, 0x14ff7fFF, 
	0x556b2fFF, 0x0FD9FAFF, 0x10DC29FF, 0x534081FF, 0x0495CDFF,
	0xEF6CE8FF, 0xBD34DAFF, 0x247C1BFF, 0x0C8E5DFF, 0x635B03FF, 
	0xCB7ED3FF, 0x65ADEBFF, 0x5C1ACCFF, 0xF2F853FF, 0x11F891FF,
	0x7B39AAFF, 0x53EB10FF, 0x54137DFF, 0x275222FF, 0xF09F5BFF, 
	0x3D0A4FFF, 0x22F767FF, 0xD63034FF, 0x9A6980FF, 0xDFB935FF,
	0x3793FAFF, 0x90239DFF, 0xE9AB2FFF, 0xAF2FF3FF, 0x057F94FF, 
	0xB98519FF, 0x388EEAFF, 0x028151FF, 0xA55043FF, 0x0DE018FF,
	0x93AB1CFF, 0x95BAF0FF, 0x369976FF, 0x18F71FFF, 0x4B8987FF, 
	0x491B9EFF, 0x829DC7FF, 0xBCE635FF, 0xCEA6DFFF, 0x20D4ADFF,
	0x2D74FDFF, 0x3C1C0DFF, 0x12D6D4FF, 0x48C000FF, 0x2A51E2FF, 
	0xE3AC12FF, 0xFC42A8FF, 0x2FC827FF, 0x1A30BFFF, 0xB740C2FF,
	0x42ACF5FF, 0x2FD9DEFF, 0xFAFB71FF, 0x05D1CDFF, 0xC471BDFF, 
	0x94436EFF, 0xC1F7ECFF, 0xCE79EEFF, 0xBD1EF2FF, 0x93B7E4FF,
	0x3214AAFF, 0x184D3BFF, 0xAE4B99FF, 0x7E49D7FF, 0x4C436EFF, 
	0xFA24CCFF, 0xCE76BEFF, 0xA04E0AFF, 0x9F945CFF, 0xDCDE3DFF,
	0x10C9C5FF, 0x70524DFF, 0x0BE472FF, 0x8A2CD7FF, 0x6152C2FF, 
	0xCF72A9FF, 0xE59338FF, 0xEEDC2DFF, 0xD8C762FF, 0x3FE65CFF
};
//==============================================================================//
new Float:LobbyTop5[5][4] = 
{
	{ 1374.64941, -37.85530, 1002.83234, 270.000 },
	{ 1374.64941, -39.15430, 1002.41254, 270.000 },
	{ 1374.64844, -36.55530, 1002.23224, 270.000 },
	{ 1374.64941, -40.45430, 1001.93591, 270.000 },
	{ 1374.64941, -35.25430, 1001.85217, 270.000 }
};
//=======================================//
new Float:BestDuel[4] = 
{
	1376.71045, -42.38430, 1002.33026, 0.000
};
//=======================================//
new Float:BestVersus[4] = 
{
	1378.71045, -42.38430, 1002.33118, 0.000
};
//=======================================//
new Float:BestDaily[4] = 
{
	1378.71045, -33.17420, 1002.33032, 180.000
};
//=======================================//
new Float:BestMonthly[4] = 
{
	1376.71045, -33.17420, 1002.33032, 180.000
};
//=======================================//
//==============================================================================//
enum 
{
	// ---------------- //
	SHOW_ONLY,
	REGISTER_LIST,
	REGISTER_PW,
	REGISTER_SEX,
	REGISTER_FAILED,
	DIALOG_LOGIN,
	ADMIN_LOGIN,

	// ---------------- //
	WL_NAME,
	WL_MAIL,
	WL_DISCORD,
	// ---------------- //
	//HelpActor,
	//DMActor,
	//DuelActor,
	//VersusActor,
	//DlActor,
	// ---------------- //
	SERVER_MENU,
	SERVER_GR,

	SERVER_CONTROL,
	SERVER_CONTROL_NAME1,
	SERVER_CONTROL_NAME2,
	SERVER_VERSUS,

	SERVER_RCON,
	RCON_LOGIN,
	RCON_NAME,
	RCON_MAP,
	RCON_WEB,
	RCON_UNLOCK,
	RCON_LOCK,
	RCON_PW,
	RCON_RR,
	RCON_OFF,

	// ---------------- //
	SERVER_CREATE,
	SERVER_DELETE,

	SERVER_AC, 
	SERVER_GLOBAL,

	// ---------------- //
	CREATE_ARENA,
	ARENA_WEAPONS,
	DELETE_ARENA,

	// ---------------- //
	CREATE_RANK,
	RANK_INFO,
	DELETE_RANK,

	// ---------------- //
	ADMIN_CHAT,

	// ---------------- //
	HELP_A1,
	HELP_A2,
	HELP_A3,	
	
	HELP_PG1,
	HELP_PG2,

	// ---------------- //
	SETTINGS_LIST,
	SETTINGS_NICK,
	SETTINGS_PW,

	// ---------------- //
	DIALOG_REPORT,
	REPORT_LIST,
	REPORT_INFO,

	// ---------------- //
	DUEL_SETUP,
	DUEL_WEAPON1,
	DUEL_WEAPON2,
	DUEL_WEAPON3,
	DUEL_HP,
	DUEL_ARMOUR,
	DUEL_ARENA,
	DUEL_TEAMMATE1,
	DUEL_TEAMMATE2,
	DUEL_OPPONENT1,
	DUEL_OPPONENT2,
	DUEL_OPPONENT3,
	DUEL_INVITE,

	// ---------------- //
	PREMIUM_OBJECT,
	PREMIUM_COLOR,

	// ---------------- //
	TOP10_LIST,
	JOIN_DIALOG,
};
//==============================================================================//

new fast_timer,
	one_second,
	one_minute;

new GMLoading,
	ClearChatTimer,
	StatsInfo,
	ServerActor[9],
	Text3D:Server3D[10],
	ServerPickup[8];

//=======================================//
new Logger:register_log,
	Logger:login_log,
	Logger:rcon_log,
	Logger:kick_log,
	Logger:ban_log,
	Logger:chat_log,
	Logger:kills_log,
	Logger:admin_log,
	Logger:make_remove_log,
	Logger:save_location_log,
	Logger:admin_hacking_log,
	Logger:ac_log,
	Logger:server_control_log,
	Logger:create_log,
	Logger:delete_log,
	Logger:bug_log,
	Logger:pm_log,
	Logger:rename_log,
	Logger:gamemode_log,
	Logger:report_log,
	Logger:owner_msg_log,
	Logger:whitelist_log;
	
//==============================================================================//

// ---------------- // Register
new bool:RegisterPW[MAX_PLAYERS],
	RegisterPass[MAX_PLAYERS][24],
	bool:RegisterSex[MAX_PLAYERS];

// ---------------- // Main
new bool:LoggedIn[MAX_PLAYERS],
	bool:FirstSpawn[MAX_PLAYERS],
	bool:Spawned[MAX_PLAYERS],
	LoginTries[MAX_PLAYERS],
	KS[MAX_PLAYERS],
	bool:InLobby[MAX_PLAYERS],
	bool:InFreeroam[MAX_PLAYERS],
	FPS[MAX_PLAYERS],
	Ping[MAX_PLAYERS],
	Float:PL[MAX_PLAYERS],
	PickupGTC[MAX_PLAYERS],
	AnimLooping[MAX_PLAYERS];

// ---------------- // Admin
new bool:WarnChat[MAX_PLAYERS],
	bool:AdminPreview[MAX_PLAYERS],
	bool:PMPreview[MAX_PLAYERS],
	bool:ACPreview[MAX_PLAYERS],
	ChatTime[MAX_PLAYERS],
	CMDTime[MAX_PLAYERS],
	bool:GodMode[MAX_PLAYERS],
	GodTimer[MAX_PLAYERS],
	TempVehicle[MAX_PLAYERS],
	Float:SpecX[MAX_PLAYERS],
	Float:SpecY[MAX_PLAYERS],
	Float:SpecZ[MAX_PLAYERS],
	Float:SpecA[MAX_PLAYERS],
	SpecInt[MAX_PLAYERS],
	SpecVW[MAX_PLAYERS],
	Spectate[MAX_PLAYERS],
	Screenshare[MAX_PLAYERS];

// ---------------- // Creating
new CreatingID[MAX_PLAYERS],
	CreatingStep[MAX_PLAYERS];

// ---------------- // PM
new bool:PMEnabled[MAX_PLAYERS],
	LastPM[MAX_PLAYERS];

// ---------------- // CBug
new bool:CBugAllowed[MAX_PLAYERS],
	CBugTime[MAX_PLAYERS],
	CBugWarns[MAX_PLAYERS];
	
// ---------------- // AFK
new AFKTimer[MAX_PLAYERS],
	AFKTime[MAX_PLAYERS];
	
// ---------------- // Versus
new Iterator:VersusList<MAX_PLAYERS>;
new bool:InVersus[MAX_PLAYERS],
	bool:VersusActive[MAX_PLAYERS],
	VersusOpponent[MAX_PLAYERS],
	VersusTime[MAX_PLAYERS];
//==============================================================================//

new Text:alertTD[5];
new PlayerText:alertPTD;
new bool:alertTDShown[MAX_PLAYERS];

//=======================================//

new PlayerText:inGamePTD[MAX_PLAYERS][18];
new bool:inGameTDShown[MAX_PLAYERS];

//=======================================//

new Text:arenaTD[10];
new PlayerText:arenaPTD[MAX_PLAYERS][3];
new bool:arenaTDShown[MAX_PLAYERS];

//=======================================//

new Text:sessionTD[2];
new PlayerText:sessionPTD[MAX_PLAYERS];
new bool:sessionTDShown[MAX_PLAYERS];

//=======================================//

new Text:versusTD[3];
new PlayerText:versusPTD[MAX_PLAYERS];
new bool:versusTDShown[MAX_PLAYERS];

//=======================================//

new Text:deathCamTD[8];
new PlayerText:deathCamPTD[MAX_PLAYERS][6];
new PlayerBar:deathCamHP[MAX_PLAYERS];
new PlayerBar:deathCamArmour[MAX_PLAYERS];
new bool:deathCamTDShown[MAX_PLAYERS];

//=======================================//

new Text:whitelistTD[13];
//new bool:whitelistTDShown[MAX_PLAYERS];

//=======================================//

new Text:animTD;
new Text:hitMarkerTD;
new PlayerText:CountDownTD[2];

//==============================================================================//
