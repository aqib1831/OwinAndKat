																				   <%@ Page Language="VB" AutoEventWireup="false" CodeFile="TicketsNew.aspx.vb" MaintainScrollPositionOnPostback="true"  Inherits="PM_TicketsNew" Theme="Default" ValidateRequest="false" %>
<%@ Register TagPrefix="radU" Namespace="Telerik.WebControls" Assembly="RadUpload.Net2" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
  
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=0.2)" />
    <meta http-equiv="Page-Enter" content="progid:DXImageTransform.Microsoft.Fade(Duration=0.2)" />
    <style type="text/css">
		.FormInnerTable td {background-color:#DEF7D6;vertical-align:middle;}		
		.WhtLine td{border-bottom: solid 1px white;}		
            #cke_2_resizer{
            display:none ;
        }
		ul {
		    list-style-position: inside;
		}
		
    </style>
</head>
<body  style ="margin :0px;background-color:#DAF5D6; height:100%; width:100%;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="400"  />
    <iframe id="divDisable" marginheight="0" marginwidth="0" scrolling="no" frameborder="0" style="display:none;z-index:09;width:0;height:0;position:absolute;filter:progid:DXImageTransform.Microsoft.alpha(opacity=50);opacity:0.5;"src="../BlankPage.htm"></iframe>
    <radu:radprogressmanager id="Radprogressmanager1" runat="server" />
    <div align="center" id="progress" style="display:none; border:0px solid black; position:absolute;left:25%; top:30%;z-index:100;">
        <radu:radprogressarea id="RadProgressArea1" runat="server"></radu:radprogressarea> 
    </div>
    <div>
    <table cellspacing="0" cellpadding="0" border="0" style="height:100%;width:100%;" class="FormTable">
              <tr>
                  <td  style="height:31px;font-size:13px;padding:5px;border-bottom:1px solid #609BD3;">
                      <b>New Ticket</b>
                   </td>
              </tr>
              <tr>
               <td align="center" style="vertical-align:top; height:100%; width:100%;" >
					<div  style="overflow:auto;height:100%;" id="Div1" >
				   <table border="0" cellpadding="1"  cellspacing="0" class="FormInnerTable" style="width:100%;  height:100%; text-align:left; vertical-align:top;" >
							<tr>
								<td style="width: 15%; height: 0px;"></td>
								<td style="width: 35%"></td>
								<td style="width: 10%"></td>
								<td style="width: 40%"></td>
							</tr>
							<tr class="WhtLine">
								<td style="padding-left: 15px;">
									Subject:<b class="RequiredField">*</b>
								</td>
								<td>
									<asp:TextBox ID="txtName" runat="server" MaxLength="50" SkinID="GreenSmallTextbox" Width="200px"></asp:TextBox>
									<asp:RequiredFieldValidator ID="RFV_Name" runat="server" ControlToValidate="txtName"
										Display="Dynamic" ErrorMessage="<br/>Please Enter Name" SkinID="RequiredFieldValidation"></asp:RequiredFieldValidator>
									<asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" CssClass="ErrorMessage"></asp:Label>
								</td>
								<td style="padding-left: 15px;">
									Type:<b class="RequiredField">*</b>
								</td>
								<td>
									<asp:DropDownList ID="ddlTypes" runat="server" DataSourceID="SDS_Type" DataTextField="Name" 
										DataValueField="ID" SkinID="SmallTextCombo" Width="200px">
									</asp:DropDownList>
									<asp:SqlDataSource ID="SDS_Type" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
										SelectCommand="PM_TaskTypes_GetAll_New" SelectCommandType="StoredProcedure" DataSourceMode="DataReader">
									</asp:SqlDataSource>
									<asp:CompareValidator ID="CV_Type" runat="server" ControlToValidate="ddlTypes" Display="Dynamic"
										ErrorMessage="<br/>Please Select Type" Operator="GreaterThan" SkinID="CompareValidation"
										Type="Integer" ValueToCompare="0"></asp:CompareValidator>
								</td>
							</tr>							
							<tr class="WhtLine">
								<td style="padding-left: 15px;">
									Required Date:<b class="RequiredField">*</b>
								</td>
								<td>
									<asp:TextBox ID="txtDueDate" runat="server" MaxLength="10" SkinID="GreenSmallTextbox" onfocus="imgDDCalander.click();" Width="173px">
									</asp:TextBox>
									<img id="imgDDCalander" align="absMiddle" border="0" onClick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtDueDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
										onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" />
									<asp:RequiredFieldValidator ID="RFV_DueDate" runat="server" ControlToValidate="txtDueDate"
										Display="Dynamic" ErrorMessage="<br/>Please Enter Ticket Date" SkinID="RequiredFieldValidation"/>
									<asp:RegularExpressionValidator ID="REV_DOB" runat="server" ControlToValidate="txtDueDate"
										Display="Dynamic" ErrorMessage="<br/>Date is not in Correct Format" ValidationExpression="^\d{1,2}\/\d{1,2}\/\d{2,4}$"/>
									<asp:CompareValidator ID="CV_FutureDate" runat="server" Display="Dynamic" ControlToValidate="txtDueDate"
										Type="Date" Operator="GreaterThanEqual" ErrorMessage="<br/>Please Select a Future Date"/>
								</td>
								<td style="padding-left: 15px;">
									Priority:<b class="RequiredField">*</b>
								</td>
								<td>
									<asp:DropDownList ID="ddlPriority" runat="server" SkinID="SmallTextCombo" Width="200px"></asp:DropDownList>
									<asp:CompareValidator ID="CV_Priority" runat="server" ControlToValidate="ddlPriority"
										Display="Dynamic" ErrorMessage="<br/>Please Select Priority" Operator="GreaterThan"
										SkinID="CompareValidation" Type="Integer" ValueToCompare="0" />
								</td>
							</tr>							
							<tr class="WhtLine">
								<td style="padding-left: 15px;">
									Client:<b class="RequiredField">*</b>
								</td>
								<td>
									<asp:DropDownList ID="ddlClients" runat="server" DataSourceID="odsClients" DataTextField="Name"  
										DataValueField="ID" SkinID="SmallTextCombo" Width="200px" AutoPostBack="true"></asp:DropDownList>
									<asp:ObjectDataSource ID="odsClients" runat="server" TypeName="Portal.BLL.Users"
										SelectMethod="GetClientsByUserIDAndSubModuleIDs">
										<SelectParameters>
											<asp:SessionParameter Name="userId" Type="int32" SessionField="AdminID" />
										</SelectParameters>
									</asp:ObjectDataSource>
									<asp:CompareValidator ID="CV_Client" runat="server" ControlToValidate="ddlClients"
										Display="Dynamic" ErrorMessage="<br/>Please Select Client" Operator="GreaterThan"
										SkinID="CompareValidation" Type="Integer" ValueToCompare="0" />
								</td>
								<td style="padding-left: 15px;" nowrap="nowrap">
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
								       <%-- <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="ddlClients" EventName="SelectedIndexChanged" />
                                            </Triggers>--%>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr class="WhtLine">
                                    <td style="padding-left: 15px;">Status:<b class="RequiredField">*</b>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlStatus" CssClass="SmallFontInput" runat="server" Width="200px">
                                            <asp:ListItem Text="Please Select" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Not Started" Value="2" Selected="True"></asp:ListItem>
                                            <%--<asp:ListItem Text="Client's Feedback Requested" Value="8"></asp:ListItem>
                                        <asp:ListItem Text="On Hold" Value="7"></asp:ListItem>--%>
                                        </asp:DropDownList>
                                        <asp:CompareValidator ID="CV_ddlStatus" runat="server" ControlToValidate="ddlStatus"
                                            Display="Dynamic" ErrorMessage="<br/>Please Select Status" Operator="GreaterThan"
                                            SkinID="CompareValidation" Type="Integer" ValueToCompare="0"></asp:CompareValidator>
                                    </td>
                                    <td style="padding-left: 15px;">Category:<b class="RequiredField">*</b>
                                    </td>
                                    <td>
                                        <asp:UpdatePanel ID="UPCategories" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:DropDownList ID="ddlCategories" runat="server" DataSourceID="SDS_Categories"
                                                    DataTextField="Name" DataValueField="ID" AutoPostBack="true" SkinID="SmallTextCombo" Width="200px">
                                                </asp:DropDownList>
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
                            
                                <tr class="WhtLine">
                                    <td style="padding-left: 15px;">Product Owner:
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlTicketOwner" runat="server" DataSourceID="sdsTicketOwner" DataTextField="OwnerName"
                                            DataValueField="ID" SkinID="SmallTextCombo" Width="200px">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="sdsTicketOwner" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                            SelectCommand="PM_TicketOwner_GetAll" SelectCommandType="StoredProcedure" DataSourceMode="DataReader"></asp:SqlDataSource>
                                  </td>
                                     <td style="padding-left: 15px;"> Sub Category:
                                    </td>
                                    <td>
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:DropDownList ID="ddlSubCategories" AutoPostBack="true" runat="server"
                                                    DataTextField="Name" DataValueField="ID" SkinID="SmallTextCombo" Width="200px">
                                                </asp:DropDownList>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
							</tr> 


                          <%--  <tr class="WhtLine">
								<td style="padding-left: 15px;">
									 Billable ticket:<b class="RequiredField">*</b>
								</td>
								<td>
                                    
                                   <asp:CheckBox ID="chkDueDateShowToClient" runat="server" ToolTip="Show due date to client"
                                                             onclick="ShowDueDateVisibility();" />
								</td>
								<td style="padding-left: 15px;">
									Add effort:<b class="RequiredField">*</b>
								</td>
								<td>
								               <asp:DropDownList ID="ddlHoursNotes" runat="server" CssClass="SmallGreenTextBox" EnableViewState="false"
                                        ValidationGroup="NotesAdd">                            
                                    </asp:DropDownList>
                                    &nbsp;:
                                    <asp:DropDownList ID="ddlMinutesNotes" runat="server" CssClass="SmallGreenTextBox" EnableViewState="false"
                                        ValidationGroup="NotesAdd" AutoPostBack="false">                           
                                    </asp:DropDownList>
                                    &nbsp;
                                    <asp:CustomValidator ID="CV_TimeSpent" ClientValidationFunction="validateTime" ErrorMessage="Select Time Spent"
                                        ValidationGroup="NotesAdd" runat="server" Display="Dynamic" CssClass="RequiredField">
                                    </asp:CustomValidator>&nbsp;    
								</td>								
							</tr>--%>
                              
                                   							
							<tr class="WhtLine">
								<td style="padding-left: 15px;" colspan="2">Description:<b class="RequiredField">*</b>&nbsp;<asp:RequiredFieldValidator ID="RFV_txtDescription" runat="server" ControlToValidate="txtDescription"
										Display="Dynamic" ErrorMessage="Please Enter Description" SkinID="RequiredFieldValidation"></asp:RequiredFieldValidator></td>								
								<td></td>
								<td style="padding-right: 10px;" align="right">
									<asp:LinkButton ID="BtnAttachment" runat="server" EnableViewState="false" OnClientClick="showAttachFiles(); return false;">
									<div class="LeadGreenButton" style="width: 100px;">
										Attach File
										<img id="Img1" align="absMiddle"  height="10" runat="server" src="~/images/blt_resetFilters.gif" width="10" />
									</div>
									</asp:LinkButton>
								</td>
							</tr>
							<tr id="trFiles" style="display: none; border: none;" class="WhtLine">
								<td colspan="4" style="height: 25px; background-color: White; border: 1px solid #50AF43;">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td style="border: none; background-color: White;" rowspan="2" align="center" width="5%">
												<img src="../images/ico_attachment.gif" align="middle" alt="attach" />
											</td>
											<td style="border: none; background-color: White;" id="tdFiles">
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="4" style="text-align: center; height: 100%; padding-left: 0px;" align="right">
									<%--<asp:TextBox ID="txtDescription" runat="server" Height="95%" MaxLength="500" SkinID="GreenMultilineTextbox"
										TextMode="MultiLine" Width="100%">
									</asp:TextBox>	--%>		
                                     <textarea name="txtDescription" id="txtDescription" runat="server"></textarea>						
								</td>
							</tr>
							<tr>
								<td colspan="4" style="text-align: center">
									Fields marked with an asterisk <b class="RequiredField">*</b> are required.
								</td>
							</tr>
						</table>
					</div>
			   </td>
			  </tr>
		<tr>
			<td align="center" style="height: 31px; border-top: 1px solid #609BD3; vertical-align: middle;">
				<asp:Button ID="btnSave" runat="server" Text="Save" OnClientClick="if (OnSaveClientSide() == false) return false;"
					CssClass="Btn3D" Width="80px" />&nbsp;&nbsp;
				<asp:Button ID="btnBack" runat="server" Text="Cancel" CausesValidation="false" CssClass="Btn3D" />
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
						<td align="right" height="25" style="padding-right:10px;"><a href="#" onClick="OnAttachmentSubmit(1);"><u>Clear All</u></a></td></tr>
					<tr>
					<td></td>
					<td height="25" >
					  <div>
						<div>File 1: <input id="file1" type="file" runat="server" style="width:330px;"/>
                                <asp:RadioButton ID="SOW" GroupName="selectSowBrd" runat="server" Text="SOW" CssClass="hdng_Radio" />
                                          &nbsp;  <asp:RadioButton ID="BRD" GroupName="selectSowBrd" runat="server" Text="BRD" CssClass="hdng_Radio" />
						</div>
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
						<div>File 2: <input id="file2" type="file" runat="server" style="width:330px;"/>
                                <asp:RadioButton ID="RadioButton2" GroupName="selectSowBrd1" runat="server" Text="SOW" CssClass="hdng_Radio" />
                                          &nbsp;  <asp:RadioButton ID="RadioButton4" GroupName="selectSowBrd1" runat="server" Text="BRD" CssClass="hdng_Radio" />
						</div>
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
					 <div>File 3: <input id="file3" type="file" runat="server" style="width:330px;"/>
                           <asp:RadioButton ID="RadioButton5" GroupName="selectSowBrd2" runat="server" Text="SOW" CssClass="hdng_Radio" />
                                          &nbsp;  <asp:RadioButton ID="RadioButton6" GroupName="selectSowBrd2" runat="server" Text="BRD" CssClass="hdng_Radio" />
					 </div> 
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
					<input  id="BtnOk" type="button" value="OK" style="width:80px;"  onclick="OnAttachmentSubmit1(); " class="Btn3D">
				</td>
				</tr>
			 </table>
			</td>
			</tr>
			</table>
	</div>
	</form>
</body>
        <script type="text/javascript" src="../scripts/jquery-1.11.2.min.js"></script>
<script src="../Standard/ckeditor.js"></script>
      <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
<script language="javascript" type="text/javascript">
    //  window.onload = function () {
    //    //alert("here");
    //    //setTimeout(InitEditor, 2000);
    //    InitEditor();
    //};
    var height = $('#txtDescription').parent().height();
    $(document).ready(function () {
        InitEditor();
    });
    function InitEditor() {
  
        CKEDITOR.replace('txtDescription');

        CKEDITOR.config.toolbar = [
        ['Bold', 'Italic', 'Underline','NumberedList', 'BulletedList', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']
        ];
        CKEDITOR.config.height = height - 40;
       
        CKEDITOR.config.removePlugins = 'elementspath,magicline';
        CKEDITOR.on('instanceReady', function (ev) {
          this.config.autoParagraph = false;
            $.each(CKEDITOR.instances, function(instance) {
                CKEDITOR.instances[instance].on("change",
                    function(e) {
                        for (instance in CKEDITOR.instances
                        )
                            CKEDITOR.instances[instance].updateElement();
                    });
                var writer = ev.editor.dataProcessor.writer;
                // The character sequence to use for every indentation step.
                writer.indentationChars = '  ';

                var dtd = CKEDITOR.dtd;
                // Elements taken as an example are: block-level elements (div or p), list items (li, dd), and table elements (td, tbody).
                for (var e in CKEDITOR.tools.extend({}, dtd.$block, dtd.$listItem, dtd.$tableContent)) {
                    ev.editor.dataProcessor.writer.setRules(e,
                        {
                            // Indicates that an element creates indentation on line breaks that it contains.
                            indent: false,
                            // Inserts a line break before a tag.
                            breakBeforeOpen: false,
                            // Inserts a line break after a tag.
                            breakAfterOpen: false,
                            // Inserts a line break before the closing tag.
                            breakBeforeClose: false,
                            // Inserts a line break after the closing tag.
                            breakAfterClose: false
                        });
                }
            
                //for (var e in CKEDITOR.tools.extend({}, dtd.$list, dtd.$listItem, dtd.$tableContent)) {
                //    ev.editor.dataProcessor.writer.setRules(e, {
                //        indent: true,
                //    });
                //}
               
            });
        });
    
         

    }
    function validateSameFiles(oSrc, args) {
        if ((getElement('<%= File1.ClientID %>').value == getElement('<%= File2.ClientID %>').value && getElement('<%= File1.ClientID %>').value != '' && getElement('<%= File2.ClientID %>').value != '') ||
		 (getElement('<%= File1.ClientID %>').value == getElement('<%= File3.ClientID %>').value && getElement('<%= File1.ClientID %>').value != '' && getElement('<%= File3.ClientID %>').value != '') ||
		 (getElement('<%= File2.ClientID %>').value == getElement('<%= File3.ClientID %>').value && getElement('<%= File2.ClientID %>').value != '' && getElement('<%= File3.ClientID %>').value != ''))
	    args.IsValid = false
	else
	    args.IsValid = true;
}
function validateFiles(oSrc, args) {
    if ((getElement('<%= File1.ClientID %>').value == '') &&
		 (getElement('<%= File2.ClientID %>').value == '') &&
		 (getElement('<%= File3.ClientID %>').value == ''))
	    args.IsValid = false
	else
	    args.IsValid = true;
}


function ResetAttachment2() {
    //	var Fupload = document.getElementById('<%=File2.ClientID%>');
    //	try {
    //		Fupload.select();
    //		n = Fupload.createTextRange();
    //		n.execCommand('delete');
    //		//	var TD = Fupload.parentElement;
    //		//	var str = TD.innerHTML;
    //		//	str = str.replace(Fupload.value, '');
    //		//	TD.innerHTML = str;
    //	}
    //	catch (ex) { }
    //	Fupload.parentElement.innerHTML = Fupload.parentElement.innerHTML;
    //alert(form1.file2.parentElement.innerHTML);
    //alert(form1.file2.parentNode.innerHTML);
    //form1.file2.value = form1.file2.value;
    //form1.file2.parentElement.innerHTML = form1.file2.parentElement.innerHTML;
    form1.file2.parentNode.innerHTML = form1.file2.parentNode.innerHTML;

}
function ResetAttachment1() {
    //	var Fupload = document.getElementById('<%=File1.ClientID%>');
    //	try {
    //		Fupload.select();
    //		n = Fupload.createTextRange();
    //		n.execCommand('delete');
    //	}
    //	catch (ex) { }
    //		Fupload.parentElement.innerHTML = Fupload.parentElement.innerHTML;
    form1.file1.parentNode.innerHTML = form1.file1.parentNode.innerHTML;

}
function ResetAttachment3() {
    //	var Fupload = document.getElementById('<%=File3.ClientID%>');
    //	try {
    //		Fupload.select();
    //		n = Fupload.createTextRange();
    //		n.execCommand('delete');
    //	}
    //	catch (ex) { }
    //		Fupload.parentElement.innerHTML = Fupload.parentElement.innerHTML;
    form1.file3.parentNode.innerHTML = form1.file3.parentNode.innerHTML;

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
    document.getElementById("<%=BtnAttachment.ClientID%>").focus();
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
        getElement('trFiles').style.display = '';
        getElement('tdFiles').innerHTML = strFiles;
    }
    strFiles = '';
}

function ShowUpdateMessage() {
    document.getElementById('spnUpdateMessage').style.display = 'inline';
    setTimeout('HideUpdateMessage()', 3000)
}

function HideUpdateMessage() {
    document.getElementById('spnUpdateMessage').style.display = 'none';
}

function OnAttachmentSubmit(flagCancel) {
    if (flagCancel == 1) {//Remove All
        document.getElementById("SOW").checked = false;
        document.getElementById("BRD").checked = false;
        document.getElementById("RadioButton2").checked = false;
        document.getElementById("RadioButton4").checked = false;
        document.getElementById("RadioButton5").checked = false;
        document.getElementById("RadioButton6").checked = false;
        ResetAttachment3(); ResetAttachment2(); ResetAttachment1();
        Page_ClientValidate('AttachmentGroup');
        document.getElementById("BtnOk").focus();
        return false;
    }

    getElement('Attachment').style.display = 'none';
    document.getElementById("<%=BtnAttachment.ClientID%>").focus();
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
function trimFileName(strFileName) {
    if (strFileName.length > 20)
        return strFileName.substr(0, 20) + ' ...';
    else
        return strFileName;
}
var buttonbtnSaveClicked = false;
function OnSaveClientSide() {
    if (buttonbtnSaveClicked)
        return false;
    if (Page_ClientValidate() && Page_ClientValidate('AttachmentGroup')) {
        buttonbtnSaveClicked = true;
        if ((getElement('<%= File1.ClientID %>').value != '') ||
			(getElement('<%= File2.ClientID %>').value != '') ||
			(getElement('<%= File3.ClientID %>').value != '')) {
		    var progress = document.getElementById('progress')
		    progress.style.display = 'inline';
		    BlackDivDisplay();
		}
    }
    else {
        return false;
    }
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
