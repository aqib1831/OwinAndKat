<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Legal_Case.aspx.vb" Inherits="admin_Legal_Legal_Case" StylesheetTheme="default"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>LegalIP</title>
    <link href="Style/style.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"> </script>

    
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"> </script>
<script type="text/javascript" language="javascript">
function Reset(){
    document.getElementById("txtSearch").value="";
    document.getElementById("ddlFirm").value="-1";
    document.getElementById("ddlType").value="-1";
    document.getElementById("ddlStatus").value="-1";
    return true;
}

</script>
<style>
.headerHeight
{
height:18px;
}
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
        
            function SetPostBack(id)
            {           
                    var firm        = document.getElementById('<%= ddlFirm.ClientID  %>');
                    var type        = document.getElementById('<%= ddlType.ClientID %>');
                    var Status      = document.getElementById('<%= ddlStatus.ClientID %>');                         
                    var location = 'Legal_Case_Edit.aspx?ID='+id+'&firm='+firm.options.value+'&type='+type.options.value+'&status='+Status.options.value;
                    window.location = location;
            }
            
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
            </script>
        <asp:UpdatePanel ID="upIdeaCount" runat="server" RenderMode="Inline">
            <ContentTemplate>
                <asp:Literal ID="ltrlRecordCount" runat="server" Text="0" Visible="false" ></asp:Literal></span>
            </ContentTemplate>
       </asp:UpdatePanel>
        <table width="100%" height="100%" border="0"  cellpadding="0" cellspacing="0"
                class="" style="padding:0px;margin:0px;width:100%;">
                <tr class="GalleryTitle" style="background-image:url('images/bg_mainHdr_1.jpg');height:31px;">
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="always" RenderMode="Inline">
                        <ContentTemplate>
                             <b>&nbsp;Case Management&nbsp;-&nbsp;<asp:Label runat="server" ID="lblCaseCount" /></b>
                            &nbsp;
                        </ContentTemplate>
                    </asp:UpdatePanel>  
                </td>
                <td style="text-align:right; padding-right:3px;">
                    <asp:ImageButton ID="reset" runat="server" ImageUrl="images/btn_ResetFilters.jpg" OnClientClick="Reset();"   />
                </td>
            </tr>
                <tr>
                    <td style="height: 100%;width:100%;" colspan="2">
                        <table border="0" align="center" cellpadding="0" cellspacing="0" style="width:100%;height:100%;" class="gvwSearchSilver">
                            <tr>
                                <td height="31px" class="" align="center" style="width:100%;" >
                                    <table width="100%;" height="100%" border="0" style="text-align:left" align="center" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="80" style="height: 43px; padding-left:10px;padding-bottom:5px;">
                                                <span class="GreyTextSmall">
                                                &nbsp; &nbsp;
                                                <input value="New Case" id="btnNewIP" type="button" class="btnSilver" onclick="parent.parent.frameMain.location='NewLegalCase.aspx'" style="width: 80px" />&nbsp;&nbsp;
                                                    </span></td>
                                            
                                            <td style="width:10px;text-align:center;">
                                                &nbsp;<span class="line_Gray"></span>
                                            </td>
                                            <td width="130" style="padding-left: 8px; height: 43px;">
                                                <span class="GreyTextSmall">Firm:<br />
                                                    <asp:DropDownList ID="ddlFirm" runat="server"  Width="140" CssClass="SmallFontInput" DataSourceID="FirmDS" DataTextField="Name" DataValueField="ID" AutoPostBack="True" AppendDataBoundItems="True">
                                                        <asp:ListItem Value="-1">All</asp:ListItem>
                                                    </asp:DropDownList>&nbsp;&nbsp;</span>
                                                    <asp:SqlDataSource ID="FirmDS" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                    SelectCommand="Legal_Firm_GetAll_ForList" DataSourceMode="DataReader" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                            </td>
                                            <td style="width:10px;text-align:center;">
                                                &nbsp;<span class="line_Gray"></span>
                                            </td>
                                            <td style="padding-left: 4px; height: 43px; width: 126px;">
                                                <span class="GreyTextSmall">Type:<br />
                                                    <asp:DropDownList ID="ddlType" runat="server" Width="120px" CssClass="SmallFontInput" DataTextField="Name" DataValueField="ID" AutoPostBack="True" AppendDataBoundItems="True" DataSourceID="sdsCaseTypes">
                                                    <asp:ListItem Value="-1">All</asp:ListItem>
                                                    </asp:DropDownList>&nbsp;<asp:SqlDataSource ID="sdsCaseTypes" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                        SelectCommand="Legal_GetCaseTypes" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                                </span></td>
                                            <td style="width:10px;text-align:center;">
                                                &nbsp;<span class="line_Gray"></span>
                                            </td>
                                            <td style="height: 43px; padding-left: 4px; width:90px;">
                                                <span class="GreyTextSmall">Status:<br />
                                                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="SmallFontInput" AutoPostBack="True" AppendDataBoundItems="True" DataSourceID="sdsCaseStatus" DataTextField="Name" DataValueField="ID" Width="160px" >
                                                    <asp:ListItem Value="-1">All</asp:ListItem>
                                                        <asp:ListItem Value="5">All Active</asp:ListItem>
                                                    </asp:DropDownList><asp:SqlDataSource ID="sdsCaseStatus" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                        SelectCommand="Legal_GetCaseStatusTypes" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                                    </span>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td style="width:10px;text-align:center;">
                                                &nbsp;<span class="line_Gray"></span>
                                            </td>
                                            <td style="height: 31px; padding-right:5px; width:200px;" align="left">
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
                                        <asp:GridView ID="GridView1" runat="server" EnableViewState="false" 
                                            SkinID="gvwSilver"  DataSourceID="LegaLCasesDS" AutoGenerateColumns="False" DataKeyNames="ID" 
                                            AllowSorting="True" AllowPaging="true" Height="100%" Width="100%"
                                            HeaderStyle-CssClass="gvwSilverHeader" ShowFooter="true" >
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
                                            <Columns>
                                                <asp:TemplateField HeaderText="Title" SortExpression="Title">
                                                    <ItemTemplate>
                                                        <span title='<%#Eval("Title").ToString() %>'>
                                                            <%#Server.HtmlEncode(Functions.StringTruncate(Eval("Title").ToString(), 40))%>
                                                        </span>                                                         
                                                    </ItemTemplate>
                                                     
                                                 <ItemStyle Width="40%" Height="18px" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Status" SortExpression="Status">
                                                    <ItemTemplate>
                                                        <span title='<%# Eval("StatusName") %>'>
                                                            <%# Server.HtmlEncode(Functions.StringTruncate(Eval("StatusName"),8)) %>
                                                        </span>                                                        
                                                    </ItemTemplate>
                                                    
                                                 <ItemStyle Width="12%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Case Date" SortExpression="CaseDate" >
                                                    <ItemTemplate>
                                                        <span title='<%# CaseMgmt.GetStringDate(Eval("CaseDate")) %>'>
                                                            <%# CaseMgmt.GetStringDate(Eval("CaseDate")) %>
                                                        </span>                                                        
                                                    </ItemTemplate>
                                                    
                                                   <ItemStyle Width="11%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Time Spent" SortExpression="TimeSpent" >                                                    
                                                    <ItemTemplate>
                                                        <div style="text-align:right;" >
                                                            <%# CaseMgmt.GetGridTimeSpent(Eval("TotalTimeSpent").ToString()) %>
                                                        </div>     
                                                    </ItemTemplate>
                                                       <ItemStyle Width="9%" />
                                                    
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Cost" SortExpression="Cost">
                                                <ItemStyle HorizontalAlign="Right" />
                                                    <ItemTemplate>
                                                        <div style="text-align:right;" title='<%#Decimal.Round(Eval("TotalCost"),2)%>'>
                                                            <%#Functions.StringTruncate(Decimal.Round(Eval("TotalCost"),2),7) %>
                                                        </div>
                                                    </ItemTemplate>
                                                   
                                                   <ItemStyle Width="7%" />
                                                </asp:TemplateField> 
                                                <asp:TemplateField HeaderText="Last Activity" SortExpression="LastActivity">
                                                    <ItemTemplate>
                                                        <span title='<%# Functions.DateDiffInWords(Eval("ModifiedDate")) %>'>
                                                            <%#Functions.StringTruncate(Functions.DateDiffInWords(Eval("ModifiedDate")), 12)%>
                                                        </span>                                                        
                                                    </ItemTemplate>
                                                     <ItemStyle Width="13%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField ShowHeader="False">
                                                    <ItemTemplate>
                                                       <a  href="#" onclick='window.event.cancelBubble = true;SetPostBack(<%# Eval("ID")%>)' style="height:18px;">Edit</a> <%-- <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("ID", "Legal_Case_Edit.aspx?ID={0}") %>' Text="Edit" onclick="javascript:event.cancelBubble=true;"></asp:HyperLink>--%>
                                                    </ItemTemplate>
                                                   
                                                       <ItemStyle Width="5%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField ShowHeader="False">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="LinkButton1" CssClass="headerHeight" runat="server"  CausesValidation="false" CommandArgument='<%#Container.DataItem("ID")%>' CommandName="Delete" Text="Delete" OnClientClick="javascript:event.cancelBubble=true;return confirm('Are you sure you want to delete this Case?')"></asp:LinkButton>
                                                    </ItemTemplate>
                                                     
                                                       <ItemStyle Width="7%" />
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                            </ContentTemplate>
                                            <Triggers>
                                                 <asp:AsyncPostBackTrigger ControlID="ddlType" EventName="SelectedIndexChanged" />
                                                 <asp:AsyncPostBackTrigger ControlID="ddlFirm" EventName="SelectedIndexChanged" />
                                                 <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                                                 <asp:AsyncPostBackTrigger ControlID="ddlStatus" EventName="SelectedIndexChanged" />
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
                                       <asp:ObjectDataSource ID="LegaLCasesDS" runat="server" SelectMethod="GetAllCases" SelectCountMethod="GetAllCasesCount" 
                                        TypeName="CaseMgmt" DeleteMethod="DeleteCase" SortParameterName="SortExpression" EnablePaging="true" >
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="ddlFirm" Name="FirmID" PropertyName="SelectedValue"
                                                Type="Int32" />
                                            <asp:ControlParameter ControlID="ddlType" Name="Type" PropertyName="SelectedValue"
                                                Type="Int32" />
                                            <asp:ControlParameter ControlID="ddlStatus" Name="Status" PropertyName="SelectedValue"
                                                Type="Int32" />
                                            <asp:Parameter Name="SortExpression" Type="String" />
                                            <asp:ControlParameter ControlID="txtSearch" Name="Search" PropertyName="Text" Type="String" />
                                        </SelectParameters>
                                        <DeleteParameters>
                                            <asp:Parameter Name="ID" Type="Int32" />
                                        </DeleteParameters>
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
