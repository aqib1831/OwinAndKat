<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ErrorPage.aspx.vb" Inherits="ErrorPage"  %>


<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Error Page</title>
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=.1)" />
    <link href="App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-color:#E4F2F5;height:100%;overflow:auto;padding:0;margin:0;">
 <form id="form1" runat="server">
   <table border="0" cellpadding="0" cellspacing="0" style="height:100%;" width="100%">
            <tr>
                <td style="height:72px;">
                  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td colspan="3">
                               <table width="100%" border="0" cellspacing="0" cellpadding="0" style="color:#467FA6;font-size:11px;background-color:#E4F1F7;font-family:Arial;">
                                    <tr>
                                        <td style="width:15px;height:18px;">&nbsp;</td>
                                        <td style="width:206px;"><asp:Image ID="Image3" runat="server" ImageUrl="~/images/logo_hdr_netsolace_top.jpg" width="206" height="18" /></td>
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
                                        <td style="width:206px;"><asp:Image ID="Image1" runat="server" ImageUrl="~/images/logo_hdr_netsolace_btm.jpg" width="206" height="53" /></td>
                                        <td style="width:20px;text-align:right;">&nbsp;<asp:Image ID="Image4" runat="server" ImageUrl="~/images/hdr_separator.jpg" ImageAlign="absmiddle" height="53" width="4" />&nbsp;</td>
                                        <%--<td style="width:40px;text-align:right;"><asp:Image ID="Image6" runat="server" ImageUrl="~/images/icn_loginHdr.jpg" width="31" height="53" /></td>--%>
                                        <td style="width:150px;text-align:left;font-size:18px;color:#383C3C;">&nbsp;Application Error</td>
                                        <td >&nbsp;</td>
                                        <td style="width:187px;"><asp:Image ID="Image5" runat="server" ImageUrl="~/images/logo_hdr_Socket.jpg" width="187" height="53" /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="2" colspan="3" bgcolor="#D5E5F4"><asp:Image ID="Image16" runat="server" ImageUrl="~/images/spacer.gif" width="1" height="1" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
            <td style="height:100%;padding:4px;">
             <div style="overflow:visible;height:100%;border:1px solid #7DA4CD;background-color:#BADCFC;text-align:center;vertical-align:middle;">
                    <table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%;">
                        <tr><td  >&nbsp;</td></tr>
                        <tr>
                            <td style="text-align:center;">
                                <table cellpadding="0" cellspacing="0" border="0" style="width:520px;height:160px;">
                                    <tr>
                                        <td style="width:8px;"><img  src="images/loginFrm_topLft.gif" height="8" width="8" /></td>
                                        <td style="height:8px;background:url('images/loginFrm_topCntr.gif');background-repeat:repeat-x;"></td>
                                        <td style="width:8px;"><img  src="images/loginFrm_topRt.gif" height="8" width="8" /></td>
                                    </tr>
                                    <%--<tr id="trErrorMessage" runat="server">
                                        <td style="background:url('images/loginFrm_lftCntr.gif');background-repeat:repeat-y;"></td>
                                        <td style="height:35px;text-align:center;background-color:#DDEEFE;color:#BA0300;"></td>
                                        <td style="background:url('images/loginFrm_rtCntr.gif');background-repeat:repeat-y;"></td>
                                    </tr>--%>
                                    <tr>
                                        <td style="background:url('images/loginFrm_lftCntr.gif');background-repeat:repeat-y;"></td>
                                        <td>
                                            <table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%;background-color:#DDEEFE;">
                                                <tr>
                                                    <td colspan="5" style="height:15px;">&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td style="width:10px;"></td>
                                                    <td>
                                                       <table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%;background-color:#DDEEFE;font-size:12px;color:#73797F;">
                                                            <%--<tr><td colspan="2"></td></tr>--%>
                                                            <tr>
                                                                <td colspan="2" style="font-size:18px;padding-left:1em;font-weight:bold;height:35px;text-align:left;background-color:#DDEEFE;color:#BA0300;">
                                                                 <img  src="images/icn_err.gif" align="absmiddle" /> &nbsp;&nbsp;Application Error
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2" style="height:15px;padding-left:2em;text-align:left; width:40%;"></td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2" style="font-size:11px;padding-left:1em; font-weight:bold;height:35px;text-align:left;background-color:#DDEEFE;color:#BA0300;">
                                                                The Application has encountered an error. Your request could not be completed. We are sorry for inconvenience. Please click continue to proceed.                                                                          
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                            <td style="height:25px;padding-left:2em;text-align:left;">
                                                            </td>                                                                        
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2" style="text-align:right;height:25px;" >
                                                                    <input type="button" value="Continue" class="Btn3D" onclick="top.location='<%= ResolveClientURl("~/login.aspx") %>';" />
                                                                </td>
                                                            </tr>
                                                            <tr><td colspan="2"></td></tr>
                                                        </table>
                                                    </td>
                                                    <td style="width:30px;"></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="5" style="height:10px;">&nbsp;</td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="background:url('images/loginFrm_rtCntr.gif');background-repeat:repeat-y;"></td>
                                    </tr>
                                    <tr>
                                        <td style="width:8px;"><img  src="images/loginFrm_btmLft.gif" height="8" width="8" /></td>
                                        <td style="height:8px;background:url('images/loginFrm_btmCntr.gif');background-repeat:repeat-x;"></td>
                                        <td style="width:8px;"><img  src="images/loginFrm_btmRt.gif" height="8" width="8" /></td>
                                    </tr>
                                    <tr>
                                        <td style="width:8px;"><img  src="images/loginFrm_reflctn_lft.jpg" height="40" width="8" /></td>
                                        <td style="height:8px;background:url('images/loginFrm_reflctn_cntr.jpg');background-repeat:repeat-x;"></td>
                                        <td style="width:8px;"><img  src="images/loginFrm_reflctn_rt.jpg" height="40" width="8" /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr><td >&nbsp;</td></tr>
                    </table>
                </div>
            </td>
            </tr>
            <tr>
                <td style="height:24px;background:url('images/ftr_bg.jpg');">
                    <table width="100%"  border="0" cellpadding="0" cellspacing="0" style="height:24px;" class="WhiteSmall">
                      <tr>
                        <td>&nbsp;&nbsp;Copyright &copy; <%= Year(Now) %>, Netsolace, Inc.&nbsp;</td>
                        <td align="right" style="width:187px;height:24px;"><asp:Image ID="Image2" runat="server" ImageUrl="~/images/logo_ftr_netsolace.jpg" Width="187" Height="24" /></td>
                      </tr>
                    </table>
                </td>
           </tr>
       </table>
    </form>
</body>
</html>
