//==============================================================================//
/*
	* Module: mysql_tables.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
public OnGameModeInit()
{
	// ---------------- //

	mysql_tquery(DB, "CREATE TABLE IF NOT EXISTS "USER_DB" (\
		`pID` INT NOT NULL AUTO_INCREMENT, \
		`pName` VARCHAR(24) NOT NULL, \
		`pIP` VARCHAR(16) NOT NULL, \
		`pPassword` VARCHAR(65) NOT NULL, \
		`pSex` BOOLEAN NOT NULL, \
		`pRegDate` DATETIME NOT NULL, \
		`pLastLogin` DATETIME NOT NULL, \
		`pOnline` BOOLEAN NOT NULL, \
		`pHours` INT NOT NULL, \
		`pMinutes` INT NOT NULL, \
\
		`pAdmin` INT NOT NULL, \
		`pAdminCode` INT NOT NULL, \
		`pPremium` BOOLEAN NOT NULL, \
		`pPremiumHours` INT NOT NULL, \
		`pJail` INT NOT NULL, \
		`pJailReason` VARCHAR(16) NOT NULL, \
		`pMute` INT NOT NULL, \
		`pMuteReason` VARCHAR(16) NOT NULL, \
		`pWarn` INT NOT NULL, \
\
		`pSkinID` INT NOT NULL, \
		`pKills` INT NOT NULL, \
		`pDeaths` INT NOT NULL, \
		`pMaxKS` INT NOT NULL, \
		`pMoney` INT NOT NULL, \
		`pDayKills` INT NOT NULL, \
		`pDayDeaths` INT NOT NULL, \
		`pDayWins` INT NOT NULL, \
		`pMonthKills` INT NOT NULL, \
		`pMonthDeaths` INT NOT NULL, \
		`pMonthWins` INT NOT NULL, \
\
		`pRank` INT NOT NULL DEFAULT '-1', \
		`pArenaKills` INT NOT NULL, \
		`pArenaDeaths` INT NOT NULL, \
		`pDuelWins` INT NOT NULL, \
		`pDuelDefeats` INT NOT NULL, \
		`pVersusWins` INT NOT NULL, \
		`pVersusDefeats` INT NOT NULL, \
		PRIMARY KEY (`pID`))");

	// ---------------- //

	mysql_tquery(DB, "CREATE TABLE IF NOT EXISTS "BAN_DB" (\
		`banName` VARCHAR(24) NOT NULL, \
		`banIP` VARCHAR(16) NOT NULL, \
		`banAdmin` VARCHAR(24) NOT NULL, \
		`banReason` VARCHAR(24) NOT NULL, \
		`banDate` DATETIME NOT NULL, \
		`banTime` INT NOT NULL)");

	// ---------------- //

	mysql_tquery(DB, "CREATE TABLE IF NOT EXISTS "SERVER_DB" (\
		`serverPoseta` INT NOT NULL, \
		`serverRecord` INT NOT NULL, \
		`serverUpozorenih` INT NOT NULL, \
		`serverKikovanih` INT NOT NULL, \
		`serverBanovanih` INT NOT NULL, \
		`serverUsers` INT NOT NULL, \
		`serverWhitelisted` INT NOT NULL, \
\
		`serverRegistration` BOOLEAN NOT NULL, \
		`serverWL` BOOLEAN NOT NULL, \
		`serverName1` VARCHAR(72) NOT NULL, \
		`serverName2` VARCHAR(72) NOT NULL, \
		`serverArena` BOOLEAN NOT NULL, \
		`serverDuel` BOOLEAN NOT NULL, \
		`serverVersus` BOOLEAN NOT NULL, \
		`versusWeapon` INT NOT NULL, \
		`serverFreeroam` BOOLEAN NOT NULL, \
\
		`dayID` INT NOT NULL, \
		`dayKills` INT NOT NULL, \
		`monthKills` INT NOT NULL, \
		`monthID` INT NOT NULL \
\
		)");
	mysql_tquery(DB, "SELECT * FROM "SERVER_DB"", "mySQL_LoadServerInfo", "");

	// ---------------- //

	mysql_tquery(DB, "CREATE TABLE IF NOT EXISTS "ARENA_DB" (\
		`arenaID` INT NOT NULL, \
		`arenaName` VARCHAR(24) NOT NULL, \
		`arenaWeapon1` INT NOT NULL, \
		`arenaWeapon2` INT NOT NULL, \
		`arenaWeapon3` INT NOT NULL, \
\
		`arenaIntID` INT NOT NULL, \
		`arenaVWID` INT NOT NULL, \
		`arenaX_0` FLOAT NOT NULL, `arenaY_0` FLOAT NOT NULL, `arenaZ_0` FLOAT NOT NULL, `arenaA_0` FLOAT NOT NULL, \
		`arenaX_1` FLOAT NOT NULL, `arenaY_1` FLOAT NOT NULL, `arenaZ_1` FLOAT NOT NULL, `arenaA_1` FLOAT NOT NULL, \
		`arenaX_2` FLOAT NOT NULL, `arenaY_2` FLOAT NOT NULL, `arenaZ_2` FLOAT NOT NULL, `arenaA_2` FLOAT NOT NULL, \
		`arenaX_3` FLOAT NOT NULL, `arenaY_3` FLOAT NOT NULL, `arenaZ_3` FLOAT NOT NULL, `arenaA_3` FLOAT NOT NULL, \
		`arenaX_4` FLOAT NOT NULL, `arenaY_4` FLOAT NOT NULL, `arenaZ_4` FLOAT NOT NULL, `arenaA_4` FLOAT NOT NULL, \
		`arenaX_5` FLOAT NOT NULL, `arenaY_5` FLOAT NOT NULL, `arenaZ_5` FLOAT NOT NULL, `arenaA_5` FLOAT NOT NULL, \
		`arenaX_6` FLOAT NOT NULL, `arenaY_6` FLOAT NOT NULL, `arenaZ_6` FLOAT NOT NULL, `arenaA_6` FLOAT NOT NULL, \
\
		`arenaKSRecord` INT NOT NULL, \
		`arenaKSRecorder` VARCHAR(24) NOT NULL, \
		`arenaKillsRecord` INT NOT NULL, \
		`arenaKillsRecorder` VARCHAR(24) NOT NULL, \
\
		`arenaLocked` BOOLEAN NOT NULL, \
		PRIMARY KEY (`arenaID`))");
	mysql_tquery(DB, "SELECT * FROM "ARENA_DB"", "mySQL_LoadArenas", "");

	// ---------------- //

	mysql_tquery(DB, "CREATE TABLE IF NOT EXISTS "ADMIN_DB" (\
		`adminID` INT NOT NULL AUTO_INCREMENT, \
		`adminName` VARCHAR(24) NOT NULL, \
		`adminLevel` INT NOT NULL, \
\
		`adminCMD` INT NOT NULL, \
		`adminBan` INT NOT NULL, \
		`adminUnban` INT NOT NULL, \
		`adminWarn` INT NOT NULL, \
		`adminUnwarn` INT NOT NULL, \
		`adminKick` INT NOT NULL, \
		`adminJail` INT NOT NULL, \
		`adminUnjail` INT NOT NULL, \
		`adminSpec` INT NOT NULL, \
\
		`adminHours` INT NOT NULL, \
		`adminMinutes` INT NOT NULL, \
		`adminLastLogin` DATETIME NOT NULL, \
		`adminOnline` BOOLEAN NOT NULL, \
		PRIMARY KEY (`adminID`))");

	// ---------------- //

	mysql_tquery(DB, "CREATE TABLE IF NOT EXISTS "RANK_DB" (\
		`rankID` INT NOT NULL, \
		`rankName` VARCHAR(24) NOT NULL, \
		`rankPoint` INT NOT NULL, \
		`rankReward` INT NOT NULL, \
		PRIMARY KEY (`rankID`))");
	mysql_tquery(DB, "SELECT * FROM "RANK_DB"", "mySQL_LoadRanks", "");

	// ---------------- //

	mysql_tquery(DB, "CREATE TABLE IF NOT EXISTS "FAME_DB" (\
		`fameID` INT NOT NULL, \
		`fameName` VARCHAR(24) NOT NULL, \
		`fameDescription` VARCHAR(256) NOT NULL, \
		`fameSkin` INT NOT NULL, \
		`fameX` FLOAT NOT NULL, \
		`fameY` FLOAT NOT NULL, \
		`fameZ` FLOAT NOT NULL, \
		`fameA` FLOAT NOT NULL, \
		PRIMARY KEY (`fameID`))");
	mysql_tquery(DB, "SELECT * FROM "FAME_DB"", "mySQL_LoadFames", "");

	// ---------------- //

	mysql_tquery(DB, "CREATE TABLE IF NOT EXISTS "WL_DB" (\
		`wlID` INT NOT NULL AUTO_INCREMENT, \
		`wlName` VARCHAR(24) NOT NULL, \
		`wlIP` VARCHAR(16) NOT NULL, \
		`wlEmail` VARCHAR(48) NOT NULL, \
		`wlDiscord` VARCHAR(32) NOT NULL, \
		`wlDiscriminator` VARCHAR(5) NOT NULL, \
		`wlStatus` FLOAT NOT NULL, \
		`wlAdmin` VARCHAR(24) NOT NULL DEFAULT 'None', \
		PRIMARY KEY (`wlID`))");

	// ---------------- //

	#if defined mysql_OnGameModeInit
		return mysql_OnGameModeInit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif

#define OnGameModeInit mysql_OnGameModeInit
#if defined mysql_OnGameModeInit
	forward mysql_OnGameModeInit();
#endif
//==============================================================================//