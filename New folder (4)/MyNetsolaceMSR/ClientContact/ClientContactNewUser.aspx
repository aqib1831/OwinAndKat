<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ClientContactNewUser.aspx.vb" EnableViewState="true" Inherits="MyNetsolace_ClientContactNewUser"  Theme="default" ValidateRequest="false" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title></title>
	<link href="../../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" language="javascript" src="../../scripts/functions.js"></script>
	<script type="text/javascript" language="JavaScript" src="../../scripts/calendar.js"></script>
	<script type="text/javascript" language="JavaScript" src="../../scripts/calendar-en.js"></script>
	<script type="text/javascript" language="JavaScript" src="../../scripts/calendar-fs.js"></script>
	<style type="text/css">
		html, body {margin:0; padding:0; height:100%;width:100%;}
		.tblDetailContent{padding:0px;width:100%;font-size:12px;}
		.tblDetailContent thead tr th{height:32px !important;font-size:17px;padding:0px;padding-left:5px;vertical-align:middle;background-image:url(../../images/bg_mainHdr_1.jpg);background-position:left top; background-repeat:repeat-x;}
		.tblDetailContent tbody tr td{height:40px;color:#666666;text-align:left;vertical-align:top;}
		.tblDetailContent tbody tr td span{padding:0px;margin:0px;position:relative;float:left;}
		.tblDetailContent tfoot tr td{height:40px;border-top:solid 1px #01CC00;text-align:center;background-color:#F2F9F1;color:#666666;}
		
		.Inactive div,.Active div {color:black;width:110px;height:30px;font-size:17px;text-align:center;line-height:30px; vertical-align:baseline; background-image:url(../images/statusbg_active.gif);background-repeat:repeat-x;background-position:center top;}
		.Inactive div span,.Active div span {position:relative;top:7px;}
		.Inactive div img,.Active div img {position:relative;top:5px;}
		.Inactive div{background-image:url(../images/statusbg_inactive.gif);}
		.ActiveUserDarkGreen {border:solid 3px #63C163; font-size:15px;font-weight:bold;color:#000000;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#FCFEFB,endColorStr=#E2F1DE);}
		.ActiveUserDarkGreen th{background-color:#63C163;color:#ffffff;padding-left:5px;font-size:15px;}
		
		.InActiveUserDarkRed{border:solid 3px #A44B51;font-size:15px;font-weight:bold;color:#000000;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#FCFEFB,endColorStr=#E2F1DE);}
		.InActiveUserDarkRed th{background-color:#A44B51;color:#ffffff;padding-left:5px;font-size:15px;}
		
	</style>
</head>
<body>
	<form id="form1" runat="server">
	<asp:HiddenField ID="hdnUserID" runat="server" />
	<asp:HiddenField ID="UserID" runat="server" />
	<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
	
	<table border="0" cellpadding="0" cellspacing="0" style="width:100%;height:100%;padding:0px;margin:0px;border-left:solid 2px #649DD4;background-color:#E0F2DA;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#ffffff,endColorStr=#E0F2DA);">
		<tr>
			<td style="height:32px;vertical-align:top;">
				<table class="tblDetailContent" border="0" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<th align="left"><asp:Label ID="lblDisplayHeader" runat="server"></asp:Label> <asp:Label ID="lblUserName" Visible="false" runat="server"></asp:Label></th>
							<th align="right">
							<asp:UpdatePanel ID="UpdatePanel2" runat="server" RenderMode="Block" UpdateMode="Conditional">
								<ContentTemplate>

								<asp:LinkButton ID="Btnactive" runat="server" class="Active"  OnClientClick="ShowInactive(); return false;" CausesValidation="false">
									<div><span>Active</span> <img src="../images/arrowDown.gif" /></div>
								</asp:LinkButton>
								<asp:LinkButton ID="BtnInactive" runat="server" class="Inactive" OnClientClick="ShowActive(); return false;" CausesValidation="false">
									<div><span>Inactive</span> <img src="../images/arrowDown.gif" /></div>
								</asp:LinkButton>
							</ContentTemplate>
							<Triggers>
								<asp:AsyncPostBackTrigger ControlID="btnUpdateUserStatus" EventName="Click" />
							</Triggers>
							</asp:UpdatePanel>
							</th>
						</tr>
					</thead>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top" style="padding:0px;margin:0px;padding-top:10px;padding-left:60px;" align="center">
				<table class="tblDetailContent" border="0" cellpadding="0"  cellspacing="0" style="width:800px;" bgcolor="">
								<tbody>
								<tr>
									<td style="width:148px;">First Name: <b class="RequiredField">*</b></td>
									<td style="width:206px;">
										<asp:TextBox ID="txtFirstName" runat="server" 
											MaxLength="50" Width="200px"></asp:TextBox>
										<asp:RequiredFieldValidator ID="RFV_FirstName" runat="server" 
											ControlToValidate="txtFirstName" Display="Dynamic"
											ErrorMessage="Please Enter First Name"  SkinID="RequiredFieldValidation">
										</asp:RequiredFieldValidator>
									</td>
									<td style="width:35px;">&nbsp;</td>
									<td style="width:164px;">Middle Name:</td>
									<td style="width:248px;">
										<asp:TextBox ID="txtMiddleName" runat="server" MaxLength="50" Width="200px"></asp:TextBox>
									</td>
								
								</tr>
								<tr>

									<td>Last Name: <b class="RequiredField">*</b></td>
									<td>
										<asp:TextBox ID="txtLastName" runat="server" MaxLength="50" Width="200px"></asp:TextBox>
										<asp:RequiredFieldValidator ID="RFV_LastName" runat="server" ControlToValidate="txtLastName"
											Display="Dynamic" ErrorMessage="Please Enter Last Name" SkinID="RequiredFieldValidation">
										</asp:RequiredFieldValidator>
									</td>
									<td>&nbsp;</td>
									<td>User&nbsp;Name:  <b class="RequiredField">*</b></td>
									<td style="white-space:nowrap;">
									<asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
										<ContentTemplate>
										<asp:TextBox ID="txtUserName" runat="server" MaxLength="50" Width="200px" ></asp:TextBox>
										<asp:RequiredFieldValidator ID="RFV_txtUserName" runat="server" ControlToValidate="txtUserName"
											Display="Dynamic" ErrorMessage="Please Enter User Name" SkinID="RequiredFieldValidation">
										</asp:RequiredFieldValidator>
										<asp:Label ID="lblErrorMessage" runat="server" CssClass="ErrorMessage" ForeColor="Red"></asp:Label>
										
										<br /><asp:LinkButton ID="LbtnResetPassword" runat="server" text="[Reset Password]" Visible="false" OnClientClick="if(confirm('Are you sure you want to reset password ?') == false) return false;"></asp:LinkButton>
										</ContentTemplate>
										<Triggers>
											<asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
										</Triggers>
									</asp:UpdatePanel>
									</td>
									
								</tr>
								<tr>
									<td >&nbsp;Job Tilte:</td>
									<td>
										<asp:TextBox ID="txtJobtitle" runat="server" MaxLength="50" Width="200px" ></asp:TextBox>
									</td>
									<td style="width:30px;">&nbsp;</td>
									<td>User Type: <b class="RequiredField">*</b></td>
									<td>
										<asp:DropDownList ID="ddlUserType" runat="server"
											 SkinID="SmallTextCombo" Width="200px">
											 <asp:ListItem Text="Select..." Value="Null"></asp:ListItem>
											 <asp:ListItem Text="Admin" Value="True"></asp:ListItem>
											<asp:ListItem Text="No Admin" Value="False"></asp:ListItem>
										</asp:DropDownList>
										<asp:CompareValidator ID="CV_ddlUserType" runat="server" ControlToValidate="ddlUserType"
												Display="Dynamic" ErrorMessage="Please Select User Type" Operator="NotEqual"
												SkinID="CompareValidation" Type="String" ValueToCompare="Null">
										</asp:CompareValidator>
									</td>
								</tr>
								<tr>
									<td >Address 1: <b class="RequiredField">*</b></td>
									<td>
										<asp:TextBox ID="txtAddress" runat="server" MaxLength="200"
											TextMode="SingleLine" Width="200px"></asp:TextBox>
										<asp:RequiredFieldValidator ID="REV_txtAddress" runat="server" 
											ControlToValidate="txtAddress"
											Display="Dynamic" 
											ErrorMessage="Please Enter Address"
											SkinID="RequiredFieldValidation">
										 </asp:RequiredFieldValidator>
										<asp:RegularExpressionValidator 
											ID="REV_CheckCount" 
											runat="server" 
											ErrorMessage="Please Enter Characters Less Than 500" 
											ControlToValidate="txtAddress" 
											Display="Dynamic" 
											ValidationExpression="^[\s\S]{1,500}$">
										</asp:RegularExpressionValidator>
									</td>
									<td>&nbsp;</td>
									<td>Address 2:</td>
									<td>
										<asp:TextBox ID="txtAddress2" runat="server" MaxLength="200"
											TextMode="SingleLine" Width="200px"></asp:TextBox>
									</td>
								</tr>
								<tr>
									<td valign="top">City:</td>
									<td valign="top">
										<asp:TextBox ID="txtCity" runat="server" MaxLength="50" Width="200px" ></asp:TextBox>
									</td>
									<td>&nbsp;</td>
									<td >Zip:</td>
									<td>
										<asp:TextBox ID="txtZip" runat="server" MaxLength="50" Width="200px"></asp:TextBox>
										<asp:RegularExpressionValidator ID="REV_txtZip" runat="server" ControlToValidate="txtZip"
											Display="Dynamic" Enabled="false" ErrorMessage="Please Enter Valid Zip Code" ValidationExpression="\d{5}(-\d{4})?">
										</asp:RegularExpressionValidator>
									</td>
									
								</tr>
								<tr>
									<td >Country:  <b class="RequiredField">*</b></td>
									<td>
										<asp:DropDownList 
											ID="ddlCountry" 
											runat="server" 
											AutoPostBack="true"    
											DataSourceID="SqlDSCountries"
											DataTextField="Name" 
											DataValueField="ID" 
											SkinID="SmallTextCombo"
											Width="200px" >
										</asp:DropDownList>
										<asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddlCountry"
												Display="Dynamic" ErrorMessage="Please Select Country" Operator="GreaterThan"
												SkinID="CompareValidation" Type="Integer" ValueToCompare="0">
										</asp:CompareValidator>
										<asp:SqlDataSource ID="SqlDSCountries" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
											SelectCommand="Countries_GetAll" 
											SelectCommandType="StoredProcedure"
											DataSourceMode="DataReader">
										</asp:SqlDataSource>
									</td>
									<td style="width:30px;">&nbsp;</td>
									<td> State: <b class="RequiredField">*</b></td>
									<td>
										<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
										<ContentTemplate>
										<asp:DropDownList
											ID="ddlStates" 
											runat="server" 
											DataTextField="Name" 
											DataValueField="ID"
											SkinID="SmallTextCombo" 
											DataSourceID = "SqlDSStates"
											EnableViewState="true"
											Width="200px">
										</asp:DropDownList>
										<asp:CompareValidator ID="CV_st" runat="server" 
											ErrorMessage="Please Select State" ControlToValidate="ddlStates" Display="Dynamic" Operator="GreaterThan" SkinID="CompareValidation" ValueToCompare="0"></asp:CompareValidator>
										<asp:SqlDataSource ID="SqlDSStates" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
											SelectCommand="States_GetByCountryID" 
											SelectCommandType="StoredProcedure" 
											DataSourceMode="DataReader">
											<SelectParameters>
												<asp:ControlParameter ControlID="ddlCountry" DefaultValue="1" Name="CountryID" PropertyName="SelectedValue" Type="Int32" />
											</SelectParameters>
										</asp:SqlDataSource>
										</ContentTemplate>
										<Triggers>
											<asp:AsyncPostBackTrigger ControlID="ddlCountry" EventName="SelectedIndexChanged" />
										</Triggers>
									</asp:UpdatePanel>
									</td>
								</tr>
								<tr>

									<td>Gender: <b class="RequiredField">*</b></td>
									<td>
										<asp:DropDownList ID="ddlGender" runat="server"
											 SkinID="SmallTextCombo" Width="200px">
											 <asp:ListItem Text="Select..." Value="Null"></asp:ListItem>
											 <asp:ListItem Text="Male" Value="False"></asp:ListItem>
											<asp:ListItem Text="Female" Value="True"></asp:ListItem>
										</asp:DropDownList>
										<asp:CompareValidator ID="CV_ddlGender" runat="server" ControlToValidate="ddlGender"
												Display="Dynamic" ErrorMessage="Please Select Gender." Operator="NotEqual"
												SkinID="CompareValidation" Type="String" ValueToCompare="Null">
										</asp:CompareValidator>
									</td>
									<td style="width:30px;">&nbsp;</td>
									<td>Work Phone: <b class="RequiredField">*</b></td>
									<td style="text-align: left; width:324px;" valign="top">
										<asp:TextBox ID="txtWorkPhone" runat="server" MaxLength="20"
											 Width="200px"></asp:TextBox>
										<asp:RequiredFieldValidator ID="RFV_WorkPhone" runat="server" 
											ControlToValidate="txtWorkPhone"
											Display="Dynamic" 
											ErrorMessage="Please Enter Work Phone" 
											SkinID="RequiredFieldValidation">
										 </asp:RequiredFieldValidator>
									</td>
									
								</tr>
								<tr>

									<td >Home Phone:</td>
									<td>
										<asp:TextBox ID="txtHomePhone" runat="server" MaxLength="20" Width="200px"></asp:TextBox>
									</td>
									<td>&nbsp;</td>
									<td>Cell Phone:</td>
									<td>
										<asp:TextBox ID="txtCellPhone" runat="server" MaxLength="20" Width="200px"></asp:TextBox>
									</td>

								</tr>
								
								<tr>
									<td >Email1: <b class="RequiredField">*</b></td>
									<td>
										<asp:TextBox ID="txtEmail" runat="server" MaxLength="50" Width="200px" ></asp:TextBox>
										<asp:RequiredFieldValidator ID="RequiredFieldValidator3"
											runat="server" 
											ControlToValidate="txtEmail"
											Display="Dynamic" 
											ErrorMessage="Please Enter Email" 
											SkinID="RequiredFieldValidation">
										</asp:RequiredFieldValidator>
										<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
											ControlToValidate="txtEmail"
											Display="Dynamic" ErrorMessage="Please Enter valid Email" 
											ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
										</asp:RegularExpressionValidator></td>
									<td>&nbsp;</td>
									<td>Email2:</td>
									<td>
										<asp:TextBox ID="txtEmail2" runat="server" MaxLength="50" Width="200px"></asp:TextBox>
										<asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtEmail2"
											Display="Dynamic" ErrorMessage="Please Enter valid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
										<asp:CompareValidator ID="CV_Duplicate" runat="server" ControlToValidate="txtEmail2" ControlToCompare="txtEmail"
												Display="Dynamic" ErrorMessage="Please Enter Different Email." Operator="NotEqual" 
												SkinID="CompareValidation" Type="String">
										</asp:CompareValidator>
									</td>
								</tr>
								<tr>
									<td >Fax:</td>
									<td>
										<asp:TextBox ID="txtFax" runat="server" MaxLength="25" Width="200px"></asp:TextBox>
									</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;
										<asp:DropDownList ID="ddlStatus" runat="server" SkinID="SmallTextCombo" Width="200px" Visible="False">
											<asp:ListItem Text="Select..." Value="Null"></asp:ListItem>
											<asp:ListItem Text="Active" Value="False" ></asp:ListItem>
											<asp:ListItem Text="InActive" Value="True"></asp:ListItem>
										</asp:DropDownList>

										<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
											DataSourceMode="DataReader" SelectCommand="Client_GetByUserID" SelectCommandType="StoredProcedure">
										</asp:SqlDataSource>
									</td>

								</tr>
								</tbody>
							</table>
			</td>
		</tr>
		<tr>
			<td style="height:40px;vertical-align:bottom;">
				<table class="tblDetailContent" border="0" cellpadding="0"  cellspacing="0">
					<tfoot>
					<tr>
						<td align="center" style="background-color:Transparent;border-top:0px;height:20px;">
							Fields marked with an asterisk <span style="color: #ff0000">*</span> are required.
						</td>
					</tr>
					<tr>
						<td align="center">
							<asp:ImageButton ID="btnSave" 
							runat="server" Text="Save"
							ImageUrl="../images/btn_Save.gif"
							ImageAlign="Bottom" />&nbsp;&nbsp;
							<input type="image"
							src="../images/btn_CancelSmall.gif"
							id="btnback" value="Cancel" runat="server"
							style="background-image:url(../images/btn_CancelSmall.gif);background-repeat:no-repeat;background-position:center bottom;"
							onclick="javascript:window.location='ClientContactUser.aspx'; return false;"/>
						</td>
					</tr>
					</tfoot>
				</table>
			</td>
		</tr>
	</table>


	<asp:UpdatePanel ID="pnlUpdateActions" runat="server" RenderMode="Block" UpdateMode="Conditional">
	<ContentTemplate>
	<div id="divUserStatus" visible="true" style="width:300px; height:300px; position:absolute;top:29px;right:0px;display:none;">
		<asp:Panel ID="pnlInActive" runat="server" DefaultButton="btnUpdateUserStatus">
		<table id="tblUserStatus" cellpadding="0" cellspacing="0" border="0" style="width:100%; height:100%;">
			<tr style="height:20px; padding:3px;">
				<th align="left" style="height: 20px;vertical-align:middle;">  
					 <label id="lblUserStatus"></label>
				</th>
				<th align="right" style="height:20px"><span onclick="CloseInActiveUser();" style="cursor:pointer;">X</span></th>
			</tr>
			<tr>
				<td colspan="2" valign="top" style="width:100%; height:100%; padding:10px;">

					<span class="BoldText" style="padding-top:10px;padding-bottom:10px;">Reason for <label id="lblStatusText"></label>:  <b class="RequiredField">*</b></span>
					 <asp:TextBox ID="txtUserStatus" runat="server" MaxLength="100" TextMode="MultiLine" style="height:250px; width:280px; padding-left:5px; font-family:Verdana; font-size:12px; " ValidationGroup="vgUserStatus"></asp:TextBox>
					 <asp:RequiredFieldValidator ID="rfvUserStatus" runat="server" ValidationGroup="vgUserStatus" ErrorMessage="Reason is required" Display="Static"  ControlToValidate="txtUserStatus"></asp:RequiredFieldValidator>
				</td>
			</tr>
			<tr style="height:20px;">
				<td colspan="2" align="center" style="padding:5px;background-color:#F2F9F1;height:40px;border-top:solid 1px #01CC00;">
					<asp:ImageButton ID="btnUpdateUserStatus" runat="server" ValidationGroup="vgUserStatus" Text="OK" runat="server" ImageUrl="../images/btn_Save.gif"
						ImageAlign="Bottom" />
					<input type="image" value="Cancel" src="../images/btn_CancelSmall.gif" style="background-image:url(../images/btn_CancelSmall.gif);background-repeat:no-repeat;background-position:center bottom;" id="btnCancelCategory" onclick="CloseInActiveUser(); return false;" />
				</td>
			</tr> 
		</table>
		</asp:Panel>
	</div>
	</ContentTemplate>
	<Triggers>
		<asp:AsyncPostBackTrigger ControlID="btnUpdateUserStatus" EventName="Click" />
	</Triggers>
	</asp:UpdatePanel>
<%--	<asp:UpdatePanel ID="pnlUpdateActions" runat="server">
	<ContentTemplate>
	<div onmouseover="OtherLinks_onClick(null,'show'); AutoHide('In');" onmouseout="AutoHide('Out');" id="mnuMore" style="display: none;
			padding: 2px; width: 100px; position: absolute; z-index:100px; background-color: #C9DFF9; border: 1px solid #88C4FA;
			font-size: 11px; font-family: Arial; color: #305872;">
			<div id="divSuspend" class="menuNr" onmouseover="this.className='menuHi';"
				onmouseout="this.className='menuNr';" onclick="ShowInActiveUser();">
			  <asp:LinkButton ID="lnkBtnStatus" runat="server" Text="Active" OnClientClick=""></asp:LinkButton>
			  </div>
			
	</ContentTemplate>
	<Triggers>
			
	</Triggers>
	</asp:UpdatePanel>--%>
	
	</form>
	<script language="javascript" type="text/javascript">

	 var x = null;
	 var y = null;
	 
	var timerID = null;
	function AutoHide(mode)
	{    
		 if (mode == "In")
		 {
			if (timerID !== null)
			{
				window.clearInterval(timerID);
			}
		}
		else
		{
			timerID = window.setTimeout('OtherLinks_onClick(null,"hide");',500);
		}
	}  
	 function HideMenu()
	 {
		mnuMore.style.display='none';
	 }
   
	function OtherLinks_onClick(img,view){
		// view = "show" | "hide"
		if (view == ''){
			if (document.getElementById("mnuMore").style.display == 'none'){
				document.getElementById("mnuMore").style.display=""; 
			}else{
				document.getElementById("mnuMore").style.display="none";
			}
		}else{
			if (view == 'show'){
				document.getElementById("mnuMore").style.display="";
			}else{
				document.getElementById("mnuMore").style.display="none";
			}
		}
	 
	 }


	function ShowActive(){
			var ID  = document.getElementById('<%=btnInactive.ClientID%>');
			var width = document.body.scrollWidth;
			findPos(ID);
			divUserStatus.style.right = width - x - 110;
			divUserStatus.style.top = y + 31;
			divUserStatus.style.display='inline';
			tblUserStatus.className = "ActiveUserDarkGreen";
			lblStatusText.innerText = "Activation";
			lblUserStatus.innerText = "Activate User";
			ID.getElementsByTagName('div')[0].getElementsByTagName('img')[0].src = '../images/arrowUp.gif';

			
		}

		function ShowInactive() {
			var ID = document.getElementById('<%=btnActive.ClientID%>');
			var width = document.body.scrollWidth;
			findPos(ID);
			divUserStatus.style.right = width - x - 110;
			divUserStatus.style.top = y + 31;
			divUserStatus.style.display = 'inline';
			tblUserStatus.className = "InActiveUserDarkRed";
			lblStatusText.innerText = "Inactivation";
			lblUserStatus.innerText = "Inactivate User";
			ID.getElementsByTagName('div')[0].getElementsByTagName('img')[0].src = '../images/arrowUp.gif';

		}


	function findPos(obj)
		{
		 var left = !!obj.offsetLeft ? obj.offsetLeft : 0;
		 var top = !!obj.offsetTop ? obj.offsetTop : 0;

		 while(obj = obj.offsetParent)
		 {
		  left += !!obj.offsetLeft ? obj.offsetLeft : 0;
		  top += !!obj.offsetTop ? obj.offsetTop : 0;
		 }
		 x = left;
		 y = top;
		}
		function CloseInActiveUser(){
			//divActions.className="";
			var ID = null;
		ID= document.getElementById('<%=btnInactive.ClientID%>');
		if (ID == null)
			ID = document.getElementById('<%=btnActive.ClientID%>');
			
		ID.getElementsByTagName('div')[0].getElementsByTagName('img')[0].src = '../images/arrowDown.gif';
		divUserStatus.style.display='none';
		//getElement('btnActions').innerText = 'Actions';
	   }
	
	</script>
</body>
</html>