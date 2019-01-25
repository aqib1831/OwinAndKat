<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UMMain.aspx.vb" Inherits="UM_UMMain" MasterPageFile="~/main.master" %>
<%@ Register Src="UMLeftPanel.ascx" TagName="UMLeftPanel" TagPrefix="CsCtrl" %>
<%@ MasterType VirtualPath="~/main.master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="Server">
  <table border="0" cellpadding="0" cellspacing="0"  width="100%" style="height:100%;background-color:#E4F1F7;padding:0px;">
  <tr>              
    <td style="width:170px;height:100%; vertical-align:top;">
      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color:#D8EAFC;height:100%;border:0px solid #609BD3;">
        <tr id="leftpanel" runat="server">
          <td valign="top" style=" ">
              <CsCtrl:UMLeftPanel ID="UMLeftPanel1" runat="server" />
           </td>
         </tr> 
      </table>
    </td> 
    <td align="center" style="padding-left:0; vertical-align:top;">
      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%;border:1px solid #609BD3;">
        <tr>
          <td style="width:100%; height:100%;"> 
             <iframe id="iframeMain" src="RecentUpdates.aspx" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
         </td>
       </tr>
      </table>
    </td>
  </tr>
</table>
</asp:Content> 
