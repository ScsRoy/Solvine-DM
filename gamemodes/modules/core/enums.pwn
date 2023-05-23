//==============================================================================//
/*
	* Module: enums.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
#define 	USER_DB 					"`user`"
#define 	BAN_DB						"`ban`"
//==============================================================================//
enum playerInfo
{
	pID,
	pName[MAX_PLAYER_NAME],
	pIP[16],
	pPassword[65],
	bool:pSex,
	pRegDate[24],
	pLastLogin[24],
	bool:pOnline,
	pHours,
	pMinutes,

	pAdmin,
	pAdminCode,
	bool:pPremium,
	pPremiumHours,
	pMute,
	pMuteReason[16],
	pJail,
	pJailReason[16],
	pWarn,

	pSkinID,
	pKills,
	pDeaths,
	pMaxKS,
	pMoney,
	pDayKills,
	pDayDeaths,
	pDayWins,
	pMonthKills,
	pMonthDeaths,
	pMonthWins,

	pRank,
	pArenaKills,
	pArenaDeaths,
	pDuelWins,
	pDuelDefeats,
	pVersusWins,
	pVersusDefeats,
}
new PI[MAX_PLAYERS][playerInfo];
//==============================================================================//
#if USE_AC == true

#endif
//==============================================================================//
#define 	SERVER_DB					"`server-info`"
//=======================================//
enum serverInfo
{
	serverPoseta,
	serverRecord,
	serverUpozorenih,
	serverKikovanih,
	serverBanovanih,
	serverUsers,
	serverWhitelisted,

	bool:serverRegistration,
	bool:serverWL,
	serverName1[72],
	serverName2[72],
	bool:serverArena,
	bool:serverDuel,
	bool:serverVersus,
	versusWeapon,
	bool:serverFreeroam,

	dayID,
	dayKills,
	monthID,
	monthKills,

	serverDailyRecord,
	onlinePlayers,
	arenaPlayers,
	duelPlayers,
	versusPlayers,
};
new ServerInfo[serverInfo];
//==============================================================================//
#define 	ARENA_DB 					"`arena`"

#define 	MAX_ARENA_POS 				7

#define 	MAX_ARENA 					20
//=======================================//
enum arenaInfo
{
	arenaID,
	arenaName[24],
	arenaWeapon1,
	arenaWeapon2,
	arenaWeapon3,

	arenaIntID,
	arenaVWID,
	Float:arenaX[MAX_ARENA_POS],
	Float:arenaY[MAX_ARENA_POS],
	Float:arenaZ[MAX_ARENA_POS],
	Float:arenaA[MAX_ARENA_POS],

	arenaKSRecord,
	arenaKSRecorder[MAX_PLAYER_NAME],
	arenaKillsRecord,
	arenaKillsRecorder[MAX_PLAYERS],

	bool:arenaLocked,
	arenaOnline,
}
new ArenaInfo[MAX_ARENA][arenaInfo];
new Iterator:ArenaList<MAX_ARENA>;

new CreatingArena[MAX_PLAYERS],
	EnteredArena[MAX_PLAYERS],
	ChosenArena[MAX_PLAYERS];
//=======================================//
enum sessionInfo
{
	sessionArenaID,
	sessionKills,
	sessionKS,
	sessionDeaths,
	sessionKiller,
	bool:sessionDC,

	sessionHours,
	sessionMinutes,
	sessionSeconds,
}
new SessionInfo[MAX_PLAYERS][sessionInfo];
new SessionTimer[MAX_PLAYERS];
//==============================================================================//
#define 	ADMIN_DB 					"`admin`"
//=======================================//
enum adminInfo
{
	adminID,
	adminName[MAX_PLAYER_NAME],
	adminLevel,

	adminCMD,
	adminBan,
	adminUnban,
	adminWarn,
	adminUnwarn,
	adminKick,
	adminJail,
	adminUnjail,
	adminSpec,

	adminHours,
	adminMinutes,
	adminLastLogin[24],
	bool:adminOnline
}
new AdminInfo[MAX_PLAYERS][adminInfo];
//==============================================================================//
#define 	MAX_REPORT 					25

#define 	REPORT_HACK					1
#define 	REPORT_RULES				2
#define 	REPORT_SPAM 				3
#define 	REPORT_CBUG 				4
#define 	REPORT_ABUSE 				5

//=======================================//
enum reportInfo
{
	reportID,
	reportName[MAX_PLAYER_NAME],
	reportType,
	reportPlayer[MAX_PLAYER_NAME],
}
new ReportInfo[MAX_REPORT][reportInfo];
new Iterator:ReportList<MAX_REPORT>;

new ReportID[MAX_PLAYERS],
	ReportTime[MAX_PLAYERS],
	ChosenReport[MAX_PLAYERS];
//==============================================================================//
#define 	MAX_DUEL 					25

//=======================================//
enum duelInfo
{
	duelWeapon[3],
	Float:duelHP,
	Float:duelArmour,
	bool:duelCBug,
	duelArenaID,
	duelLineup,
	duelTeam[3],
	duelOpponent[3],

	duelTeam1,
	duelTeam2,

	duelPlayers,
	bool:duelStarted,
}
new DuelInfo[MAX_DUEL][duelInfo];
new Iterator:DuelList<MAX_DUEL>;

new	InDuelID[MAX_PLAYERS], 
	DuelInviteID[MAX_PLAYERS],
	DuelInviteTimer[MAX_PLAYERS];
//==============================================================================//
#define 	MAX_RANK 					15

#define 	RANK_DB 					"`rank`"
//=======================================//
enum rankInfo
{
	rankID,
	rankName[24],
	rankPoint, 
	rankReward,
} 
new RankInfo[MAX_RANK][rankInfo];
new Iterator:RankList<MAX_RANK>;
//==============================================================================//
#if USE_DISCORD == true
	//=======================================//
	enum discordInfo
	{
		DCC_Guild:server_id,
		DCC_User:bot_id,

		DCC_Channel:log_in_log_out,
		DCC_Channel:commands,
		DCC_Channel:event_logs,
		DCC_Channel:staff_log,
		DCC_Channel:owner_log,
		DCC_Channel:whitelist,
	}
	new DiscordInfo[discordInfo];
#endif
//==============================================================================//
#define 	MAX_FAME 					12

#define 	MAX_DESCRIPTION				256

#define 	FAME_DB 					"`fame`"
//=======================================//
enum fameInfo
{
	fameID,
	fameName[MAX_PLAYER_NAME],
	fameDescription[MAX_DESCRIPTION],
	fameSkin,

	Float:fameX,
	Float:fameY,
	Float:fameZ,
	Float:fameA
}
new FameInfo[MAX_FAME][fameInfo];
new Iterator:FameList<MAX_FAME>;
new Text3D:Fame3D[MAX_FAME];
new FameActor[MAX_FAME];
//==============================================================================//
#define 	WL_PENDING 					1
#define 	WL_ACCEPTED 				2
#define 	WL_REFUSED 					3

#define 	WL_DB 						"`whitelist`"
//=======================================//
/*enum wlInfo
{
	wlID,
	wlName[24],
	wlIP[16],
	wlEmail[48],
	wlDiscord[32],
	wlDiscriminator[5],
	wlStatus,
	wlAdmin[24],
}
new WLInfo[MAX_PLAYERS][wlInfo];*/
//==============================================================================//