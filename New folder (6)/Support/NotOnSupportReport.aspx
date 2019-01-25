<%@ Page Language="VB" AutoEventWireup="false" CodeFile="NotOnSupportReport.aspx.vb" Inherits="Support_NotOnSupportReport"  %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Not On Support Report</title>
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
	    }
	    catch(err){
	    }
    }
    </script>
</head>
<body onload="bodyOnLoad();window.print();">
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
                            <div style="width:100%; text-align:center;" class="ReportName">Not On Support Franchises</div>
                            <div id="divClientOrState" runat="server"  style="width:100%; text-align:center; padding-top:3px;" class="GeneratedOn"><asp:Label ID="lblShowClientOrState" runat="server" Text=""></asp:Label></div>
                            <div id="divProduct" runat="server"  style="width:100%; text-align:center; padding-top:3px;" class="GeneratedOn"><asp:Label ID="lblProduct" runat="server" Text=""></asp:Label></div>
                            <div id="divStoreStatus" runat="server"  style="width:100%; text-align:center; padding-top:3px;" class="GeneratedOn"><asp:Label ID="lblStoreStatus" runat="server" Text=""></asp:Label></div>
                            <div style="width:100%; text-align:center; padding-top:3px;" class="GeneratedOn" >Generated on <%=DateTime.Now.ToString()%></div><br />
                        </td>
                    </tr>
                    <tr>
                            <td style="background-color:#FFFFFF;border:0;" valign="top" id="td1" >
                                <div style="width:100%;height:100%;" id="dv1">                                        
                                <asp:Repeater ID="rptReport" runat="server" DataSourceID="odsSupport" EnableViewState="false" >
                                <HeaderTemplate>
                                    <table style="margin: 0px; border: 0px;" cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr style="height:30px;" class="HeaderRow" >
                                            <td  align="left" style="width:4%;"  class="TableHeading"  >
                                                St #
                                            </td>
                                            <td  align="left"  style="width:11%;" class="TableHeading" >
                                                Store Nick
                                            </td>
                                            <td align="left" style="width:4%;" class="TableHeading" id="tdClient" runat="server">
                                                Client
                                            </td>
                                            <td align="left" style="width:9%;" class="TableHeading" >
                                                G.Opening
                                            </td>     
                                            <td align="left" style="width:11%;" class="TableHeading" >
                                               Product
                                            </td>   
                                            <td align="left" style="width:8%;" class="TableHeading" >
                                               Price
                                            </td>      
                                            <td align="left" style="width:9%;" class="TableHeading" >
                                               Support Start
                                            </td> 
                                            <td align="left" style="width:9%;" class="TableHeading" >
                                               Support End
                                            </td>      
                                        </tr>
                                </HeaderTemplate> 
                                <ItemTemplate>
                                         <tr style="height:25px; ">
                                            <td  class="ItemRow" >
                                                <%#Eval("StoreNumber")%>
                                                  &nbsp;
                                            </td>
                                            <td class="ItemRow" >
                                                <%#Eval("StoreNick")%>
                                                &nbsp;
                                            </td>
                                            <td class="ItemRow" id="tdClientCode" runat="server" >
                                                 <%#Eval("ClientCode")%>
                                                 &nbsp;
                                            </td>
                                            <td  class="ItemRow">
                                                <%#String.Format("{0:MMM dd, yyyy}", Functions.IfNull(Eval("GrandOpening"), Date.MinValue)).Replace("Jan 01, 1900","") %>
                                                &nbsp;
                                            </td>
                                            <td class="ItemRow">
                                                 <%#Eval("ProductName")%>  
                                                &nbsp;
                                            </td>
                                            <td class="ItemRow">
                                                   <%#FormatCurrency(Functions.IfNull(Eval("Price"), "0"))%>
                                                   <asp:Label ID="lblPrice" runat="server" Text='<%#Functions.IfNull(Eval("Price"), "0")%>' Visible="false" ></asp:Label>
                                                   &nbsp;
                                            </td>
                                            <td class="ItemRow">
                                                   <%#Functions.DateDiffInWords(Functions.IfNull(Eval("SupportStartDate"), "- - -")).Replace("Jan 01, 1900", "")%>
                                                  &nbsp;
                                            </td>
                                            <td class="ItemRow">
                                                   <%#Functions.DateDiffInWords(Functions.IfNull(Eval("SupportEnddate"), "- - -")).Replace("Jan 01, 1900", "")%>
                                                   &nbsp;
                                            </td>
                                        </tr> 
                                </ItemTemplate> 
                                <FooterTemplate>
                                    </table>
                                    <table id="tblFooter" runat="server"  style="margin: 0px; border: 0px;" cellpadding="4" cellspacing="0" border="0" width="100%">
                                         <tr style="padding-left:3px; height:35px;">
                                            <td colspan="5" align="left" style="width:55%;"  class="TableHeading">
                                                Total Stores:&nbsp;&nbsp;<asp:Label ID="lblTotalLicenses" runat="server" Text=""></asp:Label>
                                            </td>
                                            <td colspan="3" align="left" style="width:45%;" class="TableHeading">
                                                Total Price:&nbsp;&nbsp;<asp:Label ID="lblTotalPrice" runat="server" Text=""></asp:Label>
                                            </td>     
                                        </tr>
                                        <tr style="padding-left:3px; height:35px;">
                                            <td colspan="8" align="left" class="TableHeading" style="border-top:0px; border-bottom:0px; ">
                                                <i>Printed online on : <%=String.Format("{0:MMMM dd, yyyy}", DateTime.Now())%></i>
                                            </td>     
                                        </tr>
                                    </table>
                                    <table id="tblNoRecord" runat="server"  style="margin: 0px; border: 0px;" cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td style="font-weight: bold; font-size: 9pt; font-family: Arial; height:35px;" colspan="8" align="center">
                                                    ! No Record Found
                                            </td>
                                         </tr>
                                    </table>
                                </FooterTemplate> 
                                </asp:Repeater>
                               <asp:ObjectDataSource ID="odsSupport" runat="server"    
                                      EnablePaging="false" EnableViewState="false"  
                                      TypeName="Portal.BLL.NS.NS_Products_Franchises" 
                                      SelectMethod="NS_Products_FranchisesGetAllForNotSupport"
                                      SelectCountMethod="NS_Products_FranchisesGetAllCountForNotSupport">
                                   <SelectParameters>
                                        <asp:QueryStringParameter QueryStringField="txtSearch" Name="search" DefaultValue="" />
                                        <asp:QueryStringParameter QueryStringField="ddlClient" Name="ClientID" Type="Int32" />
                                        <asp:QueryStringParameter QueryStringField="ddlFilters" Name="Inactive" Type="Int32" />
                                        <asp:QueryStringParameter QueryStringField="ddlStores" Name="StoreID" Type="Int32" />
                                        <asp:QueryStringParameter QueryStringField="ddlStoreStatus" Name="StoreStatus"  Type="Int32" />
                                        <asp:QueryStringParameter QueryStringField="ddlProducts" Name="ProductID" Type="Int32" />
                                        <asp:Parameter Name="sortBy" Type="String" DefaultValue=""   />     
                                        <asp:Parameter Name="maximumRows" DefaultValue="10000"  Type="Int32" />     
                                        <asp:Parameter Name="startRowIndex" DefaultValue="0"  Type="Int32" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>
                                </div>
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
