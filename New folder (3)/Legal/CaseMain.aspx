<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CaseMain.aspx.vb" Inherits="admin_Legal_CaseMain" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>

    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>

    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>

    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>

    <script type="text/javascript" language="JavaScript" src="../scripts/functions.js"></script>

    <link href="../style/style.css" type="text/css" rel="stylesheet" />
    <link href="Style/Style.css" type="text/css" rel="stylesheet" />
    <link href="../style/Calendar/style.css" type="text/css" rel="stylesheet" />

    <script language="javascript" type="text/javascript">
    function UpdateParent()
    {
    document.getElementById("btnBinder").click();
    }
    
    function showHideVital_Case()
    {
	if (blnShowed == false)
	    {
		    setWindowedControlsVisibility(window, 'hidden');
		    getElement('OpenProfile').style.display = 'none';
		    getElement('CloseProfile').style.display = 'inline';
		    getElement('FullVital_CaseDetail').style.display = 'inline';
		    moveit(-320);
		    blnShowed = true;
	    }
	    else
	    {
			    getElement('CloseProfile').style.display = 'none';
			    getElement('OpenProfile').style.display = 'inline';
			    getElement('FullVital_CaseDetail').style.display = 'none';
			    moveleft(20);
			    blnShowed = false;
	    }
    }

    </script>

</head>
<body style="margin: 0px; width: 100%; height: 100%; background-color: #BADCFC;"
    scroll="No" class="ScrollBarHomeTicket" onload="showHideVital_Case();">
<div align="left" id="FullVital_CaseDetail" style="display:inline;position:absolute;overflow:auto;height:100%;width:100%;top:0px;left:0px;" onClick="showHideVital_Case();"></div>    
    <form id="Form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
            <tr style="display: none;">
                <td>
                    <asp:Button ID="btnBinder" runat="server" Text="" />
                </td>
            </tr>
            <tr>
                <td style="width: 32px; border-bottom: solid 1px #609BD3;" valign="top">
                    <div align="left" id="FrachiseDetail" style="display: inline; position: absolute;
                        height: 100%; width: 348px; top: 0px; left: -320px; border-top: solid 1px #609BD3;">
                        <asp:UpdatePanel runat="SERVER" ID="UPDIV">
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnBinder" EventName="Click" />
                            </Triggers>
                            <ContentTemplate>
                                <asp:FormView runat="server" ID="fvLeadVitals" Width="100%" Height="100%" DataSourceID="CaseInfoDS"
                                    CellPadding="0">
                                    <ItemTemplate>
                                        <table style="width: 100%; height: 100%;" border="0" cellpadding="0" cellspacing="0">
                                            <tr style="border-color: #FFFFFF;">
                                                <td style="border-bottom: solid 1px #609BD3;">
                                                    <table style="width: 100%; height: 100%; border-right: 1px solid #609BD3;" border="0"
                                                        align="center" cellpadding="0" cellspacing="0" class="blueSubTableTD">
                                                        <tr>
                                                            <th style="height: 20px;" align="left">
                                                                &nbsp;Case Information
                                                            </th>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <div style="height: 100%; width: 100%; overflow-y: auto;">
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                        <tr>
                                                                            <td style="width: 65px; padding-left: 5px;">
                                                                                Title:</td>
                                                                            <td style="height: 20px; font-weight: bold; width: 200px;" align="left">
                                                                                <asp:Label ID="Label1" runat="server" ToolTip='<%#Server.HtmlEncode(Eval("Title")) %>'
                                                                                    Text='<%#Server.HtmlEncode(Functions.StringTruncate(Functions.IfNull(Eval("Title"),""),30)) %>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="padding-left: 5px;">
                                                                                Franchisee:</td>
                                                                            <td style="height: 20px; font-weight: bold; " align="left">
                                                                                <asp:Label ID="Label2" runat="server" Text='<%#IIF(Eval("StoreName").ToString()<>"",Functions.IfNull(Eval("StoreName"),""),"N/A") %>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="padding-left: 5px;">
                                                                                Type:</td>
                                                                            <td style="height: 20px; font-weight: bold;" align="left">
                                                                                <asp:Label ID="Label3" runat="server" Text='<%#Server.HtmlEncode(Functions.IfNull(Eval("TypeName"),"")) %>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="padding-left: 5px;">
                                                                                Assigned:</td>
                                                                            <td style="height: 20px; font-weight: bold; " align="left">
                                                                                <asp:Label ID="Label5" runat="server" Text='<%#CaseMgmt.Legal_GetAdminName(Functions.IfNull(Eval("AssignedTo"),"")) %>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="padding-left: 5px;">
                                                                                From:</td>
                                                                            <td style="height: 20px; font-weight: bold; " align="left">
                                                                                <asp:Label ID="Label6" runat="server" Text='<%#CaseMgmt.Legal_GetAdminName(Functions.IfNull(Eval("UserId"),0)) %>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="padding-left: 5px;">
                                                                                Entered:</td>
                                                                            <td style="height: 20px; font-weight: bold; " align="left">
                                                                                <asp:Label ID="Label7" runat="server" Text='<%#Convert.ToDateTime(Functions.IfNull(Eval("DateEntered").ToString(),"")).ToShortDateString() %>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="padding-left: 5px;">
                                                                                Modified:</td>
                                                                            <td style="height: 20px; font-weight: bold; " align="left">
                                                                                <asp:Label ID="Label8" runat="server" Text='<%#IIF(Eval("ModifiedDate").ToString()<>"" ,Functions.IfNull(Eval("ModifiedDate"),""),"N/A")%>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="padding-left: 5px;">
                                                                                Firm/Vendor:</td>
                                                                            <td style="height: 20px; font-weight: bold; " align="left">
                                                                                <asp:Label ID="Label9" runat="server" ToolTip='<%# Functions.IfNull(Eval("Name"),"") %>' Text='<%#IIF(Eval("Name").ToString()<>"",Server.HtmlEncode(Functions.StringTruncate(Me.chkNullDescription(Functions.IfNull(Eval("Name"),"")),30)),"N/A")%>'>&nbsp;</asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="padding-left: 5px;">
                                                                                Status:</td>
                                                                            <td style="height: 20px; font-weight: bold; " align="left">
                                                                                <asp:Label ID="Label10" runat="server" Text='<%#Server.HtmlEncode(Functions.IfNull(Eval("StatusName"),"N/A")) %>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="padding-left: 5px;">
                                                                                Docket #:</td>
                                                                            <td style="height: 20px; font-weight: bold; " align="left">
                                                                                <asp:Label ID="Label11" runat="server" Text='<%#IIF(Eval("DocketNo").ToString()<>"",Functions.StringTruncate(Functions.IfNull(Eval("DocketNo"),""),30),"N/A") %>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="padding-left: 5px;">
                                                                                Firm Case #:</td>
                                                                            <td style="height: 20px; font-weight: bold; " align="left">
                                                                                <asp:Label ID="Label12" runat="server" Text='<%#IIF(Eval("FirmCaseNo").ToString()<>"",Functions.StringTruncate(Functions.IfNull(Eval("FirmCaseNo"),""),30),"N/A") %>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="padding-left: 5px;">
                                                                                Case Date:
                                                                            </td>
                                                                            <td style="height: 20px; font-weight: bold; " align="left">
                                                                                <asp:Label ID="Label13" runat="server" Text='<%# CaseMgmt.TimeDate(Functions.IfNull(Eval("CaseDate"),"")) %>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="padding-left: 5px;">
                                                                                TimeSpent:</td>
                                                                            <td style="height: 20px; font-weight: bold;" align="left">
                                                                                <asp:Label ID="Label14" runat="server" Text='<%#IIF(Eval("TotalTimeSpent").ToString()<>"",Functions.IfNull(Eval("TotalTimeSpent"),""),"N/A") %>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style=" padding-left: 5px;">
                                                                                Cost:</td>
                                                                            <td style="height: 20px; font-weight: bold; " align="left">
                                                                                <asp:Label ID="Label23" runat="server" Text='<%#IIF(Eval("TotalCost").ToString()<>"",Decimal.Round(Functions.IfNull(Eval("TotalCost"),""),2),"N/A")%>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style=" padding-left: 5px; vertical-align:top;" >
                                                                                Description:</td>
                                                                            <td style="height: 20px; font-weight: bold; " align="left">
                                                                                <asp:Label ID="Label24" runat="server" Text='<%# Server.HtmlEncode(Functions.StringTruncate(Me.ChkNullDescription(Functions.IfNull(Container.DataItem("Description"),"N/A")),25)) %>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        
                                                                        <tr style='<%#IIF(Eval("Name").ToString()<>"","Display:inline" , "Display:none") %>'>
                                                                            <th style="height: 20px; font-weight: bold; border-top: 1 solid #7DA4CD;" colspan="2"
                                                                                align="left">
                                                                                &nbsp;Firm/Vendor Information</th>
                                                                        </tr>
                                                                        <tr style='<%#IIF(Eval("Name").ToString()<>"","Display:inline" , "Display:none") %>'>
                                                                            <td style=" padding-left: 5px;">
                                                                                Name:
                                                                            </td>
                                                                            <td style="height: 20px; font-weight: bold; " align="left">
                                                                                <asp:Label ID="Label15" runat="server" ToolTip='<%# Functions.IfNull(Eval("Name"),"") %>' Text='<%#IIF(Eval("Name").ToString()<>"",Server.HtmlEncode(Functions.StringTruncate(Me.chkNullDescription(Functions.IfNull(Eval("Name"),"")),30)),"N/A") %>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr style='<%#IIF(Eval("Address").ToString()<>"","Display:inline" , "Display:none") %>'>
                                                                            <td style=" padding-left: 5px;">
                                                                                Address:
                                                                            </td>
                                                                            <td style="height: 20px; font-weight: bold; " align="left">
                                                                                <asp:Label ID="Label16" runat="server" Text='<%#IIF(Eval("Address").ToString()<>"",Server.HtmlEncode(Functions.StringTruncate(Me.chkNullDescription(Functions.IfNull(Eval("Address"),"")),30)),"N/A") %>'
                                                                                    ToolTip='<%# Functions.IfNull(Eval("Address"),"") %>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr style='<%#IIF(Eval("Phone").ToString()<>"","Display:inline" , "Display:none") %>'>
                                                                            <td style="padding-left: 5px;">
                                                                                Phone:
                                                                            </td>
                                                                            <td style="height: 20px; font-weight: bold; " align="left">
                                                                                <asp:Label ID="Label17" runat="server" Text='<%# Functions.IfNull(Eval("Phone"),"") %>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr style='<%#IIF(Eval("Fax").ToString()<>"","Display:inline" , "Display:none") %>'>
                                                                            <td style=" padding-left: 5px;">
                                                                                Fax:
                                                                            </td>
                                                                            <td style="height: 20px; font-weight: bold; " align="left">
                                                                                <asp:Label ID="Label18" runat="server" Text='<%# Functions.IfNull(Eval("Fax"),"") %>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr style='<%#IIF(Eval("Country").ToString()<>"","Display:inline" , "Display:none") %>'>
                                                                            <td style=" padding-left: 5px;">
                                                                                Country:
                                                                            </td>
                                                                            <td style="height: 20px; font-weight: bold; " align="left">
                                                                                <asp:Label ID="Label19" runat="server" Text='<%# Functions.IfNull(Eval("Country"),"") %>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr style='<%#IIF(Eval("State").ToString()<>"","Display:inline" , "Display:none") %>'>
                                                                            <td style="padding-left: 5px;">
                                                                                State:
                                                                            </td>
                                                                            <td style="height: 20px; font-weight: bold; " align="left">
                                                                                <asp:Label ID="Label20" runat="server" Text='<%# Functions.IfNull(Eval("State"),"") %>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr style='<%#IIF(Eval("City").ToString()<>"","Display:inline" , "Display:none") %>'>
                                                                            <td style="padding-left: 5px;">
                                                                                City:
                                                                            </td>
                                                                            <td style="height: 20px; font-weight: bold; " align="left">
                                                                                <asp:Label ID="Label21" runat="server" Text='<%# Functions.IfNull(Eval("City"),"") %>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr style='<%#IIF(Eval("Zip").ToString()<>"","Display:inline" , "Display:none") %>'>
                                                                            <td style="padding-left: 5px;">
                                                                                Zip:
                                                                            </td>
                                                                            <td style="height: 20px; font-weight: bold; " align="left">
                                                                                <asp:Label ID="Label22" runat="server" Text='<%# Functions.IfNull(Eval("Zip"),"") %>'></asp:Label>&nbsp;
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td valign="top" style="width: 27px;">
                                                    <table width="27" style="height: 100%;" border="0" align="left" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td style="height: 219px; cursor: pointer;" colspan="2" id="OpenProfile">
                                                                <img src="../images/vital_info_open.gif" onmouseout="this.src='../images/vital_info_open.gif'"
                                                                    onmouseover="this.src='../images/vital_info_open_over.gif'" onclick="showHideVital_Case();"
                                                                    name="img_vital_info" width="27" height="219" border="0" alt="" /></td>
                                                            <td style="height: 219px; display: none; cursor: pointer;" colspan="2" id="CloseProfile">
                                                                <img src="../images/vital_info_close.gif" onmouseout="this.src='../images/vital_info_close.gif';"
                                                                    onmouseover="this.src='../images/vital_info_close_over.gif'" onclick="showHideVital_Case();"
                                                                    name="img_vital_info" width="27" height="219" border="0" alt="" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="background-image: url(../images/vital_info_bottom_bg.gif); width: 8px;
                                                                border-bottom: 1px solid #609BD3;">
                                                                &nbsp;
                                                            </td>
                                                            <td style="width: 19px;">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:FormView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:ObjectDataSource ID="CaseInfoDS" runat="server" SelectMethod="GetCaseFirmInfo"
                            TypeName="CaseMgmt">
                            <SelectParameters>
                                <asp:QueryStringParameter DefaultValue="" Name="CaseID" QueryStringField="ID" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </div>
                </td>
                <td height="100%">
                    <iframe id="RightFrame" name="RightFrame" frameborder="0" scrolling="no" width="100%"
                        height="100%" hspace="0" vspace="0" src="Legal_Case_Activities.aspx?<%=Request.QueryString().tostring() %>">                        
                    </iframe>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
