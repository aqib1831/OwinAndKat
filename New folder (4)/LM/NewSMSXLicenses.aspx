<%@ Page Language="VB" AutoEventWireup="false" CodeFile="NewSMSXLicenses.aspx.vb" Inherits="LM_NewSMSXLicenses" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="RadComboBox.Net2" Namespace="Telerik.WebControls" TagPrefix="radC" %>
<%@ Register TagPrefix="radI" Namespace="Telerik.WebControls" Assembly="RadInput.Net2"%>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>New License</title>
    <link type="text/css" rel="stylesheet" href="../App_Themes/Default/Style.css" />
    <link type="text/css" rel="stylesheet" href="../App_Themes/Default/Calendar/style.css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>   
    <script language="javascript" type="text/javascript" src="../scripts/functions.js" ></script>
    <link href="../RadControls/Input/Skins/Outlook/styles.css" rel="stylesheet" type="text/css" />           
    
</head>
<body onload="SelectProductDropdownList();">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <table border="0" cellpadding="0" align="center" cellspacing="0" style="width: 100%; height:100%; border:0px;" class="tblAddFolder pad5px">                  
            <tr>
                <td>
                    Store :<span class="RequiredField"> *</span></td>
                <td>   
                        <table cellpadding="0" cellspacing="0" border="0" style="padding:0px; margin:0px; background-color:#ffffff;">
                         <tr>
                            <td style="width:20px;border-top:solid 1px #82ABC7;border-bottom:solid 1px #82ABC7;border-left:solid 1px #82ABC7; padding:0px; margin:0px;" align="center"><img src="../images/icn_search.jpg" /></td>
                            <td style="border-top:solid 1px #82ABC7;border-bottom:solid 1px #82ABC7;border-right:solid 1px #82ABC7; padding:0px; margin:0px;">
                                <radC:RadComboBox id="ddlStores" 
                                        ValidationGroup="vgNewLicense" 
                                        AutoPostBack = "true"
                                        runat="server"
                                        EnableViewState="true"  
                                        AllowCustomText="true"
                                        MarkFirstMatch="true"   
                                        Height="100"
                                        Skin="rnd" 
                                        ShowToggleImage="false"  
                                        ShowWhileLoading="true"
                                        DataValueField="StoreNumberClientID" 
                                        EnableLoadOnDemand="true"
                                        HighlightTemplatedItems="true"
                                        ItemRequestTimeout="500"
                                        Width="179px">
                                    <HeaderTemplate>
                                        <table style="width: 185px; text-align: left; font-size:10px;">
                                            <tr>
                                                <td style="width: 150px;">
                                                    Store
                                                </td>
                                                <td style="width: 35px;">
                                                    Client
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <table style="width: 185px; text-align: left;font-size:10px;">
                                            <tr>
                                                <td style="width: 150px;">
                                                    <%#DataBinder.Eval(Container.DataItem, "StoreNick")%>
                                                </td>
                                                <td style="width: 35px;">
                                                    <%#DataBinder.Eval(Container.DataItem, "ClientCode")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                            </radC:RadComboBox >
                             </td>
                            </tr>  
                         </table>
                        <asp:CustomValidator ID="rfvStores" ValidationGroup="vgNewLicense" Display="Dynamic" CssClass="RequiredField" ClientValidationFunction="checkvalue"  ErrorMessage="Required Store" runat="server"></asp:CustomValidator>
                        <asp:RegularExpressionValidator 
                            ID="revStoreHTML" 
                            runat="server" 
                            Display="dynamic"
                            CssClass="RequiredField"  
                            ControlToValidate="ddlStores" 
                            ValidationGroup="vgNewLicense" 
                            ErrorMessage="<br/>HTML not allowed." 
                            ValidationExpression="^[^<>]*$"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Product :</td>
                <td>
                   <asp:DropDownList ID="ddlProducts" style="font-size:11px;" runat="server" Width="200px" onchange="return CheckQuantityField(this);">
                        <asp:ListItem Text="SMSx bundle" Value="1"></asp:ListItem>
                        <asp:ListItem Text="SMSx additional" Value="2"></asp:ListItem>                        
                        <asp:ListItem Text="SMSx FruitExpert" Value="3"></asp:ListItem>                        
                        <asp:ListItem Text="SMSx Ordering App" Value="4"></asp:ListItem>                        
                        <asp:ListItem Text="SMSx Delivery App" Value="5"></asp:ListItem> 
                       <asp:ListItem Text="SMSx Production App" Value="6"></asp:ListItem>                                               
                   </asp:DropDownList>
                </td>
            </tr>
            <tr style="display:none;" id="trQuantity">
                <td>Quantity:</td>
                <td>                    
                    <radI:RadNumericTextBox 
                           ID="txtQuantity" 
                           runat="server"
                           Skin="Outlook"
                            Value="0"                                                                                 
                            Type="Number"
                            IncrementSettings-InterceptArrowKeys="true"  
                            IncrementSettings-InterceptMouseWheel="true"
                            IncrementSettings-Step="1"
                            NumberFormat-DecimalDigits="0"                            
                            MinValue="1" 
                            MaxValue="99"                             
                            ReadOnly="false"
                            MaxLength="2"
                            style="text-align:right"                             
                            ShowSpinButtons="true"
                            Width="203px"
                            Height="20px"                                                        
                            >
                     </radI:RadNumericTextBox>
                     <asp:CustomValidator  ID="cvQuantity" runat="server" 
                         ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic"  ErrorMessage="<br />Required Quantity" ClientValidationFunction="ValidateLicenseQuantity"></asp:CustomValidator>
                </td>
            </tr>            
            <tr>
                <td style="vertical-align:text-top;padding-top:5;">System IP:<span class="RequiredField"> *</span></td>
                <td style="margin:0; padding:1;padding-left:5;">
                   <asp:RadioButtonList ID="rdoIP" runat="server" onclick="OnChangeRadio();" RepeatDirection="Horizontal" RepeatLayout="Flow" style="font-size:12px;">
                        <asp:ListItem Text="Static" Value="0" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Dynamic" Value="1"  ></asp:ListItem>
                   </asp:RadioButtonList><br />
                   <span id="spntxtStaticIP"><asp:TextBox ID="txt_StaticIP" ValidationGroup="vgNewLicense" runat="server" Width="200px"></asp:TextBox></span>
                   <span id="spntxtDynamicIP" style="display:none;"><asp:TextBox ID="txt_DynimicIP" ValidationGroup="vgNewLicense" runat="server" Width="175px" onfocus="imgDDCalander.click();"></asp:TextBox>
                   <img id="imgDDCalander" align="absMiddle"  border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txt_DynimicIP.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                    onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" />
                   </span>
                   <asp:CustomValidator ID="CV_Static" runat="server" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic" ErrorMessage="<br/>Invalid IP" ClientValidationFunction="Val_StaticIP"></asp:CustomValidator>                   
                   <asp:CustomValidator ID="cvStaticIPValidation" runat="server" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic" ErrorMessage="<br/>Required Static IP" ClientValidationFunction="Val_CheckStaticIP"></asp:CustomValidator>
                   <asp:CustomValidator ID="cvRequiredDateIP" runat="server" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic" ErrorMessage="<br/>Required Dynamic IP Date" ClientValidationFunction="Val_DynamicIP"></asp:CustomValidator>
                   <asp:CustomValidator ID="cvValidateDynamicIPDate" runat="server" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic" ErrorMessage="<br/>Date should be greater than today" ClientValidationFunction="Val_DynamicIPDate"></asp:CustomValidator>
                </td>
            </tr>
            <tr id="trSystemIPAvailability" style="display:none;">
                <td colspan="2" align="center">
                    <span class="RequiredField">The System IP Already Exists.</span>
                </td>
            </tr>
            <tr>
                <td>
                    Invoice #:<span class="RequiredField"> *</span></td>
                <td>
                    <asp:TextBox ID="txtInvoiceNo" runat="server" Width="200px" MaxLength="50"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvInvoice" runat="server" ControlToValidate="txtInvoiceNo" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic" ErrorMessage="<br/>Required Invoice No"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revInvoiveNo" runat="server" ControlToValidate="txtInvoiceNo" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic" ErrorMessage="<br/>Invalid Invoice No" ValidationExpression="((^)[0-9]*)"></asp:RegularExpressionValidator>
                </td>
            </tr>            
            <tr>
                <td>
                    Notes:</td>
                <td>
                    <asp:TextBox ID="txtNotes" runat="server" Width="200px" Rows="3" TextMode="MultiLine" style="font-size:10px;" onblur="return GetContentLength(this);" onkeydown="return GetContentLength(this);" onkeyup="return GetContentLength(this);"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="revNotes" runat="server" ValidationExpression="^[\s\S]{0,500}$" 
                        ControlToValidate="txtNotes" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic"  ErrorMessage="<br/>Max 500 char Allowed"></asp:RegularExpressionValidator>
                        <br /><asp:Label ID="lblNotesCount" runat="server" Text="500"></asp:Label><span style="font-size:10px;font-weight:normal;">&nbsp;Character Remaining</span>
                </td>
            </tr>           
            <tr id="trBundle" style="display:none;">
                <td colspan="2" align="center">
                    <span class="RequiredField">This Store already bought the bundle</span>
                </td>
            </tr>
            <tr id="trStaticIP" style="display:none;">
                <td colspan="2" align="center">
                    <span class="RequiredField">IP Does not match with the existing record.</span>
                </td>
            </tr>
            <tr id="trStaticIPExist" style="display:none;">
                <td colspan="2" align="center">
                    <span class="RequiredField">The Static IP Exists for this record.</span>
                </td>
            </tr>
            <tr id="trDynamicIPExist" style="display:none;">
                <td colspan="2" align="center">
                    <span class="RequiredField">The Dynamic IP Exists for this record.</span>
                </td>
            </tr>            
            <tr id="trAdditionalError" style="display:none;">
                <td colspan="2" align="center">
                    <span class="RequiredField">No server keys found for this store.</span>
                </td>
            </tr>
            <tr id="trAlreadyLicense" style="display:none;">
                <td colspan="2" align="center">
                    <span class="RequiredField">This store already has an inactive license.</span>
                </td>
            </tr>            
            <tr>
                <td colspan="2" align="center">                    
                    <asp:Button ID="btnSave" runat="server" Text="Save"  CssClass="btnSilver" ValidationGroup="vgNewLicense"/>&nbsp;
                    <input id="btnCancel" type="button" value="Cancel" class="btnSilver" onClick="parent.CloseNewLicenseDiv();" />
                </td>                
            </tr>
            <tr>
                <td colspan="2">
                    &nbsp;
                </td>
            </tr>
                        
        </table>               
        <asp:HiddenField ID="hdnLicensesID" runat="server" />           
    <script type="text/javascript" language="javascript">
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
        
       function Val_DynamicIPDate(sender,args)
       {
           var value = Date.parse(trim(document.getElementById('<%= txt_DynimicIP.ClientID %>').value));              
            var date = new Date();
            date=Date.parse(date);        
            if(value < date)
            {                       
                args.IsValid = false;
            }
            
        }
        
        function ValidateLicenseQuantity(sender,args)
        {            
            if(document.getElementById('<%=ddlProducts.ClientID %>').value==2 && document.getElementById('<%=txtQuantity.ClientID %>').value=="" )
            {
               
                args.IsValid=false;           
            }
            else if(document.getElementById('<%=ddlProducts.ClientID %>').value==3 && document.getElementById('<%=txtQuantity.ClientID %>').value=="" )
            {
                args.IsValid=false;       
            }
            else
            {                
                args.IsValid=true;
            }
        
        }
        
        
        var ddlstores = <%= ddlstores.ClientID %>; 
        function checkvalue(sender,args){
            if(ddlstores.GetValue() == '0' || ddlstores.GetValue() == '')                                
                args.IsValid = false;
            else args.IsValid = true;            
        }
        function OnChangeRadio()
        {   var rdoIP0 = document.getElementById('rdoIP_0');
            var rdoIP1 = document.getElementById('rdoIP_1');
            var spntxtStaticIP = document.getElementById('spntxtStaticIP');
            var spntxtDynamicIP = document.getElementById('spntxtDynamicIP');

            var CV_Static = document.getElementById('<%=CV_Static.ClientID %>');
            var cvStaticIPValidation = document.getElementById('<%=cvStaticIPValidation.ClientID %>');
            var cvRequiredDateIP = document.getElementById('<%=cvRequiredDateIP.ClientID %>');
            var cvValidateDynamicIPDate = document.getElementById('<%=cvValidateDynamicIPDate.ClientID %>');

            if (rdoIP0.checked)
            {
                spntxtStaticIP.style.display='inline';
                spntxtDynamicIP.style.display='none';              
                cvRequiredDateIP.enabled=false;
                cvValidateDynamicIPDate.enabled= false;
                CV_Static.enabled = true;
                cvStaticIPValidation.enabled = true;
            }
            else
            {
                spntxtStaticIP.style.display='none';
                spntxtDynamicIP.style.display='inline'; 
                cvRequiredDateIP.enabled=true;
                cvValidateDynamicIPDate.enabled= true;
                CV_Static.enabled = false;
                cvStaticIPValidation.enabled = false;
            } 
        }
        function OnChangeRadios(value)
        { 
            var rdoIP0 = document.getElementById('rdoIP_0');
            var rdoIP1 = document.getElementById('rdoIP_1');
            var spntxtStaticIP = document.getElementById('spntxtStaticIP');
            var spntxtDynamicIP = document.getElementById('spntxtDynamicIP');
            
            if (value==1)
            {
                spntxtStaticIP.style.display='inline';
                spntxtDynamicIP.style.display='none';              
            }
            else
            {
                document.getElementById('imgDDCalander').style.display='none';
                spntxtStaticIP.style.display='none';
                spntxtDynamicIP.style.display='inline'; 
                document.getElementById('<%=txt_DynimicIP.ClientID %>').onfocus='';
          } 
      }
        
      function SelectProductDropdownList()
      {
          if((document.getElementById('<%=ddlProducts.ClientID %>').value==2)||(document.getElementById('<%=ddlProducts.ClientID %>').value==3) || (document.getElementById('<%=ddlProducts.ClientID %>').value==6))
            {
                trQuantity.style.display='inline';
            }
            else
            {
                trQuantity.style.display='none';
            }
        }
        
        function CheckQuantityField(dropdownList)
        {
            if((dropdownList.value == 2)||(dropdownList.value == 3)||(dropdownList.value == 4)||(dropdownList.value == 5) ||(dropdownList.value == 6))
            {                 
                trQuantity.style.display='inline';
            }
            else

            {                 
                trQuantity.style.display='none';
            }
        }  
        
        function ShowBundleError()
        {
            var rdoIP1 = document.getElementById('rdoIP_1');
            if (rdoIP1.checked){
                spntxtStaticIP.style.display='none';
                spntxtDynamicIP.style.display='inline'; 
            }
            document.getElementById('trBundle').style.display='inline';
        }
        
        function ShowSystemIPExists()
        {
            var rdoIP1 = document.getElementById('rdoIP_1');
            if (rdoIP1.checked){
                spntxtStaticIP.style.display='none';
                spntxtDynamicIP.style.display='inline'; 
            }
            document.getElementById('trSystemIPAvailability').style.display='inline';
        }
        
        function ShowStaticIpError()
        {
            var rdoIP1 = document.getElementById('rdoIP_1');
            if (rdoIP1.checked){
                spntxtStaticIP.style.display='none';
                spntxtDynamicIP.style.display='inline'; 
            }
            document.getElementById('trStaticIP').style.display='inline';
        }
        function ShowStaticIpExits()
        {
            var rdoIP1 = document.getElementById('rdoIP_1');
            if (rdoIP1.checked){
                spntxtStaticIP.style.display='none';
                spntxtDynamicIP.style.display='inline'; 
            }
            document.getElementById('trStaticIPExist').style.display='inline';
        }
        
        function DynamicIPExitsError()
        {
            var rdoIP1 = document.getElementById('rdoIP_1');
            if (rdoIP1.checked){
                spntxtStaticIP.style.display='none';
                spntxtDynamicIP.style.display='inline'; 
            }
            document.getElementById('trDynamicIPExist').style.display='inline';
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

         function CheckNoisyWord()
         {
             var mybool = true;
             var InputStr = document.getElementById('<%=ddlStores.ClientID%>').value;
       if(CheckSpecailChar(InputStr) == true) 
       {
           alert("Special characters are not Allowed.\nPlease remove them and try again.");
           document.getElementById('<%= ddlStores.ClientID %>').value = '';
         mybool = false;
         return false;
     }
     if (mybool == false)
         return false;
     else
         return true;
 }

 function showNoserverError()
 {
     var rdoIP1 = document.getElementById('rdoIP_1');
     if (rdoIP1.checked){
         spntxtStaticIP.style.display='none';
         spntxtDynamicIP.style.display='inline'; 
     }
     document.getElementById('trAdditionalError').style.display='inline';
 }
    </script>
  </form>
</body>
</html>