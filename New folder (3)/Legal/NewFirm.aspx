<%@ Page Language="VB" AutoEventWireup="false" CodeFile="NewFirm.aspx.vb" Inherits="admin_Legal_FirmMgt" Theme="Default" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Firm Management</title>
   <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>

    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>

    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>

    <script type="text/javascript" language="JavaScript" src="../scripts/functions.js"></script>

    <link href="../style/style.css" type="text/css" rel="stylesheet" />
    <link href="Style/Style.css" type="text/css" rel="stylesheet" />
    <link href="../style/Calendar/style.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="javascript">
    function chkStatus()
    {
    var status=document.getElementById("ddlStatus").value;
    if(status==3)
    {
        TRSNo.style.display="inline";
        TRRegNo.style.display="inline";
    }
    else
    {
        TRSNo.style.display="none";
        TRRegNo.style.display="none";
    }
    }
    function chkActivityState()
    {
    var status=document.getElementById("ddlActivityState").value;
     if(status==4)
     {
        TRWaitingFor.style.display="inline";
     }
     else
     {
        TRWaitingFor.style.display="none";
     }
    }
    function chkNotes(sender,args)
    {
        var notes=document.getElementById("txtAddress").value;
        if(notes.length<150)
        {
            args.IsValid=true;
        }
        else
        {
        args.IsValid=false;
        }
    }
    
    function onSaveClick_IP(FirmID,ContactID)
    {
    parent.document.getElementById("FirmTR").style.display='none';
    parent.document.getElementById("LegalTR").style.display='inline';
    parent.document.getElementById("btnBinder").click();
    parent.document.getElementById("hdnFirmID").value=FirmID;
    
    }
    function CancelFirm()
    {
    var check=document.getElementById("SubPageID").value;
    if(check==0)
        {
        parent.frameMain.location='FirmManagement.aspx';
        }
    else 
        {
        parent.document.getElementById("FirmTR").style.display='none';
        parent.document.getElementById("LegalTR").style.display='inline';
        }
    }
    function onLoad()
        {

        }
    </script>

</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" scroll="no" class="DivScroll" onload="onLoad();">
    <form id="form1" runat="server" defaultfocus="txtName" >
    <div>
       <asp:UpdateProgress ID="UpdateProgress10" runat="server" >
                                        <ProgressTemplate>
                                            <div class="ProgressIndicatorDIV">
                                                <br />
                                                <asp:Image ID="Image2" runat="server" ImageAlign="AbsMiddle" ImageUrl="images/indicator.gif" /><span
                                                    style="font-size: 14px; color: #4b92c1"><b>&nbsp; Loading ...</b></span>
                                                <br />
                                                <br />
                                            </div>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
       <asp:ScriptManager ID="ScriptManager" runat="server"></asp:ScriptManager>
        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%;"
            class="MainTable">
            <tr class="HeaderRowGreen" style="height: 31px;">
                <td style="font-weight: bold; width: 50%; font-family: Helvetica; height: 31px;">
                    <asp:Label ID="lblHeading" runat="server" Font-Names="Helvetica" font-weight="bold"
                        Text="New Firm/Vendor"></asp:Label></td>
                <td style="text-align: right">
                    &nbsp;</td>
            </tr>
            <tr>
                <td align="center" colspan="2" style="padding-right: 2px; padding-left: 2px; background-color: #daf5d6">
                    <div style="overflow: auto; height: 100%;">
                        <table border="0" cellpadding="0" cellspacing="0" style="width: 472px; height: 100%;
                            text-align: left;">
                            <tr style="height: 25px;">
                                <td colspan="4" style="border-bottom: solid thin #D0E1E9;">
                                    <strong>Firm/Vendor Information</strong>
                                    <asp:HiddenField runat="server" ID="SubPageID" Value="0" />
                                    <asp:UpdatePanel ID="pnlUpdate" runat="server" RenderMode="Inline">
                                        <ContentTemplate>
                                            &nbsp;&nbsp;<asp:Label ID="lblMsg" runat="server" CssClass="RequiredField"></asp:Label>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="BtnSave" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                    
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="padding-left: 5px; height: 10px" colspan="4">
                                &nbsp;
                                </td>
                            </tr>
                            <tr style="height: 20px;">
                                <td align="left" style="width: 20%;">
                                    Name:<span style="font-size: 8pt; color: #ff0000">*</span></td>
                                <td colspan="3">
                                    <asp:TextBox ID="txtName" runat="server" CssClass="MediumGreenTextBox" MaxLength="35"
                                        Width="350px"></asp:TextBox><br />
                                </td>
                            </tr>
                            <tr style="height: 1px;">
                                <td>
                                </td>
                                <td colspan="3">
                                    <asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvName" runat="server" ControlToValidate="txtName"
                                        CssClass="RequiredField" Display="Dynamic" ErrorMessage="Name is required">
                                    </asp:RequiredFieldValidator></td>
                            </tr>
                           
                            <tr style="height: 20px;">
                                <td>
                                    Type:<span style="font-size: 8pt; color: #ff0000">*</span>
                                </td>
                                <td colspan="3">
                                    <asp:DropDownList ID="ddlFirmType" CssClass="mediumfontinput" runat="server" Width="350" AppendDataBoundItems="true" DataSourceID="sdsFrimTypes" DataValueField="ID" DataTextField="Name"><asp:ListItem Value="0">Choose...</asp:ListItem></asp:DropDownList>
                                    <asp:SqlDataSource ID="sdsFrimTypes" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>" SelectCommand="Legal_GetAllFirmTypes" runat="server" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                </td>
                            </tr>
                            <tr style="height: 1px;">
                                <td>
                                </td>
                                <td colspan="3">
                                    <asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvType" Display="Dynamic" runat="server" ControlToValidate="ddlFirmType"
                                        CssClass="RequiredField" ErrorMessage="Choose firm type" InitialValue="0"></asp:RequiredFieldValidator></td>
                            </tr>
                            <tr height="45">
                                <td align="left" valign="top">
                                    Address:<span style="font-size: 8pt; color: #ff0000">*</span></td>
                                <td style="font-size: 8pt; color: #000000;" colspan="3">
                                    <asp:TextBox ID="txtAddress" runat="server" CssClass="MediumGreenTextBox" Height="40px"
                                        MaxLength="150" Rows="3" TextMode="MultiLine" Width="350px"></asp:TextBox><br />
                                </td>
                            </tr>
                            <tr style="height: 1px;">
                                <td>
                                </td>
                                <td colspan="3">
                                    <asp:CustomValidator SetFocusOnError="true" ID="cvAddress" runat="server" ControlToValidate="txtAddress"
                                        CssClass="RequiredField" Display="Dynamic" ErrorMessage="Address should not exceed 150 characters."
                                        ClientValidationFunction="chkNotes">
                                    </asp:CustomValidator><asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvAddress" runat="server" ControlToValidate="txtAddress"
                                        CssClass="RequiredField" Display="Dynamic" ErrorMessage="Address is required.">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator SetFocusOnError="true"  ID="REV_txtName" CssClass="RequiredField"
                                     runat="server"  Display="Dynamic"
                                      ControlToValidate="txtAddress"  ValidationExpression="^[^<>@#%$^!~&*(){}]*$"
                                        ErrorMessage="Special Characters are not allowed"></asp:RegularExpressionValidator>
                                    
                                    </td>
                            </tr>
                            <tr style="height: 20px;">
                                <td style="width: 15%; height: 20px">
                                    City:<span style="font-size: 8pt; color: #ff0000">*</span>
                                </td>
                                <td style="width: 35%">
                                    <asp:TextBox ID="txtCity" runat="server" CssClass="MediumGreenTextBox" MaxLength="50"
                                        Width="112px"></asp:TextBox></td>
                                        <td>
                                    Country:<span style="font-size: 8pt; color: #ff0000">*</span>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlCountry" runat="server" AppendDataBoundItems="true" AutoPostBack="true"
                                        CssClass="MediumFontInput" DataSourceID="CountryDS" DataTextField="Name" DataValueField="ID"
                                        Style="width: 112px" Width="350px">
                                        <asp:ListItem Value="-1">Choose...</asp:ListItem>
                                    </asp:DropDownList><asp:SqlDataSource ID="CountryDS" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                        SelectCommand="Countries_GetAll_ForFran" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                </td>
                                
                            </tr>
                            <tr style="height: 1px;">
                                <td>
                                </td>
                                <td>
                                    <asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvCity" runat="server" ControlToValidate="txtCity"
                                        CssClass="RequiredField" Display="Dynamic" ErrorMessage="City is required.">
                                    </asp:RequiredFieldValidator></td>
                                <td>
                                </td>
                                <td>
                                    <asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvState" runat="server" ControlToValidate="ddlStates"
                                        CssClass="RequiredField" Display="Dynamic" ErrorMessage="State is required."
                                        InitialValue="-1">
                                    </asp:RequiredFieldValidator></td>
                            </tr>
                            <tr style="height: 20px;">
                                <td>
                                    Zip Code:<span style="font-size: 8pt; color: #ff0000">*</span>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtZipCode" runat="server" CssClass="MediumGreenTextBox" MaxLength="10"
                                        Width="112px"></asp:TextBox></td>
                                <td style="width: 19%">
                                    State:<span style="font-size: 8pt; color: #ff0000">*</span>
                                </td>
                                <td style="width: 31%">
                                <asp:UpdatePanel ID="UPStates" runat="server" UpdateMode="Conditional">
                                                <ContentTemplate>
                                                    <asp:DropDownList ID="ddlStates" runat="server" CssClass="MediumFontInput" DataSourceID="StatesDS"
                                                        DataTextField="Name" DataValueField="ID" Style="width: 112px"></asp:DropDownList><asp:SqlDataSource ID="StatesDS" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                        SelectCommand="States_GetAll_For_List_ByCountryID" SelectCommandType="StoredProcedure">
                                                        <SelectParameters>
                                                            <asp:ControlParameter ControlID="ddlCountry" Name="CountryID" PropertyName="SelectedValue" /></SelectParameters>
                                                    </asp:SqlDataSource>
                                                  </ContentTemplate>
                                                <Triggers><asp:AsyncPostBackTrigger ControlID="ddlCountry" EventName="SelectedIndexChanged" /></Triggers>
                                            </asp:UpdatePanel>

                                </td>
                            </tr>
                            <tr style="height: 1px;">
                                <td style="width: 20%">
                                </td>
                                <td style="width: 30%">
                                    <asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvZipCode" runat="server" ControlToValidate="txtZipCode"
                                        CssClass="RequiredField" Display="Dynamic" ErrorMessage="Zip code is required.">
                                    </asp:RequiredFieldValidator></td>
                                <td style="width: 20%">
                                </td>
                                <td style="width: 30%">
                                    <asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvCountry" runat="server" ControlToValidate="ddlCountry"
                                        CssClass="RequiredField" Display="Dynamic" ErrorMessage="Country is required."
                                        InitialValue="-1">
                                    </asp:RequiredFieldValidator></td>
                            </tr>
                            <tr style="height: 20px;">
                                <td align="left" style="height: 20px; width: 15%">
                                    Phone:<span style="font-size: 9pt; color: #ff0000">*</span></td>
                                <td style="font-size: 9pt; height: 20px; width: 35%">
                                    <asp:TextBox ID="txtPhone" runat="server" CssClass="MediumGreenTextBox" MaxLength="20"
                                        Width="112px"></asp:TextBox></td>
                                <td style="width: 20%">
                                    Fax:
                                </td>
                                <td style="width: 30%">
                                    <asp:TextBox ID="txtFax" runat="server" CssClass="MediumGreenTextBox" MaxLength="20"
                                        Width="112px"></asp:TextBox></td>
                            </tr>
                            <tr style="height: 1px;">
                                <td style="width: 20%">
                                </td>
                                <td style="width: 30%">
                                    <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPhone"
                                        CssClass="RequiredField" Display="Dynamic" ErrorMessage="Phone No. is required.">
                                    </asp:RequiredFieldValidator></td>
                                <td style="width: 20%">
                                </td>
                                <td style="width: 30%">
                                </td>
                            </tr>
                            <tr style="height: 20px;">
                                <td align="left">
                                    Web Site:</td>
                                <td style="font-size: 9pt; color: #000000; height: 20px" colspan="3">
                                    <asp:TextBox ID="txtWebsite" runat="server" CssClass="MediumGreenTextBox" MaxLength="40"
                                        Width="350px"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="revWebSiteAddress" ControlToValidate="txtWebsite"  Display="dynamic" runat="server" ErrorMessage="Enter valid web address (e.g: http://qa.netsolace.com)" ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?"></asp:RegularExpressionValidator>
                                        </td>
                            </tr>
                            <tr style="height: 25px;">
                                <td colspan="4" style="border-bottom: solid thin #D0E1E9; padding-bottom: 5px;">
                                    <br />
                                    <strong>Primary Contact Information</strong>
                                </td>
                            </tr>
                           
                            <tr style="height: 20px;">
                                <td width="25%" style="padding-top: 10px">
                                    Name:<span style="font-size: 9pt; color: #ff0000">*</span>
                                </td>
                                <td colspan="3" style="padding-top: 10px">
                                    <asp:TextBox ID="txtContactName" runat="Server" Width="350" CssClass="mediumGreenTextBox"
                                        MaxLength="25"></asp:TextBox></td>
                            </tr>
                            <tr style="height: 1px">
                                <td>
                                </td>
                                <td colspan="3">
                                    <asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvContactName" runat="server" ControlToValidate="txtContactName"
                                        CssClass="RequiredField" Display="Dynamic" ErrorMessage="Contact name is required">
                                    </asp:RequiredFieldValidator></td>
                            </tr>
                            <tr style="height: 20px;">
                                <td>
                                    Title:<span style="font-size: 9pt; color: #ff0000">*</span>
                                </td>
                                <td colspan="3">
                                    <asp:TextBox ID="txtContactTitle" runat="Server" Width="350" CssClass="mediumGreenTextBox"
                                        MaxLength="25"></asp:TextBox></td>
                            </tr>
                            <tr style="height: 1px;">
                                <td>
                                </td>
                                <td colspan="3">
                                    <asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvTitle" runat="server" ControlToValidate="txtContactTitle"
                                        CssClass="RequiredField" Display="Dynamic" ErrorMessage="Title is required">
                                    </asp:RequiredFieldValidator></td>
                            </tr>
                            <tr style="height: 20px;">
                                <td style="width: 15%; height: 20px">
                                    Department:
                                </td>
                                <td style="width: 35%">
                                    <asp:TextBox ID="txtContactDepartment" runat="server" CssClass="MediumGreenTextBox"
                                        MaxLength="50" Width="112px"></asp:TextBox></td>
                                <td style="width: 19%">
                                    Phone:<span style="font-size: 8pt; color: #ff0000">*</span>
                                </td>
                                <td style="width: 31%">
                                    <asp:TextBox ID="txtContactPhone" runat="server" CssClass="MediumGreenTextBox" MaxLength="50"
                                        Width="112px"></asp:TextBox></td>
                            </tr>
                            <tr style="height: 1px;">
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvContactPhone" runat="server" ControlToValidate="txtContactPhone"
                                        CssClass="RequiredField" Display="Dynamic" ErrorMessage="Phone No. is required">
                                    </asp:RequiredFieldValidator></td>
                            </tr>
                            <tr style="height: 20px;">
                                <td style="width: 15%; height: 20px">
                                    Fax:
                                </td>
                                <td style="width: 35%">
                                    <asp:TextBox ID="txtContactFax" runat="server" CssClass="MediumGreenTextBox" MaxLength="50"
                                        Width="112px"></asp:TextBox></td>
                                <td style="width: 19%">
                                    Email:
                                </td>
                                <td style="width: 31%">
                                    <asp:TextBox ID="txtContactEmail" runat="server" CssClass="MediumGreenTextBox" MaxLength="50"
                                        Width="112px"></asp:TextBox></td>
                            </tr>
                             <tr style="height: 1px;">
                                <td style="width: 15%; ">
                                  
                                </td>
                                <td style="width: 35%">
                                   </td>
                                <td style="width: 19%">
                                  
                                </td>
                                <td style="width: 31%">
                                   <asp:RegularExpressionValidator SetFocusOnError="true" ID="rfvEmail" runat="server" CssClass="RequiredField" Display="Dynamic" ControlToValidate="txtContactEmail" ErrorMessage="Enter valid email address" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ></asp:RegularExpressionValidator></td>
                            </tr>
                            
                            <tr>
                                <td align="left" style="padding-left: 5px; width: 20%; height: 20px">
                                </td>
                                <td colspan="3">
                                    &nbsp;
                           
                                </td>
                            </tr>
                            <%--    <tr>
                            <td align="left" style="padding-left: 5px; width: 20%">
                            &nbsp;
                            </td>
                            <td colspan="3" >
                            &nbsp;</td>
                        </tr>--%>
                            <tr>
                                <td align="center" colspan="4" style="padding-left: 10px" valign="top">
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2" style="padding-right: 2px; height: 2px; padding-left: 2px;
                    background-color: #daf5d6" valign="top">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td align="center" class="RequiredFieldMessage" colspan="2" style="font-size: 12px;
                    padding-bottom: 10px; height: 5px; background-color: #daf5d6" valign="bottom">
                    Fields marked with an asterisk <span class="RequiredField">*</span> are required.
                </td>
            </tr>
            <tr class="FooterRowGreen">
                <td align="center" colspan="2" style="padding-right: 31px; height: 31px">
                    <asp:Button ID="BtnSave" runat="server" CssClass="btnGreen" Style="width: 80px" Text="Save"
                        Width="60px" />&nbsp;
                    <input id="BtnCancel" type="button" value="Cancel" onclick="CancelFirm();"
                        class="btnGreen" style="width: 80px" />
                </td>
            </tr>
        </table></div>
    </form>
</body>
</html>
