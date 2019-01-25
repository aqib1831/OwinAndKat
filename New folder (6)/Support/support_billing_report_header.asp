<% Option Explicit %>
<!-- #include file="../includes/config.asp" -->
<!-- #include file="includes/config.asp" -->
<!-- #include file="../includes/adovbs.inc" -->

<% 
'*******************************************************************************************************
'*		Page Description:  This page will use to as an header for support billing report
'*		Input Parameter:   
'*		Developer Name:    Rana Khuram Shahzad
'*		Date:			   09/29/2005																   
'*		Change History														                           
'*			Developer:														                           
'*			Date:															                           
'*			Change:															                           
'*******************************************************************************************************

'******************************* Variables ***********************************

Dim reqStartDate								' As String
Dim reqEndDate									' As String
Dim objFSO											' As Scripting.FileSystemObject
Dim strFileName									' As String	
Dim strFilePath 	 							' As String
Dim blnFileExists								' As String
Dim reqMonthID									' As String
Dim reqYearID										' As String
Dim reqReportType								' As String

'/////////////////////// Request Variables ///////////////////////
reqYearID = Trim(Request.QueryString("YearID"))
reqReportType = Trim(Request.QueryString("ReportType"))
reqMonthID = Trim(Request.QueryString("MonthID"))

If reqYearID = "" Then
	reqYearID = Year(Now())
End If
If reqMonthID = "" Then
	reqMonthID = Month(Now())
End If
 
If Trim(reqStartDate) = "" Then
	reqStartDate = Month(Now) & "/" & "01/"  & Year(Now)
End If

If reqEndDate = "" Then
	reqEndDate = DateAdd("m", 1, reqStartDate)
	reqEndDate = DateAdd("d", -1, reqEndDate)
End If

strFileName = MonthName(reqMonthID)&reqYearID&".xls"
strFilePath = Server.MapPath(cstSupportPlanReportPath)
blnFileExists = False

Set objFSO = Server.CreateObject("Scripting.FileSystemObject")

If objFSO.FileExists(strFilePath&"/"&strFileName) = True Then
	blnFileExists = True
End If

Set objFSO = Nothing

%>
<html>
<head>
<link rel="stylesheet" href="style/reports.css">
<link rel="stylesheet" href="../App_Themes/Default/Style.css">
<title>Support Billing Report</title>
		<script language =javascript>
			function getPrint()
			{
				frames("frameSupportReport").focus();
				frames("frameSupportReport").print()
			}
		</script>
	
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="overflow:auto; ">
    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td valign="top">
                <table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0"
                    bordercolor="#ACBDD5">
                    <tr class="GalleryTitle" style="background-image: url('../images/bg_mainHdr_1.jpg');
                        height: 31px;">
                        <td>
                            &nbsp;<span class="IdeaTitle">Support Billing Report </span>
                        </td>
                        <td style="padding-right: 5px;" align="right">
                            <input id="btnPrint" type="button" onclick="getPrint();" class="btnSilver" value="Print"
                                style="width: 80px;" />
                        </td>
                    </tr>
                    <tr>
                        <td bordercolor="#CCD7E6" colspan="2">
                            <table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0"
                                class="gvwSearchSilver">
                                <tr>
                                    <td height="10" align="center" class="SimpleSmall" valign="middle" style="padding-top:5px;padding-bottom:5px;">
                                        Report Month:
                                        <select name="YearID" id="YearID" onchange="window.navigate('support_billing_report_header.asp?ReportType=SupportPlanBilling&YearID='+YearID.options[YearID.selectedIndex].value+'&MonthID='+MonthID.options[MonthID.selectedIndex].value)">
                                            <option value="<%=Year(Now)-4%>" <% if clng(reqyearid) = clng(year(now)-4) then response.write("selected") %>>
                                                <%=Year(Now)-4%>
                                            </option>
                                            <option value="<%=Year(Now)-3%>" <% if clng(reqyearid) = clng(year(now)-3) then response.write("selected") %>>
                                                <%=Year(Now)-3%>
                                            </option>
                                            <option value="<%=Year(Now)-2%>" <% if clng(reqyearid) = clng(year(now)-2) then response.write("selected") %>>
                                                <%=Year(Now)-2%>
                                            </option>
                                            <option value="<%=Year(Now)-1%>" <% if clng(reqyearid) = clng(year(now)-1) then response.write("selected") %>>
                                                <%=Year(Now)-1%>
                                            </option>
                                            <option value="<%=Year(Now)%>" <% if clng(reqyearid) = clng(year(now)) then response.write("selected") %>>
                                                <%=Year(Now)%>
                                            </option>
                                        </select>
                                        <select name="MonthID" id="MonthID" onchange="window.navigate('support_billing_report_header.asp?ReportType=SupportPlanBilling&YearID='+YearID.options[YearID.selectedIndex].value+'&MonthID='+MonthID.options[MonthID.selectedIndex].value)">
                                            <option value="1" <% if reqmonthid = 1 then response.write("selected") %>>January</option>
                                            <option value="2" <% if reqmonthid = 2 then response.write("selected") %>>February</option>
                                            <option value="3" <% if reqmonthid = 3 then response.write("selected") %>>March</option>
                                            <option value="4" <% if reqmonthid = 4 then response.write("selected") %>>April</option>
                                            <option value="5" <% if reqmonthid = 5 then response.write("selected") %>>May</option>
                                            <option value="6" <% if reqmonthid = 6 then response.write("selected") %>>June</option>
                                            <option value="7" <% if reqmonthid = 7 then response.write("selected") %>>July</option>
                                            <option value="8" <% if reqmonthid = 8 then response.write("selected") %>>August</option>
                                            <option value="9" <% if reqmonthid = 9 then response.write("selected") %>>September</option>
                                            <option value="10" <% if reqmonthid = 10 then response.write("selected") %>>October</option>
                                            <option value="11" <% if reqmonthid = 11 then response.write("selected") %>>November</option>
                                            <option value="12" <% if reqmonthid = 12 then response.write("selected") %>>December</option>
                                        </select>
                                        <% If blnFileExists = True Then %>
                                        &nbsp;<img src="images/Excel.gif" style="cursor: hand;" onclick="XLSFrame.location='support_plan_report_download_xls.asp?YearID=<%= reqYearID %>&MonthID=<%= reqMonthID %>';"
                                            title="Downlad in Excel Format" height="20" align="absmiddle">
                                        &nbsp;
                                        <iframe name="XLSFrame" id="XLSFrame" width="0" height="0" src="../includes/blank.asp">
                                        </iframe>
                                        <% End If%>
                                    </td>
                                </tr>
                                <tr bordercolor="#E0E0E0" bgcolor="#CDCDCD">
                                    <td height="1">
                                        <img src="../images/spacer.gif" width="1" height="1"></td>
                                </tr>
                                <tr>
                                    <td>
                                        <iframe width="100%" height="100%" name="frameSupportReport" id="frameSupportReport"
                                            scrolling="auto" src="support_billing_report_generate.asp?ReportType=SupportPlanBilling&YearID=<%= reqYearID %>&MonthID=<%= reqMonthID %>"
                                            frameborder="0"></iframe>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
