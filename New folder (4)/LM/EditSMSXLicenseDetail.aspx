<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EditSMSXLicenseDetail.aspx.vb" Inherits="LM_EditSMSXLicenseDetail" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Edit SMS - X Licence Details</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <link type="text/css" rel="stylesheet" href="../App_Themes/Default/Calendar/style.css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
</head>
<body style="margin:0; padding:0; height:100%;" onload="OnChangeRadio();">
    <form id="form1" runat="server">
    <asp:HiddenField ID="hdnLicienceID" runat="server" />
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tblDetail" style="background-color:#F2F2F2;height:100%;">
    <tr style="height:30px; background-image:url(../images/bg_mainHdr_1.jpg);">
        <th colspan="3" align="left" class="IdeaTitle">Edit SMSx License Details</th>
        <th colspan="2" align="right" style="padding:0px;">        
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
        <td style="width:15%;">Store #:</td>
        <td style="width:33%;">
           <b><asp:Literal ID="ltrlStoreNick" runat="server"></asp:Literal>-<asp:Literal ID="ltrlStoreNo" runat="server"></asp:Literal>&nbsp;(<asp:Literal ID="ltrlClientName" runat="server"></asp:Literal>)</b></td>
        <td style="width:4%;">&nbsp;</td>
        <td style="width:15%;">System IP:</td>
        <td style="width:33%;">
            <asp:RadioButtonList ID="rdoIP" runat="server" onclick="OnChangeRadio();" RepeatDirection="Horizontal" RepeatLayout="Flow" style="font-size:12px;">
                    <asp:ListItem Text="Static" Value="0" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="Dynamic" Value="1"  ></asp:ListItem>
               </asp:RadioButtonList>
        </td>
   </tr>
   <tr>
        <td>Invoice #</td>
        <td>
             <b><asp:Literal ID="ltrlInvoiceNo" runat="server"></asp:Literal>&nbsp;</b></td>
        <td>&nbsp;</td>        
        <td><span id="spanStaticIP" >Static IP:</span>
           <span id="spanDynamicIP">Dynamic IP Date:</span>&nbsp;</td>
        <td style="padding:0px;">
            <span id="spntxtStaticIP"><asp:TextBox ID="txt_StaticIP" ValidationGroup="vgNewLicense" runat="server" Width="100px"></asp:TextBox></span>
          <span id="spntxtDynamicIP"style="display:none;"><asp:TextBox ID="txt_DynimicIP" ValidationGroup="vgNewLicense" runat="server" Width="75px" onfocus="imgDDCalander.click();" ReadOnly="true"></asp:TextBox>
                   <img id="imgDDCalander" align="absMiddle"  border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txt_DynimicIP.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                    onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" />
                   </span>
                   <asp:CustomValidator ID="CV_Static" runat="server" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic" ErrorMessage="<br/>Required Valid IP" ClientValidationFunction="Val_CheckStaticIP"></asp:CustomValidator>
                   <asp:CustomValidator ID="CV_StaticIPValidation" runat="server" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic" ErrorMessage="<br/>Invalid IP" ClientValidationFunction="Val_StaticIP"></asp:CustomValidator>
                   <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic" ErrorMessage="<br/>Required Dynamic IP Date" ClientValidationFunction="Val_DynamicIP"></asp:CustomValidator>
                   <asp:CustomValidator ID="CV_CheckIPAvailable" runat="server" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic" ErrorMessage="<br/>IP Already Exists"></asp:CustomValidator>
                   <asp:CustomValidator ID="cvValidateDynamicIPDate" runat="server" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic" ErrorMessage="<br/>Date should be greater than today" ClientValidationFunction="Val_DynamicIPDate"></asp:CustomValidator>
        </td>
        
    </tr>
    <tr>        
        <td>Issued By:</td>
        <td>
             <b><asp:Literal ID="ltrlIssuedBy" runat="server"></asp:Literal>&nbsp;</b></td>
        <td>&nbsp;</td>
        <td>
            Last Updated:
        </td>
        <td style="padding:0px;">
           <b><asp:Literal ID="ltrlUpdatedOn" runat="server"></asp:Literal>&nbsp;</b>            
        </td>               
    </tr>
    <tr>        
        <td># of Terminals:</td>
        <td>
             <b><asp:Literal ID="ltrlTerminals" runat="server"></asp:Literal>&nbsp;</b></td>
        <td>&nbsp;</td>
        <td>
            # of Live Terminals:
        </td>
        <td style="padding:0px;">
           <b><asp:Literal ID="ltrlLiveTerminals" runat="server"></asp:Literal>&nbsp;</b>            
        </td>               
    </tr>
    <tr>
        <td>Inactivate SMSx</td>
        <td style="padding:0px;" colspan="2"><asp:CheckBox ID="chkInactive" runat="server" /><asp:CustomValidator ID="cvAlreadyExist" runat="server" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic" ErrorMessage="<br/>There is already an active license for this store" ></asp:CustomValidator></td>
        
        <td>
           &nbsp;
        </td>
        <td style="padding:0px;">
           &nbsp;
        </td> 
    </tr>
    <tr>
                <td>
                    Installation Date:</td>
                <td colspan="4" align="left" style="padding-left: 0px;
                    height: 22px;">
                    <asp:TextBox ID="txtInstallationDate" runat="server"
                        Width="75px" onfocus="img1.click();" ReadOnly="true"></asp:TextBox>
                    <img id="img1" align="absMiddle" border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtInstallationDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                        onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" />
                </td>
            </tr>
    <tr>
        <td style="border-bottom:0;" valign="top" colspan="4">Notes:
            <asp:RequiredFieldValidator ID="rfvNotes" runat="server" Enabled="false" ControlToValidate="txtNotes" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic"  ErrorMessage="Required Notes"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revNotes" runat="server" ValidationExpression="^[\s\S]{0,500}$" ControlToValidate="txtNotes" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic"  ErrorMessage="Max 500 char Allowed"></asp:RegularExpressionValidator>            
        </td>
        <td align="right" style="padding-right:7px;border-bottom:0;">
            <asp:Label ID="lblNotesCount" runat="server" Text="500"></asp:Label><span>&nbsp;Character Remaining</span>
        </td>
    </tr>
    <tr style="height:100%;">
        <td style="border-bottom:0;" valign="top" colspan="5">
            <asp:TextBox ID="txtNotes" Font-Size="11px" runat="server" TextMode="MultiLine" Rows="4" onblur="return GetContentLength(this);" onkeydown="return GetContentLength(this);" onkeyup="return GetContentLength(this);" Width="100%" Height="100%"></asp:TextBox>
        </td>        
    </tr>   
    <tr style="height:30px; background-color:#dcdcdc;">
        <td colspan="6" style="border-top:solid 1px #609BD3; padding-right:10px;" align="right">
            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btnSilver" ValidationGroup="vgNewLicense" />
            <asp:Button ID="btnCacnel" runat="server" Text="Cancel" CssClass="btnSilver" CausesValidation="false" />
        </td>
    </tr>
    </table>
    <script language="javascript" type="text/javascript">    
        function Val_StaticIP(sender,args){            
            if(document.getElementById('rdoIP_0').checked)
            {               
                if(document.getElementById('<%= txt_StaticIP.ClientID %>').value=='')
                {
                    return;
                }
                else
                {                
                    if (validateIPAddress(document.getElementById('<%= txt_StaticIP.ClientID %>').value)) 
                      {
                        args.IsValid = true; 
                       }
                    else 
                        args.IsValid = false;
                 }
            }
            
        }
        function Val_DynamicIP(sender,args)
        {
           if(document.getElementById('rdoIP_1').checked)
            { 
               if(document.getElementById('<%= txt_DynimicIP.ClientID %>').value == '')
                   args.IsValid = false;
               else 
                   args.IsValid = true;
             }
             else
                args.IsValid = true;
        }
        function OnChangeRadio()
        {   var rdoIP0 = document.getElementById('rdoIP_0');
            var rdoIP1 = document.getElementById('rdoIP_1');
            var spntxtStaticIP = document.getElementById('spntxtStaticIP');
            var spntxtDynamicIP = document.getElementById('spntxtDynamicIP');
            var spanStaticIP = document.getElementById('spanStaticIP');
            var spanDynamicIP = document.getElementById('spanDynamicIP');
            
            if (rdoIP0.checked)
            {
              spntxtStaticIP.style.display='inline';
              spanStaticIP.style.display='inline';
              spntxtDynamicIP.style.display='none';
              spanDynamicIP.style.display='none';
            }
            else
            {
              spntxtStaticIP.style.display='none';
              spanStaticIP.style.display='none';
              spntxtDynamicIP.style.display='inline';
              spanDynamicIP.style.display='inline';
            } 
            
            GetContentLength(document.getElementById('<%=txtNotes.ClientID %>'));
        } 
        
        function Val_DynamicIPDate(sender,args)
        {
           if(document.getElementById('rdoIP_1').checked)
           {
                var value = Date.parse(trim(document.getElementById('<%= txt_DynimicIP.ClientID %>').value));              
                var date = new Date();
                date=Date.parse(date);        
                if(value < date)
                {                       
                    args.IsValid = false;
                }
           
           }  
            
            
        }
        
         function Val_CheckStaticIP(sender,args)
        {
            if(document.getElementById('rdoIP_0').checked)
            {               
                if(document.getElementById('<%= txt_StaticIP.ClientID %>').value=='')
                {
                    args.IsValid=false;
                }
                else
                {
                     args.IsValid=true;
                }
            }
        }
        
         function GetContentLength(oSender){           
             var NotesCharacterCount=oSender.value.length;                              
             document.getElementById('<%=lblNotesCount.ClientId%>').innerHTML =  500 - oSender.value.length;
             if(oSender.value.length >= 500)
             {
                 document.getElementById('<%=lblNotesCount.ClientId%>').innerHTML=0;
                 if(event.keyCode==8 || event.keyCode==38 || event.keyCode==37 || event.keyCode==39 || event.keyCode==40 )
                 {                    
                    return true;
                 }
                 else
                 {                    
                    return false;   
                 }
             }
        } 

          
    </script>
    </form>
</body>
</html>