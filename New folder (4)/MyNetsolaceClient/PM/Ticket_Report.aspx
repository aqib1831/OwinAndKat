<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Ticket_Report.aspx.vb" Inherits="admin_HelpDesk_History_Report" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>MyNetsolace PM Tickets Report</title>
    <style type="text/css">
    .HeaderRow
    {
        font-size:9pt;
        font-family:Arial, Helvetica, Sans-Serif;
        font-weight:bold;
    }
    .ItemRow
    {
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
    .Filters
    {
        FONT-WEIGHT: bold;
        FONT-SIZE: 10pt;
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
</head>
<body style="padding: 0px; margin: 0px;">
<form runat="server">
 <table style="width:<%=IIF(Request.queryString("Type")=1,"670px","100%") %>" height="100%" cellpadding ="0" cellspacing="0" border ="0" align="center">
            <tr>
                <td align="center">
                    <table style="height: 100%; width: 100%;" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td align="center" style="height: 20px;">
                                <div style="width: 100%; text-align: center;" class="CompanyName">
                                    <%=ConfigurationManager.AppSettings("CompanyName")%>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" style="height: 20px;">
                                <div style="width: 100%; text-align: center;" class="ReportName">
                                    MyNetsolace PM Report</div>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" style="height:20px;">
                                <div style="width: 100%; text-align: center;" class="Filters">
                                    Category:
                                    <%=IIf(Request.QueryString("categoryID") = 0, "Show All", Request.QueryString("categoryTitle"))%>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" style="height:20px;">
                                <div style="width: 100%; text-align: center;" class="Filters">
                                    Filter :
                                    <%=IIf(Request.QueryString("filterID") = 4 Or Request.QueryString("filterID") = 0, "Show All", Request.QueryString("filterTitle"))%>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" style="height: 20px;">
                                <div style="width: 100%; text-align: center;" class="Filters">
                                    Generated On:
                                    <%=FormatdateTime(Now, vbLongdate)%>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color: #FFFFFF; border: 0; width:100%;" valign="top">
                            <table style="margin: 0px; border: 0px; width: 100%;" cellpadding="0" cellspacing="0" border="0">
                                    <asp:Repeater ID="rptMyNetsolace" runat="server" EnableTheming="true" EnableViewState="false" DataSourceID="OdsPM">
                                        <HeaderTemplate>
                                                <tr style="width:100%" class="HeaderRow">
                                                    <td  style="width:40px" class="TableHeading">
                                                        Ref # &nbsp;</td>
                                                    <td align="left" class="TableHeading" style="width:15%">
                                                        Name &nbsp;</td>
                                                    <td align="left" class="TableHeading">
                                                        Status&nbsp;</td>
                                                    <td align="left" class="TableHeading">
                                                        Category</td>
                                                    <td align="left" class="TableHeading">
                                                        Due Date&nbsp;</td>
                                                    <td align="left" class="TableHeading">
                                                        Last Updated&nbsp;</td>
                                                </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr style="width: 100%;">
                                                <td style="width:40px" class="ItemRow">
                                               &nbsp; <%#Eval("RefNo")%>
                                                </td>
                                                <td class="ItemRow" style="width:15%">
                                                    <%# Server.HtmlEncode(Functions.IfNull(Eval("Name"),""))%>
                                                    &nbsp;</td>
                                                <td class="ItemRow">
                                                 <%#Server.HtmlEncode(Functions.IfNull(Eval("Status"),""))%>
                                                    &nbsp;</td>
                                                                                                    <td class="ItemRow">
                                                 <%#Server.HtmlEncode(Functions.IfNull(Eval("CategoryName"),""))%>
                                                    &nbsp;</td>
                                                                    <td class="ItemRow">
                                                <%#IIf(IsDate(Eval("DueDate")) = True, String.Format("{0:MM/dd/yyyy}", Eval("DueDate")), Eval("DueDate"))%>
                                                    &nbsp;</td>
                                                                    <td class="ItemRow">
                                                 <%#Server.HtmlEncode(Functions.IfNull(Eval("LastUpdatedMyNetsolace"), ""))%>
                                                 
                                                    &nbsp;</td>
                                                    

                                             </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                          
                                        </FooterTemplate>
                                    </asp:Repeater>
</table>
                            </td>
                        </tr>
                       
                    </table>
                    <span style="float: right; vertical-align: top; text-align: center;position:absolute; z-index:100; top:320; right:420px;">
                            <asp:Label ID="lblPrinted" Visible="false" runat="server"></asp:Label>
                        </span>
                </td>
            </tr>     
            <tr>
            <td style="padding-left:10px;" class="TableHeading" height="18px;">Total: <asp:Label ID="lblTotal" Visible="true" runat="server"></asp:Label></td>
            </tr>      
        </table>
    <asp:ObjectDataSource ID="OdsPM" runat="server"
        SelectMethod="MyTicketGetAllForMyNetsolaceCorporateForPrint"
        TypeName="Portal.DAL.PM.DBPM_Ticket_Features">
        <SelectParameters>
            <asp:SessionParameter SessionField="MyNetsolace_ClientID" Name="ClientID" Type="Int32" />
            <asp:QueryStringParameter QueryStringField="categoryID" DefaultValue="1" Name="CategoryID" Type="Int32" />
            <asp:Parameter Name="StartRowIndex" Type="int32" DefaultValue="0" />
            <asp:Parameter Name="MaximumRows" Type="int32" DefaultValue="100000" />
            <asp:QueryStringParameter QueryStringField="filterId" DefaultValue="0" Name="FilterID" Type="Int32" />
            <asp:QueryStringParameter Name="sortExpression" QueryStringField="sortExpression" Type="String" />
            <asp:QueryStringParameter QueryStringField="search" DefaultValue="" Name="txtsearch" Type="String" />            
            <asp:QueryStringParameter QueryStringField="Pending" DefaultValue="" Name="ClientStatusId" Type="Int16" />
            <asp:Parameter Name="AreaDeveloperId" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
</form>
</body>
</html>