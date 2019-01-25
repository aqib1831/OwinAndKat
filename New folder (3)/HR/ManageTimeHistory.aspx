<%@ Page Language="VB" AutoEventWireup="false"    CodeFile="ManageTimeHistory.aspx.vb" Inherits="HR_ManageTimeHistory" Theme="Default" %>
<%@ Register Assembly="RadComboBox.Net2" Namespace="Telerik.WebControls" TagPrefix="radC" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
</head>
<body style ="margin :0px; background-color:#E4F1F7; width:100%; height:100%;" >
    <form id="form1" runat="server"><asp:HiddenField ID="hdnSessionID" runat="server" ></asp:HiddenField>
    <div id="divDisable" class="modalBackground" style="z-index:0;" ></div>
        <div id="DivIFrame" runat="server"  style="display:none;border:solid 1px #000000; position:absolute; width:600px; height:215px; top:25%; left:10%; z-index:1;"    >
          <table style="height:100%;" cellpadding="0" border="0" cellspacing="0"   >
           <tr >    
              <td align="left" style="vertical-align:middle; border-bottom:solid 1px #000000; padding-left:1em; background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
                 <asp:label ID="Label1" runat="server" Text="Edit Time" Font-Bold="true" ForeColor="White" Font-Size="12pt" ></asp:label>
              </td>
              <td  style="border-bottom:solid 1px #000000;background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%; height:28px; cursor:pointer;">
                  <img src="../images/win_btn_close_black.jpg" style="float:right;" alt="Close Window" onclick="Reset();" />
              </td>               
           </tr>
           <tr valign="top">                
             <td colspan="2" style="height:100%; padding:0px; font-size:12px; background-color:White; border:0px;" >   
                <div style="overflow:auto; height:215px; width:600px; border:0px;" >   
                    <iframe name="IfHRTime" runat="server" id="IfHRTime" src="../BlankPage.htm" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
                </div>
             </td>
           </tr>            
          </table>
        </div>
        <div id="DivNotes" runat="server"  style="display:none;border:solid 1px #000000; position:absolute; width:400px;  height:300px;top:5%; left:25%; z-index:1;"    >
          <table style="height:100%;" cellpadding="0" border="0" cellspacing="0"   >
           <tr>    
              <td align="left" style="border-bottom:solid 1px #000000; padding-left:1em; background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
                  <asp:label ID="Label2" runat="server" Text="Notes" Font-Bold="true" ForeColor="White" Font-Size="12pt" ></asp:label>
              </td>
              <td  style="border-bottom:solid 1px #000000;background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%; height:28px; cursor:pointer;">
                  <img src="../images/win_btn_close_black.jpg" style="float:right;" alt="Close Window" onclick="ResetNotes()" />
              </td>               
           </tr>
           <tr valign="top">                
             <td colspan="2" style="height:100%; padding:10px; font-size:12px; background-color:White;" >   
                <div id="div" style="overflow:auto; height:300px; width:400px;" >   <label id="lblNotes"  ></label>   </div>     
             </td>
           </tr>            
          </table>
        </div>
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
                 <td  style="background-color:#A0CDEE;font-size:10px;font-weight:bold;padding:5px;width:50%;">
                    <span class="IdeaTitle" style="font-size:12px;"> 
                           <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always" RenderMode="Inline">
                            <ContentTemplate>
                                 Employee Time History   &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorCount"  />
                                &nbsp;<span class="NonBold"><asp:Label runat="server" ID="lblFilter" Text="all" Visible="false" /></span>                       
                                <asp:Button ID="Button1" runat="server"  Text=""  style="display:none;"  />
                                <asp:HiddenField ID="lbluserid" runat="server" ></asp:HiddenField>  
                                <asp:HiddenField ID="lblusername" runat="server" ></asp:HiddenField>
                                    
                            </ContentTemplate>
                            <Triggers >
                                 <asp:AsyncPostBackTrigger ControlID="ddlUsers" EventName="SelectedIndexChanged" />                
                                 <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                              
                                 <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                                 <asp:AsyncPostBackTrigger ControlID="refreshGrid" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel> 
                    </span>
                </td>
                 <td style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right; white-space:nowrap;">
                    &nbsp;&nbsp;
                    <img align="absMiddle" src="../images/pixel_skyBlue.JPG" width="1" />
                     &nbsp;&nbsp;
                     <asp:button ID="refreshGrid" runat="server" Text="" style="display:none;" CausesValidation="false" />
                     <asp:LinkButton  runat="server"  ID="lbtnPrint" CssClass="HomeButton" OnClientClick ="TimeHistoryPrint(); return false;">
                       <div style="width:110px;" class="LeadDetailButton" >
                         Print 
                       <img  src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10"  style="border:0px;" />
                       </div>
                     </asp:LinkButton>
                     &nbsp;&nbsp;
                     <img align="absMiddle"  height="20" src="../images/pixel_skyBlue.jpg" width="2" />
                     &nbsp;&nbsp;
                     <asp:LinkButton ID="lnkResetFilters" runat="server" CssClass="HomeButton">
                                <div style="width:110px;" class="LeadDetailButton" onclick="javascript:resetFilters();">
                                Reset Filters 
                                <img  src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10"  style="border:0px;" /></div>
                               </asp:LinkButton>
                    
                     <img  align="absmiddle" src="../images/pixel_skyBlue.jpg" width="1" height="20" />
                      
                 </td>                        
             </tr>              
             <tr style="height:5%;">
                <td colspan="2" style="background-color:#BADCFC;font-size:11px;">
                     <table border="0" cellpadding="0" cellspacing="0"  style="height:100%; width:100%; white-space:nowrap;">
                    <tr>

                      <td style="padding-left:5px; padding-right:5px; "  >
                          <span class="GrayHeader">Employees<br />
                          </span>
                          <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Always">
                            <ContentTemplate> 
                          <radC:RadComboBox id="ddlUsers"                                                         
                                runat="server" 
                                AutoPostBack="true"  
                                EnableViewState="true"  
                                AllowCustomText="true"
                                MarkFirstMatch="true"   
                                Width="129px"  OffsetX="2" OffsetY="0"
                                Height="100"
                                Skin="ComboSearch"
                                DropDownWidth="114px"
                                DataTextField="Name" 
                                DataValueField="ID"
                                MaxLength="10"
                                ShowToggleImage="true" 
                                ShowWhileLoading="true"                                                        
                                EnableLoadOnDemand="true"
                                HighlightTemplatedItems="true">                                                   
                        </radC:RadComboBox >
                          <asp:SqlDataSource ID="sdsUsers" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                              DataSourceMode="DataReader" SelectCommand="HR_Users_GetAll" SelectCommandType="StoredProcedure">
                          </asp:SqlDataSource>
                        </ContentTemplate> 
                        </asp:UpdatePanel> 
                      </td>
                         <td style="width:10px;text-align:center; ">
                          <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                      </td>
                      <td align="left" style="padding-left:5px; padding-right:5px; width: 15px; white-space:nowrap;">
                       <span style="font-size: 7pt; color: #7c8798; white-space:nowrap;">Start Date&nbsp;</span><br />
                          <span style="white-space:nowrap;">
                          <asp:TextBox ID="txtStartDate" 
                            runat="server" 
                            MaxLength="10" 
                            onfocus="imgDDCalander.click();"
                            SkinID="GreenSmallTextbox" 
                            Width="80px" ToolTip="Please Press the Go Button"></asp:TextBox>
                           <img id="imgDDCalander" title="After Selecting Date Press GO Button" align="absMiddle" border="0" onclick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtStartDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                              onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" />
                        </span>
                       </td>          
                       <td style="width:10px;text-align:center;">
                           <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" /> 
                      </td>
                       <td align="left" style="padding-left:5px; padding-right:5px; width: 15px; white-space:nowrap;">
                       <span style="font-size: 7pt; color: #7c8798; white-space:nowrap;">End Date&nbsp;</span><br />
                          <span style="white-space:nowrap;">
                          <asp:TextBox ID="txtEndDate" 
                            runat="server" 
                            MaxLength="10" 
                            onfocus="imgEndDate.click();"
                            SkinID="GreenSmallTextbox" 
                            Width="80px" ToolTip="Please Press the Go Button"></asp:TextBox>
                           <img id="imgEndDate" title="After Selecting Date Press GO Button" align="absMiddle" border="0" onclick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtEndDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                              onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" />
                        </span>
                       </td>          
                       <td style="width:10px;text-align:center;">
                           <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" /> 
                      </td>                        
                       <td style="padding:3px; white-space:nowrap;" align="left"  >
                           <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
                               <span class="GreyTextSmall"><span style="color: #000000"></span>Search</span><br />
                               <span>
                                   <asp:TextBox ID="txtSearch" runat="server" MaxLength="50" onfocus="javascript:this.value='';"
                                       SkinID="GreenSmallTextbox" Width="100px"></asp:TextBox>
                                   <asp:ImageButton ID="btnSearch" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/btn_go.gif" ToolTip="Press Go" />
                               </span>
                           </asp:Panel>
                      </td>
                      <td style="width:50%;text-align:right;">
                          <asp:HiddenField ID="hdfID" runat="server" Value="" />
                            <div style="width:110px;" class="LeadDetailButton" onclick="NewTimeClick();">
                                Add New 
                            <img  src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10"  style="border:0px;" />
                            </div>
                           &nbsp;
                      </td>
                   </tr>
                 </table>
                </td>
             </tr>
            <%-- <tr>
                <td colspan="2" style="background-color:#E4F1F7;  vertical-align:top; margin:0px;padding:0px;">
                       <table width="100%" border="0" cellspacing="0" cellpadding="3" style="font-family:Verdana;font-size:10px;border-bottom:1px solid #C9EAFC">
                        <tr style="height:18px; text-align:left; font-weight:bold; background-color:#BADCFC; position: relative; border-top:1px solid white;">
                            <td style="width:14%;" >Employee Name</td>
                            <td style="width:14%;" >Date</td>
                            <td style="width:14%;" >Time In</td>
                            <td style="width:14%;" >Time Out</td>
                            <td style="width:14%;" >Total Time</td>
                            <td style="width:14%;">&nbsp;</td>
                            <td style="width:13%;">&nbsp;</td>
                        </tr>
                      </table> 
                </td>                
             </tr>--%>
             <tr style=" height:85%; width:100%;">
               <td  colspan="2" style="background-color:#E4F1F7;  vertical-align:top; height: 85%; margin:0px;padding:0px;">
                    <div style="width:100%; height:100%; overflow:auto;  background-color:#E4F1F7;border:1px solid #ACBDD5;" class="ScrollBarHomeTicket" >                                       
                    <asp:UpdatePanel ID="UpdatePanel2" 
                     runat="server" 
                     UpdateMode="Conditional"
                     RenderMode="Inline">
                      <ContentTemplate>
                      <asp:GridView 
                        ID="gvReleases" 
                        runat="server"
                        PageSize="200" 
                        AutoGenerateColumns="False" 
                        EnableTheming="True" 
                        SkinID="GridViewNormal"
                        AllowSorting="True" AllowPaging="true" 
                        DataKeyNames="ID" DataSourceID="ObjectDataSource1" OnRowCreated="gvReleases_RowCreated" EnableViewState="false" >
                        <PagerSettings Mode="Numeric" Position="Bottom" />
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
                               
                               <asp:TemplateField   HeaderText="Date" SortExpression="PunchInTime" >
                                        <ItemTemplate >
                                            <span> <%#String.Format("{0:MMM dd, yyyy}",Eval("PunchInTime"))%></span>
                                        </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left"  Wrap="False"  />
                                    <ItemStyle HorizontalAlign="Left" Wrap="False" Font-Bold="True" Width="100px" />
                                </asp:TemplateField> 
                                <asp:TemplateField   HeaderText="PunchIn Time" SortExpression="PunchInTime" >
                                        <ItemTemplate >
                                            <span><%#String.Format("{0:hh:mm tt}",Eval("PunchInTime"))%></span>
                                        </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left"  Wrap="False"  />
                                    <ItemStyle HorizontalAlign="Left" Wrap="False" Font-Bold="True" Width="120px" />
                                </asp:TemplateField>
                                <asp:TemplateField   HeaderText="PunchOut Time" SortExpression="PunchOutTime" >
                                        <ItemTemplate >
                                            <span> <%#String.Format("{0:hh:mm tt}", Eval("PunchOutTime")).Replace("12:00 AM", "")%></span>
                                        </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left"  Wrap="False"  />
                                    <ItemStyle HorizontalAlign="Left" Wrap="False" Font-Bold="True" Width="120px" />
                                </asp:TemplateField>
                                <asp:TemplateField   HeaderText="Total Time" SortExpression="CurrentMinutes" >
                                        <ItemTemplate >
                                            <span><strong><%#Eval("CurrentHours").ToString.PadLeft(2, "0")%></strong></span> hrs : <span><strong><%#Eval("CurrentMinutes").ToString.PadLeft(2, "0")%></strong> min</span>
                                        </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left"  Wrap="False"  />
                                    <ItemStyle HorizontalAlign="Left" Wrap="False" Width="120px" />
                                </asp:TemplateField>
                                <asp:CheckBoxField DataField="ForcedPunchOut" HeaderText="Forced PO" SortExpression="ForcedPunchOut" >
                                    <itemstyle HorizontalAlign="Center" Width="80px" />
                                </asp:CheckBoxField>
                                <asp:TemplateField   HeaderText="Updated By" SortExpression="LastUpdatedAdminName" >
                                        <ItemTemplate >
                                            <span><%#Eval("LastUpdatedAdminName")%></span>
                                        </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left"   Wrap="False"  />
                                    <ItemStyle HorizontalAlign="Left" Wrap="False" Font-Bold="True"  />
                                </asp:TemplateField>                                   
                                 <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                        <a id="lbtnEdit" href="#" onclick="EditTime(<%#Eval("ID") %>);" >Edit</a> 
                                        <asp:LinkButton ID="lbtnNotes" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="Notes" Text="|  Notes "></asp:LinkButton>
                                    </ItemTemplate>                                                                       
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  />                                  
                                    <ItemStyle HorizontalAlign="Center" Wrap="False"  />
                                </asp:TemplateField>
                                <asp:TemplateField  Visible="False">
                                    <ItemTemplate>                                        
                                        <asp:Label ID="lblNotes" runat="server" Text='<%# Eval("LastUpdatedNotes") %>' ></asp:Label>                                  
                                    </ItemTemplate>                                                                       
                                </asp:TemplateField>
                                                                                
                                                                
                            </Columns>
                     
                            </asp:GridView>  
                           
                      </ContentTemplate>
                      <Triggers>
                         <asp:AsyncPostBackTrigger ControlID="ddlUsers" EventName="SelectedIndexChanged" />                
                         <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                              
                         <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                         <asp:AsyncPostBackTrigger ControlID="refreshGrid" EventName="Click" />
                         <asp:AsyncPostBackTrigger ControlID="Button1" EventName="Click" />
                      </Triggers>
                     </asp:UpdatePanel>
                     <asp:ObjectDataSource ID="ObjectDataSource1" 
                            runat="server"  EnableViewState="true"
                            SortParameterName="sortExpression"
                            MaximumRowsParameterName="maximumRows"
                            StartRowIndexParameterName="startRowIndex"
                            TypeName="Portal.BLL.HR.HR_UserTimeHistory" 
                            SelectMethod="HR_UserTimeHistoryGetAll"
                            SelectCountMethod="HR_UserTimeHistoryGetAllCount"
                            EnablePaging="True">
                            <SelectParameters>
                                <asp:ControlParameter Name="FromDate" ControlID="txtStartDate" Type="dateTime" />
                                <asp:ControlParameter Name="ToDate" ControlID="txtEndDate" Type="dateTime" />
                                <asp:ControlParameter Name="UserID" ControlID="ddlUsers" DefaultValue="0" Type="int32" PropertyName="Value"  />
                                <asp:Parameter Name="sortExpression" Type="String" />                               
                                <asp:ControlParameter ControlID="txtsearch" DefaultValue="" Name="txtsearch" PropertyName="Text" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </div>
               </td>
             </tr>             
             <tr style="height:24px; background-color:#BADCFC;">
                <td style="width:75%;" id="CustomPagerRow"></td>
               <td align="right"  style="width:25%;white-space:nowrap;padding-right:10px" class="GrayHeader">                    
                    <span style="font-size:7pt; color: #ff0000; display:none;">*
                    PunchIn Time after 9:15 is in Red Colors  </span>                                      
                </td> 
             </tr>
            </table>
    </div>
    </form>
<script type="text/javascript" language="javascript">
    var combo = <%=ddlUsers.ClientID %>;
    function resetFilters()
    { 
        var item; 
        if (item = document.getElementById('<%= txtSearch.ClientID %>')){
            item.value = '';
        }  
       // combo.SetValue('0');
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
      
      
      function addZero(vNumber)
      { 
        return ((vNumber < 10) ? "0" : "") + vNumber 
      } 
      function formatDate(vDate, vFormat)
      { 
        var vDay              = addZero(vDate.getDate()); 
        var vMonth            = addZero(vDate.getMonth()+1); 
        var vYearLong         = addZero(vDate.getFullYear()); 
        var vYearShort        = addZero(vDate.getFullYear().toString().substring(3,4)); 
        var vYear             = (vFormat.indexOf("yyyy")>-1?vYearLong:vYearShort) 
        var vHour             = addZero(vDate.getHours()); 
        var vMinute           = addZero(vDate.getMinutes()); 
        var vSecond           = addZero(vDate.getSeconds()); 
        var vDateString       = vFormat.replace(/dd/g, vDay).replace(/MM/g, vMonth).replace(/y{1,4}/g, vYear) 
        vDateString           = vDateString.replace(/hh/g, vHour).replace(/mm/g, vMinute).replace(/ss/g, vSecond) 
        return vDateString 
      } 
    function ShowEditDetail(ID)
    {
  
     var hr_in, min_in, hr_out, min_out;
     
     hr_in = new Date(document.getElementById('datein_'+ ID).innerText + ' ' + document.getElementById('timein_'+ ID).innerText);
     hr_out=new Date(document.getElementById('datein_'+ ID).innerText + ' ' + document.getElementById('timeout_'+ ID).innerText);
     
     min_in=hr_in.getMinutes();
     min_out=hr_out.getMinutes();
     
     //calculate hours in 12 hr format
     hr_in = hr_in.getHours();
     hr_in = (hr_in > 12) ? (hr_in -12) : hr_in;
     
     hr_out = hr_out.getHours();
     hr_out = (hr_out > 12) ? (hr_out -12) : hr_out;
     
     
      document.getElementById('divDetails').style.display='inline';
      document.getElementById('divContainer').style.display='inline';       
      document.getElementById('<%=hdfID.clientid%>').value=ID;
    
    }
      function Cancel(ID)
    {
      
    }

    function TimeHistoryPrint()
    {
        var srchText; 
        var StartDate;
        var EndDate;
        var UserID;
        var strURL;
        
        srchText = document.getElementById('<%= txtSearch.ClientID %>').value;
        StartDate = document.getElementById('<%= txtStartDate.ClientID %>').value;
        EndDate = document.getElementById('<%= txtEndDate.ClientID %>').value;
        combo = <%=ddlusers.ClientID%>;
       
        UserID = combo.GetValue();
        //alert($get(<%=ddlUsers.ClientID %>).GetValue());
//        alert(document.getElementById('<%= lbluserid.ClientID %>').value);
        if (combo.GetValue() == '' && document.getElementById('<%= lbluserid.ClientID %>').value != '')
        {
            UserID = document.getElementById('<%= lbluserid.ClientID %>').value;
            
        }
        if (UserID == '')
        {
            alert('Please Select Employee');
            return false;
        }
        
        strURL = "UsersTimeHistoryReport.aspx?UserID="+UserID+"&SDate="+StartDate+"&EDate="+EndDate+"&srchText="+srchText;  
        
        window.open(strURL);
    }
    
    function EditTime(Timeid)
    { 
        var Label1 = getElement('<%= Label1.ClientID %>')        
        Label1.innerHTML = 'Edit Time';
        IfHRTime.location='UsersTimeHistoryEdit.aspx?ID='+Timeid;
          
        var DivFram = getElement('<%= DivIFrame.ClientID %>')
        DivFram.style.display= "inline"
        
        document.getElementById('divDisable').style.width = '100%';
        document.getElementById('divDisable').style.height = '100%';
        
    }
    function Reset()
    {  
        
        var DivFram = getElement('<%= DivIFrame.ClientID %>')        
        document.getElementById('divDisable').style.width = 0;
        document.getElementById('divDisable').style.height = 0;
        IfHRTime.location='../BlankPage.htm';       
        DivFram.style.display= "none";
        return false;        
    }
    function RefreshGrid()
    {
     Reset();
     var refreshGrid = getElement('<%= refreshGrid.ClientID %>');
     refreshGrid.click();     
    }
    function NewTimeClick()
    {   
        
        combo = <%=ddlusers.ClientID%>;
        var ddlUsersvalue = combo.GetValue();          
        if (combo.GetValue() == '' && document.getElementById('<%= lbluserid.ClientID %>').value != '')
        {
            ddlUsersvalue = document.getElementById('<%= lbluserid.ClientID %>').value;
        }
        if(ddlUsersvalue > 0)
        {            
            var Label1 = getElement('<%= Label1.ClientID %>')        
            Label1.innerHTML = 'Add New Time';
            IfHRTime.location='UsersTimeHistoryEdit.aspx?UserID='+ddlUsersvalue;
              
            var DivFram = getElement('<%= DivIFrame.ClientID %>')
            DivFram.style.display= "inline"
            
            document.getElementById('divDisable').style.width = '100%';
            document.getElementById('divDisable').style.height = '100%';
            
        }
        else
        {
            var Label1 = getElement('<%= Label1.ClientID %>')        
            Label1.innerHTML = 'Add New Time';
            var hdnSessionID=document.getElementById('<%= hdnSessionID.ClientID %>').value;
            IfHRTime.location='UsersTimeHistoryEdit.aspx?UserID='+hdnSessionID;
              
            var DivFram = getElement('<%= DivIFrame.ClientID %>')
            DivFram.style.display= "inline"
            
            document.getElementById('divDisable').style.width = '100%';
            document.getElementById('divDisable').style.height = '100%';
        }
     }
    
    function OpenNotes(Notes)
    {        
    var strReplaceAll = Notes;
    var intIndexOfMatch = strReplaceAll.indexOf( "$*" );
    while (intIndexOfMatch != -1)
    {        
    strReplaceAll = strReplaceAll.replace( "$*", "<br />" )
    intIndexOfMatch = strReplaceAll.indexOf( "$*" );       
    }       
     lblNotes.innerHTML = strReplaceAll          
     SetPosition()
    }
     
    function SetPosition()
    {
    
     var DivNotes = getElement('<%= DivNotes.ClientID %>')  
        document.getElementById('divDisable').style.width = document.body.scrollWidth+240;
        document.getElementById('divDisable').style.height = document.body.scrollHeight+8;
        DivNotes.style.display= "inline"      
      
    }
    
    function ResetNotes()
    {
        lblNotes.innerText = ''
        var DivNotes = getElement('<%= DivNotes.ClientID %>')        
        document.getElementById('divDisable').style.width = 0;
        document.getElementById('divDisable').style.height = 0;
        DivNotes.style.display= "none";        
        return false;        
    }
    function setUserCombo(userid,username)
    {  
      getElement('<%= lbluserid.ClientID %>').value = userid; 
      getElement('<%= lblusername.ClientID %>').value = username; 
      getElement('<%= Button1.ClientID %>').click(); 
      combo.SetValue(userid);
      combo.SetText(username);
      Reset();
      return true;
    }


</script>
</body>
</html>
