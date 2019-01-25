<% 
'*******************************************************************************************************
'*		Page Description:  This is a config file of Forms Section						   
'*		Input Parameter:   None														       
'*		Developer Name:    M. Rehman
'*		Date:			   			 09/08/2005																   
'*		Change History														                           
'*			Developer:       Khurram Ali														                           
'*			Date:            12/16/2005															                           
'*			Change:          Add Hamden Location ID															                           
'*******************************************************************************************************

'******************************* Variables ***********************************
	Dim intPageSize					   								 										' As Integer
	Dim strAdminImagesPath								 		 										' As String
	Dim strExlSupportBillingReportFilePath		 										' As String
	Dim strExtentionLetterTemplatePath				 										' As String
	Dim strExtentionLetterEmailSubject														' As String
	Dim BackupCharges													 										' As Long		
	Dim lngRemindersRefreshPeriod							 										' As Long
'	Dim cstNetsolaceDeptID																				' As String
'	Dim cstSMSModuleID																						' As String
	Dim strAdminScriptsPath 																			' As String
	Dim strAdminStylesheetPath																		' As String
	
'******************************* Assign values ***************************
	intPageSize = 13
	BackupCharges = 20
	strAdminImagesPath = "../images/"
	strExlSupportBillingReportFilePath = "../Support_Billing_Report.xls"
	strExtentionLetterTemplatePath = "includes/Extension_letter.html"
	strExtentionLetterEmailSubject = "Edible Arrangements Opening" 
	lngRemindersRefreshPeriod = 600	' no. of seconds for refreshing reminders. 
	strAdminScriptsPath = "../scripts/"
	strAdminStylesheetPath = "../style/"
	
	Const cstActivityStateNotStarted = 1
	Const cstActivityStateInProgress = 2
	Const cstActivityStateCompleted = 3
	Const cstActivityStateWaitingFor = 4
	
	Const cstDefaultMonthlyCharges = 65
	
	Const cstAttachmentPath = "../../Fransupport_Resources/mgmt/attachments"	
	Const cstSMSSupportTypeID = 2
	Const cstDefaultTicketCharges = 45
	
	Const cstNetcenterLocationIDforHamden = 50
	'Const cstNetsolaceDeptID = 20
	Const cstNetsolaceDeptID = 1
	Const cstManagementDeptID = 4	
	Const cstSMSModuleID = 2
	Const cstSalesDeptID = 6
	Const cstAdminIDofSarju = 20
	
	Const cstExmptionDays = 90
	Const cstSupportPlanReportPath = "SupportPlanReports"
    'Const cstSupportPlanReportPath = "../../../../Fransupport_Resources/MGMT/SupportPlanReports"

	Const cstTimeLapseNotificationLetter30Days = "template/TimeLapesNotification30Days.htm"
	Const cstTimeLapseNotificationLetter60Days = "template/TimeLapesNotification60Days.htm"
	Const cstTimeLapseNotificationLetter90Days = "template/TimeLapesNotification90Days.htm"
	Const cstTimeLapseNotificationLetter120Days = "template/TimeLapesNotification120Days.htm"
	Const cstTimeLapseNotificationLetter150Days = "template/TimeLapesNotification150Days.htm"
	Const cstRequestForExtensionAttachmentPath = "template/Request_ for_Extension.doc"
	Const cstNewMessageNotification = "template/New_Message_Notification.htm"
	Const cstTimeLapesNotificationGeneral = "template/TimeLapesNotificationGeneral.htm"
	Const cstAdminMgmtImagesPath = "http://localhost/admin/mgmt/images/"
	
	Const cstWelcomeLetterID = 3
	Const cst30DaysNotificationLetterID = 1
	Const cst60DaysNotificationLetterID = 2
	Const cst90DaysNotificationLetterID = 4
	Const cst120DaysNotificationLetterID = 6
	Const cst150DaysNotificationLetterID = 5
	Const cst180DaysNotificationLetterID = 7

%>