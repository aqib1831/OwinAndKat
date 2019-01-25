<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="MyNetsolace_Default" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Area Developer</title>
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=.1)" />
    <link href="~/App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-color:#E4F2F5;height:100%;overflow:hidden;padding:0;margin:0;">
<form id="frmLogin" runat="server" defaultfocus="txtUserName" defaultbutton="cmdSignIn">
<asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>
<table border="0" cellpadding="0" cellspacing="0" style="height:100%;" width="100%">
            <tr>
                <td style="height:72px;">
                    <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td colspan="3">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="color:#467FA6;font-size:11px;background-color:#E4F1F7;font-family:Arial;">
                                    <tr>
                                        <td style="width:15px;height:18px;">&nbsp;</td>
                                        <td style="width:206px;"><asp:Image ID="Image1" runat="server" ImageUrl="~/images/logo_hdr_netsolace_top.jpg" width="206" height="18" /></td>
                                        <td style="width:15px;height:18px;">&nbsp;</td>
                                        <td style="width:50%;">&nbsp;
                                            <%--<asp:Image ID="Image2" runat="server" ImageUrl="~/images/icn_user.jpg" ImageAlign="absmiddle" />&nbsp;&nbsp;Welcome 
                                            <b><asp:Label ID="lblAdminName" runat="server" ForeColor="Black" /></b>&nbsp;|&nbsp;You have <b>XX</b> pending activities.--%>
                                        </td>
                                        <td style="text-align:right;"><%--Support Request&nbsp;|&nbsp;Change Password&nbsp;|&nbsp;<a href="<%= ResolveClientURl("~/login.aspx") %>" target="_top">Sign out</a>&nbsp;&nbsp;&nbsp;--%>&nbsp;</td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="TopBar3DTable">
                                    <tr>
                                        <td class="TopBarBGSpace">&nbsp;</td>
                                        <td style="width:206px;"><asp:Image ID="Image3" runat="server" ImageUrl="../images/logo_hdr_netsolace_btm.jpg" width="206" height="53" /></td>
                                        <td style="width:20px;text-align:right;">&nbsp;<asp:Image ID="Image4" runat="server" ImageUrl="../images/hdr_separator.jpg" ImageAlign="absmiddle" height="53" width="4" />&nbsp;</td>
                                        <%--<td style="width:40px;text-align:right;"><asp:Image ID="Image6" runat="server" ImageUrl="~/images/icn_loginHdr.jpg" width="31" height="53" /></td>--%>
                                        <td style="width:250px;text-align:left;font-size:18px;color:#383C3C;white-space:nowrap;">&nbsp;Area Developer Login</td>
                                        <td >&nbsp;</td>
                                        <td style="width:187px;"><asp:Image ID="Image5" runat="server" ImageUrl="../images/spacer.gif" width="187" height="53" /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="2" colspan="3" bgcolor="#D5E5F4"><asp:Image ID="Image16" runat="server" ImageUrl="../images/spacer.gif" width="1" height="1" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height:100%;padding:4px;">
                    <div style="overflow:visible;height:100%;border:1px solid #7DA4CD;background-color:#BADCFC;text-align:center;vertical-align:middle;">
                        <table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%;">
                            <tr><td>&nbsp;</td></tr>
                            <tr>
                                <td align="center">
                                    <table cellpadding="0" cellspacing="0" border="0" style="width:420px;height:250px;">
                                        <tr>
                                            <td style="width:8px;"><img src="../images/loginFrm_topLft.gif" height="8" width="8" /></td>
                                            <td style="height:8px;background:url('../images/loginFrm_topCntr.gif');background-repeat:repeat-x;"></td>
                                            <td style="width:8px;"><img src="../images/loginFrm_topRt.gif" height="8" width="8" /></td>
                                        </tr>
                                        <tr id="trErrorMessage" runat="server">
                                            <td style="background:url('../images/loginFrm_lftCntr.gif');background-repeat:repeat-y;"></td>
                                            <td style="height:35px;text-align:center;background-color:#DDEEFE;color:#BA0300;"><img src="../images/icn_err.gif" height="30" width="34" align="middle" />&nbsp;&nbsp;&nbsp;<b><span id='spnError' runat="server"></span></b></td>
                                            <td style="background:url('../images/loginFrm_rtCntr.gif');background-repeat:repeat-y;"></td>
                                        </tr>
                                        <tr>
                                            <td style="background:url('../images/loginFrm_lftCntr.gif');background-repeat:repeat-y;"></td>
                                            <td>
                                                <table id="tblForm" runat="server" cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%;background-color:#DDEEFE;">
                                                    <tr>
                                                        <td colspan="5" style="height:15px;">&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width:30px;"></td>
                                                        <td style="width:101px;"><img src="../images/icn_login.jpg" width="101" height="84" /></td>
                                                        <td>
                                                            <table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%;background-color:#DDEEFE;font-size:12px;color:#73797F;">
                                                                <tr><td colspan="2"></td></tr>
                                                                 <tr>
                                                                    <td style="height:25px;padding-left:1em;white-space:nowrap;" valign="top">Company Code:</td>
                                                                    <td valign="top">
                                                                        <asp:TextBox ID="txtClientCode" runat="server" MaxLength="8" CssClass="TextBoxBlueBorder" TabIndex="1" Text="" ></asp:TextBox>
                                                                        <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="Numbers" TargetControlID="txtClientCode">
                                                                        </ajaxToolkit:FilteredTextBoxExtender>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtClientCode" Display="Dynamic"  ErrorMessage="Enter Company Code"></asp:RequiredFieldValidator>
                                                                   </td>
                                                                 </tr>
                                                                <tr>
                                                                    <td style="height:25px;padding-left:1em;" valign="top">Username:</td>
                                                                    <td valign="top">
                                                                        <asp:TextBox ID="txtUserName" runat="server"  MaxLength="50" CssClass="TextBoxBlueBorder" Text="" TabIndex="2"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUserName" Display="Dynamic"  ErrorMessage="Enter Username"></asp:RequiredFieldValidator>
                                                                   </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height:25px;padding-left:1em;" valign="top">Password:</td>
                                                                    <td valign="top">
                                                                        <asp:TextBox TextMode="Password" ID="txtPassword" runat="server" MaxLength="50" EnableViewState="False" CssClass="TextBoxBlueBorder" TabIndex="3"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="RFV_lblKey" runat="server" ControlToValidate="txtPassword" Display="Dynamic"  ErrorMessage="Enter Password"></asp:RequiredFieldValidator>
                                                                   </td>
                                                                </tr>
                                                                <%--<tr>
                                                                    <td style="height:25px;padding-left:2em;">PIN Code:</td>
                                                                    <td style="text-align:right;">
                                                                        <asp:Label  ID="lblKey" runat="server"  CssClass="TextBoxBlueBorderPin" Width="40" ></asp:Label> <asp:TextBox CssClass="TextBoxBlueBorder" Width="88" ID="txtPIN" runat="server" MaxLength="4" EnableViewState="False" TextMode="Password"></asp:TextBox>
                                                                        
                                                                    </td>
                                                                </tr>--%>
                                                                <tr><td colspan="2" style="height:20px;">&nbsp;
                                                                    </td></tr>
                                                                <tr>
                                                                    <td colspan="2" style="text-align:right;height:25px;" >
                                                                         <asp:Button ID="cmdSignIn"  CssClass="Btn3D" runat="server" Text="Sign In" Width="72px" Height="25px" TabIndex="4" /></td>
                                                                </tr>
                                                                <tr><td colspan="2"></td></tr>
                                                            </table>
                                                        </td>
                                                        <td style="width:30px;"></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="5" style="height:15px;">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="background:url('../images/loginFrm_rtCntr.gif');background-repeat:repeat-y;"></td>
                                        </tr>
                                        <tr>
                                            <td style="width:8px;"><img  src="../images/loginFrm_btmLft.gif" height="8" width="8" /></td>
                                            <td style="height:8px;background:url('../images/loginFrm_btmCntr.gif');background-repeat:repeat-x;"></td>
                                            <td style="width:8px;"><img  src="../images/loginFrm_btmRt.gif" height="8" width="8" /></td>
                                        </tr>
                                        <tr>
                                            <td style="width:8px;"><img  src="../images/loginFrm_reflctn_lft.jpg" height="40" width="8" /></td>
                                            <td style="height:8px;background:url('../images/loginFrm_reflctn_cntr.jpg');background-repeat:repeat-x;"></td>
                                            <td style="width:8px;"><img  src="../images/loginFrm_reflctn_rt.jpg" height="40" width="8" /></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr><td>&nbsp;</td></tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="height:24px;background:url('../images/ftr_bg.jpg');">
                    <table width="100%"  border="0" cellpadding="0" cellspacing="0" style="height:24px;" class="WhiteSmall">
                      <tr>
                        <td style="height: 15px">&nbsp;&nbsp;Copyright &copy; <%= Year(Now) %>, Netsolace, Inc.&nbsp;&nbsp;&nbsp;</td>
                        <td align="right" style="width:187px;height:15px;"><asp:Image ID="Image2" runat="server" ImageUrl="../images/logo_ftr_netsolace.jpg" Width="187" Height="24" /></td>
                      </tr>
                    </table>
                </td>
            </tr>
        </table>
</form>
</body>
</html>