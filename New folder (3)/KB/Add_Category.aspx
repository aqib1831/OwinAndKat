<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Add_Category.aspx.vb" Inherits="KB_Add_Category"
    Theme="Default" ValidateRequest="false" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Category</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <link href="../App_Themes/Default/Calendar/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
</head>
<body style="margin: 0px; height: 100%; width: 100%;padding:0px;">
    <form id="form1" runat="server">
        <div>
            <table cellpadding="0" cellspacing="0" border="0" style="width: 100%; height: 100%;">
                <tr class="HeaderRowGreen">
                    <td style="height: 31px; width: 50%; font-weight: bold; font-family: Helvetica;">
                        <asp:Label ID="lblHeading" runat="server" Text="New Category" font-weight="bold" Font-Names="Helvetica"></asp:Label></td>
                    <td style="text-align: right; height: 31px;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="background-color: #DAF5D6;" align="center" valign="top">
                        <table cellpadding="0" cellspacing="0" border="0" style="width: 95%; height: 70%;
                            text-align: center; background-color: #DAF5D6;">
                            <tr>
                                <td align="left" style="height: 10px" valign="middle">
                                </td>
                                <td align="left" colspan="2" style="height: 6px" valign="middle">
                                </td>
                                <td align="left" style="width: 2px">
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="height: 30px;" valign="middle">
                                </td>
                                <td style="padding-left: 20px;font-size: 10pt;width: 100px;height:30px;" align="left" valign="middle">
                                  Title:<span style="font-size: 8pt; color: #ff0000">*</span></td>
                                <td align="left" valign="middle">
                                    <asp:TextBox ID="txtName" runat="server" CssClass="SmallGreenTextBox" Style="width: 350px;"
                                        MaxLength="75" Width="200px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="val_Title" runat="server" ControlToValidate="txtName"
                                        CssClass="ErrorMessage" Display="Dynamic" ErrorMessage="Enter Title"></asp:RequiredFieldValidator>
                                    <asp:Label ID="lblMsg" runat="server" Style="font-size: 8pt; color: #ff0000"></asp:Label></td>
                                <td align="left" style="width: 2px">
                                </td>
                            </tr>
                           <%-- <tr>
                                <td align="left" style="padding-bottom: 5px; height: 30px" valign="middle">
                                </td>
                                <td align="left" style="padding-left: 20px;font-size: 10pt; width: 100px;height:30px;" valign="middle">
                                    <span style="font-size: 10pt">Sequence</span> No:<span style="font-size: 8pt; color: #ff0000">*</span></td>
                                <td align="left">
                                    <asp:TextBox ID="txtSequence" runat="server" CssClass="SmallGreenTextBox" MaxLength="5"
                                        Style="width: 350px" Width="200px" onKeyUp="Validateit()"  ></asp:TextBox>&nbsp;<asp:Label ID="lblerror" runat="server"
                                            Text="" CssClass="ErrorMessage"></asp:Label><asp:RequiredFieldValidator ID="Val_Sequance" runat="server" ControlToValidate="txtSequence"
                                        CssClass="ErrorMessage" ErrorMessage="Enter sequence" Display="Dynamic"></asp:RequiredFieldValidator></td>
                                <td align="left" style="width: 2px">
                                </td>
                            </tr>--%>
                            <tr>
                                <td align="left" style="padding-top: 5px;" valign="top">
                                </td>
                                <td align="left" style="padding-left: 20px; width: 101px; padding-top: 5px" valign="top">
                                </td>
                                <td style="padding-left: 0px" valign="top">
                                </td>
                                <td style="width: 2px;">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="background-color: #DAF5D6; vertical-align: bottom; font-size: 12px;
                        padding-bottom: 10px;" align="center" valign="bottom" class="RequiredFieldMessage">
                        Fields marked with an asterisk <span class="RequiredField">*</span> are required.
                    </td>
                </tr>
                <tr class="FooterRowGreen">
                    <td colspan="2" align="center" style="height: 31px;">
                        <asp:Button ID="BtnSave" runat="server" Text="Save" Style="width: 80px;" CssClass="btnGreen" />
                        <asp:Button ID="BtnCancel" runat="server" Text="Cancel" Style="width: 80px;" CssClass="btnGreen"
                            CausesValidation="False" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
    <script type="text/javascript">
   
        
    function chk_val(val) {
    return /^\d+$/.test(val);
    }
    </script>
</body>
</html>
