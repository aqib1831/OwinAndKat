<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LegalHome.aspx.vb" Inherits="admin_Legal_LegalHome" Theme="Default" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home</title>
    <link href="../style/style.css" type="text/css" rel="stylesheet" />
    <link href="Style/Style.css" type="text/css" rel="stylesheet" />
    <link href="../style/Calendar/style.css" type="text/css" rel="stylesheet" />

    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>

    <script type="text/javascript" language="JavaScript" src="../scripts/functions.js"></script>

    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>

    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>

    <script type="text/javascript" language="javascript">
function RedirectToActivity(type,id)
{
    if(type=='Case')
    window.navigate('CaseMain.aspx?Source=LegalHome&ID='+id);
    if(type=='IP')
           window.navigate('IPMain.aspx?Source=LegalHome&ID='+id);
    if(type=='Alert')          
        window.navigate('IPMain.aspx?Source=LegalHome&ID='+id);
           
}

function RedirectActivity(type,id,alType)
{
    
    if(type=='Case')
    window.navigate('CaseMain.aspx?ID='+id);
        if(type=='IP')
    window.navigate('IPMain.aspx?ID='+id);
          if(type=='Alert')
          {
            if(alType==1)
            window.navigate('IPMain.aspx?Source=LegalHome&ID='+id);
            else
            window.navigate('CaseMain.aspx?Source=LegalHome&ID='+id);
          }

}
    </script>

    <style type="text/css">
.FloatingHeader1
{
   height:18px;
   text-align:left;
   background-color:#BADCFC;
   position: relative;
   border-top:1px solid white;
   top:expression(eval(this.parentElement.parentElement.parentElement.parentElement.scrollTop));
}
.FloatingHeader1 th
{
   color:#52789C;
   font-size:11px;
   font-weight:bold;
   padding-left:0.5em;
   background-image: url('../images/bg_toolbar.jpg');
   background-repeat:no-repeat;
   cursor:default;
}
</style>
</head>
<body style="margin: 0px;" scroll="no" class="ScrollBarHomeTicket">
    <form id="form1" runat="server">
     <asp:UpdateProgress ID="UpdateProgress1" runat="server">
            <ProgressTemplate>
                <div id="ProgressBar" style="position: absolute; width: 150px; height: 53px; right: 2%;
                    bottom: 2%;" class="MessageDiv">
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 100%">
                        <tr>
                            <td align="right" valign="middle" style="width: 40%;">
                                <div style="text-align: right;">
                                    <asp:Image ID="Image2" runat="server" ImageUrl="../../images/indicator.gif" ImageAlign="AbsMiddle" />&nbsp;&nbsp;
                                </div>
                            </td>
                            <td nowrap="nowrap" align="left" valign="middle" id="divMessage" style="width: 75%;
                                color: #4B92C1;">
                                <b>Loading ...</b>
                            </td>
                        </tr>
                    </table>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
        <table border="0" cellpadding="0" cellspacing="0" height="100%" width="100%" class="MainTable">
            <tr class="PageMainHeading" style="display:none; height:31px;">
                <td  height="31" style="border-bottom: #609bd3 1px solid;" >
                    Legal Home<asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                </td>
            </tr>
            <tr>

                <td>
                    <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="5" bgcolor="#e4f1f7">
                        <tr>
                            <td valign="top" height="100%" style="border-right: #609bd3 1px solid; border-top: #609bd3 1px solid;
                                border-left: #609bd3 1px solid; border-bottom: #609bd3 1px solid">
                                <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td height="25" style="border-bottom: #609bd3 1px solid; padding-left: 5px; background-color: #badcfc;">
                                            <strong>My Activities (<asp:Label ID="lblMyActivitiesCount" runat="server"></asp:Label>)</strong></td>
                                    </tr>
                                    <tr>
                                        <td valign="top" style="background-color: White;">
                                            <div style="overflow-y: auto; height: 100%; width: 100%;">
                                                <asp:UpdatePanel ID="UPdatePanelMyActivities" runat="server">
                                                    <ContentTemplate>
                                                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="GView">
                                                            <tr class="FloatingHeader">
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                                <td>
                                                                    <strong>Name</strong></td>
                                                                <td>
                                                                    <strong>Related To</strong></td>
                                                                <td>
                                                                    <strong>Status</strong></td>
                                                            </tr>
                                                            <asp:Repeater ID="RptrMyActivities" runat="server" DataSourceID="odsMyActivities">
                                                                <ItemTemplate>
                                                                    <tr onmouseover="this.className='HighlightedHomeRow';" onmouseout="this.className='SimpleHomeRow';"
                                                                        onclick="RedirectToActivity('<%#Eval("Type")%>','<%#Eval("ID") %>')">
                                                                        <td style="padding-left: 5px; padding-right: 5px; width: 30px">
                                                                            <img src='<%#IIF(Eval("Type").ToString()="Case","images/Case.gif","images/ip.gif") %>' />
                                                                        </td>
                                                                        <td style="width: 200px;">
                                                                            <asp:Label ID="lblName" runat="server" Text='<%#Server.HtmlEncode(Functions.StringTruncate(Eval("Subject"),30)) %>'
                                                                                ToolTip='<%#Eval("Subject") %>'></asp:Label>
                                                                        </td>
                                                                        <td style="width: 200px;">
                                                                            <asp:Label ID="lblRelatedTo" runat="server" Text='<%#Server.HtmlEncode(Functions.StringTruncate(Eval("Title"),30))  %>'
                                                                                ToolTip='<%#Eval("Title")%>'></asp:Label>
                                                                        </td>
                                                                        <td style="width: 100px; padding-right:5px;">
                                                                            <asp:Label ID="lblStatus" runat="server" Text='<%#Server.HtmlEncode(Eval("MyStatus")) %>'></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                </ItemTemplate>
                                                                <FooterTemplate>
                                                                    <tr id="trNoRec" style="height:25px;" runat="server" visible="false">
                                                                        <td align="center" valign="middle" style="height: 100%">
                                                                            <div id="divInfo" class="MessageDiv" style="left: 30%; margin: 5px; width: 200px;
                                                                                position: absolute; top: 35%; height: 50px">
                                                                                <table border="0" cellpadding="0" cellspacing="0" style="width: 170px; height: 50px">
                                                                                    <tr>
                                                                                        <td align="right" style="width: 25%" valign="middle">
                                                                                            <div style="text-align: right">
                                                                                                <asp:Image ID="Image1" runat="server" ImageUrl="~/images/icn_info.gif" />
                                                                                                &nbsp; &nbsp;</div>
                                                                                        </td>
                                                                                        <td id="divMessage" align="left" nowrap="nowrap" style="width: 75%" valign="middle">
                                                                                          &nbsp;  No activities found!</td>
                                                                                    </tr>
                                                                                </table>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </FooterTemplate>
                                                            </asp:Repeater>
                                                           
                                                        </table>
                                                        <asp:ObjectDataSource ID="odsMyActivities" runat="server" SelectMethod="Home_GetMyActivities"
                                                            TypeName="Home">
                                                            <SelectParameters>
                                                                <asp:Parameter Name="AdminID" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:ObjectDataSource>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td rowspan="2" width="35%" valign="top" style="border-right: #609bd3 1px solid;
                                border-top: #609bd3 1px solid; height:100%; border-left: #609bd3 1px solid; border-bottom: #609bd3 1px solid">
                                <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td height="25" style="border-bottom: #609bd3 1px solid; padding-left: 5px; background-color: #badcfc;">
                                            <asp:UpdatePanel ID="pnlAlret" runat="server">
                                                <ContentTemplate>
                                                        <strong>Alerts (<asp:Label ID="lblAlertsCount" runat="server"></asp:Label>)</strong>        
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                            </td>
                                    </tr>
                                    <tr valign="top">
                                        <td valign="top" style="background-color: White;height:400px;">
                                        <div style="overflow-y: auto; height: 100%; width: 100%; vertical-align:top;" class="GrayScrollBar">                                        
                                            <asp:UpdatePanel ID="pnlUpdate" runat="server">
                                                <ContentTemplate>
                                                    <table cellpadding="0" cellspacing="0" style="height: 100%; vertical-align:top;"  border="0" width="100%"
                                                        class="GView">                                                        
                                                            <asp:Repeater ID="RptrAlertsReminders" runat="server" DataSourceID="odsRemindersAlerts">
                                                                <ItemTemplate>
                                                                    <tr style="height:30px;" onmouseover="this.className='HighlightedHomeRow';" onmouseout="this.className='SimpleHomeRow';"
                                                                        onclick="RedirectActivity('<%#Eval("Type")%>',<%#Eval("ID") %>,<%# Eval("AlertType") %>);">
                                                                        <td style="padding-left: 5px; padding-right: 5px; padding-top: 5px; width: 22px;">
                                                                            <img src='<%#IIF(Eval("Type").ToString()="Alert","../images/ico_alert.gif","../../images/ico_reminder.gif") %>' />
                                                                        </td>
                                                                        <td style="padding-top: 5px;">
                                                                            <asp:Label ID="lblRemName" runat="server" Text='<%#Server.HtmlEncode(Functions.StringTruncate(Eval("Reminder"),12)) %>'
                                                                                ToolTip='<%#Eval("Reminder") %>'></asp:Label>
                                                                        </td>
                                                                        <td style="padding-top: 5px; width: 30%">
                                                                            <asp:Label ID="lblRemDate" runat="server" Text='<%#IntellectualProperty.GetStringDate(Eval("ReminderDate")) %>'></asp:Label>
                                                                        </td>
                                                                        <td style="padding-top: 5px;">
                                                                            <asp:LinkButton ID="lnkComplete" runat="server" Text="Close&nbsp;" OnClientClick="window.event.cancelBubble=true;return confirm('Are you sure you want to close this alert?')"
                                                                                CommandArgument='<%# GetArguments(Eval("ID"),Eval("AlertType"))  %>' CommandName="Edit"></asp:LinkButton>
                                                                        </td>
                                                                    </tr>
                                                                </ItemTemplate>
                                                                <FooterTemplate>
                                                                    <tr id="trNoRecAlert" runat="server" visible="false">
                                                                        <td align="center" valign="middle" style="height: 100%">
                                                                            <div id="divInfo" class="MessageDiv" style="left: 20%; margin: 5px; width: 170px;
                                                                                position: absolute; top: 35%; height: 50px">
                                                                                <table border="0" cellpadding="0" cellspacing="0" style="width: 160px; height: 50px">
                                                                                    <tr>
                                                                                        <td align="right" style="width: 25%" valign="middle">
                                                                                            <div style="text-align: right">
                                                                                                <asp:Image ID="Image1" runat="server" ImageUrl="~/images/icn_info.gif" />
                                                                                                &nbsp; &nbsp;</div>
                                                                                        </td>
                                                                                        <td id="divMessage" align="left" nowrap="nowrap" style="width: 75%" valign="middle">
                                                                                            &nbsp;&nbsp; No Alerts found!</td>
                                                                                    </tr>
                                                                                </table>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </FooterTemplate>
                                                            </asp:Repeater>      
                                                             <tr style="height:100%;">
                                                                <td colspan="4">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>                                                  
                                                    </table>                                                                                                       
                                                    <asp:ObjectDataSource ID="odsRemindersAlerts" runat="server" SelectMethod="Home_GetAlerts_Reminders"
                                                        TypeName="Home"></asp:ObjectDataSource>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                             </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" style="border-right: #609bd3 1px solid; border-top: #609bd3 1px solid;
                                border-left: #609bd3 1px solid; border-bottom: #609bd3 1px solid">
                                <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td height="25" style="border-bottom: #609bd3 1px solid; padding-left: 5px; background-color: #badcfc;">
                                            <strong>Closeout (<asp:Label ID="lblTodaysActivitiesCount" runat="server"></asp:Label>)</strong></td>
                                    </tr>
                                    <tr>
                                        <td valign="top" style="background-color: White;">
                                            <div style="overflow-y: auto; height: 100%; width: 100%;">
                                                <asp:UpdatePanel ID="UPdatePanel1" runat="server">
                                                    <ContentTemplate>
                                                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="GView">
                                                            <tr class="FloatingHeader1">
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                                <td>
                                                                    <strong>Name</strong></td>
                                                                <td>
                                                                    <strong>Related To</strong></td>
                                                                <td>
                                                                    <strong>Status</strong></td>
                                                            </tr>
                                                            <asp:Repeater ID="RptrTodaysActivities" runat="server" DataSourceID="odsTodaysActivities">
                                                                <ItemTemplate>
                                                                    <tr onmouseover="this.className='HighlightedHomeRow';" onmouseout="this.className='SimpleHomeRow';"
                                                                        onclick="RedirectToActivity('<%#Eval("Type")%>','<%#Eval("ID") %>')">
                                                                        <td style="padding-left: 5px; padding-right: 5px; width: 30px">
                                                                            <img src='<%#IIF(Eval("Type").ToString()="Case","images/Case.gif","images/ip.gif") %>' />
                                                                        </td>
                                                                        <td style="width: 200px;">
                                                                            <asp:Label ID="lblName" runat="server" Text='<%#Server.HtmlEncode(Functions.StringTruncate(Eval("Subject"),30)) %>'
                                                                                ToolTip='<%#Eval("Subject") %>'></asp:Label>
                                                                        </td>
                                                                        <td style="width: 200px;">
                                                                            <asp:Label ID="lblRelatedTo" runat="server" Text='<%#Server.HtmlEncode(Functions.StringTruncate(Eval("Title"),30)) %>'
                                                                                ToolTip='<%#Eval("Title") %>'></asp:Label>
                                                                        </td>
                                                                        <td style="width: 100px; padding-right:5px;">
                                                                        <asp:Label ID="Label1" runat="server" Text='<%#Server.HtmlEncode(Eval("MyStatus")) %>'></asp:Label>
                                                                                    <%--<asp:Label ID="lblStatus" runat="server" Text='<%#IIF(cint(Eval("ActivityState"))=4,"WF:"&functions.ifnull(Eval("AssignedAdmin").ToString(),"&nbsp;"),IIF(Eval("Type").ToString()="Case",CaseMgmt.GetActivityStateID(Eval("ActivityState")),IntellectualProperty.GetActivityStateID(Eval("ActivityState")))) %>'></asp:Label>--%>
                                                                        </td>
                                                                    </tr>
                                                                </ItemTemplate>
                                                                <FooterTemplate>
                                                                    <tr id="trNoRec" runat="server" visible="false">
                                                                        <td align="center" valign="middle" style="height: 100%">
                                                                            <div id="divInfo" class="MessageDiv" style="left: 30%; margin: 5px; width: 200px;
                                                                                position: absolute; top: 35%; height: 50px">
                                                                                <table border="0" cellpadding="0" cellspacing="0" style="width: 170px; height: 50px">
                                                                                    <tr>
                                                                                        <td align="right" style="width: 25%" valign="middle">
                                                                                            <div style="text-align: right">
                                                                                                <asp:Image ID="Image1" runat="server" ImageUrl="~/images/icn_info.gif" />
                                                                                                </div>
                                                                                        </td>
                                                                                        <td id="divMessage" align="left" nowrap="nowrap" style="width: 75%" valign="middle">
                                                                                            &nbsp;&nbsp; No activities performed today!</td>
                                                                                    </tr>
                                                                                </table>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    </table>
                                                                </FooterTemplate>
                                                            </asp:Repeater>
                                                        </table>
                                                        <asp:ObjectDataSource ID="odsTodaysActivities" runat="server" SelectMethod="Home_TodaysActivities"
                                                            TypeName="Home">
                                                            <SelectParameters>
                                                                <asp:Parameter Name="AdminID" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:ObjectDataSource>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
