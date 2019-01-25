<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReleasesNew.aspx.vb" Inherits="PM_ReleasesNew"
	Theme="Default" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>Untitled Page</title>
	<link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
	<script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
	<script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
	<script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
	<meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=0.2)" />
	<meta http-equiv="Page-Enter" content="progid:DXImageTransform.Microsoft.Fade(Duration=0.2)" />
	<style type="text/css">
		.FormInnerTable td{background-color: #DEF7D6;vertical-align: middle;}
		.WhtLine{border-bottom: solid 1px white;height: 1px;}
		.WhtLine img{height: 1px;width: 1px;src: url('../../images/spacer.gif');}
	</style>
</head>
<body style="margin: 0px; background-color: #DAF5D6; height: 100%; width: 100%;">
	<form id="form1" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="400" />
<asp:HiddenField ID="PrevPage" runat="server" Value="0" />
	<table cellspacing="0" border="0" style="height: 100%; width: 100%;"class="FormTable">
		<tr>
			<td style="height: 31px; font-size: 13px; font-weight: bold; padding: 5px; border-bottom: 1px solid #609BD3;width: 100%;">
				New Release
			</td>
		</tr>
		<tr>
			<td align="center" style="vertical-align: top; height: 100%; width: 100%;">
				<div style="overflow: auto; height: 100%;">
					<table border="0" cellpadding="1" cellspacing="0" class="FormInnerTable" style="width: 100%;height: 100%;">
						<tr>
							<td style="width: 15%"></td>
							<td style="width: 35%"></td>
							<td style="width: 10%"></td>
							<td style="width: 40%"></td>
						</tr>
						<tr>
							<td  style="padding-left: 15px;">
								Name:<b class="RequiredField" >*</b>
							</td>
							<td>
								<asp:TextBox ID="txtName" runat="server" MaxLength="50" SkinID="GreenSmallTextbox" Width="200px"></asp:TextBox>
								<asp:RequiredFieldValidator ID="RFV_Name" runat="server" ControlToValidate="txtName"
									Display="Dynamic" ErrorMessage="<br/>Please Enter Name" SkinID="RequiredFieldValidation">
								</asp:RequiredFieldValidator>
								<asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" CssClass="ErrorMessage"></asp:Label>
							</td>
							<td >
								Status:<b class="RequiredField" >*</b>
							</td>
							<td>
								<asp:DropDownList ID="ddlStatus" runat="server" SkinID="SmallTextCombo" Width="200px"></asp:DropDownList>
								<asp:CompareValidator ID="CV_Status" runat="server" ControlToValidate="ddlStatus"
									Display="Dynamic" ErrorMessage="<br/>Please Select Status" Operator="GreaterThan"
									SkinID="CompareValidation" Type="Integer" ValueToCompare="0"></asp:CompareValidator>
							</td>
						</tr>
						<tr><td class="WhtLine" colspan="4"><img /></td></tr>
						<tr>
							<td  style="padding-left: 15px;">
								Client:<b class="RequiredField" >*</b>
							</td>
							<td>
								<asp:DropDownList ID="ddlClients" runat="server" DataSourceID="odsClients" DataTextField="Name"
									DataValueField="ID" SkinID="SmallTextCombo" Width="200px"  AutoPostBack="true"></asp:DropDownList>
								<asp:ObjectDataSource ID="odsClients" runat="server" TypeName="Portal.BLL.Users"
									SelectMethod="GetClientsByUserIDAndSubModuleIDs">
									<SelectParameters>
										<asp:SessionParameter Name="userId" Type="int32" SessionField="AdminID" />
									</SelectParameters>
								</asp:ObjectDataSource>
								<asp:CompareValidator ID="CV_Client" runat="server" ControlToValidate="ddlClients"
									Display="Dynamic" ErrorMessage="<br/>Please Select Client" Operator="GreaterThan"
									SkinID="CompareValidation" Type="Integer" ValueToCompare="0"></asp:CompareValidator>
							</td>
							<td nowrap="nowrap">
								<asp:UpdatePanel ID="upAreaDeveloperTitle" runat="server" RenderMode="Inline" UpdateMode="Conditional">
								    <ContentTemplate>
								        <span id="spnAreaDeveloper" style="display:none;" runat="server">Area Developer:</span>
								    </ContentTemplate>
								    <Triggers>
								        <asp:AsyncPostBackTrigger ControlID="ddlClients" EventName="SelectedIndexChanged" />
								    </Triggers>
								</asp:UpdatePanel>&nbsp;
								</td>
								<td>
								    <asp:UpdatePanel ID="upAreaDeveloper" runat="server" RenderMode="Inline" UpdateMode="Conditional">
								        <ContentTemplate>
								            <asp:DropDownList ID="ddlAreaDeveloper" CssClass="SmallFontInput" runat="server" Width="200px" style="display:none;" 
								                              DataSourceID="odsAreaDeveloper" DataTextField="CorporateName" DataValueField="ID">
                                            </asp:DropDownList>     
                                            <asp:ObjectDataSource ID="odsAreaDeveloper" runat="server" TypeName="Portal.BLL.AreaDeveloper"
										            SelectMethod="GetAllByClientId">
										        <SelectParameters>
										                <asp:ControlParameter ControlID="ddlClients" Name="ClientID" Type="Int32" />										
										        </SelectParameters>
									        </asp:ObjectDataSource>
								        </ContentTemplate>
								        <Triggers>
								            <asp:AsyncPostBackTrigger ControlID="ddlClients" EventName="SelectedIndexChanged" />
								        </Triggers>								        
								    </asp:UpdatePanel>                                    
								</td>									
						</tr>
						<tr><td class="WhtLine" colspan="4"><img /></td></tr>
						<tr>
							<td  style="padding-left: 15px;">
								Release Date:<b class="RequiredField" >*</b>
							</td>
							<td>
								<asp:TextBox ID="txtReleaseDate" runat="server" MaxLength="10" SkinID="GreenSmallTextbox"
									onfocus="imgRDCalender.click();" Width="173px"></asp:TextBox>
								<img id="imgRDCalender" align="absMiddle" border="0" onClick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtReleaseDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
									onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" />
								<asp:RequiredFieldValidator ID="RFV_ReleaseDate" runat="server" ControlToValidate="txtReleaseDate"
									Display="Dynamic" ErrorMessage="<br/>Please Enter Release Date" SkinID="RequiredFieldValidation">
								</asp:RequiredFieldValidator>
								<asp:RegularExpressionValidator ID="REV_DOB" runat="server" ControlToValidate="txtReleaseDate"
									Display="Dynamic" ErrorMessage="<br/>Date is not in Correct Format" ValidationExpression="^\d{1,2}\/\d{1,2}\/\d{2,4}$">
								</asp:RegularExpressionValidator>
								<asp:CompareValidator ID="CV_FutureDate" runat="server" Display="Dynamic" ControlToValidate="txtReleaseDate"
									Type="Date" Operator="GreaterThanEqual" ErrorMessage="<br/>Please Select a Future Date">
								</asp:CompareValidator>
							</td>
							<td >
								Category:<b class="RequiredField" >*</b>
							</td>
							<td>
								<asp:UpdatePanel ID="UPCategories" runat="server" RenderMode="Inline" UpdateMode="Conditional" >
									<ContentTemplate>
									<asp:DropDownList ID="ddlCategories" runat="server" DataSourceID="SDS_Categories"
										DataTextField="Name" DataValueField="ID" SkinID="SmallTextCombo" Width="200px"></asp:DropDownList>
									<asp:SqlDataSource ID="SDS_Categories" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
										SelectCommand="PM_Categories_Clients_GetAll" SelectCommandType="StoredProcedure" DataSourceMode="DataReader">
										<SelectParameters>
											<asp:ControlParameter ControlID="ddlClients" Name="ClientID" Type="Int32" />
										</SelectParameters>
									</asp:SqlDataSource>
									<asp:CompareValidator ID="CV_Category" runat="server" ControlToValidate="ddlCategories"
										Display="Dynamic" ErrorMessage="<br/>Please Select Category" Operator="GreaterThan"
										SkinID="CompareValidation" Type="Integer" ValueToCompare="0" />
									</ContentTemplate>
									<Triggers>
										<asp:AsyncPostBackTrigger ControlID="ddlClients" EventName="SelectedIndexChanged" />
									</Triggers>
									</asp:UpdatePanel>
							</td>
						</tr>
						<tr><td class="WhtLine" colspan="4"><img /></td></tr>
						<tr>
							<td colspan="4" style="text-align: center; height:100%;">
								<asp:TextBox ID="txtNotes" runat="server" MaxLength="500" Rows="15" SkinID="GreenMultilineTextbox"
									TextMode="MultiLine" Width="100%" Height="95%"></asp:TextBox>
								<asp:RegularExpressionValidator ID="REV_CheckCount" runat="server" ErrorMessage="Please Enter Characters Less Than 500"
									ControlToValidate="txtNotes" Display="Dynamic" ValidationExpression="^[\s\S]{1,500}$">
								</asp:RegularExpressionValidator>
							</td>
						</tr>
						<tr>
							<td colspan="4" style="text-align: center; height: 30px;">
								Fields marked with an asterisk <b class="RequiredField">*</b> are required.
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
		<tr>
			<td align="center" style="height: 31px; border-top: 1px solid #609BD3; vertical-align: middle;
				width: 100%;">
				<asp:Button ID="btnSave" runat="server" Text="Save" CssClass="Btn3D" Width="80px"
					CommandName="Insert" />&nbsp;&nbsp;
				<asp:Button ID="btnBack" runat="server" Text="Cancel" CausesValidation="false" CssClass="Btn3D" />
			</td>
		</tr>
	</table>
	</form>
	<!-- JavaScript -->
	<script language="javascript" type="text/javascript">
 
 
	</script>

</body>
</html>
