<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SMSLicenseDetail.aspx.vb" Inherits="LM_SMSLicenseDetail" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>SMSx License Detail</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
</head>
<body style="margin:0; padding:0; height:100%;">
    <form id="form1" runat="server">
    <div>
    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color:#F2F2F2;height:100%;" class="tblDetail" >
    <tr style="height:30px; background-image:url(../images/bg_mainHdr_1.jpg);">
        <th colspan="3" align="left" class="IdeaTitle"><asp:Literal ID="ltrlStoreNo" runat="server"></asp:Literal></th>
        <th colspan="2" align="right">
             <b><asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btnSilver" style="cursor:pointer;" />&nbsp;</b>
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
                <td >Version:</td>
                <td ><b><asp:Literal ID="ltrlCurrentVersion" runat="server"></asp:Literal>&nbsp;</b></td>
                <td>&nbsp;</td>        
                <td><span id="spnserverip" runat="server" >Server IP:</span>&nbsp;</td>
                <td ><b><asp:Label ID="txtServerIP" runat="server"></asp:Label>&nbsp;</b></td>
                <td>&nbsp;</td>
                <td >Primary DNS:</td>
                <td ><b><asp:Label ID="txtPrimaryDNS" runat="server"></asp:Label>&nbsp;</b></td>
            </tr>
            <tr>
                <td>No of Licenses:</td>
                <td > <b><asp:Label ID="txtNoLicenses" runat="server"></asp:Label>&nbsp;</b></td>
                <td>&nbsp;</td>        
                <td>Static IP:</td>
                <td ><b><asp:Label ID="chkStaticIP" runat="server" />&nbsp;</b></td>
                <td>&nbsp;</td>
                <td nowrap>Secondary DNS:</td>
                <td ><b><asp:Label ID="txtSecondaryDNS" runat="server"></asp:Label>&nbsp;</b></td>
            </tr>
            <tr>
                <td nowrap>No of Live Terminals:</td>
                <td><b><asp:Label ID="ltrlLiveTerminals" runat="server"></asp:Label>&nbsp;</b></td>
                <td>&nbsp;</td>
                <td>Server Name:</td>
                <td ><b><asp:Label ID="txtServerName" runat="server"></asp:Label>&nbsp;</b></td>
                <td>&nbsp;</td>
                <td>Firewall/router:</td>
                <td ><b><asp:Label ID="txtFirewallRouter" runat="server"></asp:Label>&nbsp;</b></td>
                
            </tr>
            <tr> 
                <td>CC Payment GW:</td>
                <td ><b><asp:Label ID="ddlCCPaymentGateway" runat="server"></asp:Label>&nbsp;</b>
                </td>  
                <td>&nbsp;</td>
                <td nowrap>Server Password:</td>
                <td ><b><asp:Label ID="txtServerPassword" runat="server"></asp:Label></b>&nbsp;</td>
                <td>&nbsp;</td>
                <td nowrap>Firewall/Router Login:</td>
                <td ><b><asp:Label ID="txtFirewallRouterLogin" runat="server"></asp:Label>&nbsp;</b></td>
            </tr>
             <tr> 
                <td>CC Login:</td>
                <td ><b><asp:Label ID="txtCCLogin" runat="server"></asp:Label>&nbsp;</b></td>
                <td>&nbsp;</td>
                <td nowrap>Last IP Reported:</td>
                <td><b><asp:Label ID="ltrlLastTimeSync" runat="server"></asp:Label>&nbsp;</b></td>       
                <td>&nbsp;</td>
                <td nowrap >Firewall/Router Access:</td>
                <td ><b><asp:Label ID="txtFirewallRouterAccess" runat="server"></asp:Label >&nbsp;</b></td>
            </tr>
             <tr> 
                <td nowrap>CC Password:</td>
                <td ><b><asp:Label ID="txtCCPassword" runat="server"></asp:Label>&nbsp;</b></td>
                <td>&nbsp;</td>
                <td>Updated By:</td>
                <td><b><asp:Literal ID="ltrlUpdatedBy" runat="server"></asp:Literal>&nbsp;</b></td> 
                <td>&nbsp;</td>
                <td >ISP/Type:</td>
                <td ><b><asp:Label ID="txtISPType" runat="server" ></asp:Label>&nbsp;</b></td>
            </tr>
              <tr>    
                <td nowrap>Merchant No:</td>
                <td ><b><asp:Label ID="txtMerchantNo" runat="server"></asp:Label>&nbsp;</b></td>
                <td>&nbsp;</td>
                <td>Updated On:</td>
                <td><b><asp:Label ID="ltrlUpdateOn" runat="server"></asp:Label>&nbsp;</b></td>  
                <td>&nbsp;</td>
                <td nowrap>ISP User Name:</td>
                <td ><b><asp:Label ID="txtISPUserName" runat="server"></asp:Label>&nbsp;</b></td>
            </tr>
            <tr> 
                <td nowrap>Merchant Password:</td>
                <td ><b><asp:Label ID="txtAuthLogin" runat="server"></asp:Label>&nbsp;</b></td>
                <td>&nbsp;</td>
                <td>Content Filtering:</td>
                <td><b><asp:Label ID="lblContentFiltering" runat="server"></asp:Label>&nbsp;</b></td>  
                <td>&nbsp;</td>
                <td >ISP Password:</td>
                <td ><b><asp:Label ID="txtISPPassword" runat="server"></asp:Label>&nbsp;</b></td> 
            </tr>
            <tr>
                <td nowrap>Delivery Charge:</td>
                <td ><b><asp:Label ID="txtDeliveryCharge" runat="server"></asp:Label>&nbsp;</b></td>
                <td>&nbsp;</td>       
                <td colspan="2" >Notes :</td>
                <td>&nbsp;</td>
                <td >&nbsp;</td>
                <td >&nbsp;</td>
            </tr>
            <tr> 
                <td nowrap>Delivery Charge VAT:</td>
                <td ><b><asp:Label ID="txtDeliveryChargeVAT" runat="server"></asp:Label>&nbsp;</b></td>                  
                <td>&nbsp;</td>
                <td colspan="5" rowspan="6" style="border:solid 1px #609BD3; border-top:0px; ">
                     <asp:Label ID="txtNotes" Font-Size="12px" runat="server" Width="100%" Height="100%" Font-Bold="true"></asp:Label>
                </td>
            </tr>
            <tr> 
                <td nowrap>GPS Enabled:</td>
                <td ><b><asp:Label ID="chkTagPrinting" runat="server" ></asp:Label>&nbsp;</b></td>
                <td>&nbsp;</td>
            </tr>
            <tr> 
                <td nowrap>House Charge:</td>
                <td ><b><asp:Label ID="chkHouseCharge" runat="server" ></asp:Label>&nbsp;</b></td>
                <td>&nbsp;</td>
            </tr>
            <tr> 
                <td nowrap>House Charge Amt:</td>
                <td ><b><asp:Label ID="txtHouseChargeAmount" runat="server"></asp:Label>&nbsp;</b></td>
                <td>&nbsp;</td>
            </tr>
            <tr> 
                <td nowrap>Inter Franchisee Discount:</td>
                <td ><b><asp:Label ID="txtSMSAutoDiscount" runat="server"></asp:Label>&nbsp;</b></td>
                <td>&nbsp;</td>
            </tr>
            <tr> 
                <td nowrap>Tax Rate:</td>
                <td ><b><asp:Label ID="txtTaxRate" runat="server"></asp:Label>&nbsp;</b></td>
                <td>&nbsp;</td>
            </tr>
       </table> 
    </td>
   </tr>   
    <tr style="height:30px; background-color:#dcdcdc;">
        <td colspan="6" style="border-top:solid 1px #609BD3; padding-right:10px;" align="right">
            <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btnSilver" />
        </td>
    </tr>
    </table>
    </div>
    </form>
        <script language="javascript" type="text/javascript">
        </script>
</body>
</html>
