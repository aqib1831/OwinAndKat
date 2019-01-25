<%@ Control Language="VB" AutoEventWireup="false" CodeFile="footerMyNetsolace.ascx.vb" Inherits="MyNetsolace_Controls_footerMyNetsolace" %>
<div style="background-image:url('../../images/ftr_bg.jpg')">
<table cellpadding="0" width="0" cellspacing="0" border="0" style="background-image:url('../images/ftr_bg.jpg'); height:24px; width:100%;" class="WhiteSmall">
    <tr>
        <td align="left">&nbsp;&nbsp;Copyright &copy; <%= Year(Now) %>, Netsolace, Inc. <span style="cursor:pointer;" onmouseout="this.style.color='';" onmouseover="this.style.color='#C0D8E2';" onclick="window.open('<%= ResolveClientURl("~/term_of_use.aspx") %>','WinTerms', 'location=0,status=0,scrollbars=1,toolbar=0,resizable=1')"></span></td>
        <td align="right" style="width:187px;height:24px;cursor:pointer;" onclick="window.open('http://qa.netsolace.com');"><img src="~/images/logo_ftr_netsolace.jpg" runat="server" Width="187" Height="24" /></td>
    </tr>
</table>
</div>
