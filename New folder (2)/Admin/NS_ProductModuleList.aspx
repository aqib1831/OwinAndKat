<%@ Page Language="VB" AutoEventWireup="false" CodeFile="NS_ProductModuleList.aspx.vb" Inherits="Admin_NS_ProductModuleList" Theme="Default"  %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Product Modules</title>
</head>
<body style ="margin:0px;background-color:#E4F1F7;" onkeypress="hideDiv();" >
    <form id="form1" runat="server">
    <div id="divDisable" class="modalBackground" ></div>
    <div>
        <asp:HiddenField ID="hdnProductID" runat="server" />
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
                           <asp:Label ID="lblProductTitle" runat="server"></asp:Label>&nbsp;Modules &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label runat="server" ID="lblProductCount"  />
                            &nbsp;<span class="NonBold">(<asp:Label runat="server" ID="lblFilter" Text="all" />)</span>
                        </ContentTemplate>
                            <Triggers >                                                                    
                                  <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                                  
                                  <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                            </Triggers>
                    </asp:UpdatePanel>
                </td>  
                <td style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right;cursor:pointer; height: 1px;border-bottom:1 solid #609BD3;  width:300px;">                     
                   <asp:LinkButton ID="LinkButton1" runat="server">
                        <div style="width:110px;" class="FlatButton" onclick="javascript:OpenAddProductDiv();return false;" >Add Module<img alt="" src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10" /></div>
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
                       <td style="width:75px;">
                          &nbsp;
                        </td>
                        <td>
                         <div class="leaddetailbutton" onclick="Back();" style="width:80px; height:20px;background-color:#D1E6F9; color:#437494;font-size:10px;font-weight:bold;padding:3px;text-transform:uppercase;text-align:center;" align="absmiddle">            
                            <img src="../images/blt_Back.gif" align="absmiddle" width="10" height="10" /> Back                        
                        </div>&nbsp;
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
                         UpdateMode="Always"
                         RenderMode="Inline">
                         <ContentTemplate>
                         <asp:GridView 
                            ID="gvNSProducts" 
                            runat="server" 
                            AutoGenerateColumns="False" 
                            EnableTheming="True" 
                            SkinID="GridViewNormal" 
                            EnableViewState="false"                        
                            AllowSorting="True"                             
                            DataSourceID="odsNSProductModules" >
                            <PagerSettings Mode="Numeric" Position="Bottom"  />
                               <PagerTemplate>                                                
                                  <div style="width:100%; border:0px black solid;" >
                                      <table width="100%" border="0" cellpadding="0" cellspacing="0"  style="height:20px;">
                                           <tr style="text-align:left;">
                                                 <td style="width:20%; white-space:nowrap;" align="left"  valign="middle" >
                                                   <span class="DarkBlueTextSmall" style="font-size:10px" >&nbsp; Page <asp:Literal id="litPageNumber" runat="server"/> of <asp:Literal id="litTotalPages"  runat="server"/></span>
                                                 </td>
                                                 <td style="width:10px; " align="right" ><img alt="" src="../images/spacer.gif" width="15" height="1" align="absmiddle" /></td>                                    
                                                 <td style="width:1px; " align="center"><img alt="" src="../images/pixel_darkBlue.jpg" width="1" height="20" align="absmiddle" /></td>
                                                 <td style="width:10px;" align="right"><img alt="" src="../images/spacer.gif" width="15" height="1" align="absmiddle" /></td>
                                                 <td  align="right" valign="top"> <asp:Panel ID="pnlNumber" runat="server" HorizontalAlign="Right"  ></asp:Panel> </td>                                                                                                     
                                            </tr>
                                      </table>                                              
                                  </div>
                               </PagerTemplate>       
                               <Columns>                                                              
                                    <asp:TemplateField ItemStyle-Width="50%" HeaderText="Title" SortExpression="Title" >
                                    <ItemTemplate >
                                        <asp:Label runat="server" ID="lblTitle" Text='<%# Eval("Title")%>' ></asp:Label>                                        
                                    </ItemTemplate>
                                    </asp:TemplateField> 
                                     <asp:TemplateField HeaderText="Abbreviation" ItemStyle-Width="10%" SortExpression="Abbreviation" >
                                        <ItemTemplate >
                                            <asp:Label runat="server" ID="lblAbbreviation" Text='<%# Eval("Abbreviation")%>' ></asp:Label>                                        
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Type" ItemStyle-Width="10%" SortExpression="Type" >
                                        <ItemTemplate >
                                            <asp:Label runat="server" ID="lblType" Text='<%# functions.GetProductType(Eval("Type"))%>' ></asp:Label>                                        
                                        </ItemTemplate>
                                    </asp:TemplateField>                                    
                                     <asp:TemplateField ItemStyle-Width="10%" HeaderText="Price" SortExpression="Price">
                                        <ItemTemplate >
                                          <asp:Label runat="server" ID="lblPrice" Text='<%# Functions.IfNull(Eval("Price"), "") %>' ></asp:Label>                                        
                                          </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>                                     
                                   <%-- <asp:TemplateField ItemStyle-Width="10%" HeaderText="Monthly Price" SortExpression="SupportPrice" >
                                        <ItemTemplate >
                                            <asp:Label runat="server" ID="lblMonthlySupportPrice" Text='<%# Eval("MonthlySupportPrice") %>' ></asp:Label>                                        
                                          </span>
                                        </ItemTemplate>
                                    </asp:TemplateField> --%>
                                </Columns>
                            </asp:GridView>
                             </ContentTemplate>
                                  <Triggers >                                                                    
                                          <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                                  
                                           <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                                           <asp:AsyncPostBackTrigger ControlID="UpdateButton" EventName="Click" />
                                  </Triggers>
                            </asp:UpdatePanel> 
                        <asp:Button ID="UpdateButton" runat="server" Text="Button" Width="0px" Height="0px" />
                             <asp:ObjectDataSource ID="odsNSProductModules" runat="server" 
                                    SelectMethod="GetModulesByProductsID"
                                    SortParameterName="sortExpression"
                                    TypeName="Portal.BLL.NSProducts">
                                    <SelectParameters>
                                      <asp:ControlParameter  Name="Search" Type="String" ControlID="txtSearch" PropertyName="Text" DefaultValue=""  ConvertEmptyStringToNull="true"/>
                                      <asp:QueryStringParameter Name="ProductID" QueryStringField="ProductID" Type="Int32"  />
                                      <asp:Parameter Name="sortExpression" Type="string" DefaultValue=""  />
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
    <div id="DivNSAddProductModule" runat="server"  style="display:none;border:solid 1px #000000; position:absolute; width:280px;  height:300px;top:13%; left:15%; z-index:1; background-color:#DEF7D6;">
        <table style="height:100%;  " cellpadding="0" border="0" cellspacing="0"   >
           <tr>    
              <td align="left" style="border-bottom:solid 1px #000000;padding-top:4px; padding-left:1em;vertical-align:middle; background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
                  <label id="Label2" title="Notes" style="color:White;height:100%; overflow:auto; font-weight:bold;"  >Add Product</label>
              </td>
              <td  style="border-bottom:solid 1px #000000;background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%; height:28px; cursor:pointer;">
                  <img src="../images/win_btn_close_black.jpg" style="float:right;" alt="Close Window" onclick="CloseAddProductDiv();" />
              </td>               
           </tr>
           <tr valign="top">                
            <td colspan="2" style="width:100%; height:100%; padding:0px; font-size:12px; background-color:#def7d6;" >   
                    <iframe id="IframAddProduct" name="IframAddProduct" src="NS_AddProductModule.aspx?ProductID=<%=hdnProductID.value %>" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
             </td> 
           </tr>            
          </table>
        </div>
    </form>
    <%--<script type="text/javascript" language="javascript">

    
            function AdjustPagerRow(){
        var objTag = null;
        var objCustomRow = null;
        try{
        objCustomRow = getElement("CustomPagerRow");
        objTag = getElementByClassName('FloatingPager');
        objCustomRow.innerHTML = '&nbsp;';
        if (objTag != null && objCustomRow != null)
            {
            objTag.style.display = 'none';
            objCustomRow.innerHTML = "<table cellpadding=0 cellspacing=0 align='left' height='18' ><tr class='cpyFloatingPager'>"+objTag.innerHTML+"</tr></table>";
            }
        }catch(ex){
            alert("Javascript Error:\n"+ex.description);
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
            if (updatedPanels[i].id == '<%= UpdatePanel2.ClientID %>') {
                AdjustPagerRow();
                $get('<%= txtSearch.ClientID %>').value='';               
            }
        }
    }
    function resetFilters()
{
    var element  = document.getElementById("txtsearch");
    element.value='';
    return false; 
}
</script>--%>
<script type="text/javascript" language="javascript"  >
function resetFilters()
{
    var element  = document.getElementById("txtsearch");
    element.value='';
    return false; 
}
function OpenAddProductDiv()
{
    var element = document.getElementById("DivNSAddProductModule") ;
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
    var element = document.getElementById("DivNSAddProductModule") ;
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
       CloseAddProductDiv();
    }
}
</script>
</body>
</html>
