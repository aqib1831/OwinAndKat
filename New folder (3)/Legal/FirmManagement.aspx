<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FirmManagement.aspx.vb"
    Inherits="admin_Legal_FirmManagement" Theme="Default" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>LegalIP</title>
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=.1)" />   
    <link href="../style/style.css" type="text/css" rel="stylesheet" />
    <link href="Style/Style.css" type="text/css" rel="stylesheet" />
    <link href="../style/Calendar/style.css" type="text/css" rel="stylesheet" />
    <style type="text/css">
    .filterdropdown{
        font-size:9px;
        width:120px;
    }
</style>
<script type="text/javascript" language="javascript" >
    function Reset()
    {
        document.getElementById("txtSearch").value="";
        return true;
    }
</script>
</head>
<body style="margin: 0px; height: 100%; width: 100%; padding: 0px;" scroll="no">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <div style="left: 392px; position: absolute; top: 256px">
            &nbsp;</div>
        <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" class="MainTable"
            style="padding: 0px; margin: 0px; width: 100%;">
            <tr class="UnderlinedRow" height="31px">
                <td class="PageMainHeading" style="height: 31px; width: 100%;">
                    Firm/Vendor Management</td>
                <td align="right" class="PageMainHeading" style="width: 100%; height: 31px">
                     <asp:LinkButton ID="reset" runat="server">
                        <div style="width:110px;" class="FlatButton" onclick="return Reset();">Reset Filters <img alt="" src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10" /></div>
                     </asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td style="height: 100%; width: 100%;" colspan="2">
                    <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;
                        height: 100%;">
                        <tr>
                            <td height="31px" class="" align="center" style="width: 100%;">
                                <table width="98%;" height="100%" border="0" style="text-align: left" align="center"
                                    cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="80" style="height: 43px">
                                            <span class="GreyTextSmall">&nbsp;&nbsp;
                                                <input value="New Firm/Vendor" id="btnNewIP" type="button" class="btnExtraSimple"
                                                    onclick="parent.frameMain.location='NewFirm.aspx'" style="width: 115px" />&nbsp;&nbsp;
                                            </span>
                                        </td>
                                        <td width="1" bgcolor="#BADBFC" style="height: 43px;">
                                            <img src="../images/spacer.gif" height="35" width="1" align="absmiddle" style="background-color: #82BDE9">
                                        </td>
                                         <td style="height: 43px; width: 250px; padding-left:5px;">
                                          <asp:Panel ID="Search" DefaultButton="btnSearch" runat="server">
                                          <table cellpadding="0" cellspacing="0" class="GreyTextSmall">
                                                <tr>
                                                    <td>
                                                        Search:
                                                    </td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:TextBox ID="txtSearch" runat="server" CssClass="blueTextbox" Width="120px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        &nbsp;<asp:ImageButton ID="btnSearch" runat="server" align="absmiddle" ImageUrl="../images/btn_go.gif" />
                                                    </td>
                                                </tr>
                                            </table>
                                            </asp:Panel>  
                                        </td>                                      
                                        <td >&nbsp;</td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" bgcolor="#FFFFFF" style="width: 100%;border:solid 1px #609BD3">
                                <div style="overflow: auto; height: 100%; width: 100%;">
                                    <asp:UpdatePanel ID="UpdatePanelFirm" runat="server" UpdateMode="Always">
                                    <Triggers>
                                             <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                                             <asp:AsyncPostBackTrigger ControlID="reset" EventName="Click" />
                                     </Triggers>
                                     
                                     <ContentTemplate>
                                    <asp:GridView SkinID="GridViewNoPaging"  ID="GridView1" runat="server" EnableViewState="False" DataSourceID="AllFirmsDS" AutoGenerateColumns="False" DataKeyNames="ID" OnRowDataBound="GridView1_RowDataBound" AllowPaging="false" AllowSorting="true" Width="100%">
                                        <EmptyDataTemplate>
                                            <div id="divInfo" class="MessageDiv" style="left: 38%; width: 200px; position: absolute;
                                                top: 38%; height: 18%">
                                                <table border="0" cellpadding="0" cellspacing="0" style="height: 50px" width="100%">
                                                    <tr>
                                                        <td style="width: 5%">
                                                            &nbsp;</td>
                                                        <td align="right" style="width: 25%" valign="middle">
                                                            <div style="text-align: right">
                                                                <asp:Image ID="Image1" runat="server" ImageUrl="~/images/icn_info.gif" />
                                                                &nbsp;
                                                            </div>
                                                        </td>
                                                        <td id="divMessage" align="left" nowrap="nowrap" style="width: 75%" valign="middle">
                                                            &nbsp;No Firm Found!</td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </EmptyDataTemplate>
                                        <Columns>
                                            <asp:TemplateField HeaderText="Name" SortExpression="Name" HeaderStyle-Width="25%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblName" runat="server" Font-Bold="true" Text='<%# Server.HtmlEncode(Functions.StringTruncate(Eval("Name"),20)) %>' ToolTip='<%# Eval("Name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Address" SortExpression="City"  HeaderStyle-Width="30%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCity" runat="server" Text='<%#Server.HtmlEncode( Functions.StringTruncate(Eval("City"),15))%>' ToolTip='<%#Eval("City") %>'></asp:Label>,&nbsp;
                                                    <asp:Label ID="lblState" runat="server" Text='<%# Eval("State") %>'></asp:Label>&nbsp;
                                                    <asp:Label ID="lblZip" runat="server" Text='<%# Eval("Zip") %>'></asp:Label>&nbsp;
                                                    <asp:Label ID="lblCountry" runat="server" Text='<%# Eval("CountryName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                              <asp:TemplateField HeaderText="Phone" SortExpression="Phone" HeaderStyle-Width="30%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPhone" runat="server"  Text='<%# Server.HtmlEncode(Functions.StringTruncate(Eval("Phone"),20)) %>' ToolTip='<%# Eval("Phone") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            
                                            <asp:TemplateField ShowHeader="False" HeaderStyle-Width="20%">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("ID", "VendorProfile.aspx?FirmID={0}") %>' Text="Edit"></asp:HyperLink>
                                                    |
                                                    <asp:LinkButton ID="lnkDelete" runat="server" CausesValidation="false" Text="Delete" CommandArgument='<%#Container.DataItem("ID")%>' CommandName="Delete" OnClientClick="javascript:event.cancelBubble=true;return confirm('Are you sure you want to delete this Firm/Vendor?')"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                    <asp:ObjectDataSource ID="AllFirmsDS" runat="server" SelectMethod="GetAllFirms" TypeName="Firm" DeleteMethod="DeleteFirm" SortParameterName="SortExpression">
                                        <SelectParameters>
                                            <asp:Parameter Name="SortExpression" Type="String" />
                                            <asp:ControlParameter ControlID="txtSearch" Name="Search" PropertyName="Text" Type="String" />
                                        </SelectParameters>
                                        <DeleteParameters>
                                            <asp:Parameter Name="ID" Type="Int32" />
                                        </DeleteParameters>
                                    </asp:ObjectDataSource>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <asp:UpdateProgress ID="Progress1" runat="server" AssociatedUpdatePanelID="UpdatePanelFirm">
                                        <ProgressTemplate>
                                            <div class="ProgressIndicatorDIV">
                                                <br />
                                                <asp:Image ID="Image2" runat="server" ImageAlign="AbsMiddle" ImageUrl="images/indicator.gif" />
                                                <span style="font-size: 14px; color: #4b92c1"><b>&nbsp; Loading ...</b></span>
                                                <br />
                                                <br />
                                            </div>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                </div>
                                </td>
                        </tr>
                        <tr>
                            <td style="height: 15px">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
