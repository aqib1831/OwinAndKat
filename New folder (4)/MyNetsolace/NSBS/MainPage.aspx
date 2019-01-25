<%@ Page Language="VB" MasterPageFile="~/MyNetsolace/MyNetsolace.master" AutoEventWireup="false" CodeFile="MainPage.aspx.vb" Inherits="NSBS_MainPage" title="Netsolace Portal - License Management" %>
<%@ Register Src="leftPanel.ascx" TagName="leftPanelNSBS" TagPrefix="NSBS" %>
<%@ MasterType VirtualPath="~/MyNetsolace/MyNetsolace.master" %>
<asp:Content ID="ctHomePage" ContentPlaceHolderID="contentMyNetsolace" Runat="Server">
<table border="0" cellpadding="0" cellspacing="0"  style="height:100%;width:100%;background-color:#E4F1F7;">
  <tr>              
    <td style="width:170px;height:100%; vertical-align:top;">      
        <NSBS:leftPanelNSBS id="LeftPanel1" runat="server"></NSBS:leftPanelNSBS>
    </td> 
    <td align="center" style="vertical-align:top; border:1px solid #609BD3;">        
        <iframe id="iframeMain" frameborder="0" marginheight="0" marginwidth="0" src="ViewStatus.aspx" scrolling="no" width="100%" height="100%"></iframe>
    </td>
  </tr>
</table>
</asp:Content>

