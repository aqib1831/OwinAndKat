<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SupportBankBatch.aspx.vb" Inherits="Support_SupportBankBatch" Theme="Default" EnableViewState="true" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Bank Batch</title>
    <script language="javascript" type="text/javascript" src="../scripts/functions.js"></script>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
</head>
<body style="border:0px; margin:0px; padding:0px;">
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
    <div id="divConfirmed" style="background-color:#fff; border:solid 1px #000; display:none; position:absolute; color:#fff; height:150px; width:400px; left:25%; top:35%;">
       <table cellpadding="0" cellspacing="0" border="0" style="width:100%; height:150px;" class="MessageUsers">
           <tr>
                <th colspan="2" style="height:15px;">Bank Confirmation</th>
           </tr>
           <tr style="height:100%;">
                <td align="left" style="font-size:12px; width:10px;  padding: 15 5 5 5; vertical-align:top;"> 
                    <img align="absmiddle" src="../images/icn_info.gif" />
                </td>
                <td align="left" style="text-align:left; vertical-align:top; padding: 10 5 5 5; height:100%; width:100%;">
                     <span ID="ltrlReason" runat="server"></span> 
                </td>
           </tr>       
           <tr style="padding-bottom:8px;">
                <td colspan="2" align="center"><input type="button" class="btnSimple" style="width:60px;" value="Ok" onclick="HideConfirm();"/> </td>
           </tr>
        </table>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="conditional" RenderMode="Inline">
    <ContentTemplate>
    <div id="divNotConfirmed" style="background-color:#fff; border:solid 1px #000; display:none; position:absolute; color:#fff; height:150px; width:400px; left:25%; top:35%;">
       <table cellpadding="0" cellspacing="0" border="0" style="width:100%; height:150px;" class="MessageUsers">
           <tr>
                <th colspan="2" style="height:15px;">Bank Confirmation</th>
           </tr>
           <tr>
                <td colspan="2" align="center" style="font-size:12px; width:100%;"> 
                     <asp:TextBox ID="txtConfirmDate" runat="server" 
                       MaxLength="10" 
                       onfocus="imgDDCalander.click();"
                       ValidationGroup="abcd" 
                       Width="123px">
                   </asp:TextBox>
                   <img id="imgDDCalander" align="absMiddle"  border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtConfirmDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                       onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" />
                     <asp:RequiredFieldValidator
                           ID="RFV_DueDate" runat="server" ControlToValidate="txtConfirmDate" Display="Dynamic"
                           ErrorMessage="<br/>Please Select Confirm Date" SkinID="RequiredFieldValidation" ValidationGroup="abcd" >
                     </asp:RequiredFieldValidator>
                     <asp:CompareValidator ID="CV_FutureDate" runat="server" ValidationGroup="abcd"  Display="Dynamic" ControlToValidate="txtConfirmDate" type="Date"  Operator="LessThanEqual" 
                      ErrorMessage="<br/>Please Select a Past Date">
                   </asp:CompareValidator>
                </td>
           </tr> 
           <tr>
            <td colspan="2"  align="center" style="width:100%;">
                        Please Select Confirm date. 
             </td>
           </tr>      
           <tr style="padding-bottom:8px;">
                <td colspan="2" align="center"><asp:Button ID="btnSave" runat="server" text="Save" ValidationGroup="abcd"   class="btnSimple" style="width:70px;" />
                <asp:Button ID="btnCancle" runat="server" text="Cancel"  class="btnSimple" CausesValidation="false" OnClientClick="HideNotConfirm(); return false;"   style="width:70px;" />
                </td>
           </tr>
        </table>
    </div>
     </ContentTemplate> 
        <Triggers>  
            <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel> 
    <div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="height:100%;">
      <tr class="GalleryTitle" style="background-image:url('../images/bg_mainHdr_1.jpg');height:31px;">
        <td>&nbsp;<span class="IdeaTitle">Bank Batch - 
        <asp:UpdatePanel ID="upIdeaCount" runat="server" RenderMode="Inline">
            <ContentTemplate>
                <asp:Literal ID="ltrlRecordCount" runat="server" Text="0"></asp:Literal>
            </ContentTemplate>
        </asp:UpdatePanel></span></td>
        <td  style="padding-right:5px;" align="right">
            <iframe name="frmXLS" id="frmXLS" src="BlankPage.htm" height="0" width="0" frameborder="0" scrolling="no"></iframe>
            &nbsp;&nbsp;
        </td>
      </tr>
      <tr  style="height:41px;">
        <td valign="middle" colspan="2">
            <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
    	    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="height:100%;" class="gvwSearchSilver">
        	    <tr>
        	        <td style="padding-right:5px;">
                    </td>
                    <td >
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td colspan="2" >
                                 <span style="font-size:10px;">Clients:</span><br />
                                <asp:DropDownList ID="ddlClient" CssClass="DarkBlackTextSmall" runat="server" Width="150px" AutoPostBack="true"
                                    DataSourceID="sdsClients" DataTextField="Name" DataValueField="ID"> 
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="sdsClients" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                    SelectCommand="Clients_GetByBillingReport" SelectCommandType="StoredProcedure" DataSourceMode="DataReader"  ></asp:SqlDataSource>
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
					            <span style="font-size:10px;">Country:</span><br />
                                 <asp:UpdatePanel ID="updatepanelCountry" runat="server" UpdateMode="Conditional">
                                  <ContentTemplate>
                                    <asp:DropDownList ID="ddlCountry" CssClass="DarkBlackTextSmall" runat="server" Width="150px" AutoPostBack="true"
                                        DataSourceID="sdsCountries" DataTextField="Name" DataValueField="ID" EnableViewState="true"> 
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="sdsCountries" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                        SelectCommand="Countries_GetByClientIDForBillingReport" SelectCommandType="StoredProcedure" DataSourceMode="DataReader"  >
                                     <SelectParameters>
                                        <asp:ControlParameter Name="ClientID" ControlID="ddlClient" DefaultValue="0" Type="Int32" />
                                     </SelectParameters>       
                                    </asp:SqlDataSource>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="ddlClient" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                    </asp:UpdatePanel>
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
                                <span style="font-size:10px;">Report For:</span><br />
                                     <asp:DropDownList ID="ddlReport" 
                                          CssClass="DarkBlackTextSmall" runat="server" Width="100px" AutoPostBack="true" 
                                          DataSourceID="SDS_Report" DataTextField="StartDate" DataValueField="ID" DataTextFormatString="{0:MMM yyyy}"  >
                                     </asp:DropDownList>
                                     <asp:SqlDataSource ID="SDS_Report" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                          SelectCommand="NS_BillingReport_ForList" SelectCommandType="StoredProcedure" DataSourceMode="DataReader"  >
                                     </asp:SqlDataSource>                        
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
      <tr style="height:100%;">
        <td valign="top" colspan="2">
        <div id="divScroll" style="height:100%; width:100%; overflow-y:auto;" class="GrayScrollBar">    
        <asp:UpdatePanel ID="upKeys" runat="server" UpdateMode="Conditional">        
        <ContentTemplate>
        <asp:HiddenField ID="hdnSelectedBatchID" runat="server" />
        <asp:Label ID="hdnsortby" runat="server" Text="" style="display:none;" ></asp:Label>
            <asp:GridView ID="gvSupport" runat="server" AutoGenerateColumns="False" Width="100%"  SkinID="gvwSilvertemp"
                DataSourceID="odsSupport" AllowPaging="true" AllowSorting="true" Height="100%" ShowFooter="true" EnableViewState="false">
                <Columns>
                     <asp:TemplateField HeaderText="Date" SortExpression="GeneratedOn">
                        <ItemTemplate>
                            <%#String.Format("{0:MMM dd, yyyy hh:mm tt}", Functions.IfNull(Eval("GeneratedOn"), Date.MinValue)).Replace("Jan 01, 1900", "")%>
                        </ItemTemplate>
                        <FooterTemplate>
                            &nbsp;
                        </FooterTemplate>
                        <HeaderStyle Width="15%" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Client" SortExpression="ClientCode" >
                        <ItemTemplate>
                          <%#Eval("ClientCode")%>
                        </ItemTemplate>
                        <FooterTemplate>
                            &nbsp;
                        </FooterTemplate>
                        <HeaderStyle Width="05%" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Country" SortExpression="CountryName">
                        <ItemTemplate>
                            <%#Eval("CountryName")%>
                        </ItemTemplate>
                        <FooterTemplate>
                            &nbsp;
                        </FooterTemplate>
                        <HeaderStyle Width="10%" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="# Stores" SortExpression="TotalStore" >
                        <ItemTemplate>
                            <%#Eval("TotalStore")%>
                        </ItemTemplate>
                        <FooterTemplate>
                            &nbsp;
                        </FooterTemplate>
                        <HeaderStyle Width="05%" />
                        <ItemStyle Wrap="false" HorizontalAlign="Right" />
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Amount" SortExpression="GrandTotalAmount" >
                        <ItemTemplate>
                            <%#FormatNumber(Eval("GrandTotalAmount"), 2)%>
                        </ItemTemplate>
                        <FooterTemplate>
                            &nbsp;
                        </FooterTemplate>
                        <HeaderStyle Width="07%" />
                        <ItemStyle Wrap="false" HorizontalAlign="Right" />
                    </asp:TemplateField>               
                    <asp:TemplateField HeaderText="Download" >                   
                        <ItemTemplate>
                             <a href="#" style="text-underline-position:below;" onclick="<%#"OnXLSDownload(" & Eval("ID") & ");"%>" ><u>CSV</u></a>
                        </ItemTemplate>
                        <FooterTemplate>
                            &nbsp;
                        </FooterTemplate>
                        <HeaderStyle Width="07%" HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status" SortExpression="Confirmed" >
                        <ItemTemplate>
                            <a href="#" onclick="<%#IIf(Eval("Confirmed"), "ShowConfirm('" &  "Confirmed By " & Eval("ConfirmedBy") & " On " & CDate(Eval("ConfirmDate")).ToString("MMM dd, yyyy hh:mm tt") & " ');", "ShowNotConfirm('" & Eval("ID") & "');")%>" ><u><%#IIf(Eval("Confirmed"), "Confirmed By " & Eval("ConfirmedBy") & " On " & CDate(Eval("ConfirmDate")).ToString("MMM dd, yyyy hh:mm tt"), "<span style='color:red;'><u>Pending Confirmation</u></span>")%></u></a>
                        </ItemTemplate>
                        <FooterTemplate>
                            &nbsp;
                        </FooterTemplate>
                        <HeaderStyle Width="35%" />
                        <ItemStyle Wrap="false" />
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
            <asp:AsyncPostBackTrigger ControlID="ddlCountry" EventName="SelectedIndexChanged" />
            <asp:AsyncPostBackTrigger ControlID="ddlReport" EventName="SelectedIndexChanged" />
            <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                                
            <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
        </Triggers>
        </asp:UpdatePanel>        
        </div>
        </td>
      </tr>  
      <tr id="trPager"><td id="tdPager" colspan="2"></td></tr>  
    </table>
    </div>
<asp:ObjectDataSource ID="odsSupport" runat="server"    
      EnablePaging="true" EnableViewState="true" SortParameterName="sortBy"
      MaximumRowsParameterName="maximumRows" 
      StartRowIndexParameterName="startRowIndex" 
      TypeName="Portal.BLL.NS.NS_Billing_BankBatch" 
      SelectMethod="NS_Billing_BankBatchGetAll"
      SelectCountMethod="NS_Billing_BankBatchGetAllCount">
    <SelectParameters>
        <asp:ControlParameter ControlID="txtSearch" Name="search" DefaultValue="" PropertyName="Text" />
        <asp:ControlParameter ControlID="ddlClient" Name="ClientID" PropertyName="SelectedValue"  Type="Int32" />
        <asp:ControlParameter ControlID="ddlCountry" Name="CountryID" PropertyName="SelectedValue"   Type="Int32" />
        <asp:ControlParameter ControlID="ddlReport" Name="BillingReportID" PropertyName="SelectedValue" Type="Int32" />
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
    function onPageLoading(sender, e) {
    }
    function OnXLSDownload(ID)        
    {   
        getElement('frmXLS').src="SupportBatchReport.aspx?ID=" + ID +'&IsXLS=True';
    }
    function ShowConfirm(str)
    {   
        HideNotConfirm();
        getElement('divConfirmed').style.display='inline';
        getElement('<%=ltrlReason.ClientID%>').innerHTML=str;
    } 
    function HideConfirm()
    {   
        getElement('divConfirmed').style.display='none';
    }
    function ShowNotConfirm(id)
    {   
        HideConfirm();
        getElement('divNotConfirmed').style.display='inline';
        getElement('txtConfirmDate').value='';
        getElement('hdnSelectedBatchID').value=id;        
    } 
    function HideNotConfirm()
    {
       getElement('divNotConfirmed').style.display='none';
    } 
    </script>
    </form>
</body>
</html>
