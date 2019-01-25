<%@ Control Language="VB" AutoEventWireup="false" CodeFile="topMyNetsolace.ascx.vb" Inherits="MyNetsolace_Controls_topMyNetsolace" %>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td colspan="0">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="color:#467FA6;font-size:11px;background-color:#E4F1F7;font-family:Arial;">
                <tr>
                    <td style="width:15px;height:18px;">&nbsp;</td>
                    <td style="width:206px; height: 18px;"><img src="~/images/logo_hdr_netsolace_top.jpg" alt="Netsolace" width="206" height="18" runat="server" /></td>
                    <td style="width:15px;height:18px;">&nbsp;</td>
                    <td style="width:30%; height: 18px;">
                        <img src="~/images/icn_user.jpg" align="absmiddle" runat="server"  />&nbsp;&nbsp;Welcome 
                        <b><asp:Label ID="lblUserName" runat="server" ForeColor="Black" ></asp:Label></b>
                    </td>
                    <td style="text-align:right; height: 18px;">
                       <asp:HyperLink ID="lnkUserManual" Target="_blank"  NavigateUrl="https://qa.netsolace.com/Portal/UM/Client/UMClientMain.aspx?CategoryID=2833.05KlSmJsYws3166.35KlSmJsYws&BackTo=Portal"  runat="server" Text="User Manual"></asp:HyperLink>&nbsp;|&nbsp;<span id="spanPassword" runat="server" ><asp:HyperLink ID="btnChangePassword"  NavigateUrl="~/MyNetsolace/ChangePassword.aspx"  runat="server" Text="Change Password"></asp:HyperLink>&nbsp;|&nbsp;</span><asp:LinkButton ID="lnkSingout" runat="server">Sign out </asp:LinkButton> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="TopBar3DTable">
                <tr>
                    <td class="TopBarBGSpace">&nbsp;</td>
                    <td style="width:206px;"><img src="~/images/logo_hdr_netsolace_btm.jpg" width="206" alt="Netsolace" height="53" runat="server" /></td>
                    <td style="width:20px;text-align:right;">&nbsp;<img src="~/images/hdr_separator.jpg" align="absmiddle" height="53" width="4" runat="server" />&nbsp;</td>
                    <td id="IconHomeClass" runat="server" class="MainIcons" title=''>
                        <table id="IconHome" runat="server"  width="100%" border="0" cellspacing="0" cellpadding="0" onmouseover="this.className='TopBarHover';" onmouseout="this.className='TopBarSimple';" class="TopBarSimple" >
                            <tr>
                                <td style="height:33px;"><asp:Image ID="Image17" runat="server" ImageUrl="~/images/ico_helpdesk.gif" /></td>
                            </tr>
                            <tr>
                                <td style="height:13px;">Help Desk</td>
                            </tr>
                        </table>
                    </td>
                    <td id="IconBillingWidth" runat="server" style="width:5px;">&nbsp;</td>
                    <td id="IconBilling" runat="server" class="MainIcons" title=''>
                        <table id="IconBillingClass" runat="server" width="100%" border="0" cellspacing="0" cellpadding="0" onmouseover="this.className='TopBarHover';"  onmouseout="this.className='TopBarSimple';" class="TopBarSimple" >
                            <tr>
                                <td style="height:33px;"><asp:Image ID="Image2" runat="server" ImageUrl="~/images/ico_billing_nServices.jpg" /></td>
                            </tr>
                            <tr>
                                <td style="height:13px;">BILLING</td>
                            </tr>
                        </table>
                    </td>
                    <td  id="IconLicenceWidth" runat="server" style="width:5px;">&nbsp;</td>
                    <td  id="IconLicence" runat="server"  class="MainIcons" title=''>
                        <table id="IconLicenceClass" runat="server" width="100%" border="0" cellspacing="0" cellpadding="0" onmouseover="this.className='TopBarHover';" onmouseout="this.className='TopBarSimple';" class="TopBarSimple" >
                            <tr>
                                <td style="height:33px;"><asp:Image ID="Image1" runat="server" ImageUrl="~/images/icn_lice_mgt.gif" /></td>
                            </tr>
                            <tr>
                                <td style="height:13px;">License Mgmt</td>
                            </tr>
                        </table>
                    </td>
                    <td id="IconPMWidth" runat="server" style="width:5px;">&nbsp;</td>
                    <td id="IconPM" runat="server" class="MainIcons" title=''>
                        <table id="IconPMClass" runat="server" width="100%" border="0" cellspacing="0" cellpadding="0" onmouseover="this.className='TopBarHover';" onmouseout="this.className='TopBarSimple';" class="TopBarSimple" >
                            <tr>
                                <td style="height:33px;"><asp:Image ID="Image3" runat="server" ImageUrl="~/images/icn_newLead.gif" /></td>
                            </tr>
                            <tr>
                                <td style="height:13px;">Project Mgmt</td>
                            </tr>
                        </table>
                    </td>
                    <td id="IconCCWidth" runat="server" style="width:5px;">&nbsp;</td>
                    <td id="IconCC" runat="server" class="MainIcons" title=''>
                        <table id="IconCCClass" runat="server" width="100%" border="0" cellspacing="0" cellpadding="0" onmouseover="this.className='TopBarHover';" onmouseout="this.className='TopBarSimple';" class="TopBarSimple" >
                            <tr>
                                <td style="height:33px;"><asp:Image ID="Image4" runat="server" ImageUrl="~/images/icn_HRmgt.gif.gif" /></td>
                            </tr>
                            <tr>
                                <td style="height:13px;">Users</td>
                            </tr>
                        </table>
                    </td>
                    <td id="IconNSBSWidth" runat="server" style="width:5px;">&nbsp;</td>
                    <td id="IconNSBS" runat="server" class="MainIcons" title=''>
                        <table id="IconNSBSClass" runat="server" width="100%" border="0" cellspacing="0"
                            cellpadding="0" onmouseover="this.className='TopBarHover';" onmouseout="this.className='TopBarSimple';"
                            class="TopBarSimple">
                            <tr>
                                <td style="height: 33px;">
                                    <asp:Image ID="Image5" runat="server" ImageUrl="~/images/icn_NSBS.gif" BorderWidth="0" /></td>
                            </tr>
                            <tr>
                                <td style="height: 13px;">
                                    NSBS</td>
                            </tr>
                        </table>
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