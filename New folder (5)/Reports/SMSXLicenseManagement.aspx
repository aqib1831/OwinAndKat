<%@ Page Language="VB" AutoEventWireup="false" ValidateRequest="false" CodeFile="SMSXLicenseManagement.aspx.vb" Inherits="LM_SMSXLicenseManagement" Theme="Default" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>SMSX License Management</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script src="../scripts/jquery-1.11.2.min.js"></script>
</head>
<body style="margin:0px;padding:0px;">
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
    <td>&nbsp;<span class="IdeaTitle">SMSx License - 
    <asp:UpdatePanel ID="upIdeaCount" runat="server" RenderMode="Inline">
        <ContentTemplate>
            <asp:Literal ID="ltrlRecordCount" runat="server" Text="0"></asp:Literal>
        </ContentTemplate>
    </asp:UpdatePanel></span></td>
    <td align="right" style="padding-right:5px">
        <table cellpadding="0" cellspacing="0">
        <tr>
    <td  style="padding-right:5px; background-image:none;" align="right">
        <iframe name="frmXLS" id="frmXLS" src="../BlankPage.htm" height="0" width="0" frameborder="0" scrolling="no"></iframe>
        <img alt=""  src="../images/print.gif" align="absmiddle" style="cursor: pointer;vertical-align:bottom;" onclick="event.cancelBubble=true;NavigateToPrintVersion();" />
        <a href="#" onclick="event.cancelBubble=true;NavigateToPrintVersion();" ><span style="cursor: pointer; font-size: 10px; color: #316155; text-decoration: underline;">Printable Version</span></a>
        <img alt=""  src="../images/icn_dwnldExcel.jpg" align="absmiddle" style="cursor: pointer;padding:0px;margin:0px;border:0px;height:19px;  " onclick="javascript:GenerateExcel();" />
        <a href="#"><span style="cursor: pointer; font-size: 10px; color: #316155; text-decoration: underline;" onclick="javascript:GenerateExcel();">Download XLS</span></a>
        
    </td>
   <td>
   
   </td>
    </tr>
        
        </table>
        
        </td>
        
  </tr>
  <tr  style="height:41px;">
    <td valign="middle" colspan="2" >        
    	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="height:100%;" class="gvwSearchSilver">
        	<tr>
            	<td style="width:45%;" align="center" id="tdnewbtn">
            	    <table cellpadding="0" cellspacing="0" width="100%">
            	        <tr>
            	            <td style="padding-left:5px;">
            	                SMSx Version
            	            </td>
            	            <td>
            	                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always" RenderMode="Inline" >
            	                    <ContentTemplate>
            	                        <asp:DropDownList ID="ddlSMSxVersion" CssClass="DarkBlackTextSmall" runat="server" Width="150px" AutoPostBack="true" DataSourceID="sdsSMSxVersion" AppendDataBoundItems="true" DataTextField="CurrentVersion" DataValueField="CurrentVersion">
                                            <asp:ListItem Text="Show All" Value="All"></asp:ListItem>                                    
                                        </asp:DropDownList>
            	                    </ContentTemplate>
            	                </asp:UpdatePanel>            	                
                                <asp:SqlDataSource ID="sdsSMSxVersion" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                     SelectCommand="SMSX_GetAllSMSxVersion" SelectCommandType="StoredProcedure">
                                </asp:SqlDataSource>
            	            </td>
                             <td>
            	                Store Status
            	            </td>
            	            <td>
            	                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Always" RenderMode="Inline" >
            	                    <ContentTemplate>
            	                        <asp:DropDownList ID="ddlStoreStatus" CssClass="DarkBlackTextSmall" runat="server" Width="150px" AutoPostBack="true"  AppendDataBoundItems="true" DataTextField="CurrentVersion" DataValueField="CurrentVersion">
                                            <asp:ListItem Text="Show All" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Operating" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Terminated" Value="4"></asp:ListItem>
                                            <asp:ListItem Text="Suspended" Value="5"></asp:ListItem>
                                            <asp:ListItem Text="Coming Soon" Value="1"></asp:ListItem> 
                                            <asp:ListItem Text="Corporate" Value="3"></asp:ListItem> 
                                            <asp:ListItem Text="Transferred" Value="6"></asp:ListItem>                                   
                                        </asp:DropDownList>
            	                    </ContentTemplate>
            	                </asp:UpdatePanel>            	                
            	            </td>
            	        </tr>
            	    </table>            	              	    
			        </td>            	                                   
                <td style="width:180px;">
                    &nbsp;   
                </td>
                <td style="padding-right:5px;">
                    &nbsp;
                </td>
                <td align="right" style="width:140px;">
                    &nbsp;                	
                </td>                    
                <td  style="width:170px;">
                    &nbsp;                    	                    
                </td>    
                       
                <td align="right">
                    &nbsp;                	
                </td>
                
            </tr>
        </table>
        
    </td>
  </tr>
  <tr style="height:100%;">
    <td valign="top" colspan="2">
    <div id="divScroll" style="height:100%; width:100%; overflow-y:auto;" class="GrayScrollBar">    
    <asp:UpdatePanel ID="upKeys" runat="server" UpdateMode="Conditional">        
    <ContentTemplate>    
        <asp:GridView ID="gvwKeys" runat="server" AutoGenerateColumns="False" Width="100%"  SkinID="gvwSilver"
            DataSourceID="odsSBSSMSXLicenses" AllowPaging="true" AllowSorting="true" Height="100%" ShowFooter="true" EnableViewState="true">
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
                    <HeaderStyle Width="15%" />
                </asp:TemplateField>                                                
                <asp:TemplateField HeaderText="IP" SortExpression="SystemIP">
                    <ItemTemplate>
                        <%#IIf(Eval("IsDynamicIP"), "Dynamic IP", Eval("SystemIP"))%>
                    </ItemTemplate>
                    <HeaderStyle Width="8%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="SMSx Version">
                    <ItemTemplate>
                       <div align="left"><%#Eval("CurrentVersion")%></div>
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
                    <HeaderStyle Width="8%" />
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Store Status">
                    <ItemTemplate>
                        <%#IIf(Eval("FranchiseStatus") Is DBNull.Value, "", Eval("FranchiseStatus"))%>
                    </ItemTemplate>
                    <FooterTemplate>
                        &nbsp;
                    </FooterTemplate>
                    <HeaderStyle Width="8%" />
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
        <asp:AsyncPostBackTrigger ControlID="ddlSMSxVersion" EventName="SelectedIndexChanged" />  
         <asp:AsyncPostBackTrigger ControlID="ddlStoreStatus" EventName="SelectedIndexChanged" />                                
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

<asp:ObjectDataSource ID="odsSBSSMSXLicenses" runat="server" TypeName="Portal.BLL.SMSXLicenseManagement" 
     SelectMethod="GetAllSMSXLicensesSMSxVerion" MaximumRowsParameterName="maximumRows" StartRowIndexParameterName="startRowIndex" 
     SelectCountMethod="GetAllSMSXLicensesSMSxVerionCount" SortParameterName="sortBy" EnablePaging="true" EnableViewState="true">
    <SelectParameters>        
        <asp:ControlParameter ControlID="ddlSMSxVersion" Name="version" PropertyName="SelectedValue" />
         <asp:ControlParameter ControlID="ddlStoreStatus" Name="Status" DefaultValue="0" PropertyName="SelectedValue" Type="Int32" />        
    </SelectParameters>
</asp:ObjectDataSource>
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
        
        
        
         
        
       
        function NavigateToPrintVersion()
        {            
            var URL;
            var QueryStringValues = "?Version="+document.getElementById ("<%=ddlSMSxVersion.ClientID%>").value;
            QueryStringValues += "&SortBy=" + document.getElementById('<%=hdnSortBy.ClientID %>').value;
            URL = "SMSXLicensesReport.aspx" + QueryStringValues;
            
            window.open(URL);
        }
        function OnXLSDownload()
        {
            var URL;
            var QueryStringValues = "?Version="+document.getElementById ("<%=ddlSMSxVersion.ClientID%>").value;            
            QueryStringValues += "&SortBy=" + document.getElementById('<%=hdnSortBy.ClientID %>').value;
            URL = "SMSXLicensesReport.aspx" + QueryStringValues+'&IsXLS=True'; 
            getElement('frmXLS').src=URL;
        }        
        function GenerateExcel() {
            var SMSxVersionID = $("[id$=ddlSMSxVersion] option:selected").val();
            var SMSxVersionName = $("[id$=ddlSMSxVersion] option:selected").text();
            var SortedBy = $("[id$=hdnSortBy]").val();
            var StoreStatusValue = $("[id$=ddlStoreStatus] option:selected").val();
            var StoreStatusText = $("[id$=ddlStoreStatus] option:selected").text();
            var d = new Date();
            var uniqueid = d.getMilliseconds()

            var url = "../ExcelGenerator.ashx?Action=ExportSMSxLicense&SMSxVersionID=" + SMSxVersionID + "&SMSxVersionName=" + SMSxVersionName + "&StoreStatusValue=" + StoreStatusValue + "&StoreStatusText=" + StoreStatusText + "&nocache=" + uniqueid + "&SortedBy=" + SortedBy;
            window.open(url);

        }
    </script>
    </form>
</body>
</html>