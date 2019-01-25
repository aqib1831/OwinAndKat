<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Franchisor_StoreInbox.aspx.vb" Inherits="MyNetsolace_Help_Desk_FranchiseeInbox" Theme="Default" %>

<%@ Register Src="Controls/VitalInformationFloatingDiv.ascx" TagName="VitalInformationFloatingDiv" TagPrefix="CsCtrl" %> 

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">    
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js" ></script>
</head>
<body style ="margin :0px;background-color:#E4F1F7;"  >
    <form id="form1" runat="server">
    <div id="divDisable" class="modalBackground"></div>
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
        <table style="width:100%;height:100%;background-color:#BADCFC;" border="0" cellspacing="0" cellpadding="0"  class="MainTable">
          <tr>
           <td style="width:27px;">		   
				<CsCtrl:VitalInformationFloatingDiv ID="VitalInformationFloatingDiv" runat="server" />			
		   </td>          
           <td onclick="if (blnShowed == true){showHideVital();}">
                <table width="100%" style="height:100%; margin:0px; padding:0px;background-color:#BADCFC; " cellspacing="0" cellpadding = "0" border="0"  >
                     <tr class="UnderlinedRow">
                         <td  colspan="3" style="height:20px;background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:5px;width:60%;">
                          <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                           <ContentTemplate>
                             Inbox Tickets (&nbsp;<asp:Label runat="server" ID="lblFranchiseName" />&nbsp;)&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label runat="server" ID="lblActivityCount" Text="0"/>
                                    &nbsp;<span class="NonBold">(<asp:Label runat="server" ID="lblFilter" Text="all" />)</span>                                    
                            <asp:HiddenField ID="hdnFranchiseID" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnStoreID" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnOwnerID" runat="server" Value="0" />
                            </ContentTemplate>
                                <Triggers >                                                                    
                                      <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                                                                    
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                        <td style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right;cursor:pointer; height: 1px;border-bottom:1 solid #609BD3;width:40%;">   
							 &nbsp;
							 <asp:LinkButton ID="btnNewActivity" runat="server" CssClass="HomeButton">
								<div style="width:110px;" class="LeadDetailButton" onclick="javascript:window.location='AddActivity.aspx?FranchiseID=<%= Request.QueryString("FranchiseID").ToString() %>&ClientID=<%= Request.QueryString("ClientID").ToString() %>&PrevPage=6'; return false;">
									&nbsp;&nbsp; New Ticket 
									<img  src="../images/blt_resetfilters.gif" align="absmiddle" width="10" height="10" style="border:0px;" alt="" />
								</div>
							 </asp:LinkButton>
						 </td>
                     </tr>              
                     <tr>
                        <td colspan="4" style="height:40px;background-color:#BADCFC;font-size:11px;">
                          <table border="0" cellpadding="0" cellspacing="0" style="white-space:nowrap;">
                            <tr>
                            <td style="padding-left:5px;"><span style="font-size: 7pt; color: #7c8798">Related To:</span><br />
                                    <asp:DropDownList ID="ddlProducts" 
                                    CssClass="SmallGreenTextBox" 
                                    runat="server" 
                                    Width="100px" 
                                    AutoPostBack="true" 
                                    DataSourceID="SDS_Products" 
                                    DataTextField="Title" 
                                    DataValueField="ID" >
                                </asp:DropDownList>

                                <asp:SqlDataSource ID="SDS_Products" runat="server" ConnectionString="<%$ConnectionStrings:PortalConnectionString%>"
                                        SelectCommand="NS_Products_GetAllForModules_ByClientID" SelectCommandType="StoredProcedure" DataSourceMode="DataReader">
                                        <SelectParameters>
                                        	<asp:SessionParameter Name="ClientId" SessionField="MyNetsolace_ClientID" DefaultValue="1" />
                                    	</SelectParameters>
                                </asp:SqlDataSource>

                            </td>   
                            <td style="width:10px;text-align:center;">
                               <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" /> 
                            </td> 
                                <td align="left">
                                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
                                        <span class="GreyTextSmall">Search</span><br />
                                        <asp:TextBox ID="txtSearch" runat="server" onfocus="javascript:this.value='';" MaxLength="50" Width="100px" SkinID="GreenSmallTextbox" /><asp:ImageButton ID="btnSearch" runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />                                        
                                    </asp:Panel>
                                </td>
                                <td style="width:10px;text-align:center;">
                               <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" /> 
                            </td> 
                                <td><div style="width: 55px; height: 23px;" class="LeadDetailButton" onclick="javascript:window.location='FranchisorHistory.aspx?FranchiseID=<%= Request.QueryString("FranchiseID").ToString() %>&ClientID=<%= Request.QueryString("ClientID").ToString() %>'; return false;">
                                            History
                                        </div></td>
                            </tr>
                         </table>
                       </td>                        
                     </tr>
                     <tr>
                       <td  colspan="4" style="background-color:#E4F1F7;margin:0px;padding:0px;">
                            <div style="overflow:auto;height:100%;background-color:#E4F1F7;border:1px solid #ACBDD5;" id="_gridViewPanel1"  class="ScrollBarHomeTicket">
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
                                            <asp:TemplateField ItemStyle-Width="5%" HeaderText="" >
                                            <ItemTemplate  >
                                                 <img src='<%# ConfigurationManager.AppSettings("ImagesURL") %><%# Functions.GetActivityImage(Eval("Activity_Type")) %>'  />&nbsp;
                                                 <asp:Label ID="lblID" runat="server" Visible="false" Text='<%#Eval("Activity_ID") %>' ></asp:Label>
                                                 <asp:Label ID="lblAdminReadStatus" runat="server" Visible="false" Text='<%#Eval("AdminReadStatus") %>' ></asp:Label>
                                                 <asp:Label runat="server" ID="lblIntType" Visible="false" Text='<%# Eval("ActivityState")%>' ></asp:Label>                                        
                                            </ItemTemplate>                                            
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-Width="10%" HeaderText="Ticket #" SortExpression="Ticket">
                                            <ItemTemplate >
                                                <asp:Label runat="server" ID="lblTicketNumber" Text='<%# Functions.GetActivityPrefix(Eval("Activity_Type")) &  Eval("Activity_ID")%>' ></asp:Label>                                        
                                            </ItemTemplate>
                                            </asp:TemplateField> 
                                             <asp:TemplateField HeaderText="Type" ItemStyle-Width="10%" SortExpression="Type" >
                                                <ItemTemplate >
                                                    <asp:Label runat="server" ID="lblType" Text='<%# Functions.getActivityCaption(Eval("Activity_Type"))%>' ></asp:Label>                                        
                                                </ItemTemplate>
                                            </asp:TemplateField>                                    
                                             <asp:TemplateField ItemStyle-Width="20%" HeaderText="Subject" SortExpression="Subject">
                                                <ItemTemplate >
                                                <span title='<%# Functions.IfNull(Eval("Subject"), "") %>' >
                                                    <asp:Label runat="server" ID="lblSubject" Text='<%# Functions.StringTruncate(Functions.IfNull(Eval("Subject"), ""), 25) %>' ></asp:Label>
                                                </span>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-Width="20%" HeaderText="Related To" SortExpression="RelatedTo">
                                                <ItemTemplate >                                                
                                                    <%# Eval("Abbreviation")%>
                                                </ItemTemplate>
                                            </asp:TemplateField>   
                                            <asp:TemplateField ItemStyle-Width="15%" HeaderText="Created" SortExpression="Date">
                                                <ItemTemplate >
                                                    <asp:Label runat="server" ID="lblDate" Text='<%# Functions.DateDiffInWords(Eval("Activity_Date"))%>' ></asp:Label>                                        
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Last Updated" ItemStyle-Width="15%" SortExpression="LastUpdatedOn" Visible="true" >
                                               <ItemTemplate >
                                                   <asp:Label runat="server" ID="lblLastActivity" Text='<%# Functions.DateDiffInWords(Eval("LastUpdatedOn"))%>' ToolTip='<%#Eval("LastUpdatedOn") %>' ></asp:Label>
                                               </ItemTemplate>
                                           </asp:TemplateField>                                                                             
                                        </Columns>
                                    </asp:GridView>
                                     </ContentTemplate>
                                          <Triggers >                                                                            
                                          <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                                          <asp:AsyncPostBackTrigger ControlID="ddlProducts" EventName="SelectedIndexChanged" />
                                          </Triggers>
                                    </asp:UpdatePanel>    
                                   <asp:ObjectDataSource ID="sdsInbox" runat="server" 
                                            SelectMethod="GetHelpDeskInboxForMyNetsolace"
                                            SelectCountMethod="GetHelpDeskInboxCountForMyNetsolace" 
                                            EnablePaging="true"
                                            SortParameterName="sortExpression"
                                            TypeName="Portal.BLL.Activities">
                                            <SelectParameters>
                                              <asp:ControlParameter  Name="ClientID" Type="Int32" ControlID="hdnClientID" PropertyName="Value" />                      
                                              <asp:ControlParameter  Name="FranchiseID" Type="Int32" ControlID="hdnFranchiseID" PropertyName="Value" />
                                              <asp:ControlParameter  Name="ProductId" Type="Int32"  ControlID="ddlProducts" PropertyName="SelectedValue" />
                                              <asp:ControlParameter  Name="Search" Type="String" ControlID="txtSearch" PropertyName="Text" DefaultValue=""  ConvertEmptyStringToNull="true"/>
                                              <asp:Parameter  Name="ReturnValue" Type="Int32"  Direction="Output" />
                                            </SelectParameters>
                                    </asp:ObjectDataSource> 
                            </div>
                           
                       </td>
                     </tr>  
            <tr>
             <td style="background-color:#BADCFC; height:20px; padding:3px;font-size:12px;font-weight:bold;" colspan="4" > 
             History
             </td>
             </tr>
              <tr>
               <td  colspan="4" style="background-color:#E4F1F7;margin:0px;padding:0px;">
                    <div style="overflow:auto;height:100%;background-color:#E4F1F7;border:1px solid #ACBDD5;" id="Div1" class="ScrollBarHomeTicket">
                      <asp:UpdatePanel ID="UpdatePanel3"
                         runat="server" 
                         UpdateMode="Always"
                         RenderMode="Inline">
                         <ContentTemplate>
                         <asp:GridView 
                            ID="gvHistory" 
                            runat="server" 
                             AllowPaging ="false" 
                            AutoGenerateColumns="False" 
                            EnableTheming="True" 
                            EnableViewState="false"
                            SkinID="GridViewNormal"                         
                            AllowSorting="True"                             
                            DataSourceID="odsCompletedActivities" > 
                             <Columns>                                                              
                                    <asp:TemplateField ItemStyle-Width="5%" HeaderText="" >
                                    <ItemTemplate  >
                                         <img src='<%= ConfigurationManager.AppSettings("ImagesURL") %><%# Functions.GetActivityImage(Eval("Type")) %>'  />&nbsp;
                                         <asp:Label ID="lblID" runat="server" Visible="false" Text='<%#Eval("ID") %>' ></asp:Label>
                                         <asp:Label ID="lblFranchiseID" runat="server" Visible="false" Text='<%#Eval("FranchiseID") %>' ></asp:Label>
                                         <asp:Label runat="server" ID="lblIntType" Visible="false" Text='<%# Eval("ActivityState")%>' ></asp:Label>           
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="10%" HeaderText="Ticket #"  SortExpression="Ticket" >
                                    <ItemTemplate >
                                        <asp:Label runat="server" ID="lblTicketNumber" Text='<%# Functions.GetActivityPrefix(Eval("Type")) &  Eval("ID")%>' ></asp:Label>                                        
                                    </ItemTemplate>
                                    </asp:TemplateField> 
                                   <%--  <asp:TemplateField ItemStyle-Width="15%" HeaderText="Franchise" SortExpression="Franchise" >
                                    <ItemTemplate >
                                        <asp:Label runat="server" ID="lblFranchise" Text='<%# Eval("Franchise")%>' ></asp:Label>                                        
                                    </ItemTemplate>
                                    </asp:TemplateField>--%>
                                     <asp:TemplateField HeaderText="Type" ItemStyle-Width="10%" SortExpression="Type" >
                                        <ItemTemplate >
                                            <asp:Label runat="server" ID="lblType" Text='<%# Functions.getActivityCaption(Eval("Type"))%>' ></asp:Label>                                        
                                        </ItemTemplate>
                                    </asp:TemplateField>                                    
                                     <asp:TemplateField ItemStyle-Width="38%" HeaderText="Subject" SortExpression="Subject" >
                                        <ItemTemplate >
                                          <span title='<%# Functions.IfNull(Eval("Subject"), "") %>' >
                                            <asp:Label runat="server" ID="lblSubject" Text='<%# Functions.StringTruncate(Functions.IfNull(Eval("Subject"), ""), 40) %>' ></asp:Label>                                        
                                          </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>                                                                       
                                    <asp:TemplateField ItemStyle-Width="10%" HeaderText="Date" SortExpression="Date" >
                                        <ItemTemplate >
                                            <asp:Label runat="server" ID="lblDate" Text='<%# Functions.DateDiffInWords(Eval("Date"))%>' ></asp:Label>                                        
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Completed" ItemStyle-Width="12%" SortExpression="LastUpdatedOn" Visible="true" >
                                       <ItemTemplate >
                                           <asp:Label runat="server" ID="lblLastActivity" Text='<%# Functions.DateDiffInWords(Eval("LastUpdatedOn"))%>' ToolTip='<%#Eval("LastUpdatedOn") %>' ></asp:Label>
                                       </ItemTemplate>
                                   </asp:TemplateField>                                                                              
                                </Columns>
                            </asp:GridView>
                             </ContentTemplate>
                                  <Triggers >                                  
                                  <%-- <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />--%>
                                  </Triggers>
                            </asp:UpdatePanel>    
                            <asp:ObjectDataSource ID="odsCompletedActivities" runat="server" 
                                    SelectMethod="GetCompletedActivitiesForMyNetsolaceHelpDesk"
                                   EnablePaging="false"
                                    SortParameterName ="sortExpression"  
                                    TypeName="Portal.BLL.Activities">
                                <SelectParameters>                           
                                <asp:QueryStringParameter Name="ClientID" QueryStringField ="ClientID" />
                                <asp:QueryStringParameter Name="FranchiseID" QueryStringField ="FranchiseID" />
                                <asp:Parameter  Name="sortExpression" Type="String" DefaultValue=""    />
                                </SelectParameters>
                           </asp:ObjectDataSource> 
                         </div>                   
               </td>
             </tr>
                     <tr style="background-color:#BADCFC">
                        <td align="left" colspan="3" id="CustomPagerRow" style="height:25px;">&nbsp;</td>
                        <td align="left" class="GrayHeader">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td width="38%">&nbsp;</td>
                                    <td class="GrayHeader">
                                        &nbsp;&nbsp;&nbsp;<span style="font-size:7pt; color: #ff0000">*</span>
                                        UnRead activities are in Yellow Color<br />                    
                                        &nbsp;&nbsp;&nbsp;<span style="font-size:7pt; color: #ff0000">*</span>
                                        Delayed activities are in Red Colors                                       
                                   </td>
                                </tr>
                            </table>
                        </td>               

                     </tr>              
                 </table>
               </td>
             </tr>
           </table>
    </div>        
    </form>
    <script type="text/javascript" language="javascript">

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
                    $get('<%= txtSearch.ClientID %>').value = '';
                }
            }
        }    
</script>
</body>
</html>


