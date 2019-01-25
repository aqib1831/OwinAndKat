<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CtrlAlertDiv.ascx.vb"  Inherits="UserControls_CtrlAlertDiv" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<div  runat="server" id="divError" style="  width: 350px;visibility:hidden;FILTER: revealTrans(duration=0.45,transition=12); z-index:1001;" >
  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#f1f6fa">
    <tr>
      <td><table width="100%" border="0" cellspacing="0" cellpadding="0">     
        <tr>  
               <td align="left" style="border-bottom:solid 1px #000000; padding-left:1em; background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
                <strong><asp:Label runat="server" Font-Size="14px" ID="lblHeadertext" ForeColor="white"></asp:Label> </strong>
              </td>
               <td  style="border-bottom:solid 1px #000000;background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%; height:28px; cursor:pointer;" onclick="javascript:closeDiv('<%=diverror.ClientID %>'); return false;">
               <img  alt=""  src="../images/win_btn_close_Black.jpg" width="21" height="28" runat="server" id="imgClose" visible="true" border="0" />                    
               </td>               
            </tr>    
      </table></td>
    </tr>
    <tr>
      <td class="div_bg">
      <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">        
        <tr>
          <td  align="left"><table width="70%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
            <td width="30px" style="padding-top:20px; padding-bottom:20px;">  <asp:Image ImageUrl="../Images/icn_info.gif" runat="server" ID="ImgErrorType" /> </td>
              <td><asp:Label ID="lblError" runat="server" Font-Size="12px" EnableViewState="false" ></asp:Label></td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td height="30" align="right" style="padding-right:5px;" valign="middle" class="divBg_footer"><a href="#" onclick="javascript:closeDiv('<%=diverror.ClientID %>'); "><asp:Button ID="btnMy" runat="server"  CssClass="button_Normal" Visible="false" /></a> &nbsp; &nbsp; <a href="#" onclick="javascript:closeDiv('<%=diverror.ClientID %>'); return false;"><input type="button" size="15" runat="server" id="btnClose" value=" Close " class="button_normal"/></a></td>
        </tr>
      </table></td>
    </tr>
  </table>
</div>
<ajaxToolkit:AlwaysVisibleControlExtender ID="avce" runat="server" TargetControlID="divError" VerticalSide="Middle"  VerticalOffset="0" HorizontalSide="Center" HorizontalOffset="0" ScrollEffectDuration=".1" />
