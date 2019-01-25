<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Case_IP_History.aspx.vb" Inherits="Case_IP_History" StylesheetTheme="Default"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>History</title>
    <link href="Style/style.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"> </script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>   
<script type="text/javascript" language="javascript">
function Reset(){
    document.getElementById("txtSearch").value="";
    document.getElementById("ddlType").value="-1";
    return true;
}

</script>
<style>

 .gvSearch
{
	background-color:#EBEBEB;
	font-size:11px;
	font-family:Sans-Serif, arial, verdana, Helvetica;
	border-bottom:2px solid #71AF89;
	border-left:2px solid #71AF89;
	border-right:2px solid #71AF89;
}
.gvSearch td
{
	background-color:#EBEBEB;
	font-weight:bold;
	font-size:11px;
	color:#7B7B7B;
	font-family:Sans-Serif, arial, verdana, Helvetica;	
}
.line_Gray
{
	width:1px;
	height:28px;
	background-color:#C9C9C9;
}
</style>
</head>
<body style="margin:0px; height:100%; width:100%; padding:0px;" scroll="no" class="ScrollBarHomeTicket">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />  
        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
            <ProgressTemplate>
                <div class="ProgressIndicatorDIV" style="width: 150px; bottom: 8px; right: 8px;">
                    <br />
                    <asp:Image ID="Images2" runat="server" ImageUrl="~/images/indicator.gif" ImageAlign="AbsMiddle" /><span
                        style="color: #4B92C1; font-size: 14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
                    <br />
                    <br />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>

        <script type="text/javascript" language="javascript">
            
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
            
      function GenerateReport()
      {
        var Type= document.getElementById("<%=ddlType.ClientID %>").value;
        var StartDate= document.getElementById("<%=txtDateFrom.ClientID %>").value;
        var EndDate= document.getElementById("<%=txtDateTo.ClientID %>").value;
        var Search= document.getElementById('<%= txtSearch.ClientID %>').value;
        var CaseID = document.getElementById('<%= hdnCaseID.ClientID %>').value;
        var requestFrom = document.getElementById('<%= hdnRequestFrom.ClientID %>').value;
        var strUrl = "Case_IP_History_Report.aspx?ID="+ CaseID+ "&Type=" + Type + "&StartDate=" + StartDate + "&EndDate=" + EndDate + "&Search="  + Search + "&RequestFrom="  + requestFrom;
         window.open(strUrl);
      }
            
            </script>
        <asp:UpdatePanel ID="upIdeaCount" runat="server" RenderMode="Inline">
            <ContentTemplate>
                <asp:Literal ID="ltrlRecordCount" runat="server" Text="0" Visible="false" ></asp:Literal></span>
            </ContentTemplate>
       </asp:UpdatePanel>
        <table width="100%" height="100%" border="0"  cellpadding="0" cellspacing="0"
                class="MainTable" style="padding:0px;margin:0px;width:100%;">
                <tr class="GalleryTitle" style="background-image:url('images/bg_mainHdr_1.jpg');height:31px;">
                <td style="width:57%">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="always" RenderMode="Inline">
                        <ContentTemplate>
                             <b>&nbsp;<asp:Label runat="server" ID="lblCaseName" />&nbsp;Activity History&nbsp;-&nbsp;<asp:Label runat="server" ID="lblCaseCount" /></b>
                            &nbsp;
                        </ContentTemplate>
                    </asp:UpdatePanel>  
                </td>
                <td style="text-align:right; padding-right:3px;">
                <asp:ImageButton ID="ImgBtnBack" runat="server" ImageUrl="images/btn_back.jpg"/>&nbsp;
                    <asp:ImageButton ID="reset" runat="server" ImageUrl="images/btn_ResetFilters.jpg" OnClientClick="Reset();"   />
                    <asp:ImageButton ID="imgGenerateReport" runat="server" ImageUrl="images/btn_print.jpg"
                                        OnClientClick="GenerateReport(); return false;" />&nbsp;
                                        <asp:HiddenField ID="hdnCaseID" runat="Server" />
                                        <asp:HiddenField ID ="hdnRequestFrom" runat="server" />
                </td>
            </tr>
                <tr>
                    <td style="height: 100%;width:100%;" colspan="2">
                        <table border="0" align="center" cellpadding="0" cellspacing="0" style="width:100%;height:100%;">
                            <tr>
                                <td height="31px" class="" align="center" style="width:100%;" >
                                    <table width="100%;" height="100%" border="0" style="text-align:left" align="center" cellpadding="0" cellspacing="0" class="gvwSearch">
                                        <tr  class="gvSearch">
                                            <td style="padding-left: 4px; width: 120px;">
                                                <span class="GreyTextSmall">Type:<br />
                                                    <asp:DropDownList ID="ddlType" runat="server" Width="120px" CssClass="SmallFontInput" DataTextField="Name" DataValueField="ID" AutoPostBack="True" AppendDataBoundItems="True" DataSourceID="sdsCaseTypes">
                                                    <asp:ListItem Value="-1">All</asp:ListItem>
                                                    </asp:DropDownList>&nbsp;<asp:SqlDataSource ID="sdsCaseTypes" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                        SelectCommand="Legal_GetCaseActivityType" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                                </span></td>
                                            <td style="width:10px;text-align:center;">
                                                &nbsp;<span class="line_Gray"></span>
                                            </td>
                                            <td align="left" style="padding-left: 5px; padding-right: 5px; width: 90px;">
                                                <span style="font-size: 7pt; color: #7c8798">From Date:</span><br />
                                                <asp:TextBox runat="server" ID="txtDateFrom" ReadOnly="true" Font-Size="12px" CssClass="GreyTextBox"
                                                    Width="70px" onfocus="this.blur();" />
                                                <img id="img1" align="absMiddle" border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtDateFrom.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                                    onmouseover="style.cursor='hand';" src="../images/icn_calendar.png" alt="" />
                                            </td>
                                             <td style="width:10px;text-align:center;">
                                                &nbsp;<span class="line_Gray"></span>
                                            </td>
                                            <td style="padding-right: 3px; padding-left: 5px; width: 90px;" align="left">
                                                <span style="font-size: 7pt; color: #7c8798">To Date</span><br />
                                                <asp:TextBox runat="server" ID="txtDateTo" ReadOnly="true" Font-Size="12px" CssClass="GreyTextBox"
                                                    Width="70px" onfocus="this.blur();" />
                                                <img id="img2" align="absMiddle" border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtDateTo.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                                    onmouseover="style.cursor='hand';" src="../images/icn_calendar.png" alt="" />
                                            </td>
                                            <td style="width:10px;text-align:center;">
                                                &nbsp;<span class="line_Gray"></span>
                                            </td>
                                            <td style="height: 43px; padding-left:5px;">
                                                <asp:Panel ID="Search" DefaultButton="btnSearch" runat="server">
                                                            Search:<br />
                                                       
                                                            <asp:TextBox ID="txtSearch" runat="server" CssClass="blueTextbox" Width="120px"></asp:TextBox>
                                                            &nbsp;<asp:Button ID="btnSearch" runat="server" Text="Go" CssClass="btnSilver" width="40px"/>
                                                </asp:Panel>  
                                            </td>
                                        </tr>
                                    </table>
                                    </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" style="width:100%;border-top:solid 1px #609BD3;border-bottom:solid 1px #609BD3">
                                    <div style="overflow: auto; height: 100%;width:100%;" class="GrayScrollBar">
                                        <asp:UpdatePanel ID="CaseUpdatePanel" runat="server" UpdateMode="Always">
                                            <ContentTemplate>
                                        <asp:GridView ID="gvHistory" runat="server" EnableViewState="false" 
                                            SkinID="gvwSilver"  DataSourceID="odshistory" AutoGenerateColumns="False"
                                            AllowSorting="True" AllowPaging="true" Height="100%" Width="100%"
                                            HeaderStyle-CssClass="gvwSilverHeader" ShowFooter="true" >
                                            
                                            <Columns>
                                                <asp:TemplateField HeaderText="Subject" SortExpression="Subject">
                                                    <ItemTemplate>
                                                        <span title='<%#Eval("Subject").ToString() %>'>
                                                            <%#Server.HtmlEncode(Functions.StringTruncate(Eval("Subject").ToString(), 40))%>
                                                        </span>                                                         
                                                    </ItemTemplate>
                                                     <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                                 <ItemStyle Width="40%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Type" SortExpression="TypeName">
                                                    <ItemTemplate>
                                                      <asp:Label ID="lblTypeName" runat="server" Text='<%#Server.HtmlEncode(Eval("TypeName"))%>'></asp:Label>        
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                    &nbsp;
                                                    </FooterTemplate>
                                                 <ItemStyle Width="12%" />
                                                </asp:TemplateField>
                                                
                                                <asp:TemplateField HeaderText="Date" SortExpression="Date" >
                                                    <ItemTemplate>
                                                        <span title='<%# CaseMgmt.GetStringDate(Eval("Date")) %>'>
                                                            <%# CaseMgmt.GetStringDate(Eval("Date")) %>
                                                        </span>                                                        
                                                    </ItemTemplate>
                                                     <FooterTemplate>                                                     
                                                    </FooterTemplate>
                                                   <ItemStyle Width="11%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="CloseDate" SortExpression="CloseDate" >
                                                    <ItemTemplate>
                                                        <span title='<%# CaseMgmt.GetStringDate(Eval("CloseDate")) %>'>
                                                            <%#CaseMgmt.GetStringDate(Eval("CloseDate"))%>
                                                        </span>                                                        
                                                    </ItemTemplate>
                                                     <FooterTemplate>                                                     
                                                    </FooterTemplate>
                                                   <ItemStyle Width="11%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Time Spent" SortExpression="TimeSpent" >                                                    
                                                    <ItemTemplate>
                                                        <div>
                                                            <%# CaseMgmt.GetGridTimeSpent(Eval("TimeSpent").ToString()) %>
                                                        </div>     
                                                    </ItemTemplate>
                                                       <ItemStyle Width="9%" />
                                                     <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Cost" SortExpression="Cost">
                                                <ItemStyle HorizontalAlign="Right" />
                                                    <ItemTemplate>
                                                        <div title='<%#Decimal.Round(Eval("Cost"),2)%>'>
                                                            <%#Functions.StringTruncate(Decimal.Round(Eval("Cost"), 2), 7)%>
                                                        </div>
                                                    </ItemTemplate>
                                                     <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                                   <ItemStyle Width="7%" />
                                                </asp:TemplateField> 
                                                
                                            </Columns>
                                            
                                            <EmptyDataTemplate>                
                                                 <table class="NoRecord">
                                                    <tr>                            
                                                        <td>
                                                            <img align="absmiddle" src="images/ico_alert.gif" />&nbsp;&nbsp;No Record Found!
                                                        </td>
                                                    </tr>
                                                 </table>                
                                            </EmptyDataTemplate>
                                            <PagerStyle CssClass="gvwSilverPager" />
                                               <PagerSettings Mode="NextPreviousFirstLast" Visible="true" Position="Bottom" />
                                                <PagerTemplate>
                                                    <table id="tblPager" width="100%" border="0" cellspacing="0" cellpadding="0" style="background-color:green;">
                                                        <tr>                        
                                                           <td style="border:0;">Showing Case <asp:Literal ID="ltrlStartCount" runat="server" Text="0"></asp:Literal> to <asp:Literal ID="ltrlEndCount" runat="server" Text="0"></asp:Literal> of <asp:Literal ID="ltrlTotalCount" runat="server" Text="0"></asp:Literal></td> 
                                                           <td style="border:0;width:120px;" align="right">Page&nbsp;<asp:Literal ID="ltrlStartPage" runat="server" Text="0"></asp:Literal> of <asp:Literal ID="ltrlLastPage" runat="server" Text="0"></asp:Literal>&nbsp;&nbsp;&nbsp;<asp:LinkButton ID="lnkBtnFirst" runat="server" CommandName="page" CommandArgument="first"><asp:Image ID="imgFirst" runat="server" ImageUrl="images/First_blk.jpg" ToolTip="First" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnPrevious" runat="server" CommandName="page" CommandArgument="prev"><asp:Image ID="imgPrevious" runat="server" ImageUrl="images/back_blk.jpg" ToolTip="Previous" /></asp:LinkButton> &nbsp;<asp:LinkButton ID="lnkBtnNext" runat="server" CommandName="page" CommandArgument="next"><asp:Image ID="imgNext" runat="server" ImageUrl="images/Next_blk.jpg"  ToolTip="Next" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnLast" runat="server" CommandName="page" CommandArgument="last"><asp:Image ID="imgLast" runat="server" ImageUrl="images/Last_blk.jpg" ToolTip="Last" /></asp:LinkButton>&nbsp;&nbsp;&nbsp;</td>
                                                        </tr>
                                                    </table>
                                                </PagerTemplate>
                                        </asp:GridView>
                                            </ContentTemplate>
                                            <Triggers>
                                                 <asp:AsyncPostBackTrigger ControlID="ddlType" EventName="SelectedIndexChanged" />
                                                 <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                                                 <asp:AsyncPostBackTrigger ControlID="reset" EventName="Click" />
                                             </Triggers>
                                        </asp:UpdatePanel>
                                        <asp:UpdateProgress ID="Progress1" runat="server" AssociatedUpdatePanelID="CaseUpdatePanel">
                                            <ProgressTemplate>
                                                <div class="ProgressIndicatorDIV">
                                                    <br />
                                                    <asp:Image ID="Image2" runat="server" ImageAlign="AbsMiddle" ImageUrl="images/indicator.gif" />
                                                    <span style="font-size: 14px; color: #4b92c1"><b>&nbsp; Loading ...</b></span>
                                                    <br />
                                                    <br />
                                                </div>
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                       <asp:ObjectDataSource ID="odshistory" runat="server" SelectMethod="GetAll_Cases_IP_History" SelectCountMethod="GetAllCount_Cases_IP_History" 
                                        TypeName="CaseMgmt" SortParameterName="SortExpression" EnablePaging="true" >
                                        <SelectParameters>
                                            <asp:QueryStringParameter Name="RequestFrom" Type="INT32" QueryStringField="RequestFrom" />
                                            <asp:QueryStringParameter Name="ID" Type="INT32" QueryStringField="ID" />
                                            <asp:ControlParameter ControlID="txtDateFrom" Name="StartDate" PropertyName="Text"
                                                ConvertEmptyStringToNull="true" DefaultValue="1/1/2000" Type="String" />
                                            <asp:ControlParameter ControlID="txtDateTo" Name="EndDate" PropertyName="Text" Type="String"
                                                ConvertEmptyStringToNull="true" DefaultValue="1/1/2099" />
                                            <asp:ControlParameter ControlID="ddlType" Name="Type" PropertyName="SelectedValue"
                                                Type="Int32" />
                                            <asp:ControlParameter ControlID="txtSearch" Name="Search" PropertyName="Text" Type="String" />
                                            
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                        </div>
                                    </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trPager">
                    <td id="tdPager" colspan="2">   
                    
                   </td>
            </tr>
            </table>
    </form>
</body>
</html>
<script type="text/javascript" language="javascript">
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
    AdjustPagerRow(); 
    var postbackElement;
    Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(beginRequest);
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(pageLoaded);
    
    function beginRequest(sender, args) {
        postbackElement = args.get_postBackElement();
    }
    
    function pageLoaded(sender, args) {
        var updatedPanels = args.get_panelsUpdated();
        if (typeof(postbackElement) === "undefined") {
            return;
        } 
        for (i=0; i < updatedPanels.length; i++){
            if (updatedPanels[i].id == '<%= CaseUpdatePanel.ClientID %>') {
                $get('<%= txtSearch.ClientID %>').value='';
                AdjustPagerRow();
            }
        }
    }
</script> 
