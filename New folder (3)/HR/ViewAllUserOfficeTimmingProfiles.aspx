<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ViewAllUserOfficeTimmingProfiles.aspx.vb"
    Inherits="HR_ViewAllUserOfficeTimmingProfiles" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="style.css" type="text/css" rel="Stylesheet" />
        <script type="text/javascript" language="JavaScript" src="../scripts/jquery-1.3.2.min.js"></script>
    <style type="text/css">
        body
        {
            font-family: Calibri;
            font-size: 11px;
        }
        #divDB
        {
            border: 0px;
            margin: 0px;
            padding: 0px;
            height: 100%;
            width: 100%;
        }
        #tdHeader
        {
            height: 30px;
            background-color: #A0CDEE;
            border-bottom: solid 1px #9DBED5;
            font-weight: bold;
            font-size: 14px;
            border-bottom: solid 1px #9DBED5;
        }
        #tdHeader div
        {
            height: 100%;
            width: 100%;
            margin: 0px;
            padding-left: 5px;
            vertical-align: middle;
            padding-top: 8px;
        }
        sup
        {
            font-size: 10px;
            font-weight: bold;
        }
        #tdFilterRow
        {
            height: 35px;
            background-color: #F2F2F2;
            border-top: solid 1px #9DBED5;
            width: 100%;
            vertical-align: middle;
            border-bottom: solid 1px #9DBED5;
        }
        #tdMainHeader
        {
            height: 30px;
            width: 100%; /*padding-left:5px;*/
        }
        .title
        {
            font-size: 11px;
            font-weight: bold;
            text-align: right;
            border-bottom: solid 1px #9DBED5;
            padding-right: 2px;
        }
        .StartTimeCell
        {
            background-color: #FFFFEC;
            font-size: 11px;
            font-weight: normal;
            text-align: left;
            border-top: solid 1px #9DBED5;
            border-left: solid 1px #9DBED5;
            border-bottom: solid 1px #9DBED5;
            vertical-align: middle;
        }
        .WeekDayCell
        {
            background-color: #ECF9F0;
            font-size: 11px;
            font-weight: Bold;
            text-align: right;
            border-top: solid 1px #9DBED5;
            border-left: solid 1px #9DBED5;
            border-bottom: solid 1px #9DBED5;
        }
        .SaturDayCell
        {
            background-color: #EDF4FA;
            font-size: 11px;
            font-weight: Bold;
            text-align: right;
            border-top: solid 1px #9DBED5;
            border-left: solid 1px #9DBED5;
            border-bottom: solid 1px #9DBED5;
        }
        .BreakCell
        {
            background-color: #F3F1FE;
            font-size: 11px;
            font-weight: Bold;
            text-align: right;
            border-top: solid 1px #9DBED5;
            border-left: solid 1px #9DBED5;
            border-bottom: solid 1px #9DBED5;
        }
        .CellText
        {
            padding-top: 5px;
            padding-right: 5px;
            
        }
        .StatusCell
        {
            border-top: solid 1px #9DBED5;
            border-left: solid 1px #9DBED5;
            border-bottom: solid 1px #9DBED5;
        }
        .ActionCell
        {
            border-top: solid 1px #9DBED5;
            border-left: solid 1px #9DBED5;
            border-bottom: solid 1px #9DBED5;
        }
        .ProgressIndicatorDIV
        {
            display: none;
        }
        .dvNoRecord
        {
             display:block;
             position:absolute;
             left:420px;
             top:210px;
              font-family:Calibri;
               font-size:14px;
               font-weight:bold; 	
        }
    </style>
</head>
<body scroll="no" style="margin: 0px; padding: 0px;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scManager" runat="server">
    </asp:ScriptManager>

    <script language="javascript" type="text/javascript">

        var postbackElement;
        Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(beginRequest);
        Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(pageLoaded);
        Sys.WebForms.PageRequestManager.getInstance().add_pageLoading(onPageLoading);

        function beginRequest(sender, args) {
            postbackElement = args.get_postBackElement();
            $(".ProgressIndicatorDIV").show();
        }

        function pageLoaded(sender, args) {
            var updatedPanels = args.get_panelsUpdated();
            if (typeof (postbackElement) === "undefined") {
                return;
            }
            for (i = 0; i < updatedPanels.length; i++) {
                if (updatedPanels[i].id == '<%= upProfiles.ClientID %>') {
                    $(".ProgressIndicatorDIV").hide();
                }
            }
        }

        function onPageLoading(sender, e) {
            $(".ProgressIndicatorDIV").show();
        }

        function OpenProfile(ProfileID) {
            window.location = "AddUserOfficeTimingProfiles.aspx?ProfileID=" + ProfileID + "&NoCache=" + new Date();
        }
        function DeleteProfile(ProfileID) {
            document.getElementById('<%=hdnProfileID.ClientID%>').value = ProfileID;
            var blnConfirm;
            blnConfirm = window.confirm('Are you sure you want to delete this profile?')
            if (blnConfirm) {
                document.getElementById('<%=btnReloadRepeater.ClientID %>').click();
                return false;
            }
        }
        function NewProfile() {
            window.location = "AddUserOfficeTimingProfiles.aspx?&NoCache=" + new Date();
            return false;
        }
    </script>

    <asp:Button ID="btnReloadRepeater" runat="server" Style="display: none;" />
    <table border="0" cellpadding="0" cellspacing="0" style="height: 100%; width: 100%;">
        <tr>
            <td id="tdHeader">
                <div>
                    <span style="float: left;">Office Timing Schedule Profile</span> <span style="float: right;
                        padding-right: 5px; padding-bottom: 10px;"><span style="font-weight: normal;">Today
                            is:</span><span style="padding-left: 3px;"><asp:Literal ID="ltrlDate" runat="server"></asp:Literal></span>
                    </span>
                </div>
            </td>
        </tr>
        <tr>
            <td id="tdFilterRow" valign="middle" align="right" style="padding-right: 5px;">
                <asp:ImageButton ID="btnNew" Text="New" runat="server" Width="84px" Height="22px"
                    ImageUrl="~/HR/images/btn_new.gif" OnClientClick="return NewProfile();" />
            </td>
        </tr>
        <tr>
            <td id="tdMainHeader">
                <table border="0" cellpadding="0" cellspacing="0" style="height: 100%; width: 100%;">
                    <tr>
                        <td class="title" style="text-align: left;">
                            <span style="padding-left: 5px;">Profile Name</span>
                        </td>
                        <td class="title" style="width: 100px;">
                            &nbsp;
                        </td>
                        <td class="title" style="width: 140px;">
                            WeekDay Timings
                        </td>
                        <td class="title" style="width: 140px;">
                            Saturday Timings
                        </td>
                        <td class="title" style="width: 140px;">
                            Break Timings
                        </td>
                        <td class="title" style="width: 60px;">
                            Status
                        </td>
                        <td class="title" style="width: 60px; padding-right: 16px;">
                            Action
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="width: 100%;">
                <div style="overflow-y: auto; height: 100%; width: 100%;">
                    <asp:UpdatePanel ID="upProfiles" RenderMode="Block" runat="server">
                        <ContentTemplate>
                            <asp:HiddenField ID="hdnProfileID" runat="server" />
                            <asp:Repeater ID="rptProfiles" runat="server" DataSourceID="odsProfiles">
                                <HeaderTemplate>
                                    <table border="0" cellpadding="0" cellspacing="0" style="height: 100%; width: 100%;
                                        vertical-align: top;">
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td style="height: 50px; border-top: solid 1px #9DBED5; border-bottom: solid 1px #9DBED5;"
                                            valign="middle">
                                            <div style="height: 100%; width: 100%; padding-top: 18px; font-size: 11px; font-weight: bold;">
                                                <span style="padding-left: 5px;">
                                                    <asp:Literal ID="ltrlProfileName" runat="server" Text='<%#Eval("Name") %>'></asp:Literal>
                                                </span>
                                            </div>
                                        </td>
                                        <td style="width: 100px; height: 50px;" class="StartTimeCell">
                                            <div style="height: 25px; width: 100%; border-bottom: solid 1px #9DBED5">
                                                <div class="CellText" style="padding-left:5px;">
                                                    Start Time</div>
                                            </div>
                                            <div style="height: 25px; width: 100%;">
                                                <div class="CellText" style="padding-left:5px;">
                                                    End Time</div>
                                            </div>
                                        </td>
                                        <td style="width: 140px; height: 50px;" class="WeekDayCell">
                                            <div style="height: 25px; width: 100%; border-bottom: solid 1px #9DBED5">
                                                <div class="CellText" style="float: right; font-weight: normal;">
                                                    (<asp:Literal ID="ltrlStartTimeMargin" runat="server" Text='<%#IIF(Eval("GraceStartTime")<=9,"0"&Eval("GraceStartTime"),Eval("GraceStartTime")) %>'></asp:Literal>&nbsp;min)
                                                </div>
                                                <div class="CellText" style="float: right">
                                                    <asp:Literal ID="ltrlStartTime" runat="server" Text='<%#DateTime.Parse(Eval("StartDateTime")).ToString("hh:mm tt")%>'></asp:Literal>
                                                </div>
                                            </div>
                                            <div style="height: 25px; width: 100%;">
                                                <div class="CellText" style="float: right; font-weight: normal;">
                                                    (<asp:Literal ID="ltrlEndTimeMargin" runat="server" Text='<%#IIF(Eval("GraceEndTime")<=9,"0"&Eval("GraceEndTime"),Eval("GraceEndTime")) %>'></asp:Literal>&nbsp;min)
                                                </div>
                                                <div class="CellText" style="float: right;">
                                                    <asp:Literal ID="ltrlEndTime" runat="server" Text='<%#DateTime.Parse(Eval("EndDateTime")).ToString("hh:mm tt")%>'></asp:Literal>
                                                </div>
                                            </div>
                                        </td>
                                        <td style="width: 140px; height: 50px;" class="SaturDayCell">
                                            <div style="height: 25px; width: 100%; border-bottom: solid 1px #9DBED5">
                                                <div class="CellText" style="float: right; font-weight: normal;">
                                                    (<asp:Literal ID="ltrlSaturdayStartTimeMargin" runat="server" Text='<%#IIF(Eval("SaturdayGraceStartTime")<=9,"0"&Eval("SaturdayGraceStartTime"),Eval("SaturdayGraceStartTime")) %>'></asp:Literal>&nbsp;min)
                                                </div>
                                                <div class="CellText" style="float: right;">
                                                    <asp:Literal ID="ltrlSaturdayStartTime" runat="server" Text='<%#DateTime.Parse(Eval("SaturdayOfficeStartTime")).ToString("hh:mm tt") %>'></asp:Literal>
                                                </div>
                                            </div>
                                            <div style="height: 25px; width: 100%;">
                                                <div class="CellText" style="float: right; font-weight: normal;">
                                                    (<asp:Literal ID="ltrlSaturdayEndTimeMargin" runat="server" Text='<%#IIF(Eval("SaturdayGraceEndTime")<=9,"0"&Eval("SaturdayGraceEndTime"),Eval("SaturdayGraceEndTime"))%>'></asp:Literal>&nbsp;min)
                                                </div>
                                                <div class="CellText" style="float: right;">
                                                    <asp:Literal ID="ltrlSaturdayEndTime" runat="server" Text='<%#DateTime.Parse(Eval("SaturdayOfficeEndTime")).ToString("hh:mm tt") %>'></asp:Literal>
                                                </div>
                                            </div>
                                        </td>
                                        <td style="width: 140px; height: 50px;" class="BreakCell">
                                            <div style="height: 25px; width: 100%; border-bottom: solid 1px #9DBED5">
                                                <div class="CellText" style="float: right; font-weight: normal;">
                                                    (<asp:Literal ID="ltrlBreakStartTimeMargin" runat="server" Text='<%#IIF(Eval("BreakGraceTimeEnd")<=9,"0"&Eval("BreakGraceTimeEnd"),Eval("BreakGraceTimeEnd")) %>'></asp:Literal>&nbsp;min)
                                                </div>
                                                <div class="CellText" style="float: right;">
                                                    <asp:Literal ID="ltrlBreakStartTime" runat="server" Text='<%# DateTime.Parse(Eval("BreakStartTime")).ToString("hh:mm tt")%>'></asp:Literal>
                                                </div>
                                            </div>
                                            <div style="height: 25px; width: 100%;">
                                                <div class="CellText" style="float: right; font-weight: normal;">
                                                    (<asp:Literal ID="ltrlBreakEndTimeMargin" runat="server" Text='<%#IIF(Eval("BreakGraceTimeEnd")<=9,"0"&Eval("BreakGraceTimeEnd"),Eval("BreakGraceTimeEnd")) %>'></asp:Literal>&nbsp;min)
                                                </div>
                                                <div class="CellText" style="float: right;">
                                                    <asp:Literal ID="ltrlBreakEndTime" runat="server" Text='<%# DateTime.Parse(Eval("BreakEndTime")).ToString("hh:mm tt")%>'></asp:Literal>
                                                </div>
                                            </div>
                                        </td>
                                        <td style="width: 60px; height: 50px;" class="StatusCell">
                                            <div style="height: 100%; width: 100%; text-align: center; margin-top: 17px;">
                                                <img alt="" border="0" src='<%#IIF(Eval("IsActive"),"../images/ico_tick.gif","../images/delete.gif") %>'
                                                    style="" />
                                            </div>
                                        </td>
                                        <td style="width: 60px; height: 50px;" class="ActionCell">
                                            <div style="height: 100%; width: 100%; text-align: center; margin-top: 17px;">
                                                <span>
                                                    <img alt="" src="../images/edit.gif" onclick="OpenProfile(<%#Eval("ID")%>)" height="12"
                                                        width="10" style="cursor: pointer;" />
                                                </span><span style="margin: 0 1 0 1;">| </span><span>
                                                    <img alt="" src="../images/icn_delete.gif" onclick="DeleteProfile(<%#Eval("ID")%>)"
                                                        style="cursor: pointer;" />
                                                </span>
                                            </div>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <tr>
                                        <td colspan="7">
                                            <div style="margin: 0px; padding: 0px; height: 100%; width: 100%; overflow-y:hidden;">
                                                <table border="0" cellpadding="0" cellspacing="0" style="height: 100%; width: 100%;">
                                                    <tr>
                                                        <td style="height: 50px; border-top: solid 1px #9DBED5; border-bottom: solid 1px #9DBED5;" valign="middle">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 100px; height: 50px;" class="StartTimeCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="WeekDayCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="SaturDayCell">
                                                            &nbsp;
                                                        </td>
                                                         <td style="width: 140px; height: 50px;" class="BreakCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="StatusCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="ActionCell">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height: 50px; border-top: solid 1px #9DBED5; border-bottom: solid 1px #9DBED5;" valign="middle">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 100px; height: 50px;" class="StartTimeCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="WeekDayCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="SaturDayCell">
                                                            &nbsp;
                                                        </td>
                                                         <td style="width: 140px; height: 50px;" class="BreakCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="StatusCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="ActionCell">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height: 50px; border-top: solid 1px #9DBED5; border-bottom: solid 1px #9DBED5;" valign="middle">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 100px; height: 50px;" class="StartTimeCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="WeekDayCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="SaturDayCell">
                                                            &nbsp;
                                                        </td>
                                                         <td style="width: 140px; height: 50px;" class="BreakCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="StatusCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="ActionCell">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height: 50px; border-top: solid 1px #9DBED5; border-bottom: solid 1px #9DBED5;" valign="middle">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 100px; height: 50px;" class="StartTimeCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="WeekDayCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="SaturDayCell">
                                                            &nbsp;
                                                        </td>
                                                         <td style="width: 140px; height: 50px;" class="BreakCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="StatusCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="ActionCell">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height: 50px; border-top: solid 1px #9DBED5; border-bottom: solid 1px #9DBED5;" valign="middle">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 100px; height: 50px;" class="StartTimeCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="WeekDayCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="SaturDayCell">
                                                            &nbsp;
                                                        </td>
                                                         <td style="width: 140px; height: 50px;" class="BreakCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="StatusCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="ActionCell">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height: 50px; border-top: solid 1px #9DBED5; border-bottom: solid 1px #9DBED5;" valign="middle">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 100px; height: 50px;" class="StartTimeCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="WeekDayCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="SaturDayCell">
                                                            &nbsp;
                                                        </td>
                                                         <td style="width: 140px; height: 50px;" class="BreakCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="StatusCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="ActionCell">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height: 50px; border-top: solid 1px #9DBED5; border-bottom: solid 1px #9DBED5;" valign="middle">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 100px; height: 50px;" class="StartTimeCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="WeekDayCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="SaturDayCell">
                                                            &nbsp;
                                                        </td>
                                                         <td style="width: 140px; height: 50px;" class="BreakCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="StatusCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="ActionCell">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height: 50px; border-top: solid 1px #9DBED5; border-bottom: solid 1px #9DBED5;" valign="middle">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 100px; height: 50px;" class="StartTimeCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="WeekDayCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="SaturDayCell">
                                                            &nbsp;
                                                        </td>
                                                         <td style="width: 140px; height: 50px;" class="BreakCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="StatusCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="ActionCell">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height: 50px; border-top: solid 1px #9DBED5; border-bottom: solid 1px #9DBED5;" valign="middle">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 100px; height: 50px;" class="StartTimeCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="WeekDayCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="SaturDayCell">
                                                            &nbsp;
                                                        </td>
                                                         <td style="width: 140px; height: 50px;" class="BreakCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="StatusCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="ActionCell">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height: 50px; border-top: solid 1px #9DBED5; border-bottom: solid 1px #9DBED5;" valign="middle">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 100px; height: 50px;" class="StartTimeCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="WeekDayCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="SaturDayCell">
                                                            &nbsp;
                                                        </td>
                                                         <td style="width: 140px; height: 50px;" class="BreakCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="StatusCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="ActionCell">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height: 50px; border-top: solid 1px #9DBED5; border-bottom: solid 1px #9DBED5;" valign="middle">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 100px; height: 50px;" class="StartTimeCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="WeekDayCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="SaturDayCell">
                                                            &nbsp;
                                                        </td>
                                                         <td style="width: 140px; height: 50px;" class="BreakCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="StatusCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="ActionCell">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height: 50px; border-top: solid 1px #9DBED5; border-bottom: solid 1px #9DBED5;" valign="middle">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 100px; height: 50px;" class="StartTimeCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="WeekDayCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="SaturDayCell">
                                                            &nbsp;
                                                        </td>
                                                         <td style="width: 140px; height: 50px;" class="BreakCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="StatusCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="ActionCell">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height: 50px; border-top: solid 1px #9DBED5; border-bottom: solid 1px #9DBED5;" valign="middle">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 100px; height: 50px;" class="StartTimeCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="WeekDayCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="SaturDayCell">
                                                            &nbsp;
                                                        </td>
                                                         <td style="width: 140px; height: 50px;" class="BreakCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="StatusCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="ActionCell">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height: 50px; border-top: solid 1px #9DBED5; border-bottom: solid 1px #9DBED5;" valign="middle">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 100px; height: 50px;" class="StartTimeCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="WeekDayCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="SaturDayCell">
                                                            &nbsp;
                                                        </td>
                                                         <td style="width: 140px; height: 50px;" class="BreakCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="StatusCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="ActionCell">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height: 50px; border-top: solid 1px #9DBED5; border-bottom: solid 1px #9DBED5;" valign="middle">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 100px; height: 50px;" class="StartTimeCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="WeekDayCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 140px; height: 50px;" class="SaturDayCell">
                                                            &nbsp;
                                                        </td>
                                                         <td style="width: 140px; height: 50px;" class="BreakCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="StatusCell">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 60px; height: 50px;" class="ActionCell">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    </table>
                                </FooterTemplate>
                            </asp:Repeater>
                            <div id="dvNoRecord" class="dvNoRecord" runat="server" visible="false">
                                No record found.
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnReloadRepeater" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
    </table>
    <div class="ProgressIndicatorDIV">
        <br />
        <asp:Image ID="Image2" runat="server" ImageUrl="../images/indicator.gif" ImageAlign="AbsMiddle" />
        <span style="color: #4B92C1; font-size: 14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
        <br />
        <br />
    </div>
    

    <asp:ObjectDataSource ID="odsProfiles" runat="server" TypeName="Portal.BLL.HR.UserOfficeTimingProfiles"
        SelectMethod="ViewAllOfficeTimingProfile"></asp:ObjectDataSource>
    <script language="javascript" type="text/javascript">
       // parent.ChangeTrBackGround(2);
    </script>

    </form>
</body>
</html>
