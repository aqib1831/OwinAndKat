<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Legal_IP_Activities.aspx.vb" Inherits="admin_Legal_Legal_IP_Activities" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Legal IP</title>
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=.1)" />
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
    <link href="../style/style.css" type="text/css" rel="stylesheet" />
    <link href="Style/Style.css" type="text/css" rel="stylesheet" />
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
<body style="margin: 0px; height: 100%; width: 100%; padding: 0px;" scroll="no" class="ScrollBarHomeTicket" onload="Init()">
    <form id="form1" runat="server" defaultfocus="txtSearch">
        <script type="text/javascript" language="javascript">
        function Init(){
            try{
                document.getElementById('<%= txtSearch.ClientID %>').value='';
            }catch(ex){}
        }
        </script>
        <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" class="MainTable" style="padding: 0px; margin: 0px; width: 100%;">
            <tr class="UnderlinedRow" height="31px">
                <td class="PageMainHeading" style="height: 31px; width: 80%;">
                    <asp:Label CssClass="DarkBluelabel" ID="lblActivities" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                    <span class="SimpleSmall">[&nbsp;<span onclick="parent.parent.frameMain.location='Legal_Ip_Edit.aspx?ID=<%=Request.QueryString("ID") %>&ActivityPage=true'"><asp:LinkButton ID="lnkEdit" runat="server" Text="<b>Edit IP</b>"></asp:LinkButton></span>&nbsp;]</span>
                </td>
                <td class="PageMainHeading" align="right" style="padding-right:0.5em;">
                 <input id="btnHistory" class="FlatButton" style="width: 130px; padding: 2px;" type="button"
                        value="History" onclick="parent.RightFrame.location='Case_IP_History.aspx?RequestFrom=2&ID=<%=Request.QueryString("ID") %>'" />&nbsp;
                    <input 
                        id="btnNewIP" 
                        class="FlatButton" 
                        style="width: 130px;padding:2px;" 
                        type="button" 
                        value="New IP Activity"
                        onclick="parent.parent.frameMain.location='NewLegalActivity.aspx?ID=<%=Request.QueryString("ID") %>'" />
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
                                            <b>Inbox</b> (<asp:Label ID="lblincount" runat="server" />)</span>
                                        </td>
                                        <td width="5" align="center">
                                            <img src="../images/pixel_darkBlue.JPG" height="35" width="1" align="absmiddle" style="background-color: #82BDE9" />
                                        </td>
                                        <td style="width: 250px; white-space: nowrap; padding-left: 8px; padding-bottom: 5px;">
                                            <span class="GreyTextSmall">Search:</span><br />
                                            <asp:TextBox ID="txtSearch" runat="server" CssClass="blueTextbox" Width="180px" ValidationGroup="srch"></asp:TextBox>&nbsp;
                                            <asp:ImageButton align="absmiddle" ID="btnSearch" runat="server" ImageUrl="../images/btn_go.gif" /></td>
                                        <td style="padding-bottom: 5px; padding-right:0.5em;"><input 
                        id="btnBack" 
                        class="FlatButton" 
                        style="width: 130px;float:right; padding:2px;" 
                        type="button" 
                        value="BACK"
                        onclick="parent.location='<%=SetBackButtonUrl() %>.aspx'" /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="height: 49%">
                            <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" style="width: 100%; border-top: solid 1px #609BD3;border-bottom: solid 1px #609BD3">
                                <div style="overflow: auto; height: 100%; width: 100%;">
                                    <asp:GridView ID="GridView1" runat="server" EnableViewState="False" DataSourceID="LegalActivitiesInbox"
                                        AutoGenerateColumns="False" AllowPaging="false" Width="100%" CssClass="GView" BorderWidth="0">

                                           <FooterStyle CssClass="SimpleExSmall" />
                                        <HeaderStyle CssClass="FloatingHeader" />
                                      <RowStyle CssClass="GridRowClickable" />
                                        <EmptyDataTemplate>
                                            <div id="divInfo" class="MessageDiv" style="left: 38%; width: 250px; position: absolute;
                                                top: 38%; height: 18%">
                                                <table border="0" cellpadding="0" cellspacing="0" style="height: 50px; width: 101%;">
                                                    <tr>
                                                        <td style="width: 5%">
                                                            &nbsp;</td>
                                                        <td align="right" style="width: 17%" valign="middle">
                                                            <div style="text-align: right">
                                                                <asp:Image ID="Image1" runat="server" ImageUrl="~/images/icn_info.gif" />
                                                                &nbsp;
                                                            </div>
                                                        </td>
                                                        <td id="divMessage" align="left" nowrap="nowrap" style="width: 75%" valign="middle">
                                                            &nbsp;No Activity(s) found in Inbox!</td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </EmptyDataTemplate>
                                        <Columns>
                                           
                                            <asp:TemplateField HeaderText="Subject">
                                                <ItemTemplate>
                                                   &nbsp; <asp:Label ID="Label3" runat="server" Text='<%# Server.HtmlEncode(Eval("Subject"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Type">
                                                <ItemTemplate>
                                                    &nbsp;<asp:Label ID="Label3" runat="server" Text='<%# Server.HtmlEncode(Eval("TypeName"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                  &nbsp;  <asp:Label ID="Label1" runat="server" Text='<%# IntellectualProperty.GetActivityStateID(Cint(Eval("ActivityState").ToString())) & " " & Eval("AdminName")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Time Spent">
                                                <ItemTemplate>
                                                    &nbsp;<asp:Label ID="Label4" runat="server" Text='<%# Eval("TimeSpent") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Date">
                                                <ItemTemplate>
                                                   &nbsp; <asp:Label ID="Label2" runat="server" Text='<%# IntellectualProperty.GetStringDate(Eval("Date")) %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            
                                            <asp:TemplateField HeaderText="Cost">
                                            <ItemStyle HorizontalAlign="Left" />
                                                <ItemTemplate>
                                                  &nbsp;  <asp:Label ID="Label4" runat="server" Text='<%# Decimal.Round(Eval("Cost"),2) & "&nbsp;" %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            
                                            <asp:BoundField DataField="LastWaitingFor" HeaderText="LastWaitingFor" Visible="False" />
                                        </Columns>
                                    </asp:GridView>
                                    <asp:ObjectDataSource ID="LegalActivitiesInbox" runat="server" SelectMethod="GetLegalActivities"
                                        TypeName="IntellectualProperty">
                                        <SelectParameters>
                                            <asp:QueryStringParameter Name="ID" QueryStringField="ID" Type="Int32" />
                                            <asp:Parameter DefaultValue="1" Name="Status" Type="Int32" />
                                            <asp:Parameter Name="StartDate" Type="DateTime" />
                                            <asp:Parameter Name="CloseDate" Type="DateTime" />
                                            <asp:ControlParameter ControlID="txtSearch" Name="Search" PropertyName="Text" Type="String" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                </div>
                            </td>
                        </tr>
                        <%--<tr style="height: 31px">
                            <td class="PageSubHeading">
                                <table width="98%;" border="0" style="text-align: left;" align="center" cellpadding="0"
                                    cellspacing="0">
                                    <tr>
                                        <td style="height: 31px; width: 68px; padding-bottom:5px;">
                                            <b style="padding-bottom: 5px; width: 70px">
                                                <br />
                                                <span class="PageSubHeading" style="width: 60px; font-size: 10pt; color: black;">
                                                History(<asp:Label ID="lblHistoryCount" runat="server"></asp:Label>)</span></b></td>
                                                <td width="1" bgcolor="#BADBFC" style="height: 43px">
                                            <img src="images/spacer.gif" height="35" width="1" align="absmiddle" style="background-color: #82BDE9"></td>
                                            <td style="padding-right: 5px; padding-left: 5px;padding-bottom: 5px;" width="100">
                                             <table border="0" cellpadding="0" cellspacing="0" class="GreyTextSmall" style="width: 215px">
                                                <tr>
                                                    <td style="width: 130px;" valign="top">
                                                        <span>Start Date: </span>
                                                        <br />
                                                        <asp:TextBox ID="txtFirstUsed" CssClass="blueTextbox" Width="85px"
                                                            runat="server" onfocus="this.blur();setActiveStyleSheet(this, 'calstyle'); return showCalendar('txtFirstUsed', 'MM/dd/y');" /></td>
                                                    <td style="width: 160px;" valign="top">
                                                        <span>CloseDate:</span><br />
                                                        <asp:TextBox ID="txtCloseDate" CssClass="blueTextbox" Width="85px"
                                                            runat="server" onfocus="this.blur();setActiveStyleSheet(this, 'calstyle'); return showCalendar('txtCloseDate', 'MM/dd/y');"/>&nbsp;
                                                        <asp:ImageButton ID="ImageButton1" runat="server" align="absmiddle" ImageUrl="../images/btn_go.gif"
                                                            ValidationGroup="srch" /></td>
                                                </tr>
                                            </table>
                                            
                                            </td>
                                        <td align="right" style="width: 100%; padding-bottom: 5px; padding-left:5px; padding-right:5px;">
                                        </td>
                                        <td style="width: 250px; padding-bottom: 5px;">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>--%>
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
                            <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" style="width: 100%; border-top: solid 1px #609BD3;border-bottom: solid 1px #609BD3">
                                <div style="overflow: auto; height: 100%; width: 100%;">
                                    <asp:GridView ID="GridView2" runat="server" EnableViewState="False" DataSourceID="LegalActivitiesHistory"
                                        AutoGenerateColumns="False" AllowPaging="false" Width="100%" BorderWidth="0" CssClass="GView">
                                        <FooterStyle CssClass="SimpleExSmall" />
    <HeaderStyle CssClass="FloatingHeader" />
    <RowStyle CssClass="SimpleHomeRow"/>
                                        <EmptyDataTemplate>
                                            <div id="divInfo" class="MessageDiv" style="left: 38%; width: 250px; position: absolute;
                                                top: 38%; height: 18%">
                                                <table border="0" cellpadding="0" cellspacing="0" style="height: 50px; width: 101%;">
                                                    <tr>
                                                        <td style="width: 5%">
                                                            &nbsp;</td>
                                                        <td align="right" style="width: 17%" valign="middle">
                                                            <div style="text-align: right">
                                                                <asp:Image ID="Image1" runat="server" ImageUrl="~/images/icn_info.gif" />
                                                                &nbsp;
                                                            </div>
                                                        </td>
                                                        <td id="divMessage" align="left" nowrap="nowrap" style="width: 75%" valign="middle">
                                                            &nbsp;No Activity(s) found in History!</td>
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
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Server.HtmlEncode(Eval("TypeName"))%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# IntellectualProperty.GetActivityStateID(Cint(Eval("ActivityState").ToString()))%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label2" runat="server" Text='<%# IntellectualProperty.GetStringDate(Eval("Date")) %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                          
                                            <asp:TemplateField HeaderText="Time Spent">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("TimeSpent") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="CloseDate">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label4" runat="server" Text='<%# IntellectualProperty.GetStringDate(Eval("CloseDate")) %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Cost">
                                                <ItemStyle HorizontalAlign="Left" />
                                                <ItemTemplate>
                                                    <asp:Label ID="Label4" runat="server" Text='<%# Decimal.Round(Eval("Cost"),2) & "&nbsp;" %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                    &nbsp;
                                    <asp:ObjectDataSource ID="LegalActivitiesHistory" runat="server" SelectMethod="GetLegalActivities"
                                        TypeName="IntellectualProperty">
                                        <SelectParameters>
                                            <asp:QueryStringParameter Name="ID" QueryStringField="ID" Type="Int32" />
                                            <asp:Parameter DefaultValue="0" Name="Status" Type="Int32" />
                                            <asp:Parameter Name="StartDate" Type="DateTime" />
                                            <asp:Parameter Name="CloseDate" Type="DateTime" />
                                            <asp:Parameter Name="Search" Type="String" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 31px">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
