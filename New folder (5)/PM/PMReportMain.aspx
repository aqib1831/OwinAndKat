								   														  <%@ Page Language="VB" AutoEventWireup="false" CodeFile="PMReportMain.aspx.vb" Inherits="PM_PMReportMain" Theme="Default" EnableEventValidation="false" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
	<title>PM Report</title>
	 <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../scripts/functions.js" ></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>   
    <script language="javascript" type="text/javascript" src="../scripts/jquery-1.3.2.min.js" ></script>	
     <style>
        .SimpleHomeRow td, GridRowClickable td, .HighlightedHomeRow td, .TextWrap, .GView td, .FloatingHeader th{
            font-size:12px !important;
        }
    </style>
</head>
<body style ="margin :0px; background-color:#E4F1F7; width:100%; height:100%; ">
	
    <form id="form1" runat="server">
	<asp:HiddenField ID="hdnStartDate" runat="server" />
    <asp:HiddenField ID="hdnEndDate" runat="server" />
    <div>    
	<asp:ScriptManager ID="ScriptManager1" runat="server" />
	 <asp:UpdateProgress ID="Progress1" runat="server">
			<ProgressTemplate>
				<div class="ProgressIndicatorDIV" >
					<br />
					<asp:Image ID="Image2" runat="server" ImageUrl="../images/indicator.gif" ImageAlign="AbsMiddle" /> <span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
					<br /><br />
				</div>
			</ProgressTemplate>
		</asp:UpdateProgress>
	    <table style="height:100%;width:100%;margin:0px;padding:0px;background-color:#E4F1F7;" cellspacing="0" cellpadding="0" border="0">
			<tr class="UnderlinedRow" style="height:5%;">
                 <td  style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:5px;width:30%;">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            PM Report
                        </ContentTemplate>
                         <Triggers >
                              <asp:AsyncPostBackTrigger ControlID="ddlCategory" EventName="SelectedIndexChanged" />
                              <asp:AsyncPostBackTrigger ControlID="ddlClients" EventName="SelectedIndexChanged" />
                              <asp:AsyncPostBackTrigger ControlID="ddlType" EventName="SelectedIndexChanged" />
                              <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                              
                              <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                         </Triggers>
                    </asp:UpdatePanel>
                 </td>
                 <td style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right;width:70%;">
                      <div style="width:auto;float:right;margin-right:3px;">
                    <div style="width: 110px;float:left;margin-right:5px;" class="LeadDetailButton" onclick="PrintReport();" >
                            Print
                        </div>
                    <div style="width: 110px;float:left;margin-right:5px;" class="LeadDetailButton" onclick="GenerateExcel();" >
                            Export To Excel
                        </div>
                    <div style="float:left;">
                                <asp:LinkButton ID="lnkResetFilters" runat="server" CssClass="HomeButton">
                                <div style="width:110px;" class="LeadDetailButton" onclick="javascript:ResetFilters();">
                                    Reset Filters 
                                    <img  src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10"  style="border:0px;" /></div>
                                </asp:LinkButton>
                     </div>
                     
                        
                     </div>
                 </td>                        
             </tr>    
			<tr class=""">
				<td colspan="2" style="height:40px;background-color:#BADCFC;">
					<table border="0" cellpadding="0" cellspacing="0" >
					<tr>
					<td align="center" style=" padding-bottom:3px;">
						<div style="float:left;width:113px;margin-left:5px; text-align:left;">
                        <span style="font-size: 7pt; color: #7c8798">Clients&nbsp;</span><br />
						<asp:DropDownList 
						ID="ddlClients" 
						runat="server" 
						SkinID="SmallTextCombo"
						DataTextField="Name" 
						DataValueField="ID"
						AutoPostBack="True" Width="110px" DataSourceID="odsClients">
						</asp:DropDownList>&nbsp;
						<asp:ObjectDataSource ID="odsClients" runat="server" TypeName="Portal.BLL.Users" SelectMethod="GetClientsByUserIDAndSubModuleIDs">
						<SelectParameters>
								<asp:SessionParameter Name="userId" Type="int32" SessionField="AdminID" />
						</SelectParameters>
						</asp:ObjectDataSource>
                        </div>
						</td>
					<td style="width:5px;text-align:center;">
						 <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
					</td>
					<td align="left" style="text-align:left; padding-bottom:3px;">
						<div style="width:113px;margin-left:3px;float:left;"> 
                        <span class="GrayHeader">Teams<br />
						</span>
							<asp:DropDownList 
							ID="ddlTeams" 
							runat="server" 
							SkinID="SmallTextCombo"
							DataTextField="Name"
							DataValueField="ID"
							AutoPostBack="True" Width="110px" DataSourceID="sdsTeams">
						</asp:DropDownList>&nbsp;
						 <asp:SqlDataSource ID="sdsTeams" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                              SelectCommand="Groups_GetGroupsbyTypeForPMReport" 
                              SelectCommandType="StoredProcedure"
                              DataSourceMode="DataReader">
                              <SelectParameters>
                                  <asp:Parameter ConvertEmptyStringToNull="False" DefaultValue="2" Name="Type" Type="Int32" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                        </div>
					</td>
					<td style="width:5px;text-align:center;">
                          <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                      </td>
                      <td align="left" style="text-align:left; padding-bottom:3px;">
						<div style="width:113px;margin-left:3px;float:left;"> 
                        <span class="GrayHeader">Category<br />
						</span>
							<asp:UpdatePanel ID="upCategory" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                <ContentTemplate>
							<asp:DropDownList 
							ID="ddlCategory" 
							runat="server" 
							SkinID="SmallTextCombo"
							DataTextField="Name"
							DataValueField="ID"
							AutoPostBack="True" Width="110px" DataSourceID="sdsCategory">
						</asp:DropDownList>&nbsp;
						 <asp:SqlDataSource ID="sdsCategory" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                              SelectCommand="PM_Categories_Clients_GetAll" 
                              SelectCommandType="StoredProcedure" DataSourceMode="DataSet"
                              >
                              <SelectParameters>
                                  <asp:ControlParameter ControlID="ddlClients" PropertyName="SelectedValue" Name="ClientID" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddlClients" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
					</td>
					<td style="width:5px;text-align:center;">
                          <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                      </td>
                      
                      <td align="left" style="text-align:left; padding-bottom:3px;">
						<div style="width:113px;margin-left:3px;float:left;"> 
                        <span class="GrayHeader">Type<br />
						</span>
							<asp:DropDownList 
							ID="ddlType" 
							runat="server" 
							SkinID="SmallTextCombo"
							DataSourceID="SDS_Type" 
                            DataTextField="Name"
							DataValueField="ID"
							AutoPostBack="True" Width="110px">
						</asp:DropDownList>&nbsp;
							<asp:SqlDataSource ID="SDS_Type" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
										SelectCommand="PM_TaskTypes_GetAll" SelectCommandType="StoredProcedure" DataSourceMode="DataReader">
									</asp:SqlDataSource>
                        </div>
					</td>
                    <td style="width:5px;text-align:center;">
                          <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                      </td>
                    <td style="padding-bottom:3px;width:110px; text-align:left;" align="center">
                         <div style="float:left;width:104px;text-align:left;">
                                <span class="GreyTextSmall" style="margin-left:3px;">From Date</span><br />
                                <span style="margin-left:3px;">
                                    <asp:TextBox runat="server" ID="txtDateFrom" CssClass="GreyTextBox" Width="70px" Height="18px" onfocus="this.blur();" />
                                    <img id="img2" align="absMiddle"
                                     border="0"
                                     onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtDateFrom.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                     onmouseover="style.cursor='hand';"
                                     src="../images/ico_calendar.jpg" alt="" />
                                </span>
                             </div>                     
                        </td>
                         <td style="padding-bottom:3px;">
                            <div style="float:left;width:104px;text-align:left;">
                                <span class="GreyTextSmall">To Date</span><br />
                                <span>
                                <asp:TextBox runat="server" ID="txtDateTo" CssClass="GreyTextBox" Width="70px" Height="18px" onfocus="this.blur();" />
                                <img id="img1" align="absMiddle"
                                     border="0"
                                     onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtDateTo.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                     onmouseover="style.cursor='hand';"
                                     src="../images/ico_calendar.jpg" alt="" />
                                     </span>
                             </div>
                        </td>
                        <td style="padding-top:12px;padding-left:5px; white-space:nowrap;" align="left"  >
                           <asp:ImageButton ID="btnSearch" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/btn_go.gif" />
                        </td>
                </tr>
				</table>
				</td>
			</tr>
            <tr>
                <td style="background-color:#BADCFC;height:100%; font-size:8px !important; border-top:solid 1px #609BD3;margin:0px;" colspan="2" valign="top">
                    <table cellpadding="0" cellspacing="0" border="0" style="width:100%; height:100%;">
                       <tr>
                            <td align="center" valign="top" style="width:100%;height:100%; vertical-align:top; font-size:8px !important;">
                                                               <div style="width:100%; height:100%; overflow:auto;  background-color:#E4F1F7;border:1px solid #ACBDD5;" class="ScrollBarHomeTicket" >                   
                                <asp:UpdatePanel ID="upPMDashBoard" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                <ContentTemplate>
                                <asp:HiddenField ID="hdnSortBy" runat="server" Value="" /> 
                               <asp:GridView ID="gvPMStats" runat="server" AutoGenerateColumns="False" EnableTheming="True" SkinID="GridViewWithOutPaging" EnableViewState="false"
                               AllowSorting="True" DataSourceID="odsPMHoursSpent" PageSize="50" ShowFooter="true">
                                <Columns>
                                  <asp:TemplateField HeaderText="Team" SortExpression="Team" HeaderStyle-Width="50%">
                                    <ItemTemplate>                                    
                                        <%# CType(Container.DataItem, Data.DataRowView)("Team")%>                                    
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <span>Grand Total</span>
                                    </FooterTemplate>
                                    <FooterStyle Font-Bold="true" />
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Time Spent (HH:MM)" SortExpression="TimeSpent" HeaderStyle-Width="25%">
                                    <ItemTemplate>                                    
                                        <asp:Label ID="lblTimeSpent" runat="server" Text="0:00" CssClass="TimeSpent"  />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                       <span id="lblTimeSum" ></span>
                                    </FooterTemplate>
                                    <FooterStyle Font-Bold="true" />
                                </asp:TemplateField>                                
                                <asp:TemplateField HeaderText="Total Tickets" HeaderStyle-HorizontalAlign="Left" SortExpression="TicketsCompleted" HeaderStyle-Width="25%">
                                    <ItemTemplate>                                    
                                        <asp:Label ID="lblTotalTickets" runat="server" Text='<%# Math.Floor(Functions.IfNull(Container.DataItem("TicketsCompleted"), 0))%>' CssClass="TicketsCompleted"></asp:Label>                                    
                                    </ItemTemplate>
                                    <FooterTemplate>
                                       <span id="lblTicketSum" ></span>
                                    </FooterTemplate>
                                    <FooterStyle Font-Bold="true" />
                                </asp:TemplateField>    
                                </Columns>
                               </asp:GridView>
                                 <asp:ObjectDataSource ID="odsPMHoursSpent" runat="server" TypeName="Portal.BLL.PM.PM_Ticket_Features" SelectMethod="GetPMDashBoardStats"  SortParameterName="SortBy">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="txtDateFrom" PropertyName="Text" Name="StartDate" />
                                        <asp:ControlParameter ControlID="txtDateTo" PropertyName="Text" Name="EndDate" />
                                        <asp:ControlParameter ControlID="ddlClients" PropertyName="SelectedValue" Name="ClientId" />
                                        <asp:ControlParameter ControlID="ddlTeams" PropertyName="SelectedValue" Name="TeamId" />
                                        <asp:ControlParameter ControlID="ddlCategory" PropertyName="SelectedValue" Name="CategoryId" />
                                       <asp:ControlParameter ControlID="ddlType" PropertyName="SelectedValue" Name="Type"/>
                                    </SelectParameters>
                                 </asp:ObjectDataSource>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddlTeams" EventName="SelectedIndexChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="ddlClients" EventName="SelectedIndexChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="ddlCategory"  EventName="SelectedIndexChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="ddlType"  EventName="SelectedIndexChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                                </Triggers>                                 
                                 </asp:UpdatePanel>
                                 </div>
                            </td>                        
                       </tr>                        
                    </table>
                </td>
            </tr>
      </table>
    </div>
    </form>
    
</body>
<script type="text/javascript">
    RefreshSum();
    function ShowDetail(TeamId) {
        var ClientId = $("[id$=ddlClients] option:selected").val();
        var CategoryId =  $("[id$=ddlCategory] option:selected").val();
        var Type= $("[id$=ddlType] option:selected").val();
        var StartDate = $("[id$=txtDateFrom]").val();
        var EndDate = $("[id$=txtDateTo]").val();
        var ddlTeamId = $("[id$=ddlTeams] option:selected").val();
        var querystringToSave = "?ClientId=" + ClientId + "&TeamId=" + ddlTeamId + "&CategoryId=" + CategoryId + "&Type=" + Type + "&StartDate=" + StartDate + "&EndDate=" + EndDate + "&ddlTeamId=" + ddlTeamId;
        var querystring = "?ClientId=" + ClientId + "&TeamId=" + TeamId + "&CategoryId=" + CategoryId + "&Type=" + Type + "&StartDate=" + StartDate + "&EndDate=" + EndDate + "&ddlTeamId=" + ddlTeamId;
        SaveFilterInCookie('PMDashBoardFilter', querystringToSave);
        var url = "PMReportDetail.aspx" + querystring;
        window.location = url;


    }
    function SaveFilterInCookie(cookiename,valToStore)
    {
        document.cookie = cookiename + '=StartDashBaordCookie' + valToStore + 'EndDashBaordCookie';
    }
    function GenerateExcel() {
        var ClientId = $("[id$=ddlClients] option:selected").val();
        var CategoryId = $("[id$=ddlCategory] option:selected").val();
        var TeamId = $("[id$=ddlTeams] option:selected").val();
        var Type = $("[id$=ddlType] option:selected").val();
        var StartDate = $("[id$=txtDateFrom]").val();
        var EndDate = $("[id$=txtDateTo]").val();
        var SortBy = $("[id$=hdnSortBy]").val();

        /** Getting Selected Text **/
        var ClientName = $("[id$=ddlClients] option:selected").text();
        var CategoryName = $("[id$=ddlCategory] option:selected").text();
        var TeamName = $("[id$=ddlTeams] option:selected").text();
        var TypeName = $("[id$=ddlType] option:selected").text();

        var d = new Date();
        var uniqueid = d.getMilliseconds()

        var url = "../ExcelGenerator.ashx?Action=PMDashboard&ClientId=" + ClientId + "&TeamId=" + TeamId + "&CategoryId=" + CategoryId + "&Type=" + Type + "&StartDate=" + StartDate + "&EndDate=" + EndDate + "&ClientName=" + ClientName + "&CategoryName=" + CategoryName + "&TeamName=" + TeamName + "&TypeName=" + TypeName + "&SortBy=" + SortBy + "&nocache=" + uniqueid;
        window.open(url);
    }
    function PrintReport() {
        var ClientId = $("[id$=ddlClients] option:selected").val();
        var CategoryId = $("[id$=ddlCategory] option:selected").val();
        var TeamId = $("[id$=ddlTeams] option:selected").val();
        var Type = $("[id$=ddlType] option:selected").val();
        var StartDate = $("[id$=txtDateFrom]").val();
        var EndDate = $("[id$=txtDateTo]").val();
        var SortBy = $("[id$=hdnSortBy]").val();
        
        /** Getting Selected Text **/
        var ClientName = $("[id$=ddlClients] option:selected").text();
        var CategoryName = $("[id$=ddlCategory] option:selected").text();
        var TeamName = $("[id$=ddlTeams] option:selected").text();
        var TypeName = $("[id$=ddlType] option:selected").text();
        

        var d = new Date();
        var uniqueid = d.getMilliseconds();

        var url = "PMReportMain_Print.aspx?ClientId=" + ClientId + "&TeamId=" + TeamId + "&CategoryId=" + CategoryId + "&Type=" + Type + "&StartDate=" + StartDate + "&EndDate=" + EndDate + "&ClientName=" + ClientName + "&CategoryName=" + CategoryName + "&TeamName=" + TeamName + "&TypeName=" + TypeName + "&SortBy=" + SortBy + "&nocache=" + uniqueid;
        window.open(url);  
    }
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
        var minModulo = minsum%60;
        // Making Time String
        var TimeString = ''
        if (minModulo > 9) {
            TimeString =parseInt(hourssum) + ':' + minModulo;
        }
        else if (minModulo <= 0) {
             TimeString = parseInt(hourssum) + ':00';
        }
        else{
          TimeString = parseInt(hourssum) + ':0' + minModulo;
        }
        $("[id*=lblTimeSum]").text(TimeString);
        
    }
    function ResetFilters() {
        $("[id$=ddlClients]").val(1);
        $("[id$=ddlCategory]").val(0);
        $("[id$=ddlTeams]").val(0);
        $("[id$=ddlType]").val(0);
        $("[id$=txtDateFrom]").val($("[id$=hdnStartDate]").val());
        $("[id$=txtDateTo]").val($("[id$=hdnEndDate]").val());
    }

    var prm = Sys.WebForms.PageRequestManager.getInstance();
    prm.add_endRequest(RefreshSum);

     
        
    </script>
</html>