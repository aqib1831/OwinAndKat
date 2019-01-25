<%@ Page Language="VB" MasterPageFile="MasterPage.master" AutoEventWireup="false" CodeFile="MainMasterPage.aspx.vb" Inherits="HR_MainMasterPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMiddle" Runat="Server">
<table width="100%" style="height:360px;" scroll="no" border="0" align="center" cellpadding="0" cellspacing="0">
     <tr>
        <td align="center" width="100%" style="height:15%" valign="top">
          <iframe id="ifclock" name="ifclock" runat="server" src="Clock.aspx?Type=1"  width="100%" scrolling="no" frameborder="0" height="100"></iframe>
        </td>
     </tr>
    <tr>
        <td style="height:85%;width:100%;" align="left" valign="top">
          <iframe id="ifMainMasterPage" runat="server" src="Default.aspx"  width="100%" scrolling="no" frameborder="0" height="100%"></iframe> 
        </td>
    </tr>
</table>
<script type="text/javascript">
    function clockpage(type)
    {  
       ifclock.location='Clock.aspx?Type='+type;
    }
</script>
</asp:Content>
