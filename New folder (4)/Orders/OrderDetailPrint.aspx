<%@ Page Language="VB" AutoEventWireup="false" CodeFile="OrderDetailPrint.aspx.vb" Inherits="OrderDetailPrint" Theme="Default" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Invoice</title>
    
<style>
@media print
{
	.hideShowRow{ display:none;}
	.RowForPrint{display:inline;}
}	
@media screen
{
    .hideShowRow{ display:inline;}
    .RowForPrint{display:none;}
}
</style>
    
</head>
<body style="margin:0px; width:100%; height:100%; background-color: #FFFFFF; padding:0px;" scroll="no" >
    <form id="form1" runat="server">
        <table border="0" cellpadding="0" cellspacing="0" style="width:100%; height:100%; margin:0px;padding:0px;">
          <tr>
          <td>
          <div style="width:100%; height:100%; overflow:auto;  background-color:#FFFFFF;border:1px solid #ACBDD5; text-align:center;" >
           <table width="100%" border="0" cellspacing="0" style="height:100%; width:100%; font-family: Arial; padding:0px; margin:0px;" cellpadding="0">
                <tr>
                    <td style="width: 100px;" align="left">
                        <img src="../images/spacer.gif" alt="spacer" width="10" height="3" />
                    </td>
                    <td style="" align="left" class="verLine_ltGrey">
                        <img src="../images/spacer.gif" alt="spacer" width="322" height="3" />
                    </td>
                    <td style="width: 100px;" align="left" class="verLine_ltGrey">
                        <img src="../images/spacer.gif" alt="spacer" width="20" height="3" />
                    </td>
                </tr>
                <tr>
                    <td align="right" valign="top" style="padding-right: 5px; width: 100px;">
                        <img src="../images/spacer.gif" alt="spacer" width="10" height="0" />
                        <asp:HiddenField ID="hdnID" runat="server" Value="0" />
                        <asp:HiddenField ID="hdnSerial" runat="server" Value='0' />
                    </td>
                    <td align="center" valign="top">
                        <table width="670" border="0" style="border:solid 1px #CCCCCC;" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>                                            
                                            <td align="left" valign="top" >
                                                <table border="0" style="width: 100%;margin:0px;" cellpadding="0" cellspacing="0">
                                                    <tr valign="top" style="padding:0px;">
                                                        <td style="padding:5px;"><img src="../images/logo_netsolace_grey.jpg" height="59px" width="270px"  /></td>
                                                        <td style="height: 80px; width: 48%;margin:0px;">
                                                            <asp:FormView runat="server" Style="font-size: 8pt; font-family: Arial,Helvetica, sans-serif;" ID="FormView2" Width="100%" Height="100%" DataSourceID="SdSProducts" CellPadding="0" CellSpacing="0">
                                                                <ItemTemplate>
                                                                        <tr bgcolor="#E0E0E0" >
                                                                            <td style="font-size: 8pt; font-family: Arial,Helvetica, sans-serif; height: 25px; padding:0px;" align="center">
                                                                                    <strong>Order Date </strong>
                                                                            </td>
                                                                            <td style="font-size: 8pt; font-family: Arial,Helvetica, sans-serif; height: 25px; padding:0px;" align="center">
                                                                                    <strong>Order Number </strong>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="SimpleSmall" style="border: solid 1px #E0E0E0">
                                                                                <div align="center">
                                                                                    <%#Functions.ToLongDate(Eval("orderDate"), "")%>
                                                                                </div>
                                                                            </td>
                                                                            <td class="SimpleSmall" style="border: solid 1px #E0E0E0">
                                                                                <div align="center">
                                                                                    <strong>
                                                                                        <%#Eval("ID")%>
                                                                                    </strong>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                </ItemTemplate>
                                                                <%--<FooterTemplate>
                                                                </table>
                                                                </FooterTemplate>--%>
                                                            </asp:FormView>
                                                        </td>
                                                    </tr>
                                                </table>
                                                </td>
                                        </tr>
                                        <tr>
                                            <td align="left" valign="top">
                                                <table cellpadding="0" cellspacing="0" style="width: 100%">
                                                    <tr>
                                                        <td style="width: 48%;" valign="top">
                                                            <table style="font-size: 8pt; font-family: Arial,Helvetica, sans-serif; width: 100%;height:100%;border:solid 1px  #E0E0E0;
                                                                padding-left: 15px;"  cellpadding="0" cellspacing="0">
                                                                <tr bgcolor="#E0E0E0"">
                                                                    <td colspan="2" style="font-size: 8pt; font-weight: bold; font-family: Arial, Helvetica, sans-serif;height: 15px;">
                                                                        &nbsp;Bill to
                                                                    </td>
                                                                </tr>
                                                                <tr >
                                                                    <td style="width: 6px;height: 20px;padding-top:5px;display:none;" valign="top">
                                                                        </td>
                                                                    <td width="288" class="SimpleSmall" style="height: 20px;padding-top:5px;">
                                                                        1952 Whitney Avenue
                                                                    </td>
                                                                </tr>
                                                                <tr >
                                                                    <td style="width: 6px;height: 20px;padding-top:5px;display:none;" valign="top">
                                                                        </td>
                                                                    <td width="288" class="SimpleSmall" style="height: 20px;padding-top:5px;">
                                                                        Hamden, CT 06517
                                                                    </td>
                                                                </tr>
                                                                <tr >
                                                                    <td style="width: 6px;height: 20px;padding-top:5px;display:none;" valign="top">
                                                                        </td>
                                                                    <td width="288" class="SimpleSmall" style="height: 20px;padding-top:5px;">
                                                                        United States
                                                                    </td>
                                                                </tr>
                                                              
                                                                <tr >
                                                                    <td style="width: 6px; height: 20px;display:none;">
                                                                       
                                                                    </td>
                                                                    <td class="SimpleSmall" width="288" style="height: 20px;">
                                                                        <!--+1-203-907-4601-->
                                                                        +1-203-907-2800</td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 6px; height: 20px;display:none;">
                                                                        
                                                                    </td>
                                                                    <td style="height: 20px;">
                                                                        <!--+1-203-907-4601-->
                                                                        support@netsolace.com</td>
                                                                </tr>
                                                                <tr>
                                                                    <td  style="width: 6px;">
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 48%; border: solid 1px #E0E0E0; height: 100%;" valign="top">
                                                            <asp:FormView Style="font-size: 8pt; font-family: Arial,Helvetica, sans-serif; padding-left: 15px;"
                                                                ID="FormView1" runat="server" CellPadding="0" DataSourceID="SdSProducts" Width="100%">
                                                                <HeaderTemplate>
                                                                    <tr bgcolor="#E0E0E0" bordercolor="#E0E0E0">
                                                                        <td colspan="2" class="SimpleBold" style="font-size: 8pt; font-weight: bold; font-family: Arial, Helvetica, sans-serif;
                                                                            height: 15px;">
                                                                            Ship to
                                                                        </td>
                                                                    </tr>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                     <tr>
                                                                        <td colspan="2" style="font-size: 8pt; font-family: Arial,Helvetica, sans-serif;height: 20px;" nowrap="nowrap">                                                                         
                                                                        
                                                                            <%#Eval("StoreNick")%>-<%#Eval("StoreNumber")%> (<%#Eval("clientName")%>)
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td  colspan="2" style="font-size: 8pt; font-family: Arial,Helvetica, sans-serif;
                                                                            height: 20px; vertical-align:top;"nowrap="nowrap">
                                                                       
                                                                            <%#Eval("Address")%>
                                                                            <br />
                                                                            <%#Eval("City")%>, <%#Eval("StateCode")%> - <%#Eval("Zip")%>
                                                                             <br />
                                                                            <%#Eval("CountryName")%>
                                                                        </td>
                                                                    </tr>
                                                                   <%-- <tr>
                                                                        <td  colspan="2" style="font-size: 8pt; font-family: Arial,Helvetica, sans-serif; height: 20px;">
                                                                        
                                                                           
                                                                        </td>
                                                                    </tr>--%>
                                                                    <tr>
                                                                        <td  colspan="2" style="font-size: 8pt; font-family: Arial,Helvetica, sans-serif; height: 20px;">
                                                                         
                                                                            <%#Eval("Phone")%>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td  colspan="2" style="font-size: 8pt; font-family: Arial,Helvetica, sans-serif; height: 20px;">
                                                                         
                                                                            <%#Eval("Email")%>
                                                                        </td>
                                                                    </tr>
                                                                </ItemTemplate>
                                                            </asp:FormView>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" valign="top">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="height: 100%;">
                                                    <tr>
                                                        <td width="100%">
                                                            <table cellpadding="0" cellspacing="0" style="height: 100%; width: 100%;">
                                                                <tr>
                                                                    <td colspan="1" style="height: 2px">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td colspan="2" style="height: 2px;">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="3" style="height: 70px; text-align: center;">
                                                                        <asp:Repeater ID="RptmainProducts" runat="server" EnableViewState="true" DataSourceID="SdsItmes">
                                                                            <HeaderTemplate>
                                                                                <div style="height: 100%; width: 100%;">
                                                                                    <table style="height: 100%; width: 100%; font-size: 11px;" cellpadding="0" cellspacing="0"
                                                                                        border="0">
                                                                                        <tr>
                                                                                            <td class="txtBld_green" style="font-size: 12px; height: 25px; 
                                                                                                background-color: #E0E0E0; font-weight: bold;
                                                                                                padding-left: 10px;">&nbsp;
                                                                                            </td>
                                                                                            <td colspan="2" class="txtBld_green" style="font-size: 12px; height: 25px; background-color: #E0E0E0;
                                                                                                font-weight: bold">
                                                                                                Products</td>
                                                                                            <td class="subHdng_cyan" style="font-size: 12px; text-align: center; border-bottom: 1px solid #E0E0E0;
                                                                                                border-top: 1px solid #E0E0E0; background-color: #E0E0E0; font-weight: bold;
                                                                                                width: 15%;">
                                                                                                Qty
                                                                                            </td>
                                                                                            <td class="subHdng_cyan" style="font-size: 12px; text-align: center; background-color: #E0E0E0;
                                                                                                font-weight: bold; width: 15%;">
                                                                                                Unit Price
                                                                                            </td>
                                                                                            <td class="subHdng_cyan" style="font-size: 12px; text-align: left; background-color: #E0E0E0;
                                                                                                font-weight: bold; width: 10%;">
                                                                                                Total Price
                                                                                            </td>
                                                                                        </tr>
                                                                            </HeaderTemplate>
                                                                            <ItemTemplate>
                                                                                <tr>
                                                                                    <td background="../images/horLine_dtd_body.jpg" style="height: 2px;"
                                                                                        colspan="6">
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="padding: 0px; height: 25px; padding-left: 10px;">
                                                                                        <strong>
                                                                                            <img src="../images/arrows.gif" /> 
                                                                                        </strong>
                                                                                        <asp:Label ID="Label1" runat="Server" Visible="false" Text='<%#Eval("ID")%>'></asp:Label>
                                                                                    </td>
                                                                                    <td colspan="2" style="padding: 0px; height: 25px;">
                                                                                        <strong>
                                                                                            <%#Eval("Title")%>
                                                                                        </strong>
                                                                                        <asp:Label ID="lblID" runat="Server" Visible="false" Text='<%#Eval("ID")%>'></asp:Label>
                                                                                    </td>
                                                                                    <td class="GreyText" style="vertical-align: top; text-align: center; width: 15%;
                                                                                        vertical-align: middle; padding: 0px;" nowrap="nowrap">
                                                                                        <asp:Label ID="lblQty" runat="Server" Visible="true" Text='<%#Eval("Quantity")%>'></asp:Label>
                                                                                    </td>
                                                                                    <td class="GreyText" style="vertical-align: top; text-align: center; width: 15%;
                                                                                        vertical-align: middle; height: 25px; padding: 0px;" nowrap="nowrap">
                                                                                        $<asp:Label ID="lblPrice" runat="Server" Text='<%# math.round(CType(Eval("UnitPrice"), Decimal), 0)%>'></asp:Label>
                                                                                        <asp:HiddenField ID="hdnPrice" runat="Server" Value='<%# math.round(CType(Eval("UnitPrice"), Decimal), 0)%>'>
                                                                                        </asp:HiddenField>
                                                                                    </td>
                                                                                    <td class="GreyText" style="vertical-align: top; text-align: right; width: 10%;
                                                                                        vertical-align: middle; height: 25px; padding-right: 25px;" nowrap="nowrap">
                                                                                        $<asp:Label ID="lblAmount" runat="Server" Text='<%# math.round(CType(Eval("TotalPrice"), Decimal), 2)%>'></asp:Label>
                                                                                        <asp:HiddenField ID="hdnAmount" runat="Server" Value='<%# math.round(CType(Eval("TotalPrice"), Decimal), 2)%>'>
                                                                                        </asp:HiddenField>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                        <td style="padding: 0px; height: 20px; padding-left: 50px;"
                                                                                            colspan="3">
                                                                                            <span style="font-size: 11px;">Monthly subscription <span style="color: Red;">*</span>
                                                                                                <span style=" font-size:10px;display:<%#IIf(Container.DataItem("WaivedMonths")<>0, "inline", "none")%>">(Waived for the first <%#Eval("WaivedMonths")%> months)</span>
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td class="GreyText" style="vertical-align: middle; text-align: center; vertical-align: middle;
                                                                                            padding: 0px; padding-top: 5px; padding-right: 0px; "nowrap="nowrap" >
                                                                                            
                                                                                            $<asp:Label ID="lblMonthlyTotal" runat="Server" Visible="true" Text='<%# math.round(CType(Eval("MonthlySupportPrice"), Decimal), 0)%>'></asp:Label>
                                                                                            
                                                                                            <asp:HiddenField ID="hdnMonthlyTotal" runat="Server" Value='<%# math.round(CType(Eval("MonthlySupportPrice"), Decimal), 0)%>'>
                                                                                            </asp:HiddenField>
                                                                                        </td>
                                                                                        <td class="GreyText" style="vertical-align: middle; text-align: right; vertical-align: middle;
                                                                                            padding: 0px; padding-top: 5px; padding-right: 25px; "nowrap="nowrap" >
                                                                                            
                                                                                            $<asp:Label ID="Label2" runat="Server" Visible="true" Text='<%# math.round(CType(Eval("MonthlySupportPrice"), Decimal), 2) * Eval("Quantity")%>'></asp:Label>
                                                                                        </td>
                                                                                    </tr>
                                                                                <tr>
                                                                                    <td colspan="6">
                                                                                        <asp:Repeater ID="rpSubModules" runat="server">
                                                                                            <HeaderTemplate>
                                                                                                <table style="width: 100%; height: 100%;">
                                                                                            </HeaderTemplate>
                                                                                            <ItemTemplate>
                                                                                                <tr>
                                                                                                    <td style="padding-left: 15px; text-align: right;">
                                                                                                        <img src="../images/arrows.gif" />
                                                                                                    </td>
                                                                                                    <td style="text-align: left; padding-left: 5px; font-size: 12px;">
                                                                                                        <%#Eval("Title")%>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </ItemTemplate>
                                                                                            <FooterTemplate>
                                                                                                </table>
                                                                                            </FooterTemplate>
                                                                                        </asp:Repeater>
                                                                                    </td>
                                                                                </tr>
                                                                            </ItemTemplate>
                                                                            <FooterTemplate>
                                                                                    <tr>
                                                                                        <td background="../images/horLine_dtd_body.jpg" style="height: 2px;"
                                                                                            colspan="6">
                                                                                        </td>
                                                                                    </tr>                                                                               
                                                                                     <tr id="trTotalRow">
                                                                                        <td colspan="3" style="padding-left: 15px; text-align: right; font-size: 13px; 
                                                                                            height: 15px;">
                                                                                        </td>
                                                                                        <td style="text-align: right; padding-right: 5px; font-size: 11px;">
                                                                                            Total:
                                                                                        </td>
                                                                                        <td style=" font-size: 13px">                                                                                            
                                                                                        </td>
                                                                                        <td style="font-weight: bold; text-align: right; font-weight: bold; padding-right: 25px;
                                                                                            font-size: 12px;font-weight:bold;">
                                                                                            $<asp:Label ID="lblProductTotal" runat="server" Text="0.0"></asp:Label>
                                                                                            <asp:HiddenField ID="HdnProductTotal" runat="server" Value="0"></asp:HiddenField>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr id="trTaxRow">
                                                                                        <td  colspan="3" style="padding-left: 15px; text-align: right; font-size: 12px;
                                                                                            height: 15px;">
                                                                                        </td>
                                                                                        <td style="text-align: right; padding-right: 5px; font-size: 11px"
                                                                                            nowrap="nowrap">
                                                                                            Tax Amount:
                                                                                        </td>
                                                                                        <td style="font-size: 12px">
                                                                                        </td>
                                                                                        <td style="font-weight: bold; text-align: right; font-weight: bold; padding-right: 25px;
                                                                                             font-size: 12px">
                                                                                            +&nbsp;$<asp:Label ID="lblTax" runat="server" Text="0.0"></asp:Label>
                                                                                            <asp:HiddenField ID="hdnTaxAmount" runat="server" Value="0"></asp:HiddenField>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td colspan="3" style="padding-left: 15px; text-align: right; font-size: 15px;
                                                                                            height: 25px;">
                                                                                        </td>
                                                                                        <td class="txtBld_green" style="text-align: right; padding-right: 5px;  font-weight:bold;
                                                                                            font-size: 12px">
                                                                                            Grand Total:
                                                                                        </td>
                                                                                        <td style="font-size: 12px;border-bottom:solid 1px black;  border-top:solid 1px black;">
                                                                                        &nbsp;
                                                                                        </td>
                                                                                        <td style="font-weight: bold; text-align: right; font-weight: bold; padding-right: 25px;
                                                                                           font-size: 13px; border-bottom:solid 1px black;  border-top:solid 1px black; ">
                                                                                            $<asp:Label ID="lblGrandTotal" runat="server" Text="0.0"></asp:Label>
                                                                                            <asp:HiddenField ID="hdnGrandTotal" runat="server" Value="0"></asp:HiddenField>
                                                                                        </td>
                                                                                    </tr>
                                                                                </tr>
                                                                                
                                                                                </table>
                                                                            </FooterTemplate>
                                                                        </asp:Repeater>
                                                                        <asp:SqlDataSource ID="SDsSokcetModules" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                            SelectCommand="NS_GetProposalRequestByID" SelectCommandType="StoredProcedure">
                                                                            <SelectParameters>
                                                                                <asp:ControlParameter ControlID="hdnID" Name="ID" Type="int32" PropertyName="Value"
                                                                                    DefaultValue="0" />
                                                                            </SelectParameters>
                                                                        </asp:SqlDataSource>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td >
                                    <img src="../images/spacer.gif" height="10" alt="" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table style="width: 100%;" cellpadding="0" cellspacing="0" >
                                        <tr>
                                            <td colspan="2">
                                            <table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td style="font-size: 8pt; font-weight: bold; font-family: Arial, Helvetica, sans-serif;
                                                                background-color: #E0E0E0; height: 20px;padding-left:15px;">
                                                                Payment Information&nbsp;
                                                                <span class="hideShowRow">
                                                                <input id="txtSecurityCode" style="FONT-SIZE: 6pt; WIDTH: 60px; HEIGHT: 15px;" type="password" maxlength="50" runat="server" class="DoNotPrint" onKeyPress="if(event.keyCode == 13) { document.getElementById('btnAuthenticate').click(); return false;}">&nbsp;
                                                                <asp:LinkButton ID="btnAuthenticate" Runat="server" Font-Size="7" Font-Name="Verdana" OnClick="btnAuthenticate_Click"></asp:LinkButton>&nbsp;&nbsp;
                                                                <asp:Label id="lblNotValidSecurityCode" runat="server" CssClass="SimpleRedSmall"></asp:Label>
                                                                <asp:RequiredFieldValidator 
                                                                ID="RF_SecurityCode" 
                                                                runat="server" 
                                                                ControlToValidate="txtSecurityCode" 
                                                                Display="dynamic" 
                                                                ErrorMessage="Please enter security code">
                                                                </asp:RequiredFieldValidator>
                                                                
                                                                <asp:CompareValidator 
                                                                    ID="CV_SecurityCode" 
                                                                    runat="server" 
                                                                    ControlToValidate="txtSecurityCode"
                                                                    Display="Dynamic" 
                                                                    ErrorMessage="Please enter valid security code" 
                                                                    Operator="DataTypeCheck"
                                                                    SkinID="CompareValidation" 
                                                                    Type="Integer" 
                                                                    >
                                                                 </asp:CompareValidator>
                                                                 </span>   
                                                            </td>
                                                        </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                
                                                <asp:FormView runat="server" BorderColor="#E0E0E0" BorderWidth="2px" Style="font-size: 8pt; border-collapse:collapse;
                                                    font-family: Arial,Helvetica, sans-serif;" ID="FormView4" Width="100%" Height="100%"
                                                    DataSourceID="SdSProducts" CellPadding="0">
                                                    <HeaderTemplate>
                                                        
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <table style="display: <%#IIf( CInt(Container.DataItem("PaymentType")) = 1, "block", "none")%>;width:80%; border-collapse:collapse; ">
                                                            <tr>
                                                                <td style="font-size: 8pt; font-family: Arial, Helvetica, sans-serif; height: 20px;padding-left:15px;">
                                                                    <span style="font-weight: bold;">Method:</span>
                                                                    <%#IIf(CInt(Container.DataItem("PaymentType")) = 1, "Credit Card ", "Bank Account Direct Debit/ACH:")%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 8pt; font-family: Arial, Helvetica, sans-serif; height: 20px;padding-left:15px;">
                                                                    <span style="font-weight: bold;">CCType:</span>
                                                                    <%#Functions.GetCCType(Functions.IfNull(Container.DataItem("CCType"), 0))%>
                                                                </td>
                                                            </tr>
                                                            <tr class="hideShowRow">
                                                                <td style="font-size: 8pt; font-family: Arial, Helvetica, sans-serif; height: 20px;padding-left:15px;">
                                                                    <span style="font-weight: bold;">CC #:</span> &nbsp;&nbsp; 
                                                                    <asp:literal id="litCCNo" runat="server" Text='<%# "XXXX-" & Right(Functions.Decryption(Functions.IfNull(Container.DataItem("CCNumber"), "")), 4)%>'></asp:literal>
                                                                    
                                                                    
                                                                </td>
                                                            </tr>
                                                            <tr class="RowForPrint">
                                                                <td style="font-size: 8pt; font-family: Arial, Helvetica, sans-serif; height: 20px;padding-left:15px;">
                                                                    <span style="font-weight: bold;">CC #:</span> &nbsp;&nbsp; 
                                                                    <asp:literal id="Literal1" runat="server" Text='<%# "XXXX-" & Right(Functions.Decryption(Functions.IfNull(Container.DataItem("CCNumber"), "")), 4)%>'></asp:literal>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 8pt; font-family: Arial, Helvetica, sans-serif; height: 20px;padding-left:15px;">
                                                                    <span style="font-weight: bold;">Name on Card:</span> &nbsp;&nbsp;<%#Functions.IfNull(Container.DataItem("CCName"), "")%>
                                                                </td>
                                                            </tr>
                                                             <tr class="hideShowRow">
                                                                <td style="font-size: 8pt; font-family: Arial, Helvetica, sans-serif; height: 20px;padding-left:15px;">
                                                                    <span style="font-weight: bold;">Exp. Date</span> &nbsp;&nbsp;
                                                                    <asp:literal id="ltrlExpDate" runat="server" Text="xx / xxxx"></asp:literal>
                                                                    
                                                                </td>
                                                            </tr>
                                                            <tr class="RowForPrint">
                                                                <td style="font-size: 8pt; font-family: Arial, Helvetica, sans-serif; height: 20px;padding-left:15px;">
                                                                    <span style="font-weight: bold;">Exp. Date</span> &nbsp;&nbsp;
                                                                    <asp:literal id="Literal3" runat="server" Text="xx / xxxx"></asp:literal>
                                                                    
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <table style="display: <%#IIf(CInt(Container.DataItem("PaymentType")) = 1, "none", "block")%>; border-collapse:collapse;">
                                                            <tr>
                                                                <td style="font-size: 8pt; font-family: Arial, Helvetica, sans-serif; height: 20px;padding-left:15px;">
                                                                    <span style="font-weight: bold;">Method:</span>
                                                                    <%#IIf(CInt(Container.DataItem("PaymentType")) = 1, "Credit Card ", "Bank Account Direct Debit/ACH:")%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 8pt; font-family: Arial, Helvetica, sans-serif; height: 20px;padding-left:15px;">
                                                                    <span style="font-weight: bold;">Bank Name:</span>
                                                                    <%#Functions.IfNull(Container.DataItem("BankName"), "")%>
                                                                </td>
                                                            </tr>
                                                             <tr class="hideShowRow">
                                                                <td style="font-size: 8pt; font-family: Arial, Helvetica, sans-serif; height: 20px;padding-left:15px;">
                                                                    <span style="font-weight: bold;">Bank Account #:</span> &nbsp;&nbsp; 
                                                                    <asp:literal id="ltrlAccNo" runat="server" Text='<%# "XXXX -" & Right(Functions.Decryption(Functions.IfNull(Container.DataItem("BankAccount"), "")), 4)%>'></asp:literal>
                                                                </td>
                                                            </tr>
                                                            <tr class="RowForPrint">
                                                                <td style="font-size: 8pt; font-family: Arial, Helvetica, sans-serif; height: 20px;padding-left:15px;">
                                                                    <span style="font-weight: bold;">Bank Account #:</span> &nbsp;&nbsp; 
                                                                    <asp:literal id="Literal2" runat="server" Text='<%# "XXXX -" & Right(Functions.Decryption(Functions.IfNull(Container.DataItem("BankAccount"), "")), 4)%>'></asp:literal>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 8pt; font-family: Arial, Helvetica, sans-serif; height: 20px;padding-left:15px;">
                                                                    <span style="font-weight: bold;">Bank Routing #:</span> &nbsp;&nbsp;<%#Functions.IfNull(Container.DataItem("BankRouting"), "")%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 8pt; font-family: Arial, Helvetica, sans-serif; height: 20px;padding-left:15px;">
                                                                    <span style="font-weight: bold;">Print Name</span> &nbsp;&nbsp;
                                                                    <%#Functions.IfNull(Container.DataItem("PrintName"), "")%>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <br>
                                                    </ItemTemplate>
                                                </asp:FormView>
                                            </td>
                                            <td style="width: 5%; display:none;">
                                            </td>
                                            <td style="height: 82px; width: 45%; display:none;">
                                                <table width="300" height="100%" style="border:solid 1px #E0E0E0" cellpadding="0" cellspacing="0" >
                                                    <tr bgcolor="#E0E0E0" bordercolor="#E0E0E0">
                                                        <td colspan="2" style="font-size: 8pt; font-weight: bold; font-family: Arial, Helvetica, sans-serif;
                                                            background-color: #E0E0E0" height="20">
                                                            &nbsp;Special Instructions/Notes</td>
                                                    </tr>
                                                    <tr bordercolor="#FFFFFF">
                                                        <td width="6">
                                                            &nbsp;</td>
                                                        <td width="288" class="ExtraSmall" height="10">
                                                        </td>
                                                    </tr>
                                                    <tr bordercolor="#FFFFFF">
                                                        <td colspan="2">
                                                            &nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                    &nbsp;&nbsp;
                                </td>
                            </tr>
                           <%-- <tr>
                                <td style="display:none;">
                                    <table  cellpadding="0" cellspacing="0" width="100%" style="border:solid 1px #E0E0E0; ">
                                        <tr bgcolor="#E0E0E0" bordercolor="#E0E0E0">
                                            <td class="SimpleBold" colspan="2" style="font-size: 8pt; font-weight: bold; font-family: Arial, Helvetica, sans-serif;">
                                                &nbsp;* Terms &amp; Conditions</td>
                                        </tr>
                                        <tr bordercolor="#ffffff">
                                            <td height="50" width="1%">
                                                &nbsp;</td>
                                            <td class="ExtraSmall" width="99%">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>--%>
							
                           <tr>
                              <td align="left" class="ExtraSmall"><span style="color: Red;">*</span><span style="font-size: 10px;">EFT: Charge existing support/backup account</span></td>
                            </tr>

                            <tr>
                                <td align="center" class="ExtraSmall">                                    
                                    Copyright ©
                                    <%= Year(Now()) %>
                                    - Netsolace, Inc.                                    
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td align="left" valign="top" class="verLine_ltGrey" style="width: 100px;">
                        <asp:HiddenField ID="hdnOrderID" runat="server" Value="0" />
                        <asp:SqlDataSource ID="SdSProducts" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                            SelectCommand="SCM_Get_OrderByID" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hdnOrderID" Name="OrderID" PropertyName="Value"
                                    Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SdsItmes" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                            SelectCommand="SCM_Get_OrderDetailByID" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hdnOrderID" Name="OrderID" PropertyName="Value"
                                    Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SdsSubModules" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                            SelectCommand="NS_GetAllSubModules" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    </td>
                </tr>                
            </table>
       </div>
          </td>
          </tr>
        </table>
    </form>
</body>
</html>
