<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SupportDetail.aspx.vb" Inherits="Support_SupportDetail" Theme="Default" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>On Support Report</title>
    <script language="javascript" type="text/javascript" src="../scripts/functions.js"></script>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />   
</head>
<body style="font-family:Arial;" >
   <form id="form1" runat="server">
   <div>
   <asp:Label ID="hdnReportID" runat="server" Text="" style="display:none;" ></asp:Label>
   <asp:Label ID="hdnReportDate" runat="server" Text="" style="display:none;" ></asp:Label>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <table style="height:100%;width:100%;" cellpadding ="0" cellspacing="0" border ="0">                            
                    <tr>
                        <td style="border:0px;height:25;border-bottom:solid 1px #71AF89;" valign="top">
                        <table style="padding:5px; font-size:13px;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#ffffff,endColorStr=#F7BB0F); margin: 0px; border: 0px; height:100%;" cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td>
                                    <b>Support Billing Report for <asp:Label ID="lbltitle" runat="server" ></asp:Label> 
                                    <asp:UpdatePanel ID="upIdeaCount" runat="server" RenderMode="Inline">
                                        <ContentTemplate>
                                            <asp:Literal ID="ltrlRecordCount" runat="server" Text="0" Visible="false"></asp:Literal>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    </b>
                                </td>
                                <td align="right" >
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always" >        
                                  <ContentTemplate>
                                   <asp:DropDownList ID="ddlMonths" CssClass="DarkBlackTextSmall" runat="server" Width="100px" AutoPostBack="true" style="display:none;">
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
                                 <asp:DropDownList ID="ddlYears" CssClass="DarkBlackTextSmall" runat="server" Width="80px" AutoPostBack="true" style="display:none;">
                                        <asp:ListItem Text="2008" Value="2008" ></asp:ListItem>
                                        <asp:ListItem Text="2009" Value="2009" ></asp:ListItem>
                                  </asp:DropDownList>
                                   <iframe name="frmXLS" id="frmXLS" src="../BlankPage.htm" height="0" width="0" frameborder="0" scrolling="no"></iframe>
                                   <img alt=""  src="../images/print.gif" align="absmiddle" style="cursor: pointer;vertical-align:bottom;" onclick="event.cancelBubble=true;NavigateToPrintVersion();" />
                                   <a href="#" onclick="event.cancelBubble=true;NavigateToPrintVersion();" ><span style="cursor: pointer; font-size: 10px; color: #316155; text-decoration: underline;">Printable Version</span></a>
                                   <img alt=""  src="../images/icn_dwnldExcel.jpg" align="absmiddle" style="cursor: pointer;padding:0px;margin:0px;border:0px;height:19px;  " onclick="javascript:OnXLSDownload();" />
                                   <a href="#"><span style="cursor: pointer; font-size: 10px; color: #316155; text-decoration: underline;" onclick="javascript:OnXLSDownload();">Download XLS</span></a>
                                   &nbsp;
                                   <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btnSilver" Width="50px" />  
                                   &nbsp;
                                 </ContentTemplate>                           
                                </asp:UpdatePanel>     
                                </td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                      <tr  style="height:41px;">
                        <td valign="middle" colspan="2">
                            <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
    	                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="height:100%;" class="gvwSearchSilver">
        	                    <tr>
        	                        <td style="padding-left:3px;">
                                        &nbsp;
                                    </td>
                                    <td >
                                        <table cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td colspan="2" >
                                                 <span style="font-size:10px;">Clients:</span><br />
                                               				    				    					        
                                                    <asp:DropDownList ID="ddlClient" CssClass="DarkBlackTextSmall" runat="server" Width="150px" AutoPostBack="true"
                                                        DataSourceID="sdsClients" DataTextField="Name" DataValueField="ID" EnableViewState="true"> 
                                                    </asp:DropDownList>
                                                    <asp:SqlDataSource ID="sdsClients" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                        SelectCommand="Clients_GetAll" SelectCommandType="StoredProcedure" DataSourceMode="DataReader"  ></asp:SqlDataSource>
					                            </td>
					                        </tr>
					                    </table>   
                                    </td>
                                    <td style="padding-right:5px;padding-left:5px;">
                                        <div class="straightline"></div>
                                    </td>
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td colspan="2" >
                                                 <span style="font-size:10px;">Products:</span><br />		
                                                 <asp:DropDownList ID="ddlProducts" 
                                                        CssClass="DarkBlackTextSmall" runat="server" Width="150px" AutoPostBack="true" 
                                                        DataSourceID="SDS_Products" DataTextField="TitleAbbreviation" DataValueField="ID" >
                                                 </asp:DropDownList>
                                                 <asp:SqlDataSource ID="SDS_Products" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                        SelectCommand="NS_Products_GetForList" SelectCommandType="StoredProcedure" DataSourceMode="DataReader"  >
                                                    <SelectParameters>
                                                        <asp:Parameter Name="Type" DefaultValue="4"  Type="Int32" />
                                                        <asp:Parameter Name="ParentID" DefaultValue="0" Type="Int32" />
                                                    </SelectParameters>
                                                  </asp:SqlDataSource>                         
					                            </td>
                                            </tr>
                                        </table>                    	                    
                                    </td>
                                    <td style="padding-right:5px;padding-left:5px;">
                                        <div class="straightline"></div>
                                    </td>
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td colspan="2" >
                                                 <span style="font-size:10px;">Status:</span><br />	
                                                  <asp:DropDownList ID="ddlStatus" CssClass="DarkBlackTextSmall" runat="server" Width="150px" AutoPostBack="true" >
                                                        <asp:ListItem Text="Show All" Value="0" Selected="True" ></asp:ListItem>
                                                        <asp:ListItem Text="Exempted Only" Value="1" ></asp:ListItem>
                                                        <asp:ListItem Text="Partial Only" Value="2"></asp:ListItem>
                                                        <asp:ListItem Text="Exempted & Partial" Value="3" ></asp:ListItem>
                                                 </asp:DropDownList>
					                            </td>
                                            </tr>
                                        </table>                    	                    
                                    </td>
                                    <td style="width:40%;">
                                        &nbsp;
                                    </td>            
                                    <td align="right">
                                        <table cellpadding="0" cellspacing="0" border="0" style="width:100px;">
                                            <tr>
                                                <td style="padding-right:10px;">
                                                  <span style="font-size:10px;">Search:</span><br />
                                                  <asp:TextBox ID="txtSearch" runat="server" style="height:20px;" MaxLength="20"></asp:TextBox>&nbsp;
                                                  <asp:Button ID="btnSearch" runat="server" Text="Go" CssClass="btnSilver" Width="37px" />
                                                </td>
                                            </tr>
                                        </table>                	
                                    </td>
                                </tr>
                            </table>
                            </asp:Panel>
                        </td>
                      </tr>
                    <tr>
                        <td style="border:0;" valign="top">
                        <div id="divscroll" style="height:100%; width:100%; overflow-y:auto;">
                        <asp:UpdatePanel ID="upKeys" runat="server" UpdateMode="Conditional" >        
                           <ContentTemplate>
                           <asp:Label ID="hdnsortby" runat="server" Text="" style="display:none;" ></asp:Label>
                            <asp:GridView ID="gvFranchiseSupport" runat="server" AutoGenerateColumns="False" Width="100%"  SkinID="gvwSilver"
                             DataSourceID="odsSupport" AllowPaging="true" AllowSorting="true" Height="100%" ShowFooter="true" EnableViewState="true" >
                                <Columns>
                                     <asp:TemplateField HeaderText="<b>St #" SortExpression="StoreNumber"  >
                                        <ItemTemplate><%#Eval("StoreNumber")%></ItemTemplate>
                                        <FooterTemplate>&nbsp;</FooterTemplate>
                                        <HeaderStyle Width="3%" Font-Bold="true"/>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="<b>Store Nick" SortExpression="StoreNick" >
                                        <ItemTemplate>
                                           <span title='<%# Eval("StoreNick") %>'><%#Functions.StringTruncate(Eval("StoreNick"), 25)%></span>
                                        </ItemTemplate>
                                        <FooterTemplate>&nbsp;</FooterTemplate>
                                        <HeaderStyle Width="20%" Font-Bold="true"/>
                                        <FooterStyle VerticalAlign="Bottom" />
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="<b>Client" SortExpression="ClientCode" >
                                        <ItemTemplate><%#Eval("Code")%></ItemTemplate>
                                        <FooterTemplate>&nbsp;</FooterTemplate>
                                        <HeaderStyle Width="4%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="<b>Product Name" SortExpression="Title">
                                        <ItemTemplate><%#Eval("Title")%></ItemTemplate>
                                        <FooterTemplate>&nbsp;</FooterTemplate>
                                        <HeaderStyle Width="15%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="<b>Billing From" SortExpression="BillingFrom">
                                        <ItemTemplate><%#CDate(Eval("BillingFrom")).ToString("MMM dd, yyyy")%></ItemTemplate>
                                        <FooterTemplate>&nbsp;</FooterTemplate>
                                        <HeaderStyle Width="8%" Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="<b>Billing To" SortExpression="BillingTo">
                                        <ItemTemplate><%#CDate(Eval("BillingTo")).ToString("MMM dd, yyyy")%></ItemTemplate>
                                        <FooterTemplate>&nbsp;</FooterTemplate>
                                        <HeaderStyle Width="8%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="<b>Price" SortExpression="Rate">
                                        <ItemTemplate><%#FormatNumber(Eval("Rate"), 2)%></ItemTemplate>
                                        <FooterTemplate>&nbsp;</FooterTemplate>
                                        <HeaderStyle Width="5%" Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="<b>Amount" SortExpression="BillingAmount">
                                        <ItemTemplate><%#FormatNumber(Eval("BillingAmount"), 2)%></ItemTemplate>
                                        <FooterTemplate>&nbsp;</FooterTemplate>
                                        <HeaderStyle Width="5%" Font-Bold="true" />
                                        <FooterStyle VerticalAlign="Bottom"  />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="<b>Status" >
                                        <ItemTemplate><asp:Label ID="lblBillingType" runat="server" ></asp:Label></ItemTemplate>
                                        <FooterTemplate>&nbsp;</FooterTemplate>
                                        <HeaderStyle Width="15%" Font-Bold="true" />
                                        <ItemStyle Wrap="false" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" SortExpression="" Visible="false" >
                                        <ItemTemplate></ItemTemplate>
                                        <FooterTemplate>&nbsp;</FooterTemplate>
                                        <HeaderStyle Width="10%" />
                                    </asp:TemplateField>                                    
                                </Columns>
                                <EmptyDataTemplate>                
                                     <table class="NoRecord">
                                        <tr>                            
                                            <td>
                                                <img align="absmiddle" src="../../images/ico_alert.gif" />&nbsp;&nbsp;No Submissions Found !
                                            </td>
                                        </tr>
                                     </table>                
                                </EmptyDataTemplate>            
                                <PagerSettings Mode="NextPreviousFirstLast" Visible="true" Position="Bottom" />
                                <PagerTemplate>
                                    <table id="tblPager" width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>                        
                                           <td style="border:0; width:85%;">Showing Licenses <asp:Literal ID="ltrlStartCount" runat="server" Text="0"></asp:Literal> to <asp:Literal ID="ltrlEndCount" runat="server" Text="0"></asp:Literal> of <asp:Literal ID="ltrlTotalCount" runat="server" Text="0"></asp:Literal></td> 
                                           <td style="border:0;white-space:nowrap;" align="right" nowrap>Page&nbsp;<asp:Literal ID="ltrlStartPage" runat="server" Text="0"></asp:Literal> of <asp:Literal ID="ltrlLastPage" runat="server" Text="0"></asp:Literal>&nbsp;&nbsp;&nbsp;<asp:LinkButton ID="lnkBtnFirst" runat="server" CommandName="page" CommandArgument="first"><asp:Image ID="imgFirst" runat="server" ImageUrl="../images/First_blk.jpg" ToolTip="First" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnPrevious" runat="server" CommandName="page" CommandArgument="prev"><asp:Image ID="imgPrevious" runat="server" ImageUrl="../images/back_blk.jpg" ToolTip="Previous" /></asp:LinkButton> &nbsp;<asp:LinkButton ID="lnkBtnNext" runat="server" CommandName="page" CommandArgument="next"><asp:Image ID="imgNext" runat="server" ImageUrl="../images/Next_blk.jpg"  ToolTip="Next" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnLast" runat="server" CommandName="page" CommandArgument="last"><asp:Image ID="imgLast" runat="server" ImageUrl="../images/Last_blk.jpg" ToolTip="Last" /></asp:LinkButton>&nbsp;&nbsp;&nbsp;</td>
                                        </tr>
                                    </table>
                                </PagerTemplate>                       
                            </asp:GridView>
                           </ContentTemplate>
                           <Triggers>
                             <asp:AsyncPostBackTrigger ControlID="ddlClient" EventName="SelectedIndexChanged" />
                             <asp:AsyncPostBackTrigger ControlID="ddlStatus" EventName="SelectedIndexChanged" />
                             <asp:AsyncPostBackTrigger ControlID="ddlProducts" EventName="SelectedIndexChanged" />
                             <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />  
                           </Triggers>
                            </asp:UpdatePanel>
                            <asp:ObjectDataSource ID="odsSupport" runat="server"    
                              EnablePaging="true" EnableViewState="true" SortParameterName="sortBy"
                              MaximumRowsParameterName="maximumRows" 
                              StartRowIndexParameterName="startRowIndex" 
                              TypeName="Portal.BLL.NS.NS_BillingReport" 
                              SelectMethod="NS_BillingReportGetForFranchises"
                              SelectCountMethod="NS_BillingReportGetForFranchisesCount">
                            <SelectParameters>
                                <asp:QueryStringParameter QueryStringField="ReportID" Name="ReportID" Type="Int32" />
                                <asp:ControlParameter ControlID="ddlClient" Name="ClientID" PropertyName="SelectedValue"  Type="Int32" />
                                <asp:ControlParameter ControlID="ddlProducts" Name="ProductID" PropertyName="SelectedValue" Type="Int32" />
                                <asp:Parameter Name="FranchiseID" DefaultValue="0"  Type="Int32" />
                                <asp:ControlParameter ControlID="txtSearch" Name="Search" DefaultValue="" PropertyName="Text" />
                                <asp:ControlParameter ControlID="ddlStatus" Name="Status" PropertyName="SelectedValue"  Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                         <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="always" >        
                           <ContentTemplate>
                            <table id="gvfottor2" runat="server" border="0" cellpadding="0" cellspacing="0" style="height:30px;width:100%;background-color: #E9E9E9; border:solid 1px #B7CFE2;display:none;">
                                <tr style="HEIGHT: 30px;" >
                                    <td class="TableHeading" align="left" style="border:0px; padding-left:4px">Amount Total&nbsp;</td>
                                    <td class="TableHeading" style="WIDTH: 30%;border:0px;padding-right:4px" ><asp:Label ID="lblBillingAmountTotal" runat="server" Text="255.23"></asp:Label>&nbsp;</td>
                               </tr>
                            </table>
                            </ContentTemplate> 
                          </asp:UpdatePanel> 
                        </div>        
                        </td>
                    </tr>
                  </table>
                
        </div>
   <script language="javascript" type="text/javascript">
           function ChangeRowsClass(){
            var element = getElementByClassName('gvwSilverFooter');
            if(element!=null){
                element.className='gvwSilverFooterOdd';
            }
        } 
        
        function SetRowStyle(){
            var element = getElementByClassName('gvwSilverFooterOdd');
            if(element!=null){
                element.className='gvwSilverFooter';
            }           
        }
        
        AdjustPagerRow();
        
        function AdjustPagerRow(){                          
            var objTag = null;
            var objCustomRow = null;
            try{
            trPager.style.display='inline';
            objCustomRow = getElement("tdPager");
            objTag = getElementByClassName("gvwSilverPager");
            objCustomRow.innerHTML ='&nbsp;';
            if (objTag != null && objCustomRow != null)
            {        
                var objPagerHTML = getElement('tblPager').outerHTML;
                objCustomRow.innerHTML = objPagerHTML;
                objCustomRow.className = "cpygvwSilverPager";
                objTag.style.display = 'none';
            }
            else
            {
                //if the pager has not been displayed hide the row.
                trPager.style.display='none';
            }
            }catch(ex){
                //alert("Javascript Error:\n"+ex.description);
            }            
        }    
        var postbackElement;
        Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(beginRequest);
        Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(pageLoaded);
        Sys.WebForms.PageRequestManager.getInstance().add_pageLoading(onPageLoading);
        
        function beginRequest(sender, args) {
            postbackElement = args.get_postBackElement();
        }
        
        function pageLoaded(sender, args) {
            var updatedPanels = args.get_panelsUpdated();
            if (typeof(postbackElement) === "undefined") {
                return;
            } 
            for (i=0; i < updatedPanels.length; i++){
                if (updatedPanels[i].id == '<%= upKeys.ClientID %>') {                                     
                    AdjustPagerRow();                
                }
            }
        }
        function onPageLoading(sender, e) {
        }
     function trFooterClass(trclassname)
     {
        document.getElementById('trFooter').className = trclassname
     } 
     function NavigateToPrintVersion()
     {  
        var URL;
        //var QueryStringValues = "<%= Request.QueryString() %>";
        var QueryStringValues = "Search="+document.getElementById ("<%=txtSearch.ClientID%>").value;
        QueryStringValues += "&ClientID="+document.getElementById('<%=ddlClient.ClientID%>').value;
        QueryStringValues += "&Status=" + document.getElementById('<%=ddlStatus.ClientID %>').value;  
        QueryStringValues += "&ProductID=" + document.getElementById('<%=ddlProducts.ClientID %>').value;
        QueryStringValues += "&ReportID=" + document.getElementById('<%=hdnReportID.ClientID %>').innerText;
        QueryStringValues += "&ReportDate=" + document.getElementById('<%=hdnReportDate.ClientID %>').innerText;
        QueryStringValues += "&sortBy=" + document.getElementById('<%=hdnsortby.ClientID %>').innerText;
        URL = "SupportDetailReport.aspx?" + QueryStringValues;
        window.open(URL);  
    }
    function OnXLSDownload()        
    {   
        var URL;
        //var QueryStringValues = "<%= Request.QueryString() %>";
        var QueryStringValues = "Search="+document.getElementById ("<%=txtSearch.ClientID%>").value;
        QueryStringValues += "&ClientID="+document.getElementById('<%=ddlClient.ClientID%>').value;
        QueryStringValues += "&Status=" + document.getElementById('<%=ddlStatus.ClientID %>').value;  
        QueryStringValues += "&ProductID=" + document.getElementById('<%=ddlProducts.ClientID %>').value;
        QueryStringValues += "&ReportID=" + document.getElementById('<%=hdnReportID.ClientID %>').innerText;
        QueryStringValues += "&ReportDate=" + document.getElementById('<%=hdnReportDate.ClientID %>').innerText;
        QueryStringValues += "&sortBy=" + document.getElementById('<%=hdnsortby.ClientID %>').innerText;
        URL = "SupportDetailReport.aspx?" + QueryStringValues+'&IsXLS=True';         
        getElement('frmXLS').src=URL;
    }
    function AdjustHeight(bit)
    { 
      if(bit == 0)
        {
        document.getElementById('<%=gvFranchiseSupport.ClientID%>').style.height = document.getElementById('<%=gvFranchiseSupport.ClientID%>').offsetHeight - 34;
        document.getElementById('<%=gvfottor2.ClientID%>').style.display = 'inline';    
        }
      else
      {
        document.getElementById('<%=gvfottor2.ClientID%>').style.visibility = 'hidden';
        document.getElementById('<%=gvFranchiseSupport.ClientID%>').style.height = document.getElementById('<%=gvFranchiseSupport.ClientID%>').offsetHeight-100;
      }   
          
    }
     var x,y;
     function findPos(obj)
     {
         var left = !!obj.offsetLeft ? obj.offsetLeft : 0;
         var top = !!obj.offsetTop ? obj.offsetTop : 0;

         while(obj = obj.offsetParent)
         {
          left += !!obj.offsetLeft ? obj.offsetLeft : 0;
          top += !!obj.offsetTop ? obj.offsetTop : 0;
         }
         x = left;
         y = top;
     }
   </script>
   </form>
</body>
</html>
