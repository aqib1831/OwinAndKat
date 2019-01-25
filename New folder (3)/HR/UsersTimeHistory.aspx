<%@ Page Language="VB" CodeFile="UsersTimeHistory.aspx.vb" Inherits="HR_UsersTimeHistory" Theme="Default"  %>
<%@ Register Assembly="RadComboBox.Net2" Namespace="Telerik.WebControls" TagPrefix="radC" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
</head>
<body style ="margin :0px; background-color:#E4F1F7; width:100%; height:100%;" >
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
                 <td  style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:5px;width:50%;">
                     Employee Time History   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
      
                </td>
                 <td style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right; white-space:nowrap;">
                    &nbsp;&nbsp;
                    <img align="absMiddle" src="../images/pixel_skyBlue.JPG" width="1" />
                     &nbsp;&nbsp;                    
                     <asp:LinkButton  runat="server"  ID="lbtnPrint" CssClass="HomeButton" OnClientClick ="TimeHistoryPrint();return false;">
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
                          </span><radC:RadComboBox id="ddlUsers"                                                         
                                runat="server"
                                AutoPostBack="true"  
                                EnableViewState="true"  
                                AllowCustomText="true"
                                MarkFirstMatch="true"   
                                Width="147px"  OffsetX="2" OffsetY="0"
                                Height="100"
                                Skin="ComboSearch" 
                                DropDownWidth="132px"
                                DataTextField="Name" 
                                DataValueField="ID"
                                MaxLength="10"
                                ShowToggleImage="True"  
                                ShowWhileLoading="true"                                                        
                                EnableLoadOnDemand="true" TabIndex="1"
                                HighlightTemplatedItems="true"></radC:RadComboBox> 
                           
                          <asp:SqlDataSource ID="sdsUsers" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                              DataSourceMode="DataReader" SelectCommand="HR_Users_GetAll" SelectCommandType="StoredProcedure">
                          </asp:SqlDataSource>
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
                      <td style="width:50%;">
                      &nbsp;&nbsp;
                          <asp:HiddenField ID="hdfID" runat="server" Value="" />
                      </td>
                   </tr>
                 </table>
                </td>
             </tr>
             <tr>
                <td colspan="2" style="background-color:#E4F1F7;  vertical-align:top; margin:0px;padding:0px;">
                       <table width="100%" border="0" cellspacing="0" cellpadding="3" style="font-family:Verdana;font-size:10px;border-bottom:1px solid #C9EAFC">
                        <tr style="height:18px; text-align:left; font-weight:bold; background-color:#BADCFC; position: relative; border-top:1px solid white;">
                            <td style="width:14%;" >Employee Name</td>
                            <td style="width:14%;" >Date</td>
                            <td style="width:14%;" >Time In</td>
                            <td style="width:14%;" >Time Out</td>
                            <td style="width:14%;" >Total Time</td>
                            <td style="width:14%;">Notes</td>
                            <td style="width:13%;">&nbsp;</td>
                        </tr>
                      </table> 
                </td>                
             </tr>
             <tr style=" height:85%; width:100%;">
               <td  colspan="2" style="background-color:#E4F1F7;  vertical-align:top; height: 85%; margin:0px;padding:0px;">
                    <div style="width:100%; height:100%; overflow:auto;  background-color:#E4F1F7;border:1px solid #ACBDD5;" class="ScrollBarHomeTicket" >                                       
                    <asp:UpdatePanel ID="UpdatePanel2" 
                     runat="server" 
                     UpdateMode="Conditional"
                     RenderMode="Inline">
                      <ContentTemplate>
                          <asp:Repeater 
                            ID="srcUserName" 
                            runat="server" 
                            DataSourceID="srcTimeHistory" 
                            EnableViewState="false">
                            <HeaderTemplate>
                                <table width="100%" border="0" cellspacing="0" cellpadding="3" style="font-family:Verdana;font-size:10px;border-bottom:1px solid #C9EAFC">                                  
                            </HeaderTemplate>
                            <ItemTemplate>
                                  <tr style="font-size:8pt;">
                                    <td colspan="3" valign="bottom" style="background-color:White;height:22px;border-top:1px solid #609BD3; border-bottom:1px solid #C9EAFC;font-weight:bold;"><%# Container.DataItem("EmployeeName") %></td>
                                    <td colspan="4" style="background-color:White; border-top:1px solid #609BD3; border-bottom:1px solid #C9EAFC;font-weight:bold;">&nbsp;</td><%--<%#FormatNumber(Container.DataItem("TotalMinutes"), 2)%> hrs--%>
                                  </tr>
                                <asp:Repeater id="srcTimeHistoryDetail" runat="server" DataSource='<%# Container.DataItem.CreateChildView("Users_Timings") %>' EnableViewState="false" OnItemDataBound="srcTimeHistoryDetail_ItemDataBound" >
                                    <ItemTemplate>
                                          <tr style="background-color:<%# IIF(CType(FormatDateTime(Container.DataItem("PunchInTime"), DateFormat.LongTime),DateTime) < #1/1/0001 9:16:00 am#, "white","white")%>; cursor:pointer; height:22px; border-bottom:1px solid #C9EAFC; font-size:8pt;" onmouseover = "this.className='HighlightedHomeRow';" onmouseout = "this.className='SimpleHomeRow';">
                                            <td style="width:14%; border-bottom:1px solid #C9EAFC;">&nbsp;</td>
                                            <td style="width:14%; border-bottom:1px solid #C9EAFC;" id='datein_<%#Container.DataItem("ID")%>'><%#String.Format("{0:MMM dd, yyyy}", Container.DataItem("PunchInTime"))%></td>
                                            <td style="width:14%; border-bottom:1px solid #C9EAFC;" id='timein_<%#Container.DataItem("ID")%>'><%#String.Format("{0:hh:mm tt}", Container.DataItem("PunchInTime"))%></td>
                                            <td style="width:14%; border-bottom:1px solid #C9EAFC;" id='timeout_<%#Container.DataItem("ID")%>'><%#String.Format("{0:hh:mm tt}", Container.DataItem("PunchOutTime"))%> </td>
                                            <td style="width:14%; border-bottom:1px solid #C9EAFC;"><strong><%#Container.DataItem("CurrentHours")%></strong> hrs : <strong><%#Container.DataItem("CurrentMinutes")%></strong> min</td>
                                            <td style="width:30%; border-bottom:1px solid #C9EAFC;" id='notes_<%#Container.DataItem("ID")%>'><%#Functions.IfNull(Container.DataItem("LastUpdatedNotes"), "&nbsp;")%></td>
                                            <td style="width:8%; border-bottom:1px solid #C9EAFC;">&nbsp;</td>                                            
                                          </tr>                        
                                    </ItemTemplate>
                                </asp:Repeater>
                                 <tr style="font-size:8pt;">
                                    <td colspan="4" style="background-color:White; cursor:pointer; height:22px; border-bottom:1px solid #C9EAFC;">&nbsp;</td>
                                    <td colspan="3" style="background-color:White; cursor:pointer; height:22px; border-bottom:1px solid #C9EAFC;"><%#Container.DataItem("EmployeeName") & "'s Total Time : <strong>" & Container.DataItem("CurrentHours") & "</strong>"%> hrs : <strong><%#Container.DataItem("CurrentMinutes") %></strong> min</td>
                                 </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                            </table>
                            </FooterTemplate>
                          </asp:Repeater>
                          <asp:ObjectDataSource 
                                ID="srcTimeHistory" 
                                runat="server" 
                                TypeName="Portal.BLL.HR.HR_Activities" 
                                SelectMethod="GetTimeHistoryReport"
                                EnablePaging="false">
                               <SelectParameters>
                                    <asp:ControlParameter Name="FromDate" ControlID="txtStartDate" Type="dateTime" />
                                    <asp:ControlParameter Name="ToDate" ControlID="txtEndDate" Type="dateTime" />
                                    <asp:ControlParameter Name="UserID" ControlID="ddlUsers" DefaultValue="0" Type="int32" PropertyName="Value" />
                                    <asp:ControlParameter ControlID="txtsearch" DefaultValue="" Name="txtsearch" PropertyName="Text" Type="String" />
                                </SelectParameters>
                          </asp:ObjectDataSource>      
                                  <asp:table id="tblNoRecord" width="100%" cellpadding="0" cellspacing="0" runat="server"  visible="false" >
                                       <asp:TableFooterRow >
                                            <asp:TableCell HorizontalAlign="Center" VerticalAlign="Middle">
                                               <div id="divInfo" style="position: absolute; width:200px; height:50px; left:32%; top:38%;" class="MessageDiv"> 
                                                     <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height:50px">                                                   
                                                        <tr>
                                                            <td style="width:5%;" >&nbsp;</td>
                                                            <td align="right" valign="middle" style="width:25%;">
                                                                <div style="text-align:right;">
                                                                    <asp:Image ID="Image1" runat="server" ImageUrl="~/images/ico_alert.gif" />&nbsp;&nbsp; 
                                                                </div>
                                                            </td>
                                                            <td nowrap="nowrap" align="left" valign="middle"  id="divMessage" style="width:75%; font-size:10px;">&nbsp;No Record Found !</td>
                                                        </tr>
                                                     </table>
                                                </div>  
                                            </asp:TableCell>
                                      </asp:TableFooterRow>
                                  </asp:table>                                                                         
                      </ContentTemplate>
                      <Triggers>
                         <asp:AsyncPostBackTrigger ControlID="ddlUsers" EventName="SelectedIndexChanged" />                
                         <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                              
                         <asp:AsyncPostBackTrigger ControlID="lnkResetFilters"  EventName="Click" />
                      </Triggers>
                     </asp:UpdatePanel>
                    </div>
               </td>
             </tr>             
             <tr style="height:24px; background-color:#BADCFC;">
                <td style="width:75%;" id="CustomPagerRow"></td>
               <td align="right"  style="width:25%;white-space:nowrap;padding-right:10px" class="GrayHeader">                    
                    <span style="font-size:7pt; color: #ff0000; display:none;">*
                    PunchIn Time after 9:15 is in Red Colors</span>                                        
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
        combo = <%=ddlusers.ClientID%>;
        UserID = combo.GetValue();
        if (item = UserID)
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
            objCustomRow.innerHTML = "<table cellpadding=0 cellspacing=0 align='center' height='18' ><tr class='cpyFloatingPager'>"+objTag.innerHTML+"</tr></table>";
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
        var vDay                      = addZero(vDate.getDate()); 
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
                
        strURL = "UsersTimeHistoryReport.aspx?UserID="+UserID+"&SDate="+StartDate+"&EDate="+EndDate+"&srchText="+srchText;  
         
        window.open(strURL);
      }
</script>
</body>
</html>
