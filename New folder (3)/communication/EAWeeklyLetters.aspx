<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EAWeeklyLetters.aspx.vb" Inherits="admin_comm_EAWeeklyLetters" StylesheetTheme="Default"  Theme="Default"  %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>EAI Weekly</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js" ></script>
</head>
<body style="margin:0; padding:0;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="300" />
    <asp:UpdateProgress ID="Progress1" runat="server">
        <ProgressTemplate>
            <div class="ProgressIndicatorDivGray" style="right:20px;bottom:40px;" >
                <br />
                <asp:Image ID="Image2" runat="server" ImageUrl="~/images/indicator.gif" ImageAlign="AbsMiddle" /> <span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
                <br /><br />
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div>
        <table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%;">
            <tr class="GalleryTitle" style="background-image:url('../images/bg_mainHdr_1.jpg');height:31px;">
                <td style="height:31px;background-color:#A0CDEE;font-size:12px;padding:3px;width:50%;" >Weekly Letters - 
                    <asp:UpdatePanel ID="upHeaderCount" 
                        runat="server"
                        UpdateMode="Always"
                        RenderMode="Inline">
                        <ContentTemplate>
                            <asp:Literal runat="server" ID="lblRecCount" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <td style="text-align:right;width:50%;">
                    <asp:Button ID="btnResetFilters" runat="server" OnClientClick="javascript:resetFilters();" Text="Reset Filter" CssClass="btnSilver" />&nbsp;
                </td>
            </tr>
            <tr>
        <td colspan="2" style="height:40px;background-color:#BADCFC;" >
        <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" >
    	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="height:100%;" class="gvwSearchSilver">
        	<tr>
                <td  style="width:210px;">&nbsp;
                    <input type="button" id="btnAddWeeklyLetter"  onclick="return RedirectToPage(null);"  class="btnSilver" value='New Weekly Letter' style="width:110px" />                    
                </td><td style="width:190px;">&nbsp;</td><td style="width:220px;">&nbsp;</td>
                <td align="right" style="width:170px;"></td>
                            <td align="right">&nbsp;
                                <asp:DropDownList 
                                     ID="ddlStatus"
                                     CssClass="ddlSmall"
                                     runat="server"
                                     Width="80px"
                                     AutoPostBack="True">
                                     <asp:ListItem Value=""   Text="Show All" />
                                     <asp:ListItem Value="false" Selected="True" Text="Pending"  />
                                     <asp:ListItem Value="true" Text="Published" />
                                </asp:DropDownList> 
					        </td>
					        <td align="right">&nbsp;<asp:TextBox ID="txtSearch" runat="server" MaxLength="50" Width="150px" onfocus="this.value='';" CssClass="txtNormal" /></td>
					        <td>&nbsp;<cc1:TextBoxWatermarkExtender ID="wtxtSearch"  runat="server" TargetControlID="txtSearch"  WatermarkText="Search" WatermarkCssClass="txtWaterMark" EnableViewState="false">
                        </cc1:TextBoxWatermarkExtender></td>
                        <td align="right">&nbsp;<asp:Button ID="btnSearch"  Width="40px" runat="server" CssClass="btnSilver" Text="GO" />&nbsp;
                   </td>     
                </tr>
            </table>
            </asp:Panel>
                </td>
                </tr>
                <tr>
                <td colspan="2" height="100%">
                    <div id="divWeeklyLetters" style="height:100%; width:100%; overflow-y:auto;" >
                        <asp:UpdatePanel ID="upWeeklyLetters" runat="server" UpdateMode="conditional" RenderMode="Block">
                            <ContentTemplate>
                                <asp:GridView ID="gvLetters" runat="server" AutoGenerateColumns="False" Width="100%"  SkinID="gvwSilver"
                                DataSourceID="odsLetters" AllowPaging="true" AllowSorting="true" Height="100%" ShowFooter="true" EnableViewState="false">
                                    <Columns>
                                        <asp:TemplateField SortExpression="Title" HeaderText="Title" HeaderStyle-Width="70%">
                                            <ItemTemplate><b><span title='<%# Convert.ToString(Container.DataItem("Title")).Replace("'", "") %>'>
                                                <asp:Literal ID="ltlTitle" runat="server" Text='<%# Container.DataItem("Title") %>'></asp:Literal></span></b>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                &nbsp;
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="PublishDate" SortExpression="PublishDate" HeaderText="Published On" DataFormatString="{0:MMM dd, yyyy}" HtmlEncode="False"  HeaderStyle-Width="15%">                                            
                                        </asp:BoundField>
                                        <asp:TemplateField SortExpression="IsPublished" HeaderText="Status" HeaderStyle-Width="10%">
                                            <ItemTemplate><span title='<%# IIf(CBool(Container.DataItem("IsPublished")) = True, "Published", "Pending") %>'>
                                                <%#IIf(CBool(Container.DataItem("IsPublished")) = True, "Published", "Pending")%></span>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                &nbsp;
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:templatefield headertext="Action" HeaderStyle-Width="5%">
                                            <ItemTemplate>
                                                <asp:linkbutton id="lnkBtnEdit" runat="server" text="Edit" CausesValidation="false"></asp:linkbutton>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                &nbsp;
                                            </FooterTemplate>
                                        </asp:templatefield>  
                                        </Columns>
                                    <PagerSettings Mode="NextPreviousFirstLast" Visible="true" Position="Bottom" />
                                    <PagerTemplate>
                                        <table id="tblPager" width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>                        
                                               <td style="border:0; width:85%;">Showing Weekly Letter <asp:Literal ID="ltrlStartCount" runat="server" Text="0"></asp:Literal> to <asp:Literal ID="ltrlEndCount" runat="server" Text="0"></asp:Literal> of <asp:Literal ID="ltrlTotalCount" runat="server" Text="0"></asp:Literal></td> 
                                               <td style="border:0;white-space:nowrap;" align="right" nowrap>Page&nbsp;<asp:Literal ID="ltrlStartPage" runat="server" Text="0"></asp:Literal> of <asp:Literal ID="ltrlLastPage" runat="server" Text="0"></asp:Literal>&nbsp;&nbsp;&nbsp;<asp:LinkButton ID="lnkBtnFirst" runat="server" CommandName="page" CommandArgument="first"><asp:Image ID="imgFirst" runat="server" ImageUrl="../images/First_blk.jpg" ToolTip="First" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnPrevious" runat="server" CommandName="page" CommandArgument="prev"><asp:Image ID="imgPrevious" runat="server" ImageUrl="../images/back_blk.jpg" ToolTip="Previous" /></asp:LinkButton> &nbsp;<asp:LinkButton ID="lnkBtnNext" runat="server" CommandName="page" CommandArgument="next"><asp:Image ID="imgNext" runat="server" ImageUrl="../images/Next_blk.jpg"  ToolTip="Next" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnLast" runat="server" CommandName="page" CommandArgument="last"><asp:Image ID="imgLast" runat="server" ImageUrl="../images/Last_blk.jpg" ToolTip="Last" /></asp:LinkButton>&nbsp;&nbsp;&nbsp;</td>
                                            </tr>
                                        </table>
                                    </PagerTemplate>
                                 </asp:GridView> 
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnResetFilters" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="ddlStatus" EventName="SelectedIndexChanged" /> 
                               </Triggers>
                        </asp:UpdatePanel> 
                        <asp:ObjectDataSource 
                            ID="odsLetters" 
                            runat="server" EnableViewState="true"
                            SortParameterName="sortExpression"
                            SelectMethod="GetAllWeeklyLetterForComm"  
                            TypeName="Portal.Bll.Communication.WeeklyLetter"
                            SelectCountMethod="GetAllWeeklyLetterCountForComm" 
                            MaximumRowsParameterName="maximumRows"
                            StartRowIndexParameterName="startRowIndex" EnablePaging="True">
                        <SelectParameters>
                            <asp:ControlParameter Name="isPublished" Type="Boolean"  ControlID="ddlStatus"  />
                            <asp:ControlParameter Name="search" Type="String" ControlID="txtSearch" PropertyName="Text" ConvertEmptyStringToNull="false" />
                        </SelectParameters>
                        </asp:ObjectDataSource> 
                    </div>
               </td>
             </tr>
             <tr id="trPager" class="pager" style="display:none;">
                <td id="tdPager" style="height:20px; border-top:solid 1px #B7CFE2;" colspan="2" >&nbsp;</td>
             </tr> 
        </table>
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
                if (updatedPanels[i].id == '<%=upWeeklyLetters.ClientID %>') {                                     
                    AdjustPagerRow(); 
                }
            }
        }
        function onPageLoading(sender, e) {
        }  
    

    function EditWeeklyLetter(weeklyLetterId, trSelected){      
      trSelected.className = "selected";
      RedirectToPage(weeklyLetterId);      
    } 
    function ShowWeeklyLetterDetail(weeklyLetterId, trSelected){      
      trSelected.className = "selected";
      var Status = document.getElementById ('<%=ddlStatus.ClientID%>').value;
      parent.window.location='WeeklyLetter_Head.aspx?AdminMgmt=1&LetterId='+weeklyLetterId + '&IsPublished=' + Status + '&backPageURL=EAIWeeklyList';
    } 
    function ShowWeeklyLetterDetail(weeklyLetterId,status,trSelected){      
       trSelected.className = "selected";
       parent.window.location='WeeklyLetter_Head.aspx?AdminMgmt=1&LetterId='+weeklyLetterId + '&IsPublished=' + status + '&backPageURL=EAIWeeklyList';
    }
    function RedirectToPage(weeklyLetterId){
      var Search = document.getElementById ('<%=txtSearch.ClientID%>').value;
      var Status = document.getElementById ('<%=ddlStatus.ClientID%>').value;      
      if (Search.toLowerCase().match('search'))
        Search = '';      
      if(weeklyLetterId!= null){
        window.location='weeklyletter_edit.aspx?LetterId='+weeklyLetterId + '&Search='+ Search +'&Status='+ Status;        
        }
      else{        
        window.location='WeeklyLetter_New.aspx?Search='+ Search +'&Status='+ Status;               
      }     
    }
    function resetFilters(){
        var item;
        if (item = getElement('<%= txtSearch.ClientID %>')){
            item.value = '';
        }
        if (item = getElement('<%= ddlStatus.ClientID %>')){
            item.value = '';
        }
    }
</script>
    </div>
    </form>
</body>
</html>
