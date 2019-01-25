<%@ Page Language="VB" AutoEventWireup="false" CodeFile="DMenuEditLicenseDetail_VitalInfo.aspx.vb" Inherits="DMenu_EditLicenseDetail_VitalInfo" ValidateRequest="false" %>

<head id="Head1" runat="server">
    <title>Edit DMenu License Detail</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
</head>
<body style="margin:0; padding:0; height:100%;">
    <form id="form1" runat="server">
    <div>
    <table border="0" cellpadding="0" cellspacing="0" width="400px" class="tblDetail" style="background-color:#F2F2F2;height:200px;">
    <tr style="height:30px; background-image:url(../images/bg_mainHdr_1.jpg);">
        <th align="left" class="IdeaTitle" colspan="2">DMenu License Detail</th>
    </tr> 
    <tr>
        <td style="width:80px;">Store #:</td>
        <td style="width:320px;">
           <b><asp:Literal ID="ltrlStoreNo" runat="server"></asp:Literal>&nbsp;</b></td>
       
        
   </tr>
   <tr>
         
        <td>Static IP:</td>
        <td style="padding:0px;">
             <asp:CheckBox ID="chkStaticIP" runat="server" onclick="ToggleIpTextBox();" /></td>
        
    </tr>
    <tr>        
        <td>
           <span id="spanStaticIP" runat="server">Static IP:</span>&nbsp;</td>
        <td style="padding:0px;">
           <b><asp:TextBox ID="txtSystemIP" runat="server"></asp:TextBox>&nbsp;</b>
            <asp:CustomValidator ID="cvSystemIP" runat="server" ErrorMessage="Required System IP" ClientValidationFunction="ValidateIP" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic"></asp:CustomValidator>
        </td>               
    </tr>
  <%--
    
    <tr>
        <td>Number Of Displays:</td>
        <td style="padding:0px;">
            <asp:DropDownList ID="ddlNumberOfDisplays" style="font-size:11px;" runat="server" Width="130px">
                    <asp:ListItem Value="0">Choose...</asp:ListItem>
                    <asp:ListItem Value="1" Text="1"></asp:ListItem>
                    <asp:ListItem Value="2" Text="2"></asp:ListItem>
                    <asp:ListItem Value="3" Text="3"></asp:ListItem>
                    <asp:ListItem Value="4" Text="4"></asp:ListItem>
                    <asp:ListItem Value="5" Text="5"></asp:ListItem>
                    <asp:ListItem Value="6" Text="6"></asp:ListItem>
                    <asp:ListItem Value="7" Text="7"></asp:ListItem>
                    <asp:ListItem Value="8" Text="8"></asp:ListItem>
                    <asp:ListItem Value="9" Text="9"></asp:ListItem>
                    <asp:ListItem Value="10" Text="10"></asp:ListItem>
                   </asp:DropDownList>
                   <asp:CompareValidator 
                            ID="cvNumberOfDays" 
                            runat="server" 
                            ControlToValidate="ddlNumberOfDisplays"
                            ValueToCompare="0" 
                            Operator="GreaterThan" 
                            ErrorMessage="Please Choose" 
                            Display="Dynamic" 
                            ValidationGroup="vgNewLicense"  CssClass="RequiredField"></asp:CompareValidator>
        </td>
        <td>&nbsp;</td>
        <td>Inactivate DMenu:</td>
        <td style="padding:0px;">
            <asp:CheckBox ID="chkInActivenXstep" runat="server" /></td>
    </tr>
     <tr>
        <td >Invoice #:</td>
        <td colspan="4" style="padding:0px;">
             <asp:TextBox ID="txtInvoiceNo" runat="server"></asp:TextBox>&nbsp;
             <asp:RequiredFieldValidator ID="rfvInvoice" runat="server" ControlToValidate="txtInvoiceNo" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic"  ErrorMessage="Required Invoice No"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td>Registration Key:</td>
        <td colspan="4">
             <b><asp:Literal ID="ltrlRegkey" runat="server"></asp:Literal>&nbsp;</b></td>
    </tr>    
    <tr>        
        <td>Last Time Sync:</td>
        <td colspan="4">
             <b><asp:Literal ID="ltrlLastTimeSync" runat="server"></asp:Literal>&nbsp;</b></td>
    </tr>
    <tr>
        <td style="border-bottom:0;" valign="top" colspan="5">Notes:
            <asp:RequiredFieldValidator ID="rfvNotes" runat="server" Enabled="false" ControlToValidate="txtNotes" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic"  ErrorMessage="Required Notes"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revNotes" runat="server" ValidationExpression="^[\s\S]{0,1000}$" ControlToValidate="txtNotes" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic"  ErrorMessage="Max 1000 char Allowed"></asp:RegularExpressionValidator>
        </td>        
    </tr>
    <tr style="height:100%;">
        <td style="border-bottom:0;" valign="top" colspan="5">
            <asp:TextBox ID="txtNotes" Font-Size="11px" runat="server" TextMode="MultiLine" Width="100%" Height="100%"></asp:TextBox>
        </td>        
    </tr>
--%>
    
    <tr style="height:30px; background-color:#dcdcdc;">
        <td colspan="2" style="border-top:solid 1px #609BD3; padding-right:10px;" align="center">
            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btnSilver" ValidationGroup="vgNewLicense" />
            <asp:Button ID="btnCacnel" runat="server" Text="Cancel" CssClass="btnSilver" CausesValidation="false" />
        </td>
    </tr>
    </table>
    </div>
    <script language="javascript" type="text/javascript">
    function ToggleIpTextBox(){
            if(!document.getElementById('<%= chkStaticIP.ClientID %>').checked){
                document.getElementById('<%= spanStaticIP.ClientID %>').style.display='none';
                document.getElementById('<%= txtSystemIP.ClientID %>').style.display='none';                
            }
            else{
                document.getElementById('<%= txtSystemIP.ClientID %>').style.display='inline';
                document.getElementById('<%= spanStaticIP.ClientID %>').style.display='inline';                
            }
        }
        function ValidateIP(sender,args)
        {  
            var txtServerIP = document.getElementById('<%= txtSystemIP.ClientID %>');      
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
    </form>
</body>
