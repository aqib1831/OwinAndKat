<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CaseDetail.aspx.vb" Inherits="admin_Legal_CaseDetail" Theme="Default" validateRequest="false" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body style="margin:0px;">
    <form id="form1" runat="server">
        <asp:FormView runat="server" ID="fvLeadVitals" Width="100%" Height="100%" DataSourceID="CaseInfoDS"
                            CellPadding="0">
                            <ItemTemplate>
                                <table style="width: 100%; height: 100%;" border="0" cellpadding="0" cellspacing="0">
                                    <tr style="border-color: #FFFFFF;">
                                        <td  style="border-bottom: solid 1px #609BD3;">
                                            <table style="width: 100%; height: 100%; border-right: 1px solid #609BD3;"
                                                border="0" align="center" cellpadding="0" cellspacing="0" class="blueSubTableTD">
                                                <tr>
                                                    <th style="height: 20px;" align="left">
                                                        &nbsp;Intellectual Property Information
                                                    </th>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div style="height: 100%; width: 100%; overflow-y: auto;">
                                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Title</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label1" runat="server" ToolTip='<%#Eval("Title") %>' Text='<%#Functions.StringTruncate(Eval("Title"),30) %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Type</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label3" runat="server" Text='<%#IntellectualProperty.GetLegalTypeID(Eval("Type")) %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Assigned</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label5" runat="server" Text='<%#CaseMgmt.Legal_GetAdminName(Eval("AssignedTo")) %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        From</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label6" runat="server" Text='<%#CaseMgmt.Legal_GetAdminName(Eval("AdminID")) %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        First Used</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label7" runat="server" Text='<%#Convert.ToDateTime(Eval("DateFirstUsed").ToString()).ToShortDateString() %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Applied</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label8" runat="server" Text='<%#IIF(Eval("DateApplied").ToString()<>"" ,Eval("DateApplied"),"&nbsp;")%>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Modified</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label2" runat="server" Text='<%#IIF(Eval("ModifiedDate").ToString()<>"" ,Eval("ModifiedDate"),"&nbsp;")%>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Firm</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label9" runat="server" Text='<%#IIF(Eval("Name").ToString()<>"",Eval("Name"),"&nbsp;") %>'>&nbsp;</asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Status</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label10" runat="server" Text='<%#IntellectualProperty.GetLegalStatusID(Eval("Status")) %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Reg. #</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label11" runat="server" Text='<%#IIF(Eval("DocketNo").ToString()<>"",Eval("DocketNo"),"&nbsp;") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Serial #</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label12" runat="server" Text='<%#IIF(Eval("FirmCaseNo").ToString()<>"",Eval("FirmCaseNo"),"&nbsp;") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                               
                                                                <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        TimeSpent</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label14" runat="server" Text='<%#IIF(Eval("TimeSpent").ToString()<>"",Eval("TimeSpent"),"&nbsp;") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                  <tr>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Expires</td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label4" runat="server" Text='<%#Convert.ToDateTime(Eval("ExpiresOn").ToString()).ToShortDateString() %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                               
                                                                <tr style='<%#IIF(Eval("Name").ToString()<>"","Display:inline" , "Display:none") %>'>
                                                                    <th style="height: 20px; font-weight: bold; border-top: 1 solid #7DA4CD;" colspan="2"
                                                                        align="left">
                                                                        &nbsp;Vendor Information</th>
                                                                </tr>
                                                                <tr style='<%#IIF(Eval("Name").ToString()<>"","Display:inline" , "Display:none") %>'>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Name
                                                                    </td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label15" runat="server" Text='<%#Eval("Name") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr style='<%#IIF(Eval("Address").ToString()<>"","Display:inline" , "Display:none") %>'>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Address
                                                                    </td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label16" runat="server" Text='<%#Eval("Address") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr style='<%#IIF(Eval("Phone").ToString()<>"","Display:inline" , "Display:none") %>'>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Phone
                                                                    </td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label17" runat="server" Text='<%#Eval("Phone") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr style='<%#IIF(Eval("Fax").ToString()<>"","Display:inline" , "Display:none") %>'>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Fax
                                                                    </td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label18" runat="server" Text='<%#Eval("Fax") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr style='<%#IIF(Eval("Country").ToString()<>"","Display:inline" , "Display:none") %>'>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Country
                                                                    </td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label19" runat="server" Text='<%#Eval("Country") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr style='<%#IIF(Eval("State").ToString()<>"","Display:inline" , "Display:none") %>'>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        State
                                                                    </td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label20" runat="server" Text='<%#Eval("State") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr style='<%#IIF(Eval("City").ToString()<>"","Display:inline" , "Display:none") %>'>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        City
                                                                    </td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label21" runat="server" Text='<%#Eval("City") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr style='<%#IIF(Eval("Zip").ToString()<>"","Display:inline" , "Display:none") %>'>
                                                                    <td style="width: 30%; padding-left: 5px;">
                                                                        Zip
                                                                    </td>
                                                                    <td style="height: 20px; font-weight: bold; width: 70%;" align="left">
                                                                        <asp:Label ID="Label22" runat="server" Text='<%#Eval("Zip") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td valign="top" style="width: 27px;">
                                            <table width="27" style="height: 100%;" border="0" align="left" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="height: 219px; cursor: pointer;" colspan="2" id="OpenProfile">
                                                        <img src="../../images/vital_info_open.gif" onmouseout="this.src='../../images/vital_info_open.gif'"
                                                            onmouseover="this.src='../../images/vital_info_open_over.gif'" onclick="showHideVital();"
                                                            name="img_vital_info" width="27" height="219" border="0" alt="" /></td>
                                                    <td style="height: 219px; display: none; cursor: pointer;" colspan="2" id="CloseProfile">
                                                        <img src="../../images/vital_info_close.gif" onmouseout="this.src='../../images/vital_info_close.gif'"
                                                            onmouseover="this.src='../../images/vital_info_close_over.gif'" onclick="showHideVital();"
                                                            name="img_vital_info" width="27" height="219" border="0" alt="" /></td>
                                                </tr>
                                                <tr>
                                                    <td style="background-image: url(../../images/vital_info_bottom_bg.gif); width: 8px;
                                                        border-bottom: 1px solid #609BD3;">
                                                        &nbsp;
                                                    </td>
                                                    <td style="width: 19px;">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:FormView>
        <asp:ObjectDataSource ID="CaseInfoDS" runat="server" SelectMethod="GetIPFirmInfo"
            TypeName="IntellectualProperty">
            <SelectParameters>
                <asp:QueryStringParameter Name="IPID" QueryStringField="ID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
    
    </form>
</body>
</html>
