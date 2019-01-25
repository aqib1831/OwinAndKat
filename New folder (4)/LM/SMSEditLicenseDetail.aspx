<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SMSEditLicenseDetail.aspx.vb" Inherits="LM_LicenseDetail" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>SMS License Detail</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
</head>
<body style="margin:0; padding:0; height:100%;">
    <form id="form1" runat="server">
    <asp:HiddenField ID="hdnFransupportFranchiseID" runat="server" />  
    <asp:HiddenField ID="hdnPreviousContentFiltering" runat="server" Value="0" />  
    <div>
    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color:#F2F2F2;height:100%;" class="tblDetail" >
    <tr style="height:30px; background-image:url(../images/bg_mainHdr_1.jpg);">
        <th colspan="3" align="left" class="IdeaTitle"><asp:Literal ID="ltrlStoreNo" runat="server"></asp:Literal></th>
        <th colspan="2" align="right" style="padding:0px;">        
            <div id="divltrlActive" runat="server" style=" width:150px; height:27px;" align="center">
                <table>
                <tr>
                    <td valign="middle" style="border-bottom:0;">
                    <b>&nbsp;</b>
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
                <td >Version:</td>
                <td ><b><asp:Literal ID="ltrlCurrentVersion" runat="server"></asp:Literal>&nbsp;</b></td>
                <td>&nbsp;</td>        
                <td><span id="spnserverip" runat="server" >Server IP:</span>&nbsp;</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtServerIP" runat="server"></asp:TextBox>&nbsp;</b><asp:CustomValidator ID="cvSystemIP" runat="server" ErrorMessage="<br />Required System IP" ClientValidationFunction="ValidateIP" CssClass="RequiredField" Display="Dynamic"></asp:CustomValidator></td>
                <td>&nbsp;</td>
                <td >Primary DNS:</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtPrimaryDNS" runat="server" MaxLength="50"></asp:TextBox>&nbsp;</b></td>
            </tr>
            <tr>
                <td>No of Licenses:</td>
                <td style="padding:0;"> <b><asp:TextBox ID="txtNoLicenses" runat="server" MaxLength="50"></asp:TextBox>&nbsp;&nbsp;<asp:Label ID="lblNoLicenses" runat="server"></asp:Label>&nbsp;<asp:RangeValidator id="RangeValidator1" runat="server" ControlToValidate="txtNoLicenses" Type="Integer" ErrorMessage="<br />Licenses Must Be Number" MaximumValue="1000" MinimumValue="0" Display="Dynamic" CssClass="RequiredField"></asp:RangeValidator></b></td>
                <td>&nbsp;</td>        
                <td>Static IP:</td>
                <td style="padding:0;"><b><asp:CheckBox ID="chkStaticIP" runat="server" />&nbsp;</b></td>
                <td>&nbsp;</td>
                <td nowrap>Secondary DNS:</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtSecondaryDNS" runat="server" MaxLength="50"></asp:TextBox>&nbsp;</b></td>
            </tr>
            <tr>
                <td nowrap>No of Live Terminals:</td>
                <td><b><asp:Label ID="ltrlLiveTerminals" runat="server"></asp:Label>&nbsp;</b></td>
                <td>&nbsp;</td>
                <td>Server Name:</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtServerName" runat="server" MaxLength="50"></asp:TextBox>&nbsp;</b></td>
                <td>&nbsp;</td>
                <td>Firewall/router:</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtFirewallRouter" runat="server" MaxLength="50"></asp:TextBox>&nbsp;</b></td>
                
            </tr>
            <tr> 
                <td>CC Payment GW:</td>
                <td style="padding:0;"><b><asp:DropDownList ID="ddlCCPaymentGateway" runat="server" style="width:88%;" Height="10" Font-Size="9"  >
                    <asp:ListItem Text="Select..." Value="0" ></asp:ListItem>
                    <asp:ListItem Text="MPS" Value="1" ></asp:ListItem>
                    <asp:ListItem Text="FD" Value="2" ></asp:ListItem>
                    </asp:DropDownList>&nbsp;</b>
                <asp:CompareValidator ID="CV_ddlCCPaymentGateway" runat="server" 
                    ControlToValidate="ddlCCPaymentGateway"
                    Display="Dynamic" 
                    ErrorMessage="Select CC Payment GW" 
                    Operator="GreaterThan"
                    CssClass="RequiredField"
                    Type="Integer" 
                    ValueToCompare="0" />
                </td>  
                <td>&nbsp;</td>
                <td nowrap>Server Password:</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtServerPassword" runat="server" MaxLength="50"></asp:TextBox><span id="spanServerPasswordHidden" runat="server" style="display:none;">**********</span> </b>&nbsp;</td>
                <td>&nbsp;</td>
                <td nowrap>Firewall/Router Login:</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtFirewallRouterLogin" runat="server" MaxLength="50"></asp:TextBox>&nbsp;</b></td>
            </tr>
             <tr> 
                <td>CC Login:</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtCCLogin" runat="server" MaxLength="50"></asp:TextBox>&nbsp;</b></td>
                <td>&nbsp;</td>
                <td nowrap>Last IP Reported:</td>
                <td><b><asp:Label ID="ltrlLastTimeSync" runat="server"></asp:Label>&nbsp;</b></td>       
                <td>&nbsp;</td>
                <td nowrap >Firewall/Router Access:</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtFirewallRouterAccess" runat="server" MaxLength="50"></asp:TextBox >&nbsp;</b></td>
            </tr>
             <tr> 
                <td nowrap>CC Password:</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtCCPassword" runat="server" MaxLength="50"></asp:TextBox>&nbsp;</b></td>
                <td>&nbsp;</td>
                <td>Updated By:</td>
                <td><b><asp:Literal ID="ltrlUpdatedBy" runat="server"></asp:Literal>&nbsp;</b></td> 
                <td>&nbsp;</td>
                <td >ISP/Type:</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtISPType" runat="server" MaxLength="50" ></asp:TextBox>&nbsp;</b></td>
            </tr>
              <tr>    
                <td nowrap>Merchant No:</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtMerchantNo" runat="server" MaxLength="50"></asp:TextBox>&nbsp;<asp:RangeValidator id="RangeValidator2" runat="server" ControlToValidate="txtMerchantNo" Enabled="false" Type="Integer" ErrorMessage="<br />Merchant No Must Be Number" MaximumValue="1000000" MinimumValue="0" Display="Dynamic" CssClass="RequiredField"></asp:RangeValidator></b></td>
                <td>&nbsp;</td>
                <td>Updated On:</td>
                <td><b><asp:Label ID="ltrlUpdateOn" runat="server"></asp:Label>&nbsp;</b></td>  
                <td>&nbsp;</td>
                <td nowrap>ISP User Name:</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtISPUserName" runat="server" MaxLength="50"></asp:TextBox>&nbsp;</b></td>
            </tr>
            <tr> 
                <td nowrap>Merchant Password:</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtAuthLogin" runat="server" MaxLength="50"></asp:TextBox>&nbsp;</b></td>
                <td>&nbsp;</td>
                <td>Content Filtering:</td>
                <td style="padding:0;"><asp:DropDownList ID="ddlContentFiltering" runat="server" style="width:88%;" Height="10" Font-Size="9"  >
                        <asp:ListItem Text="Select..." Value="0" ></asp:ListItem>
                        <asp:ListItem Text="Enabled" Value="1" ></asp:ListItem>
                        <asp:ListItem Text="Not Checked" Value="2" ></asp:ListItem>
                        <asp:ListItem Text="Refused" Value="3" ></asp:ListItem>
                    </asp:DropDownList>&nbsp;
                <asp:CompareValidator ID="CompareValidator1" runat="server" 
                        ControlToValidate="ddlContentFiltering"
                        Display="Dynamic" 
                        ErrorMessage="Select Content Filtering" 
                        Operator="GreaterThan"
                        CssClass="RequiredField"
                        Type="Integer" 
                        ValueToCompare="0" />
                </td> 
                <td>&nbsp;</td>
                <td >ISP Password:</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtISPPassword" runat="server" MaxLength="50"></asp:TextBox>&nbsp;</b></td> 
            </tr>
            <tr>
                <td nowrap>Delivery Charge:</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtDeliveryCharge" runat="server" MaxLength="50"></asp:TextBox><asp:RangeValidator id="RangeValidator3" runat="server" ControlToValidate="txtDeliveryCharge" Type="Double" ErrorMessage="Number" MaximumValue="10000000" MinimumValue="0" Display="Dynamic" CssClass="RequiredField"></asp:RangeValidator></b></td>
                <td>&nbsp;</td>       
                <td colspan="2" >Notes :<asp:RegularExpressionValidator ID="revNotes" runat="server" ValidationExpression="^[\s\S]{0,1000}$" ControlToValidate="txtNotes" CssClass="RequiredField" Display="Dynamic"  ErrorMessage="Max 1000 char Allowed"></asp:RegularExpressionValidator></td>
                <td>&nbsp;</td>
                <td nowrap>&nbsp;</td>
                <td style="padding:0;">&nbsp;</td>
            </tr>
            <tr> 
                <td nowrap>Delivery Charge VAT:</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtDeliveryChargeVAT" runat="server" MaxLength="50"></asp:TextBox><asp:RangeValidator id="RangeValidator4" runat="server" ControlToValidate="txtDeliveryChargeVAT" Type="Double" ErrorMessage="Number" MaximumValue="10000000" MinimumValue="0" Display="Dynamic" CssClass="RequiredField"></asp:RangeValidator></b></td>                  
                <td>&nbsp;</td>
                <td colspan="5" rowspan="6" style="border-bottom:0;padding:0px;" valign="top">
                     <asp:TextBox ID="txtNotes" Font-Size="11px" runat="server" TextMode="MultiLine" Width="100%" Height="100%"></asp:TextBox>
                </td>
            </tr>
            <tr> 
                <td nowrap>GPS Enabled:</td>
                <td style="padding:0;"><b><asp:CheckBox ID="chkTagPrinting" runat="server" ></asp:CheckBox>&nbsp;</b></td>
                <td>&nbsp;</td>
            </tr>
            <tr> 
                <td nowrap>House Charge:</td>
                <td style="padding:0;"><b><asp:CheckBox ID="chkHouseCharge" runat="server" ></asp:CheckBox>&nbsp;</b></td>
                <td>&nbsp;</td>
            </tr>
            <tr> 
                <td nowrap>House Charge Amt:</td>
				<td style="padding:0;"><b><asp:TextBox ID="txtHouseChargeAmount" runat="server" MaxLength="50"></asp:TextBox><asp:RegularExpressionValidator id="RangeValidator5" runat="server" ValidationExpression="^(\d|,)*\.?\d*$" ControlToValidate="txtHouseChargeAmount" ErrorMessage="Number" Display="Dynamic" CssClass="RequiredField"></asp:RegularExpressionValidator></b></td>
                <td>&nbsp;</td>
            </tr>
            <tr> 
                <td nowrap>Inter Franchisee Discount:</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtSMSAutoDiscount" runat="server" MaxLength="50"></asp:TextBox><asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationExpression="^\d{0,2}(\.\d{1,4})? *%?$" ControlToValidate="txtSMSAutoDiscount" CssClass="RequiredField" Display="Dynamic"  ErrorMessage="Percentage"></asp:RegularExpressionValidator></b></td>
                <td>&nbsp;</td>
            </tr>
            <tr> 
                <td nowrap>Tax Rate:</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtTaxRate" runat="server" MaxLength="50"></asp:TextBox><asp:RangeValidator id="RangeValidator7" runat="server" ControlToValidate="txtTaxRate" Type="Double" ErrorMessage="Number" MaximumValue="10000000" MinimumValue="0" Display="Dynamic" CssClass="RequiredField"></asp:RangeValidator></b></td>
                <td>&nbsp;</td>
            </tr>
       </table> 
    </td>
   </tr>   
    <tr style="height:30px; background-color:#dcdcdc;">
        <td colspan="6" style="border-top:solid 1px #609BD3; padding-right:10px;" align="right">
            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btnSilver"  />
            <asp:Button ID="btnCacnel" runat="server" Text="Cancel" CssClass="btnSilver" CausesValidation="false" />
        </td>
    </tr>
    </table>
    </div>
    </form>
        <script language="javascript" type="text/javascript">
        load();
        function load()
        {
            document.getElementById('<%=ddlCCPaymentGateway.ClientID%>').style.width = document.getElementById('<%=txtPrimaryDNS.ClientID%>').offsetWidth;
        }
        function ToggleIpTextBox(){
            if(!document.getElementById('<%= chkStaticIP.ClientID %>').checked){
                document.getElementById('<%= spnserverip.ClientID %>').style.display='none';
                document.getElementById('<%= txtServerIP.ClientID %>').style.display='none';                
            }
            else{
                document.getElementById('<%= txtServerIP.ClientID %>').style.display='inline';
                document.getElementById('<%= spnserverip.ClientID %>').style.display='inline';                
            }
        }
        function ValidateIP(sender,args)
        {  
            var txtServerIP = document.getElementById('<%= txtServerIP.ClientID %>');      
            if(document.getElementById('<%= chkStaticIP.ClientID %>').checked)
            {       
                if(txtServerIP.value == '')
                  {  args.IsValid = false; }
                else if (validateIPAddress(txtServerIP.value) == false) 
                  { args.IsValid = false; }
                 else 
                   { args.IsValid = true;    }
            }
             else { args.IsValid = true; }
        } 
        function validateIPAddress(inputString) {
             var re = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;
             //test the input string against the regular expression
             if (re.test(inputString)) {
               //now, validate the separate parts
               var parts = inputString.split(".");
               if (parseInt(parseFloat(parts[0])) == 0) {
                 return false;
               }
               for (var i=0; i<parts.length; i++) {
                 if (parseInt(parseFloat(parts[i])) > 255) {
                   return false;
                 }
               }
               return true;
             }
             else {
               return false;
             }
            }
            
        </script>
</body>
</html>
