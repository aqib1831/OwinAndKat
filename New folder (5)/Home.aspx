<%@ Page Language="VB" MasterPageFile="~/main.master" AutoEventWireup="false" Theme="Default" CodeFile="Home.aspx.vb" Inherits="Admin_Home" title="Netsolace Portal - Home" %>
<%@ MasterType VirtualPath="~/main.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" Runat="Server">
    <div id="divDisable" class="modalBackground" ></div>
<table style="width:100%;height:100%;border:none;padding:3px;"  border="0" cellpadding="0" cellspacing="0" class="MainTable" >
  <tr>  
  	<td valign="top">
        <table style="width:100%;height:100%;"  border="0" cellpadding="0" cellspacing="0">
          <tr >
            <td valign="top" style="width:25%;height:100%;">             
              <table style="width:100%;height:100%;border:1px solid #79A0D3; background-color:#D9EAFC;" border="0" cellspacing="0" cellpadding="0" >
               <tr  style="height:25px" class="HeadingHome">
                  <td  style="width:77%;">                  
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                      <ContentTemplate>
                        Open Activities&nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="lblActivities" runat="Server" Text="0" ></asp:Label>&nbsp;
                      </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlActivitiesSource" EventName="SelectedIndexChanged" />                                                          
                            <asp:AsyncPostBackTrigger ControlID="ddlClient" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel> 
                  </td>
                  <td style="width:10%;">&nbsp;</td>
                  <td align="right">&nbsp;</td>
                </tr>
               <tr>
                  <td colspan="3" style="height:100%;">
                   
                  	<table style="width:100%;height:100%; background-color:#BADCFC;" border="0" cellspacing="0" cellpadding="0" >
                        	<tr style="height:25px">
                            	<td colspan="3">
                                	<asp:DropDownList runat="server" ID="ddlActivitiesSource" 
                                	      Width="100%"
                                	      SkinID="SmallTextCombo"
                                	      AutoPostBack="True" >
                                        <asp:ListItem Value="0"  Text="Show All Activities" />                                                                                                                               
                                    </asp:DropDownList>
                               </td>
                            </tr>
                        	<tr style="height:25px;">
                            	<td   class="SimpleSmall" style="width:100%;border-top:1px solid #88C4FA;border-bottom:1px solid #88C4FA;font-size:11px;font:Arial, Helvetica, sans-serif;padding-left:10px; padding-left:0px;">
                            	 <asp:Menu ID="MenuSortActivities" runat="server"  
                                            Orientation="Horizontal"
                                            DynamicVerticalOffset="-4"
                                            DynamicHorizontalOffset="210"
                                            Width="100%"
                                            StaticEnableDefaultPopOutImage="false"
                                            Font-Size="12px" >
                                            <StaticItemTemplate>
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="cursor:pointer;">
                                                <tr>
                                                    <td style="background-color:#BADCFC;height:20px;font-size:11px;padding-left:5px;border-bottom:1px solid #88C4FA;width:90%;">
                                                        <span class="GreyText">Sort by:</span> 
                                                        <asp:UpdatePanel runat="server" ID="UPanelMenu" UpdateMode="Always" RenderMode="Inline">
                                                            <ContentTemplate>
                                                                <asp:Label runat="server" ID="lblSortBy" Text="Store Name" />
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </td>
                                                    <td style="background-color:#BADCFC;height:20px;font-size:11px;text-align:right;border-bottom:1px solid #88C4FA;"><img  src="images/pixel_darkBlue.jpg" width="1" height="15" /></td>
                                                    <td style="background-color:#BADCFC;font-size:11px;text-align:center;border-bottom:1px solid #88C4FA;">
                                                        <img  src="images/arrow_down.gif" align="absmiddle" alt="" />
                                                    </td>
                                                </tr>
                                            </table>
                                            </StaticItemTemplate>
                                            <DynamicHoverStyle 
                                                CssClass="MenuDynamicHoverStyle"
                                                BackColor="#A0CDEE"
                                                BorderColor="#609BD3"
                                                BorderStyle="Solid"
                                                BorderWidth="1px"
                                                ForeColor="#467FA6"
                                                Height="22px"
                                            />
                                            <DynamicMenuItemStyle
                                                ForeColor="#305872"
                                                BackColor="#C9DFF9"
                                                Height="22px"
                                                Width="90px"
                                                HorizontalPadding="5px"
                                                VerticalPadding="5px"
                                                BorderColor="#C9DFF9"
                                                BorderStyle="Solid"
                                                BorderWidth="1px"
                                            />
                                            <DynamicMenuStyle
                                                BackColor="#C9DFF9"
                                                BorderColor="#88C4FA"
                                                BorderStyle="Solid"
                                                BorderWidth="1px"
                                                HorizontalPadding="2"
                                                VerticalPadding="2"
                                            />
                                            <Items>
                                                <asp:MenuItem>
                                                    <asp:MenuItem
                                                        Text="Activity Status"
                                                        Selectable="true" 
                                                        Value="1" />                                                   
                                                    <asp:MenuItem
                                                        Text="Activity Type"
                                                        Selectable="true" 
                                                        Value="2" />
                                                    <asp:MenuItem
                                                        Text="Store Number"
                                                        Selectable="true" 
                                                        Value="3" />
                                                    <asp:MenuItem
                                                        Text="Store Name"
                                                        Selectable="true" 
                                                        Value="4" />
                                                    <asp:MenuItem
                                                        Text="Activity Date"
                                                        Selectable="true" 
                                                        Value="5" />                                                  
                                                </asp:MenuItem>
                                            </Items>
                                         </asp:Menu>
                                </td>
                        	</tr>
                        	<tr>
                            <td colspan="3" valign="top"  style="height:100%; background-color:#FFFFFF;">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                <ContentTemplate>
                                    <asp:Repeater ID="rptMyActivities" runat="server" DataSourceID="odsMyActivities" EnableViewState="true" >
                                        <HeaderTemplate>
                                            <div style="overflow-y:auto;height:100%" class="ScrollBarHomeTicket" >  
                                            <table style="height:100%;width:100%;"  cellpadding="0" cellspacing="0" border="0">
                                            <tr><td>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                          <table onclick="javascript:window.location='Com/Admin_main_com.aspx?ID=<%#Eval("ID")%>&FranchiseID=<%#Eval("FranchiseID")%>&PrevPage=1&ClientID=<%#Eval("ClientID")%>';"  class='<%#IIf(Eval("Priority")=1,"RedRow","GreenRow") %>'  onmouseover="changeClass(this, 'MouseOverRow');" onmouseout="changeClass(this, 'MouseOutRow');" border="0" cellspacing="0" cellpadding="0" style="font:Arial, Helvetica, sans-serif;font-size:11px;padding-left:5px;width:100%;height:45px;background-color:<%#Functions.GetActivityPriorityColorByID(Functions.IfNull(Eval("Priority"),""))%>;">
                                                <tr style="height:15px;">
                                                    <td  align="center" valign="middle" style="padding-top:2px;width:15px;"><img src="<%= ConfigurationManager.AppSettings("ImagesURL") %><%#Functions.GetActivityImage(Eval("Type")) %>" alt="Type"  />
                                                    </td>
                                                    <td style="width:65%;font-weight:bold;">
                                                    <%#Functions.StringTruncate(Eval("StoreName"), 18)%>          
                                                    </td>
                                                    <td align="right">
                                                    <%#Functions.GetWeekDay(CType(Eval("ActivityDate"), DateTime).DayOfWeek) & " " & CType(Eval("ActivityDate"), DateTime).Day & "/" & CType(Eval("ActivityDate"), DateTime).Month%>    
                                                   &nbsp;</td>
                                                </tr>
                                                <tr style="height:15px;" onmouseover="changeClass(this, 'MouseOverRow');" onmouseout="changeClass(this, 'MouseOutRow');">
                                                    <td>&nbsp;</td>
                                                    <td colspan="2">
                                                    <span title='<%#Functions.IfNull(Eval("Subject"), "")%>'>
                                                    <%#Functions.StringTruncate(Eval("Subject"), 25)%>          
                                                    </span>
                                                    </td>
                                                </tr>
                                                <tr style="height:15px;" onmouseover="changeClass(this, 'MouseOverRow');" onmouseout="changeClass(this, 'MouseOutRow');">
                                                    <td style="border-bottom:1px solid #D0ECED;">&nbsp;</td>
                                                    <td colspan="2" style="border-bottom:1px solid #D0ECED;"><%#IIf(CInt(ddlClient.SelectedValue) = 1, "", "&nbsp;")%>
                                                        <table border="0" cellspacing="0" cellpadding="0" style="width:100%;height:100%;font:Arial, Helvetica, sans-serif;font-size:11px;<%# IIF(CInt(ddlClient.SelectedValue) = 1 ,"display:inline;","display:none;") %>">
                                                        <tr>
                                                        <td style="color:#7C8798;">&nbsp;</td>
                                                        <td style="font-style:italic;color:#7C8798;" align="right">
                                                           <%#Eval("ActivityStateText")%> <%#IIf(Eval("ActivityState") = 4, ":" & Functions.StringTruncate(Functions.IfNull(Eval("WaitingForName"), ""), 8), "")%> 
                                                        </td>            
                                                        </tr>
                                                        </table>
                                                    </td>
                                                   </tr>
                                                </table>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </td></tr>
                                                <tr id="trMyActivities_NoRecord" runat="server" style="background-color:#FFFFFF;"><td style="font:Arial, Helvetica, sans-serif;font-size:11px;font-style:italic;text-align:center;height:20px;">No Activity to show!</td></tr>
                                                <tr><td style="height:100%;"></td></tr>
                                            </table> 
                                            </div>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                    <asp:ObjectDataSource ID="odsMyActivities" runat="server" 
                                            SelectMethod="ActivitiesGetAllBySearch"
                                            TypeName="Portal.BLL.Activities">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="ddlClient"  Name="ClientID" PropertyName="SelectedValue" Type="Int32" />
                                                <asp:ControlParameter ControlID="ddlActivitiesSource"  Name="WaitingFor" PropertyName="SelectedValue" Type="String" />                                                
                                                <asp:ControlParameter Name="SortExpression" Direction="Input" ControlID="MenuSortActivities" Type="Int32" DefaultValue="4" PropertyName="SelectedValue"  />                                                
                                        </SelectParameters>
                                    </asp:ObjectDataSource> 
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddlActivitiesSource" EventName="SelectedIndexChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="MenuSortActivities" EventName="MenuItemClick" />
                                    <asp:AsyncPostBackTrigger ControlID="ddlClient" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>                            	
                           </td>
                           </tr>
                    </table>  
                  </td>
               </tr>               
                <tr    >
                                    <%--<td colspan="3">
                    <asp:UpdatePanel ID="UpdatePanel5" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                    	        <table style="width:100%;height:100px;" runat="server" id="trStoreStats" border="0" cellspacing="0" cellpadding="0">
                        	        <tr style="height:25px;" class="HeadingHome">
                            	        <td>Client Stats&nbsp;</td>
                                        <td>&nbsp;</td>                                     
                        	        </tr>
                                    <tr>
                                    <td colspan="2" > 
                                    <div id="divToolTip" style="background:'#D8EAFC';border:1px solid black;display:none;position:absolute;width:300px;z-Index:1000;font-size:12px; padding:2px; padding-left:3px;"></div>            
                                         <asp:Repeater
                                            runat="server"
                                            ID="rptrClientState"  >
                                            <HeaderTemplate>
                                             <table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%;" class="HomeClientStats">
                                                    <tr>
                                                          <th style="width:5px; height:20px;" >&nbsp;</th>
                                                          <th style="width:80px;" align="left">Name </th>
                                                          <th style="width:20px;">Stores&nbsp;</th>
                                                          <th style="width:20px;">Activities&nbsp;</th>
                                                          <th style="width:20px;">Tickets</th>
                                                          <th style="width:5px;">&nbsp;</th>
                                                    </tr> 
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                    <tr style="background-color:#FFFFFF;" >
                                                          <td >&nbsp;</td>
                                                          <td style="padding:0px;"   align="left"  ><%#Functions.StringTruncate(Functions.IfNull(Eval("ClientName"), ""), 21)%> </td>
                                                          <td align="Center"><%#Eval("TotalStores")%></td>
                                                          <td align="Center"><%#Eval("OpenActivities")%></td>
                                                          <td align="Center"><%#Eval("OpenTicket")%></td> 
                                                          <td >&nbsp;</td>
                                                   </tr>                                         
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                   <tr style="background-color:#FFFFFF; ">
                                                          <td >&nbsp;</td>
                                                          <td style="font-weight:bold;" align="right"  >Total </td>
                                                          <td align="Center" ><asp:Label runat="server" ID="lblStoreTotal" Text="0" ></asp:Label></td>
                                                          <td align="Center" ><asp:Label runat="server" ID="lblActivityTotal" Text="0" ></asp:Label></td>
                                                          <td align="Center"><asp:Label runat="server" ID="lblTicketTotal" Text="0" ></asp:Label></td> 
                                                          <td style="font-size:11px;font:Arial, Helvetica, sans-serif;font-weight:bold;">&nbsp;</td>
                                                   </tr>                                     
                                                   <tr id="trStores_NoRecord" runat="server" visible="false" style="background-color:#FFFFFF;"><td colspan="5" style="font-style:italic;text-align:center;height:20px;">No Stats to show!</td></tr>
                                                </table>
                                            </FooterTemplate>
                                         </asp:Repeater>                                          
                                    </td>
                                 </tr>
                                </table>
                                </ContentTemplate> 
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddlClient" EventName="SelectedIndexChanged" />                        
                                </Triggers>             
                          </asp:UpdatePanel>  
                        </td>--%>
                    </tr>
              </table>            
            </td>
            <td valign="top" style="padding-left:3px; width:35%;">
             <asp:UpdatePanel ID="UpdatePanel6" runat="server" UpdateMode="Conditional" RenderMode="Inline">
              <ContentTemplate>
                <table  border="0" cellspacing="0" cellpadding="0"  style="width:100%;height:100%;border:1px solid #79A0D3;background-color:#D9EAFC; ">
                  <tr style="height:25px;" class="HeadingHome">
                     <td>
                      <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                          <ContentTemplate>
                             Stores&nbsp;|&nbsp; <asp:Label runat="server" ID="lblStores" Text="3" /> &nbsp;(with pending activities)
                          </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddlStates" EventName="SelectedIndexChanged" />
                                <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                     </td>
                     <td align="right">
                         <asp:LinkButton ID="lnkResetFilters" CausesValidation="false" runat="server" CssClass="HomeButton">
                            <div style="width:90px;" class="LeadDetailButton" onclick="javascript:resetFilters();" >Reset &nbsp; <img  src="images/blt_resetFilters.gif" align="absmiddle" width="10" height="10" /></div>
                         </asp:LinkButton>
                     </td>
                  </tr>
                  <tr>
                    <td colspan="2">
                        <table  border="0" cellspacing="0" cellpadding="0" style="font-family:Arial, Helvetica, sans-serif;font-size:11px;width:100%;height:100%;">
                            <tr style="height:35px;">
                                <td colspan="6">
                                  <table  border="0" cellspacing="0" cellpadding="0" style="font-family:Arial, Helvetica, sans-serif;font-size:11px;width:100%;height:100%;">
                                        <tr style="height:10px;">
                                          <td  style="background-color:#BADBFC;font-size:9px;padding-left:2px;padding-top:5px;">Search a Store :</td>
                                          <td  style="background-color:#BADBFC;font-size:9px;padding-left:2px;padding-top:5px;">State :</td>
                                        </tr>                                       
                                        <tr style="height:25px;">
                                            <td   style=" background-color:#BADBFC; width:65%;border-top:1px solid #88C4FA;border-bottom:1px solid #88C4FA;font-size:11px;padding-left:2px; height: 25px;">                                               
                                            <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
                                               <asp:TextBox runat="server" ID="txtSearch" CssClass="GreyTextBox" MaxLength="50" onfocus="javascript:this.value='';" />
                                               <asp:ImageButton ID="btnSearch" runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />                           
                                               </asp:Panel>
                                            </td>
                                            <td style="background-color:#BADBFC;  border-top:1px solid #88C4FA;border-bottom:1px solid #88C4FA;font-size:11px;font:Arial, Helvetica, sans-serif;padding-left:2px; height: 25px;">
                                               <asp:DropDownList runat="server" ID="ddlStates" 
                                                Width="100%"
                                                SkinID="SmallTextCombo"
                                                DataSourceID="sdsStates"
                                                DataTextField="Name"
                                                DataValueField="StateID"
                                                AutoPostBack="True" >                                                                                                                                               
                                               </asp:DropDownList> 
                                               <asp:SqlDataSource ID="sdsStates" runat="server"
                                                        ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                        SelectCommand="States_GetAll_ByFranchises"
                                                        SelectCommandType="StoredProcedure"
                                                        DataSourceMode="DataReader">
                                               </asp:SqlDataSource>                                            
                                          </td>
                                        </tr>
                                  </table>	    
                                </td>
                          </tr>
                          <tr style="width:100%; background-color:#FFFFFF;">
                                <td style="width:100%;background-color:#FFFFFF;" colspan="6">                                  
                                    <asp:UpdatePanel runat="server" ID="UPCurrentActivities" ChildrenAsTriggers="false"  UpdateMode="Conditional"  >                                       
                                        <ContentTemplate>                                        
                                            <asp:Repeater
                                                runat="server"
                                                ID="rptStores"
                                                DataSourceID="odsStores" >
                                                <HeaderTemplate>
                                                    <table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%;" class="HomeStores">
                                                        <tr>                                              
                                                            <th style="width:3%;">&nbsp;</th>              
                                                            <th style="width:15%;"><img  align="absmiddle" src="images/spacer.gif" />&nbsp;&nbsp;Store#</th>
                                                            <th style="width:35%;">&nbsp;&nbsp;Name</th>
                                                            <th style="width:17%;">Activities</th>
                                                            <th style="width:25%;">Last Updated&nbsp;</th>                                                            
                                                        </tr>
                                                        <tr>
                                                          <td colspan="5" >
                                                            <div id="Div1" style="overflow-y:auto;Height:100%;Width:100%;border:0px solid #FFFFFF;" class="ScrollBarHomeTicket">                                                             
                                                                <table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%; border:0;" class="HomeStores">
                                                 </HeaderTemplate>
                                                 <ItemTemplate>
                                                                <tr onclick="javascript:window.location='Com/Admin_main_com.aspx?FranchiseID=<%#Eval("ID")%>&ClientID=<%# Eval("ClientID") %>';" onmouseover="this.className='MouseOverRow';" onmouseout="this.className='MouseOutRow';"    >
                                                                    <td style="width:3%;">&nbsp;<img  align="absmiddle" src="images/arrows.gif" /></td>
                                                                    <td style="width:15%;">&nbsp;&nbsp;<%#Eval("StoreNumber")%></td>
                                                                    <td style="width:35%;" onmousemove="this.className='HighlightedLeftPanelRow';showToolTip(this,'<%# "<b>" & Eval("StoreName") & " - " & Eval("StoreNumber") & "</b> [ " & Eval("ClientName") & " ]" & "<br/><b>Status:</b> " & Functions.GetStoreStatus1(Eval("Status"),Eval("IsSuspended"),Eval("IsAbandon"))  & "<br/><b>Phone:</b> " & Eval("Phone") & "<br/><b>Corporate Name:</b> " & Replace(Eval("CorporateName"), "'", "\'")%>');" onmouseout="this.className='';hideToolTip();" >
                                                                    <%#Functions.StringTruncate(Eval("StoreName"), 20)%></td>
                                                                    <td style="width:12%;"><%#Eval("OpenActivities")%></td>
                                                                    <td style="width:25%;">&nbsp;&nbsp;&nbsp;<%#CType(IIf(IsDBNull(Eval("LastUpdated")) = True, Date.Now, Eval("LastUpdated")), Date).ToShortDateString()%></td>                                                                    
                                                                </tr>                                                        
                                                </ItemTemplate>
                                                                        <FooterTemplate>
                                                                            <tr id="trStores_NoRecord" runat="server">
                                                                                <td colspan="5" style="font-style: italic; text-align: center; height: 20px; border: 0;">No Store to show!</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="5" style="height: 100%; text-align: center;">
                                                                                    <%--<img src="../images/pixel_gray.JPG" height="1" width="100%" />--%></td>
                                                                            </tr>
                                                                            </table>
                                                        </div>
                                                    </td>
                                                  </tr>
                                                 </table>
                                                </FooterTemplate>
                                            </asp:Repeater>
                                            <asp:ObjectDataSource ID="odsStores" runat="server"                                                
                                                SelectMethod="GetStoreByActivities"
                                                TypeName="Portal.BLL.Activities">                                           
                                                <SelectParameters>                                                                                    
                                                    <asp:ControlParameter ControlID="ddlClient"  Name="ClientID" PropertyName="SelectedValue" Type="Int32" />
                                                    <asp:ControlParameter Name="StateID" Type="Int32" ControlID="ddlStates" PropertyName="SelectedValue" />                                                                                                                                                                        
                                                    <asp:ControlParameter Name="Search" Type="String" ControlID="txtSearch" PropertyName="Text" ConvertEmptyStringToNull="false" />
                                                </SelectParameters>
                                             </asp:ObjectDataSource> 
                                        </ContentTemplate>
                                        <Triggers>                                                                                    
                                            <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                                            <asp:AsyncPostBackTrigger ControlID="ddlStates" EventName="SelectedIndexChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                                            <asp:AsyncPostBackTrigger ControlID="ddlClient" EventName="SelectedIndexChanged" />     
                                        </Triggers>
                                    </asp:UpdatePanel>                                   
                                </td>
                            </tr>                            
                        </table>
                    </td>
                  </tr>
      </table>
             </ContentTemplate>   
                <Triggers>
                  <asp:AsyncPostBackTrigger ControlID="ddlClient" EventName="SelectedIndexChanged" />                              
                </Triggers>           
            </asp:UpdatePanel>  
            </td>            
            <td valign="top" style="padding-left:3px;width:40%; height:100%;" >
             <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                <ContentTemplate>
                 <table  border="0" cellspacing="0" cellpadding="0" bgcolor="D9EAFC" style="width:100%; height:100%;border:1px solid #79A0D3;">
                      <tr style="height:25px" class="HeadingHome">
                        <td  style="width:35%;">Tickets / Features &nbsp;|&nbsp;<asp:Label ID="lblTicketCount" runat="server" Text="0" ></asp:Label>&nbsp;</td>
                        <td  style="width:60%;" nowrap="nowrap" align="right">&nbsp;
                        <asp:Panel ID="pnlSearchPM" runat="server" DefaultButton="btnsearchPM" Visible="false">
                          <asp:TextBox runat="server" ID="txtsearchPM" CssClass="GreyTextBox" MaxLength="50" Width="100" onfocus="javascript:this.value='';" />
                          <asp:ImageButton ID="btnsearchPM" runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />                                                                             
                          </asp:Panel>
                          <asp:DropDownList runat="server" ID="ddlClient"
                            Width="100"
                            Enabled="true"
                            SkinID="SmallTextCombo"
                            DataSourceID="sdsClients" 
                            DataTextField="Name"
                            DataValueField="ID"
                            AutoPostBack="True" >
                          </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsClients" 
                              runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                              SelectCommand="Clients_GetByUserID" 
                              SelectCommandType="StoredProcedure"
                              DataSourceMode="DataReader">
                              <SelectParameters>
                                  <asp:SessionParameter DefaultValue="" Name="UserID" SessionField="AdminID" Type="Int32" />
                              </SelectParameters>
                          </asp:SqlDataSource>&nbsp;
                          &nbsp;
                        </td>
                      </tr>
                      <tr style="width:100%; height:100%;">
                        <td colspan="2" style="width:100%; height:100%;">
                                                        <table id="tblMyTickets" runat="server" style="width:100%; height:100%;" border="3" cellspacing="0" cellpadding="0" >
                                <tr>
                                    <td  style="width:100%; border-left:0px;border-right:0px;">                                                                            
                                         <asp:Repeater runat="server" ID="rptrTickets" DataSourceID="sdsTickets" EnableViewState="false">

                                            <HeaderTemplate>
                                                <table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%;" class="HomeTickets">
                                                    <tr>
                                                        <th style="height:20px;width:10%;">&nbsp;</th>
                                                        <th style="width:7%;">Ref #</th>
                                                        <th style="width:49%;">Subject</th>                                           
                                                        <th style="width:16%;">Due Date</th>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="4">                                                     
                                                            <div id="NewsDiv" style="overflow-y:auto;Height:100%;Width:100%;border:0px solid #FFFFFF;" class="ScrollBarHomeTicket">
                                                                <table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%; font-size:11px;">                                                                                                              
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                                <tr  style='<%# IIF(Functions.IfNull(Eval("Read"), False) = True  ,"background-color:#FFFFFF;","background-color:#FFFF00;") %>' onclick="javascript:window.location='PM/PMMain.aspx?Page=TicketsDetail.aspx?ReleaseID=<%# Eval("ReleaseID") %>&ID=<%# Eval("ID") %>&PrevPage=1&ClientID=<%# IIF(ddlClient.SelectedValue = "" ,ddlClient.Items(0).Value ,ddlClient.SelectedValue) %>';" onmouseover="this.className='MouseOverRow';" onmouseout="this.className='MouseOutRow';"   >
                                                                    <td style="height:20px;width:10%;">
                                                                    <img src='<%= ConfigurationManager.AppSettings("ImagesURL") %><%#Eval("Priority") %>' alt="priority"  />&nbsp;
                                                                    <img id="imgflagDueDate" runat="server" src='images/flag_orange.gif' title='Due date is near' visible='<%# Eval("ShowDueDateFlag") %>' />
                                                                    <img id="Img1" src="images/flag_red.gif" runat="server" title='Delayed' visible='<%#  IIf(Eval("DueDate") < DateTime.Now.Date AndAlso (Functions.IFNull(Eval("Status"), "")  <> "Completed" ANDAlso Functions.IFNull(Eval("Status"), "")  <> "Confirm Solved" ), "True", "False") %>'/>
                                                                    </td>
                                                                    <td style="font-weight:bold;width:7%;"><%#Eval("RefNo")%></td>
                                                                    <td style="width:49%;"><span title='<%#Eval("Name")%>'><%#Functions.StringTruncate(Functions.IfNull(Eval("Name"), ""), 30)%> </span><br />
                                                                    <span style="font-style:italic;color:#7C8798;" >
                                                                       <%#Eval("Status") %> 
                                                                    </span>                                                                       
                                                                     </td>                                           
                                                                    <td style="width:16%;"><%#CType(Eval("DueDate"), DateTime).ToShortDateString()%>&nbsp;</td>
                                                                </tr>                                                    
                                            </ItemTemplate>
                                                                <FooterTemplate>
                                                                    <tr id="trTickets_NoRecord" runat="server" style="background-color: #FFFFFF;">
                                                                        <td colspan="4" style="font-style: italic; text-align: center; height: 20px; border: 0;">No Tickets / Features to show!</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="4" style="height: 100%; text-align: center; background-color: #FFFFFF;">
                                                                            </td>
                                                                    </tr>
                                                                    </table>
                                                            </div>
                                                          </td>
                                                        </tr> 
                                                     </table>                                            
                                            </FooterTemplate>                                            
                                        </asp:Repeater>
                                        <asp:SqlDataSource ID="sdsTickets" runat="server" SelectCommandType="StoredProcedure"  
                                                           SelectCommand="PM_Ticket_Features_GetForHome" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>" 
                                                           DataSourceMode="DataReader">
                                            <SelectParameters>                                    
                                                <asp:ControlParameter ControlID="ddlClient"  Name="ClientID" PropertyName="SelectedValue" Type="Int32" />
                                                <asp:SessionParameter Name="UserID" SessionField="AdminId" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>                                         
                                    </td>
                                </tr>
                                <tr style="height: 25px;display:none;" class="HeadingHome" id="trViewMore" runat="server">
                                    <td align="right">
                                        <a href="PM/PMMain.aspx?Page=MyTickets.aspx">view more</a>&nbsp;
                                    </td>
                                </tr>
                              </table>
                        </td>
                      </tr>
                                        <%--<tr id="TR_News" runat="server">
                         <td colspan="3">                   
                    	        <table style="width:100%;height:160px;" runat="server" id="Table1" border="0" cellspacing="0" cellpadding="0">
                        	        <tr style="height:25px;" class="HeadingHome">
                            	        <td >News&nbsp;</td>
                                        <td >&nbsp;</td>                                     
                        	        </tr>
                                    <tr>
                                    <td colspan="2" >                                                                    
                                         <asp:Repeater
                                            runat="server"
                                            ID="rptrNews"
                                            DataSourceID="sdsNews" >
                                            <HeaderTemplate>
                                                <table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%;">                                                                                                          
                                                    <tr>
                                                        <td colspan="4">                                                     
                                                            <div id="NewsDiv" style="overflow-y:auto;Height:100%;Width:100%;border:0px solid #FFFFFF;" class="ScrollBarHomeTicket">
                                                                <table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%;">                                                                                                              
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                                <tr style="background-color:#FFFFFF;"   onclick="javascript:showContact('<%#Eval("ID")%>'); " onmouseover="this.className='MouseOverRow';" onmouseout="this.className='MouseOutRow';"   >
                                                                    <td style="height:20px;width:3%;" class="RecordTableGridRow">
                                                                    <img src="images/ico_news_small.gif" width="20" height="21" alt="news" />
                                                                    </td>
                                                                    <td class="RecordTableGridRow" style="font-weight:bold;width:2%;"></td>
                                                                    <td class="RecordTableGridRow" style="width:57%;"><span title='<%#Eval("HeadLine").Replace("'","&rsquo;")%>'><%#Functions.StringTruncate(Functions.IfNull(Eval("HeadLine"), ""), 45)%> </span>                                                      
                                                                     </td>                                           
                                                                    <td class="RecordTableGridRow" style="width:16%;"><%#CType(Eval("Date"), DateTime).ToShortDateString()%>&nbsp;</td>
                                                                </tr>                                                    
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                                 <tr id="trTickets_NoRecord" runat="server"  style="background-color:#FFFFFF;"><td colspan="4" style="font-style:italic;text-align:center;height:20px;font-size:11px;">No news to show!</td></tr>
                                                                <tr><td colspan="4" style="height:100%;text-align:center;background-color:#FFFFFF;"><img  src="../images/pixel_gray.JPG" height="1" width="100%" /></td></tr>
                                                                
                                                            </table>
                                                          </div>
                                                         </td>
                                                        </tr> 
                                                     </table>                                            
                                            </FooterTemplate>
                                        </asp:Repeater>
                                         <asp:ObjectDataSource ID="sdsNews" runat="server"
                                            SelectMethod="NewsGetByUserIDForHome"
                                            TypeName="Portal.BLL.News.News">
                                    </asp:ObjectDataSource>
                                    
                                    <table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%; font-size:11px;" runat="server" id="tblForRptNoNews" visible="false">
                                        <tr id="tr1" runat="server"  style="background-color:#FFFFFF;"><td colspan="4" style="font-style:italic;text-align:center;height:20px;">No news to show!</td></tr>
                                        <tr><td colspan="4" style="height:1px;text-align:center;background-color:#FFFFFF;"><img  src="../images/pixel_gray.JPG" height="1" width="100%" /></td></tr>
                                        <tr><td colspan="4" style="height:100%;text-align:center;background-color:#FFFFFF;"><img  src="../images/pixel_gray.JPG" height="1" width="100%" /></td></tr>
                                                                <tr>
                                                                    <td colspan="4" style="height: 100%; text-align: center; background-color: #FFFFFF;">
                                                                        <img src="../images/pixel_gray.JPG" height="1" width="100%" /></td>
                                                                </tr>
                                                            </table>

                                    </td>
                                 </tr>                                
                                </table>                                 
                         </td>
                      </tr>--%>
                </table> 
         </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddlClient" EventName="SelectedIndexChanged" />                                
            </Triggers>
         </asp:UpdatePanel>   
    </td>
  </tr>
</table>
    </td>
 </tr>
</table>
<div id="DivOption" runat="server"  style="display:none;border:solid 1px #000000; position:absolute; width:100%;  height:100%;top:0%; left:0%; z-index:1;"    >
          <table style="height:100%;" cellpadding="0" border="0" cellspacing="0"   >
           <tr>    
              <td align="left" style="border-bottom:solid 1px #000000;padding-top:4px; padding-left:1em;vertical-align:middle; background-image:url(images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
                  <label id="Label1" title="Notes"    style="color:White;height:100%; overflow:auto; font-weight:bold;"  >News Detail</label>
              </td>
              <td  style="border-bottom:solid 1px #000000;background-image:url(images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%; height:28px; cursor:pointer;">
                  <img src="images/win_btn_close_black.jpg" style="float:right;" alt="Close Window" onclick="DivOptionHide();" />
              </td>               
           </tr>
           <tr valign="top">                
             <td colspan="2" style="height:100%; padding:0px; font-size:12px; background-color:White;" >
             <iframe name="IfContactProfile" runat="server" id="IfContactProfile" src="Com/Blank.aspx" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>            
             </td>
           </tr>            
          </table>
        </div>
 <script type="text/javascript" language="javascript" src="scripts/functions.js"></script>
<script type="text/javascript" language="javascript">
    function resetFilters(){
    
        var item;       
        if (item = document.getElementById('<%= txtSearch.ClientID %>')){
            item.value = '';
        }
        if (item = document.getElementById('<%= ddlStates.ClientID %>')){
            item.value = 0;
        }       
    }
    
    function changeClass(element, className)
        {
	        element.className = className;
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
          $get('<%= txtSearch.ClientID %>').value='';
            if (updatedPanels[i].id == '<%= UPCurrentActivities.ClientID %>')
            {
           
                
            }
        }
    } 
    function DisableDropDown()
    {   
        setWindowedControlsVisibility(window, 'hidden');       
        return true;
    }
    
    function EnableDropDown()
    {              
       document.getElementById('<%= ddlActivitiesSource.ClientID %>').style.visibility = 'visible'
    }
    
      //  Contatc Display 
        
  
   function showContact(NewsID)
        {
            var DivOption = getElement('<%= DivOption.ClientID %>');
            var ddlClient = getElement('<%= ddlClient.ClientID %>');
            divDisable.style.width = document.body.scrollWidth
            divDisable.style.height = document.body.scrollHeight-110
            DivOption.style.display= "inline";
            ddlClient.style.display= "none";
            IfContactProfile.location = "News/NewsDetail.aspx?NewsID=" + NewsID;
        
        }
        
   function DivOptionHide()
        {
            var DivOption = getElement('<%= DivOption.ClientID %>')
            var ddlClient = getElement('<%= ddlClient.ClientID %>')
            divDisable.style.width = 0;
            divDisable.style.height = 0;
            DivOption.style.display= "none"; 
            ddlClient.style.display= "inline";
            IfContactProfile.location = "Com/Blank.aspx"         
            return false;            
        }

    function hideToolTip() {
        //var obj = document.getElementById("divToolTip");
        //obj.style.display = "none";
    }
    function showToolTip(obj, msg) {
        //var obj = document.getElementById("divToolTip");
        //obj.innerHTML = msg;
        //obj.style.left = event.x - 5;
        //obj.style.top = event.y - 50;
        //obj.style.display = 'inline';
    }

    </script>
</asp:Content>