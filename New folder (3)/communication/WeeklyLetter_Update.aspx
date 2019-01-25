<%@ Page Language="VB" AutoEventWireup="false" CodeFile="WeeklyLetter_Update.aspx.vb" Inherits="admin_comm_WeeklyLetter_Update" Theme="Default"  %>
<%@ Register TagPrefix="radE" Namespace="Telerik.WebControls" Assembly="RadEditor.Net2" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<title>EA Weekly</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>   
</head>
<body style="overflow:hidden;" leftmargin="1" topmargin="1">
  <form id="form1" runat="server">
<div>
<asp:HiddenField ID="hdnID" runat="server" Value="" />
<table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%; ">
 <tr>
    <td colspan="2" style="height:100%; width:100%;" align="center">
       <table width="100%"  cellspacing="0" border="0" style="background-color:#D8EAFC;height:100%;border-left:1px solid #609BD3;border-right:1px solid #609BD3;border-top:1px solid #609BD3;"  >
          <tr  class="HeaderRowGreen">
             <td colspan="2" style="height:31px;background-color:#BDE4B8;font-size:13px;font-weight:bold;padding:5px;width:90%;border-bottom:1px solid #609BD3;">
                 <asp:Literal ID="ltlHeading" runat="server" Text="Weekly Letter"></asp:Literal>
             </td>
          </tr>              
          <tr>
            <td align="center" colspan="2" style="height:100%; width:100%;background-color:#DAF5D6;font-size:11px;">
                  <div style="overflow:auto;height:100%;" id="Div1" >
                     <table cellpadding="0" cellspacing="0" border="0" style="height:100%;width:100%;background-color:#DAF5D6;">
                        <tr>
                          <td style="height:100%;width:100%;" >
                             <div style="height:100%;width:100%;overflow:auto;"  id="ScrollPanel1" >                                        
                                            
                                            <table cellpadding="0" cellspacing="0" border="0" style="height:100%;width:100%;padding-left:4px; padding-right:4px;font-size:12px;" >
                                                <tr>
                                                    <td colspan="2" style="height:5px;">                                                             
                                                    </td>
                                                </tr>  
                                                <tr>
                                                    <td style="width:80%;" >
                                                        Weekly Letters :<span class="RequiredField">*</span><br />
                                                        <asp:DropDownList ID="ddlWeeklyLetters" runat="server" DataSourceID="odsPendingWeekLetters"
                                                            DataTextField="Title" DataValueField="ID" Width="75%" SkinID="SmallTextCombo"  >
                                                        </asp:DropDownList>                                                                                                             
                                                        <br />
                                                        <asp:RequiredFieldValidator ID="vald_WeeklyLetter" runat="server" ControlToValidate="ddlWeeklyLetters"
                                                            CssClass="RequiredField" Display="Dynamic" ErrorMessage="Please select a weekly letter" SkinID="RequiredFieldValidation" 
                                                            InitialValue="Select..."></asp:RequiredFieldValidator>
                                                        <asp:ObjectDataSource ID="odsPendingWeekLetters" runat="server"
                                                            SelectMethod="WeeklyLetter_GetAll_PendingLetters" TypeName="Portal.BLL.Communication.WeeklyLetter">
                                                            <SelectParameters>
                                                                <asp:Parameter DefaultValue="" Name="HasForum" Type="Boolean"/>
                                                            </SelectParameters>
                                                        </asp:ObjectDataSource>
                                                    </td>
                                                    <td id="tdSequence" runat="server" valign="top" style="width:20%;">
                                                        Sequence: <span class="RequiredField">*</span><br />
                                                        <asp:TextBox 
                                                            ID="txtSequence" 
                                                            Width="100px" SkinID="GreenSmallTextbox"
                                                            runat="server" MaxLength="4" />
                                                        <br />
                                                        <asp:RequiredFieldValidator ID="rfvSequence" runat="server" 
                                                            ControlToValidate="txtSequence" 
                                                            CssClass="RequiredField" SkinID="RequiredFieldValidation" 
                                                            ErrorMessage="Please enter sequence" 
                                                            Display="Dynamic" />                                                             
                                                        <asp:RangeValidator ID="RangeValidator1" 
                                                             runat="server" 
                                                             ControlToValidate="txtSequence" 
                                                             CssClass="RequiredField" 
                                                             ErrorMessage="Please enter valid sequence" 
                                                             Type="integer" MinimumValue="0"
                                                             MaximumValue="9999"                                                             
                                                             Display="Dynamic" ></asp:RangeValidator>                                                             
                                                    </td>
                                                </tr>
                                                 <tr valign="top" runat="server" id="tr1" style="padding-top:3px;">                                                                                                 
                                                    <td style="height: 25px; width:100%;" colspan="2"><asp:Literal ID="ltrlQuote" runat="server" Text="Quote:"></asp:Literal> <span class="RequiredField">*</span><br />
                                                        <asp:TextBox 
                                                            ID="txtQuote" 
                                                            runat="server" 
                                                            Text = '<%# Bind("HeadLine") %>'
                                                            TextMode="MultiLine" 
                                                            SkinID="GreenSmallTextbox" 
                                                            Rows="3" 
                                                            Width="100%" 
                                                             />
                                                           <asp:RequiredFieldValidator ID="val_Quote" runat="server" 
                                                            ControlToValidate="txtQuote" 
                                                            CssClass="RequiredField" SkinID="RequiredFieldValidation"  
                                                            ErrorMessage="Please enter quote" 
                                                            Display="Dynamic" 
                                                             />
                                                             <asp:RegularExpressionValidator 
                                                             ID="regVal_Quote" 
                                                             ControlToValidate="txtQuote" 
                                                             CssClass="RequiredField" SkinID="RequiredFieldValidation" 
                                                             ErrorMessage="Quote cannot be greater than 500 characters." 
                                                             ValidationExpression="^[\s\S]{0,500}$" 
                                                             runat="server"
                                                             Display="Dynamic" 
                                                              />
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtQuote"
                                                            ErrorMessage="Html is not allowed. Please enter valid text." Display="Dynamic" SkinID="RequiredFieldValidation" 
                                                            ValidationExpression="^[^<>]*$" CssClass="RequiredField"></asp:RegularExpressionValidator></td>
                                                </tr>    
                                                <tr valign="top" style="padding-top:3px; ">
                                                    <td style="height: 30px; width:100%;" colspan="2">
                                                    <asp:Label ID="lblSmallDescription" runat="server" Text="Small Description:" />  <span class="RequiredField">*</span><br />
                                                        <asp:TextBox 
                                                            ID="txtSmallDescription" 
                                                            runat="server" 
                                                            TextMode="MultiLine" 
                                                            SkinID="GreenMultilineTextbox" 
                                                            Rows="3" 
                                                            Width="100%" 
                                                             />
                                                           <asp:RequiredFieldValidator ID="rfvSmallDescrp" runat="server" 
                                                            ControlToValidate="txtSmallDescription" 
                                                            CssClass="RequiredField" SkinID="RequiredFieldValidation"  
                                                            ErrorMessage="Please enter small description" 
                                                            Display="Dynamic" 
                                                            />
                                                            
                                                            <asp:RegularExpressionValidator 
                                                             ID="revSmallDescrp" 
                                                             ControlToValidate="txtSmallDescription" 
                                                             CssClass="RequiredField" SkinID="RequiredFieldValidation"  
                                                             Text="Small Description cannot be greater than 250 characters." 
                                                             ValidationExpression="^[\s\S]{0,250}$" 
                                                             runat="server"
                                                             Display="Dynamic" 
                                                              />
                                                        <asp:RegularExpressionValidator ID="revSmallDescrpHtml" runat="server" 
                                                            Display="Dynamic" ControlToValidate="txtSmallDescription" SkinID="RequiredFieldValidation"  
                                                            ErrorMessage="Html is not allowed. Please enter valid text." ValidationExpression="^[^<>]*$"></asp:RegularExpressionValidator></td>
                                                </tr>                                                                                                                                                                                                                                                                                                                                                                                                              
                                                <tr>
                                                    <td colspan="2" height="100%">
                                                    Detail Description: <span class="RequiredField">*</span><br />
                                                      <rade:radeditor ID="RadEditor" runat="server" Skin="Custom"
                                                             ToolsFile="~/RadControls/Editor/EditorMenuTools.xml" 
                                                            RadControlsDir="~/RadControls/Editor/RadControls/"
                                                            ShowSubmitCancelButtons="false"
                                                            ShowPreviewMode="true"                                                            
                                                            ShowHtmlMode="true"
                                                            SpellAllowAddCustom="false"
                                                            FocusOnLoad="true" 
                                                            EnableContextMenus="true"
                                                            Visible="true"                                                                     
				                                            Editable="True" 
				                                            AllowThumbGeneration="true"
				                                            height="90%"
                                                            width="100%" 
                                                            StripAbsoluteImagesPaths="false" ImagesFilters="*.gif,*.xbm,*.xpm,*.png,*.ief,*.jpg,*.jpe,*.jpeg,*.tiff,*.tif,*.rgb,*.g3f,*.xwd,*.pict,*.ppm,*.pgm,*.pbm,*.pnm,*.bmp,*.ras,*.pcd,*.cgm,*.mil,*.cal,*.fif,*.dsf,*.cmx,*.wi,*.dwg,*.dxf,*.svf"   
                                                            >
                                                        </rade:radeditor>                                                     
                                                        <asp:requiredfieldvalidator 
                                                            ID="RFV_RadEditor" 
                                                            runat="server"
                                                            Display="Dynamic" SkinID="RequiredFieldValidation"   
                                                            ControlToValidate="RadEditor" 
                                                            ErrorMessage="Please Enter Description">
                                                       </asp:requiredfieldvalidator>
                                                    </td>
                                                </tr>
                                          </table> 
                                                                       
                                    </div>
                                  </td>
                            </tr>
                     </table>                                    
                  </div>
            </td>
          </tr>                 
        </table>
    </td>
 </tr>
 <tr class="HeaderRowGreen">
    <td style="height:31px;background-color:#BDE4B8;font-size:12px; border-left:1px solid #609BD3; border-top:1px solid #609BD3; border-bottom:1px solid #609BD3;">
       &nbsp;
    </td>
    <td align="right"  style="height:31px;background-color:#BDE4B8;font-size:4px;border-right:1px solid #609BD3; border-top:1px solid #609BD3; border-bottom:1px solid #609BD3;">
       <asp:Button ID="btnSave" runat="server" CssClass="Btn3D" Text="Save" />
       <asp:Button ID="btnCancel" runat="server" CssClass="Btn3D" Text="Cancel" CausesValidation="false" />
    </td>
 </tr>
</table>  

</div>
</form>
<script type="text/javascript" language="javascript">
RadEditorCommandList["ImageManager1"] = function(commandName, editor, oTool)
{      
      editor.Fire("ImageManager"); //open the Image Manager
      var oWindow = document.getElementById("RadWindowContentWrapper0"); //get a reference to the dialog
      //set the desired position of the dialog
      oWindow.style.top = "15px"; 
      oWindow.style.left = "250px"
}; 
</script>
</body>
</html>
