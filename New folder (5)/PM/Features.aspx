<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Features.aspx.vb" Inherits="PM_Features" Theme="Default"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript"  src="../scripts/functions.js" language="javascript" ></script>
    <script language="javascript" type="text/javascript" src="../scripts/jquery-1.3.2.min.js" ></script>
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=0.2)" />
    <meta http-equiv="Page-Enter" content="progid:DXImageTransform.Microsoft.Fade(Duration=0.2)" />
    <style>
        .SimpleHomeRow td, GridRowClickable td, .HighlightedHomeRow td, .TextWrap, .GView td, .FloatingHeader th{
            font-size:12px !important;
        }
    </style>
</head>
<body style ="margin :0px;background-color:#E4F1F7;  width:100%; height:100%; ">
    <form id="form1" runat="server"><asp:HiddenField  ID="hdnClient" runat="server" /><asp:HiddenField ID="hdnCatagory" runat="server" />
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
     <asp:HiddenField ID="ReleaseID" runat="server" />
          <asp:HiddenField ID="PMHidden" runat="server" />
     <asp:HiddenField ID="hdnReleaseName" runat="server" />
     <asp:HiddenField ID="PrevPage" runat="server" Value="0" /> 
     <asp:HiddenField ID="hdnSortBy" runat="server" Value="" /> 
    <table style="height:100%; width:100%; " cellspacing="0" border="0"  >
     <tr class="UnderlinedRow" style="height:5%; width:100%;">
         <td  style="height:20px;background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:5px;width:50%; ">
              Release:&nbsp;<asp:Label ID="lblReleaseName" runat="server" Text=""></asp:Label>
              <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                           &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label runat="server" ID="lblErrorCount" />
                            &nbsp;<span class="NonBold">(<asp:Label runat="server" ID="lblFilter" Text="all" />)</span>
                        </ContentTemplate>
                         <Triggers >
                          <asp:AsyncPostBackTrigger ControlID="ddlCategories" EventName="SelectedIndexChanged" />
                          <asp:AsyncPostBackTrigger ControlID="ddlStatus" EventName="SelectedIndexChanged" />
                          <asp:AsyncPostBackTrigger ControlID="ddlClients" EventName="SelectedIndexChanged" />
                          <asp:AsyncPostBackTrigger ControlID="ddlTypes" EventName="SelectedIndexChanged" />
                          <asp:AsyncPostBackTrigger ControlID="ddlFilter" EventName="SelectedIndexChanged" />
                          <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                          <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                          </Triggers>
               </asp:UpdatePanel>

        </td>
         <td style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right; white-space:nowrap;width:50%;">
             <asp:LinkButton ID="btnBack" runat="server" CssClass="HomeButton"> <div style="width:110px;" class="LeadDetailButton" >
                 <img  src="../images/blt_Back.gif" align="absmiddle" width="10" height="10"  style="border:0px;" />
                 Back </div></asp:LinkButton>
             &nbsp;&nbsp;
             <img align="absMiddle"  height="20" src="../images/pixel_skyBlue.jpg" width="1" />
             &nbsp;&nbsp;
             <asp:LinkButton ID="lnkResetFilters" runat="server" CssClass="HomeButton"> <div style="width:110px;" class="LeadDetailButton" onclick="javascript:resetFilters();">
                    Reset Filters <img  src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10"  style="border:0px;" /></div></asp:LinkButton>
            
             <img  align="absmiddle" src="../images/pixel_skyBlue.jpg" width="1" height="20" />
            
         </td>                        
     </tr>              
     <tr style="height:5%; width:100%;">
        <td colspan="2" style="background-color:#BADCFC;font-size:11px;">
          <table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%; white-space:nowrap;">
            <tr>
              <td style="padding:5px;text-align:left ; white-space:nowrap; padding-right:1em; padding-top:13px; ">
                <div id="btnnewfeature" runat="server" style="width: 100px;" onclick="javascript:StateSaveNewFeature();" class="LeadDetailButton"  >
                  NEW FEATURES
                  <img align="absMiddle"  height="10" src="../images/blt_resetFilters.gif" width="10" /> 
                  </div>
              </td>
              <td style="width:30px;text-align:center;">
                 <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
              </td>
              <td style="padding-left:5px; padding-right:5px;"  >
                  <span style="font-size: 7pt; color: #7c8798">Categories<br />
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
                     SelectCommand="PM_Categories_GetAll" 
                     SelectCommandType="StoredProcedure"
                     DataSourceMode="DataReader">
                  </asp:SqlDataSource>
              </td>
              <td style="width:30px;text-align:center;">
                 <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
              </td>
              <td style="padding-left:5px; padding-right:5px;"  >
                  <span style="font-size: 7pt; color: #7c8798">Status<br />
                  </span>
				 <asp:DropDownList ID="ddlStatus" runat="server" 
							SkinID="SmallTextCombo"
							AutoPostBack="True"
							Width="100px">
						  <asp:ListItem Text="Select" Value="0" Selected="True" />
						  <asp:ListItem Text="Not Started" Value="2" />
						  <asp:ListItem Text="In Progress" Value="4" />
						  <asp:ListItem Text="On Hold" Value="7" />
						  <asp:ListItem Text="Feedback Requested" Value="8" />
						  <asp:ListItem Text="Feedback Received" Value="9" />
						  <asp:ListItem Text="Confirm Solved" Value="10" />
						  <asp:ListItem Text="Completed" Value="5" />
					  </asp:DropDownList>&nbsp;
              </td>
              <td style="width:10px;text-align:center;">
                  <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
              </td>
              <td align="left" style="padding-left:5px; padding-right:5px; ">
                <span style="font-size: 7pt; color: #7c8798"><span style="font-size: 7pt; color: #7c8798">
                    Clients&nbsp;</span><br />
                    <asp:DropDownList ID="ddlClients" runat="server" AutoPostBack="True" DataSourceID="odsClients"
                        DataTextField="Name" DataValueField="ID" SkinID="SmallTextCombo" Width="110px">
                    </asp:DropDownList>&nbsp;
                     <asp:ObjectDataSource ID="odsClients" runat="server" TypeName="Portal.BLL.Users" SelectMethod="GetClientsByUserIDAndSubModuleIDs">
                           <SelectParameters>
                                <asp:SessionParameter Name="userId" Type="int32" SessionField="AdminID" />                                 
                           </SelectParameters>
                       </asp:ObjectDataSource>
                </span>
                
                 </td> 
                 <td style="width:30px;text-align:center;display:none;">
                 <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
              </td>
              <td style="padding-left:5px; padding-right:5px;display:none;"  >
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
                   <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" /> 
              </td> 
               <td style="padding-left:5px; padding-right:5px; "  >
                  <span class="GrayHeader">Filter<br />
                  </span>
                    <asp:DropDownList 
                    ID="ddlFilter" 
                    runat="server" 
                    SkinID="SmallTextCombo"
                    AutoPostBack="True" EnableViewState="false" Width="120px">
                  </asp:DropDownList>&nbsp;&nbsp;
               </td>
             <td style="width:10px;text-align:center;">
                  <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
             </td>
              <td style="padding:3px; white-space:nowrap;" align="left" >
                 <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
                       <span class="GreyTextSmall"><span style="color: #000000"></span>Search</span><br />
                       <span>
                           <asp:TextBox ID="txtSearch"  runat="server" MaxLength="50" onfocus="javascript:this.value='';"
                               SkinID="GreenSmallTextbox" onkeyup="if(CheckNoisyWord()==false) return false;" Width="100px"></asp:TextBox>
                           <asp:ImageButton ID="btnSearch" OnClientClick="if(CheckNoisyWord()==false) return false;" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/btn_go.gif" />
                       </span>
                   </asp:Panel>
              </td>
                <td style="font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right;">
                      <div style="width:auto; padding-top:8px;">
                        <div id="Expbtn" style="width: 110px;float:left;margin-right:5px;" class="LeadDetailButton" onclick="GenerateExcel();" >
                            Export To Excel
                        </div>
                     </div>
                       </td>
            <td style="width:50%;">
              &nbsp;&nbsp;
              </td>
           </tr>
         </table>
       </td>
     </tr>
     <tr style=" height:85%; width:100%;">
       <td  colspan="2" style="background-color:#E4F1F7;  vertical-align:top; margin:0px;padding:0px;">
            <div style="width:100%; height:100%; overflow:auto;  background-color:#E4F1F7;border:1px solid #ACBDD5;" class="ScrollBarHomeTicket" >
            <asp:UpdatePanel ID="UpdatePanel2"
             runat="server" 
             UpdateMode="Always"
             RenderMode="Inline">
             <ContentTemplate>
                 <asp:HiddenField ID="hdnUserlLogID" runat="server" Value="" />
                <asp:GridView 
                ID="gvReleases" 
                runat="server" 
                AutoGenerateColumns="False" 
                EnableTheming="True" 
                SkinID="GridViewWithPaging"
                AllowSorting="True" DataKeyNames="ID" DataSourceID="odsRecentTickets" OnRowDataBound ="gvReleases_RowDataBound1">                 
                <Columns>
                        <asp:TemplateField HeaderText="^"  HeaderStyle-HorizontalAlign="Center"  HeaderStyle-Font-Bold="true" SortExpression="Priority" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" >
                            <ItemTemplate>
							<span style="display:'<%# IIf(Functions.IFNull(Eval("Status"),"").toString().tolower()  <> "on hold", "inline", "none") %>';">
								<img id="Img1" src="../images/flag_red.gif" runat="server" title='Delayed' visible='<%#  IIf(Eval("DueDate") < DateTime.Now.Date AndAlso (Functions.IFNull(Eval("Status"), "")  <> "Completed" ANDAlso Functions.IFNull(Eval("Status"), "")  <> "Confirm Solved" ), "True", "False") %>'/>										
								<img id="imgflagDueDate" src='../images/flag_orange.gif' runat="server"  title='Due date is near' visible='<%# Eval("ShowDueDateFlag") %>' />
							</span>
							<img src='<%# ConfigurationManager.AppSettings("ImagesURL") & CType(Container.DataItem, Data.DataRowView)("ImageName") %>' />
							</ItemTemplate>
                            <ItemStyle Width="2%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Ref #" SortExpression="RefNo">
                            <ItemTemplate>
                                <%#CType(Container.DataItem, Data.DataRowView)("RefNo")%>
                            </ItemTemplate>
                                <ItemStyle Width="5%" HorizontalAlign="Center" Font-Bold="true"  />
                                <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                            <asp:TemplateField HeaderText="Subject" SortExpression="Name">
                            <ItemTemplate>
                                <span title='<%# CType(Container.DataItem, Data.DataRowView)("Name")%>'>
                                    <%# Functions.StringTruncate(CType(Container.DataItem, Data.DataRowView)("Name"), 60)%>
                                </span>
                            </ItemTemplate>
                                <ItemStyle Width="25%"/>
                        </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status" SortExpression="Status">
                            <ItemTemplate>                                    
                                <%#CType(Container.DataItem, Data.DataRowView)("Status")%>                                    
                            </ItemTemplate>
                            <ItemStyle Width="10%"/>
                        </asp:TemplateField>                                 
                        <asp:TemplateField HeaderText="Due Date" SortExpression="DueDate">
                            <ItemTemplate>
                                <%#Functions.FormatShortDate(CType(Container.DataItem, Data.DataRowView)("DueDate"))%>
                            </ItemTemplate>
                            <ItemStyle Width="10%" />
                        </asp:TemplateField>    
     <%--<asp:BoundField  DataField="SowSignedDate" HeaderText="Sow Signed Date" SortExpression="SowSignedDate" DataFormatString="{0:d}" HtmlEncode="False" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />--%>

                         <asp:TemplateField HeaderText="SOW Signed Date" SortExpression="SowSignedDate">
                            <ItemTemplate>
                                <%#Functions.FormatShortDate(CType(Container.DataItem, Data.DataRowView)("SowSignedDate"))%>
                            </ItemTemplate>
                            <ItemStyle Width="10%" />
                        </asp:TemplateField> 
                    <asp:TemplateField HeaderText="CRB Approved Date" SortExpression="CRBApprovedDate">
                            <ItemTemplate>
                           <%#Functions.IfNull(Functions.FormatShortDate(CType(Container.DataItem, Data.DataRowView)("CRBApprovalDate")),"")%>
                            </ItemTemplate>
                            <ItemStyle Width="10%" />
                        </asp:TemplateField>                                  
                        <asp:TemplateField HeaderText="Entered on" SortExpression="DateEntered">
                            <ItemTemplate>
                                <%#Functions.FormatShortDate(CType(Container.DataItem, Data.DataRowView)("DateEntered"))%>
                            </ItemTemplate>
                            <ItemStyle Width="8%"/>
                        </asp:TemplateField>                                
                        <asp:TemplateField HeaderText="Updated on" SortExpression="LastUpdatedOn">
                            <ItemTemplate>                                    
                                <%#Functions.FormatShortDate(CType(Container.DataItem, Data.DataRowView)("LastUpdatedOn"))%>
                            </ItemTemplate>
                            <ItemStyle Width="10%"/>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Assigned by" SortExpression="AssignedBy">
                            <ItemTemplate>                                    
                                <%#CType(Container.DataItem, Data.DataRowView)("AssignedBy")%>
                            </ItemTemplate>
                            <ItemStyle Width="9%"/>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Type" SortExpression="TypeName">
                            <ItemTemplate>                                    
                                <%#CType(Container.DataItem, Data.DataRowView)("TypeName")%>
                            </ItemTemplate>
                            <ItemStyle Width="10%"/>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                </ContentTemplate>
                          <Triggers>
                          <asp:AsyncPostBackTrigger ControlID="ddlCategories" EventName="SelectedIndexChanged" />
                          <asp:AsyncPostBackTrigger ControlID="ddlStatus" EventName="SelectedIndexChanged" />
                          <asp:AsyncPostBackTrigger ControlID="ddlClients" EventName="SelectedIndexChanged" />
                          <asp:AsyncPostBackTrigger ControlID="ddlTypes" EventName="SelectedIndexChanged" />
                          <asp:AsyncPostBackTrigger ControlID="ddlFilter" EventName="SelectedIndexChanged" />
                          <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                          <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                          </Triggers>
                    </asp:UpdatePanel>
                <asp:ObjectDataSource ID="odsRecentTickets" 
							runat="server"
							StartRowIndexParameterName="StartRowIndex"
							MaximumRowsParameterName="MaximumRows"
							SelectMethod="PM_TicketGetAll"
							SortParameterName="SortExpression"
							EnablePaging="True"
							SelectCountMethod="PM_TicketGetAllCount" 
							TypeName="Portal.BLL.PM.PM_Ticket_Features">
							<SelectParameters>
                                <asp:ControlParameter ControlID="ReleaseID" DefaultValue="1" Name="ReleaseId" PropertyName="Value" Type="Int32" />
								<asp:ControlParameter ControlID="ddlClients" Name="ClientID" PropertyName="SelectedValue" Type="Int32" />
								<asp:ControlParameter ControlID="ddlCategories" DefaultValue="1" Name="CategoryID" PropertyName="SelectedValue" Type="String" />
								<asp:ControlParameter ControlID="ddlStatus" DefaultValue="0" Name="StatusID" PropertyName="SelectedValue" Type="String" />
								<asp:ControlParameter ControlID="ddlTypes" DefaultValue="0" Name="TypeID" PropertyName="SelectedValue" Type="String" />
								<asp:ControlParameter ControlID="ddlFilter" DefaultValue="0" Name="FilterID" PropertyName="SelectedValue" Type="Int32" />								
                                <asp:Parameter Name="WaitingForUserID" DefaultValue="0" />                                
								<asp:ControlParameter ControlID="txtSearch" DefaultValue="" Name="Search" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
							</SelectParameters>
						</asp:ObjectDataSource>                
            </div>
       </td>
     </tr>
     <tr style="height:20px; background-color:#BADCFC;" >
         <td align="left" style="width:75%;" id="CustomPagerRow">
        </td>
        <td align="left"  style="width:25%;white-space:nowrap; padding-left:60px;" class="GrayHeader">
            <span style="font-size:7pt; color: #ff0000">*</span>
            UnRead Features are in Yellow Color<br />
            <span style="font-size:7pt; color: #ff0000; height:7px;"><img  src="../images/pm_flag.gif" height="7"  alt="*"/></span>
                Delayed Features are in Red flag 
        </td>
     </tr>
    </table>
    </div>
    </form>
    
</body>
<script type="text/javascript" language="javascript">
    $(document).ready(function () {
      

        if ($("#<%= PMHidden.ClientID  %>").val() == 0)
        {
          // $('#Expbtn').css('display', 'none')
        }
    });


 function resetFilters()
    {      
        var item;
        if (item = document.getElementById('<%= txtSearch.ClientID %>')) {
        	item.value = '';
        }
        if (item = document.getElementById('<%= ddlCategories.ClientID %>')) {
        	item.value = 0;
        }
        if (item = document.getElementById('<%= ddlStatus.ClientID %>')) {
        	item.value = 0;
        }
        if (item = document.getElementById('<%= ddlClients.ClientID %>')) {
        	item.value = 0;
        }
        if (item = document.getElementById('<%= ddlTypes.ClientID %>')) {
        	item.value = 0;
        }
        if (item = document.getElementById('<%= ddlFilter.ClientID %>')) {
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
    	//		$get('<%= txtSearch.ClientID %>').value = '';
    		}
    	}
    }
    //These Mothods are used to Enable pagging on a TD and Also Empty txtSearch
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
            function StateSaveNewFeature(){
            var URL
           var QueryStringValues = "?txtSearch="+document.getElementById ("<%=txtSearch.ClientID%>").value;
            QueryStringValues += "&ddlClients=" + document.getElementById('<%=ddlClients.ClientID %>').value;
            QueryStringValues += "&ddlCategories=" + document.getElementById('<%=ddlCategories.ClientID %>').value;
            QueryStringValues += "&ddlStatus=" + document.getElementById('<%=ddlStatus.ClientID %>').value; 
            QueryStringValues += "&ddlFilter=" + document.getElementById('<%=ddlFilter.ClientID %>').value;  
            QueryStringValues += "&ddlTypes=" + document.getElementById('<%=ddlTypes.ClientID %>').value;  
            QueryStringValues += "&ReleaseID=" + document.getElementById('<%=ReleaseID.ClientID %>').value;
            QueryStringValues += "&reClient=" + document.getElementById('<%=hdnClient.ClientID %>').value;
            QueryStringValues += "&reCatagory=" + document.getElementById('<%=hdnCatagory.ClientID %>').value;
            QueryStringValues += "&PrevPage=4"
            URL="FeaturesNew.aspx" + QueryStringValues ;
            window.location=URL;
            }

    function GenerateExcel() {
        
        var UserLogID = $("[id$=hdnUserlLogID]").val();
        var ClientId = $("[id$=ddlClients] option:selected").val();
        var CategoryId = $("[id$=ddlCategories] option:selected").val();
        var typeID = $("[id$=ddlTypes] option:selected").val();

        var status = $("[id$=ddlStatus] option:selected").val();
        var filter = $("[id$=ddlFilter] option:selected").val();


        //var StartDate = $("[id$=txtDateFrom]").val();
        //var EndDate = $("[id$=txtDateTo]").val();
        var SortBy = $("[id$=hdnSortBy]").val();

        /** Getting Selected Text **/
        var ClientName = $("[id$=ddlClients] option:selected").text();
        var CategoryName = $("[id$=ddlCategories] option:selected").text();
        var searchtxt = $("[id$=txtSearch]").val();
        var FilterName = $("[id$=ddlFilter] option:selected").text();
        var StatusName = $("[id$=ddlStatus] option:selected").text();
        var ReleaseID = $("[id$=ReleaseID]").val(); 
        var ReleaseName = $("[id$=hdnReleaseName]").val();

        var d = new Date();
        var uniqueid = d.getMilliseconds()

        var url = "../ExcelGenerator.ashx?Action=ExportPMCurrentReleases&ClientId=" + ClientId + "&CategoryId=" + CategoryId + "&TypeID=" + typeID + "&Status=" + status + "&ClientName=" + ClientName + "&CategoryName=" + CategoryName + "&SortBy=" + SortBy + "&UserLogID=" + UserLogID + "&searchtxt=" + searchtxt + "&filter=" + filter + "&FilterName=" + FilterName + "&StatusName=" + StatusName + "&ReleaseID=" + ReleaseID + "&ReleaseName=" + ReleaseName + "&nocache=" + uniqueid;
        window.open(url);

    } function AnotherFunction() {

    }
</script>
</html>