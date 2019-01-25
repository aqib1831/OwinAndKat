<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Users.aspx.vb" Inherits="Admin_Users" Theme="Default"  %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript"  src="../scripts/functions.js" language="javascript" ></script>
    <script type="text/javascript" language="javascript">
    function FixPager(){            
        if(getElement("tblPager") !=null){                
            trPager.style.display = "none";                
            tdPager.innerHTML = getElement("tblPager").outerHTML;                
            getElementByClassName("pager").style.display="none";
        }      
        else{
            trPager.style.display = "none";
        }
    }
</script>
</head>
<body style="margin:0; padding:0; height:100%; width:100%">
    <form id="form1" runat="server">
    <div>
    <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="300"  />
     <asp:UpdateProgress ID="Progress1" runat="server">
            <ProgressTemplate>
               <div class="ProgressIndicatorDivGray" style="right: 20px; bottom: 40px">                            
                    <br />
                    <img src="../images/indicator.gif" align="absmiddle" /><b>&nbsp;&nbsp;Loading ...</b>
                    <br /><br />
                </div>
            </ProgressTemplate>
    </asp:UpdateProgress>
    <table style="height:100%;width:100% " cellspacing="0" border="0" cellpadding="0" >
             <tr class="GalleryTitle" style="background-image:url('../images/bg_mainHdr_1.jpg');height:31px;">
                 <td  style="height:31px;background-color:#A0CDEE;font-size:12px;padding:3px;width:50%;">
                    <asp:UpdatePanel ID="upRecordCount" runat="server" UpdateMode="Always">
                    <ContentTemplate>
                       <span style="font-weight:bold;">Manage Users&nbsp;-&nbsp;<asp:Literal ID="ltrlRecordCount" runat="server" Text="0"></asp:Literal>
                     </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                 <td style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right;">
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <img src="../images/btn_ResetFilters.jpg" style="cursor:pointer;" onclick="javascript:resetFilters();"/>
                     <img  align="absmiddle" src="../images/pixel_skyBlue.jpg" width="1" height="20" />
                    
                 </td>                        
             </tr>              
             <tr>
                <td colspan="2" style="height:36px; font-size:11px;">
                  <table border="0" cellpadding="0" cellspacing="0" width="100%" class="gvwSearchSilver">
                    <tr>
                      
                      <td style="width:100px;" align="center" id="tdnewbtn">
            	           <div id="divNewKey" style="padding:2 4 2 4; width:90px;">
            	                <input id="btnNewUser" type="button" onclick="javascript:window.location='UsersNew.aspx'" class="btnSilver" value="NEW USER" style="width:80px; cursor:pointer;"/>
                      </td>
                      <td style="padding-left:5px; padding-right:5px; display:none; "  >
                          <span style="font-size: 7pt; color: #7c8798">Country</span><br />
                           <asp:DropDownList 
                               ID="ddlCountry" 
                               runat="server" 
                               SkinID="SmallTextCombo" 
                               DataSourceID="SqlDSCountries" 
                               DataTextField="Name" 
                               DataValueField="ID" 
                               AutoPostBack="True" Width="100px">
                               <asp:ListItem Selected="True" Value="0">Select...</asp:ListItem>
                          </asp:DropDownList>
                          <asp:SqlDataSource ID="SqlDSCountries" 
                              runat="server" 
                              ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                              SelectCommand="Countries_GetByUserID" 
                              SelectCommandType="StoredProcedure"
                              DataSourceMode="DataReader">
                          </asp:SqlDataSource>
                      </td>
                      <td style="width:10px;text-align:center; display:none;">
                          <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                      </td>
                      <td align="left" style="padding-left:5px; padding-right:5px; width: 130px;">
                        <span style="font-size: 7pt; color: #7c8798">
                              Departments</span><br />
                            <asp:DropDownList 
                            ID="ddlDeparments" 
                            runat="server" 
                            SkinID="SmallTextCombo" 
                            DataSourceID="SqlDSDepartments" 
                            DataTextField="Name" 
                            DataValueField="ID" 
                            AutoPostBack="True" Width="120px">
                          </asp:DropDownList>
                          <asp:SqlDataSource 
                          ID="SqlDSDepartments" 
                          runat="server" 
                          ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                          SelectCommand="Groups_GetGroupsbyType" 
                          SelectCommandType="StoredProcedure"
                          DataSourceMode="DataReader">
                                  <SelectParameters>
                                      <asp:Parameter ConvertEmptyStringToNull="False" DefaultValue="1" Name="Type" Type="Int32" />
                                  </SelectParameters>
                              </asp:SqlDataSource>
                         </td>                      
                      <td style="width:10px;text-align:center;">
                          <div class="straightline"></div>
                      </td>
                      <td  align="left" style=" padding-left:5px; padding-right:5px; width: 130px;">
                          <span style="font-size: 7pt; color: #7c8798">Teams
                          </span><br />
                          <asp:DropDownList ID="ddlTeams" 
                                runat="server" 
                                SkinID="SmallTextCombo" 
                                DataSourceID="SqlDSTeams" 
                                DataTextField="Name" 
                                DataValueField="ID" 
                                AutoPostBack="True" Width="120px">
                          </asp:DropDownList>
                          <asp:SqlDataSource ID="SqlDSTeams" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                              SelectCommand="Groups_GetGroupsbyType" 
                              SelectCommandType="StoredProcedure"
                              DataSourceMode="DataReader">
                              <SelectParameters>
                                  <asp:Parameter ConvertEmptyStringToNull="False" DefaultValue="2" Name="Type" Type="Int32" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                          
                      </td>
                      <td style="width:10px;text-align:center;">
                           <div class="straightline"></div>
                      </td>
                      <td style="padding-left:5px; padding-right:5px; width: 130px; ">
                          <span style="font-size: 7pt; color: #7c8798">Offices<br />
                          </span>
                          <asp:DropDownList ID="ddlOfficess" runat="server" 
                             SkinID="SmallTextCombo" 
                             DataSourceID="SqlDSOfficess" 
                             DataTextField="Name" 
                             DataValueField="ID" 
                             AutoPostBack="True" 
                             Width="120px" 
                             EnableViewState="False">
                          </asp:DropDownList>
                          <asp:SqlDataSource ID="SqlDSOfficess" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                              SelectCommand="Groups_GetGroupsbyType" 
                              SelectCommandType="StoredProcedure"
                              DataSourceMode="DataReader">
                              <SelectParameters>
                                  <asp:Parameter ConvertEmptyStringToNull="False" DefaultValue="3" Name="Type" Type="Int32" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                      </td>
                      <td style="width:10px;text-align:center;">
                           <div class="straightline"></div>
                      </td>
                      <td style=" padding-left:5px; padding-right:5px; width: 130px; ">
                          <span style="font-size: 7pt; color: #7c8798">
                          Status</span><br />
                          <asp:DropDownList ID="ddlStatus" runat="server" SkinID="SmallTextCombo" AutoPostBack="true" Width="100px">
                              <asp:ListItem Text="Select..." Value="Null"></asp:ListItem>
                              <asp:ListItem Text="Active" Value="False" ></asp:ListItem>
                              <asp:ListItem Text="InActive" Value="True"></asp:ListItem>
                          </asp:DropDownList>
                      </td>
                      <td style="width:10px;text-align:center;" visible="true" >
                           <div class="straightline"></div>
                      </td>
                      <td style=" padding-left:5px; padding-right:5px; ">
                          <asp:DropDownList ID="ddlType" runat="server" SkinID="SmallTextCombo" AutoPostBack="true" Width="70px" Visible="False">
                              <asp:ListItem Selected="True" Text="Select..." Value="Null"></asp:ListItem>
                              <asp:ListItem Value="True">FranSupport</asp:ListItem>
                              <asp:ListItem Value="False">Portal</asp:ListItem>
                          </asp:DropDownList>
                      </td>
                    
                      <td style="padding-left:5px; padding-right:5px; white-space:nowrap;" align="left" >
                      <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" >
                           <span class="GreyTextSmall">Search</span><br />
                            <span><asp:TextBox ID="txtSearch" runat="server" MaxLength="50" Width="120px" />
                            <asp:ImageButton ID="btnSearch" runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />
                            </span>
                      </asp:Panel>                         
                      </td>
                      <td style="width:25%;">
                      &nbsp;&nbsp;
                      </td>
                   </tr>
                 </table>
               </td>
             </tr>
             <tr>
               <td  colspan="2" style="height:100%;">
               <div id="divScroll" style="height:100%; width:100%; overflow-y:auto;" class="GrayScrollBar">
                    <asp:UpdatePanel ID="upKeys"
                         runat="server" 
                         UpdateMode="Always"
                         RenderMode="Inline">
                         <ContentTemplate>                        
                        <asp:GridView 
                        ID="gvUsers" 
                        runat="server" 
                        AutoGenerateColumns="False" 
                        EnableTheming="True" 
                        SkinID="gvwSilver" 
                        CellPadding="0"
                        CellSpacing="0"                        
                        DataKeyNames="ID,Name,Username,Email" 
                        DataSourceID="ODS_GetAll"  
                        Height="100%" ShowFooter="true"
                        AllowSorting="true" EnableViewState="true" AllowPaging="true">
                            <Columns>
                                <asp:TemplateField HeaderText="Name" SortExpression="Name" HeaderStyle-Width="50%" >
                                    <ItemTemplate>                                    
                                       <b><asp:Label ID="lblName" runat="server" Text='<%# Server.HtmlEncode(Functions.StringTruncate(Eval("Name") ,20))%>' ToolTip='<%#Eval("Name")%>'></asp:Label></b> 
                                    </ItemTemplate>
                                    <FooterTemplate>
                                           &nbsp;
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="User Name" SortExpression="UserName" HeaderStyle-Width="15%">
                                    <ItemTemplate>
                                        <%#Eval("UserName")%>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                           &nbsp;
                                    </FooterTemplate>
                                </asp:TemplateField>                                
                                <asp:TemplateField HeaderText="Work Phone" SortExpression="WorkPhone" HeaderStyle-Width="15%">
                                    <ItemTemplate>
                                        <%#Eval("WorkPhone")%>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                           &nbsp;
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Email" SortExpression="Email" HeaderStyle-Width="20%">
                                    <ItemTemplate>
                                        <%#Eval("Email")%>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                           &nbsp;
                                    </FooterTemplate>
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
                       <td style="border:0; width:85%;">Showing Users <asp:Literal ID="ltrlStartCount" runat="server" Text="0"></asp:Literal> to <asp:Literal ID="ltrlEndCount" runat="server" Text="0"></asp:Literal> of <asp:Literal ID="ltrlTotalCount" runat="server"></asp:Literal></td> 
                       <td style="border:0;" align="right" nowrap="nowrap">Page&nbsp;<asp:Literal ID="ltrlStartPage" runat="server" Text="0"></asp:Literal> of <asp:Literal ID="ltrlLastPage" runat="server" Text="0"></asp:Literal>&nbsp;&nbsp;&nbsp;<asp:LinkButton ID="lnkBtnFirst" runat="server" CommandName="page" CommandArgument="first"><asp:Image ID="imgFirst" runat="server" ImageUrl="../images/First_blk.jpg" ToolTip="First" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnPrevious" runat="server" CommandName="page" CommandArgument="prev"><asp:Image ID="imgPrevious" runat="server" ImageUrl="../images/back_blk.jpg" ToolTip="Previous" /></asp:LinkButton> &nbsp;<asp:LinkButton ID="lnkBtnNext" runat="server" CommandName="page" CommandArgument="next"><asp:Image ID="imgNext" runat="server" ImageUrl="../images/Next_blk.jpg"  ToolTip="Next" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnLast" runat="server" CommandName="page" CommandArgument="last"><asp:Image ID="imgLast" runat="server" ImageUrl="../images/Last_blk.jpg" ToolTip="Last" /></asp:LinkButton>&nbsp;&nbsp;&nbsp;</td>
                    </tr>
                </table>
            </PagerTemplate>
                        </asp:GridView>
                       </ContentTemplate>
                                  <Triggers >
                                  <asp:AsyncPostBackTrigger ControlID="ddlCountry" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlDeparments" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlTeams" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlOfficess" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlStatus" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlType" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" /> 
                                  </Triggers>
                            </asp:UpdatePanel> 
                        <asp:ObjectDataSource 
                        ID="ODS_GetAll" 
                        runat="server" 
                        SelectMethod="GetAll" 
                        SelectCountMethod="GetAllCount" 
                        TypeName="Portal.BLL.Users"                          
                        SortParameterName="sortExpression" 
                        MaximumRowsParameterName="maximumRows" StartRowIndexParameterName="startRowIndex" 
                        EnablePaging="true" EnableViewState="true">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddlCountry" DefaultValue="1" Name="CountryID" PropertyName="SelectedValue"
                                    Type="Int32" />
                                <asp:ControlParameter ControlID="ddlDeparments" DefaultValue="1" Name="DepartmentID"
                                    PropertyName="SelectedValue" Type="Int32" />
                                <asp:ControlParameter ControlID="ddlTeams" DefaultValue="5" Name="TeamID" PropertyName="SelectedValue"
                                    Type="Int32" />
                                <asp:ControlParameter ControlID="ddlOfficess" DefaultValue="9" Name="OfficeID" PropertyName="SelectedValue"
                                    Type="Int32" />
                                <asp:ControlParameter ControlID="ddlStatus" DefaultValue="Null" Name="Status" PropertyName="SelectedValue"
                                    Type="String" />
                                <asp:Parameter DefaultValue="1" Name="Type" Type="Int32" />
                                <asp:Parameter Name="sortExpression" Type="String" />
                                <asp:ControlParameter ControlID="txtSearch"  Name="txtsearch" PropertyName="Text"
                                    Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </div>
               </td>
             </tr>
             <tr id="trPager" class="pager" style="display:none;">
                <td id="tdPager" style="height:20px; border-top:solid 1px #B7CFE2;" colspan="2" >&nbsp;</td>
             </tr> 
            </table>
    </div>

<script type="text/javascript" language="javascript">
 function resetFilters()
    {         
        var item;     
        if (item = document.getElementById('<%= txtSearch.ClientID %>'))
        {
            item.value = '';
        }
        if (item = document.getElementById('<%= ddlCountry.ClientID %>'))
        {
            item.value = 0;
        }
        if (item = document.getElementById('<%= ddlDeparments.ClientID %>'))
        {
            item.value = 0;
        }
        if (item = document.getElementById('<%= ddlTeams.ClientID %>'))
        {
            item.value = 0;
        }
        if (item = document.getElementById('<%= ddlOfficess.ClientID %>'))
        {
            item.value = 0;
        }
         if (item = document.getElementById('<%= ddlStatus.ClientID %>'))
        {
            item.value = 'Null' ;
        }
         if (item = document.getElementById('<%= ddlType.ClientID %>'))
        {
            item.value = 'Null' ;
        } 
         document.getElementById('<%= btnSearch.ClientID  %>').click();
        return true;
    } 
    
    function ShowUserDetail(userId, trClicked){
        var Search = document.getElementById('<%= txtSearch.ClientID %>').value;
        var Status = document.getElementById('<%= ddlStatus.ClientID %>').value;
        var Office = document.getElementById('<%= ddlOfficess.ClientID %>').value;
        var Team = document.getElementById('<%= ddlTeams.ClientID %>').value;
        var Department = document.getElementById('<%= ddlDeparments.ClientID %>').value;
        window.location='UsersEdit.aspx?UserID=' + userId + '&Search=' + Search + '&Status=' + Status + '&Office=' + Office + '&Team=' + Team + '&Department=' + Department;
        trClicked.className="selectedRow";
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
    
</script>
    </form>
</body>
</html>
