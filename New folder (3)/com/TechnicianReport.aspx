										 									   										 		 							  				 						  											  	 				 <%@ Page Language="VB" AutoEventWireup="false" CodeFile="TechnicianReport.aspx.vb"
    Inherits="com_TechnicianReport" Theme="Default" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%-- <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />--%>
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
    <script language="javascript" type="text/javascript" src="../scripts/jquery-1.7.2.min.js"></script>
   <script type="text/javascript" src="../scripts/SparklineChart/jquery.sparkline.min.js"></script>
   
   

    
    <script type="text/javascript"></script>
    
    <style type="text/css">
        body 
        {
            margin: 0px; 
        }
        .gvwWhite
        {
            font-family: Arial, Verdana, Sans-Serif; 
            font-size: 12px;
        }
        .gvwWhite .gvwHdrGray TH
        {
            background-image: url(../images/bg_Gray.jpg);
            border-bottom: #cdcdcd 1px solid;
            border-right: #DCE1E5 1px solid;
            position: relative;
            padding-bottom: 2px;
            padding-left: 5px;
            padding-right: 2px;
            background-repeat: repeat-x;
            height: 20px;
            color: #363233;
            top: expression(eval(this.parentElement.parentElement.parentElement.parentElement.scrollTop));
            font-weight: lighter;
            padding-top: 2px;
            text-align: left;
        }
        
        .gvwWhite td
        {
            border-right: #DCE1E5 1px solid;
            border-bottom: #DCE1E5 1px solid;
            text-align: right;
            padding-right: 5px;
            padding-left: 5px;
        }
        .bottomFixed
        {
            bottom: 0px;
            position: absolute;
        }
        
        .repSlice
        {
            background-image: url('../Images/footerslice.png');
            background-repeat: repeat;
        }
        
        .emptyErrorDiv
        {
            width: 250px;
            height: 25px;
            position: absolute;
            top: 70%;
            left: 46%;
            font-weight: bold;
            font-size: 14px;
        }
        
        #tblSummery
        {
            border: 1px solid #81AFDF;
            width: 80%;
            background-color: White;
        }
        
        #tblSummery tr td
        {
            border-bottom: 1px solid #dce1F4; border-right: 1px solid #dce1F4;
            text-align: center;
            vertical-align: middle;
            padding: 5px;
        }
        #tblSummery tr td div
        {
            margin: auto;
        }
        
        #tblSummery tr td img
        {
            vertical-align: middle;
        }
        
        .gridFooter
        {
            background-color: Red;
            border: 2px solid Red;
        }
        .greatColumn
        {
            color: #0066CA;
        }
        
        .okeyColumn
        {
            color: #36AC22;
        }
        
        .nothappyColumn
        {
            color: #BF0103;
        }
        .totalColumn
        {
            background-color: #FEFFEF;
        }
        
        .nameHeader
        {
            background-color: #F2F2F2;
            width: 32%;
            font-size: 10px;
            height: 14px;
        }
        .valuesHeader
        {
            width: 102px;
            background-color: #F2F2F2;
            font-size: 10px;
        }
        
        .nameFooter
        {
            font-size: 12px;
            font-weight: bold;
            background-color: #FFFFCD;
            text-align: left;
        }
        .valuesFooter
        {
            font-size: 12px;
            font-weight: bold;
            background-color: #FFFFCD;
            padding-right: 7px;
            width: 100px;
        }
        
        .pageHeaderTr
        {
            background-color: #A1CCEE;
            height: 20px;
            font-size: 12px;
            font-weight: bold;
        }
        .pageHeaderTr td
        {
            padding-left: 5px;
            height: 30px;
            border-bottom: 1px solid #6A9ACB;
            border-top: 1px solid #6A9ACB;
        }
        
        #datesTr
        {
            background-color: #CFE8FE;
            height: 30px;
        }
        
        #datesTr td
        {
            border-bottom: 2px solid #B2BECC;
            padding: 5px;
        }
        
        #ratingDashboardDiv
        {
            background-image: url(../images/bg_Gray.jpg);
            height: 20px;
            font-weight: bolder;
            font-size: 14px;
            padding-left: 10px;
            padding-top: 2px;
            border-bottom: 1px solid #6A9ACB;
        }
        
        .rptFooter td
        {
            text-align: right;
            height: 30px;
            border-bottom: #dce1e5 1px solid;
            border-right: #dce1e5 1px solid;
        }
        .noRecordFound
        {
            position:absolute;
            font-size:14px;
            font-weight:bold;
            bottom:17%;
            left:46%;
        }
        .loadingDiv
        {
            width:130px; 
            position:absolute; 
            bottom:5px; 
            right:5px;
            float:left;
            background-color:#E0F0FD;
            color:#5C9CC6;
            font-size:20px;
            border-top:3px solid #5C90B3;
            border-bottom:3px solid #5C90B3;
            height:50px;
            padding-top:5px;
        }    
        
        .NoBottomBorder
        {
            border-bottom:0px !important;
        }
        .NoRightBorder
        {
         border-right:0px !important;
        }
        .t12Bold
        {
            color:#333333;
            font-size:12px;
            font-weight:600;
            /*font-family: Arial, Verdana,Halvetica, Sans-Serif;*/
        }
        .t13Bold
        {
         font-size: 13px;
         font-weight: bold;
         background-color: #FFFFCD;
         text-align: left;
        }
        .MarginTop2
        {
            margin-top:2px;
        }
        .Td40Px
        {
        width: 40px;
         text-align:right;
        }
        .Td40Px span
        {
            margin-right:5px;
            text-align:right;
            width:100%;
        }
        .radChartDiv
        {
            height:194px !important;
            width:100%;
            margin-top:2px;
        }
    </style>
</head>
<body style="background-color: #F2F9F1;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    
    </asp:ScriptManager>

    <script type="text/javascript">
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_endRequest(MakeChart);
        function resetFilters() {
            var txtFrom = document.getElementById('<%=txtDateFrom.ClientID %>');
            var txtTo = document.getElementById('<%=txtDateTo.ClientID %>');
            var initDateFrom = txtFrom.getAttribute('init');
            var initDateTo = txtTo.getAttribute('init');
            txtFrom.value = initDateFrom;
            txtTo.value = initDateTo;
            return false; //to avoid postback
        }

        function MakeChart() {
            /************** CREATING SPRKLINE CHART PLEASE GOOGLE FOR SPARKLINE CHARTS**************/
            var great = $("[id$='lblGreatTotal']").html();
            var ok = $("[id$=lblOkeyTotal]").html();
            var UnHapy = $("[id$=lblNotHappytotal]").html();
            var NoFb = $("[id$=lblNoFeedback]").html();
            var data = [];
            var colors= [];
            //data = [great, ok, UnHapy, NoFb];
            //colors = ["#0066CA", "#34AE1F", "#BF0103", "#CCCCCC"]
            if ((great != 0) || (ok != 0) || (UnHapy != 0) || (NoFb != 0)) 
            {
                if (great != 0) {
                    data.push(great);
                    colors.push("#0066CA");
                }
                if (ok != 0) {
                    data.push(ok);
                    colors.push("#34AE1F");
                }
                if (UnHapy != 0) {
                    data.push(UnHapy);
                    colors.push("#BF0103");
                }
                if (NoFb != 0) {
                    data.push(NoFb);
                    colors.push("#CCCCCC");
                }
                $('.radChartDiv').sparkline(data, { type: 'pie', barColor: 'green', width: '190', height: '190', sliceColors: colors });
            }
            
            /*****************************************************/
        }




        $("document").ready(function() {
            try {
                $("#radPieChart").html('');
                $("#radPieChart").css('display', 'none');
                MakeChart();

            }
            catch (ex) {
            }

        });
    </script>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server" >
    <ContentTemplate>
    <asp:UpdateProgress ID="progress" AssociatedUpdatePanelID ="UpdatePanel1" runat="server" >
        <ProgressTemplate>
        <div class="loadingDiv">
            <img src="../images/indicator.gif" alt="" style="vertical-align:middle" /> Loading...
        </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <table style="width: 100%; height: 100%;" cellspacing="0" cellpadding="0" border="0">
        <tr>
            <td style="vertical-align: top; height:60px;">
                        <div id="pageHeaderDiv">
                            <table cellpadding="0px" cellspacing="0px" style="width: 100%;">
                                <tr id="pageHeaderTr" class="pageHeaderTr">
                                    <td>
                                        Technician Report
                                    </td>
                                    <td>
                                        &nbsp
                                    </td>
                                    <td style="text-align: right; padding-right: 5px;">
                                        <asp:LinkButton ID="lnkResetFilters" runat="server" CssClass="HomeButton" PostBackUrl="~/com/GenerateReport.aspx" >
        <div style="width:120px;" class="LeadDetailButton" >
            GENERATE REPORT
        <img  src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10" style="border:0px;"/>
        </div>
                                        </asp:LinkButton>
                                        &nbsp
                                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="HomeButton"  OnClientClick="return resetFilters()">
        <div style="width:110px;" class="LeadDetailButton" >
            RESET FILTERS
        <img  src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10" style="border:0px;"/>
        </div>
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                                <tr id="datesTr">
                                    <td style="width: 160px; padding-right: 0px;">
                                        <span class="GreyTextSmall">Start Date</span><br />
                                        <asp:TextBox ID="txtDateFrom" runat="server" CssClass="GreyTextBox" Style="height: 20px;"
                                            onfocus="this.blur();"></asp:TextBox>
                                        <img id="imgDDCalander" align="absMiddle" border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtDateFrom.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                            onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" alt="" />
                                    </td>
                                    <td style="width: 160px;">
                                        <span class="GreyTextSmall">End Date</span><br />
                                        <asp:TextBox ID="txtDateTo" runat="server" Style="height: 20px;" CssClass="GreyTextBox"
                                            onfocus="this.blur();"></asp:TextBox>
                                        <img id="imgDDCalander0" align="absMiddle" border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtDateTo.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                            onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" alt="" />
                                    </td>
                                    <td>
                                        <img src="../images/seperator.png" style="vertical-align: middle; margin-right: 5px;
                                            height: 40px;" alt="" />
                                        <asp:ImageButton ID="btnSearch" Style="margin-top: 10px;" runat="server" ImageUrl="~/images/btn_go.gif"
                                            ImageAlign="AbsMiddle" />
                                <asp:CompareValidator ID="cmpvStartDate" runat="server" ControlToValidate="txtDateFrom" ControlToCompare="txtDateTo" Type="Date" Operator="LessThanEqual" Display="Dynamic" ErrorMessage="Start Date must be less than or equal to End Date" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="ratingDashboardDiv">
                            Ratings Dashboard</div>
            </td>
        </tr>
                        <tr>
                            <td align="center" style="margin-top:0px;">
                            <asp:UpdatePanel ID="upTopStats" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                <ContentTemplate>
                                <table style="width: 100%;height:100%;">
                                    <tr>
                                        <td style="text-align: center;width:50%;max-height:200px;" align="right">
                                            <div class="radChartDiv" id="radChartDiv">
                                            </div>
                                        </td>
                                        <td style="text-align: right; padding-right: 20px;width:50%;" align="left">
                                            <table id="tblSummery" align="left" cellpadding="0" cellspacing="0" border="0" style="width:300px;">
                                                <tr>
                                                    <td style="text-align: left" class="t12Bold">
                                                        <img src="../Images/great-small.jpg" />&nbsp Great
                                                    </td>
                                                    <td class="t12Bold Td40Px" style="background-image: url('../images/blueBlock.png'); background-position: center;
                                                        background-repeat: no-repeat;">
                                                        &nbsp;
                                                    </td>
                                                    <td class="t12Bold Td40Px">
                                                        <asp:Label ID="lblPrcntGreatTotal" runat="server" Text=""></asp:Label>
                                                    </td>
                                                    <td class="NoRightBorder t12Bold Td40Px">
                                                        <asp:Label ID="lblGreatTotal" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td  style="text-align: left;" class="t12Bold">
                                                        <img src="../Images/ok-small.jpg" />&nbsp Okay
                                                    </td>
                                                    <td class="t12Bold" style="background-image: url('../images/greenBlock.png'); background-position: center;
                                                        background-repeat: no-repeat;">
                                                        &nbsp;
                                                    </td>
                                                    <td class="t12Bold Td40Px">
                                                        <asp:Label ID="lblPrcntOkeyTotal" runat="server" Text=""></asp:Label>
                                                    </td>
                                                    <td class="NoRightBorder t12Bold Td40Px">
                                                        <asp:Label ID="lblOkeyTotal" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: left" class="t12Bold">
                                                        <img src="../Images/happy-small.jpg" />&nbsp Not Happy
                                                    </td>
                                                    <td class="t12Bold" style="background-image: url('../images/redBlock.png'); background-position: center;
                                                        background-repeat: no-repeat;">
                                                        &nbsp;
                                                    </td>
                                                    <td class="t12Bold Td40Px">
                                                        <asp:Label ID="lblPrcntNotHappyTotal" runat="server" Text=""></asp:Label>
                                                    </td>
                                                    <td class="NoRightBorder t12Bold Td40Px">
                                                        <asp:Label ID="lblNotHappytotal" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: left;height:35px;" class="t12Bold">
                                                        No Feedback
                                                    </td>
                                                    <td class="t12Bold" style="background-image: url('../images/greyBlock.png'); background-position: center;
                                                        background-repeat: no-repeat;">
                                                        &nbsp;
                                                    </td>
                                                    <td class="t12Bold Td40Px">
                                                        <asp:Label ID="lblPrcntNoFeedbackTotal" runat="server" Text=""></asp:Label>
                                                    </td>
                                                    <td class="NoRightBorder t12Bold Td40Px">
                                                        <asp:Label ID="lblNoFeedback" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr style="background-color: #FFFFCD; font-weight: bold">
                                                    <td colspan="4" class="NoBottomBorder NoRightBorder">
                                                        <div style="float: left" class="t13Bold MarginTop2">
                                                            Total</div>
                                                        <div style="text-align: right;padding-right:5px;" class="MarginTop2 t13Bold">
                                                            <asp:Label ID="lblTotal" runat="server" Text="" ></asp:Label></div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                                </Triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr>
                            <td style="height:170px;vertical-align:bottom;border-top: 2px solid #609ECD;" valign="top">
                              <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                <ContentTemplate>
                                <div id="dvSurvey" style="width: 100%;height:170px; overflow-y: scroll; background-color: White;">
                               
                                
                                    <asp:Repeater ID="rptSurveyReport" runat="server" DataSourceID="sdsSurveyReport"
                                        EnableViewState="false">
                                        <HeaderTemplate>
                                            <table cellpadding="0" cellspacing="0" border="0" style="width: 100%; height:230px;"
                                                class="gvwWhite">
                                                <tr class="gvwHdrGray">
                                                    <th style="height: 20px;">
                                                        Technicians
                                                    </th>
                                                    <th style="width: 100px; height: 20px;">
                                                        Great
                                                    </th>
                                                    <th style="width: 100px;">
                                                        Okay
                                                    </th>
                                                    <th style="width: 100px;">
                                                        Not Happy
                                                    </th>
                                                    <th style="width: 100px;">
                                                        Total
                                                    </th>
                                                </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td style="text-align: left; height: 30px;">
                                                    <span>
                                                        <%# DataBinder.Eval(Container.DataItem, "FullName")%></span>
                                                </td>
                                                <td class="greatColumn">
                                                    <span>
                                                        <%# DataBinder.Eval(Container.DataItem, "Great")%></span>
                                                </td>
                                                <td class="okeyColumn">
                                                    <span>
                                                        <%# DataBinder.Eval(Container.DataItem, "Okay")%></span>
                                                </td>
                                                <td class="nothappyColumn">
                                                    <span>
                                                        <%# DataBinder.Eval(Container.DataItem, "NotHappy")%></span>
                                                </td>
                                                <td class="totalColumn">
                                                    <span>
                                                        <%# DataBinder.Eval(Container.DataItem, "Total")%></span>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <tr id="trFakeRow" runat="server">
                                                <td class="repSlice">
                                                    &nbsp;
                                                </td>
                                                <td class="repSlice">
                                                    &nbsp;
                                                </td>
                                                <td class="repSlice">
                                                    &nbsp;
                                                </td>
                                                <td class="repSlice">
                                                    &nbsp;
                                                </td>
                                                <td class="repSlice">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </div>
                                <table style="width: 100%;" cellpadding="0" cellspacing="0">
                                    <tr id="rptFooter" class="rptFooter  footer">
                                        <td class="nameFooter" style="text-align: left;">
                                            <span style="margin-left: 5px;">Grand Total </span>
                                        </td>
                                        <td class="valuesFooter" style="width: 100px;">
                                            <asp:Label ID="lblGreatFooter" runat="server" Text=""></asp:Label>
                                        </td>
                                        <td class="valuesFooter" style="width: 100px;">
                                            <asp:Label ID="lblOkeyFooter" runat="server" Text=""></asp:Label>
                                        </td>
                                        <td class="valuesFooter" style="width: 100px;">
                                            <asp:Label ID="lblNotHappyFooter" runat="server" Text=""></asp:Label>
                                        </td>
                                        <td class="valuesFooter" style="width: 100px;">
                                            <asp:Label ID="lblTotalFooter" runat="server" Text=""></asp:Label>
                                        </td>
                                        <td style="width: 16px;">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                                </ContentTemplate>
                                  <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                                </Triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
    </table>
    <div id="dvNoRecord" class="noRecordFound"
        visible="false" style="display:none;">
        <img align="absmiddle" src="../images/ico_alert.gif" />&nbsp;&nbsp;No Record
        Found!
    </div>
    <asp:SqlDataSource ID="sdsSurveyReport" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
        SelectCommand="Activities_GetTechnicianReport" SelectCommandType="StoredProcedure">
        <SelectParameters>
		<asp:ControlParameter ControlID="txtDateTo" Name="dateTo" Type="DateTime" />
            <asp:ControlParameter ControlID="txtDateFrom" Name="dateFrom" Type="DateTime" />            
		<asp:Parameter Name="technicianID" DefaultValue="0" />
            <asp:Parameter Name="storeIDs" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>
    </ContentTemplate> 
    </asp:UpdatePanel>
    </form>
</body>
</html>