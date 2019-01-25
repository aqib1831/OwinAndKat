<%@ Page Language="VB" AutoEventWireup="false" EnableTheming="true" Theme="Default"  CodeFile="Client.aspx.vb" Inherits="URLM_Category" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=.2)" />  
</head>
<body style="margin:0;background-color:#E4F1F7; height:100%; width:100%">
    <form id="form1" runat="server">
    <div id="divDisable" class="modalBackground"  ></div>    
     <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="300" ></asp:ScriptManager>
       <div>  
            <asp:UpdateProgress ID="Progress1" runat="server">
                    <ProgressTemplate>
                        <div class="ProgressIndicatorDIV" >
                            <br />
                            <asp:Image ID="Image2" runat="server" ImageUrl="../images/indicator.gif" ImageAlign="AbsMiddle" /> <span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
                            <br /><br />
                        </div>
                    </ProgressTemplate>
            </asp:UpdateProgress>
            <table width="100%" style="height:100%;width:100% " cellspacing="0" border="0"  >
                     <tr class="UnderlinedRow">
                         <td  style="height:31px;background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:5px;width:50%;">
                             <asp:UpdatePanel ID="UpdatePanel1"
                                   runat="server" 
                                   UpdateMode="Conditional"
                                   RenderMode="Inline" >
                                   <ContentTemplate>
                                     Clients&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label runat="server" ID="lblCount" Visible="false"  />
                                            &nbsp;<span class="NonBold"><asp:Label runat="server" ID="lblFilter" Text="all" Visible="false"  /></span>&nbsp;&nbsp;<asp:Label runat="server" ID="lblError" Text="Category with this title already added." Visible="false" CssClass="ErrorMessage" ></asp:Label> 
                                   </ContentTemplate>
                                <Triggers >
                                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click"></asp:AsyncPostBackTrigger>
                                   <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click"></asp:AsyncPostBackTrigger>
                                 </Triggers>
                               </asp:UpdatePanel>     
                        </td>
                         <td style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right;">
                            &nbsp;&nbsp;&nbsp;&nbsp;
                             <asp:LinkButton ID="lnkResetFilters" runat="server" CssClass="HomeButton">
                                  <div style="width:110px;"  class="LeadDetailButton" onclick="javascript:resetFilters();">
                                      Reset Filters 
                                      <img  src="../images/blt_resetFilters.gif" align="absmiddle" width="10" style="border:0px;" height="10" alt="" />
                                  </div>
                             </asp:LinkButton>
                            
                             <img  align="absmiddle" src="../images/pixel_skyBlue.jpg" width="1" height="20" />
                            
                         </td>                        
                     </tr>              
                     <tr>
                        <td colspan="2" style="height:40px;background-color:#BADCFC;font-size:11px;">               
                         <asp:UpdatePanel ID="UpdatePanel3"
                           runat="server" 
                           UpdateMode="Conditional"
                           RenderMode="Inline" >
                              <ContentTemplate>
                                <table border="0" cellpadding="0" cellspacing="0" width="100%" >                        
                                  <tr class="UnderlinedRow" id="tr_Search" runat="server" style="display:inline;">
                                    <td style="width:90px;padding:5px;text-align:center;white-space:nowrap; padding-right:5px; padding-top:13px;">
                                        <div style="width:75px;white-space:nowrap;" class="LeadDetailButton" onclick="javascript:window.location='ClientView.aspx'">
                                          NEW CLIENT
                                          <img align="absMiddle"  height="10" src="../images/blt_resetFilters.gif" width="10" / >
                                        </div>
                                      </td>
                                      <td style="width:25px;text-align:center;padding-right:5px;">
                                         <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                                      </td>
                                     <td style="height:40px;width:90%;background-color:#BADCFC;">
                                         <span class="GreyTextSmall">Search </span><br />
                                         <asp:Panel runat="server" ID="Panel1" DefaultButton="btnSearch" >
                                            <asp:TextBox ID="txtSearch" runat="server" MaxLength="50" onfocus="javascript:this.value='';this.focus();" Width="220px"  CssClass="GreyTextBox" />
                                            <asp:ImageButton ID="btnSearch" runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />
                                         </asp:Panel>
                                     </td>                                                                        
                                  </tr>                                     
                                </table>
                              </ContentTemplate>
                      </asp:UpdatePanel>
                       </td>
                     </tr>
                     <tr>
                       <td  colspan="2" style="height:97%;">
                            <div style="overflow:auto;height:100%;background-color:#E4F1F7;border:1px solid #ACBDD5;border-top:0px;" id="_gridViewPanel1" class="ScrollBarHomeTicket">
                              <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" >
                                 <ContentTemplate>                         
                                    <asp:GridView id="gvClient"
                                           runat="server"
                                           SkinID="GridViewNormal"
                                           DataSourceID="sdsClients"
                                           EnableTheming="True"
                                           AutoGenerateColumns="False">
                                           <EmptyDataTemplate>         
                                               <div id="divInfo" style="position: absolute; width:200px; height:18%; left:38%; top:38%;" class="MessageDiv"> 
                                                     <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height:50px">
                                                       <tr>
                                                            <td style="width:5%;" >&nbsp;</td>
                                                            <td align="right" valign="middle" style="width:25%;">
                                                                <div style="text-align:right;">
                                                                    <asp:Image ID="Image1" runat="server" ImageUrl="~/images/icn_info.gif" />&nbsp;&nbsp; 
                                                                </div>
                                                            </td>
                                                            <td nowrap="nowrap" align="left" valign="middle" id="divMessage" style="width:75%;">&nbsp;No How Heard Found!</td>
                                                        </tr>
                                                     </table>
                                                </div>  
                                          </EmptyDataTemplate>
                                           <Columns>
                                                <asp:TemplateField >
                                                   <ItemStyle Width="2%" />
                                                    <ItemTemplate  >
                                                       <img src="../images/arrows.gif" alt="" id="imgarrow" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>                                                 
                                                <asp:TemplateField HeaderText="Name" SortExpression="Name">
                                                    <ItemStyle Font-Bold="True" Width="30%" />
                                                    <ItemTemplate>
                                                         <asp:Label ID="lblTitle" runat="server" Text='<%# Server.HtmlEncode(Functions.IfNull(Container.DataItem("Name"), "")) %>'></asp:Label>
                                                    </ItemTemplate>                  
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Code" SortExpression="Code">
                                                    <ItemStyle  Width="10%" />
                                                    <ItemTemplate>
                                                         <asp:Label ID="lblDescription" runat="server" Text='<%# Functions.StringTruncate(Server.HtmlEncode(Functions.IfNull(Container.DataItem("Code"), "")) , 85)%>'></asp:Label>
                                                    </ItemTemplate>                  
                                                </asp:TemplateField>
                                                 <asp:TemplateField HeaderText="Email" SortExpression="Email">
                                                    <ItemStyle  Width="14%" />
                                                    <ItemTemplate>
                                                         <asp:Label ID="lblEmail" runat="server" Text='<%# Functions.StringTruncate(Server.HtmlEncode(Functions.IfNull(Container.DataItem("Email"), "")) , 85)%>'></asp:Label>
                                                    </ItemTemplate>                  
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="URL" SortExpression="url">
                                                    <ItemStyle  Width="14%" />
                                                    <ItemTemplate>
                                                         <asp:Label ID="lblurl" runat="server" Text='<%# Functions.StringTruncate(Server.HtmlEncode(Functions.IfNull(Container.DataItem("url"), "")) , 85)%>'></asp:Label>
                                                    </ItemTemplate>                  
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Country" SortExpression="CountryName">
                                                    <ItemStyle  Width="12%" Wrap="false" />
                                                    <ItemTemplate>
                                                         <asp:Label ID="lblCountryName" runat="server" Text='<%# Functions.StringTruncate(Server.HtmlEncode(Functions.IfNull(Container.DataItem("CountryName"), "")) , 85)%>'></asp:Label>
                                                    </ItemTemplate>                  
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Action">
                                                    <ItemTemplate> 
                                                        <asp:HyperLink  ID="hylEdit"  runat="server" NavigateUrl='<%# "ClientView.aspx?ClientID=" &  Eval("ID") %>'  Text="Edit |"></asp:HyperLink> 
                                                        <asp:LinkButton ID="lbtnDelete" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="MyDelete" Text=" Delete" OnClientClick="if (confirm('Are you sure you want to Delete this Client.') == false) return false;" ></asp:LinkButton> 
                                                    </ItemTemplate>                                   
                                                    <HeaderStyle HorizontalAlign="Center" />                                  
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>              
                                                <asp:TemplateField HeaderText="ID" Visible="False">                                           
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblID" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                    </asp:GridView> 
                                 </ContentTemplate>
                                 <Triggers >
                                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click"></asp:AsyncPostBackTrigger>
                                   <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click"></asp:AsyncPostBackTrigger>
                                 </Triggers>
                              </asp:UpdatePanel> 
                              <asp:SqlDataSource ID="sdsClients" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>" SelectCommand="Clients_Search" SelectCommandType="StoredProcedure" SortParameterName="SortExpression" >
                                <SelectParameters >  
                                  <asp:ControlParameter ControlID="txtSearch" Name="Search" Type="String" PropertyName="Text" ConvertEmptyStringToNull="false" />                          
                                </SelectParameters>
                              </asp:SqlDataSource>                    
                            </div>
                       </td>
                     </tr>
                     <tr style="background-color:#BADCFC;">
                        <td align="left" colspan="2" id="CustomPagerRow" style="height:22px;">&nbsp;</td>
                     </tr>
            </table>
         </div>
    </form>
    <script type="text/javascript" language="javascript">
         function resetFilters()
            {         
                var item;     
              
                if (item = document.getElementById('<%= txtSearch.ClientID %>')){
              
                    item.value = '';
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
                    objCustomRow.innerHTML = "<table cellpadding=0 cellspacing=0  align='left' height='18' ><tr class='cpyFloatingPager'>"+objTag.innerHTML+"</tr></table>";
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
      </script>
</body>
</html>