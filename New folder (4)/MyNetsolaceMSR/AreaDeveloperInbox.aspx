<%@ Page Language="VB"  AutoEventWireup="false" CodeFile="AreaDeveloperInbox.aspx.vb" Inherits="MyNetsolace_AreaDeveloperInbox" Theme="Default" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js" ></script>
</head>
<body style=" border:0; margin:0; height:100%; width:100%; overflow-y:auto;">
    <form id="form1" runat="server">    
    <asp:ScriptManager Id="smInbox" runat="server">
    </asp:ScriptManager>
    <asp:UpdateProgress ID="uprogInbox" runat="server">
        <ProgressTemplate>
         <div class="ProgressIndicatorDIV" >
                    <br />
                    <asp:Image ID="Image2" runat="server" ImageUrl="../images/indicator.gif" ImageAlign="AbsMiddle" /> <span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
                    <br /><br />
                </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:HiddenField ID="hdnAreaDeveloperID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnClientId" runat="server" Value="0" />
    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height:100%;">
        <tr class="headerrow" style="font-weight:bold; height:31px;">
            <td>
                Inbox Tickets |
                <asp:UpdatePanel id="upCount" runat="server" UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                        <asp:Label ID="lblActivityCount" runat="server" Text="0"/>                
                        &nbsp;<span class="NonBold">(<asp:Label runat="server" ID="lblFilter" Text="all" />)</span>
                    </ContentTemplate>
                </asp:UpdatePanel>
                
            </td>
            <td align="right" colspan="2">
                <asp:LinkButton ID="lnkResetFilters" runat="server" CssClass="HomeButton">
                    <div style="width:110px;" class="LeadDetailButton" onclick="javascript:resetFilters();">
                    Reset Filters 
                    <img  src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10" style="border:0px;"/>
                    </div>
                </asp:LinkButton>                 
            </td>            
        </tr>
        <tr style="background-color:#BADCFC;">
            <td colspan="3" style="border-bottom:solid 1px #609BD3;">
            <table border="0" cellpadding="0" cellspacing="0" style="padding:3px;">
              <tr>
                <td style="width:150px" >
                    <span class="GreyTextSmall">Filters</span><br />
                    <asp:DropDownList ID="ddlFilters" runat="server" Width="130px" SkinID="SmallTextCombo">
                        <asp:ListItem Text="Show All" Value="all" Selected="True"></asp:ListItem>                        
                        <asp:ListItem Text="Waiting for ME" Value="forme" ></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td style="width:150px">
                    <span class="GreyTextSmall">Franchises</span><br />
                    <asp:DropDownList ID="ddlFranchises" runat="server" Width="130px" SkinID="SmallTextCombo" 
                        DataTextField="StoreNick" DataValueField="FranchiseID" DataSourceID="sdsFranchisesList">                        
                    </asp:DropDownList>                    
                </td>
                <td style="width:170px">
                    <span class="GreyTextSmall">Search</span><br />
                    <asp:TextBox ID="txtSearch" runat="server" Width="130px" SkinID="GreenSmallTextbox"></asp:TextBox>
                    <asp:ImageButton ID="btnSearch"  runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />                                
                </td>                
              </tr>
            </table>  
            </td>          
        </tr>
        <tr>
            <td colspan="3" style="height:100%; width:100%;">
                <div id="divInbox" style="height:100%; width:100%; overflow-y:auto;" class="ScrollBarHomeTicket">
                    <asp:UpdatePanel id="upInbox" runat="server" UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                    <asp:GridView ID="gvwInbox" runat="server" 
                        SkinID="GridViewNormal" DataSourceID="odsInbox" AutoGenerateColumns="False" >
                      <Columns>
                        <asp:TemplateField ItemStyle-Width="5%">
                            <ItemTemplate>
                                <img src='<%= ConfigurationManager.AppSettings("ImagesURL") %><%# Functions.GetActivityImage(Eval("ActivityType")) %>'  />
                            </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:TemplateField ItemStyle-Width="10%" HeaderText="Ticket #"  SortExpression="Ticket" >
                            <ItemTemplate>
                                <asp:Literal runat="server" ID="lblTicketNumber" Text='<%# Functions.GetActivityPrefix(Eval("ActivityType")) &  Eval("ActivityID")%>' ></asp:literal>
                            </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:TemplateField ItemStyle-Width="15%" HeaderText="Franchise" SortExpression="Franchise" >
                            <ItemTemplate >
                                <asp:Literal runat="server" ID="lblFranchise" Text='<%# Eval("StoreNick")%>' ></asp:Literal>                                        
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Type" ItemStyle-Width="10%" SortExpression="Type">
                            <ItemTemplate>
                                <asp:Literal runat="server" ID="lblType" Text='<%# Functions.getActivityCaption(Eval("ActivityType"))%>' ></asp:Literal>                                        
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-Width="30%" HeaderText="Subject" SortExpression="Subject" >
                            <ItemTemplate >
                              <span title='<%# Functions.IfNull(Eval("Subject"), "") %>' >
                                <asp:Literal runat="server" ID="lblSubject" Text='<%# Functions.StringTruncate(Functions.IfNull(Eval("Subject"), ""), 40) %>' ></asp:Literal>                                        
                              </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-Width="20%" HeaderText="Status" SortExpression="ActivityState" >
                            <ItemTemplate >
                              <span title='<%# Functions.GetActivityStatus(Eval("ActivityStateID")) & IIf(Eval("ActivityStateID") = 4, ":" & Functions.StringTruncate(Functions.IfNull(Eval("WaitingForName"), ""), 100), "") %>' >
                                <asp:Literal runat="server" ID="lblstatus" Text='<%# Functions.GetActivityStatus(Eval("ActivityStateID")) & IIf(Eval("ActivityStateID") = 4, ":" & Functions.StringTruncate(Functions.IfNull(Eval("WaitingForName"), ""), 15), "") %>' ></asp:Literal>                                        
                              </span>
                            </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:TemplateField ItemStyle-Width="10%" HeaderText="Date" SortExpression="Date" >
                            <ItemTemplate >
                                <%#String.Format("{0: MMM dd, yyy}", Eval("ActivityDate"))%>
                            </ItemTemplate>
                        </asp:TemplateField>                                                                                       
                      </Columns>
                    </asp:GridView>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="ddlFranchises" EventName="SelectedIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="ddlFilters" EventName="SelectedIndexChanged" />
                    </Triggers>
                    </asp:UpdatePanel>
                </div>
            </td>            
        </tr>
        <tr class="FooterRow" style="height:31px;">
            <td colspan="3">
                &nbsp;
            </td>            
        </tr>
    </table>
    <asp:ObjectDataSource ID="odsInbox" runat="server" 
            SelectMethod="GetAreaDeveloperActivitiesInbox"
            SelectCountMethod="GetAreaDeveloperActivitiesInboxCount" 
            EnablePaging="true"
            SortParameterName="sortExpression"
            TypeName="Portal.BLL.Activities">                                    
        <SelectParameters>                           
          <asp:ControlParameter  Name="FranchiseID" Type="Int32" ControlID="ddlFranchises" PropertyName="SelectedValue" DefaultValue="0" />
          <asp:ControlParameter  Name="Filter" Type="String"  ControlID="ddlFilters" PropertyName="SelectedValue" DefaultValue="" />
          <asp:ControlParameter  Name="ClientID" Type="String"  ControlID="hdnClientID" PropertyName="Value" />
          <asp:ControlParameter  Name="Search" Type="String" ControlID="txtSearch" PropertyName="Text" DefaultValue=""  />
          <asp:Parameter Name="ReturnValue" Type="Int32"  Direction="Output" />          
          <asp:ControlParameter  Name="AreaDeveloperID" Type="String"  ControlID="hdnAreaDeveloperID" PropertyName="Value" />
        </SelectParameters>
   </asp:ObjectDataSource>   
   <asp:SqlDataSource ID="sdsFranchisesList" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
      SelectCommand="Activities_GetOpenActivities_StoreList" SelectCommandType="StoredProcedure">
      <SelectParameters>
        <asp:Parameter  Name="Status" DefaultValue="False" Type="Boolean" />
        <asp:Parameter  Name="ClientID" DefaultValue="3" Type="Int32" />
        <asp:ControlParameter Name="AreaDeveloperID" Type="int32" ControlID="hdnAreaDeveloperID" PropertyName="Value" />
      </SelectParameters>
  </asp:SqlDataSource>   
    </form>
    <script type="text/javascript" language="javascript">
        function resetFilters()
        {
            document.getElementById('<%=ddlFranchises.ClientID %>').value=0;
            document.getElementById('<%=txtSearch.ClientID%>').value='';
            document.getElementById('<%=ddlFilters.ClientID%>').value='';            
        }
                
        function ShowDetail(activityId, franId, clientId)
        {
            window.location='ActivityDetail.aspx?Id='+activityId+'&FranchiseId='+franId+'&ClientId='+clientId+'&PrevPage=6';        
        }
    </script>
</body>
</html>                             


