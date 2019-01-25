<%@ Control Language="VB" AutoEventWireup="false" CodeFile="TopControl.ascx.vb" Inherits="TopControl" %>
<script language="javascript" type="text/javascript">
function ShowCaption(td)
{
    var id = td.id.replace('ctl00_ucTop1_rptModules_ctl','').replace('_td','');
    document.getElementById('ctl00_ucTop1_rptModules_ctl'+id+'_tdC').style.display='inline';
}
function HideCaption(td)
{
    var id = td.id.replace('ctl00_ucTop1_rptModules_ctl','').replace('_td','');
    document.getElementById('ctl00_ucTop1_rptModules_ctl'+id+'_tdC').style.display='none';
}
function ShowHomeC()
{   
    document.getElementById('<%= IconHome.ClientID  %>').className ='TopLinkHover';
    document.getElementById('<%= tdCHome.ClientID  %>').style.display='inline';
    
}
function HideHomeC()
{
    document.getElementById('<%= tdCHome.ClientID  %>').style.display='none';
    document.getElementById('<%= IconHome.ClientID  %>').className ='';
}

</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
    <tr>
        <td colspan="0">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="color:#467FA6;font-size:11px;background-color:#E4F1F7;font-family:Arial;background-image:url(https://qa.netsolace.com/Portal/images/hdrBG_top.jpg);">
                <tr>
                    <td style="width:130px; height: 35px;"><asp:Image ID="Image1" runat="server" ImageUrl="~/images/netsolace_logo.jpg" AlternateText="Netsolace Logo Top" width="130" height="30" /></td>
                    <td style="text-align:right; height: 18px;">
                        &nbsp;&nbsp;Welcome 
                        <b><asp:Label ID="lblAdminName" runat="server" ForeColor="Black" ></asp:Label></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
                       <a id="lnkSMSXReport" runat="server" href="SMSxReports/SMSxOrderedFranchises.aspx" target="_blank" style="display:none;">SMSx Report&nbsp;|&nbsp;</a><a href="<%= ResolveClientURl("~/resources/userfiles/Netsolace_HANDBOOK.pdf") %>" target="_blank">Employee Handbook</a>&nbsp;|&nbsp;<span id="testStoreDiv" style="display:none;" runat="server"><a href="<%= ResolveClientURl("https://www.fransupport.com/v2/TestStore.aspx") %>" target="_blank">Test Store</a>&nbsp;|&nbsp;</span><span id="spnChangePassword" runat="server"><a href="<%= ResolveClientURl("~/changepassword.aspx") %>" target="_top">Change Password&nbsp;|&nbsp;</a></span><asp:LinkButton ID="lbtnSignout" runat="server">Sign out </asp:LinkButton> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td style="height:32px;" valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="color: #467FA6;font-size: 11px; background-color: #E4F1F7; font-family: Arial;background-image:url(https://qa.netsolace.com/Portal/images/hdrBG_btm.jpg);color:Black;font-size:9px;">
                <tr>
                        <td id="tdSep" runat="server" style="width:3px;" align="center"><img width="1" height="24" src="images/hdr_menuSeparator.jpg" alt="" /></td>
                            <td id="tdP" runat="server" style="width:31px;height:32px;" align="center">
                                <table id="IconHome" runat="server" width="100%" border="0" cellspacing="0" cellpadding="0" align="center" style="font-size:9px;cursor:pointer; height:30px;">
                                    <tr>
                                        <td id="td" runat="server"  style="width:31px;padding:0 10px 0 10px;"><asp:Image ID="Image17" runat="server" ImageUrl="~/images/icn_home.gif" /></td>
                                        <td id="tdCHome"  nowrap="nowrap" runat="server" style="display:none;padding:3px 10px 0 0;"><strong>Home</strong></td>
                                    </tr>
                                </table>
                            </td>
                    <asp:Repeater ID="rptModules" DataSourceID="sdsModules"  runat="server">
                        <ItemTemplate>
                            <td id="tdSep" runat="server" style="width:3px;" align="center"><img width="1" height="24" src="https://qa.netsolace.com/Portal/images/hdr_menuSeparator.jpg" alt="" /></td>
                            <td id="tdP" runat="server" style="width:31px;height:32px;" align="center">
                            <asp:Label Visible="false" ID="lblID" runat="server" Text='<%# Container.DataItem("ID")%>'></asp:Label>
                                <table id="menutblID" width="100%" border="0" cellspacing="0" cellpadding="0" onmouseover="this.className='TopLinkHover';" onmouseout="this.className='TopLinkSimple';" class="TopLinkSimple" runat="server" style="font-size:9px;cursor:pointer; height:30px;">
                                    <tr>
                                        <td id="td"  runat="server" style="width:31px;padding:0 10px 0 10px;"><img align="absmiddle"  src='<%= ConfigurationManager.AppSettings("ImagesURL") %><%#Eval("Image") %>' /></td>
                                        <td id="tdC" nowrap="nowrap"  runat="server" style="display:none;padding:3px 10px 0 0;"><strong><%# Container.DataItem("Caption")%></strong></td>
                                    </tr>
                                </table>
                            </td>
                        </ItemTemplate> 
                        <FooterTemplate></FooterTemplate>
                    </asp:Repeater>
                    <td>
                        &nbsp;
                         <asp:SqlDataSource 
                                ID="sdsModules" 
                                runat="server"  
                                ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>" 
                                SelectCommand="Modules_GetByID" 
                                SelectCommandType="StoredProcedure" 
                                DataSourceMode="DataReader">
                                  <SelectParameters>
                                    <asp:SessionParameter DefaultValue="1" Name="IDs" SessionField="UsersModulesID" Type="string" /> 
									<asp:SessionParameter DefaultValue="false" Name = "IsLimitedAccess" SessionField="Remote_LimitedAccess" Type="Boolean"  />
                                  </SelectParameters>
                          </asp:SqlDataSource>   
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>