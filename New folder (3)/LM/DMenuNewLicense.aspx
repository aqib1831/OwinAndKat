 <%@ Page Language="VB" AutoEventWireup="false" CodeFile="DMenuNewLicense.aspx.vb" Inherits="LM_NewLicense" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="RadComboBox.Net2" Namespace="Telerik.WebControls" TagPrefix="radC" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>New License</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">

        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <table border="0" cellpadding="0" align="center" cellspacing="0" style="width: 100%; height:100%; border:0px;" class="tblAddFolder pad5px">         
         <%--<tr>
                <td style="width:45%;">                    
                    Client :<span class="RequiredField"> *</span></td>
                <td style="width:55%;">
                    <radC:RadComboBox ID="ddlClient" 
                     runat="server" Width="200px" AutoPostBack="false"  
                        DataSourceID="sdsClients" 
                        ValidationGroup="vgNewLicense" 
                        DataTextField="Name" DataValueField="ID" 
                        AllowCustomText="false"
                        MarkFirstMatch="true"   
                        Skin="WindowsXPLikeRND"
                        EnableViewState="true"> 
                    </radC:RadComboBox>
                    <asp:SqlDataSource ID="sdsClients" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                        SelectCommand="Clients_GetAll" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    <asp:RequiredFieldValidator ID="rfvClients" ValidationGroup="vgNewLicense" Display="Dynamic" CssClass="RequiredField" ErrorMessage="Required Client" runat="server" InitialValue="0" ControlToValidate="ddlClient"></asp:RequiredFieldValidator>    
                </td>
            </tr>--%>
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
                         </table> 
                        
                        <asp:CustomValidator ID="rfvStores" ValidationGroup="vgNewLicense" Display="Dynamic" CssClass="RequiredField" ClientValidationFunction="checkvalue"  ErrorMessage="Required Store" runat="server"></asp:CustomValidator>
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
                <td>Static IP:</td>
                <td style="margin:0; padding:1;">
                    <asp:CheckBox ID="chkStaticIP" Checked="true" runat="server" onclick="ToggleIpTextBox();" />                                        
                    &nbsp;<asp:TextBox ID="txtStaticIP" ValidationGroup="vgNewLicense" runat="server" Width="180px"></asp:TextBox>
                    <asp:CustomValidator ID="cvSystemIP" runat="server" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic" ErrorMessage="&nbsp;Required Static IP" ClientValidationFunction="ValidateIP"></asp:CustomValidator>
                </td>                    
            </tr>            
            <tr>
                <td >
                    Invoice #:<span class="RequiredField"> *</span></td>
                <td>
                    <asp:TextBox ID="txtInvoiceNo" runat="server" Width="200px" MaxLength="50"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvInvoice" runat="server" ControlToValidate="txtInvoiceNo" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic" ErrorMessage="Required Invoice No"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td >
                    # Of Display:<span class="RequiredField"> *</span></td>
                <td>                    
                    <asp:DropDownList ID="ddlNumberOfDisplays" style="font-size:11px;" runat="server" Width="200px">
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
            </tr> 
            <tr>
                <td >
                    Notes:</td>
                <td>
                    <asp:TextBox ID="txtNotes" runat="server" Width="200px" Rows="3" TextMode="MultiLine" style="font-size:10px;"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="revNotes" runat="server" ValidationExpression="^[\s\S]{0,490}$" 
                        ControlToValidate="txtNotes" ValidationGroup="vgNewLicense" CssClass="RequiredField" Display="Dynamic"  ErrorMessage="Max 500 char Allowed"></asp:RegularExpressionValidator>
                </td>
            </tr>            
            <tr>
                <td colspan="2" align="center">                    
                    <asp:Button ID="btnSave" runat="server" Text="Save"  CssClass="btnSilver" ValidationGroup="vgNewLicense"/>&nbsp;
                    <input id="btnCancel" type="button" value="Cancel" class="btnSilver" onClick="parent.CloseNewLicenseDiv();" />
                </td>                
            </tr>
             <tr>
                <td colspan="2">&nbsp;
                    
                </td>                
            </tr>
        </table>                          
    <script type="text/javascript" language="javascript">
        function ToggleIpTextBox(){
            if(!document.getElementById('<%= chkStaticIP.ClientID %>').checked){
                document.getElementById('<%= txtStaticIP.ClientID %>').style.display='none';
            }
            else{
                document.getElementById('<%= txtStaticIP.ClientID %>').style.display='inline';
            }
        }
        function ValidateIP(sender,args){            
            if(document.getElementById('<%= chkStaticIP.ClientID %>').checked){                
                if(document.getElementById('<%= txtStaticIP.ClientID %>').value == ''){                     
                     args.IsValid = false;                        
                 }
                 else{ args.IsValid = true;
                 }                                
            }                     
        }
        var ddlstores = <%= ddlstores.ClientID %>; 
        function checkvalue(sender,args){
            if(ddlstores.GetValue() == '0' || ddlstores.GetValue() == '')                                
               args.IsValid = false;
            else args.IsValid = true;            
            }
    </script>
    </form>
</body>
</html>
