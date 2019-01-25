							  												   <%@ Page Language="VB" AutoEventWireup="false" CodeFile="PMReportDetail.aspx.vb" Inherits="PM_PMReportDetail" Theme="Default" EnableEventValidation="false" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>PM Detail Report</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../scripts/functions.js" ></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
    <script language="javascript" type="text/javascript" src="../scripts/jquery-1.3.2.min.js" ></script>	   
    <style>
        .SimpleHomeRow td, GridRowClickable td, .HighlightedHomeRow td, .TextWrap, .GView td, .FloatingHeader th{
            font-size:12px !important;
        }
    </style>
</head>
<body style ="margin :0px; background-color:#E4F1F7; width:100%; height:100%; ">
    <form id="form1" runat="server">
    <asp:HiddenField ID="hdnStartDate" runat="server" />
    <asp:HiddenField ID="hdnEndDate" runat="server" />
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
    <table  style="height:100%; width:100%; " cellspacing="0" border="0">
             <tr class="UnderlinedRow">
                 <td colspan="2"  style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding-left:5px;padding-bottom:1px;height:27px;">
                    <div style="float:left;width:150px;height:20px;line-height:20px;">PM Detail Report</div>
                    <div style="width:467px;float:right;margin-right:4px;">
                         <div style="width:120px;float:left;margin-top:1px;margin-left:2px;">
                        <asp:UpdatePanel ID="upUsers" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                          <ContentTemplate>
                        <asp:DropDownList ID="ddlUsers" runat="server"
                            SkinID="SmallTextCombo"
						    DataTextField="Name" 
						    DataValueField="ID"
						    AutoPostBack="True" Width="110px" DataSourceID="odsUsers">
						</asp:DropDownList>&nbsp;
                     
                        </ContentTemplate>
                        <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddlTeams" EventName="SelectedIndexChanged" />
                        </Triggers>
                        </asp:UpdatePanel>
                           <asp:ObjectDataSource ID="odsUsers" runat="server" TypeName="Portal.BLL.Users" SelectMethod="GetByGroupId">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddlTeams" PropertyName="SelectedValue" DefaultValue="0" Name="GroupId" Type="Int32"/>
                            </SelectParameters>
                        </asp:ObjectDataSource>
                     </div>
                        <%--<div style="width: 110px;float:left;margin-right:5px;" class="LeadDetailButton" onclick="PrintReport();" >
                            Print
                        </div>--%>
                        <div style="width: 110px;float:left;margin-right:5px;" class="LeadDetailButton" onclick="GenerateExcel();" >
                            Export To Excel
                        </div>
                        <div style="float:left;margin-right:2px;">
                        <asp:LinkButton ID="lnkResetFilters" runat="server" CssClass="HomeButton">
                          <div style="width:110px;" class="LeadDetailButton" onclick="javascript:ResetFilters();">
                                    Reset Filters 
                                    <img  src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10"  style="border:0px;" /></div>
                        </asp:LinkButton>
                        </div>
                        <div style="width: 110px;" class="LeadDetailButton" onclick="return BackToMainGrid();">
                            Back
                        </div>
                     </div>
                 </td>                        
             </tr>              
             <tr>
                <td colspan="2" style="background-color:#BADCFC;font-size:11px;height:40px;">
                    <table border="0" cellpadding="0" cellspacing="0"  style="height:100%;">
                    <tr>
                    <td align="center" style=" padding-bottom:3px;">
						<div style="float:left;width:113px;margin-left:5px; text-align:left;">
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
                        </div>
						</td>
					<td style="width:5px;text-align:center;">
						 <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
					</td>
					<td align="left" style="text-align:left; padding-bottom:3px;">
						<div style="width:113px;margin-left:3px;float:left;"> 
                        <span class="GrayHeader">Teams<br />
						</span>
							<asp:DropDownList 
							ID="ddlTeams" 
							runat="server" 
							SkinID="SmallTextCombo"
							DataTextField="Name"
							DataValueField="ID"
							AutoPostBack="True" Width="110px" DataSourceID="sdsTeams">
						</asp:DropDownList>&nbsp;
						 <asp:SqlDataSource ID="sdsTeams" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                              SelectCommand="Groups_GetGroupsbyTypeForPMReport" 
                              SelectCommandType="StoredProcedure"
                              DataSourceMode="DataReader">
                              <SelectParameters>
                                  <asp:Parameter ConvertEmptyStringToNull="False" DefaultValue="2" Name="Type" Type="Int32" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                        </div>
					</td>
					<td style="width:5px;text-align:center;">
                          <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                      </td>
                    <td align="left" style="text-align:left; padding-bottom:3px;">
						<div style="width:113px;margin-left:3px;float:left;"> 
                        <span class="GrayHeader">Category<br />
						</span>
						<asp:UpdatePanel ID="upCategory" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                        <ContentTemplate>
							<asp:DropDownList 
							ID="ddlCategory" 
							runat="server" 
							SkinID="SmallTextCombo"
							DataTextField="Name"
							DataValueField="ID"
							AutoPostBack="True" Width="110px" DataSourceID="sdsCategory">
						</asp:DropDownList>&nbsp;
						 <asp:SqlDataSource ID="sdsCategory" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                              SelectCommand="PM_Categories_Clients_GetAll" 
                              SelectCommandType="StoredProcedure" DataSourceMode="DataSet"
                              >
                              <SelectParameters>
                                  <asp:ControlParameter ControlID="ddlClients" PropertyName="SelectedValue" Name="ClientID" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlClients" EventName="SelectedIndexChanged" />
                        </Triggers>
                        </asp:UpdatePanel>
                        </div>
					</td>
					<td style="width:5px;text-align:center;">
                          <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                      </td>
                    <td align="left" style="text-align:left; padding-bottom:3px;">
						<div style="width:113px;margin-left:3px;float:left;"> 
                        <span class="GrayHeader">Type<br />
						</span>
							<asp:DropDownList 
							ID="ddlType" 
							runat="server" 
							SkinID="SmallTextCombo"
							DataSourceID="SDS_Type" 
                            DataTextField="Name"
							DataValueField="ID"
							AutoPostBack="True" Width="110px">
						</asp:DropDownList>&nbsp;
							<asp:SqlDataSource ID="SDS_Type" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
										SelectCommand="PM_TaskTypes_GetAll" SelectCommandType="StoredProcedure" DataSourceMode="DataReader">
									</asp:SqlDataSource>
                        </div>
					</td>
                    <td style="width:5px;text-align:center;">
                          <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                      </td>
                    <td style="padding-bottom:3px;width:110px; text-align:left;" align="center">
                         <div style="width:104px;text-align:left;">
                                <span class="GreyTextSmall" style="margin-left:3px;">From Date</span><br />
                                <span style="margin-left:3px;">
                                    <asp:TextBox runat="server" ID="txtDateFrom" CssClass="GreyTextBox" Width="70px" Height="18px" onfocus="this.blur();" />
                                    <img id="img2" align="absMiddle"
                                     border="0"
                                     onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtDateFrom.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                     onmouseover="style.cursor='hand';"
                                     src="../images/ico_calendar.jpg" alt="" />
                                </span>
                             </div>                     
                        </td>
                        <td style="padding-bottom:3px;">
                            <div style="width:104px;text-align:left;">
                                <span class="GreyTextSmall">To Date</span><br />
                                <span>
                                <asp:TextBox runat="server" ID="txtDateTo" CssClass="GreyTextBox" Width="70px" Height="18px" onfocus="this.blur();" />
                                <img id="img1" align="absMiddle"
                                     border="0"
                                     onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtDateTo.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                     onmouseover="style.cursor='hand';"
                                     src="../images/ico_calendar.jpg" alt="" />
                                     </span>
                             </div>
                        </td> 
                     <td style="padding-top:12px;padding-left:5px; white-space:nowrap;" align="left"  >
                           <asp:ImageButton ID="btnSearch" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/btn_go.gif" />
                        </td>
                      
                   </tr>
                 </table>
                </td>
             </tr>
             <tr>
                <td  colspan="2" style="background-color:#E4F1F7;  vertical-align:top; height: 85%; margin:0px;padding:0px;">              
                       <div style="width:100%; height:100%; overflow:auto;  background-color:#E4F1F7;border:1px solid #ACBDD5;" class="ScrollBarHomeTicket" >                   
                    <asp:UpdatePanel ID="UpdatePanel2" 
                     runat="server" 
                     UpdateMode="Always"
                     RenderMode="Inline">
                     <ContentTemplate>
                        <asp:HiddenField ID="hdnSortBy" runat="server" Value="" /> 
                        <asp:GridView 
                        ID="gvDashBoardTickets" 
                        runat="server" 
                        AutoGenerateColumns="False" 
                        EnableTheming="True" 
                        SkinID="GridViewWithOutPaging"
                        EnableViewState="false"
                        AllowSorting="True" DataSourceID="odsDashBoardTicket" PageSize="50" >
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
                               <asp:TemplateField SortExpression="Priority">
                                    <ItemTemplate>
                                        <img src='<%# ConfigurationManager.AppSettings("ImagesURL") & CType(Container.DataItem, Data.DataRowView)("ImageName") %>' />
                                    </ItemTemplate>
                                    <ItemStyle Width="2%" />                                    
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Ref #" SortExpression="RefNo">
                                    <ItemTemplate>
                                        <%#CType(Container.DataItem, Data.DataRowView)("RefNo")%>
                                    </ItemTemplate>
                                     <ItemStyle Width="6%" HorizontalAlign="Center" Font-Bold="true"  />
                                     <HeaderStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Subject" SortExpression="Name">
                                    <ItemTemplate>
                                        <span title='<%#CType(Container.DataItem, Data.DataRowView)("Name")%>'>
                                            <%#Functions.StringTruncate(CType(Container.DataItem, Data.DataRowView)("Name"),50)%>
                                        </span>
                                    </ItemTemplate>
                                     <ItemStyle Width="22%"/>
                                </asp:TemplateField>                                
                                <asp:TemplateField HeaderText="Category" SortExpression="CategoryName">
                                    <ItemTemplate>                                    
                                        <%# CType(Container.DataItem, Data.DataRowView)("CategoryName")%>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%"/>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Entered On" SortExpression="DateEntered">
                                    <ItemTemplate>                                    
                                        <%# CType(Container.DataItem, Data.DataRowView)("DateEntered")%>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%"/>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Completed On" SortExpression="DateCompleted">
                                    <ItemTemplate>                                    
                                        <%# CType(Container.DataItem, Data.DataRowView)("DateCompleted")%>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%"/>
                                </asp:TemplateField>
                               <asp:TemplateField HeaderText="Completed Survey Y/N" SortExpression="SurveyExisted">
                                    <ItemTemplate>                                    
                                         <%# Functions.IfNull(IIf(CType(Container.DataItem, Data.DataRowView)("SurveyExisted") = 0, "No", "Yes"),"N/A")%>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%"/>
                                </asp:TemplateField>

                                
<asp:TemplateField HeaderText="Time Spent (HH:MM)" SortExpression="TimeSpent">
                                    <ItemTemplate>                                    
                                          <asp:Label ID="lblTimeSpent" runat="server" Text="0:00" CssClass="TimeSpent" />                                    
                                    </ItemTemplate>
                                    <ItemStyle Width="13%" />
                                </asp:TemplateField>                                 

                        
                            </Columns>
                        </asp:GridView>                         
                             </ContentTemplate>
                                  <Triggers >
                                  <asp:AsyncPostBackTrigger ControlID="ddlCategory" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlClients" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlType" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlTeams" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlUsers" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                              
                                  <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                                  </Triggers>
                            </asp:UpdatePanel>       
                        <asp:ObjectDataSource ID="odsDashBoardTicket" 
                            runat="server" 
                            SortParameterName="SortExpression"
                            SelectMethod="GetPMDashBoardTickets"
                            EnablePaging="true"
                            StartRowIndexParameterName="StartRowIndex"
                            MaximumRowsParameterName="MaximumRows"
                            SelectCountMethod="GetPMDashBoardTicketsCount" 
                            TypeName="Portal.BLL.PM.PM_Ticket_Features">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="txtDateFrom" PropertyName="Text" Name="StartDate" />
                                <asp:ControlParameter ControlID="txtDateTo" PropertyName="Text" Name="EndDate" />
                                <asp:ControlParameter ControlID="ddlClients" Name="ClientID" PropertyName="SelectedValue" DefaultValue="1" Type="Int32" />
                                <asp:ControlParameter ControlID="ddlCategory" DefaultValue="0" Name="CategoryID" PropertyName="SelectedValue" Type="Int32" />
                                <asp:ControlParameter ControlID="ddlType" DefaultValue="0" Name="Type" PropertyName="SelectedValue" Type="Int32" />                               
                                <asp:ControlParameter ControlID="ddlTeams" DefaultValue="0" Name="TeamId" PropertyName="SelectedValue" Type="Int32" />                                
                                <asp:ControlParameter ControlID="ddlUsers" DefaultValue="0" Name="UserId" PropertyName="SelectedValue" Type="Int32" />
                                <asp:Parameter Name="txtsearch" DefaultValue=""/>                                
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </div>
                </td>
             </tr>
             <tr style="height:20px; background-color:#BADCFC;">
                <td style="width:75%;" id="CustomPagerRow">
                </td>
                <td style="width:25%;" align="right" valign="middle">
                     <asp:UpdatePanel ID="upTotalTime" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                     <ContentTemplate>
                     <div style="margin-right:5px; font-family: Arial; font-size:12px; font-weight:bold;">Total Time Spent - <asp:Label ID="lblTimeSum" runat="server" Text="" /></div>
                     </ContentTemplate>
                     <Triggers>
                          <asp:AsyncPostBackTrigger ControlID="ddlCategory" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlClients" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlType" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlTeams" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="ddlUsers" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                              
                                  <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                     </Triggers>
                     </asp:UpdatePanel>
                </td>
             </tr>
            </table>
    </div>
    </form>
    <script type="text/javascript" language="javascript">
        function resetFilters() {
            var item;
            if (item = document.getElementById('<%= ddlCategory.ClientID %>')) {
                item.value = 0;
            }
            if (item = document.getElementById('<%= ddlClients.ClientID %>')) {
                item.value = 0;
            }
            if (item = document.getElementById('<%= ddlType.ClientID %>')) {
                item.value = 0;
            }
            
            return true;
        }
        //These Mothods are used to Enable pagging on a TD and Also Empty txtSearch
        function AdjustPagerRow() {
            var objTag = null;
            var objCustomRow = null;
            try {
                objCustomRow = getElement("CustomPagerRow");
                objTag = getElementByClassName('FloatingPager');
                objCustomRow.innerHTML = '&nbsp;';
                if (objTag != null && objCustomRow != null) {
                    objTag.style.display = 'none';
                    objCustomRow.innerHTML = "<table cellpadding=0 cellspacing=0 align='left' height='18' ><tr class='cpyFloatingPager'>" + objTag.innerHTML + "</tr></table>";
                }
            } catch (ex) {
                alert("Javascript Error:\n" + ex.description);
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
            if (typeof (postbackElement) === "undefined") {
                return;
            }
            for (i = 0; i < updatedPanels.length; i++) {
                if (updatedPanels[i].id == '<%= UpdatePanel2.ClientID %>') {
                    AdjustPagerRow();
                    
                }
            }
        }

        function ShowDetail(ID) {
            var url = "TicketsDetail.aspx";
            var quesrystring = "?ReleaseID=0&ID=" + ID + "&ClientId=" + document.getElementById('<%=ddlClients.ClientID %>').value
	                        + "&CategoryId=" + document.getElementById('<%=ddlCategory.ClientID %>').value
                            + "&Type=" + document.getElementById('<%=ddlType.ClientID %>').value
                            + "&TeamId=" + document.getElementById('<%=ddlTeams.ClientID %>').value
                            + "&UserId=" + document.getElementById('<%=ddlUsers.ClientID %>').value
                            + "&StartDate=" + document.getElementById('<%=txtDateFrom.ClientID %>').value
                            + "&EndDate=" + document.getElementById('<%=txtDateTo.ClientID %>').value
	                        + "&PrevPage=7"
            url = url + quesrystring;
            SaveFilterInCookie('PMDashBaordDetailCookie', quesrystring)
            window.location = url;
        }
        function SaveFilterInCookie(cookiename, valToStore) {
            document.cookie = cookiename + '=StartDashBaordDetailCookie' + valToStore + 'EndDashBaordDetailCookie';
        }

function OnRowClick(ReleaseID, ID) {
            window.location = "TicketsDetail.aspx?ReleaseID=" + ReleaseID + "&ID=" + ID + "&ddlClients=" + document.getElementById('<%=ddlClients.ClientID %>').value
	                        + "&ddlCategory=" + document.getElementById('<%=ddlCategory.ClientID %>').value
	                        + "&ddlType=" + document.getElementById('<%=ddlType.ClientID %>').value
	                        + "&PrevPage=6"
        }

        function GenerateExcel() {
            var ClientId = $("[id$=ddlClients] option:selected").val();
            var UserId = $("[id$=ddlUsers] option:selected").val();
            var CategoryId = $("[id$=ddlCategory] option:selected").val();
            var TeamId = $("[id$=ddlTeams] option:selected").val();
            var Type = $("[id$=ddlType] option:selected").val();
            var StartDate = $("[id$=txtDateFrom]").val();
            var EndDate = $("[id$=txtDateTo]").val();
            var SortBy = $("[id$=hdnSortBy]").val();

            /*** Getting Selected Text ***/
            var ClientName = $("[id$=ddlClients] option:selected").text();
            var UserName = $("[id$=ddlUsers] option:selected").text();
            var CategoryName = $("[id$=ddlCategory] option:selected").text();
            var TeamName = $("[id$=ddlTeams] option:selected").text();
            var TypeName = $("[id$=ddlType] option:selected").text();

            var d = new Date();
            var uniqueid = d.getMilliseconds();

            var url = "../ExcelGenerator.ashx?Action=PMDashBoardTickets&ClientId=" + ClientId + "&TeamId=" + TeamId + "&UserId=" + UserId + "&CategoryId=" + CategoryId + "&Type=" + Type + "&StartDate=" + StartDate + "&EndDate=" + EndDate + "&ClientName=" + ClientName + "&UserName=" + UserName + "&CategoryName=" + CategoryName + "&TeamName=" + TeamName + "&TypeName=" + TypeName + "&SortBy=" + SortBy + "&nocache=" + uniqueid;
            window.open(url);
        }
        function PrintReport() {
            var ClientId = $("[id$=ddlClients] option:selected").val();
            var UserId = $("[id$=ddlUsers] option:selected").val();
            var CategoryId = $("[id$=ddlCategory] option:selected").val();
            var TeamId = $("[id$=ddlTeams] option:selected").val();
            var Type = $("[id$=ddlType] option:selected").val();
            var StartDate = $("[id$=txtDateFrom]").val();
            var EndDate = $("[id$=txtDateTo]").val();
            var SortBy = $("[id$=hdnSortBy]").val();

            /*** Getting Selected Text ***/
            var ClientName = $("[id$=ddlClients] option:selected").text();
            var UserName = $("[id$=ddlUsers] option:selected").text();
            var CategoryName = $("[id$=ddlCategory] option:selected").text();
            var TeamName = $("[id$=ddlTeams] option:selected").text();
            var TypeName = $("[id$=ddlType] option:selected").text();


            var d = new Date();
            var uniqueid = d.getMilliseconds();

            var url = "PMReportDetail_Print.aspx?ClientId=" + ClientId + "&TeamId=" + TeamId + "&UserId="+UserId + "&CategoryId=" + CategoryId + "&Type=" + Type + "&StartDate=" + StartDate + "&EndDate=" + EndDate + "&ClientName=" + ClientName + "&UserName=" + UserName + "&CategoryName=" + CategoryName + "&TeamName=" + TeamName + "&TypeName=" + TypeName + "&SortBy="+SortBy+"&nocache=" + uniqueid;
            window.open(url);
        }
        function ResetFilters() {
            $("[id*=ddlClients]").val(1);
            $("[id*=ddlCategory]").val(0);
            $("[id*=ddlTeams]").val(0);
            $("[id*=ddlType]").val(0);
            $("[id*=ddlUsers]").val(0);
            $("[id$=txtDateFrom]").val($("[id$=hdnStartDate]").val());
            $("[id$=txtDateTo]").val($("[id$=hdnEndDate]").val());
        }
        function BackToMainGrid() {
            var url = '';
            /*url = 'PMReportMain.aspx?ClientId=' + '<%=Request.QueryString("ClientId")%>';
            url = url + '&TeamId=' + '<%=Request.QueryString("TeamId")%>';
            url = url + '&CategoryId=' + '<%=Request.QueryString("CategoryId")%>';
            url = url + '&Type=' + '<%=Request.QueryString("Type")%>';
            url = url + '&StartDate=' +'<%=Request.QueryString("StartDate")%>';
            url = url + '&EndDate=' + '<%=Request.QueryString("EndDate")%>';*/
            var coockieVal = document.cookie.valueOf();
            var dashboardcookie = coockieVal.substr(coockieVal.indexOf('StartDashBaordCookie'), coockieVal.indexOf('EndDashBaordCookie'));
            var Qstr = dashboardcookie.replace('StartDashBaordCookie', '');
            Qstr = Qstr.replace('EndDashBaordCookie', '');
            window.location = 'PMReportMain.aspx' + Qstr;
        }

        
</script>
</body>
</html>
