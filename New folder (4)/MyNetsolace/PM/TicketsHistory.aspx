<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TicketsHistory.aspx.vb" Inherits="PM_TicketsHistory" Theme="Default"  %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../../scripts/functions.js" ></script>
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
                    <asp:Image ID="Image2" runat="server" ImageUrl="../../images/indicator.gif" ImageAlign="AbsMiddle" /> <span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
                    <br /><br />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
    <table  style="height:100%; width:100%; " cellspacing="0" border="0"  >
             <tr class="UnderlinedRow" style="height:5%;">
                 <td  style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:5px;width:50%;">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            Tickets History &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorCount" />
                            &nbsp;<span class="NonBold">(<asp:Label runat="server" ID="lblFilter" Text="all" />)</span>                       
                        </ContentTemplate>
                         <Triggers >
                              <asp:AsyncPostBackTrigger ControlID="ddlCategories" EventName="SelectedIndexChanged" />                              
                              <asp:AsyncPostBackTrigger ControlID="ddlTypes" EventName="SelectedIndexChanged" />
                              <asp:AsyncPostBackTrigger ControlID="ddlFilter" EventName="SelectedIndexChanged" />
                              <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                              
                              <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                         </Triggers>
                    </asp:UpdatePanel>
      
                </td>
                 <td style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right;">
                    &nbsp;&nbsp;

                     <img align="absMiddle"   src="../../images/pixel_skyBlue.JPG" width="1" />
                     &nbsp;&nbsp;
                     <asp:LinkButton ID="lnkResetFilters" runat="server" CssClass="HomeButton">
                                <div style="width:110px;" class="LeadDetailButton" onclick="javascript:resetFilters();">
                                Reset Filters 
                                <img  src="../../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10"  style="border:0px;" /></div>
                               </asp:LinkButton>
                    
                     <img  align="absmiddle" src="../../images/pixel_skyBlue.jpg" width="1" height="20" />
                    
                 </td>                        
             </tr>              
             <tr>
                <td colspan="2" style="background-color:#BADCFC;font-size:11px;">
                    <table border="0" cellpadding="0" cellspacing="0"  style="height:100%; width:100%; white-space:nowrap;">
                    <tr>
                       <td style="padding:5px;text-align:left ; white-space:nowrap; padding-right:1em; padding-top:13px;  ">
                        <div id="divNewTicket" runat="server" style="width:100px;" class="LeadDetailButton" onclick="javascript:StateSaveNewTicket();"   >
                          NEW TICKET
                          <img align="absMiddle"  height="10" src="../../images/blt_resetFilters.gif" width="10" /> 
                          </div>
                      </td>
                     <%-- <td style="width:10px;text-align:center; ">
                          <img  src="../../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                      </td>
                      <td align="left" style="padding-left:5px; padding-right:5px; width: 15px;">
                          <span style="font-size: 7pt; color: #7c8798">Clients&nbsp;</span><br />
                         <asp:DropDownList 
                           ID="ddlClients" 
                           runat="server" 
                           SkinID="SmallTextCombo"                           
                           DataTextField="Name" 
                           DataValueField="ID" 
                           AutoPostBack="True" Width="110px" DataSourceID="odsClients">
                          </asp:DropDownList>&nbsp;
                          <asp:ObjectDataSource ID="odsClients" runat="server" TypeName="Portal.BLL.Users" SelectMethod="GetClientsByUserIDAndSubModuleIDs">
                           <SelectParameters>
                                <asp:SessionParameter Name="userId" Type="int32" SessionField="AdminID" />                                 
                           </SelectParameters>
                           </asp:ObjectDataSource>
                         </td>   --%>     
                      <td style="width:30px;text-align:center; ">
                         <img  src="../../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                      </td>
                      <td style="padding-left:5px; padding-right:5px; "  >
                          <span class="GrayHeader">Categories<br />
                          </span>
                            <asp:DropDownList 
                            ID="ddlCategories" 
                            runat="server" 
                            SkinID="SmallTextCombo" 
                            DataTextField="Name" 
                            DataValueField="ID" 
                            AutoPostBack="True" Width="100px" DataSourceID="SDS_Categories">
                          </asp:DropDownList>&nbsp;
                         <asp:SqlDataSource ID="SDS_Categories" 
								runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
								SelectCommand="PM_Categories_Clients_GetAll" 
								SelectCommandType="StoredProcedure"
								DataSourceMode="DataReader">
								<SelectParameters>
									<asp:SessionParameter Name="ClientID" SessionField="MyNetsolace_ClientID" DefaultValue="0" />
								</SelectParameters>
							</asp:SqlDataSource>
                       </td> 
                       <td style="width:30px;text-align:center; ">
                         <img  src="../../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                      </td>
                      <td style="padding-left:5px; padding-right:5px; "  >
                          <span class="GrayHeader">Types<br />
                          </span>
                            <asp:DropDownList 
                            ID="ddlTypes" 
                            runat="server" 
                            SkinID="SmallTextCombo"                           
                            DataTextField="Name" 
                            DataValueField="ID" 
                            AutoPostBack="True" Width="100px" DataSourceID="SDS_Type">
                          </asp:DropDownList>&nbsp;&nbsp;
                          <asp:sqldatasource ID="SDS_Type" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                DataSourceMode="DataReader" 
                                SelectCommand="PM_TaskTypes_GetAll" 
                                SelectCommandType="StoredProcedure">
                          </asp:sqldatasource>
                       </td>  
                       <td style="width:10px;text-align:center;">
                           <img  src="../../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" /> 
                      </td>
                      <td style="padding-left:5px; padding-right:5px; "  >
                          <span class="GrayHeader">Filter<br />
                          </span>
                            <asp:DropDownList 
                            ID="ddlFilter" 
                            runat="server" 
                            SkinID="SmallTextCombo"                                                       
                            AutoPostBack="True" Width="100px">
                          </asp:DropDownList>&nbsp;&nbsp;                         
                       </td>  
                       <td style="width:10px;text-align:center;">
                           <img  src="../../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" /> 
                      </td>                    
                       <td style="padding:3px; white-space:nowrap;" align="left"  >
                           <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
                               <span class="GreyTextSmall"><span style="color: #000000"></span>Search</span><br />
                               <span>
                                   <asp:TextBox ID="txtSearch" runat="server" MaxLength="50" onkeyup="if(CheckNoisyWord()==false) return false;" onfocus="javascript:this.value='';"
                                       SkinID="GreenSmallTextbox"  Width="100px"></asp:TextBox>
                                   <asp:ImageButton ID="btnSearch" runat="server" OnClientClick="if(CheckNoisyWord()==false) return false;" ImageAlign="AbsMiddle" ImageUrl="~/images/btn_go.gif" />
                               </span>
                           </asp:Panel>
                      </td>
                      <td style="width:50%;">
                      &nbsp;&nbsp;
                      </td>
                   </tr>
                 </table>
                </td>
             </tr>
             <tr style="width:100%;">
               <td  colspan="2" style="background-color:#E4F1F7;  vertical-align:top; height: 85%; margin:0px;padding:0px;">
                    <div style="width:100%; height:100%; overflow:auto;  background-color:#E4F1F7;border:1px solid #ACBDD5;" class="ScrollBarHomeTicket" >                   
                    <asp:UpdatePanel ID="UpdatePanel2" 
                     runat="server" 
                     UpdateMode="Always"
                     RenderMode="Inline">
                     <ContentTemplate>
                        <asp:GridView 
                        ID="gvReleases" 
                        runat="server" 
                        AutoGenerateColumns="False" 
                        EnableTheming="True" 
                        SkinID="GridViewWithOutPaging"
                        AllowSorting="True" DataKeyNames="ID" DataSourceID="ObjectDataSource1" PageSize="50" >
                         <PagerSettings Mode="Numeric" Position="Bottom" />
                             <PagerTemplate>                                                
                                  <div style="width:100%; border:0px black solid;" >
                                      <table width="100%" border="0" cellpadding="0" cellspacing="0"  style="height:20px;">
                                           <tr style="text-align:left;">
                                                 <td style="width:20%; white-space:nowrap;" align="left"  valign="middle" >
                                                   <span class="DarkBlueTextSmall" style="font-size:10px" >&nbsp; Page <asp:Literal id="litPageNumber" runat="server"/> of <asp:Literal id="litTotalPages"  runat="server"/></span>
                                                 </td>
                                                 <td style="width:10px; " align="right" ><img alt="" src="../../images/spacer.gif" width="15" height="1" align="absmiddle" /></td>                                    
                                                 <td style="width:1px; " align="center"><img alt="" src="../../images/pixel_darkBlue.jpg" width="1" height="20" align="absmiddle" /></td>
                                                 <td style="width:10px;" align="right"><img alt="" src="../../images/spacer.gif" width="15" height="1" align="absmiddle" /></td>
                                                 <td  align="right" valign="top"> <asp:Panel ID="pnlNumber" runat="server" HorizontalAlign="Right"  ></asp:Panel> </td>                                                                                                     
                                            </tr>
                                      </table>  
                                  </div>
                              </PagerTemplate> 
                            <Columns>
                                <asp:TemplateField  SortExpression="Priority" >
                                    <ItemTemplate> 
                                        <img src='<%= ConfigurationManager.AppSettings("ImagesURL") %><%#Eval("Priority") %>'  />                                
                                    </ItemTemplate>
                                    <ItemStyle Width="2%" />                                    
                                </asp:TemplateField>
                                <asp:TemplateField   HeaderText="Ref #" SortExpression="RefNo" >
                                    <ItemTemplate >
                                    <span></span>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center"  Wrap="False"  />
                                    <ItemStyle HorizontalAlign="Center" Wrap="False" Font-Bold="True"  />
                                </asp:TemplateField>                                    
                                 <asp:TemplateField HeaderText="Name" SortExpression="Name" >
                                    <ItemTemplate>
                                    <span title='<%#Eval("Name")%>' >
                                        <asp:Label ID="lblName" runat="server" Text='<%# Server.HtmlEncode(Functions.StringTruncate(Functions.IfNull(Eval("Name"),""),80))%>' > ></asp:Label>
                                    </span>
                                    </ItemTemplate>
                                    <ItemStyle Width="450px" />
                                </asp:TemplateField>
                               
                                <asp:BoundField DataField="DueDate" HeaderText="Date Completed" SortExpression="DateCompleted"  DataFormatString="{0:d}" HtmlEncode="False"  />
                                
                                <asp:BoundField DataField="TypeName" HeaderText="Type" SortExpression="TypeName" />
                                 <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="HyperLink1" Target="_blank" runat="server" NavigateUrl='<%# "TicketsReport.aspx?TicketID=" &  Eval("ID") %>'  Text="Print "></asp:HyperLink>                                  
                                        <asp:HyperLink ID="lbtnEdit" runat="server" Visible="false" NavigateUrl='<%# "TicketsEdit.aspx?TicketID=" &  Eval("ID") &"&PrevPage=3" %>'  Text="| Edit "></asp:HyperLink>                                       
                                        <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="View" Text="| View "></asp:LinkButton>                                      
                                    </ItemTemplate>                                                                       
                                    <HeaderStyle HorizontalAlign="Center" />                                  
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                                                
                            </Columns>
                        </asp:GridView>                         
                             </ContentTemplate>
                                  <Triggers >
                                  <asp:AsyncPostBackTrigger ControlID="ddlCategories" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlTypes" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlFilter" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                              
                                  <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                                  </Triggers>
                            </asp:UpdatePanel>       
                        <asp:ObjectDataSource ID="ObjectDataSource1" 
                            runat="server" 
                            SortParameterName="sortExpression"
                            SelectMethod="PM_TicketGetAllHistoryForMyNetsolace"
                            EnablePaging="true" 
                            SelectCountMethod="PM_TicketGetAllHistoryCountForMyNetsolace" 
                            TypeName="Portal.BLL.PM.PM_Ticket_Features" OldValuesParameterFormatString="original_{0}">
                            <SelectParameters>
                                <asp:SessionParameter SessionField="MyNetsolace_ClientID"  Name="ClientID" Type="Int32" />
                                <asp:ControlParameter ControlID="ddlCategories" DefaultValue="1" Name="CategoryID" PropertyName="SelectedValue" Type="Int32" />
                                <asp:ControlParameter ControlID="ddlTypes" DefaultValue="0" Name="TypeID" PropertyName="SelectedValue" Type="Int32" />                               
                                <asp:ControlParameter ControlID="ddlFilter" DefaultValue="0" Name="FilterID" PropertyName="SelectedValue" Type="Int32" />
                                <asp:Parameter Name="sortExpression" Type="String" />                               
                                <asp:ControlParameter ControlID="txtsearch" DefaultValue="" Name="txtsearch" PropertyName="Text" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </div>
               </td>
             </tr>             
             <tr style="height:20px; background-color:#BADCFC;">
                <td style="width:75%;" id="CustomPagerRow">
                </td>
                <td style="width:25%;">
                    <table cellpadding="0" cellspacing="0" class="GrayHeader">
                            <tr>
                                <td>
                                    <span style="font-size:7pt; color: #ff0000">*</span>
                                    UnRead Tickets are in Yellow Color
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span style="font-size:7pt; color: #ff0000">*</span>
                                    Delayed Tickets are in Red Colors 
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
        if (item = document.getElementById('<%= txtSearch.ClientID %>')){
        
            item.value = '';
        }
        if (item = document.getElementById('<%= ddlCategories.ClientID %>'))
        {
            item.value = 0;
        }
        if (item = document.getElementById('<%= ddlTypes.ClientID %>'))
        {
            item.value = 0;
        }
        if (item = document.getElementById('<%= ddlFilter.ClientID %>'))
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
     function CheckNoisyWord()
        { 
           var mybool = true;
          var InputStr = document.getElementById('<%= txtsearch.ClientID %>').value;
           if (CheckSpecailChar(InputStr)==true)
           {
                alert ("Special characters are not Allowed.\nPlease remove them and try again.");
                document.getElementById('<%= txtSearch.ClientID %>').value='';                
                mybool = false;
                return false;
           }
             if (mybool == false)  
                return false;
             else
                 return true;
            }
            function StateSaveNewTicket(){
            var URL
           var QueryStringValues = "?txtSearch="+document.getElementById ("<%=txtSearch.ClientID%>").value;
           QueryStringValues += "&ddlClients=" + '<%=Session("MyNetsolace_ClientID") %>'; 
            QueryStringValues += "&ddlCategories=" + document.getElementById('<%=ddlCategories.ClientID %>').value; 
            QueryStringValues += "&ddlFilter=" + document.getElementById('<%=ddlFilter.ClientID %>').value;  
            QueryStringValues += "&ddlTypes=" + document.getElementById('<%=ddlTypes.ClientID %>').value;  
            QueryStringValues += "&PrevPage=3"
            URL="TicketsNew.aspx" + QueryStringValues ;
            window.location=URL;
    }
</script>
</body>
</html>
