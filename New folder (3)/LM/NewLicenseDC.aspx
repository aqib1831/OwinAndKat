<%@ Page Language="VB" AutoEventWireup="false" CodeFile="NewLicenseDC.aspx.vb" Inherits="LM_NewLicenseDC" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="RadComboBox.Net2" Namespace="Telerik.WebControls" TagPrefix="radC" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>New License</title>
    <link type="text/css" rel="stylesheet" href="../App_Themes/Default/Style.css" />
    <link type="text/css" rel="stylesheet" href="../App_Themes/Default/Calendar/style.css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
</head>
<body>
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
                   <asp:DropDownList ID="ddlProducts" style="font-size:11px;" runat="server" Width="200px">                        
                   </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="vertical-align:text-top;padding-top:5;">IP:</td>
                <td style="margin:0; padding:1;padding-left:5;">
                   <asp:RadioButtonList ID="rdoIP" runat="server" onclick="OnChangeRadio();" RepeatDirection="Horizontal" RepeatLayout="Flow" style="font-size:12px;">
                        <asp:ListItem Text="Static" Value="0" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Dynamic" Value="1"  ></asp:ListItem>
                   </asp:RadioButtonList><br />
                   <span id="spntxtStaticIP"><asp:TextBox ID="txt_StaticIP" ValidationGroup="vgNewLicense" runat="server" Width="200px"></asp:TextBox></span>
                   <span id="spntxtDynamicIP"style="display:none;"><asp:TextBox ID="txt_DynimicIP" ValidationGroup="vgNewLicense" runat="server" Width="175px" onfocus="imgDDCalander.click();"></asp:TextBox>
                   <img id="imgDDCalander" align="absMiddle"  border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txt_DynimicIP.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                    onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" />
                   </span>
                   <asp:CustomValidator ID="CV_Static" runat="server" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic" ErrorMessage="<br/>Required Static IP" ClientValidationFunction="Val_StaticIP"></asp:CustomValidator>
                   <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic" ErrorMessage="<br/>Required Dynamic IP Date" ClientValidationFunction="Val_DynamicIP"></asp:CustomValidator>
                </td>
            </tr>
            <tr>
                <td >
                    Invoice #:<span class="RequiredField"> *</span></td>
                <td>
                    <asp:TextBox ID="txtInvoiceNo" runat="server" Width="200px" MaxLength="50"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvInvoice" runat="server" ControlToValidate="txtInvoiceNo" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic" ErrorMessage="<br/>Required Invoice No"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td >
                    Training:</td>
                <td style="margin:0; padding:1;">
                    <asp:CheckBox ID="chkTrainingActive" runat="server" />
                </td>
            </tr>
            <tr>
                <td >
                    Notes:</td>
                <td>
                    <asp:TextBox ID="txtNotes" runat="server" Width="200px" Rows="3" TextMode="MultiLine" style="font-size:10px;"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="revNotes" runat="server" ValidationExpression="^[\s\S]{0,490}$" 
                        ControlToValidate="txtNotes" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic"  ErrorMessage="<br/>Max 500 char Allowed"></asp:RegularExpressionValidator>
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
    <script type="text/javascript" language="javascript">
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
            if (rdoIP0.checked)
            {
              spntxtStaticIP.style.display='inline';
              spntxtDynamicIP.style.display='none';
            }
            else
            {
              spntxtStaticIP.style.display='none';
              spntxtDynamicIP.style.display='inline';
            } 
        }    
    </script>
    </form>
</body>
</html>
