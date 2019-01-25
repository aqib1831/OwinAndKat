<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PMReportDetail_Print.aspx.vb" Inherits="PM_PMReportDetail" Theme="Default" EnableEventValidation="false" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
	<title>PM Detail Report</title>
	<script language="javascript" type="text/javascript" src="../scripts/jquery-1.3.2.min.js" ></script>	
    <script type="text/javascript">
        function PageLoaded() {
            $("[id*=lblRecordCount]").text($(".DataRow").length);
            if ($(".DataRow").length <= 0) {
                $(".trNoRecord").show();
                $(".trTotalTime").hide();

            }
            else {

                $(".trNoRecord").hide();
                $(".trTotalTime").show();
            }
            window.print();
        }
</script>
</head>
<body style ="margin:0px;background-color:white;min-height:400px;height:auto;font-family:Arial;" onload="PageLoaded();">
	<form id="form1" runat="server">
	    <table style="min-height:400px;height:auto;width:760px;margin-top:10px;padding:0px;" cellspacing="0" cellpadding="0" border="0" align="center">
			<tr>
                 <td style="font-weight:bold; font-size:16px;" align="center">
                    Netsolace, Inc.
                </td>
            </tr>    
			<tr>
                <td>
                   &nbsp; 
                </td>
            </tr>
            <tr>
                <td style="font-weight:bold; font-size:14px;" align="center">
                         PM Detail Report
                </td>
            </tr>
            <tr>
                <td style="font-weight:bold; font-size:13px;" align="center">
                         Generated On: <%=System.DateTime.Now.ToString()%>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td align="center" style="font-weight:bold; font-size:12px;">
                    <asp:Literal ID="ltrlFilters" runat="server"/>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td style="height:100%; font-size:8px !important;margin:0px;width:760px;" valign="top">
                    <table cellpadding="0" cellspacing="0" border="0" style="width:660px;">
                       <tr>
                            <td align="center" valign="top" style="width:760px;height:100%; vertical-align:top; font-size:8px !important;">
                               <asp:Repeater ID="rptrPMStats" runat="server" EnableViewState="false"
                               DataSourceID="odsDashBoardTicket">
                                <HeaderTemplate>
                                    <table cellpadding="0" cellspacing="2" border="0" style="width:760px; font-size:11px;">
                                    <tr>
                                        <td style="border-bottom: solid 1px black;width:9%; font-weight:bold;">
                                            <span>Ref #</span>
                                        </td>
                                        <td style="border-bottom: solid 1px black;width:34%; font-weight:bold;">
                                            <span>Subject</span>
                                        </td>
                                        <td style="border-bottom: solid 1px black;width:15%; font-weight:bold;">
                                            <span>Category</span>
                                        </td>
                                        <td style="border-bottom: solid 1px black;width:15%; font-weight:bold;">
                                            <span>Entered On</span>
                                        </td>
                                        <td style="border-bottom: solid 1px black;width:15%; font-weight:bold;">
                                            <span>Completed On</span>
                                        </td>
                                          <td style="border-bottom: solid 1px black;width:15%; font-weight:bold;">
                                            <span>Completed Survey Y/N</span>
                                        </td>
                                        <td style="border-bottom: solid 1px black;width:13%; font-weight:bold;">
                                            <span>Time Spent (HH:MM)</span>
                                        </td>
                                    </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                        <tr class="DataRow">
                                            <td>
                                                <%#Container.DataItem("RefNo")%>  
                                            </td>
                                            <td>
                                               <%#Functions.StringTruncate(Container.DataItem("Name"),50)%>                                     
                                            </td>
                                            <td>
                                                <%# Container.DataItem("CategoryName")%>                                             
                                            </td>
                                            <td>
                                                <%# Container.DataItem("DateEntered")%>                                             
                                            </td>
                                            <td>
                                                <%# Container.DataItem("DateCompleted")%>                                             
                                            </td>
                                            <td>
                                                 <%# Functions.IfNull(IIf(CType(Container.DataItem, Data.DataRowView)("SurveyExisted") = 0, "No", "Yes"),"N/A")%>
                                            </td>
                                            <td>
                                                <%# Functions.IfNull(Container.DataItem("TimeAsString"), "N/A")%>                                             
                                            </td>
                                        </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <tr class="trTotalTime">
                                        <td colspan="5" align="left" style="font-weight:bold;" >
                                             Total Time Spent
                                        </td>
                                        <td align="right" style="font-weight:bold;">
                                            <asp:Label ID="lblTimeSum" runat="server" Text = "0:00" />
                                        </td>
                                    </tr>
                                    <tr class="trNoRecord">
                                        <td colspan="6" align="center" style=" font-weight:bold;height:50px;">
                                             No Record Found!
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" align="left" style="border-top: solid 1px black;">
                                            Total Records -     <asp:Label ID="lblRecordCount" runat="server" Text="30" />
                                        </td>
                                    </tr>
                                    </table>
                                </FooterTemplate>
                                </asp:Repeater>
                              <asp:ObjectDataSource ID="odsDashBoardTicket" 
                            runat="server" 
                            SelectMethod="GetPMDashBoardTickets"
                            
                            TypeName="Portal.BLL.PM.PM_Ticket_Features">
                            <SelectParameters>
                                <asp:QueryStringParameter QueryStringField="StartDate" Name="StartDate" />
                                <asp:QueryStringParameter QueryStringField="EndDate"  Name="EndDate" />
                                <asp:QueryStringParameter QueryStringField="ClientId" Name="ClientID" DefaultValue="1" Type="Int32" />
                                <asp:QueryStringParameter QueryStringField="CategoryId" DefaultValue="0" Name="CategoryID"  Type="Int32" />
                                <asp:QueryStringParameter QueryStringField="Type" DefaultValue="0" Name="Type" Type="Int32" />                               
                                <asp:QueryStringParameter QueryStringField="TeamId" DefaultValue="0" Name="TeamId" Type="Int32" />                                
                                <asp:QueryStringParameter QueryStringField="UserId" DefaultValue="0" Name="UserId" Type="Int32" />
                                <asp:QueryStringParameter QueryStringField="SortBy" Name="SortExpression" />
                                <asp:Parameter Name="MaximumRows" DefaultValue="100000000" />
                                    <asp:Parameter Name="StartRowIndex" DefaultValue="0" />
                                <asp:Parameter Name="txtsearch" DefaultValue=""/>                                
                            </SelectParameters>
                        </asp:ObjectDataSource>
                            </td>                        
                       </tr>                        
                    </table>
                </td>
            </tr>
      </table>
    </form>
</body>
<script type="text/javascript">
    RefreshSum();
    function RefreshSum() {
        /* Making Stats Sum */
        var columnarray = ['TimeSpent'];
        var sum = 0;
        var hourssum = 0;
        var MinArray = new Array();
        for (var counter = 0; counter < columnarray.length; counter++) {
            sum = 0;
            $("." + columnarray[counter]).each(function () {
                var str = $(this).text();
                sum = sum + parseInt(str.split(":")[0]);
            });
            switch (columnarray[counter]) {
                case 'TimeSpent':
                    //$("[id*=lblTimeSum]").text(sum);
                    hourssum = sum;
                    break;
            }
        }
        /// Find Minutes Sum To Adjust in Hour Time Spent
        var minsum = 0
        $(".TimeSpent").each(function () {
            var str = $(this).text();
            minsum = minsum + parseFloat(str.split(":")[1]);
        });
        //Converting Minutes (which are convertable) to hours and adding to total hours
        hourssum = hourssum + (minsum / 60);
        // Finding remaining minutes (0-59) which are unconvertable to hours
        var minModulo = minsum % 60;
        // Making Time String
        var TimeString = ''
        if (minModulo > 9) {
            TimeString = parseInt(hourssum) + ':' + minModulo;
        }
        else if (minModulo <= 0) {
            TimeString = parseInt(hourssum) + ':00';
        }
        else {
            TimeString = parseInt(hourssum) + ':0' + minModulo;
        }
        $("[id*=lblTimeSum]").text(TimeString);

    }

</script>

</html>