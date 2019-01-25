		 <%@ Page Language="VB" AutoEventWireup="false" ValidateRequest="false" CodeFile="Admin_Inbox.aspx.vb" Inherits="com_admin_inbox" Theme="Default" EnableSessionState="ReadOnly" EnableEventValidation="false" EnableViewState="false" %> 

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Open Actvities</title>
    <link href="../style/style.css" rel="stylesheet" />
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <link href="ComStyle.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <link href="../style/RnDStyleSheet.css" rel="stylesheet" />
    <style type="text/css">
        .SimpleHomeRow TD, .OrangeRow td, .GreenRow td, .RedRow td, .YellowRow td, .HighlightedHomeRow td, FloatingHeader th a {
            white-space: nowrap;
        }


        .gvwSilverPager1 {
            position: relative;
            height: 10px;
            top: expression(parentNode.parentNode.offsetHeight >= offsetParent.offsetHeight ? 0 - parentNode.parentNode.offsetHeight + offsetParent.offsetHeight + offsetParent.scrollTop : 0);
        }

            .gvwSilverPager1 td {
                background-color: #DDEEFE;
                border-top: solid 3px #B7CFE2;
                font-size: 11px;
                color: #7B7B7B;
                font-weight: bold;
                font-family: sans-serif, Arial, verdana, Helvetica;
                padding: 2 2 2 3px;
            }

        .cpygvwSilverPager1 {
            position: relative;
            height: 10px;
            top: expression(parentNode.parentNode.offsetHeight >= offsetParent.offsetHeight ? 0 - parentNode.parentNode.offsetHeight + offsetParent.offsetHeight + offsetParent.scrollTop : 0);
        }

            .cpygvwSilverPager1 td {
                background-color: #DDEEFE;
                border-top: solid 3px #B7CFE2;
                font-size: 11px;
                color: #000000;
                font-weight: bold;
                font-family: sans-serif, Arial, verdana, Helvetica;
                padding: 2 2 2 3px;
            }
    </style>
    <script type="text/javascript">

        function inboxCount(value) {
            if (parent.getElement('lblCount') != null)
                parent.getElement('lblCount').innerText = "(" + value + ")";
         }

         function ChangeRowsClass() {
             var element = getElementByClassName('gvwSilverFooter');
             if (element != null) {
                 element.className = 'gvwSilverFooterOdd';
             }
         }

    </script>

    <meta http-equiv="refresh" content="150">
</head>
<body style="margin: 0px; background-color: #E4F1F7;">
    <form id="form1" runat="server">
        <asp:HiddenField ID="hdnHasSupportAccess" runat="server" Value="False" />
        <asp:HiddenField ID="hdnHelpdeskType" runat="server" Value="1,2" />
        <asp:HiddenField ID="hdnActivityType" runat="server" Value="3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25" />
        <asp:HiddenField ID="hdnHelpdeskCount" runat="server" Value="0" />
        <asp:HiddenField ID="hdnActivityCount" runat="server" Value="0" />
        <iframe id="divDisable" marginheight="0" marginwidth="0" scrolling="no" frameborder="0" style="display: none; z-index: 09; width: 0; height: 0; position: absolute; filter: progid:DXImageTransform.Microsoft.alpha(opacity=50); opacity: 0.5;" src="../BlankPage.htm"></iframe>
        <div id="divToolTip" onmouseover="this.style.display='none'" class="divToolTip"></div>
        <div>
	<asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="300"  />
		<asp:UpdateProgress ID="Progress1" runat="server">
			<ProgressTemplate>
				<div class="LaodingDiv"><img src="../images/indicator.gif" align="absmiddle" /><b>Loading ...</b></div>
			</ProgressTemplate>
		</asp:UpdateProgress>
		<div id="DivMessageAlert">
		<table cellpadding="0" border="0" cellspacing="0">
			<tr>
			  <td class="DivMeAletableTd1">
				  <span title="Franchises Support Expiration Alert">Franchises Support Expiration Alert</span>
			  </td>
			  <td class="DivMeAletableTd2">
				  <img src="../images/btn_close.gif" style="float:right;" alt="Close Window" onClick="Reset();" />
			  </td>
			</tr>
			<tr valign="top">
			 <td colspan="2" class="DivMessageAlerttabletd">
				<div style="overflow-y:auto; height:300px;width:600px;">
				<asp:Repeater
					ID="rptrContactInfo" runat="server"
					DataSourceID="sdsContactInfo" EnableViewState="false" >
					<HeaderTemplate>
						<table id="tbsamplevalue" class="ExpirationTable" border="0" cellpadding="3" cellspacing="0" >
						<tr class="ExpirationTableTr" >
							<td style="width:50px;padding-left:5px;">Store #</td>
							<td style="width:250;">Store Nick</td>
							<td style="width:90; ">Product</td>
							<td style="width:100px;">Expiration Date</td>
						</tr>
					</HeaderTemplate>
					<ItemTemplate>
						<tr onClick="javascript:window.location='Franchise_Inbox.aspx?FranchiseID=<%#Eval("FranchiseID")%>&ClientID=<%#Eval("ClientID")%>';">
							<td><b><%#Eval("StoreNumber")%></b></td>
							<td title='<%#Eval("StoreNick")%>' ><%#Functions.StringTruncate(Eval("StoreNick"), 35)%></td>
							<td><%#Eval("ProductName")%></td>
							<td><%#IIf(Eval("OnSupport") = False, "Not On Support", "<b>" & String.Format("{0:MMM dd, yyyy}", Eval("SupportEndDate")) & "</b>")%></td>
						</tr>
					</ItemTemplate>
					<FooterTemplate></table></FooterTemplate>
				</asp:Repeater>
				<asp:SqlDataSource 
					ID="sdsContactInfo"
					EnableViewState="false"
					runat="Server" 
					ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>" 
					SelectCommand="com_NS_Product_Franchises_SupportEndDate"
					DataSourceMode="DataReader"
					SelectCommandType="StoredProcedure">
				</asp:SqlDataSource> 
				</div>
			 </td>
			</tr>
			<tr>
				<td align="center" colspan="2" class="DivMeAletableTdBottom">
					<input id='btnClose' type='button' class='Btn3D' value='Close' style="height:18px;" title='Close Window' onClick="Reset();" />
				</td>
			</tr>
		</table>
		</div>
	<table class="TableTop" cellspacing="0" cellpadding = "0" border="0">
	 <tr class="UnderlinedRowTR">
		<td>
		<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
		   <ContentTemplate>
                                <h3>Inbox &nbsp;&nbsp;<div style="display:none;">|&nbsp;&nbsp;<asp:Label runat="server" ID="lblActivityCount" /></h3>&nbsp;(<asp:Label runat="server" ID="lblFilter"  Text="all" />)</div>
			<asp:HiddenField ID="hdnAdminID" runat="server" Value="0" />
            <asp:HiddenField ID="hdnSubModuleID" runat="server" Value="" />
            <asp:HiddenField ID="hdnClientIDList" runat="server" Value="" />
			<asp:HiddenField ID="hdnSearch" runat="server" Value="" />
			</ContentTemplate>
				<Triggers >
					<asp:AsyncPostBackTrigger ControlID="ddlFranchises" EventName="SelectedIndexChanged" />
					<asp:AsyncPostBackTrigger ControlID="ddlAssignedByNames" EventName="SelectedIndexChanged" />
					<asp:AsyncPostBackTrigger ControlID="ddlWaitingForNames" EventName="SelectedIndexChanged" />
					<asp:AsyncPostBackTrigger ControlID="ddlFilters" EventName="SelectedIndexChanged" />
					<asp:AsyncPostBackTrigger ControlID="ddlClient" EventName="SelectedIndexChanged" />
					<asp:AsyncPostBackTrigger ControlID="ddlPriority" EventName="SelectedIndexChanged" />
					<asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
					<asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
				</Triggers>
		</asp:UpdatePanel>
		</td>
		 <td align="right">
		 Topics:&nbsp;
			<asp:DropDownList runat="server" ID="ddlTopics"
				Width="150px" Enabled="true" SkinID="SmallTextCombo"
				DataSourceID="sdsTopics" DataTextField="Topic" DataValueField="ID" AutoPostBack="True" >
			</asp:DropDownList>
			<asp:SqlDataSource ID="sdsTopics" 
				runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
				SelectCommand="Activities_GetTopics" SelectCommandType="StoredProcedure" DataSourceMode="DataReader">
			</asp:SqlDataSource>
			&nbsp;<img align="absMiddle" height="20" src="../images/pixel_skyBlue.jpg" width="1" />
			&nbsp;Client:&nbsp;
			<asp:DropDownList runat="server" ID="ddlClient"
					Width="150px" Enabled="true" SkinID="SmallTextCombo"
					DataSourceID="sdsClients" DataTextField="Name"
					DataValueField="ID" AutoPostBack="True" >
			</asp:DropDownList>&nbsp;
			<asp:SqlDataSource ID="sdsClients"
				runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                              SelectCommand="Clients_GetByUserIDForCom_BySubModuleID" 
                              SelectCommandType="StoredProcedure"
                              DataSourceMode="DataReader">
                              <SelectParameters>
                                  <asp:SessionParameter DefaultValue="" Name="UserID" SessionField="AdminID" Type="Int32" />
								<asp:ControlParameter ControlID="hdnSubModuleID" Name="SubModuleID"  PropertyName="Value" Type="String" />
                               </SelectParameters>
                          </asp:SqlDataSource>   
            <%--<asp:SqlDataSource ID="sdsClients"
				runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
				SelectCommand="Clients_GetByUserIDForCom" SelectCommandType="StoredProcedure"
				DataSourceMode="DataReader">
				<SelectParameters>
					<asp:SessionParameter DefaultValue="" Name="UserID" SessionField="AdminID" Type="Int32" />
				</SelectParameters>
			</asp:SqlDataSource>--%>
			<img align="absMiddle" height="20" src="../images/pixel_skyBlue.jpg" width="1"/>&nbsp;
			<asp:LinkButton ID="lnkResetFilters" runat="server" CssClass="HomeButton">
				<div style="width:110px;" class="LeadDetailButton" onClick="javascript:resetFilters();">
				Reset Filters 
				<img  src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10" style="border:0px;"/>
				</div>
			</asp:LinkButton>
		</td>
	 </tr>
	 <tr>
		<td colspan="2" style="height:40px;">
		<table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%;" class="TblTopFilter">
			<tr>
			<td style="width:80px;">
				<span>Filters</span><br />
				<asp:DropDownList
					ID="ddlFilters" runat="server"
					SkinID="SmallTextCombo" AutoPostBack="True" Width="80px">
					<asp:ListItem Text="Show All" Value="-1" Selected="True"></asp:ListItem>
					<asp:ListItem Text="Unassigned" Value="0" ></asp:ListItem>
					<asp:ListItem Text="Assigned" Value="1"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td style="width:5px;text-align:center;"><img src="../images/pixel_darkBlue.jpg" /></td>
			<td style="width:140px;">
				<span>Franchises</span><br />
				<asp:UpdatePanel ID="upFranchisesList" runat="server" UpdateMode="Always">
					<ContentTemplate>
						<asp:DropDownList ID="ddlFranchises"
							SkinID="SmallTextCombo" runat="server"
							AutoPostBack="True" Width="140px" 
							DataSourceID="sdsFranchisesList" DataTextField="StoreNick" DataValueField="FranchiseID">
						</asp:DropDownList>&nbsp;
						<asp:SqlDataSource ID="sdsFranchisesList" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
							SelectCommand="Activities_GetOpenActivities_StoreList_ByClientIDList" SelectCommandType="StoredProcedure">
							<SelectParameters>
								<asp:Parameter  Name="Status" DefaultValue="True" Type="Boolean" />
								<asp:ControlParameter ControlID="ddlClient" Name="ClientID" PropertyName="SelectedValue" Type="Int32" />
								<%--<asp:ControlParameter ControlID="hdnSubModuleID" Name="SubModuleID"  PropertyName="Value" Type="String" />--%>
                                <asp:ControlParameter ControlID="hdnClientIDList" Name="ClientIDList"  PropertyName="Value" Type="String" />
							</SelectParameters>
						</asp:SqlDataSource>
					 </ContentTemplate>
				<Triggers>
					<asp:AsyncPostBackTrigger ControlID="ddlClient" EventName="SelectedIndexChanged" />
				</Triggers>
				</asp:UpdatePanel>
				</td>
				<td style="width:5px;"><img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" /></td>
				<td style="width:110px;">
				<span style="font-size: 7pt; color: #7c8798;">Initiated By:</span><br />
						<asp:DropDownList 
							ID="ddlAssignedByNames" 
							runat="server" 
							SkinID="SmallTextCombo"
							DataSourceID="SDS_AssignedBy" 
							DataTextField="UserName"
							DataValueField="ID"
							AutoPostBack="True" Width="110px">
							</asp:DropDownList>&nbsp;
							<asp:SqlDataSource ID="SDS_AssignedBy" runat="server" 
								ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>" 
								SelectCommand="Com_User_GetAll" 
								SelectCommandType="StoredProcedure"
								DataSourceMode="DataReader">
							</asp:SqlDataSource>
				</td>
				<td style="width:5px;text-align:center;">
					<img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
				  </td>
				  <td align="left" style="width:110px;" >
				  <span style="font-size: 7pt; color: #7c8798">Waiting For:</span><br />
						 <asp:DropDownList 
							ID="ddlWaitingForNames" 
							runat="server" 
							SkinID="SmallTextCombo"
							DataSourceID="SDS_AssignedBy" 
							DataTextField="UserName"
							DataValueField="ID"
							   AutoPostBack="True" Width="110px">
							  </asp:DropDownList>&nbsp;
				  </td>
				  <td style="width:5px;text-align:center;">
					   <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
				  </td>
				  <td align="left" style="width:80px;" >
				  <span style="font-size: 7pt; color: #7c8798">Priority:</span><br />
					<asp:DropDownList ID="ddlPriority" 
							runat="server"
							AutoPostBack="true"
							CssClass="SmallGreenTextBox" 
							Width="80px" >
							<asp:ListItem Text="Select..." Value="0" Selected="True" ></asp:ListItem>
							<asp:ListItem Text="Low" Value="1" />
							<asp:ListItem Text="Minimal" Value="2"/>
							<asp:ListItem Text="Moderate" Value="3" />
							<asp:ListItem Text="High" Value="4" />
							<asp:ListItem Text="Critical" Value="5" />
					 </asp:DropDownList>
				</td>
				<td style="width:5px;text-align:center;">
                                    <img src="../images/pixel_darkBlue.jpg" width="1" height="30" />
				</td>
				<td>
				<asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" >
                                        <span class="GreyTextSmall">Search</span><br />
                                        <span>
                                            <asp:TextBox ID="txtSearch" runat="server" onfocus="javascript:this.value='';" MaxLength="50" Width="100px" SkinID="GreenSmallTextbox" />
                                            <asp:ImageButton ID="btnSearch" runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />
                                        </span>
                                    </asp:Panel>
                                </td>
                                 <td style="text-align:left;width:100%;padding-left:7px;padding-top:7px;border:0px solid Red;padding-bottom:0px !important;">
                                <asp:LinkButton ID="lbtnExportToExcel" runat="server" CssClass="HomeButton">
                                    <div style="width:150px;" class="LeadDetailButton" >
                                        Export Open Tickets
                                    </div>
                                </asp:LinkButton>
                        </td>
                            </tr>
		 </table>
	   </td>
	 </tr>
	 <tr>
                    <td colspan="2" style="background-color: #E4F1F7; margin: 0px; padding: 0px;">
                        <table cellpadding="0" cellspacing="0" border="0" style="height: 100%; width: 100%; background-color: #E4F1F7; border: 1px solid #ACBDD5;" class="ScrollBarHomeTicket">
                            <tr class="HeaderRow">
                                <td style="height: 20px; font-size: 12px; font-weight: bold; background-color: #A0CDEE; border-bottom: 1px solid #609BD3; border-top: 1px solid #609BD3; padding-left: 5px;">
                                    <asp:UpdatePanel
                                        ID="updatepnlHelpdesk"
                                        runat="server"
                                        UpdateMode="Always"
                                        RenderMode="Inline">
                                        <ContentTemplate>
                                            Helpdesk &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label runat="server" ID="lblHelpDiskFilter" />
                                            &nbsp;<span class="NonBold">(<asp:Label runat="server" ID="lblHelpDiskCount" Text="All" />)</span>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlFranchises" EventName="SelectedIndexChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="ddlTopics" EventName="SelectedIndexChanged" />
						<asp:AsyncPostBackTrigger ControlID="ddlAssignedByNames" EventName="SelectedIndexChanged" />
						<asp:AsyncPostBackTrigger ControlID="ddlWaitingForNames" EventName="SelectedIndexChanged" />
						<asp:AsyncPostBackTrigger ControlID="ddlFilters" EventName="SelectedIndexChanged" />
						<asp:AsyncPostBackTrigger ControlID="ddlClient" EventName="SelectedIndexChanged" />
						<asp:AsyncPostBackTrigger ControlID="ddlPriority" EventName="SelectedIndexChanged" />
						<asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
						<asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>

                                </td>
                            </tr>
                            <tr>
                                <td style="width: 100%; height: 50%;" colspan="2">
                                    <asp:ObjectDataSource ID="sdsInbox" runat="server"
                                        SelectMethod="GetAdminInboxForHelpDesk_ByClientIdList"
                                        SelectCountMethod="GetAdminInboxForHelpDeskcount_ByClientIdList"
                                        EnablePaging="true"
						SortParameterName="sortExpression"
						TypeName="Portal.BLL.Activities">
					<SelectParameters>
					  <asp:ControlParameter  Name="FranchiseID" Type="Int32" ControlID="ddlFranchises" PropertyName="SelectedValue" DefaultValue="0" />
					  <asp:ControlParameter  Name="TopicID" Type="Int32" ControlID="ddlTopics" PropertyName="SelectedValue" DefaultValue="0" />
					  <asp:ControlParameter  Name="AssingedBy" Type="String"  ControlID="ddlAssignedByNames" PropertyName="SelectedValue" DefaultValue="" />
					  <asp:ControlParameter  Name="WaitingFor" Type="String"  ControlID="ddlWaitingForNames" PropertyName="SelectedValue" DefaultValue="" />
					  <asp:ControlParameter  Name="Filter" Type="String"  ControlID="ddlFilters" PropertyName="SelectedValue" DefaultValue="" />
					  <asp:ControlParameter  Name="ClientID" Type="String"  ControlID="ddlClient" PropertyName="SelectedValue" DefaultValue="1" />
					  <asp:ControlParameter  Name="PriorityID" Type="Int32"  ControlID="ddlPriority" PropertyName="SelectedValue" DefaultValue="0" />
					  <asp:ControlParameter  Name="Search" Type="String" ControlID="txtSearch" PropertyName="Text" DefaultValue=""  />
                                            <asp:Parameter Name="ReturnValue" Type="Int32" Direction="Output" />
                                            <asp:ControlParameter ControlID="hdnClientIDList" Name="ClientIDList" PropertyName="Value" Type="String" />
                                            <asp:ControlParameter ControlID="hdnHelpdeskType" Name="TicketType"  Type="String" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                    <div style="overflow: auto; background-color: #E4F1F7; border: 1px solid #ACBDD5; height: 100%;"
                                        id="_gridViewPanel1" class="ScrollBarHomeTicket">
                                        <asp:UpdatePanel ID="updatepnlhelpdesk2" runat="server" UpdateMode="Always" RenderMode="Inline">
                                            <ContentTemplate>
                                                <asp:HiddenField ID="hdnPageIndex" runat="server" Value="0" />
                                                <asp:GridView ID="gvInbox" runat="server" AutoGenerateColumns="False" EnableViewState="False"
                                                    DataSourceID="sdsInbox" AllowPaging="True" SkinID="gvwSilverHelpDesk2" ShowFooter="true" Height="100%">
                                                    <Columns>
                                                        <asp:TemplateField HeaderStyle-Width="28px">
                                                            <ItemTemplate>
                                                                <img title='<%# Functions.getActivityCaption(Eval("Activity_Type"))%>' src='<%= ConfigurationManager.AppSettings("ImagesURL") %><%# Functions.GetActivityImage(Eval("Activity_Type")) %>' />
                                                            </ItemTemplate>
                                                            <ItemStyle Width="28px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderStyle-Width="65px" HeaderText="Tkt #" SortExpression="Ticket">
                                                            <ItemTemplate><%# Functions.GetActivityPrefix(Eval("Activity_Type")) &  Eval("Activity_ID")%></ItemTemplate>
                                                            <ItemStyle Width="65px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderStyle-Width="150px" HeaderText="Store #" SortExpression="StoreNumber">
                                                            <ItemTemplate><%#Functions.StringTruncate(Eval("StoreNick") & " - " & Eval("StoreNumber"), 25)%></ItemTemplate>
                                                            <ItemStyle Width="150px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Client" HeaderStyle-Width="40px" ItemStyle-HorizontalAlign="Center" SortExpression="ClientCode">
                                                            <ItemTemplate><%# Eval("ClientCode")%></ItemTemplate>
                                                            <ItemStyle Width="40px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderStyle-Width="190px" HeaderText="Subject" SortExpression="Subject">
                                                            <ItemTemplate><%#Functions.StringTruncate(Functions.IfNull(Eval("Subject"), ""), 30)%></ItemTemplate>
                                                            <ItemStyle Width="190px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Status" SortExpression="Status">
                                                            <ItemTemplate><%#IIf(Eval("ActivityStateText").Equals("Waiting For"), Eval("ActivityStateText").Replace("Waiting For", "WF"), Eval("ActivityStateText")) & IIf(Eval("ActivityState") = 4, ":" & Functions.StringTruncate(Functions.IfNull(Eval("WaitingForName"), ""), 15), "") %></ItemTemplate>
                                                            <ItemStyle Width="100px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderStyle-Width="90px" HeaderText="Created" SortExpression="Date">
                                                            <ItemTemplate>
                                                                <div class="StringTruncate"><%# Functions.DateDiffInWords(Eval("Activity_Date"))%></div>
                                                                <asp:HiddenField runat="server" ID="hdnDate" Value='<%# Eval("Activity_Date", "{0:yyyy-MM-dd HH:mm:ss}")%>' />
                                                            </ItemTemplate>
                                                            <ItemStyle Width="90px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Last Updated" HeaderStyle-Width="90px" SortExpression="LastUpdatedOn">
                                                            <ItemTemplate>
                                                                <div class="StringTruncate"><%# Functions.DateDiffInWords(Eval("LastUpdatedOn"))%></div>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="90px" />
                                                        </asp:TemplateField>
                                                    </Columns>

                                                </asp:GridView>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="ddlFranchises" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="ddlTopics" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="ddlAssignedByNames" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="ddlWaitingForNames" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="ddlFilters" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="ddlClient" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="ddlPriority" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                                                <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </div>
                                </td>
                            </tr>
                            <tr id="trPager" style="display: none;">
                                <td id="tdPager" colspan="2"></td>
                            </tr>
                            <%--Activities--%>
                            <tr class="HeaderRow">
                                <td style="height: 20px; font-size: 12px; font-weight: bold; background-color: #A0CDEE; border-bottom: 1px solid #609BD3; border-top: 1px solid #609BD3; padding-left: 5px;">
                                    <asp:UpdatePanel ID="updatepnlActivities" runat="server" UpdateMode="Always" RenderMode="Inline">
                                        <ContentTemplate>
                                            Activities&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label runat="server" ID="lblActvityFilter" />
                                            &nbsp;<span class="NonBold">(<asp:Label runat="server" ID="lblActivityCountFiltered" Text="all" />)</span>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlFranchises" EventName="SelectedIndexChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="ddlTopics" EventName="SelectedIndexChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="ddlAssignedByNames" EventName="SelectedIndexChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="ddlWaitingForNames" EventName="SelectedIndexChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="ddlFilters" EventName="SelectedIndexChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="ddlClient" EventName="SelectedIndexChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="ddlPriority" EventName="SelectedIndexChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                                            <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>

                            </tr>
                            <tr>
                                <td style="height: 50%;" colspan="2">
                                    <asp:ObjectDataSource ID="odsActivity" runat="server"
                                        SelectMethod="GetAdminInboxForHelpDesk_ByClientIdList"
                                        SelectCountMethod="GetAdminInboxForHelpDeskcount_ByClientIdList"
                                        EnablePaging="true"
                                        SortParameterName="sortExpression"
                                        TypeName="Portal.BLL.Activities">
                                        <SelectParameters>
                                            <asp:ControlParameter Name="FranchiseID" Type="Int32" ControlID="ddlFranchises" PropertyName="SelectedValue" DefaultValue="0" />
                                            <asp:ControlParameter Name="TopicID" Type="Int32" ControlID="ddlTopics" PropertyName="SelectedValue" DefaultValue="0" />
                                            <asp:ControlParameter Name="AssingedBy" Type="String" ControlID="ddlAssignedByNames" PropertyName="SelectedValue" DefaultValue="" />
                                            <asp:ControlParameter Name="WaitingFor" Type="String" ControlID="ddlWaitingForNames" PropertyName="SelectedValue" DefaultValue="" />
                                            <asp:ControlParameter Name="Filter" Type="String" ControlID="ddlFilters" PropertyName="SelectedValue" DefaultValue="" />
                                            <asp:ControlParameter Name="ClientID" Type="String" ControlID="ddlClient" PropertyName="SelectedValue" DefaultValue="1" />
                                            <asp:ControlParameter Name="PriorityID" Type="Int32" ControlID="ddlPriority" PropertyName="SelectedValue" DefaultValue="0" />
                                            <asp:ControlParameter Name="Search" Type="String" ControlID="txtSearch" PropertyName="Text" DefaultValue="" />
                                            <asp:Parameter Name="ReturnValue" Type="Int32" Direction="Output" />
                                            <asp:ControlParameter ControlID="hdnClientIDList" Name="ClientIDList" PropertyName="Value" Type="String" />
                                            <asp:ControlParameter Name="TicketType" Type="String" ControlID="hdnActivityType"/>
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                    <div style="overflow: auto; height: 100%; background-color: #E4F1F7; border: 1px solid #ACBDD5;"
                                        id="Div1" class="ScrollBarHomeTicket">
                                        <asp:UpdatePanel ID="updatepnlActivities2" runat="server" UpdateMode="Always" RenderMode="Inline">
                                            <ContentTemplate>
                                                <asp:GridView ID="GV_Activity"  runat="server" AutoGenerateColumns="False" EnableViewState="False"
                                                    DataSourceID="odsActivity" AllowPaging="true" SkinID="gvwSilverHelpDesk3" ShowFooter="true"
                                                    Height="100%" Width="100%">
                                                    <Columns>
                                                        <asp:TemplateField HeaderStyle-Width="28px">
                                                            <ItemTemplate>
                                                                <img title='<%# Functions.getActivityCaption(Eval("Activity_Type"))%>' src='<%= ConfigurationManager.AppSettings("ImagesURL") %><%# Functions.GetActivityImage(Eval("Activity_Type")) %>' />
                                                            </ItemTemplate>
                                                            <ItemStyle Width="28px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderStyle-Width="65px" HeaderText="Tkt #" SortExpression="Ticket">
                                                            <ItemTemplate><%# Functions.GetActivityPrefix(Eval("Activity_Type")) &  Eval("Activity_ID")%></ItemTemplate>
                                                            <ItemStyle Width="65px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderStyle-Width="150px" HeaderText="Store #" SortExpression="StoreNumber">
                                                            <ItemTemplate><%#Functions.StringTruncate(Eval("StoreNick") & " - " & Eval("StoreNumber"), 25)%></ItemTemplate>
                                                            <ItemStyle Width="150px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Client" HeaderStyle-Width="40px" ItemStyle-HorizontalAlign="Center" SortExpression="ClientCode">
                                                            <ItemTemplate><%# Eval("ClientCode")%></ItemTemplate>
                                                            <ItemStyle Width="40px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderStyle-Width="190px" HeaderText="Subject" SortExpression="Subject">
                                                            <ItemTemplate><%#Functions.StringTruncate(Functions.IfNull(Eval("Subject"), ""), 30)%></ItemTemplate>
                                                            <ItemStyle Width="190px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Status" SortExpression="Status">
                                                            <ItemTemplate><%# Eval("ActivityStateText").Replace("Waiting For","WF") & IIf(Eval("ActivityState") = 4, ":" & Functions.StringTruncate(Functions.IfNull(Eval("WaitingForName"), ""), 15), "") %></ItemTemplate>
                                                            <ItemStyle Width="100px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderStyle-Width="90px" HeaderText="Created" SortExpression="Date">
                                                            <ItemTemplate>
                                                                <div class="StringTruncate"><%# Functions.DateDiffInWords(Eval("Activity_Date"))%></div>
                                                                <asp:HiddenField runat="server" ID="hdnDate" Value='<%# Eval("Activity_Date", "{0:yyyy-MM-dd HH:mm:ss}")%>' />
                                                            </ItemTemplate>
                                                            <ItemStyle Width="90px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Last Updated" HeaderStyle-Width="90px" SortExpression="LastUpdatedOn">
                                                            <ItemTemplate>
                                                                <div class="StringTruncate"><%# Functions.DateDiffInWords(Eval("LastUpdatedOn"))%></div>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="90px" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="ddlFranchises" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="ddlTopics" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="ddlAssignedByNames" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="ddlWaitingForNames" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="ddlFilters" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="ddlClient" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="ddlPriority" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                                                <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </div>
                                </td>
                            </tr>
                            <tr id="trPager1">
                                <td id="tdPager1" colspan="2"></td>
                            </tr>

                           <%-- <tr>
                                <td style="height: 5px; padding: 2px; padding-right: 10px; background-color: #BADCFC;" align="right" class="GrayHeader" colspan="2">Status:&nbsp;
                                <span style="background-color: #FFFFFF; width: 12; border: outset 1px #EFF5FE;"></span>&nbsp;Read
                                <span style="background-color: #FFFFCC; width: 12; border: outset 1px #EFF5FE;"></span>&nbsp;UnRead
                                </td>
                            </tr>--%>
                        </table>
                    </td>
                </tr>
              <%--  <tr style="background-color: #BADCFC">
                    <td align="left" id="CustomPagerRow" style="height: 25px;">&nbsp;</td>
                    <td style="text-align: right; padding-left: 40%;">
                        <table cellpadding="0" cellspacing="0" border="0" class="GrayHeader" style="width: 100%;">
                            <tr>
                                <td>&nbsp;</td>
                                <td style="padding-left: 5px; width: 100%;">
                                    <span style="background-color: #ff0000; width: 12; border: outset 1px #FFFFFF;"></span>&nbsp;Priority
				    <span style="background-color: #FFFFFF; width: 12; border: outset 1px #FFFFFF;"></span>&nbsp;Low
					<span style="background-color: #FFF200; width: 12; border: outset 1px #FFF200;"></span>&nbsp;Minimal
					<span style="background-color: #FF7F27; width: 12; border: outset 1px #FF7F27;"></span>&nbsp;Moderate
					<span style="background-color: #FFEBCC; width: 12; border: outset 1px #FFEBCC;"></span>&nbsp;High
					<span style="background-color: #880015; width: 12; border: outset 1px #880015;"></span>&nbsp;Critical
                    <span style="background-color: #CB0104; width: 12; border: outset 1px #CB0104;"></span>&nbsp;Delayed
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>--%>
	</table>
	</div>
</form>
    <script type="text/javascript" language="javascript">

        function OpenTicketsExportToExcel() {
  
            var FranchiseID = document.getElementById('<%= ddlFranchises.ClientID %>').value;
            var ddlTopics = document.getElementById('<%= ddlTopics.ClientID %>').value;
            var AssingedBy = document.getElementById('<%= ddlAssignedByNames.ClientID %>').value;
            var ddlWaitingForNames = document.getElementById('<%= ddlWaitingForNames.ClientID %>').value;
            var ddlPriority = document.getElementById('<%= ddlPriority.ClientID %>').value;
            var ddlFilters = document.getElementById('<%= ddlFilters.ClientID %>').value;            // assigned or unassigned. 
            var ClientID = document.getElementById('<%= ddlClient.ClientID %>').value;
            var PriorityID = document.getElementById('<%= ddlPriority.ClientID %>').value;
            var Search = document.getElementById('<%= hdnSearch.ClientID %>').value;
            window.open('ExcelGeneration.ashx?Action=' + "FranchseeOpenTickets" + '&FranchiseID=' + FranchiseID + '&ddlTopics=' + ddlTopics + '&AssingedBy=' + AssingedBy + '&ddlWaitingForNames=' + ddlWaitingForNames + '&ddlPriority=' + ddlPriority + '&ddlFilters=' + ddlFilters + '&ClientID=' + ClientID + '&PriorityID=' + PriorityID + '&Search=' + Search );
            return false;
        }

        function resetFilters() {
		var item;
		if (item = document.getElementById('<%= txtSearch.ClientID %>')) {
			item.value = '';
		}
		if (item = document.getElementById('<%= ddlFilters.ClientID %>')) {
			item.value = -1;
		}
		if (item = document.getElementById('<%= ddlFranchises.ClientID %>')) {
			item.value = '0';
		}
		if (item = document.getElementById('<%= ddlTopics.ClientID %>')) {
			item.value = '0';
		}
		if (item = document.getElementById('<%= ddlWaitingForNames.ClientID %>')) {
			item.value = '0';
		}
		if (item = document.getElementById('<%= ddlAssignedByNames.ClientID %>')) {
			item.value = '0';
		}
		if (item = document.getElementById('<%= ddlPriority.ClientID %>')) {
			item.value = '0';
		}
            return true;
        }

        var postbackElement;
        Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(beginRequest);
	Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(pageLoaded);
	
	function beginRequest(sender, args) {
		postbackElement = args.get_postBackElement();
	}
	
	function pageLoaded(sender, args) {
		var updatedPanels = args.get_panelsUpdated();
		if (typeof(postbackElement) === "undefined") {
                return;
            }
            for (i = 0; i < updatedPanels.length; i++) {
                if (updatedPanels[i].id == '<%= updatepnlHelpdesk2.ClientID %>') {
                    AdjustPagerRow();
                    AdjustPagerRow1();
                    $get('<%= hdnSearch.ClientID %>').value = $get('<%= txtSearch.ClientID %>').value;
                    $get('<%= txtSearch.ClientID %>').value = '';
                }
            }
        }



        window.onload = function start() {
            //CheckRowCount();
        }
        function ShowMessageAlert() {
            var DivMessageAlert = document.getElementById('DivMessageAlert');
            var x1 = document.body.offsetWidth;
            var y1 = document.body.offsetHeight;
            DivMessageAlert.style.width = '600px';
		DivMessageAlert.style.top = (y1/2) - 175;
		DivMessageAlert.style.left = (x1/2) - 305;
		DivMessageAlert.style.display = 'inline';
	}
  function SetPosition()
	{
	var divDisable = document.getElementById('divDisable') ;
	divDisable.style.width = document.body.scrollWidth
	divDisable.style.height = document.body.scrollHeight
	divDisable.style.display = 'block';
	}
  function Reset()
	{
		var divDisable = document.getElementById('divDisable') ;
		divDisable.style.width = 0;
		divDisable.style.height = 0;
		divDisable.style.display = 'none';
		DivMessageAlert.style.display = 'none';
		return false;
	}
	function CheckRowCount()
	{
	valtable = window.document.getElementById("tbsamplevalue");
	if(valtable.rows.length > 1){
		SetPosition();
		ShowMessageAlert();
		}
	else
		Reset();
	}
	function showToolTip(msg)
	{
		var obj = document.getElementById("divToolTip");
		obj.innerHTML = msg;
		obj.style.left = event.x - (obj.offsetWidth/2);
		obj.style.top = event.y + 20;
		obj.style.display = 'inline';
	}
	function hideToolTip()
	{
		var obj = document.getElementById("divToolTip");
		obj.style.display = "none";
	}
	function ToolTipSub(Subject, Initiated, TimeSpent, Priority) {
		var msg = 'Subject: ' + Subject + '<br />Initiated By: ' + Initiated + '<br />TimeSpent: ' + TimeSpent + '<br />Priority: ' + Priority;
		var obj = document.getElementById("divToolTip");		
		obj.innerHTML = msg;
		obj.style.left = event.x - (obj.offsetWidth / 2);
		obj.style.top = event.y + 20;
		obj.style.display = 'inline';
	}
	function ToolTipSta(Status) {
		var msg = 'Status: <br />' + Status;
		var obj = document.getElementById("divToolTip");
		obj.innerHTML = msg;
		obj.style.left = event.x - (obj.offsetWidth / 2);
		obj.style.top = event.y + 20;
		obj.style.display = 'inline';
	}
	function ToolTipCre(Date) {
		var msg = 'Created Date: <br />' + Date;
		var obj = document.getElementById("divToolTip");
		obj.innerHTML = msg;
		obj.style.left = event.x - (obj.offsetWidth / 2);
		obj.style.top = event.y + 20;
		obj.style.display = 'inline';
	}
	function ToolTipUpd(Date) {
		var msg = 'Last Updated On:<br />' + Date;
		var obj = document.getElementById("divToolTip");
		obj.innerHTML = msg;
		obj.style.left = event.x - (obj.offsetWidth / 2);
		obj.style.top = event.y + 20;
		obj.style.display = 'inline';
	}
	function RowClick(ID, ClientID, FranchiseID) {
	    var FilterID = document.getElementById('<%= ddlFilters.ClientID %>').value;	    
	    var AssignedByNamesID = document.getElementById('<%= ddlAssignedByNames.ClientID %>').value;
	    var WaitingForNamesID = document.getElementById('<%= ddlWaitingForNames.ClientID %>').value;
	    var PriorityID = document.getElementById('<%= ddlPriority.ClientID %>').value;
	    var TopicID = document.getElementById('<%= ddlTopics.ClientID %>').value;
	    var ddlFranchises = document.getElementById('<%= ddlFranchises.ClientID %>').value;
	    var search = document.getElementById('<%= hdnSearch.ClientID %>').value;
	    var PageIndex = document.getElementById('<%= hdnPageIndex.ClientID %>').value;
	    window.location = 'ActivityDetail.aspx?ID=' + ID + '&PrevPage=4&ClientID=' + ClientID + '&FranchiseID=' + FranchiseID + '&FilterID=' + FilterID + '&AssignedByNamesID=' + AssignedByNamesID + '&WaitingForNamesID=' + WaitingForNamesID + '&PriorityID=' + PriorityID + '&TopicID=' + TopicID + '&ddlFranchises=' + ddlFranchises + '&search=' + search + '&pageindex=' + PageIndex;
		return false;
	}
        function RowOver(row) {
            //row.className = 'HighlightedHomeRow';
        }
       
        function RowOut(row, cssclass) {
            
            //if (cssclass == "RedNewInbox")
            //    row.className = 'RedRowNewInbox';
            //else if (cssclass == "RedInbox")
            //    row.className = 'RedRowInbox';
            //else if (cssclass == "GreenInbox")
            //    row.className = 'GreenRowInbox';
            //else if (cssclass == "YellowInbox")
            //    row.className = 'YellowRowInbox';
            //else if (cssclass == "OrangeInbox")
            //    row.className = 'OrangeRowInbox';
            //else if (cssclass == "SimpleHome")
            //    row.className = 'SimpleHomeRow';
            //else if (cssclass == 'BlueInstallationInbox')
            //    row.className = 'BlueInstallationRowInbox';
            //else if (cssclass == 'GreenOrderInbox')
            //    row.className = 'GreenOrderRowInbox';
            //else if (cssclass == 'RedInboxCritical')
            //    row.className = 'RedRowInboxCritical';
            //else
              //  row.className = 'SimpleHomeRow';

            hideToolTip();
        }


        AdjustPagerRow();
        function AdjustPagerRow() {

            var objTag = null;
            var objCustomRow = null;
            try {

                objCustomRow = getElement("tdPager");
                objTag = getElementByClassName("gvwSilverPager");
                objCustomRow.innerHTML = '&nbsp;';
                if (objTag != null && objCustomRow != null) {
                    var objPagerHTML = getElement('tblPager').outerHTML;
                    objCustomRow.innerHTML = objPagerHTML;
                    objCustomRow.className = "cpygvwSilverPager";
                    objTag.style.display = 'none';
                    trPager.style.display = 'inline';
                }
                else {
                    //if the pager has not been displayed hide the row.
                    trPager.style.display = 'none';
                }
            } catch (ex) {
                alert("Javascript Error:\n" + ex.description);
            }
        }


        AdjustPagerRow1();

        function AdjustPagerRow1() {

            var objTag = null;
            var objCustomRow = null;
            try {
                trPager1.style.display = 'inline';
                objCustomRow = getElement("tdPager1");
                objTag = getElementByClassName("gvwSilverPager1");
                objCustomRow.innerHTML = '&nbsp;';
                if (objTag != null && objCustomRow != null) {
                    var objPagerHTML = getElement('tblPager1').outerHTML;
                    objCustomRow.innerHTML = objPagerHTML;
                    objCustomRow.className = "cpygvwSilverPager1";
                    objTag.style.display = 'none';
                }
                else {
                    //if the pager has not been displayed hide the row.
                    trPager1.style.display = 'none';
                }
            } catch (ex) {
                alert("Javascript Error:\n" + ex.description);
            }
        }

       
    </script>
</body>
</html>