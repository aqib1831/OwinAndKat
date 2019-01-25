<% Option Explicit %>
<!-- #include file="../includes/config.asp" -->
<!-- #include file="includes/config.asp" -->
<!-- #include file="../includes/adovbs.inc" -->
<!-- #include file="../includes/functions.asp" -->

<% 
'*******************************************************************************************************
'*		Page Description:  This page will use to generating report support plan for support billing report
'*		Input Parameter:   QueryString Parameters
'*		Developer Name:    Rana Khuram Shahzad
'*		Date:			   			 09/29/2005																   
'*		Change History														                           
'*			Developer:		   Khurram Ali												                           
'*			Date:						 04/17/2006									                           
'*			Change:					 Total Mismatched Error										                           
'*******************************************************************************************************

'******************************* Variables ***********************************

Dim conDb																		' As ADODB.Connection
Dim rsReport																' As ADODB.Recordset
Dim strConnectionString											' As String
Dim strSqlGetReport													' As String
Dim reqReportDate														' As Date			
Dim reqReportID															' As Long	
Dim grandTotal															' As Long
Dim dtPlanDate															' As Date
Dim BackupGrandTotal												' As Long						
Dim ReportTotal															' As Long
Dim dblBackupAmount													' As Double	
'******************************* Request Variables ***********************************
strConnectionString = cstFransupportConnectionString
reqReportID = Request.QueryString("ReportID")
dtPlanDate = Request.QueryString("PlaneDate")

reqReportID = FixLongForComparison(reqReportID,0)
ReportTotal = 0
grandTotal = 0
dblBackupAmount = 0

If reqReportID = 0 Then

%>

<div align="center" id="ExpiredMessage" style="display: inline; border: 2px solid black; position: absolute; BACKGROUND-COLOR: #FFFFCC; left: 185px; top: 100px; width: 350px; height: 80px;"> 
  <table width="100%"  cellpadding="0" cellspacing="0">
    <tr bgcolor="#000099"> 
      <td height="21" colspan="2"  align="left" valign="middle"><div align="left"><strong><font size="1" color="#FFFFFF"  face="verdana, Arial, Helvetica, sans-serif">&nbsp;Support 
          Plan Billing- Alert</font></strong></div></td>
    </tr>    
    <tr> 
      <td width="100%" align="left" valign="middle"> <table border="0" align="center" width="100%" cellpadding="0" cellspacing="0">
          <tr> 
            <td align="center" height="25" colspan="2"><font size="2" face="verdana, Arial, Helvetica, sans-serif">&nbsp;</font></td>
          </tr>
          <tr> 
            <td align="right"  valign="middle"><div align="right">&nbsp;&nbsp;<img src="images/ico_alert.gif" align="absmiddle" >&nbsp;&nbsp; 
              </div></td>
            <td height="25"><font size="2" face="verdana, Arial, Helvetica, sans-serif"><strong>No 
              Record Exists In This Month!</strong> </font></td>
          </tr>
          
          <tr> 
            <td align="center" colspan="2" height="25" > &nbsp; &nbsp; &nbsp; 
            </td>
          </tr>
        </table></td>
    </tr>
  </table>
</div>

<%
Else 

'******************************* Queries ***********************************

strSqlGetReport = "SELECT * FROM View_SupportPlanReports WHERE ReportID = '"& reqReportID&"' Order by storenick"

'******************************* Queries Execution ***********************************
Set conDb = Server.CreateObject("ADODB.Connection")
conDb.Open strConnectionString

Set rsReport = conDb.Execute(strSqlGetReport)

%>

<html>
<head>
<title>Support Plan Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="style/reports.css">
<script language="javascript" defer="true">
  function PrintReport()
  {  	
		 document.getElementById('ButtonArea').style.display='none';
		 window.print();
		 document.getElementById('ButtonArea').style.display='inline';		 
  }
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" >
      
     <table width="670" border="0" cellspacing="2" cellpadding="2" align="center">
        <tr>
          
    <td align="center" class="PageSubHeading"><b>Support Plan Billing Report</b></td>
        </tr>
        <tr>
          <td align="center" > </td>
        </tr>
        <tr>
					
    <td align="center" class="SimpleLabel"><b> For <%= MonthName(Month(dtPlanDate))&" "&year(dtPlanDate) %> </b></td>
        </tr>
      </table>
      <br>
      <br>
<table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td width="8%" class="SimpleSmallBold" align="left" height="35">Store #</td>
    <td width="14%" class="SimpleSmallBold" align="left">Store Name</td>
	<td width="18%" class="SimpleSmallBold" align="left">Corporate Name</td>
    <td width="15%" class="SimpleSmallBold">Plan Start Date</td>
    <td width="19%" class="SimpleSmallBold">Support Amount</td>
    <td width="12%" class="SimpleSmallBold">Backup Amount</td>
	<td width="14%" class="SimpleSmallBold">Total</td>
 </tr>

<%
	Do While Not rsReport.EOF
%>
	
  <tr>
    <td  class="SimpleSmall" align="left" width="8%" height="30"><%=rsReport("StoreNumber")%></td>
    <td  class="SimpleSmall" align="left" width="14%">
		<% If Len(rsReport("StoreNick")) > 13 Then 
				Response.Write(Left(rsReport("StoreNick"), 13) & "...")
		 Else 
				Response.Write(rsReport("StoreNick")) 
		 End If %>
	</td>
	<td  class="SimpleSmall" align="left" width="18%">
			<% If Len(rsReport("CorporateName")) > 15 Then 
				    Response.Write(Left(rsReport("CorporateName"), 15) & "...")
			 Else 
						Response.Write(rsReport("CorporateName"))
			 End If %>
	</td>
    <td  class="SimpleSmall" align="left" width="15%"><%=rsReport("PlanStartDate")%></td>
	<!-- <td  class="TableRowWithLine" align="left" width="14%"><%=rsReport("PlanEndDate")%></td> -->
    <td  class="SimpleSmall" align="left" width="19%">
		<% Response.Write formatcurrency(rsReport("Amount"))
		If rsReport("IsExempted") = False Then
				grandTotal = cdbl(grandTotal) + cdbl(rsReport("Amount"))
		End If
		If rsReport("IsPartial") = True Then
			Response.Write(" (Partial)")		
		ElseIf rsReport("IsExempted") = True Then
			Response.Write(" (Exempted)")
		End If %>
	</td>
    <td valign="middle" class="SimpleSmall" align="left" width="12%">
		<%
		Response.Write formatcurrency(rsReport("BackupAmount"))
		BackupGrandTotal = cdbl(BackupGrandTotal) + cdbl(rsReport("BackupAmount")) 
		%>
	</td>
	<td class="SimpleSmall" align="left" width="14%">
	<%If rsReport("IsExempted") = True Then
	  	Response.Write(FormatCurrency(rsReport("BackupAmount") , 2) )	
	  Else
		 Response.Write(FormatCurrency(cdbl(rsReport("BackupAmount"))  + cdbl(rsReport("Amount")), 2) )
	  End If %></td>
  </tr>
<%
	If rsReport("IsExempted") = True Then
		ReportTotal = cdbl(ReportTotal) + cdbl(rsReport("BackupAmount"))
	Else
		ReportTotal = cdbl(ReportTotal) + cdbl(rsReport("BackupAmount"))  + cdbl(rsReport("Amount"))
	End if
	rsReport.MoveNext
	Loop
%>
 <tr>
 	<td colspan="4" align="right" class="SimpleSmall">Total :&nbsp;&nbsp;</td>
	<td class="SimpleSmall"><% =  FormatCurrency(grandTotal) %></td>
	<td class="SimpleSmall"><%= FormatCurrency(BackupGrandTotal, 2) %></td>
	<td class="SimpleSmall"><%= FormatCurrency(ReportTotal, 2) %></td>
 </tr>
</table>

</body>
</html>

<%
'*************************** Object Destructin ***********************************
rsReport.Close
conDb.Close

Set rsReport = Nothing
Set conDb = Nothing


End If
%>



