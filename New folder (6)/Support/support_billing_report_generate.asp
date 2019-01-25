<% Option Explicit %>
<!-- #include file="../includes/config.asp" -->
<!-- #include file="includes/config.asp" -->
<!-- #include file="../includes/adovbs.inc" -->

<% 
'*******************************************************************************************************
'*		Page Description:  This page will use to generate support billing report
'*		Input Parameter:   QueryString Parameters
'*		Developer Name:    Rana Khuram Shahzad
'*		Date:			   09/29/2005																   
'*		Change History														                           
'*			Developer:														                           
'*			Date:															                           
'*			Change:															                           
'*******************************************************************************************************

'******************************* Variables ***********************************

Dim conDb																' As ADODB.Connection
Dim rstSupportPlanReport								' As ADODB.Recordset
Dim strConeectionString									' As String

Dim reqPlanDate													' As Date
Dim reqSupportPlanID										' As Long
Dim dtCurrentDate												' As Date
Dim reqYearID														' As Long
Dim reqMonthID													' As Long									

'******************************* Request Variables **************************
strConeectionString = cstFransupportConnectionString
reqYearID = Trim(Request.QueryString("YearID"))
reqMonthID = Trim(Request.QueryString("MonthID"))

reqPlanDate = DateSerial(reqYearID, reqMonthID, 1)
dtCurrentDate = DateSerial(Year(Now()), Month(Now())+1, 1)

'******************************* Queries Execution ************************
Set conDb = Server.CreateObject("ADODB.Connection")
conDb.Open strConeectionString

Set rstSupportPlanReport = conDb.Execute("SELECT * FROM SupportPlanReports WHERE PlanDate='"&reqPlanDate&"'")
If (rstSupportPlanReport.eof) and (reqPlanDate <= dtCurrentDate) Then

	rstSupportPlanReport.Close
	Set rstSupportPlanReport = Nothing
	
	conDb.Close
	Set conDb = Nothing

	Response.Redirect("support_billing.asp?YearID="&reqYearID&"&MonthID="&reqMonthID)

ElseIf Not rstSupportPlanReport.eof Then
	reqSupportPlanID = rstSupportPlanReport("ID").value
End if
		
	rstSupportPlanReport.Close
	Set rstSupportPlanReport = Nothing
	
	conDb.Close
	Set conDb = Nothing
	Response.Redirect("Report_Support_Plan.asp?ReportID="&reqSupportPlanID&"&PlaneDate="&reqPlanDate)

%>