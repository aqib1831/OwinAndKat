<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ChangePassword.aspx.vb" EnableTheming="true" Theme="Default" Inherits="Admin_ChangePassword"  %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server" >
   <title>Welcome to My Netsolace</title>
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=.1)" />
    <script type="text/javascript" language="javascript" src="~/scripts/functions.js"></script>
</head>
<body style="background-color:#E4F2F5;height:100%;overflow:auto;padding:0;margin:0;">
    <form id="frmPassword" runat="server">
    <asp:HiddenField ID="hdnType" runat="server" Value="" />
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
                                        <td style="width:50%;">&nbsp;</td>
                                        <td style="text-align:right;">&nbsp;</td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="TopBar3DTable">
                                    <tr>
                                        <td class="TopBarBGSpace">&nbsp;</td>
                                        <td style="width:206px;"><asp:Image ID="Image3" runat="server" ImageUrl="~/images/logo_hdr_netsolace_btm.jpg" width="206" height="53" /></td>
                                        <td style="width:20px;text-align:right;">&nbsp;<asp:Image ID="Image4" runat="server" ImageUrl="~/images/hdr_separator.jpg" ImageAlign="absmiddle" height="53" width="4" />&nbsp;</td>
                                        <td colspan="2" style="text-align:left;font-size:18px;color:#383C3C;">&nbsp;Change Password</td>
                                        <td style="width:187px;"><asp:Image ID="Image5" runat="server" ImageUrl="~/images/spacer.gif" width="187" height="53" /></td>
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
                         <div style="overflow:auto;height:100%;border:1px solid #7DA4CD;background-color:#BADCFC;text-align:center;vertical-align:middle;">
                                <table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%;">
                                    <tr><td  >&nbsp;</td></tr>
                                    <tr>
                                        <td style="text-align:center;">
                                            <table cellpadding="0" cellspacing="0" border="0" style="width:520px;height:220px;">
                                                <tr>
                                                    <td style="width:8px;"><img alt="" src="../images/loginFrm_topLft.gif" height="8" width="8" /></td>
                                                    <td style="height:8px;background:url('../images/loginFrm_topCntr.gif');background-repeat:repeat-x;"></td>
                                                    <td style="width:8px;"><img alt="" src="../images/loginFrm_topRt.gif" height="8" width="8" /></td>
                                                </tr>
                                                <tr id="trErrorMessage" style="display:none;" runat="server" >
                                                    <td style="background:url('../images/loginFrm_lftCntr.gif');background-repeat:repeat-y;"></td>
                                                    <td style="height:35px;text-align:center;background-color:#DDEEFE;color:#BA0300;" valign="middle">
                                                        <img alt=""   src="../images/icn_err.gif" height="30" width="34"  align="absmiddle" />
                                                        &nbsp;&nbsp;&nbsp;
                                                        <b>
                                                            <span id='spnError' style="font-size:12px; font-weight:bold;" runat="server"></span>
                                                        </b>
                                                    </td>
                                                    <td style="background:url('../images/loginFrm_rtCntr.gif');background-repeat:repeat-y;"></td>
                                                </tr>
                                                <tr>
                                                    <td style="background:url('../images/loginFrm_lftCntr.gif');background-repeat:repeat-y;"></td>
                                                    <td>
                                                        <table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%;background-color:#DDEEFE;">
                                                            <tr>
                                                                <td colspan="5" style="height:15px;color:#73797F;font-size:12px;">
                                                                       <span id="SpanSecurutyMess" runat="server">
                                                                           Due to security reasons, you must change password.
                                                                           Please enter the new password having at least eight alpha numeric characters.
                                                                          
                                                                           <br />(Example:<span style ="font-weight:bold;">6jpxlk@Y</span>) 
                                                                       </span>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width:10px;"></td>
                                                                <td style="width:101px;"><img alt="" src="../images/icn_login.jpg" width="101" height="84" /></td>
                                                                <td>
                                                                    <table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%;background-color:#DDEEFE;font-size:12px;color:#73797F;">
                                                                        <tr><td colspan="2"></td></tr>
                                                                        <tr>
                                                                            <td style="height:25px;padding-left:2em;text-align:left; width:40%;">Old Password:</td>
                                                                            <td style="text-align:left;width:60%;">
                                                                                <asp:TextBox runat="server" ID="OldPassword" TextMode="Password" maxlength="100" style="width:90%" CssClass="TextBoxBlueBorder" /> 
                                                                                <asp:RequiredFieldValidator 
                                                                                    ID="val_OldPassword"
                                                                                    runat="server"
                                                                                    ControlToValidate="OldPassword"
                                                                                    ErrorMessage="*"
                                                                                    SetFocusOnError="true"
                                                                                    Display="Dynamic" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="height:25px;padding-left:2em;text-align:left;">New Password:</td>
                                                                            <td style="text-align:left;">
                                                                                <asp:TextBox runat="server"  ID="NewPassword"  TextMode="Password" maxlength="100" style="width:90%" CssClass="TextBoxBlueBorder"/>
                                                                                <asp:RequiredFieldValidator 
                                                                                    ID="val_NewPassword"
                                                                                    runat="server"
                                                                                    ControlToValidate="NewPassword"
                                                                                    ErrorMessage="*"
                                                                                    SetFocusOnError="true"
                                                                                    Display="Dynamic" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="height:25px;padding-left:2em;text-align:left;">Confirm Password:</td>
                                                                            <td style="text-align:left;">
                                                                                <asp:TextBox runat="server"  ID="ConfirmPassword" TextMode="Password" maxlength="100" style="width:90%" CssClass="TextBoxBlueBorder" /> 
                                                                                <asp:RequiredFieldValidator 
                                                                                    ID="val_ConfirmPassword"
                                                                                    runat="server"
                                                                                    ControlToValidate="ConfirmPassword"
                                                                                    ErrorMessage="*"
                                                                                    SetFocusOnError="true"
                                                                                    Display="Dynamic" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2" style="height:20px;">
                                                                                <asp:CustomValidator 
                                                                                    runat="server"
                                                                                    ID="val_PasswordStrength"
                                                                                    ClientValidationFunction="CheckNewPasswordFormat"
                                                                                    />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2" style="text-align:center;height:25px;" >
                                                                                 <asp:Button ID="BtnSave" runat="server"  Width="150px" CssClass="Btn3D"  Text="Change Password"  /> 
                                                                                 <asp:Button runat="server" ID="btnCancel" Text="Close" PostBackUrl="~/Mynetsolace/MainPage.aspx" CssClass="Btn3D" CausesValidation="false"  />
                                                                            </td>
                                                                        </tr>
                                                                        <tr><td colspan="2"></td></tr>
                                                                    </table>
                                                                </td>
                                                                <td style="width:30px;"></td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="5" style="height:30px;">&nbsp;</td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td style="background:url('../images/loginFrm_rtCntr.gif');background-repeat:repeat-y;"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width:8px;"><img alt="" src="../images/loginFrm_btmLft.gif" height="8" width="8" /></td>
                                                    <td style="height:8px;background:url('../images/loginFrm_btmCntr.gif');background-repeat:repeat-x;"></td>
                                                    <td style="width:8px;"><img alt="" src="../images/loginFrm_btmRt.gif" height="8" width="8" /></td>
                                                </tr>
                                                <tr>
                                                    <td style="width:8px;"><img alt="" src="../images/loginFrm_reflctn_lft.jpg" height="40" width="8" /></td>
                                                    <td style="height:8px;background:url('../images/loginFrm_reflctn_cntr.jpg');background-repeat:repeat-x;"></td>
                                                    <td style="width:8px;"><img alt="" src="../images/loginFrm_reflctn_rt.jpg" height="40" width="8" /></td>
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
                        <td style="height:24px;background:url('../images/ftr_bg.jpg');">
                            <table width="100%"  border="0" cellpadding="0" cellspacing="0" style="height:24px;" class="WhiteSmall">
                              <tr>
                                <td>&nbsp;&nbsp;Copyright &copy; <%= Year(Now) %>, Netsolace, Inc.&nbsp;&nbsp;&nbsp;</td>
                                <td align="right" style="width:187px;height:24px;"><asp:Image ID="Image2" runat="server" ImageUrl="~/images/logo_ftr_netsolace.jpg" Width="187" Height="24" /></td>
                              </tr>
                            </table>
                        </td>
                    </tr>
                </table>

    <script type="text/javascript" language="javascript">
    
         function CheckNewPasswordFormat(src, args){
            
            var opass = getElement('<%= OldPassword.ClientID %>');
            var npass = getElement('<%= NewPassword.ClientID %>');
            var cpass = getElement('<%= ConfirmPassword.ClientID %>');
            var trError = getElement('<%= trErrorMessage.ClientID %>');
            var spnError = getElement('<%= spnError.ClientID %>');
            
            if (/^.{8,}$/.test(npass.value) == true || npass.value == "") 
            {
                if (/^.*\d.*$/.test(npass.value) == true || npass.value == "" )	
                {
                    if (/^.*[a-zA-Z].*$/.test(npass.value) == true || npass.value == "" )
                    {                   
                        if( npass.value != "" &&  cpass.value != "")
                        {                             
                            if ( npass.value != cpass.value)
                            {
                                 trError.style.display= 'inline'
                                 spnError.innerHTML= 'New password and confirm password does not match.'  
                                 args.IsValid = false;
                            }
                            else if(opass.value == npass.value){
                                 trError.style.display= 'inline';
                                 spnError.innerHTML= 'Old and new password must not match.';
                                 args.IsValid = false;
                            }
                            else 
                            {
                                 args.IsValid = true;
                            }
                        }
                        else 
                         {
                         args.IsValid = false;
                         }
                    }
                    else 
                    {
                        trError.style.display= 'inline'
                        spnError.innerHTML= 'Please enter a valid password. The password must contain alphabets.'  
                        args.IsValid = false;
                    }                    	
                }
                else 
                {
                    trError.style.display= 'inline'
                    spnError.innerHTML= 'Please enter a valid password. The password must contain numbers.'  
                    args.IsValid = false;
                }
            }
            else 
            {
                trError.style.display= 'inline'
                spnError.innerHTML= 'Password must be atleast eight character in length.'             
                args.IsValid = false;            
            }
            
         }
    </script>
    </form>
</body>
</html>