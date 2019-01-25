<%@ Page Language="VB"  AutoEventWireup="false" MasterPageFile="~/AreaDeveloper/MyNetsolace.master" CodeFile="MainPage.aspx.vb" Inherits="MyNetsolace_MainPage" title="Netsolace Portal - My Netsolace" Theme="Default" %>
<%@ MasterType VirtualPath="~/AreaDeveloper/MyNetsolace.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentMyNetsolace" Runat="Server">
<asp:HiddenField ID="hdnClientId" runat="server" />
<asp:HiddenField ID="hdnFranchiseId" runat="server" Value="0" />
<asp:HiddenField ID="hdnAreaDeveloperID" runat="server" Value="0" />
<table border="0" cellpadding="0" cellspacing="0"  width="100%" style="height:100%;background-color:#E4F1F7;padding:4px;">
  <tr>
    <td align="center" style="padding-left:0; vertical-align:top;">
      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin :0px; background-color:#BADCFC;height:100%; border:solid 1px #609BD3;">
        <tr>
          <td style="width:100%; height:100%;"> <!--comments by saqib Second column -->
             <iframe name="iframeMain" runat="server"  title="Netsolace Portal - My Netsolace" id="iframeMain" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
         </td>
       </tr>       
      </table>
    </td>
  </tr>   
</table>
</asp:Content>

