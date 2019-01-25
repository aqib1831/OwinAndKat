<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Legal_Case_Activities.aspx.vb" Inherits="admin_Legal_Legal_IP_Activities" validateRequest="false" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Legal Case</title>
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=.1)" />
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
    
    <link href="Style/Style.css" type="text/css" rel="stylesheet" />
    <link href="../Style/Style.css" type="text/css" rel="stylesheet" />
       
    
    <link href="../App_Themes/Default/Calendar/style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
    .filterdropdown{
        font-size:9px;
        width:120px;
    }
    .FloatingHeader1{
        height:18px;
        text-align:left;
        background-color:#BADCFC;
        position: relative;
        border-top:1px solid white;
        top:expression(eval(this.parentElement.parentElement.parentElement.parentElement.scrollTop));
    }
    .FloatingHeader1 th{
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
<body style="margin: 0px;padding: 0px;" scroll="no" class="ScrollBarHomeTicket" onload="Init()">
    <form id="form1" runat="server" defaultfocus="txtSearch">
        <script type="text/javascript" language="javascript">
        function Init(){
            try{
                document.getElementById('<%= txtSearch.ClientID %>').value='';
            }catch(ex){}
        }
        </script>
        <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" class="MainTable"
            style="padding: 0px; margin: 0px;">
            <tr class="UnderlinedRow" height="31px">
                <td class="PageMainHeading" style="height: 31px; width: 60%;">
                <asp:Label CssClass="DarkBluelabel" ID="lblTitle" runat="server"></asp:Label>
                    &nbsp;&nbsp;<span class="SimpleSmall">[&nbsp;<a href="#" onclick="parent.parent.frameMain.location='Legal_Case_Edit.aspx?<%=Request.QueryString().ToString() %>&ActivityPage=true'">Edit Case</a>&nbsp;]</span>
          </td>
                <td class="PageMainHeading" align="right" style="padding-right:0.5em;">
               <input id="btnHistory" class="FlatButton" style="width: 130px; padding: 2px;" type="button"
                        value="History" onclick="parent.RightFrame.location='Case_IP_History.aspx?RequestFrom=1&ID=<%=Request.QueryString("ID") %>'" />
                    <input 
                        id="btnNewIP" 
                        class="FlatButton" 
                        style="width: 130px;padding:2px;" 
                        type="button" 
                        value="New Case Activity"
                        onclick="parent.parent.frameMain.location='NewCaseActivity.aspx?ID=<%=Request.QueryString("ID") %>'" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;height: 100%;">
                        <tr>
                            <td style="height: 31px">
                                <table width="100%" border="0" style="text-align: left" align="center" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="width: 100px; padding-bottom: 5px;height: 43px;padding-left:0.5em;">
                                            <br />
                                            <span class="PageSubHeading" style="font-size: 10pt; color: black;">
                                            <b>Inbox</b> (<asp:Label ID="lblincount" runat="server"></asp:Label>)</span>
                                        </td>
                                        <td width="5" align="center">
                                            <img src="../images/pixel_darkBlue.JPG" height="35" width="1" align="absmiddle" style="background-color: #82BDE9" />
                                        </td>
                                        <td style="width: 250px; white-space: nowrap; padding-left: 8px; padding-bottom: 5px;">
                                            <span class="GreyTextSmall">Search:</span><br />
                                            <asp:TextBox ID="txtSearch" runat="server" CssClass="blueTextbox" Width="180px" ValidationGroup="srch"></asp:TextBox>&nbsp;
                                            <asp:ImageButton align="absmiddle" ID="btnSearch" runat="server" ImageUrl="../images/btn_go.gif" /></td>
                                        <td style="padding-bottom: 2px; padding-right:0.5em;"><input 
                        id="btnBack" 
                        class="FlatButton" 
                        style="width: 130px;float:right; padding:2px;" 
                        type="button" 
                        value="BACK"
                        onclick="parent.location='<%=SetBackButtonUrl()%>.aspx'" /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="height: 49%">
                            <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" style="width: 100%; border-top: solid 1px #609BD3;
                                border-bottom: solid 1px #609BD3">
                                <div style="overflow: auto; height: 100%; width: 100%;">
                                    <asp:GridView ID="GridView1" runat="server" EnableViewState="False" DataSourceID="LegalActivitiesInbox"
                                        AutoGenerateColumns="False" AllowPaging="false" Width="100%" CssClass="GView" BorderWidth="0" >
                                        <FooterStyle CssClass="SimpleExSmall" />
    <HeaderStyle CssClass="FloatingHeader" />
    <RowStyle CssClass="SimpleHomeRow"/>
                                        <EmptyDataTemplate>
                                            <div id="divInfo" class="MessageDiv" style="left: 38%; width: 200px; position: absolute;
                                                top: 38%; height: 18%">
                                                <table border="0" cellpadding="0" cellspacing="0" style="height: 50px; width: 120%;">
                                                    <tr>
                                                        <td style="width: 5%">&nbsp;
                                                            </td>
                                                        <td align="right" style="width: 25%" valign="middle">
                                                            <div style="text-align: right">
                                                                <asp:Image ID="Image1" runat="server" ImageUrl="~/images/icn_info.gif" />
                                                                &nbsp;
                                                            </div>
                                                        </td>
                                                        <td id="divMessage" align="left" nowrap="nowrap" style="width: 75%" valign="middle">
                                                            &nbsp;No Activity Found in Inbox!</td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </EmptyDataTemplate>
                                        <Columns>
                                            <asp:TemplateField HeaderText="Subject">
                                                 <ItemTemplate>
                                                    &nbsp;<asp:Label ID="Label3" runat="server" Text='<%#Server.HtmlEncode(Functions.StringTruncate(Eval("Subject").ToString(),40)) %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                           
                                            <asp:TemplateField HeaderText="Type">
                                                <ItemTemplate>
                                                    &nbsp;<asp:Label ID="Label1" runat="server" Text='<%#Server.HtmlEncode(Eval("TypeName"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                  &nbsp;  <asp:Label ID="Label2" runat="server" Text='<%#CaseMgmt.GetActivityStateID(Eval("ActivityState")) & " " & Eval("AssignedTo")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                          
                                            <asp:TemplateField HeaderText="Date">
                                               
                                                <ItemTemplate>
                                                    &nbsp;<asp:Label ID="Label6" runat="server" Text='<%# CaseMgmt.GetStringDate(Eval("Date"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="TimeSpent">
                                                 <ItemTemplate>
                                                  &nbsp;  <asp:Label ID="Label5" runat="server" Text='<%#CaseMgmt.GetGridTimeSpent(Eval("TimeSpent")) %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Cost">
                                            <ItemStyle HorizontalAlign="Left" />
                                                <ItemTemplate>
                                                  &nbsp;  <asp:Label ID="Label4" runat="server" Text='<%# Decimal.Round(Eval("Cost"),2) & "&nbsp;" %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                    <asp:ObjectDataSource ID="LegalActivitiesInbox" runat="server" SelectMethod="GetCaseActivities"
                                        TypeName="CaseMgmt">
                                        <SelectParameters>
                                            <asp:QueryStringParameter Name="ID" QueryStringField="ID" Type="Int32" />
                                            <asp:Parameter DefaultValue="true" Name="Status" Type="Boolean" />
                                            <asp:Parameter Name="StartDate" Type="DateTime" />
                                            <asp:Parameter Name="CloseDate" Type="DateTime" />
                                            <asp:ControlParameter ControlID="txtSearch" Name="Search" PropertyName="Text" Type="String" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                </div>
                            </td>
                        </tr>
                        <tr style="height: 31px">
                            <td>
                                <table width="100%" border="0" style="text-align: left;" align="center" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="width: 100px; padding-bottom: 5px;height: 43px;padding-left:0.5em;">
                                            <br />
                                            <span class="PageSubHeading" style="font-size: 10pt; color: black;">
                                            <b>History</b> (<asp:Label ID="lblHistoryCount" runat="server" />)</span>
                                        </td>
                                        <td>&nbsp;</td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="height: 49%">
                            <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" style="width: 100%; border-top: solid 1px #609BD3;
                                border-bottom: solid 1px #609BD3;">
                                <div style="overflow: auto; height: 100%; width: 100%;">
                                    <asp:GridView ID="GridView2" runat="server" EnableViewState="False" DataSourceID="LegalActivitiesHistory"
                                        AutoGenerateColumns="False" AllowPaging="false" Width="100%" BorderWidth="0" CssClass="GView">
                                        <FooterStyle CssClass="SimpleExSmall" />
    <HeaderStyle CssClass="FloatingHeader" />
    <RowStyle CssClass="SimpleHomeRow"/>
                                        <EmptyDataTemplate>
                                            <div id="divInfo" class="MessageDiv" style="left: 38%; width: 200px; position: absolute;
                                                top: 38%; height: 18%">
                                                <table border="0" cellpadding="0" cellspacing="0" style="height: 50px; width: 120%;">
                                                    <tr>
                                                        <td style="width: 5%">&nbsp;
                                                            </td>
                                                        <td align="right" style="width: 25%" valign="middle">
                                                            <div style="text-align: right">
                                                                <asp:Image ID="Image1" runat="server" ImageUrl="~/images/icn_info.gif" />
                                                                &nbsp;
                                                            </div>
                                                        </td>
                                                        <td id="divMessage" align="left" nowrap="nowrap" style="width: 75%" valign="middle">
                                                            &nbsp;No Activity Found in History!</td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </EmptyDataTemplate>
                                        <Columns>
                                             <asp:TemplateField HeaderText="Subject">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Server.HtmlEncode(Eval("Subject"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Type">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label1" runat="server" Text='<%#Server.HtmlEncode(Eval("TypeName"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label2" runat="server" Text='<%# CaseMgmt.GetActivityStateID(CInt(Eval("ActivityState"))) %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Date">
                                               <ItemTemplate>
                                                    <asp:Label ID="Label3" runat="server" Text='<%# CaseMgmt.GetStringDate(Eval("Date")) %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="CloseDate">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label5" runat="server" Text='<%# CaseMgmt.GetStringDate(Eval("CloseDate")) %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="TimeSpent" HeaderText="TimeSpent" />
                                            <asp:TemplateField HeaderText="Cost">
                                            <ItemStyle HorizontalAlign="Left" />
                                                <ItemTemplate>
                                                    <asp:Label ID="Label4" runat="server" Text='<%# Decimal.Round(Eval("Cost"),2) & "&nbsp;" %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                    &nbsp;
                                    <asp:ObjectDataSource ID="LegalActivitiesHistory" runat="server" SelectMethod="GetCaseActivities"
                                        TypeName="CaseMgmt">
                                        <SelectParameters>
                                            <asp:QueryStringParameter Name="ID" QueryStringField="ID" Type="Int32" />
                                            <asp:Parameter DefaultValue="false" Name="Status" Type="Boolean" />
                                            <asp:Parameter Name="StartDate" Type="DateTime" />
                                            <asp:Parameter Name="CloseDate" Type="DateTime" />
                                            <asp:Parameter Name="Search" Type="String" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 10px">&nbsp;</td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
