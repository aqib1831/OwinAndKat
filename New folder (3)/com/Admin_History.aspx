<%@ Page Language="VB" AutoEventWireup="false" ValidateRequest="false" CodeFile="Admin_History.aspx.vb" Inherits="com_admin_History" Theme="Default" %> 
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Actvities History</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>   
</head>
<body style ="margin:0px;background-color:#E4F1F7;">
    <form id="form1" runat="server">
    <div id="divToolTip" onMouseOver="this.style.display='none'"  
style="border:1px solid black;display:none;position:absolute;z-index:50000;color:#676860;font-size:10px; padding:5px; padding-left:5px;background:#F0F0F0;
                                  filter:
                                  progid:DXImageTransform.Microsoft.dropshadow(OffX=4, OffY=4, Color='gray', Positive='true')
                                  progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#FFFFFF,endColorStr=#BEDAFF)
                                  progid:DXImageTransform.Microsoft.Wheel(duration=3);">
    </div>
    <div>
     <asp:HiddenField ID="hdnClientID" runat="server"/>
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
    <table width="100%" style="height:100%; margin:0px; padding:0px;background-color:#E4F1F7;width:100%;" cellspacing="0" cellpadding="0" border="0">
             <tr>
                 <td  style="height:20px;background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:5px;border-bottom:1px solid #609BD3;width:650px;">
                     <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                       <ContentTemplate>
                       Closed Actvities &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label runat="server" ID="lblActivityCount" Text="0" />
                            &nbsp;<span class="NonBold">(<asp:Label runat="server" ID="lblFilter" Text="all" />)</span>
                        <asp:HiddenField ID="hdnAdminID" runat="server" Value="0" />
                        </ContentTemplate>
                            <Triggers >                                  
                                 <asp:AsyncPostBackTrigger ControlID="ddlFranchises" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                              
                                  <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                                  <asp:AsyncPostBackTrigger ControlID="btnDateSearch" EventName="Click" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlType" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlSubType" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlClient" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlAssignedByNames" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlCompletedBy" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlRelatedTo" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlPriority" EventName="SelectedIndexChanged" />
                            </Triggers>
                    </asp:UpdatePanel>
                </td>
                 <td style="background-color:#A0CDEE;border-bottom:1px solid #609BD3;text-align:right;">
                     <table  border="0" cellpadding="0" cellspacing="0" style="height:100%;padding:3px;border-bottom:0px;" >
                        <tr>
                            <td>
                                <span style="font-size:7pt;color:#7c8798">Client:</span><br />
                                <asp:DropDownList runat="server" ID="ddlClient"
                                    Width="150px"
                                    Enabled="true"
                                    SkinID="SmallTextCombo"
                                    DataSourceID="sdsClients" 
                                    DataTextField="Name"
                                    DataValueField="ID"
                                    AutoPostBack="True" >
                                  </asp:DropDownList>
                                  <asp:SqlDataSource ID="sdsClients" 
                                      runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                      SelectCommand="Clients_GetByUserIDForCom_BySubModuleID" 
                                      SelectCommandType="StoredProcedure"
                                      DataSourceMode="DataReader">
                                      <SelectParameters>
                                          <asp:SessionParameter DefaultValue="" Name="UserID" SessionField="AdminID" Type="Int32" />
                                           <asp:ControlParameter ControlID="hdnSubModuleID" Name="SubModuleID"  PropertyName="Value" Type="String" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                            </td>
                            <td style="width:10px;text-align:center;">
                               <img  src="../images/pixel_skyBlue.jpg" width="1" height="30" align="absmiddle" />                                
                            </td>  
                            <td>
                            <span style="font-size:7pt;color:#7c8798">Related To:</span><br />
                         <asp:UpdatePanel ID="upRelatedToList" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:DropDownList ID="ddlRelatedTo"  
                                        SkinID="SmallTextCombo" runat="server" 
                                        AutoPostBack="True" Width="150px"
                                        DataSourceID="SDS_Products" DataTextField="Title" DataValueField="ID">                                
                                    </asp:DropDownList>&nbsp;
                                    <asp:SqlDataSource ID="SDS_Products" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                          SelectCommand="NS_Products_GetAllForModules_ByClientID" SelectCommandType="StoredProcedure">
                                          <SelectParameters>
                                             
                                               <asp:ControlParameter ControlID="ddlClient" Name="ClientID" PropertyName="SelectedValue" Type="Int32" />                                          
                                          </SelectParameters>
                                    </asp:SqlDataSource>
                                 </ContentTemplate>
                              <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddlClient" EventName="SelectedIndexChanged" />
                              </Triggers>
                              </asp:UpdatePanel> </td>
                             <td style="width:10px;text-align:center;">
                               <img  src="../images/pixel_skyBlue.jpg" width="1" height="30" align="absmiddle" />                                
                            </td> 
                            <td>
                                <span style="font-size:7pt;color:#7c8798">Initiated By:</span><br />
                                <asp:DropDownList 
                                  ID="ddlAssignedByNames" 
                                  runat="server" 
                                  SkinID="SmallTextCombo"                           
                                  DataSourceID="SDS_AssignedBy" 
                                  DataTextField="UserName"
                                  DataValueField="ID"
                                  AutoPostBack="True" Width="110px">
                                </asp:DropDownList>&nbsp;
                                <asp:SqlDataSource ID="SDS_AssignedBy" runat="server" 
                                  ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>" 
                                  SelectCommand="Com_User_GetAll" 
                                  SelectCommandType="StoredProcedure"
                                  DataSourceMode="DataReader">
                                </asp:SqlDataSource>
                            </td>
                            <td style="width:10px;text-align:center;">
                               <img  src="../images/pixel_skyBlue.jpg" width="1" height="30" align="absmiddle" />                                
                            </td>  
                           <td>
                                <span style="font-size:7pt;color:#7c8798">Completed By:</span><br />
                                <asp:DropDownList 
                                  ID="ddlCompletedBy" 
                                  runat="server" 
                                  SkinID="SmallTextCombo"                           
                                  DataSourceID="SDS_AssignedBy" 
                                  DataTextField="UserName"
                                  DataValueField="ID"
                                  AutoPostBack="True" Width="110px">
                                </asp:DropDownList>&nbsp;
                            </td>
                            <td style="width:10px;text-align:center;">
                               <img  src="../images/pixel_skyBlue.jpg" width="1" height="30" align="absmiddle" />                                
                            </td>  
                           <td>
                            <span style="font-size: 7pt; color: #7c8798">Priority:</span><br />
                                <asp:DropDownList ID="ddlPriority" 
                                    runat="server"                                 
                                    AutoPostBack="true"                                                                                                            
                                    CssClass="SmallGreenTextBox" 
                                    Width="100px" >
                                    <asp:ListItem Text="Select..." Value="0" Selected="True" ></asp:ListItem>
                                    <asp:ListItem Text="Low" Value="1" />
                                    <asp:ListItem Text="Minimal" Value="2"/>
                                    <asp:ListItem Text="Moderate" Value="3" />
                                    <asp:ListItem Text="High" Value="4" />
                                    <asp:ListItem Text="Critical" Value="5" />
                                 </asp:DropDownList>
                           </td>
                            <td style="width:10px;text-align:center;">
                               <img  src="../images/pixel_skyBlue.jpg" width="1" height="30" align="absmiddle" />                                
                            </td>  
                            <td>
                                <asp:LinkButton ID="lnkResetFilters" runat="server" CssClass="HomeButton">
                                    <div style="width:110px;" class="LeadDetailButton" onClick="javascript:resetFilters();">
                                     Reset Filters 
                                    <img  src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10" style="border:0px;"/>
                                    </div>
                                </asp:LinkButton>
                            </td>
                        </tr>
                     </table>
                 </td>                        
             </tr>              
             <tr>
                <td colspan="2" style="height:40px;background-color:#BADCFC;font-size:11px;">
                  <table border="0" cellpadding="0" cellspacing="0" style="white-space:nowrap;">                   
                    <tr>
                       <td style="padding:3px; white-space:nowrap;width:125px;">
                          <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" >
                               <span class="GreyTextSmall">Search</span><br />
                                <span><asp:TextBox ID="txtSearch" runat="server" onfocus="javascript:this.value='';" MaxLength="50"   Width="100px"  SkinID="GreenSmallTextbox" />
                                <asp:ImageButton ID="btnSearch"  runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />
                                </span></asp:Panel>
                        </td>
                        <td  style="width:10px;text-align:center;">
                            <img alt="" src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                        </td>
                        <td style="width:140px;">
                            <span style="font-size: 7pt; color: #7c8798">Franchises</span><br />
                            <asp:UpdatePanel ID="upFranchisesList" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:DropDownList ID="ddlFranchises"  
                                        SkinID="SmallTextCombo" runat="server" 
                                        AutoPostBack="True" Width="140px"
                                        DataSourceID="sdsFranchisesList" DataTextField="StoreNick" DataValueField="FranchiseID">                                
                                    </asp:DropDownList>&nbsp;
                                    <asp:SqlDataSource ID="sdsFranchisesList" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                          SelectCommand="Activities_GetOpenActivities_StoreList_ByClientIDList" SelectCommandType="StoredProcedure">
                                          <SelectParameters>
                                               <asp:Parameter  Name="Status" DefaultValue="True" Type="Boolean" />
                                               <asp:ControlParameter ControlID="ddlClient" Name="ClientID" PropertyName="SelectedValue" Type="Int32" />                                          
                                               <asp:ControlParameter ControlID="hdnClientIDList" Name="ClientIDList"  PropertyName="Value" Type="String" />                                      
                                          </SelectParameters>
                                    </asp:SqlDataSource>
                                 </ContentTemplate>
                              <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddlClient" EventName="SelectedIndexChanged" />
                              </Triggers>
                              </asp:UpdatePanel>
                          </td>    
                          <td style="width:10px;text-align:center;">
                               <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" /> 
                          </td>               
                        <td style="width:100px;">
                            <span class="GreyTextSmall">Type</span><br />
                            <asp:DropDownList runat="server" ID="ddlType" SkinID="SmallTextCombo" AutoPostBack="true" Width="100px">
                                <asp:ListItem Text="Show All" Value="0" />
                                <asp:ListItem Text="HelpDesk" Value="1" />
                                <asp:ListItem Text="Message" Value="2" />
                                <asp:ListItem Text="Call" Value="3" />
                                <asp:ListItem Text="Email" Value="4" />
                                <asp:ListItem Text="Fax" Value="5" />
                                <asp:ListItem Text="Meeting" Value="6" />
                                <asp:ListItem Text="Letter" Value="7" />
                                <asp:ListItem Text="Other" Value="8" />                               
                                <asp:ListItem Text="EdibleIdea" Value="11" />
                                <asp:ListItem Text="Discussion" Value="12" />
                                <asp:ListItem Text="ProfileUpdate" Value="13" />
                                <asp:ListItem Text="StoreUpdate" Value="14" />
                                <asp:ListItem Text="CoordinatorChange" Value="15" />
                                <asp:ListItem Text="Finance" Value="16" />
                                <asp:ListItem Text="AdditionalArea" Value="17" />
                            </asp:DropDownList>
                        </td>
                        <td style="width:10px;text-align:center;">
                            <img alt="" src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                        </td>
                        <td style="width:100px;">
                            <span class="GreyTextSmall">SubType</span><br />
                            <asp:DropDownList runat="server" ID="ddlSubType" SkinID="SmallTextCombo" AutoPostBack="true" Width="100px">
                                <asp:ListItem Text="Show All" Value="0" />
                                <asp:ListItem Text="General" Value="1" />
                                <asp:ListItem Text="Notice" Value="2" />
                                <asp:ListItem Text="Complaint" Value="3" />
                                <asp:ListItem Text="Compliment" Value="4" />
                                <asp:ListItem Text="Violation" Value="5" />
                                <asp:ListItem Text="Weeklycall" Value="6" />
                                <asp:ListItem Text="Leftmessage" Value="7" />
                                <asp:ListItem Text="SalesReport" Value="8" />
                            </asp:DropDownList>
                        </td>
                        <td style="width:10px;text-align:center;">
                            <img alt="" src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                        </td>
                        <td style="width:110px;">
                            <span class="GreyTextSmall">From Date</span><br />
                            <asp:TextBox runat="server" ID="txtDateFrom" CssClass="GreyTextBox" Width="70px" onfocus="this.blur();" />                           
                             <img id="imgDDCalander" align="absMiddle"
                                 border="0"
                                 onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtDateFrom.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                 onmouseover="style.cursor='hand';"
                                 src="../images/ico_calendar.jpg" alt="" />
                        </td>
                        <td style="width:140px;">
                            <span class="GreyTextSmall">To Date</span><br />
                            <asp:TextBox runat="server" ID="txtDateTo" CssClass="GreyTextBox" Width="70px" onfocus="this.blur();" />
                            <img id="img1" align="absMiddle"
                                 border="0"
                                 onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtDateTo.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                 onmouseover="style.cursor='hand';"
                                 src="../images/ico_calendar.jpg" alt="" />
                            &nbsp;<asp:ImageButton ID="btnDateSearch" runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />
                        </td>
                        <td style="width:10px;text-align:center;">
                            <img alt="" src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                        </td>

                        <td style="text-align:left;width:29%;padding-left:7px;padding-top:7px;border:0px solid Red;padding-bottom:0px !important;">
                                <%--<span class="GreyTextSmall">&nbsp;</span><br />--%>
                                <asp:LinkButton ID="lbtnExportToExcel" runat="server" CssClass="HomeButton">
                                    <div style="width:110px;" class="LeadDetailButton" >
                                        Export To Excel
                                    </div>
                                </asp:LinkButton>
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
                         <asp:HiddenField ID="hdnPageIndex" runat="server" Value="0" />                         
                         <asp:HiddenField ID="hdnSearch" runat="server" Value="" />
                         <asp:HiddenField ID="hdnSubModuleID" runat="server" Value="" />
                         <asp:HiddenField ID="hdnClientIDList" runat="server" Value="" />
                        <asp:GridView 
                            ID="gvInbox" 
                            runat="server" 
                            AutoGenerateColumns="False" 
                            EnableTheming="True" 
                            EnableViewState="false"
                            SkinID="GridViewNormal"                         
                            AllowSorting="True"                             
                            DataSourceID="sdsInbox" >
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
                                    <asp:TemplateField ItemStyle-Width="4%" HeaderText="" >
                                    <ItemTemplate  >
                                         <img title='<%# Functions.getActivityCaption(Eval("Activity_Type"))%>' src='<%= ConfigurationManager.AppSettings("ImagesURL") %><%# Functions.GetActivityImage(Eval("Activity_Type")) %>'  />&nbsp;                                         
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="8%" HeaderText="Ticket #"  SortExpression="Ticket" ItemStyle-Wrap="false">
                                    <ItemTemplate >
                                        <%# Functions.GetActivityPrefix(Eval("Activity_Type")) &  Eval("Activity_ID")%>
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="15%" HeaderText="Store #" SortExpression="StoreNumber">
                                            <ItemTemplate >
                                                <span title='<%# Eval("StoreNick") & " - " & Eval("StoreNumber")%>'><%#Functions.StringTruncate(Eval("StoreNick") & " - " & Eval("StoreNumber"),30)%></span>
                                            </ItemTemplate>
                                    </asp:TemplateField> 
                                     <%--<asp:TemplateField ItemStyle-Width="15%" HeaderText="Franchise" SortExpression="Franchise" Visible="false" >
                                    <ItemTemplate >
                                        <asp:Label runat="server" ID="lblFranchise" Text='<%# Eval("StoreNick")%>' ></asp:Label>                                        
                                    </ItemTemplate>
                                    </asp:TemplateField> --%>
                                    <asp:TemplateField HeaderText="Client" ItemStyle-Width="5%" SortExpression="Client" >
                                        <ItemTemplate >
                                            <%# Eval("ClientCode")%>
                                        </ItemTemplate>
                                    </asp:TemplateField>                                    
                                     <asp:TemplateField ItemStyle-Width="25%" HeaderText="Subject" SortExpression="Subject" >
                                        <ItemTemplate >
                                            <%# Functions.StringTruncate(Functions.IfNull(Eval("Subject"), ""), 50) %>
                                        </ItemTemplate>
                                    </asp:TemplateField>                                     
                                    <asp:TemplateField ItemStyle-Width="14%" HeaderText="Status"  SortExpression="Status">
                                        <ItemTemplate >
                                          <%# Eval("ActivityStateText").Replace("Waiting For","WF") & IIf(Eval("ActivityState") = 4, ":" & Functions.StringTruncate(Functions.IfNull(Eval("WaitingForName"), ""), 13), "") %>
                                        </ItemTemplate>
                                    </asp:TemplateField> 
                                    <asp:TemplateField ItemStyle-Width="13%" HeaderText="Created" SortExpression="Date">
                                        <ItemTemplate >
                                            <%# Functions.DateDiffInWords(Eval("Activity_Date"))%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Completed" ItemStyle-Width="14%" SortExpression="LastUpdatedOn" Visible="true" HeaderStyle-Wrap="false" >
                                        <ItemTemplate >
                                            <%# Functions.DateDiffInWords(Eval("LastUpdatedOn"))%>
                                        </ItemTemplate>
                                    </asp:TemplateField>                                                                             
                                </Columns>
                            </asp:GridView>
                             </ContentTemplate>
                                  <Triggers >                                  
                                  <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                              
                                  <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                                  <asp:AsyncPostBackTrigger ControlID="btnDateSearch" EventName="Click" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlType" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlSubType" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlClient" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlAssignedByNames" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlCompletedBy" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlRelatedTo" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlPriority" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlFranchises" EventName="SelectedIndexChanged" />
                                  </Triggers>
                            </asp:UpdatePanel>   
       
                            <asp:ObjectDataSource ID="sdsInbox" runat="server" 
                                    SelectMethod="GetAdminHistoryForHelpDesk"
                                    TypeName="Portal.BLL.Activities"                                    
                                    SelectCountMethod="GetAdminHistoryCountForHelpDesk" 
                                    EnablePaging="true"
                                    SortParameterName="sortExpression" >                                    
                                <SelectParameters>      
                                  <asp:ControlParameter  Name="FranchiseID" Type="Int32" ControlID="ddlFranchises" PropertyName="SelectedValue" DefaultValue="0" />                                                       
                                  <asp:ControlParameter  Name="ClientID" Type="String"  ControlID="ddlClient" PropertyName="SelectedValue" DefaultValue="1" />
                                  <asp:Parameter  Name="Filter" Type="String"  DefaultValue="" />
                                  <asp:ControlParameter  Name="Search" Type="String" ControlID="txtSearch" PropertyName="Text" DefaultValue=""  />                                 
                                  <asp:ControlParameter Name="Type" Type="Int32" ControlID="ddlType" PropertyName="SelectedValue" />
                                  <asp:ControlParameter Name="SubType" Type="Int32" ControlID="ddlSubType" PropertyName="SelectedValue" />
                                  <asp:ControlParameter Name="DateFrom" Type="DateTime" ControlID="txtDateFrom" PropertyName="Text" ConvertEmptyStringToNull="true" DefaultValue="1/1/2000" />
                                  <asp:ControlParameter Name="DateTo" Type="DateTime" ControlID="txtDateTo" PropertyName="Text" ConvertEmptyStringToNull="true" DefaultValue="1/1/2099" />
                                  <asp:ControlParameter  Name="AssingedBy" Type="String"  ControlID="ddlAssignedByNames" PropertyName="SelectedValue" DefaultValue="" />
                                  <asp:ControlParameter  Name="CompletedBy" Type="String"  ControlID="ddlCompletedBy" PropertyName="SelectedValue" DefaultValue="" />
                                  <asp:ControlParameter  Name="RelatedTo" Type="String"  ControlID="ddlRelatedTo" PropertyName="SelectedValue" DefaultValue="" />
                                  <asp:ControlParameter  Name="PriorityID" Type="Int32"  ControlID="ddlPriority" PropertyName="SelectedValue" DefaultValue="0" />
                                  <asp:Parameter  Name="ReturnValue" Type="Int32"  Direction="Output" />
                                </SelectParameters>
                           </asp:ObjectDataSource> 
                    </div>
                   
               </td>
             </tr> 
             <tr style="background-color:#BADCFC">
                <td align="left" colspan="2"  style="height:25px;">
                    <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
                        <tr>
                            <td id="CustomPagerRow" style="width:50%;" >&nbsp;</td>
                            <td class="GrayHeader" style="padding-left:4px;width:50%;">
                                <%--<span style="font-size:7pt; color: #ff0000">*</span>
                                Priority:&nbsp;
                                

                                <span style="background-color:#FFFFFF;width:12;border:outset 1px #FFFFFF;"></span>&nbsp;Low
					            <span style="background-color:#FFF200;width:12;border:outset 1px #FFF200;"></span>&nbsp;Minimal
					            <span style="background-color:#FF7F27;width:12;border:outset 1px #FF7F27;"></span>&nbsp;Moderate
					            <span style="background-color:#ED1C24;width:12;border:outset 1px #ED1C24;"></span>&nbsp;High
					            <span style="background-color:#880015;width:12;border:outset 1px #880015;"></span>&nbsp;Critical
                                <span style="background-color:#CB0104;width:12;border:outset 1px #CB0104;"></span>&nbsp;Delayed
								--%>

                           </td>
                        </tr>
                    </table>
                </td>
             </tr>
         </table>
    </div>
    </form>
    <script type="text/javascript" language="javascript">

    function OpenExportToExcel() {
        var FranchiseID = document.getElementById('<%= ddlFranchises.ClientID %>').value;
        var ClientID = document.getElementById('<%= ddlClient.ClientID %>').value;
            var Search = document.getElementById('<%= hdnSearch.ClientID %>').value;
        var Type = document.getElementById('<%= ddlType.ClientID %>').value;
        var SubType = document.getElementById('<%= ddlSubType.ClientID %>').value;
        var DateFrom = document.getElementById('<%= txtDateFrom.ClientID %>').value;
        var DateTo = document.getElementById('<%= txtDateTo.ClientID %>').value;
        var AssingedBy = document.getElementById('<%= ddlAssignedByNames.ClientID %>').value;
        var PriorityID = document.getElementById('<%= ddlPriority.ClientID %>').value;
            var CompletedBy = document.getElementById('<%= ddlCompletedBy.ClientID %>').value;
            var RelatedTo = document.getElementById('<%= ddlRelatedTo.ClientID %>').value;

            window.open('ExcelGeneration.ashx?FranchiseID=' + FranchiseID + '&CompletedBy=' + CompletedBy + '&RelatedTo=' + RelatedTo + '&ClientID=' + ClientID + '&Search=' + Search + '&Type=' + Type + '&SubType=' + SubType + '&DateFrom=' + DateFrom + '&DateTo=' + DateTo + '&AssingedBy=' + AssingedBy + '&PriorityID=' + PriorityID);
            return false;
        }

 function resetFilters()
    {  
        var item;
        if (item = document.getElementById('<%= txtSearch.ClientID %>')){
            item.value = '';}
        if (item = document.getElementById('<%= ddlFranchises.ClientID %>')){
            item.value = '0';}
        if (item = document.getElementById('<%= ddlAssignedByNames.ClientID %>')){
            item.value = '0';}
        if (item = document.getElementById('<%= ddlPriority.ClientID %>')){
            item.value = '0';} 
        if (item = document.getElementById('<%= ddlSubType.ClientID %>')){
            item.value = '0';} 
        if (item = document.getElementById('<%= ddlType.ClientID %>')){
            item.value = '0';}
       return true;
    }
    
        
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
                $get('<%= hdnSearch.ClientID %>').value = $get('<%= txtSearch.ClientID %>').value
                $get('<%= txtSearch.ClientID %>').value = '';                
            }
        }
    }
    function showToolTip(msg)
    {  
        var obj = document.getElementById("divToolTip");
        obj.innerHTML = msg;
        obj.style.left = event.x - (obj.offsetWidth/2);
        obj.style.top = event.y + 20;
        obj.style.display = 'inline';
    }
    function hideToolTip()
    {
        var obj = document.getElementById("divToolTip");
        obj.style.display = "none";
    }
    
    function RowClick(ID, ClientID, FranchiseID) 
    {        
        var AssignedByNamesID = document.getElementById('<%= ddlAssignedByNames.ClientID %>').value;
            var CompletedByNamesID = document.getElementById('<%= ddlCompletedBy.ClientID %>').value;
            var SubTypeID = document.getElementById('<%= ddlSubType.ClientID %>').value;
            var PriorityID = document.getElementById('<%= ddlPriority.ClientID %>').value;
            var TypeID = document.getElementById('<%= ddlType.ClientID %>').value;
            var ddlFranchises = document.getElementById('<%= ddlFranchises.ClientID %>').value;
            var FromDate = document.getElementById('<%= txtDateFrom.ClientID %>').value;
            var ToDate = document.getElementById('<%= txtDateTo.ClientID %>').value;
            var search = document.getElementById('<%= hdnSearch.ClientID %>').value;
            var PageIndex = document.getElementById('<%= hdnPageIndex.ClientID %>').value;
            var RelatedTo = document.getElementById('<%= ddlRelatedTo.ClientID %>').value;
            CID = document.getElementById('<%= ddlClient.ClientID %>').value;
            FID = document.getElementById('<%= ddlFranchises.ClientID %>').value;
            window.location = 'ActivityDetail.aspx?ID=' + ID + '&RelatedTo=' + RelatedTo + '&PrevPage=2&ClientID=' + ClientID + '&FranchiseID=' + FranchiseID + '&CompletedByNamesID=' + CompletedByNamesID + '&AssignedByNamesID=' + AssignedByNamesID + '&SubTypeID=' + SubTypeID + '&PriorityID=' + PriorityID + '&TypeID=' + TypeID + '&ddlFranchises=' + ddlFranchises + '&FromDate=' + FromDate + '&ToDate=' + ToDate + '&search=' + search + '&cid=' + CID + '&fid=' + FID + '&pageindex=' + PageIndex;
        return false;
    }
</script>
</body>
</html>