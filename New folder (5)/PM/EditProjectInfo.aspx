<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EditProjectInfo.aspx.vb" Inherits="PM_EditProjectInfo"
    ValidateRequest="false" EnableEventValidation="false" ViewStateEncryptionMode="never" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <link href="../App_Themes/Default/Calendar/style.css" rel="stylesheet" type="text/css" />
    <link href="../style/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
    <%-- <script type="text/javascript" language="JavaScript" src="../scripts/jquery-1.3.2.min.js"></script>    --%>

    <script src="../scripts/jquery-1.8.3.js"></script>
    <%-- <script type="text/javascript" src="../scripts/autocomplete-0.3.0.js"></script>--%>
    <script src="../scripts/jquery-ui-1.9.2.custom.min.js"></script>
    <link href="PMStyle.css" rel="stylesheet" type="text/css" />
    <script src="../Standard/ckeditor.js"></script>
    <style>
        #tblUsersTimeSpentOnTicket tbody tr td {
            border-bottom: 1px solid gray;
        }

        .WhtLine img {
            height: 20px;
            width: 20px;
        }

        .txt_black {
            font-size: 14px !important;
        }

        #DivTicketDetail .FormInnerTable td {
            padding-top: 2px;
            padding-bottom: 2px;
        }

        #ResourcesGrid {
            width: 82% !important;
        }

            #ResourcesGrid tr td {
                vertical-align: middle;
            }

                #ResourcesGrid tr td:first-child {
                    vertical-align: bottom;
                }

                #ResourcesGrid tr td div {
                    margin-top: 30px;
                }

                #ResourcesGrid tr td span {
                    font-size: 12px;
                }

            #ResourcesGrid tr {
                border: none;
            }


        #EstimatesGrid tr td {
            vertical-align: top;
            /*padding: 5px;*/
            /*padding-left :5px;*/
            /*width: 4px;*/
        }

            /*#EstimatesGrid tr td:nth-child(2) {
            line-height: 3em;
        }*/
            /*#EstimatesGrid tr td div #EstimatesGrid$ctl08$txtEstimateSearchBox{
                margin-top:30px !important;
           }*/
            /*#EstimatesGrid tr td div input  {
                  margin-top:30px;
            }*/
            #EstimatesGrid tr td span {
                font-size: 12px;
            }
        /*#EstimatesGrid tr td input {
            display: block;
        }*/
        #EstimatesGrid tr {
            border: none;
        }

            #EstimatesGrid tr td:first-child {
                width: 40%;
            }

            #EstimatesGrid tr td:nth-child(2) {
                width: 40%;
            }

            #EstimatesGrid tr td:nth-child(3) {
                width: 20%;
            }

        .align {
            font-size: 12px;
        }

        #cke_2_resizer {
            display: none;
        }

        #cke_2_bottom {
            display: none;
        }

        #cke_1_bottom {
            display: none;
        }

        #dlData tr td {
            vertical-align: bottom;
        }

        .ui-widget INPUT {
            font-size: 16px !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="400" />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
            <ContentTemplate>
                <asp:HiddenField ID="hdnID" runat="server" Value="0" EnableViewState="false" />
                <asp:HiddenField ID="hdnName" runat="server" Value="0" EnableViewState="false" />
                <asp:HiddenField ID="hdnClientID" runat="server" Value="9960" />
                <asp:HiddenField ID="listOfDeletedItem" runat="server" Value="" EnableViewState="true" />
                <asp:HiddenField ID="listOfAddedItem" runat="server" Value="" EnableViewState="true" />
                <asp:HiddenField ID="AddedResource" runat="server" Value="" EnableViewState="true" />
                <asp:HiddenField ID="hdnRoleId" runat="server" Value="0" EnableViewState="true" />
                <asp:HiddenField ID="hndOption" runat="server" Value="0" EnableViewState="true" />
                <asp:HiddenField ID="Mid" runat="server" Value="3" />
                <asp:HiddenField ID="hdnOldSubject" runat="server" />
                <asp:HiddenField ID="hdnOldSowSignedDate" runat="server" Value="" />
                <asp:HiddenField ID="hdnOldCRBApprovalDate" runat="server" Value="" />
                <asp:HiddenField ID="hdnOldClientId" runat="server" />
                <asp:HiddenField ID="hdnOldCategoryId" runat="server" />
                <asp:HiddenField ID="hdnOldsubCategoryId" runat="server" />
                <asp:HiddenField ID="hdnOldCategoryValue" runat="server" />
                <asp:HiddenField ID="hdnOldSubCategoryValue" runat="server" />
                <asp:HiddenField ID="hdnOldTypeId" runat="server" />
                <asp:HiddenField ID="hdnOldPriorityId" runat="server" />
                <asp:HiddenField ID="hdnOldAreaDeveloperId" runat="server" Value="0" />
                <asp:HiddenField ID="hdnCategoryID" runat="server" Value="0" EnableViewState="false" />
                <asp:HiddenField ID="hdnType" runat="server" Value="" />
                <asp:HiddenField ID="hdnStatus" runat="server" Value="0" />
                <asp:HiddenField ID="ListOfAddedResourceNames" runat="server" Value="0" />

                <asp:HiddenField ID="hdnProductOwner" runat="server" EnableViewState="true" />
                <asp:HiddenField ID="hdnDesignLead" runat="server" EnableViewState="true" />
                <asp:HiddenField ID="hdnDevlopmentLead" runat="server" EnableViewState="true" />
                <asp:HiddenField ID="hdnQALead" runat="server" EnableViewState="true" />
                <asp:HiddenField ID="hdnProductOwnerID" runat="server" EnableViewState="true" />
                <asp:HiddenField ID="hdnDevlopmentLeadID" runat="server" EnableViewState="true" />
                <asp:HiddenField ID="hdnQALeadID" runat="server" EnableViewState="True" />
                <asp:HiddenField ID="hdnDesignLeadID" runat="server" EnableViewState="true" />

                <asp:HiddenField ID="hdnListOfPM" runat="server" EnableViewState="true" />
                <asp:HiddenField ID="hdnListOfPMIds" runat="server" EnableViewState="true" />
                <asp:HiddenField ID="hdnListOfOldPMIds" runat="server" EnableViewState="true" />
                <asp:HiddenField ID="HiddenField2" runat="server" EnableViewState="true" />
                <asp:HiddenField ID="hdnOldProductOwnerID" runat="server" EnableViewState="true" />
                <asp:HiddenField ID="hdnOldDevlopmentLeadID" runat="server" EnableViewState="true" />
                <asp:HiddenField ID="hdnOldQALeadID" runat="server" EnableViewState="true" />
                <asp:HiddenField ID="hdnOldDesignLeadID" runat="server" EnableViewState="true" />

                <asp:HiddenField ID="hdnListOfProjectManager" runat="server" EnableViewState="true" />
                <asp:HiddenField ID="hdnResource" runat="server" EnableViewState="true" />
                <asp:HiddenField ID="hdnResourceID" runat="server" EnableViewState="true" />
                <asp:HiddenField ID="editNotes" runat="server" EnableViewState="true" />
                <asp:HiddenField ID="removeLinkedID" runat="server" EnableViewState="true" />
                <asp:HiddenField ID="deleteResource" runat="server" EnableViewState="true" />
                <asp:HiddenField ID="deleteEstimate" runat="server" EnableViewState="true" />


            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Always">
            <ContentTemplate>
                <div id="DivTicketFlagRemove" runat="server" style="position: fixed; top: 38%; left: 31%; margin-top: -25px; margin-left: 0px; border: 1px solid black; display: none; width: 400px; z-index: 102; height: 150px; background-color: #BDE4B8;">
                    <table cellspacing="0" cellpadding="0" border="0" style="height: 100%; width: 100%;">
                        <tr>

                            <td style="height: 30px; text-align: right; padding-right: 5px;"></td>

                        </tr>
                        <tr>
                            <td style="height: 70px; padding: 5px; text-align: center; background-color: #DAF5D6;">
                                <div style="width: 90%; height: 40px; background-color: white; text-align: center; border: 1px solid #1F497D; z-index: 1; margin-left: 19px;">
                                    <span style="position: relative; top: 8px; font-size: 15px;"><b>Are you sure you want to remove linked ticket ?</b></span>
                                </div>

                            </td>
                        </tr>

                        <tr>
                            <td style="padding: 0px; background-color: #BDE4B8; text-align: center;">

                                <div style="padding: 2px; width: 100%; text-align: center;">
                                    <asp:Button ID="btnYes" runat="server" OnClick="btnYes_OnClick" Text="Yes" CssClass="Btn3D" Width="80px" />&nbsp;&nbsp;
                        <input type="button" class="Btn3D" value="No" id="btnNo" runat="server" onclick="HideDivRemove();" />

                                </div>
                            </td>
                        </tr>

                    </table>


                </div>

                <div id="removeResource" runat="server" style="position: fixed; top: 38%; left: 31%; margin-top: -25px; margin-left: 0px; border: 1px solid black; display: none; width: 400px; z-index: 102; height: 150px; background-color: #BDE4B8;">
                    <table cellspacing="0" cellpadding="0" border="0" style="height: 100%; width: 100%;">
                        <tr>

                            <td style="height: 30px; text-align: right; padding-right: 5px;"></td>

                        </tr>
                        <tr>
                            <td style="height: 70px; padding: 5px; text-align: center; background-color: #DAF5D6;">
                                <div style="width: 90%; height: 40px; background-color: white; text-align: center; border: 1px solid #1F497D; z-index: 1; margin-left: 19px;">
                                    <span style="position: relative; top: 8px; font-size: 15px;"><b>Are you sure you want to delete the Resource?</b></span>
                                </div>

                            </td>
                        </tr>

                        <tr>
                            <td style="padding: 0px; background-color: #BDE4B8; text-align: center;">

                                <div style="padding: 2px; width: 100%; text-align: center;">
                                    <asp:Button ID="Button1" runat="server" OnClick="Button1_OnClick" OnClientClick="return removeTableRow();" Text="Yes" CssClass="Btn3D" Width="80px" />&nbsp;&nbsp;
                            <input type="button" class="Btn3D" value="No" id="Button4" runat="server" onclick="HideDivRemove();" />

                                </div>
                            </td>
                        </tr>

                    </table>


                </div>

                <div id="divEstimate" runat="server" style="position: fixed; top: 38%; left: 31%; margin-top: -25px; margin-left: 0px; border: 1px solid black; display: none; width: 400px; z-index: 102; height: 150px; background-color: #BDE4B8;">
                    <table cellspacing="0" cellpadding="0" border="0" style="height: 100%; width: 100%;">
                        <tr>

                            <td style="height: 30px; text-align: right; padding-right: 5px;"></td>

                        </tr>
                        <tr>
                            <td style="height: 70px; padding: 5px; text-align: center; background-color: #DAF5D6;">
                                <div style="width: 90%; height: 40px; background-color: white; text-align: center; border: 1px solid #1F497D; z-index: 1; margin-left: 19px;">
                                    <span style="position: relative; top: 8px; font-size: 15px;"><b>Are you sure you want to delete the Estimate?</b></span>
                                </div>

                            </td>
                        </tr>

                        <tr>
                            <td style="padding: 0px; background-color: #BDE4B8; text-align: center;">

                                <div style="padding: 2px; width: 100%; text-align: center;">
                                    <asp:Button ID="Button5" runat="server" OnClick="Button5_OnClick" OnClientClick="return removeTableRow();" Text="Yes" CssClass="Btn3D" Width="80px" />&nbsp;&nbsp;
                            <input type="button" class="Btn3D" value="No" id="Button6" runat="server" onclick="HideDivRemove();" />

                                </div>
                            </td>
                        </tr>

                    </table>


                </div>
                <div id="DivTicketDetail" style="position: absolute; top: 26%; left: 30%; display: none; width: 455px; z-index: 102; height: 175px; background-color: #BDE4B8; border: 1px solid #BDE4B8;">
                    <table cellspacing="0" cellpadding="0" border="0" style="height: 100%; width: 100%;">
                        <tr>
                            <td style="height: 20px; padding: 5px; font-size: 11pt;">
                                <b>Search and Add Linked Ticket</b>
                                <%--   <span style="padding-bottom:10px;"> <b>Search and Add Linked Ticket&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;</b>
                       <span style="float:right;"></span><img src="../images/closebox2.gif" onclick="HideDiv();" style="cursor: pointer;"> </span>
                    &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                                --%>
                  
                            </td>
                            <td style="text-align: right; padding-right: 5px;">
                                <img src="../images/closebox2.gif" onclick="HideDiv();" style="cursor: pointer;">
                            </td>

                        </tr>
                        <tr>
                            <td style="height: 40px; padding: 5px; border-bottom: 1px solid #BDE4B8;" colspan="2">
                                <asp:TextBox ID="txtSearchBox" runat="server" Width="165" ValidationGroup="btn"></asp:TextBox>

                                <asp:Button ID="btnSearchpop" ValidationGroup="btn" Text="Search" runat="server" Font-Size="10" OnClientClick="return validate()" OnClick="btnSearchpop_OnClick" Style="margin-left: 10px; border: none; background-color: white;" />
                                <br />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                                    ControlToValidate="txtSearchBox"
                                    ValidationExpression="^[\d\s]+$"
                                    Display="Dynamic"
                                    EnableClientScript="true"
                                    ErrorMessage="Please enter numbers only"
                                    runat="server" />
                            </td>
                        </tr>

                        <tr>
                            <td style="padding: 5px; background-color: white;" colspan="2">
                                <div style="width: 70%;">
                                    <asp:GridView ID="ticketGrid" EmptyDataText="No data found!" Font-Size="11" runat="server" Width="100%" AutoGenerateColumns="false" ShowHeader="False" BorderStyle="None" GridLines="None" Style="padding: 10px;">
                                        <EmptyDataTemplate>
                                            <asp:Label Text="No Data found ." runat="server"></asp:Label></EmptyDataTemplate>
                                        <Columns>
                                            <asp:TemplateField HeaderText="Type" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="checkTicket" runat="server" Checked Enabled="false" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Type" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true">
                                                <ItemTemplate>
                                                    <asp:Label ID="ticketNumber" runat="server" Text='<%#Eval("ID")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="ticketName" runat="server" Text='<%#Eval("Name")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                    <%-- <asp:ObjectDataSource ID="ticketDataSource" runat="server" SelectMethod="PM_TicketFeature_TicketLink_Search" TypeName="Portal.BLL.PM.PM_Ticket_Features">
                            <SelectParameters>
                                <asp:ControlParameter Name="TicketID" Type="Int32" ControlID="hdnID" PropertyName="Value" />
                            </SelectParameters>
                        </asp:ObjectDataSource>--%>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" style="height: 40px; vertical-align: middle;" colspan="2">
                                <asp:Button ID="btnSaveTicket" runat="server" Text="Save" OnClick="btnSaveTicket_OnClick" CssClass="Btn3D" Width="80px" />&nbsp;&nbsp;
                       <%-- <input type="button" class="Btn3D" value="Cancel" id="btnCancelTicket" runat="server" onclick ="" />--%>
                                <asp:Button ID="Button3" runat="server" Text="Cancel" CausesValidation="false" UseSubmitBehavior="false" CssClass="Btn3D" />

                            </td>
                        </tr>
                    </table>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <table id="mainTable" cellspacing="0" cellpadding="0" border="0" style="width: 100%; overflow-y: scroll;" class="FormInnerTable">
            <tr style="background-color: #BDE4B8;">
                <td style="height: 5%; font-size: 13px; padding: 5px; border-bottom: 1px solid #609BD3; vertical-align: middle;">
                    <b>Edit Project Information</b>
                </td>
            </tr>
            <tr>
                <td style="height: 90%;">
                    <div style="max-height: 600px; height: 100%; overflow-y: auto;" class="DivScroll">
                        <table class="FormInnerTable" style="width: 100%; height: 97%; overflow-y: scroll;">
                            <tr class="WhtLine">
                                <td class="clearfix FormInnerTable EditTicket" style="height: 5%; padding-left: 15px; font-size: 15px; padding-top: 2px; vertical-align: middle;">
                                    <b>Ref#: <%= hdnID.Value  %></b>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 22%;">
                                    <div style="float: left; height: 100%; width: 100%;">
                                        <table border="0" cellpadding="1" cellspacing="0" class="FormInnerTable" style="width: 100%; height: 100%;">
                                            <tr>
                                                <td style="padding-left: 42px; padding-bottom: 10px; vertical-align: middle; font: 10pt Arial">Subject:<b class="RequiredField">*</b>
                                                </td>
                                                <td style="padding-bottom: 10px; vertical-align: middle;">
                                                    <asp:TextBox ID="txtName" runat="server" MaxLength="50" SkinID="GreenSmallTextbox" Width="196px" Height="15" CssClass="align"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RFtxt_Name" runat="server" ControlToValidate="txtName"
                                                        Display="Dynamic" ErrorMessage="<br/>Please Enter Subject" SkinID="RequiredFieldValidation"></asp:RequiredFieldValidator>
                                                    <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" CssClass="ErrorMessage"></asp:Label>
                                                </td>
                                                <td style="padding-bottom: 10px; padding-left: 50px; font: 10pt Arial; vertical-align: middle;">Sub Category: 
                                                </td>
                                                <td style="padding-bottom: 10px; vertical-align: middle;">

                                                    <asp:DropDownList ID="ddlSubCategories" runat="server" CssClass="SmallFontInput" DataSourceID="sdsSubCate"
                                                        DataTextField="Name" DataValueField="ID" SkinID="SmallTextCombo" Width="200px" Height="20" Font-Size="8">
                                                    </asp:DropDownList>
                                                    <asp:SqlDataSource ID="sdsSubCate" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                        SelectCommand="PM_SubCategories_CategoryID" SelectCommandType="StoredProcedure" DataSourceMode="DataReader">
                                                        <SelectParameters>
                                                            <asp:ControlParameter ControlID="ddlTicketCategories" Name="CategoryID" Type="Int32" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>


                                                </td>
                                                <td style="padding-bottom: 10px; padding-left: 50px; font: 10pt Arial; vertical-align: middle;">Priority:<b class="RequiredField">*</b>
                                                </td>
                                                <td style="padding-bottom: 10px; vertical-align: middle;">
                                                    <asp:DropDownList ID="ddlPriority" runat="server" SkinID="SmallTextCombo" Width="200px" Height="20" Font-Size="8" CssClass="SmallFontInput"></asp:DropDownList>
                                                    <asp:CompareValidator ID="CV_Priority" runat="server" ControlToValidate="ddlPriority"
                                                        Display="Dynamic" ErrorMessage="<br/>Please Select Priority" Operator="GreaterThan"
                                                        SkinID="CompareValidation" Type="Integer" ValueToCompare="0"></asp:CompareValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 42px; font: 10pt Arial">Client:<b class="RequiredField">*</b>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlTicketClients" runat="server" Height="20" Font-Size="8" DataSourceID="odsClients" DataTextField="Name"
                                                        DataValueField="ID" SkinID="SmallTextCombo" Width="200px" AutoPostBack="false">
                                                    </asp:DropDownList>
                                                    <asp:ObjectDataSource ID="odsClients" runat="server" TypeName="Portal.BLL.Users"
                                                        SelectMethod="GetClientsByUserIDAndSubModuleIDs">
                                                        <SelectParameters>
                                                            <asp:SessionParameter Name="userId" Type="int32" SessionField="AdminID" />
                                                            <asp:ControlParameter Name="subModuleIds" Type="String" ControlID="Mid" PropertyName="Value" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                    <asp:CompareValidator ID="CV_Client" runat="server" ControlToValidate="ddlTicketClients"
                                                        Display="Dynamic" ErrorMessage="<br/>Please Select Client" Operator="GreaterThan"
                                                        SkinID="CompareValidation" Type="Integer" ValueToCompare="0" />
                                                </td>
                                                <td style="padding-left: 50px; font: 10pt Arial">Type:<b class="RequiredField">*</b>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlTicketTypes" runat="server" DataSourceID="SDS_Type" DataTextField="Name"
                                                        DataValueField="ID" SkinID="SmallTextCombo" Width="200px" Height="20" Font-Size="8">
                                                    </asp:DropDownList>
                                                    <asp:SqlDataSource ID="SDS_Type" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                        SelectCommand="PM_TaskTypes_GetAll" SelectCommandType="StoredProcedure" DataSourceMode="DataReader"></asp:SqlDataSource>
                                                    <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddlTicketTypes"
                                                        Display="Dynamic" ErrorMessage="<br/>Please Select Type" Operator="GreaterThan"
                                                        SkinID="CompareValidation" Type="Integer" ValueToCompare="0"></asp:CompareValidator>
                                                </td>
                                                <td style="padding-left: 50px; font: 10pt Arial">Category:<b class="RequiredField">*</b>
                                                </td>
                                                <td>
                                                    <asp:UpdatePanel ID="upAreaDeveloper" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                        <ContentTemplate>
                                                            <asp:DropDownList ID="ddlTicketCategories" AutoPostBack="True" runat="server" CssClass="SmallFontInput" DataSourceID="SDS_Categories"
                                                                DataTextField="Name" DataValueField="ID" SkinID="SmallTextCombo" Width="200px" Height="20" Font-Size="8">
                                                            </asp:DropDownList>
                                                            <asp:SqlDataSource ID="SDS_Categories" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                SelectCommand="PM_Categories_Clients_GetAll" SelectCommandType="StoredProcedure" DataSourceMode="DataReader">
                                                                <SelectParameters>
                                                                    <asp:ControlParameter ControlID="ddlTicketClients" Name="ClientID" Type="Int32" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                            <asp:CompareValidator ID="CV_Category" runat="server" ControlToValidate="ddlTicketCategories"
                                                                Display="Dynamic" ErrorMessage="<br/>Please Select Category" Operator="GreaterThan"
                                                                SkinID="CompareValidation" Type="Integer" ValueToCompare="0" />
                                                        </ContentTemplate>
                                                        <%--<Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="ddlClients" EventName="SelectedIndexChanged" />
                                            </Triggers>--%>
                                                    </asp:UpdatePanel>
                                                </td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 44px; font: 10pt Arial; vertical-align: middle;">Linked Tickets:</td>
                                                <td style="font: 10pt Arial; vertical-align: middle;" colspan="6">
                                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Always">
                                                        <ContentTemplate>
                                                            <asp:DataList ID="dlData" runat="server" RepeatDirection="Horizontal" DataSourceID="LinkTicket">
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server" ID="ticketNumber" Font-Size="11"><%# Eval("Link_Ticket_Feature_Id") %></asp:Label>

                                                                    <img onclick="FunLinkedTicket(this);" id="<%# Eval("Link_Ticket_Feature_Id") %>" src="../images/icn_cross.png" height="12" style="padding-left: 5px; padding-right: 5px;" />
                                                                    <%--<asp:ImageButton ID="addEstimate" runat="server" ImageUrl="../images/icn_cross.png" OnClick="addEstimate_Click" />--%>
                                                                </ItemTemplate>
                                                            </asp:DataList>
                                                            <script type="text/javascript" language="javascript">  
                                                                Sys.Application.add_load(doMyAction);  
                                                            </script>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                    <%-- <span id="addticket">Add ticket <img src="../images/icn_cross.png" /></span>--%>
                                                    <asp:ObjectDataSource ID="LinkTicket" runat="server" SelectMethod="PM_TicketFeature_TicketLink_GetByTicketID" TypeName="Portal.BLL.PM.PM_Ticket_Features">
                                                        <SelectParameters>
                                                            <asp:ControlParameter Name="TicketID" Type="Int32" ControlID="hdnID" PropertyName="Value" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>

                            </tr>

                            <tr>
                                <td class="clearfix FormInnerTable EditTicket" style="height: 82%;">
                                    <div style="width: 100%; height: 14%; vertical-align: middle;">
                                        <table style="height: 100%;">
                                            <tr class="WhtLine">
                                                <td style="height: 30%; padding-left: 12px; font-size: 15px; padding-top: 0px;"><b>Dates:</b>
                                                </td>

                                            </tr>


                                            <tr class="WhtLine">
                                                <div style="height: 70%;"></div>
                                                <td style="padding-left: 38px; vertical-align: middle">
                                                    <span style="font: 10pt Arial">CRB Approval Date:</span>

                                                </td>
                                                <td style="padding-left: 5px; vertical-align: middle">
                                                    <input id="txtCRBApprovalDate" runat="server" readonly="readonly" maxlength="10" skinid="GreenSmallTextbox" onfocus="imgDDCalander.click();" style="width: 115px; height: 15px; line-height: 15px;" />

                                                    <img id="imgDDCalander" align="absMiddle" style="padding-top: 0px;" border="0" onclick=" setActiveStyleSheet(this, 'winter'); showCalendar('<%= txtCRBApprovalDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                                        onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" style="margin-left: 2px" />
                                                </td>
                                                <td style="padding: 3px; vertical-align: middle; padding-left: 80px;">
                                                    <span style="padding-right: 10px; font: 10pt Arial">SOW Approval Date:</span>

                                                </td>
                                                <td style="padding-left: 0px; vertical-align: middle">
                                                    <input id="txtSowSignedDate" runat="server" readonly="readonly" maxlength="10" skinid="GreenSmallTextbox" onfocus="imgDDCalander1.click();" style="width: 125px; height: 15px; line-height: 15px;" />

                                                    <img id="imgDDCalander1" style="padding-top: 0px;" align="absMiddle" border="0" onclick=" setActiveStyleSheet(this, 'winter'); showCalendar('<%= txtSowSignedDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                                        onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" style="margin-left: 2px" />
                                                </td>
                                    </div>
                            </tr>
                        </table>
                    </div>
                    <div style="height: 50%;">
                        <div style="float: left; height: 50%; width: 35%;">
                            <table border="0" cellpadding="1" cellspacing="0" class="FormInnerTable" style="width: 100%; height: 100%;">
                                <tr>
                                    <td style="padding-left: 13px; font-size: 15px; padding-top: 10px; padding-bottom: 0px;" id="td2" runat="server"><b>Resources:</b>
                                    </td>
                                    <td id="td3" runat="server"></td>


                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <div>
                                                    <asp:GridView ID="ResourcesGrid" runat="server" Height="180" OnRowCommand="OnRowCommand" OnRowDataBound="ResourcesGrid_RowDataBound" Width="50%" AutoGenerateColumns="false" ShowHeader="False" BorderStyle="None" GridLines="None" Style="margin-left: 10%;">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Type" HeaderStyle-Width="50%" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true">

                                                                <ItemTemplate>
                                                                    <asp:Label runat="server" ID="lblName" Text='<%#Server.HtmlEncode(Functions.StringTruncate(Functions.IfNull(RTrim(Eval("Title")), ""), 20)&":") %>' />

                                                                </ItemTemplate>
                                                                <FooterTemplate>
                                                                    <div class="ui-widget" style="height: 100%;">

                                                                        <asp:TextBox ID="txtResourceSearchBox" placeholder="Add New Field Name" runat="server" MaxLength="20" Width="259" Height="15"></asp:TextBox>
                                                                        <asp:ImageButton ID="ImageButton1" CommandName="ButtonField" runat="Server" ImageUrl="../images/less.png" Style="padding-left: 5px;"></asp:ImageButton>
                                                                        <asp:RequiredFieldValidator ID="RFV1_Name" runat="server" ControlToValidate="txtResourceSearchBox"
                                                                            ValidationGroup="NewDepartmentValidationGroup" ErrorMessage="<br/>Please Enter Resource Name" SkinID="RequiredFieldValidation"></asp:RequiredFieldValidator>
                                                                        <asp:HiddenField ID="hdnResourceSearchBox" runat="server" Value="0" />
                                                                    </div>
                                                                    <asp:LinkButton ID="linkButton" OnClick="linkButton_OnClick" runat="server">Save</asp:LinkButton>
                                                                    <%-- <asp:HyperLink  runat="server">Save</asp:HyperLink>--%>
                                                                </FooterTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Type" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true">
                                                                <ItemTemplate>
                                                                    <%-- <asp:UpdatePanel ID="upAreaDeveloper" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                                        <ContentTemplate>--%>

                                                                    <asp:Label ID="PO" runat="server" />

                                                                    <asp:DropDownList ID="ddlTicketOwner" onMouseWheel="return false;" runat="server" DataTextField="Name" AutoPostBack="True"
                                                                        DataValueField="ID" Width="150" onchange="changeIndex(this);" Height="20" Font-Size="8" OnSelectedIndexChanged="ddlTicketOwner_SelectedIndexChanged">
                                                                    </asp:DropDownList>
                                                                    <%-- <span ID="RoleID" class="role" style="display:none"><%# Eval("RoleID") %></span>
                                                                            <asp:HiddenField ID="RoleID" Value='<%# Eval("RoleID") %>'  runat="server"/>  --%>
                                                                    <asp:ImageButton ID='cross' runat="Server" data='<%# Eval("RoleID") %>' ImageUrl="../images/less.png" OnClientClick="return assignDeleteRole(this);" Style="padding-left: 2px"></asp:ImageButton>
                                                                    <%-- </ContentTemplate>
                                                                    </asp:UpdatePanel>--%>
                                                                </ItemTemplate>
                                                                <%-- <FooterTemplate>
                                                                    <asp:Label ID="PO" runat="server" />
                                                                    <asp:DropDownList ID="ddlAllUser" runat="server"  DataTextField="Name" AppendDataBoundItems="true" 
                                                                        DataValueField="ID" DataSourceID="ddlAllUserList" onMouseWheel="return false;" Width="150" onchange="changeIndex(this);" Height="20" Font-Size="8">
                                                                     <asp:ListItem Text="Add Owner" Value="0" />
                                                                    </asp:DropDownList>
                                                                    <asp:CompareValidator ID="ddlUserCheck" runat="server" ControlToValidate="ddlAllUser"
                                                                      ValidationGroup="NewDepartmentValidationGroup" 
                                                                      Display="Dynamic" ErrorMessage="<br/>Please Select Owner" Operator="GreaterThan"
                                                           SkinID="CompareValidation" Type="Integer" ValueToCompare="0"></asp:CompareValidator>
                                                             <asp:ObjectDataSource ID="ddlAllUserList" runat="server" SelectMethod="PM_Users_GetAll" TypeName="Portal.BLL.PM.PM_Ticket_Features"></asp:ObjectDataSource>
                                                                </FooterTemplate>--%>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                </ItemTemplate>
                                                                <%-- <FooterTemplate>
                                                                     <asp:ImageButton ID="ImageButton33" CommandName = "ButtonField" runat="Server" ImageUrl="../images/icn_cross.png" Style="padding-left:5px;"></asp:ImageButton>
                                                                </FooterTemplate>--%>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>


                                <tr>
                                    <td colspan="2" style="height: 26px; padding-left: 26px; padding-bottom: 3px; vertical-align: bottom;">
                                        <asp:LinkButton ID="addResources" runat="server" OnClick="addResources_OnClick">Edit</asp:LinkButton>
                                        <%--     <asp:ImageButton ID="addResources" runat="server" ImageUrl="../images/add.png" OnClick="addResources_Click" />--%>
                                        <%--<asp:LinkButton ID="addResources"  runat="server" Text="Add Field">
                                                        
                                                    </asp:LinkButton>
                                                   <asp:ImageButton runat="server"></asp:ImageButton>
                                                    <img src="../images/icn_add.png" class="imgadd" height="11"  />--%>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div style="width: 30%; display: inline-block; padding-top: 1px; text-align: center;">
                            <table border="0" cellpadding="1" cellspacing="0" class="FormInnerTable" style="width: 100%; height: 100%;">


                                <tr class="WhtLine">
                                    <td style="padding-left: 6px; font-size: 15px; padding-top: 10px; text-align: left;"><b>Notes:</b>
                                    </td>

                                </tr>
                                <tr>
                                    <td style="padding-top: 7px;">
                                        <textarea id="txtNotes" rows="10" cols="45" runat="server" style="overflow: hidden; font-size: 13px;"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="FormInnerTable" style="padding-bottom: 10px; padding-top: 10px; font-size: 8pt; height: 5%;">
                                        <div class="FormInnerTable" style="text-align: center;">
                                            Fields marked with asterisk<b class="RequiredField">*</b> are required.
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div style="float: right; height: 50%; width: 35%;">
                            <table border="0" cellpadding="1" cellspacing="0" class="FormInnerTable" style="width: 100%; height: 100%;">

                                <tr class="WhtLine">

                                    <td style="padding-left: 50px; font-size: 15px; padding-top: 12px; padding-bottom: 15px;"><b>Estimates:</b></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <div>
                                            <asp:UpdatePanel ID="UpdatePanel5" runat="server" UpdateMode="Conditional">
                                                <ContentTemplate>
                                                    <asp:GridView ID="EstimatesGrid" Height="200" runat="server" OnRowDataBound="EstimatesGrid_RowDataBound" OnRowCommand="OnRowCommandEstimate" DataSourceID="odsGetTicketEstimates" Width="88%" AutoGenerateColumns="false" ShowHeader="False" BorderStyle="None" GridLines="None" Style="margin-left: 10%;">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Type" HeaderStyle-Width="50%" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true">

                                                                <ItemTemplate>
                                                                    <asp:Label runat="server" ID="lblEstimateName" Text='<%#Server.HtmlEncode(Functions.StringTruncate(Functions.IfNull(RTrim(Eval("Title")), ""), 20)) & ":"%>' />

                                                                </ItemTemplate>
                                                                <FooterTemplate>

                                                                    <div class="ui-widget" style="height: 100%;">
                                                                        <asp:TextBox ID="txtEstimateSearchBox" MaxLength="50" runat="server" Width="249" Height="15"></asp:TextBox>
                                                                        <asp:ImageButton ID="ImageButton1" runat="Server" CommandName = "EstimateCancelbtn" ImageUrl="../images/less.png" Style="padding-left:5px"></asp:ImageButton>
                                                                        <asp:RequiredFieldValidator ID="RFV1_Name" runat="server" ControlToValidate="txtEstimateSearchBox"
                                                                            ValidationGroup="NewDepartmentValidationGroup" ErrorMessage="<br/>Please Enter Estimate Name" SkinID="RequiredFieldValidation"></asp:RequiredFieldValidator>
                                                                    </div>
                                                                    <asp:LinkButton ID="LinkEstimateSave" OnClick="LinkEstimateSave_OnClick" runat="server">Save</asp:LinkButton>
                                                                    <asp:HiddenField ID="hdnEstimates" runat="server" Value="0" />
                                                                </FooterTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Type" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="txtlbl" runat="server" Text='<%# Eval("EstimatesTypeID") %>' Visible="False"></asp:Label>
                                                                    <asp:TextBox ID="txtName" onkeydown=" return isNumber(event);" runat="server" MaxLength="5" SkinID="GreenSmallTextbox" Width="114px" onblur="myFunction(this)" onfocus="myFunction1(this)" Height="15px" Style="line-height: 15px; font-size: 15px; vertical-align: middle;" Text='<%# Eval("Estimates", "{0:N0}") %>'></asp:TextBox>
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <asp:ImageButton ID='EstimateCross' runat="Server" data='<%# Eval("ID") %>' ImageUrl="../images/less.png" OnClientClick="return assignDeleteRole1(this);" Style="padding-left: 0px;"></asp:ImageButton>
                                                                    <asp:RegularExpressionValidator CssClass="w" SetFocusOnError="true" ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtName" ValidationExpression="[a-zA-Z0-9'#\s()\-]*$" ErrorMessage="Special characters not allowed." />

                                                                </ItemTemplate>
                                                                <%-- <FooterTemplate>
                                                                 <div style="width:100%; display:inline-block">
                                                                 <asp:TextBox ID="Estimate" runat="server" MaxLength="5" SkinID="GreenSmallTextbox" Width="114px" Height="15px" onkeydown = "return isNumber(event);" Text=''></asp:TextBox>
                                                                
                                                              </FooterTemplate>--%>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                </ItemTemplate>
                                                              <%--  <FooterTemplate>
                                                                </FooterTemplate>--%>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                                        <asp:ObjectDataSource ID="odsGetTicketEstimates" runat="server" SelectMethod="PM_MYTicket_Estimates_GetByTicketID" TypeName="Portal.BLL.PM.PM_Ticket_Features">
                                            <SelectParameters>
                                                <asp:ControlParameter Name="ID" Type="Int32" ControlID="hdnID" PropertyName="Value" />

                                            </SelectParameters>
                                        </asp:ObjectDataSource>


                                    </td>
                                </tr>

                                <tr>
                                    <td colspan="2" style="height: 18px; padding-left: 26px; padding-bottom: 0px; padding-top: 9px;">
                                        <%-- <asp:LinkButton ID="addfield1" runat="server" Text="Add Field"></asp:LinkButton><img src="../images/icn_add.png" class="imgadd" />--%>
                                        <asp:LinkButton ID="addEstimate" runat="server" OnClick="addEstimate_OnClick">Edit</asp:LinkButton>
                                        <%-- <asp:ImageButton ID="addEstimate" runat="server" ImageUrl="../images/add.png" OnClick="addEstimate_Click" />--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 100px;"><b><span style="font-size: 15px;">Total:</span></b></td>
                                    <td style="padding-right: 112px;"><b>
                                        <asp:Label ID="Label2" runat="server" Text="" Font-Size="10"></asp:Label></b></td>
                                </tr>

                            </table>
                        </div>
                    </div>
                </td>
                <%--  <tr>
           <td class="FormInnerTable" style="padding-bottom:10px; padding-top:10px;font-size:8pt;height:5%;">
               <div class="FormInnerTable" style="text-align:center;">
                   Fields marked with asterisk<b class="RequiredField">*</b> are required.
               </div>
           </td>--%>
            </tr>

        </table>
        <%--                  
    <tr>
        <td class="FormInnerTable" style="padding-bottom:10px; padding-top:10px;font-size:8pt;height:5%;">
            <div class="FormInnerTable" style="text-align:center;">
                Fields marked with asterisk<b class="RequiredField">*</b> are required.
            </div>
        </td>
    </tr>--%>


        <tr style="background-color: #BDE4B8;">
            <td align="center" style="height: 5%; border-top: 1px solid #609BD3; vertical-align: middle; background-color: #BDE4B8;">
                <asp:Button ID="btnUpdateTicketDetail" ValidationGroup="NewDepartmentValidationGroup" runat="server" Text="Save" CssClass="Btn3D" Width="80px" />&nbsp;&nbsp;
				    <asp:Button ID="Button2" runat="server" Text="Cancel" CausesValidation="false" UseSubmitBehavior="false" CssClass="Btn3D" />
            </td>
        </tr>

    </form>
    <script type="text/javascript">
        $(document).keypress(function(e)
        {
            if(e.keyCode === 13)
            {
                e.preventDefault();
                return false;
            }
        });
        $(function () {
            if(<%= dt.Rows.Count%> > 0)
        {
            var availableTags = [ <%= SuggestionList %>];
            var availableEstimateTags = [ <%= SuggestionEstimateList %>];

            var ftextbox = document.getElementById('<%= (CType(ResourcesGrid.FooterRow.FindControl("txtResourceSearchBox"), TextBox)).ClientID %>')
            var fhdn = document.getElementById('<%= (CType(ResourcesGrid.FooterRow.FindControl("hdnResourceSearchBox"), HiddenField)).ClientID %>') 
            var Etextbox = document.getElementById('<%= (CType(EstimatesGrid.FooterRow.FindControl("txtEstimateSearchBox"), TextBox)).ClientID %>') 
            var Ehdn = document.getElementById('<%= (CType(EstimatesGrid.FooterRow.FindControl("hdnEstimates"), HiddenField)).ClientID %>') 

            if (ftextbox != null) {
                //alert('hurray');
                $(ftextbox).autocomplete({
                    source: availableTags,
                    messages: {
                        noResults: '',
                        results: function () { }
                    },
                    select: function (event, ui) {
                        event.preventDefault();
                        $(ftextbox).val(ui.item.label);
                        $(fhdn).val(ui.item.value);
                    },
                    focus: function (event, ui) {
                        event.preventDefault();
                        $(ftextbox).val(ui.item.label);
                    }
                });
            }

            if (Etextbox != null) {
                //alert('hurray');
                $(Etextbox).autocomplete({
                    source: availableEstimateTags,
                    messages: {
                        noResults: '',
                        results: function () { }
                    },
                    select: function (event, ui) {
                        event.preventDefault();
                        $(Etextbox).val(ui.item.label);
                        $(Ehdn).val(ui.item.value);
                    },
                    focus: function (event, ui) {
                        event.preventDefault();
                        $(Etextbox).val(ui.item.label);
                    }
                });
            }
        }
    });


    var listOfDeletedItem = null;
    var listOfAddedItem = null;
    var AddedResource = null;
    function RemoveOwner(img) {
           
        var UserID = img.id;
        var newListOfAddedItem=null;
        //$('#span' + UserID).css("display", "none");
        var span = document.getElementById("span"+UserID);
        var UserName = span.innerText;
       
        $('#span' + UserID).next("br").remove();
        span.parentNode.removeChild(span);  
        //span.parentNode.removeChild('br');

        var listOfDeletedItem = $("#listOfDeletedItem").val();
        if (listOfDeletedItem == "") {
            listOfDeletedItem = UserID;
        }
        else {
            listOfDeletedItem = listOfDeletedItem + "," + UserID;
        }
        $('#listOfDeletedItem').val(listOfDeletedItem);
        var ListOfResource = $('#listOfAddedItem').val();
        if (ListOfResource != "") {
            ListOfResource.replace("1," + UserID, "");
            $("#listOfAddedItem").val(ListOfResource);
        }
        var delItem=  $("#hdnListOfProjectManager").val();
        if (delItem == "") {
            $("#hdnListOfProjectManager").val(UserID);
        } else {
            $("#hdnListOfProjectManager").val(delItem+"," + UserID);
        }


        var PMIDS = $("#hdnListOfPMIds").val();
        var PMNames=$("#hdnListOfPM").val();
        if (PMIDS != "") {
            var isYes = false;
            var ListPM = PMIDS.split(",");
            var NewListPM=""
            for (var i = 0; i<ListPM.length;i++){
                if (ListPM[i] == UserID) {
                    isYes = true;
                }
                if (isYes == false) {
                    if (NewListPM == "") {
                        NewListPM = ListPM[i];
                    } else {
                        NewListPM = NewListPM +","+ListPM[i];
                    }
                }
            }
            $("#hdnListOfPMIds").val(NewListPM);
        }

        if (PMNames != "") {
            var isYes = false;
            var ListPM = PMNames.split(",");
            var NewListPM=""
            for (var i = 0; i<ListPM.length;i++){
                if (ListPM[i] == UserName) {
                    isYes = true;
                }
                if (isYes == false) {
                    if (NewListPM == "") {
                        NewListPM = ListPM[i];
                    } else {
                        NewListPM = NewListPM +","+ListPM[i];
                    }
                }
            }
            $("#hdnListOfPM").val(NewListPM);
        }
        //var ResourceArray=ListOfResource.split("|")
        //var id =0
        //for (var i = 0; i<ResourceArray.length;i++){
        //    var x=ResourceArray[i]
        //    var Resource =x.split(",")
        //    if (Resource[1]==UserID){
        //        id=i;
        //        break;
        //    }
        //}
        //ResourceArray.splice(id,1);
        //for (var i=0;i<ResourceArray.length;i++){
        //    if(newListOfAddedItem==null){
        //        newListOfAddedItem=ResourceArray[i];
        //    }
        //    else{
        //        newListOfAddedItem+="|"+ResourceArray[i];
        //    }
        //}
        //$("#listOfAddedItem").val(newListOfAddedItem);

        //var x= $("#listOfAddedItem").val();
        //x.replace("1,UserID|","")
        //alert(x);
    }
    function changeIndex(container) {
        debugger;
        var id = container.id;
        var RoleID = container.data;
        var UserID = container.value;
        var UserName =container.options[container.selectedIndex].text;
        var txt = $("#ResourcesGrid_ctl07_txtResourceSearchBox").val();
        var Option = $("#" + id + " :selected").text()
        var hiddenRole = document.getElementById('<%= hdnRoleId.ClientID %>');
            if(hiddenRole){
                hiddenRole.value = RoleID;
            }
            var hiddenOption = document.getElementById('<%= hndOption.ClientID %>');
            if(hiddenOption){
                hiddenOption.value = Option;
            }
            if(RoleID=="1"){
                var html = "<span style='font-size:13px;' id= span" + UserID + " >" + Option + "<img id =" + UserID + " data =" + RoleID + " src='../images/icn_cross.png' style='padding-left:8px;width:13px;'  class='imgcross' onclick='RemoveOwner(this)' /></span> <br>"
                $("#" + container.id).parent().children("span").append(html);
            }
            else{
                // var html =  Option + "<img id =" + UserID + " data =" + RoleID + " src='../images/icn_cross.png' style='padding-left:8px;width:13px;'  class='imgcross' onclick='RemoveOwner(this)' />"
                $("#" + container.id).parent().children("span").val("");
                $("#" + container.id).parent().children("span").val(Option);
            }
            if (RoleID != undefined) {
                if (listOfAddedItem == null) {
                    listOfAddedItem = RoleID + "," + UserID;
                    $("#listOfAddedItem").val(listOfAddedItem);
                
                }
                else {
                    var Items=listOfAddedItem.split("|");
                    var AddItems ;
                    for(var i=0;i<Items.length;i++)
                    {
                        var item=Items[i].split(",");
                        if(item[0]=RoleID && RoleID!=1)
                        {
                            Items[i]= RoleID + "," + UserID;
                        }
                        if(AddItems==null)
                            AddItems=Items[i]
                        else
                            AddItems=AddItems+"|"+Items[i]
                    }
                    listOfAddedItem = AddItems
                    $("#listOfAddedItem").val(listOfAddedItem);
                }
        
                return true;
            }

            var fhdn = document.getElementById('<%= (CType(ResourcesGrid.FooterRow.FindControl("hdnResourceSearchBox"), HiddenField)).ClientID %>').id;
            var val = $("#" + fhdn).val();
            if (val != 0) {
                if (listOfAddedItem == null) {
                    listOfAddedItem = val + "," + UserID;
                    $("#listOfAddedItem").val(listOfAddedItem);
                }
                else {
                    listOfAddedItem = listOfAddedItem + "|" + val + "," + UserID;
                    $("#listOfAddedItem").val(listOfAddedItem);
                }
            }
            else {
                var ftextbox = document.getElementById('<%= (CType(ResourcesGrid.FooterRow.FindControl("txtResourceSearchBox"), TextBox)).ClientID %>').id 
                var txtResourceSearchBox = $("#" + ftextbox).val();
                // if (AddedResource==null)
                //{
                var x = Option 
                $('#ResourcesGrid_ctl07_PO').text(x);
                AddedResource = UserID;
                //}
                //else
                //{
                //  AddedResource = AddedResource + "," +UserID;
                //}
             
                $("#AddedResource").val(AddedResource);
            }
       
            return true;
        }
        
        function isNumber(evt) {
                
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && !((charCode >= 48 && charCode <= 57) || (charCode >= 96 && charCode <= 105))) {
                return false;
            }
            return true;
        }

        $(document).ready(function() {
            $('#mainTable').css("height", $(window).height()-20);
        });
        function RemoveRes(img) {
            var id = img.id;
            var role = img.data;
            var parentId = $('#' + id).parent().attr("id");
            var deleted=   $('#listOfDeletedItem').val();
            var item= role +","+ id;
            if (deleted == "") {
                $('#listOfDeletedItem').val(id);
            } else {
                $('#listOfDeletedItem').val(deleted + ","+ id);
            }
            $("#" + parentId).html("<br/> ");
           
            if (role == "2") {
              
                $("#hdnProductOwnerID").val("");
                $("#hdnProductOwner").val(null);
               
            }
            else if (role == "3") {
                $("#hdnDesignLead").val("");
                $("#hdnDesignLeadID").val("");
            }
            else if (role == "4") {
                $("#hdnDevlopmentLeadID").val("");
                $("#hdnDevlopmentLead").val("");
            }
            else if (role == "5") {
                $("#hdnQALeadID").val("");
                $("#hdnQALead").val("");
            }
        }
        function RemoveResource() {
            $('#ResourcesGrid_ctl07_PO').text(x);
        } 
        $( document ).ready(function() {
            var table = $('#dlData').html();
            
            if (table !== undefined ) {
            
                //  $('#DataList1" >tbody:last').append("<tr><td>Item value...</td></tr>");
                $('#dlData tr').append("<td><img onclick='addLinkedTicket();' src='../images/add_ticket.png' /></td>");
            } else {
               
                $('#UpdatePanel4')
                    .append(
                        "<table><tr><td><img onclick='addLinkedTicket();' src='../images/add_ticket.png' /></td></tr></table>");
            }
            InitEditor();
            $('#ResourcesGrid$ctl08$txtResourceSearchBox').val("Add");
            
           
           
        });
        function InitEditor() {
  
            //CKEDITOR.replace('txtNotes');
            CKEDITOR.replace( 'txtNotes',
                {
                    on :
                    {
                        instanceReady : function( ev )
                        {
                            // Output paragraphs as <p>Text</p>.
                            this.dataProcessor.writer.setRules( 'p',
                                {
                                    indent : false,
                                    breakBeforeOpen : true,
                                    breakAfterOpen : false,
                                    breakBeforeClose : false,
                                    breakAfterClose : true
                                });
                        }
                    }
                });
            CKEDITOR.config.toolbar = [
                ['Bold', 'Italic', 'Underline','NumberedList', 'BulletedList', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']
               
            ];
            //  CKEDITOR.config.height=260;
            //n.setRules('p',{indent:false,breakAfterOpen:false});
            // CKEDITOR.config.width=555;
            CKEDITOR.config.removePlugins='elementspath,magicline';
            //CKEDITOR.config.removePlugins = '';
            CKEDITOR.on('instanceReady', function () {
                $.each(CKEDITOR.instances, function (instance) {
                    CKEDITOR.instances[instance].on("change",function (e) {
               
                        
                        for (instance in CKEDITOR.instances
                        )
                            CKEDITOR.instances[instance].updateElement();


                    });
                });
            });
           
    

        }

        var preValue = 0;
        function myFunction1(text) {
            preValue=text.value  
        }
        function myFunction(text) {
           
            //if (preValue != 0) {
            //    txt = txt.replace(/,/g, "");
            //    var x = Number(txt)-Number(preValue);
            //    $('#Label2').text(x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
            //}
            var txt= $('#Label2').text();
            var val=text.value
            if (txt == "") {
                $('#Label2').text(val + " Hrs");
            } else {
                txt = txt.replace(/,/g, "");
                txt = txt.replace("Hrs", "");
                // preValue=preValue.replace(/,/g, "");
                //  alert(txt)
                var x = Number(val) + Number(txt) -Number(preValue);
                $('#Label2').text(x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") +" Hrs");
            }

          
        }
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(doMyAction);
        function FunLinkedTicket(ev) {
            $('#removeLinkedID').val(ev.id);
            $('#DivTicketFlagRemove').css('display', 'block');
        }
        function HideDivRemoveFlag(){
            var divTicketDetails = getElement('DivTicketFlagRemove');
            divTicketDetails.style.display = 'none';
            //var del = getElement('del');
            //del.style.display = 'none';
            //window.location = "MyPMReports.aspx"
 
        }
        function doMyAction() {
            
            var table = $('#dlData').html();
            if (table !== undefined ) {
                $('#dlData tr').append("<td><img onclick='addLinkedTicket();' src='../images/add_ticket.png' /></td>");
            } else {
                $('#UpdatePanel4')
                    .append(
                        "<table><tr><td><img onclick='addLinkedTicket();' src='../images/add_ticket.png' /></td></tr></table>");
            }
        }
        function addLinkedTicket() {
            ShowDiv();
        }
       
        function ShowDiv() {
            $('#DivTicketDetail').css("display", "inline");
        }
        function validate() {
            var text = $("#txtSearchBox").val();
            if (text == "") {
                return false;
            } else {
                return true;
            }
        }
        function HideDiv(){
            var divTicketDetails = getElement('DivTicketDetail');
            divTicketDetails.style.display = 'none';
            $('#<%=ticketGrid.ClientID%>').html("");
            $('#txtSearchBox').val("");
        }

        var item = null;
        function assignDeleteRole(ev) {
            item = ev;
            $('#deleteResource').val(ev.data);
            $('#removeResource').css("display", "inline");
            return false;

        }
        function assignDeleteRole1(ev) {
            item = ev;
            $('#deleteEstimate').val(ev.data);
            $('#divEstimate').css("display", "inline");
            return false;

        }
        function HideDivRemove() {
            var divTicketDetails = getElement('removeResource');
            divTicketDetails.style.display = 'none';
        }
        function removeTableRow() {
            if (item != null) {
                var id = item.id;
                $('#' + id).parent().parent().html("");
                item = null;
                return true;
            } else {
                return false;
            }
        }
       
    </script>

</body>
</html>
