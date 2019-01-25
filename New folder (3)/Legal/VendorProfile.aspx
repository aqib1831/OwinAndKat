<%@ Page Language="VB" AutoEventWireup="false" CodeFile="VendorProfile.aspx.vb" Inherits="admin_Legal_VendorProfile" Theme="Default" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Vendor Profile</title>
    <link rel="stylesheet" href="../style/style.css" />
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=.1)" />   
</head>
<body class="gradientbody" scroll="no" style="margin:0px;">
    <form id="form1" runat="server" class="DIVSCROLL">
    <asp:HiddenField ID="hdnFirmID" Value="" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" >
    </asp:ScriptManager>
     <div>
            <table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%;">
                <tr>
                    <td style="border:1px solid #6B94CA;">
                        <table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%;background-color:#DAF5D6;">
                            <tr class="HeaderRowGreen">
                                <td colspan="2" style="height:31px;padding-left:0.5em;">
                                    <strong>Firm/Vendor Profile</strong>
                                </td>
                                <td colspan="3" style="text-align:right;padding-right:1em;">
                                    <asp:UpdateProgress ID="Progress1" runat="server" DynamicLayout="false" EnableViewState="false">
                                        <ProgressTemplate>
                                            <div style="float:right;display:inline;">
                                                <asp:Image ID="Image2" runat="server" ImageUrl="~/images/loading.gif" ImageAlign="AbsMiddle" /><span style="font-size:12px;color:#275521"><b>&nbsp;&nbsp;Updating ...</b></span>
                                            </div>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                </td>
                            </tr>
                            
                            <tr>
                                <td style="width:50%">
                                    <div style="overflow:auto;height:100%;padding:4px;">
                                        <table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%;">
                                            <tr style="height: 1px;">
                                                <td colspan="3">
                                                    <asp:UpdatePanel ID="pnlUpdate" runat="server" RenderMode="Inline">
                                                        <ContentTemplate>
                                                            &nbsp;&nbsp;<asp:Label ID="lblMsg" runat="server" CssClass="RequiredField"></asp:Label>
                                                        </ContentTemplate>
                                                        <Triggers>
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><img alt="" src="../images/spacer.gif" height="1" width="1" /></td>
                                                <td align="center" style="width:270px;">
                                                    <asp:FormView 
                                                        runat="server"
                                                        ID="fvVendor"
                                                        Width="100%"
                                                        Height="100%"
                                                        DataSourceID="odsFirm"
                                                        DataKeyNames="StateID, Type"
                                                        CellPadding="0"
                                                        CellSpacing="0">
                                                        <ItemTemplate>
                                                            <table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%;">
                                                                <tr>
                                                                    <td colspan="2" style="height:30px;padding-top:5px;font-size:15px;border-bottom:1px solid #50AF43;" valign="top">
                                                                        <strong>Vital Information</strong>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height:25px;width:40px;padding-top:5px; padding-right:20px;" valign="top">Name:</td>
                                                                    <td style="padding-top:5px;" valign="top" >
                                                                        <strong>
                                                                            <%#Server.HtmlEncode(Container.DataItem("Name"))%>
                                                                        </strong>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height:25px;" valign="top">Type:</td>
                                                                    <td valign="top">
                                                                        <strong>
                                                                        
                                                                           <%#Server.HtmlEncode(Container.DataItem("FirmType"))%>
                                                                        </strong>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height:25px;padding-top:5px;" valign="top">Address:</td>
                                                                    <td valign="top" style="padding-top:5px;cursor:default;" title='<%#Container.DataItem("Address").ToString.Replace("'", "&rsquo;")%>'>
                                                                        <strong>
                                                                            <%#Server.HtmlEncode(Functions.StringTruncate(Container.DataItem("Address"), 40)).ToString.Replace(vbCrLf, "")%>
                                                                        </strong>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height:25px;" valign="top">City:</td>
                                                                    <td valign="top">
                                                                        <strong>
                                                                            <%#Server.HtmlEncode(Container.DataItem("City"))%>
                                                                        </strong>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height:25px;" valign="top">State:</td>
                                                                    <td valign="top">
                                                                        <strong>
                                                                            <%#Container.DataItem("State")%>
                                                                        </strong>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height:25px;" valign="top">Zip:</td>
                                                                    <td valign="top">
                                                                        <strong>
                                                                            <%#Server.HtmlEncode(Container.DataItem("Zip"))%>
                                                                        </strong>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height:25px;" valign="top">Country:</td>
                                                                    <td valign="top">
                                                                        <strong>
                                                                            <%#Server.HtmlEncode(Container.DataItem("Country"))%>
                                                                        </strong>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height:25px;" valign="top">Phone:</td>
                                                                    <td valign="top">
                                                                        <strong>
                                                                            <%#Server.HtmlEncode(Container.DataItem("Phone"))%>
                                                                        </strong>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height:25px;" valign="top">Fax:</td>
                                                                    <td valign="top">
                                                                        <strong>
                                                                            <%#Functions.ReplaceNullOrEmpty(Container.DataItem("Fax"), CType("-", Object))%>
                                                                        </strong>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height:25px;" valign="top">Website:</td>
                                                                    <td valign="top">
                                                                        <strong>
                                                                         <a target="_blank" runat="server" href='<%# (Functions.ReplaceNullOrEmpty(Container.DataItem("Website"), CType("-", Object)))%>'><%#Functions.ReplaceNullOrEmpty(Container.DataItem("Website"), CType("-", Object))%></a>
                                                                        </strong>
                                                                    </td>
                                                                </tr>
                                                                <tr><td colspan="2">&nbsp;</td></tr>
                                                                <tr>
                                                                    <td style="height:30px;" colspan="2" align="center">
                                                                        <asp:Button ID="EditButton" runat="server" Text="Edit" CommandName="Edit" CssClass="BtnGreen" Width="50px" ValidationGroup="vgVitals" CausesValidation="false" />
                                                                        
                                                                        </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%;">
                                                                <tr>
                                                                    <td colspan="2" style="height:30px;padding-top:5px;font-size:15px;border-bottom:1px solid #50AF43;" valign="top">
                                                                        <strong>Vital Information</strong>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height:25px;width:30%;">Name:
                                                                    <asp:RequiredFieldValidator ID="v_txtName" ControlToValidate="txtName" runat="server" Display="Static" ErrorMessage="*" Font-Bold="true" SetFocusOnError="true" ValidationGroup="vgVitals" /><asp:CustomValidator ID="cv_VendorName" ControlToValidate="txtName" runat="server" Display="Dynamic" ErrorMessage="Name already exists!" SetFocusOnError="true" ValidationGroup="vgVitals"/></td>
                                                                    <td style="width: 70%;">
                                                                        <asp:TextBox ID="txtName" runat="server" Text='<%#Bind("Name")%>' CssClass="SmallGreenTextBox" MaxLength="35" Width="170px" /></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height:25px;">Type:
                                                                    <asp:RequiredFieldValidator ID="v_txtType" ControlToValidate="ddlFirmType" InitialValue="0" runat="server" Display="Static" ErrorMessage="*" Font-Bold="true" SetFocusOnError="true" ValidationGroup="vgVitals" />
                                                                    </td>
                                                                    <td>
                                                                    <asp:DropDownList OnDataBound="ddlFirmType_DataBound" ID="ddlFirmType" CssClass="SmallGreenTextBox"  runat="server" Width="170" AppendDataBoundItems="true" DataSourceID="sdsFrimTypes" DataValueField="ID" DataTextField="Name"><asp:ListItem Value="0">Choose...</asp:ListItem></asp:DropDownList>
                                                                    <asp:SqlDataSource ID="sdsFrimTypes" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>" SelectCommand="Legal_GetAllFirmTypes" runat="server" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height:25px;padding-top:5px;" valign="top">Address:<asp:RequiredFieldValidator ID="v_txtAddress" ControlToValidate="txtAddress" runat="server" Display="Static" ErrorMessage="*" Font-Bold="true" SetFocusOnError="true" ValidationGroup="vgVitals" />
                                                                    <asp:CustomValidator ID="cv_txtAddress" runat="server" ControlToValidate="txtAddress" ClientValidationFunction="onAddressValidate" ErrorMessage="max. 150 chars" Display="Dynamic" SetFocusOnError="true" ValidationGroup="vgVitals"/>
                                                                        
                                                                    
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Text='<%#Bind("Address")%>' CssClass="SmallGreenTextBox" Width="170px" Height="45px" />
                                                                        <asp:RegularExpressionValidator SetFocusOnError="true" ID="REV_txtName" CssClass="RequiredField"
                                                                            runat="server" Display="Dynamic" ControlToValidate="txtAddress" ValidationExpression="^[^<>@#%$^!~&*(){}]*$"
                                                                            ErrorMessage="<br>Special Characters are not allowed" ValidationGroup="vgVitals"></asp:RegularExpressionValidator>
                                                                        
                                                                        </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height:25px;">City:<asp:RequiredFieldValidator ID="v_txtCity" ControlToValidate="txtCity" runat="server" Display="Static" ErrorMessage="*" Font-Bold="true" SetFocusOnError="true" ValidationGroup="vgVitals" /></td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtCity" runat="server" Text='<%#Bind("City")%>' CssClass="SmallGreenTextBox" Width="170px" MaxLength="30" /></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height:25px;">Zip:<asp:RequiredFieldValidator ID="v_txtZip" ControlToValidate="txtZip" runat="server" Display="Static" ErrorMessage="*" Font-Bold="true" SetFocusOnError="true" ValidationGroup="vgVitals" /></td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtZip" runat="server" Text='<%#Bind("Zip")%>' CssClass="SmallGreenTextBox" Width="170px" MaxLength="10" /></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height:25px;">Country:
                                                                    <asp:RequiredFieldValidator ID="v_ddlCountry" ControlToValidate="ddlCountry" InitialValue="-1" runat="server" Display="Static" ErrorMessage="*" Font-Bold="true" SetFocusOnError="true" ValidationGroup="vgVitals" />
                                                                    </td>
                                                                    <td><asp:UpdatePanel ID="UPCountries" runat="server" UpdateMode="Conditional">
                                                                        <ContentTemplate>
                                                                         <asp:DropDownList 
                                                                            ID="ddlCountry" 
                                                                            runat="server" 
                                                                            AppendDataBoundItems="true" 
                                                                            AutoPostBack="true"
                                                                            CssClass="SmallGreenTextBox" 
                                                                            DataSourceID="CountryDS" 
                                                                            DataTextField="Name" 
                                                                            DataValueField="ID"
                                                                            Style="width: 112px" 
                                                                            SelectedValue='<%# Bind("CountryID") %>' 
                                                                            Width="350px">
                                                                                <asp:ListItem Value="-1">Choose...</asp:ListItem>
                                                                         </asp:DropDownList>
                                                                         <asp:SqlDataSource 
                                                                            ID="CountryDS" 
                                                                            runat="server" 
                                                                            ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                            SelectCommand="Countries_GetAll_ForFran" 
                                                                            SelectCommandType="StoredProcedure"
                                                                            ></asp:SqlDataSource>
                                                                            </ContentTemplate>
                                                                            <Triggers>
                                                                            <asp:AsyncPostBackTrigger ControlID="ddlCountry" EventName="SelectedIndexChanged" />
                                                                            </Triggers>
                                                                            </asp:UpdatePanel>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height:25px;">State:</td>
                                                                    <td>
                                                                    <asp:UpdatePanel ID="UPStates" runat="server" UpdateMode="Conditional">
                                                                        <ContentTemplate>
                                                                        <asp:DropDownList 
                                                                          ID="ddlStates" 
                                                                          runat="server" 
                                                                          CssClass="SmallGreenTextBox" 
                                                                          DataSourceID="StatesDS"
                                                                          DataTextField="Name" 
                                                                          DataValueField="ID" 
                                                                          OnDataBound="ddlStates_DataBound"
                                                                          Style="width: 112px">
                                                                      </asp:DropDownList>
                                                                          <asp:SqlDataSource ID="StatesDS" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                            SelectCommand="States_GetAll_For_List_ByCountryID" SelectCommandType="StoredProcedure">
                                                                             <SelectParameters>
                                                                                <asp:ControlParameter ControlID="ddlCountry" Name="CountryID" PropertyName="SelectedValue" />
                                                                             </SelectParameters>
                                                                         </asp:SqlDataSource>
                                                                       </ContentTemplate>
                                                                       <Triggers>
                                                                           <asp:AsyncPostBackTrigger ControlID="ddlCountry" EventName="SelectedIndexChanged" />
                                                                      </Triggers>
                                                                    </asp:UpdatePanel>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height:25px;">Phone:
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="txtPhone" runat="server" Display="Static" ErrorMessage="*" Font-Bold="true" SetFocusOnError="true" ValidationGroup="vgVitals" /></td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtPhone" runat="server" Text='<%#Bind("Phone")%>' CssClass="SmallGreenTextBox" Width="170px" MaxLength="25" /></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height:25px;">Fax:</td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtFax" runat="server" Text='<%#Bind("Fax")%>' CssClass="SmallGreenTextBox" Width="170px" MaxLength="25" /></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height:25px;">Website:</td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtWebsite" runat="server" Text='<%#Bind("Website")%>' CssClass="SmallGreenTextBox" Width="170px" MaxLength="35" />
                                                                        <asp:RegularExpressionValidator ID="revWebSiteAddress" ControlToValidate="txtWebsite" ValidationGroup="vgVitals"  Display="dynamic" runat="server" ErrorMessage="Enter valid web address (e.g: http://qa.netsolace.com)" ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?"></asp:RegularExpressionValidator>
                                                                        </td>
                                                                </tr>
                                              
                                                              
                                                                <tr><td colspan="2"><img alt="" src="../images/spacer.gif" height="1" width="1" /></td></tr>
                                                                <tr>
                                                                    <td style="height:30px;" colspan="2" align="center">
                                                                        <asp:Button ID="UpdateButton" runat="server" Text="Update" CommandName="Update" CssClass="BtnGreen" Width="80px" ValidationGroup="vgVitals" />
                                                                        &nbsp;&nbsp;
                                                                        <asp:Button ID="CancelUpdateButton" runat="server" Text="Cancel" CommandName="Cancel" CssClass="BtnGreen" Width="80px" ValidationGroup="vgVitals" CausesValidation="false" /></td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </asp:FormView>
                                                    <asp:ObjectDataSource
                                                        ID="odsFirm"
                                                        runat="server"
                                                        TypeName="Firm"
                                                        SelectMethod="GetSingleFirm" 
                                                        UpdateMethod="UpdateFirm">
                                                        <SelectParameters>
                                                            <asp:ControlParameter Name="FirmID" ControlID="hdnFirmID" PropertyName="Value" /></SelectParameters>
                                                        <UpdateParameters>
                                                            <asp:ControlParameter ControlID="hdnFirmID" Name="ID" PropertyName="Value" />
                                                            <asp:ControlParameter ControlID="fvVendor$txtName" Name="Name" PropertyName="Text" Size="100" Type="String" />
                                                            <asp:ControlParameter ControlID="fvVendor$txtAddress" Name="Address" PropertyName="Text" Size="500" Type="String" />
                                                            <asp:ControlParameter ControlID="fvVendor$txtCity" Name="City" PropertyName="Text" Size="100" Type="String" />
                                                            <asp:ControlParameter ControlID="fvVendor$ddlStates" Name="State" PropertyName="SelectedValue" />
                                                            <asp:ControlParameter ControlID="fvVendor$ddlCountry" Name="Country" PropertyName="SelectedValue" />
                                                            <asp:ControlParameter ControlID="fvVendor$ddlFirmType" Name="TypeID" PropertyName="SelectedValue" />
                                                            <asp:ControlParameter ControlID="fvVendor$txtPhone" Name="Phone" PropertyName="Text" />
                                                            <asp:ControlParameter ControlID="fvVendor$txtFax" Name="Fax" PropertyName="Text" />
                                                            <asp:ControlParameter ControlID="fvVendor$txtZip" Name="Zip" PropertyName="Text" />
                                                            <asp:ControlParameter ControlID="fvVendor$txtWebSite" Name="Website" PropertyName="Text" />
                                                            <asp:Parameter Direction="Output"  Name="retVal" Type="int32" DefaultValue="0" />
                                                        </UpdateParameters>
                                                    </asp:ObjectDataSource>
                                                </td>
                                                <td><img alt="" src="../images/spacer.gif" height="1" width="1" /></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td width="3" style="background-color:#50AF43;width:3px;FILTER: progid:DXImageTransform.Microsoft.Alpha( style=2,opacity=100,finishOpacity=0); ">
                                    <img alt="" src="../images/spacer.gif" height="1" width="3" />
                                </td>
                                <td style="background-color:#EFF7FA;">
                                    <div style="overflow:auto;height:100%;padding:4px;">
                                        <table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%;">
                                            <tr>
                                                <td><img alt="" src="../images/spacer.gif" height="1" width="1" /></td>
                                                <td align="center" style="width:270px;">
                                                    <table border="0" cellpadding="0" style="height:100%;width:100%;font-size:11px;font-weight:bold;">
                                                        <tr id="trBtnNewContact">
                                                            <td style="height:30px;padding:4px;font-size:15px;border-bottom:1px solid #50AF43;">
                                                                <strong>Contacts</strong>
                                                            </td>
                                                            <td align="right" style="padding:4px;font-size:15px;border-bottom:1px solid #50AF43;">
                                                            &nbsp;
                                                                <asp:Button ID="btnNew" runat="server" Text="New Contact" OnClientClick="onNewContact(true);return false;" CssClass="BtnGreen" Width="100px"  /></td>
                                                        </tr>
                                                        <tr id="trNewContact" style="display:none;">
                                                            <td colspan="2" valign="top" style="height:20px;">
                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="font-size:11px;font-weight:bold;">
                                                                    <tr>
                                                                        <td style="height:20px;padding-left:9px;width:40%;" class="NonBold">Name:<asp:RequiredFieldValidator ID="v_txtFirstName" ControlToValidate="txtCName" runat="server" Display="Static" ErrorMessage="*" Font-Bold="true" SetFocusOnError="true" ValidationGroup="vgNewContact" /></td>
                                                                        <td><asp:TextBox ID="txtCName" runat="server" Text='' CssClass="SmallGreenTextBox" Width="150px" MaxLength="35" /></td>
                                                                    </tr>
                                                                     <tr>
                                                                        <td colspan="2" style="height:1px;text-align:center;"><img alt="" src="../images/pixel_green.JPG" height="1" width="95%" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="height:20px;padding-left:9px;width:40%;" class="NonBold">Title:<asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="txtCTitle" runat="server" Display="Static" ErrorMessage="*" Font-Bold="true" SetFocusOnError="true" ValidationGroup="vgNewContact" /></td>
                                                                        <td><asp:TextBox ID="txtCTitle" runat="server" Text='' CssClass="SmallGreenTextBox" Width="150px" MaxLength="35" /></td>
                                                                    </tr>
                                                                     <tr>
                                                                        <td colspan="2" style="height:1px;text-align:center;"><img alt="" src="../images/pixel_green.JPG" height="1" width="95%" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="height:20px;padding-left:9px;width:40%;" class="NonBold">Department:</td>
                                                                        <td><asp:TextBox ID="txtCDept" runat="server" Text='' CssClass="SmallGreenTextBox" Width="150px" MaxLength="30" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2" style="height:1px;text-align:center;"><img alt="" src="../images/pixel_green.JPG" height="1" width="95%" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="height:20px;padding-left:9px;width:40%;" class="NonBold">Phone:<asp:RequiredFieldValidator ID="v_txtPhone" ControlToValidate="txtCPhone" runat="server" Display="Static" ErrorMessage="*" Font-Bold="true" SetFocusOnError="true" ValidationGroup="vgNewContact" /></td>
                                                                        <td><asp:TextBox ID="txtCPhone" runat="server" Text='' CssClass="SmallGreenTextBox" Width="150px" MaxLength="25" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2" style="height:1px;text-align:center;"><img alt="" src="../images/pixel_green.JPG" height="1" width="95%" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="height:20px;padding-left:9px;width:40%;" class="NonBold">Fax:</td>
                                                                        <td><asp:TextBox ID="txtCFax" runat="server" Text='' CssClass="SmallGreenTextBox" Width="150px" MaxLength="25" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2" style="height:1px;text-align:center;"><img alt="" src="../images/pixel_green.JPG" height="1" width="95%" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="height:20px;padding-left:9px;width:40%;" class="NonBold">Email:
                                                                            <asp:RegularExpressionValidator ID="rv_txtEmail" runat="server" ControlToValidate="txtCEmail" Display="Dynamic" ErrorMessage="Invalid email format!" ValidationGroup="vgNewContact" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" /></td>
                                                                        <td><asp:TextBox ID="txtCEmail" runat="server" Text='' CssClass="SmallGreenTextBox" Width="150px" MaxLength="35" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2" style="height:1px;text-align:center;"><img alt="" src="../images/pixel_green.JPG" height="1" width="95%" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2" style="height:20px;padding:4px;" align="center">
                                                                            <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="BtnGreen" Width="70px" ValidationGroup="vgNewContact" />&nbsp;
                                                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClientClick="onNewContact(false); return false;" CssClass="BtnGreen" Width="70px" /></td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="height:30px;" colspan="2">
                                                                <asp:DataList 
                                                                    ID="dlContacts"
                                                                    runat="server" 
                                                                    DataSourceID="odsContacts"
                                                                    RepeatLayout="Flow"
                                                                    DataKeyField="ID"><ItemTemplate><table border="0" cellpadding="0" style="height:20px;width:100%;">
                                                                            <tr>
                                                                                <td colspan="2" style="height:20px;padding-left:4px;">
                                                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="font-size:11px;font-weight:bold;">
                                                                                        <tr>
                                                                                            <td>&nbsp;<img 
                                                                                                        id='imgContactRow_<%# Container.DataItem("ID") %>'
                                                                                                        onclick='javascript:onSectionShowHide(this,"trContactRow_<%# Container.DataItem("ID") %>",1,false)'
                                                                                                        alt="" 
                                                                                                        src='../images/<%#IIf(CBool(Container.DataItem("IsPrimary")) = False, "expand.gif", "colapse.gif")%>' 
                                                                                                        style="cursor:pointer;"
                                                                                                        height="9" width="9" align="absMiddle" /> &nbsp;&nbsp;
                                                                                                        <span class="BlackTextBigger"><a onclick='javascript:imgContactRow_<%# Container.DataItem("ID") %>.click(); return false;' href="#"><%#Functions.StringTruncate(Container.DataItem("Name"), 15)%></a></span>
                                                                                                        <em class="NonBold"><%#IIf(CBool(Container.DataItem("IsPrimary")) = True, "(Primary)", "")%></em></td>
                                                                                            <td style="width:30%;color:#4D728F;text-align:right;padding-right:4px;">
                                                                                                 <asp:LinkButton ID="lnkDelete" runat="server"  Text='<%#IIf(CBool(Container.DataItem("IsPrimary")) = False, "Delete", "")%>' OnClientClick="javascript:return confirm('Are you sure you want to delete this contact?');" CommandArgument='<%# Container.DataItem("ID") %>' CommandName="Delete" />
                                                                                                &nbsp;&nbsp; 
                                                                                                <asp:Button ID="lnkEdit" runat="server"  CssClass="BtnGreen" style="text-align:center; vertical-align:bottom; padding-top:2px;" Height="20" Width="50"  Text="Edit" CommandName="Edit" /></td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="2" style="height:2px;text-align:center;"><img alt="" src="../images/pixel_green.JPG" height="2" width="97%" /></td>
                                                                            </tr>
                                                                            <tr id='trContactRow_<%# Container.DataItem("ID") %>' style='display:<%#IIf(CBool(Container.DataItem("IsPrimary")) = False, "none", "block")%>;'>
                                                                                <td colspan="2" valign="top" style="height:20px;">
                                                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="font-size:11px;font-weight:bold;">
                                                                                         <tr>
                                                                                             <td style="height:20px;padding-left:9px;width:40%;" class="NonBold">Title:</td>
                                                                                             <td style="height: 20px; padding-left:5px"><%# Container.DataItem("Title") %></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td colspan="2" style="height:1px;text-align:center;"><img alt="" src="../images/pixel_green.JPG" height="1" width="95%" /></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td style="height:20px;padding-left:9px;width:40%;"  class="NonBold">Department</td>
                                                                                            <td style="padding-left:5px;"><%#Container.DataItem("Department")%></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td colspan="2" style="height:1px;text-align:center;"><img alt="" src="../images/pixel_green.JPG" height="1" width="95%" /></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td style="height:20px;padding-left:9px;width:40%;" class="NonBold">Phone:</td>
                                                                                            <td style="padding-left:5px;"><%#Container.DataItem("Phone")%></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td colspan="2" style="height:1px;text-align:center;"><img alt="" src="../images/pixel_green.JPG" height="1" width="95%" /></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td style="height:20px;padding-left:9px;width:40%;" class="NonBold">Fax:</td>
                                                                                            <td style="height: 20px; padding-left:5px;"><%# Container.DataItem("Fax") %></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td colspan="2" style="height:1px;text-align:center;"><img alt="" src="../images/pixel_green.JPG" height="1" width="95%" /></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td style="height:20px;padding-left:9px;width:40%;" class="NonBold">Email:</td>
                                                                                            <td style="padding-left:5px;"><a title='<%#Container.DataItem("Email").ToString.ToLower%>'  href='mailto:<%# Container.DataItem("Email") %>'><%#Functions.StringTruncate(Container.DataItem("Email").ToString.ToLower, 19)%></a></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td colspan="2" style="height:1px;text-align:center;"><img alt="" src="../images/pixel_green.JPG" height="1" width="95%" /></td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <table border="0" cellpadding="0" style="height:30px;width:100%;">
                                                                            <tr>
                                                                                <td colspan="2" style="height:20px;padding-left:4px;">
                                                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="font-size:11px;font-weight:bold;">
                                                                                        <tr>
                                                                                            <td>
                                                                                                &nbsp;<img id='imgContactRow_<%# Container.DataItem("ID") %>'
                                                                                                onclick='javascript:onSectionShowHide(this,"trContactRow_<%# Container.DataItem("ID") %>",1,false)'
                                                                                                alt="" 
                                                                                                src='../images/colapse.gif' 
                                                                                                style="cursor:pointer;"
                                                                                                height="9" width="9" align="absMiddle" /> &nbsp;&nbsp;
                                                                                                <span class="BlackTextBigger"><a onclick='javascript:imgContactRow_<%# Container.DataItem("ID") %>.click(); return false;' href="#"><%#Functions.StringTruncate(Container.DataItem("Name").ToString(), 15)%></a></span>
                                                                                                <em class="NonBold"><%#IIf(CBool(Container.DataItem("IsPrimary")) = True, "(Primary)", "")%></em>
                                                                                            </td>
                                                                                            <td style="width:35%;color:#4D728F;text-align:right;padding-right:4px;white-space:nowrap;">
                                                                                                <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" ValidationGroup="vgEditContact" />
                                                                                                &nbsp;&nbsp; 
                                                                                                <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" CausesValidation="false" /></td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="2" style="height:2px;text-align:center;"><img alt="" src="../images/pixel_green.JPG" height="2" width="97%" /></td>
                                                                            </tr>
                                                                            <tr id='trContactRow_<%# Container.DataItem("ID") %>'>
                                                                                <td colspan="2" valign="top" style="height:20px;">
                                                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="font-size:11px;font-weight:bold;">
                                                                                        <tr>
                                                                                            <td style="height:20px;padding-left:9px;width:40%;" class="NonBold">Name:<asp:RequiredFieldValidator ID="v_txtFirstName" ControlToValidate="txtCName" runat="server" Display="Static" ErrorMessage="*" Font-Bold="true" SetFocusOnError="true" ValidationGroup="vgEditContact" /></td>
                                                                                            <td><asp:TextBox ID="txtCName" runat="server" Text='<%#Bind("Name")%>' CssClass="SmallGreenTextBox" Width="150px" MaxLength="35" /></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td colspan="2" style="height:1px;text-align:center;"><img alt="" src="../images/pixel_green.JPG" height="1" width="95%" /></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td style="height:20px;padding-left:9px;width:40%;" class="NonBold">Title:<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtCTitle" runat="server" Display="Static" ErrorMessage="*" Font-Bold="true" SetFocusOnError="true" ValidationGroup="vgEditContact" /></td>
                                                                                            <td><asp:TextBox ID="txtCTitle" runat="server" Text='<%#Bind("Title")%>' CssClass="SmallGreenTextBox" Width="150px" MaxLength="35" /></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td colspan="2" style="height:1px;text-align:center;"><img alt="" src="../images/pixel_green.JPG" height="1" width="95%" /></td>
                                                                                        </tr>
                                                                                         <tr>
                                                                                            <td style="height:20px;padding-left:9px;width:40%;" class="NonBold">Department:</td>
                                                                                            <td><asp:TextBox ID="txtCDept" runat="server" Text='<%#Bind("Department")%>' CssClass="SmallGreenTextBox" Width="150px" MaxLength="30" /></tr>
                                                                                        <tr>
                                                                                            <td colspan="2" style="height:1px;text-align:center;"><img alt="" src="../images/pixel_green.JPG" height="1" width="95%" /></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td style="height:20px;padding-left:9px;width:40%;" class="NonBold">Phone:<asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtCPhone" runat="server" Display="Static" ErrorMessage="*" Font-Bold="true" SetFocusOnError="true" ValidationGroup="vgEditContact" /></td>
                                                                                            <td><asp:TextBox ID="txtCPhone" runat="server" Text='<%#Bind("Phone")%>' CssClass="SmallGreenTextBox" Width="150px" MaxLength="25" /></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td colspan="2" style="height:1px;text-align:center;"><img alt="" src="../images/pixel_green.JPG" height="1" width="95%" /></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td style="height:20px;padding-left:9px;width:40%;" class="NonBold">Fax:</td>
                                                                                            <td><asp:TextBox ID="txtCFax" runat="server" Text='<%#Bind("Fax")%>' CssClass="SmallGreenTextBox" Width="150px" MaxLength="25" /></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td colspan="2" style="height:1px;text-align:center;"><img alt="" src="../images/pixel_green.JPG" height="1" width="95%" /></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td style="height:20px;padding-left:9px;width:40%;" class="NonBold">Email:
                                                                                            <asp:RegularExpressionValidator ID="rv_txtEmail" runat="server" ControlToValidate="txtCEmail" Display="Dynamic" ErrorMessage="Invalid email format!" ValidationGroup="vgEditContact" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" /></td>
                                                                                            <td><asp:TextBox ID="txtCEmail" runat="server" Text='<%#Bind("Email")%>' CssClass="SmallGreenTextBox" Width="150px" MaxLength="35" /></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td colspan="2" style="height:1px;text-align:center;"><img alt="" src="../images/pixel_green.JPG" height="1" width="95%" /></td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </EditItemTemplate>
                                                                </asp:DataList>
                                                            </td>
                                                        </tr>
                                                        <tr><td colspan="2">&nbsp;</td></tr>
                                                    </table>
                                                    <asp:ObjectDataSource
                                                        ID="odsContacts"
                                                        runat="server" 
                                                        TypeName="Firm" 
                                                        SelectMethod="GetContactsByFirmID"
                                                        UpdateMethod="UpdateFirmContact"
                                                        DeleteMethod="DeleteContact" 
                                                        InsertMethod="AddFirmContact" >
                                                        <SelectParameters>
                                                            <asp:ControlParameter Name="FirmID" ControlID="hdnFirmID" PropertyName="Value" /></SelectParameters>
                                                        <UpdateParameters>
                                                            <asp:Parameter Name="ID" Type="Int32" />
                                                            <asp:Parameter Name="Name" Type="String" Size="50" />
                                                            <asp:Parameter Name="Department" Type="String" Size="50" />
                                                            <asp:Parameter Name="Title" Type="String" Size="50" />
                                                            <asp:Parameter Name="Phone" Type="String" Size="50" />
                                                            <asp:Parameter Name="Fax" Type="String" Size="100" />
                                                            <asp:Parameter Name="Email" Type="String" Size="50" />
                                                        </UpdateParameters>
                                                        <InsertParameters>
                                                            <asp:Parameter Name="Name" Type="String" Size="50" />
                                                            <asp:Parameter Name="Department" Type="String" Size="50" />
                                                            <asp:Parameter Name="Title" Type="String" Size="50" />
                                                            <asp:Parameter Name="Phone" Type="String" Size="50" />
                                                            <asp:Parameter Name="Fax" Type="String" Size="100" />
                                                            <asp:Parameter Name="Email" Type="String" Size="50" />
                                                            <asp:Parameter Name="FirmID" Type="Int32" Size="50" />
                                                        </InsertParameters>
                                                        <DeleteParameters><asp:Parameter Name="ContactID" Type="Int32" /></DeleteParameters>
                                                    </asp:ObjectDataSource>
                                                </td>
                                                <td><img alt="" src="../images/spacer.gif" height="1" width="1" /></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            <%--    <td style="background-color:#50AF43;width:3px;FILTER: progid:DXImageTransform.Microsoft.Alpha( style=2,opacity=100,finishOpacity=0); ">
                                    <img alt="" src="../images/spacer.gif" height="1" width="3" />
                                </td>--%>
                    
                    
                            </tr>
                            <tr class="FooterRowGreen">
                                <td colspan="7" align="center" style="height:35px;">
                                    <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="BtnGreen" OnClientClick="parent.frameMain.location='FirmManagement.aspx';return false;" Width="80px" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

<script type="text/javascript" language="javascript">

function clearIds(){
    $get('hdnZipIds').value = '';
}

function addZipId(chk){

    var IdList = $get('hdnZipIds').value;
    if (chk.checked){ 
        if (IdList == ''){
            IdList += ','+chk.value+','
        }else{
            IdList += chk.value+','
        }
    }else{
        IdList = IdList.replace(','+chk.value+',',',');
        if (IdList==',') IdList = '';
    }
    $get('hdnZipIds').value = IdList;

}

function DeleteSelected_Click(){
    
    if ($get('hdnZipIds').value==''){
        alert('Please! select service area(s)!');
        return;
    }
    if (confirm('Are you sure you want to delete selected Service Areas?')){
        _DeleteServiceArea($get('hdnZipIds').value);
    }
    
}

function reloadServiceZips(){
    
    $get('hdnFilterStateID').value=$get('ddlStates').value;
    $get('btnRefresh_UPSAreas').click();
    $get('txtZip').value='';
    
}

function onAddressValidate(oSrc,oArgs){
    if ($get(oSrc.controltovalidate).value.length > 150){
        oArgs.IsValid = false;
    }
    else{
        oArgs.IsValid = true;
    }
    
}

var selValuesCount = 0;
//function GetAllSelectedValues(cmb){

//    selValuesCount = 0;
//    var Ids = '';
//    for (var i=cmb.options.length-1; i>=0; i--){
//        if (cmb.options[i].selected == true){
//            selValuesCount += 1;
//            if (Ids == '')
//                Ids += cmb.options[i].value
//            else
//                Ids += ',' + cmb.options[i].value;
//        }
//    }
//    return Ids;
//    
//}

//    var msg;
//    if (storeZips){
//        msg = selValuesCount+' zip(s) selected. \nPress OK to proceed...';
//    }else{
//        msg = 'Be sure you are adding proper zip code.\nPress OK to add entered zip code(s) as service areas...';
//    }
//    if (confirm(msg)){
//        _AddServiceArea(splrId,franId,countryID);
//    }
//    
//}

function onSectionShowHide(img,tr,count,updateViewOnly) {

    if (parseInt(count)<1) {
    }else{
        if (updateViewOnly){
            $get(tr).style.display='block';
            img.src=img.src.replace('expand.gif','colapse.gif');
        }
    }
    if (updateViewOnly) return;
    if (img.src.indexOf('colapse.gif')>=0){
        // Contact info is open
        $get(tr).style.display='none';
        img.src=img.src.replace('colapse.gif','expand.gif');
    }else{
        $get(tr).style.display='block';
        img.src=img.src.replace('expand.gif','colapse.gif');
    }
    
}

function onNewContact(show){

    if (show){
        //$get('trBtnNewContact').style.display='none';
        $get('btnNew').style.display='none';
        $get('trNewContact').style.display='';
    }else{
        $get('btnNew').style.display='';
        $get('trNewContact').style.display='none';
    }

}

</script>

     </div>
 
    </form>
</body>
</html>
