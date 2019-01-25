<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Legal_Home.aspx.vb" Inherits="Legal_Legal_Home" %>
<%@ Register Src="leftpanel_Legal.ascx" TagName="leftpanel_Legal" TagPrefix="uc1" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<title>Legal</title>
    <link href="Style/Style.css" type="text/css" rel="stylesheet" />
    <link href="../style/Calendar/style.css" type="text/css" rel="stylesheet" />
    <link href="../style/style.css" type="text/css" rel="stylesheet"  />
    <link href="../style/Calendar/style.css" type="text/css" rel="stylesheet"  />
</head>
<body style="margin:0px 0px 0px 0px;height:100%;overflow:hidden;">
    <form id="form1" runat="server">
    <div style="overflow:auto">
    <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="300" />
        <div id="divDisable" class="modalBackground" ></div>
   <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%;background-color:#E4F1F7;padding:4px;">
   <tr>
      <td style="width:225px;height:31px;">
         <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color:#D8EAFC;height:100%;border:1px solid #609BD3;">
             <tr>
                <td style="height:31px;background-color:#A0CDEE;padding:5px;width:90%;border-bottom:1px solid #609BD3;">
                  <span class="DarkBluelabel"> Legal</span><sup><b>&nbsp;<asp:Label ID="Label1" runat="server"
                      Font-Italic="True" Font-Names="Arial" Font-Overline="False" Font-Size="XX-Small"
                      Font-Strikeout="False" Font-Underline="False" Text="BETA"></asp:Label></b></sup></td>                 
             </tr>
             <tr>
                <td valign="top">
                    <uc1:leftpanel_Legal id="Leftpanel_Legal1" runat="server">
                    </uc1:leftpanel_Legal></td>
             </tr>
        </table>
     </td>            
     <td align="center" style="padding-left:0;" valign="top" >
        <iframe name="frameMain" id="frameMain" width="100%" height="100%" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0" src="LegalHome.aspx" runat="server"></iframe>
      </td>
   </tr>
</table>      
   </div>
 </form>
 <script type="text/javascript" language="javascript" >
  function Redirect()
  {
    setTimeout('RedirecrUrl()' , 500000)
  
  }
  function RedirecrUrl()
  {
  window.location='Default.aspx'
  }
 
 </script>
</body>
</html>
