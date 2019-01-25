<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Compose_New.aspx.vb" Inherits="admin_comm_compose_new" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Compose</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
</head>
<body onLoad="SetPosition();" scroll="no" leftmargin="1" topmargin="1" marginwidth="1" marginheight="1">
<form id="form1" runat="server">
<div id="divDisable" class="modalBackground" style="height:100%; width:100%">
    <asp:HiddenField ID="hdnPinCode" runat="server" />
</div>
<div id="DivOption"  style="position:absolute; width:500px; height:350px;top:10%; left:20%;"    >
<table width="100%"  style="height:350px;"  border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td style="background-image:url(../images/wndw_topLft.Gif);background-repeat:no-repeat; height: 16px; width: 14px;"><img src="../images/spacer.gif" width="13" height="1" alt="" align="absmiddle" /></td>
        <td align="right" valign="top" style="background-image:url(../images/wndw_topCntr.Gif);background-repeat:repeat-x; width:100%; height:16px; cursor:pointer;"><!--<img src="../images/wndw_btn_close.Gif" width="35" height="16" onClick="Reset()" alt="Click to close..." align="absmiddle" />--></td>
        <td valign="top" style="background-image:url(../images/wndw_topRt.Gif);background-repeat:no-repeat; height: 16px;"><img src="../images/spacer.gif" width="18" height="1" alt="" align="absmiddle" /></td>
    </tr>
    <tr>
        <td style="background-image:url(../images/wndw_lftCntr.Gif);background-repeat:repeat-y; width:14px; height:100%;">&nbsp;</td>
        <td valign="top">
            <table width="100%" style="height:100%;" border="0" cellpadding="0" cellspacing="0" class="OptionBackground">
                  <tr>                      
                      <td style="width:90%;height:25px;color:#FFFFFF; font-weight:bold; "> Compose Options </td>
                  </tr>
                  <tr>
                  <td style="width:90%;height:100%;">
                      <div id="divPinCode" style="display:none;width:100%;height:100%;background-color:#EFF4F7;">
                        <table style="width: 100%; height: 100%; border: solid 1px #5A5D62;">
                            <tr><td colspan="3" ></td></tr>
                            <tr style="display:none;border-color:#FFFFCC;border:0px;" id="trerror">                                 
                                <td align="right" style="width:30%;height:35px;margin-right:30px; "><img src="../../images/icn_err.gif" alt="" /></td>
                                <td colspan="2">
                                    <b><font color="#CC0000" size="2" face="Verdana, Arial, Helvetica, sans-serif">The PINcode is incorrect. </font></b><font color="#CC0000" size="2" face="Verdana, Arial, Helvetica, sans-serif"><br />Please retype the correct PIN code.</font>
                                </td>                              
                            </tr>
                            <tr>
                                <td align="right" style="width:30%;height:25px;margin-right:5px;">Pin Code:</td><td style="width:170px;white-space:nowrap;">
                                <asp:Panel ID="PincodePanel" DefaultButton="btnGo"  runat="server" Wrap="false" ><asp:TextBox Width="170px" ID="txtPinCode" style="font-size:11px;" CssClass="GreyTextBox" runat="server" MaxLength="4" TextMode="Password"></asp:TextBox><asp:ImageButton OnClientClick ="javascript:ValidatePin();return false;" runat="server" align="absmiddle" style="margin-left:5px;" ID="btnGo" ImageUrl="~/images/btn_go.gif" /></asp:Panel></td><td>&nbsp</td>
                            </tr>
                            <tr><td colspan="3" ></td></tr>
                        </table>
                      </div>  
                      <table id="tblOptions" border="0" cellpadding="0" cellspacing="0" style="display:none;width: 100%; height: 100%; border: solid 1px #5A5D62;background-color: #EFF4F7;">
                          <tr><td colspan="6">&nbsp;</td></tr>
                          <tr id="trEmergencyOne" runat="server" valign="middle" visible="false">
                              <td style="height: 10%"></td>
                              <td></td>
                              <td>
                                  <img src="../images/wndw_blt_grn.jpg" align="absmiddle" width="24px" height="24px"
                                      alt="cancel" />
                              </td>
                              <td colspan="2">
                                  <a href="#" onClick="javascript:showPinCodeDiv();"  style="font-family: Arial; font-size: 17px;
                                      font-weight: bold; color: Red;">Send Emergency Message</a>
                              </td>
                              <td style="width: 15%;"></td>
                          </tr>
                          <tr id="trEmergencyTwo" runat="server" visible="false" valign="middle" style="border-bottom: 1px solid #C9D3E4;">
                              <td style="height: 2%"></td>
                              <td style="height: 2%;" colspan="4">
                                  <hr style="color: #D0D5D8; size: 1px;" />
                              </td>
                              <td style="height: 2%"></td>
                          </tr>
                          <tr valign="middle">
                              <td style="width: 15%; height: 10%"></td>
                              <td style="width: 5%;"></td>
                              <td style="width: 10%;">
                                  <img src="../images/wndw_blt_grn.jpg" align="absmiddle" width="24px" height="24px"
                                      alt="cancel" />
                              </td>
                              <td colspan="2" style="width: 55%;">
                                  <a href="email_compose.aspx" style="font-family: Arial; font-size: 17px; font-weight: bold;
                                      color: #444547;">Send Email Now</a>
                              </td>
                              <td style="width: 15%;"></td>
                          </tr>
                          <tr valign="middle" style="border-bottom: 1px solid #C9D3E4;">
                              <td style="height: 2%"></td>
                              <td style="height: 2%;" colspan="4">
                                  <hr style="color: #D0D5D8; size: 1px;" />
                              </td>
                              <td style="height: 2%"></td>
                          </tr>
                          <tr valign="middle">
                              <td style="width: 15%; height: 10%"></td>
                              <td style="width: 5%;"></td>
                              <td style="width: 10%;">
                                  <img src="../images/wndw_blt_grn.jpg" align="absmiddle" width="24px" height="24px"
                                      alt="cancel" />
                              </td>
                              <td colspan="2" style="width: 55%;">
                                  <a href="WeeklyLetter_Add.aspx?Forum=0" style="font-family: Arial; font-size: 17px;
                                      font-weight: bold; color: #444547;">EA Weekly</a>
                              </td>
                              <td style="width: 15%;"></td>
                          </tr>
                          <tr valign="middle" style="border-bottom: 1px solid #C9D3E4;">
                              <td style="height: 2%"></td>
                              <td style="height: 2%;" colspan="4">
                                  <hr style="color: #D0D5D8; size: 1px;" />
                              </td>
                              <td style="height: 2%"></td>
                          </tr>
                          <tr valign="middle">
                              <td style="height: 10%"></td>
                              <td></td>
                              <td>
                                  <img src="../images/wndw_blt_grn.jpg" align="absmiddle" width="24px" height="24px"
                                      alt="cancel" />
                              </td>
                              <td>
                                  <a href="WeeklyLetter_Add.aspx?Forum=1" style="font-family: Arial; font-size: 17px;
                                      font-weight: bold; color: #444547;">Franchisee Forum</a>
                              </td>
                              <td></td>
                              <td></td>
                          </tr>
                          <tr><td colspan="6">&nbsp;</td></tr>
                      </table>
                  </td>
                  </tr>  
                  <tr>
                    <td align="center"  style="height:10px;"><img src="../images/spacer.gif" width="13" height="10" alt="" align="absmiddle" /></td>
                  </tr>                 
                  <tr>
                    <td align="center">&nbsp;</td>
                  </tr>                 
                  <tr >
                    <td align="center" style="height:20px;">            
                        <!--<input id="btnClose" name="btnClose"  type="button" value="Close" class="btn3D" onClick="Reset()" />-->
                    </td>
                  </tr>
                 
            </table>
        </td>
        <td style="background-image:url(../images/wndw_rtCntr.Gif);background-repeat:repeat-y; width:13px; height:100%;">&nbsp;</td>
    </tr>
    <tr>
        <td style="background-image:url(../images/wndw_btmLft.Gif);background-repeat:no-repeat; width:14px; height:15px;"><img src="../images/spacer.gif" width="13" height="15" alt="" align="absmiddle" /></td>
        <td style="background-image:url(../images/wndw_btmCntr.Gif);background-repeat:repeat-x; width:100%; height:15px;"><img src="../images/spacer.gif"  height="15" alt="" align="absmiddle" /></td>
        <td style="background-image:url(../images/wndw_btmRt.Gif);background-repeat:no-repeat; width:18px; height:15px;"><img src="../images/spacer.gif" width="13" height="15" alt="" align="absmiddle" /></td>
    </tr>
</table>
</div>    
<script language="javascript">
function SetPosition()
{
    if (navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.toUpperCase().indexOf("MSIE 7.0") < 0)
    {
        setWindowedControlsVisibility(window,'hidden');
    }
    divDisable.style.width = document.body.scrollWidth - 1;
    divDisable.style.height = document.body.scrollHeight - 1;
    DivOption.style.display = "inline";
}
function showPinCodeDiv(Display)
{

    getElement('divPinCode').style.display = 'inline';
    getElement('txtPinCode').focus();
    getElement('btnClose').value = "Back"
    
    return false;
}
function ValidatePin()
{
    var txtPin = getElement('txtPinCode').value;
    var AdminPin = getElement('hdnPinCode').value;
    if(txtPin == AdminPin)
        window.location = 'email_compose.aspx?t=E';
    else
        getElement('trerror').style.display = 'inline';
}
function showOptionsTbl()
{
    getElement('tblOptions').style.display = 'inline';    
}
function Reset()
{
    if(getElement('btnClose').value == "Back")
    {
        getElement('tblOptions').style.display = 'inline';
        getElement('divPinCode').style.display = 'none';
        getElement('btnClose').value = "Close";
    }
    else
        window.location = '<%= ConfigurationManager.AppSettings("FranSupportUrl")  %>' + 'admin/mgmt/home.asp';
}
</script>

</form>
</body>
</html>
