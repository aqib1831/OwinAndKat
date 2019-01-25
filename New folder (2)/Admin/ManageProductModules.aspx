<%@ Page Language="VB" Theme="Default" AutoEventWireup="false" CodeFile="ManageProductModules.aspx.vb" Inherits="Admin_ManageProductModules" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Manage Product Modules</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript"  src="../scripts/functions.js" language="javascript" ></script>    
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
                 <td  style="height:31px;background-color:#A0CDEE;font-size:12px;padding:3px;width:95%;">
                    <asp:UpdatePanel ID="upRecordCount" runat="server" UpdateMode="Always">
                    <ContentTemplate>
                       <span style="font-weight:bold;">Manage Product Modules&nbsp;-&nbsp;<asp:Literal ID="ltrlModulesCount" runat="server" Text="0"></asp:Literal>
                     </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                 <td style="font-weight:bold;text-align:right;">                    
                    <img src="../images/btn_ResetFilters.jpg" style="cursor:pointer;" onclick="javascript:resetFilters();"/>
                 </td>                        
             </tr>              
             <tr>
                <td colspan="2" style="height:36px; font-size:11px;">
                  <table border="0" cellpadding="0" cellspacing="0" width="100%" class="gvwSearchSilver">
                    <tr>
                      
                      <td style="width:100px;" align="center" id="tdnewbtn">
            	           <div id="divNewKey" style="padding:2 4 2 4; width:90px;">
            	                <input id="btnNewUser" type="button" onclick="javascript:window.location='ProductModule.aspx'" class="btnSilver" value="NEW MODULE" style="width:90px; cursor:pointer;"/>
                      </td>                      
                      <td style="width:10px;text-align:center;">
                          <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                      </td>
                      <td style=" padding-left:5px; padding-right:5px; width: 90%; ">
                        <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" >
                           <span class="GreyTextSmall">Search</span><br />
                            <span><asp:TextBox ID="txtSearch" onfocus="this.value='';" runat="server" MaxLength="50" Width="150px" /><asp:ImageButton ID="btnSearch" runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" /></span></asp:Panel>  
                          
                      </td>
                      <td>
                        <span style="font-size: 7pt; color: #7c8798">
                            Product</span><br />
                            <asp:DropDownList ID="ddlProducts" 
                                CssClass="SmallGreenTextBox" 
                                ValidationGroup="ProductSelector"
                                runat="server" 
                                Width="200px" 
                                AutoPostBack="true" 
                                DataSourceID="sdsDivProducts"
                                DataTextField="Title"
                                DataValueField="ID" >
                            </asp:DropDownList>
                            <asp:SqlDataSource 
                                ID="sdsDivProducts" 
                                runat="server" 
                                ConnectionString="<%$ConnectionStrings:PortalConnectionString%>"
                                SelectCommand="NS_Products_GetAllForModules" 
                                SelectCommandType="StoredProcedure"                                             
                                DataSourceMode="DataReader">                                        
                            </asp:SqlDataSource>            
                      </td>
                      <td style="padding-left:5px; padding-right:5px; white-space:nowrap;">
                        <span style="font-size: 7pt; color: #7c8798">
                            Status</span><br />
                            <asp:DropDownList ID="ddlStatus" runat="server" SkinID="SmallTextCombo" AutoPostBack="true" Width="100px">
                                <asp:ListItem Text="All" Value="-1"></asp:ListItem>
                                <asp:ListItem Selected="True" Text="Active" Value="0" ></asp:ListItem>
                                <asp:ListItem Text="Inactive" Value="1"></asp:ListItem>
                            </asp:DropDownList>             
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
                         UpdateMode="Conditional"
                         RenderMode="Inline">
                         <ContentTemplate>
                            <asp:GridView 
                                ID="gvModules" 
                                runat="server" 
                                AutoGenerateColumns="False"                             
                                SkinID="gvwSilverWithNoPaging" 
                                CellPadding="0"
                                CellSpacing="0"
                                DataSourceID="odsModules"
                                ShowFooter="true"
                                Height="100%" 
                                DataKeyNames="ID,Name"
                                AllowPaging="false">
                                <Columns>
                                    <asp:TemplateField HeaderText="Name" SortExpression="Name" HeaderStyle-Width="45%" >
                                        <ItemTemplate>
                                                <asp:Label ID="lblName" runat="server" Text='<%# Server.HtmlEncode(Functions.StringTruncate(Eval("Name") ,35))%>' ToolTip='<%#Eval("Name")%>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                           &nbsp;
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Product" SortExpression="Product" HeaderStyle-Width="45%" >
                                        <ItemTemplate>
                                                <asp:Label ID="lblProduct" runat="server" Text='<%# Server.HtmlEncode(Functions.StringTruncate(Eval("Product") ,35))%>' ToolTip='<%#Eval("Product")%>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                           &nbsp;
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <center><asp:LinkButton CommandName='<%# GetStatusOperation(Eval("Inactive")) %>' OnClientClick=<%# "return OnChangeStatus('" & GetStatusOperation(Eval("Inactive")) & "');"%> CommandArgument='<%# Eval("ID")%>' ID="lnkActivateDeactivate" runat="server"><%# GetStatusOperation(Eval("Inactive")) %></asp:LinkButton></center>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                           &nbsp;
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddlProducts" EventName="SelectedIndexChanged" />
                                <asp:AsyncPostBackTrigger ControlID="ddlStatus" EventName="SelectedIndexChanged" />
                                <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                        <asp:ObjectDataSource                           
                            ID="odsModules" 
                            runat="server" 
                            SelectMethod="GetAll"
                            TypeName="Portal.DAL.NSProductModuleManager">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddlProducts" Name="ProductID" PropertyName="SelectedValue" Type="int32"/>
                                <asp:ControlParameter ControlID="ddlStatus" Name="Inactive" PropertyName="SelectedValue" Type="int32"/>
                                <asp:ControlParameter ControlID="txtSearch"  Name="Search" PropertyName="Text" Type="String" /></SelectParameters>
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
    function OnChangeStatus(status){
        event.cancelBubble = true;
        return confirm("Are you sure you want to " + status + " this module?");
    }    
    function resetFilters()
    {         
        var item;     
        if (item = document.getElementById('<%= txtSearch.ClientID %>'))
        {
            item.value = '';
        }        
         if (item = document.getElementById('<%= ddlStatus.ClientID %>'))
        {
            item.value = '0' ;
        }        
        document.getElementById('<%= btnSearch.ClientID  %>').click();
        return true;
    } 
    function ModuleClicked(ID){
        window.location='ProductModule.aspx?ModuleID='+ID;
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
      
    var postbackElement;
   
</script>
    </form>
</body>
</html>
