<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReleasesEdit.aspx.vb" Inherits="PM_ReleasesEdit" Theme ="Default"  %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title>Edit Release</title>
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
		.PL15{padding-left:15px;}
	</style>
</head>.<body  style ="margin :0px;background-color:#DAF5D6; height:100%; width:100%;" >
<form id="form1" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="400" />
<asp:HiddenField ID="ReleaseID" runat="server" />
<asp:HiddenField ID="hdnProgress" runat="server" />
	<table cellspacing="0" border="0" style="height:100%; width:100%;" class="FormTable">
	<tr>
		<td	style="height:31px;font-size:13px;padding:5px;border-bottom:1px solid #609BD3;">
			<b>Edit Release</b>
		</td>
	</tr>
	<tr >
	<td align="center" style="vertical-align:top; height:100%; width:100%;">
		<table border="0" cellpadding="0"  cellspacing="0" class="FormInnerTable" style="width:100%;  height:100%; text-align:left; vertical-align:top;" >
			<tr>
				<td style="width: 20%;height:0px;"></td>
				<td style="width: 30%"></td>
				<td style="width: 15%"></td>
				<td style="width: 35%"></td>
			</tr>
			<tr>
				<td class="PL15">Name:<b class="RequiredField" >*</b></td>
				<td><asp:TextBox ID="txtName" runat="server" MaxLength="50" SkinID="GreenSmallTextbox" Width="200px"></asp:TextBox>
					<asp:RequiredFieldValidator ID="RFV_Name" runat="server" ControlToValidate="txtName"
						Display="Dynamic" ErrorMessage="<br/>Please Enter Name" SkinID="RequiredFieldValidation"></asp:RequiredFieldValidator>
					<asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" CssClass="ErrorMessage"></asp:Label>
				</td>
				<td class="PL15">Status:<b class="RequiredField" >*</b><span></span></td>
				<td>
					<asp:DropDownList ID="ddlStatus" runat="server" 
						DataTextField="Name" DataValueField="ID" SkinID="SmallTextCombo" Width="200px">
					</asp:DropDownList>
					<asp:CompareValidator ID="CV_Status" runat="server" ControlToValidate="ddlStatus"
						Display="Dynamic" ErrorMessage="<br/>Please Select Status" Operator="GreaterThan"
						SkinID="CompareValidation" Type="Integer" ValueToCompare="0">
				  </asp:CompareValidator>
				 <asp:CustomValidator
						ID="val_StatusRelease"	ClientValidationFunction="validateStatus"
						ErrorMessage="<br/>Sorry you are not Allowed to mark Status as Released.<br/>Progress is not 100%."
						runat="server"	Display="Dynamic">
				  </asp:CustomValidator>
				</td>
			</tr>
			<tr><td class="WhtLine" colspan="4"><img /></td></tr>
			<tr>
				<td class="PL15">Client:<span><b class="RequiredField" >*</b></span></td>
				<td>
					<asp:DropDownList ID="ddlClients" runat="server" DataSourceID="odsClients"
						DataTextField="Name" DataValueField="ID" SkinID="SmallTextCombo" Width="200px" AutoPostBack="true">
					</asp:DropDownList>
					 <asp:ObjectDataSource ID="odsClients" runat="server" TypeName="Portal.BLL.Users" SelectMethod="GetClientsByUserIDAndSubModuleIDs">
						<SelectParameters>
							<asp:SessionParameter Name="userId" Type="int32" SessionField="AdminID" />
						</SelectParameters>
					</asp:ObjectDataSource>
					<asp:CompareValidator ID="CV_Client" runat="server" ControlToValidate="ddlClients"
						Display="Dynamic" ErrorMessage="<br/>Please Select Client" Operator="GreaterThan"
						SkinID="CompareValidation" Type="Integer" ValueToCompare="0"></asp:CompareValidator>
				</td>
				<td class="PL15">Category:<span><b class="RequiredField" >*</b></span></td>
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
				<td  class="PL15" style="white-space:nowrap;">New Release Date:</td>
				<td>
					<asp:TextBox ID="txtNewReleaseDate" runat="server" 
						MaxLength="10" SkinID="GreenSmallTextbox"
						onfocus="imgNRDCalender.click();"
						Width="173px">
					</asp:TextBox>
					<img id="imgNRDCalender" align="absMiddle" border="0" onclick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtNewReleaseDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
						onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" />
					<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtNewReleaseDate"
						Display="Dynamic" ErrorMessage="<br/>Date is not in Correct Format" ValidationExpression="^\d{1,2}\/\d{1,2}\/\d{2,4}$">
				  </asp:RegularExpressionValidator>
			<%--	  <asp:CompareValidator ID="CV_FutureDate" Display="Dynamic" runat="server" ControlToValidate="txtNewReleaseDate" type="Date"  Operator="GreaterThanEqual"
					  ErrorMessage="<br/>Please Select a Future Date">
					</asp:CompareValidator>--%>
				<%--<asp:CompareValidator ID="CV_GreaterDate" Display="Dynamic" runat="server" ControlToValidate="txtNewReleaseDate"  type="Date"  Operator="GreaterThan"
				ErrorMessage="<br/>Please Select a Date greater than Release Date">
				</asp:CompareValidator> --%>
				</td>
				<td  class="PL15" style="white-space:nowrap;">Release Date:</td>
				<td>
					<b><asp:label ID="lblReleaseDate" runat="server"></asp:label></b>
				</td>

			</tr>
			<tr style="display:none;">
				<td>Date Created:</td>
				<td><asp:Label ID="lblDateCreated" runat="server"></asp:Label></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td colspan="4" align="center" style="height:100%;">
					<asp:TextBox ID="txtNotes" runat="server" MaxLength="500" 
					Rows="17" SkinID="GreenMultilineTextbox" TextMode="MultiLine"
					Width="100%" Height="95%">
					</asp:TextBox>
					<asp:RegularExpressionValidator 
						ID="REV_CheckCount" 
						runat="server" 
						ErrorMessage="Please Enter Characters Less Than 500" 
						ControlToValidate="txtNotes" 
						Display="Dynamic" 
						ValidationExpression="^[\s\S]{1,500}$">
				 </asp:RegularExpressionValidator>
				</td>
			</tr>
			<tr>
				<td colspan="4" style="text-align: center;height:30px;">
					Fields marked with an asterisk <span class="RequiredField">*</span> are required.
				</td>
			</tr>
		 </table>
	</td>
	</tr>
	<tr>
		<td align="center" style="height:31px; border-top: 1px solid #609BD3;vertical-align: middle;">
			<asp:Button ID="btnSave" runat="server" Text="Save" CssClass="Btn3D" Width="80px"/>&nbsp;&nbsp;
			<asp:Button ID="btnBack" runat="server" Text="Cancel" CausesValidation="false" CssClass="Btn3D" />
		</td>
	  </tr>
	</table>
	</form>
 <script language="javascript" type="text/javascript">
function validateStatus(oSrc, args) {
	var ActivityState = document.getElementById('<%=ddlStatus.ClientID %>');
	var hdnrelProgress = document.getElementById('<%=hdnProgress.ClientID %>');

	if (ActivityState.value == "5" && hdnrelProgress.value < 100) {
		args.IsValid = false;
	}
	else {
		args.IsValid = true;
	}
}
 </script>
</body>
</html>
