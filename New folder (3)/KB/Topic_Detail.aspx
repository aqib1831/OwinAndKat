<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Topic_Detail.aspx.vb" Inherits="KB_Topic_Detail" %>

<%@ Register Src="KB_Navigation.ascx" TagName="KB_Navigation" TagPrefix="uc1" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Topic Detail</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <link href="../App_Themes/Default/Calendar/style.css" rel="stylesheet" type="text/css" />
    <!--  <link href="../../fckeditor/editor/css/fck_editorarea.css" />-->
    <style type="text/css" media="screen">
      .noprint  
     { display: block; } 

     .PrintArea
        {                
        border:1px;
        border-color:Green;
        } 
     .noscreen
        {
        display: none;
        }
</style>
    <style type="text/css" media="print">
    .noprint  
   { display: none;
   }
   .PrintArea
   {         
     border:0px;
   } 
  
</style>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <link href="../App_Themes/Default/Calendar/style.css" rel="stylesheet" type="text/css" />


</head>
<body class="Supplierbody" style="margin: 0px; height: 100%; width: 100%;">
    <object id="factory" viewastext style="display: none" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814"
        codebase="../ScriptX/smsx.cab#Version=6,3,435,20">
    </object>
    <form id="form1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server">
     </asp:ScriptManager>
    <table border="0" cellspacing="0" cellpadding="0" style="width:100%; height:100%;">
      <tr class="HeaderRowGreen noprint">
        <td>
    	    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="width:98%;">
              <tr>
                <td style="width:80%; font-weight:bold; border-bottom:0; font-family:Arial, Verdana, Sans-Serif, Helvetica; font-size:14px;">
                    <asp:Label ID="lblHeading" runat="server" Text="No Topic Selected"></asp:Label>                         
                </td>
                <td style="width:20%; border-bottom:0;" align="right">
                    <asp:LinkButton ID="BtnPrint" runat="server" CssClass="PrintButtonGreen" Height="20px"
                     Width="100px" OnClientClick="PrintPage();return false;" Enabled="true">Print</asp:LinkButton>&nbsp;
                </td>
              </tr>
            </table>
        </td>
      </tr>
      <tr class="HeaderRowGreen noprint" >
        <td style="border-bottom: #50af43 1px solid; font-weight:bold; font-family:Arial, Sans-Serif, Verdana, Helvetica; font-size:12px; padding:5px;">
            <uc1:KB_Navigation ID="KB_Navigation1" runat="server" />
        </td>
      </tr>
      <tr>
        <td style="height:100%; width:100%;">            
                <iframe id="ifrmTopicDetail" runat="server" marginheight="0" marginwidth="0" frameborder="0" height="100%" class="divScroll" width="100%" style="padding:3px;"></iframe>            
        </td>
      </tr>
    </table>        
    <asp:HiddenField ID="hdnTopicID" runat="server" Value="-1"></asp:HiddenField>
    </form>

<script type="text/javascript">
function PrintPage(){
    try{
       //window.focus();
       var factory = document.getElementById('factory');
       if (factory != null){
	        factory.printing.header = "&w&bPage &p of &P";
            factory.printing.footer = "";
	        factory.printing.leftMargin = 0.40;
            factory.printing.rightMargin = 0.40;
            factory.printing.topMargin = 0.80;
            factory.printing.bottomMargin = 0.80;
            ifrmTopicDetail.focus();
            ifrmTopicDetail.print();
	        }
     }
         catch(err)
         {}
   return false;
}
</script>
</body>
</html>
