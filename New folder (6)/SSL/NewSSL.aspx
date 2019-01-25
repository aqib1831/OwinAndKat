				   <%@ Page Language="VB" AutoEventWireup="false" EnableTheming="true" EnableViewState="true"
    Theme="Default" CodeFile="NewSSL.aspx.vb" Inherits="SSL_NewSSL" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>SSL Management</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js">     </script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js">      </script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js">   </script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js">   </script>
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=.2)" />
</head>
<body style="margin: 0px; background-color: #DAF5D6; height: 100%; width: 100%;">
    <form id="form1" runat="server">
    <div>
        <table cellspacing="0" border="0" style="height: 100%; width: 100%;" class="FormTable">
            <tr>
                <td style="height: 31px; font-size: 13px; font-weight: bold; padding: 5px; border-bottom: 1px solid #609BD3;">
                    <asp:Label runat="server" ID="lblTitle" Text="New SSL"></asp:Label>&nbsp;&nbsp;<asp:Label
                        runat="server" ID="lblErrorMessage" CssClass="ErrorMessage" Text=" " Visible="false"></asp:Label>
                    <asp:HiddenField ID="hdnURLID" runat="server" Value="0" />
                </td>
            </tr>
            <tr>
                <td align="center" style="vertical-align: top; height: 100%; background-color: #DAF5D6;
                    width: 100%;">
                    <div style="overflow: auto; background-color: #DAF5D6;" id="divNewURL" runat="server">
                        <table style="height: 100%;" cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr>
                                <td style="width: 15%; background-color: #DAF5D6;">
                                </td>
                                <td style="padding-bottom: 10px; padding-top: 10px; background-color: #DAF5D6;" align="center">
                                    <table cellspacing="4" cellpadding="1" width="100%" class="FormInnerTable" align="center"
                                        border="0">
                                        <tr style="background-color: #DAF5D6;">
                                            <td valign="top" width="10%">
                                            </td>
                                            <td valign="top" width="15%" class="SimpleLabel">
                                                SSL:<span class="ErrorMessage">*</span>
                                            </td>
                                            <td style="width: 85%;" valign="top">
                                                <asp:TextBox SkinID="GreenSmallTextbox" MaxLength="150" ID="txtURL" runat="server"
                                                    Width="200"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" CssClass="ErrorMessage"
                                                    runat="server" ControlToValidate="txtURL" ValidationGroup="NewSSL" ErrorMessage="Enter SSL."
                                                    Display="Dynamic">
                                                </asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="regUrl" runat="server" ValidationGroup="NewSSL" CssClass="ErrorMessage" Font-Bold="false" ControlToValidate="txtURL" Display="Dynamic" ErrorMessage="Enter valid SSL." ValidationExpression="^[^#![;<>\\)}{?|(]*$"></asp:RegularExpressionValidator>
                                            </td>
                                        </tr>
                                        <tr style="background-color: #DAF5D6;">
                                            <td valign="top" width="10%">
                                            </td>
                                            <td valign="top" class="SimpleLabel">
                                                Registrar:<span class="ErrorMessage">*</span>
                                            </td>
                                            <td valign="top">
                                                <asp:DropDownList SkinID="SmallTextCombo" ID="ddlRegistrar1" runat="server" DataValueField="ID"
                                                    DataTextField="DataText" DataSourceID="srcRegistrar" Width="200">
                                                </asp:DropDownList>
                                                <asp:ObjectDataSource ID="srcRegistrar" runat="server" TypeName="SSLM" SelectMethod="GetAllRegistrars">
                                                </asp:ObjectDataSource>
                                                <asp:CompareValidator ID="CompareValidator4" runat="server" CssClass="ErrorMessage"
                                                    ControlToValidate="ddlRegistrar1" ValidationGroup="NewSSL" ErrorMessage="Select Registrar"
                                                    Display="Dynamic" ValueToCompare="0" Operator="NotEqual"></asp:CompareValidator>
                                            </td>
                                        </tr>
                                        <tr style="background-color: #DAF5D6;">
                                            <td valign="top" width="10%">
                                            </td>
                                            <td valign="top" class="SimpleLabel">
                                                Category:<span class="ErrorMessage">*</span>
                                            </td>
                                            <td valign="top">
                                                <asp:DropDownList SkinID="SmallTextCombo" ID="ddlCategory1" runat="server" DataValueField="ID"
                                                    DataTextField="DataText" DataSourceID="srcCategory" Width="200">
                                                </asp:DropDownList>
                                                <asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="ddlCategory1"
                                                    ValidationGroup="NewSSL" CssClass="ErrorMessage" ErrorMessage="Select Category"
                                                    Display="Dynamic" ValueToCompare="0" Operator="NotEqual">
                                                </asp:CompareValidator>
                                                <asp:ObjectDataSource ID="srcCategory" runat="server" TypeName="SSLM" SelectMethod="GetAllCategories">
                                                </asp:ObjectDataSource>
                                            </td>
                                        </tr>
                                        <tr style="background-color: #DAF5D6;">
                                            <td valign="top" width="10%">
                                            </td>
                                            <td valign="top" class="SimpleLabel">
                                                Account:<span class="ErrorMessage">*</span>
                                            </td>
                                            <td valign="top">
                                                <asp:DropDownList SkinID="SmallTextCombo" ID="ddlAccount1" runat="server" DataValueField="ID"
                                                    DataTextField="DataText" DataSourceID="srcAccounts" EnableViewState="true" Width="200">
                                                </asp:DropDownList>
                                                <asp:ObjectDataSource ID="srcAccounts" runat="server" TypeName="SSLM" SelectMethod="GetAllAccounts">
                                                </asp:ObjectDataSource>
                                                <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddlAccount1"
                                                    CssClass="ErrorMessage" ValidationGroup="NewSSL" ErrorMessage="Select Account"
                                                    Display="Dynamic" ValueToCompare="0" Operator="NotEqual">
                                                </asp:CompareValidator>
                                            </td>
                                        </tr>
                                        <tr style="background-color: #DAF5D6;">
                                            <td valign="top" width="10%">
                                            </td>
                                            <td valign="top" class="SimpleLabel">
                                                Country:
                                            </td>
                                            <td valign="top">
                                                <asp:DropDownList SkinID="SmallTextCombo" ID="ddlCountry" runat="server" DataValueField="ID"
                                                    DataTextField="Name" DataSourceID="odsGetAllCountries" EnableViewState="true"
                                                    Width="200">
                                                </asp:DropDownList>
                                                <asp:ObjectDataSource ID="odsGetAllCountries" runat="server" TypeName="SSLM" SelectMethod="GetAllCountries">
                                                </asp:ObjectDataSource>
                                            </td>
                                        </tr>
                                        <tr style="background-color: #DAF5D6;">
                                            <td valign="top" width="10%">
                                            </td>
                                            <td valign="top" class="SimpleLabel">
                                                Exp. Date:<span class="ErrorMessage">*</span>
                                            </td>
                                            <td valign="top">
                                                <asp:TextBox SkinID="GreenSmallTextbox" ID="txtExpirydate" runat="server" Width="170"></asp:TextBox>
                                                <img style="cursor: pointer" onclick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtExpirydate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                                    height="20" src="../images/ico_calendar.jpg" width="24" align="absMiddle" alt="" />&nbsp;
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtExpirydate"
                                                    CssClass="ErrorMessage" ValidationGroup="NewSSL" ErrorMessage="Enter Date" Display="Dynamic"
                                                    SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                <asp:CompareValidator ID="CompareValidator1" CssClass="ErrorMessage" runat="server"
                                                    ControlToValidate="txtExpirydate" Display="Dynamic" ErrorMessage="Enter valid Date"
                                                    Operator="DataTypeCheck" Type="Date" ValidationGroup="NewSSL"></asp:CompareValidator>
                                            </td>
                                        </tr>
                                        <tr style="background-color: #DAF5D6;">
                                            <td valign="top" width="10%">
                                            </td>
                                            <td valign="top" class="SimpleLabel">
                                                Act. Date:
                                            </td>
                                            <td valign="top">
                                                <asp:TextBox SkinID="GreenSmallTextbox" onfocus="this.blur();" ID="txtActivationDate"
                                                    runat="server" Width="170"></asp:TextBox>
                                                <img style="cursor: pointer" onclick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtActivationDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                                    height="20" src="../images/ico_calendar.jpg" width="24" align="absMiddle" alt="" />&nbsp;
                                            </td>
                                        </tr>
                                        <tr style="background-color: #DAF5D6;">
                                            <td valign="top" width="10%">
                                            </td>
                                            <td valign="top" class="SimpleLabel">
                                                Reg. Date:
                                            </td>
                                            <td valign="top">
                                                <asp:TextBox SkinID="GreenSmallTextbox" onfocus="this.blur();" ID="txtRegistration"
                                                    runat="server" Width="170"></asp:TextBox>
                                                <img style="cursor: pointer" onclick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtRegistration.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                                    height="20" src="../images/ico_calendar.jpg" width="24" align="absMiddle" alt="" />&nbsp;
                                            </td>
                                        </tr>
                                        <tr style="background-color: #DAF5D6;">
                                            <td valign="top" width="10%">
                                            </td>
                                            <td valign="top" class="SimpleLabel">
                                                Who is Server:
                                            </td>
                                            <td valign="top">
                                                <asp:TextBox SkinID="GreenSmallTextbox" ID="txtWhoisServer" runat="server" Width="200"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr style="background-color: #DAF5D6;">
                                            <td valign="top" width="10%">
                                            </td>
                                            <td valign="top" class="SimpleLabel">
                                                Name Server1:
                                            </td>
                                            <td valign="top">
                                                <asp:TextBox SkinID="GreenSmallTextbox" MaxLength="70" ID="txtnameServer1" runat="server"
                                                    Width="200"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr style="background-color: #DAF5D6;">
                                            <td valign="top" width="10%">
                                            </td>
                                            <td valign="top" class="SimpleLabel">
                                                Name Server2:
                                            </td>
                                            <td class="SimpleLabel" valign="top">
                                                <asp:TextBox SkinID="GreenSmallTextbox" ID="txtNameServer2" runat="server" Width="200"
                                                    MaxLength="70"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr style="background-color: #DAF5D6;">
                                            <td valign="top" width="10%">
                                            </td>
                                            <td valign="top" class="SimpleLabel">
                                                Referral SSL:
                                            </td>
                                            <td valign="top">
                                                <asp:TextBox SkinID="GreenSmallTextbox" ID="txtreferralURL" runat="server" MaxLength="70"
                                                    Width="200"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr style="background-color: #DAF5D6;">
                                            <td valign="top" width="10%">
                                                &nbsp;</td>
                                            <td valign="top" class="SimpleLabel">
                                                Notes:</td>
                                            <td valign="top">
                                                <asp:TextBox ID="txtNotes" runat="server" Height="90px" TextMode="MultiLine" SkinID="GreenSmallTextbox"
                                                    Width="200px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr style="background-color: #DAF5D6;">
                                            <td valign="top" width="10%">
                                            </td>
                                            <td align="left" class="SmallText" colspan="2" valign="bottom">
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Fields marked with
                                                an asterisk <span class="RequiredField" style="color: #000000"><span style="color: #ff0000">
                                                    *</span></span> are required.
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="center" style="height: 31px; border-top: 1px solid #609BD3; vertical-align: middle;">
                    <asp:Button ID="btnSave" runat="server" Text="Save" ValidationGroup="NewSSL" CssClass="Btn3D"
                        Width="80px" />&nbsp;&nbsp;
                    <asp:Button ID="btnBack" PostBackUrl="~/SSL/SSLHome.aspx" runat="server" Text="Cancel"
                        CausesValidation="false" CssClass="Btn3D" />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>