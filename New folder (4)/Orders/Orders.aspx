<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Orders.aspx.vb" Inherits="Orders_Orders" Theme="Default"   %> 

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Manage Orders</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../scripts/functions.js" ></script>
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=0.2)" />
    <meta http-equiv="Page-Enter" content="progid:DXImageTransform.Microsoft.Fade(Duration=0.2)" />
</head>
<body style ="margin :0px; background-color:#E4F1F7; width:100%; height:100%; ">
    <form id="form1" runat="server">
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
    <table  style="height:100%; width:100%; " cellspacing="0" border="0"  >
             <tr class="UnderlinedRow" style="height:5%;">
                 <td  style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:5px;width:25%;">
                      <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            Online Orders&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorCount" />
                            &nbsp;<span class="NonBold">(<asp:Label runat="server" ID="lblFilter" Text="all" />)</span>                       
                        </ContentTemplate>
                        <Triggers >
                              <asp:AsyncPostBackTrigger ControlID="ddlClients" EventName="SelectedIndexChanged" />
                              <asp:AsyncPostBackTrigger ControlID="ddlStates" EventName="SelectedIndexChanged" />
                              <asp:AsyncPostBackTrigger ControlID="ddlOrderStatus" EventName="SelectedIndexChanged" />                              
                              <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                              
                              <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
      
                </td>
                 <td style="width:75%;background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right;">
                    <table style="height:25px; width:100%; border:0px; text-align:right;border-bottom:0px;"  cellspacing="0" cellpadding="0" border="0">
                        <tr>                                                       
                            <td style="border-bottom:0px; width:100%;">                                  
                                  <asp:LinkButton ID="lnkResetFilters" runat="server" CssClass="HomeButton">
                                    <div style="width:110px;  cursor:pointer;" class="LeadDetailButton" onclick="javascript:resetFilters();">
                                    Reset Filters 
                                    <img  src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10"  style="border:0px;" /></div>
                                  </asp:LinkButton>
                            </td>                            
                        </tr>
                    </table>
                 </td>                        
             </tr>              
             <tr style="height:5%;">
                <td colspan="2" style="background-color:#BADCFC;font-size:11px;">
                    <table border="0" cellpadding="0" cellspacing="0"  style="height:100%; width:100%; white-space:nowrap;">
                    <tr>
                       <%--<td style="padding:5px;text-align:left ; white-space:nowrap; padding-right:1em; padding-top:13px;  ">
                        <div style="width:100px;" class="LeadDetailButton" onclick="javascript:window.location='TicketsNew.aspx?PrevPage=3'"   >
                          NEW TICKET
                          <img align="absMiddle"  height="10" src="../images/blt_resetFilters.gif" width="10" /> 
                          </div>
                      </td>
                      <td style="width:10px;text-align:center; ">
                          <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                      </td>--%>
                      <td align="left" style="padding-left:5px; padding-right:5px; width: 15px;">
                          <span style="font-size: 7pt; color: #7c8798">Clients&nbsp;</span><br />
                         <asp:DropDownList 
                           ID="ddlClients" 
                           runat="server" 
                           SkinID="SmallTextCombo"                           
                           DataTextField="Name" 
                           DataValueField="ID" 
                           AutoPostBack="True" Width="110px" DataSourceID="SDS_Clients">
                          </asp:DropDownList>&nbsp;
                          <asp:SqlDataSource ID="SDS_Clients" 
                              runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                              SelectCommand="Clients_GetByUserID" 
                              SelectCommandType="StoredProcedure"
                              DataSourceMode="DataReader">
                              <SelectParameters>
                                  <asp:SessionParameter DefaultValue="" Name="UserID" SessionField="AdminID" Type="Int32" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                         </td>        
                      <td style="width:30px;text-align:center; ">
                         <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                      </td>
                      <td style="padding-left:5px; padding-right:5px; "  >
                          <span class="GrayHeader">States<br />
                          </span>
                            <asp:DropDownList 
                            ID="ddlStates" 
                            runat="server" 
                            SkinID="SmallTextCombo"
                            DataTextField="Name" 
                            DataValueField="ID" 
                            AutoPostBack="True" Width="100px" DataSourceID="SDS_States">
                          </asp:DropDownList>&nbsp;
                          <asp:SqlDataSource 
                                ID="SDS_States" 
                                runat="server" 
                                ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                SelectCommand="States_GetAll_For_List" 
                                SelectCommandType="StoredProcedure" 
                                DataSourceMode="DataReader">                                                                        
                            </asp:SqlDataSource>
                       </td>
                       <td style="width:30px;text-align:center; ">
                         <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                      </td>
                       <td style="padding-left:5px; padding-right:5px; "  >
                          <span class="GrayHeader">Status<br />
                          </span>
                            <asp:DropDownList 
                            ID="ddlOrderStatus" 
                            runat="server" 
                            SkinID="SmallTextCombo"
                            DataTextField="Status" 
                            DataValueField="ID" 
                            AutoPostBack="True" Width="100px" DataSourceID="sds_OrdersStatus">
                          </asp:DropDownList>&nbsp;
                          <asp:SqlDataSource 
                                ID="sds_OrdersStatus" 
                                runat="server" 
                                ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                SelectCommand="SCM_OrderStatus_GetAll" 
                                SelectCommandType="StoredProcedure" 
                                DataSourceMode="DataReader">                                                                        
                            </asp:SqlDataSource>
                       </td>
                       <td style="width:30px;text-align:center; ">
                         <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                      </td>         
                       <td style="padding:3px; white-space:nowrap;" align="left"  >
                           <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
                               <span class="GreyTextSmall"><span style="color: #000000"></span>Search</span><br />
                               <span>
                                   <asp:TextBox ID="txtSearch" runat="server" MaxLength="50" onfocus="javascript:this.value='';"
                                       SkinID="GreenSmallTextbox" Width="100px"></asp:TextBox>
                                   <asp:ImageButton ID="btnSearch" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/btn_go.gif" />
                               </span>
                           </asp:Panel>
                      </td>
                      <td style="width:70%;">
                      &nbsp;&nbsp;
                      </td>
                   </tr>
                 </table>
                </td>
             </tr>
             <tr style=" height:85%; width:100%;">
               <td  colspan="2" style="background-color:#E4F1F7;  vertical-align:top; height: 85%; margin:0px;padding:0px; ">              
                    <div style="width:100%; height:100%; overflow:auto;  background-color:#E4F1F7;border:1px solid #ACBDD5;" class="ScrollBarHomeTicket" >                   
                    <asp:UpdatePanel ID="UpdatePanel2" 
                     runat="server" 
                     UpdateMode="Always"
                     RenderMode="Inline">
                     <ContentTemplate>
                        <asp:GridView 
                        ID="gvReleases" 
                        runat="server"
                        PageSize="200" 
                        AutoGenerateColumns="False" 
                        EnableTheming="True" 
                        SkinID="GridViewWithOutPaging"
                        AllowSorting="True" DataKeyNames="ID" DataSourceID="ObjectDataSource1" >
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
                            
                                 <asp:TemplateField HeaderText="" SortExpression="" HeaderStyle-Wrap="false" >
                                    <ItemTemplate>
                                     <img src="../images/arrows.gif" /> 
                                    </ItemTemplate>
                                    <ItemStyle Wrap="false" Width="1%"/>
                                </asp:TemplateField> 
                                                             
                                  <asp:TemplateField HeaderText="Order #" SortExpression="ID" HeaderStyle-Wrap="false" >
                                    <ItemTemplate>
                                    <span title='<%#Eval("ID")%>' >
                                        <asp:Label ID="lblName" runat="server" Text='<%# Server.HtmlEncode(Functions.StringTruncate(Functions.IfNull(Eval("ID"),""),30))%>' > ></asp:Label>
                                    </span>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="false" Width="4%"/>
                                </asp:TemplateField>                                   
                                 <asp:TemplateField HeaderText="Store" SortExpression="StoreName" HeaderStyle-Wrap="false" >
                                    <ItemTemplate>
                                    <span title='<%#Eval("StoreName")%>' >
                                        <asp:Label ID="lblName" runat="server" Text='<%# Server.HtmlEncode(Functions.StringTruncate(Functions.IfNull(Eval("StoreName"),""),30))%>' > ></asp:Label>
                                    </span>
                                    </ItemTemplate>
                                    <ItemStyle  Width="55%" Wrap="false"/>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Client" SortExpression="ClientName" HeaderStyle-Wrap="false" >
                                    <ItemTemplate>
                                    <span title='<%#Eval("ClientName")%>' >
                                        <asp:Label ID="lblStatus" runat="server" Text='<%# Server.HtmlEncode(Functions.StringTruncate(Functions.IfNull(Eval("ClientName"),""),30))%>' > ></asp:Label>
                                    </span>
                                    </ItemTemplate>
                                    <ItemStyle  Width="17%" Wrap="false"/>
                                </asp:TemplateField>                               
                                <asp:BoundField DataField="OrderDate" HeaderText="Order Date" SortExpression="OrderDate"  DataFormatString="{0:d}" HtmlEncode="False" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
                                 <asp:TemplateField HeaderText="Grand Total" SortExpression="GrandTotal" HeaderStyle-Wrap="false" >
                                    <ItemTemplate>
                                    <span title='<%#FormatCurrency(Functions.IfNull(Eval("GrandTotal"),0))%>' >
                                        <asp:Label ID="lblName" runat="server" Text='<%# FormatCurrency(Functions.IfNull(Eval("GrandTotal"),0))%>' > ></asp:Label>
                                    </span>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="false"  Width="13%"/>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Status&nbsp;&nbsp;" SortExpression="Status" HeaderStyle-Wrap="false" >
                                    <ItemTemplate>
                                    <span>
                                        <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("OrderStatus")%>' style="padding-right:2px;"></asp:Label>                                        
                                    </span>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="false"  Width="10%"/>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Action" Visible="false">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="HyperLink1" Target="_blank" runat="server" NavigateUrl='<%# "OrderDetailPrint.aspx?OrderID=" &  Eval("ID") %>'  Text="Print "></asp:HyperLink>
                                        <asp:HyperLink ID="HyperLink2" Target="_self" runat="server" NavigateUrl='<%# "OrderDetail.aspx?OrderID=" &  Eval("ID") %>'  Text="| View Invoice &nbsp;&nbsp;"></asp:HyperLink>
                                        <%--<asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="View" Text="| View Invoice &nbsp;&nbsp;"></asp:LinkButton>--%>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="false"  />                                  
                                    <ItemStyle HorizontalAlign="Center" Wrap="false"  />
                                </asp:TemplateField>
                                                                
                            </Columns>
                        </asp:GridView>                         
                             </ContentTemplate>
                                  <Triggers >
                                  <asp:AsyncPostBackTrigger ControlID="ddlStates" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlClients" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                              
                                  <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                                  </Triggers>
                            </asp:UpdatePanel>       
                        <asp:ObjectDataSource ID="ObjectDataSource1" 
                            runat="server" 
                            SortParameterName="sortExpression"
                            SelectMethod="SCM_OrdersGetAll"
                            TypeName="Portal.BLL.Orders.SCM_Orders">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddlClients" Name="ClientID" PropertyName="SelectedValue"   Type="Int32" />
                                <asp:ControlParameter ControlID="ddlOrderStatus" DefaultValue="0" Name="OrderStatusID"
                                    PropertyName="SelectedValue" Type="Int32" />
                                <asp:ControlParameter ControlID="ddlStates" DefaultValue="1" Name="StateID" PropertyName="SelectedValue" Type="Int32" />
                                <asp:Parameter Name="sortExpression" Type="String" />
                                <asp:Parameter DefaultValue="" Name="maximumRows" Type="Int32" />
                                <asp:Parameter Name="startRowIndex" Type="Int32" />                         
                                <asp:ControlParameter ControlID="txtsearch" DefaultValue="" Name="txtsearch" PropertyName="Text" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </div>
               </td>
             </tr>             
             <tr style="height:20px; background-color:#BADCFC;">
                <td style="width:75%; text-align:left;" id="CustomPagerRow">&nbsp;</td>                    
                <td style="width:25%;">
                    <table cellpadding="0" cellspacing="0" class="GrayHeader">
                            <tr>
                                <td>
                                    <span style="font-size:7pt; color: #ff0000"></span>
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span style="font-size:7pt; color: #ff0000"></span>
                                </td>
                            </tr>
                    </table> 
                </td>
             </tr>
            </table>
    </div>
    </form>
    <script type="text/javascript" language="javascript">
    function resetFilters()
    {      
        var item; 
        if (item = document.getElementById('<%= txtSearch.ClientID %>'))
        {        
            item.value = '';
        }
        if (item = document.getElementById('<%= ddlStates.ClientID %>'))
        {
            item.value = 0;
        }
        if (item = document.getElementById('<%= ddlClients.ClientID %>'))
        {
            item.value = 0;
        }
        if (item = document.getElementById('<%= ddlOrderStatus.ClientID %>'))
        {
            item.value = 0;
        }
       return true;
    }
   //These Mothods are used to Enable pagging on a TD and Also Empty txtSearch
   function AdjustPagerRow()
   {
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
    
    function beginRequest(sender, args) 
    {
        postbackElement = args.get_postBackElement();
    }    
    function pageLoaded(sender, args) 
    {
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
    //These Mothods are used to Enable pagging on a TD and Also Empty txtSearch
</script>
</body>
</html>
