<%@ Page Language="VB" AutoEventWireup="false" ValidateRequest="false" CodeFile="Report_Survey.aspx.vb" Inherits="Com_Report_Survey" Theme="Default" %> 
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Survey Report</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script> 
</head>
<body style ="margin:0px;background-color:#E4F1F7;">
    <form id="form1" runat="server">
    <div>
    <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="300"  />
        <asp:UpdateProgress ID="Progress1" runat="server">
            <ProgressTemplate>
                <div class="ProgressIndicatorDIV">
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
                        Closed Actvities&nbsp;&nbsp;<asp:Label runat="server" ID="lblActivityCount" />
                            &nbsp;<span class="NonBold">(<asp:Label runat="server" ID="lblFilter" Text="all" />)</span>
                    
                    <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
                        </ContentTemplate>
                            <Triggers >                                                                    
                                  <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                                  
                                  <asp:AsyncPostBackTrigger ControlID="btnDateSearch" EventName="Click" />
                            </Triggers>
                    </asp:UpdatePanel>
                </td>
               <td style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right;cursor:pointer; height: 1px;border-bottom:1 solid #609BD3;  width:300px;">
                    <div style="width:110px;" class="LeadDetailButton" onclick="openPrint();" >
                        &nbsp;&nbsp; Print
                        <img  src="../images/blt_resetfilters.gif" align="absmiddle" width="10" height="10" style="border:0px;" alt="" />
                    </div>
                 </td>                         
             </tr>              
             <tr>
                <td colspan="2" style="height:40px;background-color:#BADCFC;font-size:11px;">
                  <table border="0" cellpadding="0" cellspacing="0" width="100%" style="white-space:nowrap;">
                     <tr>
                        <td style="width:10px;text-align:center;">
                            &nbsp;
                        </td>
                        <td style="width:100px;">
                            <span class="GreyTextSmall">From Date</span><br />
                            <asp:TextBox runat="server" ID="txtDateFrom" CssClass="GreyTextBox" Width="70px" onfocus="this.blur();" />
                             <img id="img1" align="absMiddle"
                                 border="0"
                                 onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtDateFrom.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                 onmouseover="style.cursor='hand';"
                                 src="../images/ico_calendar.jpg" alt="" />
                        </td>
                         <td style="width:10px;text-align:center;">
                            <img alt="" src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                        </td>
                        <td style="width:130px;">
                            <span class="GreyTextSmall">To Date</span><br />
                            <asp:TextBox runat="server" ID="txtDateTo" CssClass="GreyTextBox" Width="70px" onfocus="this.blur();" />
                             <img id="img2" align="absMiddle"
                                 border="0"
                                 onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtDateTo.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                 onmouseover="style.cursor='hand';"
                                 src="../images/ico_calendar.jpg" alt="" />
                            &nbsp;<asp:ImageButton ID="btnDateSearch" runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />
                        </td>
                         <td style="width:10px;text-align:center;">
                            <img alt="" src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                        </td>
                        <td style="width:100px;">
                            <span class="GreyTextSmall">Client</span><br />
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
                                  SelectCommand="Clients_GetByUserIDForCom" 
                                  SelectCommandType="StoredProcedure"
                                  DataSourceMode="DataReader">
                                  <SelectParameters>
                                      <asp:SessionParameter DefaultValue="" Name="UserID" SessionField="AdminID" Type="Int32" />
                                  </SelectParameters>
                              </asp:SqlDataSource>
                        </td>
                         <td style="width:10px;text-align:center;display:none;">
                            <img alt="" src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                        </td>
                        <td style="padding:3px; white-space:nowrap;display:none;" align="left"   >
                          <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" >
                               <span class="GreyTextSmall">Search</span><br />
                                <span><asp:TextBox ID="txtSearch" runat="server" onfocus="javascript:this.value='';" MaxLength="50"   Width="170px"  SkinID="GreenSmallTextbox" />
                                <asp:ImageButton ID="btnSearch"  runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />
                                </span>
                           </asp:Panel>
                        </td>
                        <td style="width:40%;"> &nbsp;
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
                            SkinID="GridViewNormal" 
                            EnableViewState="false"                        
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
                                    <asp:TemplateField ItemStyle-Width="3%" HeaderText="" >
                                    <ItemTemplate  >
                                         <img src='<%= ConfigurationManager.AppSettings("ImagesURL") %><%# Functions.GetActivityImage(Eval("Activity_Type")) %>'  />&nbsp;
                                         <asp:Label ID="lblID" runat="server" Visible="false" Text='<%#Eval("Activity_ID") %>' ></asp:Label>
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField ItemStyle-Width="8%" HeaderText="Ticket #" SortExpression="Ticket" >
                                    <ItemTemplate >
                                        <asp:Label runat="server" ID="lblTicketNumber" Text='<%# Functions.GetActivityPrefix(Eval("Activity_Type")) &  Eval("Activity_ID")%>' ></asp:Label>                                        
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Client" ItemStyle-Width="5%" ItemStyle-HorizontalAlign="Center" SortExpression="ClientCode" >
                                        <ItemTemplate >
                                            <%# Eval("ClientCode")%>
                                        </ItemTemplate>
                                    </asp:TemplateField> 
                                    <asp:TemplateField ItemStyle-Width="18%" HeaderText="Store #" SortExpression="StoreNumber"  >                                    
                                    <ItemTemplate >
                                        <%# Eval("StoreNick")& " - " & Eval("StoreNumber")%>
                                    </ItemTemplate>
                                    </asp:TemplateField>                                      
                                     <asp:TemplateField ItemStyle-Width="25%" HeaderText="Subject" SortExpression="Subject">
                                        <ItemTemplate >
                                          <span title='<%# Functions.IfNull(Eval("Subject"), "") %>' >
                                            <asp:Label runat="server" ID="lblSubject" Text='<%# Functions.StringTruncate(Functions.IfNull(Eval("Subject"), ""), 60) %>' ></asp:Label>                                        
                                          </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Initiated By" ItemStyle-Width="12%" ItemStyle-HorizontalAlign="Center" SortExpression="ContactName" >
                                        <ItemTemplate >
                                            <%# Eval("ContactName")%>
                                        </ItemTemplate>
                                    </asp:TemplateField> 
                                    <asp:TemplateField HeaderText="Rating" ItemStyle-Width="8%" ItemStyle-HorizontalAlign="Center" SortExpression="Rate" >
                                        <ItemTemplate >
                                            <%#IIf(Eval("Rate") = 1, "Unsatisfactory", IIf(Eval("Rate") = 2, "Average", IIf(Eval("Rate") = 3, "Good", "Excellent")))%>
                                        </ItemTemplate>
                                    </asp:TemplateField>       
                                      <asp:TemplateField HeaderText="Last Updated" ItemStyle-Width="12%" ItemStyle-HorizontalAlign="Center" SortExpression="LastUpdatedBy" ItemStyle-Wrap="false"   >
                                        <ItemTemplate >
                                            <%#Eval("LastUpdateName")%>
                                        </ItemTemplate>
                                    </asp:TemplateField>                                          
                                </Columns>
                            </asp:GridView>
                             </ContentTemplate>
                                  <Triggers >                                                                    
                                          <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                                  
                                          <asp:AsyncPostBackTrigger ControlID="btnDateSearch" EventName="Click" />
                                          <asp:AsyncPostBackTrigger ControlID="ddlClient" EventName="SelectedIndexChanged" />
                                  </Triggers>
                            </asp:UpdatePanel>    
                             <asp:ObjectDataSource ID="sdsInbox" runat="server" 
                                    SelectMethod="GetFranchiseeSurveyReportForHelpDesk"
                                    SelectCountMethod="GetFranchiseeSurveyReportCountForHelpDesk" 
                                    EnablePaging="true"
                                    SortParameterName="sortExpression"
                                    TypeName="Portal.BLL.Activities">
                                    <SelectParameters>
                                      <asp:ControlParameter  Name="ClientID" Type="String"  ControlID="ddlClient" PropertyName="SelectedValue" DefaultValue="0" />
                                      <%--<asp:ControlParameter  Name="FranchiseID" Type="Int32" ControlID="hdnFranchiseID" PropertyName="Value" />                                      --%>
                                      <asp:ControlParameter  Name="Search" Type="String" ControlID="txtSearch" PropertyName="Text" DefaultValue=""  ConvertEmptyStringToNull="true"/>
                                      <asp:ControlParameter Name="DateFrom" Type="DateTime" ControlID="txtDateFrom" PropertyName="Text" ConvertEmptyStringToNull="true" DefaultValue="1/1/2000" />
                                      <asp:ControlParameter Name="DateTo" Type="DateTime" ControlID="txtDateTo" PropertyName="Text" ConvertEmptyStringToNull="true" DefaultValue="1/1/2099" />
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
    function openPrint()
    {
        var txtDateFrom = document.getElementById("<%= txtDateFrom.ClientID %>");
        var txtDateTo = document.getElementById("<%= txtDateTo.ClientID %>");
        var ddlClient = document.getElementById("<%= ddlClient.ClientID %>");
        
        window.open('TicketsReport.aspx?DateFrom='+txtDateFrom.value+'&DateTo='+txtDateTo.value+'&ClientID='+ddlClient.value)
    }
</script>
</body>
</html>
