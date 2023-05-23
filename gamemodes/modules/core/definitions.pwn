//==============================================================================//
/*
	* Module: defitions.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//

/*
	MySql Baza Podataka
	Host:
	Pass:
	DB:
*/
#if IN_LOCAL == true
	#define 	MYSQL_HOST 				"5.9.8.124"
	#define 	MYSQL_USER 				"u1621582_ZpfJSKdJfh"
	#define 	MYSQL_PASS 				"p24P9l2W^9^5@hfzQ+FGbi11"
	#define 	MYSQL_DB   				"s1621582_solvinedm"
#else
	#define 	MYSQL_HOST 				"5.9.8.124"
	#define 	MYSQL_USER 				"u1621582_ZpfJSKdJfh"
	#define 	MYSQL_PASS 				"p24P9l2W^9^5@hfzQ+FGbi11"
	#define 	MYSQL_DB   				"s1621582_solvinedm"
#endif

new MySQL:DB;
new MySQLOpt:my_Option;

//==============================================================================//

#define     FB                    		""
#define     FORUM                   	""

#define     OWNER                   	"Royvan"
#define     COOWNER  					"N / A"
#define     DIRECTOR                	"N / A"
#define     SCRIPTER                	"None"
#define     MAPER                   	"N / A"
#define 	HOSTING						"N / A"

#define     V_MOD                   	"Sol-Vine"
#define     N_MOD                   	"Beta Test"
#define     ZADNJI_UP               	"26.11.2021."
#define 	PROJECT_STARTED 			"26.11.2021."
#define     MAP                     	"San Andreas"
#define     LANGUAGE                	"English"
#define 	IP 							""

#define 	RCON_PASS 					"roy210305"
#define 	RCON_PIN					12345
#define 	DEV_PW						"Kontol"

//==============================================================================//

#define     function%0(%1)          	forward%0(%1); public%0(%1)

#define     PRESSED(%0)             	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

#define     HOLDING(%0)             	((newkeys & (%0)) == (%0))

#define     RELEASED(%0)            	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

#define     IsValidWeapon(%0)       	((%0 >= 0 && %0 <= 18 || %0 >= 21 && %0 <= 46))

#define     randomEx(%0,%1)         	(random((%1) - (%0)) + (%0))

#define 	ClearChat(%0,%1)			for(new n = 0; n < %1; n++) SendClientMessage(%0, -1, " ")

//==============================================================================//

#define 	InfoMessage(%0,%1) 			SendClientMessageEx(%0, COL_SERVER, "Solvine Deathmatch // "WHITE""%1)
#define 	AMessage(%0,%1)				SendClientMessageEx(%0, COL_SERVER, "A | "WHITE""%1)

#define 	UsageMessage(%0,%1) 		SendClientMessageEx(%0, COL_ORANGE, "USAGE // "WHITE"/"%1)
#define 	DuelMessage(%0,%1)			SendClientMessageEx(%0, COL_ORANGE, "DUEL // "WHITE""%1)

#define 	ErrorMessage(%0,%1) 		SendClientMessageEx(%0, COL_RED, "ERROR // "WHITE""%1)
#define 	VersusMessage(%0,%1)		SendClientMessageEx(%0, COL_PINK, "VERSUS // "WHITE""%1)
#define 	PremiumMessage(%0,%1) 		SendClientMessageEx(%0, COL_GREEN, "PREMIUM | "WHITE""%1)
#define 	DiscordMessage(%0,%1)		SendClientMessageEx(%0, COL_YELLOW, "DISCORD // "WHITE""%1)

//==============================================================================//

#define		MAX_WARN					8

#define 	SEX_FEMALE 					false
#define 	SEX_MALE 					true

#define 	VERSUS_VW 					128

#define 	TYPE_DAY 					1
#define 	TYPE_MONTH 					2

//==============================================================================//
