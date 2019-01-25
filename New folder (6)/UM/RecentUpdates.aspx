<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RecentUpdates.aspx.vb" Inherits="UM_RecentUpdate" StylesheetTheme="Default"    %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Recent Updates</title>
    <link href="../UM/style/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <meta http-equiv="Page-Enter" content="progid:DXImageTransform.Microsoft.Fade(duration=1)" />
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=1)" />
</head>
<body style="margin:0px; overflow:auto;">
    <form id="form1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="upHiddenFields" runat="server" RenderMode="Inline" UpdateMode="Always">
          <ContentTemplate>            
            <asp:HiddenField ID="hdnCategoryID" runat="server" Value="0" />
          </ContentTemplate>
    </asp:UpdatePanel>
    <div id="divDisable" class="modalBackground" style="z-index:2;"></div>
  <asp:UpdateProgress ID="Progress1" runat="server">
      <ProgressTemplate>  
            <div class="ProgressIndicatorDivGray">                            
            <br />
            <img src="images/indicator.gif" align="absmiddle" /><b>&nbsp;&nbsp;Loading ...</b>
            <br /><br />
            </div>  
        </ProgressTemplate>
        </asp:UpdateProgress>
    <div>
   <asp:UpdatePanel ID="upIdeaCount" runat="server" RenderMode="Inline">
        <ContentTemplate>
            <asp:Literal ID="ltrlRecordCount" runat="server" Text="0" Visible="false" ></asp:Literal></span>
        </ContentTemplate>
    </asp:UpdatePanel>
    <table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%;">
            <tr class="GalleryTitle" style="background-image:url('images/bg_mainHdr_1.jpg');height:31px;">
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                             <b>&nbsp;Recent Updates&nbsp;-&nbsp;<asp:Label runat="server" ID="lblCategoryCount" /></b>
                            &nbsp;
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                              
                            <asp:AsyncPostBackTrigger ControlID="imgresetFilters" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>  
                </td>
                <td style="text-align:right; padding-right:3px; display:none;">
                    <asp:ImageButton ID="imgresetFilters" runat="server" ImageUrl="images/btn_ResetFilters.jpg" OnClientClick="resetFilters();"   />
                </td>
            </tr>
            <tr style="height:41px;">
                <td colspan="2" style="height: 41px" valign="middle">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="gvSearch" style="height:41px;">
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td style="padding-left:5px; width:220px;">
                                <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSearch" Wrap="true"  >
                                    Search
                                    <asp:TextBox ID="txtSearch" runat="server" MaxLength="50" Width="150px" onfocus="this.value='';" CssClass="txtGray"  />
                                    <asp:ImageButton ID="btnSearch" runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle"  />
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                    </td>
            </tr>
            <tr style="height:100%; width:100%;">
                <td colspan="2" valign="top">
                    <div style="overflow:auto; height:100%; width:100%; background-color:#E4F1F7;border:1px solid #ACBDD5;" class="GrayScrollBar">
                        <asp:UpdatePanel ID="UPTopics" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:GridView id="gvTopics" DataKeyNames="ID" EnableViewState="true"  
                                    runat="server" DataSourceID="odsTopics" EnableTheming="True" Height="100%" Width="100%" AllowPaging="false"   
                                    AutoGenerateColumns="False" SkinID="gvwSilver" HeaderStyle-CssClass="gvwSilverHeader" ShowFooter="true" pageSize="100" OnRowCreated="gvTopics_RowCreated" >
                                     <PagerStyle CssClass="gvwSilverPager" />
                                       <PagerSettings Mode="NextPreviousFirstLast" Visible="true" Position="Bottom" />
                                        <PagerTemplate>
                                            <table id="tblPager" width="100%" border="0" cellspacing="0" cellpadding="0" style="background-color:green;">
                                                <tr>                        
                                                   <td style="border:0; width:80%;">Showing Topics <asp:Literal ID="ltrlStartCount" runat="server" Text="0"></asp:Literal> to <asp:Literal ID="ltrlEndCount" runat="server" Text="0"></asp:Literal> of <asp:Literal ID="ltrlTotalCount" runat="server" Text="0"></asp:Literal></td> 
                                                   <td style="border:0;" align="right">Page&nbsp;<asp:Literal ID="ltrlStartPage" runat="server" Text="0"></asp:Literal> of <asp:Literal ID="ltrlLastPage" runat="server" Text="0"></asp:Literal>&nbsp;&nbsp;&nbsp;<asp:LinkButton ID="lnkBtnFirst" runat="server" CommandName="page" CommandArgument="first"><asp:Image ID="imgFirst" runat="server" ImageUrl="../../admin/VendorManagement/images/First_blk.jpg" ToolTip="First" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnPrevious" runat="server" CommandName="page" CommandArgument="prev"><asp:Image ID="imgPrevious" runat="server" ImageUrl="../../admin/VendorManagement/images/back_blk.jpg" ToolTip="Previous" /></asp:LinkButton> &nbsp;<asp:LinkButton ID="lnkBtnNext" runat="server" CommandName="page" CommandArgument="next"><asp:Image ID="imgNext" runat="server" ImageUrl="../../admin/VendorManagement/images/Next_blk.jpg"  ToolTip="Next" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnLast" runat="server" CommandName="page" CommandArgument="last"><asp:Image ID="imgLast" runat="server" ImageUrl="../../admin/VendorManagement/images/Last_blk.jpg" ToolTip="Last" /></asp:LinkButton>&nbsp;&nbsp;&nbsp;</td>
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
                                    <Columns>
                                         <asp:TemplateField HeaderText="ID" SortExpression="ID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCategoryID" runat="server" ToolTip='<%#Container.DataItem("ID") %>' Text='<%#Functions.StringTruncate(Container.DataItem("ID"),16) %>' Font-Bold="true"  ></asp:Label>
                                                </ItemTemplate>
                                                 <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                            <ItemStyle Width="0%" />
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Topic" SortExpression="Title">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTopiclTitle" runat="server" ToolTip='<%#Container.DataItem("Title") %>' Text='<%#Functions.StringTruncate(Container.DataItem("Title"),40) %>' Font-Bold="true"  ForeColor="black"></asp:Label>
                                                </ItemTemplate>
                                                 <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                            <ItemStyle Width="30%" />
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Category" SortExpression="Manual">
                                            <ItemTemplate>
                                                <asp:Label ID="lblManual" runat="server" ToolTip='<%#Container.DataItem("Manual") %>' Text='<%#Functions.StringTruncate(Container.DataItem("Manual"),20) %>' Font-Bold="false" ForeColor="black"></asp:Label>
                                                </ItemTemplate>
                                                 <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                            <ItemStyle Width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Created By" SortExpression="AddedByAdminName">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCreatedBy" runat="server" ToolTip='<%#Container.DataItem("AddedByAdminName") %>' Text='<%#Functions.StringTruncate(Container.DataItem("AddedByAdminName"),25) %>' Font-Bold="false"  ForeColor="black"  ></asp:Label>
                                                </ItemTemplate>
                                                 <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                            <ItemStyle Width="15%" />
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Created On" SortExpression="AddedOn">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCreatedOn" runat="server" Font-Bold="false" ToolTip='<%#String.Format("{0:MMM dd,yyyy}",Container.DataItem("AddedOn")) %>' Text='<%#String.Format("{0:MMM dd,yyyy}",Container.DataItem("AddedOn")) %>'  ForeColor="black"  ></asp:Label>
                                            </ItemTemplate>
                                             <FooterTemplate>
                                                &nbsp;
                                            </FooterTemplate>
                                            <ItemStyle Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Last Updated By" SortExpression="LastUpdatedBy">
                                            <ItemTemplate>
                                                <asp:Label ID="lblUpdatedBy" runat="server" Font-Bold="false"  ForeColor="black" ToolTip='<%#functions.IfNull(Container.DataItem("LastUpdatedAdminName"),"-")%>' Text='<%#Functions.stringTruncate(Functions.IfNull(Container.DataItem("LastUpdatedAdminName"),"-"),17) %>' ></asp:Label>
                                            </ItemTemplate>
                                             <FooterTemplate>
                                                &nbsp;
                                            </FooterTemplate>
                                            <ItemStyle Width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Last Updated On" SortExpression="LastUpdatedOn">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLastUpdatedOn" runat="server"  ForeColor="black" Font-Bold="false" ToolTip='<%#Functions.DateDiffInWords(Container.DataItem("LastUpdatedOn"))%>' Text='<%#Functions.DateDiffInWords(Container.DataItem("LastUpdatedOn")) %>' ></asp:Label>
                                            </ItemTemplate>
                                             <FooterTemplate>
                                                &nbsp;
                                            </FooterTemplate>
                                            <ItemStyle Width="15%" />
                                        </asp:TemplateField>
                                        </Columns>
                                 </asp:GridView> 
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="imgresetFilters" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                               </Triggers>
                        </asp:UpdatePanel> 
                        </div>
                    <asp:ObjectDataSource ID="odsTopics" runat="server" SortParameterName="SortExpression"
                        SelectMethod="GetRecentlyUpdatedTopics" TypeName="Portal.BLL.UM.Topic" EnablePaging="false" DeleteMethod="Delete">
                        <SelectParameters>
                            <asp:ControlParameter Name="Search" ControlID="txtSearch" PropertyName="Text" ConvertEmptyStringToNull="false"/>
                            <asp:Parameter Name="SortExpression" Type="String" />
                       </SelectParameters> 
                    </asp:ObjectDataSource>
               </td>
             </tr>
             <tr id="trPager">
                <td id="tdPager" colspan="2">     
                </td>
            </tr>
        </table>
    </div>
    <div id="divCategory" style="width:300px; height:150px; position:absolute; display:none;" >
    <asp:Panel ID="pnlCategory" runat="server" DefaultButton="btnSaveCategory">
    <table cellpadding="0" cellspacing="0" border="0" style="width:100%; height:100%;" class="tblAddFolder">
        <tr style="height:20px; padding:3px;">
            <th align="left">                
                 <label id="lblCategory"></label>                
            </th>
            <th align="right"><span onclick="CloseCategoryDiv();" style="cursor:pointer;">X</span></th>
        </tr>
        <tr>
            <td colspan="2" align="center">
            <asp:UpdatePanel ID="upCategory" runat="server" UpdateMode="Always">
            <ContentTemplate>
                 <span class="BoldText">Title:<span class="RequiredField">*</span>&nbsp;&nbsp;</span><asp:TextBox ID="txtTitle" ValidationGroup="vgCategory" runat="server" MaxLength="50"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ErrorMessage="<br>Title is required" Display="Dynamic" ControlToValidate="txtTitle" ValidationGroup="vgCategory"></asp:RequiredFieldValidator>
                  <asp:CustomValidator ID="cvCategory" ControlToValidate="txtTitle" runat="server" Display="Dynamic" ErrorMessage="<br>Category with this title exits" ValidationGroup="vgCategory"></asp:CustomValidator>
             </ContentTemplate>
            </asp:UpdatePanel>
            </td>
        </tr>
        <tr style="height:20px;">
            <td colspan="2" align="center">  
                <asp:Button ID="btnSaveCategory" runat="server" CssClass="btnSimpleSmall" Text="Save" ValidationGroup="vgCategory" OnClientClick="SetDefaultButton();" />
                <input type="button" value="Cancel"  class="btnSimpleSmall"  id="btnCancelCategory" onclick="CloseCategoryDiv();" >
            </td>
        </tr> 
        <tr>
            <td>&nbsp;</td>
        </tr>                   
    </table>
    </asp:Panel>
    
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
    function ConfirmDeletion(){
                return confirm("Are you sure you want delete this activity type ?");
       } 
       function AddCategory(){
        lblCategory.innerText='New Manual';
        divCategory.className="darkGreenColor";
        divCategory.style.left = "0";
        divCategory.style.top =getRealTop(getElement('btnAddCategory'))+23;
        divCategory.style.display='inline';
        getElement('<%= hdnCategoryID.ClientID %>').value = '0';
        getElement('<%= txtTitle.ClientID %>').value = '';
        getElement('<%= txtTitle.ClientID %>').focus();     
       }
       
       function EditCategoryDiv(id, title){
        lblCategory.innerText='Edit Category';
        divCategory.style.left ="25%";
        divCategory.style.top ="25%";
        divCategory.style.display='inline';
        getElement('<%= hdnCategoryID.ClientID %>').value = id;    
        getElement('<%= txtTitle.ClientID %>').value = title;
        getElement('<%= txtTitle.ClientID %>').focus();     
       }
        function CloseCategoryDiv(){
        divAddCategory.className="";
        divCategory.style.display='none';
        getElement('<%= txtTitle.ClientID %>').value='';
       }
    </script>
    </form>
</body> 
</html>
<script language="javascript" type="text/javascript">
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
            if (updatedPanels[i].id == '<%= UPTopics.ClientID %>') {
                $get('<%= txtSearch.ClientID %>').value='';
                AdjustPagerRow();
            }
        }
    }
    function resetFilters(){
        var item;
        if (item = getElement('<%= txtSearch.ClientID %>')){
            item.value = '';
        }
    }
    function SetDefaultButton()
    {
       __defaultFired = false;
    } 
   </script> 

