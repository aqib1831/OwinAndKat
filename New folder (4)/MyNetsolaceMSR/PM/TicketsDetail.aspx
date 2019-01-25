<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TicketsDetail.aspx.vb" Inherits="PM_TicketsDetail" ValidateRequest="false" %>
<%@ Register TagPrefix="radU" Namespace="Telerik.WebControls" Assembly="RadUpload.Net2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Import Namespace="Portal.BLL" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Edit Ticket</title>
    <link href="../../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <link href="../../App_Themes/Default/Calendar/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../../scripts/calendar-fs.js"></script>
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=0.2)" />
    <meta http-equiv="Page-Enter" content="progid:DXImageTransform.Microsoft.Fade(Duration=0.2)" />
	<style type="text/css">
		.FormInnerTable td {background-color:#DEF7D6;vertical-align:middle;}
		.WhtLine{ border-bottom: solid 1px white;height:1px;}
		.WhtLine img{height:1px;width:1px;src:url('../../images/spacer.gif');}
	</style>
</head>
<body style="margin:0px;width:100%;height:100%;">
 <form id="form1" runat="server" >
	<iframe id="divDisable" marginheight="0" marginwidth="0" scrolling="no" frameborder="0" style="display:none;z-index:09;width:0;height:0;position:absolute;filter:progid:DXImageTransform.Microsoft.alpha(opacity=50);opacity:0.5;"src="../../BlankPage.htm"></iframe>
	<iframe id="IframeDownload" name="IframeDownload" marginheight="0" marginwidth="0" scrolling="no" frameborder="0" style="display:none;width:0;height:0;" src="../../BlankPage.htm"></iframe>
    <radu:radprogressmanager id="Radprogressmanager1" runat="server" />
    <div align="center" id="progress" style="display:none; border:0px solid black; position:absolute;left:25%; top:30%;z-index:100;">
        <radu:radprogressarea id="RadProgressArea1" runat="server"></radu:radprogressarea> 
    </div>
    <div>
    <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="400"  />
    <asp:UpdateProgress ID="Progress1" runat="server">
            <ProgressTemplate>
                <div class="ProgressIndicatorDIVGreen" >
                    <br />
                    <asp:Image ID="Image2" runat="server" ImageUrl="../../images/indicator.gif" ImageAlign="AbsMiddle" /> <span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Updating ...</b></span>
                    <br /><br />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>  
      <table   style="width:100%;height:100%;background-color:#FFFFFF;" class="Table" border="0" align="center" cellpadding="0" cellspacing="0">
         <tr>
           <td style="height:85px;">
            <asp:HiddenField ID="hdnID" runat="server" Value="0"  />
            <asp:HiddenField ID="PrevPage" runat="server" Value="0"  /> 
            <asp:HiddenField ID="hdnReleaseID" runat="server" />
            <asp:HiddenField ID="hdnDueDate" runat="server" Value="0" />
            <asp:HiddenField ID="IsRelease" runat="server" Value="0" />
            <asp:HiddenField ID="hdnTimeSpent" runat="server" Value="00:00:00" />
            <asp:HiddenField ID="hdnUserID" runat="server" Value="0" />
            <asp:HiddenField ID="hdnRefNo" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsReadOnlyAccess" runat="server" Value="0" />
            <asp:HiddenField ID="hdnReleaseDueDate" runat="server" Value="" />
            <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
            <asp:HiddenField ID="hdnClientContactID" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsDueDateShowToClient" runat="server" Value="0" />
            <asp:HiddenField ID="hdnIsListChanged" runat="server" Value="0"  />            
            
                  <table style="width:100%;height:85px;background-color:#DDE4EE;"  border="0" cellpadding="0" cellspacing="0" class="SimpleExSmall">
                   <tr>
                      <td height="31" colspan="5">
                          <table cellpadding="0" cellspacing="0" border="0"  width="100%" style="background-color:#BDE7BD;">
                                <tr>
                                   <td height="31" class="SimpleBold" style="width:150px;color:#000000;border-bottom:1 solid #609BD3;">
                                    &nbsp;<asp:Label ID="lblTitle" runat="server" Text="Ticket Detail"></asp:Label>&nbsp; <asp:image ID="ImgPriority" runat="server" />                                    
                                    </td>
                                    <td style="background-color:#BDE7BD;color:#000000;border-bottom:1 solid #609BD3;">&nbsp;</td>
                                    <td style="background-color:#BDE7BD;color:#000000;border-bottom:1 solid #609BD3;">&nbsp;</td>
                                    <td align="right" class="SimpleBold" style="width:80px; text-align:right;   background-color:#BDE7BD;color:#000000;border-bottom:1 solid #609BD3;">
                                        <img alt=""  src="../../images/print.gif" align="absmiddle" style="cursor: pointer;" onclick="window.open('TicketsReport.aspx?TicketID= <%= Request.QueryString("ID") %>')" />
                                        <asp:HyperLink  ID="lBtnPrint" runat="server" CausesValidation="false" Visible="true" style=" text-align:left; font-size:11px; width:40px; height:18px;" Text="Print" Target="_blank" />
                                    </td>
                                    
                                </tr>
                           </table>
                        </td>
                    </tr>
					<tr style="background-color:#DEF7D6;">                        
                        <td style="width:200px;">&nbsp;From: <asp:Label runat="server" ID="lblAssignBy" Font-Bold="true"  /></td>                        
                        <td style="width:150px;" class="SimpleExSmall">Type: <asp:Label runat="server" ID="lblActivityType" Font-Bold="true" /></td>                        
                        <td style="width:250px;" class="SimpleExSmall">Due Date: <asp:Label runat="server" ID="lblDueDate" Font-Bold="true" /></td>
                        <td style="width:170px;" class="SimpleExSmall">Category: <asp:Label runat="server" ID="lblCategoryName" Font-Bold="true" /></td>
                        <td><asp:Label runat="server" ID="lblClientName" style="display:none;" /></td>
                    </tr>
                    <tr style="background-color:#BDE7BD">                        
                        <td colspan="4" style="white-space:nowrap;" height="20">
                        <span class="SimpleExSmall" style="padding-right:10px;padding-left:10px;">Subject:</span>
                            <asp:Label runat="server" ID="lblActivitySubject" Text="" Font-Bold="true" />
                        </td>
                        <td style="white-space:nowrap;" class="SimpleExSmallBold" align="right"  >                        
                            <asp:LinkButton ID="btnAddNotes" runat="server" CausesValidation="false" style="padding:4px; text-align:right; font-size:11px; width:90px; height:18px;" Text="Add Notes" OnClientClick="Notes(); return false;" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                   </tr>
                     <tr class="SimpleExSmallBold" id="trFiles" style="display:none;border:none;">
                        <td style="height:25px;" colspan="8">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="background-color:White;">
                                <tr>
                                    <td style="border:none;" rowspan="2" align="center" width="5%"><img src="../../images/ico_attachment.gif" align="middle" alt="attach" /></td>
                                    <td style="border:none;" id="tdFiles"></td>
                                 </tr> 
                            </table>
                        </td>
                      </tr>
                </table>   
                  <asp:SqlDataSource ID="sdsActivity" 
                    runat="server" 
                    ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>" 
                    SelectCommand="PM_GetTicket_Feature_DetailByID" 
                    SelectCommandType="StoredProcedure" 
                    DataSourceMode="DataSet" >
                    <SelectParameters>
                       <asp:ControlParameter  Name="TicketID" DefaultValue="0"  ControlID="hdnID" Type="int32" PropertyName="value" />
                    </SelectParameters>
                </asp:SqlDataSource>
               <asp:SqlDataSource ID="SDS_TicketsAttachments" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                   SelectCommand="PM_Ticket_Features_Attachments_GetByTicketID" 
                   SelectCommandType="StoredProcedure"
                   DataSourceMode="DataSet" >
                   <SelectParameters>
                       <asp:ControlParameter ControlID="hdnID" Name="Ticket_FeatureID" PropertyName="Value"
                           Type="Int32" />
                   </SelectParameters>
               </asp:SqlDataSource>
          </td>
        </tr>
         <tr>
           <td style="width: 100%;height:100%;" >
            <table style="width:100%; height:100%; vertical-align:top;" border="0" cellpadding="0" cellspacing="0">
			   <tr>
					<td style=" width:100%; height:100%; vertical-align:top;">
						<table id="DivRepeaterAndContacts" cellspacing="0" cellpadding="0" style="width:100%;height:100%;">
							<tr>
								<td id="DivNotes" colspan="2" style="display: none;height:110px">
									<div  style="height:110px;padding:3px;padding-left:10px;width:100%;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#E7F7E1,endColorStr=#DEF7D6;);background-color:#DAF5D6; border-bottom:solid 1px #609BD3;">
										<table style=" width:100%; height:100px;" cellpadding="0" cellspacing="0" border="0" ondblclick="event.cancelBubble=true;">
											<tr><td colspan="2" valign="middle" class="SimpleExSmallBold">Notes:</td>
											</tr><tr>
											<td class="SimpleExSmallBold">
												<asp:TextBox ID="txtNotes" runat="server" style="width:100%;border:1px solid black; font-size:11px;" CssClass="SmallGreenTextBox" Height="70px" ValidationGroup="NotesAdd" TextMode="MultiLine"></asp:TextBox>
											</td>
											<td style="width:20%;text-align:center;vertical-align:top;" class="SimpleExSmallBold">
													<div>
														<asp:LinkButton ID="btnattch" runat="server"  OnClientClick="showAttachFiles(); return false;">
															<div class="LeadDetailGreenButton" style="width: 100px;"> Attach File</div>
														</asp:LinkButton>
													 </div>
													 <div style="padding-top:5px;">
														 <asp:Button runat="server"  ID="btnSave" style="height:20px; width:100px;" OnClientClick="if (OnSaveClientSide() == false) return false;" ValidationGroup="NotesAdd"   CssClass="LeadDetailGreenButton" Text="Save" />
													</div>
													<div style="padding-top:5px;">
														<asp:RequiredFieldValidator ID="RequiredFieldValidator1" 
															runat="server" ControlToValidate="txtNotes" ValidationGroup="NotesAdd" ErrorMessage="Enter Notes"
															Display="Dynamic" Enabled="true"/>
													</div>
												</td>
											   </tr>
										</table>
									</div>
								</td>
							</tr>
							<tr valign="top">
								<td style="width:100%;height:100%;">
								<div id="DivNotesDisplay"  runat="server"  style="width:100%;height:100%;overflow-y:scroll; padding-left:5px;" class="DivScroll" ondblclick="Notes();">
									 <asp:UpdatePanel ID="UpdatePanel2"
										 runat="server" 
										 UpdateMode="always" 
										 RenderMode="Inline">
										 <ContentTemplate>
                                             <asp:Repeater ID="rptrNotes" runat="server" DataSourceID="sdsNotes" EnableViewState="false">
                                                 <HeaderTemplate>
                                                     <table border="0" cellspacing="0" cellpadding="0" style="font-size: 11px; width: 100%;">
                                                 </HeaderTemplate>
                                                 <ItemTemplate>
                                                     <tr>
                                                         <td style="border-bottom: 1px solid #BDE4B8; border-bottom-style: dashed;">
                                                             <br />
                                                             <asp:Label ID="lblID" runat="Server" Visible="false" Text='<%#Container.DataItem("ID")%>'></asp:Label><asp:Label
                                                                 ID="lblTimeSpent" runat="Server" Visible="false" Text='<%#Container.DataItem("TimeSpent")%>' />
                                                             <b>
                                                                 <%#IIf(Functions.IfNull(Container.DataItem("UserID"), 0) <> 0, Functions.IfNull(Container.DataItem("UserName"), ""), Functions.IfNull(Container.DataItem("ClientContactName"), ""))%></b>&nbsp;On:
                                                             <b>
                                                                 <%#Container.DataItem("DateEntered")%><i>&nbsp;(EST)</i></b> <span style='<%# IIF(Functions.IfNull(Container.DataItem("TimeSpent"), "00:00:00") = "00:00:00" ,"Display:none" , "Display:inline;") %>'>
                                                                     <br />
                                                                     <i>TimeSpent(HH:MM): </i><b>
                                                                         <asp:Label ID="lblTimeSpentModified" runat="Server" /></b></span><br />
                                                             <asp:Repeater ID="rptrAttachments" runat="server" EnableViewState="false">
                                                                 <HeaderTemplate>
                                                                     <i>
                                                                         <br />
                                                                         Attachments:</i></HeaderTemplate>
                                                                 <ItemTemplate>
                                                                     [&nbsp;<a href='#' onclick="javascript:OpenAttachment('<%# ResolveUrl("Downlaod.aspx?dt=" & Functions.EncryptData(DateTime.Now) & "&AttachmentID=")& Functions.EncryptData( Container.DataItem("ID")) %>');"><%#Container.DataItem("FileName")%></a>&nbsp;]
                                                                     &nbsp;
                                                                 </ItemTemplate>
                                                             </asp:Repeater>
                                                             <br />
                                                             <div style="<%#IIF( Cbool(Eval("Type")) = True , "color:Blue;","color:Black;") %>">
                                                                 <%#CType(Container.DataItem("Notes"), String).Replace(vbCrLf, "<br />")%></div>
                                                             <br />
                                                             <br />
                                                         </td>
                                                     </tr>
                                                 </ItemTemplate>
                                                 <FooterTemplate>
                                                     </table>
                                                 </FooterTemplate>
                                             </asp:Repeater>
                                            <asp:Repeater ID="rptrTicket" runat="server" DataSourceID="sdsActivity">
                                            <ItemTemplate>
	                                            <table cellpadding="0" cellspacing="0" border="0" style="font-size: 11px;width:98%;">
		                                            <tr>
			                                            <td>
			                                            <br /><b>Original message sent by <%#IIF( Functions.Ifnull(Container.DataItem("UserID"),0) <> 0,Functions.Ifnull(Container.DataItem("UserName"),""),Functions.Ifnull(Container.DataItem("ClientContactName"),""))%> on <%#Container.DataItem("DateEntered")%><i>&nbsp;(EST)</i></b>
			                                            </td>
		                                            </tr>
		                                            <tr><td>
			                                            <asp:Repeater ID="rptrTicketAttachments" runat="server" DataSourceID="SDS_TicketsAttachments">
				                                            <HeaderTemplate><i>Attachments:</i></HeaderTemplate>
				                                            <ItemTemplate>
				                                            [&nbsp;<a href='#'onclick="javascript:OpenAttachment('<%# ResolveUrl("Downlaod.aspx?dt=" & Functions.EncryptData(DateTime.Now) & "&TicketID=")& Functions.EncryptData(Container.DataItem("ID")) %>');" ><%#Container.DataItem("FileName")%></a>&nbsp;] &nbsp;
				                                            </ItemTemplate>
			                                            </asp:Repeater>
		                                            </td></tr>
		                                            <tr><td><br /><%#Server.HtmlEncode(CType(Container.DataItem("Description"), String)).Replace(vbCrLf, "<br />")%><br /><br /></td></tr>
		                                            <tr><td style="border-top: 1px solid #BDE4B8; border-top-style: solid;">&nbsp;</td></tr>
	                                            </table>
	                                            <br />
                                            </ItemTemplate>
                                            </asp:Repeater>
						   </ContentTemplate>
							</asp:UpdatePanel>
							</div>
								</td>
								<td style="height:100%;padding:0px;" valign="top">
								<asp:UpdatePanel ID="upContactsTable" runat="server" UpdateMode="Conditional" RenderMode="Block">
								<ContentTemplate>
								    <table id="contactsTable" runat="server" cellspacing="0" cellpadding="0" style="width:200px;height:100%;display:inline;">
											<tr valign="top">
												<td style="height:45px;width:100%; padding:0px;">
												<asp:Panel ID="pnlsearch" runat="server" DefaultButton="btnSearch">
													<div style="border-color:#F5F5F5; background-color:#DEF7D6; padding-top:3px; padding-left:7px; border-bottom:solid 1px white;" class="SimpleExSmallBold"><asp:TextBox ID="txtClientUserSearch" runat="server" Height="18" Width="140"  onkeyup='SearchUsers(this);'></asp:TextBox>
													<ajaxToolkit:TextBoxWatermarkExtender ID="wmtxtSearch" runat="server" TargetControlID="txtClientUserSearch" WatermarkText="Search Contacts.." WatermarkCssClass="waterMark">
													</ajaxToolkit:TextBoxWatermarkExtender>
													<asp:ImageButton ID="btnSearch"   runat="server" OnClientClick="txtClientUserSearch.onkeyup(); return false;" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />
													</div> 
													</asp:Panel>
													<div style="border-color:#F5F5F5; background-color:#DEF7D6; height:20px; padding-bottom:1px;white-space:nowrap;padding-right:3px;" class="SimpleExSmallBold"><asp:Label ID="lblContactClientName" runat="server"></asp:Label>&nbsp;Contacts:
													</div> 
												</td>
											</tr>
											<tr style="width:100%;" valign="top">
												<td style="width:100%;padding:0px;">
													<div id="DivContacts" style="width:100%;height:100%;overflow-y:scroll;" class="DivScroll">
													<asp:UpdatePanel ID="upnlClientContacts" runat="server" UpdateMode="Conditional">
														<ContentTemplate>
																<asp:Repeater ID="rptClientContacts" runat="server" DataSourceID="sdsClientContacts" >
																<HeaderTemplate>
																	   <div id="dvClientContacts" class="SimpleExSmallBold">
																</HeaderTemplate>
																<ItemTemplate>
																	<div>
																		<asp:CheckBox ID="chkClientContacts" ToolTip='<%# Eval("ClientUserName")%>' runat="server" Text='<%# Functions.StringTruncate(Eval("ClientUserName"), 15) %>' Checked='<%# Eval("Checked") %>' ClientContactID='<%# Eval("ClientContactID") %>' PrevClientChecked='<%# Eval("Checked") %>'/>
																	</div>
																</ItemTemplate>
																<FooterTemplate></div></FooterTemplate>
																</asp:Repeater> 
																<asp:SqlDataSource 
																   ID="sdsClientContacts" 
																   runat="server" 
																   ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
																   SelectCommand="PM_Ticket_Features_Users_ClientContacts"
																   SelectCommandType="StoredProcedure"
																   DataSourceMode="DataReader">
																   <SelectParameters>
																		<asp:ControlParameter Name="ClientID" DefaultValue="0"  ControlID="hdnClientID" Type="int32" PropertyName="value" />
																		<asp:ControlParameter Name="TicketID" DefaultValue="0"  ControlID="hdnID" Type="int32" PropertyName="value" />
																   </SelectParameters>
																</asp:SqlDataSource>
															</ContentTemplate>
															</asp:UpdatePanel>
													</div>
												</td>
											   </tr>											   
												<tr>
													<td style="height:30px;border-color:#F5F5F5; background-color:#DEF7D6;" align="center">													
														<asp:Button runat="server"  ID="btnUpdateUsers" style="height:20px; width:80px;" CssClass="LeadDetailGreenButton" OnClientClick="clearSearchUser();" Text="Update" />														
													</td>
												</tr>
									  </table>
								</ContentTemplate>
								</asp:UpdatePanel>									
								</td>
							</tr>
						</table>
						<asp:SqlDataSource 
						   ID="sdsNotes" 
						   runat="server" 
						   ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
						   SelectCommand="PM_Notes_GetByTicketIDForMyNetsolace" 
						   SelectCommandType="StoredProcedure"
						   DataSourceMode="DataSet" >
						   <SelectParameters>
							 <asp:ControlParameter Name="TicketID" DefaultValue="0"  ControlID="hdnID" Type="int32" PropertyName="value" />
						   </SelectParameters>
						</asp:SqlDataSource>
						<asp:SqlDataSource 
						ID="sdsAttachments" 
						runat="server" 
						ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
						SelectCommand="PM_Attachments_GetByTicketID"
						SelectCommandType="StoredProcedure"
						DataSourceMode="DataSet" >
						<SelectParameters >
							 <asp:ControlParameter  Name="TicketID" DefaultValue="0"  ControlID="hdnID" Type="int32" PropertyName="value" />
						</SelectParameters>
						</asp:SqlDataSource>
				   </td>
			   </tr>
		   </table>
          </td>
        </tr>
         <tr style="background-color:#BDE7BD;height:31px;">
             <td style="border-top:1 solid #609BD3;height:31px;" >
              <asp:UpdatePanel ID="UpdatePanel3"  runat="server" ChildrenAsTriggers="true" UpdateMode="always"  RenderMode="block">
                  <ContentTemplate>  
             <asp:HiddenField ID="hdnPreValueStatus" runat="server" Value="0" />
             <asp:HiddenField ID="hdnWaitingFor" runat="server" Value="0" /> 
                <table style="width:100%;height:31px;" border="0" cellpadding="0" cellspacing="0" >
                <tr style="height:31;" >
                    <td class="SimpleExSmall" style="width:20%">
                        <div runat="server"  id="divStatus">&nbsp;Status:&nbsp;
                            <asp:Label ID="lblActivityStatus" runat="server" Font-Bold="true" style="white-space:nowrap;"></asp:Label>
                            <asp:DropDownList ID="ddlActivityStatus" runat="server" Width="150px" style="display:none;" AutoPostBack="true">
                                <asp:ListItem Text="Not Started" Value="2"></asp:ListItem>
                                <asp:ListItem Text="In Requirement Gathering" Value="14"></asp:ListItem>
                                <asp:ListItem Text="Completed" Value="5"></asp:ListItem>
                                <asp:ListItem Text="In Design Phase" Value="13"></asp:ListItem>
                                <asp:ListItem Text="In Progress" Value="4"></asp:ListItem>
                                <asp:ListItem Text="In Development Phase" Value="11"></asp:ListItem>
                                <asp:ListItem Text="In QA Phase" Value="12"></asp:ListItem>
                                <asp:ListItem Text="Client's Feedback Requested" Value="8"></asp:ListItem>
                                <asp:ListItem Text="Client's Feedback Recieved" Value="9"></asp:ListItem>
                                <asp:ListItem Text="Confirm Solved" Value="10"></asp:ListItem>
                                <asp:ListItem Text="On Hold" Value="7"></asp:ListItem>
                            </asp:DropDownList>
                       </div>
                   </td>
                    <td class="SimpleExSmall"  style="width:60%;" align="left">
                        <div id="StatusConfirmation" runat="server" style="vertical-align:middle;white-space:nowrap;">&nbsp;
							<img src="../../images/ico_alert.gif" align="middle" />&nbsp;&nbsp;<span style="position:relative;top:2px;">Netsolace wants to close the ticket. Do you want to close? &nbsp;
							<asp:Button ID="BtnComplited" runat="server" Text="Yes" CssClass="Btn3D" Width="70px" OnClientClick="SelectStatusDDL(5);" />&nbsp;
							<asp:Button ID="BtnConfirmNO" runat="server" CssClass="Btn3D" Text="No" Width="70px" OnClientClick="SelectStatusDDL(9);" /></span>
                         </div>
                      </td>
                     <td style="width:20%; white-space:nowrap;" align="right">                             
                             <asp:Button ID="btnBack" runat="server"  CssClass="Btn3D" CausesValidation="false" Text="Back" Width="80px" />&nbsp;&nbsp;
                     </td>
                 </tr>
               </table>
             </ContentTemplate>
                       <Triggers >
                            <asp:AsyncPostBackTrigger ControlID="ddlActivityStatus"  EventName="SelectedIndexChanged" />
                       </Triggers> 
           </asp:UpdatePanel>
            <ajaxToolkit:UpdatePanelAnimationExtender ID="upae" BehaviorID="animation" runat="server" TargetControlID="UpdatePanel3">
            <Animations>
                <OnUpdating>
                    <Sequence>
                       <Parallel duration="0.5">
                            <ScriptAction Script="onUpdating();" />
                            <EnableAction AnimationTarget="ddlActivityStatus" Enabled="false" />
                            <FadeOut minimumOpacity=".5" />
                            <FadeOut AnimationTarget="DivNotesDisplay" minimumOpacity=".5" />
                        </Parallel>
                        <StyleAction Attribute="overflow" Value="hidden" />
                    </Sequence>
                </OnUpdating>
                <OnUpdated>
                    <Sequence>
                       <Parallel duration="0.5">
                            <ScriptAction Script="onUpdated();" />
                            <EnableAction AnimationTarget="ddlActivityStatus" Enabled="true" />
                            <FadeIn minimumOpacity=".5" />
                            <FadeIn AnimationTarget="DivNotesDisplay" minimumOpacity="1" />
                      </Parallel>
                    </Sequence>
                </OnUpdated>
            </Animations>
        </ajaxToolkit:UpdatePanelAnimationExtender>
        </td>
        </tr>
   </table>
    </div>
    <div align="center" id="Attachment" style="display:none; border:0px solid black; position:absolute;left:25%; top:25%; width:50%; max-width:450px;height: 210px;z-index:11;">
		<table align="center"  cellpadding="0" cellspacing="0" style="width:100%;" class="MainAlertDiv">
			<tr>
			  <th height="21" valign="middle" align="left">&nbsp;Attachment(s)</th>
			  <th align="right" valign="top"><img src="../../images/closebox2.gif" onClick="OnAttachmentSubmit1(); return false;" style="cursor:pointer;"></th>
			</tr>
			<tr>
			<td width="100%" valign="top" colspan="2">
				<table align="center" width="100%" cellpadding="0" cellspacing="0" class="MainAlertDiv" style="width:100%;text-align:center;border:none;">
					 <tr>
						<td></td>
						<td align="right" height="25" style="padding-right:10px;"><a href="#" onclick="OnAttachmentSubmit(1);"><u>Remove All</u></a></td></tr>
					<tr>
					<td></td>
					<td  height="25">
					<div>
						<div>File 1: <input id="file1" type="file" runat="server" style="width:330px;"/></div>
                        <div style="text-align:left;padding-right:5px;padding-left:5px;"><asp:RegularExpressionValidator 
                            ID="REV_file1" runat="server" 
                            ErrorMessage="Attachment must be a .jpg, .jpeg, .png, .gif, .doc,.docx, .pdf, .txt, .rtf, .xls, .xlsx, .rar, or .zip file" 
                            ValidationExpression="^.*(.txt|.zip|.doc|.jpg|.jpeg|.png|.gif|.doc|.docx|.pdf|.rtf|.xls|.xlsx|.rar|.TXT|.ZIP|.DOC|.DOCX|.XLS|.XLSX|.JPG|.JPEG|.PNG|.GIF|.DOC|.DOCX|.XLS|.XLSX|.RAR|.PDF|.RTF)$"  
                            ValidationGroup="AttachmentGroup" 
                            Display="Dynamic"
                            ControlToValidate="file1" Font-Size="10px" >
                        </asp:RegularExpressionValidator></div>
                     </div>
                     <div>
						<div>File 2: <input id="file2" type="file" runat="server" style="width:330px;"/></div>
                        <div style="text-align:left;padding-right:5px;padding-left:5px;"><asp:RegularExpressionValidator 
                            id="REV_file2" runat="server" 
                            ErrorMessage="Attachment must be a .jpg, .jpeg, .png, .gif, .doc,.docx, .pdf, .txt, .rtf, .xls, .xlsx, .rar, or .zip file" 
                            ValidationExpression="^.*(.txt|.zip|.doc|.jpg|.jpeg|.png|.gif|.doc|.docx|.pdf|.rtf|.xls|.xlsx|.rar|.TXT|.ZIP|.DOC|.DOCX|.XLS|.XLSX|.JPG|.JPEG|.PNG|.GIF|.DOC|.DOCX|.XLS|.XLSX|.RAR|.PDF|.RTF)$" 
                            ValidationGroup="AttachmentGroup" 
                            Display="Dynamic"
                            ControlToValidate="file2" Font-Size="10px">
                        </asp:RegularExpressionValidator></div>
                     </div>
                     <div >
                     <div>File 3: <input id="file3" type="file" runat="server" style="width:330px;"/></div> 
                     <div style="text-align:left;padding-right:5px;padding-left:5px;"><asp:RegularExpressionValidator 
                            id="REV_file3" runat="server" 
                            ErrorMessage="Attachment must be a .jpg, .jpeg, .png, .gif, .doc,.docx, .pdf, .txt, .rtf, .xls, .xlsx, .rar, or .zip file" 
                            ValidationExpression="^.*(.txt|.zip|.doc|.jpg|.jpeg|.png|.gif|.doc|.docx|.pdf|.rtf|.xls|.xlsx|.rar|.TXT|.ZIP|.DOC|.DOCX|.XLS|.XLSX|.JPG|.JPEG|.PNG|.GIF|.DOC|.DOCX|.XLS|.XLSX|.RAR|.PDF|.RTF)$" 
                            ValidationGroup="AttachmentGroup" 
                            Display="Dynamic"
                            ControlToValidate="file3" Font-Size="10px">
                        </asp:RegularExpressionValidator></div>
                     </div>
					</td></tr>
					<tr><td colspan="2" height="30" align="center">
						<input id="BtnOk" type="button" value="OK" style="width:80px;"  onclick="OnAttachmentSubmit1();" class="Btn3D">
						</td>
					</tr>
				</table>
			</td>
			</tr>
			</table>
	</div>  

 </form>
<script language="javascript" type="text/javascript">
    function OnUserListChanged(CurrentUserId) { 
    }

function SearchUsers(txtsearch)
{
	var search = txtsearch.value.toLowerCase();
	//alert(search);
	if (search == 'search contacts...')
		search = '';
	
	 var dvClientContacts = document.getElementById('dvClientContacts');
	 var colldvClientContacts = dvClientContacts.getElementsByTagName('div'); //array
	 var colldvClientContactslength = colldvClientContacts.length;
	 var i = colldvClientContactslength;
	 
	  while(i--) 
	  {  
		 var result = colldvClientContacts[i].getElementsByTagName('label')[0].innerHTML.toLowerCase().search(search);
		 if(result > -1 || search.length == 0)
			colldvClientContacts[i].style.display = 'block';
		 else   
			colldvClientContacts[i].style.display = 'none';
	  }
	  return false;
}
function clearSearchUser() {
	var txtsearch = document.getElementById('<%=txtClientUserSearch.ClientID%>');
	txtsearch.value = '';

	var dvClientContacts = document.getElementById('dvClientContacts');
	var colldvClientContacts = dvClientContacts.getElementsByTagName('div'); //array
	var colldvClientContactslength = colldvClientContacts.length;
	var i = colldvClientContactslength;

	while (i--) {
		colldvClientContacts[i].style.display = 'block';
	}
}

function validateSameFiles(oSrc, args){
if ( (getElement('<%= File1.ClientID %>').value == getElement('<%= File2.ClientID %>').value && getElement('<%= File1.ClientID %>').value != '' && getElement('<%= File2.ClientID %>').value != '') || 
	 (getElement('<%= File1.ClientID %>').value == getElement('<%= File3.ClientID %>').value && getElement('<%= File1.ClientID %>').value != '' && getElement('<%= File3.ClientID %>').value != '') || 
	 (getElement('<%= File2.ClientID %>').value == getElement('<%= File3.ClientID %>').value && getElement('<%= File2.ClientID %>').value != '' && getElement('<%= File3.ClientID %>').value != '') )
   args.IsValid = false
else
   args.IsValid = true;
}
function validateFiles(oSrc, args){
if ( (getElement('<%= File1.ClientID %>').value == '') && 
	 (getElement('<%= File2.ClientID %>').value == '') &&
	 (getElement('<%= File3.ClientID %>').value == '') )
	args.IsValid = false
else
	args.IsValid = true;
}

function Notes()
{
   var ActivityState = document.getElementById('<%=ddlActivityStatus.ClientID %>')
   var isReadOnlyAccess = document.getElementById('<%=hdnIsReadOnlyAccess.ClientID %>').value;
   if(isReadOnlyAccess == 0){
		if(ActivityState.value != 5)
		 {
		   if (DivNotes.style.display=='none')
				{
					DivNotes.style.display = 'inline';
					document.getElementById('<%=btnAddNotes.ClientID%>').innerText = 'Cancel';
					document.getElementById('<%=txtNotes.ClientID%>').value = '';
					document.getElementById('<%=txtNotes.ClientID%>').focus();
				}
			else
				{
					DivNotes.style.display = 'none';
					document.getElementById('<%=btnAddNotes.ClientID%>').innerText = 'Add Notes';
					OnAttachmentSubmit(1);
					trFiles.style.display = 'none';
				}
		 }
  }
}
function activityStateChange()
	{           

	var ActivityState = document.getElementById('<%=ddlActivityStatus.ClientID %>')
	if (ActivityState.value == "5")
	{
		
		if (confirm("The Status has been selected as Compeletd.\n To confirm press OK, other wise Cancel") == false)
		{
			ActivityState.value = document.getElementById('<%=hdnPreValueStatus.ClientID %>').value
			return false;
		}
	}

}



function ResetAttachment2() {
	var Fupload = document.getElementById('<%=File2.ClientID%>');
	Fupload.select();
	n = Fupload.createTextRange();
	n.execCommand('delete');
	//	var TD = Fupload.parentElement;
	//	var str = TD.innerHTML;
	//	str = str.replace(Fupload.value, '');
	//	TD.innerHTML = str;
	Fupload.parentElement.innerHTML = Fupload.parentElement.innerHTML;
}
function ResetAttachment1() {

	var Fupload = document.getElementById('<%=File1.ClientID%>');
	Fupload.select();
	n = Fupload.createTextRange();
	n.execCommand('delete');
	Fupload.parentElement.innerHTML = Fupload.parentElement.innerHTML;
}
function ResetAttachment3() {

	var Fupload = document.getElementById('<%=File3.ClientID%>');
	Fupload.select();
	n = Fupload.createTextRange();
	n.execCommand('delete');
	Fupload.parentElement.innerHTML = Fupload.parentElement.innerHTML;
}
function showAttachFiles() {
document.getElementById("Attachment").style.display = 'inline';
document.getElementById("BtnOk").focus();
BlackDivDisplay();
}

function OnAttachmentSubmit1() {
if (Page_ClientValidate('AttachmentGroup') == false) {
alert('Please attach a valid file or remove it.')
return false;
}

BlackDivHide();
document.getElementById("Attachment").style.display = 'none';
document.getElementById("<%=btnattch.ClientID%>").focus();
var strFiles = '';
if (document.getElementById('<%=File1.ClientID%>').value != '')
strFiles += '<table style=\'display:inline;border:none;background-color:White;font-size:11px; \'><tr><td rowspan=2 style=\'border:none;background-color:White;\'>&nbsp;&nbsp;</td><td style=\'border:none;background-color:White;\'>' + trimFileName(getElement('file1').value.substr(getElement('file1').value.lastIndexOf("\\") + 1)) + '</td></tr><tr><td style=\'cursor:pointer;font-size:7px;border:none;background-color:White;\' align=right onClick=\'ResetAttachment1();OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>';
if (document.getElementById('<%=File2.ClientID%>').value != '')
strFiles += '<table style=\'display:inline;border:none;background-color:White;font-size:11px;\'><tr><td rowspan=2 style=\'border:none;background-color:White;\'>&nbsp;&nbsp;</td><td style=\'border:none;background-color:White;\'>' + trimFileName(getElement('file2').value.substr(getElement('file2').value.lastIndexOf("\\") + 1)) + '</td></tr><tr><td style=\'cursor:pointer;font-size:7px;border:none;background-color:White;\' align=right onClick=\'ResetAttachment2();OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>';
if (document.getElementById('<%=File3.ClientID%>').value != '')
strFiles += '<table style=\'display:inline;border:none;background-color:White;font-size:11px;\' ><tr><td rowspan=2 style=\'border:none;background-color:White;\'>&nbsp;&nbsp;</td><td style=\'border:none;background-color:White;\'>' + trimFileName(getElement('file3').value.substr(getElement('file3').value.lastIndexOf("\\") + 1)) + '</td></tr><tr><td style=\'cursor:pointer;font-size:7px;border:none;background-color:White;\' align=right onClick=\'ResetAttachment3();OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>';

if (strFiles == '') {
getElement('trFiles').style.display = 'none';
getElement('tdFiles').innerHTML = '';
}
else {
getElement('trFiles').style.display = 'inline';
getElement('tdFiles').innerHTML = strFiles;
}
strFiles = '';
}


function textCounter(field)
{

if (field.value.length > 500)        
field.value = field.value.substring(0, 500);
}

function ShowUpdateMessage()
{
document.getElementById('spnUpdateMessage').style.display = 'inline' ;       
setTimeout('HideUpdateMessage()' , 3000)
}

function HideUpdateMessage()
{       
document.getElementById('spnUpdateMessage').style.display = 'none' ;
}

function OnAttachmentSubmit(flagCancel) {
if (flagCancel == 1) {//Remove All
	ResetAttachment3(); ResetAttachment2(); ResetAttachment1();
	Page_ClientValidate('AttachmentGroup');	
	return false;
}

getElement('Attachment').style.display = 'none';
document.getElementById("<%=btnattch.ClientID%>").focus();
var strFiles = '';
if (document.getElementById('<%=File1.ClientID%>').value != '')
	strFiles += '<table style=\'display:inline;\' class=SimpleExSmallBold><tr><td rowspan=2 style=\'border:none;\'>&nbsp;&nbsp;</td><td style=\'border:none;\'>' + trimFileName(getElement('file1').value.substr(getElement('file1').value.lastIndexOf("\\") + 1)) + '</td></tr><tr><td style=\'cursor:pointer;font-size:7px;border:none;\' align=right onClick=\'ResetAttachment1();OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>';
if (document.getElementById('<%=File2.ClientID%>').value != '')
	strFiles += '<table style=\'display:inline;\' class=SimpleExSmallBold><tr><td rowspan=2 style=\'border:none;\'>&nbsp;&nbsp;</td><td style=\'border:none;\'>' + trimFileName(getElement('file2').value.substr(getElement('file2').value.lastIndexOf("\\") + 1)) + '</td></tr><tr><td style=\'cursor:pointer;font-size:7px;border:none;\' align=right onClick=\'ResetAttachment2();OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>';
if (document.getElementById('<%=File3.ClientID%>').value != '')
	strFiles += '<table style=\'display:inline;\' class=SimpleExSmallBold><tr><td rowspan=2 style=\'border:none;\'>&nbsp;&nbsp;</td><td style=\'border:none;\'>' + trimFileName(getElement('file3').value.substr(getElement('file3').value.lastIndexOf("\\") + 1)) + '</td></tr><tr><td style=\'cursor:pointer;font-size:7px;border:none;\' align=right onClick=\'ResetAttachment3();OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>';

if (strFiles == '') {
	getElement('trFiles').style.display = 'none';
	getElement('tdFiles').innerHTML = '';
}
else {
	getElement('trFiles').style.display = 'inline';
	getElement('tdFiles').innerHTML = strFiles;
}
strFiles = '';
}

function trimFileName(strFileName)
	{
		if (strFileName.length > 20)
			return strFileName.substr(0,20)+' ...';
		else
			return strFileName;
	}
function validateNotes()
{
	var ret = false;
	if (trim(document.getElementById('<%=txtNotes.ClientID%>').value) == '')
	{
		alert('Please enter some Notes.');
		ret = false
	}	
	else
	{
		ret = true;
	}
	return ret;
}

window.onload=function()
{   
 var ddlActivityStatus = getElement('<%= ddlActivityStatus.ClientID %>')          
	//ddlActivityStatus.style.display= "inline";
			  
}     
function onUpdating()
{
	var ddlActivityStatus = getElement('<%= ddlActivityStatus.ClientID %>')          		
	var btnBack = getElement('<%= btnBack.ClientID %>')  	
	var btnUpdateusers = getElement('<%= btnUpdateUsers.ClientID %>')
	var btnAddNotes = getElement('<%= btnAddNotes.ClientID %>')  
	var btnattch = getElement('btnattch')  
	var btnSave = getElement('<%= btnSave.ClientID %>') 
	ddlActivityStatus.disabled = true;		
	btnBack.disabled = true;
	
  
  if (btnUpdateusers != null)
  {                    
		btnUpdateusers.disabled = true;
  }
  if (btnAddNotes != null)
  {
		  btnAddNotes.disabled = true;
  }
  if (DivNotes.style.display = 'inline')
  {        
	  DivNotes.style.display = 'none';
	  DivNotesDisplay.style.height = '100%';
	 
	  document.getElementById('<%=btnAddNotes.ClientID%>').innerText = 'Add Notes';
  }
  getElement('img1').disabled = true; 
 
	 
}
function onUpdated()
{

	var ddlActivityStatus = getElement('<%= ddlActivityStatus.ClientID %>') 	
	var btnBack = getElement('<%= btnBack.ClientID %>')	
	var btnUpdateusers = getElement('<%= btnUpdateUsers.ClientID %>')
	var btnAddNotes = getElement('<%= btnAddNotes.ClientID %>')
	var btnattch = getElement('btnattch')
	var btnSave = getElement('<%= btnSave.ClientID %>')
	ddlActivityStatus.disabled = false;	
	btnBack.disabled = false;	
	   if (btnUpdateusers != null)
	{
		btnUpdateusers.disabled = false;
	}
	if (btnAddNotes != null)
	{
			btnAddNotes.disabled = false;
	} 
	if (DivNotes.style.display = 'inline')
	{        
		DivNotes.style.display = 'none';
		DivNotesDisplay.style.height = '100%';
		
		document.getElementById('<%=btnAddNotes.ClientID%>').innerText = 'Add Notes';
	}
						 
	getElement('img1').disabled = false;


}


//mainly used in show upload progress bar    
function OnSaveClientSide()
{
if (Page_ClientValidate('NotesAdd') && Page_ClientValidate('AttachmentGroup')) {
	if ((getElement('<%= File1.ClientID %>').value != '') ||
		(getElement('<%= File2.ClientID %>').value != '') ||
		(getElement('<%= File3.ClientID %>').value != '')) {
		var progress = document.getElementById('progress')
		progress.style.display = 'inline';
		BlackDivDisplay()
	}
	var ddlActivityStatus = getElement('<%= ddlActivityStatus.ClientID %>');
	if (ddlActivityStatus.value == 8 || ddlActivityStatus.value == 10)
	{
		ddlActivityStatus.value = 9;
	}
	return true;
	
}
else { return false; }
}
function BlackDivDisplay() {
var divDisable = getElement('divDisable');
divDisable.style.width = document.body.scrollWidth;
divDisable.style.height = document.body.scrollHeight;
divDisable.style.display = "Block";
}
function BlackDivHide() {
var divDisable = getElement('divDisable');
divDisable.style.width = 0
divDisable.style.height = 0
divDisable.style.display = 'none';
}
function OpenAttachment(Path){
	var IframeDownload = document.getElementById('IframeDownload');
	IframeDownload.src = Path;
}
function SelectStatusDDL(value) {
	var ddlActivityStatus = getElement('<%= ddlActivityStatus.ClientID %>');

	ddlActivityStatus.value = value;
	return true;
}
 </script>
</body>
</html>
