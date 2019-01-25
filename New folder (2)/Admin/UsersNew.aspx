<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UsersNew.aspx.vb" Inherits="Admin_UsersNew" Theme="Default" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
</head>
<body style ="margin :0px;background-color:#F2F2F2; height:100%;width:100%; overflow:auto; ">
    <form id="form1" runat="server" defaultfocus="txtFirstName">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
         <asp:UpdateProgress ID="Progress1" runat="server">
            <ProgressTemplate>
               <div class="ProgressIndicatorDivGray" style="right: 20px; bottom: 40px">                            
                    <br />
                    <img src="../images/indicator.gif" align="absmiddle" /><b>&nbsp;&nbsp;Loading ...</b>
                    <br /><br />
                </div>
            </ProgressTemplate>
    </asp:UpdateProgress>
        <table  cellspacing="0" border="0" style="height:100%; width:100%;Background-color:#F2F2F2;padding-left: 1em; "  >
                   <tr class="GalleryTitle" style="background-image:url('../images/bg_mainHdr_1.jpg');height:31px;">
                         <td  style="height:31px;background-color:#A0CDEE;font-size:12px;padding:5px;width:65%;">
                               <span style="font-weight:bold;">New User</span>
                        </td>
                   </tr>       
                  <tr>
                    <td align="center" style="vertical-align:top; height:100%; width:100%; Background-color:#F2F2F2;" >
                      <div  style="overflow:auto; height:100%; width:100%; padding-top:10px;" id="Div1" class="GrayScrollBar" >
                        <table border="0" cellpadding="0"  class="Table" cellspacing="0" style="width:100%;  height:100%; text-align:left; vertical-align:top; padding-left:1em; Background-color:#F2F2F2;">
                                    <tr>
                                        <td style="width: 15%; text-align: left;">
                                        </td>
                                        <td style="width: 13%; text-align: left;">
                                        </td>
                                        <td style="width: 15%; text-align: left;">
                                        </td>
                                        <td style="width: 5%; text-align: left;">
                                        </td>
                                        <td style="width: 9%; text-align: left;">
                                        </td>
                                        <td style="width: 15%; text-align: left;">
                                        </td>
                                        <td style="width: 25%; text-align: left;">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 25px;" valign="top" >
                                        </td>
                                        <td style="text-align: left;" valign="top"  >
                                            First Name:<span class="RequiredField" style="font-size: 9pt; color: #000000"><span
                                                style="font-size: 8pt; color: #ff0000">*</span></span>
                                        </td>
                                        <td style="text-align: left;" valign="top">
                                            <asp:TextBox ID="txtFirstName" runat="server" 
                                                MaxLength="200" 
                                                cssClass="GreyTextBoxNormal"
                                                Width="150px">
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RFV_FirstName" runat="server" 
                                                ControlToValidate="txtFirstName"
                                                Display="Dynamic" 
                                                ErrorMessage="Please Enter First Name" 
                                                SkinID="RequiredFieldValidation">
                                           </asp:RequiredFieldValidator><span
                                           style="font-size: 8pt; color: #ff0000"></span>
                                        </td>
                                        <td style="text-align: left" valign="top" >
                                        </td>
                                        <td style=" text-align: left;" valign="top" >
                                            <span class="RequiredField" style="font-size: 9pt; color: #ff0000"></span>
                                                Middle Name:
                                        </td>
                                        <td style="text-align: left;" valign="top" >
                                            <span
                                                    style="font-size: 8pt; color: #ff0000"> 
                                            <asp:TextBox ID="txtMiddleName" runat="server" 
                                                MaxLength="50" CssClass="GreyTextBoxNormal"
                                                Width="150px">
                                           </asp:TextBox>
                                           </span><span style="font-size: 7pt"></span>
                                        </td>
                                        <td style="text-align: left; width: 25%;" valign="top" >
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 25px;" valign="top">
                                        </td>
                                        <td style="text-align: left; height: 25px;" valign="top">
                                            <span>Last Name:<span class="RequiredField" style="color: #000000">
                                            <span style="color: #ff0000">*</span></span></span>
                                        </td>
                                        <td style="text-align: left;" valign="top">
                                            <span style="font-size: 8pt; color: #ff0000"> 
                                            <asp:TextBox ID="txtLastName" runat="server" MaxLength="200" CssClass="GreyTextBoxNormal" 
                                                Width="150px"></asp:TextBox><br />
                                            <asp:RequiredFieldValidator ID="RFV_LastName" runat="server" ControlToValidate="txtLastName"
                                                Display="Dynamic" ErrorMessage="Please Enter Last Name" SkinID="RequiredFieldValidation">
                                            </asp:RequiredFieldValidator>
                                            </span>
                                        </td>
                                        <td style="text-align: left" valign="top">
                                        </td>
                                        <td style=" text-align: left;" valign="top">
                                            User &nbsp;Name:<span style="color: #000000"><span style="color: #ff0000">*</span></span></td>
                                        <td style="text-align: left;" valign="top">
                                            <asp:TextBox ID="txtUserName" runat="server" MaxLength="200" CssClass="GreyTextBoxNormal" 
                                                 Width="150px" >
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RFV_txtUserName" runat="server" ControlToValidate="txtUserName"
                                                Display="Dynamic" ErrorMessage="Please Enter User Name" SkinID="RequiredFieldValidation"></asp:RequiredFieldValidator>
                                            <asp:Label ID="lblErrorMessage" runat="server" CssClass="ErrorMessage" ForeColor="Red"></asp:Label></td>
                                        <td style="width: 25%; text-align: left" valign="top">
                                        </td>
                                    </tr>
                                    <tr style="font-size: 9pt">
                                        <td style="height: 25px;" valign="top">
                                        </td>
                                        <td style="text-align: left;" valign="top"><span class="RequiredField" style="color: #000000"><span style="color: #ff0000"></span>
                                            <span>
                                            Address:<br />
                                            </span>
                                            <font face="arial, helvetica, sans-serif" size="1">( max.500<br />
                                                characters. )</font></span>
                                        </td>
                                        <td style="text-align: left; " valign="top">
                                            <asp:TextBox ID="txtAddress" runat="server" MaxLength="500"                                
                                                Rows="3" CssClass="GreyTextBoxNormal" 
                                                TextMode="MultiLine" Width="150px">
                                            </asp:TextBox>
                                            <asp:RegularExpressionValidator 
                                                ID="REV_CheckCount" 
                                                runat="server" 
                                                ErrorMessage="Please Enter Characters Less Than 500" 
                                                ControlToValidate="txtAddress" 
                                                Display="Dynamic" 
                                                ValidationExpression="^[\s\S]{1,500}$">
                                          </asp:RegularExpressionValidator>
                                        </td>
                                        <td style="text-align: left; " valign="top">
                                        </td>
                                        <td style="text-align: left; " valign="top">
                                            City:
                                        </td>
                                        <td style="text-align: left; " valign="top">
                                            <asp:TextBox ID="txtCity" runat="server" MaxLength="100" cssClass="GreyTextBoxNormal"
                                                 Width="150px" >
                                            </asp:TextBox>
                                        </td>
                                        <td style="width: 25%; text-align: left; " valign="top">
                                        </td>
                                    </tr>
                                    <tr style="font-size: 9pt">
                                        <td style="height: 25px;" valign="top">
                                        </td>
                                        <td style="text-align: left; "><span><span><span style="color: #000000">
                                            Country:
                                            <span class="RequiredField" style="font-size: 9pt; color: #ff0000">*</span>
                                            </span>
                                            </td>
                                        <td style="text-align: left;">
                                            <span style="font-size: 8pt; color: #ff0000"> 
                                            <asp:DropDownList 
                                            ID="ddlCountry" 
                                            runat="server" 
                                            AutoPostBack="true"    
                                            DataSourceID="SqlDSCountries"
                                            DataTextField="Name" 
                                            DataValueField="ID" 
                                            SkinID="SmallTextCombo"
                                            Width="150px" >
                                                <asp:ListItem Value="0">Select...</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlDSCountries" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                SelectCommand="Countries_GetAll" 
                                                SelectCommandType="StoredProcedure"
                                                DataSourceMode="DataReader">
                                            </asp:SqlDataSource>
                                            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddlCountry"
                                                    Display="Dynamic" ErrorMessage="Please Select Country" Operator="GreaterThan"
                                                    SkinID="CompareValidation" Type="Integer" ValueToCompare="0">
                                            </asp:CompareValidator>
                                            </span>
                                        </td>
                                        <td style="text-align: left">
                                        </td>
                                        <td style=" text-align: left;">
                                            State:<span style="color: #ff0000">*</span></td>
                                        <td style="text-align: left;">
                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                             <asp:DropDownList   
                                            ID="ddlStates" 
                                            runat="server" 
                                            DataTextField="Name" 
                                            DataValueField="ID"
                                            SkinID="SmallTextCombo" 
                                            DataSourceID = "SqlDSStates"
                                            Width="150px" >
                                            <asp:ListItem Value="0">Select...</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlDSStates" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                SelectCommand="States_GetByCountryID" 
                                                SelectCommandType="StoredProcedure" 
                                                DataSourceMode="DataReader">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlCountry" DefaultValue="1" Name="CountryID" PropertyName="SelectedValue"
                                                        Type="Int32" />
                                                </SelectParameters>                                               
                                            </asp:SqlDataSource>
                                            </ContentTemplate>
                                              <Triggers>
                                              <asp:AsyncPostBackTrigger ControlID="ddlCountry" EventName="SelectedIndexChanged" />
                                              </Triggers>
                                              </asp:UpdatePanel>
                                                <asp:CompareValidator ID="CV_st" runat="server" 
                                                ErrorMessage="Please Select States" ControlToValidate="ddlStates" Display="Dynamic" Operator="GreaterThan" SkinID="CompareValidation" ValueToCompare="0"></asp:CompareValidator></td>
                                        <td style="width: 25%; text-align: left" valign="top">
                                        </td>
                                    </tr>
                                    <tr style="font-size: 9pt">
                                        <td style="height: 25px;" valign="top">
                                        </td>
                                        <td style="text-align: left; height: 25px;" valign="top">
                                            <span class="RequiredField" style="color: #000000"><span style="font-size: 8pt;
                                                color: #ff0000"></span> <span>
                                            Zip:</span></span>
                                        </td>
                                        <td style="text-align: left;" valign="top">
                                            <asp:TextBox ID="txtZip" runat="server" MaxLength="50" cssClass="GreyTextBoxNormal"
                                                 Width="150px">
                                            </asp:TextBox>
                                            <asp:RegularExpressionValidator ID="REV_txtZip" runat="server" ControlToValidate="txtZip"
                                                Display="Dynamic" ErrorMessage="Please Enter Valid Zip Code" ValidationExpression="\d{5}(-\d{4})?">
                                            </asp:RegularExpressionValidator>
                                        </td>
                                        <td style="text-align: left" valign="top">
                                        </td>
                                        <td style="text-align: left;" valign="top">
                                            Gender:<span style="color: #ff0000">*</span>
                                        </td>
                                        <td style="text-align: left;" valign="top">
                                            <asp:RadioButtonList ID="rbtlstGender" runat="server" CellPadding="0" Height="20px"
                                                RepeatDirection="Horizontal" SkinID="SmallTextRadioButton"  >
                                                <asp:ListItem Value="False" Selected="True">&lt;span style=&quot;font-size:12px;&quot; &gt;Male&lt;/span&gt;</asp:ListItem>
                                                <asp:ListItem Value="True">&lt;span style=&quot;font-size:12px;&quot;&gt;Female&lt;/span&gt;</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                        <td style="width: 25%; text-align: left" valign="top">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 25px;" valign="top">
                                        </td>
                                        <td style="text-align: left; " valign="top">
                                            <span>DOB:<span style="font-size: 9pt;
                                                color: #ff0000">*</span>
                                            </span>
                                        </td>
                                        <td style="text-align: left;" valign="top">
                                            <asp:TextBox ID="txtDOB" runat="server" MaxLength="10" 
                                                cssClass="GreyTextBoxNormal"  onfocus="imgDOBCalander.click();"
                                                Width="123px">
                                             </asp:TextBox>
                                           <img id="imgDOBCalander" src="../images/ico_calendar.jpg" border="0" align="absmiddle" onMouseOver="style.cursor='hand';" onClick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtDOB.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"  />
                                            <asp:RequiredFieldValidator ID="RFV_DOB" runat="server" 
                                                ControlToValidate="txtDOB"
                                                Display="Dynamic" ErrorMessage="Please Select DOB" 
                                                SkinID="RequiredFieldValidation">
                                            </asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="REV_DOB" runat="server" 
                                                ControlToValidate="txtDOB"
                                                Display="Dynamic" 
                                                ErrorMessage="Date is not in Correct Format" 
                                                ValidationExpression="^\d{1,2}\/\d{1,2}\/\d{2,4}$">
                                           </asp:RegularExpressionValidator>
                                        </td>
                                        <td style="text-align: left;" valign="top">
                                        </td>
                                        <td style="text-align: left;" valign="top">
                                            Work Phone:<span style="color: #ff0000">*</span></td>
                                        <td style="text-align: left;" valign="top">
                                            <asp:TextBox ID="txtWorkPhone" runat="server" MaxLength="50" cssClass="GreyTextBoxNormal"
                                                 Width="150px">
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RFV_WorkPhone" runat="server" 
                                                ControlToValidate="txtWorkPhone"
                                                Display="Dynamic" 
                                                ErrorMessage="Please Enter Work Phone" 
                                                SkinID="RequiredFieldValidation">
                                             </asp:RequiredFieldValidator>
                                          </td>
                                        <td style="width: 25%; text-align: left" valign="top">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 25px;" valign="top">
                                        </td>
                                        <td style="text-align: left;" valign="top">
                                            Hiring Date:<span style="color: #ff0000">*</span>
                                        </td>
                                        <td style="text-align: left;" valign="top">
                                            <asp:TextBox ID="txtHiringDate" runat="server" 
                                                MaxLength="10" cssClass="GreyTextBoxNormal" 
                                                onfocus="imgHDCalander.click();"
                                                 Width="123px">
                                            </asp:TextBox>
                                            <img id="imgHDCalander" src="../images/ico_calendar.jpg" border="0" align="absmiddle" onMouseOver="style.cursor='hand';" onClick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtHiringDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"  /> 
                                            <asp:RequiredFieldValidator ID="RFV_HiringDate" runat="server" 
                                                ControlToValidate="txtHiringDate"
                                                Display="Dynamic" 
                                                ErrorMessage="Please Select Hiring Date" 
                                                SkinID="RequiredFieldValidation">
                                            </asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" 
                                                runat="server" 
                                                ControlToValidate="txtHiringDate"
                                                Display="Dynamic" 
                                                ErrorMessage="Date is not in Correct Format" 
                                                ValidationExpression="^\d{1,2}\/\d{1,2}\/\d{2,4}$">
                                             </asp:RegularExpressionValidator>
                                             <asp:CompareValidator ID="CV_DobLessThanHD" runat="server"
                                                 
                                                ErrorMessage="DOB must be Greater than Hiring Date" ControlToCompare="txtDOB" ControlToValidate="txtHiringDate" Display="Dynamic" Operator="GreaterThan" Type="Date"></asp:CompareValidator>
                                        </td>
                                        <td style="text-align: left;" valign="top">
                                        </td>
                                        <td style="text-align: left;" valign="top">
                                            Home Phone:
                                        </td>
                                        <td style="text-align: left;" valign="top">
                                            <asp:TextBox ID="txtHomePhone" runat="server" MaxLength="50" cssClass="GreyTextBoxNormal"
                                                Width="150px">
                                            </asp:TextBox>
                                        </td>
                                        <td style="width: 25%; text-align: left;" valign="top">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 25px;" valign="top">
                                        </td>
                                        <td style="text-align: left; height: 25px;" valign="top">
                                            SSN/NIC:<span style="color: #ff0000">*</span>
                                        </td>
                                        <td style="text-align: left; height: 25px;" valign="top">
                                            <asp:TextBox ID="txtSSN" runat="server" MaxLength="15" cssClass="GreyTextBoxNormal"
                                                 Width="150px">
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" 
                                                runat="server" ControlToValidate="txtSSN"
                                                Display="Dynamic" 
                                                ErrorMessage="Please Enter SSN/NIC" 
                                                SkinID="RequiredFieldValidation">
                                            </asp:RequiredFieldValidator>                                           
                                        </td>
                                        <td style="text-align: left; height: 25px;" valign="top">
                                        </td>
                                        <td style="text-align: left; height: 25px;" valign="top">
                                            Cell Phone:
                                        </td>
                                        <td style="text-align: left; height: 25px;" valign="top">
                                            <asp:TextBox ID="txtCellPhone" runat="server" MaxLength="50" cssClass="GreyTextBoxNormal"
                                                 Width="150px">
                                            </asp:TextBox>
                                        </td>
                                        <td style="width: 25%; text-align: left; height: 25px;" valign="top">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 25px;" valign="top">
                                        </td>
                                        <td style="text-align: left; height: 25px;" valign="top">
                                            Job Tilte:
                                        </td>
                                        <td style="text-align: left; height: 25px;" valign="top">
                                            <asp:TextBox ID="txtJobtitle" runat="server" MaxLength="200" cssClass="GreyTextBoxNormal"
                                                 Width="150px" >
                                             </asp:TextBox>
                                        </td>
                                        <td style="text-align: left; height: 25px;" valign="top">
                                        </td>
                                        <td style="text-align: left; height: 25px;" valign="top">
                                            Work
                                            Email:<span style="color: #ff0000">*</span></td>
                                        <td style="text-align: left; height: 25px;" valign="top">
                                            <asp:TextBox ID="txtEmail" runat="server" MaxLength="200" cssClass="GreyTextBoxNormal"
                                                 Width="150px" >
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" 
                                                runat="server" 
                                                ControlToValidate="txtEmail"
                                                Display="Dynamic" 
                                                ErrorMessage="Please Enter Email" 
                                                SkinID="RequiredFieldValidation">
                                            </asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                                ControlToValidate="txtEmail"
                                                Display="Dynamic" ErrorMessage="Please Enter valid Email"   
                                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                                            </asp:RegularExpressionValidator>
                                        </td>
                                        <td style="width: 25%; text-align: left; height: 25px;" valign="top">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 25px;"  valign="top">
                                        </td>
                                        <td style="text-align: left; height: 25px;" valign="top">
                                            Department:<span style="color: #ff0000">*</span></td>
                                        <td align="left" style="text-align: left; height: 25px;" valign="top">
                                            <asp:DropDownList ID="ddlDeparments" runat="server" 
                                                AutoPostBack="false" DataSourceID="SqlDSDepartments"
                                                DataTextField="Name" DataValueField="ID" 
                                                SkinID="SmallTextCombo" Width="150px">
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlDSDepartments" 
                                                runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                SelectCommand="Groups_GetGroupsbyType" 
                                                SelectCommandType="StoredProcedure"
                                                DataSourceMode="DataReader">
                                                <SelectParameters>
                                                    <asp:Parameter ConvertEmptyStringToNull="False" DefaultValue="1" Name="Type" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:CompareValidator ID="CV_Department" runat="server" ControlToValidate="ddlDeparments"
                                                Display="Dynamic" ErrorMessage="Please Select Department" Operator="GreaterThan"
                                                SkinID="CompareValidation" Type="Integer" ValueToCompare="0"></asp:CompareValidator></td>
                                        <td align="left" style="text-align: left; height: 25px;" valign="top">
                                        </td>
                                        <td align="left" style="text-align: left; height: 25px;" valign="top">
                                            Team:<span style="color: #ff0000">*</span>
                                        </td>
                                        <td align="left" style="text-align: left; height: 25px;" valign="top">
                                            <asp:DropDownList ID="ddlTeams" runat="server" DataSourceID="SqlDSTeams"
                                                DataTextField="Name" DataValueField="ID" 
                                                SkinID="SmallTextCombo" Width="150px">
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlDSTeams" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                SelectCommand="Groups_GetGroupsbyType" 
                                                SelectCommandType="StoredProcedure"
                                                DataSourceMode="DataReader">
                                                <SelectParameters>
                                                    <asp:Parameter ConvertEmptyStringToNull="False" DefaultValue="2" Name="Type" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:CompareValidator ID="CV_Teams" runat="server" ControlToValidate="ddlTeams" Display="Dynamic"
                                                ErrorMessage="Please Select Teams" Operator="GreaterThan" SkinID="CompareValidation"
                                                Type="Integer" ValueToCompare="0"></asp:CompareValidator></td>
                                        <td align="left" style="width: 25%; text-align: left; height: 25px;" valign="top">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 25px;">
                                        </td>
                                        <td style="text-align: left;"><span style="color: #ff0000"></span>Office:<span style="color: #ff0000">*</span>
                                        </td>
                                        <td align="left" style="text-align: left;">
                                            <asp:DropDownList ID="ddlOfficess" runat="server" DataSourceID="SqlDSOfficess"
                                                DataTextField="Name" DataValueField="ID" 
                                                SkinID="SmallTextCombo" Width="150px">
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlDSOfficess" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                SelectCommand="Groups_GetGroupsbyType" 
                                                SelectCommandType="StoredProcedure"
                                                DataSourceMode="DataReader">
                                                <SelectParameters>
                                                    <asp:Parameter ConvertEmptyStringToNull="False" DefaultValue="3" Name="Type" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:CompareValidator ID="CV_Offices" runat="server" ControlToValidate="ddlOfficess"
                                                Display="Dynamic" ErrorMessage="Please Select Offices" Operator="GreaterThan"
                                                SkinID="CompareValidation" Type="Integer" ValueToCompare="0">
                                            </asp:CompareValidator>
                                        </td>
                                        <td align="left" style="text-align: left">
                                        </td>
                                        <td align="left" style="text-align: left;">
                                            Fax:</td>
                                        <td align="left" style="text-align: left;">
                                            <asp:TextBox ID="txtFax" runat="server" MaxLength="50" cssClass="GreyTextBoxNormal"
                                                 Width="150px" >
                                            </asp:TextBox>
                                        </td>
                                        <td align="left" style="width: 25%; text-align: left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 25px;" >
                                        </td>
                                        <td style="text-align: left;" >
                                            Time Zone:<span style="color: #ff0000">*</span>
                                        </td>
                                        <td align="left" style="text-align: left;" >
                                            <asp:DropDownList ID="ddlTimeZone" runat="server" DataSourceID="SQLDS_TimeZone"
                                                DataTextField="Name" DataValueField="ID" 
                                                SkinID="SmallTextCombo" Width="150px">
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SQLDS_TimeZone" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                SelectCommand="TimeZone_GetAll" 
                                                SelectCommandType="StoredProcedure"
                                                DataSourceMode="DataReader">
                                            </asp:SqlDataSource>
                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlTimeZone"
                                                Display="Dynamic" ErrorMessage="Please Select Your Time Zone" Operator="GreaterThan"
                                                SkinID="CompareValidation" Type="Integer" ValueToCompare="0">
                                            </asp:CompareValidator>
                                        </td>
                                        <td align="left" style="text-align: left" >
                                        </td>
                                        <td align="left"  style="white-space:nowrap;">
                                            RFID:&nbsp;</td>
                                        <td align="left" style="text-align: left; white-space:nowrap;" colspan="" rowspan="" >
                                            <asp:TextBox ID="txtRFID" runat="server" MaxLength="12" cssClass="GreyTextBoxNormal" Width="150px" ></asp:TextBox></td>
                                        <td align="left" colspan="1" rowspan="1" style="width: 25%; text-align: left" >
                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <td style="height: 25px;"> </td>
                                        <td style="text-align: left;">Personal Email:</td>
                                        <td align="left" style="text-align: left;">
                                            <asp:TextBox ID="txtPersonalEmail" runat="server" CssClass="GreyTextBoxNormal" MaxLength="50" Width="150px"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4"
                                                    runat="server" ControlToValidate="txtPersonalEmail" Display="Dynamic" ErrorMessage="Please Enter valid email"
                                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                                                </asp:RegularExpressionValidator>
                                                <asp:CompareValidator ID="compareEmail" runat="server" Display="Dynamic" SetFocusOnError="true" Operator="NotEqual" ControlToValidate="txtPersonalEmail" ControlToCompare="txtEmail" ErrorMessage="Netsolace email and personal email must not match">
                                                </asp:CompareValidator>
                                        </td>
                                        <td align="left" style="text-align: left"></td>
                                        <td align="left"  style="white-space:nowrap;">Timimg Profile:</td>
                                        <td align="left" style="text-align: left; white-space:nowrap;" colspan="" rowspan="">
                                            <asp:DropDownList ID="ddlProfiles" runat="server" AppendDataBoundItems="true" SkinID="SmallTextCombo"
                                                Width="150px" DataSourceID="sdsUserOfficeTimingProfiles" DataValueField="ID"
                                                DataTextField="Name">
                                                <asp:ListItem Selected="True" Value="0">Select...</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="sdsUserOfficeTimingProfiles" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                SelectCommand="UserOfficeTimingProfile_GetAllActive" SelectCommandType="StoredProcedure"
                                                DataSourceMode="DataReader"></asp:SqlDataSource>
                                        </td>
                                        <td align="left" colspan="1" rowspan="1" style="width: 25%; text-align: left"></td>
                                    </tr>
                                    
                                     <tr>
                                        <td style="height: 25px;" >
                                        </td>
                                        <td style="text-align: left;" >
                                            Time Exampted:</td>
                                        <td align="left" style="text-align: left;" >
                                            
                                            <asp:CheckBox ID="chkTimeExampted" runat="server" /> 
                                        </td>
                                        <td align="left" style="text-align: left" >
                                        </td>
                                        <td align="left"  style="white-space:nowrap;">
                                            Portal Remote User:
                                        </td>
                                        <td align="left" style="text-align: left; white-space:nowrap;" colspan="" rowspan="" >
                                            <asp:CheckBox ID="chkRemoteUser" runat="server" Checked="true"  AutoPostBack="false" onclick="CheckChanged(this)" /></td> 
                                        <td align="left" colspan="1" rowspan="1" style="width: 25%; text-align: left" >
                                        </td>
                                    </tr>
                                    
                                    <tr id="trIps" style="display:none;">
                                        <td>
                                        </td>
                                        <td></td>
                                        <td>
                                                </td>
                                        <td></td>
                                        <td align="left" style="white-space:nowrap; height: 25px;" colspan="2">
                                          
                                                    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="Table">
                                                        <tr>
                                                            <td rowspan="3" style="width: 38%; white-space: nowrap;">
                                                                <asp:Label ID="lblIP" runat="server" Text="Remote IP:" style="display:none;" ></asp:Label>
                                                                <br />
                                                                <asp:Label ID="lblIP2" runat="server" Text="Remote IP 2:" style="display:none;" ></asp:Label>
                                                            </td>
                                                            <td id="tdtxtIP" runat="server"  colspan="2" rowspan="3" style="width: 62%">
                                                                &nbsp;&nbsp;<asp:TextBox ID="txtIP" runat="server" MaxLength="200" CssClass="GreyTextBoxNormal" style="display:none;" Width="150px"></asp:TextBox>
                                                                &nbsp;&nbsp;<asp:TextBox ID="txtIP2" runat="server" MaxLength="200" CssClass="GreyTextBoxNormal" style="display:none;" Width="150px"></asp:TextBox>
                                                         </td>
                                                        </tr>
                                                        <tr>
                                                        </tr>
                                                        <tr>
                                                        </tr>
                                                        <tr>
                                                            <td rowspan="1" style="width: 38%; white-space: nowrap; ">
                                                            </td>
                                                            <td colspan="2" rowspan="1" style="width: 62%;">
                                                            <asp:CustomValidator 
                                                                    ID="val_chkRemoteUser"
                                                                    ClientValidationFunction="validateip"
                                                                    ErrorMessage="Please Enter IP"
                                                                    runat="server"
                                                                    Display="Dynamic" >                                                                    
                                                              </asp:CustomValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td rowspan="1" style="width: 38%; white-space: nowrap">
                                                            </td>                                                             
                                                            <td colspan="2" rowspan="1" style="width: 62%">
                                                             <asp:RegularExpressionValidator ID="REV_IP" runat="server" ControlToValidate="txtIP" 
                                                                    Display="Dynamic" ErrorMessage="Please Enter Valid IP" ValidationExpression="((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9]))">
                                                              </asp:RegularExpressionValidator>
                                                              <asp:RegularExpressionValidator ID="REV_IP2" runat="server" ControlToValidate="txtIP2" 
                                                                    Display="Dynamic" ErrorMessage="Please Enter Valid IP" ValidationExpression="((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9]))">
                                                              </asp:RegularExpressionValidator>
                                                            </td>
                                                        </tr>
                                                    </table>                                             
                                        </td>
                                        <td align="left" style="height: 25px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 25px;" valign="top" >
                                        </td>
                                        <td style="text-align: left; height: 25px;" valign="top">
                                            Create Email:</td>
                                        <td style="text-align: left; height: 25px;" valign="top">
                                            <asp:CheckBox ID="chkNewEmailAccount" runat="server" />
                                        <td align="left" style="text-align: left; height: 25px;" valign="top" >
                                        </td>
                                        <td align="left"  style="white-space:nowrap; height: 25px;" valign="top">
                                            Off Sarurday Group:
                                            </td>
                                        <td align="left" style="text-align: left; white-space:nowrap; height: 25px;" colspan="" rowspan="" valign="top">
                                            <asp:DropDownList   ID="ddlOffSaturdayGroup" 
                                                                    runat="server" 
                                                                    SkinID="SmallTextCombo" 
                                                                    Width="150px">
                                                <asp:ListItem Enabled="true" Value="0">Select...</asp:ListItem>
                                                <asp:ListItem Enabled="true" Value="1">Group A</asp:ListItem>
                                                <asp:ListItem Enabled="true" Value="2">Group B</asp:ListItem>    
                                                </asp:DropDownList>
                                            </td>
                                        <td align="left" colspan="1" rowspan="1" style="width: 25%; text-align: left; height: 25px;" valign="top" >
                                            
                                        </td>
                                    </tr>
                                    <tr style="display:none;">
                                        <td style="height: 10px;" valign="top" >
                                        </td>
                                        <td style="text-align: left; height: 10px;" valign="top">
                                            Change Password Access:</td>
                                        <td style="text-align: left; height: 10px;" valign="top">
                                            <asp:CheckBox ID="chkAllowChangePassword" runat="server" /></td>
                                        <td align="left" style="text-align: left; height: 10px;" valign="top" >
                                        </td>
                                        <td align="left"  style="white-space:nowrap; height: 10px;" valign="top">
                                            
                                        </td>
                                        <td align="left" style="text-align: left; white-space:nowrap; height: 25px;" colspan="" rowspan="" valign="top">
                                            
                                        </td> 
                                        <td align="left" colspan="1" rowspan="1" style="width: 25%; text-align: left; height: 25px;" valign="top" >
                                        </td>
                                    </tr>
                                 <tr>
                                        <td style="height: 10px;" valign="top" >
                                        </td>
                                        <td style="text-align: left; height: 10px;" valign="top">
                                            Is Email Working:</td>
                                        <td style="text-align: left; height: 10px;" valign="top">
                                            <asp:CheckBox ID="chkIsEmailWorking" runat="server" /></td>
                                        <td align="left" style="text-align: left; height: 10px;" valign="top" >
                                        </td>
                                        <td align="left"  style="white-space:nowrap; height: 10px;" valign="top">
                                            
                                        </td>
                                        <td align="left" style="text-align: left; white-space:nowrap; height: 25px;" colspan="" rowspan="" valign="top">
                                            
                                        </td> 
                                        <td align="left" colspan="1" rowspan="1" style="width: 25%; text-align: left; height: 25px;" valign="top" >
                                        </td>

                                    </tr>
                            <tr>
                                        <td align="center" colspan="7">
                                            Fields marked with an asterisk 
                                            <span class="RequiredField" style="color: #000000">
                                                <span style="color: #ff0000">*</span>
                                            </span> are required.
                                        </td>
                                    </tr>                                                                           
                         </table>
                      </div>                                                        
                    </td>
                  </tr>
                  <tr style="background-color:#dcdcdc;">               
                    <td align="center"  style="height:31px; border-top:1px solid #609BD3; vertical-align:middle;">
                        <asp:Button ID="btnSave"  OnClientClick="DisableCancelButton();"  
                            runat="server" 
                             Text="Save" 
                            CssClass="btnSimple" 
                            Width="80px" 
                            CommandName="Insert" />&nbsp;&nbsp;
                      <input type="button" 
                              id="btnCancel" 
                              value="Cancel" 
                              class="btnSimple"                                           
                              onclick="javascript:window.location='Users.aspx';" />
                   </td>
              </tr>                              
         </table>       
    </div>
    </form>
    <script language="javascript" type="text/javascript">        
        function DisableCancelButton()
        {
            if ($get('<%= chkNewEmailAccount.ClientID %>').checked == true )
            {
                document.getElementById('btnCancel').disabled= 'disabled';    
            }
            else
            {
                document.getElementById('btnCancel').disabled= '';
            }
        }
        function EnableCancelButton()
        {
            document.getElementById('btnCancel').disabled= '';
        }
  /////////////////////////////Down Remote Users////////////////////////////////////////
  function validateip(oSrc, args){
            if ($get('<%= ChkRemoteUser.ClientID %>').checked == false )
            {      
                if (document.getElementById('<%=txtIP.ClientID%>').value == "")
                {               
                args.IsValid = false                
                }
                else 
                {
                args.IsValid = true
                }
            }
            else 
            {
             args.IsValid = true
            }            
        }
        
        function CheckChanged(chk){
               
            if (chk.checked == false)           
            {
                document.getElementById('trIps').style.display='inline';
                document.getElementById('<%=lblIP.ClientID%>').style.display = 'inline';
                document.getElementById('<%=lblIP2.ClientID%>').style.display = 'inline';
                document.getElementById('<%=txtIP.ClientID%>').style.display = 'inline';              
                document.getElementById('<%=txtIP2.ClientID%>').style.display = 'inline';              
            }
            else
            {                 
                document.getElementById('trIps').style.display='none';
                document.getElementById('<%=lblIP.ClientID%>').style.display = 'none';
                document.getElementById('<%=lblIP2.ClientID%>').style.display = 'none';
                document.getElementById('<%=txtIP.ClientID%>').style.display = 'none';
                document.getElementById('<%=txtIP2.ClientID%>').style.display = 'none';
                document.getElementById('<%=val_chkRemoteUser.ClientID%>').style.display = 'none';
                document.getElementById('<%=REV_IP.ClientID%>').style.display = 'none';
                document.getElementById('<%=REV_IP2.ClientID%>').style.display = 'none';
            }
                      
         }        
   /////////////////////////////UP Remote Users////////////////////////////////////////
    </script>  
                                        
</body> 
</html>