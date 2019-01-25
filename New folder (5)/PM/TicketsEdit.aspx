<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TicketsEdit.aspx.vb" Inherits="PM_TicketsEdit" Theme="Default"  %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=0.2)" />
    <meta http-equiv="Page-Enter" content="progid:DXImageTransform.Microsoft.Fade(Duration=0.2)" />
</head>
<body style ="margin :0px;background-color:#DAF5D6; height:100%; width:100%;">
    <form id="form1" runat="server">
    <div>
    <asp:HiddenField ID="TicketID" runat="server" />
        <table cellspacing="0" border="0" style="height:100%; width:100%; padding-left: 1em; " class="FormTable"  >
           <tr>
              <td style="height:31px;font-size:13px;font-weight:bold;padding:5px;border-bottom:1px solid #609BD3;">
                  Edit Ticket
                  <asp:Label ID="lblTicketNo" runat="server"></asp:Label></td>
           </tr>              
           <tr>
               <td align="center" style="vertical-align:top; height:100%; width:100%;" >
                  <div style="overflow:auto;" id="Div1" >
                   <table border="0" cellpadding="0"  cellspacing="0" class="FormInnerTable" style="width:100%;  height:100%; text-align:left; vertical-align:top;" >
                       <tr>
                           <td align="left" style="width: 15%">
                           </td>
                           <td align="left" style="width: 8%">
                           </td>
                           <td style="width: 15%">
                           </td>
                           <td align="left" style="width: 7%">
                           </td>
                           <td style="width: 15%">
                           </td>
                           <td style="width: 15%">
                           </td>
                       </tr>
                       <tr>
                           <td align="left" style="width: 15%; height: 15px;">
                           </td>
                           <td align="center" colspan="4">
                            <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" CssClass="ErrorMessage"></asp:Label></td>
                           <td style="width: 15%">
                           </td>
                       </tr>                       
                       <tr>
                           <td align="left" style="width: 15%; height: 25px;">
                           </td>
                           <td align="left">
                               Name:<span style="color: #ff0000">*</span></td>
                           <td>
                               <asp:TextBox ID="txtName" runat="server" MaxLength="200" SkinID="GreenSmallTextbox" Width="150px"></asp:TextBox><asp:RequiredFieldValidator ID="RFV_Name" runat="server" ControlToValidate="txtName"
                               Display="Dynamic" ErrorMessage="<br/>Please Enter Name" SkinID="RequiredFieldValidation"></asp:RequiredFieldValidator></td>
                           <td align="left">
                               Type:<span style="color: #ff0000">*</span></td>
                           <td>
                           <span>
                               <asp:DropDownList ID="ddlTypes" runat="server" DataSourceID="SDS_Type"
                                   DataTextField="Name" DataValueField="ID" SkinID="SmallTextCombo" Width="150px">
                               </asp:DropDownList>
                               <asp:SqlDataSource ID="SDS_Type" 
                                    runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                   SelectCommand="PM_TaskTypes_GetAll" 
                                   SelectCommandType="StoredProcedure"
                                   DataSourceMode="DataReader">
                               </asp:SqlDataSource>
                               <asp:CompareValidator ID="CV_Type" runat="server" ControlToValidate="ddlTypes" Display="Dynamic"
                                   ErrorMessage="Please Select Type" Operator="GreaterThan" SkinID="CompareValidation"
                                   Type="Integer" ValueToCompare="0"></asp:CompareValidator>
                              </span> 
                               </td>
                           <td style="width: 15%">
                           </td>                          
                       </tr>
                       <tr>
                           <td align="left" style="width: 15%; height: 25px;">
                           </td>
                           <td align="left">
                               Required Date:<span style="color: #ff0000">*</span></td>
                           <td>
                              <asp:TextBox ID="txtDueDate" runat="server" 
                                   MaxLength="10" SkinID="GreenSmallTextbox"
                                   onfocus="imgDDCalander.click();"
                                   Width="123px">
                               </asp:TextBox>
                               <img id="imgDDCalander" align="absMiddle"  border="0" onclick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtDueDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                   onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" />
                                   <asp:RequiredFieldValidator
                                       ID="RFV_DueDate" runat="server" ControlToValidate="txtDueDate" Display="Dynamic"
                                       ErrorMessage="<br/>Please Enter Ticket Required Date" 
                                       SkinID="RequiredFieldValidation"></asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                           ID="REV_DOB" runat="server" ControlToValidate="txtDueDate" Display="Dynamic"
                                           ErrorMessage="<br/>Date is not in Correct Format" ValidationExpression="^\d{1,2}\/\d{1,2}\/\d{2,4}$"></asp:RegularExpressionValidator></td>
                           <td align="left" style="width: 153px">
                               Priority:<span style="color: #ff0000">*</span></td>
                           <td><asp:DropDownList ID="ddlPriority" runat="server" SkinID="SmallTextCombo" Width="150px">
                           </asp:DropDownList>
                           <asp:CompareValidator ID="CV_Priority" runat="server" ControlToValidate="ddlPriority"
                                   Display="Dynamic" ErrorMessage="<br />Please Select Priority" Operator="GreaterThan"
                                   SkinID="CompareValidation" Type="Integer" ValueToCompare="0"></asp:CompareValidator></td>
                           <td style="width: 15%" id="TD1" runat="server">
                           </td>
                       </tr>
                       <tr>
                           <td align="left" style="width: 15%; height: 25px;">
                           </td>
                           <td align="left">
                               Category:<span style="color: #ff0000">*</span></td>
                           <td>
                               <asp:DropDownList ID="ddlCategories" runat="server" DataSourceID="SDS_Categories"
                                   DataTextField="Name" DataValueField="ID" SkinID="SmallTextCombo" Width="150px">
                               </asp:DropDownList><asp:SqlDataSource ID="SDS_Categories" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                   SelectCommand="PM_Categories_GetAll" 
                                   SelectCommandType="StoredProcedure"
                                   DataSourceMode="DataReader">
                                   </asp:SqlDataSource>
                               <asp:CompareValidator ID="CV_Category" runat="server" ControlToValidate="ddlCategories"
                                   Display="Dynamic" ErrorMessage="Please Select Category" Operator="GreaterThan"
                                   SkinID="CompareValidation" Type="Integer" ValueToCompare="0">
                                   </asp:CompareValidator>
                            </td>
                           <td align="left" style="width: 153px">
                               Client:<span style="color: #ff0000">*</span></td>
                           <td>
                               <asp:DropDownList ID="ddlClients" runat="server" DataSourceID="SDS_Clients"
                                   DataTextField="Name" DataValueField="ID" SkinID="SmallTextCombo" Width="150px">
                               </asp:DropDownList>
                               <asp:SqlDataSource ID="SDS_Clients" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                   SelectCommand="Clients_GetAll" 
                                   SelectCommandType="StoredProcedure"
                                   DataSourceMode="DataReader">
                               </asp:SqlDataSource>
                               <asp:CompareValidator ID="CV_Client" runat="server" ControlToValidate="ddlClients"
                                   Display="Dynamic" ErrorMessage="Please Select Client" Operator="GreaterThan"
                                   SkinID="CompareValidation" Type="Integer" ValueToCompare="0"></asp:CompareValidator></td>
                           <td style="width: 15%">
                           </td>
                       </tr>
                       <tr >
                           <td align="left" style="width: 15%; height: 25px;">
                           </td>
                           <td align="left">
                               </td>
                           <td></td>
                           <td align="left">
                               <asp:SqlDataSource ID="SDS_TicketsAttachments" 
                               runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                   SelectCommand="PM_Ticket_Features_Attachments_GetByTicketID" 
                                   SelectCommandType="StoredProcedure"
                                   DataSourceMode="DataReader">
                                   <SelectParameters>
                                       <asp:ControlParameter ControlID="TicketID" Name="Ticket_FeatureID" PropertyName="Value"
                                           Type="Int32" />
                                   </SelectParameters>
                               </asp:SqlDataSource>
                           </td>
                           <td >                          
                               <div class="LeadGreenButton" onclick="showAttachFiles();" style="width:100px;">
                                   Attach File
                                   <img align="absMiddle"  height="10" src="../images/blt_resetFilters.gif" width="10" />
                               </div>
                           </td>
                           <td style="width: 15%">
                           </td>
                       </tr>
                        <tr class="SimpleExSmallBold" id="trFiles" style="display:none;border:none;">
                           <td  align="left" style="width: 15%; height: 25px">
                           </td> 
                          <td colspan="4" style="height:25px;">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td style="border:none;" rowspan="2" align="center" width="5%"><img src="../images/ico_attachment.gif" align="middle" alt="attach" /></td>
                                    <td style="border:none;" id="tdFiles"></td>
                                </tr>
                            </table> 
                          </td>
                          <td style="width: 15%">
                           </td>
                        </tr>
                       <tr style="vertical-align:middle;">
                           <td align="left" colspan="1" style="width: 15%; height: 25px;">
                           </td>
                           <td align="left" colspan="4" style="height: 25px;">
                               <asp:Repeater 
                                    ID="rptrTicketAttachments" 
                                    runat="server" 
                                    DataSourceID="SDS_TicketsAttachments" 
                                    EnableViewState="false">                                  
                                   <ItemTemplate>
                                       [<a href='<%= ConfigurationManager.AppSettings("PMAttachmentPath") %><%# Container.DataItem("FilePath")  %>'
                                           target="_blank"><%#Container.DataItem("FileName")%>
                                       </a>] &nbsp;
                                   </ItemTemplate>
                               </asp:Repeater>
                           </td>
                           <td align="left" colspan="1" style="width: 15%; height: 25px;">
                           </td>
                       </tr>
                       <tr>
                           <td colspan="1" style="width: 15%; height:100%;">
                           </td>
                           <td colspan="4" style="text-align :center ;">
                               &nbsp;<asp:TextBox ID="txtDescription" runat="server" MaxLength="500" Height="90%" 
                                    SkinID="GreenMultilineTextbox" TextMode="MultiLine"
                                   Width="550px" Rows="25"></asp:TextBox></td>
                           <td colspan="1" style="width: 15%">
                           </td>
                       </tr>
                       <tr>
                           <td colspan="1" style="width: 15%;height:30px;">
                           </td>
                           <td colspan="4" style="text-align: center">
                               Fields marked with an asterisk <span class="RequiredField" style="color: #000000"><span
                                   style="color: #ff0000">*</span></span> are required.</td>
                           <td colspan="1" style="width: 15%">
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
                    CssClass="Btn3D" 
                    Width="80px" 
                    CommandName="Insert" />&nbsp;&nbsp;
                  <asp:Button 
                  id="btnBack" 
                  runat="server"
                  Text="Cancel"
                  cssclass="Btn3D"/>      
               </td>
            </tr>                              
        </table>
    </div>
    <div align="center" id="Attachment" style="display:none; border:0px solid black; position:absolute;left:30%; top:35%; width: 450px; height: 210px;">
        <table align="center" width="100%" cellpadding="0" cellspacing="0" class="MainAlertDiv">
	        <tr>
	          <th height="21" align="left" valign="middle">&nbsp;Attachments - Alert</th>
	          <th align="right" valign="top"><img src="../images/closebox2.gif" onClick="OnAttachmentSubmit(); return false;" style="cursor:pointer;"></th>
	        </tr>
	        <tr>
	        <td width="100%" valign="top" colspan="2">
		        <table align="center" width="100%" cellpadding="0" cellspacing="0" class="MainAlertDiv" style="border:none;">
			        <tr><td align="center" height="25" colspan="2">Attach Files!</td></tr>
                    <tr>
                    <td></td>
                    <td  height="25" >
                        <font size="2" face="verdana, Arial, Helvetica, sans-serif">
                           &nbsp;File 1: <span id="spnFile1">
                                                <asp:FileUpload id="file1" Runat="server" style="width:330px;" />
                                                <asp:RegularExpressionValidator 
                                                    ID="REV_file1" runat="server" 
                                                    ErrorMessage="Attachment must be a .jpg, .jpeg, .png, .gif, .doc,.docx, .pdf, .txt, .rtf, .xls, .xlsx, .rar, or .zip file" 
                                                    ValidationExpression="^.*(.txt|.zip|.doc|.jpg|.jpeg|.png|.gif|.doc|.docx|.pdf|.rtf|.xls|.xlsx|.rar|.TXT|.ZIP|.DOC|.DOCX|.XLS|.XLSX|.JPG|.JPEG|.PNG|.GIF|.DOC|.DOCX|.XLS|.XLSX|.RAR|.PDF|.RTF)$"  
                                                    Display="Dynamic"                                           
                                                    ControlToValidate="file1" Font-Size="10px" >
                                                </asp:RegularExpressionValidator>
                                           </span><br>
                            &nbsp;File 2: <span id="spnFile2">
                                                <asp:FileUpload id="file2" Runat="server" style="width:330px;" />
                                                <asp:RegularExpressionValidator 
                                                    id="REV_file2" runat="server" 
                                                    ErrorMessage="Attachment must be a .jpg, .jpeg, .png, .gif, .doc,.docx, .pdf, .txt, .rtf, .xls, .xlsx, .rar, or .zip file" 
                                                    ValidationExpression="^.*(.txt|.zip|.doc|.jpg|.jpeg|.png|.gif|.doc|.docx|.pdf|.rtf|.xls|.xlsx|.rar|.TXT|.ZIP|.DOC|.DOCX|.XLS|.XLSX|.JPG|.JPEG|.PNG|.GIF|.DOC|.DOCX|.XLS|.XLSX|.RAR|.PDF|.RTF)$" 
                                                    Display="Dynamic"                                           
                                                    ControlToValidate="file2" Font-Size="10px">
                                                </asp:RegularExpressionValidator>
                                          </span><br>
                            &nbsp;File 3: <span id="spnFile3">
                                                <asp:FileUpload id="file3" Runat="server" style="width:330px;" />
                                                <asp:RegularExpressionValidator 
                                                    id="REV_file3" runat="server" 
                                                    ErrorMessage="Attachment must be a .jpg, .jpeg, .png, .gif, .doc,.docx, .pdf, .txt, .rtf, .xls, .xlsx, .rar, or .zip file" 
                                                    ValidationExpression="^.*(.txt|.zip|.doc|.jpg|.jpeg|.png|.gif|.doc|.docx|.pdf|.rtf|.xls|.xlsx|.rar|.TXT|.ZIP|.DOC|.DOCX|.XLS|.XLSX|.JPG|.JPEG|.PNG|.GIF|.DOC|.DOCX|.XLS|.XLSX|.RAR|.PDF|.RTF)$" 
                                                    Display="Dynamic"                                           
                                                    ControlToValidate="file3" Font-Size="10px">
                                                </asp:RegularExpressionValidator>
                                           </span></font></td></tr>
                    <tr><td colspan="2" height="30" align="center">
                        <input type="button" value="OK" style="width:80px;"  onclick="OnAttachmentSubmit(); "  class="btnExtraSimple">&nbsp;
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


       


function ResetAttachment2()
 {
   var Fupload = document.getElementById('<%=File2.ClientID%>');
   var TD = Fupload.parentElement ;
   var str = TD.innerHTML;
    str = str.replace(Fupload.value,'');
    TD.innerHTML = str ;
   } 
 function ResetAttachment1()
  {
 
   var Fupload = document.getElementById('<%=File1.ClientID%>');
    var TD = Fupload.parentElement ;
   var str = TD.innerHTML;
    str = str.replace(Fupload.value,'');
    TD.innerHTML = str ;
   
   } 
     function ResetAttachment3()
  {
 
   var Fupload = document.getElementById('<%=File3.ClientID%>');
    var TD = Fupload.parentElement ;
   var str = TD.innerHTML;
    str = str.replace(Fupload.value,'');
    TD.innerHTML = str ;
   
   } 
   function showAttachFiles()
    {
        document.getElementById("Attachment").style.display='inline';
        //document.getElementById('ddlPriority').style.display='none';
    }
    
    function OnAttachmentSubmit()
    {
   
   
      var Fupload = document.getElementById('<%=File1.ClientID%>')
        var count = 0 
        if (Fupload.value != '' )
        {
        count = count+1
        }
        Fupload = document.getElementById('<%=File2.ClientID%>')
        if (Fupload.value != '' )
        {
        count = count+1
        }
        Fupload = document.getElementById('<%=File3.ClientID%>')
        if (Fupload.value != '' )
        {
        count = count+1
        }       
      
        document.getElementById("Attachment").style.display='none';
        //document.getElementById('ddlPriority').style.display='inline';
	}

// function textCounter(field)
//     {
//   
//        if (field.value.length > 500)        
//        field.value = field.value.substring(0, 500);
//    }
    
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
	        if (flagCancel == 1)
	        {
		        ResetAttachment3();ResetAttachment2();ResetAttachment1();
	        }
        	
	        getElement('Attachment').style.display = 'none';	
	        var strFiles = '';
	        if (document.getElementById('<%=File1.ClientID%>').value != '')
		        strFiles += '<table style=\'display:inline;\' class=SimpleExSmallBold><tr><td rowspan=2 style=\'border:none;\'>&nbsp;&nbsp;</td><td style=\'border:none;\'>'+trimFileName(getElement('file1').value.substr(getElement('file1').value.lastIndexOf("\\")+1))+'</td></tr><tr><td style=\'cursor:pointer;font-size:7px;border:none;\' align=right onClick=\'ResetAttachment1();OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>' ;
	        if (document.getElementById('<%=File2.ClientID%>').value != '')
		        strFiles += '<table style=\'display:inline;\' class=SimpleExSmallBold><tr><td rowspan=2 style=\'border:none;\'>&nbsp;&nbsp;</td><td style=\'border:none;\'>'+trimFileName(getElement('file2').value.substr(getElement('file2').value.lastIndexOf("\\")+1))+'</td></tr><tr><td style=\'cursor:pointer;font-size:7px;border:none;\' align=right onClick=\'ResetAttachment2();OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>' ;
	        if (document.getElementById('<%=File3.ClientID%>').value != '')
		        strFiles += '<table style=\'display:inline;\' class=SimpleExSmallBold><tr><td rowspan=2 style=\'border:none;\'>&nbsp;&nbsp;</td><td style=\'border:none;\'>'+trimFileName(getElement('file3').value.substr(getElement('file3').value.lastIndexOf("\\")+1))+'</td></tr><tr><td style=\'cursor:pointer;font-size:7px;border:none;\' align=right onClick=\'ResetAttachment3();OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>' ;
        	
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
   
 </script>
</html>
