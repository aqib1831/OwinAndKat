<% Option Explicit %>
<!-- #include file="../includes/config.asp" -->
<!-- #include file="includes/config.asp" -->
<!-- #include file="../includes/adovbs.inc" -->

<% 
'*******************************************************************************************************
'*		Page Description:  This page will use to support billing 
'*		Input Parameter:   QueryString Parameters
'*		Developer Name:    Rana Khuram Shahzad
'*		Date:			   09/29/2005																   
'*		Change History														                           
'*			Developer:														                           
'*			Date:															                           
'*			Change:															                           
'*******************************************************************************************************

'******************************* Variables ***********************************

Dim conDB															' As ADODB.Connection	
Dim rstSupportReport									' As ADODB.RecordSet
Dim strConnectionString								' As String

Dim sqlGetFranSupportReport						' As String
Dim reqIsViewed												' As String	
Dim reqIsPrinted											' As String
Dim reqYearID													' As Long						
Dim reqMonthID												' As Long 
	
	
'******************************* Request Variables ************************
strConnectionString = cstFransupportConnectionString
reqYearID = Trim(Request.QueryString("YearID"))
reqMonthID = Trim(Request.QueryString("MonthID"))

if reqMonthID = "" Then
	reqMonthID = Year(Now())
End if
if reqYearID = "" Then
	reqYearID = Month(Now())
End if

	
'******************************* Queries *******************************

sqlGetFranSupportReport = "SELECT * FROM SupportPlanReports WHERE PlanDate = '" & _
							DateSerial(year(reqYearID), month(reqMonthID), 1) & "'"

'///////////////// Request Variables ////////////////////////

'////////////////////////Execute Query////////////////////////
Set conDb = Server.CreateObject("ADODB.Connection")
conDb.open strConnectionString

Set rstSupportReport = Server.CreateObject("ADODB.RecordSet")
rstSupportReport.open sqlGetFranSupportReport, conDb, adOpenForwardOnly, adLockReadOnly, adCmdText

If rstSupportReport.EOF Then

	rstSupportReport.Close
	conDb.Close
	
	Set rstSupportReport = Nothing
	Set conDb = Nothing

	Response.Redirect("generate_support_plan.asp?YearID="&reqYearID&"&MonthID="&reqMonthID)

ElseIf rstSupportReport("IsViewed") = false Then	
	conDb.Execute("UPDATE SupportPlanReports SET IsViewed = 1 WHERE ID = " & rstSupportReport("ID"))

	rstSupportReport.Close
	conDb.Close
	
	Set rstSupportReport = Nothing
	Set conDb = Nothing

	Response.Redirect("report_support_plan.asp?ReportID=" & rstSupportReport("ID"))
End if

%>