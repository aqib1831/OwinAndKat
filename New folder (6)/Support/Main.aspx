<%@ Page Language="VB" MasterPageFile="~/main.master" AutoEventWireup="false" CodeFile="Main.aspx.vb" Inherits="Support_MainPage" title="Support" %>
<%@ Register Src="leftPanel.ascx" TagName="leftPanel" TagPrefix="leftPanel" %>
<%@ MasterType VirtualPath="~/main.master" %>
<asp:Content ID="ctHomePage" ContentPlaceHolderID="Content" Runat="Server">
<table border="0" cellpadding="0" cellspacing="0"  style="height:100%;width:100%;background-color:#E4F1F7;">
  <tr>              
    <td style="width:170px;height:100%; vertical-align:top;">      
        <leftPanel:leftPanel id="LeftPanel1" runat="server"></leftPanel:leftPanel>
    </td> 
    <td align="center" style="vertical-align:top; border:1px solid #609BD3;">        
        <iframe id="iframeMain" name="iframeMain" runat="server"  frameborder="0" marginheight="0" marginwidth="0" src="../Support/NsProducts.aspx" scrolling="no" width="100%" height="100%"></iframe>
    </td>
  </tr>
</table>
    <script type="text/javascript" language="javascript" >
     iframeMain = document.getElementsByName('<%= iframeMain.ClientID %>');
     </script>
</asp:Content>

