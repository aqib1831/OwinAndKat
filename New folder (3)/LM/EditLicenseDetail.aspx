<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EditLicenseDetail.aspx.vb" Inherits="LM_EditLicenseDetail" ValidateRequest="false"   %>

<head id="Head1" runat="server">
    <title>Edit nXstep License Detail</title>
    <link type="text/css" rel="stylesheet" href="../App_Themes/Default/Style.css" />
    <link type="text/css" rel="stylesheet" href="../App_Themes/Default/Calendar/style.css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
</head>
<body style="margin:0; padding:0; height:100%;">
    <form id="form1" runat="server">
    <div>
    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tblDetail" style="background-color:#F2F2F2;height:100%;">
    <tr style="height:30px; background-image:url(../images/bg_mainHdr_1.jpg);">
        <th colspan="3" align="left" class="IdeaTitle">nXstep License Detail</th>
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
           <b><asp:Literal ID="ltrlStoreNo" runat="server"></asp:Literal>&nbsp;</b></td>
        <td style="width:4%;">&nbsp;</td>
        <td style="width:15%;">Store Nick:</td>
        <td style="width:33%;">
            <b><asp:Literal ID="ltrlStoreNick" runat="server"></asp:Literal>&nbsp;</b></td>
   </tr>
   <tr>
        <td>Client:</td>
        <td>
             <b><asp:Literal ID="ltrlClientName" runat="server"></asp:Literal>&nbsp;</b></td>
        <td>&nbsp;</td>        
        <td>IP:</td>
        <td style="padding:0px;">
             <asp:RadioButtonList ID="rdoIP" runat="server" onclick="OnChangeRadio();" RepeatDirection="Horizontal" RepeatLayout="Flow" style="font-size:12px;">
                    <asp:ListItem Text="Static" Value="0" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="Dynamic" Value="1"  ></asp:ListItem>
               </asp:RadioButtonList></td>
        
    </tr>
    <tr>        
        <td>CurrentVersion:</td>
        <td>
             <b><asp:Literal ID="ltrlCurrentVersion" runat="server"></asp:Literal>&nbsp;</b></td>
        <td>&nbsp;</td>
        <td>
           <span id="spanStaticIP" >Static IP:</span>
           <span id="spanDynamicIP">Dynamic IP Date:</span>&nbsp;</td>
        <td style="padding:0px;">
           <%--<b><asp:TextBox ID="txtSystemIP" runat="server"></asp:TextBox>&nbsp;</b>
            <asp:CustomValidator ID="cvSystemIP" runat="server" ErrorMessage="Required System IP" ClientValidationFunction="ValidateIP" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic"></asp:CustomValidator>--%>
          <span id="spntxtStaticIP"><asp:TextBox ID="txt_StaticIP" ValidationGroup="vgNewLicense" runat="server" Width="100px"></asp:TextBox></span>
          <span id="spntxtDynamicIP"style="display:none;"><asp:TextBox ID="txt_DynimicIP" ValidationGroup="vgNewLicense" runat="server" Width="75px" onfocus="imgDDCalander.click();"></asp:TextBox>
                   <img id="imgDDCalander" align="absMiddle"  border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txt_DynimicIP.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                    onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" />
                   </span>
                   <asp:CustomValidator ID="CV_Static" runat="server" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic" ErrorMessage="<br/>Required Valid IP" ClientValidationFunction="Val_StaticIP"></asp:CustomValidator>
                   <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic" ErrorMessage="<br/>Required Dynamic IP Date" ClientValidationFunction="Val_DynamicIP"></asp:CustomValidator>  
        </td>               
    </tr>
    <tr>
        <td>Training Activated:</td>
        <td style="padding:0px;">
            <asp:CheckBox ID="chkTrainingActive" runat="server" /></td>
        <td>&nbsp;</td>        
        <td>Inactivate nXstep:</td>
        <td style="padding:0px;">
            <asp:CheckBox ID="chkInActivenXstep" runat="server" /></td>
    </tr>
     <tr>
        <td >Invoice #:</td>
        <td style="padding:0px;">
             <b><asp:TextBox ID="txtInvoiceNo" runat="server"></asp:TextBox>&nbsp;</b>
             <asp:RequiredFieldValidator ID="rfvInvoice" runat="server" ControlToValidate="txtInvoiceNo" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic"  ErrorMessage="Required Invoice No"></asp:RequiredFieldValidator>
        </td>
        <td>&nbsp;</td>        
        <td>App to Connect:</td>
        <td style="padding:0px;">
            <asp:DropDownList ID="ddlApptoConnect" runat="server" Width="100" Font-Size="8pt" 
                DataTextField="Name" DataValueField="ID" DataSourceID="SDS_ddlApptoConnect">
           </asp:DropDownList>&nbsp;
           <asp:SqlDataSource ID="SDS_ddlApptoConnect" 
              runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
              SelectCommand="SBS_ApplicationToConnect_GetAll" 
              SelectCommandType="StoredProcedure"
              DataSourceMode="DataReader">
           </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td>Registration Key:</td>
        <td ><b><asp:Literal ID="ltrlRegkey" runat="server"></asp:Literal>&nbsp;</b></td>
        <td>&nbsp;</td>        
        <td>Inactivate SMS:</td>
        <td style="padding:0px;">
            <asp:CheckBox ID="chkInactiveSMS" runat="server" /></td>     
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
    <tr style="height:30px; background-color:#dcdcdc;">
        <td colspan="6" style="border-top:solid 1px #609BD3; padding-right:10px;" align="right">
            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btnSilver" ValidationGroup="vgNewLicense" />
            <asp:Button ID="btnCacnel" runat="server" Text="Cancel" CssClass="btnSilver" CausesValidation="false" />
        </td>
    </tr>
    </table>
    </div>
    <script language="javascript" type="text/javascript">

       function Val_StaticIP(sender,args){            
            if(document.getElementById('rdoIP_0').checked)
            {                
                if(document.getElementById('<%= txt_StaticIP.ClientID %>').value == '')
                   args.IsValid = false;
                else if (validateIPAddress(document.getElementById('<%= txt_StaticIP.ClientID %>').value) == false) 
                  { args.IsValid = false; }
                else 
                    args.IsValid = true;
            }
            else  
                args.IsValid = true;
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
        }   
    </script>
    </form>
</body>
