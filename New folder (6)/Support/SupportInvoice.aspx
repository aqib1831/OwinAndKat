<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SupportInvoice.aspx.vb" Inherits="Support_SupportInvoice" Theme="Default" EnableViewState="true" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Support Invoices</title>
    <script language="javascript" type="text/javascript" src="../scripts/functions.js"></script>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/jquery.js"></script>
    <style type="text/css">
        .DateTextBoxBorderStyleLeft{background-color:White;border-top:solid 1px #82A9C8;border-bottom:solid 1px #82A9C8;border-left:solid 1px #82A9C8;}
        .DateTextBoxBorderStyleRight{background-color:White;width:15px;padding-right:2px;padding-left:2px;border-top:solid 1px #82A9C8;border-bottom:solid 1px #82A9C8;border-right:solid 1px #82A9C8;}
        .calanderIcon{background:url('../images/icn_date.png');width:15px;height:16px; cursor:pointer;}
    </style>
</head>
<body style="border:0px; margin:0px; padding:0px;">
    <form id="form1" runat="server">
        <asp:HiddenField ID="hdnInvoiceIds" runat="server" />
        <asp:HiddenField ID="hdnbtnMarkAsPaid" runat="server" Value="0" />
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
                <th colspan="2" style="height:15px;">Confirm</th>
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
       <table cellpadding="0" cellspacing="0" border="0" style="width:100%; height:150px;font-size:12px;" class="MessageUsers">
           <tr>
                <th colspan="2" style="height:15px;">Mark As Paid</th>
           </tr>
           <tr>
            <td style="padding-left:20%;">Payment Mode:</td>
            <td style="width:70%;">
                    <asp:DropDownList ID="ddlPaymentMethod" runat="server" CssClass="SmallGreenTextBox" Width="150px"
                    DataSourceID="SDS_ddlPaymentMethod" DataTextField="Name" DataValueField="ID">   
                    </asp:DropDownList>
                   <asp:SqlDataSource ID="SDS_ddlPaymentMethod" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                        SelectCommand="NS_PaymentMethod_GetAllForList" SelectCommandType="StoredProcedure" DataSourceMode="DataReader"  >
                     </asp:SqlDataSource> 
                     <asp:CompareValidator
                           ID="RFV_DueDate" runat="server" ControlToValidate="ddlPaymentMethod" Display="Dynamic" ValueToCompare="0" Operator="GreaterThan"   
                           ErrorMessage="<br/>Please Select Payment Method" SkinID="CompareValidation" ValidationGroup="abcd" >
                     </asp:CompareValidator> 
                </td>
           </tr> 
           <tr id="trQuickbookRefNumber">
            <td style="padding-left:20%;">Quick Book Ref #:</td>
            <td style="width:70%;">
                   <asp:TextBox ID="txtQBNumber" runat="server" 
                       MaxLength="10" 
                       ValidationGroup="abcd" 
                       Width="150px">
                   </asp:TextBox>
                  <asp:RequiredFieldValidator
                       ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtQBNumber" Display="Dynamic"
                       ErrorMessage="<br />Please Enter Quick Book Ref #." SkinID="RequiredFieldValidation" ValidationGroup="abcd" >
                  </asp:RequiredFieldValidator>
                  <asp:RangeValidator
                       ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtQBNumber" Display="Dynamic"
                       ErrorMessage="<br />Please Enter Valid Quick Book Ref #." Font-Bold="false" Font-Size="10px"  ValidationGroup="abcd" Type="integer" MinimumValue="0" MaximumValue="999999999">
                  </asp:RangeValidator>
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
        <td>&nbsp;<span class="IdeaTitle">Support Invoices - 
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
    	    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="height:100%;" class="gvwSearchSilver">
        	    <tr>
        	        <td style="padding-right:5px;">
                    </td>
                    <td style="width:125px;">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td colspan="2" >
                                 <span style="font-size:10px;">Clients:</span><br />
                                <asp:DropDownList ID="ddlClient" CssClass="DarkBlackTextSmall" runat="server" Width="120px" AutoPostBack="true"
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
                    <td style="width:125px;">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td colspan="2" >
					            <span style="font-size:10px;">States:</span><br />
                                    <asp:DropDownList ID="ddlStates" CssClass="DarkBlackTextSmall" runat="server" Width="120px" AutoPostBack="true"
                                        DataSourceID="sdsStates" DataTextField="Name" DataValueField="ID" EnableViewState="true"> 
                                    </asp:DropDownList>
                                   <asp:SqlDataSource ID="sdsStates" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                     SelectCommand="States_GetAll_For_List" SelectCommandType="StoredProcedure" DataSourceMode="DataReader">
                                     </asp:SqlDataSource>
					            </td>
					        </tr>
					    </table>   
                    </td>
                     <td style="padding-right:5px;padding-left:5px;">
                        <div class="straightline"></div>
                    </td>
                    <td style="width:90px;">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td colspan="2" >
					            <span style="font-size:10px;">Status:</span><br />
                                    <asp:DropDownList ID="ddlStatus" CssClass="DarkBlackTextSmall" runat="server" Width="80px" AutoPostBack="true"
                                       EnableViewState="true"> 
                                       <asp:ListItem Selected="True" Text="Show All"  Value="0" ></asp:ListItem>
                                       <asp:ListItem Text="Paid" Value="1"  ></asp:ListItem>
                                       <asp:ListItem Text="Unpaid" Value="2"  ></asp:ListItem>
                                    </asp:DropDownList>
                                   
					            </td>
					        </tr>
					    </table>   
                    </td>
                   <td style="padding-right:5px;padding-left:5px;">
                        <div class="straightline"></div>
                    </td>            
                    <td style="width:180px;">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td style="width:90px">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td style="padding-right:5px;">Start Date:</td>
                                        </tr>
                                        <tr>
                                            <td class="DateTextBoxBorderStyleLeft">
                                                <asp:TextBox runat="server" id="txtStartDate"  onfocus="spnCalanderStart.click();" readonly="true" style="width:65px;font-size:12px;border:0px;" />
                                            </td>
                                            <td class="DateTextBoxBorderStyleRight" align="center"><span id="spnCalanderStart" class="calanderIcon" onclick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtStartDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"></span></td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="width:90px;padding-left:10px;">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td style="padding-right:5px;">End Date:</td>  
                                        </tr>
                                        <tr>                                                                                                 
                                            <td class="DateTextBoxBorderStyleLeft">
                                                <asp:TextBox runat="server" id="txtEndDate" ReadOnly="true" onfocus="spnCalanderEnd.click();" style="width:65px;font-size:12px;border:0;" />
                                            </td>
                                            <td class="DateTextBoxBorderStyleRight" align="center"><span id="spnCalanderEnd" class="calanderIcon" onclick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtEndDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"></span></td>
                                            <td style="padding-left:5px;">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>                            
					    </table>   
                    </td>
                    <td style="padding-right:5px;padding-left:5px;">
                        <div class="straightline"></div>
                    </td>                                
                    <td style="width:120px;">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td style="padding-right:10px;">
                                  <span style="font-size:10px;">Search:</span><br />
                                  <asp:TextBox ID="txtSearch" runat="server" style="height:20px;width:112px;" MaxLength="20"></asp:TextBox>&nbsp;
                                  <asp:Button ID="btnSearch" runat="server" Text="Go" CssClass="btnSilver" Width="37px"  />
                                </td>
                            </tr>
                        </table>
            </asp:Panel>
        </td>
                  
                     <td  style="width:100%">
                        &nbsp;
                    </td>
                    <td style="padding-top:0px;">
                        <table cellpadding="0" cellspacing="0" width="100px">
                            <tr>
                                <td align="right" style="padding-right:5px;">
                                    <asp:Button ID="btnPaid" runat="server" Text="Mark as Paid" CssClass="btnSilver" style="width:85px;" OnClientClick="btnPaid_Click();return false;" />
                                </td>
                            </tr>
                        </table>                        
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
         <asp:HiddenField ID="hdnSelectedInvoiceID" runat="server" />
        <asp:Label ID="hdnsortby" runat="server" Text="" style="display:none;" ></asp:Label>
            <asp:GridView ID="gvSupport" runat="server" AutoGenerateColumns="False" Width="100%"  SkinID="gvwSilverTemp"
                DataSourceID="odsSupport" AllowPaging="true" Height="100%" 
                ShowFooter="true" EnableViewState="true">
                <Columns>
                     <asp:TemplateField HeaderText="">
                        <HeaderTemplate>                            
                            <asp:CheckBox id="CheckAll" runat="server" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkBox" runat="server" Visible='<%#IIf(Eval("Status"), "False", "True")%>' />&nbsp;<asp:HiddenField ID="hdnID" runat="server" Value='<%# Container.DataItem("ID")%>' />
                        </ItemTemplate>
                        <FooterTemplate>
                            &nbsp;
                        </FooterTemplate>
                        <HeaderStyle Width="02%" />
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Invoice #" SortExpression="ID" >
                        <ItemTemplate><%#Eval("ID").ToString.PadLeft(4, CChar(CStr(0)))%>
                        </ItemTemplate>
                        <FooterTemplate>
                            &nbsp;
                        </FooterTemplate>
                        <HeaderStyle Width="08%" />
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Store #" SortExpression="StoreNumber" >
                        <ItemTemplate><%#Eval("StoreNumber")%>
                        </ItemTemplate>
                        <FooterTemplate>
                            &nbsp;
                        </FooterTemplate>
                        <HeaderStyle Width="08%" />
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Client" SortExpression="ClientCode" >
                        <ItemTemplate><%#Eval("ClientCode")%>
                        </ItemTemplate>
                        <FooterTemplate>
                            &nbsp;
                        </FooterTemplate>
                        <HeaderStyle Width="10%" />
                        <ItemStyle  />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Store" SortExpression="StoreNick">
                        <ItemTemplate><%#Eval("StoreNick")%>
                        </ItemTemplate>
                        <FooterTemplate>
                            &nbsp;
                        </FooterTemplate>
                        <HeaderStyle Width="30%" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Amount" SortExpression="TotalAmount" >
                        <ItemTemplate>
                            <%#FormatNumber(Eval("TotalAmount"), 2)%>
                        </ItemTemplate>
                        <FooterTemplate>
                            &nbsp;
                        </FooterTemplate>
                        <HeaderStyle Width="14%" />
                        <ItemStyle Wrap="false" HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status" SortExpression="Status" >
                        <ItemTemplate>
                            <a href="#" onclick="<%#IIf(Eval("Status"), "ShowConfirm('" & "Payment Mode: " & Eval("PaymentMethodName") & "<br /><br />Quick Book # : " & IIF(Eval("QuickBookInvoiceNo") = 0, "N/A",Eval("QuickBookInvoiceNo")) & "<br /><br />By " & Eval("PaymentBy") & " On " & CDate(Eval("PaymentDate")).ToString("MMM dd, yyyy") & "');", "ShowNotConfirm('" & Eval("ID") & "','0');")%>" ><u><%#IIf(Eval("Status"), "<span style='color:green'><u>Paid (" & Eval("PaymentMethodName") & ")</u></span>", "<span style='color:red'><u>Unpaid</u></span>")%></u></a>
                        </ItemTemplate>
                        <FooterTemplate>
                            &nbsp;
                        </FooterTemplate>
                        <HeaderStyle Width="30%" />
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
            <asp:AsyncPostBackTrigger ControlID="ddlStates" EventName="SelectedIndexChanged" />
            <asp:AsyncPostBackTrigger ControlID="ddlStatus" EventName="SelectedIndexChanged" />
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
      TypeName="Portal.BLL.NS.NS_Billing_SupportInvoices" 
      SelectMethod="NS_Billing_SupportInvoicesGetAll"
      SelectCountMethod="NS_Billing_SupportInvoicesGetAllCount">
    <SelectParameters>
        <asp:ControlParameter ControlID="txtSearch" Name="search" DefaultValue="" PropertyName="Text" />
        <asp:ControlParameter ControlID="ddlClient" Name="ClientID" PropertyName="SelectedValue"  Type="Int32" />
        <asp:ControlParameter ControlID="ddlStates" Name="StateID" PropertyName="SelectedValue"   Type="Int32" />
        <asp:ControlParameter ControlID="ddlStatus" Name="Status" PropertyName="SelectedValue"   Type="Int32" />
        <asp:ControlParameter ControlID="txtStartDate" Name="StartDate" PropertyName="Text"   Type="DateTime" />
        <asp:ControlParameter ControlID="txtEndDate" Name="EndDate" PropertyName="Text"   Type="DateTime" />
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
    function ShowNotConfirm(id,type)
    {
        document.getElementById('<%=hdnbtnMarkAsPaid.ClientID %>').value = type;
        $("#RequiredFieldValidator1").hide();        
        HideConfirm();
        getElement('divNotConfirmed').style.display='inline';
        getElement('txtQBNumber').value='';
        getElement('ddlPaymentMethod').value=0;
        getElement('hdnSelectedInvoiceID').value=id;  
        
    } 
    function HideNotConfirm()
    {
        getElement('divNotConfirmed').style.display='none';
    } 
    function Detail(ID)
    {
        var ClientID = getElement('ddlClient').value;
        var StateID = getElement('ddlStates').value;
        var StatusID = getElement('ddlStatus').value;
        var StartDate = getElement('txtStartDate').value;
        var EndDate = getElement('txtEndDate').value;
        window.location='SupportInvoiceDetail.aspx?SupportInvoiceID='+ID+'&ClientID='+ClientID+'&StateID='+StateID+'&StatusID='+StatusID+'&StartDate='+StartDate+'&EndDate='+EndDate;
    }
    
    function CheckAll(src)
    {  
     if (src.checked)
     {
          $(":checkbox").attr('checked',true);
          $("#btnPaid").removeAttr('disabled');
      }
     else
     {
        $(":checkbox").attr('checked',false);
         $("#btnPaid").attr('disabled','disabled');             
     }
    
    }
    
    function SetCheckdStatus(src)
        {
                                                              
            var unChecked  = 0;
            var totalCheckBox = 0;
            var totalCheckedCheckBox = 0;
            unChecked = $("input:checkbox").not(":checked").length;
            totalCheckedCheckBox = $("input:checkbox:checked").length;
            totalCheckBox = $("input:checkbox").length;           
            if (totalCheckBox > 2)
            {
                if(unChecked > 1)
                {                    
                   var checked = 0;
                   checked = $("input[@type=checkbox][@checked]").length;
                   if (checked == 1 && $("input[@type=checkbox][@checked]")[0].id == "gvSupport_ctl01_CheckAll")
                   {                       
                       $("#gvSupport tr th input[type=checkbox]").attr("checked", false); 
                   }                                    
                }
               else if (unChecked == 1)
                {
                    
                    if($("input:checkbox").not(":checked")[0].id == "gvSupport_ctl01_CheckAll")
                        {
                            
                             $("#gvSupport tr th input[type=checkbox]").attr("checked", true);  
                        } 
                    else
                        {                             
                            $("#gvSupport tr th input[type=checkbox]").attr("checked", false);  
                        } 
                }
           }
           else
           {
               if (src.checked)
               {
                    $(":checkbox").attr('checked',true);                     
                }
               else
               {
                    $(":checkbox").attr('checked',false);                    
                }
           }
           if(totalCheckedCheckBox==0)
           {
                 $("#btnPaid").attr('disabled','disabled'); 
           }
           else
           {
                $("#btnPaid").removeAttr('disabled'); 
           }
        } 
        
        function btnPaid_Click()
        {
            var isChecked = false;
            var trInvoices = $("#gvSupport tr");
            document.getElementById('<%=hdnInvoiceIds.ClientID %>').value = '';
            trInvoices.each(function(index) {                
                if ($(this).find("input[id$='chkBox']").is(":checked") == true) {
                    isChecked = true;
                    if (document.getElementById('<%=hdnInvoiceIds.ClientID %>').value=='')
                    {
                        document.getElementById('<%=hdnInvoiceIds.ClientID %>').value = $(this).find("input[id$='hdnID']").val() ;                        
                    }
                    else
                    {
                        document.getElementById('<%=hdnInvoiceIds.ClientID %>').value = document.getElementById('<%=hdnInvoiceIds.ClientID %>').value + "," + $(this).find("input[id$='hdnID']").val();                        
                    }                  
                                   
                }
            });
            document.getElementById('<%=hdnbtnMarkAsPaid.ClientID %>').value = "1";
            ValidatorEnable(document.getElementById('<%= RequiredFieldValidator1.ClientID %>'), false);           
            $("#trQuickbookRefNumber").hide();
            ShowNotConfirm(document.getElementById('<%=hdnInvoiceIds.ClientID %>').value,1);            
            
        }
        
        function MarkAsPaidValidation()
        {            
            var trInvoices = $("#gvSupport tr");
            var isChecked = false;            

            trInvoices.each(function(index) {                               
                if ($(this).find("input[id$='chkBox']").is(":checked") == true) {                     
                    isChecked = true;
                }                
            }); 
            
            if(isChecked==false)
            {
                $("#btnPaid").attr('disabled','disabled');
            } 
            else
            {
                $("#btnPaid").removeAttr('disabled');
            }         
            
        }       
    
    </script>
    </form>
</body>
</html>