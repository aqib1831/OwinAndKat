<% Option Explicit %>

<!-- #include file="../includes/config.asp" -->
<!-- #include file="includes/config.asp" -->
<!-- #include file="../includes/adovbs.inc" -->
<!-- #include file="../includes/functions.asp" -->

<%

'*******************************************************************************************************
'*		Page Description:  This page use to import data in excel format 
'*		Input Parameter:   QueryString variables														       
'*		Developer Name:    Rana Khuram Shahzad														           
'*		Date:			   09/27/2005																   
'*		Change History														                           
'*			Developer:														                           
'*			Date:															                           
'*			Change:															                           
'*******************************************************************************************************
	' Increase ScriptTimeout because it may take some time on creating Excel file and downlaoding it.
	Server.ScriptTimeout = 999

'**************************** Variables **********************************

Dim conDB													' As ADODB.Connection
Dim rstFranchises									' As ADODB.Recordset
Dim strConString									' As String
Dim objExcel											' As Excel.Application
Dim objWorkbook										' AS Excel.WorkBook
Dim objWorksheet									' AS Excel.Worksheet
Dim objStream											' As ADODB.Stream
Dim objFSO												' As Scripting.FileSystemObject
Dim strFileName										' As String					
Dim strFilePath										' As String
Dim curTotalSales									' As Integer
Dim intRow 												' As Integer
Dim intExcelRow 									' As Integer
Dim strSqlRetrieveFranchises 			' As String
Dim reqState											' As String
Dim reqOnSupport									' As String
Dim strTempSupport								' As String
Dim strTempDate										' As String
Dim reqBackup											' As String
Dim strTempBackup									' AS String

'********************* Request Variables *****************************************
strConString = cstFransupportConnectionString
reqState =  request.QueryString("StateCode")
reqOnSupport =  request.QueryString("Support")
reqBackup = request.QueryString("Backup")


'*********************** SQL Queries ***************************************
strSqlRetrieveFranchises = " SELECT  *, States.ID AS StateID, States.Code AS StateCode, FranchisesSupport.SMSVersion AS SMSVersion "&_
				" FROM vFranchises INNER JOIN "&_
				" States ON vFranchises.StateID = States.ID INNER JOIN "&_
				" FranchisesSupport ON vFranchises.ID = FranchisesSupport.FranchiseID " & _
				" AND vFranchises.Status NOT IN (4, 6) "
IF reqState <> "" AND reqState <> "0" then
		strSqlRetrieveFranchises =	strSqlRetrieveFranchises & " AND StateID='" & reqState & "' "
End IF

IF reqOnSupport = "Yes" then
		strSqlRetrieveFranchises =	strSqlRetrieveFranchises & " And vFranchises.Onsupport = 1 "

ElseIf reqOnSupport = "No" then
		strSqlRetrieveFranchises =	strSqlRetrieveFranchises & " And vFranchises.Onsupport = 0 "

ElseIf reqOnSupport = "Exp" then
		strSqlRetrieveFranchises =	strSqlRetrieveFranchises & " AND vFranchises.[SupportEndDate] < '" & Date & "' "

ElseIf reqOnSupport = "Free" then
		strSqlRetrieveFranchises =	strSqlRetrieveFranchises & " AND GrandOpening BETWEEN DateAdd(Month, -3, GetDate()) AND GetDate()"
		
End IF

strSqlRetrieveFranchises =	strSqlRetrieveFranchises & " Order By vFranchises.StoreNick "
	
'********************** Queries Execution ****************************************

Set conDb = Server.CreateObject("ADODB.Connection")
conDb.Open strConString

Set rstFranchises = Server.CreateObject("ADODB.Recordset")
rstFranchises.Open strSqlRetrieveFranchises,conDb,adOpenKeyset,adLockOptimistic

	strFileName = "Support_Billing_Report.xls"
	strFilePath = Server.MapPath(strExlSupportBillingReportFilePath)



	Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
	If objFSO.FileExists(strFilePath) = True Then
		Call objFSO.DeleteFile(strFilePath, True)
	End If

	On Error Resume Next
	Set objExcel = Server.CreateObject("Excel.Application")
	If Err.Number <> 0 Then
		%>
		<html>
			<head>
				<title>Error</title>
				<script language="JavaScript">
					function displayError()
						{
						alert('Report could not be generated because Microsoft Excel is not installed on the server.\n\nError Code: <%= Err.Number %>\nError Description: <%= Replace(Replace(Err.Description, "'", "\'"), vbCrLf, "\n") %>');
						}
				</script>
			</head>
			<body onLoad="displayError();">
			</body>
		</html>
		<%
		Response.End
	End If
	On Error GoTo 0


if 	reqBackup = "false" OR reqBackup = ""  Then

' IF Backup is not selected then i have to different sheet with columns upto G

	Set objWorkbook = objExcel.Workbooks.Add()
	Set objWorksheet = objWorkbook.ActiveSheet
	
	objWorksheet.Rows.RowHeight = 16
	objWorksheet.Rows.VerticalAlignment = -4108	'xlCenter

	objWorksheet.Cells(1, 1).Value = "Support Plan Report"
	objWorksheet.Cells(1, 1).Font.Size = 12
	objWorksheet.Cells(1, 1).Font.Bold = True
	objWorksheet.Range("A1").HorizontalAlignment = -4108	'xlCenter

	objWorksheet.Cells(2, 1).Value = "Generated on: " & Date
	objWorksheet.Cells(2, 1).Font.Bold = True
	objWorksheet.Range("A2").HorizontalAlignment = -4108	'xlCenter

				curTotalSales = 0
				intRow = 0
				intExcelRow = 4
				
				objWorksheet.Range("A1", "G1").Merge
				objWorksheet.Range("A2", "G2").Merge
				objWorksheet.Range("A3", "G3").Interior.Color = RGB(204, 255, 204)
				objWorksheet.Range("A3", "G3").Borders.Color = RGB(0, 0, 0)
				objWorksheet.Range("A3", "G3").Font.Bold = True
				objWorksheet.Range("A:A").ColumnWidth = 8
				objWorksheet.Range("B:B").ColumnWidth = 25
				objWorksheet.Range("C:C").ColumnWidth = 5
				objWorksheet.Range("D:D").ColumnWidth = 25
				objWorksheet.Range("E:E").ColumnWidth = 12
				objWorksheet.Range("F:F").ColumnWidth = 11
				objWorksheet.Range("G:G").ColumnWidth = 14
				
				objWorksheet.Cells(3, 1).Value = "Store #"
				objWorksheet.Cells(3, 2).Value = "Store Name"
				objWorksheet.Cells(3, 3).Value = "State"
				objWorksheet.Cells(3, 4).Value = "CorporateName"
				objWorksheet.Cells(3, 5).Value = "SMS Version"
				objWorksheet.Cells(3, 6).Value = "On Support"
				objWorksheet.Cells(3, 7).Value = "Expiration Date"

				rstFranchises.MoveFirst
				Do While Not rstFranchises.EOF
				
					strTempSupport = ""
					strTempDate = ""
					If DateAdd("m", 3, rstFranchises("GrandOpening")) >= Date Then 
						strTempSupport = "Free until"
					 Else 
						
					 	IF rstFranchises("OnSupport")  = true then
								strTempSupport = "Yes"
						 Else
							 strTempSupport = "No"
						 end if

					 End If 
					
					If DateAdd("m", 3, rstFranchises("GrandOpening")) >= Date Then 
						strTempDate = DateAdd("m", 3, rstFranchises("GrandOpening"))
					Else 
						strTempDate = rstFranchises("SupportEndDate") 
					End If
		 
					objWorksheet.Cells(intExcelRow, 1).Value = rstFranchises("StoreNumber")
					objWorksheet.Cells(intExcelRow, 2).Value = rstFranchises("StoreNick")
					objWorksheet.Cells(intExcelRow, 3).Value = rstFranchises("StateCode")
					objWorksheet.Cells(intExcelRow, 4).Value = rstFranchises("CorporateName")
					objWorksheet.Cells(intExcelRow, 5).Value = rstFranchises("SMSVersion")
					objWorksheet.Cells(intExcelRow, 6).Value = strTempSupport
					objWorksheet.Cells(intExcelRow, 7).Value = strTempDate
					
					rstFranchises.MoveNext
					intRow = intRow + 1
					intExcelRow = intExcelRow + 1
        		Loop

	
Else

' IF Backup  selected then i have to different sheet with columns upto H

	Set objWorkbook = objExcel.Workbooks.Add()
	Set objWorksheet = objWorkbook.ActiveSheet

	objWorksheet.Rows.RowHeight = 16
	objWorksheet.Rows.VerticalAlignment = -4108	'xlCenter

	objWorksheet.Cells(1, 1).Value = "Support Plan Report"
	objWorksheet.Cells(1, 1).Font.Size = 12
	objWorksheet.Cells(1, 1).Font.Bold = True
	objWorksheet.Range("A1").HorizontalAlignment = -4108	'xlCenter

	objWorksheet.Cells(2, 1).Value = "Generated on: " & Date
	objWorksheet.Cells(2, 1).Font.Bold = True
	objWorksheet.Range("A2").HorizontalAlignment = -4108	'xlCenter

				curTotalSales = 0
				intRow = 0
				intExcelRow = 4
				objWorksheet.Range("A1", "H1").Merge
				objWorksheet.Range("A2", "H2").Merge
				objWorksheet.Range("A3", "H3").Interior.Color = RGB(204, 255, 204)
				objWorksheet.Range("A3", "H3").Borders.Color = RGB(0, 0, 0)
				objWorksheet.Range("A3", "H3").Font.Bold = True
				objWorksheet.Range("A:A").ColumnWidth = 8
				objWorksheet.Range("B:B").ColumnWidth = 25
				objWorksheet.Range("C:C").ColumnWidth = 5
				objWorksheet.Range("D:D").ColumnWidth = 25
				objWorksheet.Range("E:E").ColumnWidth = 12
				objWorksheet.Range("F:F").ColumnWidth = 11
				objWorksheet.Range("G:G").ColumnWidth = 10
				objWorksheet.Range("H:H").ColumnWidth = 14
				
				objWorksheet.Cells(3, 1).Value = "Store #"
				objWorksheet.Cells(3, 2).Value = "Store Name"
				objWorksheet.Cells(3, 3).Value = "State"
				objWorksheet.Cells(3, 4).Value = "CorporateName"
				objWorksheet.Cells(3, 5).Value = "SMS Version"
				objWorksheet.Cells(3, 6).Value = "On Support"
				objWorksheet.Cells(3, 7).Value = "Backup"
				objWorksheet.Cells(3, 8).Value = "Expiration Date"
				
				rstFranchises.MoveFirst
				Do While Not rstFranchises.EOF
				
					strTempSupport = ""
					strTempDate = ""
					If DateAdd("m", 3, rstFranchises("GrandOpening")) >= Date Then 
						strTempSupport = "Free until"
					 Else 

					 	IF rstFranchises("OnSupport")  = true then
								strTempSupport = "Yes"
						 Else
							 strTempSupport = "No"
						 end if

					 End If 
					
					If DateAdd("m", 3, rstFranchises("GrandOpening")) >= Date Then 
						strTempDate = DateAdd("m", 3, rstFranchises("GrandOpening"))
					Else 
						strTempDate = rstFranchises("SupportEndDate") 
					End If
					
					
					IF rstFranchises("OnBackupService") = "True" Then 
						strTempBackup = "Yes"
					Else
						strTempBackup = "No"
					End IF
		 
					objWorksheet.Cells(intExcelRow, 1).Value = rstFranchises("StoreNumber")
					objWorksheet.Cells(intExcelRow, 2).Value = rstFranchises("StoreNick")
					objWorksheet.Cells(intExcelRow, 3).Value = rstFranchises("StateCode")
					objWorksheet.Cells(intExcelRow, 4).Value = rstFranchises("CorporateName")
					objWorksheet.Cells(intExcelRow, 5).Value = rstFranchises("SMSVersion")
					objWorksheet.Cells(intExcelRow, 6).Value = strTempSupport
					objWorksheet.Cells(intExcelRow, 7).Value = strTempBackup
					objWorksheet.Cells(intExcelRow, 8).Value = strTempDate
					
					rstFranchises.MoveNext
					intRow = intRow + 1
					intExcelRow = intExcelRow + 1
     		Loop

End IF

objWorkbook.SaveAs (strFilePath)
objExcel.Quit

	Set objWorksheet = Nothing
	Set objWorkbook = Nothing
	Set objExcel = Nothing
	
	Set objStream = Server.CreateObject("ADODB.Stream")
	Response.AddHeader "content-disposition", "attachment; filename=" & strFileName
	Response.ContentType = "application/x-msexcel"
	objStream.Open
	objStream.Type = 1		'adTypeBinary
	objStream.LoadFromFile strFilePath
	Response.BinaryWrite objStream.Read
	objStream.Close
	Set objStream = Nothing

	If objFSO.FileExists(strFilePath) = True Then
		Call objFSO.DeleteFile(strFilePath, True)
	End If

	Set objFSO = Nothing

'************************ Destroy Objects **************************************

rstFranchises.Close
Set rstFranchises = Nothing

conDB.Close
Set conDB = Nothing

%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
</body>
</html>