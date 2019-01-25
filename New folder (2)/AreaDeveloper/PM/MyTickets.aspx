<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MyTickets.aspx.vb" Inherits="PM_MyTickets"  Theme="Default" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
	<title></title>
	<link href="../../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" language="javascript" src="../../scripts/functions.js"></script>	
	<script src="../../scripts/jquery.js" type="text/javascript"></script>
	<meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=0.2)" />
	<meta http-equiv="Page-Enter" content="progid:DXImageTransform.Microsoft.Fade(Duration=0.2)" />
</head>
<body  style ="margin :0px;background-color:#E4F1F7;" onresize="AdjustHeight();">
	<form id="form1" runat="server">
	<div>
	<asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="300"  />
	<asp:UpdateProgress ID="Progress1" runat="server">
			<ProgressTemplate>
				<div class="ProgressIndicatorDIV" >
					<br />
					<asp:Image ID="Image2" runat="server" ImageUrl="~/images/indicator.gif" ImageAlign="AbsMiddle" /> <span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
					<br /><br />
				</div>
			</ProgressTemplate>
		</asp:UpdateProgress>
	<table width="100%" style="height:100%; margin:0px; padding:0px;background-color:#E4F1F7; " cellspacing="0" cellpadding = "0" border="0">
			 <tr class="UnderlinedRow" style="height:30px;">
				 <td  style="background-color:#A0CDEE;font-size:12px;font-weight:bold;width:50%;">
					<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
						<ContentTemplate>
							<span style="font-family:Arial;font-size:12px;font-weight:bold;padding-left:3px;">My Tickets  |  <asp:Label runat="server" ID="lblErrorCount" />&nbsp;(<asp:Label runat="server" ID="lblFilter" Text="all" class="NonBold" />)</span>
						</ContentTemplate>
						<Triggers >
							  <asp:AsyncPostBackTrigger ControlID="ddlCategories" EventName="SelectedIndexChanged" />
							  <asp:AsyncPostBackTrigger ControlID="ddlFilter" EventName="SelectedIndexChanged" />
							  <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
							  <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
						</Triggers>
					</asp:UpdatePanel>
				</td>
				 <td style="background-color:#A0CDEE;padding:3px;text-align:right;">
					 <asp:LinkButton ID="lnkResetFilters" runat="server" CssClass="HomeButton">
						<div style="width:110px;" class="LeadDetailButton" onClick="javascript:resetFilters();">
							Reset Filters 
							<img id="Img1" runat="server" src="~/images/blt_resetFilters.gif" align="absmiddle" width="10" height="10" style="border:0px;"/>
						</div>
					 </asp:LinkButton>
				 </td>
			 </tr>
			 <tr>
				<td colspan="2" style="height:40px;background-color:#BADCFC;font-size:11px;">
				  <table border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
					  <td style="text-align:left; width: 100px; padding-left:3px; padding-right:3px; white-space:nowrap; padding-top:10px;">
						  <div class="LeadDetailButton" onClick="javascript:StateSaveNewTicket();"
							  style="width: 100px">
								New Ticket <img id="Img2" align="absMiddle"  height="10" src="~/images/blt_resetFilters.gif" runat="server" width="10" />
						  </div>
					  </td>
					  <td style="width:10px;text-align:center;">
						 <img id="Img3" runat="server" src="~/images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
					  </td>
					  <td align="left" style="width:100px; ">
						<span style="font-size: 7pt; color: #7c8798">Categories</span><br />
						  <asp:DropDownList ID="ddlCategories" runat="server" 
								SkinID="SmallTextCombo"
								DataTextField="Name" 
								DataValueField="ID" 
								AutoPostBack="True"
								Width="100px"
								DataSourceID="SDS_Categories">
						  </asp:DropDownList>
						  <asp:SqlDataSource ID="SDS_Categories" 
								   runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
								   SelectCommand="PM_Categories_AreaDeveloper_GetAll" 
								   SelectCommandType="StoredProcedure"
								   DataSourceMode="DataReader">
								   <SelectParameters>
								        <asp:SessionParameter Name="AreaDeveloperID" SessionField="MyNetsolace_AreaDeveloperID" DefaultValue="0" />
								   </SelectParameters>
							   </asp:SqlDataSource>
						 </td>
						 <td style="width:10px;text-align:center;">
						   <img id="Img4" runat="server" src="~/images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" /> 
						  </td>
						  <td align="left" style="Width:100px;">
							  <span class="GrayHeader">Filter<br />
							  </span>
								<asp:DropDownList 
								ID="ddlFilter" 
								runat="server" 
								SkinID="SmallTextCombo"
								AutoPostBack="True" Width="100px">
							  </asp:DropDownList>
						   </td>
						  <td style="width:10px;text-align:center;">
							   <img id="Img5" runat="server"  src="~/images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" /> 
						  </td>
						  <td style="white-space:nowrap;" align="left">
							<asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" >
							   <span class="GreyTextSmall">Search</span><br />
								<span><asp:TextBox ID="txtSearch" runat="server" onfocus="javascript:this.value='';" MaxLength="50"   Width="100px"  SkinID="GreenSmallTextbox" style="vertical-align:top;" />
								<asp:ImageButton ID="btnSearch"  runat="server" ImageUrl="~/images/btn_go.gif" />
								</span>
							</asp:Panel>
						  </td>
						   <td style="width:40%;"></td>
				   </tr>
				 </table>
			   </td>
			 </tr>
			 <tr>
			   <td  colspan="2" style="background-color:#E4F1F7;margin:0px;padding:0px; vertical-align:top;">
					<div style="overflow:auto;height:100%;background-color:#E4F1F7;border:1px solid #ACBDD5;" id="_gridViewPanel1"  class="ScrollBarHomeTicket">
					  <asp:UpdatePanel ID="UpdatePanel2"
						 runat="server" 
						 UpdateMode="Always"
						 RenderMode="Inline">
								  <Triggers >
								  <asp:AsyncPostBackTrigger ControlID="ddlCategories" EventName="SelectedIndexChanged" />
								  <asp:AsyncPostBackTrigger ControlID="ddlFilter" EventName="SelectedIndexChanged" />
								  <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
								  <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
								  </Triggers>
						  <ContentTemplate>
						<asp:GridView ID="gvReleases" runat="server" AllowSorting="True" AutoGenerateColumns="False"
							DataKeyNames="ID,ReleaseID" DataSourceID="odsMyTickets" EnableTheming="True" SkinID="GridViewNormal" OnRowCreated="gvReleases_RowCreated" OnRowDataBound="gvReleases_RowDataBound" EnableViewState="false">
							 <PagerSettings Mode="Numeric" Position="Bottom" />
							 <PagerTemplate>
								  <div style="width:100%; border:0px black solid;" >
									  <table width="100%" border="0" cellpadding="0" cellspacing="0"  style="height:20px;">
										   <tr style="text-align:left;">
												 <td style="width:20%; white-space:nowrap;" align="left"  valign="middle" >
												   <span class="DarkBlueTextSmall" style="font-size:10px" >&nbsp; Page <asp:Literal id="litPageNumber" runat="server"/> of <asp:Literal id="litTotalPages"  runat="server"/></span>
												 </td>
												 <td style="width:10px; " align="right" ><img id="Img6" alt="" runat="server" src="~/images/spacer.gif" width="15" height="1" align="absmiddle" /></td>
												 <td style="width:1px; " align="center"><img id="Img7" alt="" runat="server" src="~/images/pixel_darkBlue.jpg" width="1" height="20" align="absmiddle" /></td>
												 <td style="width:10px;" align="right"><img id="Img8" alt="" runat="server" src="~/images/spacer.gif" width="15" height="1" align="absmiddle" /></td>
												 <td  align="right" valign="top"> <asp:Panel ID="pnlNumber" runat="server" HorizontalAlign="Right"  ></asp:Panel> </td>
											</tr>
									  </table>  
								  </div>
							  </PagerTemplate> 
							<Columns>
								<asp:TemplateField HeaderText="^"  HeaderStyle-HorizontalAlign="Center"  HeaderStyle-Font-Bold="true" SortExpression="Priority" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" >
									<ItemTemplate>
										<img  src="../../images/pm_flag.gif"  style='<%#  IIf(CType(Container.DataItem, Data.DataRowView)("Status")  = "Confirm Solved" Or CType(Container.DataItem, Data.DataRowView)("Status")  = "Feedback Requested", "display:inline", "display:none") %>'  />
										<img src='<%= ConfigurationManager.AppSettings("ImagesURL") %><%#Ctype(Container.Dataitem,Data.DataRowView)("Priority") %>'  />
									</ItemTemplate>
									<ItemStyle Width="2%" />
								</asp:TemplateField> 
								<asp:TemplateField HeaderText="Ref #" SortExpression="RefNo">
									<ItemTemplate><span><%#CType(Container.DataItem, Data.DataRowView)("RefNo")%></span></ItemTemplate>
									 <ItemStyle Width="5%" Wrap="false" HorizontalAlign="Center" Font-Bold="true" />
									 <HeaderStyle Wrap="false" HorizontalAlign="Center" />
								</asp:TemplateField>    
								 <asp:TemplateField HeaderText="Name" SortExpression="Name" HeaderStyle-Wrap="false" >
									<ItemTemplate>
										<span title='<%#CType(Container.DataItem, Data.DataRowView)("Name")%>'><%#Functions.StringTruncate(Server.HtmlEncode(Functions.IfNull(CType(Container.DataItem, Data.DataRowView)("Name"), "")), 30)%></span>
									</ItemTemplate>
									 <ItemStyle Width="25%" Wrap="false"  />
								</asp:TemplateField>
								 <asp:TemplateField HeaderText="Status" SortExpression="Status" HeaderStyle-Wrap="false">
									<ItemTemplate>
										<span title='<%#IIf(Ctype(Container.Dataitem,Data.DataRowView)("Status") = "QA Phase","Developement Phase",Ctype(Container.Dataitem,Data.DataRowView)("Status"))%>'>
        										<%# IIF(Ctype(Container.Dataitem,Data.DataRowView)("Status") = "QA Phase","Development Phase",Ctype(Container.Dataitem,Data.DataRowView)("Status"))%>
									    </span>
									</ItemTemplate>
									<ItemStyle Wrap="false" Width="10%"  />
								</asp:TemplateField>
								<asp:BoundField DataField="CategoryName" HeaderText="Category" SortExpression="CatagoryName" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderStyle-Width="10%" />
								<asp:BoundField Visible="false" DataField="DueDate" HeaderText="Due Date" SortExpression="DueDate" DataFormatString="{0:d}" HtmlEncode="False" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderStyle-Width="10%" />
								<asp:TemplateField HeaderText="Due Date" SortExpression="DueDate" HeaderStyle-Wrap="false">
									<ItemTemplate>
									</ItemTemplate><ItemStyle Wrap="false" Width="5%"/>
								</asp:TemplateField>
								<asp:BoundField DataField="LastUpdatedMyNetsolace" HeaderText="Last Updated" SortExpression="LastUpdatedMyNetsolace" DataFormatString="{0:MM/dd/yyyy hh:mm tt}" HtmlEncode="False" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderStyle-Width="10%" />
							</Columns>
						</asp:GridView>
						  </ContentTemplate>
							</asp:UpdatePanel>
						<asp:ObjectDataSource ID="odsMyTickets" 
							runat="server"
							SortParameterName="sortExpression"
							MaximumRowsParameterName="MaximumRows"
							StartRowIndexParameterName="StartRowIndex"
							SelectMethod="PM_MYTicketGetAllForMyNetsolaceCorporate"
							EnablePaging="true" 
							SelectCountMethod="PM_MYTicketGetAllCountForMyNetsolaceCorporate" 
							TypeName="Portal.BLL.PM.PM_Ticket_Features">
							<SelectParameters>
								<asp:SessionParameter SessionField="MyNetsolace_ClientID" Name="ClientID" Type="Int32" />
								<asp:ControlParameter ControlID="ddlCategories" DefaultValue="1" Name="CategoryID" PropertyName="SelectedValue" Type="Int32" />
								<asp:ControlParameter ControlID="ddlFilter" DefaultValue="0" Name="FilterID" PropertyName="SelectedValue" Type="Int32" />
								<asp:ControlParameter ControlID="txtsearch" DefaultValue="" Name="txtsearch" PropertyName="Text" Type="String" />								
								<asp:Parameter DefaultValue="0" Name="ClientStatusId" Type="Int16" />
								<asp:SessionParameter SessionField="MyNetsolace_AreaDeveloperID" Type="Int32" Name="AreaDeveloperID" />
							</SelectParameters>
						</asp:ObjectDataSource>
					</div>
				   
			   </td>
			 </tr>
			 <tr style="height:20px; background-color:#BADCFC;">
				<td align="left"  style="width:70%;" id="CustomPagerRow"></td>
				<td align="left" style="width:30%;" class="GrayHeader">
					<span style="font-size:7pt; color: #ff0000">*</span>
					UnRead Tickets & Features are in Yellow Color<br />
					<span style="font-size:7pt; color: #ff0000; height:7px;"><img  src="../../images/pm_flag.gif" height="7"  alt="*"/></span>
					Tickets that requires your attention
				</td>
			 </tr>
			</table>
	</div>
	</form>
	<script type="text/javascript" language="javascript">

	    AdjustHeight();
	    function AdjustHeight() {
	        var client_height = $(window).height() - 95;
	        $('#_gridViewPanel1').attr('style', 'height:' + client_height + 'px;overflow:auto;background-color:#E4F1F7;border:1px solid #ACBDD5;');
	    }
	
	    function resetFilters() {
	        var item;
	        if (item = document.getElementById('<%= txtSearch.ClientID %>')) {
	            item.value = '';
	        }
	        if (item = document.getElementById('<%= ddlCategories.ClientID %>')) {
	            item.value = 0;
	        }
	        if (item = document.getElementById('<%= ddlFilter.ClientID %>')) {
	            item.value = 0;
	        }
	        return true;
	    }
	    //These Mothods are used to Enable pagging on a TD and Also Empty txtSearch
	    function AdjustPagerRow() {
	        var objTag = null;
	        var objCustomRow = null;
	        try {
	            objCustomRow = getElement("CustomPagerRow");
	            objTag = getElementByClassName('FloatingPager');
	            objCustomRow.innerHTML = '&nbsp;';
	            if (objTag != null && objCustomRow != null) {
	                objTag.style.display = 'none';
	                objCustomRow.innerHTML = "<table cellpadding=0 cellspacing=0 align='left' height='18' ><tr class='cpyFloatingPager'>" + objTag.innerHTML + "</tr></table>";
	            }
	        } catch (ex) {
	            alert("Javascript Error:\n" + ex.description);
	        }
	    }
	    AdjustPagerRow();

	    var postbackElement;
	    Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(beginRequest);
	    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(pageLoaded);

	    function beginRequest(sender, args) {
	        postbackElement = args.get_postBackElement();
	    }
	    function pageLoaded(sender, args) {
	        var updatedPanels = args.get_panelsUpdated();
	        if (typeof (postbackElement) === "undefined") {
	            return;
	        }
	        for (i = 0; i < updatedPanels.length; i++) {
	            if (updatedPanels[i].id == '<%= UpdatePanel2.ClientID %>') {
	                AdjustPagerRow();
	                $get('<%= txtSearch.ClientID %>').value = '';
	            }
	        }
	    }
	    //These Mothods are used to Enable pagging on a TD and Also Empty txtSearch
	    function StateSaveNewTicket() {
	        var URL
	        var QueryStringValues = "?txtSearch=" + document.getElementById("<%=txtSearch.ClientID%>").value;
	        QueryStringValues += "&ddlCategories=" + document.getElementById('<%=ddlCategories.ClientID %>').value;
	        QueryStringValues += "&ddlFilter=" + document.getElementById('<%=ddlFilter.ClientID %>').value;
	        QueryStringValues += "&PrevPage=4"
	        URL = "TicketsNew.aspx" + QueryStringValues;
	        window.location = URL;
	    }
	    function OnRowClick(ReleaseID, ID) {
	        var URL
	        var QueryStringValues = "?ReleaseID=" + ReleaseID
	        QueryStringValues += "&ID=" + ID;
	        QueryStringValues += "&ddlCategories=" + document.getElementById('<%=ddlCategories.ClientID %>').value;
	        QueryStringValues += "&ddlFilter=" + document.getElementById('<%=ddlFilter.ClientID %>').value;
	        QueryStringValues += "&txtSearch=" + document.getElementById('<%=txtSearch.ClientID %>').value;
	        QueryStringValues += "&PrevPage=3"
	        URL = "TicketsDetail.aspx" + QueryStringValues;
	        window.location = URL;
	    }
</script>
</body>
</html>