<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SupportReport.aspx.vb" Inherits="Support_SupportReport" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>SMS Sales Analysis Report By State</title>
    <link href="../../style/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../../scripts/functions.js"></script>
    <script type="text/javascript" language="javascript" src="../../scripts/calendar.js"></script>
    <script type="text/javascript" language="javascript" src="../../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="javascript" src="../../scripts/calendar-fs.js"></script>
    <link href="../../style/Calendar/style.css" rel="stylesheet" type="text/css" />
    <style type="text/css"  >
    .GridBottomBorder
    {
        border-top:solid 1px black;
        border-bottom:solid 1px black;
    }
    .HighlightedReportRowSMS
    {
       background-color:#F1F1F1;
    }
    .HighlightedReportRowSMS TD
    {
        background-color:#F1F1F1;
    }
    .rptGridRowClickableSMS
    {
       background-color:#FFFFFF;
    }
    .rptGridRowClickableSMS TD
    {
	    background-color:#FFFFFF;
    }
    .EmptyreportDIV
    {
	    position: relative; 
	    width:200px; 
	    left:35%; 
	    top:40%;
	    border:1px solid #DEDEDE;
	    border-bottom-width:4px;
	    border-top-width:4px;
	    background-color:#FFFFFF;
	    position:absolute;
	    text-align:center;
	    height:70px;
    }
    </style> 
    <script language="javascript" type="text/javascript">
    function printReport()
    {
            var QueryStringValues = "?FromDate="+document.getElementById('<%=DateFrom.ClientID%>').value;
            QueryStringValues += "&ToDate="+document.getElementById('<%=DateTo.ClientID%>').value;
            QueryStringValues += "&SortExpression=" + document.getElementById('<%=hdnSortExpression.ClientID %>').value;  
            var URL = "GeneralReport_Printable.aspx" + QueryStringValues;            
            window.open(URL);
    }
    </script>
    </head>
<body scroll="no" class="gradientbody" style="margin:0px;">
    <form id="form1" runat="server">
    <asp:HiddenField ID="hdnSortExpression" Value="State"  runat="server" />
    <asp:HiddenField ID="hdnFromDate" Value=""  runat="server" />
    <asp:HiddenField ID="hdnToDate" Value="" runat="server" />
    <script language="javascript" type="text/javascript">
     function setValues(SExp)
     {
            document.getElementById('<%=hdnSortExpression.ClientID %>').value = SExp;
     }
    </script>
    <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="360000" />
       <asp:UpdateProgress ID="Progress1" runat="server">
        <ProgressTemplate>
            <div  class="EmptyreportDIV">
               <br />
               <asp:Image ID="Image2" runat="server" ImageUrl="~/images/indicator.gif" ImageAlign="AbsMiddle" /> <span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Analyzing ...</b></span>
           </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
        <div>
            <table style="height:100%;width:100%;" cellpadding ="0" cellspacing="0" border ="0">
                <tr>
                    <td style="border:0px solid #6B94CA;">
                        <table style="height:100%;width:100%;" cellpadding ="0" cellspacing="0" border="0">
                            <tr class="HeaderRow" >
                                <td style="width:100%;height:30px;font-weight:bold;padding-left:5px;padding-right:5px;">
                                    <span runat="server" id="spanHeading">
                                        SMS Sales Analysis Report By State
                                    </span>
                                </td>
                                <td style="width:150px;padding-right:5px" align="right">
                                     <asp:LinkButton ID="lnkExportExcel" runat="server">
                                        <div style="width:150px;background-repeat:no-repeat;background-image:url(../../images/ico_exportExcel.gif);" class="PrintButton">Export To Excel&nbsp;<img alt="" src="../../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10" /></div>
                                    </asp:LinkButton>                               
                                </td>
                                <td style="width:92px;padding-right:5px" align="right" >
                                    <div id="Div1"  runat="server" class="PrintButton" style="width:92px;background-repeat:no-repeat;background-image:url(../../images/icn_printableV.gif); " onclick="printReport(); return false;" >Print <img alt="" src="../../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10" />&nbsp;</div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" style="height:30px;padding:5px;">
                                    <table style="width:100%;height:100%;" border="0" cellpadding="0" cellspacing ="0">
                                        <tr>
                                            <td style="width:140px;" >
                                                <span class="GreyTextSmall">From: </span>
                                                <asp:TextBox 
                                                    runat="server" 
                                                    id="DateFrom" 
                                                    readonly="true" onclick="img1.click();"
                                                    style="width:100px;font-size:10px;" 
                                                     />
                                                <img src="../../images/icn_calendar.png" 
                                                    border="0" id="img1" 
                                                    align="absmiddle" style="display:none;"
                                                    onclick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= DateFrom.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"  
                                                    alt="" />
                                            </td>
                                            <td style="width:160px;" >
                                                <span class="GreyTextSmall">To: </span>
                                                <asp:TextBox 
                                                    runat="server" 
                                                    id="DateTo" 
                                                    ReadOnly="true" onclick="img2.click();"
                                                    style="width:100px;font-size:10px;" 
                                                    />
                                                <img src="../../images/icn_calendar.png" id="img2"
                                                    border="0" 
                                                    align="absmiddle"  style="display:none;"
                                                    onclick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= DateTo.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');" 
                                                    alt="" />
                                                &nbsp;<asp:ImageButton ID="btnSearch" runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle"  />
                                            </td>
                                            <td>
                                            &nbsp;<asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="to date must be greater then from date" ControlToCompare="DateFrom" ControlToValidate="DateTo" Operator="GreaterThan" Display="Dynamic" Type="Date"   ></asp:CompareValidator>
                                            </td>
                                        </tr>
                                    </table> 
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3"  style="background-color:#FFFFFF;border:0;padding:8px;padding-bottom:0;" valign="top" id="td1" >
                                    <div style="overflow:auto;width:100%;height:100%;" id="dv1" class="ScrollBars">
                                    <asp:UpdatePanel ID="UPReport" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:GridView 
                                                ID="gvOrders" 
                                                AllowPaging="false"
                                                AllowSorting="true"  
                                                runat="server" 
                                                DataSourceID="odsOrderDetail"
                                                AutoGenerateColumns="False" 
                                                SkinID="gvReportsSMS" Width="100%" ShowFooter="True">
                                                <Columns>
                                                    <asp:TemplateField>
                                                    <HeaderTemplate>
                                                         <table style="margin: 0px; border: 0px;" cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                <tr style="font-weight: bold; height: 25px">
                                                                    <td rowspan="2" style="width:16%;  border:solid 1px black; border-right:0px;border-bottom:solid 1px black;" align="center" valign="middle"   >
                                                                        <asp:LinkButton ID="lnkStateName" runat="server" Text="State" CommandName="Sort"
                                                                        CommandArgument="State" ForeColor="black"></asp:LinkButton>
                                                                    </td>
                                                                    <td colspan="3" align="center"  style="width: 26%; border:solid 1px black; border-bottom:0px; ">
                                                                        Orders
                                                                    </td>
                                                                    <td colspan="3" align="center" style="width: 29%; border-top:solid 1px black;">
                                                                        Merchandise
                                                                    </td>
                                                                    <td colspan="1" rowspan="2" align="center" style="width: 11%;border:solid 1px black; border-bottom:solid 1px black; padding-left:2px;" valign="middle">
                                                                         <asp:LinkButton ID="lnkDeliveryCharges" runat="server" Text="Del Charges" CommandName="Sort"
                                                                        CommandArgument="DeliveryCharges" ForeColor="black"></asp:LinkButton>
                                                                    </td>     
                                                                    <td colspan="1" rowspan="2" align="center" style="width: 9%;border:solid 1px black; border-left:0px; border-bottom:solid 1px black; " valign="middle">
                                                                        <asp:LinkButton ID="lnkTaxes" runat="server" Text="Taxes" CommandName="Sort"
                                                                        CommandArgument="Taxes" ForeColor="black"></asp:LinkButton>
                                                                    </td> 
                                                                    <td colspan="1" rowspan="2" align="center" style="width: 9%;border:solid 1px black; border-left:0px; border-bottom:solid 1px black; " valign="middle">
                                                                        <asp:LinkButton ID="lnkVoid" runat="server" Text="Voided" CommandName="Sort"
                                                                        CommandArgument="Void" ForeColor="black"></asp:LinkButton>
                                                                    </td>    
                                                                </tr>
                                                                <tr style="font-weight: bold; height: 25px">
                                                                    <td align="center" style="width: 6%; border:solid 1px black;">
                                                                        <asp:LinkButton ID="lnkOrderCount" runat="server" Text="Total" CommandName="Sort"
                                                                        CommandArgument="OrderCount" ForeColor="black"></asp:LinkButton>
                                                                    </td>
                                                                    <td align="center" style="width: 11%; border:solid 1px black; border-left:0px;">
                                                                        <asp:LinkButton ID="lnkOrderTotal" runat="server" Text="Amount" CommandName="Sort"
                                                                        CommandArgument="OrdersTotal" ForeColor="black"></asp:LinkButton>
                                                                    </td>
                                                                     <td align="center" style="width: 9%; border:solid 1px black; border-left:0px; border-right:solid 1px black;">
                                                                        <asp:LinkButton ID="lnkOrdersDiscount" runat="server" Text="Disc." CommandName="Sort" CommandArgument="OrderDiscount"
                                                                        ForeColor="black"></asp:LinkButton>
                                                                    </td>
                                                                    <td align="center" style="width: 6%; border:solid 1px black; border-left:0px; ">
                                                                        <asp:LinkButton ID="lnkMerchandiseCount" runat="server" Text="Total" CommandName="Sort" CommandArgument="MerchandiseCount"
                                                                        ForeColor="black"></asp:LinkButton>
                                                                    </td>
                                                                    <td align="center"  style="width: 13%; border:solid 1px black; border-left:0px;">
                                                                        <asp:LinkButton ID="lnkMerchandiseTotal" runat="server" Text="Amount" CommandName="Sort" CommandArgument="MerchandiseTotal"
                                                                        ForeColor="black"></asp:LinkButton>
                                                                    </td>
                                                                    <td align="center" style="width: 10%; border:solid 1px black; border-left:0px; border-right:0px;">
                                                                        <asp:LinkButton ID="lnkMerchandiseDiscount" runat="server" Text="Disc." CommandName="Sort" CommandArgument="MerchandiseDiscount"
                                                                        ForeColor="black"></asp:LinkButton>
                                                                    </td>
                                                                   </tr>
                                                         </table> 
                                                    </HeaderTemplate> 
                                                    <ItemTemplate>
                                                      <table cellpadding="0" cellspacing="0" border="0" width="100%" style="margin: 0px; border: 0px;">   
                                                        <tr style="height: 25px; margin:0px;">
                                                            <td style="width:16%; border-bottom:solid 1px #F1F1F1; margin:0px;" title="Click to view details">
                                                                <asp:HyperLink ID="hlinkState" runat="server" style="display:none;" Text='<%#Eval("State")%>' NavigateUrl='<%#"~/admin/SMS/ReportByLocation.aspx?StateID="&Eval("ID") & "&FromDate=" & hdnFromDate.value & "&ToDate=" & hdnToDate.value & "&BackAction=General" %>'   ></asp:HyperLink>
                                                                <asp:LinkButton ID="lnkState" runat="server" Text='<%#Eval("State")%>' ForeColor="#609BD3"></asp:LinkButton>
                                                            </td>
                                                            <td style="width: 6%; border-bottom:solid 1px #F1F1F1; margin:0px;" align="right"> 
                                                                <%#Functions.IfNull(Eval("OrderCount"), 0)%>
                                                                &nbsp;
                                                            </td>
                                                            <td style="width: 11%; border-bottom:solid 1px #F1F1F1; margin:0px;" align="right">
                                                                 <%#FormatNumber(Functions.IfNull(Eval("OrdersTotal"), 0), 2)%>
                                                                 &nbsp;
                                                            </td>
                                                            <td style="width: 9%; border-bottom:solid 1px #F1F1F1; margin:0px;" align="right">
                                                                 <%#FormatNumber(Functions.IfNull(Eval("Discount"), 0), 2)%>
                                                                 &nbsp;
                                                            </td>
                                                            <td style="width: 6%; border-bottom:solid 1px #F1F1F1; margin:0px;" align="right" title="Click to view details">
                                                                <asp:HyperLink ID="hlinkMerchandiseCount" runat="server" Text='<%#Eval("MerchandiseCount")%>' NavigateUrl='<%#"~/admin/SMS/MerchandisesReportByState.aspx?StateID="&Eval("ID") & "&FromDate=" & hdnFromDate.value & "&ToDate=" & hdnToDate.value%>'   ></asp:HyperLink>                                                        
                                                                &nbsp;
                                                            </td>
                                                            <td align="right" style="width: 13%; border-bottom:solid 1px #F1F1F1; margin:0px;" >
                                                                <%#FormatNumber(Functions.IfNull(Eval("MerchandiseTotal"), 0), 2)%>
                                                            </td>
                                                            <td align="right" style="width: 10%; border-bottom:solid 1px #F1F1F1;margin:0px;" >
                                                               <%#FormatNumber(Functions.IfNull(Eval("MerchandiseDiscount"), 0), 2)%>
                                                            </td>
                                                            <td align="right" style="width: 11%; border-bottom:solid 1px #F1F1F1; margin:0px;" colspan="1" >
                                                                   <%#FormatNumber(Functions.IfNull(Eval("DeliveryCharges"), 0), 2)%>
                                                            </td>
                                                            <td align="right" style="width: 9%; border-bottom:solid 1px #F1F1F1; margin:0px;">
                                                                <%#FormatNumber(Functions.IfNull(Eval("Taxes"), 0), 2)%>&nbsp;
                                                            </td>
                                                            <td align="right" style="width: 9%; border-bottom:solid 1px #F1F1F1; margin:0px;">
                                                                <%#FormatNumber(Functions.IfNull(Eval("Void"), 0),2)%>&nbsp;
                                                            </td>
                                                        </tr>
                                                      </table>                                                      
                                                    </ItemTemplate> 
                                                    <FooterTemplate>
                                                      <table style="margin: 0px; border: 0px;" cellpadding="0" cellspacing="0" border="0"
                                                        width="100%">
                                                        <tr>
                                                            <td style="width: 16%; height:25px;" class="GridBottomBorder" >
                                                                &nbsp;<b>Total:</b> 
                                                            </td>
                                                            <td style="width: 6%;" class="GridBottomBorder" align="right">
                                                                <asp:Label ID="lblTotalOrderCount" runat="server" Text=""></asp:Label>
                                                            </td>
                                                            <td style="width: 11%;" align="right"  class="GridBottomBorder">
                                                                 <asp:Label ID="lblTotalOrdersTotal" runat="server" Text=""></asp:Label>
                                                            </td>
                                                            <td align="right" style="width: 9%;" class="GridBottomBorder">
                                                               <asp:Label ID="lblOrderDiscount" runat="server" Text=""></asp:Label>  
                                                            </td>
                                                            <td align="right" style="width: 6%" class="GridBottomBorder">
                                                                 <asp:Label ID="lblTotalMerchandiseCount" runat="server" Text=""></asp:Label>                                                                
                                                            </td>
                                                            <td align="right" style="width: 13%" class="GridBottomBorder">
                                                                <asp:Label ID="lblTotalMerchandiseTotal" runat="server" Text=""></asp:Label>  
                                                            </td>
                                                            <td align="right" style="width: 10%;" class="GridBottomBorder">
                                                               <asp:Label ID="lblTotalMerchandiseDiscount" runat="server" Text=""></asp:Label>  
                                                            </td>
                                                            <td align="right" style="width: 11%;" colspan="1" class="GridBottomBorder">
                                                                   <asp:Label ID="lblTotalDeliveryCharges" runat="server" Text=""></asp:Label>  
                                                            </td>
                                                            <td align="right" style="width: 9%;" class="GridBottomBorder">
                                                                <asp:Label ID="lblTotalTaxes" runat="server" Text=""></asp:Label>  
                                                            </td>
                                                            <td align="right" style="width: 9%;" class="GridBottomBorder">
                                                                <asp:Label ID="lblTotalVoids" runat="server" Text=""></asp:Label>&nbsp;  
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="10" style="height:35px;">
                                                                &nbsp;<b style="font-style:italic;">Disclaimer</b>: <span style="font-family:Arial; font-style:italic;">Accuracy of data on this report is not guaranteed, Please verify all numbers before processing.</span> 
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    </FooterTemplate> 
                                                    </asp:TemplateField>
                                                 </Columns>                                                
                                            </asp:GridView>
                                            <asp:ObjectDataSource  
                                                ID="odsOrderDetail" 
                                                runat="server" EnablePaging="false"  
                                                TypeName="SMS_OrderDetail" 
                                                SortParameterName="SortExpression"                                                
                                                SelectMethod="GetSMSGeneralReport">
                                                <SelectParameters> 
                                                    <asp:ControlParameter Name="FromDate" ControlID="DateFrom"  DefaultValue="1/1/2000" Direction="Input"  PropertyName="Text" Type="Datetime"/> 
                                                    <asp:ControlParameter Name="ToDate" ControlID="DateTo" DefaultValue="12/31/2009" Direction="Input"  PropertyName="Text" Type="Datetime"/> 
                                                    <asp:Parameter Name="SortExpression" Direction="Input" Type="string" />       
                                                </SelectParameters> 
                                            </asp:ObjectDataSource>
                                        </ContentTemplate>                                        
                                        <Triggers>                                       
                                         <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                    </div> 
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>          
            </table>
        </div>
        <div align="center" id="ErrorMessage" style="display:none; border:0px solid black; position:absolute;left:25%; top:20%; width: 350px; height: 130px; z-index:1000;">
    <table align="center" width="100%" cellpadding="0" cellspacing="0" class="MainAlertDiv">
        <tr>
            <th style="height:10px;" align="left" valign="middle">&nbsp;Alert</th>
            <th align="right" valign="top"><img src="../../images/closebox2.gif" onclick="CloseErrorMessage(); return false;" style="cursor:pointer;" alt="" /></th>
        </tr>
        <tr style="background-color:#F0F5F9;">
            <td  style="height:25px; background-color:#F0F5F9; padding-left:10px;" colspan="1">
            <div style="font-size:10px;">  
                <asp:Label ID="errLabel" runat="server" Text="Error Occured In Creating Excel Report."></asp:Label>
            </div> 
            </td>
            <td style="background-color:#F0F5F9;">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="2" style="height:30px; background-color:#F0F5F9;" align="center">
            <input type="button" value="OK" style="width:80px;"  onclick="CloseErrorMessage();"  class="btnExtraSimple" />&nbsp;
            </td>
        </tr>
    </table>
</div>
<script type="text/javascript" language="javascript">
  function ShowErrorMessage()
    {
        if(document.getElementById("ErrorMessage").style.display == "none")
        {
            document.getElementById("ErrorMessage").style.display = "inline";
        }
    }
    function CloseErrorMessage()
    {
        if(document.getElementById("ErrorMessage").style.display == "inline")
        {
            document.getElementById("ErrorMessage").style.display = "none";
        }
    }
</script>
    </form>
</body>
</html>
<script type="text/javascript" language="javascript">
   var postbackElement;
    Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(beginRequest);
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(pageLoaded);
    function beginRequest(sender, args) {
        postbackElement = args.get_postBackElement();
        if(document.getElementById("EmptyDiv") != null)
        {
            document.getElementById("EmptyDiv").style.display ="none";
        } 
    }
    function pageLoaded(sender, args) {
        var updatedPanels = args.get_panelsUpdated();
        if (typeof(postbackElement) === "undefined") {
            return;
        } 
        for (i=0; i < updatedPanels.length; i++){
            if (updatedPanels[i].id == '<%= UPReport.ClientID %>') {
                  if(document.getElementById("EmptyDiv") != null)
                  {
                    document.getElementById("EmptyDiv").style.display ="inline";
                  } 
            }
        }
    }
    function ShowReport(StateID,FromDate,ToDate)
    {
        URL = "ReportByLocation.aspx?StateID=" + StateID + "&FromDate=" + FromDate + "&ToDate=" + ToDate + "&BackAction=General";
        window.open(URL); 
    }
</script>
