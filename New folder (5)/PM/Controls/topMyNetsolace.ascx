<%@ Control Language="VB" AutoEventWireup="false" CodeFile="topMyNetsolace.ascx.vb" Inherits="MyNetsolace_Controls_topMyNetsolace" %>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td colspan="0">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="color:#467FA6;font-size:11px;background-color:#E4F1F7;font-family:Arial;">
                <tr>
                    <td style="width:15px;height:18px;">&nbsp;</td>
                    <td style="width:206px; height: 18px;"><img src="../images/logo_hdr_netsolace_top.jpg" alt="Netsolace" width="206" height="18" /></td>
                    <td style="width:15px;height:18px;">&nbsp;</td>
                    <td style="width:30%; height: 18px;">
                        <img src="../images/icn_user.jpg" align="absmiddle" />&nbsp;&nbsp;Welcome 
                        <b><asp:Label ID="lblUserName" runat="server" ForeColor="Black" ></asp:Label></b>
                    </td>
                    <td style="text-align:right; height: 18px;">
                       <asp:LinkButton ID="lnkSingout" runat="server">Sign out </asp:LinkButton> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="TopBar3DTable">
                <tr>
                    <td class="TopBarBGSpace">&nbsp;</td>
                    <td style="width:206px;"><img src="../images/logo_hdr_netsolace_btm.jpg" width="206" alt="Netsolace" height="53" /></td>
                    <td style="width:20px;text-align:right;">&nbsp;<img src="../images/hdr_separator.jpg" align="absmiddle" height="53" width="4" />&nbsp;</td>
                    <td  title='Project Management' >
                        <div id="tblHome" runat="server" style="text-align:left; padding-top:10px; height:33px; font-weight:bold; font-size:18px; font-family:Verdana, Arial, Sans-Serif, Helvetica; width:100%; color:#000000; cursor:pointer;">
                              Project Management
                        </div>
                    </td>
                    <td style="width:5px;">&nbsp;</td>                                                                                                                                         
                    <td >&nbsp;</td>                    
                </tr>
            </table>
        </td>
    </tr>
    <tr>
       <td height="2" colspan="3"  bgcolor="#D5E5F4"><img src="../images/spacer.gif" width="1" height="1" /></td>
    </tr>
</table>
