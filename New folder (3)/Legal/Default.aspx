<%@ Page Language="VB" MasterPageFile="../main.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="admin_Legal_Default" title="Legal" %>
<%@ Register Src="leftpanel_Legal.ascx" TagName="leftpanel_Legal" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" Runat="Server">
<script language="javascript" type="text/javascript">
</script>

<table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%;background-color:#E4F1F7;padding:4px;">
   <tr>
      <td style="width:225px;height:31px;">
         <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color:#D8EAFC;height:100%;border:1px solid #609BD3;">
             <tr>
                <td style="height:31px;background-color:#A0CDEE;padding:5px;width:90%;border-bottom:1px solid #609BD3;">
                  <span class="DarkBluelabel"> Legal</span></td>                 
             </tr>
             <tr>
                <td valign="top">
                    <uc1:leftpanel_Legal id="Leftpanel_Legal1" runat="server">
                    </uc1:leftpanel_Legal></td>
             </tr>
        </table>
     </td>            
     <td align="center" style="padding-left:0;" valign="top" >
        <iframe name="frameMain" id="frameMain" width="100%" height="100%" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0" src="LegalHome.aspx" runat="server"></iframe>
      </td>
   </tr>
</table>
</asp:Content>

