<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SMSxOrderedFranchises_Print.aspx.vb" Inherits="SMSxOrderedFranchises" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>SMSx - Franchises</title>
    
<style type="text/css" media="print">
        .NoPrint{
            display:none;
        }
    </style>
    <style type="text/css">
		  .Heading 
{
	font-family:Arial;
	font-size:16px;
	font-weight:bold;	
}
.simpleText 
{
    font-family:Arial;
	font-size:12px;
	font-weight: normal;	
}
.gridHeading
{
	font-family:Arial;
	font-size:12px;
	font-weight:bold;
	text-align:Left;	
}
    </style>
</head>
<body style="overflow-y:auto;" scroll="auto">
    <form id="form1" runat="server">
    <div align="center">
<asp:SqlDataSource ID="sdsStores" runat="server" SelectCommandType="StoredProcedure"
SelectCommand="Franchises_Get_WhoNotOrdered_SMSX" ConnectionString="<%$ ConnectionStrings:FransupportConnectionString %>"
ProviderName="<%$ ConnectionStrings:FransupportConnectionString.ProviderName %>" />
		<asp:Repeater ID="rptPlArrange" runat="server" DataSourceID="sdsStores">
                <HeaderTemplate>
                    <table id="tblReport" width="700px" style="height: 100%;" cellpadding="0" cellspacing="0">
						<tr id="trReportTitle">
							<td colspan="2" align="center">
								<asp:Label ID="lblCompany" runat="server" Text="Edible Arrangements International , Inc."
									CssClass="Heading"></asp:Label>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="padding: 2px 0px 2px 0px;" align="center">
								<asp:Label ID="lblAdrequest" runat="server" Text="STORES THAT HAVE NOT ORDERED SMSx"
									CssClass="Heading"></asp:Label>
							</td>
						</tr>
                            
						<tr>
							<td align="center" valign="top" colspan="2" style="height:30px">
								<asp:Label ID="lblGeneratedon" CssClass="simpleText" runat="server"></asp:Label>
							</td>
						</tr>
                        <tr id="trReportHeader">
							<td class="gridHeading" align="left" style="width: 200px; height: 25px; border-bottom: solid 2px black;">
                                Store #
                            </td>
                            <td class="gridHeading" align="left" style="height: 25px; border-bottom: solid 2px black;">
                                Store Location
                            </td>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr style="height:20px;">
                        <td style="width:200px; padding-left:3px;" align="left"  >
                            <asp:Label ID="lblStoreNumber" CssClass="simpleText" Text='<%#Container.DataItem("StoreNumber") %>'
                                runat="server"></asp:Label>
                        </td>
                        <td style="padding-left:3px;" align="left">
                            <asp:Label ID="lblLocation" CssClass="simpleText" Text='<%#Container.DataItem("Location") %>'
                                runat="server"></asp:Label>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                <tr style="height:20px;">
                <td colspan="2" align="right" style="font-weight:bold;border-bottom:solid 1px #000000;border-top:solid 1px #000000; padding-top:10px;">
                    <asp:Label ID="lbltotal" CssClass="simpleText" runat="server"></asp:Label>
                </td>
                </tr>
                <tr><td>&nbsp;</td></tr>
                </FooterTemplate>
            </asp:Repeater>
     </div>
    </form>
</body>
</html>

