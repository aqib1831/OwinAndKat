<%@ Page Language="VB" AutoEventWireup="false" CodeFile="NS_ProductsList.aspx.vb" Inherits="Admin_NS_ProductsServices" Theme ="Default" %>
<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Netsolace Products And Services</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
</head>
<body style ="margin:0px;background-color:#E4F1F7;" onkeypress="hideDiv();">
    <form id="form1" runat="server">
    <div id="divDisable" class="modalBackground" ></div>
    <div>
    <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="300"  />
        <asp:UpdateProgress ID="Progress1" runat="server">
            <ProgressTemplate>
                <div class="ProgressIndicatorDIV" >
                    <br />
                    <asp:Image ID="Image2" runat="server" ImageUrl="../images/indicator.gif" ImageAlign="AbsMiddle" /> <span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
                    <br /><br />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>  
    <table width="100%" style="height:100%; margin:0px; padding:0px;background-color:#E4F1F7; " cellspacing="0" cellpadding = "0" border="0"  >
             <tr class="UnderlinedRow">
                 <td  style="height:20px;background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:5px;width:60%;">                     
                     <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                       <ContentTemplate>
                        Netsolace Products <%--&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label runat="server" ID="lblProductCount"  />
                            &nbsp;<span class="NonBold">(<asp:Label runat="server" ID="lblFilter" Text="all" />)</span>--%>
                        </ContentTemplate>
                            <Triggers >                                                                    
                                  <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                                  
                                  <asp:AsyncPostBackTrigger ControlID="ddlType" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                            </Triggers>
                    </asp:UpdatePanel>
                </td>  
                <td style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right;cursor:pointer; height: 20px;border-bottom:1 solid #609BD3;  width:300px;">                     
                   <asp:LinkButton ID="LinkButton1" runat="server">
                        <div style="width:110px;" class="FlatButton" onclick="javascript:OpenAddProductDiv();return false;" >Add Product<img alt="" src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10" /></div>
                    </asp:LinkButton>&nbsp;
                    <img align="absMiddle"  height="20" src="../images/pixel_skyBlue.jpg" width="1" alt="" />&nbsp;
                   <asp:LinkButton ID="lnkResetFilters" runat="server">
                        <div style="width:110px;" class="FlatButton" onclick="javascript:resetFilters();">Reset Filters <img alt="" src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10" /></div>
                    </asp:LinkButton>
                 </td>                                       
             </tr>              
             <tr>
                <td colspan="2" style="height:40px;background-color:#BADCFC;font-size:11px;">
                  <table border="0" cellpadding="0" cellspacing="0" width="100%" style="white-space:nowrap;">
                     <tr>
                       <td style="padding:3px; white-space:nowrap; width:200px;" align="left"   >
                          <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" >
                               <span class="GreyTextSmall">Search</span><br />
                                <span><asp:TextBox ID="txtSearch" runat="server" onfocus="javascript:this.value='';" MaxLength="50"   Width="170px"  SkinID="GreenSmallTextbox" />
                                <asp:ImageButton ID="btnSearch"  runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />
                                </span></asp:Panel>
                        </td>
                       <td style="width:10px;text-align:center;">
                            <img alt="" src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                        </td>                     
                       <td style="width:75px;">
                            <span class="GreyTextSmall">Type</span><br />
                            <asp:DropDownList runat="server" ID="ddlType" SkinID="SmallTextCombo" AutoPostBack="true">
                                <asp:ListItem Text="Show All" Value="0" />
                                <asp:ListItem Text="Hardware" Value="2" />
                                <asp:ListItem Text="Software" Value="1" />
                                <asp:ListItem Text="Services" Value="3" />
                            </asp:DropDownList>
                        </td>
                        <td>
                        &nbsp;
                        </td>
                    </tr>
                 </table>
               </td>
             </tr>
             <tr>
               <td  colspan="2" style="background-color:#E4F1F7;margin:0px;padding:0px;">
                    <div style="overflow:auto;height:100%;background-color:#E4F1F7;border:1px solid #ACBDD5;" id="_gridViewPanel1" class="ScrollBarHomeTicket">
                      <asp:UpdatePanel ID="UpdatePanel2"
                         runat="server" 
                         UpdateMode="Conditional" 
                         RenderMode="Inline">
                         <ContentTemplate>
                             <radG:RadGrid ID="gvNSProducts" 
                                runat="server" 
                                DataSourceID="odsNSProducts" 
                                AutoGenerateColumns="False"  
                                EnableTheming="True" 
                                GridLines="None" 
                                Skin="FransupportBlue" AllowSorting="True" CellPadding="0" >
                             <MasterTableView  Name="Product"
                             DataSourceID="odsNSProducts" 
                             DataKeyNames="ID" 
                             HierarchyLoadMode="Client" 
                             ShowHeadersWhenNoRecords="False" NoDetailRecordsText="" HierarchyDefaultExpanded="True" NoMasterRecordsText="">
                             <NoRecordsTemplate>                                                 
                                 <div id="RadGriddivInfo" style="display:visible;position: absolute; width:200px; height:50px; left:32%; top:38%;" class="MessageDiv"> 
                                 <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height:50px;">                                                   
                                    <tr>
                                        <td style="width:5%;" >&nbsp;</td>
                                        <td align="right" valign="middle" style="width:25%;">
                                            <div style="text-align:right;">
                                                <asp:Image ID="Image1" runat="server" ImageUrl="~/images/ico_alert.gif" />&nbsp;&nbsp; 
                                            </div>
                                        </td>
                                        <td nowrap="nowrap" align="left" valign="middle" id="divMessage" style="width:75%;font-size:8pt;">&nbsp;No Product Found</td>
                                    </tr>
                                 </table>
                             </div>                                                                                      
                             </NoRecordsTemplate>
                             <DetailTables >
                                <radG:GridTableView runat="server"
                                 DataSourceID="odsNSProductModules" Name="Module"
                                 DataKeyNames="ID,ParentID" ShowHeader="False" Width="100%"  
                                  ShowHeadersWhenNoRecords="False" HierarchyLoadMode="Client" NoDetailRecordsText="" NoMasterRecordsText=""   >
                                    <ParentTableRelation>
                                        <radG:GridRelationFields DetailKeyField="ParentID" MasterKeyField="ID" />
                                    </ParentTableRelation>
                                    <Columns>
                             <radG:GridTemplateColumn UniqueName="TemplateColumn" Visible="False">
                             <ItemTemplate>
                                        <asp:Label runat="server" ID="lblID" Text='<%# Eval("ID")%>' ></asp:Label>                                        
                                        <asp:Label runat="server" ID="lblParentID" Text='<%# Eval("ParentID")%>' ></asp:Label>                                        
                              </ItemTemplate>
                             </radG:GridTemplateColumn> 
                             <radG:GridTemplateColumn  HeaderText="Title" SortExpression="Title" UniqueName="TemplateColumn1" >
                              <ItemTemplate >
                                       <asp:Label runat="server" ID="lblTitle" ToolTip='<%# Eval("Title")%>'  Text='<%# Functions.StringTruncate(Eval("Title"),40)%>' ></asp:Label>                                      
                             </ItemTemplate> 
                                 <ItemStyle Width="50%" />
                             </radG:GridTemplateColumn>
                             <radG:GridTemplateColumn HeaderText="Abbreviation" SortExpression="Abbreviation" UniqueName="TemplateColumn2">
                             <ItemTemplate>
                                        <asp:Label runat="server" ID="lblAbbreviation" Text='<%# Eval("Abbreviation")%>' ></asp:Label>                                       
                                    </ItemTemplate>
                                 <ItemStyle Width="15%" />
                             </radG:GridTemplateColumn>
                             <radG:GridTemplateColumn HeaderText="Type" SortExpression="Type"  UniqueName="TemplateColumn3">
                               <ItemTemplate >
                                       <asp:Label runat="server" ID="lblType" Text='<%# functions.GetProductType(Eval("Type"))%>' ></asp:Label>                                    
                             </ItemTemplate> 
                                 <ItemStyle Width="15%" />
                             </radG:GridTemplateColumn>
                             <radG:GridTemplateColumn HeaderText="Price" SortExpression="Price"  UniqueName="TemplateColumn4">
                               <ItemTemplate >
                                       &nbsp;<asp:Label runat="server" ID="lblPrice" Text='<%# Strings.FormatNumber(Functions.IfNull(Eval("Price"), ""),2) %>' ></asp:Label>                                       
                                    </ItemTemplate>
                                 <ItemStyle Width="10%" />
                             </radG:GridTemplateColumn>
                              <radG:GridTemplateColumn UniqueName="TemplateColumn5">
                             <ItemTemplate>
                                &nbsp;<asp:LinkButton runat="server"  ID="lnkEditModule" Text="Edit" CommandArgument ='<%#Eval("ID") %>' CommandName="EditModule"></asp:LinkButton>
                                <ItemStyle Width="10%"   />
                             </ItemTemplate>
                             </radG:GridTemplateColumn>
                             </Columns> 
                                    <ExpandCollapseColumn Resizable="False" Visible="False">
                                        <HeaderStyle Width="20px" />
                                    </ExpandCollapseColumn>
                                    <RowIndicatorColumn Visible="False">
                                        <HeaderStyle Width="20px" />
                                    </RowIndicatorColumn>
                                </radG:GridTableView>
                             </DetailTables> 
                             <Columns>
                              <radG:GridTemplateColumn UniqueName="TemplateColumn" ShowSortIcon="False" >
                                 <ItemTemplate>
                                     <img src="../images/blt_normal.gif" />
                                 </ItemTemplate>
                                 <ItemStyle  Width="10px" Height="10px"/> 
                            </radG:GridTemplateColumn> 
                             <radG:GridTemplateColumn UniqueName="TemplateColumn" Visible="False" ShowSortIcon="False">
                             <ItemTemplate>
                                        <asp:Label runat="server" ID="lblID" Text='<%# Eval("ID")%>' ></asp:Label>                                        
                              </ItemTemplate>
                             </radG:GridTemplateColumn> 
                             <radG:GridTemplateColumn HeaderText="Title"  SortExpression="Title" UniqueName="TemplateColumn1" ShowSortIcon="False" >
                              <ItemTemplate >
                                       <asp:Label runat="server" ID="lblTitle" ToolTip='<%# Eval("Title")%>'  Text='<%# Functions.StringTruncate(Eval("Title"),34)%>' ></asp:Label>                                      
                             </ItemTemplate> 
                                 <ItemStyle Width="50%" Font-Bold="True"         />
                             </radG:GridTemplateColumn>
                             <radG:GridTemplateColumn HeaderText="Abbreviation" SortExpression="Abbreviation" UniqueName="TemplateColumn2" ShowSortIcon="False">
                             <ItemTemplate>
                                        <asp:Label runat="server" ID="lblAbbreviation" Text='<%# Eval("Abbreviation")%>' ></asp:Label>                                       
                                    </ItemTemplate>
                                 <ItemStyle Width="15%" />
                             </radG:GridTemplateColumn>
                             <radG:GridTemplateColumn HeaderText="Type" SortExpression="Type" UniqueName="TemplateColumn3" ShowSortIcon="False">
                               <ItemTemplate >
                                       <asp:Label runat="server" ID="lblType" Text='<%# functions.GetProductType(Eval("Type"))%>' ></asp:Label>                                    
                             </ItemTemplate> 
                                 <ItemStyle Width="15%" />
                             </radG:GridTemplateColumn>
                             <radG:GridTemplateColumn HeaderText="Price" SortExpression="Price" UniqueName="TemplateColumn4" ShowSortIcon="False">
                               <ItemTemplate >
                                        <asp:Label runat="server" ID="lblPrice" Text='<%# Strings.FormatNumber(Functions.IfNull(Eval("Price"), ""),2) %>' ></asp:Label>                                       
                                    </ItemTemplate>
                                 <ItemStyle Width="10%" />
                             </radG:GridTemplateColumn>
                             <radG:GridTemplateColumn HeaderText="Action" UniqueName="TemplateColumn5" ShowSortIcon="False">
                             <ItemTemplate>
                               <asp:LinkButton runat="server"  ID="lnkEdit" Text="Edit" CommandArgument ='<%#Eval("ID") %>' CommandName="EditProduct"></asp:LinkButton>
                                </ItemTemplate> 
                              <ItemStyle width="10%" HorizontalAlign="Left"   />
                             </radG:GridTemplateColumn>
                             </Columns>
                                 <ExpandCollapseColumn Resizable="False">
                                     <HeaderStyle Width="20px" />
                                 </ExpandCollapseColumn>
                                 <RowIndicatorColumn Visible="False">
                                     <HeaderStyle Width="20px" />
                                 </RowIndicatorColumn>
                             </MasterTableView> 
                               <ClientSettings AllowExpandCollapse="True">
                                     </ClientSettings>
                                 <ExportSettings>
                                     <Pdf PageBottomMargin="" PageFooterMargin="" PageHeaderMargin="" PageHeight="11in"
                                         PageLeftMargin="" PageRightMargin="" PageTopMargin="" PageWidth="8.5in" />
                                 </ExportSettings>
                                 <ItemStyle Wrap="False" />
                             </radG:RadGrid>
                             </ContentTemplate>
                                  <Triggers >                                                                    
                                          <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                                  
                                          <asp:AsyncPostBackTrigger ControlID="ddlType" EventName="SelectedIndexChanged" />
                                           <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                                           <asp:AsyncPostBackTrigger ControlID="UpdateButton" EventName="Click" />
                                  </Triggers>
                            </asp:UpdatePanel> 
                        <asp:Button ID="UpdateButton" runat="server" Text="Button" Width="0px" Height="0px" />
                             <asp:ObjectDataSource ID="odsNSProducts" runat="server" 
                                    SelectMethod="ProductsGetAll" SelectCountMethod="ProductsGetAllCount" 
                                    SortParameterName="sortExpression"
                                    TypeName="Portal.BLL.NSProducts">
                                    <SelectParameters>
                                      <asp:ControlParameter  Name="Search" Type="String" ControlID="txtSearch" PropertyName="Text" DefaultValue=""  ConvertEmptyStringToNull="true"/>
                                      <asp:ControlParameter Name="Type" Type="Int32" ControlID="ddlType" PropertyName="SelectedValue" />
                                      <asp:Parameter Name="sortExpression" Type="string" DefaultValue=""  />
                                    </SelectParameters> 
                            </asp:ObjectDataSource> 
                             <asp:ObjectDataSource ID="odsNSProductModules" runat="server" 
                                    SelectMethod="GetModulesByProductsID"
                                    SortParameterName="sortExpression"
                                    TypeName="Portal.BLL.NSProducts">
                                    <SelectParameters>
                                      <asp:ControlParameter  Name="Search" Type="String" ControlID="txtSearch" PropertyName="Text" DefaultValue=""  ConvertEmptyStringToNull="true"/>
                                      <asp:ControlParameter Name="Type" Type="Int32" ControlID="ddlType" PropertyName="SelectedValue" />
                                      <asp:Parameter Name="sortExpression" Type="string" DefaultValue=""  />
                                      <asp:controlparameter ControlID="gvNSProducts" Name="ParentID" PropertyName="SelectedValue"
                                        Type="Int32" />
                                    </SelectParameters>
                            </asp:ObjectDataSource> 
                    </div>
               </td>
             </tr> 
             <tr style="background-color:#BADCFC">
                    <td align="left" colspan="2" id="CustomPagerRow" style="height:22px;">&nbsp;</td>
              </tr>                  
         </table>
    </div>
    <asp:UpdatePanel ID="UpdatePanelAddProducts" runat="server"  RenderMode="Inline"   >
    <ContentTemplate >
    <div id="DivNSAddProduct" runat="server"  style="display:none;border:solid 1px #000000; position:absolute; width:500px;  height:250px;top:13%; left:15%; z-index:1; background-color:#DEF7D6;">
        <table style="height:100%;  " cellpadding="0" border="0" cellspacing="0"   >
           <tr>    
              <td align="left" style="border-bottom:solid 1px #000000;padding-top:4px; padding-left:3px; vertical-align:middle; background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
                  <label id="Label2" title="Notes" style="color:White;height:100%; overflow:auto; font-weight:bold;"  >Add Product</label>
              </td>
              <td  style="border-bottom:solid 1px #000000;background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%; height:28px; cursor:pointer;">
                  <img src="../images/win_btn_close_black.jpg" style="float:right;" alt="Close Window" onclick="CloseAddProductDiv();" />
              </td>               
           </tr>
           <tr valign="top">                
            <td colspan="2" style="width:100%; height:100%; padding:0px; font-size:12px; background-color:#def7d6;" >   
                    <iframe id="IframAddProduct" name="IframAddProduct" src="NS_AddProduct.aspx" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
             </td> 
           </tr>            
          </table>
        </div>
    <div id="DivNSEditProduct" runat="server"  style="display:none;border:solid 1px #000000; position:absolute; width:500px;  height:230px;top:13%; left:15%; z-index:1; background-color:#DEF7D6;">
        <table style="height:100%;  " cellpadding="0" border="0" cellspacing="0"   >
           <tr>    
              <td align="left" style="border-bottom:solid 1px #000000;padding-top:4px; padding-left:3px; vertical-align:middle; background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
                  <label id="Label4" title="Notes" style="color:White;height:100%; overflow:auto; font-weight:bold;"  >Edit Product</label>
              </td>
              <td  style="border-bottom:solid 1px #000000;background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%; height:28px; cursor:pointer;">
                  <img src="../images/win_btn_close_black.jpg" style="float:right;" alt="Close Window" onclick="CloseEditProductDiv();" />
              </td>               
           </tr>
           <tr valign="top">                
            <td colspan="2" style="width:100%; height:100%; padding:0px; font-size:12px; background-color:#def7d6;" >   
                    <iframe id="IframEditProduct" name="IframEditProduct" src="NS_AddProduct.aspx?ProductID=<%=hdnProductID.value %>"  style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
             </td> 
           </tr>            
          </table>
        </div>
        <asp:HiddenField ID="hdnProductID" runat="server" />
         <asp:HiddenField ID="hdnModuleID" runat="server" />
    <div id="DivNSAddProductModule" runat="server"  style="display:none;border:solid 1px #000000; position:absolute; width:500px;  height:230px;top:13%; left:15%; z-index:2; background-color:#DEF7D6;">
        <table style="height:100%;  " cellpadding="0" border="0" cellspacing="0"   >
           <tr>    
              <td align="left" style="border-bottom:solid 1px #000000;padding-top:4px; padding-left:3px ;vertical-align:middle; background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
                  <label id="Label1" title="Notes" style="color:White;height:100%; overflow:auto; font-weight:bold;"  >Add Module</label>
              </td>
              <td  style="border-bottom:solid 1px #000000;background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%; height:28px; cursor:pointer;">
                  <img src="../images/win_btn_close_black.jpg" style="float:right;" alt="Close Window" onclick="CloseAddProductModuleDiv();" />
              </td>               
           </tr>
           <tr valign="top">                
            <td colspan="2" style="width:100%; height:100%; padding:0px; font-size:12px; background-color:#def7d6;" >   
                    <iframe id="IframAddProductModule" name="IframAddProductModule" src="NS_AddProductModule.aspx?ProductID=<%=hdnProductID.value %>" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
             </td> 
           </tr>            
          </table>
        </div>
    <div id="DivNSEditProductModule" runat="server"  style="display:none;border:solid 1px #000000; position:absolute; width:500px;  height:230px;top:13%; left:15%; z-index:2; background-color:#DEF7D6;">
        <table style="height:100%;  " cellpadding="0" border="0" cellspacing="0"   >
           <tr>    
              <td align="left" style="border-bottom:solid 1px #000000;padding-top:4px; padding-left:3px ;vertical-align:middle; background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
                  <label id="Label3" title="Notes" style="color:White;height:100%; overflow:auto; font-weight:bold;"  >Edit Module</label>
              </td>
              <td  style="border-bottom:solid 1px #000000;background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%; height:28px; cursor:pointer;">
                  <img src="../images/win_btn_close_black.jpg" style="float:right;" alt="Close Window" onclick="CloseEditProductModuleDiv();" />
              </td>               
           </tr>
           <tr valign="top">                
            <td colspan="2" style="width:100%; height:100%; padding:0px; font-size:12px; background-color:#def7d6;" >   
                    <iframe id="IframEditProductModule" name="IframEditProductModule" src="NS_AddProductModule.aspx?ModuleID=<%=hdnModuleID.value %>&ProductID=<%=hdnProductID.value %>" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
             </td> 
           </tr>            
          </table>
        </div>     
    </ContentTemplate>
    </asp:UpdatePanel>
    </form>
<script type="text/javascript" language="javascript"  >
function resetFilters()
{
    var element  = document.getElementById("txtsearch");
    var ele  = document.getElementById("ddlType");
    element.value='';
    ele.value = 0;
    return false; 
}
function OpenAddProductDiv()
{
    var element = document.getElementById("DivNSAddProduct") ;
    if (element.style.display == "none")
    {
           element.style.display = "inline";
           divDisable.style.width = document.body.scrollWidth;
           divDisable.style.height = document.body.scrollHeight;
    }
    
    return false;
}
function CloseAddProductDiv()
{
    var element = document.getElementById("DivNSAddProduct") ;
    if (element.style.display == "inline")
    {
           element.style.display = "none";
           divDisable.style.width = 0;
           divDisable.style.height = 0;
    }
    return false;
}
function OpenEditProductDiv()
{
    var element = document.getElementById("DivNSEditProduct") ;
    if (element.style.display == "none")
    {
           element.style.display = "inline";
           divDisable.style.width = document.body.scrollWidth;
           divDisable.style.height = document.body.scrollHeight;
    }
    return false;
}
function CloseEditProductDiv()
{
    var element = document.getElementById("DivNSEditProduct") ;
    if (element.style.display == "inline")
    {
           element.style.display = "none";
           divDisable.style.width = 0;
           divDisable.style.height = 0;
    }
    return false;
}

function UpdateButton()
{
    var element = document.getElementById("UpdateButton") ;
    element.click();
}
function SetInBox(value)    
{   
   
   
}
///////////////////////
function OpenAddProductModuleDiv()
{
    var element = document.getElementById("DivNSAddProductModule") ;
    element.style.display = "inline";
    divDisable.style.width = document.body.scrollWidth;
    divDisable.style.height = document.body.scrollHeight;
    return false;
}
function CloseAddProductModuleDiv()
{
    var element = document.getElementById("DivNSAddProductModule") ;
    if (element.style.display == "inline")
    {
           element.style.display = "none";
           divDisable.style.width = 0;
           divDisable.style.height = 0;
    }
    return false;
}
function OpenEditProductModuleDiv()
{
    var element = document.getElementById("DivNSEditProductModule") ;
    element.style.display = "inline";
    divDisable.style.width = document.body.scrollWidth;
    divDisable.style.height = document.body.scrollHeight;
    return false;
}
function CloseEditProductModuleDiv()
{
    var element = document.getElementById("DivNSEditProductModule") ;
    if (element.style.display == "inline")
    {
           element.style.display = "none";
           divDisable.style.width = 0;
           divDisable.style.height = 0;
    }
    return false;
}
function UpdateButton()
{
    var element = document.getElementById("UpdateButton") ;
    element.click();
}
function hideDiv()
{
    if (event.keyCode == 27)
    {
       CloseAddProductModuleDiv();
       CloseEditProductDiv();
       CloseEditProductModuleDiv();
       CloseAddProductDiv();
    }
}
</script>
</body>
</html>
 <%--
 window.IframAddProduct.ClearControls();--%>