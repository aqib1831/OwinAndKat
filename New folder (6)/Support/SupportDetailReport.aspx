<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SupportDetailReport.aspx.vb" EnableViewState="false" Inherits="Support_SupportDetailReport"  %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Support Billing Report</title>
    <style type="text/css">
    .HeaderRow
    {
        font-size:9pt;
        font-family:Arial, Helvetica, Sans-Serif;
        font-weight:bold;
    }
    .ItemRow
    {
        border-bottom:solid 1px #E1E1E1;
        font-size:9pt;
        font-family:Arial, Helvetica, Sans-Serif;
        padding-left:3px;
    }
    .ReportName
    {
        FONT-WEIGHT: bold;
        FONT-SIZE: 14pt;
        FONT-FAMILY: Arial
    }
    .CompanyName
    {
        FONT-WEIGHT: bold;
        FONT-SIZE: 12pt;
        FONT-FAMILY: Arial
    }
    .GeneratedOn
    {
        FONT-WEIGHT: bold;
        FONT-SIZE: 9pt;
        FONT-FAMILY: Arial;
    }
    .TableHeading
    {
        BORDER-TOP: #000000 1px solid;
        FONT-WEIGHT: bold;
        FONT-SIZE: 9pt;
        BORDER-BOTTOM: #000000 1px solid;
        FONT-FAMILY: Arial
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
		    initialiseMaxiPT();		
	    }
	    catch(err){
	    }
    }
    </script>
</head>
<body onload="bodyOnLoad();">
      <object id="factory" viewastext style="display: none;" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814"
        codebase="../ScriptX/smsx.cab#Version=6,3,435,20">
    </object>  
    <form id="form1" runat="server">
   <div>
        <table style="height:100%;width:100%;" cellpadding ="0" cellspacing="0" border ="0">
            <tr>
                <td  align="center">
                    <table style="height:100%;width:670px;" cellpadding ="0" cellspacing="0" border ="0">                            
                    <tr>
                        <td align="center" style="height:50px;">
                            <div style="width:100%; text-align:center; " class="CompanyName"><%=ConfigurationManager.AppSettings("CompanyName")%></div>
                            <div style="width:100%; text-align:center;" class="ReportName">Support Billing Report</div>
                            <div id="divClient" runat="server" style="width:100%; text-align:center; padding-top:3px;" class="GeneratedOn"><asp:Label ID="lblClient" runat="server" Text=""></asp:Label></div>
                            <div id="divProduct" runat="server" style="width:100%; text-align:center; padding-top:3px;" class="GeneratedOn"><asp:Label ID="lblProduct" runat="server" Text=""></asp:Label></div>
                            <div id="divStatus" runat="server" style="width:100%; text-align:center; padding-top:3px;" class="GeneratedOn"><asp:Label ID="lblStatus" runat="server" Text=""></asp:Label></div>
                            <div id="divReportDate" runat="server" style="width:100%; text-align:center; padding-top:3px;" class="GeneratedOn"><asp:Label ID="lblReportDate" runat="server" Text=""></asp:Label></div>
                            <%--<div style="width:100%; text-align:center; padding-top:3px;" class="GeneratedOn" >Generated on <%=DateTime.Now.ToString()%></div>--%><br />
                        </td>
                    </tr>
                    <tr>
                            <td style="background-color:#FFFFFF;border:0;" valign="top" >
                                <div style="width:100%;height:100%;" >
                                    <asp:Repeater ID="rptFranchises" runat="server" EnableViewState="false" DataSourceID="odsSupport">
                                        <HeaderTemplate>
                                            <table style="margin: 0px; border: 0px;width:100%;" cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr style="height:30px;width:100%;" class="HeaderRow" >
                                                <td align="left" style="" class="TableHeading">Store #</td>
                                                <td align="left" style="" class="TableHeading">Store Nick</td>
                                                <td align="left" class="TableHeading"  style='display:<%#IIf(request.QueryString("ClientID") > 0,"none","inline") %>;' >Clients&nbsp;</td>
                                                <td align="left" class="TableHeading" style='display:<%#IIf(request.QueryString("ProductID") > 0,"none","inline") %>;'>Product Name&nbsp;</td>
                                                <td align="left" style="" class="TableHeading">Billing From</td>
                                                <td align="left" style="" class="TableHeading">Billing To</td>
                                                <td align="left" style="" class="TableHeading">Price</td>
                                                <td align="left" style="" class="TableHeading">Amount</td>
                                                <td align="left" style="" class="TableHeading">Status</td>
                                            </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                                <tr style="height:25px;width:100%;">
                                                    <td class="ItemRow"><%#Eval("StoreNumber")%>&nbsp;</td>
                                                    <td class="ItemRow"><%# Eval("StoreNick") %>&nbsp;</td>
                                                    <td class="ItemRow" style='display:<%#IIf(request.QueryString("ClientID") > 0,"none","inline") %>;'><%# Eval("Code") %>&nbsp;</td>
                                                    <td class="ItemRow" style='display:<%#IIf(request.QueryString("ProductID") > 0,"none","inline") %>;'><%#Eval("Title")%>&nbsp;</td>
                                                    <td class="ItemRow"><%#CDate(Eval("BillingFrom")).ToString("MMM dd, yyyy")%>&nbsp;</td>
                                                    <td class="ItemRow"><%#CDate(Eval("BillingTo")).ToString("MMM dd, yyyy")%>&nbsp;</td>
                                                    <td class="ItemRow"><%#FormatNumber(Eval("Rate"), 2)%>&nbsp;</td>
                                                    <td class="ItemRow"><%#FormatNumber(Eval("BillingAmount"), 2)%>&nbsp;</td>
                                                    <td class="ItemRow"><asp:Label ID="lblBillingType" runat="server" ></asp:Label>&nbsp;</td>
                                                </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                           <tr style="height:30px;" class="HeaderRow">
                                                <td align="left" class="TableHeading">&nbsp;</td>
                                                <td align="left" class="TableHeading">Total Amount&nbsp;</td>
                                                <td align="left" class="TableHeading" style='display:<%#IIf(request.QueryString("ClientID") > 0,"none","inline") %>;'>&nbsp;</td>
                                                <td align="left" class="TableHeading" style='display:<%#IIf(request.QueryString("ProductID") > 0,"none","inline") %>;'>&nbsp;</td>
                                                <td align="left" class="TableHeading">&nbsp;</td>
                                                <td align="left" class="TableHeading">&nbsp;</td>
                                                <td align="left" class="TableHeading">&nbsp;</td>
                                                <td align="left" class="TableHeading"><asp:Label ID="lblTotalAmount" runat="server"></asp:Label>&nbsp;</td>
                                                <td align="left" class="TableHeading">&nbsp;</td>
                                            </tr>
                                         </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                    <asp:ObjectDataSource ID="odsSupport" runat="server"    
                                          EnablePaging="false" EnableViewState="true" 
                                          TypeName="Portal.BLL.NS.NS_BillingReport" 
                                          SelectMethod="NS_BillingReportGetForFranchises">
                                        <SelectParameters>
                                            <asp:QueryStringParameter QueryStringField="ClientID" Name="ClientID" Type="Int32" />
                                            <asp:QueryStringParameter QueryStringField="ReportID" Name="ReportID" Type="Int32" />
                                            <asp:QueryStringParameter QueryStringField="ProductID" Name="ProductID" Type="Int32" />
                                            <asp:Parameter Name="FranchiseID" DefaultValue="0"  Type="Int32" />
                                            <asp:QueryStringParameter QueryStringField="Search"  Name="Search" Type="String" />
                                            <asp:QueryStringParameter QueryStringField="Status"  Name="Status" Type="Int32" />
                                            <asp:Parameter Name="maximumRows" DefaultValue="10000"  Type="Int32" />
                                            <asp:Parameter Name="startRowIndex" DefaultValue="0"  Type="Int32" />
                                            <asp:QueryStringParameter QueryStringField="sortBy" Name="sortBy" ConvertEmptyStringToNull="false" Type="string" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource> 
                                </div>
                            </td>
                        </tr>
                         <tr style="padding-left:3px; height:35px;vertical-align:top;">
                            <td align="left" class="TableHeading" style="border-top:0px; border-bottom:0px;font-style:italic;">
                                <i>Printed online on : <%=String.Format("{0:MMMM dd, yyyy}", DateTime.Now())%></i>
                            </td>     
                         </tr>
                    </table>
                </td>
            </tr>          
        </table>
        </div>
    </form>
</body>
</html>
