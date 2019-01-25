<%@ Page Language="VB" MasterPageFile="~/MyNetsolaceClient/MyNetsolace.master" AutoEventWireup="false" CodeFile="UrlmMain.aspx.vb" Inherits="URLM_UrlmMain" title="Netsolace Portal-Url Management" %>
<%@ Register Src="~/MyNetsolaceClient/URLM/leftpanel_Urlm.ascx" TagName="LeftPanel" TagPrefix="ucComLeftPanel" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ MasterType VirtualPath="~/MyNetsolaceClient/MyNetsolace.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="contentMyNetsolace" Runat="Server">
<table border="0" cellpadding="0" cellspacing="0"  width="100%" style="height:100%;background-color:#E4F1F7;padding:4px;">
  <tr>              
    <td style="width:230px;height:100%; vertical-align:top;">
      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color:#D8EAFC;height:100%;border:1px solid #609BD3;">
        <tr>
          <td style="height:31px;background-color:#A0CDEE;font-size:15px;font-weight:bold;padding:5px;width:90%;border-bottom:1px solid #609BD3;">
              <span class="DarkBluelabel"> URLM </span></td>                 
        </tr>
        <tr>
          <td valign="top" id="LeftPanelContainer">
             <ucComLeftPanel:LeftPanel ID="ComLeftPanel" runat="server"  />
          </td>
        </tr>
      </table>
    </td> 
    <td align="center" style="padding-left:0; vertical-align:top;">
      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin :0px; background-color:#BADCFC;height:100%;border:1px solid #609BD3;">
        <tr>
          <td style="width:100%; height:100%;"> <!--comments by saqib Second column -->
             <iframe name="Iframe" runat="server" id="Iframe" src="UrlmHome.aspx" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
         </td>
       </tr>       
      </table>
    </td>
  </tr>
</table>
<script type="text/javascript">
        function AdjustHeightForSafari()
	    {    
	        var browser = '<%=Session("UserBrowser")%>';
	        if(browser=="AppleMAC-Safari")
	        {
	            var elem1 = document.getElementById('LeftPanelContainer');
	            elem2 = document.getElementById("TrFooter");
                var desiredheight = elem2.offsetTop-elem1.offsetTop;
                desiredheight = desiredheight-138;
                SetStoreDivHeight(desiredheight); //Function Call because the desired server side elem is not accessioble here;
            }
            else
            {
                SetStoreDivHeight(0);//Function Call because the desired server side elem is not accessioble here;
            }
       }
       
</script>
</asp:Content>