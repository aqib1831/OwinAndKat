<%@ Page Language="VB" AutoEventWireup="false" CodeFile="IPMain.aspx.vb" Inherits="admin_Legal_CaseMain" Theme="Default" %>

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
    
    function showHideVital_IP()
    {
	if (blnShowed == false)
	    {
		    setWindowedControlsVisibility(window, 'hidden');
		    getElement('OpenProfile').style.display = 'none';
		    getElement('CloseProfile').style.display = 'inline';
		    getElement('FullVital_IPDetail').style.display = 'inline';
		    moveit(-320);
		    blnShowed = true;
	    }
	    else
	    {
			    getElement('CloseProfile').style.display = 'none';
			    getElement('OpenProfile').style.display = 'inline';
			    getElement('FullVital_IPDetail').style.display = 'none';
			    moveleft(20);
			    blnShowed = false;
	    }
    }

    </script>
</head>
<body style="margin: 0px; width: 100%; height: 100%; background-color: #BADCFC;" scroll="No" class="ScrollBarHomeTicket" onload="showHideVital_IP();">
<div align="left" id="FullVital_IPDetail" style="display:inline;position:absolute;overflow:auto;height:100%;width:100%;top:0px;left:0px;" onClick="showHideVital_IP();"></div>
    <form id="Form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
         <tr style="display:none;">
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
                                            <table style="width: 100%; height: 100%; border-right: 1px solid #609BD3;"
                                                border="0" align="center" cellpadding="0" cellspacing="0" class="blueSubTableTD">
                                                <tr>
                                                    <th style="height: 20px;" align="left">
                                                        &nbsp;Intellectual Property Information
                                                    </th>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div style="height: 100%; width: 100%; overflow-y: auto;">
                                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Title:</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label1" runat="server" ToolTip='<%#Eval("Title") %>' Text='<%#Server.HtmlEncode(Functions.StringTruncate(Eval("Title"),30)) %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Type:</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label3" runat="server" Text='<%#Server.HtmlEncode(Functions.IfNull(Eval("TypeName"), "N/A")) %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Assigned:</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label5" runat="server" Text='<%#CaseMgmt.Legal_GetAdminName(Eval("AssignedTo")) %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        From:</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label6" runat="server" Text='<%#CaseMgmt.Legal_GetAdminName(Eval("UserId")) %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        First Used:</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label7" runat="server" Text='<%#Convert.ToDateTime(Convert.ToString(Eval("DateFirstUsed"))).ToShortDateString() %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Applied:</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label8" runat="server" Text='<%# Functions.ToLongDate(Eval("DateApplied"), "N/A") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Modified:</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label2" runat="server" Text='<%# Functions.ToLongDate(Eval("ModifiedDate"), "N/A") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Firm/Vendor:</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label9" runat="server" Text='<%#IIF(String.IsNullOrEmpty(Functions.IfNull(Eval("Name"), String.Empty))= False,Server.HtmlEncode(Functions.StringTruncate(Me.chkNullDescription(Eval("Name")),30)),"N/A") %>' ToolTip='<%#Functions.IfNull(Eval("Name"), String.Empty) %>'>&nbsp;</asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Status:</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label10" runat="server" Text='<%#Server.HtmlEncode(Functions.IfNull(Eval("StatusName"), "N/A")) %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Reg. #:</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label11" runat="server" Text='<%#IIF(String.IsNullOrEmpty(Functions.IfNull(Eval("RegistrationNo"), String.Empty))= False,Functions.StringTruncate(Functions.IfNull(Eval("RegistrationNo"), String.Empty),30),"N/A") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Serial #:</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label12" runat="server" Text='<%#IIF(String.IsNullOrEmpty(Functions.IfNull(Eval("SerialNo"), String.Empty))= False,Functions.StringTruncate(Functions.IfNull(Eval("SerialNo"), String.Empty),30),"N/A") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                               
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        TimeSpent:</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label14" runat="server" Text='<%#IIF(Eval("TimeSpent").ToString()<>"",Eval("TimeSpent"),"00:00")+" (HH:MM) " %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                  <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Expires:</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label4" runat="server" Text='<%# Functions.ToLongDate(Eval("ExpiresOn"), "&nbsp;") & ShowHyphenBetweenDates(Eval("ExpiresOn"), Eval("ExpiresOnTo")) & Functions.ToLongDate(Eval("ExpiresOnTo"), "N/A")  %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Country:</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label13" runat="server" Text='<%#IIF(String.IsNullOrEmpty(Functions.IfNull(Eval("LegalCountryName"), String.Empty)) = False,Functions.IfNull(Eval("LegalCountryName"), String.Empty),"N/A") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Owner:</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label24" runat="server" Text='<%#IIF(String.IsNullOrEmpty(Functions.IfNull(Eval("OwnerName"), String.Empty)) = False, Functions.IfNull(Eval("OwnerName"), String.Empty),"N/A") %>'></asp:Label>
                                                                    </td>
                                                                </tr>                                                                
                                                                
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Dec. of Use:</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label25" runat="server" Text='<%# Functions.ToLongDate(Eval("DeclarationOfUseFrom"), "&nbsp;") & Me.ShowHyphenBetweenDates(Eval("DeclarationOfUseFrom"), Eval("DeclarationOfUseTo")) & Functions.ToLongDate(Eval("DeclarationOfUseTo"), "N/A")  %>'></asp:Label>
                                                                    </td>
                                                                </tr>

                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Creation Date:</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label26" runat="server" Text='<%# Functions.ToLongDate(Eval("CreationDate"), "N/A") %>'></asp:Label>
                                                                    </td>
                                                                </tr>                                                                

                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Reg. Date:</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label27" runat="server" Text='<%# Functions.ToLongDate(Eval("RegistrationDate"), "N/A") %>'></asp:Label>
                                                                    </td>
                                                                </tr>                                                                
                                                                
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Pub. for Opp.:</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label28" runat="server" Text='<%# Functions.ToLongDate(Eval("PbulishedForOpposition"), "N/A") %>'></asp:Label>
                                                                    </td>
                                                                </tr>                                                                

                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px; vertical-align:top;">
                                                                        Description:</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label23" runat="server" Text='<%#Me.ChkNullDescription(Functions.StringTruncate(Functions.IfNull(Container.DataItem("Description"), "N/A"),40))%>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr style='<%#IIF(String.IsNullOrEmpty(Functions.IfNull(Eval("Name"), String.Empty))= False,"Display:inline" , "Display:none") %>'>
                                                                    <th style="height: 20px; font-weight: bold; border-top: 1 solid #7DA4CD;" colspan="2"
                                                                        align="left">
                                                                        &nbsp;Firm/Vendor Information:</th>
                                                                </tr>
                                                                <tr style='<%#IIF(String.IsNullOrEmpty(Functions.IfNull(Eval("Name"), String.Empty))= False,"Display:inline" , "Display:none") %>'>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Name:
                                                                    </td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label15" runat="server" Text='<%#IIF(String.IsNullOrEmpty(Functions.IfNull(Eval("Name"), String.Empty))= False,Server.HtmlEncode(Functions.StringTruncate(Me.chkNullDescription(Functions.IfNull(Eval("Name"), String.Empty)),30)),"N/A") %>' ToolTip='<%#Functions.IfNull(Eval("Name"), String.Empty) %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr style='<%#IIF(String.IsNullOrEmpty(Functions.IfNull(Eval("Address"), String.Empty))= False,"Display:inline" , "Display:none") %>'>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Address:
                                                                    </td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label16" runat="server" Text='<%#IIF(String.IsNullOrEmpty(Functions.IfNull(Eval("Address"), String.Empty))= False,Server.HtmlEncode(Functions.StringTruncate(Me.chkNullDescription(Functions.IfNull(Eval("Address"), String.Empty)),30)),"N/A") %>' ToolTip='<%#Functions.IfNull(Eval("Address"), String.Empty) %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr style='<%#IIF(String.IsNullOrEmpty(Functions.IfNull(Eval("Phone"), String.Empty))= False,"Display:inline" , "Display:none") %>'>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Phone:
                                                                    </td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label17" runat="server" Text='<%#Functions.IfNull(Eval("Phone"), "N/A") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr style='<%#IIF(String.IsNullOrEmpty(Functions.IfNull(Eval("Fax"), String.Empty))= False,"Display:inline" , "Display:none") %>'>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Fax:
                                                                    </td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label18" runat="server" Text='<%#Functions.IfNull(Eval("Fax"), "N/A") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr style='<%#IIF(String.IsNullOrEmpty(Functions.IfNull(Eval("Country"), String.Empty))= False,"Display:inline" , "Display:none") %>'>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Country:
                                                                    </td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label19" runat="server" Text='<%#Functions.IfNull(Eval("Country"), "N/A") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr style='<%#IIF(String.IsNullOrEmpty(Functions.IfNull(Eval("State"), String.Empty))= False,"Display:inline" , "Display:none") %>'>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        State:
                                                                    </td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label20" runat="server" Text='<%# Functions.IfNull(Eval("State"), "N/A") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr style='<%#IIF(String.IsNullOrEmpty(Functions.IfNull(Eval("City"), String.Empty))= False,"Display:inline" , "Display:none") %>'>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        City:
                                                                    </td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label21" runat="server" Text='<%#Functions.IfNull(Eval("City"), "N/A") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr style='<%#IIF(String.IsNullOrEmpty(Functions.IfNull(Eval("Zip"), String.Empty))= False,"Display:inline" , "Display:none") %>'>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Zip:
                                                                    </td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label22" runat="server" Text='<%#Functions.IfNull(Eval("Zip"), "N/A") %>'></asp:Label>&nbsp;
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
                                                            onmouseover="this.src='../images/vital_info_open_over.gif'" onclick="showHideVital_IP();"
                                                            name="img_vital_info" width="27" height="219" border="0"
                                                            alt="" /></td>
                                                    <td style="height: 219px; display: none; cursor: pointer;" colspan="2" id="CloseProfile">
                                                        <img src="../images/vital_info_close.gif" onmouseout="this.src='../images/vital_info_close.gif'"
                                                            onmouseover="this.src='../images/vital_info_close_over.gif'" onclick="showHideVital_IP();"
                                                            name="img_vital_info" width="27" height="219" border="0" alt="" /></td>
                                                </tr>
                                                <tr>
                                                    <td style="background-image: url(../images/vital_info_bottom_bg.gif); width: 8px;border-bottom: 1px solid #609BD3;">&nbsp;</td>
                                                    <td style="width: 19px;">&nbsp;</td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:FormView>
                        </ContentTemplate>
                        </asp:UpdatePanel>
        <asp:ObjectDataSource ID="CaseInfoDS" runat="server" SelectMethod="GetIPFirmInfo"
            TypeName="IntellectualProperty">
            <SelectParameters>
                <asp:QueryStringParameter Name="IPID" QueryStringField="ID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
                    </div>
                </td>
                <td height="100%">
                    <iframe id="RightFrame" frameborder="0" scrolling="no" width="100%" height="100%"
                        hspace="0" vspace="0" src="Legal_IP_Activities.aspx?<%=Request.QueryString().tostring %>">
                    </iframe>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
