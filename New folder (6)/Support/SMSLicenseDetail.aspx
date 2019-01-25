<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SMSLicenseDetail.aspx.vb" Inherits="LM_LicenseDetail" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>SMS License Detail</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
</head>
<body style="margin:0; padding:0; height:100%;">
    <form id="form1" runat="server">
    <div>
    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color:#F2F2F2;height:100%;" class="tblDetail" >
    <tr style="height:30px; background-image:url(../images/bg_mainHdr_1.jpg);">
        <th colspan="3" align="left" class="IdeaTitle">SMS License Detail</th>
        <th colspan="2" align="right" class="IdeaTitle" style="padding:0px;">        
            <div id="divltrlActive" runat="server" style=" width:150px; height:27px;" align="center">
                <table>
                <tr>
                    <td valign="middle" style="border-bottom:0;">
                    <b><asp:Label ID="ltrlActive" runat="server" style="color:White;" ></asp:Label>&nbsp;</b>
                    </td>
                </tr>
                </table>
            </div>
        </th>
    </tr> 
   <tr>
    <td colspan="5" style="padding:0;">
        <table border="0" cellpadding="0" cellspacing="0" style="width:100%; background-color:#F2F2F2;height:100%;margin:0px;" class="tblDetail" >
              <tr>
                <td style="width:12%;"></td>
                <td style="width:18%;"></td>
                <td style="width:03%;"></td>
                <td style="width:12%;"></td>
                <td style="width:18%;"></td> 
                <td style="width:03%;"></td>
                <td style="width:12%;"></td>
                <td style="width:18%;"></td>                
              </tr>
              <tr>
                <td >Store #:</td>
                <td ><b><asp:Literal ID="ltrlStoreNo" runat="server"></asp:Literal>&nbsp;</b></td>
                <td >&nbsp;</td>
                <td >Client:</td>
                <td ><b><asp:Literal ID="ltrlClientName" runat="server"></asp:Literal>&nbsp;</b></td> 
                <td >&nbsp;</td>
                <td colspan="2"  align="right">
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btnSilver" />
                </td>                
           </tr>
            <tr>
                <td >Store Nick:</td>
                <td ><b><asp:Literal ID="ltrlStoreNick" runat="server"></asp:Literal>&nbsp;</b></td>
                <td>&nbsp;</td>        
                <td>Static IP:</td>
                <td><b><asp:Literal ID="ltrlIsStaticIP" runat="server"></asp:Literal>&nbsp;</b></td>
                <td>&nbsp;</td>
                <td >On Support:</td>
                <td ><b><asp:Literal ID="ltrlOnSupport" runat="server"></asp:Literal>&nbsp;</b></td>  
            </tr>
            <tr>
                <td >Version:</td>
                <td ><b><asp:Literal ID="ltrlCurrentVersion" runat="server"></asp:Literal>&nbsp;</b></td>
                <td>&nbsp;</td>        
                <td><span id="spnserverip" runat="server" >Server IP:</span>&nbsp;</td>
                <td><b><asp:Literal ID="ltrlServerIP" runat="server"></asp:Literal>&nbsp;</b></td>
                <td>&nbsp;</td>
                <td nowrap>Last Time Sync:</td>
                <td><b><asp:Label ID="ltrlLastTimeSync" runat="server"></asp:Label>&nbsp;</b></td>       
            </tr>
            <tr> 
                <td>Server Name:</td>
                <td><b><asp:Literal ID="ltrlServerName" runat="server"></asp:Literal>&nbsp;</b></td>                       
                <td>&nbsp;</td>
                <td nowrap>No of Live Terminals:</td>
                <td><b><asp:Label ID="ltrlLiveTerminals" runat="server"></asp:Label>&nbsp;</b></td>                
                <td>&nbsp;</td>
                <td>Updated On:</td>
                <td><b><asp:Label ID="ltrlUpdateOn" runat="server"></asp:Label>&nbsp;</b></td>  
            </tr>
              <tr>    
                <td nowrap>Server Password:</td>
                <td><b><asp:Literal ID="ltrlServerPassword" runat="server"></asp:Literal></b>&nbsp;</td>
                <td>&nbsp;</td>
                <td>No of Licenses:</td>
                <td> <b><asp:Literal ID="ltrlNoLicenses" runat="server"></asp:Literal>&nbsp;</b></td>                
                <td>&nbsp;</td>
                <td>Updated By:</td>
                <td><b><asp:Literal ID="ltrlUpdatedBy" runat="server"></asp:Literal>&nbsp;</b></td>
            </tr>
            <tr style="height:30px; background-image:url(../images/bg_mainHdr_1.jpg);">
                <th colspan="4" align="left" class="IdeaTitle">Technical Information </th>
                <th colspan="4" align="right" style="padding:0px;"></th>
            </tr>
             <tr>
                <td >ISP/Type:</td>
                <td ><b><asp:Literal ID="ltrlISPType" runat="server"></asp:Literal>&nbsp;</b></td>
                <td>&nbsp;</td>
                 <td nowrap >Firewall/Router Access:</td>
                <td><b><asp:Literal ID="ltrlFirewallRouterAccess" runat="server"></asp:Literal>&nbsp;</b></td> 
                <td>&nbsp;</td>
                <td >ISP Password:</td>
                <td ><b><asp:Literal ID="ltrlISPPassword" runat="server"></asp:Literal>&nbsp;</b></td> 
                
            </tr>
            <tr>
                <td >Primary DNS:</td>
                <td ><b><asp:Literal ID="ltrlPrimaryDNS" runat="server"></asp:Literal>&nbsp;</b></td>                
                <td>&nbsp;</td>        
                <td>Firewall/router:</td>
                <td><b><asp:Literal ID="ltrlFirewallRouter" runat="server"></asp:Literal>&nbsp;</b></td>
                <td>&nbsp;</td>
                <td >Dialup Speed:</td>
                <td ><b><asp:Literal ID="ltrlDialupSpeed" runat="server"></asp:Literal>&nbsp;</b></td>        
                
            </tr>
             <tr>
                <td>Secondary DNS:</td>
                <td><b><asp:Literal ID="ltrlSecondaryDNS" runat="server"></asp:Literal>&nbsp;</b></td>
                <td>&nbsp;</td>        
                <td nowrap>Firewall/Router Login:</td>
                <td><b><asp:Literal ID="ltrlFirewallRouterLogin" runat="server"></asp:Literal>&nbsp;</b></td>
                <td>&nbsp;</td>
                <td >ISP UserName:</td>
                <td ><b><asp:Literal ID="ltrlISPUserName" runat="server"></asp:Literal>&nbsp;</b></td>
            </tr>
             <tr>
                <td valign="top" colspan="5">Notes :</td>
                <td>&nbsp;</td> 
                <td>Switch :</td>
                <td><b><asp:Literal ID="ltrlSwitch" runat="server"></asp:Literal>&nbsp;</b></td>
            </tr>   
           
       </table> 
    </td>
   </tr>
   
   
    <tr style="height:100%;">
        <td style="border-bottom:0;" valign="top" colspan="5">
            <asp:Literal ID="ltrlNotes" runat="server"></asp:Literal>
        </td>        
    </tr>
    <tr style="height:30px; background-color:#dcdcdc;">
        <td colspan="6" style="border-top:solid 1px #609BD3; padding-right:10px;" align="right">
            <input type="button" class="btnSilver" value="Back" onclick="window.location='SMSLicenseManagement.aspx';" />
        </td>
    </tr>
    </table>
    </div>
    </form>
</body>
</html>
