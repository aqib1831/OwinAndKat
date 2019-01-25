<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Features.aspx.vb" Inherits="PM_Features" Theme="Default"  %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript"  src="../../scripts/functions.js" language="javascript" ></script>
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=0.2)" />
    <meta http-equiv="Page-Enter" content="progid:DXImageTransform.Microsoft.Fade(Duration=0.2)" />
</head>
<body style ="margin :0px;background-color:#E4F1F7;  width:100%; height:100%; ">
    <form id="form1" runat="server"><asp:HiddenField  ID="hdnClient" runat="server" /><asp:HiddenField ID="hdnCatagory" runat="server" />
    <div>
    <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="300"  />
    <asp:UpdateProgress ID="Progress1" runat="server">
            <ProgressTemplate>
                <div class="ProgressIndicatorDIV" >
                    <br />
                    <asp:Image ID="Image2" runat="server" ImageUrl="../../images/indicator.gif" ImageAlign="AbsMiddle" /> <span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
                    <br /><br />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>  
     <asp:HiddenField ID="ReleaseID" runat="server" />
     <asp:HiddenField ID="PrevPage" runat="server" Value="0" /> 
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
                          <asp:AsyncPostBackTrigger ControlID="ddlTypes" EventName="SelectedIndexChanged" />
                          <asp:AsyncPostBackTrigger ControlID="ddlFilter" EventName="SelectedIndexChanged" />
                          <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                              
                          <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                          </Triggers>
               </asp:UpdatePanel>

        </td>
         <td style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right; white-space:nowrap;width:50%;">
             <asp:LinkButton ID="btnBack" runat="server" CssClass="HomeButton">
             <div style="width:110px;" class="LeadDetailButton" >
                 <img  src="../../images/blt_Back.gif" align="absmiddle" width="10" height="10"  style="border:0px;" />
                 Back 
             </div>
             </asp:LinkButton>
             &nbsp;&nbsp;
             <img align="absMiddle"  height="20" src="../../images/pixel_skyBlue.jpg" width="1" />
             &nbsp;&nbsp;
             <asp:LinkButton ID="lnkResetFilters" runat="server" CssClass="HomeButton">
                    <div style="width:110px;" class="LeadDetailButton" onclick="javascript:resetFilters();">
                    Reset Filters 
                    <img  src="../../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10"  style="border:0px;" />
                    </div>
             </asp:LinkButton>
            
             <img  align="absmiddle" src="../../images/pixel_skyBlue.jpg" width="1" height="20" />
            
         </td>                        
     </tr>              
     <tr style="height:5%; width:100%;">
        <td colspan="2" style="background-color:#BADCFC;font-size:11px;">
          <table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%; white-space:nowrap;">
            <tr>
              <td style="padding:5px;text-align:left; display:none; white-space:nowrap; padding-right:1em; padding-top:13px; ">
                <div id="btnnewfeature" runat="server" style="width: 100px;" onclick="javascript:StateSaveNewFeature();" class="LeadDetailButton"  >
                  NEW FEATURES
                  <img align="absMiddle"  height="10" src="../../images/blt_resetFilters.gif" width="10" /> 
                  </div>
              </td>
              <td style="width:30px;text-align:center; display:none; ">
                 <img  src="../../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
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
						SelectCommand="PM_Categories_Clients_GetAll" 
						SelectCommandType="StoredProcedure"
						DataSourceMode="DataReader">
						<SelectParameters>
							<asp:SessionParameter Name="ClientID" SessionField="MyNetsolace_ClientID" DefaultValue="0" />
						</SelectParameters>
					</asp:SqlDataSource>
              </td>              
              <td style="width:30px;text-align:center; ">
                 <img  src="../../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
              </td>
              <td style="padding-left:5px; padding-right:5px; "  >
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
                   <img  src="../../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" /> 
              </td> 
               <td style="padding-left:5px; padding-right:5px; "  >
                  <span class="GrayHeader">Filter<br />
                  </span>
                    <asp:DropDownList 
                    ID="ddlFilter" 
                    runat="server" 
                    SkinID="SmallTextCombo"                                                       
                    AutoPostBack="True" Width="100px">
                  </asp:DropDownList>&nbsp;&nbsp;                         
               </td>                  
             <td style="width:10px;text-align:center;">
                  <img  src="../../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
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
                <asp:GridView 
                ID="gvReleases" 
                runat="server" 
                AutoGenerateColumns="False" 
                EnableTheming="True" 
                SkinID="GridViewNormal"                              
                AllowSorting="True" DataKeyNames="ID" DataSourceID="ObjectDataSource1" >
                 <PagerSettings Mode="Numeric" Position="Bottom" />
                     <PagerTemplate>                                                
                          <div style="width:100%; border:0px black solid;" >
                              <table width="100%" border="0" cellpadding="0" cellspacing="0"  style="height:20px;">
                                   <tr style="text-align:left;">
                                         <td style="width:20%; white-space:nowrap;" align="left"  valign="middle" >
                                           <span class="DarkBlueTextSmall" style="font-size:10px" >&nbsp; Page <asp:Literal id="litPageNumber" runat="server"/> of <asp:Literal id="litTotalPages"  runat="server"/></span>
                                         </td>
                                         <td style="width:10px; " align="right" ><img alt="" src="../../images/spacer.gif" width="15" height="1" align="absmiddle" /></td>                                    
                                         <td style="width:1px; " align="center"><img alt="" src="../../images/pixel_darkBlue.jpg" width="1" height="20" align="absmiddle" /></td>
                                         <td style="width:10px;" align="right"><img alt="" src="../../images/spacer.gif" width="15" height="1" align="absmiddle" /></td>
                                         <td  align="right" valign="top"> <asp:Panel ID="pnlNumber" runat="server" HorizontalAlign="Right"  ></asp:Panel> </td>                                                                                                     
                                    </tr>
                              </table>  
                          </div>
                      </PagerTemplate> 
                    <Columns>
                    <asp:TemplateField HeaderText="Ref #" SortExpression="RefNo" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" >
                            <ItemTemplate>
                                <span style="width:10px;"><img  src="../../images/pm_flag.gif" style='<%# IIf(Eval("ActualDueDate") < DateTime.Now.Date AndAlso Functions.IFNull(Eval("Status"), "  ")  <> "Completed", "display:inline", "display:none") %>'  /></span>
                                <span style="width:35px; text-align:center;<%# IIf(Eval("ActualDueDate") < DateTime.Now.Date AndAlso Functions.IFNull(Eval("Status"), "  ")  <> "Completed", "padding-left:0px;", "padding-left:5px;") %>"><asp:Label ID="lblTokenNo" runat="server" Text='<%# IIF(Eval("RefNo") <> 0 , Eval("RefNo"), Eval("ID") ) %>' ></asp:Label></span> 
                            </ItemTemplate>
                             <ItemStyle Width="8%" Wrap="false" HorizontalAlign="Center" Font-Bold="true"  />
                             <HeaderStyle Wrap="false" HorizontalAlign="Center" />
                        </asp:TemplateField>                                  
                        <asp:TemplateField HeaderText="Name" SortExpression="Name"  HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                            <ItemTemplate>
                            <span title='<%#Eval("Name")%>' >
                                <asp:Label ID="lblName" runat="server" Text='<%# Server.HtmlEncode(Functions.StringTruncate(Functions.IfNull(Eval("Name"),""),45))%>' > ></asp:Label>
                            </span>
                            </ItemTemplate>
                            <ItemStyle Width="20%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status" SortExpression="Status" HeaderStyle-Wrap="false" >
                            <ItemTemplate>
                            <span title='<%#Eval("Status")%>' >
                                <asp:Label ID="lblStatus" runat="server" Text='<%# Server.HtmlEncode(Functions.StringTruncate(Functions.IfNull(Eval("Status"),""),20))%>' > ></asp:Label>
                            </span>
                            </ItemTemplate>
                            <ItemStyle Width="20%" Wrap="false"/>
                         </asp:TemplateField>                   
                        <asp:BoundField DataField="TypeName" HeaderText="Type" SortExpression="TypeName" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="10%"/>
                        <asp:BoundField DataField="CategoryName" HeaderText="Category" SortExpression="CatagoryName" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="15%" />
                        <asp:BoundField DataField="ClientName" HeaderText="Client" SortExpression="ClientName" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="10%" />
                        <asp:TemplateField HeaderText="Due Date" SortExpression="DueDate" HeaderStyle-Wrap="false">
							<ItemTemplate>
							</ItemTemplate><ItemStyle Wrap="false" Width="5%"/>
						</asp:TemplateField>
                        <asp:BoundField DataField="LastUpdatedMyNetsolace" HeaderText="Last Updated" SortExpression="LastUpdatedMyNetsolace" DataFormatString="{0:d}" HtmlEncode="False" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-Width="10%" />
                        
                    </Columns>
                </asp:GridView>
                </ContentTemplate>
                          <Triggers >
                          <asp:AsyncPostBackTrigger ControlID="ddlCategories" EventName="SelectedIndexChanged" />
                          <asp:AsyncPostBackTrigger ControlID="ddlTypes" EventName="SelectedIndexChanged" />
                          <asp:AsyncPostBackTrigger ControlID="ddlFilter" EventName="SelectedIndexChanged" />
                          <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                              
                          <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                          </Triggers>
                    </asp:UpdatePanel>    
                <asp:ObjectDataSource ID="ObjectDataSource1" 
                    runat="server" 
                    OldValuesParameterFormatString="original_{0}" 
                    SortParameterName="sortExpression"
                    SelectMethod="PM_FeaturesGetAllForMyNetsolace"
                    EnablePaging="true" 
                    SelectCountMethod="PM_FeaturesGetAllCountForMyNetsolace" 
                    TypeName="Portal.BLL.PM.PM_Ticket_Features">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ReleaseID" DefaultValue="1" Name="ReleaseID" PropertyName="Value" Type="Int32" />
                        <asp:SessionParameter SessionField="MyNetsolace_ClientID"  DefaultValue="" Name="ClientID" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlCategories" DefaultValue="1" Name="CategoryID" PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlTypes" DefaultValue="0" Name="TypeID" PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlFilter" DefaultValue="0" Name="FilterID" PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter DefaultValue="" Name="sortExpression" Type="String" />                                
                        <asp:ControlParameter ControlID="txtsearch" DefaultValue="" Name="txtsearch" PropertyName="Text" Type="String" />
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
            <span style="font-size:7pt; color: #ff0000; height:7px;"><img  src="../../images/pm_flag.gif" height="7"  alt="*"/></span>
                                    Delayed Features are in Red flag 
        </td>            
     </tr>
    </table>
    </div>
    </form>
    
</body>
<script type="text/javascript" language="javascript">
 function resetFilters()
    {      
        var item; 
        if (item = document.getElementById('<%= txtSearch.ClientID %>')){
        
            item.value = '';
        }
        if (item = document.getElementById('<%= ddlCategories.ClientID %>'))
        {
            item.value = 0;
        }
        if (item = document.getElementById('<%= ddlTypes.ClientID %>'))
        {
            item.value = 0;
        }
        if (item = document.getElementById('<%= ddlFilter.ClientID %>'))
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
        if (typeof(postbackElement) === "undefined") 
        {
            return;
        } 
        for (i=0; i < updatedPanels.length; i++){
            if (updatedPanels[i].id == '<%= UpdatePanel2.ClientID %>') {
                AdjustPagerRow();
                $get('<%= txtSearch.ClientID %>').value='';               
            }
        }
    }
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
            QueryStringValues += "&ddlCategories=" + document.getElementById('<%=ddlCategories.ClientID %>').value; 
            QueryStringValues += "&ddlFilter=" + document.getElementById('<%=ddlFilter.ClientID %>').value;  
            QueryStringValues += "&ddlTypes=" + document.getElementById('<%=ddlTypes.ClientID %>').value;  
            QueryStringValues += "&ReleaseID=" + document.getElementById('<%=ReleaseID.ClientID %>').value;
            QueryStringValues += "&reClient=" + document.getElementById('<%=hdnClient.ClientID %>').value;
            QueryStringValues += "&reCatagory=" + document.getElementById('<%=hdnCatagory.ClientID %>').value;
            QueryStringValues += "&PrevPage=4"
            URL="FeaturesNew.aspx" + QueryStringValues ;
            window.location=URL;
            }
</script>
</html>
