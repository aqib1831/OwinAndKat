														  										 				  				   		 		  			<%@ Page Language="VB" AutoEventWireup="false" CodeFile="GenerateReport.aspx.vb"
    Inherits="com_GenerateReport" Theme="Default" %>

<%@ Register Src="SelectionControl.ascx" TagName="SelectionControl" TagPrefix="uc1" %>
<!DOCTYPE html">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
    <script src="../scripts/jquery-1.3.2.min.js" type="text/javascript"></script>
    <style type="text/css">
        body
        {
            margin: 0px;
            height:100%;
        }
        body,html
{
    height:100%;
}
.pageHeader
{
    
}
.pageHeader td
{
    background-color:#A1CCEE;
    font-size:15px;
    font-weight:bold;
    height:25px;
    padding-left:5px;
    border-bottom:1px solid #709CC3;
}

.reportHeader td
{
    background-image: url(../images/bg_Gray.jpg);
    height:18px;
    font-size:12px; 
    padding-left:5px;
    border-bottom: 1px solid #6A9ACB;
}
.reportHeader td span
{
    margin-top:5px;
}


.leftTd
{
    font-size:11px;
    background-color:#E2F1DE;
    border-right:2px solid #6A9ACB;
    padding-left:10px;
    vertical-align:top;
}
.leftTd select
{
    margin:0px;
    font-size:12px;
    margin-bottom:4px;
    border: 1px solid #6A9BC6;
}
.leftTd td
{
    color:#7A7C77;
}
.filtersTd
{
    width:40%;
    background-color:#ECF1F7;
    font-size:12px;
    padding-left:5px;
    vertical-align:top;
}
.filtersTd span
{
    width:70px;
    vertical-align:middle;
    line-height:20px;
    display:inline-block;
    color:#7A7C77;
}
.filtersTd input
{
    width:200px;
    vertical-align:middle;
    border: 1px solid #6A9BC6;
    font-size:11px;
    height:15px;
    padding-left:2px;
    padding-top:4px;
}
.filtersTd select
{
    width:205px;
    vertical-align:middle;
    border: 1px solid #6A9BC6;
    font-size:11px;
    height:20px;
}
.filtersTd input,select,span
{
    margin-top:10px;
}

.filtersTd img
{
    vertical-align:middle;
    margin-left:-23px;
    margin-top:11px;
}
#filtersHeader
{
    font-size:14px;
    padding-top:10px;
}

#filters div input,select
{
    border:1px solid #0066CA;
}

#filters div span
{
    float:left;
    width:100px;
    font-size:13px;
}
#filters div img
{
    
}

#footerDiv
{
    background-color:#F2F9F1;
    height:40px;
}

hr
{
    display:block;
    border:0px;
    border-bottom:1px solid #709CC3;
}
.footer td
{
    background-color:#F2F9F1; 
    height:40px;
    text-align:center;
    border-top: 1px solid #07CA0E;
}
#UpdatePanel1
{
    height:100%;
}
.gnrtBtn
{
    background-image: url('../images/generateRprtBtn.png');
    background-repeat:no-repeat;
    background-position:center;
    background-color:transparent;
    border:none;
    cursor:pointer;
    width:190px;
    height:30px;
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
        .t12Bold
        {
            color:#333333;
            font-size:12px;
            font-weight:600;
            /*font-family: Arial, Verdana,Halvetica, Sans-Serif;*/
        }
    </style>
</head>
<body>
    <script type="text/javascript">
        $("[id$=StoreSelectionCtrl]").css("display:none;");
        function showFilters(indx) {
            $("#SSR_customs").hide();
            $("#SDR_customs").hide();
            $("#TR_customs").hide();
            switch (indx) {
                case 0:
                    $("#SSR_filters").show();
                    $("#SDR_filters").hide();
                    $("#TR_filters").hide();
                    isCustom_SSR();
                    break;
                case 1:
                    $("#SSR_filters").hide();
                    $("#SDR_filters").show();
                    $("#TR_filters").hide();
                    isCustom_SDR();
                    break;
                case 2:
                    $("#SSR_filters").hide();
                    $("#SDR_filters").hide();
                    $("#TR_filters").show();
                    isCustom_TR();
                    break;
            }

        }
        function isCustom_SSR() {
            var isCustom = ($('#<% =SSR_ddlPeriod.ClientID %>').val() == 6);
            if (isCustom) {
                $("#SSR_customs").show();
            }
            else {
                $("#SSR_customs").hide();
            }
        }
        function isCustom_SDR() {
            var isCustom = ($('#<% =SDR_ddlPeriod.ClientID %>').val() == 6);
            if (isCustom) {
                $("#SDR_customs").show();
            }
            else {
                $("#SDR_customs").hide();
            }
        }
        function isCustom_TR() {
            var isCustom = ($('#<% =TR_ddlPeriod.ClientID %>').val() == 6);
            if (isCustom) {
                $("#TR_customs").show();
            }
            else {
                $("#TR_customs").hide();
            }
        }

        function showFiltersOnPostBack() {

            var radioSSR = document.getElementById('<% =radioSSR.ClientID %>')
            var radioSDR = document.getElementById('<% =radioSDR.ClientID %>')
            if (radioSSR.checked) {
                showFilters(0);
            }
            else if (radioSDR.checked) {
            showFilters(1);
            }
            else{
                showFilters(2);
            }
            if ($("[id$=selectionLftTbl] tr").length == 0) {
                $("[id$=selectionRtTbl] tr[id='0All']").css("display","none");
            }
            else {
                $("[id$=selectionRtTbl] tr[id='0All']").css("display", "inline");
            }
        }

        function isValidDate(date) {
            var date = new Date(dat)
            if (date == NaN) {
                return false
            }
            else{
            return true;
            }

    }

//    function onGenerateValidateDate() {
//        var radioSSR = document.getElementById('<% =radioSSR.ClientID %>');
//        var radioSDR = document.getElementById('<% =radioSDR.ClientID %>');
//        var radioTR = document.getElementById('<% =radioTR.ClientID %>');
//        var ssr_Custum = $('#<% =SSR_ddlPeriod.ClientID %>');
//        var sdr_Custum = $('#<% =SDR_ddlPeriod.ClientID %>');
//        var tr_Custum = $('#<% =TR_ddlPeriod.ClientID %>');

//        if (radioSDR.checked && ssr.val() == "6") {
//            
//        }
//    
//    }

    </script>
    <form id="form1" runat="server" style="height:100%">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="progress" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
                <ProgressTemplate>
                    <div class="loadingDiv">
                        <img src="../images/indicator.gif" alt="" style="vertical-align: middle" />
                        Loading...
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height:100%;">
                    <tr class="pageHeader">
                        <td >
                            Generate Report
                        </td>
                        <td style="text-align:right; padding-right:10px;">
                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="HomeButton" PostBackUrl="~/com/TechnicianReport.aspx" >
                        <div style="width:125px;padding-top:0px;padding-bottom:0px;display:inline-block;" class="LeadDetailButton"><span style="margin-top:2px;height:18px;line-height:18px; vertical-align:middle;">BACK TO DASHBOARD<img  src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10" style="border:0px;"/></span></div></asp:LinkButton>
                        
                        </td>
                    </tr>
                    <tr class="reportHeader">
                        <td colspan="2">
                            <span>Report Type</span>
                        </td>
                    </tr>
                    <tr>
                        <td id="leftTd" class="leftTd">
                            <asp:RadioButton ID="radioSSR" runat="server" GroupName="report" Text="SURVEY SUMMARY REPORT"
                                Checked="true" onclick="showFilters(0)" />
                            <br />
                            <hr style="border-bottom:1px solid #DAE2E4;"  />
                            <asp:RadioButton ID="radioSDR" runat="server" Text="SURVEY DETAIL REPORT" GroupName="report"
                                onclick="showFilters(1)" />
                            <br />
                            <hr style="border-bottom:1px solid #DAE2E4;" />
                            <asp:RadioButton ID="radioTR" runat="server" Text="TECHNICIAN REPORT" GroupName="report"
                                onclick="showFilters(2)" />
                            <br />
                            <hr />
                            <table>
                                <tr>
                                    <td>
                                        Client:
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlClient" runat="server" Width="200px" DataSourceID="sdsClients"
                                            DataTextField="Name" DataValueField="ID" AutoPostBack="True">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Country:
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlCountry" runat="server" Width="200px" DataSourceID="sdsCountries"
                                            DataTextField="Name" DataValueField="ID" AutoPostBack="True">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        State:
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlState" runat="server" Width="200px" DataSourceID="sdsStates"
                                            DataTextField="Name" DataValueField="ID" AutoPostBack="True"
                                            >
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                            <span style="color:#7A7C77; margin-bottom:5px; margin-left:3px;">
                            Select Store(s)
                            </span>
                            <br />
                            <uc1:SelectionControl ID="StoreSelectionCtrl" Width="400px" Height="185px" runat="server" />
                        </td>
                        <td id="filtersTd"  class="filtersTd">
                            <!--Filters Main td-->
                            <div id="filtersHeader t13Bold" style=" margin-top:8px;">
                                Filters</div>
                            <div id="SSR_filters">
                                <!--SSR_filters-->
                                <span>Period:</span>
                                <asp:DropDownList ID="SSR_ddlPeriod" runat="server" onchange="isCustom_SSR()">
                                    <asp:ListItem Text="This Week" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Last Week" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="This Month" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Last Month" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="This Year" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="Last Year" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="Custom" Value="6"></asp:ListItem>
                                </asp:DropDownList>
                                <br />
                                <div id="SSR_customs" style="display: none">
                                    <span>From:</span>
                                    <asp:TextBox ID="SSR_txtFromDate" Text="Please Select" runat="server" onfocus="this.blur();"></asp:TextBox>
                                    <img id="imgDDCalander" border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= SSR_txtFromDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                        onmouseover="style.cursor='hand';" src="../images/ico_calender2.png" 
                                         alt="" />
                                    <br />
                                    <span>To:</span>
                                    <asp:TextBox ID="SSR_txtToDate" Text="Please Select" runat="server" onfocus="this.blur();"></asp:TextBox>
                                    <img id="img1" border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= SSR_txtToDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                        onmouseover="style.cursor='hand';" src="../images/ico_calender2.png" 
                                         alt="" />
                                </div>
                            </div>
                            <!--SSR_filters-->
                            <div id="SDR_filters" style="display: none">
                                <!--SDR_filters-->
                                <span>Period:</span>
                                <asp:DropDownList ID="SDR_ddlPeriod" runat="server" onchange="isCustom_SDR()">
                                    <asp:ListItem Text="This Week" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Last Week" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="This Month" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Last Month" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="This Year" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="Last Year" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="Custom" Value="6"></asp:ListItem>
                                </asp:DropDownList>
                                <div id="SDR_customs">
                                    <span>From:</span>
                                    <asp:TextBox ID="SDR_txtFromDate" Text="Please Select" runat="server" onfocus="this.blur();"></asp:TextBox>
                                    <img id="img2" border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= SDR_txtFromDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                        onmouseover="style.cursor='hand';" src="../images/ico_calender2.png" 
                                         alt="" />
                                    <br />
                                    <span>To:</span>
                                    <asp:TextBox ID="SDR_txtToDate" Text="Please Select" runat="server" onfocus="this.blur();"></asp:TextBox>
                                    <img id="img3" border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= SDR_txtToDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                        onmouseover="style.cursor='hand';" src="../images/ico_calender2.png" 
                                         alt="" />
                                </div>
                                <br />
                                <span>Priority:</span>
                                <asp:DropDownList ID="SDR_ddlPriority" runat="server">
                                    <asp:ListItem Text="All" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Low" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Minimal" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Moderate" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="Severe" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="Critical" Value="5"></asp:ListItem>
                                </asp:DropDownList>
                                <br />
                                <span>Feedback:</span>
                                <asp:DropDownList ID="SDR_ddlFeedback" runat="server">
                                    <asp:ListItem Text="All" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Great" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Okay" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Unhappy" Value="3"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <!--SDR_filters-->
                            <div id="TR_filters" style="display: none">
                                <!--TR_filters-->
                                <span>Period:</span>
                                <asp:DropDownList ID="TR_ddlPeriod" runat="server" onchange="isCustom_TR()">
                                    <asp:ListItem Text="This Week" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Last Week" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="This Month" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Last Month" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="This Year" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="Last Year" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="Custom" Value="6"></asp:ListItem>
                                </asp:DropDownList>
                                <br />
                                <div id="TR_customs">
                                    <span>From:</span>
                                    <asp:TextBox ID="TR_txtFromDate" Text="Please Select" runat="server" onfocus="this.blur();"></asp:TextBox>
                                    <img id="img4" border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= TR_txtFromDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                        onmouseover="style.cursor='hand';" src="../images/ico_calender2.png" width="18px"
                                        height="15px" alt="" />
                                    <br />
                                    <span>To:</span>
                                    <asp:TextBox ID="TR_txtToDate" Text="Please Select" runat="server" onfocus="this.blur();"></asp:TextBox>
                                    <img id="img5" border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= TR_txtToDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                        onmouseover="style.cursor='hand';" src="../images/ico_calender2.png" 
                                         alt="" />
                                    <br />
                                </div>
                                <span>Technician:</span>
                                <asp:DropDownList ID="TR_ddlTechnician" runat="server" DataSourceID="sdsTechnician"
                                    DataTextField="FullName" AppendDataBoundItems="true" EnableViewState="false"
                                    DataValueField="ID">
                                    <asp:ListItem Text="All" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <!--TR_filters-->
                        </td>
                        <!--Filters Main td end-->
                    </tr>
                    <tr class="footer" >
                        <td colspan="2">
                            <asp:Button ID="btnGenerateReport" runat="server" CssClass="gnrtBtn" OnClientClick="SetHiddenValues();"  />
                        </td>
                    </tr>
                </table>

            <!--sqlDataSources-->
            <!--clients-->
            <asp:SqlDataSource ID="sdsClients" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                SelectCommand="Clients_GetAll" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsCountries" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                SelectCommand="Countries_GetAll_forList" SelectCommandType="StoredProcedure">
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsStates" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                SelectCommand="States_GetAll_ByCountryID" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlCountry" Name="countryID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsTechnician" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                SelectCommand="Users_GetAllTechnicians" SelectCommandType="StoredProcedure">
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsStores" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                SelectCommand="Franchises_GetBy_Client_Country_State" SelectCommandType="StoredProcedure" DataSourceMode="DataReader">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlClient" Name="clientID" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="ddlCountry" Name="countryID" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="ddlState" Name="stateID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsGetSurveySummeryReport" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                SelectCommand="Activities_GetSurverySummeryReport" SelectCommandType="StoredProcedure"
                DataSourceMode="DataReader"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsGetSurveyDetailReport" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                SelectCommand="Activities_GetSurveyDetailReport" SelectCommandType="StoredProcedure"
                DataSourceMode="DataReader">
                <SelectParameters>
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsGetTechnicianReport" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                SelectCommand="Activities_GetTechnicianReport" SelectCommandType="StoredProcedure"
                DataSourceMode="DataReader">
                <SelectParameters>
                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
        <Triggers>
        <asp:PostBackTrigger ControlID="btnGenerateReport" />
        </Triggers>
    </asp:UpdatePanel>
    </form>
</body>
<script type="text/javascript">
    $("[id$=StoreSelectionCtrl]").css("display:inline;");
    function SetHiddenValues() {
        $("#StoreSelectionCtrl_SelectedValuesField").val("");
        
        $("[id$=selectionRtTbl] tr").each(function() {
            if ($(this).attr("id") != "0All") {
                $("#StoreSelectionCtrl_SelectedValuesField").val($("#StoreSelectionCtrl_SelectedValuesField").val() + "$%" + $(this).attr("id"));
            }
        });
        if ($("[id$=selectionRtTbl] tr").length == 1 && $("[id$=selectionRtTbl] tr").attr("id") == "0All") {
            $("[id$=selectionLftTbl] tr").each(function() {
                    $("#StoreSelectionCtrl_SelectedValuesField").val($("#StoreSelectionCtrl_SelectedValuesField").val() + "$%" + $(this).attr("id"));
               
            });
        }
        return;
    }

    var prm = Sys.WebForms.PageRequestManager.getInstance();
    prm.add_endRequest(showFiltersOnPostBack);
</script>
</html>