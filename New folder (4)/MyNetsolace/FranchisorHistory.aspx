<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FranchisorHistory.aspx.vb" Inherits="MyNetsolace_FranchisorHistory" Theme="Default" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Netsolace Portal - My Netsolace</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>   
</head>
<body style ="margin:0px;background-color:#E4F1F7;">
    <form id="form1" runat="server">
    <div>
    <asp:HiddenField ID="hdnClientID" runat="server" />
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
                 <td  style="height:20px;background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:5px;width:50%;">
                     <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                       <ContentTemplate>
                       Closed Tickets &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label runat="server" ID="lblActivityCount" />
                            &nbsp;<span class="NonBold">(<asp:Label runat="server" ID="lblFilter" Text="all" />)</span>
                        <asp:HiddenField ID="hdnAdminID" runat="server" Value="0" />
                        </ContentTemplate>
                            <Triggers >
                                <asp:AsyncPostBackTrigger ControlID="ddlFranchises" EventName="SelectedIndexChanged" />
                                <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                              
                                <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDateSearch" EventName="Click" />                                  
                            </Triggers>
                    </asp:UpdatePanel>
                </td>
                 <td style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;text-align:right;height: 1px;">
                     <img align="absMiddle"  height="20" src="../images/pixel_skyBlue.jpg" width="1" /><img align="absMiddle"  height="20" src="../images/pixel_skyBlue.JPG" width="1" />                     
                     <asp:LinkButton ID="lnkResetFilters" runat="server" CssClass="HomeButton">
                                <div style="width:110px;" class="LeadDetailButton" onclick="javascript:resetFilters();">
                                Reset Filters 
                                <img  src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10" style="border:0px;"/>
                                </div>
                     </asp:LinkButton>                    
                     <img  align="absmiddle" src="../images/pixel_skyBlue.jpg" width="1" height="20" />
                    
                 </td>                        
             </tr>              
             <tr>
                <td colspan="2" style="height:40px;background-color:#BADCFC;font-size:11px;">
                  <table border="0" cellpadding="0" cellspacing="0" width="100%" style="white-space:nowrap;">                   
                    <tr>                       
                        <td align="left" style="padding-left:5px; padding-right:5px;width:0px;">
                            <span style="font-size: 7pt; color: #7c8798">Franchises</span><br />
                                <asp:DropDownList ID="ddlFranchises"  
                                        SkinID="SmallTextCombo" runat="server" 
                                        AutoPostBack="True" Width="120px"
                                        DataSourceID="sdsFranchisesList" DataTextField="StoreNick" DataValueField="FranchiseID">                                
                                    </asp:DropDownList>&nbsp;
                                    <asp:SqlDataSource ID="sdsFranchisesList" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                          SelectCommand="Activities_GetOpenActivities_StoreList" SelectCommandType="StoredProcedure">
                                          <SelectParameters>
                                               <asp:Parameter  Name="Status" DefaultValue="True" Type="Boolean" />
                                               <asp:ControlParameter ControlID="hdnClientID" Name="ClientID" PropertyName="Value" Type="Int32" />                                          
                                          </SelectParameters>
                                    </asp:SqlDataSource>                  
                         </td>  
                          <td style="width:0px;text-align:center;display:none;">
                            <img alt="" src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                        </td> 
                        <td style="padding:3px; white-space:nowrap;" align="left"   >
                          <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" >
                               <span class="GreyTextSmall">Search</span><br />
                                <span><asp:TextBox ID="txtSearch" runat="server" onfocus="javascript:this.value='';" MaxLength="50"   Width="100px"  SkinID="GreenSmallTextbox" />
                                <asp:ImageButton ID="btnSearch"  runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />
                                </span></asp:Panel>
                        </td>                       
                        <td  style="width:10px;text-align:center;">
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
                        <td style="width:35%;">
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
                                    <asp:TemplateField ItemStyle-Width="1%" HeaderText="" >
                                    <ItemTemplate  >
                                         <img src='<%= ConfigurationManager.AppSettings("ImagesURL") & "arrows.gif" %>'  />&nbsp;
                                         <asp:Label ID="lblID" runat="server" Visible="false" Text='<%#Eval("Activity_ID") %>' ></asp:Label>
                                         <asp:Label ID="lblFranchiseID" runat="server" Visible="false" Text='<%#Eval("FranchiseID") %>' ></asp:Label>
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="10%" HeaderText="Ticket #"  SortExpression="Ticket" >
                                    <ItemTemplate >
                                        <asp:Label runat="server" ID="lblTicketNumber" Text='<%# Functions.GetActivityPrefix(Eval("Activity_Type")) &  Eval("Activity_ID")%>' ></asp:Label>                                        
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField ItemStyle-Width="15%" HeaderText="Franchise" SortExpression="Franchise" >
                                    <ItemTemplate >
                                        <asp:Label runat="server" ID="lblFranchise" Text='<%# Eval("StoreNick")%>' ></asp:Label>                                        
                                    </ItemTemplate>
                                    </asp:TemplateField> 
                                     <%--<asp:TemplateField HeaderText="Type" ItemStyle-Width="10%" SortExpression="Type" >
                                        <ItemTemplate >
                                            <asp:Label runat="server" ID="lblType" Text='<%# Functions.getActivityCaption(Eval("Activity_Type"))%>' ></asp:Label>                                        
                                        </ItemTemplate>
                                    </asp:TemplateField>    --%>                                
                                     <asp:TemplateField ItemStyle-Width="25%" HeaderText="Subject" SortExpression="Subject" >
                                        <ItemTemplate >
                                         <span title='<%# Functions.IfNull(Eval("Subject"), "") %>' >
                                            <asp:Label runat="server" ID="lblSubject" Text='<%# Functions.StringTruncate(Functions.IfNull(Eval("Subject"), ""), 60) %>' ></asp:Label>                                        
                                         </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>                                     
                                    <asp:TemplateField ItemStyle-Width="15%" HeaderText="Status"  SortExpression="Status">
                                        <ItemTemplate >
                                          <span title='<%# Eval("ActivityStateText") & IIf(Eval("ActivityState") = 4, ":" & Functions.StringTruncate(Functions.IfNull(Eval("WaitingForName"), ""), 100), "") %>' >
                                            <asp:Label runat="server" ID="lblstatus" Text='<%# Functions.GetActivityStatus(Eval("ActivityState")).Replace("Waiting For","WF") & IIf(Eval("ActivityState") = 4, ":" & Functions.StringTruncate(Functions.IfNull(Eval("WaitingForName"), ""), 15), "") %>' ></asp:Label>                                        
                                          </span>
                                        </ItemTemplate>
                                    </asp:TemplateField> 
                                    <asp:TemplateField ItemStyle-Width="14%" HeaderText="Created" SortExpression="Date">
                                        <ItemTemplate >
                                            <asp:Label runat="server" ID="lblDate" Text='<%# Functions.DateDiffInWords(Eval("Activity_Date"))%>' ToolTip='<%#Eval("Activity_Date") %>' ></asp:Label>                                        
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Completed" ItemStyle-Width="14%" SortExpression="LastUpdatedMyNetsolace" Visible="true" HeaderStyle-Wrap="false" >
                                        <ItemTemplate >
                                            <asp:Label runat="server" ID="lblLastActivity" Text='<%# Functions.DateDiffInWords(Eval("LastUpdatedMyNetsolace"))%>' ToolTip='<%#Eval("LastUpdatedMyNetsolace") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>                                                                             
                                </Columns>
                            </asp:GridView>
                             </ContentTemplate>
                                  <Triggers >                                  
                                  <asp:AsyncPostBackTrigger ControlID="ddlFranchises" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                              
                                  <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                                  <asp:AsyncPostBackTrigger ControlID="btnDateSearch" EventName="Click" />                                  
                                  <asp:AsyncPostBackTrigger ControlID="hdnClientID" EventName="" />
                                  </Triggers>
                            </asp:UpdatePanel>   
       
                            <asp:ObjectDataSource ID="sdsInbox" runat="server" 
                                    SelectMethod="GetAdminHistoryForMyNetsolace"
                                    TypeName="Portal.BLL.Activities"                                    
                                    SelectCountMethod="GetAdminHistoryCountForMyNetsolace" 
                                    EnablePaging="true"
                                    SortParameterName="sortExpression" >                                    
                                <SelectParameters> 
                                  <asp:ControlParameter  Name="FranchiseID" Type="Int32" ControlID="ddlFranchises" PropertyName="SelectedValue" DefaultValue="0" />                                                            
                                  <asp:ControlParameter  Name="ClientID" Type="String"  ControlID="hdnClientID" PropertyName="Value" DefaultValue="1" />
                                  <asp:ControlParameter  Name="Search" Type="String" ControlID="txtSearch" PropertyName="Text" DefaultValue=""  />
                                  <asp:ControlParameter Name="DateFrom" Type="DateTime" ControlID="txtDateFrom" PropertyName="Text" ConvertEmptyStringToNull="true" DefaultValue="1/1/2000" />
                                  <asp:ControlParameter Name="DateTo" Type="DateTime" ControlID="txtDateTo" PropertyName="Text" ConvertEmptyStringToNull="true" DefaultValue="1/1/2099" />
                                  <asp:Parameter  Name="ReturnValue" Type="Int32"  Direction="Output" />
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
    </form>
    <script type="text/javascript" language="javascript">
 function resetFilters()
    {       
        var item;
        if (item = document.getElementById('<%= txtSearch.ClientID %>')){
            item.value = '';}
         if (item = document.getElementById('<%= ddlFranchises.ClientID %>')){
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
            }
        }
    }
    

</script>
</body>
</html>
