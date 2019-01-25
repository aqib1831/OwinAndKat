<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Legal_Settings_IPActivityType.aspx.vb" Inherits="admin_Legal_Settings" Theme="Default" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Settings</title>
    <link href="../style/style.css" type="text/css" rel="stylesheet" />
    <link href="Style/Style.css" type="text/css" rel="stylesheet" />
    <link href="../style/Calendar/style.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
    <script type="text/javascript" language="javascript">
   function ShowAddNewType()
    {
        document.getElementById("NewType").style.top=(document.body.offsetHeight/2)-200;
        document.getElementById("NewType").style.left=(document.body.offsetWidth/2)-120;
        document.getElementById("NewType").style.display='inline';
        document.getElementById("txtNewTypeName").value='';
        document.getElementById("txtNewTypeName").focus();
    }
    function HideAddNewType()
    {
        document.getElementById('edit').style.display='none';
        document.getElementById("NewType").style.display='none';
        document.getElementById("lblMsg").style.display='none';
        document.getElementById("RequiredFieldValidator1").style.display='none';
    }
    </script>

</head>
<body scroll="no" style="margin: 0px; width: 100%; height: 100%;">
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />
            <asp:HiddenField ID="hdnEdit" runat="server" />
            <asp:HiddenField ID="hdnID" runat="server" />
            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%;"
                class="MainTable">
                <tr class="UnderlinedRow">
                    <td class="PageMainHeading" style="height: 31px">
                        Settings
                        <br />
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%;" valign="top">
                        <table border="0" cellpadding="0" cellspacing="0" height="100%" style="width: 100%;" width="100%">
                            <tr>
                                <td style="padding-right: 5px; padding-left: 5px; padding-bottom: 5px; padding-top: 5px;
                                    border-bottom: #609bd3 1px solid; height: 15px;">
                                    <strong>Intellectual Property Activity Types&nbsp; </strong>
                                    <img src="../images/spacer.gif" height="15" width="1" align="absmiddle" style="background-color: #82BDE9">&nbsp;
                                    <input id="btnNewIP" class="btnExtraSimple" onclick="ShowAddNewType();document.getElementById('hdnEdit').value=false;" style="width: 88px" type="button" value="Add New" /></td>
                            </tr>
                            <tr>
                                <td colspan="4" style="width: 100%; background-color: white;" valign="top">
                                    <div style="overflow-y: auto; height: 100%; background-color: white">
                                        <asp:UpdatePanel ID="UPTypes" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:GridView ID="gridCaseStatusType" runat="server" AutoGenerateColumns="False"
                                                    DataKeyNames="ID" DataSourceID="odsIPActivityType" OnRowCommand="gridCaseStatusType_RowCommand"
                                                    OnRowDataBound="gridCaseStatusType_RowDataBound" SkinID="GridViewNoPaging"  Width="100%" AllowPaging="false">
                                                    <EmptyDataTemplate>
                                                        <div id="divInfo" class="MessageDiv" style="left: 38%; width: 200px; position: absolute;
                                                            top: 38%; height: 50px; margin: 5px;">
                                                            <table border="0" cellpadding="0" cellspacing="0" style="height: 50px; width: 100%;">
                                                                <tr>
                                                                    <td align="right" style="width: 25%" valign="middle">
                                                                        <div style="text-align: right">
                                                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/icn_info.gif" />
                                                                        </div>
                                                                    </td>
                                                                    <td id="divMessage" align="left" nowrap="nowrap" style="width: 75%" valign="middle">
                                                                        No IP Activity Type Found! &nbsp;&nbsp;&nbsp;
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </EmptyDataTemplate>
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Name">
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtCaseStatusType" runat="server" MaxLength="25" Text='<%# Bind("Name") %>'></asp:TextBox>
                                                                <asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvCaseStatusType" runat="server"
                                                                    ControlToValidate="txtCaseStatusType" CssClass="RequiredField" Display="Static"
                                                                    ErrorMessage="Name is required."></asp:RequiredFieldValidator>
                                                            </EditItemTemplate>
                                                            <ItemStyle Width="78%" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="Label1" runat="server" Text='<%# Server.HtmlEncode(Eval("Name"))%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ShowHeader="False">
                                                            <ItemTemplate>
                                                                <a>Edit</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandArgument='<%#Eval("ID")%>'
                                                                    CommandName="Delete" OnClientClick="javascript:event.cancelBubble=true;return confirm('Are you sure you want to delete this IP Activity Type?');"
                                                                    Text="Delete"></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                                <asp:ObjectDataSource ID="odsIPActivityType" runat="server" DeleteMethod="DeleteIPActivityType"
                                                    SelectMethod="GetIPActivityTypes" TypeName="IntellectualProperty" UpdateMethod="UpdateIPActivityType">
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
                                        <asp:Panel ID="PanelType" runat="server" DefaultButton="Save">
                                            <div id="NewType" align="center" style="border-right: black 1px solid; border-top: black 1px solid;
                                                display: none; left: 128px; border-left: black 1px solid; width: 240px; border-bottom: black 1px solid;
                                                position: absolute; top: 24px; height: 150px;">
                                                <asp:UpdatePanel ID="UPAdd" runat="server" UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                        <table id="tblSearch" border="0" cellpadding="0" cellspacing="0" height="150" style="display: inline;
                                                            font-weight: bold; font-size: 12px; width: 100%; border-bottom: #000000 1px solid;
                                                            background-color: #daf5d6;">
                                                            <tr>
                                                                <td height="28" style="font-weight: bold; font-size: 12px; background-image: url(images/bg_CellNormal_black.jpg);
                                                                    cursor: default; color: white; border-bottom: #000000 1px solid" width="100%">
                                                                    &nbsp;New IP Activity Type<span id="edit" style="display: none;">&nbsp;<asp:Label
                                                                        ID="lblEditCaption" Text="(edit)" runat="server"></asp:Label></span></td>
                                                                <td align="right" style="padding-right: 2px; font-weight: bold; font-size: 12px;
                                                                    background-image: url(images/bg_CellNormal_black.jpg); color: white; padding-top: 2px;
                                                                    border-bottom: #000000 1px solid; height: 20px" valign="top" width="35">
                                                                    <img onclick="HideAddNewType();"
                                                                        src="../images/closebox2.gif" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center" colspan="2" style="border-right: 0px; border-top: #000000; border-left: 0px;
                                                                    border-bottom: #609bd3 1px solid" valign="middle">
                                                                    <table style="background-color: #daf5d6;">
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Label ID="lblMsg" runat="server" CssClass="RequiredField" Font-Size="Smaller"></asp:Label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                Name :</td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtNewTypeName" runat="server" CausesValidation="True" EnableViewState="False"
                                                                                    MaxLength="25" ValidationGroup="newType"></asp:TextBox></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                            </td>
                                                                            <td>
                                                                                <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator1" runat="server"
                                                                                    ControlToValidate="txtNewTypeName" CssClass="RequiredField" Display="Static"
                                                                                    ErrorMessage="Please Enter Type Name !" ValidationGroup="newType"></asp:RequiredFieldValidator></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr class="HeaderRowGreen">
                                                                <td align="center" colspan="2" height="31">
                                                                    <asp:Button ID="Save" runat="server" CssClass="btn" Style="width: 50px; height: 20px"
                                                                        Text="Save" ValidationGroup="newType" OnClientClick="document.getElementById(&quot;lblMsg&quot;).style.display='none';" />
                                                                    <input id="Close" class="btn" name="Close" onclick="HideAddNewType();"
                                                                        style="width: 50px; height: 20px" type="button" value="Close" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="Save" EventName="Click" />
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                            </div>
                                        </asp:Panel>
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
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
