<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Add_Topic.aspx.vb" Inherits="KB_Add_Topic"
    Theme="Default" EnableTheming="true" ValidateRequest="false" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Add Topic</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <link href="../App_Themes/Default/Calendar/style.css" rel="stylesheet" type="text/css" />
    
  
    <style type="text/css">
        ul
 {
     float:none !important
 }
 
  ul.reToolbar
 {
     float:left !important
 }
 body 
{
	margin:0px;

	font-family: Arial, verdana, Helvetica, sans-serif;
}
table {
	font-family: Arial,verdana,  Helvetica, sans-serif;
	font-size: 13px;
	font-weight: normal;
	color: #000000;
}
 </style>
</head>
<body style="margin: 0px; height: 100%; width: 100%;">
    <form id="form1" runat="server">
    
        <div>
            <asp:HiddenField runat="server" ID="hdnCategoryID" Value="0" />
            <asp:HiddenField runat="server" ID="hdnParentID" Value="0" />
            <table cellpadding="0" cellspacing="0" border="0" style="width: 100%; height: 100%;">
                <tr class="HeaderRowGreen">
                    <td style="height: 31px; width: 50%; font-weight: bold; font-family: Helvetica;">
                        <asp:Label ID="lblHeading" runat="server" Text="New Topic" font-weight="bold" Font-Names="Helvetica"></asp:Label>
                    </td>
                    <td style="text-align: right;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="background-color: #DAF5D6; padding-left: 2px; padding-right: 2px;"
                        align="center" valign="top">
                        <table cellpadding="0" cellspacing="0" border="0" style="width: 100%; height: 100%;">
                            <tr>
                                <td align="left" style="padding-left: 5px; width: 20%; height: 10px">
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="height: 25px; padding-left: 5px; width: 20%;">
                                    Category:<span style="font-size: 8pt; color: #ff0000">*</span></td>
                                <td>
                                    <asp:DropDownList ID="ddlCategories" runat="server" CssClass="SmallFontInput" Width="75%" DataSourceID="SDsCategories" DataTextField="Name" DataValueField="ID">
                                    </asp:DropDownList>
                                    <asp:Label ID="lblChapter" runat="server" Font-Bold="True" Visible="false"></asp:Label>
                                    <asp:SqlDataSource ID="SDsCategories" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                        SelectCommand="KB_Get_Categories" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                    <asp:CompareValidator ID="Val_category" runat="server" ControlToValidate="ddlCategories"
                                        ErrorMessage="Select Category" Operator="GreaterThan" Type="Integer" ValueToCompare="0" CssClass="ErrorMessage"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 25px; padding-left: 5px; width: 20%; " align="left">
                                    Title:<span style="font-size: 8pt; color: #ff0000">*</span></td>
                                <td valign="middle" style="height: 25px">
                                    <asp:TextBox ID="txtName" runat="server" CssClass="SmallGreenTextBox" MaxLength="75"
                                        Width="75%"></asp:TextBox>&nbsp;
                                    <asp:RequiredFieldValidator ID="val_Title" runat="server" ControlToValidate="txtName"
                                        CssClass="ErrorMessage" ErrorMessage="Enter Title" Width="70px" Display="Dynamic"></asp:RequiredFieldValidator></td>
                            </tr>
                    
                            <tr>
                                <td align="left" style="padding-left: 5px; width: 20%; height: 30px" valign="top">
                                    Keywords:<br>
                                    <span style="font-size:11px;">(Comma Seprated)</span><br>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtKeyword" runat="server" CssClass="SmallGreenTextBox" Width="75%"
                                        Height="46px" TextMode="MultiLine" MaxLength="2000"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td align="left" style="padding-left: 5px; width: 20%;">
                                Description:<span style="font-size: 8pt; color: #ff0000">*</span>
                                </td>
                                <td style="height: 5px;">
                                    <asp:RequiredFieldValidator ID="val_Editor" runat="server" ErrorMessage="Enter Description &nbsp;&nbsp;"
                                        ControlToValidate="editorDescription" Display="Dynamic" CssClass="ErrorMessage"></asp:RequiredFieldValidator><asp:Label Style="font-size: 8pt; color: #ff0000" ID="lblMsg" runat="server"></asp:Label></td>
                            </tr>                           
                            <tr>
                                <td align="center" colspan="2" style="padding: 5px;" valign="top">   
                                
                                
                                <telerik:RadEditor runat="server" ID="editorDescription" 
                                      
                                            Width="61%"  EnableResize="False"   ImageManager-MaxUploadFileSize="5242880"
                                          ToolsFile="~/RadControls/Editor/EditorMenuTools.xml" 
                                          AllowScripts="True" Skin="WebBlue" OnClientLoad="OnClientLoad" >
                                        </telerik:RadEditor>
                                        
                               <%--                                          
                                    <radE:radeditor ID="editorDescription" runat="server" Skin="Custom" 
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
				                          AllowThumbGeneration="True"
				                          height="100%"
                                          width="99%" 
                                          StripAbsoluteImagesPaths="false" ImagesFilters="*.gif,*.xbm,*.xpm,*.png,*.ief,*.jpg,*.jpe,*.jpeg,*.tiff,*.tif,*.rgb,*.g3f,*.xwd,*.pict,*.ppm,*.pgm,*.pbm,*.pnm,*.bmp,*.ras,*.pcd,*.cgm,*.mil,*.cal,*.fif,*.dsf,*.cmx,*.wi,*.dwg,*.dxf,*.svf" EnableEnhancedEdit="False"> 
                                    </radE:radeditor>--%>
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>               
                <tr class="FooterRowGreen">
                    <td align="center" colspan="2" style="height: 31px; padding-right: 31px;">
                        <asp:Button ID="BtnSave" runat="server" CssClass="btnGreen" Style="width: 80px" Text="Save" />&nbsp;<asp:Button
                            ID="BtnCancel" runat="server" CausesValidation="False" CssClass="btnGreen" Style="width: 80px"
                            Text="Cancel" /></td>
                </tr>
            </table>
        </div>
        
         <asp:ScriptManager ID="ScriptManager2" runat="server">
    </asp:ScriptManager>
    </form>

<script type="text/javascript" language="javascript">
RadEditorCommandList["ImageManager1"] = function(commandName, editor, oTool)
{      
      editor.Fire("ImageManager"); //open the Image Manager
      var oWindow = document.getElementById("RadWindowContentWrapper0"); //get a reference to the dialog
      //set the desired position of the dialog
      oWindow.style.top = "15px"; 
      oWindow.style.left = "15px"
}; 

function Editor_Validation(sender,args)
{
    
    var oEditor = document.getElementById('<%= editorDescription.ClientID %>');
    if (oEditor.GetXHTML( true )== '')
           args.IsValid=false; 
    else
          args.IsValid=true; 
}

        
    function chk_val(val) {
    return /^\d+$/.test(val);
}


function OnClientLoad(sender, args) {

    $(".rade_toolZone").find("Ul").each(function () {

        //        $(this).width("");
    });
}
    </script>

</body>
</html>