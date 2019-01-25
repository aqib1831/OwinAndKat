<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ShippingInformation.aspx.vb" Inherits="Orders_ShippingInformation" Theme="Default" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Shipment Information</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <style>
    @media print
    {
	    .hideShowRow{ display:none;}	
    }
    @media screen
    {
        .hideShowRow{ display:inline;}    
    }
    </style>
</head>
<body style="border:0; margin:0; padding:0;">
    <form id="form1" runat="server">
    <div>
        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
            <tr>
                <td style="padding:5px;" align="right" class="hideShowRow">
                <div style="width:110px; cursor:pointer;" class="LeadDetailButton" onclick="Print();" >
                  Print&nbsp;<img  src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10"  style="border:0px;" />
                </div>
                </td>
            </tr>
            <tr>
                <td align="center" valign="middle" style="padding-top:15px;">
                    <asp:FormView ID="fvShippingInformation" runat="server" Width="80%" DataSourceID="sdsShippingInfo">
                    <ItemTemplate>
                    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; border:solid 1px #E0E0E0; padding:5px; font-family:Arial, Sans-Serif, Verdana, Helvetica; font-size:12px;">
                        <tr>
                            <td colspan="2" style="font-weight:bold; background-color:#E0E0E0; font-size:14px; font-family:Arial, Verdana, Sans-Serif; padding-left:3px;">Shipment Information
                            </td>                
                        </tr>            
                        <tr>
                            <td style="width:30%" >Order # :
                            </td>                
                            <td style="width:70%">
                                <strong><%# Eval("OrderID") %></strong>
                            </td>                
                        </tr>   
                        <tr>
                            <td >Shipping Date :
                            </td>                
                            <td>
                                <strong><%#String.Format("{0:MMM dd, yyyy}", Eval("ShipDate")) %></strong>
                            </td>                
                        </tr>   
                        <tr>
                            <td >Shipping Via :
                            </td>                
                            <td><strong><%# Eval("ShippingCompany") %></strong>
                            </td>                
                        </tr>   
                        <tr>
                            <td >Tracking # :
                            </td>                
                            <td><strong><%# Eval("TrackingNo") %></strong>
                            </td>                
                        </tr>   
                        <tr>
                            <td >Shipping Charges :
                            </td>                
                            <td><strong><%# FormatNumber(Eval("ShipCharges"),2) %></strong>
                            </td>                
                        </tr>   
                        <tr>
                            <td valign="top">Shipping Notes :
                            </td>                
                            <td><strong><%# Eval("Notes") %></strong>
                            </td>                
                        </tr>   
                    </table>
                    </ItemTemplate>
                    </asp:FormView>                    
                    <asp:SqlDataSource ID="sdsShippingInfo" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                        SelectCommand="SCM_Orders_GetShippingInfoByOrderID" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="OrderID" QueryStringField="OrderID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>                
            </tr>            
        </table>
    
    </div>
    </form>
</body>
</html>
<script language="javascript" type="text/javascript">
    function Print()
    {        
        window.focus();
        window.print();
    }
</script>
