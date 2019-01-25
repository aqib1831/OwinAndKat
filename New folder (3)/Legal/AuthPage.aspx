<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AuthPage.aspx.vb" Inherits="admin_research_Default" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Welcome to Fransupport.com - Company Authentication</title>
    <link href="../../style/style.css" type="text/css" rel="stylesheet" />
</head>
<body  style="overflow:hidden;height:100%; padding:0px; width:100%; background-color:#BADCFC;" onLoad="try{parent.topFrame.SelectLegal();}catch(ex){}">
 <form id="form1" runat="server" defaultfocus="txtPin">
 <asp:HiddenField ID="DetailURL_FromMySocket" runat="server" Value="" />
<table style="height:100%; width:100%;"  border="0" cellpadding="0" cellspacing="0"> 
  <tr>
     <td style="height:100%;padding:4px;">
                    <div style="overflow:visible;height:100%;background-color:#BADCFC;text-align:center;vertical-align:middle;">
                        <table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%;">
                            <tr><td>&nbsp;</td></tr>
                            <tr>
                                <td style="text-align:center; height:40px;">
                                    <table cellpadding="0" cellspacing="0" border="0" style="width:450px;height:100%;">
                                        <tr>
                                            <td style="width:8px;"><img src="../../images/loginFrm_topLft.gif" height="8" width="8" /></td>
                                            <td style="height:8px;background:url('../../images/loginFrm_topCntr.gif');background-repeat:repeat-x;"></td>
                                            <td style="width:8px;"><img src="../../images/loginFrm_topRt.gif" height="8" width="8" /></td>
                                        </tr>                                        
                                        <tr>
                                            <td style="background:url('../../images/loginFrm_lftCntr.gif');background-repeat:repeat-y;"></td>
                                            <td>
                                                <table id="tblForm" runat="server" cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%;background-color:#DDEEFE;">
                                                    <tr>
                                                        <td colspan="5" style="height:15px;">&nbsp;</td>
                                                    </tr>
                                                     <tr style="border-color:#FFFFCC;border:0px;" runat="server" id="trerror" visible="false">
                                                         <td style="width: 30px;">
                                                         </td>
                                                         <td style="width: 10px;">
                                                         </td>
                                                         <td style="width: 60px; height: 53px;">
                                                             <div align="center">
                                                                 <b>
                                                                     <img src="images/icn_err.gif" alt="" /></b>
                                                             </div>
                                                         </td>
                                                         <td style="width: 334px;">
                                                             <b><font color="#CC0000" size="2" face="Verdana, Arial, Helvetica, sans-serif">The PIN
                                                                 code is incorrect. </font></b><font color="#CC0000" size="2" face="Verdana, Arial, Helvetica, sans-serif">
                                                                     <br />
                                                                     Please retype the correct PIN code.</font>
                                                         </td>
                                                         <td style="width: 30px;">
                                                         </td>
                                                     </tr>
                                                     <tr>
                                                        <%--<td style="width:30px;"></td>
                                                        <td style="width:10px;"></td>--%>
                                                        <td colspan="5">
                                                            <asp:Panel runat="server" ID="pnlAuth" DefaultButton="btnGo" align="center" >  
                                                            <table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%;background-color:#DDEEFE;font-size:12px;color:#73797F;">
                                                                <tr>
                                                                    <td align="center" width="40%" >
                                                                        <font color="#000000" face="Verdana, Arial, Helvetica, sans-serif" size="2">PIN Code:</font>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox runat="server" ID="txtPin" Text="" TextMode="Password" MaxLength="4" CssClass="GreyTextBox" ></asp:TextBox>
                                                                        &nbsp;<asp:ImageButton runat="server" align="absmiddle"  ID="btnGo" ImageUrl="~/images/btn_go.gif" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            </asp:Panel>
                                                        </td>                                                        
                                                    </tr>
                                                    <tr>
                                                        <td colspan="5" style="height:15px;">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="background:url('../../images/loginFrm_rtCntr.gif');background-repeat:repeat-y;"></td>
                                        </tr>
                                        <tr>
                                            <td style="width:8px;"><img  src="../../images/loginFrm_btmLft.gif" height="8" width="8" /></td>
                                            <td style="height:8px;background:url('../../images/loginFrm_btmCntr.gif');background-repeat:repeat-x;"></td>
                                            <td style="width:8px;"><img  src="../../images/loginFrm_btmRt.gif" height="8" width="8" /></td>
                                        </tr>
                                        <tr>
                                            <td style="width:8px;"><img  src="../../images/loginFrm_reflctn_lft.jpg" height="40" width="8" /></td>
                                            <td style="height:8px;background:url('../../images/loginFrm_reflctn_cntr.jpg');background-repeat:repeat-x;"></td>
                                            <td style="width:8px;"><img  src="../../images/loginFrm_reflctn_rt.jpg" height="40" width="8" /></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr><td>&nbsp;</td></tr>
                        </table>
                    </div>
     </td>    
  </tr>  
</table>
</form>
</body>
</html>
