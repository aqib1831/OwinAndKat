<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FeaturesEdit.aspx.vb" Inherits="PM_FeaturesEdit" Theme="Default" ValidateRequest="false" %>
<%@ Register TagPrefix="radU" Namespace="Telerik.WebControls" Assembly="RadUpload.Net2" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title></title>
	<link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
	 <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
	<script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
	<script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
	<script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
	<meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=0.2)" />
	<meta http-equiv="Page-Enter" content="progid:DXImageTransform.Microsoft.Fade(Duration=0.2)" />
	<style type="text/css">
		.FormInnerTable td {background-color:#DEF7D6;vertical-align:middle;}
		.WhtLine{ border-bottom: solid 1px white;height:1px;}
		.WhtLine img{height:1px;width:1px;src:url('../../images/spacer.gif');}
	</style>
</head>
<body style="margin :0px;background-color:#DAF5D6; height:100%; width:100%;">
	<form id="form1" runat="server">
	<iframe id="divDisable" marginheight="0" marginwidth="0" scrolling="no" frameborder="0" style="display:none;z-index:09;width:0;height:0;position:absolute;filter:progid:DXImageTransform.Microsoft.alpha(opacity=50);opacity:0.5;"src="../BlankPage.htm"></iframe>
	<radu:radprogressmanager id="Radprogressmanager1" runat="server" />
	<div align="center" id="progress" style="display:none; border:0px solid black; position:absolute;left:25%;top:30%;z-index:100;">
		<radu:radprogressarea id="RadProgressArea1" runat="server"></radu:radprogressarea> 
	</div>
	<div>
<asp:HiddenField ID="hdnFeatureID" runat="server" />
<asp:HiddenField ID="hdnCategoryID" runat="server" />
<asp:HiddenField ID="hdnClientID" runat="server" />
	<table cellspacing="0" border="0" style="height:100%; width:100%;" class="FormTable" >
			  <tr>
				<td  style="height:31px;font-size:13px;font-weight:bold;padding:5px;border-bottom:1px solid #609BD3;">
				  <asp:Label ID="lblTitle" runat="server" Text="Edit Feature"></asp:Label>
				</td>
			  </tr>
			  <tr >
			   <td align="center" style="vertical-align:top; height:100%; width:100%;">
					<div style="overflow:auto;" id="Div1" >
				   <table border="0" cellpadding="1"  cellspacing="0" class="FormInnerTable" style="width:100%;  height:100%; text-align:left; vertical-align:top;">
					  <tr>
						   <td  style="width: 15%"></td>
						   <td  style="width: 30%;"></td>
						   <td  style="width: 15%"></td>
						   <td  style="width: 40%"></td>
					   </tr>
					   <tr>
						   <td  style="padding-left:15px;">
							   Name:<b class="RequiredField" >*</b></td>
						   <td style="text-align: left"  >
							   <asp:TextBox ID="txtName" runat="server" MaxLength="50" SkinID="GreenSmallTextbox"
								   Width="200px"></asp:TextBox>
							   <asp:RequiredFieldValidator ID="RFV_Name" runat="server" ControlToValidate="txtName"
								   Display="Dynamic" ErrorMessage="Please Enter Name" SkinID="RequiredFieldValidation">
							   </asp:RequiredFieldValidator>
							   <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" CssClass="ErrorMessage"></asp:Label>
						   </td>
						   <td  style="padding-left:15px;">
							   Type:<b class="RequiredField" >*</b></td>
						   <td ><asp:DropDownList ID="ddlTypes" runat="server" DataSourceID="SDS_Type"
								   DataTextField="Name" DataValueField="ID" SkinID="SmallTextCombo" Width="200px">
						   </asp:DropDownList>
						   <asp:SqlDataSource ID="SDS_Type" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
								   SelectCommand="PM_TaskTypes_GetAll" 
								   SelectCommandType="StoredProcedure"
								   DataSourceMode="DataReader">
						   </asp:SqlDataSource>
							   <asp:CompareValidator ID="CV_Type" runat="server" ControlToValidate="ddlTypes"
								   Display="Dynamic" ErrorMessage="<br/>Please Select Type" Operator="GreaterThan"
								   SkinID="CompareValidation" Type="Integer" ValueToCompare="0"></asp:CompareValidator>
						  </td>
					   </tr>
					   <tr><td class="WhtLine" colspan="4"><img /></td></tr>
					   <tr>
						   <td  style="padding-left:15px;">
							   Release:<b class="RequiredField" >*</b></td>
						   <td style="text-align: left" >
						   <asp:DropDownList ID="ddlReleases" runat="server" DataSourceID="SDS_Releases"
								   DataTextField="Name" DataValueField="ID" SkinID="SmallTextCombo" Width="200px">
						   </asp:DropDownList>
						   <asp:SqlDataSource ID="SDS_Releases" 
									runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
								   SelectCommand="PM_Releases_GetAllForList" 
								   SelectCommandType="StoredProcedure"
								   DataSourceMode="DataReader">
								   <SelectParameters>
									   <asp:ControlParameter ControlID="hdnClientID"  Name="ClientID" Type="Int32" />
								   </SelectParameters>
							   </asp:SqlDataSource>
							   <asp:CompareValidator ID="CV_Releases" runat="server" ControlToValidate="ddlReleases"
								   Display="Dynamic" ErrorMessage="Please Select Releases" Operator="GreaterThan"
								   SkinID="CompareValidation" Type="Integer" ValueToCompare="0">
							  </asp:CompareValidator></td>
						   <td  style="padding-left:15px;">
							   Required Date:<b class="RequiredField" >*</b></td>
						   <td >
							   <asp:TextBox ID="txtDueDate" runat="server" 
								   MaxLength="10" SkinID="GreenSmallTextbox"
								   onfocus="imgDDCalander.click();"
								   Width="173px">
							   </asp:TextBox>
							   <img id="imgDDCalander" align="absMiddle"  border="0" onclick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtDueDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
								   onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" />
							   <asp:RequiredFieldValidator
									   ID="RFV_DueDate" runat="server" ControlToValidate="txtDueDate" Display="Dynamic"
									   ErrorMessage="<br/>Please Enter Feature Due Date" SkinID="RequiredFieldValidation">
							   </asp:RequiredFieldValidator>
							   <asp:RegularExpressionValidator
									   ID="REV_DOB" runat="server" ControlToValidate="txtDueDate" Display="Dynamic"
									   ErrorMessage="<br/>Date is not in Correct Format" ValidationExpression="^\d{1,2}\/\d{1,2}\/\d{2,4}$">
							   </asp:RegularExpressionValidator>
						   </td>
					   </tr>
					   <tr><td class="WhtLine" colspan="4"><img /></td></tr>
					   <tr>
						   <td colspan="3"   style="padding-left:15px;">
							<asp:Repeater ID="rptrTicketAttachments" runat="server" DataSourceID="SDS_TicketsAttachments"
								   EnableViewState="false">
								   <ItemTemplate>
									   [<a href='<%= ConfigurationManager.AppSettings("PMAttachmentPath") %><%# Container.DataItem("FilePath")  %>'
										   target="_blank"><%#Container.DataItem("FileName")%>
									   </a>] &nbsp;
								   </ItemTemplate>
							   </asp:Repeater>
								<asp:SqlDataSource ID="SDS_TicketsAttachments" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
									   SelectCommand="PM_Ticket_Features_Attachments_GetByTicketID" 
									   SelectCommandType="StoredProcedure"
									   DataSourceMode="DataReader">
									   <SelectParameters>
										   <asp:ControlParameter ControlID="hdnFeatureID" Name="Ticket_FeatureID" PropertyName="Value" Type="Int32" />
								   </SelectParameters>
							   </asp:SqlDataSource>
						   </td>
						   <td  align="right"  style="padding-right:15px;">
							   <div class="LeadGreenButton" onclick="showAttachFiles();" style="width: 100px">
								   Attach File
								   <img align="absMiddle"  height="10" src="../images/blt_resetFilters.gif" width="10" />
							   </div>
						   </td>
					   </tr>
					   <tr class="SimpleExSmallBold" id="trFiles" style="display:none;border:none;">
						   <td colspan="4" style="height:25px; background-color:White; border:1px solid #50AF43;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td style="border:none;background-color:White;" rowspan="2" align="center" width="5%"><img src="../images/ico_attachment.gif" align="middle" alt="attach" /></td>
									<td style="border:none;background-color:White;" id="tdFiles"></td>
								</tr>
							</table> 
						  </td>
						</tr>
						   
					   <tr>
							<td  colspan="4" style="padding-left:15px">
						   </td>
					   </tr>
					   <tr>
						   <td colspan="4" style="text-align: center;height:100%;">
							   <asp:TextBox ID="txtDescription" runat="server" MaxLength="500" 
									Rows="15" SkinID="GreenMultilineTextbox" TextMode="MultiLine"
								   Width="100%" Height="95%">
							   </asp:TextBox>
								<asp:RequiredFieldValidator ID="RFV_txtDescription" runat="server" ControlToValidate="txtDescription"
								   Display="Dynamic" ErrorMessage="Please Enter Description" SkinID="RequiredFieldValidation"></asp:RequiredFieldValidator>
						   </td>
					   </tr>
					   <tr>
						   <td colspan="4" style="text-align:center;">
							   Fields marked with an asterisk <b class="RequiredField" >*</b> are required.
						   </td>
					   </tr>
					 </table>
					</div>
				</td>
			  </tr>
			  <tr>
				<td align="center"  style="height:31px; border-top:1px solid #609BD3; vertical-align:middle;">
					<asp:Button ID="btnSave" 
							runat="server" 
							Text="Save"
							OnClientClick="if (OnSaveClientSide() == false) return false;" 
							CssClass="Btn3D" 
							Width="80px"/>&nbsp;&nbsp;
					  <asp:Button 
						  ID="btnBack" 
						  Text="Cancel"
						  runat="server"  
						  CssClass="Btn3D"
						  CausesValidation ="false" 
						  EnableViewState="false"
						  UseSubmitBehavior="false" />
				</td>
			</tr>
		</table>
	</div> 
	<div align="center" id="Attachment" style="display:none; border:0px solid black; position:absolute;left:25%; top:25%; width:50%; max-width:450px;height: 210px;z-index:11;">
		<table cellpadding="0" cellspacing="0" style="width:100%;" class="MainAlertDiv">
			<tr>
			  <th height="21" valign="middle" align="left">&nbsp;Attachment(s)</th>
			  <th align="right" valign="top"><img src="../images/closebox2.gif" onClick="OnAttachmentSubmit1(); return false;" style="cursor:pointer;"></th>
			</tr>
			<tr>
			<td width="100%" valign="top" colspan="2">
				<table cellpadding="0" cellspacing="0" class="MainAlertDiv" style="width:100%;text-align:center;border:none;">
					<tr>
						<td></td>
						<td align="right" height="25" style="padding-right:10px;"><a href="#" onclick="OnAttachmentSubmit(1);"><u>Remove All</u></a></td></tr>
					<tr>
					<td></td>
					<td height="25" >
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
					 </td>
			   </tr>
				<tr><td colspan="2" height="30" align="center">
					<input type="button" value="OK" style="width:80px;"  onclick="OnAttachmentSubmit1(); " class="Btn3D">
				</td>
				</tr>
			 </table>
			</td>
			</tr>
			</table>
	</div>
	</form>
</body>
<script language="javascript" type="text/javascript">
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
  
	function OpenWindow(LeadID)
	{
		window.open('../BlankPage.aspx?Page=lead/PrintLead&PageTitle=Print Lead&LeadID='+LeadID,'','dialogHeight=750px,menubar=1,dialogWidth=600px,status=1');
	
	}

	function ResetAttachment2() {
//	var Fupload = document.getElementById('<%=File2.ClientID%>');
//	Fupload.select();
//	n = Fupload.createTextRange();
//	n.execCommand('delete');
//	//	var TD = Fupload.parentElement;
//	//	var str = TD.innerHTML;
//	//	str = str.replace(Fupload.value, '');
//	//	TD.innerHTML = str;
//	Fupload.parentElement.innerHTML = Fupload.parentElement.innerHTML;
	form1.file2.parentNode.innerHTML = form1.file2.parentNode.innerHTML;
	}
	function ResetAttachment1() {

//	var Fupload = document.getElementById('<%=File1.ClientID%>');
//	Fupload.select();
//	n = Fupload.createTextRange();
//	n.execCommand('delete');
//	Fupload.parentElement.innerHTML = Fupload.parentElement.innerHTML;
	form1.file1.parentNode.innerHTML = form1.file1.parentNode.innerHTML;
	}
	function ResetAttachment3() {

//	var Fupload = document.getElementById('<%=File3.ClientID%>');
//	Fupload.select();
//	n = Fupload.createTextRange();
//	n.execCommand('delete');
//	Fupload.parentElement.innerHTML = Fupload.parentElement.innerHTML;
	form1.file3.parentNode.innerHTML = form1.file3.parentNode.innerHTML;
}

	  function showAttachFiles()
	{
		document.getElementById("Attachment").style.display = 'inline';
		BlackDivDisplay();
	}

	function OnAttachmentSubmit1() {
		if (Page_ClientValidate('AttachmentGroup') == false) {
			alert('Please attach a valid file or remove it.')
			return false;
		}

		BlackDivHide();
		document.getElementById("Attachment").style.display = 'none';
		var strFiles = '';
		if (document.getElementById('<%=File1.ClientID%>').value != '')
			strFiles += '<table style=\'display:inline;border:none;background-color:White; \'><tr><td rowspan=2 style=\'border:none;background-color:White;\'>&nbsp;&nbsp;</td><td style=\'border:none;background-color:White;\'>' + trimFileName(getElement('file1').value.substr(getElement('file1').value.lastIndexOf("\\") + 1)) + '</td></tr><tr><td style=\'cursor:pointer;font-size:7px;border:none;background-color:White;\' align=right onClick=\'ResetAttachment1();OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>';
		if (document.getElementById('<%=File2.ClientID%>').value != '')
			strFiles += '<table style=\'display:inline;border:none;background-color:White;\'><tr><td rowspan=2 style=\'border:none;background-color:White;\'>&nbsp;&nbsp;</td><td style=\'border:none;background-color:White;\'>' + trimFileName(getElement('file2').value.substr(getElement('file2').value.lastIndexOf("\\") + 1)) + '</td></tr><tr><td style=\'cursor:pointer;font-size:7px;border:none;background-color:White;\' align=right onClick=\'ResetAttachment2();OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>';
		if (document.getElementById('<%=File3.ClientID%>').value != '')
			strFiles += '<table style=\'display:inline;border:none;background-color:White;\' ><tr><td rowspan=2 style=\'border:none;background-color:White;\'>&nbsp;&nbsp;</td><td style=\'border:none;background-color:White;\'>' + trimFileName(getElement('file3').value.substr(getElement('file3').value.lastIndexOf("\\") + 1)) + '</td></tr><tr><td style=\'cursor:pointer;font-size:7px;border:none;background-color:White;\' align=right onClick=\'ResetAttachment3();OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>';

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


 function ShowUpdateMessage()
	 {
		document.getElementById('spnUpdateMessage').style.display = 'inline' ;
		setTimeout('HideUpdateMessage()' , 3000)
	 }
	 
 function HideUpdateMessage()
	 {
		document.getElementById('spnUpdateMessage').style.display = 'none' ;
	 }
 
	   function OnAttachmentSubmit(flagCancel)
		{
			if (flagCancel == 1) {
				ResetAttachment3(); ResetAttachment2(); ResetAttachment1(); Page_ClientValidate('AttachmentGroup'); return false;
			}
			
			getElement('Attachment').style.display = 'none';	
			 var strFiles = '';
			if (document.getElementById('<%=File1.ClientID%>').value != '')
				strFiles += '<table style=\'display:inline;border:none;background-color:White; \'><tr><td rowspan=2 style=\'border:none;background-color:White;\'>&nbsp;&nbsp;</td><td style=\'border:none;background-color:White;\'>'+trimFileName(getElement('file1').value.substr(getElement('file1').value.lastIndexOf("\\")+1))+'</td></tr><tr><td style=\'cursor:pointer;font-size:7px;border:none;background-color:White;\' align=right onClick=\'ResetAttachment1();OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>' ;
			if (document.getElementById('<%=File2.ClientID%>').value != '')
				strFiles += '<table style=\'display:inline;border:none;background-color:White;\'><tr><td rowspan=2 style=\'border:none;background-color:White;\'>&nbsp;&nbsp;</td><td style=\'border:none;background-color:White;\'>'+trimFileName(getElement('file2').value.substr(getElement('file2').value.lastIndexOf("\\")+1))+'</td></tr><tr><td style=\'cursor:pointer;font-size:7px;border:none;background-color:White;\' align=right onClick=\'ResetAttachment2();OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>' ;
			if (document.getElementById('<%=File3.ClientID%>').value != '')
				strFiles += '<table style=\'display:inline;border:none;background-color:White;\' ><tr><td rowspan=2 style=\'border:none;background-color:White;\'>&nbsp;&nbsp;</td><td style=\'border:none;background-color:White;\'>'+trimFileName(getElement('file3').value.substr(getElement('file3').value.lastIndexOf("\\")+1))+'</td></tr><tr><td style=\'cursor:pointer;font-size:7px;border:none;background-color:White;\' align=right onClick=\'ResetAttachment3();OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>' ;
			
			if (strFiles == '')
			{
				getElement('trFiles').style.display = 'none';
				getElement('tdFiles').innerHTML = '';
			}
			else
			{
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

	function OnSaveClientSide()
	{
		if (Page_ClientValidate() && Page_ClientValidate('AttachmentGroup')) {
			if ((getElement('<%= File1.ClientID %>').value != '') ||
				(getElement('<%= File2.ClientID %>').value != '') ||
				(getElement('<%= File3.ClientID %>').value != '')) {
				var progress = document.getElementById('progress')
				progress.style.display = 'inline';
				BlackDivDisplay()
			}
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

 </script>
</html>
