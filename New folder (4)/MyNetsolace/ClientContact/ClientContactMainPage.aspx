<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MyNetsolace/MyNetsolace.master" CodeFile="ClientContactMainPage.aspx.vb" Inherits="MyNetsolace_ClientContactMainPage" %>
<%@ Register Src="~/MyNetsolace/ClientContact/LeftPanelMyClientContact.ascx" TagName="leftPanelMyClientContact" TagPrefix="MyClientContact" %>
<%@ MasterType VirtualPath="~/MyNetsolace/MyNetsolace.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="contentMyNetsolace" Runat="Server">
<asp:HiddenField ID="hdnClientId" runat="server" />
<asp:HiddenField ID="hdnFranchiseId" runat="server" Value="0" />
<asp:HiddenField ID="hdnAreaDeveloperID" runat="server" Value="0" />
<link href="../../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
<table border="0" cellpadding="0" cellspacing="0"  width="100%" style="height:100%;background-color:#E4F1F7;padding:4px;">
  <tr>              
    <td style="width:165px;height:100%; vertical-align:top;">
      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color:#E4F1F7;height:100%;border:0px solid #609BD3;">
        <tr class="">
    <td  align="center" style="padding:15 10 15 10;">
        <table border="0" cellpadding="1" cellspacing="0" style="width:auto;height:100%;" >
           <tr>
            <td><img src="../images/icn_users.gif" alt="Users" /></td>
            <td style="font-size:12px;font-weight:bold;padding-left:5px;">
             <asp:Label ID="Label1"  runat="server" style="display:none;" Text="0" ></asp:Label>
            </td>
           </tr>
        </table>
    </td>            
</tr>
        <tr>
          
    <td id="lftforAdmin" runat="server" style="width:170px;height:100%; vertical-align:top;" >
        <MyClientContact:leftPanelMyClientContact ID="LeftPanelMyClientContact1" runat="server"/>
    </td>  
    
    
        </tr>
      </table>
    </td> 
    <td align="center" style="padding-left:0; vertical-align:top;">
      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin :0px; background-color:#BADCFC;height:100%; border:solid 1px #609BD3;">
        <tr>
          <td style="width:100%; height:100%;"> 
             <iframe name="iframeMain" runat="server"  src="ClientContactUser.aspx" title="Netsolace Portal - My Netsolace" id="iframeMain" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
         </td>
       </tr>       
      </table>
    </td>
  </tr>
</table>


</asp:Content>
