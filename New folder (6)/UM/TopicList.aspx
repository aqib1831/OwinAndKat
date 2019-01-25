<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TopicList.aspx.vb" Inherits="UM_TopicList" StylesheetTheme="Default"   %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Topics</title>
    <link href="../UM/style/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <meta http-equiv="Page-Enter" content="progid:DXImageTransform.Microsoft.Fade(duration=1)" />
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=1)" />
</head>
<body style="margin:0px; overflow:auto;" onload="changeSettings();" >
    <form id="form1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="upHiddenFields" runat="server" RenderMode="Inline" UpdateMode="Always">
          <ContentTemplate>            
            <asp:HiddenField ID="hdnTopicID" runat="server" Value="0" />
          </ContentTemplate>
        </asp:UpdatePanel>
    <div id="divDisable" class="modalBackground" style="z-index:2;"></div>
  <asp:UpdateProgress ID="Progress1" runat="server">
      <ProgressTemplate>  
            <div class="ProgressIndicatorDivGray">                            
            <br />
            <img src="../images/indicator.gif" align="absmiddle" /><b>&nbsp;&nbsp;Loading ...</b>
            <br /><br />
            </div>  
        </ProgressTemplate>
        </asp:UpdateProgress>
    <div>
   <asp:UpdatePanel ID="upTopicCount" runat="server" RenderMode="Inline">
        <ContentTemplate>
            <asp:Literal ID="ltrlRecordCount" runat="server" Text="0" Visible="false" ></asp:Literal></span>
        </ContentTemplate>
    </asp:UpdatePanel>
    <table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%;">
            <tr class="GalleryTitle" style="background-image:url('images/bg_mainHdr_1.jpg');height:31px;">
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always"  RenderMode="Inline">
                        <ContentTemplate>
                             <b>&nbsp;Topics&nbsp;-&nbsp;<asp:Label runat="server" ID="lblTopicCount" /></b>
                            &nbsp;
                        </ContentTemplate>
                    </asp:UpdatePanel>  
                </td>
                <td style="text-align:right; padding-right:3px;">
                    <img alt="" src="images/btn_back.jpg" align="absmiddle" onclick="Back();" style="cursor:pointer;" />
                    <asp:ImageButton ID="imgresetFilters" runat="server" ImageUrl="images/btn_ResetFilters.jpg" OnClientClick="resetFilters();"   />
                </td>
            </tr>
            <tr style="height:41px;">
                <td colspan="2" style="height: 41px" valign="middle">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="gvSearch" style="height:41px;">
                        <tr>
                            <td style="width:100px;">
                                <div id="divAddTopic" style="padding:3 4 5 4; width:80%;"><input type="button" value="New Topic" id="btnAddTopic" class="btnSimpleSmall" style="width:80px;" onclick="AddTopic();" ></div>
                          </td>
                          <td>
                          &nbsp;
                          </td>
                            <td style="padding-left:5px; width:220px;">
                                   Category:&nbsp;<asp:DropDownList ID="ddlCategories" runat="server" DataTextField="Title" CssClass="txtGray"
                                    DataValueField="ID" DataSourceID="sdsCategories" AutoPostBack="true" Width="150px" >
                                   </asp:DropDownList>
                                <asp:SqlDataSource ID="sdsCategories" runat="server" SelectCommand="UM_Categories_GetAllForList" SelectCommandType="StoredProcedure" ConnectionString="<%$ConnectionStrings:PortalConnectionString %>"></asp:SqlDataSource>
                            </td>
                            <td style="width:10px;text-align:center;">
                                &nbsp;<span class="line_Gray"></span>
                            </td>
                            <td style="padding-left:5px; width:120px;">
                                   Type:&nbsp;<asp:DropDownList ID="ddlType" runat="server" AutoPostBack="true" CssClass="txtGray">
                                   <asp:ListItem Text ="Show All..." Value="0"></asp:ListItem> 
                                   <asp:ListItem Text ="Public" Value="1"></asp:ListItem> 
                                   <asp:ListItem Text ="Private" Value="2"></asp:ListItem>
                                   <asp:ListItem Text ="Client" Value="3"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td style="width:10px;text-align:center;">
                                &nbsp;<span class="line_Gray"></span>
                            </td>
                            <td style="padding-left:5px; width:220px;">
                                <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSearch" Wrap="true"  >
                                    Search:&nbsp;
                                    <asp:TextBox ID="txtSearch" runat="server" MaxLength="50" Width="150px" onfocus="this.value='';" CssClass="txtGray"  />
                                    <asp:ImageButton ID="btnSearch" runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" OnClientClick="SetDefaultButton();"  />
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
                                <asp:GridView id="gvContent" DataKeyNames="ID" EnableViewState="true"  
                                    runat="server" DataSourceID="odsContent" EnableTheming="True" Height="100%" Width="100%" AllowPaging="true"   
                                    AutoGenerateColumns="False" SkinID="gvwSilver" HeaderStyle-CssClass="gvwSilverHeader" ShowFooter="true" pageSize="50">
                                     <PagerStyle CssClass="gvwSilverPager" />
                                       <PagerSettings Mode="NextPreviousFirstLast" Visible="true" Position="Bottom" />
                                        <PagerTemplate>
                                            <table id="tblPager" width="100%" border="0" cellspacing="0" cellpadding="0" style="background-color:green;">
                                                <tr>                        
                                                   <td style="border:0; width:80%;">Showing Topics <asp:Literal ID="ltrlStartCount" runat="server" Text="0"></asp:Literal> to <asp:Literal ID="ltrlEndCount" runat="server" Text="0"></asp:Literal> of <asp:Literal ID="ltrlTotalCount" runat="server" Text="0"></asp:Literal></td> 
                                                   <td style="border:0;" align="right">Page&nbsp;<asp:Literal ID="ltrlStartPage" runat="server" Text="0"></asp:Literal> of <asp:Literal ID="ltrlLastPage" runat="server" Text="0"></asp:Literal>&nbsp;&nbsp;&nbsp;<asp:LinkButton ID="lnkBtnFirst" runat="server" CommandName="page" CommandArgument="first"><asp:Image ID="imgFirst" runat="server" ImageUrl="images/First_blk.jpg" ToolTip="First" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnPrevious" runat="server" CommandName="page" CommandArgument="prev"><asp:Image ID="imgPrevious" runat="server" ImageUrl="images/back_blk.jpg" ToolTip="Previous" /></asp:LinkButton> &nbsp;<asp:LinkButton ID="lnkBtnNext" runat="server" CommandName="page" CommandArgument="next"><asp:Image ID="imgNext" runat="server" ImageUrl="images/Next_blk.jpg"  ToolTip="Next" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnLast" runat="server" CommandName="page" CommandArgument="last"><asp:Image ID="imgLast" runat="server" ImageUrl="images/Last_blk.jpg" ToolTip="Last" /></asp:LinkButton>&nbsp;&nbsp;&nbsp;</td>
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
                                                <asp:Label ID="lblTopicID" runat="server" ToolTip='<%#Container.DataItem("ID") %>' Text='<%#Functions.StringTruncate(Container.DataItem("ID"),16) %>' Font-Bold="true" ForeColor="black"></asp:Label>
                                                </ItemTemplate>
                                                 <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                            <ItemStyle Width="0%" />
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Topic" SortExpression="Title">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTopicTitle" runat="server" ToolTip='<%#Container.DataItem("Title") %>' Text='<%#Functions.StringTruncate(Container.DataItem("Title"),40) %>' Font-Bold="true" ForeColor="black"></asp:Label>
                                                </ItemTemplate>
                                                 <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                            <ItemStyle Width="27%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Manual" SortExpression="Manual">
                                            <ItemTemplate>
                                                <asp:Label ID="lblManual" runat="server" ToolTip='<%#Container.DataItem("Manual") %>' Text='<%#Functions.StringTruncate(Container.DataItem("Manual"),20) %>' Font-Bold="false" ForeColor="black"></asp:Label>
                                                </ItemTemplate>
                                                 <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                            <ItemStyle Width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Type" SortExpression="Type">
                                            <ItemTemplate>
                                                <asp:Label ID="lblType" runat="server" ToolTip='<%#Container.DataItem("Type") %>' Text='<%#Functions.StringTruncate(Container.DataItem("Type"),16) %>' Font-Bold="false" ForeColor="black"></asp:Label>
                                                </ItemTemplate>
                                                 <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                            <ItemStyle Width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Created By" SortExpression="AddedByAdminName">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCreatedBy" runat="server" ToolTip='<%#Container.DataItem("AddedByAdminName") %>' Text='<%#Functions.StringTruncate(Container.DataItem("AddedByAdminName"),20) %>' Font-Bold="false" ForeColor="black"></asp:Label>
                                                </ItemTemplate>
                                                 <FooterTemplate>
                                                    &nbsp;
                                                </FooterTemplate>
                                            <ItemStyle Width="15%" />
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Created On" SortExpression="AddedOn">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCreatedOn" runat="server" Font-Bold="false" ToolTip='<%#String.Format("{0:MMM dd, yyyy}",Container.DataItem("AddedOn")) %>' Text='<%#String.Format("{0:MMM dd, yyyy}",Container.DataItem("AddedOn")) %>' ForeColor="black"></asp:Label>
                                            </ItemTemplate>
                                             <FooterTemplate>
                                                &nbsp;
                                            </FooterTemplate>
                                            <ItemStyle Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Last Updated By" SortExpression="LastUpdatedBy" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLastUpdatedBy" runat="server" Font-Bold="false" ForeColor="black" ToolTip='<%#functions.IfNull(Container.DataItem("LastUpdatedBy"),"N/A")%>' Text='<%#Functions.stringTruncate(Functions.IfNull(Container.DataItem("LastUpdatedBy"),"N/A"),17) %>' ></asp:Label>
                                            </ItemTemplate>
                                             <FooterTemplate>
                                                &nbsp;
                                            </FooterTemplate>
                                            <ItemStyle Width="0%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Last Updated On" SortExpression="LastUpdatedOn">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLastUpdatedOn" runat="server" Font-Bold="false" ForeColor="black" ToolTip='<%#Functions.DateDiffInWords(Container.DataItem("LastUpdatedOn"))%>' Text='<%#Functions.DateDiffInWords(Container.DataItem("LastUpdatedOn")) %>' ></asp:Label>
                                            </ItemTemplate>
                                             <FooterTemplate>
                                                &nbsp;
                                            </FooterTemplate>
                                            <ItemStyle Width="12%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action" >
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit"></asp:LinkButton>
                                                |
                                                <asp:LinkButton ID="lnkBtnDelete" runat="server" Text="Delete" CommandName="delete" CommandArgument='<%# Eval("ID") %>' OnClientClick="event.cancelBubble=true;return ConfirmDeletion();"></asp:LinkButton>
                                            </ItemTemplate>
                                             <FooterTemplate>
                                                &nbsp;
                                            </FooterTemplate>
                                            <ItemStyle Width="10%" />
                                        </asp:TemplateField>
                                        </Columns>
                                 </asp:GridView> 
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="imgresetFilters" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="ddlCategories" EventName="SelectedIndexChanged" />
                                <asp:AsyncPostBackTrigger ControlID="ddlType" EventName="SelectedIndexChanged" />
                               </Triggers>
                        </asp:UpdatePanel> 
                        </div>
                    <asp:ObjectDataSource ID="odsContent" runat="server" SortParameterName="SortExpression"
                        SelectMethod="GetAllTopicsBySearch" SelectCountMethod="GetAllTopicsBySearchCount" TypeName="Portal.BLL.UM.Topic" EnablePaging="true" DeleteMethod="Delete"  >
                        <SelectParameters>
                            <asp:ControlParameter Name="Search" ControlID="txtSearch" PropertyName="Text" ConvertEmptyStringToNull="false"/>
                            <asp:QueryStringParameter Name="CategoryID" QueryStringField="CategoryID" Type="int32"   />
                            <asp:QueryStringParameter Name="UMType" QueryStringField="UMType" Type="int32"   />
                            <asp:ControlParameter Name="TypeID" ControlID="ddlType" Type="int32"   />
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
<script language="javascript" type="text/javascript">
    function changeSettings()
    {
        switch (parseInt('<%=Request.QueryString("UMType") %>'))
               {
                    case 1:
                             document.getElementById('btnAddTopic').value = "New Topic";
                             break;   
                    case 4:
                             document.getElementById('btnAddTopic').value = "New Topic";
                             break;
               }  
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
    function ConfirmDeletion(){
                return confirm("Are you sure you want delete this topic ?");
       } 
       function AddTopic(){
            switch (parseInt ('<%=Request.QueryString("UMType") %>'))
            {
                case 1:
                       window.location="NewTopic.aspx?UMType="+'<%=Request.QueryString("UMType")%>';
                       break;
                case 4:
                       window.location="NewTopic.aspx?UMType="+'<%=Request.QueryString("UMType")%>'; 
                       break;
                
            }    
        }            
       function Back()
       {
        var URL = "ManualList.aspx?UMType="+'<%=Request.QueryString("UMType")%>';
        document.location =URL;
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
        if (item = getElement('<%=ddlType.ClientID%>')){
            item.value = 0;
        }
        if(item = getElement('<%=ddlCategories.ClientID%>')){
             item.value = 0;
        }
    }
    function SetDefaultButton()
    {
       __defaultFired = false;
    } 
   </script> 

