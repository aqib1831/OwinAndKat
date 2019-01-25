<%@ Page Language="VB" Theme="Default" AutoEventWireup="false" CodeFile="ProductModule.aspx.vb" Inherits="Admin_ProductModule" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Module</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript"  src="../scripts/functions.js" language="javascript" ></script>    
</head>
<body style ="margin :0px;background-color:#F2F2F2; height:100%;width:100%; overflow:auto; ">
    <form id="form1" runat="server">
    <div>
        <table style="height:100%;width:100%;" cellspacing="0" border="0" cellpadding="0" >
            <tr><td colspan="3"></td></tr>
            <tr>
                <td></td>
                <td style="width:300px;height:200px;" valign="top">
                    <table style="width:100%;height:100%;" cellspacing="0" cellpadding="0" class="tblProductModule" >
                        <tr>
                            <th colspan="2">
                                <asp:Literal ID="ltrlProductOpeation" Text="New Module" runat="server" />
                                <asp:HiddenField ID="hdnModuleID" runat="server" />
                                <asp:HiddenField ID="hdnProductID" runat="server" />
                            </th>
                        </tr>
                        <tr>
                            <td style="width:70px;height:20px;"></td>
                            <td style="">
                                <asp:CustomValidator
                                    ID="cvValidateModuleName"
                                    runat="server"
                                    Display="Dynamic"
                                    ErrorMessage="Module with this name already exsits">
                                </asp:CustomValidator>
                                <asp:RequiredFieldValidator 
                                    ID="rfvModuleName"
                                    runat="server"
                                    Display="Dynamic"
                                    ControlToValidate="txtModuleName"
                                    ErrorMessage="Please enter module name">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="height:25px;">Name:<span class="RequiredField">*</span></td>
                            <td>
                                <asp:TextBox ID="txtModuleName" style="font:9pt Arial;" runat="server" MaxLength="150" Width="200" />
                            </td>
                        </tr>
                        <tr>
                            <td style="height:25px;">Related to: </td>
                            <td>
                                <asp:DropDownList
                                    ID="ddlProducts"
                                    DataTextField="Title"
                                    DataValueField="ID"
                                    runat="server"
                                    Width="200"
                                    DataSourceID="sdsProducts" />
                            </td>
                        </tr>
                        <tr>
                            <td style="height:25px;">Inactive: </td>
                            <td>
                                <asp:CheckBox ID="chkInactive" runat="server"/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <asp:Button 
                                    ID="btnSave"
                                    runat="server"
                                    Text="Save" 
                                    CssClass="btnSimple" 
                                    Width="80px" />&nbsp;
                                <asp:Button 
                                    ID="btnCancel"
                                    runat="server"
                                    Text="Cancel" 
                                    OnClientClick="javascript:window.location='ManageProductModules.aspx'; return false"
                                    CssClass="btnSimple" 
                                    Width="80px" />                                
                                <asp:SqlDataSource 
                                    ID="sdsProducts"
                                    ConnectionString = '<%$ ConnectionStrings:PortalConnectionString %>'                                    
                                    runat="server"
                                    SelectCommand="NS_Products_GetAllForModules" />                                    
                            </td>
                        </tr>
                    </table>
                </td>
                <td></td>
            </tr>
            <tr><td></td></tr>
        </table>
    </div>
    </form>
</body>
</html>
