//==============================================================================//
/*
	* Module: report.pwn
	* Author: Sule
	* Date: 12.04.2020
*/
//==============================================================================//
CMD:report(playerid, params[])
{
	if(ReportTime[playerid] > gettime()) return ErrorMessage(playerid, "You can use this command every 60 seconds.");	
	new report = Iter_Free(ReportList);
	if(report == -1) return ErrorMessage(playerid, "List of report is full, please try again later.");
	new id;
	if(sscanf(params, "u", id)) return UsageMessage(playerid, "report [ID/Nick]");
	if(id == INVALID_PLAYER_ID) return ErrorMessage(playerid, "Wrong ID.");
	if(id == playerid) return ErrorMessage(playerid, "Wrong ID.");
	ReportID[playerid] = report;
	ReportTime[playerid] = gettime() + 120;

	Iter_Add(ReportList, report);
	ReportInfo[report][reportID] = report;
	strmid(ReportInfo[report][reportName], GetName(playerid), 0, strlen(GetName(playerid)));
	strmid(ReportInfo[report][reportPlayer], GetName(id), 0, strlen(GetName(id)));

	ShowPlayerDialog(playerid, DIALOG_REPORT, DIALOG_STYLE_LIST, ""SERVER"Solvine Deathmatch > "WHITE"Report", "\
		"SERVER"> "WHITE"Hacking\n\
		"SERVER"> "WHITE"Breaking the rules\n\
		"SERVER"> "WHITE"Spamming\n\
		"SERVER"> "WHITE"C-Bugging\n\
		"SERVER"> "WHITE"Abusing\n\
		", "REPORT", "");
	return 1;
}
//==============================================================================//
clearReport(report)
{
	ReportInfo[report][reportID] = report;
	strmid(ReportInfo[report][reportName], "None", 0, strlen("None"));
	ReportInfo[report][reportType] = 0;
	strmid(ReportInfo[report][reportPlayer], "None", 0, strlen("None"));
	return 1;
}
//=======================================//
reportDialog(playerid, report)
{
	new dialog[512+128], string[72];
	format(string, sizeof(string), ""SERVER"> "WHITE"Report ID\t"SERVER"[ %d ]\n", report);
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Reporter\t"SERVER"[ %s ]\n", ReportInfo[report][reportName]);
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Reason\t"SERVER"[ %s ]\n", getReportReasonName(report));
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Reported\t"SERVER"[ %s ]\n", ReportInfo[report][reportPlayer]);
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"\n"SERVER"> "WHITE"\n");
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Spectate\n");
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Action taken\n");
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Clear\n");
	strcat(dialog, string);
	format(string, sizeof(string), ""SERVER"> "WHITE"Cancel\n");
	strcat(dialog, string);

	ShowPlayerDialog(playerid, REPORT_INFO, DIALOG_STYLE_TABLIST, ""SERVER"Solvine Deathmatch > "WHITE"Report Info", dialog, "CHOOSE", "");
	return 1;
}
//=======================================//
getReportReasonName(report)
{
	new name[19];
	switch(ReportInfo[report][reportType])
	{
		case REPORT_HACK: name = "Hacking";
		case REPORT_RULES: name = "Breaking the rules";
		case REPORT_SPAM: name = "Spamming";
		case REPORT_CBUG: name = "C-Bugging";
		case REPORT_ABUSE: name = "Abusing";
		default: name = "None";
	}
	return name;
}
//==============================================================================//
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		//======================================================================//
		case DIALOG_REPORT:
		{
			if(!response || response)
			{
				new report = ReportID[playerid], 
					id = GetPlayerIdFromName(ReportInfo[report][reportPlayer]);
				
				if(id == INVALID_PLAYER_ID)
				{
					clearReport(report);
					ErrorMessage(playerid, "In meanwhile player has left server. Report canceled.");
					return 1;
				}
				switch(listitem)
				{
					case 0://Hack
					{
						ReportInfo[report][reportType] = REPORT_HACK;

						InfoMessage(playerid, "You have successfully subbmited report for %s. Reason for reporting 'hacking'.", GetName(id));

						new string[128];
						format(string, sizeof(string), "Player %s(%d) has subbmited report for %s(%d) with reason of: 'hacking'", GetName(playerid), playerid, GetName(id), id);
						sendMessageToAdmin(string);
					}
					case 1://Rules
					{
						ReportInfo[report][reportType] = REPORT_RULES;

						InfoMessage(playerid, "You have successfully subbmited report for %s. Reason for reporting 'breaking the rules'.", GetName(id));

						new string[128];
						format(string, sizeof(string), "Player %s(%d) has subbmited report for %s(%d) with reason of: 'breaking the rules'", GetName(playerid), playerid, GetName(id), id);
						sendMessageToAdmin(string);
					}
					case 2://Spam
					{
						ReportInfo[report][reportType] = REPORT_SPAM;

						InfoMessage(playerid, "You have successfully subbmited report for %s. Reason for reporting 'spamming'.", GetName(id));

						new string[128];
						format(string, sizeof(string), "Player %s(%d) has subbmited report for %s(%d) with reason of: 'spamming'", GetName(playerid), playerid, GetName(id), id);
						sendMessageToAdmin(string);
					}
					case 3://CBug
					{
						ReportInfo[report][reportType] = REPORT_CBUG;

						InfoMessage(playerid, "You have successfully subbmited report for %s. Reason for reporting 'c-bugging'.", GetName(id));

						new string[128];
						format(string, sizeof(string), "Player %s(%d) has subbmited report for %s(%d) with reason of: 'c-bugging'", GetName(playerid), playerid, GetName(id), id);
						sendMessageToAdmin(string);
					}
					case 4://Abusing
					{
						ReportInfo[report][reportType] = REPORT_ABUSE;

						InfoMessage(playerid, "You have successfully subbmited report for %s. Reason for reporting 'abusing'.", GetName(id));

						new string[128];
						format(string, sizeof(string), "Player %s(%d) has subbmited report for %s(%d) with reason of: 'abusing'", GetName(playerid), playerid, GetName(id), id);
						sendMessageToAdmin(string);
					}
				}
			}
			return 1;
		}
		//======================================================================//
		case REPORT_LIST:
		{
			if(!response) return 1;
			if(response)
			{
				if(!Iter_Contains(ReportList, listitem)) return ErrorMessage(playerid, "Invalid report.");

				ChosenReport[playerid] = listitem;
				reportDialog(playerid, listitem);
			}
			return 1;
		}
		//======================================================================//
		case REPORT_INFO:
		{
			if(!response || response)
			{
				new report = ChosenReport[playerid];
				switch(listitem)
				{
					case 6://Spec
					{
						new id = GetPlayerIdFromName(ReportInfo[report][reportPlayer]), string[8];
						if(id == INVALID_PLAYER_ID)
						{
							ErrorMessage(playerid, "Wrong ID.");
							reportDialog(playerid, report);
							return 1;
						}
						format(string, sizeof(string), "%d", id);
						callcmd::spec(playerid, string);
					}
					case 7://Action Taken
					{
						InfoMessage(playerid, "You finished (action taken) %s's report on %s. Reason for reporting: %s", ReportInfo[report][reportName], ReportInfo[report][reportPlayer], getReportReasonName(report));	
						new string[128+32];
						format(string, sizeof(string), "Admin %s has just finished (action taken) %s's report on %s. Reason for reporting: %s", GetName(playerid), ReportInfo[report][reportName], ReportInfo[report][reportPlayer], getReportReasonName(report));
						sendMessageToAdmin(string);

						Iter_Remove(ReportList, report);
						clearReport(report);
					}
					case 8://Clear
					{
						InfoMessage(playerid, "You cleared %s's report on %s. Reason for reporting: %s", ReportInfo[report][reportName], ReportInfo[report][reportPlayer], getReportReasonName(report));	
						new string[128+32];
						format(string, sizeof(string), "Admin %s has just clear %s's report on %s. Reason for reporting: %s", GetName(playerid), ReportInfo[report][reportName], ReportInfo[report][reportPlayer], getReportReasonName(report));
						sendMessageToAdmin(string);

						Iter_Remove(ReportList, report);
						clearReport(report);
					}
					case 9://Cancel
					{
						callcmd::reportlist(playerid);
					}
					default:
					{
						reportDialog(playerid, ChosenReport[playerid]);
					}
				}
			}
			return 1;
		}
		//======================================================================//
	}
	
	#if defined report_OnDialogResponse
		return report_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnDialogResponse
	#undef OnDialogResponse
#else
	#define _ALS_OnDialogResponse
#endif

#define OnDialogResponse report_OnDialogResponse
#if defined report_OnDialogResponse
	forward report_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif
//==============================================================================//
