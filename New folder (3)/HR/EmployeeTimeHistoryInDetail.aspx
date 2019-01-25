<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EmployeeTimeHistoryInDetail.aspx.vb"
    Inherits="HR_EmployeeTimeHistoryInDetail" Theme="Default" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="RadComboBox.Net2" Namespace="Telerik.WebControls" TagPrefix="radC" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server"><title>HR TIME REPORT</title>
<link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
<link href="HRTimeReport.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
<script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
<script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
<script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
<script type="text/javascript" language="JavaScript" src="../scripts/jquery-1.3.2.min.js"></script>
</head>
<body class="BD" onload="SetEmtyCellsOnLoad();" onresize="/*OnReSize();*/">
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="3000" ScriptMode="Release" />
        <table border="0" cellpadding="0" cellspacing="0" class="tblGeneral">
            <tr id="trTitle">
                <td>
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td id="tdReportTitleContainer">
                                <asp:UpdatePanel ID="pnlTotal" RenderMode="Inline" runat="server">
                                    <ContentTemplate>
                                        Employee Time History<span><span class="NonBold"><asp:Label runat="server" ID="lblFilter"
                                            Text="all" Visible="false" /></span>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="ddlUsers" EventName="SelectedIndexChanged" />
                                        <asp:AsyncPostBackTrigger ControlID="imgBtnChangeInterval" EventName="Click" />
                                        <asp:AsyncPostBackTrigger ControlID="refreshGrid" EventName="Click" />
                                        <asp:AsyncPostBackTrigger ControlID="btnGo" EventName="Click" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                            <td id="tdReportResetFilter">
                                  <div>
                                    <img src="../images/btn_ResetFilters.jpg" alt="" height="20" width="106" onclick="javascript:resetFilters();" />
                                </div>
                                <div id="dvPrint" onclick="PrintReport();">
                                    <img alt="" src="../images/btn_Printer.jpg" height="20" title="Print Time History Report"
                                        height="22" />
                                </div>
                              
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="trFilterMain">
                <td id="tdFilterMain">
                    <asp:UpdatePanel ID="pnlFilters" runat="server" UpdateMode="Always">
                        <ContentTemplate>
                            <table border="0" cellpadding="0" cellspacing="0" class="tblGeneral">
                                <tr id="trFilterRowInner">
                                    <td id="tdSearchEmployee">
                                        <span class="GrayHeader">Search Employee</span><br />
                                        <radC:RadComboBox ID="ddlUsers" runat="server" AutoPostBack="true" EnableViewState="true"
                                            AllowCustomText="true" MarkFirstMatch="true" Width="180px" OffsetX="2" OffsetY="0"
                                            Height="180" Skin="ComboSearch" DropDownWidth="162px" DataTextField="FullName"
                                            DataValueField="UserComboBindStr" MaxLength="10" ShowToggleImage="True" ShowWhileLoading="true"
                                            EnableLoadOnDemand="true" TabIndex="1" HighlightTemplatedItems="true" OnClientKeyPressing="HandleKeyPress">
                                        </radC:RadComboBox>
                                    </td>
                                    <td id="tdPeriodContainer">
                                        <span class="GrayHeader">Period</span><br />
                                        <asp:DropDownList ID="ddlPeriod" runat="server" SkinID="SmallTextCombo" AutoPostBack="false"
                                            Width="100px" onchange="return CheckPeriodFilter(this);" EnableViewState="false">
                                            <asp:ListItem Value="1">Today</asp:ListItem>
                                            <asp:ListItem Value="2">Yesterday</asp:ListItem>
                                            <asp:ListItem Value="3">This Week</asp:ListItem>
                                            <asp:ListItem Value="4">Last Week</asp:ListItem>
                                            <asp:ListItem Value="5">This Month</asp:ListItem>
                                            <asp:ListItem Value="6">Last Month</asp:ListItem>
                                            <asp:ListItem Value="8">Last 7 Days</asp:ListItem>
                                            <asp:ListItem Value="7">Custom</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td id="tdStatusContainer">
                                        <span class="GrayHeader">Status</span><br />
                                        <asp:DropDownList ID="ddlStatus" runat="server" SkinID="SmallTextCombo" AutoPostBack="false"
                                            Width="83px" EnableViewState="false">
                                            <asp:ListItem Value="0">Show All</asp:ListItem>
                                            <asp:ListItem Value="3">Present</asp:ListItem>
                                            <asp:ListItem Value="1">Absent</asp:ListItem>
                                            <asp:ListItem Value="4">Late Arrivals</asp:ListItem>
                                            <asp:ListItem Value="5">Late Sitting</asp:ListItem>
                                            <asp:ListItem Value="6" Enabled="false">Saturday Off</asp:ListItem>
                                            <asp:ListItem Value="7" Enabled="false">Saturday On</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td id="tdDepartmentContainer">
                                        <span class="GrayHeader">Department</span><br />
                                        <asp:DropDownList ID="ddlDeparments" runat="server" SkinID="SmallTextCombo" DataSourceID="SqlDSDepartments"
                                            DataTextField="Name" DataValueField="ID" AutoPostBack="false" Width="120px" EnableViewState="false">
                                        </asp:DropDownList>
                                    </td>
                                    <td id="tdTeamsContainer">
                                        <span>Teams </span>
                                        <br />
                                        <asp:DropDownList ID="ddlTeams" runat="server" SkinID="SmallTextCombo" DataSourceID="SqlDSTeams"
                                            DataTextField="Name" DataValueField="ID" AutoPostBack="false" Width="100px">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                            SelectCommand="Groups_GetGroupsbyType" SelectCommandType="StoredProcedure" DataSourceMode="DataReader">
                                            <SelectParameters>
                                                <asp:Parameter ConvertEmptyStringToNull="False" DefaultValue="2" Name="Type" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                    <td id="tdActionsContainer">
                                        <div class="div1" style="padding-left:0px;"><asp:ImageButton ID="btnGo" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/icn_go.gif"
                                                Height="16" Width="16" BorderStyle="None" /></div>
                                        <div class="div3">
                                            <asp:HiddenField ID="HiddenField1" runat="server" Value="" />
                                            <div class="dvAddNewTimeRecord" id="dvAddNewTimeRecord" runat="server" visible="false"
                                                onclick="NewTimeClick();" title="Add Time History Record">
                                                <img src="images/btn_new.gif" align="absmiddle" height="22" />
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td class="tdSilverWhiteGradient">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td id="tdMain">
                    <div id="dvMain">
                        <asp:UpdatePanel ID="pnlmain" runat="server" RenderMode="Block" EnableViewState="false"
                            UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Repeater ID="rptTimeHistoryMain" runat="server" DataSourceID="odsTimeHistory"
                                    EnableViewState="false">
                                    <ItemTemplate>
                                        <asp:Literal ID="ltrlEmptyDivs" runat="server"></asp:Literal>
                                        <div id="dvInnerTotal" class="dvInnerTotal" runat="server" visible="false">
                                            <table class="dvInnerTotalTblMain" border="0" cellpadding="0" cellspacing="0">
                                                <tr class="trRowTotalMain">
                                                    <td class="TDTotalInnerHours">
                                                        <div class="dv1">
                                                            <asp:Literal ID="ltrlTotalHours" runat="server" Text="00:00"></asp:Literal>
                                                        </div>
                                                    </td>
                                                    <td class="TDInnerNotes">
                                                        <asp:Image CssClass="imgNotes" ID="imgNotes" runat="server" Visible="false" ImageUrl="images/icn_notes.gif"
                                                            Width="17" Height="22" />
                                                    </td>
                                                    <td class="TDInnerLAs">
                                                        <div class="dvTDInnerLAsImageContainer">
                                                            <asp:Image CssClass="imgLA" ID="imgLA" runat="server" ImageAlign="AbsMiddle" Visible="false"
                                                                Height="21" Width="20" ImageUrl="~/Images/ico_alert.gif" />
                                                        </div>
                                                        <div id="dvLA" runat="server">
                                                            <asp:Literal ID="ltrlLA" runat="server"></asp:Literal>
                                                        </div>
                                                    </td>
                                                    <td class="TDInnerEDs">
                                                        <div class="dvTDInnerLAsImageContainer">
                                                            <asp:Image CssClass="imgED" ID="imgED" runat="server" ImageAlign="AbsMiddle" Visible="false"
                                                                Height="21" Width="20" ImageUrl="~/Images/ico_alert.gif" />
                                                        </div>
                                                        <div id="dvED" runat="server">
                                                            <asp:Literal ID="ltrlED" runat="server"></asp:Literal>
                                                        </div>
                                                    </td>
                                                    <td class="TDInnerLSs">
                                                        <div class="dvTDInnerLAsImageContainer">
                                                            <asp:Image CssClass="imgLS" ID="imgLS" runat="server" ImageAlign="AbsMiddle" Visible="false"
                                                                Height="21" Width="20" ImageUrl="~/Images/ico_alert.gif" />
                                                        </div>
                                                        <div id="dvLS" runat="server">
                                                            <asp:Literal ID="ltrlLS" runat="server"></asp:Literal>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <asp:Literal ID="ltrldivContainerEnd" runat="server" Visible="false" Text="</div>"></asp:Literal>
                                        <div id="dvBreaker2" class="dvBreaker2" visible="false" runat="server">
                                        </div>
                                        <div id="dvTotals" class="dvTotals" runat="server" visible="false">
                                            Totals
                                        </div>
                                        <div id="dvTotalsInOutCells" class="dvTotalsInOutCellsWithoutTopAndRightBorder" runat="server"
                                            visible="false">
                                            &nbsp;
                                        </div>
                                        <asp:Literal ID="ltrlEmptyDivsTotal" runat="server" Visible="false"></asp:Literal>
                                        <div id="dvRowTotal" class="dvRowTotal" runat="server" visible="false">
                                            <table class="tblRowTotalMain" border="0" cellpadding="0" cellspacing="0">
                                                <tr class="TRRowTotalMain">
                                                    <td class="tdTotalHours">
                                                        <div class="divTotalHoursContainer">
                                                            <asp:Literal ID="ltrlUserTotalHours" runat="server" Text="00:00"></asp:Literal>
                                                        </div>
                                                    </td>
                                                    <td style="width: 260px; height: 40px; border: solid 1px #95BEDE;" class="LeavesInfoContainer">
                                                        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%;"
                                                            class="LeavesInfoContainer">
                                                            <tr>
                                                                <td style="background-color: #F3F1FE;">
                                                                    <div>
                                                                        AL-A
                                                                    </div>
                                                                    <div>
                                                                        <asp:Literal ID="ltrlAL_A" runat="server"></asp:Literal>
                                                                    </div>
                                                                </td>
                                                                <td style="background-color: #F3F1FE;">
                                                                    <div>
                                                                        AL-T
                                                                    </div>
                                                                    <div>
                                                                        <asp:Literal ID="ltrlAL_T" runat="server"></asp:Literal>
                                                                    </div>
                                                                </td>
                                                                <td style="background-color: #ECE7FB;">
                                                                    <div>
                                                                        AL-B
                                                                    </div>
                                                                    <div>
                                                                        <asp:Literal ID="ltrlAL_B" runat="server"></asp:Literal>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="dvName" class="dvName" runat="server" visible="false">
                                            <span class="spanName">
                                                <asp:Literal ID="ltrlName" runat="server" Text='<%#Eval("FullName") %>'></asp:Literal>&nbsp;-&nbsp;
                                            </span><span class="spanDepartment">
                                                <asp:Literal ID="Literal1" runat="server" Text='<%#Eval("Department") %>'></asp:Literal>
                                            </span>
                                            <div id="dvCaptions" class="dvCaptions" runat="server" visible="false">
                                                <table id="tblCaptions" border="0" cellpadding="0" cellspacing="0">
                                                    <tr id="trCaptions">
                                                        <td id="tdCaptionTotalHrs">
                                                            <div id="dvCaptionTotalHrs">
                                                                Total Hrs
                                                            </div>
                                                        </td>
                                                        <td id="tdCaptionNotes">
                                                            Notes
                                                        </td>
                                                        <td id="tdCaptionNotesLA">
                                                            LA
                                                        </td>
                                                        <td id="tdCaptionNotesED">
                                                            ED
                                                        </td>
                                                        <td id="tdCaptionNotesLS">
                                                            LS
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                        <div id="dvBreaker" class="dvBreaker" visible="false" runat="server">
                                        </div>
                                        <asp:Literal ID="ltrldivContainerStart" runat="server" Visible="false" Text="<div style='width:100%' class='dvMainContainer'>"></asp:Literal>
                                        <div id="dvDate" class="dvDate" runat="server" visible="false">
                                            <span class="spanDay">
                                                <asp:Literal ID="ltrlPunchInDay" runat="server" Text='<%#DateTime.Parse(Eval("PunchInDate")).ToString("ddd")%>'></asp:Literal>
                                            </span>
                                            <br />
                                            <span class="spanDate">
                                                <asp:Literal ID="ltrlPunchInDate" runat="server" Text='<%#DateTime.Parse(Eval("PunchInDate")).ToString("dd MMM, yyyy")%>'></asp:Literal>
                                            </span>
                                        </div>
                                        <div id="dvInOutNote" class="dvInOutNote" runat="server" visible="false">
                                            <div class="dvInOutNoteIN">
                                                IN
                                            </div>
                                            <div class="dvInOutNoteOut">
                                                OUT
                                            </div>
                                        </div>
                                        <asp:Literal ID="ltrContainerDivStart" runat="server" Text="<div class='dvCellsContainer' style='float:left;'>"
                                            Visible="false"></asp:Literal>
                                        <div id="dvTimeInTimeOut" class="dvTimeInTimeOut" runat="server" visible="false">
                                            <div class="dvTimeInTimeOut_IN">
                                                <span style="color: #000000;">
                                                    <asp:Literal ID="ltrlTimeIn" runat="server"></asp:Literal>
                                                </span>
                                                <asp:Literal ID="ltrlTimeOffSet" runat="server"></asp:Literal>
                                            </div>
                                            <div class="dvTimeInTimeOut_OUT">
                                                <span style="color: #000000;">
                                                    <asp:Literal ID="ltrlTimeOut" runat="server"></asp:Literal>
                                                </span><span style="padding-left: 3px; color: #000000;">
                                                    <asp:Literal ID="ltrlTimeOutOffSet" runat="server"></asp:Literal>
                                                </span>
                                            </div>
                                        </div>
                                        <asp:Literal ID="ltrContainerDivEnd" runat="server" Text="</div>" Visible="false"></asp:Literal>
                                        <asp:Literal ID="ltrlOffDays" runat="server" Visible="false"></asp:Literal>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Literal ID="ltrlEmptyDivs" runat="server"></asp:Literal>
                                        <div id="dvInnerTotal" class="dvInnerTotal" runat="server" visible="false">
                                            <table class="dvInnerTotalTblMain" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="width: 70px; text-align: center;">
                                                        <div style="height: 40px; border: solid 1px #95BEDE; padding-top: 10px; font-weight: bold;
                                                            font-size: 16px; color: #2C902E;">
                                                            <asp:Literal ID="ltrlTotalHours" runat="server" Text="00:00"></asp:Literal>
                                                        </div>
                                                    </td>
                                                    <td style="width: 50px; height: 40px; border: solid 1px #FFFFFF; text-align: center;">
                                                        <asp:Image CssClass="imgNotes" ID="imgNotes" Visible="false" runat="server" ImageUrl="images/icn_notes.gif"
                                                            Width="17" Height="22" />
                                                    </td>
                                                    <td style="width: 70px; height: 40px; border: solid 1px #FFFFFF; text-align: center;
                                                        background-color: #F3F1FE;">
                                                        <div class="dvTDInnerLAsImageContainer">
                                                            <asp:Image ID="imgLA" CssClass="imgLA" runat="server" ImageAlign="AbsMiddle" Visible="false"
                                                                Height="21" Width="20" ImageUrl="~/Images/ico_alert.gif" />
                                                        </div>
                                                        <div id="dvLA" runat="server">
                                                            <asp:Literal ID="ltrlLA" runat="server"></asp:Literal>
                                                        </div>
                                                    </td>
                                                    <td style="width: 70px; height: 40px; border: solid 1px #FFFFFF; text-align: center;
                                                        background-color: #F1FAF7;">
                                                        <div class="dvTDInnerLAsImageContainer">
                                                            <asp:Image ID="imgED" CssClass="imgED" runat="server" ImageAlign="AbsMiddle" Visible="false"
                                                                Height="21" Width="20" ImageUrl="~/Images/ico_alert.gif" />
                                                        </div>
                                                        <div id="dvED" runat="server">
                                                            <asp:Literal ID="ltrlED" runat="server"></asp:Literal>
                                                        </div>
                                                    </td>
                                                    <td style="width: 70px; height: 40px; border: solid 1px #FFFFFF; text-align: center;
                                                        background-color: #EFF9E1;">
                                                        <div class="dvTDInnerLAsImageContainer">
                                                            <asp:Image ID="imgLS" CssClass="imgLS" runat="server" ImageAlign="AbsMiddle" Visible="false"
                                                                Height="21" Width="20" ImageUrl="~/Images/ico_alert.gif" />
                                                        </div>
                                                        <div id="dvLS" runat="server">
                                                            <asp:Literal ID="ltrlLS" runat="server"></asp:Literal>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <asp:Literal ID="ltrldivContainerEnd" runat="server" Visible="false" Text="</div>"></asp:Literal>
                                        <div id="dvBreaker2" class="dvBreaker2" visible="false" runat="server">
                                        </div>
                                        <div id="dvTotals" class="dvTotals" runat="server" visible="false">
                                            Totals
                                        </div>
                                        <div id="dvTotalsInOutCells" class="dvTotalsInOutCellsWithBorder" runat="server"
                                            visible="false">
                                            &nbsp;
                                        </div>
                                        <asp:Literal ID="ltrlEmptyDivsTotal" runat="server" Visible="false"></asp:Literal>
                                        <div id="dvRowTotal" class="dvRowTotal" runat="server" visible="false">
                                            <table class="tblRowTotalMain" border="0" cellpadding="0" cellspacing="0">
                                                <tr class="TRRowTotalMain">
                                                    <td style="width: 70px; text-align: center;">
                                                        <div style="height: 40px; border: solid 1px #95BEDE; padding-top: 10px; font-weight: bold;
                                                            font-size: 16px; color: #2C902E;">
                                                            <asp:Literal ID="ltrlUserTotalHours" runat="server" Text="00:00"></asp:Literal>
                                                        </div>
                                                    </td>
                                                    <td style="width: 260px; height: 40px; border: solid 1px #95BEDE;" class="LeavesInfoContainer">
                                                        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%;"
                                                            class="LeavesInfoContainer">
                                                            <tr>
                                                                <td style="background-color: #F3F1FE;">
                                                                    <div>
                                                                        AL-A
                                                                    </div>
                                                                    <div>
                                                                        <asp:Literal ID="ltrlAL_A" runat="server"></asp:Literal>
                                                                    </div>
                                                                </td>
                                                                <td style="background-color: #F3F1FE;">
                                                                    <div>
                                                                        AL-T
                                                                    </div>
                                                                    <div>
                                                                        <asp:Literal ID="ltrlAL_T" runat="server"></asp:Literal>
                                                                    </div>
                                                                </td>
                                                                <td style="background-color: #ECE7FB;">
                                                                    <div>
                                                                        AL-B
                                                                    </div>
                                                                    <div>
                                                                        <asp:Literal ID="ltrlAL_B" runat="server"></asp:Literal>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="divNoRecord" runat="server" visible="false" style="text-align: center; vertical-align: middle;">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr id="trNoRecord">
                                                    <td colspan="6" style="width: 100%; text-align: center; padding-top: 150px;">
                                                        <div style="width: 220px; height: 50px; border: solid 4px #dedede; vertical-align: middle;
                                                            text-align: center;">
                                                            <div style="float: left; padding-left: 23px; padding-top: 10px;">
                                                                <img alt="" src="../images/icn_info.gif" width="23" height="18" border="0" />
                                                            </div>
                                                            <div style="float: left; padding-left: 7px; padding-top: 10px;">
                                                                No report data found!
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddlUsers" EventName="SelectedIndexChanged" />
                                <asp:AsyncPostBackTrigger ControlID="imgBtnChangeInterval" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="refreshGrid" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnGo" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="tblFooter">
                    <div>
                        <b>Key: </b>AL-A,-T,- B =<b>Annual Leaves, Taken, Balance</b>
                    </div>
                </td>
            </tr>
        </table>
        <div class="ProgressIndicatorDIV">
            <br />
            <asp:Image ID="Image2" runat="server" ImageUrl="../images/indicator.gif" ImageAlign="AbsMiddle" />
            <span style="color: #4B92C1; font-size: 14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
            <br />
            <br />
        </div>
        <asp:HiddenField ID="hdnDefaultStartDate" runat="server" />
        <asp:HiddenField ID="hdnDefaultEndDate" runat="server" />
        <asp:HiddenField ID="hdnDefaultTeamID" runat="server" />
        <asp:HiddenField ID="hdnDefaultDepartmentID" runat="server" />
        <asp:HiddenField ID="hdnSessionID" runat="server" />
        <asp:HiddenField ID="hdnHasEditAccess" runat="server" />
        <asp:HiddenField ID="hdnIsAdmin" runat="server" />
        <asp:HiddenField ID="hdnIsHead" runat="server" />
        <asp:HiddenField ID="hdnTeamID" runat="server" />
        <asp:HiddenField ID="hdnTimeZoneHoursDIFF" runat="server" />
        <asp:HiddenField ID="hdnTeamsUnder" runat="server" />
        <asp:Button ID="refreshGrid" runat="server" Text="" Style="display: none;" CausesValidation="false" />
        <asp:UpdatePanel ID="pnlHiddenVaidables" runat="server">
            <ContentTemplate>
                <asp:HiddenField ID="hdnTimeRecordID" runat="server" />
                <asp:HiddenField ID="hdnPunchIn" runat="server" />
                <asp:HiddenField ID="hdnPunchOut" runat="server" />
                <asp:HiddenField ID="hdnDateOn" runat="server" />
                <asp:HiddenField ID="hdnStartDate" runat="server" />
                <asp:HiddenField ID="hdnEndDate" runat="server" />
                <asp:HiddenField ID="hdnSelectedUser" runat="server" />
                
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddlUsers" EventName="SelectedIndexChanged" />
                <asp:AsyncPostBackTrigger ControlID="imgBtnChangeInterval" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="refreshGrid" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnGo" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
        <div id="divNotes">
            &nbsp;
        </div>
        <div id="divTimeInterval">
            <table id="tblTimeInterval" border="0" cellpadding="0" cellspacing="0" class="tblGeneral">
                <tr id="trHeader">
                    <td id="tdHeaderContainer" style="">
                        <span style="float: left; font-weight: bold; padding-left: 5px;">Set Custom Period</span>
                        <span style="float: right; margin-right: 10px; font-weight: bold; cursor: pointer;"
                            onclick="ShowCustomIntertvalDIV(0);">X</span>
                    </td>
                </tr>
                <tr id="trBody">
                    <td id="tdBodyContainer">
                        <table id="tblBodyContainerInner" border="0" cellpadding="0" cellspacing="0">
                            <tr id="trBodyContainerInner">
                                <td id="td1">
                                    &nbsp;
                                </td>
                                <td id="td2">
                                    <span style="">Start Date</span>
                                    <asp:TextBox runat="server" type="text" ID="DateFrom" ReadOnly="true" Style="width: 70px;
                                        font-size: 10px;" onfocus="datefromfocus();" onkeydown="if (event.keyCode==46||event.keyCode==8) {this.value=''; event.keyCode=0;}" /><img
                                            src="../images/icn_calendar.png" border="0" style="margin-top: 1px;" align="absmiddle"
                                            height="22" onclick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= DateFrom.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                            alt="" />
                                </td>
                                <td id="td3">
                                    &nbsp;
                                </td>
                                <td id="td4">
                                    <span>End Date</span>
                                    <asp:TextBox runat="server" type="text" ID="DateTo" ReadOnly="true" Style="width: 70px;
                                        font-size: 10px;" onfocus="datetofocus();" onkeydown="if (event.keyCode==46||event.keyCode==8) {this.value=''; event.keyCode=0;}" /><img
                                            src="../images/icn_calendar.png" style="margin-top: 1px;" height="22" border="0"
                                            align="absmiddle" onclick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= DateTo.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                            alt="" /></span>
                                </td>
                                <td id="td5">
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trFooter">
                    <td style="height: 40px; text-align: center;">
                        <span>
                            <asp:ImageButton ID="imgBtnChangeInterval" runat="server" ImageUrl="~/Images/btn_ok.gif"
                                ValidationGroup="DivTimeInterval" OnClientClick="return CheckDate();" />
                        </span><span>
                            <asp:ImageButton ID="imgCloseCustomTimeDiv" runat="server" ImageUrl="~/Images/btn_cancel_small.gif"
                                CausesValidation="false" OnClientClick="ShowCustomIntertvalDIV(0); return false;" />
                        </span>
                    </td>
                </tr>
            </table>
        </div>
        <div id="DivIFrame" class="DivIFrame" runat="server">
            <table cellpadding="0" border="0" cellspacing="0">
                <tr id="trHeading">
                    <td id="tdHeading" align="left">
                        <asp:Label ID="Label1" runat="server" Text="Edit Time" Font-Bold="true" ForeColor="White"
                            Font-Size="12pt"></asp:Label>
                    </td>
                    <td id="tdClose">
                        <img src="../images/win_btn_close_black.jpg" style="" alt="Close Window"
                            onclick="Reset();" />
                    </td>
                </tr>
                <tr id="trFrameSourceContainer" valign="top">
                    <td id="tdFrameSourceContainer" colspan="2">
                        <div id="dvFrameSourceContainer">
                            <iframe name="IfHRTime" runat="server" id="IfHRTime" src="../BlankPage.htm" style="margin: 0px;
                                width: 100%; height: 100%; border: 0px" scrolling="no" frameborder="0"></iframe>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div id="divBlackOut">
            &nbsp;
        </div>
        <asp:SqlDataSource ID="sdsUsers" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
            DataSourceMode="DataReader" SelectCommand="HR_Users_GetAll" SelectCommandType="StoredProcedure">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDSDepartments" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
            SelectCommand="Groups_GetGroupsbyType" SelectCommandType="StoredProcedure" DataSourceMode="DataReader">
            <SelectParameters>
                <asp:Parameter ConvertEmptyStringToNull="False" DefaultValue="1" Name="Type" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDSTeams" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
            SelectCommand="Groups_GetGroupsbyType" SelectCommandType="StoredProcedure" DataSourceMode="DataReader">
            <SelectParameters>
                <asp:Parameter ConvertEmptyStringToNull="False" DefaultValue="2" Name="Type" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:ObjectDataSource ID="odsTimeHistory" runat="server" EnableViewState="true" TypeName="Portal.BLL.HR.HR_UserTimeHistory"
            SelectMethod="GetEmployeesTimeHistoryDetail" EnablePaging="false">
            <SelectParameters>
                <asp:ControlParameter ControlID="hdnStartDate" Name="StartDate" PropertyName="Value"
                    Type="DateTime" />
                <asp:ControlParameter ControlID="hdnEndDate" Name="EndDate" PropertyName="Value"
                    Type="DateTime" />
                <asp:ControlParameter Name="DepartmentID" ControlID="ddlDeparments" DefaultValue="0"
                    Type="int32" />
                <asp:ControlParameter Name="EmployeeID" ControlID="hdnSelectedUser" DefaultValue="0"
                    Type="int32" />
                <asp:ControlParameter Name="TeamID" ControlID="ddlTeams" DefaultValue="0" Type="int32" />
                <asp:ControlParameter Name="Status" ControlID="ddlStatus" DefaultValue="0" Type="int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
    
        <script language="javascript" type="text/javascript">
            var mainContainerWidthGlobal = 0;
        
            function ClosePunchInPunchOutDIV() {
                document.getElementById("divPunchInPunctOut").style.display = 'none';
                backgroundFilter();
            }


            function ShowPunchInPunchOutDIV() {
                backgroundFilter();
                document.getElementById("divPunchInPunctOut").style.display = "";
            }


            function backgroundFilter() {
                var div;

                div = document.getElementById('divBlackOut');
                if (div.style.display == '' && div.offsetWidth != undefined && div.offsetHeight != undefined) {
                    div.style.display = (div.offsetWidth != 0 && div.offsetHeight != 0) ? 'block' : 'none';
                }
                div.style.display = (div.style.display == '' || div.style.display == 'block') ? 'none' : 'block';
            }
            var postbackElement;
            Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(beginRequest);
            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(pageLoaded);
            Sys.WebForms.PageRequestManager.getInstance().add_pageLoading(onPageLoading);

            function beginRequest(sender, args) {
                postbackElement = args.get_postBackElement();
                $(".ProgressIndicatorDIV").show();
                //clearDisposableItems(sender, args);
            }

            function pageLoaded(sender, args) {
                var updatedPanels = args.get_panelsUpdated();
                if (typeof (postbackElement) === "undefined") {
                    return;
                }
                for (i = 0; i < updatedPanels.length; i++) {
                    if (updatedPanels[i].id == '<%= pnlmain.ClientID %>') {
                        SetEmtyCellsOnLoad();
                        $(".ProgressIndicatorDIV").hide();
                    }
                    else if (updatedPanels[i].id == '<%= pnlFilters.ClientID %>') {
                        $(".ProgressIndicatorDIV").hide();
                    }
                }
            }

            function onPageLoading(sender, e) {
                $(".ProgressIndicatorDIV").show();
            }

            function SetDefaultButton() {
                __defaultFired = false;
            }

            function EditTime(Timeid) {
                
                if (document.getElementById('<%=hdnHasEditAccess.ClientID %>').value == '1') {
                    var Label1 = getElement('<%= Label1.ClientID %>')
                    Label1.innerHTML = 'Edit Time';
                    IfHRTime.location = 'UsersTimeHistoryEdit.aspx?ID=' + Timeid;

                    var DivFram = getElement('<%= DivIFrame.ClientID %>')
                    DivFram.style.display = "inline"

                    document.getElementById('divBlackOut').style.width = '100%';
                    document.getElementById('divBlackOut').style.height = '100%';
                }
            }
            function Reset() {
                var DivFram = getElement('<%= DivIFrame.ClientID %>')
                document.getElementById('divBlackOut').style.width = 0;
                document.getElementById('divBlackOut').style.height = 0;
                IfHRTime.location = '../BlankPage.htm';
                DivFram.style.display = "none";
                return false;
            }
            function RefreshGrid() {
                Reset();
                var refreshGrid = getElement('<%= refreshGrid.ClientID %>');
                refreshGrid.click();
            }
            function NewTimeClick() {
                var Label1 = getElement('<%= Label1.ClientID %>')
                Label1.innerHTML = 'Add New Time';
                
                var SelectedUserID = <%=ddlUsers.ClientID %>.SelectedItem.Value;
                if(SelectedUserID!='')
                {
                    SelectedUserID = SelectedUserID.substr(0,SelectedUserID.indexOf('&'));
                }
                
                IfHRTime.location = 'UsersTimeHistoryAddNew.aspx?NoCache='+new Date()+'&UserID='+ SelectedUserID;

                var DivFram = getElement('<%= DivIFrame.ClientID %>')
                DivFram.style.display = "inline"

                document.getElementById('divBlackOut').style.width = '100%';
                document.getElementById('divBlackOut').style.height = '100%';
            }
            function CheckPeriodFilter(source) {
                if (document.getElementById(source.id).value == 7) {
                    ShowCustomIntertvalDIV(1);
                    return false;
                }
                else {
                    document.getElementById(source.id)[7].text = "Custom";
                    getElement('<%=DateFrom.ClientId%>').value = "";
                    getElement('<%=DateTo.ClientId%>').value = "";
                    return false;
                }
            }

            function CheckCustomDate() {
                
                var sourceElement = document.getElementById('<%=ddlPeriod.ClientID %>');
                if (sourceElement.value == '7') {
                    var dateFrom = new Date(document.getElementById('<%=DateFrom.ClientID %>').value);
                    var dateTo = new Date(document.getElementById('<%=DateTo.ClientID %>').value);
                    if (dateFrom == '' || dateTo == '') {
                        return false;
                    }
                    else if (dateFrom > dateTo) {
                        alert("From date must be earlier than To date.");
                        return false;
                    }
                    else {
                        return true;
                     }
                }
                else {
                    return true;
                }
                
            }

            function resetFilters() {
                var item;
                if (item = getElement('<%= DateFrom.ClientID %>')) {
                    item.value = document.getElementById('<%=hdnDefaultStartDate.ClientID %>').value;
                }
                if (item = getElement('<%= DateTo.ClientID %>')) {
                    item.value = document.getElementById('<%=hdnDefaultEndDate.ClientID %>').value;
                }
                if (item = getElement('<%= hdnDefaultStartDate.ClientID %>')) {
                    item.value = document.getElementById('<%=hdnDefaultStartDate.ClientID %>').value;
                }
                if (item = getElement('<%= hdnDefaultEndDate.ClientID %>')) {
                    item.value = document.getElementById('<%=hdnDefaultEndDate.ClientID %>').value;
                }
                if (item = document.getElementById('<%=ddlDeparments.ClientID%>')) {
                    item.value = document.getElementById('<%=hdnDefaultDepartmentID.ClientID %>').value;
                }
                if (item = document.getElementById('<%=ddlTeams.ClientID%>')) {
                    item.value = document.getElementById('<%=hdnDefaultTeamID.ClientID %>').value;
                }
                if (item = document.getElementById('<%=ddlStatus.ClientID%>')) {
                    item.value = 0;
                }
                if (item = document.getElementById('<%=ddlPeriod.ClientID%>')) {
                    item.value = 7;
                }
                if (item = document.getElementById('<%=ddlUsers.ClientID%>')) {
                    SelectComboBoxItem(document.getElementById('<%=hdnSessionID.ClientID %>').value);
                }
                document.getElementById('<%=refreshGrid.ClientID%>').click();
            }

            function SelectComboBoxItem(itemVal) {
                var combo = <%=ddlUsers.ClientID%>;
                var item = combo.FindItemByValue(itemVal);
                if (item) {
                    item.Select();
                }
            }

            function CheckDate() {
                var dateFrom = new Date(document.getElementById('<%=DateFrom.ClientID %>').value);
                var dateTo = new Date(document.getElementById('<%=DateTo.ClientID %>').value);
                var one_day= 1000*60*60*24;
                if(document.getElementById('<%=DateFrom.ClientID %>').value == '' && document.getElementById('<%=DateTo.ClientID %>').value == '')
                {
                    alert("Select date range to see the records.");
                    return false;
                }
                if (document.getElementById('<%=DateFrom.ClientID %>').value == '') {
                        alert("From date cannot be empty.");
                        return false;
                    }
                    
                if (document.getElementById('<%=DateTo.ClientID %>').value == '') {
                        alert("To date cannot be empty.");
                        return false;
                    }
                
                if (dateFrom > dateTo) {
                    alert("From date must be earlier than To date.");
                    return false;
                }
                if(monthDiff(dateFrom,dateTo) >= 3)
                {
                    alert('Date range can be of 4 months maximum.');
                    return false;
                }
                else {
                    ShowCustomIntertvalDIV(0);
                    return true;
                }
            }
            function monthDiff(d1, d2) {
                var months;
                months = (d2.getFullYear() - d1.getFullYear()) * 12;
                months -= d1.getMonth() + 1;
                months += d2.getMonth();
                return months;
            }
            function datefromfocus() {
                getElement('<%=DateFrom.ClientId%>').value = "";
            }
            function datetofocus() {
                getElement('<%=DateTo.ClientId%>').value = "";
            }
            function HandleKeyPress(combo, e){
                var URLToAppend  = '';
                URLToAppend += '&IsAdmin='+document.getElementById('<%=hdnIsAdmin.ClientID %>').value;
                combo.LoadOnDemandUrl = "/Portal/hr/EmployeeTimeHistoryInDetail.aspx?rcbID=ddlUsers%26rcbServerID=ddlUsers";
                combo.LoadOnDemandUrl = combo.LoadOnDemandUrl + URLToAppend;
                if (e.keyCode == 13){
                combo.SetValue(combo.GetValue());
                combo.SelectedIndex = combo.GetValue();
                combo.SelectedValue =combo.GetValue();
                keyPress = true;
                }
            }
        
            
            function SetEmtyCellsOnLoad() {
                var i = 0;
                var widthTimeInOut = 0;
                while (i <= $(".dvTimeInTimeOut").length) {
                    if ($(".dvTimeInTimeOut")[i] != null) {
                        if ($(".dvTimeInTimeOut")[i].innerHTML != "&nbsp;") {
                            widthTimeInOut = $(".dvTimeInTimeOut")[i].offsetWidth;
                            break;
                        }
                    }
                    i = i + 1;
                }
                var mainContainerWidth = $(".dvMainContainer").width();
                mainContainerWidth = mainContainerWidth - 306 - 100 - 40;
                mainContainerWidthGlobal = mainContainerWidth / 5;
                $(".dvTimeInTimeOut").css("width", mainContainerWidth / 5);
                $(".divOffDay").css("width", mainContainerWidth - (mainContainerWidth % 5));
                $(".dvEmptyCellTotalRow").css("width", mainContainerWidth - (mainContainerWidth % 5));

                $(".dvDate").css("width", 100 + (mainContainerWidth % 5));
                $(".dvTotals").css("width", 100 + (mainContainerWidth % 5));
                getSpanElements();
            }
            function OnReSize()
            {
                  SetEmtyCellsOnLoad();
            }
            
            function resizeStuff() {
                OnReSize();
            }
            var TO = false;
            $(window).resize(function(){
            if(TO !== false)
            clearTimeout(TO);
            TO = setTimeout(resizeStuff, 2000); //200 is time in miliseconds
            });
            
            function ShowNotes(StrHtml, srcImageElement) {
                var posTop = 0;
                var posLeft = 0;
                var offset = $("#" + srcImageElement.id).offset();
                posTop = offset.top - 50;
                posLeft = offset.left - ($("#" + srcImageElement.id).width() + 200);
                if(StrHtml!='')
                {
                    document.getElementById('divNotes').style.top = posTop;
                    document.getElementById('divNotes').style.left = posLeft;
                    while (StrHtml.indexOf('###NewNote###') != -1) {
                        StrHtml = StrHtml.replace("###NewNote###", "<hr class='NotesSeperator'></hr>");
                    }
                    $(".NotesSeperator").html("");
                    document.getElementById('divNotes').innerHTML = StrHtml;
                    $('#divNotes').show();
                }
            }
            function HideNotes() {
                $(".NotesSeperator").html("");
                $('#divNotes').hide();
            }
            function ShowCustomIntertvalDIV(show) {
                if (show == 1) {
                    $("#divTimeInterval").show()
                }
                else {
                    $("#divTimeInterval").hide()
                }
            }
            function PrintReport() {
                var combo = <%=ddlUsers.ClientID%>;
                var PrintURL = "";
                PrintURL =  'EmployeeTimeHistoryInDetail_Printable.aspx?NoCache=' + new Date();
                PrintURL += '&StartDate='+document.getElementById('<%=hdnStartDate.ClientID %>').value;
                PrintURL += '&EndDate='+document.getElementById('<%=hdnEndDate.ClientID %>').value;
                PrintURL += '&UserID='+combo.SelectedItem.Value;
                PrintURL += '&DepartmentID='+document.getElementById('ddlDeparments').value;
                PrintURL += '&TeamID='+document.getElementById('ddlTeams').value;
                PrintURL += '&Status='+document.getElementById('ddlStatus').value;
                document.getElementById('frmPrintReport').src = PrintURL;
            }
            function clearDisposableItems( sender , args ) {
            if (Sys.Browser.agent == Sys.Browser.InternetExplorer ) {
                $get('dvClass').tBodies[0].removeNode(true);
            } else {
                $get('dvClass').innerHTML="";
            }
}
        
        </script>
        
        <script language="javascript" type="text/javascript">

            function disposeTree(sender, args) {
                var elements = args.get_panelsUpdating();
                for (var i = elements.length - 1; i >= 0; i--) {
                    var element = elements[i];
                    var allnodes = element.getElementsByTagName('*'),
                length = allnodes.length;
                    var nodes = new Array(length)
                    for (var k = 0; k < length; k++) {
                        nodes[k] = allnodes[k];
                    }
                    for (var j = 0, l = nodes.length; j < l; j++) {
                        var node = nodes[j];
                        if (node.nodeType === 1) {
                            if (node.dispose && typeof (node.dispose) === "function") {
                                node.dispose();
                            }
                            else if (node.control && typeof (node.control.dispose) === "function") {
                                node.control.dispose();
                            }

                            var behaviors = node._behaviors;
                            if (behaviors) {
                                behaviors = Array.apply(null, behaviors);
                                for (var k = behaviors.length - 1; k >= 0; k--) {
                                    behaviors[k].dispose();
                                }
                            }
                        }
                    }
                    element.innerHTML = "";
                }
            }
            function getSpanElements() {
                var i = 0;
                var ArrTimeCellTimeShortLeave = new Array();
                var ArrTimeCellTimeOutDuty = new Array(); 
                ArrTimeCellTimeShortLeave = $(".TimeCellTimeShortLeave");
                while (i < ArrTimeCellTimeShortLeave.length) {
                    ArrTimeCellTimeShortLeave[i].parentElement.parentElement.style.filter = 'progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#F5EDB7,endColorStr=#FCB649);';
                    i = i + 1;
                }
                i = 0;
                ArrTimeCellTimeOutDuty = $(".TimeCellTimeOutDuty");
                while (i < ArrTimeCellTimeOutDuty.length) {
                    ArrTimeCellTimeOutDuty[i].parentElement.parentElement.style.filter = 'progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#3B9BCA,endColorStr=#257398);';
                    i = i + 1;
                }
            }
            
            Sys.WebForms.PageRequestManager.getInstance().add_pageLoading(disposeTree);
            
        </script>
        
    </div>
    <iframe id="frmPrintReport" height="0" width="0" src="../BlankPage.htm"></iframe>

    </form>
</body>
</html>
