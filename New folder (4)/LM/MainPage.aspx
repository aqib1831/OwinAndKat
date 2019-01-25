<%@ Page Language="VB" MasterPageFile="~/main.master" AutoEventWireup="false" CodeFile="MainPage.aspx.vb" Inherits="LM_MainPage" title="Netsolace Portal - License Management" %>
<%@ Register Src="leftPanelLM.ascx" TagName="leftPanelLM" TagPrefix="LM" %>
<%@ MasterType VirtualPath="~/main.master" %>

<asp:Content ID="ctHomePage" ContentPlaceHolderID="Content" Runat="Server">
<table border="0" cellpadding="0" cellspacing="0"  style="height:100%;width:100%;background-color:#E4F1F7;">
  <tr>              
    <td style="width:170px;height:100%; vertical-align:top;">      
        <LM:leftPanelLM id="LeftPanelLM1" runat="server"></LM:leftPanelLM>
    </td> 
    <td align="center" style="vertical-align:top; border:1px solid #609BD3;">        
        <iframe id="iframeMain" frameborder="0" marginheight="0" marginwidth="0" src="../LM/LicenseManagement.aspx" scrolling="no" width="100%" height="100%"></iframe>
    </td>
  </tr>
</table>
</asp:Content>

