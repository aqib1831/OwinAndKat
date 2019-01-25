<% Option Explicit %>
<!-- #include file="../includes/config.asp" -->
<!-- #include file="includes/config.asp" -->
<!-- #include file="../includes/adovbs.inc" -->

<% 
'*******************************************************************************************************
'*		Page Description:  This page will use to download support plan report in Excel Format
'*		Input Parameter:	 Querystring   
'*		Developer Name:    Rana Khuram Shahzad
'*		Date:			   15 April 2006
'*		Change History														                           
'*			Developer:														                           
'*			Date:															                           
'*			Change:															                           
'*******************************************************************************************************

'******************************* Variables ***********************************
Dim objStream 								' ADODB.Stream
Dim strFilePath								' As String
Dim strFileName								' As String
Dim reqMonthID								' As String
Dim reqYearID									' As String

'******************************* Request Variables ***********************************
reqYearID = Trim(Request.QueryString("YearID"))
reqMonthID = Trim(Request.QueryString("MonthID"))

If reqYearID = "" Then
	reqYearID = Year(Now())
End If
If reqMonthID = "" Then
	reqMonthID = Month(Now())
End If

'******************************* Download File ***********************************
strFileName = MonthName(reqMonthID)&reqYearID&".xls"
strFilePath = Server.MapPath(cstSupportPlanReportPath)

Set objStream = Server.CreateObject("ADODB.Stream")
Response.AddHeader "content-disposition", "attachment; filename=" & strFileName
Response.ContentType = "application/x-msexcel"
objStream.Open
objStream.Type = 1		'adTypeBinary
objStream.LoadFromFile strFilePath&"/"&strFileName
Response.BinaryWrite objStream.Read
objStream.Close
Set objStream = Nothing

%>