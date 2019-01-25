<%@ Page Language="VB" AutoEventWireup="false"  ValidateRequest="false" CodeFile="Franchise_Inbox.aspx.vb" Inherits="Com_Fran_Inbox" Theme="Default" %>
<%@ Register Src="VitalInformationFloatingDiv.ascx" TagName="VitalInformationFloatingDiv"
	TagPrefix="CsCtrl" %> 
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title>Open Actvities</title>
	<link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" language="javascript" src="../scripts/functions.js" ></script>
    <style>
        .orangeRow {
            
        }
    </style>
</head>
<body style ="margin :0px;background-color:#E4F1F7;"  >
	<form id="form1" runat="server">
	<asp:HiddenField ID="hdnHasSupportAccess" runat="server" Value="False" />
	<iframe id="divDisable" marginheight="0" marginwidth="0" scrolling="no" frameborder="0" style="display:none;z-index:09;width:0;height:0;position:absolute;filter:progid:DXImageTransform.Microsoft.alpha(opacity=50);opacity:0.5;"src="../BlankPage.htm"></iframe>
	<div>
	<asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="300"  />
		<asp:UpdateProgress ID="Progress1" runat="server">
			<ProgressTemplate>
				<div class="ProgressIndicatorDIV" >
					<br />
					<asp:Image ID="Image2" runat="server" ImageUrl="../images/indicator.gif" ImageAlign="AbsMiddle" /> <span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
					<br /><br />
				</div>
			</ProgressTemplate>
		</asp:UpdateProgress> 
		<table style="width:100%;height:100%;background-color:#BADCFC;" border="0" cellspacing="0" cellpadding="0"  class="MainTable">
		  <tr>
		   <td style="width:27px;">
		   <asp:UpdatePanel ID="update1" runat="server" UpdateMode="Always" RenderMode="Block" >
			 <ContentTemplate>  
				<CsCtrl:VitalInformationFloatingDiv ID="VitalInformationFloatingDiv" runat="server" />
			 </ContentTemplate>
		   </asp:UpdatePanel>
		   </td>
		   <td style="padding:5px;" onclick="if (blnShowed == true){showHideVital();}"> 
				<table width="100%" style="height:100%; margin:0px; padding:0px;background-color:#E4F1F7; border:solid 1px #6298D0; " cellspacing="0" cellpadding = "0" border="0"  >
					 <tr class="UnderlinedRow">
						 <td  colspan="3" style="height:20px;background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:5px;width:60%;">
						  <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
						   <ContentTemplate>
							 Actvities (&nbsp;<asp:Label runat="server" ID="lblFranchiseName" />&nbsp;)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label runat="server" ID="lblActivityCount" />
									&nbsp;<span class="NonBold">(<asp:Label runat="server" ID="lblFilter" Text="all" />)</span>
									&nbsp;<img align="absMiddle"  height="20" src="../images/pixel_skyBlue.jpg" width="1" alt="" /><img align="absMiddle"  height="20" src="../images/pixel_skyBlue.JPG" width="1" alt="" />
								 &nbsp; 
								[&nbsp;<asp:Label ID="lblClient" runat="server" Text="" ></asp:Label>&nbsp;]&nbsp;
							<asp:HiddenField ID="hdnFranchiseID" runat="server" Value="0" />
							<asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
							<asp:HiddenField ID="hdnStoreID" runat="server" Value="0" />
							<asp:HiddenField ID="hdnOwnerID" runat="server" Value="0" />
							<asp:HiddenField ID="hdnFranStatus" runat="server" Value="0" />
							<asp:HiddenField ID="hdnFranIsSuspendedOrAbandon" runat="server" Value="0" />
							</ContentTemplate>
								<Triggers >
									  <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
								</Triggers>
							</asp:UpdatePanel>
						</td>
						 <td style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right;cursor:pointer; height: 1px;border-bottom:1 solid #609BD3;width:40%;">   
							<img align="absMiddle"  height="20" src="../images/pixel_skyBlue.jpg" width="1" alt="" /><img align="absMiddle"  height="20" src="../images/pixel_skyBlue.JPG" width="1" alt="" />
							 &nbsp;
							 <asp:LinkButton ID="btnNewActivity" runat="server" CssClass="HomeButton">
								<div style="width:110px;" class="LeadDetailButton" onclick="javascript:window.location='AddActivity.aspx?FranchiseID=<%= Request.QueryString("FranchiseID").ToString() %>&ClientID=<%= Request.QueryString("ClientID").ToString() %>'; return false;">
									&nbsp;&nbsp; New Activity 
									<img  src="../images/blt_resetfilters.gif" align="absmiddle" width="10" height="10" style="border:0px;" alt="" />
								</div>
							 </asp:LinkButton> 
							 &nbsp;
							 <img align="absMiddle"  height="20" src="../images/pixel_skyBlue.jpg" width="1" alt="" /><img align="absMiddle"  height="20" src="../images/pixel_skyBlue.JPG" width="1" alt="" />
							 &nbsp; 
							 <asp:LinkButton ID="LinkButton1" runat="server" CssClass="HomeButton">
								<div style="width:110px;" class="LeadDetailButton" onclick="javascript:window.location='AddMessage.aspx?FranchiseID=<%= Request.QueryString("FranchiseID").ToString() %>&ClientID=<%= Request.QueryString("ClientID").ToString() %>'; return false;">
									&nbsp;&nbsp; New Message
									<img  src="../images/blt_resetfilters.gif" align="absmiddle" width="10" height="10" style="border:0px;" alt="" />
								</div>
							 </asp:LinkButton> 
						 </td>
					 </tr>
					 <tr>
						<td colspan="4" style="height:40px;background-color:#BADCFC;font-size:11px;">
						  <table border="0" cellpadding="0" cellspacing="0" width="100%" style="white-space:nowrap;">
							<tr>
							<td style="padding:3px;white-space:nowrap;" align="left">
							<asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
								<span class="GreyTextSmall">Search</span><br />
									<span><asp:TextBox ID="txtSearch" runat="server" onfocus="javascript:this.value='';" MaxLength="50"   Width="100px"  SkinID="GreenSmallTextbox" />
									<asp:ImageButton ID="btnSearch"  runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />
									<img align="absMiddle"  height="18" src="../images/pixel_skyBlue.JPG" width="1" alt="" />
									<asp:DropDownList ID="ddlFranchiseContact" 
										runat="server"
										DataSourceID="odsContacts"
										AutoPostBack="false" 
										DataTextField="Name"  
										CssClass="SmallGreenTextBox" 
										DataValueField="ID" Width="130px" >
									  </asp:DropDownList>
									 <asp:ObjectDataSource ID="odsContacts" runat="server"
										   OldValuesParameterFormatString="original_{0}"
										   SelectMethod="FranchisesContactByID"
										   TypeName="Portal.BLL.Franchises"> 
										   <SelectParameters>
												<asp:ControlParameter Name="ClientID" DefaultValue="1"  ControlID="hdnClientID" Type="int32" PropertyName="value" />
												<asp:ControlParameter  Name="FranchiseID" Type="Int32" ControlID="hdnFranchiseID" PropertyName="Value" />
										   </SelectParameters>
									  </asp:ObjectDataSource>
									  <div style="width:55px; height:23px;  " class="LeadDetailButton" onclick="Javascript:showContact();">
											 &nbsp;View&nbsp;
									  </div>
									  <img align="absMiddle"  height="23" src="../images/pixel_skyBlue.JPG" width="1" alt="" />
									 <div style="width:55px; height:23px; " class="LeadDetailButton" onclick="javascript:window.location='Franchise_History.aspx?FranchiseID=<%= Request.QueryString("FranchiseID").ToString() %>&ClientID=<%= Request.QueryString("ClientID").ToString() %>'; return false;">
									 History
									<%--<img  src="../images/blt_resetfilters.gif" align="absmiddle" width="10" height="10" style="border:0px; display:none;" alt="" />--%>
									</div>
									</span> 
									</asp:Panel>
								
							  </td>
							   <td id="tdCorpInfo" runat="server" style='width:50%;' align="right"  > 
									 <img align="absMiddle"  height="20" src="../images/pixel_skyBlue.JPG" width="1" alt="" />
										 &nbsp;  
									 <img id="OwnersList" src="../images/ico_owner_info.gif" align="absmiddle" onmouseover="this.src='../images/ico_owner_info_hover.gif';" onmouseout="this.src='../images/ico_owner_info.gif';" onclick="DivOptionDisplay();" style="cursor:pointer;" alt="Owner Info" />
									 &nbsp;
									 <img align="absMiddle" style="<%= IIF(CInt(hdnClientID.value) = 1 ,"display:inline;cursor:pointer;","display:none;") %>"  height="20" src="../images/pixel_skyBlue.JPG" width="1" alt="" />
										 &nbsp;
									 <img id="OwnerLogin" runat="server" visible="false" src="../images/ico_owner_login.gif" align="absmiddle" onmouseover="this.src='../images/ico_owner_login_hover.gif';" onmouseout="this.src='../images/ico_owner_login.gif';" style="cursor:pointer;" alt="owner login" /> 
										 &nbsp;
									 <img align="absMiddle" id="imgSeparator" visible="false"  height="20" runat="server" src="../images/pixel_skyBlue.JPG" style="cursor:pointer;" width="1" alt="" />
										  &nbsp;
									 <img id="StoreLogin" runat="server" visible="false" src="../images/ico_store_login.gif" align="absmiddle" onmouseover="this.src='../images/ico_store_login_hover.gif';" onmouseout="this.src='../images/ico_store_login.gif';" style="cursor:pointer;" alt="store login" />
							   </td>
						   </tr>
						 </table>
					   </td>
					 </tr>
					 <tr>
					   <td  colspan="4" style="background-color:#E4F1F7;margin:0px;padding:0px;">
							<div style="overflow:auto;height:100%;background-color:#E4F1F7;border:1px solid #ACBDD5;" id="_gridViewPanel1"  class="ScrollBarHomeTicket">
							  <asp:UpdatePanel ID="UpdatePanel2"
								 runat="server" 
								 UpdateMode="Always"
								 RenderMode="Inline">
								 <ContentTemplate>
								 <asp:GridView 
									ID="gvInbox" 
									runat="server" 
									AutoGenerateColumns="False" 
									EnableTheming="True" 
									EnableViewState="false"
									SkinID="GridViewNormal"
									AllowSorting="True" 
									DataSourceID="sdsInbox" > 
									<PagerSettings Mode="Numeric" Position="Bottom"  />
										<PagerTemplate>   
										  <div style="width:100%; border:0px black solid;" >
											  <table width="100%" border="0" cellpadding="0" cellspacing="0"  style="height:20px;">
												   <tr style="text-align:left;">
														 <td style="width:20%; white-space:nowrap;" align="left"  valign="middle" >
														   <span class="DarkBlueTextSmall" style="font-size:10px" >&nbsp; Page <asp:Literal id="litPageNumber" runat="server"/> of <asp:Literal id="litTotalPages"  runat="server"/></span>
														 </td>
														 <td style="width:10px; " align="right" ><img alt="" src="../images/spacer.gif" width="15" height="1" align="absmiddle" /></td>
														 <td style="width:1px; " align="center"><img alt="" src="../images/pixel_darkBlue.jpg" width="1" height="20" align="absmiddle" /></td>
														 <td style="width:10px;" align="right"><img alt="" src="../images/spacer.gif" width="15" height="1" align="absmiddle" /></td>
														 <td  align="right" valign="top"> <asp:Panel ID="pnlNumber" runat="server" HorizontalAlign="Right"  ></asp:Panel> </td>
													</tr>
											  </table>
										  </div>
									 </PagerTemplate>
									 <Columns>
											<asp:TemplateField ItemStyle-Width="4%" HeaderText="" >
											<ItemTemplate  >
												 <img src='<%# ConfigurationManager.AppSettings("ImagesURL") %><%# Functions.GetActivityImage(Eval("Activity_Type")) %>'  />&nbsp;
												 <asp:Label ID="lblID" runat="server" Visible="false" Text='<%#Eval("Activity_ID") %>' ></asp:Label>
												 <asp:Label ID="lblAdminReadStatus" runat="server" Visible="false" Text='<%#Eval("AdminReadStatus") %>' ></asp:Label>
												 <asp:Label runat="server" ID="lblIntType" Visible="false" Text='<%# Eval("ActivityState")%>' ></asp:Label>    
											</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField ItemStyle-Width="10%" HeaderText="Ticket #" SortExpression="Ticket">
											<ItemTemplate >
												<asp:Label runat="server" ID="lblTicketNumber" Text='<%# Functions.GetActivityPrefix(Eval("Activity_Type")) &  Eval("Activity_ID")%>' ></asp:Label>    
											</ItemTemplate>
											</asp:TemplateField> 
											<asp:TemplateField ItemStyle-Width="7%" HeaderText="Store #" SortExpression="StoreNumber">
											<ItemTemplate >
												<asp:Label runat="server" ID="lblStoreNumber" Text='<%# Eval("StoreNumber")%>' ></asp:Label>
											</ItemTemplate>
											</asp:TemplateField>  
											 <asp:TemplateField ItemStyle-Width="30%" HeaderText="Subject" SortExpression="Subject">
												<ItemTemplate >
												<span title='<%# Functions.IfNull(Eval("Subject"), "") %>' >
													<asp:Label runat="server" ID="lblSubject" Text='<%# Functions.StringTruncate(Functions.IfNull(Eval("Subject"), ""), 40) %>' ></asp:Label>
												</span>
												</ItemTemplate>
											</asp:TemplateField> 
											<asp:TemplateField ItemStyle-Width="20%" HeaderText="Status" SortExpression="Status">
												<ItemTemplate >
													<span title='<%# Eval("ActivityStateText") & IIf(Eval("ActivityState") = 4, ":" & Functions.StringTruncate(Functions.IfNull(Eval("WaitingForName"), ""), 100), "") %>' >
														<asp:Label runat="server" ID="lblstatus" Text='<%# Eval("ActivityStateText").Replace("Waiting For","WF") & IIf(Eval("ActivityState") = 4, ":" & Functions.StringTruncate(Functions.IfNull(Eval("WaitingForName"), ""), 15), "") %>' ></asp:Label>    
													</span>
												</ItemTemplate>
											</asp:TemplateField> 
											<asp:TemplateField ItemStyle-Width="15%" HeaderText="Created" SortExpression="Date">
												<ItemTemplate >
                                                    <div class="StringTruncate"><%# Functions.DateDiffInWords(Eval("Activity_Date"))%></div>
                                                    <asp:HiddenField runat="server" ID="hdnDate" Value='<%# Eval("Activity_Date", "{0:yyyy-MM-dd HH:mm:ss}")%>' />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Last Updated" ItemStyle-Width="20%" SortExpression="LastUpdatedOn" Visible="true" >
											   <ItemTemplate >
												   <asp:Label runat="server" ID="lblLastActivity" Text='<%# Functions.DateDiffInWords(Eval("LastUpdatedOn"))%>' ToolTip='<%#Eval("LastUpdatedOn") %>' ></asp:Label>
											   </ItemTemplate>
										   </asp:TemplateField> 
										</Columns>
									</asp:GridView>
									 </ContentTemplate>
										  <Triggers >    
										  <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
										  </Triggers>
									</asp:UpdatePanel>    
								   <asp:ObjectDataSource ID="sdsInbox" runat="server" 
											SelectMethod="GetFranchiseeInboxForHelpDesk"
											SelectCountMethod="GetFranchiseeInboxCountForHelpDesk" 
											EnablePaging="true"
											SortParameterName="sortExpression"
											TypeName="Portal.BLL.Activities">
											<SelectParameters>
											  <asp:ControlParameter  Name="ClientID" Type="Int32" ControlID="hdnClientID" PropertyName="Value" />    
											  <asp:ControlParameter  Name="FranchiseID" Type="Int32" ControlID="hdnFranchiseID" PropertyName="Value" />
											  <asp:ControlParameter  Name="Search" Type="String" ControlID="txtSearch" PropertyName="Text" DefaultValue=""  ConvertEmptyStringToNull="true"/>
											  <asp:Parameter  Name="ReturnValue" Type="Int32"  Direction="Output" />
											</SelectParameters>
									</asp:ObjectDataSource> 
							</div>
						   
					   </td>
					 </tr>  
			<tr>
			 <td style="background-color:#BADCFC; height:20px; padding:3px;" colspan="4" > 
			 <span style="font-weight:bold;font-family:Arial;font-size:12px;">History</span> 
			 </td>
			 </tr>
			  <tr>
			   <td  colspan="4" style="background-color:#E4F1F7;margin:0px;padding:0px;">
					<div style="overflow:auto;height:100%;background-color:#E4F1F7;border:1px solid #ACBDD5;" id="Div1" class="ScrollBarHomeTicket">
					  <asp:UpdatePanel ID="UpdatePanel3"
						 runat="server" 
						 UpdateMode="Always"
						 RenderMode="Inline">
						 <ContentTemplate>
						 <asp:GridView 
							ID="gvHistory" 
							runat="server" 
							 AllowPaging ="false" 
							AutoGenerateColumns="False" 
							EnableTheming="True" 
							EnableViewState="false"
							SkinID="GridViewNormal"  
							AllowSorting="True"  
							DataSourceID="odsCompletedActivities" > 
							 <Columns>   
									<asp:TemplateField ItemStyle-Width="5%" HeaderText="" >
									<ItemTemplate  >
										 <img src='<%= ConfigurationManager.AppSettings("ImagesURL") %><%# Functions.GetActivityImage(Eval("Type")) %>'  />&nbsp;
										 <asp:Label ID="lblID" runat="server" Visible="false" Text='<%#Eval("ID") %>' ></asp:Label>
										 <asp:Label ID="lblFranchiseID" runat="server" Visible="false" Text='<%#Eval("FranchiseID") %>' ></asp:Label>
										 <asp:Label runat="server" ID="lblIntType" Visible="false" Text='<%# Eval("ActivityState")%>' ></asp:Label>  
									</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField ItemStyle-Width="10%" HeaderText="Ticket #"  SortExpression="Ticket" >
									<ItemTemplate >
										<asp:Label runat="server" ID="lblTicketNumber" Text='<%# Functions.GetActivityPrefix(Eval("Type")) &  Eval("ID")%>' ></asp:Label>    
									</ItemTemplate>
									</asp:TemplateField> 
								   <%--  <asp:TemplateField ItemStyle-Width="15%" HeaderText="Franchise" SortExpression="Franchise" >
									<ItemTemplate >
										<asp:Label runat="server" ID="lblFranchise" Text='<%# Eval("Franchise")%>' ></asp:Label>    
									</ItemTemplate>
									</asp:TemplateField>--%>   
									 <asp:TemplateField ItemStyle-Width="30%" HeaderText="Subject" SortExpression="Subject" >
										<ItemTemplate >
										  <span title='<%# Functions.IfNull(Eval("Subject"), "") %>' >
											<asp:Label runat="server" ID="lblSubject" Text='<%# Functions.StringTruncate(Functions.IfNull(Eval("Subject"), ""), 40) %>' ></asp:Label>    
										  </span>
										</ItemTemplate>
									</asp:TemplateField> 
									<asp:TemplateField ItemStyle-Width="20%" HeaderText="Status" SortExpression="Status" >
										<ItemTemplate >
										  <span title='<%# Functions.GetActivityStatus(Eval("ActivityState"))  %>' >
											<asp:Label runat="server" ID="lblstatus" Text='<%# Functions.GetActivityStatus(Eval("ActivityState"))  %>' ></asp:Label>    
										  </span>
										</ItemTemplate>
									</asp:TemplateField> 
									<asp:TemplateField ItemStyle-Width="10%" HeaderText="Created" SortExpression="Date" >
										<ItemTemplate >
											<asp:Label runat="server" ID="lblDate" Text='<%# Functions.DateDiffInWords(Eval("Date"))%>' ToolTip='<%#Eval("Date") %>' ></asp:Label>    
										</ItemTemplate>
									</asp:TemplateField> 
									<asp:TemplateField HeaderText="Completed" ItemStyle-Width="12%" SortExpression="LastUpdatedOn" Visible="true" >
									   <ItemTemplate >
										   <asp:Label runat="server" ID="lblLastActivity" Text='<%# Functions.DateDiffInWords(Eval("LastUpdatedOn"))%>' ToolTip='<%#Eval("LastUpdatedOn") %>' ></asp:Label>
									   </ItemTemplate>
								   </asp:TemplateField>
								</Columns>
							</asp:GridView>
							 </ContentTemplate>
								  <Triggers >  
								  <%-- <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />--%>
								  </Triggers>
							</asp:UpdatePanel>    
							<asp:ObjectDataSource ID="odsCompletedActivities" runat="server" 
									SelectMethod="GetCompletedActivitiesForHelpDesk"
								   EnablePaging="false"
									SortParameterName ="sortExpression"  
									TypeName="Portal.BLL.Activities">
								<SelectParameters>
								<asp:QueryStringParameter Name="ClientID" QueryStringField ="ClientID" />
								<asp:QueryStringParameter Name="FranchiseID" QueryStringField ="FranchiseID" />
								<asp:Parameter  Name="sortExpression" Type="String" DefaultValue=""    />
								</SelectParameters>
						   </asp:ObjectDataSource> 
						 </div> 
			   </td>
			 </tr>
					 <tr style="background-color:#BADCFC; display:none;" >
						<td align="left" colspan="2" id="CustomPagerRow" style="height:25px;width:70%;">&nbsp;</td>
						<td align="right" colspan="2" style="width:30%;">
							<table cellpadding="0" cellspacing="0" border="0" width="100%" style="width:100%;height:100%;">
								<tr>
									<td  width="100%;" class="GrayHeader">
										<span style="font-size:7pt; color: #ff0000">*</span>
											Priority:&nbsp;
											<span style="background-color:#FFFFFF;width:12;border:outset 1px #FFFFFF;"></span>&nbsp;Low
					                        			<span style="background-color:#FFF200;width:12;border:outset 1px #FFF200;"></span>&nbsp;Minimal
					                        			<span style="background-color:#FF7F27;width:12;border:outset 1px #FF7F27;"></span>&nbsp;Moderate
					                        			<span style="background-color:#ED1C24;width:12;border:outset 1px #ED1C24;"></span>&nbsp;High
					                        			<span style="background-color:#880015;width:12;border:outset 1px #880015;"></span>&nbsp;Critical
                                            						<span style="background-color:#CB0104;width:12;border:outset 1px #CB0104;"></span>&nbsp;Delayed

								   </td>
								</tr>
							</table>
						</td> 
					 </tr>
				 </table>
			   </td>
			 </tr>
		   </table>
	</div>    
	<div id="DivOption" runat="server"  style="display:none;border:solid 1px #000000;position:absolute;width:600px;height:60%;top:15%;left:10%;z-index:10;">
		  <table style="height:100%;" cellpadding="0" border="0" cellspacing="0"   >
		   <tr>    
			  <td align="left" style="border-bottom:solid 1px #000000;padding-top:4px; padding-left:1em;vertical-align:middle; background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
				  <label id="lblTitle" title="Notes"    style="color:White;height:100%; overflow:auto; font-weight:bold;"  >Owner's List</label>
			  </td>
			  <td  style="border-bottom:solid 1px #000000;background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%; height:28px; cursor:pointer;">
				  <img src="../images/win_btn_close_black.jpg" style="float:right;" alt="Close Window" onclick="DivOptionHide();" />
			  </td> 
		   </tr>
		   <tr valign="top">  
			 <td colspan="2" style="height:100%; padding:10px; font-size:12px; background-color:White;" >   
			 <div style="height:100%;width:100%; overflow-y:auto;">
				 <table style="width:100%;height:100%;" border="0" cellspacing="0" cellpadding="0" >
				  <tr>
					<td height="30" class="SimpleBold">&nbsp;<asp:Label ID="lblStore" runat="server" Text=""  ></asp:Label>   own by :</td>
				  </tr>
				  <tr  style="height:100%;" >
					<td valign="top" align="center" style="padding:5px;">    	
								<asp:Repeater
									runat="server"
									ID="rptrFranchiseOwner" DataSourceID="odsrstOwners"  >
									<HeaderTemplate>
									 <table border="0" cellpadding="0" cellspacing="0" style="width:100%; font-size:11px;"> 
									</HeaderTemplate>
									<ItemTemplate>
											<tr style="background-color:#FFFFFF;height:20px;" >  
												  <td class="RecordTableGridRow"  style="padding:0px;"   align="left"  ><%#Functions.IfNull(Eval("OwnerName") & " " & IIf(Eval("Primary") = True, "(Primary)", ""), "")%> </td>  
										   </tr>
									</ItemTemplate>
									<FooterTemplate>  
										   <tr id="trStores_NoRecord" runat="server" visible="false" style="background-color:#FFFFFF;"><td colspan="5" style="font-style:italic;text-align:center;height:20px;">No owner to show!</td></tr>
										</table>
									</FooterTemplate>
								 </asp:Repeater>
								<asp:ObjectDataSource ID="odsrstOwners" runat="server" 
									SelectMethod="FranchisesOwnersGetByID"
									TypeName="Portal.BLL.Franchises">
									<SelectParameters>
									  <asp:ControlParameter  Name="ClientID" Type="Int32" ControlID="hdnClientID" PropertyName="Value" />    
									  <asp:ControlParameter  Name="FranchiseID" Type="Int32" ControlID="hdnFranchiseID" PropertyName="Value" />    
									</SelectParameters>
								</asp:ObjectDataSource> 
								<asp:Repeater
									runat="server"
									ID="rptrOwnerOtherFranchises" DataSourceID="odsrstOtherFranchises"  >
									<HeaderTemplate>
									 <table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%; font-size:11px;"> 
									</HeaderTemplate>
									<ItemTemplate>
											<tr>
												<td style="height:20px;" >
												<br />
												<asp:Label runat="server" ID="lblContactID" Visible="false" Text='<%# Eval("ID")%>' ></asp:Label>
												  <strong><%#Eval("FirstName") & " " & Eval("LastName")%> also owns :</strong><br /><br />
													<asp:Repeater
													runat="server"
													ID="rptrFranchises" DataSource='<%# Container.DataItem.CreateChildView("Owner_Franchises") %>'  >
													<HeaderTemplate>
													</HeaderTemplate>
													<ItemTemplate>
													<li style="height:20px;">
														 <span onclick="window.navigate('Franchise_Inbox.aspx?FranchiseID=<%# Eval("FranchiseID")%>&ClientID=<%# hdnClientID.value %>');" style="cursor:pointer;">
															<u><%#Eval("StoreNumber") & " - " & Eval("StoreName")%></u>
														 </span>
													</li>
													</ItemTemplate>
													<FooterTemplate> 
													</FooterTemplate>
												  </asp:Repeater>
												</td>
											</tr>
									</ItemTemplate>
									<FooterTemplate> 
									<tr ><td>&nbsp;</td></tr> 
										   <tr id="trStores_NoRecord" runat="server" visible="false" style="background-color:#FFFFFF;"><td colspan="5" style="font-style:italic;text-align:center;height:20px;">No owner to show!</td></tr>
										</table>
									</FooterTemplate>
								 </asp:Repeater>
								<asp:ObjectDataSource ID="odsrstOtherFranchises" runat="server" 
									SelectMethod="OwnersOtherFranchisesGetByID"
									TypeName="Portal.BLL.Franchises">
									<SelectParameters>
									  <asp:ControlParameter  Name="ClientID" Type="Int32" ControlID="hdnClientID" PropertyName="Value" />    
									  <asp:ControlParameter  Name="FranchiseID" Type="Int32" ControlID="hdnFranchiseID" PropertyName="Value" />    
									</SelectParameters>
							</asp:ObjectDataSource>
					   
					</td>
				  </tr>
				 <%-- <tr height="10"><td><img src="../images/spacer.gif" height="10" width="1" /></td></tr>    --%>   
				 <tr ><td>&nbsp;</td></tr>
				</table>
				 </div>
			 </td>
		   </tr>   
		  </table>
		</div>
	<div id="DivContact" runat="server"  style="display:none;border:solid 1px #000000;position:absolute;width:600px;height:220px;top:15%;left:10%;z-index:10;">
		  <table style="height:100%;" cellpadding="0" border="0" cellspacing="0"   >
		   <tr>    
			  <td align="left" style="border-bottom:solid 1px #000000;padding-top:4px; padding-left:1em;vertical-align:middle; background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
				  <label id="lblContact" title="Notes"    style="color:White;height:100%; overflow:auto; font-weight:bold;"  >Contact Information</label>
			  </td>
			  <td  style="border-bottom:solid 1px #000000;background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%; height:28px; cursor:pointer;">
				  <img src="../images/win_btn_close_black.jpg" style="float:right;" alt="Close Window" onclick="DivContactHide();" />
			  </td> 
		   </tr>
		   <tr valign="top">  
			 <td colspan="2" style="height:100%; padding:0px; font-size:12px; background-color:White;" >   
			 <iframe name="IfContactProfile" runat="server" id="IfContactProfile" src="Blank.aspx" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
			 </td>
		   </tr>   
		  </table>
		</div>
   <div id="DivMessageFranchise" style="display:inline;border:solid 2px #A31A19; position:absolute;width:200px;z-index:10;background-color:#FECCCB;">
	  <table style="height:100%;" cellpadding="0" border="0" cellspacing="0"    >
	   <tr>    
		  <td align="left" style="padding-left:5px;width:80%;">
			  <span title="Franchise Termination Alert" style="color:black;font-weight:bold;font-size:12px;"></span>
		  </td>
		  <td  style="height:24px;cursor:pointer;">
			  <img src="../images/btn_close.gif" style="float:right;" alt="Close Window" onclick="javascript:history.back();" />
		  </td> 
	   </tr>
	   <tr valign="top">  
		 <td colspan="2" align="center"  style="width:100%;font-size:13px;">   
			<div style="overflow-y:auto;width:350px;left:126px;top:10px;float:left;position:relative;">
				<table border="0" cellpadding="3" cellspacing="0" style="width:100%;text-align:left;font-size:12px;">
				  <tr style="font-weight:bold;">
					 <td><span id="DivMessageFranchiseMSG" runat="server">TERMINATED STORE!</span></td>
				  </tr>
				   <tr style="font-size:11px;color:#7E6A67;">
					 <td><span id="DivMessageFranchiseMSG2" runat="server">Please request caller to contact Franchise<BR>Systems Compliance office.</span></td>
				  </tr>
				</table>
			</div>
			<div style="float:left;position:relative;top:-40px;left:60px;">
				<img src="../images/icn_suspendedSupportAlert.jpg" />
			</div>
		 </td>
	   </tr>
	   <tr>
			<td colspan="2" align="center" style="background-color:#FDA29F;border-top:solid 1px #B8474F;height:35px; vertical-align:middle;">
			  <!--<INPUT class="Btn3D" id="btnOK" style="WIDTH: 80px" onclick="Reset();" type="button"  name="btnOK" value="Yes" />-->
				&nbsp;
			  <INPUT class="Btn3D" id="btnCancle" style="WIDTH: 80px" onclick="javascript:history.back();" type="button" name="btnCancle" value="OK" />
			</td>
		  </tr>   
	  </table>
	</div> 
	<div id="DivMessageAlert" style="display:none;border:solid 1px #609BD3; position:absolute;width:400px;z-index:10;">
		  <table style="height:100%;" cellpadding="0" border="0" cellspacing="0"   >
		   <tr>    
			  <td align="left" style="border-bottom:solid 1px #609BD3; padding-left:5px;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=#ABD0E8,endColorStr=#FAFCFE);width:80%;">
				  <span title="Franchises Support Expiration Alert" style="color:black;font-weight:bold;font-size:12px;">Franchises Support Expiration Alert</span>
			  </td>
			  <td  style="border-bottom:solid 1px #609BD3;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=#FAFCFE,endColorStr=#FFFFFF);width:20%;height:24px;cursor:pointer;">
				  <img src="../images/btn_close.gif" style="float:right;" alt="Close Window" onclick="Reset2();" />
			  </td> 
		   </tr>
		   <tr valign="top">  
			 <td colspan="2" style="width:100%;font-size:12px;">
				<table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%;text-align:center;font-size:12px;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#ABD0E8,endColorStr=#FFFFFF);">
				  <tr style="font-weight:bold;padding-top:5px;">
					 <td>The following Product(s) with are expirated or not supported.</td>
				  </tr>
				  <tr >
					 <td style="height:80%;width:100%;">
						 <%--<table border="0" cellpadding="3" cellspacing="0" style="background-color:white;width:100%;font-size:12px;">
						   <tr style="color:#52789C;font-weight:bold;height:21px;">
								<td style="width:100px;border-right:solid 1px #6B8AC1;border-bottom:solid 1px #6B8AC1;border-top:solid 1px #6B8AC1;">Product</td>
								<td style="border-bottom:solid 1px #6B8AC1;border-top:solid 1px #6B8AC1;white-space:nowrap;">Expiration Date</td>
							</tr>
						</table>--%>
						<div style="overflow-y:auto;height:120px;width:400px;">
						<asp:Repeater
							runat="server"
							ID="rptrContactInfo"
							DataSourceID="sdsContactInfo">
							<HeaderTemplate>
							<table id="tbsamplevalue" border="0" cellpadding="3" cellspacing="0" style="width:100%;font-size:12px;">
							<tr style="color:#52789C;font-weight:bold;height:21px;background-color:white;top:expression(eval(this.parentElement.parentElement.parentElement.scrollTop));position:relative;">
								<td style="width:150px;border-right:solid 1px #6B8AC1;border-bottom:solid 1px #6B8AC1;border-top:solid 1px #6B8AC1;">Product</td>
								<td style="width:100px;border-right:solid 1px #6B8AC1;border-bottom:solid 1px #6B8AC1;border-top:solid 1px #6B8AC1;white-space:nowrap;">Expiration Date</td>
								<td style="width:150px;border-right:solid 1px #6B8AC1;border-bottom:solid 1px #6B8AC1;border-top:solid 1px #6B8AC1;display:<%#iif(hdnHasSupportAccess.value,"inline","none") %>;">Action</td>
							</HeaderTemplate>
							<ItemTemplate>
								<tr style="height:22px;">
									<td style="width:150px;border-bottom:solid 1px #C9EAFC;"><%#Eval("ProductName")%></td>
									<td style="width:100px;border-bottom:solid 1px #C9EAFC;white-space:nowrap;"><%#IIf(Eval("OnSupport") = False, "Not On Support", "<b>" & String.Format("{0:MMM dd, yyyy}", Eval("SupportEndDate")) & "</b>")%></td>
									<td style="width:150px;border-bottom:solid 1px #C9EAFC;display:<%#iif(hdnHasSupportAccess.value,"inline","none") %>;"><a href='#' onclick="signup('<%#Eval("ProductsFranchisesID")%>','<%#Eval("FranchiseID")%>','<%#Eval("ClientID")%>','<%#Eval("ProductID")%>','<%#Eval("OnSupport")%>');"><%#IIf(Eval("OnSupport") = False AndAlso Eval("ProductsFranchisesID") = 0, "Sign Up", IIf(Eval("OnSupport") = False AndAlso Eval("ProductsFranchisesID") > 0, "Turn On", "Edit"))%>&nbsp;</a></td>
								</tr>    
							</ItemTemplate>
							<FooterTemplate>
								</table>
							</FooterTemplate>
						</asp:Repeater>
						<asp:SqlDataSource 
							ID="sdsContactInfo" 
							runat="server" 
							ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>" 
							SelectCommand="com_NS_Product_Franchises_SupportEndDateByID" 
							SelectCommandType="StoredProcedure">
							<SelectParameters>
								<asp:ControlParameter Name="FranchiseID" ControlID="hdnFranchiseID" PropertyName="Value" DefaultValue="759"  />  
							</SelectParameters>
						</asp:SqlDataSource> 
						</div> 
					 </td>
				  </tr>
				  <tr style="font-weight:bold;padding-bottom:5px;padding-top:5px;">
					 <td>Do you want to proceed ?</td>
				  </tr>
				  <tr>
					<td style="padding-bottom:5px;">
						<INPUT class="Btn3D" id="Button1" style="WIDTH: 80px" onclick="Reset2();" type="button"  name="btnOK" value="Yes" />
						&nbsp;
						<INPUT class="Btn3D" id="Button2" style="WIDTH: 80px" onclick="javascript:history.back();" type="button" name="btnCancle" value="No" />
					</td>
				  </tr>
				</table>
			 </td>
		   </tr>   
		  </table>
		</div>
	</form>
	<script type="text/javascript" language="javascript">
	   function AdjustPagerRow(){
		var objTag = null;
		var objCustomRow = null;
		try{
		objCustomRow = getElement("CustomPagerRow");
		objTag = getElementByClassName('FloatingPager');
		objCustomRow.innerHTML = '&nbsp;';
		if (objTag != null && objCustomRow != null)
			{
			objTag.style.display = 'none';
			objCustomRow.innerHTML = "<table cellpadding=0 cellspacing=0 align='left' height='18' ><tr class='cpyFloatingPager'>"+objTag.innerHTML+"</tr></table>";
			}
		}catch(ex){
			alert("Javascript Error:\n"+ex.description);
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
		if (typeof(postbackElement) === "undefined") {
			return;
		} 
		for (i=0; i < updatedPanels.length; i++){
			if (updatedPanels[i].id == '<%= UpdatePanel2.ClientID %>') {
				AdjustPagerRow();
				$get('<%= txtSearch.ClientID %>').value=''; 
			}
		}
	}
	function FranchiseLogin(primary , FranchiseID)
	{   
		if (primary == '1')	    	   
			window.open('../FranchiseAutoSignin.aspx?Coordinator=1&FranchiseID=' + FranchiseID + '&Type=' + $get('<%= hdnOwnerID.ClientID %>').value );
		else
			window.open('../FranchiseAutoSignin.aspx?Coordinator=1&FranchiseID=' + FranchiseID + '&Type=' + $get('<%= hdnStoreID.ClientID %>').value );
	}
   function OwnerListShow()
	{
		getElement('StoreOwnersDiv').style.display = 'inline';
	}
		
   function DivOptionDisplay()
	{
		var DivOption = getElement('<%= DivOption.ClientID %>')
		var divDisable = document.getElementById('divDisable');   
		divDisable.style.width = document.body.scrollWidth
		divDisable.style.height = document.body.scrollHeight
		divDisable.style.display = 'block';
		DivOption.style.display= "inline"
	}
		
   function DivOptionHide()
	{
		var DivOption = getElement('<%= DivOption.ClientID %>');
		var divDisable = document.getElementById('divDisable');
		divDisable.style.width = 0;
		divDisable.style.height = 0;
		divDisable.style.display = 'none';
		DivOption.style.display= "none"; 
		return false;
	}
		
   function showContact()
	 {
		var DivOption = getElement('<%= DivContact.ClientID %>');
		var divDisable = document.getElementById('divDisable');   
		divDisable.style.width = document.body.scrollWidth
		divDisable.style.height = document.body.scrollHeight
		divDisable.style.display = 'block';
		DivOption.style.display= "inline";
		//try{setWindowedControlsVisibility(window, 'visible');}catch(e){}
		//setWindowedControlsVisibility(window,'hidden');
	   IfContactProfile.location = "ContactDetail.aspx?ClientID="+$get('<%=hdnClientID.ClientID%>').value + "&ContactID=" + $get('<%=ddlFranchiseContact.ClientID%>').value;
		}
		function DivContactHide()
		{
			var DivOption = getElement('<%= DivContact.ClientID %>');
			var divDisable = document.getElementById('divDisable');
			divDisable.style.width = 0;
			divDisable.style.height = 0;
			divDisable.style.display = 'none';
			DivOption.style.display= "none";
			IfContactProfile.location = "Blank.aspx";
			//setWindowedControlsVisibility(window,'visible');
			return false;
		}
  window.onload=function start()
	{ 
	  var hdnFranStatus = document.getElementById('<%=hdnFranStatus.ClientID%>');
	  var hdnFranIsSuspendedOrAbandon = document.getElementById('<%=hdnFranIsSuspendedOrAbandon.ClientID%>');
	  if(hdnFranStatus.value == 4 || hdnFranStatus.value == 5 || hdnFranStatus.value == 6 || hdnFranIsSuspendedOrAbandon.value == "True")
	  {
		SetPosition();
		ShowMessageAlert();
	  }
	  else
	  {
		Reset();
		valtable = window.document.getElementById("tbsamplevalue");
		if(valtable.rows.length > 1){
		   SetPosition();
		   ShowMessageAlert2();
		  }
		else
		  Reset2();
	  }
	  //alert(hdnFranStatus.value);
	}
   function ShowMessageAlert()
	{
	  var DivMessageFranchise = document.getElementById('DivMessageFranchise');
	  var x1=document.body.offsetWidth;
	  var y1=document.body.offsetHeight;
	  DivMessageFranchise.style.top = (y1/2) - 150; 
	  DivMessageFranchise.style.left = (x1/2) - 200; 
	  DivMessageFranchise.style.display = 'inline';
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
		DivMessageFranchise.style.display = 'none';
		return false;
	} 
	function ShowMessageAlert2()
	{
	  var DivMessageAlert = document.getElementById('DivMessageAlert');
	  var x1=document.body.offsetWidth;
	  var y1=document.body.offsetHeight;
	  DivMessageAlert.style.top = (y1/2) - 150; 
	  DivMessageAlert.style.left = (x1/2) - 200; 
	  DivMessageAlert.style.display = 'inline';
	}
  function Reset2()
	{    
		Reset();
		DivMessageAlert.style.display = 'none';
		return false;
	}
	function signup(id,franid,clientid,proid,onsupport)
	{  
	   parent.showSupport(id,franid,clientid,proid,onsupport);
	}
</script>
</body>
</html>