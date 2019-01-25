<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AddUserOfficeTimingProfiles.aspx.vb"
    Inherits="HR_AddUserOfficeTimingProfiles" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script language="javascript" type="text/javascript">
        function ShowProfiles() {
            window.location = 'ViewAllUserOfficeTimmingProfiles.aspx';
            return false;
        }
    </script>

    <style type="text/css">
        body
        {
            font-family: Calibri;
            font-size: 12px;
        }
        #dvHeader
        {
            height: 35px;
            background-color: #A0CDEE;
            width: 100%;
            vertical-align: middle;
            margin: 0px;
            padding-top: 8px;
            padding-left: 5px;
            border-bottom: solid 1px #689ACF;
        }
        #dvHeader #spnTitle
        {
            float: left;
            font-size: 14px;
            font-weight: bold;
        }
        #dvHeader #spnDate
        {
            float: right;
            font-size: 14px;
            font-weight: bold;
        }
        #divProfileNameSection
        {
            height: 50px;
            background-color: #E0F2DA;
            font-family: Calibri;
            font-size: 16px;
            font-weight: bold;
            width: 100%;
            margin-top: 10px;
            vertical-align: middle;
            margin: 0px;
            padding: 0px;
            border: solid 1px #689ACF;
        }
        #divProfileNameSection span
        {
            font-size: 14px;
            font-weight: bold;
        }
        #divMainFormContainer
        {
            width: 100%;
        }
        #divMainFormContainer #tdMainForm
        {
            width: 670px;
            vertical-align: top;
        }
        table
        {
            width: 100%;
        }
        sup
        {
            font-weight: bold;
            font-size: 10px;
        }
        #divMainForm
        {
            height: 100%;
            vertical-align: top;
        }
        #tdMainForm #divWeekDayTimings
        {
            width: 100%;
            border-bottom: solid 2px #AFCCBA;
            height: 60px;
            padding-top: 30px;
            font-size: 14px;
            font-weight: bold;
        }
        div
        {
            vertical-align: top;
            margin:0px;
            padding:0px;
        }
        .dvShiftTimmings
        {
            padding-top: 15px;
            font-size: 14px;
            vertical-align: middle;
            font-weight: bold;
            height: 50px;
        }
    </style>
    <link href="style.css" type="text/css" rel="Stylesheet" />
</head>
<body style="margin: 0px;">
    <form id="form1" runat="server">
    <asp:HiddenField ID="hdnProfileID" runat="server" />
    <table id="divMainFormContainer" border="0" cellpadding="0" cellspacing="0" class="tblProfile"
        style="height: 100%; padding: 0px;">
        <tr>
            <td style="height: 85px; vertical-align: text-top;">
                <div id="dvHeader">
                    <span id="spnTitle">Office Timming Schedule Profile </span>
                        <span id="spnDate" style="padding-right:5px;"><span style="font-weight:normal;">Today is: &nbsp;</span><asp:Literal ID="lrtlDate" runat="server"></asp:Literal></span>
                </div>
                <div id="divProfileNameSection">
                    <table border="0" cellpadding="0" cellspacing="0" style="height: 100%;">
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td style="width: 670px;">
                                <span style="width:93px;">Profile Name:</span>
                                <span style="color:Red; padding-left:2px; width:5px;">*</span>
                                <span style="padding-left: 5px;">
                                    <asp:TextBox ID="txtProfileName" runat="server" Width="350px" CssClass="TextBoxOnBlue" MaxLength="150"></asp:TextBox>
                                </span>
                                <span style=" padding-left:5px; font-weight:normal; font-family:Calibri; font-size:8px;">
                                    <asp:RequiredFieldValidator ID="rfvTxtProfileName" runat="server"
                                      ControlToValidate="txtProfileName" CssClass="RequiredField" Font-Size="10px"
                                      ErrorMessage="Enter profile name" SetFocusOnError="true">
                                      </asp:RequiredFieldValidator>
                                </span>
                                
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td style="width: 100%;">
                <div style="margin: 0px; width: 100%; height: 100%; overflow-y: auto;">
                    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%;">
                        <td id="tdLeft">
                            &nbsp;
                        </td>
                        <td id="tdMainForm" style="width: 670px;">
                            <div id="divWeekDayTimings">
                                Weekday Timings
                            </div>
                            <div class="dvShiftTimmings">
                                Shift Timings:
                            </div>
                            <div style="color: #2A2F29; font-size: 12px;">
                                <div style="float: left; width: 150px;">
                                    Shift Start Time (HH:MM):<span style="color:Red; padding-left:2px;">*</span></div>
                                <div style="float: left; width: 20px; padding-left: 5px;">
                                    <asp:DropDownList ID="ddlShiftStartHours" runat="server" CssClass="SmallFontInput">
                                        <asp:ListItem Value="24">12 AM</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div style="float: left; width: 6px; padding: 0 2 0 2">
                                    :</div>
                                <div style="float: left; width: 20px;">
                                    <asp:DropDownList ID="ddlShiftStartMinutes" runat="server" CssClass="SmallFontInput">
                                        <asp:ListItem Value="00" Selected="True">00 Minutes</asp:ListItem>
                                        <asp:ListItem Value="10">10 Minutes</asp:ListItem>
                                        <asp:ListItem Value="15">15 Minutes</asp:ListItem>
                                        <asp:ListItem Value="30">30 Minutes</asp:ListItem>
                                        <asp:ListItem Value="45">45 Minutes</asp:ListItem>
                                        <asp:ListItem Value="50">50 Minutes</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div style="float: left; width: 100px;">
                                    &nbsp;</div>
                                <div style="float: left; width: 185px;">
                                    Shift Start Time Relaxation (MM):</div>
                                <div style="float: clear; width: 20px; padding-left: 5px;">
                                    <asp:DropDownList ID="ddlShiftStartRelaxtionMinutes" runat="server" CssClass="SmallFontInput">
                                        <asp:ListItem Value="00" Selected="True">No</asp:ListItem>
                                        <asp:ListItem Value="10">10 Minutes</asp:ListItem>
                                        <asp:ListItem Value="15">15 Minutes</asp:ListItem>
                                        <asp:ListItem Value="30">30 Minutes</asp:ListItem>
                                        <asp:ListItem Value="60">60 Minutes</asp:ListItem>
                                        <asp:ListItem Value="120">2 Hours</asp:ListItem>
                                        <asp:ListItem Value="180">3 hours</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                
                               
                                
                                <div style="float: left; width: 150px;height:10px;">&nbsp;</div>
                                <div style="float: left;padding-left: 5px; height:10px;">
                                    <asp:RequiredFieldValidator ID="rfvDdlShiftStartHours" runat="server"
                                      ControlToValidate="ddlShiftStartHours" CssClass="RequiredField" Font-Size="10px"
                                      ErrorMessage="Select an hour" SetFocusOnError="true" InitialValue="00">
                                      </asp:RequiredFieldValidator></div>
                                
                                <div style="clear: left; height: 1px;">
                                    &nbsp;</div>
                                <div style="float: left; width: 150px;">
                                    Shift End Time (HH:MM):<span style="color:Red; padding-left:2px;">*</span></div>
                                <div style="float: left; width: 20px; padding-left: 5px;">
                                    <asp:DropDownList ID="ddlShiftEndTimeHours" runat="server" CssClass="SmallFontInput">
                                        <asp:ListItem Value="24">12 AM</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div style="float: left; width: 6px; padding: 0 2 0 2">
                                    :</div>
                                <div style="float: left; width: 20px;">
                                    <asp:DropDownList ID="ddlShiftEndTimeMinutes" runat="server" CssClass="SmallFontInput">
                                        <asp:ListItem Value="00" Selected="True">00 Minutes</asp:ListItem>
                                        <asp:ListItem Value="10">10 Minutes</asp:ListItem>
                                        <asp:ListItem Value="15">15 Minutes</asp:ListItem>
                                        <asp:ListItem Value="30">30 Minutes</asp:ListItem>
                                        <asp:ListItem Value="45">45 Minutes</asp:ListItem>
                                        <asp:ListItem Value="50">50 Minutes</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div style="float: left; width: 100px;">
                                    &nbsp;</div>
                                <div style="float: left; width: 185px;">
                                    Shift End Time Relaxation (MM):</div>
                                <div style="float: left; width: 20px; padding-left: 5px;">
                                    <asp:DropDownList ID="ddlShiftEndTimeRelaxationMinutes" runat="server" CssClass="SmallFontInput">
                                        <asp:ListItem Value="00" Selected="True">No</asp:ListItem>
                                        <asp:ListItem Value="10">10 Minutes</asp:ListItem>
                                        <asp:ListItem Value="15">15 Minutes</asp:ListItem>
                                        <asp:ListItem Value="30">30 Minutes</asp:ListItem>
                                        <asp:ListItem Value="60">60 Minutes</asp:ListItem>
                                        <asp:ListItem Value="120">2 Hours</asp:ListItem>
                                        <asp:ListItem Value="180">3 hours</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                
                                <div style="float: left; width: 150px;height:10px;">&nbsp;</div>
                                <div style="float: left;padding-left: 5px; height:10px;">
                                    <asp:RequiredFieldValidator ID="rfvDdlShiftEndTimeHours" runat="server"
                                      ControlToValidate="ddlShiftEndTimeHours" CssClass="RequiredField" Font-Size="10px"
                                      ErrorMessage="Select an hour" SetFocusOnError="true" InitialValue="00">
                                      </asp:RequiredFieldValidator></div>
                                
                                
                                
                            </div>
                            <div style="clear: left; height: 15px; width: 620px; border-bottom: solid 1px #D5DDD2;">
                                &nbsp;</div>
                            <div class="dvShiftTimmings">
                                Break Timings:
                            </div>
                            <div style="color: #2A2F29; font-size: 12px;">
                                <div style="float: left; width: 150px;">
                                    Break Start Time(HH:MM):<span style="color:Red; padding-left:2px;">*</span></div>
                                <div style="float: left; width: 20px; padding-left: 5px;">
                                    <asp:DropDownList ID="ddlBreakStartHours" runat="server" CssClass="SmallFontInput">
                                        <asp:ListItem Value="24">12 AM</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div style="float: left; width: 6px; padding: 0 2 0 2">
                                    :</div>
                                <div style="float: left; width: 20px;">
                                    <asp:DropDownList ID="ddlBreakStartMinutes" runat="server" CssClass="SmallFontInput">
                                        <asp:ListItem Value="00" Selected="True">00 Minutes</asp:ListItem>
                                        <asp:ListItem Value="10">10 Minutes</asp:ListItem>
                                        <asp:ListItem Value="15">15 Minutes</asp:ListItem>
                                        <asp:ListItem Value="30">30 Minutes</asp:ListItem>
                                        <asp:ListItem Value="45">45 Minutes</asp:ListItem>
                                        <asp:ListItem Value="50">50 Minutes</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div style="float: left; width: 100px;">
                                    &nbsp;</div>
                                <div style="float: left; width: 185px;">
                                    Break Start Time Relaxation (MM):</div>
                                <div style="float: left; width: 20px; padding-left: 5px;">
                                    <asp:DropDownList ID="ddlBreakStartRelaxtionMinutes" runat="server" CssClass="SmallFontInput">
                                        <asp:ListItem Value="00" Selected="True">No</asp:ListItem>
                                        <asp:ListItem Value="-10">10 Minutes</asp:ListItem>
                                        <asp:ListItem Value="-15">15 Minutes</asp:ListItem>
                                        <asp:ListItem Value="-30">30 Minutes</asp:ListItem>
                                        <asp:ListItem Value="-60">60 Minutes</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                    
                                    <div style="float: left; width: 150px;height:10px;">&nbsp;</div>
                                <div style="float: left;padding-left: 5px; height:10px;">
                                    <asp:RequiredFieldValidator ID="rfvDdlBreakStartHours" runat="server"
                                      ControlToValidate="ddlBreakStartHours" CssClass="RequiredField" Font-Size="10px"
                                      ErrorMessage="Select an hour" SetFocusOnError="true" InitialValue="00">
                                      </asp:RequiredFieldValidator></div>
                                   
                                     <div style="clear: left; height: 1px; width: 500px">
                                    &nbsp;</div>
                                    
                                <div style="float: left; width: 150px;">
                                    Break End Time (HH:MM):<span style="color:Red; padding-left:2px;">*</span></div>
                                <div style="float: left; width: 20px; padding-left: 5px;">
                                    <asp:DropDownList ID="ddlBreakEndHours" runat="server" CssClass="SmallFontInput">
                                        <asp:ListItem Value="24">12 AM</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div style="float: left; width: 6px; padding: 0 2 0 2">
                                    :</div>
                                <div style="float: left; width: 20px;">
                                    <asp:DropDownList ID="ddlBreakEndminutes" runat="server" CssClass="SmallFontInput">
                                        <asp:ListItem Value="00" Selected="True">00 Minutes</asp:ListItem>
                                        <asp:ListItem Value="10">10 Minutes</asp:ListItem>
                                        <asp:ListItem Value="15">15 Minutes</asp:ListItem>
                                        <asp:ListItem Value="30">30 Minutes</asp:ListItem>
                                        <asp:ListItem Value="45">45 Minutes</asp:ListItem>
                                        <asp:ListItem Value="50">50 Minutes</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div style="float: left; width: 100px;">
                                    &nbsp;</div>
                                <div style="float: left; width: 185px;">
                                    Break End Time Relaxation (MM):</div>
                                <div style="float: left; width: 20px; padding-left: 5px;">
                                    <asp:DropDownList ID="ddlBreakEndRelaxationMinutes" runat="server" CssClass="SmallFontInput">
                                        <asp:ListItem Value="00" Selected="True">No</asp:ListItem>
                                        <asp:ListItem Value="10">10 Minutes</asp:ListItem>
                                        <asp:ListItem Value="15">15 Minutes</asp:ListItem>
                                        <asp:ListItem Value="30">30 Minutes</asp:ListItem>
                                        <asp:ListItem Value="60">60 Minutes</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                
                                <div style="float: left; width: 150px;height:10px;">&nbsp;</div>
                                <div style="float: left;padding-left: 5px; height:10px;">
                                    <asp:RequiredFieldValidator ID="rfvddlBreakEndHours" runat="server"
                                      ControlToValidate="ddlBreakEndHours" CssClass="RequiredField" Font-Size="10px"
                                      ErrorMessage="Select an hour" SetFocusOnError="true" InitialValue="00">
                                      </asp:RequiredFieldValidator></div>
                                   
                                     <div style="clear: left; height: 1px; width: 500px">
                                    &nbsp;</div>
                            </div>
                            
                            <div class="dvShiftTimmings">
                                Saturday Timings:
                            </div>
                            <div style="border-top: solid 2px #AFCCBA;">
                                &nbsp;
                            </div>
                            <div style="color: #2A2F29; font-size: 12px;">
                                <div style="float: left; width: 150px;">
                                    Shift Start Time(HH:MM):<span style="color:Red; padding-left:2px;">*</span></div>
                                <div style="float: left; width: 20px; padding-left: 5px;">
                                    <asp:DropDownList ID="ddlSaturdayStartTimeHours" runat="server" CssClass="SmallFontInput">
                                        <asp:ListItem Value="24">12 AM</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div style="float: left; width: 6px; padding: 0 2 0 2">
                                    :</div>
                                <div style="float: left; width: 20px;">
                                    <asp:DropDownList ID="ddlSaturdayStartTimeMinutes" runat="server" CssClass="SmallFontInput">
                                        <asp:ListItem Value="00" Selected="True">00 Minutes</asp:ListItem>
                                        <asp:ListItem Value="10">10 Minutes</asp:ListItem>
                                        <asp:ListItem Value="15">15 Minutes</asp:ListItem>
                                        <asp:ListItem Value="30">30 Minutes</asp:ListItem>
                                        <asp:ListItem Value="45">45 Minutes</asp:ListItem>
                                        <asp:ListItem Value="50">50 Minutes</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div style="float: left; width: 100px;">
                                    &nbsp;</div>
                                <div style="float: left; width: 185px;">
                                    Shift Start Time Relaxation (MM):</div>
                                <div style="float: left; width: 20px; padding-left: 5px;">
                                    <asp:DropDownList ID="ddlSaturdayStartTimeRelaxation" runat="server" CssClass="SmallFontInput">
                                        <asp:ListItem Value="00" Selected="True">No</asp:ListItem>
                                        <asp:ListItem Value="10">10 Minutes</asp:ListItem>
                                        <asp:ListItem Value="15">15 Minutes</asp:ListItem>
                                        <asp:ListItem Value="30">30 Minutes</asp:ListItem>
                                        <asp:ListItem Value="60">60 Minutes</asp:ListItem>
                                        <asp:ListItem Value="120">2 Hours</asp:ListItem>
                                        <asp:ListItem Value="180">3 hours</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                
                                
                                  <div style="float: left; width: 150px;height:10px;">&nbsp;</div>
                                <div style="float: left;padding-left: 5px; height:10px;">
                                    <asp:RequiredFieldValidator ID="rfvddlSaturdayStartTimeHours" runat="server"
                                      ControlToValidate="ddlSaturdayStartTimeHours" CssClass="RequiredField" Font-Size="10px"
                                      ErrorMessage="Select an hour" SetFocusOnError="true" InitialValue="00">
                                      </asp:RequiredFieldValidator></div>
                                   
                                     <div style="clear: left; height: 1px; width: 500px">
                                    &nbsp;</div>
                                
                                <div style="float: left; width: 150px;">
                                    Shift End Time (HH:MM):<span style="color:Red; padding-left:2px;">*</span></div>
                                <div style="float: left; width: 20px; padding-left: 5px;">
                                    <asp:DropDownList ID="ddlSaturdayEndTimeHours" runat="server" CssClass="SmallFontInput">
                                        <asp:ListItem Value="24">12 AM</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div style="float: left; width: 6px; padding: 0 2 0 2">
                                    :</div>
                                <div style="float: left; width: 20px;">
                                    <asp:DropDownList ID="ddlSaturdayEndTimeMinutes" runat="server" CssClass="SmallFontInput">
                                        <asp:ListItem Value="00" Selected="True">00 Minutes</asp:ListItem>
                                        <asp:ListItem Value="10">10 Minutes</asp:ListItem>
                                        <asp:ListItem Value="15">15 Minutes</asp:ListItem>
                                        <asp:ListItem Value="30">30 Minutes</asp:ListItem>
                                        <asp:ListItem Value="45">45 Minutes</asp:ListItem>
                                        <asp:ListItem Value="50">50 Minutes</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div style="float: left; width: 100px;">
                                    &nbsp;</div>
                                <div style="float: left; width: 185px;">
                                    Shift End Time Relaxation (MM):</div>
                                <div style="float: left; width: 20px; padding-left: 5px;">
                                    <asp:DropDownList ID="ddlSaturdayEndTimeRelaxtion" runat="server" CssClass="SmallFontInput">
                                        <asp:ListItem Value="00" Selected="True">No</asp:ListItem>
                                        <asp:ListItem Value="10">10 Minutes</asp:ListItem>
                                        <asp:ListItem Value="15">15 Minutes</asp:ListItem>
                                        <asp:ListItem Value="30">30 Minutes</asp:ListItem>
                                        <asp:ListItem Value="60">60 Minutes</asp:ListItem>
                                        <asp:ListItem Value="120">2 Hours</asp:ListItem>
                                        <asp:ListItem Value="180">3 hours</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                
                                <div style="float: left; width: 150px;height:10px;">&nbsp;</div>
                                <div style="float: left;padding-left: 5px; height:10px;">
                                    <asp:RequiredFieldValidator ID="rfvddlSaturdayEndTimeHours" runat="server"
                                      ControlToValidate="ddlSaturdayEndTimeHours" CssClass="RequiredField" Font-Size="10px"
                                      ErrorMessage="Select an hour" SetFocusOnError="true" InitialValue="00">
                                      </asp:RequiredFieldValidator></div>
                                   
                                     <div style="clear: left; height: 1px; width: 500px">
                                    &nbsp;</div>
                               <span style="font-size:14px; font-family:Calibri; float:left; font-weight:bold;">
                                    Status
                               </span><span style="padding-left:20px; float:left;">
                                    <asp:RadioButtonList ID="rbtnListStatus" RepeatLayout="Flow" 
                                                         RepeatDirection="Horizontal"  CellSpacing="20" Width="200"
                                                         runat="server" style="float:left; width:400px; padding-bottom:8px; cursor:pointer;">
                                        <asp:ListItem Selected="True" Value="True">Active&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </asp:ListItem>
                                        <asp:ListItem Value="False">Inactive</span></asp:ListItem>
                                    </asp:RadioButtonList>
                               </span>
                               <div style="clear:left; height:10px;">&nbsp;</div>
                            </div>
                            
                        </td>
                        <td id="tdRight">
                            &nbsp;
                        </td>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td style="height: 60px; border-top: solid 2px #08CB05; background-color: #F2F9F1;
                text-align: center;">
                <span>
                    <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/HR/Images/btn_saveSmall.gif" Style="border: 0px;
                        cursor: pointer;" CausesValidation="true" />
                </span><span style="padding-left:5px;">
                    <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="~/HR/Images/btn_cancelSmall.gif"
                        Style="border: 0px; cursor: pointer;" CausesValidation="false" OnClientClick="return ShowProfiles();"  /></span>
            </td>
        </tr>
    </table>
    <script language="javascript" type="text/javascript">
        //parent.ChangeTrBackGround(2);
    </script>
    </form>
</body>
</html>
