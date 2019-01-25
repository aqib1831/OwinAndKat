<%@ Page Language="VB" MasterPageFile="~/main.master" AutoEventWireup="false" CodeFile="AdminMain.aspx.vb" Inherits="Admin_AdminMain" title="Netsolace Portal - Administration" Theme="Default"  %>
<%@ Register Src="leftpanel_Admin.ascx" TagName="ContactLeftPanel" TagPrefix="ucContactLeftPanel" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ MasterType VirtualPath="~/main.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" Runat="Server">
<table border="0" cellpadding="0" cellspacing="0"  width="100%" style="height:100%;background-color:#E4F1F7;">
  <tr>              
    <td style="width:165px;height:100%;" align="center" >
      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color:#D8EAFC;height:100%;">
        <tr>
          <td style="height:31px;font-size:15px;font-weight:bold;padding:15 10 0 10;width:90%;">
               <table border="0" cellpadding="1" cellspacing="0" style="width:auto;height:100%;" >
                   <tr>
                    <td><img src="../images/icn_admin.gif" alt="License Management" /></td>
                    <td style="font-size:12px;font-weight:bold;padding-left:5px;">
                     Administration
                    </td>
                   </tr>
                </table>
              
          </td>                 
        </tr>
        <tr>
          <td>
                <asp:Literal id="litJavaScript" runat="server" ></asp:Literal> 
                <ucContactLeftPanel:ContactLeftPanel ID="CalendarLeftPanel1" runat="server" Selected="1" />      

          </td>
        </tr>
      </table>
    </td> 
    <td align="center" style="padding-left:0; vertical-align:top;">
      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color:#BADCFC;height:100%;border:1px solid #609BD3;">
        <tr>
          <td style="width:100%; height:100%;"> <!--comments by saqib Second column -->
             <iframe name="IfAdmin" runat="server" id="IfAdmin" src="Users.aspx" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
         </td>
       </tr>
      </table>
    </td>
  </tr>
</table>
 
</asp:Content>

