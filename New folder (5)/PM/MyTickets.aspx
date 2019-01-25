<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MyTickets.aspx.vb" Inherits="PM_MyTickets" Theme="Default" %>

<%--<%@ Register TagPrefix="DDMS" TagName="MultiSelectDropDown" Src="~/PM/Controls/MultiSelectDropDown.ascx" %>--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <link href="../style/Multiselectdropdown.css" rel="stylesheet" />
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
<script language="javascript" type="text/javascript" src="../scripts/jquery-1.3.2.min.js"></script>
    <style>
        .DivClose
{
         display:none;
         position:absolute;
         width:250px;
         height:200px;
         border-style:solid;
         border-color:Gray;
         border-width:1px;
         background-color:white;
}
        .DivClose1
{
         display:none;
         position:absolute;
         width:250px;
         height:180px;
         border-style:solid;
         border-color:Gray;
         border-width:1px;
         background-color:white;
}
.LabelClose
{
         vertical-align:text-top;
         position:absolute;
         bottom:15px;
         font-family:Verdana; 
         left:30px;
}

.DivCheckBoxList
{
         display:none;
         background-color:White;
         width:250px;
         position:absolute;
         height:200px;
         overflow-y:auto;
         overflow-x:hidden;
         border-style:solid;
         border-color:Gray;
         border-width:1px;
}
.DivCheckBoxList1
{
         display:none;
         background-color:White;
         width:250px;
         position:absolute;
         height:180px;
         overflow-y:auto;
         overflow-x:hidden;
         border-style:solid;
         border-color:Gray;
         border-width:1px;
}
.CheckBoxList
{
         position:relative;
         width:250px;
         height:10px;
         overflow:scroll;
         font-size:small;
}
.fake-input { position: relative; width:80px; }
.fake-input input { border:none: background:#fff; display:block; width: 100%; box-sizing: border-box }
.fake-input img { position: absolute; top: 4px; right: 2px }
    </style>
</head>
<body style="margin: 0px; background-color: #E4F1F7;" onresize="AdjustHeight();">
 <%--   <asp:HiddenField ID="hdnlistOfCategoryIds" runat ="server" />--%>
    <form id="form1" runat="server">
        <asp:HiddenField ID="hdnlistOfCategoryIds" runat="server" />
        <asp:HiddenField ID="hdnlistOfTypeIds" runat="server" />
         <asp:HiddenField ID="hdnlistofStatusIds" runat="server" />
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="300" />
            <asp:UpdateProgress ID="Progress1" runat="server">
                <ProgressTemplate>
                    <div class="ProgressIndicatorDIV">
                        t
                    <br />
                        <asp:Image ID="Image2" runat="server" ImageUrl="../images/indicator.gif" ImageAlign="AbsMiddle" />
                        <span style="color: #4B92C1; font-size: 14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
                        <br />
                        <br />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <table width="100%" style="height: 100%; margin: 0px; padding: 0px; background-color: #E4F1F7;" cellspacing="0" cellpadding="0" border="0">
                <tr class="UnderlinedRow" style="height: 30px;">
                    <td style="background-color: #A0CDEE; font-size: 12px; font-weight: bold; width: 50%;">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always" RenderMode="Inline">
                            <ContentTemplate>
                                My Tickets &amp; Features &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorCount" />
                                &nbsp;<span class="NonBold">(<asp:Label runat="server" ID="lblFilter" Text="all" />)</span>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                    <td style="background-color: #A0CDEE; padding  : 5px; text-align: right;">
                        <asp:LinkButton ID="lnkResetFilters" runat="server" CssClass="HomeButton">
                            <div style="width: 110px;" class="LeadDetailButton" onclick="javascript:resetFilters();">
                                Reset Filters 
							<img id="Img1" runat="server" src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10" style="border: 0px;" />
                            </div>
                        </asp:LinkButton>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 40px; background-color: #BADCFC; font-size: 11px;">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td style="text-align: left; width: 90px; padding-left: 3px; padding-right: 3px; white-space: nowrap; padding-top: 10px;">
                                    <div id="divNewTicket" runat="server" class="LeadDetailButton" onclick="javascript:StateSaveNewTicket();" style="width: 90px; display: inline-block;">
                                        New Ticket &nbsp;<img align="absMiddle" height="10" src="../images/blt_resetFilters.gif"
                                            width="10" />
                                    </div>
                                </td>
                                <td style="text-align: left; width: 10px; padding-left: 3px; padding-right: 3px; white-space: nowrap;">
                                    <img id="img3" runat="server" src="../images/pixel_darkblue.jpg" width="1" height="30" align="absmiddle" />
                                </td>
                                <td style="text-align: left; width: 80px; padding-left: 3px; padding-right: 3px; white-space: nowrap;">
                                    <span style="font-size: 7pt; color: #7c8798">Clients</span><br />
                                    <asp:DropDownList ID="ddlClients" runat="server"
                                        SkinID="SmallTextCombo"
                                        DataTextField="Name"
                                        DataValueField="ID"
                                        AutoPostBack="True"
                                        Width="80px"
                                        DataSourceID="odsClients">
                                    </asp:DropDownList>&nbsp;
                           <asp:ObjectDataSource ID="odsClients" runat="server" TypeName="Portal.BLL.Users" SelectMethod="GetClientsByUserIDAndSubModuleIDs">
                               <SelectParameters>
                                   <asp:SessionParameter Name="userId" Type="int32" SessionField="AdminID" />
                               </SelectParameters>
                           </asp:ObjectDataSource>
                                </td>
                                <td style="width: 10px; text-align: center;">
                                    <img src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                                </td>
                                <td style="text-align: left; width: 80px; padding-left:10px; padding-right: 3px; white-space: nowrap;text-align:left;">
                                    
                                    <div style="padding-top:5px;" id="divCustomCheckBoxList" runat="server" onmouseover="clearTimeout(timoutID);"
                                        onmouseout="timoutID = setTimeout('HideMList()', 0);" >
                                        <table>
                                            <tr>
                                                <td align="left" class="DropDownLook">
                                                    <span style="font-size: 7pt; color: #7c8798">Categories</span>
                                                    <div class="fake-input">
                                                            <input id="txtSelectedMLValues" type="text" value="Select..."
                                                         style="width: 80px;"  runat="server"  />
                                                           <img id="img6" runat="server" src="../images/drop.png"
                                                        />
                                                     </div>
                                                  
                                                      
                                                </td>
                                                <td align="left" class="DropDownLook">
                                                   <%--   <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle"  OnClientClick ="CloseDiv2();" />--%>
                                                   <%-- <img id="imgShowHide" runat="server" src="../images/drop.png"
                                                        onclick="ShowMList()" align="left" />--%>
                                             </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="DropDownLook">
                                                    <div style="width:50%;">
                                                        <div runat="server" id="divCheckBoxListClose" class="DivClose" style="width:150px;">
                                                      <%--  <label runat="server" onclick="HideMList();"
                                                                class="LabelClose" id="lblClose">
                                                                x</label>--%>
                                                           <%-- <asp:Button ID="btnCategoryFilter" runat="server" Text="FILTER >>" class="LabelClose" style="background-color:#BADCFC; border: 2px solid #4680A6 "/>--%>
                                                        </div>
                                                        <div runat="server" id="divCheckBoxList" class="DivCheckBoxList"  style="width:150px;">
                                                            <asp:CheckBoxList ID="lstMultipleValues" runat="server" 
                                                                Width="150px" CssClass="CheckBoxList" Font-Size="8">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                  <%--    <asp:DropDownList ID="ddlCategories" runat="server"
                                        SkinID="SmallTextCombo"
                                        DataTextField="Name"
                                        DataValueField="ID"
                                        AutoPostBack="True"
                                        Width="80px"
                                        DataSourceID="SDS_Categories">
                                    </asp:DropDownList>&nbsp;
                        <asp:SqlDataSource ID="SDS_Categories"
                            runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                            SelectCommand="PM_Categories_GetAll"
                            SelectCommandType="StoredProcedure"
                            DataSourceMode="DataReader"></asp:SqlDataSource>--%>
                                </td>
                                <td style="text-align: left; width: 10px; padding-left: 3px; padding-right: 3px; white-space: nowrap;">
                                    <img id="Img4" runat="server" src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                                </td>


                                <td style="text-align: left; width: 80px; padding-left: 3px; padding-right: 3px; white-space: nowrap;">
                                   
                                    
                                      <div style="padding-top:5px;" id="divCustomCheckBoxList1" runat="server" onmouseover="clearTimeout(timoutID);"
                                        onmouseout="timoutID = setTimeout('HideMList1()', 0);">
                                        <table>
                                            <tr>
                                                <td align="left" class="DropDownLook">
                                                     <span style="font-size: 7pt; color: #7c8798">Type</span><br />
                                                    <div class="fake-input">
                                                            <input id="txtSelectedMLValues1" type="text" value="Select..." 
                                                         style="width: 80px;" runat="server"  />
                                                           <img id="img7" runat="server" src="../images/drop.png"
                                                        />
                                                     </div>
                                                  
                                                      
                                                </td>
                                                <td align="left" class="DropDownLook">
                                                     <%-- <asp:ImageButton ID="btnTypeFilter" runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" OnClientClick="CloseDiv1();"  />--%>
                                                   <%-- <img id="imgShowHide" runat="server" src="../images/drop.png"
                                                        onclick="ShowMList()" align="left" />--%>
                                             </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="DropDownLook">
                                                    <div style="width:50%;">
                                                        <div runat="server" id="divCheckBoxListClose1" class="DivClose1" style="width:200px; display:none;">
                                                        <%--<label runat="server" onclick="HideMList1();"
                                                                class="LabelClose" id="Label1">
                                                                x</label>--%>
                                                             <%--<asp:Button ID="btnTypeFilter1" runat="server" Text="FILTER >>" class="LabelClose" style="background-color:#BADCFC; border: 2px solid #4680A6 "/>--%>
                                                        </div>
                                                        <div runat="server" id="divCheckBoxList1" class="DivCheckBoxList1"  style="width:200px;">
                                                            <asp:CheckBoxList ID="lstMultipleValues1" runat="server"  
                                                                Width="200px" CssClass="CheckBoxList" Font-Size="8">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>

                                  <%--  <asp:DropDownList ID="ddlTypes" runat="server"
                                        SkinID="SmallTextCombo"
                                        DataTextField="Name"
                                        DataValueField="ID"
                                        AutoPostBack="True"
                                        Width="80px"
                                        DataSourceID="SDS_Type">
                                    </asp:DropDownList>&nbsp;
                          <asp:SqlDataSource ID="SDS_Type" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                              SelectCommand="PM_TaskTypes_GetAll" SelectCommandType="StoredProcedure" DataSourceMode="DataReader"></asp:SqlDataSource>--%>
                                </td>
                                <td style="text-align: left; width: 10px; padding-left: 3px; padding-right: 3px; white-space: nowrap;">
                                    <img id="Img5" runat="server" src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                                </td>

                                <td style="text-align: left; width: 80px; padding-left: 3px; padding-right: 3px; white-space: nowrap;">
                               
                                
                                     <div style="padding-top:5px;" id="divCustomCheckBoxList2" runat="server" onmouseover="clearTimeout(timoutID);"
                                        onmouseout="timoutID = setTimeout('HideMList2()', 0);">
                                        <table>
                                            <tr>
                                                <td align="left" class="DropDownLook">
                                                         <span style="font-size: 7pt; color: #7c8798">Status</span><br />
                                                    <div class="fake-input">
                                                            <input id="txtSelectedMLValues2" type="text" value="Select..." 
                                                       style="width: 80px;" runat="server"  />
                                                           <img id="img8" runat="server" src="../images/drop.png"
                                                         />
                                                     </div>
                                                  
                                                      
                                                </td>
                                                <td align="left" class="DropDownLook">
                                                <%--  <asp:ImageButton ID="btnStatusFilter" runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" OnClientClick="CloseDiv();" />--%>
                                                   <%-- <img id="imgShowHide1" runat="server" src="../images/drop.png"
                                                        onclick="ShowMList()" align="left" />--%>
                                             </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="DropDownLook">
                                                    <div style="width:50%;">
                                                        <div runat="server" id="divCheckBoxListClose2" class="DivClose" style="width:180px;">
                                                     <%--   <label runat="server" onclick="HideMList2();"
                                                                class="LabelClose" id="Label2">
                                                                x</label>--%>
                                                           <%--  <asp:Button ID="btnStatusFilter1" runat="server" Text="FILTER >>" class="LabelClose" style="background-color:#BADCFC; border: 2px solid #4680A6 "/>--%>
                                                        </div>
                                                        <div runat="server" id="divCheckBoxList2" class="DivCheckBoxList"  style="width:180px;">
                                                            <asp:CheckBoxList ID="lstMultipleValues2" runat="server"   
                                                                Width="160px" CssClass="CheckBoxList" Font-Size="8">
                                             
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    
                                     <%--   <asp:DropDownList ID="ddlStatus" runat="server"
                                        SkinID="SmallTextCombo"
                                        AutoPostBack="True"
                                        Width="80px">
                                        <asp:ListItem Text="Select" Value="0" Selected="True" />
                                        <asp:ListItem Text="Not Started" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="In Requirement Gathering" Value="14"></asp:ListItem>
                                        <asp:ListItem Text="Completed" Value="5" Enabled="false"></asp:ListItem>
                                        <asp:ListItem Text="In Design Phase" Value="13"></asp:ListItem>
                                        <asp:ListItem Text="In Progress" Value="4" Enabled="false"></asp:ListItem>
                                        <asp:ListItem Text="In Development Phase" Value="11"></asp:ListItem>
                                        <asp:ListItem Text="In QA Phase" Value="12"></asp:ListItem>
                                        <asp:ListItem Text="On Hold" Value="7"></asp:ListItem>
                                        <%--  <asp:ListItem Text="Feedback Requested" Value="8"></asp:ListItem>
                              <asp:ListItem Text="Feedback Recieved" Value="9"></asp:ListItem>--%>
                                       <%-- <asp:ListItem Text="Confirm Solved" Value="10"></asp:ListItem>

                                        <asp:ListItem Text="UAT Phase" Value="16"></asp:ListItem>
                                        <asp:ListItem Text="Local Production Checkout" Value="17"></asp:ListItem>
                                        <asp:ListItem Text="Ready to go live" Value="18"></asp:ListItem>


                                    </asp:DropDownList>&nbsp;--%>

                                   

                                </td>
                                <td style="text-align: left; width: 10px; padding-left: 3px; padding-right: 3px; white-space: nowrap;">
                                    <img src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                                </td>
                                <td style="text-align: left; width: 100px; padding-left: 6px; padding-right: 3px; white-space: nowrap;">
                                    <span class="GrayHeader">Filter<br />
                                    </span>
                                    <asp:DropDownList
                                        ID="ddlFilter"
                                        runat="server"
                                        SkinID="SmallTextCombo"
                                        AutoPostBack="True" Width="80px">
                                        <asp:ListItem Text="Select..." Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Assigned By Me" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Associated With Me" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Assigned To Me" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="Flagged for Follow-up" Value="4"></asp:ListItem>
                                    </asp:DropDownList>&nbsp;&nbsp;
                                </td>
                                <td style="text-align: left; width: 10px; padding-left: 3px; padding-right: 3px; white-space: nowrap;">
                                    <img src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                                </td>

                                <td style="text-align: left; width: 80px; padding-left: 3px; padding-right: 3px; white-space: nowrap;">
                                    <div style="float: left; width: 100px; text-align: left; padding-left:3px;">
                                        <span class="GreyTextSmall" style="margin-left: 3px;">From Date</span><br />
                                        <span style="margin-left: 0px;">
                                            <asp:TextBox runat="server" ID="txtDateFrom" CssClass="GreyTextBox" Width="60px" Height="18px" onfocus="this.blur();" />
                                            <img id="img2" align="absMiddle"
                                                border="0"
                                                onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtDateFrom.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                                onmouseover="style.cursor='hand';"
                                                src="../images/ico_calendar.jpg" alt="" />
                                        </span>
                                    </div>
                                </td>
                                <td style="text-align: left; width: 80px; padding-left: 3px; padding-right: 3px; white-space: nowrap;">
                                    <div style="float: left; width: 84px; text-align: left;">
                                        <span class="GreyTextSmall">To Date</span><br />
                                        <span>
                                            <asp:TextBox runat="server" ID="txtDateTo" CssClass="GreyTextBox" Width="60px" Height="18px" onfocus="this.blur();" />
                                            <img id="img1" align="absMiddle"
                                                border="0"
                                                onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtDateTo.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                                onmouseover="style.cursor='hand';"
                                                src="../images/ico_calendar.jpg" alt="" />
                                        </span>
                                    </div>
                                </td>
                                <td style="padding-top: 8px; width: 10px; padding-right: 5px; white-space: nowrap;" align="left">
                                    <%--<asp:ImageButton ID="btnSearchDate" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/btn_go.gif" />--%>
                                </td>
                                <td style="text-align: left; width: 10px; padding-left: 3px; padding-right: 3px; white-space: nowrap;">
                                    <img src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                                </td>
                                <td style="text-align: left; width: 130px; padding-left: 3px; padding-right: 3px; white-space: nowrap;">
                                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
                                        <span class="GreyTextSmall">Search</span><br />
                                        <span>
                                            <asp:TextBox ID="txtSearch" runat="server" onkeyup="if(CheckNoisyWord()==false) return false;" onfocus="javascript:this.value='';" MaxLength="50" Width="80px" SkinID="GreenSmallTextbox" />
                                            <asp:ImageButton ID="btnSearch" runat="server" ImageUrl="~/images/btn_go.gif" OnClientClick="if(CheckNoisyWord()==false) return false;" ImageAlign="AbsMiddle" Style="padding-bottom: 2px;" />
                                        </span>
                                    </asp:Panel>
                                </td>
                                <%-- <td style="width:40%;padding-right:5px;" align="right">&nbsp;					
					       </td>--%>
                                <td style="font-size: 12px; font-weight: bold; padding: 3px; color: #437494; text-align: right;">
                                    <div style="width: auto; padding-top: 8px;">
                                        <div style="width: 105px; float: left; margin-right: 5px;" class="LeadDetailButton" onclick="GenerateExcel();">
                                            Export To Excel
                                        </div>
                                    </div>
                                </td>


                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="background-color: #E4F1F7; margin: 0px; padding: 0px; vertical-align: top;">
                        <div style="overflow: auto; height: 100%; background-color: #E4F1F7; border: 1px solid #ACBDD5;" id="_gridViewPanel1" class="ScrollBarHomeTicket">
                            <asp:UpdatePanel ID="UpdatePanel2"
                                runat="server"
                                UpdateMode="Conditional"
                                RenderMode="Inline">
                                <ContentTemplate>
                                    <asp:HiddenField ID="hdnSortBy" runat="server" Value="" />
                                    <asp:HiddenField ID="hdnUserlLogID" runat="server" Value="" />
                                    <asp:HiddenField ID="hdnCurrentPageNumber" runat="server" Value="" />
                                    <asp:GridView ID="gvwMyTickets" runat="server"
                                        SkinID="GridViewWithPaging" EnableViewState="false" AllowSorting="True" DataSourceID ="odsMyTickets"> 
                                        <Columns>
                                            <asp:TemplateField HeaderText="^" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Bold="true" SortExpression="Priority" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderStyle-Width="3%">
                                                <ItemTemplate>
                                                    <span style="display: '<%# IIf(Functions.IFNull(Eval("Status"),"").toString().tolower()  <> "on hold", "inline", "none") %>';">
                                                        <img id="Img1" src="../images/flag_red.gif" runat="server" title='Delayed' visible='<%#  IIf(Eval("DueDate") < DateTime.Now.Date AndAlso (Functions.IFNull(Eval("Status"), "")  <> "Completed" ANDAlso Functions.IFNull(Eval("Status"), "")  <> "Confirm Solved" ), "True", "False") %>' />
                                                        <img id="imgflagDueDate" src='../images/flag_orange.gif' runat="server" title='Due date is near' visible='<%# Eval("ShowDueDateFlag") %>' />
                                                        <img id="imgFlag" src='../images/flag_blue.gif' runat="server" title='Due date is near' visible='<%# Eval("Flag") %>' />
                                                    </span>
                                                    <img src='<%# ConfigurationManager.AppSettings("ImagesURL") & CType(Container.DataItem, Data.DataRowView)("ImageName") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Ref #" SortExpression="RefNo" HeaderStyle-Width="6%">
                                                <ItemTemplate>
                                                    <%#CType(Container.DataItem, Data.DataRowView)("RefNo")%>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Font-Bold="true" />
                                                <HeaderStyle HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Subject" SortExpression="Name" HeaderStyle-Width="25%">
                                                <ItemTemplate>
                                                    <div title="<%# CType(Container.DataItem, Data.DataRowView)("Name")%>">
                                                        <%#Functions.StringTruncate(CType(Container.DataItem, Data.DataRowView)("Name"), 50)%>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status" SortExpression="Status" HeaderStyle-Width="10%">
                                                <ItemTemplate>
                                                    <div title='<%# CType(Container.DataItem, Data.DataRowView)("Status")%>'>
                                                        <%#Functions.StringTruncate(CType(Container.DataItem, Data.DataRowView)("Status"), 15)%>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Category" SortExpression="CatagoryName" HeaderStyle-Width="10%">
                                                <ItemTemplate>
                                                    <div>
                                                        <%#CType(Container.DataItem, Data.DataRowView)("CategoryName")%>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Type" SortExpression="TypeID" HeaderStyle-Width="8%">
                                                <ItemTemplate>
                                                    <div>
                                                        <%#Functions.StringTruncate(CType(Container.DataItem, Data.DataRowView)("TypeName"), 12)%>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Client" HeaderStyle-HorizontalAlign="Left" SortExpression="ClientName" HeaderStyle-Width="5%">
                                                <ItemTemplate>
                                                    <%#CType(Container.DataItem, Data.DataRowView)("ClientName")%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Due Date" SortExpression="DueDate" HeaderStyle-Width="10%">
                                                <ItemTemplate>
                                                    <%#Functions.FormatShortDate(CType(Container.DataItem, Data.DataRowView)("DueDate"))%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Entered on" SortExpression="DateEntered" HeaderStyle-Width="10%">
                                                <ItemTemplate>
                                                    <%#Functions.FormatShortDate(CType(Container.DataItem, Data.DataRowView)("DateEntered"))%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Updated on" SortExpression="LastUpdatedOn" HeaderStyle-Width="10%">
                                                <ItemTemplate>
                                                    <%#Functions.FormatShortDate(CType(Container.DataItem, Data.DataRowView)("LastUpdatedOn"))%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </ContentTemplate>
                               <Triggers>
                                    <%--<asp:AsyncPostBackTrigger ControlID="ddlCategories" EventName="SelectedIndexChanged" />--%>
<%--                                    <asp:AsyncPostBackTrigger ControlID="ddlTypes" EventName="SelectedIndexChanged" />--%>
<%--                                    <asp:AsyncPostBackTrigger ControlID="ddlStatus" EventName="SelectedIndexChanged" />--%>
                                   <asp:AsyncPostBackTrigger ControlID="ddlClients" EventName="SelectedIndexChanged" />
                                   <asp:AsyncPostBackTrigger ControlID="ddlFilter" EventName="SelectedIndexChanged" />
                                   <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                                 <%--  <asp:AsyncPostBackTrigger ControlID="btnSearchDate" EventName="Click" />--%>
                                   <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                          <%--         <asp:AsyncPostBackTrigger ControlID="ImageButton1" EventName="Click" />--%>
                                   <%--<asp:AsyncPostBackTrigger ControlID="btnCategoryFilter" EventName="Click" />
                                   <asp:AsyncPostBackTrigger ControlID="btnTypeFilter" EventName="Click" />
                                   <asp:AsyncPostBackTrigger ControlID="btnStatusFilter" EventName="Click" />--%>
                                </Triggers>
                            </asp:UpdatePanel>
                            <asp:ObjectDataSource ID="odsMyTickets"
                                runat="server"
                                SelectMethod="PM_MYTicketGetAll"
                                EnablePaging="true"
                                StartRowIndexParameterName="StartRowIndex"
                                MaximumRowsParameterName="MaximumRows"
                                SelectCountMethod="PM_MYTicketGetAllCount"
                                TypeName="Portal.BLL.PM.PM_Ticket_Features"
                                SortParameterName="sortExpression">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="ddlClients" Name="ClientID" PropertyName="SelectedValue" Type="Int32" />
                                    <asp:ControlParameter ControlID="hdnlistOfCategoryIds" DefaultValue="0" Name="CategoryID" Type="String" />
                                    <asp:ControlParameter ControlID="hdnlistofStatusIds" DefaultValue="0" Name="StatusID" Type="String"  />
                                    <asp:ControlParameter ControlID="ddlFilter" DefaultValue="0" Name="FilterID" PropertyName="SelectedValue" Type="Int32" />
                                    <asp:ControlParameter ControlID="txtsearch" DefaultValue="" Name="txtsearch" PropertyName="Text" Type="String" />
                                    <asp:ControlParameter ControlID="txtDateFrom" PropertyName="Text" Name="StartDate" />
                                    <asp:ControlParameter ControlID="txtDateTo" PropertyName="Text" Name="EndDate" />
                                    <asp:ControlParameter ControlID="hdnlistOfTypeIds" DefaultValue="0" Name="TypeID"  Type="String" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </div>

                    </td>
                </tr>
                <tr style="background-color: #BADCFC; height: 20px;">
                    <td id="CustomPagerRow"></td>
                    <td align="right" style="padding-right: 10px;">
                        <table cellpadding="0" cellspacing="0" class="GrayHeader">
                            <tr>
                                <td>
                                    <span style="font-size: 7pt; color: #ff0000; height: 7px;">
                                        <img src="../images/btm_flag_red.gif" height="7" alt="Delayed Tickets Flag" /></span>&nbsp;
								Delayed Tickets are in Red flag
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span style="font-size: 7pt; color: #ff0000; height: 7px;">
                                        <img src="../images/btm_flag_orange.gif" height="7" alt="Due Date Approaching Ticket Flag" /></span>&nbsp;
								Due Date Approaching Tickets are in Orange flag
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </form>
    <script type="text/javascript" language="javascript">
      

        AdjustHeight();
        function AdjustHeight() {
            var client_height = $(window).height() - 105;
            $('#_gridViewPanel1').attr('style', 'height:' + client_height + 'px;overflow:auto;background-color:#E4F1F7;border:1px solid #ACBDD5;');
        }

        function resetFilters() {
            window.location = "MyTickets.aspx";
           <%-- var item;
            if (item = document.getElementById('<%= txtSearch.ClientID %>')) {
                item.value = '';
            }
            if (item = document.getElementById('<%= ddlClients.ClientID %>')) {
                item.value = 0;
            }
            <%--if (item = document.getElementById('<%= ddlCategories.ClientID %>')) {
                item.value = 0;
            }--%>
            <%--if (item = document.getElementById('<%= ddlStatus.ClientID %>')) {
                item.value = 0;
            }--%>
           <%-- if (item = document.getElementById('<%= ddlFilter.ClientID %>')) {
                item.value = 0;
            }
            return true;--%>
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
                //$get('<%= txtSearch.ClientID %>').value='';               
            }
        }
    }
        //These Mothods are used to Enable pagging on a TD and Also Empty txtSearch
        function CheckNoisyWord() {
            var mybool = true;
            var InputStr = document.getElementById('<%= txtsearch.ClientID %>').value;
           if (CheckSpecailChar(InputStr) == true) {
               alert("Special characters are not Allowed.\nPlease remove them and try again.");
               document.getElementById('<%= txtSearch.ClientID %>').value = '';
                mybool = false;
                return false;
            }
            if (mybool == false)
                return false;
            else
                return true;
        }
        function StateSaveNewTicket() {
            var URL
            var QueryStringValues = "?txtSearch=" + document.getElementById("<%=txtSearch.ClientID%>").value;
            QueryStringValues += "&ddlClients=" + document.getElementById('<%=ddlClients.ClientID %>').value;
              <%--  QueryStringValues += "&ddlCategories=" + document.getElementById('<%=ddlCategories.ClientID %>').value;--%>
            <%--    QueryStringValues += "&ddlStatus=" + document.getElementById('<%=ddlStatus.ClientID %>').value;--%>
                QueryStringValues += "&ddlFilter=" + document.getElementById('<%=ddlFilter.ClientID %>').value;
                QueryStringValues += "&PrevPage=4"
                URL = "TicketsNew.aspx" + QueryStringValues;
                window.location = URL;
            }
        function OnRowClick(TicketID) {
           
           <%-- var DateFrom = unescape(document.getElementById('<%=txtDateFrom.ClientID %>').value.toString()).replace(/'/gi, "")--%>
            //var DateTo=unescape(document.getElementById('<%=txtDateFrom.ClientID %>').value.toString()).replace(/'/gi, "")
            var locationpath = "TicketsDetail.aspx?ID=" + TicketID + "&ddlClients=" + document.getElementById('<%=ddlClients.ClientID %>').value
                                                      + <%--"&ddlCategories=" + document.getElementById('<%=ddlCategories.ClientID %>').value--%>
                                                     <%-- + "&ddlStatus=" + document.getElementById('<%=ddlStatus.ClientID %>').value--%>
                                                      + "&ddlFilter=" + document.getElementById('<%=ddlFilter.ClientID %>').value
                                                      + "&txtSearch=" + document.getElementById('<%=txtSearch.ClientID %>').value
                                                  + "&txtDateFrom=" + document.getElementById('<%=txtDateFrom.ClientID %>').value
                                                  + "&txtDateTo=" + document.getElementById('<%=txtDateTo.ClientID %>').value
                                                  <%--"&ddlTypes=" + document.getElementById('<%=ddlTypes.ClientID %>').value--%>
                                                  + "&hdnSortBy=" + $("[id$=hdnSortBy]").val()
                                                      + "&PrevPage=4"
                                                  + "&CurrentPageNumber=" + $("[id$=hdnCurrentPageNumber]").val() + "";
            window.location = locationpath;
        }


        function GenerateExcel() {

            var UserLogID = $("[id$=hdnUserlLogID]").val();
            var ClientId = $("[id$=ddlClients] option:selected").val();
            var cid = $("[id$=hdnlistOfCategoryIds]").val()
         

            var CategoryId = '0';
            if (cid != "")
            {
                CategoryId = cid;
            }
            var TId=$("[id$=hdnlistOfTypeIds]").val();
            var typeID = '0'
            if (TId != "") {
                typeID = TId;
            }
             
            var SID=$("[id$=hdnlistofStatusIds]").val();
            var status = '0'
            if (SID != "") {
                status = SID;
            }
            var filter = $("[id$=ddlFilter] option:selected").val();


            var StartDate = $("[id$=txtDateFrom]").val();
            var EndDate = $("[id$=txtDateTo]").val();
            var SortBy = $("[id$=hdnSortBy]").val();

            /** Getting Selected Text **/
            var ClientName = $("[id$=ddlClients] option:selected").text();
            var CName = $("#txtSelectedMLValues").val();
            var CategoryName = "";
            if (CName != "Select...") {
                CategoryName = CName;
            }
           

            var searchtxt = $("[id$=txtSearch]").val();
            var FilterName = $("[id$=ddlFilter] option:selected").text();
            var StName = $("#txtSelectedMLValues2").val();
            var StatusName = "";
            if (StName != "Select...") {
                StatusName = StName;
            }


            var d = new Date();
            var uniqueid = d.getMilliseconds()

            var url = "../ExcelGenerator.ashx?Action=ExportPMTicketsAndFeatures&ClientId=" + ClientId + "&CategoryId=" + CategoryId + "&TypeID=" + typeID + "&Status=" + status + "&StartDate=" + StartDate + "&EndDate=" + EndDate + "&ClientName=" + ClientName + "&CategoryName=" + CategoryName + "&SortBy=" + SortBy + "&UserLogID=" + UserLogID + "&searchtxt=" + searchtxt + "&filter=" + filter + "&FilterName=" + FilterName + "&StatusName=" + StatusName + "&nocache=" + uniqueid;
            window.open(url);

        }
    </script>
    <script type="text/javascript">

   var timoutID;

   //This function shows the checkboxlist
   function ShowMList()
   {
       var divRef = document.getElementById("divCheckBoxList");
       divRef.style.display = "block";
       var divRefC = document.getElementById("divCheckBoxListClose");
       divRefC.style.display = "block";
   }
   function ShowMList1() {
       var divRef = document.getElementById("divCheckBoxList1");
       divRef.style.display = "block";
       var divRefC = document.getElementById("divCheckBoxListClose1");
       divRefC.style.display = "block";
   }
   function ShowMList2() {
       var divRef = document.getElementById("divCheckBoxList2");
       divRef.style.display = "block";
       var divRefC = document.getElementById("divCheckBoxListClose2");
       divRefC.style.display = "block";
   }
   //This function hides the checkboxlist
   function HideMList()
   {
       document.getElementById("divCheckBoxList").style.display = "none";
       document.getElementById("divCheckBoxListClose").style.display = "none";
   }
   function HideMList1() {
       document.getElementById("divCheckBoxList1").style.display = "none";
       document.getElementById("divCheckBoxListClose1").style.display = "none";
   }
   function HideMList2() {
       document.getElementById("divCheckBoxList2").style.display = "none";
       document.getElementById("divCheckBoxListClose2").style.display = "none";
   }

   //This function finds the checkboxes selected in the list and using them,
   //it shows the selected items text in the textbox (comma separated)
   function FindSelectedItems(sender,textBoxID)
   {
       var cblstTable = document.getElementById(sender.id);
       var checkBoxPrefix = sender.id + "_";
       var noOfOptions = cblstTable.rows.length;
       var selectedText = "";
       var defaultText = "Select...";
       var selectedval="";
       for(i=0; i < noOfOptions ; ++i)
       {
          if(document.getElementById(checkBoxPrefix+i).checked)
          {
              if (selectedText == "") {
                  selectedText = document.getElementById
                                     (checkBoxPrefix + i).parentNode.innerText;
                  
                 // var selectedval = $("#"+checkBoxPrefix + i).closest('span').attr('data-value')
                  selectedval = $("#" + checkBoxPrefix + i).parent().parent().find("span").attr("data-value")
                  
              }
              else {
                  selectedText = selectedText + "," +
                   document.getElementById(checkBoxPrefix + i).parentNode.innerText;
                  selectedval =selectedval+","+ $("#" + checkBoxPrefix + i).parent().parent().find("span").attr("data-value")
                  
              }
             
              

          }
       }
       
       //alert( $('#hdnlistOfCategoryIds').val());
       if (textBoxID.id == "txtSelectedMLValues") {
           $('#hdnlistOfCategoryIds').val(selectedval)
       }
       else if (textBoxID.id == "txtSelectedMLValues1") {
           $('#hdnlistOfTypeIds').val(selectedval)
       
       }
       
       else if (textBoxID.id == "txtSelectedMLValues2") {
           $('#hdnlistofStatusIds').val(selectedval)
       }
       if (selectedText == "") {
           document.getElementById(textBoxID.id).value = defaultText;
       }
       else {
           document.getElementById(textBoxID.id).value = selectedText;
           document.getElementById(textBoxID.id).title = selectedText;
       }
   }
   function CloseDiv() {
       HideMList2();
       return true;
   }
   function CloseDiv1() {
       HideMList1();
       return true;
   }
   function CloseDiv2() {
       HideMList();
       return true;
   }
   $('#txtSelectedMLValues ,#img6').click(function (e) {
       e.stopPropagation();
       HideMList1();
       HideMList2();
       ShowMList();
   });
   $('#txtSelectedMLValues1 ,#img7').click(function (e) {
       e.stopPropagation();
       HideMList();
       HideMList2();
       ShowMList1();
       e.stopPropagation();
   });
   $('#txtSelectedMLValues2 ,#img8').click(function (e) {
       e.stopPropagation();
       HideMList1();
       HideMList();
       ShowMList2();
   });

   $('body').click(function () {
   
       HideMList();
       HideMList1();
       HideMList2();
   });
   $('#divCustomCheckBoxList').click(function (e) {
       e.stopPropagation();
   });
   $('#divCustomCheckBoxList1').click(function (e) {
       e.stopPropagation();
   });
   $('#divCustomCheckBoxList2').click(function (e) {
       e.stopPropagation();
   });
</script>
    <style>
        .SimpleHomeRow td, GridRowClickable td, .HighlightedHomeRow td, .TextWrap, .GView td, .FloatingHeader th {
            font-size: 12px !important;
        }
    </style>
</body>
</html>

