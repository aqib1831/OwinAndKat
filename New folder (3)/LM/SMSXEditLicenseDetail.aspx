<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SMSXEditLicenseDetail.aspx.vb" Inherits="LM_LicenseDetail" ValidateRequest="false" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>SMSX License Detail</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <link type="text/css" rel="stylesheet" href="../App_Themes/Default/Calendar/style.css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
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
                <td>Firewall/router:</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtFirewallRouter" runat="server" MaxLength="50"></asp:TextBox>&nbsp;</b></td>
            </tr>
            <tr>
                <td>No of Licenses:</td>
                <td> <b><asp:Label ID="txtNoLicenses" runat="server"></asp:Label>&nbsp;&nbsp;<asp:Label ID="lblNoLicenses" runat="server"></asp:Label>&nbsp;</b></td>
                <td>&nbsp;</td>        
                <td>Static IP:</td>
                <td style="padding:0;"><b><asp:CheckBox ID="chkStaticIP" runat="server" />&nbsp;</b></td>
                <td>&nbsp;</td>
               <td nowrap>Firewall/Router Login:</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtFirewallRouterLogin" runat="server" MaxLength="50"></asp:TextBox>&nbsp;</b></td>
            </tr>
            <tr>
                <td nowrap>No of Live Terminals:</td>
                <td><b><asp:Label ID="ltrlLiveTerminals" runat="server"></asp:Label>&nbsp;</b></td>
                <td>&nbsp;</td>
                <td>Server Name:</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtServerName" runat="server" MaxLength="50"></asp:TextBox>&nbsp;</b></td>
                <td>&nbsp;</td>
                <td nowrap >Firewall/Router Access:</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtFirewallRouterAccess" runat="server" MaxLength="50"></asp:TextBox >&nbsp;</b></td>
                
            </tr>
            <tr> 
               <td>Content Filtering:</td>
                <td style="padding:0;">
              
                <asp:DropDownList ID="ddlContentFiltering" runat="server" style="width:130;" Height="10" Font-Size="9"  >
                        <asp:ListItem Text="Select..." Value="0" ></asp:ListItem>
                        <asp:ListItem Text="Enabled" Value="1" ></asp:ListItem>
                        <asp:ListItem Text="Not Checked" Value="2" ></asp:ListItem>
                        <asp:ListItem Text="Refused" Value="3" ></asp:ListItem>
                    </asp:DropDownList>&nbsp;
                <asp:CompareValidator ID="CompareValidator1" runat="server" 
                        ControlToValidate="ddlContentFiltering"
                        Display="Dynamic" 
                        ErrorMessage="<br>Select Content Filtering" 
                        Operator="GreaterThan"
                        CssClass="RequiredField"
                        Type="Integer" 
                        ValueToCompare="0" />
                </td> 
                <td>&nbsp;</td>
                <td nowrap>Server Password:</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtServerPassword" runat="server" MaxLength="50"></asp:TextBox><span id="spanServerPasswordHidden" runat="server" style="display:none;">**********</span> </b>&nbsp;</td>
                <td>&nbsp;</td>
                <td >ISP/Type:</td>
                <td style="padding:0;"><b><asp:TextBox ID="txtISPType" runat="server" MaxLength="50" ></asp:TextBox>&nbsp;</b></td>
            </tr>
             <tr> 
                <td nowrap>Last IP Reported:</td>
                <td><b><asp:Label ID="ltrlLastTimeSync" runat="server"></asp:Label>&nbsp;</b></td>  
                <td>&nbsp;</td>
                <td>Updated By:</td>
                <td><b><asp:Literal ID="ltrlUpdatedBy" runat="server"></asp:Literal>&nbsp;</b></td>   
                <td>&nbsp;</td>
                <td>Updated On:</td>
                <td><b><asp:Label ID="ltrlUpdateOn" runat="server"></asp:Label>&nbsp;</b></td>  
            </tr>
            <tr>
                <td>Installation Date:</td>
                <td align="left" style="padding-left:0px; height:22px;">
                <asp:TextBox ID="txtInstallationDate"  runat="server" Width="103" onfocus="imgDDCalander.click();" ReadOnly="true"></asp:TextBox>
                   <img id="imgDDCalander" align="absMiddle"  border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtInstallationDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                    onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" />
                </td>  
                <td>&nbsp;</td>
                <td nowrap>SMTP Port:</td>
                <td style="padding:0;">
                    <asp:DropDownList ID="ddlSMTPPort" runat="server" style="width:100px;" Font-Size="9">
                        <asp:ListItem Text="Select..." Value="0" ></asp:ListItem>
                        <asp:ListItem Text="25" Value="25" ></asp:ListItem>
                        <asp:ListItem Text="587" Value="587" ></asp:ListItem>                        
                    </asp:DropDownList>&nbsp;
                    <asp:CompareValidator ID="cvSMTPPort" runat="server"
                        ControlToValidate="ddlSMTPPort"
                        Display="Dynamic"
                        ErrorMessage="Select SMTP Port"
                        Operator="GreaterThan"
                        CssClass="RequiredField"
                        Type="Integer"
                        ValueToCompare="0" />
                </td>  
                <td>
                    &nbsp;
                </td>
                <td>
                    OS Version:
                </td>  
                <td style="padding:0px;">
                    <asp:DropDownList ID="ddlOSVersions" runat="server" DataSourceID="sdsOSVersions" DataTextField="Name" DataValueField="ID" Font-Size="9" />
                    <br /><asp:CompareValidator ID="cmpvOSVErsion" runat="server" ValueToCompare="0" Operator="NotEqual" Type="Integer" ControlToValidate="ddlOSVersions" Display="Dynamic" ErrorMessage="Please select OS Version" />
                    <asp:SqlDataSource ID="sdsOSVersions" runat="server" ConnectionString="<%$ConnectionStrings:PortalConnectionString %>" SelectCommand="NS_Products_Franchises_OSVersion_GetAllForList">
                    </asp:SqlDataSource>
                </td>  
            </tr>
            <tr>
                <td colspan="10" >Notes :<asp:RegularExpressionValidator ID="revNotes" runat="server" ValidationExpression="^[\s\S]{0,1000}$" ControlToValidate="txtNotes" CssClass="RequiredField" Display="Dynamic"  ErrorMessage="Max 1000 char Allowed"></asp:RegularExpressionValidator></td>
            </tr>
            <tr> 
                <td colspan="10" rowspan="6" style="border-bottom:0;padding:0px;" valign="top">
                     <asp:TextBox ID="txtNotes" Font-Size="11px" runat="server" TextMode="MultiLine" Width="100%" Height="180"></asp:TextBox>
                </td>
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
        //load();
        
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