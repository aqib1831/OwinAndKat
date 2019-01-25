<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SupportClient.aspx.vb" EnableViewState="false" Inherits="Support_SupportClient"  %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Support Billing Report</title>
    <style type="text/css">
    .HeaderRow td
    {
        font-size:9pt;
        font-family:Arial, Helvetica, Sans-Serif;
        font-weight:bold;
        border-bottom:solid 2px #649AD2;
        border-top:solid 2px #649AD2;
    }
    .ItemRow td
    {
        border-bottom:solid 1px #E1E1E1;
        font-size:9pt;
        font-family:Arial, Helvetica, Sans-Serif;
        padding-left:3px;
        border-right:solid 1px #649AD2;
    }
   .ItemRowImg td
    {
        border-bottom:solid 1px #E1E1E1;
        font-size:9pt;
        font-family:Arial, Helvetica, Sans-Serif;
        padding-left:3px;
        border-right:solid 1px #649AD2;
        background-image:url(../images/Alternate1.JPG);
    }
    .ItemRowImgAlter td
    {
        border-bottom:solid 1px #E1E1E1;
        font-size:9pt;
        font-family:Arial, Helvetica, Sans-Serif;
        padding-left:3px;
        border-right:solid 1px #649AD2;
        background-image:url(../images/Alternate2.JPG);
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
</head>
<body style="font-family:Arial;" >
   <form id="form1" runat="server">
   <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <table style="height:100%;width:100%;" cellpadding ="0" cellspacing="0" border ="0">                            
                    <tr>
                        <td style="border:0px;height:25;" valign="top">
                        <table style="padding:5px;font-size:13px;background-color:#FCE197;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#ffffff,endColorStr=#F7BB0F); margin: 0px; border: 0px; height:100%;" cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td>
                                    <b>Support Billing Report </b>
                                </td>
                                <td align="right" >
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always" >        
                                  <ContentTemplate>
                                   <span style="font-size:11px"><b>Period:</b></span>
                                   <asp:DropDownList ID="ddlMonths" CssClass="DarkBlackTextSmall" runat="server" Width="100px" AutoPostBack="true">
                                        <asp:ListItem Text="January" Value="01" ></asp:ListItem>
                                        <asp:ListItem Text="February" Value="02" ></asp:ListItem>
                                        <asp:ListItem Text="March" Value="03" ></asp:ListItem>
                                        <asp:ListItem Text="April" Value="04" ></asp:ListItem>
                                        <asp:ListItem Text="May" Value="05" ></asp:ListItem>
                                        <asp:ListItem Text="June" Value="06" ></asp:ListItem>
                                        <asp:ListItem Text="July" Value="07" ></asp:ListItem>
                                        <asp:ListItem Text="August" Value="08" ></asp:ListItem>
                                        <asp:ListItem Text="September" Value="09" ></asp:ListItem>
                                        <asp:ListItem Text="October" Value="10" ></asp:ListItem>
                                        <asp:ListItem Text="November" Value="11" ></asp:ListItem>
                                        <asp:ListItem Text="December" Value="12" ></asp:ListItem>
                                 </asp:DropDownList>
                                 <asp:DropDownList ID="ddlYears" 
                                    CssClass="DarkBlackTextSmall" runat="server" 
                                    Width="80px" AutoPostBack="true" DataTextField="Year" DataValueField="Year" 
                                    DataSourceID="SDS_ReportYears">
                                 </asp:DropDownList> 
                                 <asp:SqlDataSource ID="SDS_ReportYears" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                    SelectCommand="NS_BillingReport_GetYears" SelectCommandType="StoredProcedure" 
                                    DataSourceMode="DataReader">
                                  </asp:SqlDataSource> 
                                 </ContentTemplate>                           
                                </asp:UpdatePanel>     
                                </td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="border:0;" valign="top">
                         <div style="height:100%; width:100%; overflow-y:auto;" id="tblClients" runat="server">
                        <asp:UpdatePanel ID="upKeys" runat="server" UpdateMode="Conditional" >         
                          <ContentTemplate>
                           <table  style="width:100%;padding:5px;background-color:White;margin: 0px; border: 1px; height:100%;" cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr id="trHeader" style="height:30px;background-color:#E9E9E9;" class="HeaderRow" >
                                            <td align="left" style="width:20%;" class="TableHeading">Clients</td>
                                            <%--<td align="left" style="width:10%;" class="TableHeading"># of Stores</td>--%>
                                            <%--<td align="left" style="width:1%;" class="TableHeading">&nbsp;</td>--%>
                                            <asp:Repeater ID="rptProducts" runat="server" OnItemDataBound="rptProducts_ItemDataBound">
                                                <ItemTemplate><td align="left" class="TableHeading"><%#Eval("ProductName")%></td></ItemTemplate>
                                            </asp:Repeater>
                                            <td align="left" style="width:10%;" class="TableHeading">Total&nbsp;</td>
                                        </tr>
                                <asp:Repeater ID="rptClients" runat="server" EnableViewState="false">
                                    <HeaderTemplate>
                                         <tr style="height:0px;">
                                         <td colspan="8"></td>
                                        </tr>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                            <tr style="height:25px;" class="ItemRow">
                                                <td ><%#Eval("ClientName")%>&nbsp;</td>
                                                <%--<td align="right" style="cursor:pointer;" title="Click to have a Detail View" onclick='this.getElementsByTagName("SPAN")[0].click();'><asp:Label ID="lblFranchiseCount" runat="server" ></asp:Label>&nbsp;</td>--%>
                                                <%--<td >&nbsp;</td>--%>
                                                <asp:Repeater ID="rptClientProducts" runat="server" DataSource='<%# Container.DataItem.CreateChildView("ProductDetail") %>' OnItemDataBound="rptClientProducts_ItemDataBound"  >
                                                    <ItemTemplate><td align="right" class="ItemRow" style="cursor:pointer;" title="Click to have a Detail View" onclick='this.getElementsByTagName("SPAN")[0].click();' ><asp:Label ID="lblPrice" runat="server" Text='<%#FormatNumber(Eval("BillingAmount"), 2)%>'></asp:Label>&nbsp;</td></ItemTemplate>
                                                </asp:Repeater>
                                                <td align="right" style="cursor:pointer;" title="Click to have a Detail View" onclick='this.getElementsByTagName("SPAN")[0].click();'><asp:Label ID="lblClientTotal" runat="server" Text="">&nbsp;</asp:Label></td>
                                            </tr>
                                    </ItemTemplate>
                                    <AlternatingItemTemplate> 
                                            <tr style="height:25px;background-color:#F9FAFC;" class="ItemRow">
                                                <td><%#Eval("ClientName")%>&nbsp;</td>
                                                <%--<td align="right" style="cursor:pointer;" title="Click to have a Detail View" onclick='this.getElementsByTagName("SPAN")[0].click();'><asp:Label ID="lblFranchiseCount" runat="server" ></asp:Label>&nbsp;</td>--%>
                                                <%--<td>&nbsp;</td>--%>
                                                <asp:Repeater ID="rptClientProducts" runat="server" DataSource='<%# Container.DataItem.CreateChildView("ProductDetail") %>' OnItemDataBound="rptClientProducts_ItemDataBound"  >
                                                    <ItemTemplate><td align="right" class="ItemRow" style="cursor:pointer;" title="Click to have a Detail View" onclick='this.getElementsByTagName("SPAN")[0].click();' ><asp:Label ID="lblPrice" runat="server" Text='<%#FormatNumber(Eval("BillingAmount"), 2)%>'></asp:Label>&nbsp;</td></ItemTemplate>
                                                </asp:Repeater>
                                                <td align="right" style="cursor:pointer;" title="Click to have a Detail View" onclick='this.getElementsByTagName("SPAN")[0].click();'><asp:Label ID="lblClientTotal" runat="server" Text="">&nbsp;</asp:Label></td>
                                            </tr>
                                     </AlternatingItemTemplate>
                                    <FooterTemplate>
                                        <tr id="trFooter" style="height:100%;" class="ItemRowImg">
                                            <td>&nbsp;</td>
                                            <%--<td>&nbsp;</td>--%>
                                            <%--<td>&nbsp;</td>--%>
                                            <asp:Repeater ID="rptProductstd" runat="server">
                                               <ItemTemplate><td align="right">&nbsp;</td></ItemTemplate>
                                            </asp:Repeater>
                                            <td>&nbsp;</td>                                                           
                                        </tr>
                                        <tr id="trNoRecord" style="height:100%;" class="ItemRowImg" STYLE="display:none;">
                                        <td colspan="2">
                                            <table style="height:100%;width:100%;padding:0;margin:0;">
                                            <tr>                            
                                                <td style="font-family:Arial, Verdana,Sans-serif,Helvetica;font-size:12px;color:#7B7B7B;font-weight:bold;text-align:center; vertical-align:middle; border:0;vertical-align:middle;width:100%;height:100%;">
                                                    <img align="absmiddle" src="../images/ico_alert.gif" />&nbsp;&nbsp;No Record Found !
                                                </td>
                                            </tr>
                                            </td>
                                         </table> 
                                         </tr>     
                                    </FooterTemplate>
                                </asp:Repeater>
                                        <tr id="trfooter2" style="height:30px;background-color:#E9E9E9;" class="HeaderRow" >
                                            <td align="left" class="TableHeading">Grand Total&nbsp;</td>
                                            <%--<td align="left" class="TableHeading"><asp:Label ID="lblTotalFranchiseCount" runat="server" Visible="false" ></asp:Label>&nbsp;</td>--%>
                                            <%--<td align="left" style="width:10%;" class="TableHeading">&nbsp;</td>--%>
                                            <asp:Repeater ID="rptProductsFooter" runat="server">
                                              <ItemTemplate><td align="right" class="TableHeading"><asp:Label ID="lblProductTotal" runat="server" Text=""></asp:Label><asp:Label ID="lblProductID" runat="server" Text='<%#Eval("ProductID") %>' Visible="false" ></asp:Label>&nbsp;</td></ItemTemplate>
                                            </asp:Repeater>
                                            <td align="right" style="width:10%;" class="TableHeading" style="cursor:pointer;" title="Click to have a Detail View" onclick='this.getElementsByTagName("SPAN")[0].click();'><asp:Label ID="lblGrandTotal" runat="server" Text=""></asp:Label>&nbsp;</td>
                                        </tr>
                                   </table>
                              </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddlMonths" EventName="SelectedIndexChanged" />
                             <%--<asp:AsyncPostBackTrigger ControlID="ddlYears" EventName="SelectedIndexChanged" />--%>
                            </Triggers>
                            </asp:UpdatePanel>
                        </div>
                        </td>
                    </tr>
                  </table>
                
        </div>
   <script language="javascript" type="text/javascript">
     function ShowDetail(reportid,clientid,prodid)
     {   
        var ddlMonths = document.getElementById('<%=ddlMonths.ClientID %>');
        var ddlYears = document.getElementById('<%=ddlYears.ClientID %>');
        var reportdate = ddlMonths.value+'-01-'+ddlYears.value
        window.location='SupportDetail.aspx?ReportID='+reportid+'&ClientID='+clientid+'&ProductID='+prodid+'&ReportDate='+reportdate;
     }
     function trFooterClass(trclassname,count)
     {  
        if (count > 0)
        {
            document.getElementById('trFooter').className = trclassname
        }
        else
        {
            document.getElementById('trFooter').style.display = 'none';
            document.getElementById('trHeader').style.display = 'none';
            document.getElementById('trfooter2').style.display = 'none';
            document.getElementById('trNoRecord').style.display = 'inline';
        }
     }
   </script>
   </form>
</body>
</html>

