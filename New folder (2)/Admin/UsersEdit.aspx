<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UsersEdit.aspx.vb" Inherits="Admin_UsersEdit" Theme="Default"  %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
</head>
<body style ="margin :0px;background-color:#F2F2F2;  height:100%;width:100%; overflow:auto;">
    <form id="form1" runat="server">
    <asp:HiddenField ID="hdnStatus" runat="server" /> 
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
        <asp:HiddenField ID="UserID" runat="server" />
        <asp:HiddenField ID="hdnOffSaturdayGroupType" runat="server" />             
    <table style="height:100%;width:100%; background-color:#F2F2F2;" cellpadding="0" cellspacing="0">
        <tr id="trInactiveHold" runat="server" visible="false" style="padding: 2 3 0 3 px;">
                <td  align="center" colspan="2" style="vertical-align:top;height:30px;">
                    <table class="tdInActive" cellpadding="0" cellspacing="0" border="0" style="width:100%;">
                        <tr>
                            <td align="left">
                                &nbsp;<asp:Image ID="Image2" runat="server" ImageUrl="~/images/icon_alert_red.gif" style="padding-left:2px;" ImageAlign="AbsMiddle" />&nbsp;
                                <span id="spInactiveHold" style="font-weight:bold;">INACTIVE</span>
                                
                            </td>
                            <td valign="middle" align="right" style="padding-right:2px; vertical-align:middle; color:Black;">
                                <span>InActivated By:</span>
                                <span title='<%= lblStatusChangedBy.Text %>'><asp:Label ID="lblStatusChangedBy" runat="server"></asp:Label></span>
                                <span>on <asp:Label ID="lblStatusChangedDate" runat="server"></asp:Label></span>
                                <span><input type="button" class="btnSimple" style="width:80px;" value="Why InActive?" onClick="ShowWhyInActive();" id="Button2" /></span>
                            </td>
                        </tr>
                    </table>
                </td>
        </tr> 
        <tr style="padding:3px; height:100%;">
            <td valign="top" >
                <table  cellspacing="0"  style="background-color:#F2F2F2;height:100%;padding-left: 1em; height:100%; width: 100%;vertical-align:top; border:1px solid #609BD3;">
                       <tr class="GalleryTitle" style="background-image:url('../images/bg_mainHdr_1.jpg');height:31px; width:100%;">
                         <td style="height:31px;background-color:#A0CDEE;font-size:12px;padding:5px" align="left">
                               <span style="font-weight:bold;">Edit User</span>
                        </td>
                          <td valign="middle" align="right" style="background-color:#BDE4B8; vertical-align:middle; cursor:pointer;">
                          
                              <div id="divActions" style="padding: 2 5 3 5; float:right; text-align:right;">
                                   <div id="btnActions" class="GradientOffwhiteButtonSmall"  onclick="onOptionsClick();" onMouseOut="onOptionsOut();">Actions&nbsp;
                                        <img id="imgArrow" src="../images/arrow_down.gif" style="vertical-align:middle;" alt=""/>
                                   </div>
                              </div>
                          </td>
                     </tr>          
                     
                      <tr>
                        <td align="left" colspan="4" style="background-color:#F2F2F2;border:0px;">
                            <div style="overflow:auto; height:100%;border:0px;" class="GrayScrollBar" id="Div1">
                                    <table border="0" cellpadding="0" cellspacing="0" class="Table" style="border:0px;padding-left: 1em; width: 100%; height: 100% ; vertical-align:top;" >
                                        <tr>
                                            <td style="height: 3px; padding-left:25px; width:50px;">
                                               </td>
                                            <td style="height: 3px; width: 150px;">
                                            </td>
                                            <td style="height: 3px; width: 150px;">
                                            </td>
                                            <td style="height: 3px; width: 150px;">
                                            </td>
                                            <td style="height: 3px; width: 150px;">
                                                </td>
                                            <td style="height: 3px; padding-left:25px; width:50px;">
                                               </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 25px; text-align: left">
                                            </td>
                                            <td style="text-align: left; height: 25px;" >
                                                First Name:<span class="RequiredField" style="font-size: 9pt; color: #000000"><span
                                                    style="font-size: 8pt; color: #ff0000">*</span> </span>
                                            </td>
                                            <td style="text-align: left; height: 25px; width: 213px;">
                                                <asp:TextBox ID="txtFirstName" runat="server" 
                                                    MaxLength="200" CssClass="GreyTextBoxNormal"
                                                    Width="150px">
                                                </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RFV_FirstName" 
                                                    runat="server" ControlToValidate="txtFirstName"
                                                    Display="Dynamic" ErrorMessage="Please Enter First Name" 
                                                    SkinID="RequiredFieldValidation"></asp:RequiredFieldValidator>
                                               <span style="font-size: 8pt; color: #ff0000"></span>
                                            </td>
                                            <td style=" text-align: left; height: 25px; width: 94px;" ><span class="RequiredField" style="font-size: 9pt; color: #ff0000"></span>
                                                Middle Name:
                                            </td>
                                            <td style="height: 25px; text-align: left;" >
                                                <span style="font-size: 8pt; color: #ff0000"> 
                                                <asp:TextBox ID="txtMiddleName" runat="server" CssClass="GreyTextBoxNormal" 
                                                    MaxLength="50"
                                                     Width="150px">
                                                </asp:TextBox>
                                                </span><span style="font-size: 7pt"></span>
                                           </td>
                                            <td style="height: 25px; text-align: left">
                                                </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 25px; text-align: left">
                                            </td>
                                            <td style="text-align: left; height: 25px;">
                                                <span> 
                                                Last Name:<span class="RequiredField" style="color: #000000"><span style="color: #ff0000">*</span></span>
                                            </span>
                                            </td>
                                            <td style="text-align: left; height: 25px; width: 213px;">
                                                <span style="font-size: 8pt; color: #ff0000"> 
                                                <asp:TextBox ID="txtLastName" runat="server" 
                                                    MaxLength="200" CssClass="GreyTextBoxNormal"
                                                    Width="150px">
                                                </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RFV_LastName" runat="server" 
                                                    ControlToValidate="txtLastName"
                                                    Display="Dynamic" 
                                                    ErrorMessage="Please Enter Last Name" 
                                                    SkinID="RequiredFieldValidation"></asp:RequiredFieldValidator>
                                              </span>
                                            </td>
                                            <td style=" text-align: left; height: 25px; width: 94px;">
                                                User &nbsp;Name:<span style="color: #000000"><span style="color: #ff0000">*</span></span>
                                            </td>
                                            <td style="height: 25px; text-align: left;" valign="bottom">
                                                <asp:TextBox ID="txtUserName" runat="server" MaxLength="200" CssClass="GreyTextBoxNormal"
                                                     Width="150px" >
                                                </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RFV_txtUserName" 
                                                    runat="server" ControlToValidate="txtUserName"
                                                    Display="Dynamic" ErrorMessage="<br />Please Enter User Name" 
                                                    SkinID="RequiredFieldValidation">
                                                </asp:RequiredFieldValidator><br />
                                                <asp:Label ID="lblErrorMessage" runat="server" CssClass="ErrorMessage" ForeColor="Red"></asp:Label>
                                            </td>
                                            <td style="height: 25px; text-align: left">
                                            </td>
                                        </tr>
                                        <tr style="font-size: 9pt">
                                            <td style="height: 25px; text-align: left">
                                            </td>
                                            <td style="text-align: left; height: 25px;"><span class="RequiredField" style="color: #000000"><span style="color: #ff0000"></span>
                                                <span>
                                                Address:<br />
                                                </span><font face="arial, helvetica, sans-serif" size="1">( max.500<br />
                                                    characters. )</font>
                                                </span>
                                            </td>
                                            <td style="text-align: left; height: 25px; width: 213px;">
                                                <asp:TextBox ID="txtAddress" runat="server" CssClass="GreyTextBoxNormal"
                                                    MaxLength="200" 
                                                    Rows="3"  
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
                                            <td style="text-align: left; height: 25px; width: 94px;">
                                                City:</td>
                                            <td style="height: 25px; text-align: left;">
                                                <asp:TextBox ID="txtCity" runat="server" MaxLength="100" CssClass="GreyTextBoxNormal"
                                                     Width="150px" >
                                                </asp:TextBox>
                                           </td>
                                            <td style="height: 25px; text-align: left">
                                            </td>
                                        </tr>
                                        <tr style="font-size: 9pt">
                                            <td style="height: 25px; text-align: left">
                                            </td>
                                            <td style="text-align: left; height: 25px;">
                                                Country:<span class="RequiredField" style="font-size: 9pt; color: #ff0000">*</span>
                                            </td>
                                            <td style="text-align: left; height: 25px; width: 213px;">
                                                <span
                                                        style="font-size: 8pt; color: #ff0000"> 
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
                                                <asp:SqlDataSource ID="SqlDSCountries" 
                                                    runat="server" 
                                                    ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                    SelectCommand="Countries_GetAll" 
                                                    SelectCommandType="StoredProcedure" 
                                                    DataSourceMode="DataReader" >
                                                </asp:SqlDataSource>
                                                <asp:CompareValidator ID="CompareValidator2" runat="server" 
                                                    ControlToValidate="ddlCountry"
                                                    Display="Dynamic" 
                                                    ErrorMessage="Please Select Country" Operator="GreaterThan"
                                                    SkinID="CompareValidation" 
                                                    Type="Integer" 
                                                    ValueToCompare="0"></asp:CompareValidator></span></td>
                                            <td style=" text-align: left; height: 25px; width: 94px;"> 
                                            State:
                                            <span class="RequiredField" style="color: #ff0000">*</span>
                                            </td>
                                            <td style="height: 25px; text-align: left;" valign="bottom">
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
                                                    <asp:SqlDataSource
                                                        ID="SqlDSStates" 
                                                        runat="server" 
                                                        ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                        SelectCommand="States_GetByCountryID" 
                                                        SelectCommandType="StoredProcedure" 
                                                        DataSourceMode="DataReader" >
                                                        <SelectParameters>
                                                            <asp:ControlParameter ControlID="ddlCountry" DefaultValue="1" Name="CountryID" PropertyName="SelectedValue"
                                                                Type="Int32" />
                                                        </SelectParameters>                                               
                                                    </asp:SqlDataSource>
                                                         &nbsp;
                                                 </ContentTemplate>
                                                 <Triggers>
                                                     <asp:AsyncPostBackTrigger ControlID="ddlCountry" EventName="SelectedIndexChanged" />                                                     
                                                 </Triggers>
                                              </asp:UpdatePanel>                                                
                                                    <asp:CompareValidator ID="CV2_States" runat="server" ControlToValidate="ddlStates"
                                                         Display="Dynamic" ErrorMessage="Please Select State" 
                                                         Operator="GreaterThan"
                                                         SkinID="CompareValidation" Type="Integer" 
                                                         ValueToCompare="0"></asp:CompareValidator></td>
                                            <td style="height: 25px; text-align: left">
                                            </td>
                                        </tr>
                                        <tr style="font-size: 9pt">
                                            <td style="height: 25px; text-align: left">
                                            </td>
                                            <td style="text-align: left; height: 25px;">
                                                <span class="RequiredField" style="color: #000000"><span style="font-size: 8pt;
                                                    color: #ff0000">
                                                </span>
                                                <span>
                                                Zip:<span style="color: #ff0000"></span></span>
                                                </span>
                                            </td>
                                            <td style="text-align: left; height: 25px; width: 213px;">
                                                <asp:TextBox ID="txtZip" runat="server" 
                                                    MaxLength="50" CssClass="GreyTextBoxNormal"
                                                     Width="150px">
                                                </asp:TextBox>
                                                <asp:RegularExpressionValidator ID="REV_txtZip" runat="server" 
                                                    ControlToValidate="txtZip"
                                                    Display="Dynamic" 
                                                    ErrorMessage="Please Enter Valid Zip Code" 
                                                    ValidationExpression="\d{5}(-\d{4})?"></asp:RegularExpressionValidator>
                                            </td>
                                            <td style="text-align: left; height: 25px; width: 94px;">
                                                Gender:<span style="color: #ff0000">*</span>
                                            </td>
                                            <td style="height: 25px; text-align: left;">
                                                <asp:RadioButtonList ID="rbtlstGender" runat="server" CellPadding="0" Height="20px"
                                                    RepeatDirection="Horizontal" SkinID="SmallTextRadioButton"  >
                                                    <asp:ListItem Value="False" Selected="True">&lt;span style=&quot;font-size:12px;&quot; &gt;Male&lt;/span&gt;</asp:ListItem>
                                                    <asp:ListItem Value="True">&lt;span style=&quot;font-size:12px;&quot;&gt;Female&lt;/span&gt;</asp:ListItem>
                                                </asp:RadioButtonList></td>
                                            <td style="height: 25px; text-align: left">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 25px; text-align: left">
                                            </td>
                                            <td style="text-align: left; height: 25px;">
                                                <span>DOB:<span style="font-size: 9pt;
                                                    color: #ff0000">*</span>&nbsp;</span></td>
                                            <td style="text-align: left; height: 25px; width: 213px;">
                                                 <asp:TextBox ID="txtDOB" runat="server" MaxLength="10" 
                                                 CssClass="GreyTextBoxNormal"  onfocus="imgDOBCalander.click();"
                                                 Width="123px" >
                                                </asp:TextBox>
                                                <img id="imgDOBCalander" src="../images/ico_calendar.jpg" border="0" align="absmiddle" onMouseOver="style.cursor='hand';" onClick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtDOB.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');" />
                                                <asp:RequiredFieldValidator ID="RFV_DOB" runat="server" 
                                                    ControlToValidate="txtDOB"
                                                    Display="Dynamic" 
                                                    ErrorMessage="Please Enter/Select DOB" 
                                                    SkinID="RequiredFieldValidation"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="REV_DOB" runat="server" 
                                                    ControlToValidate="txtDOB"
                                                    Display="Dynamic" 
                                                    ErrorMessage="Date is not in Correct Format" 
                                                    ValidationExpression="^\d{1,2}\/\d{1,2}\/\d{2,4}$"></asp:RegularExpressionValidator>
                                             </td>
                                            <td style="text-align: left; height: 25px; width: 94px;">
                                                Work Phone:<span style="color: #ff0000">*</span></td>
                                            <td style="height: 25px; text-align: left;">
                                                <asp:TextBox ID="txtWorkPhone" runat="server" MaxLength="50" 
                                                    CssClass="GreyTextBoxNormal"
                                                    Width="150px">
                                                </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RFV_WorkPhone" runat="server" 
                                                    ControlToValidate="txtWorkPhone"
                                                    Display="Dynamic" ErrorMessage="Please Enter Work Phone" 
                                                    SkinID="RequiredFieldValidation"></asp:RequiredFieldValidator>
                                            </td>
                                            <td style="height: 25px; text-align: left">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 25px; text-align: left">
                                            </td>
                                            <td style="text-align: left; height: 25px;">
                                                Hiring Date:<span style="color: #ff0000">*</span>&nbsp;
                                            </td>
                                            <td style="text-align: left; height: 25px; width: 213px;">
                                                <asp:TextBox ID="txtHiringDate" runat="server" 
                                                    MaxLength="10" CssClass="GreyTextBoxNormal"
                                                    onfocus="imgHDCalander.click();"
                                                     Width="123px">
                                                </asp:TextBox>
                                                <img id="imgHDCalander" src="../images/ico_calendar.jpg" border="0" align="absmiddle" onMouseOver="style.cursor='hand';" onClick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtHiringDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"  /> 
                                                <asp:RequiredFieldValidator ID="RFV_HiringDate" 
                                                    runat="server" ControlToValidate="txtHiringDate"
                                                    Display="Dynamic" 
                                                    ErrorMessage="Please Enter/Select Hiring Date" 
                                                    SkinID="RequiredFieldValidation"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" 
                                                    runat="server" ControlToValidate="txtHiringDate"
                                                    Display="Dynamic" ErrorMessage="Date is not in Correct Format" 
                                                    ValidationExpression="^\d{1,2}\/\d{1,2}\/\d{2,4}$"></asp:RegularExpressionValidator>
                                             </td>
                                            <td style="text-align: left; height: 25px; width: 94px;">
                                                Home Phone:
                                            </td>
                                            <td style="height: 25px; text-align: left;">
                                                <asp:TextBox ID="txtHomePhone" runat="server" 
                                                    MaxLength="50" CssClass="GreyTextBoxNormal"
                                                    Width="150px">
                                               </asp:TextBox>
                                           </td>
                                            <td style="height: 25px; text-align: left">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 25px; text-align: left">
                                            </td>
                                            <td style="text-align: left; height: 25px;">
                                                SSN/NIC:<span style="color: #ff0000">*</span>
                                            </td>
                                            <td style="text-align: left; height: 25px; width: 213px;">
                                                <asp:TextBox ID="txtSSN" runat="server" 
                                                    MaxLength="15" CssClass="GreyTextBoxNormal"
                                                     Width="150px">
                                                </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" 
                                                    runat="server" ControlToValidate="txtSSN"
                                                    Display="Dynamic" 
                                                    ErrorMessage="Please Enter SSN/NIC" 
                                                    SkinID="RequiredFieldValidation">
                                               </asp:RequiredFieldValidator>                                                
                                            </td>
                                            <td style="text-align: left; height: 25px; width: 94px;">
                                                Cell Phone:</td>
                                            <td style="height: 25px; text-align: left;">
                                                <asp:TextBox ID="txtCellPhone" runat="server" MaxLength="50" CssClass="GreyTextBoxNormal"
                                                     Width="150px">
                                                </asp:TextBox>
                                            </td>
                                            <td style="height: 25px; text-align: left">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 25px; text-align: left">
                                            </td>
                                            <td style="text-align: left; height: 25px;">
                                                Job Tilte:
                                            </td>
                                            <td style="text-align: left; height: 25px; width: 213px;">
                                                <asp:TextBox ID="txtJobtitle" runat="server" 
                                                    MaxLength="200" CssClass="GreyTextBoxNormal"
                                                     Width="150px" >
                                                </asp:TextBox>
                                            </td>
                                            <td style="text-align: left; height: 25px; width: 94px;">
                                                Work Email:<span style="color: #ff0000">*</span>
                                            </td>
                                            <td style="height: 25px; text-align: left;">
                                                <asp:TextBox ID="txtEmail" runat="server" MaxLength="200" CssClass="GreyTextBoxNormal"
                                                     Width="150px" >
                                               </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" 
                                                    runat="server" ControlToValidate="txtEmail"
                                                    Display="Dynamic" 
                                                    ErrorMessage="Please Enter Email" 
                                                    SkinID="RequiredFieldValidation">
                                               </asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" 
                                                    runat="server" ControlToValidate="txtEmail"
                                                    Display="Dynamic" 
                                                    ErrorMessage=">Please Enter valid Email" 
                                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                                               </asp:RegularExpressionValidator>
                                          </td>                                        
                                            <td style="height: 25px; text-align: left">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 25px; text-align: left">
                                            </td>
                                            <td style="text-align: left; height: 25px;">
                                                Department:<span style="color: #ff0000">*</span></td>
                                            <td align="left" style="text-align: left; height: 25px; width: 213px;">
                                                <asp:DropDownList ID="ddlDeparments" runat="server"
                                                    AutoPostBack="false" DataSourceID="SqlDSDepartments"
                                                    DataTextField="Name" DataValueField="ID" 
                                                    CssClass="GreyTextBoxNormal" Width="150px">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="SqlDSDepartments" 
                                                    runat="server" 
                                                    ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                    SelectCommand="Groups_GetGroupsbyType" 
                                                    SelectCommandType="StoredProcedure"
                                                    DataSourceMode="DataReader" >
                                                    <SelectParameters>
                                                        <asp:Parameter ConvertEmptyStringToNull="False" DefaultValue="1" Name="Type" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                                <asp:CompareValidator ID="CV_Department" runat="server" 
                                                    ControlToValidate="ddlDeparments"
                                                    Display="Dynamic" 
                                                    ErrorMessage="Please Select Department" 
                                                    Operator="GreaterThan"
                                                    SkinID="CompareValidation" Type="Integer" ValueToCompare="0"></asp:CompareValidator></td>
                                            <td align="left" style="text-align: left; height: 25px; width: 94px;">
                                                Team:<span style="color: #ff0000">*</span>
                                           </td>
                                            <td align="left" style="height: 25px; text-align: left;">
                                                <asp:DropDownList ID="ddlTeams" runat="server" DataSourceID="SqlDSTeams"
                                                    DataTextField="Name" DataValueField="ID" 
                                                    SkinID="SmallTextCombo" Width="150px">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="SqlDSTeams" 
                                                    runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                    SelectCommand="Groups_GetGroupsbyType" 
                                                    SelectCommandType="StoredProcedure"
                                                    DataSourceMode="DataReader" >
                                                    <SelectParameters>
                                                        <asp:Parameter ConvertEmptyStringToNull="False" DefaultValue="2" Name="Type" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                                <asp:CompareValidator ID="CV_Teams" runat="server" 
                                                    ControlToValidate="ddlTeams" Display="Dynamic"
                                                    ErrorMessage="Please Select Teams" 
                                                    Operator="GreaterThan" SkinID="CompareValidation"
                                                    Type="Integer" ValueToCompare="0">
                                               </asp:CompareValidator></td>
                                            <td align="left" style="height: 25px; text-align: left">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 25px; text-align: left">
                                            </td>
                                            <td style="text-align: left; height: 25px;">
                                            <span style="color: #ff0000"></span>Office:
                                            <span style="color: #ff0000">*</span></td>
                                            <td align="left" style="text-align: left; height: 25px; width: 213px;">
                                                <asp:DropDownList ID="ddlOfficess" 
                                                    runat="server" 
                                                    DataSourceID="SqlDSOfficess"
                                                    DataTextField="Name" DataValueField="ID" 
                                                    SkinID="SmallTextCombo" Width="150px">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="SqlDSOfficess" 
                                                    runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                    SelectCommand="Groups_GetGroupsbyType" 
                                                    SelectCommandType="StoredProcedure"
                                                    DataSourceMode="DataReader">
                                                    <SelectParameters>
                                                        <asp:Parameter ConvertEmptyStringToNull="False" DefaultValue="3" Name="Type" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                                <asp:CompareValidator ID="CV_Offices" runat="server" ControlToValidate="ddlOfficess"
                                                    Display="Dynamic" 
                                                    ErrorMessage="Please Select Offices" 
                                                    Operator="GreaterThan"
                                                    SkinID="CompareValidation" 
                                                    Type="Integer" 
                                                    ValueToCompare="0">
                                               </asp:CompareValidator>
                                            </td>
                                            <td align="left" style="text-align: left; height: 25px; width: 94px;">
                                                Fax:
                                            </td>
                                            <td align="left" style="height: 25px; text-align: left;">
                                                <asp:TextBox ID="txtFax" runat="server" MaxLength="50" CssClass="GreyTextBoxNormal"
                                                     Width="150px" >
                                                </asp:TextBox>
                                            </td>
                                            <td align="left" style="height: 25px; text-align: left">
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
                                        
                                        <td align="left"  style="white-space:nowrap;">
                                            RFID:&nbsp;</td>
                                        <td align="left" style="text-align: left; white-space:nowrap;" colspan="" rowspan="" >
                                            <asp:TextBox ID="txtRFID" runat="server" MaxLength="13" cssClass="GreyTextBoxNormal" Width="150px" ></asp:TextBox></td>
                                        <td align="left" colspan="1" rowspan="1" style="text-align: left" >
                                        </td>
                                    </tr>
                                     <tr>
                                            <td style="height: 25px; text-align: left">
                                            </td>
                                            <td style="text-align: left; height: 25px;">
                                                Netsolace Email:
                                            </td>
                                            <td style="text-align: left; height: 25px; width: 213px;">
                                                <asp:Label ID="lblEmailAddress" runat="server" Width="150px" style="color:Blue;"></asp:Label> 
                                            </td>
                                            <td style="text-align: left; height: 25px; width: 94px;">
                                            Personal Email:</td>
                                            <td style="height: 25px; text-align: left;">
                                                <asp:TextBox ID="txtPersonalEmail" runat="server" CssClass="GreyTextBoxNormal" MaxLength="50" Width="150px"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4"
                                                    runat="server" ControlToValidate="txtPersonalEmail" Display="Dynamic" ErrorMessage="Please Enter valid email"
                                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                                                </asp:RegularExpressionValidator>
                                                <asp:CompareValidator ID="compareEmail" runat="server" Display="Dynamic" SetFocusOnError="true" Operator="NotEqual" ControlToValidate="txtPersonalEmail" ControlToCompare="txtEmail" ErrorMessage="Netsolace email and personal email must not match">
                                                </asp:CompareValidator>
                                            </td>
                                            <td style="height: 25px; text-align: left">
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <td style="height: 28px;">
                                            </td>
                                            <td style="text-align: left; height: 28px;">
                                                Timimg Profile:
                                            </td>
                                            <td align="left" style="text-align: left; height: 28px;">
                                                <asp:DropDownList   id="ddlProfiles" 
                                                                    runat="server" 
                                                                    AppendDataBoundItems="true"
                                                                    SkinID="SmallTextCombo" 
                                                                    Width="150px" 
                                                                    DataSourceID="sdsUserOfficeTimingProfiles"
                                                                    DataValueField="ID" 
                                                                    DataTextField="Name">
                                                    <asp:ListItem Selected="True" Value="0">Select...</asp:ListItem> 
                                                </asp:DropDownList>
                                                <asp:SqlDataSource  ID="sdsUserOfficeTimingProfiles" 
                                                                    runat="server" 
                                                                    ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                    SelectCommand="UserOfficeTimingProfile_GetAllActive" 
                                                                    SelectCommandType="StoredProcedure" 
                                                                    DataSourceMode="DataReader">
                                                </asp:SqlDataSource>
                                                <%--<asp:RequiredFieldValidator ID="rfvDDLProfiles" 
                                                                            runat="server" 
                                                                            ErrorMessage="Select Timing Profile." 
                                                                            ControlToValidate="ddlProfiles" 
                                                                            Display="Dynamic"  
                                                                            InitialValue="0"
                                                                            SkinID="RequiredFieldValidation">
                                                </asp:RequiredFieldValidator> --%>
                                            </td>
                                            <td align="left" style="white-space: nowrap; height: 28px;">
                                                Off Sarurday Group:
                                            </td>
                                            <td align="left" style="text-align: left; white-space: nowrap; height: 28px;" colspan=""
                                                rowspan="">
                                                <asp:DropDownList   ID="ddlOffSaturdayGroup" 
                                                                    runat="server" 
                                                                    SkinID="SmallTextCombo" 
                                                                    Width="150px">
                                                <asp:ListItem Enabled="true" Value="0">Select...</asp:ListItem>
                                                <asp:ListItem Enabled="true" Value="1">Group A</asp:ListItem>
                                                <asp:ListItem Enabled="true" Value="2">Group B</asp:ListItem>    
                                                </asp:DropDownList>
                                            </td>
                                            <td align="left" colspan="1" rowspan="1" style="text-align: left; height: 28px;">
                                            </td>
                                        </tr>
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        <tr style="height:1px;">
                                            <td align="left">
                                            
                                            </td>
                                            <td align="left">
                                            
                                            </td>
                                            <td align="left" colspan="4">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Select Timing Profile."
                                                    ControlToValidate="ddlProfiles" Display="Dynamic" Enabled="false"  InitialValue="0" SkinID="RequiredFieldValidation">
                                                </asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        
                                        
                                        
                                        
                                    <tr>
                                        <td style="height: 28px;">
                                        </td>
                                        <td style="text-align: left; height: 28px;" >
                                            Portal Remote User:</td>
                                        <td align="left" style="text-align: left; height: 28px;" >
                                            <asp:CheckBox ID="chkRemoteUser" runat="server" Checked="true"  AutoPostBack="false" onclick="CheckChanged(this)" />
                                        </td>
                                        <td align="left"  style="white-space:nowrap; height: 28px;">
                                            <asp:Literal id="ltrlChangePasswordCaption" runat="server" Text="Change Password Access:" Visible="false"></asp:Literal>
                                        </td>
                                        <td align="left"  style="text-align: left; white-space:nowrap; height: 28px;" colspan="" rowspan="" >
                                        <span id="spnChangePassword" runat="server" style="display:none;">
                                            <asp:CheckBox ID="chkChangePasswordAccess" runat="server" />
                                        </span>
                                            
                                            </td> 
                                        <td align="left" colspan="1" rowspan="1" style="text-align: left; height: 28px;" >
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
                                    <tr id="trIps" style="display:none;" runat="server">
                                        <td style="height: 25px;">
                                        </td>
                                        <td style="height: 25px; white-space: nowrap;">
                                            
                                        </td>
                                        <td align="left" style="height: 25px; white-space: nowrap;">
                                        <table style="width: 100%" cellpadding="0" cellspacing="0" class="Table">
                                                        <tr>
                                                            <td rowspan="3" style="width: 38%; white-space: nowrap;">
                                                                <asp:Label ID="lblIP" runat="server" Text="Remote IP:"></asp:Label>
                                                                <br />
                                                                <asp:Label ID="lblIP2" runat="server" Text="Remote IP 2:" ></asp:Label>
                                                            </td>
                                                            <td id="tdtxtIP" runat="server"  colspan="2" rowspan="3" style="width: 62%">
                                                                <asp:TextBox ID="txtIP" runat="server" MaxLength="200" CssClass="GreyTextBoxNormal" Width="90px"></asp:TextBox><br />
                                                                <asp:TextBox ID="txtIP2" runat="server" MaxLength="200" CssClass="GreyTextBoxNormal" Width="90px"></asp:TextBox>
                                                         </td>
                                                        </tr>
                                                        <tr>
                                                        </tr>
                                                        <tr>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" rowspan="1">
                                                            <asp:CustomValidator 
                                                                    ID="val_chkRemoteUser"
                                                                    ClientValidationFunction="validateip"
                                                                    ErrorMessage="Please Enter IP"
                                                                    runat="server"
                                                                    Display="Dynamic" >                                                                    
                                                              </asp:CustomValidator></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" rowspan="1">
                                                             <asp:RegularExpressionValidator ID="REV_IP" runat="server" ControlToValidate="txtIP" 
                                                                    Display="Dynamic" ErrorMessage="Please Enter Valid IP" ValidationExpression="((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9]))">
                                                              </asp:RegularExpressionValidator><br />
                                                              <asp:RegularExpressionValidator ID="REV_IP2" runat="server" ControlToValidate="txtIP2" 
                                                                    Display="Dynamic" ErrorMessage="Please Enter Valid IP" ValidationExpression="((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9]))">
                                                              </asp:RegularExpressionValidator>
                                                            </td>
                                                        </tr>
                                                    </table>
                                            </td>
                                        <td align="left" style="white-space:nowrap; height: 25px;" colspan="3">
                                          
                                                                                                        
                                            </td>
                                        </tr>
                                        
                                        
                                        <tr>
                                            <td style="height: 28px;">
                                                
                                            </td>
                                            <td style="height: 28px;">
                                                Time Exampted:
                                                
                                            </td>
                                            <td style="height: 28px;">
                                                <asp:CheckBox ID="chkTimeExampted" runat="server" />  
                                            </td>
                                            <td style="height: 28px;">
                                            
                                            </td>
                                            <td style="height: 28px;">
                                            
                                            </td>
                                            <td style="height: 28px;">
                                            
                                            </td>
                                        </tr>
                                        
                                        
                                       <tr>
                                           <td style="height: 10px">
                                           </td>
                                            <td style="height: 10px">
                                                </td>
                                            <td style="height: 10px; width: 213px;">
                                            </td>
                                            <td style="height: 10px; width: 94px;">
                                                </td>
                                            <td style="height: 10px">
                                            </td>
                                           <td style="height: 10px">
                                           </td>
                                        </tr>
                                          <tr>
                                              <td align="center" colspan="5" style="height: 30px">
                                                Fields marked with an asterisk <span class="RequiredField" style="color: #000000"><span
                                                    style="color: #ff0000">*</span></span> are required.
                                              </td>
                                              <td align="center" colspan="1" style="height: 30px">
                                              </td>
                                        </tr>
                                                                               
                                    </table>
                                  </div>
                        </td>
                      </tr>                                                    
                </table>
            </td>
            <td style="width:230px; vertical-align:top;padding-left:0px;">               
                 <table border="0" cellpadding="0" cellspacing="0" style="padding-left: 0.5em; width: 100%;height:100%; vertical-align:top; border:1px solid #609BD3; " class="Table" >
                     
                     <tr class="GalleryTitle" style="background-image:url('../images/bg_mainHdr_1.jpg');height:31px;">
                         <td  colspan="" style="height:31px;background-color:#A0CDEE;font-size:12px; width:50%;">
                               <div style="font-weight:bold; width:80px; float:left; text-align:center; padding-left:0px; padding-top:5px; padding-left:-5px;">User Access</div>
                              
                         </td>
                         
                     </tr>    
                    <tr>
                      <td style="text-align:left; vertical-align:top; background-color:#F2F2F2;">
                         <div style="overflow:auto; height:100%; display:none; width: 100%;" class="GrayScrollBar" id="DivTree">
                             <asp:TreeView ID="tvAccess" runat="Server" ImageSet="Msdn" NodeIndent="10" > 
                                 <NodeStyle Font-Names="Arial" CssClass="Table" NodeSpacing="1px" VerticalPadding="2px" />
                                 <RootNodeStyle Font-Bold="True"  />
                             </asp:TreeView>
                         </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="height:100%">
                
           </td>
        </tr>
        <tr style="padding:3px; padding-top:0px;">
            <td align="center" colspan="2" style="vertical-align:bottom;height:31px;">
            <table style="height:31px;width:100%; " cellpadding="3px" cellspacing="0" >
                <tr>
                  <td align="center" colspan="2" style="height:31px; background-color:#dcdcdc;font-size:4px;border:1px solid #609BD3; visibility:visible; white-space:nowrap; vertical-align:middle; ">
                        <asp:Button ID="btnSave"  
                             runat="server" 
                             Text="Save" 
                             CssClass="btnSimple" 
                             Width="80px" 
                             CommandName="Insert" />&nbsp;&nbsp;
                      <input type="button" 
                          id="btnCancel" 
                          value="Cancel" 
                          class="btnSimple"                                           
                          onclick="javascript:window.location='Users.aspx?<%= Request.QueryString.ToString() %>';" />
                 </td>
                 </tr> 
             </table>
             </td>
        </tr>      
    </table>    
    </div>
    <asp:Panel ID="pnl1" runat="server" >
    <div id="divUserStatus" style="width:300px; height:400px; position:absolute; display:none;" >
        <table id="tblUserStatus" cellpadding="0" cellspacing="0" border="0" style="width:100%; height:100%;">
            <tr style="height:20px; padding:3px;">
                <th align="left" style="height: 20px">  
                     <label id="lblUserStatus"></label>
                </th>
                <th align="right" style="height: 20px"><span onClick="CloseInActiveUser();" style="cursor:pointer;">X</span></th>
            </tr>
            <tr>
                <td colspan="2" valign="top" style="width:100%; height:100%; padding:5px;">
                     &nbsp;&nbsp;<span class="BoldText" style="">Reason for <label id="lblStatusText"></label></span> <span class="RequiredField">*</span><br />
                     <asp:TextBox ID="txtUserStatus" runat="server" MaxLength="500" TextMode="MultiLine" style="height:320px; width:280px; padding-left:5px; font-family:Calibri; font-size:11pt;"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="rfvUserStatus" runat="server" ValidationGroup="vgUserStatus" ErrorMessage="<br>Reason is required" Display="Dynamic"  ControlToValidate="txtUserStatus"></asp:RequiredFieldValidator>
                     <asp:RegularExpressionValidator ID="valReason" runat="server" SetFocusOnError="true" Display="Dynamic" ValidationExpression="^[^<>]*$" ControlToValidate="txtUserStatus" ErrorMessage="reason is invalid"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr style="height:20px;" valign="top">
                <td colspan="2" align="center" style="padding:5px;">
                    <asp:Button ID="btnUpdateUserStatus" runat="server" Width="80" ValidationGroup="vgUserStatus" CssClass="btnSimple" Text="OK"/>
                    <input type="button" value="Cancel"  class="btnSimple"  style="width:80px;" id="btnCancelCategory" onClick="CloseInActiveUser();">
                </td>
            </tr> 
        </table>
    </div>
    </asp:Panel>
        <asp:Panel ID="pnlOptions" runat="server">
            <div id="dvOptions" style="display: none; right: 5px; top: 25px;" onMouseOver="onOptionsOver();" onMouseOut="onOptionsOut();"
                class="dvOptionsMenu">
                <div style="padding: 0;">
                    <img alt="" src="../images/pixel_navyblue.JPG" width="31%" height="2" /></div>
                <div id="1" class="OptionsMenuItems" onClick="ShowInActiveUser();" onMouseOut="ItemsOut(this);" onMouseOver="ItemsOver(this);">
                    <span id="lnkBtnStatus" runat="server"></span>
                </div>
                <div id="2" class="OptionsMenuItems" onMouseOut="ItemsOut(this);" onMouseOver="ItemsOver(this);">
                    <span id="spnResetPassword" runat="server" onClick="ShowResetPassDiv();">Reset password</span>
                </div>
                <div id="dvCreateAccount" onClick="DisableCancelButton()" class="OptionsMenuItems" onMouseOut="ItemsOut(this);" onMouseOver="ItemsOver(this);" runat="server">
                     <asp:LinkButton ID="lnkBtnCreateAccount" runat="server" style="color:Black; font-family:Calibri;" onmouseout="ItemsOut(this);" onmouseover="ItemsOver(this);"></asp:LinkButton>
                </div>
                <div id="dvWebMailAccess" class="OptionsMenuItems" onMouseOut="ItemsOut(this);" onMouseOver="ItemsOver(this);" runat="server">
                     <asp:LinkButton ID="lnkWebMail" runat="server" style="color:Black; font-family:Calibri;" onmouseout="ItemsOut(this);" onmouseover="ItemsOver(this);"></asp:LinkButton>
                </div>
            </div>
        </asp:Panel> 
  <div id="divMessage" runat="server" style="background-color:#fff; border:solid 1px #000; display:none; position:absolute; color:#fff; height:80px; width:325px; left:25%; top:35%;">
   <table cellpadding="0" cellspacing="0" border="0" style="width:100%; padding: 10 5 5 5; height:80px;" class="MessageUsers">
       <tr valign="top">
            <th style="height:15px;">Info&nbsp;</th>
       </tr>
       <tr valign="top">
            <td style="font-size:12px;" align="center"> 
                &nbsp;&nbsp;<img align="absmiddle" src="../images/icn_info.gif" />&nbsp;&nbsp;&nbsp;Password has been reset successfully!<br />&nbsp;&nbsp;&nbsp; And Email has been sent to you.
            </td>
       </tr>       
    </table>
</div>

  <div id="divMessageMail" runat="server" style="background-color:#fff; border:solid 1px #000; display:none; position:absolute; color:#fff; height:80px; width:325px; left:25%; top:35%;">
   <table cellpadding="0" cellspacing="0" border="0" style="width:100%; padding: 10 5 5 5; height:80px;" class="MessageUsers">
       <tr valign="top">
            <th style="height:15px;">Info&nbsp;</th>
       </tr>
       <tr valign="top">
            <td style="font-size:12px;" align="center"> 
                &nbsp;&nbsp;<img align="absmiddle" src="../images/icn_info.gif" />&nbsp;&nbsp;&nbsp;Password has been reset successfully!
            </td>
       </tr>       
    </table>
</div>

<div id="divWhyInActive" style="background-color:#fff; border:solid 1px #000; display:none; position:absolute; color:#fff; height:150px; width:400px; left:25%; top:35%;">
   <table cellpadding="0" cellspacing="0" border="0" style="width:100%; height:150px;" class="MessageUsers">
       <tr>
            <th colspan="2" style="height:15px;">Reason for InActive <asp:Label ID="lblUserName" runat="server"></asp:Label></th>
       </tr>
       <tr style="height:100%;">
            <td align="left" style="font-size:12px; width:10px;  padding: 15 5 5 5; vertical-align:top;"> 
                <img align="absmiddle" src="../images/icn_info.gif" />
            </td>
            <td align="left" style="text-align:left; vertical-align:top; padding: 10 5 5 5; height:100%; width:100%;">
                    <asp:Literal ID="ltrlReason" runat="server"></asp:Literal> 
            </td>
       </tr>       
       <tr style="padding-bottom:8px;">
            <td colspan="2" align="center"><input type="button" class="btnSimple" style="width:60px;" value="Ok" onClick="HideWhyInActive();"/> </td>
       </tr>
    </table>
</div>

<asp:UpdatePanel ID="upPnlResetPass" runat="server" >
    <ContentTemplate>
      <div id="dvResetPasswrod" style="background-color:#fff; border:solid 1px #000; display:none; position:absolute; color:#fff; height:130px; width:400px; left:25%; top:35%;">
       <table cellpadding="0" cellspacing="0" border="0" style="width:100%; height:130px;" class="MessageUsers">
           <tr>
                <th colspan="2" style="height:15px;">Reset Password</th>
           </tr>
           <tr style="height:100%;">
                <td align="left" style="font-size:12px; width:10px;  padding: 15 10 5 5; vertical-align:top;"> 
                    <img align="absMiddle" src="../images/ico_helpdesktickets.gif" />
                </td>
                <td align="left" style="text-align:left; vertical-align:top; padding: 20 5 5 5; height:100%; width:100%;">
                  <span id="Span1" runat="server">Are you sure you want to reset password for <asp:Label ID="lblUserName2" runat="server" style="color:Blue"></asp:Label>?</span></td>
           </tr>       
           <tr style="padding-bottom:15px;">
                <td colspan="2" align="center">
                <asp:Button ID="btnResetPassword" runat="server" Width="60" Text="Yes" CssClass="btnSimple" />
                <input type="button" class="btnSimple" style="width:60px;" value="No" onClick="HideResetPassDiv();"/> </td>
           </tr>
        </table>
       </div>
    </ContentTemplate>
    <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnResetPassword" EventName="Click" />
    </Triggers>
</asp:UpdatePanel>


    </form>
    <script language="javascript" type="text/javascript">
    /////////////////////////////Down Tree View////////////////////////////////////////////
    function DisableCancelButton()
{
    document.getElementById('btnCancel').disabled= 'disabled';
    document.getElementById("<%=btnSave.ClientID %>").disabled= 'disabled';
}
function EnableCancelButton()
{
    document.getElementById('btnCancel').disabled= '';
    document.getElementById("<%=btnSave.ClientID %>").disabled= '';    
}
     var x = null;
     var y = null;
     function ShowResetPassDiv()
     {
        if (document.getElementById('spnResetPassword').disabled == false)
        {
        document.getElementById('dvResetPasswrod').style.display='inline';
        document.getElementById('<%= ddlStates.ClientID %>').style.display = 'none';
        document.getElementById('<%= ddlCountry.ClientID %>').style.display = 'none';
        document.getElementById('<%= ddlTeams.ClientID %>').style.display = 'none';
        document.getElementById('<%= ddlDeparments.ClientID %>').style.display = 'none';
        }
     }
     function HideResetPassDiv()
     {
        document.getElementById('dvResetPasswrod').style.display='none';
        document.getElementById('<%= ddlStates.ClientID %>').style.display = 'inline';
        document.getElementById('<%= ddlCountry.ClientID %>').style.display = 'inline';
        document.getElementById('<%= ddlTeams.ClientID %>').style.display = 'inline';
        document.getElementById('<%= ddlDeparments.ClientID %>').style.display = 'inline';
     }
    function ShowWhyInActive()
    {
        document.getElementById('divWhyInActive').style.display='inline';
        HideControls();
    } 
    function HideWhyInActive()
    {
        document.getElementById('divWhyInActive').style.display='none';
        ShowControls();
    } 
    var timerID = null;
    function AutoHide(mode)
    {            
         if (mode == "In")
         {
            if (timerID !== null)
            {
                window.clearInterval(timerID);
            }
        }
        else
        {                
            timerID = window.setTimeout('OtherLinks_onClick(null,"hide");',1500);
        }
    }   
     
      var tmr = null;
        function onOptionsOut(){
            var objDv = document.getElementById('dvOptions');
            if (objDv.style.display == 'none') return;
            tmr = setTimeout('OptionsHide()',3000);
        }
        
         function OptionsHide(){
            document.getElementById('dvOptions').style.display='none';
        }
        
        function onOptionsOver(){
            if (tmr !== null) clearInterval(tmr);
        }
        
     function ItemsOut(dv){
            dv.style.color='black';
            dv.style.backgroundColor='';
        }
        
    function ItemsOver(dv){
        dv.style.color='white';
        dv.style.backgroundColor='#36c';
    }
             
         function onOptionsClick(){
            var objDv = document.getElementById('dvOptions');
            if (getElement('btnActions').innerText != 'Active' && getElement('btnActions').innerText != 'InActive'){
                objDv.style.display = (objDv.style.display == '') ?('none') :('')
                document.getElementById('btnActions').focus();
                var y = getRealTop(document.getElementById('btnActions'));        
                var width = document.body.scrollWidth;
                var ID  = document.getElementById('btnActions');
                findPos(ID);
                objDv.style.right = width - x - 70;
                objDv.style.top = y + 18;
           }
        }
     
    function OtherLinks_onClick(img,view){
        // view = "show" | "hide"                
        if (view == ''){
            if (document.getElementById("mnuMore").style.display == 'none'){
                document.getElementById("mnuMore").style.display="";              
            }else{
                document.getElementById("mnuMore").style.display="none";                
            }
        }else{
            if (view == 'show'){
                document.getElementById("mnuMore").style.display="";
            }else{
                document.getElementById("mnuMore").style.display="none";                
            }
        }
     
     }
    
    function ShowmnuMore ()
    {
        var y = getRealTop(document.getElementById('btnActions'));        
        var width = document.body.scrollWidth;
        var ID  = document.getElementById('btnActions');
        findPos(ID);
        mnuMore.style.right = width - x - 90;
        mnuMore.style.top = y + 25;
        mnuMore.style.display='inline';
    }
    
    function ShowInActiveUser(){
        if (document.getElementById('<%= hdnStatus.ClientID %>').value == 'Active')
        {
            lblUserStatus.innerText="Active user";
            lblStatusText.innerText= "Active user";
            divActions.className="ActiveUserColor";
            tblUserStatus.className= "ActiveUserDarkGreen";
            var ID  = document.getElementById('btnActions');
            var width = document.body.scrollWidth;
            findPos(ID);
            divUserStatus.style.right = width - x - 75;
            divUserStatus.style.top = y + 23;
            getElement('btnActions').innerText = 'Active';
            divUserStatus.style.display='inline';
            HideControls();
        }
        else if(document.getElementById('<%= hdnStatus.ClientID %>').value == 'InActive')
        {
            getElement('btnActions').innerText = 'InActive';
            lblUserStatus.innerText="InActive user";
            lblStatusText.innerText= "InActive user";
            divActions.className="InActiveUserColor";
            tblUserStatus.className= "InActiveUserDarkRed";
            var ID  = document.getElementById('btnActions');
            var width = document.body.scrollWidth;
            findPos(ID);
            divUserStatus.style.right = width - x - 75;
            divUserStatus.style.top = y + 23;
            divUserStatus.style.display='inline';
            HideControls();
        }
        
    }

    function findPos(obj)
        {
         var left = !!obj.offsetLeft ? obj.offsetLeft : 0;
         var top = !!obj.offsetTop ? obj.offsetTop : 0;

         while(obj = obj.offsetParent)
         {
          left += !!obj.offsetLeft ? obj.offsetLeft : 0;
          top += !!obj.offsetTop ? obj.offsetTop : 0;
         }
         x = left;
         y = top;
        }
    
    function ShowControls()
    {
            document.getElementById('<%= ddlStates.ClientID %>').style.display = 'inline';
            document.getElementById('<%= ddlTeams.ClientID %>').style.display = 'inline';
            document.getElementById('<%= ddlCountry.ClientID %>').style.display = 'inline';
            document.getElementById('<%= ddlDeparments.ClientID %>').style.display = 'inline';
            document.getElementById('<%= ddlOfficess.ClientID %>').style.display = 'inline';
            document.getElementById('<%= ddlTimeZone.ClientID %>').style.display = 'inline';
    }
    function HideControls()
    {
            document.getElementById('<%= ddlStates.ClientID %>').style.display = 'none';
            document.getElementById('<%= ddlTeams.ClientID %>').style.display = 'none';
            document.getElementById('<%= ddlCountry.ClientID %>').style.display = 'none';
            document.getElementById('<%= ddlDeparments.ClientID %>').style.display = 'none';
            document.getElementById('<%= ddlOfficess.ClientID %>').style.display = 'none';
            document.getElementById('<%= ddlTimeZone.ClientID %>').style.display = 'none';
            document.getElementById('<%= txtUserStatus.ClientID %>').value='';
    }
    function CloseInActiveUser(){
        divActions.className="";
        divUserStatus.style.display='none';
        getElement('btnActions').innerText = 'Actions';
        ShowControls();
    }
    
    function ShowAlertMessage(){
            divMessage.style.display="inline";
            window.setTimeout('HideAlertMessage()', 3000);
            document.getElementById('<%= ddlCountry.ClientID %>').style.display = 'none';
            document.getElementById('<%= ddlStates.ClientID %>').style.display = 'none';
            return false;
        }
    function HideAlertMessage(){
        divMessage.style.display="none";
        document.getElementById('<%= ddlCountry.ClientID %>').style.display = 'inline';
        document.getElementById('<%= ddlStates.ClientID %>').style.display = 'inline';
    }
    
    function ShowAlertMessageMail()
    {
            divMessageMail.style.display="inline";
            window.setTimeout('HideAlertMessageMail()', 3000);
            document.getElementById('<%= ddlCountry.ClientID %>').style.display = 'none';
            document.getElementById('<%= ddlStates.ClientID %>').style.display = 'none';
            return false;        
    }
    function HideAlertMessageMail(){
        divMessageMail.style.display="none";
        document.getElementById('<%= ddlCountry.ClientID %>').style.display = 'inline';
        document.getElementById('<%= ddlStates.ClientID %>').style.display = 'inline';
    }
  
 function OnTreeClick(evt)
  {
 
       var src = window.event != window.undefined ? window.event.srcElement : evt.target;
       var isChkBoxClick = (src.tagName.toLowerCase() == "input" && src.type == "checkbox");
       if(isChkBoxClick)
       {
           var parentTable = GetParentByTagName("table", src);
           var nxtSibling = parentTable.nextSibling;          
           if(nxtSibling && nxtSibling.nodeType == 1)//check if nxt sibling is not null & is an element node
           {
               if(nxtSibling.tagName.toLowerCase() == "div") //if node has children
               {
                   //check or uncheck children at all levels
                   CheckUncheckChildren(parentTable.nextSibling, src.checked);
               }
           }
           //check or uncheck parents at all levels
           
           CheckUncheckParents(src, src.checked);
     }
  }
  function CheckUncheckChildren(childContainer, check)
  {
     var childChkBoxes = childContainer.getElementsByTagName("input");
     var childChkBoxCount = childChkBoxes.length;
     for(var i = 0; i < childChkBoxCount; i++)
     {
       childChkBoxes[i].checked = check;
     }
  }
  function CheckUncheckParents(srcChild, check)
  {
      var parentDiv = GetParentByTagName("div", srcChild);
      var parentNodeTable = parentDiv.previousSibling;
     
      if(parentNodeTable)
       {
           var checkUncheckSwitch;
          
           if(check) //checkbox checked
           {
               var isAllSiblingsChecked = AreAllSiblingsChecked(srcChild);
               if(isAllSiblingsChecked)
                   checkUncheckSwitch = true;
               else   
                   return; //do not need to check parent if any(one or more) child not checked
           }
           else //checkbox unchecked
           {               
               checkUncheckSwitch = false;
           }
          
           var inpElemsInParentTable = parentNodeTable.getElementsByTagName("input");
           if(inpElemsInParentTable.length > 0)
           {
               var parentNodeChkBox = inpElemsInParentTable[0];
               parentNodeChkBox.checked = checkUncheckSwitch;
               //do the same recursively
               CheckUncheckParents(parentNodeChkBox, checkUncheckSwitch);
           }
       }
  }
  function AreAllSiblingsChecked(chkBox)
  {
    var parentDiv = GetParentByTagName("div", chkBox);
    var childCount = parentDiv.childNodes.length;
  
    for(var i=0; i < childCount; i++)
       {
       if(parentDiv.childNodes[i].nodeType == 1) //check if the child node is an element node
       {
           if(parentDiv.childNodes[i].tagName.toLowerCase() == "table")
           {
              var prevChkBox = parentDiv.childNodes[i].getElementsByTagName("input")[0];
             //if any of sibling nodes are not checked, return false
            
             if(!prevChkBox.checked)
             {
                return false;
             }
           }
       }
    }
    return true;
  }
  //utility function to get the container of an element by tagname
  function GetParentByTagName(parentTagName, childElementObj)
  {
     var parent = childElementObj.parentNode;
     while(parent.tagName.toLowerCase() != parentTagName.toLowerCase())
     {
        parent = parent.parentNode;
     }
   return parent;   
  }
  /////////////////////////////UP Tree View////////////////////////////////////////////
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
                document.getElementById('trIps').style.display = 'inline';
                document.getElementById('<%=lblIP.ClientID%>').style.display = 'inline';
                document.getElementById('<%=lblIP2.ClientID%>').style.display = 'inline';
                document.getElementById('<%=txtIP.ClientID%>').style.display = 'inline';
                document.getElementById('<%=txtIP2.ClientID%>').style.display = 'inline';              
            }
            else
            {                 
                document.getElementById('trIps').style.display = 'none';
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
 //////////////////////////////Window load ////////////////////////////////////////
	 window.onload = function() {
 		var DivTree = getElement('DivTree')
 		DivTree.style.display = "inline";
 		HideSpecificNodes();
	 }
    //////////////////////////////Window load ////////////////////////////////////////
	function HideSpecificNodes() {
		var tvAccess = document.getElementById('tvAccess');
		//tvAccess.parentNode.parentNode.style
		//var spancoll = getElementByClassName('HideTreeNode');
		var spancoll = tvAccess.getElementsByTagName('span');
		
		var i = 0;
		for (i = 0; i < spancoll.length; i++) {
			if (spancoll[i].className == 'HideTreeNode') {
				//alert(spancoll[i].parentNode.parentNode.parentNode.innerHTML);
				var tr = spancoll[i].parentNode.parentNode.parentNode;
				tr.style.display = 'none';
			}
		}
		
	}
</script>
</body>
</html>