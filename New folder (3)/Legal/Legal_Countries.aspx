<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Legal_Countries.aspx.vb" Inherits="admin_Legal_Legal_Countries" Theme="Default" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Settings</title>
    <link href="../style/style.css" type="text/css" rel="stylesheet" />
    <link href="Style/Style.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="JavaScript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="javascript">
    function ShowAddNewCountry()
    {
        document.getElementById("hdnEdit").value=false;
        document.getElementById("NewType").style.top=(document.body.offsetHeight/2)-200;
        document.getElementById("NewType").style.left=(document.body.offsetWidth/2)-120;
        document.getElementById("NewType").style.display='inline';
        document.getElementById("txtNewCountry").value='';
        document.getElementById("txtNewCountry").focus();
    }
    function HideAddNewCountry()
    {
        document.getElementById('edit').style.display='none';
        document.getElementById("NewType").style.display='none';
        document.getElementById("lblMsg").style.display='none';
        document.getElementById("RequiredFieldValidator1").style.display='none';
    }
    </script>
</head>
<body scroll="no" style="margin: 0px; width: 100%; height: 100%;">
<form id="form1" runat="server" defaultbutton="Save">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />
            <asp:HiddenField ID="hdnEdit" runat="server" Value="false" />
            <asp:HiddenField ID="hdnID" runat="server" />
            <asp:UpdateProgress ID="Progress1" runat="server">
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
            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%;"
                class="MainTable">
                <tr class="UnderlinedRow">
                    <td class="PageMainHeading" style="height: 31px">
                        Settings</td>
                </tr>
                <tr>
                    <td style="width: 100%;" valign="top">
                        <table style="width: 100%; height: 100%;" border="0" cellpadding="0" cellspacing="0"
                            height="242" width="100%">
                            <tr>
                                <td style="padding-right: 5px; padding-left: 5px; padding-bottom: 5px; width: 10%;
                                    padding-top: 5px; height: 15px; border-bottom: solid 1px #609bd3;">
                                    <strong>Countries</strong>&nbsp;
                                    <img src="../images/spacer.gif" height="15" width="1" align="absmiddle" style="background-color: #82BDE9">&nbsp;
                                    <input id="btnNewCountry" class="btnExtraSimple" onClick="ShowAddNewCountry();" style="width: 88px"
                                        type="button" value="Add New" /><a href="#" onClick="ShowAddNewCountry();"></a></td>
                            </tr>
                            <tr>
                                <td style="width: 100%;" colspan="3" valign="top">
                                    <div style="height: 100%; overflow-y: auto; background-color: white;">
                                        <asp:UpdatePanel ID="UPTypes" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:GridView ID="grdCountries" runat="server" AutoGenerateColumns="False" DataSourceID="odsCountries"
                                                    DataKeyNames="ID" OnRowCommand="grdCountries_RowCommand" OnRowDataBound="grdCountries_RowDataBound"
                                                    AllowPaging="false" Width="100%" SkinID="GridViewNoPaging" >
                                                    <EmptyDataTemplate>
                                                        <div id="divInfo" class="MessageDiv" style="left: 38%; width: 150px; position: absolute;
                                                            top: 38%; height: 50px; margin: 5px;">
                                                            <table border="0" cellpadding="0" cellspacing="0" style="height: 50px; width: 100%;">
                                                                <tr>
                                                                    <td align="right" style="width: 25%" valign="middle">
                                                                        <div style="text-align: right">
                                                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/icn_info.gif" />
                                                                        </div>
                                                                    </td>
                                                                    <td id="divMessage" align="left" nowrap="nowrap" style="width: 75%" valign="middle">
                                                                        No Country Found! &nbsp;&nbsp;&nbsp;
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </EmptyDataTemplate>
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Name">
                                                            <EditItemTemplate>
                                                                <asp:TextBox MaxLength="25" ID="txtCountryEdit" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                                                                <asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvCountry" runat="server"
                                                                    ControlToValidate="txtCountryEdit" CssClass="RequiredField" Display="Static"
                                                                    ErrorMessage="Name is required."></asp:RequiredFieldValidator>
                                                            </EditItemTemplate>
                                                            <ItemStyle Width="78%" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="Label1" runat="server" Text='<%# Server.HtmlEncode(Eval("Name")) %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ShowHeader="False">
                                                            <ItemTemplate>
                                                                <a>Edit</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandName="Delete"
                                                                    CommandArgument='<%#Eval("ID")%>' Text="Delete" OnClientClick="javascript:event.cancelBubble=true;return confirm('Are you sure you want to delete this Country?');"></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                                <asp:ObjectDataSource ID="odsCountries" runat="server" SelectMethod="GetAll"
                                                    TypeName="Legal_Country" UpdateMethod="Update" DeleteMethod="Delete">
                                                    <UpdateParameters>
                                                        <asp:Parameter Name="ID" Type="Int32" />
                                                        <asp:Parameter Name="Name" Type="String" />
                                                    </UpdateParameters>
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="ID" Type="Int32" />
                                                    </DeleteParameters>
                                                </asp:ObjectDataSource>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="Save" EventName="Click" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <div id="NewType" align="center" style="border: black 1px solid; display: none; left: 128px;width: 240px; position: absolute; top: 24px; height: 150px">
            <asp:UpdatePanel ID="UPAdd" runat="server" >
                <ContentTemplate>
                <asp:Panel ID="Panel1" runat="server" DefaultButton="Save">
                    <table id="tblSearch" border="0" cellpadding="0" cellspacing="0" height="150" style="display: inline;
                        font-weight: bold; font-size: 12px; width: 100%; border-bottom: #000000 1px solid;
                        background-color: #daf5d6">
                        <tr>
                            <td height="28" style="font-weight: bold; font-size: 12px; background-image: url(images/bg_CellNormal_black.jpg);
                                cursor: default; color: white; border-bottom: #000000 1px solid" width="100%">
                                &nbsp;New Country<span id="edit" style="display: none;">&nbsp;<asp:Label ID="lblEditCaption"
                                    Text="(edit)" runat="server"></asp:Label></span></td>
                            <td align="right" style="padding-right: 2px; font-weight: bold; font-size: 12px;
                                background-image: url(images/bg_CellNormal_black.jpg); color: white; padding-top: 2px;
                                border-bottom: #000000 1px solid; height: 20px" valign="top" width="35">
                                <img onClick="HideAddNewCountry();"
                                    src="../images/closebox2.gif" /></td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2" style="border-right: 0px; border-top: #000000; border-left: 0px;
                               border-bottom: #609bd3 1px solid" valign="middle">
                                    <table style="background-color: #daf5d6">
                                        <tr>
                                            <td colspan="2">
                                                <asp:Label ID="lblMsg" runat="server" CssClass="RequiredField" Font-Size="Smaller"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Name :</td>
                                            <td>
                                                <asp:TextBox ID="txtNewCountry" runat="server" CausesValidation="True" EnableViewState="False" 
                                                    MaxLength="25" ValidationGroup="newType"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td>
                                                <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator1" runat="server"
                                                    ControlToValidate="txtNewCountry" CssClass="RequiredField" Display="Static"
                                                    ErrorMessage="Please Enter Name !" ValidationGroup="newType"></asp:RequiredFieldValidator></td>
                                        </tr>
                                    </table>
                            </td>
                        </tr>
                        <tr class="HeaderRowGreen">
                            <td align="center" colspan="2" height="31">
                                <asp:Button ID="Save" runat="server" CssClass="btn" Style="width: 50px; height: 20px"
                                    Text="Save" ValidationGroup="newType" OnClientClick="document.getElementById(&quot;lblMsg&quot;).style.display='none';" />
                                <input id="Close" class="btn" name="Close" onClick="HideAddNewCountry();"
                                    style="width: 50px; height: 20px" type="button" value="Close" />
                            </td>
                        </tr>
                    </table>
                    </asp:Panel>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="Save" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
