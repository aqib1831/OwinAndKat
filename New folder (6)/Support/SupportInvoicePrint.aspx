<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SupportInvoicePrint.aspx.vb" Inherits="Support_SupportInvoicePrint" Theme="Default" %>

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
      <script type="text/javascript" language="javascript">
       function bodyOnLoad(){
	    try{
		    window.focus();
		    factory.printing.header = ""
		    factory.printing.topMargin = 0.3;
		    factory.printing.bottomMargin = 0.3;
		    factory.printing.footer = "";		
	    }
	    catch(err){
	    }
    }
    </script>  
</head>
<body onload="bodyOnLoad();" style="margin:0px; width:100%; height:100%; background-color: #FFFFFF; padding:0px;" scroll="no" >
    <object id="factory" viewastext style="display: none;" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814"
        codebase="../ScriptX/smsx.cab#Version=6,3,435,20">
    </object>
    <form id="form1" runat="server">
       <div>
        <table style="height:100%;width:100%;" cellpadding ="0" cellspacing="0" border ="0">
            <tr>
                <td  align="center" >
                <div style="height:100%; width:100%;overflow-y:auto;padding:10 0 10 0;" class="GrayScrollBar"> 
                <asp:HiddenField ID="hdnSupportInvoiceID" runat="server" Value="0" />
                <table width="670" border="0" style="border:solid 1px #CCCCCC;" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>                                            
                                    <td align="left" valign="top" >
                                        <table border="0" style="width: 100%;margin:0px;" cellpadding="0" cellspacing="0">
                                            <tr valign="top" style="padding:0px;">
                                                <td style="padding:5px;"><img src="../images/logo_netsolace_grey.jpg" height="59px" width="270px"  /></td>
                                                <td style="height: 80px; width: 385;margin:0px;">
                                                        <table style="font-size: 8pt; font-family: Arial,Helvetica, sans-serif;width: 379;height: 76px;" cellpadding="0" cellspacing="0" border="0" >
                                                                <tr bgcolor="#E0E0E0" >
                                                                    <td style="font-size: 8pt; font-family: Arial,Helvetica, sans-serif; height: 25px; padding:0px;" align="center">
                                                                            <strong>Invoice Date </strong>
                                                                    </td>
                                                                    <td style="font-size: 8pt; font-family: Arial,Helvetica, sans-serif; height: 25px; padding:0px;" align="center">
                                                                            <strong>Invoice Number </strong>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="SimpleSmall" style="border: solid 1px #E0E0E0">
                                                                        <div align="center">
                                                                            <asp:Label id="lblInvoiceDate" runat="server" ></asp:Label>
                                                                        </div>
                                                                    </td>
                                                                    <td class="SimpleSmall" style="border: solid 1px #E0E0E0">
                                                                        <div align="center">
                                                                            <strong>
                                                                                <asp:Label id="lblInvoceNumber" runat="server"></asp:Label>
                                                                            </strong>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                        </table>
                                                </td>
                                            </tr>
                                        </table>
                                        </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <table style="font-size: 8pt; font-family: Arial,Helvetica, sans-serif; width: 100%;height:100%;border-top:solid 1px  #E0E0E0;
                                            padding-left: 15px;"  cellpadding="0" cellspacing="0" border="0">
                                            <tr bgcolor="#E0E0E0"">
                                                <td colspan="2"  style="font-size: 8pt; font-weight: bold; font-family: Arial, Helvetica, sans-serif;height: 15px;">
                                                    Bill to
                                                </td>
                                            </tr>
                                             <tr >
                                                <td style="width: 6px;height: 20px;padding-top:5px;display:none;" valign="top"></td>
                                                <td width="288" class="SimpleSmall" style="height: 20px;padding-top:5px;">
                                                      <asp:Label id="lblStoreName" runat="server" ></asp:Label>
                                                </td>
                                            </tr>
                                            <tr >
                                                <td style="width: 6px;height: 20px;padding-top:5px;display:none;" valign="top"></td>
                                                <td width="288" class="SimpleSmall" style="height: 20px;padding-top:5px;">
                                                    <asp:Label id="lblAddress" runat="server" ></asp:Label>
                                                </td>
                                            </tr>
                                            <tr >
                                                <td style="width: 6px;height: 20px;padding-top:5px;display:none;" valign="top"></td>
                                                <td width="288" class="SimpleSmall" style="height: 20px;padding-top:5px;">
                                                    <asp:Label id="lblCityStateCodeZip" runat="server" ></asp:Label>
                                                </td>
                                            </tr>
                                            <tr >
                                                <td style="width: 6px;height: 20px;padding-top:5px;display:none;" valign="top"></td>
                                                <td width="288" class="SimpleSmall" style="height: 20px;padding-top:5px;">
                                                    <asp:Label id="lblCountry" runat="server" ></asp:Label>
                                                </td>
                                            </tr>
                                            <tr >
                                                <td style="width: 6px; height: 20px;display:none;"></td>
                                                <td class="SimpleSmall" width="288" style="height: 20px;">
                                                    <asp:Label id="lblPhone" runat="server" ></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 6px; height: 20px;display:none;"></td>
                                                <td style="height: 20px;">
                                                    <asp:Label id="lblCoporateEmail" runat="server" ></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 6px;"></td>
                                                <td></td>
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
                                                                <asp:Repeater ID="RptmainProducts" runat="server" EnableViewState="true" DataSourceID="SDsSokcetModules">
                                                                    <HeaderTemplate>
                                                                        <div style="height: 100%; width: 100%;">
                                                                            <table border="0" style="height:100%;width:100%;font-size:11px;border-top:solid 1px #E0E0E0;" cellpadding="0" cellspacing="0">
                                                                                <tr>
                                                                                    <td class="txtBld_green" style="font-size:12px;height:25px;
                                                                                        background-color: #E0E0E0;font-weight:bold;padding-left:10px;">&nbsp;
                                                                                    </td>
                                                                                    <td class="txtBld_green" style="font-size: 12px;height:25px;background-color:#E0E0E0;
                                                                                        font-weight:bold;">
                                                                                        Support</td>
                                                                                    <td class="subHdng_cyan" style="font-size: 12px;text-align: center;
                                                                                        background-color:#E0E0E0;font-weight:bold;width:15%;">
                                                                                        Billing From
                                                                                    </td>
                                                                                    <td class="subHdng_cyan" style="font-size: 12px; text-align: center;background-color:#E0E0E0;
                                                                                        font-weight:bold;width:15%;">
                                                                                        Billing To
                                                                                    </td>
                                                                                    <td class="subHdng_cyan" style="font-size:12px;text-align:center;background-color:#E0E0E0;
                                                                                        font-weight:bold;width:15%;" nowrap="nowrap">
                                                                                        Rate Per Month
                                                                                    </td>
                                                                                    <td class="subHdng_cyan" style="font-size:12px;text-align:right;background-color:#E0E0E0;
                                                                                        font-weight:bold;width:24%; padding-right:38px;">
                                                                                        Billing Amount
                                                                                    </td>
                                                                                </tr>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <tr>
                                                                            <td style="padding: 0px; height: 25px; padding-left: 10px;">
                                                                                <img src="../images/arrows.gif" />
                                                                            </td>
                                                                            <td style="padding: 0px; height: 25px;">
                                                                                <strong><%#Eval("ProductName")%></strong>
                                                                            </td>
                                                                            <td class="GreyText" style="vertical-align:top;text-align:center;
                                                                                vertical-align: middle; padding:0px;" nowrap="nowrap">
                                                                                <%#CDate(Eval("BillingFrom")).ToString("MMM dd, yyyy")%>
                                                                            </td>
                                                                            <td class="GreyText" style="vertical-align: top; text-align: center;
                                                                                vertical-align: middle; height:25px; padding:0px;" nowrap="nowrap">
                                                                                <%#CDate(Eval("BillingTo")).ToString("MMM dd, yyyy")%>
                                                                            </td>
                                                                            <td class="GreyText" style="vertical-align: top; text-align: center;
                                                                                vertical-align: middle; height: 25px; padding: 0px;" nowrap="nowrap">
                                                                                $<%#Math.Round(CType(Eval("Rate"), Decimal), 2)%>
                                                                            </td>
                                                                            <td class="GreyText" style="vertical-align: top; text-align: right;
                                                                                vertical-align: middle;height:25px;padding-right: 40px;" nowrap="nowrap">
                                                                                $<asp:Label ID="lblAmount" runat="Server" Text='<%# math.round(CType(Eval("BillingAmount"), Decimal), 2)%>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="height:2px;background-color:#E2E2E2;"
                                                                                colspan="6">
                                                                            </td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <FooterTemplate>                                                                    
                                                                             <tr id="trTotalRow">
                                                                                <td colspan="4" style="padding-left: 15px; text-align: right; font-size: 13px; 
                                                                                    height: 15px;">
                                                                                </td>
                                                                                <td style="text-align: right; padding-right: 5px; font-size: 11px;">
                                                                                    Total:
                                                                                </td>
                                                                                <td style="font-weight: bold; text-align: right; font-weight: bold; padding-right: 38px;
                                                                                    font-size: 12px;font-weight:bold;">
                                                                                    $<asp:Label ID="lblProductTotal" runat="server" Text="0.0"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr id="trTaxRow">
                                                                                <td  colspan="4" style="padding-left: 15px; text-align: right; font-size: 12px;
                                                                                    height: 15px;">
                                                                                </td>
                                                                                <td style="text-align: right; padding-right: 5px; font-size: 11px"
                                                                                    nowrap="nowrap">
                                                                                    Tax Amount:
                                                                                </td>
                                                                                <td style="font-weight: bold; text-align: right; font-weight: bold; padding-right: 2px;
                                                                                     font-size: 12px">
                                                                                    +&nbsp;$<asp:Label ID="lblTax" runat="server" Text="0.0"></asp:Label>&nbsp;<asp:Label ID="lblTaxRate" style="text-align: right; font-weight:normal; font-size: 11px" runat="server" Text="(1%)"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="4" style="padding-left: 15px; text-align: right; font-size: 15px;
                                                                                    height: 25px;">
                                                                                </td>
                                                                                <td class="txtBld_green" style="text-align: right; padding-right: 5px;  font-weight:bold;
                                                                                    font-size: 12px">
                                                                                    Grand Total:
                                                                                </td>
                                                                                <td style="font-weight: bold; text-align: right; font-weight: bold; padding-right: 38px;
                                                                                   font-size: 13px; border-bottom:solid 1px black;  border-top:solid 1px black; ">
                                                                                    $<asp:Label ID="lblGrandTotal" runat="server" Text="0.0"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </tr>
                                                                        </table>
                                                                    </FooterTemplate>
                                                                </asp:Repeater>
                                                                <asp:SqlDataSource ID="SDsSokcetModules" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                    SelectCommand="NS_Billing_SupportInvoicesItem_GetBySupportInvoiceID" SelectCommandType="StoredProcedure">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter ControlID="hdnSupportInvoiceID" Name="SupportInvoiceID" Type="int32" PropertyName="Value" DefaultValue="0" />
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
                            <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td colspan="2">
                                    <table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
                                                <tr>
                                                    <td style="font-size: 8pt; font-weight: bold; font-family: Arial, Helvetica, sans-serif;
                                                        background-color: #E0E0E0; height: 20px;padding-left:15px;border-top:solid 1px  #E0E0E0;">
                                                        Payment Information&nbsp;
                                                    </td>
                                                </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                     <table id="tblPaid" runat="server" style="width:80%; border-collapse:collapse;">
                                                    <tr>
                                                        <td style="font-size: 8pt; font-family: Arial, Helvetica, sans-serif; height: 20px;padding-left:15px;">
                                                            <span style="font-weight: bold;">Payment Method:</span>&nbsp;
                                                            <asp:Label ID="lblPaymentMethod" runat="server" ></asp:Label> 
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="font-size: 8pt; font-family: Arial, Helvetica, sans-serif; height: 20px;padding-left:15px;">
                                                            <span style="font-weight: bold;">Quick Book Ref Number:</span>&nbsp;
                                                            <asp:Label ID="lblQBRefnumber" runat="server" ></asp:Label> 
                                                        </td>
                                                    </tr>
                                                    <tr >
                                                        <td style="font-size: 8pt; font-family: Arial, Helvetica, sans-serif; height: 20px;padding-left:15px;">
                                                            <span style="font-weight: bold;">By :</span> &nbsp;
                                                            <asp:Label ID="lblBy" runat="server" ></asp:Label> 
                                                        </td>
                                                    </tr>
                                          </table>
                                     <table id="tblUnpaid" runat="server" style="width:80%; border-collapse:collapse;">
                                            <tr>
                                                <td style="font-size: 8pt; font-family: Arial, Helvetica, sans-serif; height: 20px;padding-left:15px;">
                                                    <span style="font-weight: bold;">Unpaid</span>
                                                </td>
                                            </tr>
                                     </table>
                                    </td>
                                    <td style="width: 5%; display:none;">
                                    </td>
                                    <td style="height: 82px; width: 45%; display:none;">
                                        
                                    </td>
                                </tr>
                            </table>
                            &nbsp;&nbsp;
                        </td>
                    </tr>                          
                    <tr>
                        <td align="center" class="ExtraSmall">
                            Copyright ©
                            <%= Year(Now()) %>
                            - Netsolace, Inc.
                            <span style="float:left;padding-left:3px;"><i>Printed online on : <%=String.Format("{0:MMMM dd, yyyy}", DateTime.Now())%></i></span>           
                        </td>
                    </tr>
                </table>
                
                </div>
                </td>
            </tr>          
        </table>
        </div>
    </form>
</body>
</html>