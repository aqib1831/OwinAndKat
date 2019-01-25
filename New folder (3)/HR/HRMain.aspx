<%@ Page Language="VB" MasterPageFile="~/main.master" AutoEventWireup="false" CodeFile="~/HR/HRMain.aspx.vb" Inherits="HR_HRMain" title="Netsolace Portal-Human Resource Managment" %>
<%@ Register Src="~/HR/leftpanel_HR.ascx" TagName="ContactLeftPanel" TagPrefix="ucContactLeftPanel" %>
<%@ MasterType VirtualPath="~/main.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" Runat="Server">
<table border="0" cellpadding="0" cellspacing="0"  width="100%" style="height:100%;background-color:#E4F1F7;padding:4px;">
  <tr>              
    <td style="width:230px;height:100%; vertical-align:top;">
      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color:#D8EAFC;height:100%;border:1px solid #609BD3;">
        <tr>
          <td style="height:31px;background-color:#A0CDEE;font-size:15px;font-weight:bold;padding:5px;width:90%;border-bottom:1px solid #609BD3;">
              <span class="DarkBluelabel"> Human Resource Management</span>
          </td>
        </tr>
        <tr>
          <td>
             <ucContactLeftPanel:ContactLeftPanel ID="CalendarLeftPanel1" runat="server" Selected="3" />
          </td>
        </tr>
      </table>
    </td> 
    <td align="center" style="padding-left:0; vertical-align:top;">
      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin :0px; background-color:#BADCFC;height:100%;border:1px solid #609BD3;">
        <tr>
          <td style="width:100%; height:100%;"> <!--comments by saqib Second column -->
             <iframe name="IfHR" runat="server" id="IfHR" src="UsersTimeHistory.aspx" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
         </td>
       </tr>       
      </table>
    </td>
  </tr>
</table>
</asp:Content>

