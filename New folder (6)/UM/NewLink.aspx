<%@ Page Language="VB" AutoEventWireup="false" CodeFile="NewLink.aspx.vb" Inherits="UM_NewLink" %>
<%@ Register Assembly="RadEditor.Net2" Namespace="Telerik.WebControls" TagPrefix="radE" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>New Link</title>
    <link href="../UM/style/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <meta http-equiv="Page-Enter" content="progid:DXImageTransform.Microsoft.Fade(duration=1)" />
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=1)" />
    <style type="text/css">
    .SummaryValidationDiv
    {
        border: 1px solid #6095B5;
        filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#C8E2FC,endColorStr=#EFF6FC);
        left: 20%;
        top: 15%;    
        width: 25%;
        border-bottom-style:groove;  
        z-index:20;
    }
    </style>
</head>
<body style="margin:0px; overflow:auto;">
    <form id="form1" runat="server">
    <script language="javascript" type="text/javascript">
    function Back()
    {
        window.location = "LinksList.aspx?UMType="+'<%=Request.QueryString("UMType")%>';
    }
    function SetPosition()
    {
        var divDisable = document.getElementById('divDisable') ;
        divDisable.style.width = document.body.scrollWidth
        divDisable.style.height = document.body.scrollHeight
        divDisable.style.display = 'block';
    }
    function Reset()
    {    
        var divDisable = document.getElementById('divDisable') ;
        divDisable.style.width = 0;
        divDisable.style.height = 0;
        divDisable.style.display = 'none';
        return false;
    }
    function Validate()
    {
        if(Page_ClientValidate('vgTopic') == false)
        {
            SetPosition();
            return false;
        }
        else                     
              return true;
     } 
    function CloseValidationSummaryDiv()
    {
        var ValidationSummary3 = document.getElementById('ValidationSummary3')
        if (ValidationSummary3 != null)
        ValidationSummary3.style.display = 'none'; 
        Reset();            
    }
    </script>
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
    <asp:HiddenField ID="hdnLinkID" runat="server" Value="0" />    
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div>
    <table border="0" cellpadding="0" cellspacing="0" style="width:100%;height:100%; background-color:#EBEBEB;">
    <tr class="GalleryTitle" style="background-image:url('images/bg_mainHdr_1.jpg');height:31px;">
        <td>
            <b>&nbsp;<asp:Label ID="lblPageHeader" runat="server" Text="Add"></asp:Label>&nbsp;Link</b>
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
                        <asp:CustomValidator ID="cvTopic" ControlToValidate="txtTitle" runat="server" ErrorMessage="<br />Link with this title exits" Display="Dynamic"  ></asp:CustomValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Enter valid text" ControlToValidate="txtTitle" ValidationExpression="^[^<>]*$" Display="none"></asp:RegularExpressionValidator>
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
                         <asp:RequiredFieldValidator ID="rfv_AddCategories" runat="server" InitialValue="0" ErrorMessage="Select a manual" Display="none" ControlToValidate="ddlAddCategories" ValidationGroup="vgTopic"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <span class="BoldText">Link:<span class="RequiredField">*</span>&nbsp;&nbsp;</span>
                    </td>
                    <td>
                         <asp:TextBox ID="txtLink" runat="server" CssClass="txtGray" Width="80%" MaxLength="1000"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="rfv_Link" runat="server" ErrorMessage="Enter a link" Display="none" ControlToValidate="txtLink" ValidationGroup="vgTopic"></asp:RequiredFieldValidator>
                         <asp:RegularExpressionValidator ID="rev_Description" runat="server" ErrorMessage="Enter valid URL" ControlToValidate="txtLink" ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?" Display="none" ValidationGroup="vgTopic"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr style="height:100%; padding:3;">
                    <td align="right">  
                        <span class="BoldText">Description:<span class="RequiredField">*</span>&nbsp;&nbsp;</span>
                    </td>
                    <td>
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
                         </radE:radeditor>
                        <asp:RequiredFieldValidator ID="rfv_Description" runat="server" ErrorMessage="Enter description" Display="none" ControlToValidate="txtDescription" ValidationGroup="vgTopic"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr style="height:30px; background-color:#dcdcdc;">
                    <td align="center" colspan="2" style="border-top:solid 1px #609BD3;">
                         <asp:Button ID="btnSaveLink" runat="server" CssClass="btnSimpleSmall" Text="Save" ValidationGroup="vgTopic" OnClientClick="javascript:if(Validate()== false) return false;" />
                         <input type="button" value="Cancel"  class="btnSimpleSmall"  id="btnCancelLink" onclick="Back();" />
                    </td>
                </tr>
        </table>  
        </td>
    </tr>
    </table>
    </div>
    </form>
</body>
</html>
