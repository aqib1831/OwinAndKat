<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ClientContactNewUser.aspx.vb" Inherits="MyNetsolace_ClientContactNewUser"  Theme="default" ValidateRequest="false" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
	<title></title>	
</head>
<body style="margin:0px;"> 
	<form id="form1" runat="server">
	<asp:HiddenField ID="hdnUserID" runat="server" />
	<asp:HiddenField ID="UserID" runat="server" />	
	<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>	
	
	    <table border="0" cellpadding="0" cellspacing="0" style="width:100%;height:100%;border-left:solid 2px #649DD4;background-color:#E0F2DA;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#ffffff,endColorStr=#E0F2DA);">
	    <asp:UpdatePanel ID="upInactiveLog" runat="server" UpdateMode="Always" RenderMode="Inline">
	        <ContentTemplate>
	            <asp:HiddenField ID="hdnIsInactive" runat="server" Value="" />
	            <tr id="trInactiveHold" runat="server" visible="false" style="padding: 2 3 0 3 px;">
                    <td  align="center" colspan="2" style="vertical-align:top;height:30px;">
                        <table class="tdInActive" cellpadding="0" cellspacing="0" border="0" style="width:100%;">
                            <tr>
                                <td align="left">
                                    &nbsp;<asp:Image ID="Image2" runat="server" ImageUrl="~/images/icon_alert_red.gif" style="padding-left:2px;" ImageAlign="AbsMiddle" />&nbsp;
                                    <span id="spInactiveHold" style="font-weight:bold;">INACTIVE</span>
                                    
                                </td>
                                <td valign="middle" align="right" style="padding-right:2px; vertical-align:middle; color:Black;">
                                    <span>InActivated By:</span>
                                    <span title='<%= lblStatusChangedBy.Text %>'><asp:Label ID="lblStatusChangedBy" runat="server"></asp:Label></span>
                                    <span>on <asp:Label ID="lblStatusChangedDate" runat="server"></asp:Label></span>
                                    <span><input type="button" class="btnSimple" style="width:80px;" value="Why Inactive?" onClick="ShowWhyInActive();" id="Button2" /></span>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>      
	        </ContentTemplate>
	    </asp:UpdatePanel>	   
		<tr>
			<td style="height:32px;vertical-align:top;">
				<table class="tblDetailContent" style="width:100%;" border="0" cellpadding="0" cellspacing="0">				   
					<tr style="background-image: url('../../images/bg_mainHdr_1.jpg'); height: 30px;">
						<th align="left">&nbsp;<asp:Label ID="lblDisplayHeader" runat="server"></asp:Label><asp:Label ID="lblUserName" Visible="false" runat="server"></asp:Label></th>
						<th align="right">
							<asp:LinkButton ID="Btnactive" runat="server" class="Active"  OnClientClick="ShowInactive(); return false;" CausesValidation="false">
								<div><span>Active</span> <img src="../images/arrowDown.gif" /></div>
							</asp:LinkButton>
							<asp:LinkButton ID="BtnInactive" runat="server" class="Inactive" OnClientClick="ShowActive(); return false;" CausesValidation="false">
								<div><span>Inactive</span> <img src="../images/arrowDown.gif" /></div>
							</asp:LinkButton>
						</th>
					</tr>				
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top" style="padding-top:15px;">
			 <div style="width: 100%; height: 100%; overflow-y: auto;" class="DivScroll">
				<table border="0" cellpadding="0"  cellspacing="0" style="width:800px;" align="center" class="tblDetailContent">
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
					<td>User Name:  <b class="RequiredField">*</b></td>
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
					<td >&nbsp;Job Title:</td>
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
							<asp:ListItem Text="User" Value="False"></asp:ListItem>
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
					<td style='display:<%= IIf(hdnHasMarkTicketForApprovalByClientId.Value = "True" , "inline", "none")%>'>PM Ticket Access:</td>
					<td><span style='display:<%= IIf(hdnHasMarkTicketForApprovalByClientId.Value = "True" , "inline", "none")%>'>
					        <asp:CheckBox ID="chkHasPMFullAccess" runat="server" Text="Read & Write" /><br />
                            <asp:CheckBox ID="chkHasTicketApprovalAccess" runat="server" Text="Pending Approval" />
                        </span>
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
			    </div>
		 </td>
        </tr>            
            <tr>
			<td style="height:40px;vertical-align:bottom;">
				<table class="tblDetailContent" border="0" cellpadding="0"  cellspacing="0">
                    <tr>
                        <td style="text-align: center;">
                            Fields marked with an asterisk&nbsp;<div style="display:inline;color:Red;">*</div>&nbsp;are required.
                        </td>
                    </tr>
                    <tfoot>					
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
	
	<asp:HiddenField ID="hdnHasMarkTicketForApprovalByClientId" runat="server" Value="0" />
	
		
	<div id="divUserStatus" visible="true" style="width:300px; height:300px; position:absolute;top:20px;right:0px;display:none;">
		<asp:Panel ID="pnlInActive" runat="server" DefaultButton="btnUpdateUserStatus">
		<table id="tblUserStatus" cellpadding="0" cellspacing="0" border="0" style="width:100%; height:100%;">
			<tr style="height:20px; padding:3px;">
				<th align="left" style="height: 20px;vertical-align:middle;">  
					 <label id="lblUserStatus"></label>
				</th>
				<th align="right" style="height:20px"><span onClick="CloseInActiveUser();" style="cursor:pointer;">X</span></th>
			</tr>
			<tr>
				<td colspan="2" valign="top" style="width:100%; height:100%; padding:10px;">
					<span class="BoldText" style="padding-top:10px;padding-bottom:10px;">Reason:<b class="RequiredField">*</b></span>
					 <asp:TextBox ID="txtUserStatus" runat="server" MaxLength="100" TextMode="MultiLine" style="height:250px; width:280px; padding-left:5px; font-family:Verdana; font-size:12px; " ValidationGroup="vgUserStatus"></asp:TextBox>
					 <asp:RequiredFieldValidator ID="rfvUserStatus" runat="server" ValidationGroup="vgUserStatus" ErrorMessage="Reason is required" Display="Static"  ControlToValidate="txtUserStatus"></asp:RequiredFieldValidator>
				</td>
			</tr>
			<tr style="height:20px;">
				<td colspan="2" align="center" style="padding:5px;background-color:#F2F9F1;height:40px;border-top:solid 1px #01CC00;">
					<asp:ImageButton ID="btnUpdateUserStatus" runat="server" ValidationGroup="vgUserStatus" Text="OK" runat="server" ImageUrl="../images/btn_Save.gif"
						ImageAlign="Bottom" />
					<input type="image" value="Cancel" src="../images/btn_CancelSmall.gif" style="background-image:url(../images/btn_CancelSmall.gif);background-repeat:no-repeat;background-position:center bottom;" id="btnCancelCategory" onClick="CloseInActiveUser(); return false;" />
				</td>
			</tr> 
		</table>
		</asp:Panel>
	</div>
	<div id="divWhyInActive" style="background-color:#fff; border:solid 1px #000; display:none; position:absolute; color:#fff; height:150px; width:400px; left:25%; top:35%;">
       <table cellpadding="0" cellspacing="0" border="0" style="width:100%; height:150px;" class="MessageUsers">
           <tr>
                <th colspan="2" style="height:15px;">Reason for Inactive <%= lblUserName.Text  %></th>
           </tr>
           <tr style="height:100%;">
                <td align="left" style="font-size:12px; width:10px;  padding: 15 5 5 5; vertical-align:top;"> 
                    <img align="absmiddle" src="../../images/icn_info.jpg" />
                </td>
                <td align="left" style="text-align:left; vertical-align:top; padding: 10 5 5 5; height:100%; width:100%;">
                        <asp:Literal ID="ltrlReason" runat="server"></asp:Literal> 
                </td>
           </tr>       
           <tr style="padding-bottom:8px;">
                <td colspan="2" align="center"><input type="button" class="btnSimple" style="width:60px;" value="Ok" onClick="HideWhyInActive();"/> </td>
           </tr>
        </table>
    </div>
	</form>
	<script language="javascript" type="text/javascript">

	    var x = null;
	    var y = null;

	    var timerID = null;
	    function AutoHide(mode) {
	        if (mode == "In") {
	            if (timerID !== null) {
	                window.clearInterval(timerID);
	            }
	        }
	        else {
	            timerID = window.setTimeout('OtherLinks_onClick(null,"hide");', 500);
	        }
	    }
	    function HideMenu() {
	        mnuMore.style.display = 'none';
	    }

	    function OtherLinks_onClick(img, view) {
	        // view = "show" | "hide"
	        if (view == '') {
	            if (document.getElementById("mnuMore").style.display == 'none') {
	                document.getElementById("mnuMore").style.display = "";
	            } else {
	                document.getElementById("mnuMore").style.display = "none";
	            }
	        } else {
	            if (view == 'show') {
	                document.getElementById("mnuMore").style.display = "";
	            } else {
	                document.getElementById("mnuMore").style.display = "none";
	            }
	        }

	    }

	    function ShowWhyInActive() {
	        document.getElementById('divWhyInActive').style.display = 'inline';	        
	    }
	    function HideWhyInActive() {
	        document.getElementById('divWhyInActive').style.display = 'none';	        
	    } 


	    function ShowActive() {
	        var ID = document.getElementById('<%=btnInactive.ClientID%>');
	        var width = document.body.scrollWidth;
	        findPos(ID);
	        divUserStatus.style.right = width - x - 110;
	        divUserStatus.style.top = y + 29;
	        divUserStatus.style.display = 'inline';
	        tblUserStatus.className = "ActiveUserDarkGreen";
	        lblUserStatus.innerText = "Activate User";
	        ID.getElementsByTagName('div')[0].getElementsByTagName('img')[0].src = '../images/arrowUp.gif';


	    }

	    function ShowInactive() {
	        var ID = document.getElementById('<%=btnActive.ClientID%>');
	        var width = document.body.scrollWidth;
	        findPos(ID);
	        divUserStatus.style.right = width - x - 110;
	        divUserStatus.style.top = y + 29;
	        divUserStatus.style.display = 'inline';
	        tblUserStatus.className = "InActiveUserDarkRed";
	        lblUserStatus.innerText = "Inactivate User";
	        ID.getElementsByTagName('div')[0].getElementsByTagName('img')[0].src = '../images/arrowUp.gif';

	    }


	    function findPos(obj) {
	        var left = !!obj.offsetLeft ? obj.offsetLeft : 0;
	        var top = !!obj.offsetTop ? obj.offsetTop : 0;

	        while (obj = obj.offsetParent) {
	            left += !!obj.offsetLeft ? obj.offsetLeft : 0;
	            top += !!obj.offsetTop ? obj.offsetTop : 0;
	        }
	        x = left;
	        y = top;
	    }
	    function CloseInActiveUser() {
	        //divActions.className="";
	        var ID = null;
	        ID = document.getElementById('<%=btnInactive.ClientID%>');
	        if (ID == null)
	            ID = document.getElementById('<%=btnActive.ClientID%>');

	        ID.getElementsByTagName('div')[0].getElementsByTagName('img')[0].src = '../images/arrowDown.gif';
	        divUserStatus.style.display = 'none';
	        //getElement('btnActions').innerText = 'Actions';
	    }
	
	</script>
</body>
</html>