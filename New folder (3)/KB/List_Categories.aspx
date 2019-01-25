<%@ Page Language="VB" AutoEventWireup="false" CodeFile="List_Categories.aspx.vb" Inherits="KB_List_Categories" Theme="Default" EnableTheming="true" ValidateRequest="false" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Open Actvities</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <link href="../App_Themes/Default/Calendar/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="javaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="javaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="javaScript" src="../scripts/calendar-fs.js"></script>
    <style type="text/css">
    .GridArrowColumn
    {   
	background-image: url('../images/arrows.gif');
	background-repeat:no-repeat;
	background-position:center;
    }
    </style>
</head>
<body style ="margin :0px;background-color:#E4F1F7;">
    <form id="form1" runat="server">
    <div>
    <asp:HiddenField runat="server" ID="hdnCategoryID" Value="0" />
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
                 <td  style="height:20px;background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:5px;width:80%;">
                     <asp:UpdatePanel ID="UPHeaderCount" runat="server" UpdateMode="Always" RenderMode="Inline">
                        <ContentTemplate>
                            &nbsp;
                            <asp:Label ID="lblCategoryName" runat="server" Font-Bold="True" Text="Categories"></asp:Label>
                            | <span class="NonBold">
                                <asp:Label runat="server" ID="lblRecCount" />
                                (<asp:Label runat="server" ID="lblFilter" Text="all" />)</span>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                 <td  style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;text-align:right; height: 1px;width:150px;" align="right" >
                     <asp:LinkButton ID="lnkResetFilters" runat="server" CssClass="HomeButton">
                                <div style="width:110px;" class="LeadDetailButton" onclick="javascript:resetFilters();">
                                Reset Filters 
                                <img  src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10" style="border:0px;"/>
                                </div>
                     </asp:LinkButton>&nbsp;
                    
                 </td>                        
             </tr>              
             <tr>
                <td colspan="2" style="height:40px;background-color:#BADCFC;font-size:11px;">
                  <table border="0" cellpadding="0" cellspacing="0" width="100%" style="white-space:nowrap;">
                    <tr>  
                    <td style="padding-bottom: 2px;padding-left:5px;" valign="bottom" width="10px;" align="center" runat="server"
                                id="tdNewTopic">
                                <asp:LinkButton ID="lnkAddTopic" runat="server" Visible="True">
                            <div style="width:120px;display:inline;" class="FlatButton">New Category</div>
                                </asp:LinkButton>
                            </td>                
                                                       
                          <td style="width:10px;text-align:center;">
                               <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" /> 
                          </td>                    
                          <td style="padding:3px; white-space:nowrap;" align="left"   >
                          <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" >
                               <span class="GreyTextSmall">Search</span><br />
                                <span><asp:TextBox ID="txtSearch" runat="server" onfocus="javascript:this.value='';" MaxLength="50"   Width="100px"  SkinID="GreenSmallTextbox" />
                                <asp:ImageButton ID="btnSearch"  runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />
                                </span></asp:Panel>
                          </td>
                           <td style="width:50%;" >
                           &nbsp;&nbsp;
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
                         RenderMode="Inline">
                         <ContentTemplate>
                            <asp:GridView ID="GdChapterDetail"
                            runat="server"
                            AutoGenerateColumns="False"
                            AllowPaging="false"
                            DataSourceID="sdCategories" 
                            EnableTheming="True" 
                            EnableViewState="false"
                            SkinId="GridViewNoPaging"
                            DataKeyNames="ID">
                             <Columns>
                                        <asp:TemplateField SortExpression="ID">
                                            <ItemTemplate>
                                                <asp:Label ID="lblID" runat="server" Text='<%# Bind("ID") %>' Visible="false"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="7px" CssClass="GridArrowColumn" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Category" SortExpression="Name">
                                            <ItemTemplate>
                                                <%#Server.HtmlEncode(Functions.StringTruncate(Container.DataItem("Name"), 65))%>
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="True" Height="22px"  />
                                        </asp:TemplateField>
                                      <asp:BoundField DataField="UpdateDate" HeaderText="Last Activity" SortExpression="UpdateDate"
                                            HtmlEncode="False">
                                            <ItemStyle Height="22px" Width="120px" Wrap="False" />
                                        </asp:BoundField>
                                     <asp:HyperLinkField DataNavigateUrlFields="ID" DataNavigateUrlFormatString="Add_Category.aspx?CategoryID={0}"
                                            Text="Edit" ControlStyle-Font-Bold="true" ItemStyle-HorizontalAlign="right" />
                                        <asp:CommandField ShowDeleteButton="True">
                                         <ItemStyle HorizontalAlign="center" Width="70px"  />
                                         </asp:CommandField>
                                    </Columns>
                            </asp:GridView>
                             </ContentTemplate>
                                  <Triggers >                                  
                                  <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                              
                                  <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                                  </Triggers>
                            </asp:UpdatePanel> 
                             <asp:ObjectDataSource
                                ID="sdCategories" runat="server"
                                SelectMethod="GetCategories"
                                TypeName="Category" 
                                SortParameterName="sortExpression"
                                 DeleteMethod="Delete">   
                                <SelectParameters>                           
                                    <asp:Parameter DefaultValue="0" Name="Reccount" Type="Int32" />
                                    <asp:Parameter DefaultValue="" Name="SortExpression" Type="String" />
                                  <asp:ControlParameter  Name="Search" Type="String" ControlID="txtSearch" PropertyName="Text" DefaultValue=""  />
                                </SelectParameters>
                                 <DeleteParameters>
                                     <asp:Parameter Name="ID" Type="Int32" />
                                 </DeleteParameters>
                           </asp:ObjectDataSource> 
                          
                         </div>                   
               </td>
             </tr> 
         </table>
    </div>
    </form>
    <script type="text/javascript" language="javascript">
 function resetFilters(){
    var item;     
    if (item = document.getElementById('<%= txtSearch.ClientID %>'))
        item.value = '';
    return true;
    }

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
                $get('<%= txtSearch.ClientID %>').value='';               
            }
        }
    }
</script>
</body>
</html>