<%@ Page Language="VB" AutoEventWireup="false" CodeFile="NsProductsReport.aspx.vb" Inherits="Support_NsProducts" Theme="Default" %>
<%@ Register TagPrefix="radcb" Namespace="Telerik.WebControls" Assembly="RadComboBox.Net2" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Support</title>
    <script language="javascript" type="text/javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdateProgress ID="uProgIdeaNotes" runat="server">
        <ProgressTemplate>        
        <div class="ProgressIndicatorDivGray">                            
            <br />
            <img src="../images/indicator.gif" align="absmiddle" /><b>&nbsp;&nbsp;Loading ...</b>
            <br /><br />
        </div>
     </ProgressTemplate>
    </asp:UpdateProgress>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="height:100%;">
  <tr class="GalleryTitle" style="background-image:url('../images/bg_mainHdr_1.jpg');height:31px;">
    <td>&nbsp;<span class="IdeaTitle">Store Support  
    <asp:UpdatePanel ID="upIdeaCount" runat="server" RenderMode="Inline">
        <ContentTemplate>
            <asp:Literal ID="ltrlRecordCount" runat="server" Text="0"></asp:Literal>
        </ContentTemplate>
    </asp:UpdatePanel></span></td>
  </tr>
  <tr  style="height:41px;">
    <td valign="middle">
        <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="height:100%;" class="gvwSearchSilver">
        	<tr>
                <td style="padding:0 0 0 5;">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td>Clients:&nbsp;</td>
                            <td>
                              <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"  RenderMode="inline">
                                <ContentTemplate>				    				    					        
                                <asp:DropDownList ID="ddlClient" CssClass="DarkBlackTextSmall" runat="server" Width="100px" AutoPostBack="true"
                                    DataSourceID="sdsClients" DataTextField="Name" DataValueField="ID" EnableViewState="true"> 
                                </asp:DropDownList>
                                </ContentTemplate>
                                <Triggers>
                                     <asp:AsyncPostBackTrigger ControlID="ddlClient" EventName="SelectedIndexChanged" />
                                </Triggers>
                                </asp:UpdatePanel>
                                <asp:SqlDataSource ID="sdsClients" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                 SelectCommand="Clients_GetAll" SelectCommandType="StoredProcedure" DataSourceMode="DataReader"  ></asp:SqlDataSource>
					        </td>
					    </tr>
					</table>   
                </td>
                <td style="padding-right:5px;padding-left:5px;">
                    <div class="straightline"></div>
                </td>
                <td >
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td>Stores:&nbsp;</td>
                            <td>				    				    
					        <asp:UpdatePanel ID="upStores" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                 <asp:DropDownList ID="ddlStores" CssClass="DarkBlackTextSmall" runat="server" Width="140px" AutoPostBack="true"
                                      DataSourceID="sdsStoresList" DataTextField="StoreNick" DataValueField="ID" EnableViewState="true" >
                                </asp:DropDownList>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddlClient" EventName="SelectedIndexChanged" />
                                </Triggers>
                                </asp:UpdatePanel>
                                <asp:SqlDataSource ID="sdsStoresList" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                     SelectCommand="FranchiseID_GetByClientID_ForList" SelectCommandType="StoredProcedure" DataSourceMode="DataReader">
                                     <SelectParameters>
                                        <asp:ControlParameter ControlID="ddlClient" Name="ClientID" PropertyName="SelectedValue" />
                                     </SelectParameters>
                                </asp:SqlDataSource>
					        </td>
					    </tr>
					</table>   
                </td>
                <td style="padding-right:5px;padding-left:5px;">
                    <div class="straightline"></div>
                </td>
                <td >
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td>Products:&nbsp;</td>
                            <td>
                              <asp:DropDownList ID="ddlProducts" 
                                    CssClass="DarkBlackTextSmall" runat="server" Width="80px" AutoPostBack="true" 
                                    DataSourceID="SDS_Products" DataTextField="Abbreviation" DataValueField="ID" >
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
                <td >
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td nowrap>Start Date:&nbsp;</td>
                            <td nowrap>
                              <asp:TextBox ID="txtStartDate" runat="server" 
                                   MaxLength="10" CssClass="DarkBlackTextSmall"
                                   ReadOnly="true" 
                                   onfocus="imgDDCalander.click();"
                                   Width="80px">
                               </asp:TextBox>
                               <img id="imgDDCalander" align="absMiddle"  border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtStartDate.ClientID %>', 'MMM dd, yyyy');"
                                   onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" />
					        </td>
                        </tr>
                    </table>                    	                    
                </td>
                <td style="padding-right:5px;padding-left:5px;">
                    <div class="straightline"></div>
                </td>
                <td >
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td nowrap>End Date:&nbsp;</td>
                            <td nowrap>
                              <asp:TextBox ID="txtEndDate" runat="server" 
                                   MaxLength="10" CssClass="DarkBlackTextSmall"
                                   ReadOnly="true" 
                                   onfocus="imgMMCalander.click();"
                                   Width="80px">
                               </asp:TextBox>
                               <img id="imgMMCalander" align="absMiddle"  border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtEndDate.ClientID %>', 'MMM dd, yyyy');"
                                   onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" />
					        </td>
                        </tr>
                    </table>                    	                    
                </td>
               <td style="padding-right:5px;padding-left:5px;">
                    <div class="straightline"></div>
                </td>
                <td  >
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td colspan="2" >
                             <span style="font-size:10px;">Status:</span><br />	
                              <asp:DropDownList ID="ddlStoreStatus" CssClass="DarkBlackTextSmall" runat="server" Width="100px" AutoPostBack="true" >
                                    <asp:ListItem Text="Show All" Value="0" Selected="True" ></asp:ListItem>
                                    <asp:ListItem Text="Coming Soon" Value="1" ></asp:ListItem>
                                    <asp:ListItem Text="Operating" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Corporate" Value="3" ></asp:ListItem>
                                    <asp:ListItem Text="Terminated" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="Suspended" Value="5" ></asp:ListItem>
                                    <asp:ListItem Text="Transferred" Value="6"></asp:ListItem>
                             </asp:DropDownList>
					        </td>
                        </tr>
                    </table>                    	                    
                </td>
                <td style="display:none;">
                    <div class="straightline"></div>
                </td>
                <td  style="width:170px;display:none;">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td>&nbsp;&nbsp;Status:&nbsp;</td>
                            <td>
                              <asp:DropDownList ID="ddlFilters" CssClass="DarkBlackTextSmall" runat="server" Width="80px" AutoPostBack="true" >
                                    <asp:ListItem Text="Show All" Value="-1" Selected="True" ></asp:ListItem>
                                    <asp:ListItem Text="Active" Value="0" ></asp:ListItem>
                                    <asp:ListItem Text="Inactive" Value="1"></asp:ListItem>
                             </asp:DropDownList>
					        </td>
                        </tr>
                    </table>                    	                    
                </td>
                <td style="width:80%;">
                    
                </td>           
                <td align="right" style="display:none;">
                    <table cellpadding="0" cellspacing="0" border="0" style="width:100px;">
                        <tr>
                            <td>Search:&nbsp;</td>
                            <td><asp:TextBox ID="txtSearch" runat="server" style="height:20px;" MaxLength="20"></asp:TextBox>&nbsp;</td>
                            <td>
                                <asp:Button ID="btnSearch" runat="server" Text="Go" CssClass="btnSilver" Width="37px" />&nbsp;&nbsp;&nbsp;
                            </td>
                        </tr>
                    </table>                	
                </td>
            </tr>
        </table>
        </asp:Panel>
    </td>
  </tr>
  <tr style="height:100%;">
    <td valign="top">
    <div id="divScroll" style="height:100%; width:100%; overflow-y:auto;" class="GrayScrollBar">    
    <asp:UpdatePanel ID="upKeys" runat="server" UpdateMode="Conditional">        
    <ContentTemplate>    
        <asp:GridView ID="gvSupport" runat="server" AutoGenerateColumns="False" Width="100%"  SkinID="gvwSilver"
            DataSourceID="odsSupport" AllowPaging="true" AllowSorting="true" Height="100%" ShowFooter="true" EnableViewState="true">
            <Columns>
                 <asp:TemplateField HeaderText="St #" SortExpression="StoreNumber"  >
                    <ItemTemplate>
                        <%# Eval("StoreNumber") %>
                    </ItemTemplate>                   
                    <HeaderStyle Width="4%" />
                    <FooterTemplate>
                        &nbsp;
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Store Nick" SortExpression="StoreNick" >
                    <ItemTemplate>
                       <span title='<%# Eval("StoreNick") %>'><%#Functions.StringTruncate(Eval("StoreNick"), 16)%></span>
                    </ItemTemplate>
                    <FooterTemplate>
                        &nbsp;
                    </FooterTemplate>
                    <HeaderStyle Width="10%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Client" SortExpression="ClientCode">
                    <ItemTemplate>
                        <%#Eval("ClientCode")%>
                    </ItemTemplate>
                    <FooterTemplate>
                        &nbsp;
                    </FooterTemplate>
                    <HeaderStyle Width="5%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Product" SortExpression="ProductName">
                    <ItemTemplate>
                        <%#Eval("ProductName")%>
                    </ItemTemplate>
                    <FooterTemplate>
                        &nbsp;
                    </FooterTemplate>
                    <HeaderStyle Width="7%" />
                </asp:TemplateField> 
                <asp:TemplateField HeaderText="Monthly Charges" SortExpression="" >
                    <ItemTemplate>
                        <%#Functions.IfNull(Eval("Price"), 0)%>
                    </ItemTemplate>
                    <FooterTemplate>
                        &nbsp;
                    </FooterTemplate>
                    <HeaderStyle Width="5%" />
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
        <asp:AsyncPostBackTrigger ControlID="ddlFilters" EventName="SelectedIndexChanged" />
        <asp:AsyncPostBackTrigger ControlID="ddlStores" EventName="SelectedIndexChanged" />
        <asp:AsyncPostBackTrigger ControlID="ddlStoreStatus" EventName="SelectedIndexChanged" />
        <asp:AsyncPostBackTrigger ControlID="ddlProducts" EventName="SelectedIndexChanged" />
        <asp:AsyncPostBackTrigger ControlID="btnRebindGrid" EventName="Click" />
        <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                                
    </Triggers>
    </asp:UpdatePanel>        
    </div>
    </td>
  </tr>  
  <tr id="trPager"><td id="tdPager"></td></tr>  
</table>
<div id="divNewLicense" style="display:none;position:absolute; height:355px; width:350px;">
     <table border="0" cellpadding="0" cellspacing="0" style="height:100%;" class="tblAddFolder pad5px">
        <tr>
            <th colspan="2" align="left" style="height:25px;" >
                <label id="lblAlbumHeading">Create new license</label>
            </th>                
        </tr>
        <tr>
            <td align="center">
                <iframe id="ifNewLicense" width="100%" height="100%" frameborder="0" src="../BlankPage.htm" marginheight="0" marginwidth="0" scrolling="no"></iframe>
            </td>
        </tr>
      </table>      
</div>
<asp:Button ID="Button1" runat="server" Text="Rebind Grid" style="display:none" />
<asp:Button ID="btnRebindGrid" runat="server" Text="Rebind Grid" style="display:none;" />
<asp:ObjectDataSource ID="odsSupport" runat="server"    
      EnablePaging="true" EnableViewState="true" SortParameterName="sortBy"
      MaximumRowsParameterName="maximumRows" 
      StartRowIndexParameterName="startRowIndex" 
      TypeName="Portal.BLL.NS.NS_Products_Franchises" 
      SelectMethod="NS_Products_FranchisesGetAllForSupport"
      SelectCountMethod="NS_Products_FranchisesGetAllCountForSupport">
    <SelectParameters>
        <asp:ControlParameter ControlID="txtSearch" Name="search" DefaultValue="" PropertyName="Text" />
        <asp:ControlParameter ControlID="ddlClient" Name="ClientID" PropertyName="SelectedValue"  Type="Int32" />
        <asp:ControlParameter ControlID="ddlFilters" Name="Inactive" PropertyName="SelectedValue" Type="Int32" />
        <asp:ControlParameter ControlID="ddlStores" Name="StoreID" PropertyName="SelectedValue"   Type="Int32" />
        <asp:ControlParameter ControlID="ddlStoreStatus" Name="StoreStatus" PropertyName="SelectedValue"   Type="Int32" />
        <asp:ControlParameter ControlID="ddlProducts" Name="ProductID" PropertyName="SelectedValue" Type="Int32" />        
    </SelectParameters>
</asp:ObjectDataSource>
 
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
                    document.getElementById('<%= txtsearch.ClientID %>').value='';                                 
                }
            }
        }
        function onPageLoading(sender, e){
        } 
        function RebindRecords(){
           document.getElementById('<%= btnRebindGrid.ClientID %>').click(); 
        } 
        function ShowDetail(licenseId){
           window.location='SMSLicenseDetail.aspx?ID='+licenseId;
        }
    </script>
    </form>
</body>
</html>
