<%@ Control Language="VB" AutoEventWireup="false" CodeFile="footer.ascx.vb" Inherits="LMS_footer" %>
<asp:Panel ID="FooterPanel1" runat="server" BackImageUrl="~/images/ftr_bg.jpg" Width="100%">
    <table width="100%"  border="0" cellpadding="0" cellspacing="0" style="height:24px;" class="WhiteSmall">
      <tr>
        <td>&nbsp;&nbsp;Copyright &copy; <%= Year(Now) %>, Netsolace, Inc. <span style="cursor:pointer;" onmouseout="this.style.color='';" onmouseover="this.style.color='#C0D8E2';" onclick="window.open('<%= ResolveClientURl("~/term_of_use.aspx") %>','WinTerms', 'location=0,status=0,scrollbars=1,toolbar=0,resizable=1')"></span></td>
        <td align="right" style="width:187px;height:24px;cursor:pointer;" onclick="window.open('http://qa.netsolace.com');"><asp:Image runat="server" ImageUrl="~/images/logo_ftr_netsolace.jpg" Width="187" Height="24" /></td>
      </tr>
    </table>
</asp:Panel>