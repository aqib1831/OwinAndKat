<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PMReportMain_Print.aspx.vb" Inherits="PM_PMReportMain" EnableEventValidation="false" EnableViewStateMac="true" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
	<title>PM Report</title>
	<script language="javascript" type="text/javascript" src="../scripts/jquery-1.3.2.min.js" ></script>	
    <script type="text/javascript">
        function PageLoaded() {
            $("[id*=lblRecordCount]").text($(".DataRow").length);
            window.print();
        }
</script>
</head>
<body style ="margin:0px;background-color:white;height:100%;font-family:Arial;" onload="PageLoaded();">
	<form id="form1" runat="server">
	    <table style="height:100%;width:660px;margin-top:10px;padding:0px;" cellspacing="0" cellpadding="0" border="0" align="center">
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
                       PM Report
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
                <td style="height:100%; font-size:8px !important;margin:0px;width:660px;" valign="top">
                    <table cellpadding="0" cellspacing="0" border="0" style="width:660px;">
                       <tr>
                            <td align="center" valign="top" style="width:660px;height:100%; vertical-align:top; font-size:8px !important;">
                               <asp:Repeater ID="rptrPMStats" runat="server" EnableViewState="false"
                               DataSourceID="odsPMHoursSpent">
                                <HeaderTemplate>
                                    <table cellpadding="0" cellspacing="2" border="0" style="width:660px; font-size:13px;">
                                    <tr>
                                        <td style="border-bottom: solid 1px black;width:50%; font-weight:bold;">
                                            <span>Team</span>
                                        </td>
                                        <td style="border-bottom: solid 1px black;width:25%; font-weight:bold;">
                                            <span>Time Spent (HH:MM)</span>
                                        </td>
                                        <td style="border-bottom: solid 1px black;width:25%; font-weight:bold;" > 
                                            <span>Total Tickets</span>
                                        </td>
                                    </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                        <tr class="DataRow">
                                            <td>
                                                <%# Container.DataItem("Team")%>    
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblTimeSpent" runat="server" Text="0:00" CssClass="TimeSpent" />
                                            </td>
                                            <td align="right">
                                               <asp:Label ID="lblTotalTickets" runat="server" Text='<%# Math.Floor(Functions.IfNull(Container.DataItem("TicketsCompleted"), 0))%>' CssClass="TicketsCompleted"></asp:Label>                                                                                    
                                            </td>
                                        </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <tr>
                                        <td style="width:50%; font-weight:bold;" valign="middle">
                                            <span>Grand Total</span>
                                        </td>
                                        <td style="width:25%; font-weight:bold;" align="right" valign="middle">
                                             <span id="lblTimeSum" ></span>
                                        </td>
                                        <td style="width:25%; font-weight:bold;"  align="right" valign="middle"> 
                                            <span id="lblTicketSum" ></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="left" style="border-top: solid 1px black;">
                                            Total Records - <asp:Label ID="lblRecordCount" runat="server" Text="30" />
                                        </td>
                                    </tr>
                                    </table>
                                </FooterTemplate>
                                </asp:Repeater>
                                <asp:ObjectDataSource ID="odsPMHoursSpent" runat="server" TypeName="Portal.BLL.PM.PM_Ticket_Features" SelectMethod="GetPMDashBoardStats" >
                                    <SelectParameters>
                                          <asp:QueryStringParameter QueryStringField="StartDate" Name="StartDate" />
                                          <asp:QueryStringParameter QueryStringField="EndDate" Name="EndDate" />
                                          <asp:QueryStringParameter QueryStringField="ClientId" Name="ClientId" />
                                          <asp:QueryStringParameter QueryStringField="TeamId" Name="TeamId" />
                                          <asp:QueryStringParameter QueryStringField="CategoryId" Name="CategoryId" />
                                          <asp:QueryStringParameter QueryStringField="SortBy" Name="SortBy" />
                                         <asp:QueryStringParameter QueryStringField="Type" Name="Type"/>
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
        var columnarray = ['TimeSpent', 'TicketsCompleted'];
        var sum = 0;
        var hourssum = 0;
        for (var counter = 0; counter < columnarray.length; counter++) {
            sum = 0;
            $("." + columnarray[counter]).each(function () {
                var str = $(this).text();
                sum = sum + parseInt(str.split(":")[0]);
            });
            switch (columnarray[counter]) {
                case 'TimeSpent':
                    $("[id*=lblTimeSum]").text(sum);
                    hourssum = sum;
                    break;
                case 'TicketsCompleted':
                    $("[id*=lblTicketSum]").text(sum);
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