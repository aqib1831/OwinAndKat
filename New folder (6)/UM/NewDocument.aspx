
<%@ Page Language="VB" AutoEventWireup="false" CodeFile="NewDocument.aspx.vb" Inherits="UM_NewDocument" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>New Document</title>
     
     <link href="../UM/style/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script src="../scripts/jquery-1.7.2.js" type="text/javascript"></script>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <meta http-equiv="Page-Enter" content="progid:DXImageTransform.Microsoft.Fade(duration=1)" />
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=1)" />
    
    <style type="text/css">
     
 ul
 {
     float:none !important
 }
 
  ul.reToolbar
 {
     float:left !important
 }
   
    .SummaryValidationDiv
    {
        border-left: 1px solid #6095B5;
            border-right: 1px solid #6095B5;
            border-top: 1px solid #6095B5;
            border-bottom: 1px groove #6095B5;
   filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#C8E2FC,endColorStr=#EFF6FC);
   background-image:-ms-linear-gradient(top, #C8E2FC 0%, #EFF6FC 100%);
            left: 26%;
            top: 21%;    
            width: 25%;
        z-index:20;
    }
    </style>
</head>
<body style="margin:0px; overflow:auto;">
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager2" runat="server">
    </asp:ScriptManager>
     <div>
        <asp:ValidationSummary
                style="position:absolute;z-Index:1000; width:50%; height:55%;"  
                ID="ValidationSummary3" 
                runat="server"
                Font-Bold="true" 
                Font-Size="11px"
                ForeColor="black" 
                ShowMessageBox="false"
                ValidationGroup="vgTopic"
                DisplayMode="BulletList"
                HeaderText="<table width='100%' cellpadding='4' cellspacing='0' border='0' ><tr style='height:31px;'><td style='text-align:left;' class='ErrorMessageWindowTitleNew'>Alert</td><td style='text-align:right;' class='ErrorMessageWindowTitleNew' align='right'><img src='../images/closebox2.gif' style='cursor:pointer;' alt='Close' onclick='CloseValidationSummaryDiv();'></td></tr></table><br>&nbsp;&nbsp;&nbsp;<img src='../images/icn_info.jpg'><input type='button' value='Close' style='position:absolute; left:45%; top:80%; height:22px; width:50px;' align='absmiddle' class='Btn3D' onclick='CloseValidationSummaryDiv();' />&nbsp;&nbsp;Please fix the following problem(s) to proceed!"
                CssClass="SummaryValidationDiv" />
    </div>
     <iframe id="divDisable" marginheight="0" marginwidth="0" scrolling="no" frameborder="0" style="z-index:09;width:0;height:0; background-color:black;position:absolute;filter:progid:DXImageTransform.Microsoft.alpha(opacity=50);opacity:0.5;" src="blank.htm" ></iframe>
    <asp:HiddenField ID="hdnDocumentID" runat="server" Value="0" />    
 
    <div>
    <table border="0" cellpadding="0" cellspacing="0" style="width:100%;height:100%; background-color:#EBEBEB;">
    <tr class="GalleryTitle" style="background-image:url('images/bg_mainHdr_1.jpg');height:31px;">
        <td>
            <b>&nbsp;<asp:Label ID="lblPageHeader" runat="server" Text="Add"></asp:Label>&nbsp;Document</b>
        </td>
     </tr> 
    <tr>
        <td style="width:100%;height:100%;"> 
            <table border="0" cellpadding="0" cellspacing="0" style="padding:3px; width:100%; height:100%;" class="Form">
                <tr>
                    <td align="right">
                        <span class="BoldText">Title:<span class="RequiredField">*</span>&nbsp;&nbsp;</span>
                    </td>
                    <td>
                        <asp:TextBox ID="txtTitle" ValidationGroup="vgTopic" runat="server" MaxLength="100" CssClass="txtGray" Width="80%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvTopic" runat="server" ErrorMessage="Enter title" Display="none" ControlToValidate="txtTitle" ValidationGroup="vgTopic"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cvTopic" ControlToValidate="txtTitle" runat="server" Display="Dynamic"  ErrorMessage="<br />Document with this title exits"></asp:CustomValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Enter valid text" ControlToValidate="txtTitle" ValidationExpression="^[^<>]*$" Display="None"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <span class="BoldText">Category:<span class="RequiredField">*</span>&nbsp;&nbsp;</span>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlAddCategories" runat="server" DataTextField="Title" DataValueField="ID" DataSourceID="sdsAddCategories" CssClass="txtGray" Width="80%">
                         </asp:DropDownList>
                         <asp:SqlDataSource ID="sdsAddCategories" runat="server" SelectCommand="UM_Categories_GetAllForList" SelectCommandType="StoredProcedure" 
                         ConnectionString="<%$ConnectionStrings:PortalConnectionString %>"></asp:SqlDataSource> 
                         <asp:RequiredFieldValidator ID="rfv_AddCategories" runat="server" InitialValue="0" ErrorMessage="Select a manual" Display="None" ControlToValidate="ddlAddCategories" ValidationGroup="vgTopic"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr id="TRuploadfile" runat="server">
                    <td align="right">
                        <span class="BoldText">Document:<span class="RequiredField">*</span>&nbsp;&nbsp;</span>
                    </td>
                    <td>
                        <asp:FileUpload ID="fileUploadDocument" runat="server" CssClass="fileUpload" Width="80%"/>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" InitialValue="0" ErrorMessage="upload a file" Display="None" ControlToValidate="fileUploadDocument" ValidationGroup="vgTopic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" Display="None"  
                        ValidationExpression="^.*(.txt|.zip|.doc|.jpg|.jpeg|.png|.gif|.doc|.docx|.pdf|.rtf|.xls|.xlsx|.rar|.TXT|.ZIP|.DOC|.DOCX|.XLS|.XLSX|.JPG|.JPEG|.PNG|.GIF|.DOC|.DOCX|.XLS|.XLSX|.RAR|.PDF|.RTF)$"
                        ErrorMessage="Attachment must be a .jpg, .jpeg, .png, .gif, .doc, .pdf, .txt, .rtf or .zip file"
                        ControlToValidate="fileUploadDocument" ValidationGroup="vgTopic">
                        </asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator ID="rfv_fileUpload" runat="server" ErrorMessage="upload a document" Display="None" ControlToValidate="fileUploadDocument" ValidationGroup="vgTopic"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                 <tr id="TRUploadedfile" runat="server" style="display:none;">
                    <td align="right">
                        <span class="BoldText">Document:<span class="RequiredField">*</span>&nbsp;&nbsp;</span>
                    </td>
                    <td>
                         <a id="uploadedfile" runat="server"></a>
                    </td>
                </tr>
                <tr style="height:100%; padding:3;">
                    <td align="right">  
                        <span class="BoldText">Description:<span class="RequiredField">*</span>&nbsp;&nbsp;</span>
                    </td>
                    <td>
                                       <telerik:RadEditor runat="server" ID="txtDescription" 
                                      
                                            Width="80%"  EnableResize="False"   ImageManager-MaxUploadFileSize="5242880"
                                          ToolsFile="~/RadControls/Editor/EditorMenuTools.xml" 
                                          AllowScripts="True" Skin="WebBlue" OnClientLoad="OnClientLoad" >
                                        </telerik:RadEditor>

                 

                  <%--
                        <radE:radeditor ID="txtDescription" runat="server" Skin="Custom" 
                          ToolsFile="~/RadControls/Editor/MinMenuTools.xml" 
                          RadControlsDir="~/RadControls/Editor/RadControls/"                                                                                                    
                          ShowSubmitCancelButtons="false"
                          ShowPreviewMode="false"
                          SpellAllowAddCustom="false"
                          FocusOnLoad="true" 
                          EnableContextMenus="true"
                          Visible="true"                                                                     
                          Editable="True" 
                          AllowThumbGeneration="True"
                          height="100%"
                          width="80%"
                          EnableDocking="false" 
                          EnableClientSerialize="false" 
                          CacheLocalization="true" 
                          EnableViewState="false"> 
                         </radE:radeditor>--%>

                        <asp:RequiredFieldValidator ID="rfv_Description" runat="server" ErrorMessage="Enter description" Display="None" ControlToValidate="txtDescription" ValidationGroup="vgTopic"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr style="height:30px; background-color:#dcdcdc;">
                    <td align="center" colspan="2" style="border-top:solid 1px #609BD3;">
                         <asp:Button ID="btnSaveDocument" runat="server" CssClass="btnSimpleSmall" Text="Save" ValidationGroup="vgTopic" OnClientClick="javascript:if(Validate()== false) return false;" />
                         <input type="button" value="Cancel"  class="btnSimpleSmall"  id="btnCancelTopic" onclick="Cancel();" />
                    </td>
                </tr>
        </table>  
        </td>
    </tr>
    </table>
    </div>


    <script language="javascript" type="text/javascript">
        function Cancel() {
            window.location = "DocumentList.aspx?UMType=" + '<%=Request.QueryString("UMType")%>';
        }
        function SetPosition() {
            var divDisable = document.getElementById('divDisable');
            divDisable.style.width = document.body.scrollWidth
            divDisable.style.height = document.body.scrollHeight
            divDisable.style.display = 'block';

        }
        function Reset() {
            var divDisable = document.getElementById('divDisable');
            divDisable.style.width = 0;
            divDisable.style.height = 0;
            divDisable.style.display = 'none';
            return false;
        }
        function Validate() {
            if (Page_ClientValidate('vgTopic') == false) {
                SetPosition();
                return false;
            }
            else
                return true;
        }
        function CloseValidationSummaryDiv() {
            var ValidationSummary3 = document.getElementById('ValidationSummary3')
            if (ValidationSummary3 != null)
                ValidationSummary3.style.display = 'none';
            Reset();
        }

        function OnClientLoad(sender, args) {
          
          $(".rade_toolZone").find("Ul").each(function () {
          
              $(this).width("");
});
        }
  
    </script>
    </form>
</body>
</html>