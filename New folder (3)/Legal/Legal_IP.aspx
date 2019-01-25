<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Legal_IP.aspx.vb" Inherits="admin_Legal_Legal_IP" StylesheetTheme="Default"%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>LegalIP</title>
    <link href="Style/style.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"> </script>
<script type="text/javascript" language="javascript">
function ShowDivDel(ID)
{
DivDeleteMessage.style.display='inline';

}
function Reset()
{
document.getElementById("txtSearch").value="";
document.getElementById("ddlFirm").value="-1";
document.getElementById("ddlType").value="-1";
document.getElementById("ddlStatus").value="-1";
document.getElementById("ddlCountry").value="-1";
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
<body style="margin: 0px; height: 100%; width: 100%; padding: 0px;" scroll="no" class="ScrollBarHomeTicket">
    <form id="form1" runat="server">
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
    </script>
        <asp:ScriptManager ID="ScriptManager2" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="upIdeaCount" runat="server" RenderMode="Inline">
        <ContentTemplate>
            <asp:Literal ID="ltrlRecordCount" runat="server" Text="0" Visible="false" ></asp:Literal></span>
        </ContentTemplate>
    </asp:UpdatePanel>
   <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
            <div class="ProgressIndicatorDIV" style="width:150px;bottom:8px; right: 8px;" >
                <br />
                <asp:Image ID="Images2" runat="server" ImageUrl="~/images/indicator.gif" ImageAlign="AbsMiddle" /><span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
                <br /><br />
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
        <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0"
            style="padding: 0px; margin: 0px; width: 100%;" class="Table">
            <tr class="GalleryTitle" style="background-image:url('images/bg_mainHdr_1.jpg');height:31px;">
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="always" RenderMode="Inline">
                        <ContentTemplate>
                             <b>&nbsp; Intellectual Property&nbsp;-&nbsp;<asp:Label runat="server" ID="lblIPCount" /></b>
                            &nbsp;
                        </ContentTemplate>
                    </asp:UpdatePanel>  
                </td>
                <td style="text-align:right; padding-right:3px;">
                    <asp:ImageButton ID="reset" runat="server" ImageUrl="images/btn_ResetFilters.jpg" OnClientClick="Reset();"   />
                </td>
            </tr>
            <tr>
                <td style="height: 100%; width: 100%;" colspan="2">
                    <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;height: 100%;"   class="gvwSearchSilver">
                        <tr class="gvwSearchSilver">
                            <td height="31px" class="" align="center" style="width: 100%; " colspan="2" >
                                <table width="100%;"  border="0" style="text-align: left" align="center" cellpadding="0" cellspacing="0">
                                    <tr >
                                    <td width="80" style="height: 43px;padding-Left:10px;padding-bottom:5px;">
                                            <span class="GreyTextSmall">&nbsp;&nbsp;
                                                <input value="New IP" id="btnNewIP" type="button" class="btnSilver"
                                                    onclick="parent.parent.frameMain.location='NewLegalIP.aspx';" style="width: 80px" />&nbsp;&nbsp;
                                            </span>
                                    </td>
                                    
                                      
                                        <td style="width:10px;text-align:center;">
                                            &nbsp;<span class="line_Gray"></span>
                                      </td>
                                          <td width="100" style="padding-left: 8px; height: 43px;">
                                            <span class="GreyTextSmall">Firm/Vendor:<br />
                                                <asp:DropDownList ID="ddlFirm" runat="server" CssClass="SmallFontInput" DataSourceID="FirmDS"
                                                    DataTextField="Name" DataValueField="ID" AutoPostBack="True" AppendDataBoundItems="True" Width="100px">
                                                    <asp:ListItem Value="-1">All</asp:ListItem>
                                                </asp:DropDownList>&nbsp;&nbsp;</span>
                                                <asp:SqlDataSource ID="FirmDS" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                  SelectCommand="Legal_Firm_GetAll_ForList" DataSourceMode="DataReader" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                        </td>
                                       <td style="width:10px;text-align:center;">
                                            &nbsp;<span class="line_Gray"></span>
                                      </td>
                                        <td style="padding-left: 8px; height: 43px; width: 85px;">
                                            <span class="GreyTextSmall">Type:<br />
                                                <asp:DropDownList ID="ddlType" runat="server" CssClass="SmallFontInput" DataTextField="Name"
                                                    DataValueField="ID" AutoPostBack="True" AppendDataBoundItems="True" DataSourceID="sdsIPTypes">
                                                    <asp:ListItem Value="-1">All</asp:ListItem>
                                                </asp:DropDownList>&nbsp;<asp:SqlDataSource ID="sdsIPTypes" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                    SelectCommand="Legal_GetIPTypes" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                            </span></td>
                                        <td style="width:10px;text-align:center;">
                                            &nbsp;<span class="line_Gray"></span>
                                      </td>
                                        <td style="height: 43px; padding-left: 8px; width:70px;">
                                            <span class="GreyTextSmall">Status:<br />
                                                <asp:DropDownList ID="ddlStatus" runat="server" Width="100" AutoPostBack="True" CssClass="SmallFontInput" AppendDataBoundItems="True" DataSourceID="sdsIPStatus" DataTextField="Name" DataValueField="ID">
                                                    <asp:ListItem Value="-1">All</asp:ListItem>
                                                    <asp:ListItem Value="5">All Active</asp:ListItem>
                                                </asp:DropDownList><asp:SqlDataSource ID="sdsIPStatus" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                    SelectCommand="Legal_GetIPStatusTypes" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                            </span>
                                        </td>

                                       <td style="width:10px;text-align:center;">
                                            &nbsp;<span class="line_Gray"></span>
                                      </td>

                                        <td style="height: 43px; padding-left: 8px;">
                                            <span class="GreyTextSmall">Country:<br />
                                                 <asp:DropDownList ID="ddlCountry" runat="server" CssClass="SmallFontInput" Width="100px"
                                                    DataSourceID="odsCountries" DataTextField="Name" DataValueField="ID" AutoPostBack="true" AppendDataBoundItems="true">
                                                    <asp:ListItem Value="-1">All</asp:ListItem>
                                                </asp:DropDownList>
                                                 <asp:ObjectDataSource ID="odsCountries" runat="server" SelectMethod="GetAll"
                                                    TypeName="Legal_Country" >
                                                </asp:ObjectDataSource>                                                
                                            </span>
                                        </td>
                                      <td>
                                        &nbsp;
                                      </td> 
                                       <td style="width:10px;text-align:center;">
                                            &nbsp;<span class="line_Gray"></span>
                                      </td>
                                      <td style="height: 43px; width: 200px; padding-left:5px;width:180px;">
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
                            <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" style="width: 100%; border-top: solid 1px #609BD3;border-bottom: solid 1px #609BD3">
                                <div style="overflow: auto; height: 100%; width: 100%;" class="GrayScrollBar">
                                    <asp:UpdatePanel ID="IPUpdatePanel" runat="server">
                                        <Triggers>
                                     <asp:AsyncPostBackTrigger ControlID="ddlType" EventName="SelectedIndexChanged" />
                                     <asp:AsyncPostBackTrigger ControlID="ddlFirm" EventName="SelectedIndexChanged" />
                                     <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                                     <asp:AsyncPostBackTrigger ControlID="ddlStatus" EventName="SelectedIndexChanged" />
                                     <asp:AsyncPostBackTrigger ControlID="ddlCountry" EventName="SelectedIndexChanged" />
                                     <asp:AsyncPostBackTrigger ControlID="reset" EventName="Click" />
                                     </Triggers>
                                        <ContentTemplate>
                                    <asp:GridView ID="GridView1" runat="server" EnableViewState="true" DataSourceID="LegalIPDS" SkinID="gvwSilver" ShowFooter="true" Height="100%" Width="100%"
                                        AutoGenerateColumns="False" HeaderStyle-CssClass="gvwSilverHeader" AllowSorting="True" DataKeyNames="ID" OnRowCommand="GridView1_RowCommand" AllowPaging="true" >
                                        <Columns>
                                            <asp:TemplateField HeaderText="Name" SortExpression="Title" ItemStyle-Width="150">
                                               <ItemTemplate>
                                                <span title='<%#Eval("Title") %>'>
                                                    <%#Server.HtmlEncode(functions.stringtruncate(IIF(Eval("Title") IS DBNULL.value,"",Eval("Title")),25)) %>
                                                </span>                                                
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                                 <ItemStyle Width="33%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Reg #" SortExpression="RegistrationNo" ItemStyle-Width="80">
                                               <ItemTemplate>
                                                <span title='<%#Eval("RegistrationNo") %>'>
                                                    <%#functions.stringtruncate(IIF(Eval("RegistrationNo")IS Dbnull.value,"",Eval("RegistrationNo")),12)%>
                                                </span>                                                    
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                                <ItemStyle Width="13%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="First Used" SortExpression="DateFirstUsed">
                                                <ItemTemplate>
                                                    <span title='<%#IntellectualProperty.GetStringDate(Eval("DateFirstUsed"))%>'>
                                                        <%# IntellectualProperty.GetStringDate(Eval("DateFirstUsed")) %>                                                    
                                                    </span>                                                    
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                                <ItemStyle Width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Firm/Vendor" SortExpression="FirmName">
                                                <ItemTemplate>
                                                    <span title='<%# Eval("Name") %>'>
                                                        <%#Functions.StringTruncate(IIf(Eval("Name") Is DBNull.Value, "", Eval("Name")), 8)%>
                                                    </span>                                                    
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                                <ItemStyle Width="12%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status" SortExpression="Status">
                                                <ItemTemplate>
                                                    <span title='<%# Server.HtmlEncode(Eval("StatusName")) %>'>
                                                        <%# Server.HtmlEncode(functions.stringtruncate(IIF(Eval("StatusName") IS DBNULL.value,"",Eval("StatusName")),8)) %> 
                                                    </span>                                                    
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                                <ItemStyle Width="9%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Last Activity" SortExpression="LastActivity">
                                                <ItemTemplate>
                                                <span title='<%#Functions.DateDiffInWords(Eval("LastActivity"))%>'>
                                                        <%#functions.stringtruncate(Functions.DateDiffInWords(Eval("LastActivity")),15)%>
                                                </span>                                                    
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                                <ItemStyle Width="14%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField ShowHeader="False">
                                                <ItemTemplate>
                                                    <a  href="#" onclick='window.event.cancelBubble = true;SetPostBack(<%# Eval("ID")%>)'>Edit</a> 
                                                 </ItemTemplate>
                                                <ItemStyle Width="4%" />
                                                <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkbtnDelete" CausesValidation="false" runat="server" CommandArgument='<%#Container.DataItem("ID")%>' CommandName="Delete" Text="Delete" OnClientClick="javascript:event.cancelBubble=true;return confirm('Are you sure you want to delete this Intellectual Property?')" ></asp:LinkButton>
                                                </ItemTemplate>
                                                <ItemStyle Width="5%" />
                                                <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                     <PagerStyle CssClass="gvwSilverPager" />
                                       <PagerSettings Mode="NextPreviousFirstLast" Visible="true" Position="Bottom" />
                                        <PagerTemplate>
                                            <table id="tblPager" width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>                        
                                                   <td style="border:0; ">Showing IP <asp:Literal ID="ltrlStartCount" runat="server" Text="0"></asp:Literal> to <asp:Literal ID="ltrlEndCount" runat="server" Text="0"></asp:Literal> of <asp:Literal ID="ltrlTotalCount" runat="server" Text="0"></asp:Literal></td> 
                                                   <td style="border:0;width:120px;" align="right">Page&nbsp;<asp:Literal ID="ltrlStartPage" runat="server" Text="0"></asp:Literal> of <asp:Literal ID="ltrlLastPage" runat="server" Text="0"></asp:Literal>&nbsp;&nbsp;&nbsp;<asp:LinkButton ID="lnkBtnFirst" runat="server" CommandName="page" CommandArgument="first"><asp:Image ID="imgFirst" runat="server" ImageUrl="images/First_blk.jpg" ToolTip="First" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnPrevious" runat="server" CommandName="page" CommandArgument="prev"><asp:Image ID="imgPrevious" runat="server" ImageUrl="images/back_blk.jpg" ToolTip="Previous" /></asp:LinkButton> &nbsp;<asp:LinkButton ID="lnkBtnNext" runat="server" CommandName="page" CommandArgument="next"><asp:Image ID="imgNext" runat="server" ImageUrl="Next_blk.jpg"  ToolTip="Next" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnLast" runat="server" CommandName="page" CommandArgument="last"><asp:Image ID="imgLast" runat="server" ImageUrl="images/Last_blk.jpg" ToolTip="Last" /></asp:LinkButton>&nbsp;&nbsp;&nbsp;</td>
                                                </tr>
                                            </table>
                                        </PagerTemplate>
                                    <EmptyDataTemplate>                
                                         <table class="NoRecord">
                                            <tr>                            
                                                <td>
                                                    <img align="absmiddle" src="images/ico_alert.gif" />&nbsp;&nbsp;No Record Found !
                                                </td>
                                            </tr>
                                         </table>                
                                    </EmptyDataTemplate> 
                                    </asp:GridView>
                                    <asp:ObjectDataSource ID="LegalIPDS" runat="server" SelectMethod="GetAllLegalIPs" SelectCountMethod="GetAllLegalIPsCount" 
                                        TypeName="IntellectualProperty" SortParameterName="SortExpression" DeleteMethod="DeleteLegalIP" EnablePaging="true"  >
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="ddlFirm" DefaultValue="0" Name="FirmID" PropertyName="SelectedValue"
                                                Type="Int32" />
                                            <asp:ControlParameter ControlID="ddlType" DefaultValue="" Name="Type" PropertyName="SelectedValue"
                                                Type="Int32" />
                                            <asp:ControlParameter ControlID="ddlStatus" Name="Status" PropertyName="SelectedValue"
                                                Type="Int32" />
                                            <asp:ControlParameter ControlID="ddlCountry" Name="Country" PropertyName="SelectedValue"
                                                Type="Int32" />
                                            <asp:Parameter Name="SortExpression" Type="String" />
                                            <asp:ControlParameter ControlID="txtSearch" Name="Search" PropertyName="Text" Type="String" />
                                        </SelectParameters>
                                        <DeleteParameters>
                                            <asp:Parameter Name="ID" Type="Int32" />
                                        </DeleteParameters>
                                    </asp:ObjectDataSource>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>                                   
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
             <tr id="trPager">
                    <td id="tdPager" colspan="2"  style="width:100%;">     
                    </td>
              </tr>       
        </table>
    </form>
</body>
</html>
  <script language="javascript" type="text/javascript">
  function SetPostBack(id)
  {    
        
        var firm        = document.getElementById('<%= ddlFirm.ClientID  %>');
        var type        = document.getElementById('<%= ddlType.ClientID %>');
        var Status      = document.getElementById('<%= ddlStatus.ClientID %>');
        var country     = document.getElementById('<%= ddlCountry.ClientID %>');
        
        var location = 'Legal_IP_Edit.aspx?ID='+id+'&firm='+firm.options.value+'&type='+type.options.value+'&status='+Status.options.value+'&country='+country.options.value;
        window.location = location;
  }
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
            if (updatedPanels[i].id == '<%= IPUpdatePanel.ClientID %>') {
                $get('<%= txtSearch.ClientID %>').value='';
                AdjustPagerRow();
            }
        }
    }
   
    </script>
