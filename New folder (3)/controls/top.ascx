<%@ Control Language="VB" AutoEventWireup="false" CodeFile="top.ascx.vb" Inherits="LMS_top" %>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td colspan="0">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="color:#467FA6;font-size:11px;background-color:#E4F1F7;font-family:Arial;">
                <tr>
                    <td style="width:15px;height:18px;">&nbsp;</td>
                    <td style="width:206px; height: 18px;"><asp:Image ID="Image1" runat="server" ImageUrl="~/images/logo_hdr_netsolace_top.jpg" AlternateText="Netsolace Logo Top" width="206" height="18" /></td>
                    <td style="width:15px;height:18px;">&nbsp;</td>
                    <td style="width:30%; height: 18px;">
                        <asp:Image ID="Image2" runat="server" ImageUrl="~/images/icn_user.jpg" ImageAlign="absmiddle" />&nbsp;&nbsp;Welcome 
                        <b><asp:Label ID="lblAdminName" runat="server" ForeColor="Black" ></asp:Label></b>
                    </td>
                    <td style="text-align:right; height: 18px;">
                       <div id="testStoreDiv" style="display:none;" runat="server"><a href="<%= ResolveClientURl("~/TestStore.aspx") %>" target="_blank">Test Store</a>&nbsp;|&nbsp;</div><a href="<%= ResolveClientURl("~/resources/userfiles/Netsolace_HANDBOOK.pdf") %>" target="_blank">Employee Handbook</a>&nbsp;|&nbsp;<a href="<%= ResolveClientURl("~/changepassword.aspx") %>" target="_top">Change Password</a>&nbsp;|&nbsp; <asp:LinkButton ID="lbtnSignout" runat="server">Sign out </asp:LinkButton> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="TopBar3DTable">
                <tr>
                    <td class="TopBarBGSpace">&nbsp;</td>
                    <td style="width:206px;"><asp:Image ID="Image3" runat="server" ImageUrl="~/images/logo_hdr_netsolace_btm.jpg" width="206" AlternateText="Netsolace Logo Bottom" height="53" /></td>
                    <td style="width:20px;text-align:right;">&nbsp;<asp:Image ID="Image4" runat="server" ImageUrl="~/images/hdr_separator.jpg" ImageAlign="absmiddle" height="53" width="4" />&nbsp;</td>
                    <td class="MainIcons" title='Home'>
                        <table id="IconHome" runat="server"  width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td style="height:33px;"><asp:Image ID="Image17" runat="server" ImageUrl="~/images/icn_home.gif" /></td>
                            </tr>
                            <tr>
                                <td style="height:13px;">HOME</td>
                            </tr>
                        </table>
                    </td>
                    <td style="width:5px;">&nbsp;</td>
                    <asp:Repeater ID="rptTopMenu"   runat="server" DataSourceID="srcTopMenu">
                    <ItemTemplate>
                    
                   <td runat="server" id='ss' title='<%# Container.DataItem("Name")%>' class="MainIcons">
                   <asp:Label Visible="false" ID="lblID" runat="server" Text='<%# Container.DataItem("ID")%>'></asp:Label> 
                      <table id="menutblID" width="100%" border="0" cellspacing="0" cellpadding="0" onmouseover="this.className='TopBarHover';" onmouseout="this.className='TopBarSimple';" class="TopBarSimple"   runat="server"  >
                      <%--<table id="Table1" width="100%" border="0" cellspacing="0" cellpadding="0" onmouseover="this.className='TopBarHover';" onmouseout="this.className='TopBarSimple';" class="TopBarSimple"  onclick="window.location='<%# ResolveClientUrl(Container.DataItem("Url")) %>?PageID=Icn_<%# Container.DataItem("ID")%>';" runat="server"  >--%>
                        <%--<table id="<%= Bind("ID") %>" width="100%" border="0" cellspacing="0" cellpadding="0" onmouseover="this.className='TopBarHover';" onmouseout="this.className='TopBarSimple';" class="TopBarSimple"   runat="server"  >--%>
                            <tr>
                                <td style="height:33px;">                                    
                                    <img src='<%= ConfigurationManager.AppSettings("ImagesURL") %><%#Eval("Image") %>'  />
                                </td>
                            </tr>
                            <tr>
                                <td style="height:13px;"><%# Container.DataItem("Caption")%></td>
                            </tr>
                        </table>
                    </td>
                    <td style="width:5px;">&nbsp;</td>
                    
                    
                        <%--<asp:Label ID="ll" runat="server" Text='<%# Container.DataItem("ID")  %>'></asp:Label>--%>
                    </ItemTemplate>
                    <FooterTemplate></FooterTemplate>
                    </asp:Repeater>
                    <asp:SqlDataSource 
                    ID="srcTopMenu" 
                    runat="server"  
                    ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>" 
                    SelectCommand="Modules_GetByID" 
                    SelectCommandType="StoredProcedure" 
                    DataSourceMode="DataReader"
                    >
                      <SelectParameters>
                        <asp:SessionParameter DefaultValue="1" Name="IDs" SessionField="UsersModulesID" Type="string" /> 
                      </SelectParameters>
                    </asp:SqlDataSource>               
                    <td >&nbsp;</td>                    
                </tr>
            </table>
        </td>
    </tr>
    <tr>
       <td height="2" colspan="3"  bgcolor="#D5E5F4"><asp:Image ID="Image16" runat="server" ImageUrl="~/images/spacer.gif" width="1" height="1" /></td>
    </tr>
</table>