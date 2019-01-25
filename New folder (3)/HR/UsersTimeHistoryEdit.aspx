<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UsersTimeHistoryEdit.aspx.vb" Inherits="HR_UsersTimeHistoryEdit" Theme="Default"  %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="RadComboBox.Net2" Namespace="Telerik.WebControls" TagPrefix="radC" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
     <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
     <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
</head>
<body  style ="margin :0px;background-color:#DAF5D6; height:100%; width:100%;">
    <form id="form1" runat="server">
    <div>
    <asp:HiddenField ID="hdnTimeHistoryID" runat="server" />
    
    
    <asp:HiddenField ID="hdnPunchOutTime" runat="server" />
    <asp:Label runat="server" ID="hdntimezineoffset" style="display:none;" />
    <asp:HiddenField ID="hdnMode" runat="server" />
    <asp:HiddenField ID="hdnPreForcePO" runat="server" />

    <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="300" />
     <asp:UpdateProgress ID="Progress1" runat="server">
            <ProgressTemplate>
                <div class="ProgressIndicatorDIV" >
                    <br />
                        <asp:Image ID="Image2" runat="server" ImageUrl="~/images/indicator.gif" ImageAlign="AbsMiddle" /> <span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
                    <br /><br />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
<div  style="display:none;"> 
   <asp:UpdatePanel ID="upd1" runat="server" UpdateMode="Always" RenderMode="Inline">
    <ContentTemplate>
        <asp:HiddenField ID="hdnTeamID" runat="server" />
        <asp:HiddenField ID="hdnTimeZoneOffSet" runat="server" />
        <asp:HiddenField ID="hdnUserID" runat="server" />
    </ContentTemplate>
    </asp:UpdatePanel>
</div>

    <table cellspacing="0" border="0" style="height:100%; width:100%; padding-left: 1em; " class="FormTable"  >
                         
              <tr>
               <td align="center" style="vertical-align:top; height:100%; width:100%;" >                        
                    <div  style="overflow:auto;" id="Div1" >
                   <table border="0" cellpadding="0"  cellspacing="0" class="FormInnerTable" style="width:100%;  height:100%; text-align:left; vertical-align:top;" >
                       <tr>
                           <td align="left" style="width: 10%;height:5px;">
                           </td>
                           <td align="left" style="width: 15%">
                           </td>
                           <td style="width: 15%">
                           </td>
                           <td align="left" style="width: 15%">
                           </td>
                           <td style="width: 15%">
                           </td>
                           <td style="width: 10%">
                           </td>
                       </tr>
                        <tr>
                           <td align="left" style="height: 25px">
                           </td>
                           <td align="left">
                               Name:</td>
                           <td>
                               <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Always">
                                <ContentTemplate>
                        <radC:RadComboBox id="ddlUsers"                                                         
                                runat="server"
                                AutoPostBack="true"  
                                EnableViewState="true"  
                                AllowCustomText="true"
                                MarkFirstMatch="true"   
                                Width="147px"  OffsetX="2" OffsetY="0"
                                Height="100"
                                Skin="ComboSearch" 
                                DropDownWidth="132px"
                                DataTextField="Name" 
                                DataValueField="ID"
                                MaxLength="10"
                                ShowToggleImage="True"  
                                ShowWhileLoading="true"                                                        
                                EnableLoadOnDemand="true" TabIndex="1"
                                HighlightTemplatedItems="true">                                                   
                        </radC:RadComboBox >
                        </ContentTemplate> 
                    </asp:UpdatePanel>
                        <%--<asp:CustomValidator ID="CustomValidator1" 
                            Display="Dynamic" 
                            CssClass="RequiredField" 
                            ClientValidationFunction="checkvalue"  
                            ErrorMessage="Please Select an Employee" 
                            runat="server">
                         </asp:CustomValidator>--%>
                          <asp:SqlDataSource ID="sdsUsers" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                              DataSourceMode="DataReader" SelectCommand="HR_Users_GetAll" SelectCommandType="StoredProcedure">
                          </asp:SqlDataSource></td>
                           <td align="left" style="padding-left: 30px">
                               Notes: <span style="color: #ff0000">*</span>&nbsp;</td>
                           <td rowspan="5">
                               <asp:TextBox ID="txtNotes" TabIndex="6"
                                    runat="server" 
                                    Height="80%" 
                                    MaxLength="500" 
                                    SkinID="GreenMultilineTextbox" 
                                    TextMode="MultiLine"  
                                    Width="200px" ></asp:TextBox>                               
                           <asp:RequiredFieldValidator ID="RFV_txtNotes" 
                                    runat="server" 
                                    ControlToValidate="txtNotes"
                                    Display="Dynamic" 
                                    ErrorMessage="Please Enter Reason" 
                                    Font-Bold="true" 
                                    Font-Size="10px" 
                                    SkinID="RequiredFieldValidation">
                                </asp:RequiredFieldValidator></td>
                       </tr>
                       <tr>
                           <td align="left" style="height: 25px;">
                           </td>
                           <td align="left">
                               Date: <span style="color: #ff0000">*</span></td>
                           <td>
                                <asp:TextBox ID="txtDate" runat="server" TabIndex="2"
                                   MaxLength="10" SkinID="GreenSmallTextbox"
                                   onfocus="imgDDCalander.click();"
                                   Width="123px">
                               </asp:TextBox>
                               <img id="imgDDCalander" align="absMiddle"  border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                                   onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" />
                                 <asp:RequiredFieldValidator
                                       ID="RFV_DueDate" 
                                        runat="server" 
                                        ControlToValidate="txtDate" 
                                        Display="Dynamic"
                                        ErrorMessage="Please Enter Date" 
                                        Font-Bold="true"  
                                        Font-Size="10px" 
                                        SkinID="RequiredFieldValidation">
                                 </asp:RequiredFieldValidator>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
                                <ContentTemplate>
                                 <asp:CompareValidator ID="CV_txtDate"
                                     ControlToValidate="txtDate"                                      
                                     Display="Dynamic"
                                     Text="Future Date not Allowed"
                                     Operator="Lessthanequal" 
                                     Type="Date"
                                     Runat="Server" 
                                     SkinID="CompareValidation" >
                               </asp:CompareValidator>
                            </ContentTemplate>
                            </asp:UpdatePanel>
                                <asp:RegularExpressionValidator
                                           ID="REV_DOB" 
                                           runat="server" 
                                           ControlToValidate="txtDate" 
                                           Display="Dynamic"
                                           ErrorMessage="Date is not in Correct Format" 
                                           ValidationExpression="^\d{1,2}\/\d{1,2}\/\d{2,4}$">
                                </asp:RegularExpressionValidator></td>
                           <td align="left" style="padding-left:30px;" >
                               </td>
                           <td style="">
                           </td>
                       </tr>
                       

                       <tr title="Press A for 'AM' or P for 'PM'">
                           <td align="left" style="height: 25px;">
                           </td>
                           <td align="left"  style="white-space:nowrap;">
                               Punch In Time: <span style="color: #ff0000">*</span>
                           </td>
                           <td>
                               <asp:textbox TabIndex="3"
                                    ID="txtPunchInTime" 
                                    runat="server" 
                                    MaxLength="200" 
                                    SkinID="GreenSmallTextbox"
                                    Width="150px"
                                    >
                                </asp:textbox>
                               <ajaxToolkit:MaskedEditExtender
                                    ID="MEE_txtPunchInTime" 
                                    runat="server" 
                                    TargetControlID="txtPunchInTime"
                                    Mask="99:99"                                                                
                                    MaskType="Time" 
                                    AcceptAMPM="true"
                                    InputDirection="LeftToRight"
                                    AutoComplete="true" 
                                    />
                                <ajaxToolkit:MaskedEditValidator
                                    ID="MEV_MEE_txtPunchInTime" 
                                    runat="server" 
                                    ControlExtender="MEE_txtPunchInTime"
                                    ControlToValidate="txtPunchInTime" 
                                    IsValidEmpty="False"
                                    EmptyValueMessage="Please Enter PunchIn Time"
                                    InvalidValueMessage="Please Enter Valid Time"
                                    Display="Dynamic"
                                    TooltipMessage=""/>
                                    
                           </td>
                           <td align="left">
                           </td>
                           <td >
                           </td>
                       </tr>
                       <tr title="Press A for 'AM' or P for 'PM'">
                           <td align="left" style="height: 25px;">
                           </td>
                           <td align="left" style="white-space:nowrap;padding-right:2px;">
                               Punch Out Time: <span id="sPunchOut" visible="false" runat="server" style="color: #ff0000;">*</span>
                           </td>
                           <td>
                               <asp:textbox TabIndex="4"
                                    ID="txtPunchOutTime" 
                                    runat="server" 
                                    MaxLength="200" 
                                    SkinID="GreenSmallTextbox"
                                    Width="150px">
                               </asp:textbox>
                               <ajaxToolkit:MaskedEditExtender
                                    ID="MEE_txtPunchOutTime" 
                                    runat="server" 
                                    TargetControlID="txtPunchOutTime"
                                    Mask="99:99"
                                    MaskType="Time" 
                                    AcceptAMPM="true"
                                    InputDirection="LeftToRight"  
                                    AutoComplete="true" 
                                   
                                    />
                                <ajaxToolkit:MaskedEditValidator
                                    ID="MEV_MEE_txtPunchOutTime" 
                                    runat="server" 
                                    ControlExtender="MEE_txtPunchOutTime"
                                    ControlToValidate="txtPunchOutTime" 
                                    IsValidEmpty="False" 
                                    EmptyValueMessage="Please Enter PunchOut Time"
                                    InvalidValueMessage="Please Enter Valid Time"
                                    Display="Dynamic"
                                    TooltipMessage=""/>
                                <%--<asp:CompareValidator ID="Comparevalidator1"
                                     ControlToValidate="txtPunchInTime" 
                                     ControlToCompare="txtPunchOutTime"
                                     Display="Dynamic"
                                     Text="PunchIn time must be greater than Punchout time!"
                                     Operator="LessThan" 
                                     Type="Date"
                                     Runat="Server"                                     
                                     SkinID="CompareValidation" >
                               </asp:CompareValidator>--%>
                            <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Always">
                                <ContentTemplate>
                               <asp:CustomValidator
                                    ID="CV_CompareTime"
                                    ControlToValidate=""                                    
                                    ErrorMessage="PunchIn time must be greater than Punchout time"                                                       
                                    Display="Dynamic"
                                    ClientValidationFunction="CompareTime" 
                                    runat="server" >
                              </asp:CustomValidator>
                             </ContentTemplate> 
                            </asp:UpdatePanel> 
                              <asp:CustomValidator
                                ID="CVS_CheckTimeDuration"
                                ErrorMessage="" 
                                CssClass="RequiredField"
                                Display="Dynamic"
                                runat="server" />   
                               </td>
                               <td align="left">
                           </td>
                           <td>
                           </td>
                       </tr>                       
                       <tr>
                           <td align="left" style="height: 20px">
                           </td>
                           <td align="left" style="white-space: nowrap; padding-left:5px;">
                           Type
                           </td>
                           <td>
                                <asp:DropDownList ID="ddlAttendenceRecordTypes" runat="server" style="width: 150px; font-family: Arial; font-size: 11px;" TabIndex="5">
                                    <asp:ListItem Value="0">Select...</asp:ListItem>
                                    <asp:ListItem Value="1">Time Correction</asp:ListItem>
                                    <asp:ListItem Value="2">Short Leave</asp:ListItem>
                                    <asp:ListItem Value="3">Out Duty</asp:ListItem>
                                </asp:DropDownList><br />
                                <asp:RequiredFieldValidator ID="reqAttendenceRecordTypes" 
                                                            runat="server" 
                                                            ControlToValidate="ddlAttendenceRecordTypes" 
                                                            InitialValue="0" 
                                                            ErrorMessage="Select attendence type."  
                                                            SkinID="RequiredFieldValidation">
                                </asp:RequiredFieldValidator>
                           </td>
                           <td align="left">
                                
                           </td>
                           <td rowspan="1">
                               &nbsp;</td>
                           <td>
                           </td>
                       </tr>
                        <tr title="Press A for 'AM' or P for 'PM'">
                           <td colspan="1" >
                           </td>
                           <td colspan="4" style="text-align: center">
                           &nbsp;
                           </td>
                           <td colspan="1" style="">
                           </td>
                       </tr>  
                       <tr>
                           <td colspan="1" style="height:20px;">
                           </td>
                           <td colspan="4" style="text-align: center">
                               Fields marked with an asterisk <span class="RequiredField" style="color: #000000"><span
                                   style="color: #ff0000">*</span></span> are required.
                           </td>
                           <td colspan="1" style="">
                           </td>
                       </tr>
                     </table>                              
                   </div>
                </td>
              </tr>
              <tr>
                     <td align="center"  style="height:31px; border-top:1px solid #609BD3; vertical-align:middle;">
                        <asp:Button ID="btnSave" 
                        runat="server" TabIndex="7"
                         Text="Save" 
                        CssClass="Btn3D"  
                        Width="80px" 
                        CommandName="Insert" />&nbsp;&nbsp;
                      <button  
                      id="btnBack" TabIndex="8"
                      onclick="parent.Reset();"                      
                      class="Btn3D" >Cancel</button>       
                      </td>
                  </tr>                              
        </table>
    </div>
    </form>
</body>
<script language="javascript" type="text/javascript">
var combo = <%=ddlUsers.ClientID %>;
    window.onload=function()
    {   
       var hdnMode = getElement('<%= hdnMode.ClientID %>');
       var imgDDCalander = getElement('imgDDCalander');      
       if (hdnMode.value == 'EditMode')
       {
        imgDDCalander.disabled = true;
       }
    }
    function CompareTime(sender, args)
    {   
        var txtPunchInTime = getElement('<%= txtPunchInTime.ClientID %>');
        var txtPunchOutTime = getElement('<%= txtPunchOutTime.ClientID %>');
        var enumsupportnight = <%= Portal.BLL.Enumeration.TeamType.Support_Night %>
        var hdnTeamID = getElement('<%= hdnTeamID.ClientID %>');
        if (hdnTeamID.value == enumsupportnight)
        {
            args.IsValid = true
            return;
        }
        else
        {
            
       
        
        
//       var intime = new Date();
//       var ourtime = new Date()
//       intime = Date.parse('1970/01/01 ' + txtPunchInTime.value)
//       ourtime = Date.parse('1970/01/01 ' + txtPunchOutTime.value);
       
  
//        var sTime = txtPunchInTime    
//        var eTime = txtPunchOutTime   
//        var sArray = new Array()
//        sArray = sTime.value;
//        sArray=sArray.toString().split(':');        
//        alert("Hours :"+sArray[0]);
//        alert("Minutes:"+sArray[1]);
//        alert("Seconds:"+sArray[2]);
//        var eArray = new Array()
//        eArray = eTime.value;
//        eArray=eArray.toString().split(':');        
//        alert("Hours :"+eArray[0]);
//        alert("Minutes:"+eArray[1]);
//        alert("Seconds:"+eArray[2]);
        
        
  
  
  
  
  
  
       
       Z = "1970/01/01 " // Should not be a Summer Time Change Date
       ST = txtPunchInTime.value //"07:00:00 am"
       FT = txtPunchOutTime.value //"11:36:00 pm"
//       alert(ST)
//       alert(FT)
       D = new Date(Z+FT) - new Date(Z+ST)
       Ans = new Date(D).toUTCString().replace(/^.* ([^ ]{8}) .*$/, "$1")
       var num = Ans
       //alert(num)
       if (new Date(Z+FT) <= new Date(Z+ST))
       {
        args.IsValid = false
        //alert('cool')
       }
       else
       {
       args.IsValid = true       
       //alert('bad')
       }

        }
       
       
      // alert(intime.getDate()) 
//       //if (txtPunchInTime.getTime() > txtPunchOutTime.getTime())
//        {
//        
//        }
//      //  else
//        {
//        args.IsValid = false
//        }
    }
    function checkvalue(sender,args){
        if(combo.GetValue() == '')                                
           args.IsValid = false;
        else 
            args.IsValid = true;
        }       
  
 </script>   
</html>