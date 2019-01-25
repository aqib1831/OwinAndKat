<%@ Page Language="VB" AutoEventWireup="false" CodeFile="QsLicenseManagement.aspx.vb" Inherits="LM_QsLicenseManagement" Theme="Default" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Qs License Management</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
</head>
<body onclick="CloseNewLicenseDiv();" style="margin:0px;padding:0px;">
    <form id="form1" runat="server">
    <script language="javascript" type="text/javascript">
     function setValues(SExp)
     {
            document.getElementById('<%=hdnSortBy.ClientID %>').value = SExp;
     }
    </script>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:HiddenField ID="hdnSortBy" runat="server" />
         <asp:HiddenField ID="hdnSearch" runat="server" />
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
    <td>&nbsp;<span class="IdeaTitle">Qs License - 
    <asp:UpdatePanel ID="upIdeaCount" runat="server" RenderMode="Inline">
        <ContentTemplate>
            <asp:Literal ID="ltrlRecordCount" runat="server" Text="0"></asp:Literal>
        </ContentTemplate>
    </asp:UpdatePanel></span></td>
    <td align="right" style="padding-right:5px">
        <table cellpadding="0" cellspacing="0">
        <tr>
    <td  style="padding-right:5px;" align="right">
        <iframe name="frmXLS" id="frmXLS" src="../BlankPage.htm" height="0" width="0" frameborder="0" scrolling="no"></iframe>
        <img alt=""  src="../images/print.gif" align="absmiddle" style="cursor: pointer;vertical-align:bottom;" onclick="event.cancelBubble=true;NavigateToPrintVersion();" />
        <a href="#" onclick="event.cancelBubble=true;NavigateToPrintVersion();" ><span style="cursor: pointer; font-size: 10px; color: #316155; text-decoration: underline;">Printable Version</span></a>
        <img alt=""  src="../images/icn_dwnldExcel.jpg" align="absmiddle" style="cursor: pointer;padding:0px;margin:0px;border:0px;height:19px;  " onclick="javascript:OnXLSDownload();" />
        <a href="#"><span style="cursor: pointer; font-size: 10px; color: #316155; text-decoration: underline;" onclick="javascript:OnXLSDownload();">Download XLS</span></a>
        
    </td>
   <td style="padding-top:3px">
   <img src="../images/btn_ResetFilters.jpg" valign="absMiddle" style="cursor:pointer;" onclick="javascript:resetFilters();"/>
   </td>
    </tr>
        
        </table>
        
        </td>
        
  </tr>
  <tr  style="height:41px;">
    <td valign="middle" colspan="3" >
        <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="height:100%;" class="gvwSearchSilver">
        	<tr>
            	<td style="width:100px;" align="center" id="tdnewbtn" runat="server">
            	   <div id="divNewKey" style="padding:4 2 4 2; width:90px;">
            	    <input id="btnNewLicense" runat="server" type="button" onclick="event.cancelBubble=true;ShowNewLicenseDiv();" class="btnSilver" value="New License" style="width:80px;"/>
            	   </div>
                </td>
                <td style="padding-right:5px;">
                    <div class="straightline"></div>
                </td>
                <td style="width:180px;">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td>Clients:&nbsp;</td>
                            <td>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always" RenderMode="Inline"  >
                                <ContentTemplate>				    				    					        
                                <asp:DropDownList ID="ddlClient" CssClass="DarkBlackTextSmall" runat="server" Width="120px" AutoPostBack="true"
                                    DataSourceID="sdsClients" DataTextField="Name" DataValueField="ID" EnableViewState="true"> 
                                </asp:DropDownList>
                                  </ContentTemplate>
                                </asp:UpdatePanel>                         
					        </td>
					    </tr>
					</table>   
                </td>
                <td style="padding-right:5px;">
                    <div class="straightline"></div>
                </td>
                <td align="right" style="width:140px;">
                    <table cellpadding="0" cellspacing="0" border="0" style="width:100px;">
                        <tr>
                            <td>State:&nbsp;</td>
                            <td>
                                    <asp:DropDownList ID="ddlStates" CssClass="DarkBlackTextSmall" runat="server" Width="120px" AutoPostBack="true"
                                          DataSourceID="sdsStates" DataTextField="Name" DataValueField="ID" EnableViewState="true" >
                                    </asp:DropDownList>
                            </td>
                        </tr>
                    </table>                	
                </td>    
                <td>
                    <div class="straightline"></div>
                </td>
                <td  style="width:170px;">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td>&nbsp;&nbsp;Status:&nbsp;</td>
                            <td>
                            <asp:DropDownList ID="ddlFilters" CssClass="DarkBlackTextSmall" runat="server" Width="100px" AutoPostBack="true" >
                                    <asp:ListItem Text="Show All" Value="-1"></asp:ListItem>
                                    <asp:ListItem Text="Active" Value="0" Selected="True" ></asp:ListItem>
                                    <asp:ListItem Text="InActive" Value="1"></asp:ListItem>
                                </asp:DropDownList>
					        </td>
                        </tr>
                    </table>                    	                    
                </td>    
                       
                <td align="right">
                    <table cellpadding="0" cellspacing="0" border="0" style="width:100px;">
                        <tr>
                            <td>Search:&nbsp;</td>
                            <td><asp:TextBox ID="txtSearch"  onfocus="javascript:this.value='';" onkeyup="if(CheckNoisyWord()==false) return false;" runat="server" style="height:20px;" MaxLength="50"></asp:TextBox>&nbsp;</td>
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
    <td valign="top" colspan="3">
    <div id="divScroll" style="height:100%; width:100%; overflow-y:auto;" class="GrayScrollBar">    
    <asp:UpdatePanel ID="upKeys" runat="server" UpdateMode="Conditional">        
    <ContentTemplate>    
        <asp:GridView ID="gvwKeys" runat="server" AutoGenerateColumns="False" Width="100%"  SkinID="gvwSilver"
            DataSourceID="odsQsLicenese" AllowPaging="true" AllowSorting="true" Height="100%" ShowFooter="true" EnableViewState="true">
            <Columns>
                 <asp:TemplateField HeaderText="St #" SortExpression="StoreNumber" >
                    <ItemTemplate>
                         <div align="right"><%# Eval("StoreNumber") %>&nbsp;</div>
                    </ItemTemplate>                   
                    <HeaderStyle Width="5%" />
                    <FooterTemplate>
                        &nbsp;
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Store Nick" SortExpression="StoreNick" >
                    <ItemTemplate>
                       <span title='<%# Eval("StoreNick") %>'><%#Functions.StringTruncate(Eval("StoreNick"), 35)%></span>
                    </ItemTemplate>
                    <FooterTemplate>
                        &nbsp;
                    </FooterTemplate>
                    <HeaderStyle Width="18%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Client" SortExpression="Client">
                    <ItemTemplate>
                        <%#Eval("ClientCode")%>
                    </ItemTemplate>
                    <FooterTemplate>
                        &nbsp;
                    </FooterTemplate>
                    <HeaderStyle Width="6%" />
                </asp:TemplateField>                                
                <asp:TemplateField HeaderText="IP" SortExpression="SystemIP">
                    <ItemTemplate>
                        <%#IIf(Eval("IsDynamicIP"), "Dynamic IP", Eval("SystemIP"))%>
                    </ItemTemplate>
                    <HeaderStyle Width="10%" />
                </asp:TemplateField>                                                               
                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <%#IIf(Eval("Inactive") = True, "Inactive", "Active")%>
                    </ItemTemplate>
                    <FooterTemplate>
                        &nbsp;
                    </FooterTemplate>
                    <HeaderStyle Width="6%" />
                </asp:TemplateField>
                
                <asp:TemplateField HeaderText="No of License">
                    <ItemTemplate>
                      <div align="right"><%#IIf(Eval("TerminalCount") Is DBNull.Value, 0, Eval("TerminalCount"))%> </div>
                    </ItemTemplate>
                    <FooterTemplate>
                        &nbsp;
                    </FooterTemplate>
                    <HeaderStyle Width="7%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="No of Live Terminal">
                    <ItemTemplate>
                       <div align="center"><%--<%#Eval("LiveTerminalCount")%>--%>-</div>
                    </ItemTemplate>
                    <FooterTemplate>
                        &nbsp;
                    </FooterTemplate>
                    <HeaderStyle Width="10%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Last Reported">
                    <ItemTemplate>
                        <%#IIf(Eval("LastReported") Is DBNull.Value, String.Format("{0:MMM dd, yyyy}", Eval("IssuedOn")), String.Format("{0:MMM dd, yyyy}", Eval("LastReported")))%>
                    </ItemTemplate>
                    <FooterTemplate>
                        &nbsp;
                    </FooterTemplate>
                    <HeaderStyle Width="11%" />
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
                       <td style="border:0;" align="right" nowrap="nowrap">Page&nbsp;<asp:Literal ID="ltrlStartPage" runat="server" Text="0"></asp:Literal> of <asp:Literal ID="ltrlLastPage" runat="server" Text="0"></asp:Literal>&nbsp;&nbsp;&nbsp;<asp:LinkButton ID="lnkBtnFirst" runat="server" CommandName="page" CommandArgument="first"><asp:Image ID="imgFirst" runat="server" ImageUrl="../images/First_blk.jpg" ToolTip="First" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnPrevious" runat="server" CommandName="page" CommandArgument="prev"><asp:Image ID="imgPrevious" runat="server" ImageUrl="../images/back_blk.jpg" ToolTip="Previous" /></asp:LinkButton> &nbsp;<asp:LinkButton ID="lnkBtnNext" runat="server" CommandName="page" CommandArgument="next"><asp:Image ID="imgNext" runat="server" ImageUrl="../images/Next_blk.jpg"  ToolTip="Next" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnLast" runat="server" CommandName="page" CommandArgument="last"><asp:Image ID="imgLast" runat="server" ImageUrl="../images/Last_blk.jpg" ToolTip="Last" /></asp:LinkButton>&nbsp;&nbsp;&nbsp;</td>
                    </tr>
                </table>
            </PagerTemplate>                       
        </asp:GridView>     
    </ContentTemplate>                           
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="ddlClient" EventName="SelectedIndexChanged" />
        <asp:AsyncPostBackTrigger ControlID="ddlFilters" EventName="SelectedIndexChanged" />
        <asp:AsyncPostBackTrigger ControlID="ddlStates" EventName="SelectedIndexChanged" />
        <asp:AsyncPostBackTrigger ControlID="btnRebindGrid" EventName="Click" />
        <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                                
    </Triggers>
    </asp:UpdatePanel>        
    </div>
    </td>
  </tr>  
  <tr id="trPager" > 
    <td id="tdPager" colspan="2">     
    </td>
  </tr>  
</table>
<div id="divNewLicense" style="display:none;position:absolute; height:385px; width:350px;" onclick="event.cancelBubble=true;">
     <table border="0" cellpadding="0" cellspacing="0" style="height:100%;width:100%;" class="tblAddFolder pad5px">
        <tr>
            <th colspan="2" align="left" style="height:25px;" >
                <label id="lblAlbumHeading">Create New License</label>
            </th>                
        </tr>
        <tr>
            <td align="center">
                <iframe id="ifNewLicense" width="100%" height="100%" frameborder="0" src="../BlankPage.htm" marginheight="0" marginwidth="0" scrolling="no"></iframe>
            </td>
        </tr>
      </table>      
</div>
<asp:Button ID="btnRebindGrid" runat="server" Text="Rebind Grid" style="display:none" />
<asp:ObjectDataSource ID="odsQsLicenese" runat="server" TypeName="Portal.BLL.QsLicenseManagment" 
     SelectMethod="GetAllQsLicenses" MaximumRowsParameterName="maximumRows" StartRowIndexParameterName="startRowIndex" 
     SelectCountMethod="GetAllQsLicensesCount" SortParameterName="sortBy" EnablePaging="true" EnableViewState="true">
    <SelectParameters>
        <asp:ControlParameter ControlID="txtSearch" Name="search" DefaultValue="" PropertyName="Text" />
        <asp:ControlParameter ControlID="ddlClient" Name="clientId" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="ddlFilters" Name="inActive" PropertyName="SelectedValue"/>
        <asp:ControlParameter ControlID="ddlStates" Name="stateId" PropertyName="SelectedValue" />
    </SelectParameters>
</asp:ObjectDataSource>
<%--<asp:SqlDataSource ID="sdsClients" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="Clients_GetAll" SelectCommandType="StoredProcedure" DataSourceMode="DataReader"  ></asp:SqlDataSource>--%>
<asp:SqlDataSource ID="sdsClients" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="Clients_GetByUserIDAndSubModulesID"  SelectCommandType="StoredProcedure" DataSourceMode="DataReader"  >
    <SelectParameters>
    <asp:SessionParameter Name="userId" Type="int32" SessionField="AdminID" /> 
    </SelectParameters>
    </asp:SqlDataSource>
<asp:SqlDataSource ID="sdsStoresList" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
     SelectCommand="Franchises_GetByClientID_ForList" SelectCommandType="StoredProcedure" DataSourceMode="DataReader">
     <SelectParameters>
        <asp:ControlParameter ControlID="ddlClient" Name="ClientID" PropertyName="SelectedValue" />                            
     </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsStates" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
     SelectCommand="States_GetAll_For_List" SelectCommandType="StoredProcedure" DataSourceMode="DataReader">
</asp:SqlDataSource>

    <script language="javascript" type="text/javascript" src="../scripts/functions.js"></script>
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
            document.getElementById ("<%=hdnSearch.ClientID%>").value = document.getElementById('<%= txtsearch.ClientID %>').value;
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
        function onPageLoading(sender, e) {
        }      
        
        function ShowNewLicenseDiv(){            
            divNewLicense.style.display='inline';
            ifNewLicense.location='NewQsLicenses.aspx';
            divNewLicense.style.left="0";
            divNewLicense.style.top=getRealTop(divNewKey)+30;            
            divNewKey.className="darkGreenColor";
        }
        
        function CloseNewLicenseDiv(){            
            divNewLicense.style.display='none';
            divNewKey.className="";
        }    
        
        function RebindRecords(){
           document.getElementById('<%= btnRebindGrid.ClientID %>').click(); 
        }  
        
        function ShowDetail(licenseId){
          var ddlClient = document.getElementById('<%= ddlClient.ClientID %>').value; 
          var ddlStates =  document.getElementById('<%= ddlStates.ClientID %>').value; 
          var ddlFilters =  document.getElementById('<%= ddlFilters.ClientID %>').value; 
          window.location='QSLicenseDetail.aspx?LicenseID='+licenseId+'&ddlClient='+ddlClient+'&ddlStates='+ddlStates+'&ddlFilters='+ddlFilters;
        }
        function ShowDetailReadonly(licenseId){
          var ddlClient = document.getElementById('<%= ddlClient.ClientID %>').value; 
          var ddlStates =  document.getElementById('<%= ddlStates.ClientID %>').value; 
          var ddlFilters =  document.getElementById('<%= ddlFilters.ClientID %>').value; 
          window.location='QsLicenseDetail.aspx?LicenseID='+licenseId+'&ddlClient='+ddlClient+'&ddlStates='+ddlStates+'&ddlFilters='+ddlFilters+'&PrevPage=MyNetsolace';
        }
        function NavigateToPrintVersion()
        {
            var ddlStates = document.getElementById('<%=ddlStates.ClientID%>');
            var URL;
            var QueryStringValues = "?Search="+document.getElementById ("<%=hdnSearch.ClientID%>").value;
            QueryStringValues += "&ClientID="+document.getElementById('<%=ddlClient.ClientID%>').value;
            QueryStringValues += "&Filter=" + document.getElementById('<%=ddlFilters.ClientID %>').value;  
            QueryStringValues += "&StateID=" + document.getElementById('<%=ddlStates.ClientID %>').value; 
            QueryStringValues += "&SortBy=" + document.getElementById('<%=hdnSortBy.ClientID %>').value;  
            QueryStringValues += "&State=" + ddlStates.options[ddlStates.selectedIndex].text;  
            URL = "QsLicenseReport.aspx" + QueryStringValues;
            
            window.open(URL);
        }
        function OnXLSDownload()
        {
            var ddlStates = document.getElementById('<%=ddlStates.ClientID%>');
            var URL;
            var QueryStringValues = "?Search="+document.getElementById ("<%=hdnSearch.ClientID%>").value;
            QueryStringValues += "&ClientID="+document.getElementById('<%=ddlClient.ClientID%>').value;
            QueryStringValues += "&Filter=" + document.getElementById('<%=ddlFilters.ClientID %>').value;  
            QueryStringValues += "&StateID=" + document.getElementById('<%=ddlStates.ClientID %>').value; 
            QueryStringValues += "&SortBy=" + document.getElementById('<%=hdnSortBy.ClientID %>').value;  
            QueryStringValues += "&State=" + ddlStates.options[ddlStates.selectedIndex].text;  
            URL = "QsLicenseReport.aspx" + QueryStringValues+'&IsXLS=True'; 
            getElement('frmXLS').src=URL;
        }
        function resetFilters()
        {
         var item;     
            if (item = document.getElementById('<%= ddlClient.ClientID %>'))
            {
            item.value = 0;
            }
            if (item = document.getElementById('<%= ddlStates.ClientID %>'))
            {
            item.value = 0;
            }
            if (item = document.getElementById('<%= ddlFilters.ClientID %>'))
            {
            item.value = 0;
            }
            if (item = document.getElementById('<%= txtSearch.ClientID %>'))
            {
            item.value = '';
            }
           document.getElementById('<%= btnSearch.ClientID  %>').click();
           return true;
        }
       function CheckNoisyWord() {
        var mybool = true;
        var InputStr = document.getElementById('<%=txtsearch.ClientID%>').value;
        if (ChecksSpecailChar(InputStr) == true) {
        alert("Special characters are not Allowed.\nPlease remove them and try again.");
        document.getElementById('<%= txtSearch.ClientID %>').value = '';
        mybool = false;
        return false;
        }
        if (mybool == false)
        return false;
        else
        return true;
    }
    
    function ChecksSpecailChar(val) {
    var iChars = "!@#$%^&*()+=_[]\\\;/{}|\":<>?";
    for (var i = 0; i < val.length; i++) {
        if (iChars.indexOf(val.charAt(i)) != -1) {
            return true;
        }
    }
}
    </script>
    </form>
</body>
</html>