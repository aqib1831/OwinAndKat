<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TestStore.aspx.vb" Inherits="TestStore" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Netsolace - Portal</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <table cellpadding="0" cellspacing="0" border="0" style="width:500px; height:200px;" align="center">
        <tr>
            <td colspan="2">
                Test Store Activation
            </td>
        </tr>
        <tr>
            <td>Clients:</td>
            <td>
                <asp:DropDownList ID="ddlClients" runat="server" AutoPostBack="true" DataSourceID="sdsClients" DataTextField="Name" DataValueField="ID"
                    Width="250px">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsClients" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                    SelectCommand="Clients_HavingFransupport_GetAll" SelectCommandType="StoredProcedure">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>Stores:</td>
            <td>
                 <asp:DropDownList  ID="ddlStores" runat="server" DataSourceID="sdsStores" DataTextField="StoreNick" DataValueField="StoreNumber" 
                    Width="250px">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsStores" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                    SelectCommand="Client_TestStores_GetByClientID" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlClients" Name="ClientID" Type="int32" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <asp:Button ID="btnEnable" runat="server" Text="Enable" />
                <asp:Button ID="btnDisable" runat="server" Text="Disable" />
            </td>
                    </tr>
                    <tr>
                    <td colspan="2" align="center"><asp:Label ID="lblMessage" runat="server"></asp:Label></td></tr>
     </table>
    </div>
    </form>
</body>
</html>
