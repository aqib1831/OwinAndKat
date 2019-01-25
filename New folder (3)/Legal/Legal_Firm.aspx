<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Legal_Firm.aspx.vb" Inherits="admin_Legal_Legal_Firm" validateRequest="false" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>

    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>

    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>

    <script type="text/javascript" language="JavaScript" src="../scripts/functions.js"></script>

    <link href="../style/style.css" type="text/css" rel="stylesheet" />
    <link href="Style/Style.css" type="text/css" rel="stylesheet" />
    <link href="../style/Calendar/style.css" type="text/css" rel="stylesheet" />
    <title>Legal Vendor</title>
</head>
<body style="margin: 0px; width: 100%; height: 100%; overflow: hidden;" scroll="no">
    <form id="form1" runat="server">
        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%;"
            class="MainTable">
            <tr class="HeaderRowGreen">
                <td style="font-weight: bold; font-family: Helvetica; padding-left: 5px; height: 31px;">
                    <asp:Label ID="lblHeading" runat="server" Font-Names="Helvetica" font-weight="bold"></asp:Label></td>
            </tr>
            <tr>
                <td align="center" style="padding-right: 2px; padding-left: 2px; background-color: white;" valign="top">
                   <div style="overflow-y:auto; height:100%;">
                   
                    <table border="0" cellpadding="0" cellspacing="0" style="width: 65%;
                        text-align: left">
                        <tr>
                            <td style="padding-left: 5px; width: 25%; height: 10px" align="left" colspan="2">
                                <asp:HiddenField ID="hdnFirmID" runat="server" />
                            </td>
                        </tr>
                         <tr>
                            <td style="padding-left: 5px; width: 20%; border-bottom: #4faf43 thin solid; height: 20px; font-size:10pt; font-weight:600;"
                                align="left" colspan="2">
                                Firm/Vendor Information</td>
                           
                        </tr>
                        <tr>
                            <td align="left" style="padding-left: 5px; width: 25%; border-bottom: #4faf43 1px solid;
                                height: 20px">
                                Name:</td>
                            <td style="width: 338px; font-size: 9pt; color: #000000; border-bottom: #4faf43 1px solid;
                                height: 20px;" align="left">
                                <asp:Label Font-Bold="True" ID="lblName" runat="server"></asp:Label></td>
                        </tr>
                        
                         <tr>
                            <td align="left" style="padding-left: 5px; width: 25%; padding-top: 5px; border-bottom: #4faf43 1px solid;
                                height: 20px" valign="middle">
                                Type:</td>
                            <td align="left" style="font-size: 8pt; width: 338px; color: #000000; border-bottom: #4faf43 1px solid;
                                height: 20px">
                                <asp:Label Font-Bold="True" ID="lblType" runat="server"></asp:Label></td>
                        </tr>
                        <tr style="color: #000000; display:none;" id="tr1">
                            <td align="left" style="padding-left: 5px; width: 25%; border-bottom: #4faf43 1px solid;
                                height: 20px">
                                Title:</td>
                            <td style="width: 338px; font-size: 9pt; color: #000000; border-bottom: #4faf43 1px solid;
                                height: 20px;" align="left">
                                <asp:Label ID="lblTitle" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                        <tr style="color: #000000">
                            <td align="left" style="padding-left: 5px; width: 25%; padding-top: 5px; border-bottom: #4faf43 1px solid;
                                height: 20px" valign="middle">
                                Address:</td>
                            <td align="left" style="font-size: 8pt; width: 338px; color: #000000; border-bottom: #4faf43 1px solid;
                                height: 20px">
                                <asp:Label ID="lblAddress" runat="server" Font-Bold="True"></asp:Label></td>
                        </tr>
                       
                        <tr>
                            <td align="left" style="padding-left: 5px; width: 25%; padding-top: 5px; border-bottom: #4faf43 1px solid;
                                height: 20px">
                                Country:</td>
                            <td style="width: 338px; border-bottom: #4faf43 1px solid; height: 20px">
                                <table cellpadding="0" cellspacing="0" style="width: 338px">
                                    <tr>
                                        <td align="left" style="width: 148px">
                                            <asp:Label ID="lblCountry" runat="server" Font-Bold="True"></asp:Label></td>
                                        <td align="left" style="padding-left: 5px; padding-top: 5px">
                                            City:</td>
                                        <td align="right" style="padding-left: 5px; width: 161px">
                                            <asp:Label ID="lblCity" runat="server" Font-Bold="True"></asp:Label>&nbsp;</td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="padding-left: 5px; width: 25%; padding-top: 5px; border-bottom: #4faf43 1px solid;
                                height: 20px">
                                State:</td>
                            <td style="width: 338px; border-bottom: #4faf43 1px solid; height: 20px">
                                <table cellpadding="0" cellspacing="0" style="width: 338px">
                                    <tr>
                                        <td style="width: 148px">
                                            <asp:Label ID="lblState" runat="server" Font-Bold="True"></asp:Label></td>
                                        <td align="left" style="padding-left: 5px; padding-top: 5px">
                                            Zip Code:</td>
                                        <td align="right" style="padding-left: 5px">
                                            <asp:Label ID="lblZipCode" runat="server" Font-Bold="True"></asp:Label></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="padding-left: 5px; width: 25%; border-bottom: #4faf43 1px solid;
                                height: 20px">
                                Phone:</td>
                            <td align="left" style="font-size: 9pt; border-bottom: #4faf43 1px solid; height: 20px;">
                                 <table cellpadding="0" cellspacing="0" style="width: 338px">
                                    <tr>
                                        <td style="width: 148px">
                                            <asp:Label ID="lblPhone" runat="server" Font-Bold="True"></asp:Label></td>
                                        <td align="left" style="padding-left: 5px; padding-top: 5px">
                                            Fax:</td>
                                        <td align="right" style="padding-left: 5px">
                                             <asp:Label ID="lblFax" runat="server" Font-Bold="True"></asp:Label></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="padding-left: 5px; width: 25%; padding-top: 5px; border-bottom: #4faf43 1px solid;
                                height: 20px" valign="middle">
                                Web Site:</td>
                            <td align="left" style="font-size: 8pt; width: 338px; color: #000000; border-bottom: #4faf43 1px solid;
                                height: 20px">
                                <asp:Label Font-Bold="True" ID="lblWebSite" runat="server" Text="&nbsp;"></asp:Label></td>
                        </tr>
                        <tr>
                        <td style="height:15px;"></td>
                        </tr>
                         <tr>
                            <td style="padding-left: 5px; width: 20%; border-bottom: #4faf43 thin solid; height: 20px; font-size:10pt; font-weight:600;"
                                align="left" colspan="2">
                                Primary Contact Information</td>
                           
                        </tr>
                           <tr>
                            <td align="left" style="padding-left: 5px; width: 25%; border-bottom: #4faf43 1px solid;
                                height: 20px">
                                Name:</td>
                            <td style="width: 338px; font-size: 9pt; color: #000000; border-bottom: #4faf43 1px solid;
                                height: 20px;" align="left">
                                <asp:Label Font-Bold="True" ID="lblContactName" runat="server"></asp:Label></td>
                        </tr>
                         <tr>
                            <td align="left" style="padding-left: 5px; width: 25%; border-bottom: #4faf43 1px solid;
                                height: 20px">
                                Title:</td>
                            <td style="width: 338px; font-size: 9pt; color: #000000; border-bottom: #4faf43 1px solid;
                                height: 20px;" align="left">
                                <asp:Label Font-Bold="True" ID="lblContactTitle" runat="server"></asp:Label></td>
                        </tr>
                         <tr>
                            <td align="left" style="padding-left: 5px; width: 25%; border-bottom: #4faf43 1px solid;
                                height: 20px">
                                Department:</td>
                            <td style="width: 338px; font-size: 9pt; color: #000000; border-bottom: #4faf43 1px solid;
                                height: 20px;" align="left">
                                <asp:Label Font-Bold="True" ID="lblDept" runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <td align="left" style="padding-left: 5px; width: 25%; border-bottom: #4faf43 1px solid;
                                height: 20px">
                                Phone:</td>
                            <td style="width: 338px; font-size: 9pt; color: #000000; border-bottom: #4faf43 1px solid;
                                height: 20px;" align="left">
                                <asp:Label Font-Bold="True" ID="lblContactPhone" runat="server"></asp:Label></td>
                        </tr>
                         <tr>
                            <td align="left" style="padding-left: 5px; width: 25%; border-bottom: #4faf43 1px solid;
                                height: 20px">
                                Fax:</td>
                            <td style="width: 338px; font-size: 9pt; color: #000000; border-bottom: #4faf43 1px solid;
                                height: 20px;" align="left">
                                <asp:Label Font-Bold="True" ID="lblContactFax" runat="server"></asp:Label></td>
                        </tr>
                         <tr>
                            <td align="left" style="padding-left: 5px; width: 25%; border-bottom: #4faf43 1px solid;
                                height: 20px">
                                Email:</td>
                            <td style="width: 338px; font-size: 9pt; color: #000000; border-bottom: #4faf43 1px solid;
                                height: 20px;" align="left">
                                <asp:Label Font-Bold="True" ID="lblContactEmail" runat="server"></asp:Label></td>
                        </tr>
                    </table>
                   </div>
                </td>
            </tr>
            <tr>
                <td align="center" style="background-color: white; height:5px;">
                    &nbsp;</td>
            </tr>
            <tr class="FooterRowGreen">
                <td align="center" style="height: 31px">
                    <asp:Button ID="btnEdit" runat="server" CssClass="btnGreen" Style="width: 80px" Text="Edit" />
                    <asp:Button
                        ID="btnBack" runat="server" CssClass="btnGreen" Style="width: 80px" Text="Back" />&nbsp;</td>
            </tr>
        </table>
    </form>
</body>
</html>
