<%@ Page Language="VB" AutoEventWireup="false" CodeFile="NewCaseActivity.aspx.vb" Inherits="admin_Legal_NewLegalActivity" validateRequest="false" %>
<html>
<head id="Head1" runat="server">
    <title>Untitled Page</title>

    <link href="../Style/style.css" rel="stylesheet" type="text/css" />
    <link href="Style/Style.css" rel="stylesheet" type="text/css" />
     <link href="../App_Themes/Default/Calendar/style.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" src="../scripts/calendar-fs.js"></script>
    <script type="text/javascript" src="../scripts/jquery.js"></script>
    <meta http-equiv="Page-Enter" content="progid:DXImageTransform.Microsoft.Fade(Duration=0.2)" />
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(Duration=0.2)" />
<style>

</style>

    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
    <script language="javascript" type="text/javascript">
    function chkStatus()
    {
        var status=document.getElementById("ddlActivityState").value;
        if(status==4)
        {
            TDWait.style.display='inline';
        }
        else
        {
            TDWait.style.display='none';
        }
        showReminder();
    }
     function OnAttachmentSubmit(flagCancel)
        {
        
            var FileExp = new RegExp("^.*(.txt|.zip|.doc|.jpg|.jpeg|.png|.gif|.doc|.docx|.pdf|.rtf|.xls|.xlsx|.rar|.TXT|.ZIP|.DOC|.DOCX|.XLS|.XLSX|.JPG|.JPEG|.PNG|.GIF|.DOC|.DOCX|.XLS|.XLSX|.RAR|.PDF|.RTF)$"); 
	        if (flagCancel == 1)
	        {
		        ResetAttachment3();ResetAttachment2();ResetAttachment1();
	        }
	        else 
	        {
	             if(!(FileExp.test(trim(document.getElementById('<%=FileUpload1.ClientID%>').value))))
	             {
	             ResetAttachment1();
	             }
	             if(!(FileExp.test(trim(document.getElementById('<%=FileUpload2.ClientID%>').value))))
	             {
	             ResetAttachment2();
	             }
	             if(!(FileExp.test(trim(document.getElementById('<%=FileUpload3.ClientID%>').value))))
	             {
	             ResetAttachment3();
	             }
	         
	        }        
        	
	        getElement('Attachment').style.display = 'none';	
	        var strFiles = '';
	       if (trim(document.getElementById('<%=FileUpload1.ClientID%>').value) != '')
		        strFiles += '<table style=\'display:inline;\' class=SimpleExSmallBold><tr><td rowspan=2 style=\'border:none;\'>&nbsp;&nbsp;</td><td style=\'border:none;\'>'+trimFileName(getElement('FileUpload1').value.substr(getElement('FileUpload1').value.lastIndexOf("\\")+1))+'</td></tr><tr><td style=\'cursor:pointer;font-size:7px;border:none;\' align=right onClick=\'ResetAttachment1();OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>' ;
	        if (trim(document.getElementById('<%=FileUpload2.ClientID%>').value) != '')
		        strFiles += '<table style=\'display:inline;\' class=SimpleExSmallBold><tr><td rowspan=2 style=\'border:none;\'>&nbsp;&nbsp;</td><td style=\'border:none;\'>'+trimFileName(getElement('FileUpload2').value.substr(getElement('FileUpload2').value.lastIndexOf("\\")+1))+'</td></tr><tr><td style=\'cursor:pointer;font-size:7px;border:none;\' align=right onClick=\'ResetAttachment2();OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>' ;
	        if (trim(document.getElementById('<%=FileUpload3.ClientID%>').value) != '')
		        strFiles += '<table style=\'display:inline;\' class=SimpleExSmallBold><tr><td rowspan=2 style=\'border:none;\'>&nbsp;&nbsp;</td><td style=\'border:none;\'>'+trimFileName(getElement('FileUpload3').value.substr(getElement('FileUpload3').value.lastIndexOf("\\")+1))+'</td></tr><tr><td style=\'cursor:pointer;font-size:7px;border:none;\' align=right onClick=\'ResetAttachment3();OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>' ;
        	
	        if (strFiles == '')
	        {
		        getElement('trFiles').style.display = 'none';
		        getElement('tdFiles').innerHTML = '';
	        }
	        else
	        {
	        
		        getElement('trFiles').style.display = 'inline';
		        getElement('tdFiles').innerHTML = strFiles;	
	        }
	        strFiles = '';
	        setWindowedControlsVisibility(window, 'visible');
        }
        
        
        
        function trimFileName(strFileName)
            {
            
	            if (strFileName.length > 20)
		            return strFileName.substr(0,20)+' ...';
	            else
		            return strFileName;
            }
            function ResetAttachment2()
             {
               var Fupload = document.getElementById('<%=FileUpload2.ClientID%>');
               var TD = Fupload.parentElement ;
               var str = TD.innerHTML;
                str = str.replace(Fupload.value,'');
                TD.innerHTML = str ;
               } 
      function ResetAttachment1()
              {
           
               var Fupload = document.getElementById('<%=FileUpload1.ClientID%>');
                var TD = Fupload.parentElement ;
               var str = TD.innerHTML;
                str = str.replace(Fupload.value,'');
                TD.innerHTML = str ;
               
               } 
   
      function ResetAttachment3()
              {
             
               var Fupload = document.getElementById('<%=FileUpload3.ClientID%>');
                var TD = Fupload.parentElement ;
               var str = TD.innerHTML;
                str = str.replace(Fupload.value,'');
                TD.innerHTML = str ;
               
               } 
               function chkNStatus(sender,args)
    {
        var status=document.getElementById("ddlActivityState").value;
        if(status==4)
        {
            var admin=document.getElementById("ddlAssignedTo").value;
            if(admin>0)
                args.IsValid=true
            else
                args.IsValid=false
        }
    }
    function chkTime(sender,args)
    {
       var hours=document.getElementById("ddlHoursNotes").value;
    var mins=document.getElementById("ddlMinutesNotes").value;
    if(hours==0&&mins==0)
    {
        args.IsValid=false;
        setWindowedControlsVisibility(window,'visible');
       
    }
    else 
    args.IsValid=true;
    }

    function showReminder()
    {
        if(document.getElementById("chkReminder").checked==true)
        {
        document.getElementById("tdDate").style.display='inline';
        document.getElementById("tdCalender").style.display='inline';
        document.getElementById("tdTime").style.display='inline';
        //document.getElementById("tdReminderMsg").style.display='none';
        document.getElementById("tdRemChk").style.display='inline';
       //document.getElementById("lnkRemAdd").style.display='inline';
      // document.getElementById("tdButtons").style.display='inline';
       
         
        }
        else
        {
       
        document.getElementById("tdDate").style.display='none';
        document.getElementById("tdCalender").style.display='none';
        document.getElementById("tdTime").style.display='none';
       // document.getElementById("rfvchkReminder").style.display='none';
       // document.getElementById("tdReminderMsg").style.display='inline';
       // document.getElementById("lnkRemAdd").style.display='none';
       // document.getElementById("tdButtons").style.display='none';
         
        }
        //if(document.getElementById("tdReminderMsg").style.display=='inline'){document.getElementById("tdRemChk").style.display='none';} else {document.getElementById("tdRemChk").style.display='inline';}
    }
     function ValidateReminder(sender,args)
    {
      if(document.getElementById("chkReminder").checked==true&&document.getElementById("txtReminderDate").value=="")
        {
           args.IsValid=false;
        }
      else
        {
           args.IsValid=true;
        }
    }
    </script>

</head>
<body style="margin: 0px; height: 100%; width: 100%; padding: 0px;" scroll="no" onload="chkStatus();">
      <form id="form1" runat="server">
        <table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0"
            id="tblMain" class="mainTable">
            <tr class="UnderlinedRow" style="cursor: default; background-color: #BDE7BD;">
                <td style="height: 31px; border-bottom: Solid 1px White;padding-left:2px;font-size:14px;">
                    <strong>&nbsp;New Activity <span style="display:none;">(<asp:Label ID="lblCaseName" runat="server"></asp:Label>
                        )</span></strong><asp:SqlDataSource ID="sdsIPActivityType" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                            SelectCommand="SELECT * FROM [Legal_CaseActivityTypes] WHERE [Deleted] = 0">
                        </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td colspan="1" valign="top">
                    <table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0"
                        style="border: none; background-color: #DEF7D6;">
                        <tr style="height: 15px;">
                            <td style="border-bottom: white 1px solid;width:15%;padding-left:5px;">Type:<span class="RequiredField">*</span></td>
                            <td style="border-bottom: white 1px solid;width:35%">
                                <asp:DropDownList 
                                    ID="ddlNType" 
                                    runat="server" 
                                    CssClass="mediumfontinput" 
                                    Width="105px"
                                    DataSourceID="sdsIPActivityType" 
                                    DataTextField="Name" 
                                    DataValueField="ID"  TabIndex="1">
                                    <asp:ListItem Value="-1">Choose...</asp:ListItem>
                                    <asp:ListItem Value="1">Call</asp:ListItem>
                                    <asp:ListItem Value="2">Application</asp:ListItem>
                                    <asp:ListItem Value="3">Letter</asp:ListItem><asp:ListItem Value="4">Fax</asp:ListItem><asp:ListItem Value="5">Meeting</asp:ListItem><asp:ListItem Value="6">Other</asp:ListItem></asp:DropDownList>
                                <asp:RequiredFieldValidator
                                    SetFocusOnError="true" 
                                    ID="RequiredFieldValidator1" 
                                    runat="server" 
                                    ErrorMessage="Choose activity type"
                                    ControlToValidate="ddlNType" 
                                    CssClass="RequiredField" 
                                    InitialValue="-1" 
                                    Width="144px"
                                    Display="Dynamic"></asp:RequiredFieldValidator></td>
                            <td align="left" style="border-bottom: white 1px solid;width:17%;">Time Start:</td>
                            <td align="left" style="border-bottom: white 1px solid;width:33%;">
                                <input type="text" name="txtTime" readonly id="txtTime" value='<%=FormatDateTime(DateTime.Now.TimeOfDay.ToString()) %>'
                                    class="MediumGreenTextBox" maxlength="8" style="width: 115px" TabIndex="2"></td>
                            <%--<td style="border-bottom: white 1px solid;">&nbsp;</td>--%>
                        </tr>
                        <tr>
                            <td style="height: 25px; border-bottom: white 1px solid;padding-left:5px;">Time Spent:<span style="font-size: 8pt; color: #ff0000">*</span></td>
                            <td style="border-bottom: white 1px solid">
                                <asp:DropDownList Width="42" ID="ddlHoursNotes" runat="server" AutoPostBack="false" TabIndex="3" CssClass="mediumfontinput"><asp:ListItem Selected="True" Text="00" Value="0"></asp:ListItem><asp:ListItem Text="01" Value="1"></asp:ListItem><asp:ListItem Text="02" Value="2"></asp:ListItem><asp:ListItem Text="03" Value="3"></asp:ListItem><asp:ListItem Text="04" Value="4"></asp:ListItem><asp:ListItem Text="05" Value="5"></asp:ListItem><asp:ListItem Text="06" Value="6"></asp:ListItem><asp:ListItem Text="07" Value="7"></asp:ListItem><asp:ListItem Text="08" Value="8"></asp:ListItem><asp:ListItem Text="09" Value="9"></asp:ListItem><asp:ListItem Text="10" Value="10"></asp:ListItem><asp:ListItem Text="11" Value="11"></asp:ListItem></asp:DropDownList>
                                &nbsp;&nbsp;:&nbsp;&nbsp;
                                <asp:DropDownList Width="42" ID="ddlMinutesNotes" runat="server" AutoPostBack="false" TabIndex="4" CssClass="mediumfontinput"><asp:ListItem Selected="True" Text="00" Value="0"></asp:ListItem><asp:ListItem Text="01" Value="1"></asp:ListItem><asp:ListItem Text="02" Value="2"></asp:ListItem><asp:ListItem Text="03" Value="3"></asp:ListItem><asp:ListItem Text="04" Value="4"></asp:ListItem><asp:ListItem Text="05" Value="5"></asp:ListItem><asp:ListItem Text="06" Value="6"></asp:ListItem><asp:ListItem Text="07" Value="7"></asp:ListItem><asp:ListItem Text="08" Value="8"></asp:ListItem><asp:ListItem Text="09" Value="9"></asp:ListItem><asp:ListItem Text="10" Value="10"></asp:ListItem><asp:ListItem Text="11" Value="11"></asp:ListItem><asp:ListItem Text="12" Value="12"></asp:ListItem><asp:ListItem Text="13" Value="13"></asp:ListItem><asp:ListItem Text="14" Value="14"></asp:ListItem><asp:ListItem Text="15" Value="15"></asp:ListItem><asp:ListItem Text="16" Value="16"></asp:ListItem><asp:ListItem Text="17" Value="17"></asp:ListItem><asp:ListItem Text="18" Value="18"></asp:ListItem><asp:ListItem Text="19" Value="19"></asp:ListItem><asp:ListItem Text="20" Value="20"></asp:ListItem><asp:ListItem Text="21" Value="21"></asp:ListItem><asp:ListItem Text="22" Value="22"></asp:ListItem><asp:ListItem Text="23" Value="23"></asp:ListItem><asp:ListItem Text="24" Value="24"></asp:ListItem><asp:ListItem Text="25" Value="25"></asp:ListItem><asp:ListItem Text="26" Value="26"></asp:ListItem><asp:ListItem Text="27" Value="27"></asp:ListItem><asp:ListItem Text="28" Value="28"></asp:ListItem><asp:ListItem Text="29" Value="29"></asp:ListItem><asp:ListItem Text="30" Value="30"></asp:ListItem><asp:ListItem Text="31" Value="31"></asp:ListItem><asp:ListItem Text="32" Value="32"></asp:ListItem><asp:ListItem Text="33" Value="33"></asp:ListItem><asp:ListItem Text="34" Value="34"></asp:ListItem><asp:ListItem Text="35" Value="35"></asp:ListItem><asp:ListItem Text="36" Value="36"></asp:ListItem><asp:ListItem Text="37" Value="37"></asp:ListItem><asp:ListItem Text="38" Value="38"></asp:ListItem><asp:ListItem Text="39" Value="39"></asp:ListItem><asp:ListItem Text="40" Value="40"></asp:ListItem><asp:ListItem Text="41" Value="41"></asp:ListItem><asp:ListItem Text="42" Value="42"></asp:ListItem><asp:ListItem Text="43" Value="43"></asp:ListItem><asp:ListItem Text="44" Value="44"></asp:ListItem><asp:ListItem Text="45" Value="45"></asp:ListItem><asp:ListItem Text="46" Value="46"></asp:ListItem><asp:ListItem Text="47" Value="47"></asp:ListItem><asp:ListItem Text="48" Value="48"></asp:ListItem><asp:ListItem Text="49" Value="49"></asp:ListItem><asp:ListItem Text="50" Value="50"></asp:ListItem><asp:ListItem Text="51" Value="51"></asp:ListItem><asp:ListItem Text="52" Value="52"></asp:ListItem><asp:ListItem Text="53" Value="53"></asp:ListItem><asp:ListItem Text="54" Value="54"></asp:ListItem><asp:ListItem Text="55" Value="55"></asp:ListItem><asp:ListItem Text="56" Value="56"></asp:ListItem><asp:ListItem Text="57" Value="57"></asp:ListItem><asp:ListItem Text="58" Value="58"></asp:ListItem><asp:ListItem Text="59" Value="59"></asp:ListItem></asp:DropDownList>
                                <asp:CustomValidator SetFocusOnError="true" ID="cvTimeSpent" runat="server" ClientValidationFunction="chkTime"
                                    CssClass="RequiredField" Display="Dynamic" ErrorMessage="Enter time spent."></asp:CustomValidator>&nbsp;</td>
                            <td style="border-bottom: white 1px solid;">Assigned to:<span style="font-size: 8pt; color: #ff0000">*</span></td>
                            <td style="border-bottom: white 1px solid;">
                                <asp:DropDownList ID="ddlActivityAssginedTo" runat="server" AppendDataBoundItems="True"
                                    DataSourceID="ComplianceAdminsDS" DataTextField="Name" DataValueField="ID" Width="115px"
                                    CssClass="mediumfontinput" TabIndex="5"><asp:ListItem Value="-1">Choose...</asp:ListItem></asp:DropDownList>
                                <asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvAdminAssignedTo" runat="server" ControlToValidate="ddlActivityAssginedTo"
                                    CssClass="RequiredField" Display="Dynamic" ErrorMessage="<br />Choose an admin." InitialValue="-1"></asp:RequiredFieldValidator></td>
                            <%--<td style="border-bottom: white 1px solid;">&nbsp;</td>--%>
                        </tr>
                        
                        <tr>
                            <td style="border-bottom: white 1px solid;height: 25px;padding-left:5px;">Subject:<span class="RequiredField">*</span></td>
                            <td colspan="2" style="border-bottom: white 1px solid">
                                <asp:TextBox ID="txtSubject" runat="server" TabIndex="7" CssClass="MediumFontInput" MaxLength="70" Width="100%"></asp:TextBox></td>                            <td style="border-bottom: white 1px solid; padding-left: 15px;">
                                <input type="button" id="btnAttach" TabIndex="8" name="btnAttach" value="Attach File" style="width: 80px;"
                                    onclick="try{Attachment.style.display = 'inline'; return false;} catch(e){return false;}"
                                    class="Btn">&nbsp;
                                <asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvSubject" runat="server" ControlToValidate="txtSubject"
                                    CssClass="RequiredField" ErrorMessage="<br />Subject is required." Display="Dynamic">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <%--<td style="height: 0px; border-bottom: white 1px solid;">
                            </td>--%>
                            <td colspan="4" style="height: 1px;padding-left:5px;">
                            <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtNote"
                                    CssClass="RequiredField" ErrorMessage="Please enter notes" Display="Dynamic">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr class="SimpleExSmallBold" id="trFiles" style="display: none;">
                            <td colspan="5" style="height: 20px;padding-left:5px;">
                                <table width="99%" border="0" cellspacing="0" cellpadding="0" style="border: none;height: 100%; background-color:#FAFCCE;border:1px solid #50AF43;">
                                    <tr>
                                        <td style="border: none;"  align="center" width="5%">
                                            <img src="../images/ico_attachment.gif" align="middle"></td>
                                        <td style="border: none;" class="SimpleExSmall" id="tdFiles">
                                        </td>
                                    </tr>
                                    <%--<tr>--%>
                                </table>
                            </td>
                            <%--<td colspan="1" style="border-right: medium none; border-top: medium none; border-left: medium none;
                                border-bottom: medium none; height: 20px">
                            </td>--%>
                        </tr>
                        <tr>
                            <td colspan="4" style="padding-left:5px;">
                                    <asp:TextBox
                                        ID="txtNote" 
                                        runat="server" 
                                        Width="99%" 
                                        CssClass="mediumgreentextbox" 
                                        Height="98%"
                                        TextMode="MultiLine" TabIndex="9">
                                    </asp:TextBox>
                                </td>
                        </tr>
                        <tr>
                            <td height="15" colspan="4">
                                <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="height: 15px;width:300px;" valign="middle">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td style="padding-left:5px;width:70px;">Status:<span class="RequiredField">*</span></td>
                                            <td >
                                             <asp:DropDownList ID="ddlActivityState" runat="server" CssClass="mediumfontinput"
                                                onchange="chkStatus();" Width="95px" TabIndex="10"><asp:ListItem Value="-1">Choose...</asp:ListItem><asp:ListItem Value="1">Not Started</asp:ListItem><asp:ListItem Value="2">In Progress</asp:ListItem><asp:ListItem Value="3">Complete</asp:ListItem><asp:ListItem Value="4">Waiting For</asp:ListItem></asp:DropDownList>
                                             <asp:RequiredFieldValidator
                                                SetFocusOnError="true" 
                                                ControlToValidate="ddlActivityState" 
                                                CssClass="RequiredField"
                                                ErrorMessage="Status is required!" 
                                                ID="rfvActivityType" 
                                                InitialValue="-1" 
                                                runat="server"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                            </td>
                                            <td id="TDWait">
                                            <asp:DropDownList ID="ddlAssignedTo" TabIndex="11" runat="server" CssClass="mediumfontinput" Width="115px"
                                                DataSourceID="ComplianceAdminsDS" DataTextField="Name" DataValueField="ID" AppendDataBoundItems="True"><asp:ListItem Value="0">Choose...</asp:ListItem></asp:DropDownList>
                                            </td>
<%--                                            <td>&nbsp;
                                             
                                            </td>--%>
                                            </tr>
                                            </table>
                                          
                                        </td>
                                        <td>
                                                  <table id="tdReminder" border="0" cellpadding="0" cellspacing="0" height="28" width="250">
                                                                     <tr>
                                                                        <td style="width:1px"><img src="../images/pixel_green.JPG" height="23" width="1" align="absmiddle" /></td>
                                                                        <td id="tdRemChk" style=" border-top-style: none; border-right-style: none;
                                                                            border-left-style: none; border-bottom-style: none;padding-left:5px;">
                                                                            <asp:CheckBox ID="chkReminder" runat="server" CausesValidation="True" Font-Size="X-Small"
                                                                                Height="16px" onclick="showReminder();"
                                                                                Text="Reminder" Width="80px" TabIndex="12" /></td>
                                                                        <td id="tdDate" style="width: 72px; border-top-style: none; border-right-style: none;
                                                                            border-left-style: none; border-bottom-style: none">
                                                                            <asp:TextBox ID="txtReminderDate" runat="server" CausesValidation="True" 
                                                                                onfocus="this.blur();" Width="70px" TabIndex="13" CssClass="MediumGreenTextBox"></asp:TextBox>
                                                                                
                                                                                </td>
                                                                        <td id="tdCalender" style="border-top-style: none; border-right-style: none; border-left-style: none;
                                                                            border-bottom-style: none" width="16" align="center">
                                                                            <asp:ImageButton align="absmiddle" TabIndex="14" ID="imgCalender" runat="server" Height="16px" ImageUrl="~/images/icn_calendar.png"
                                                                                OnClientClick="setActiveStyleSheet(this, 'calstyle'); return showCalendar('txtReminderDate', 'MM/dd/y');"
                                                                                Width="16px" /></td>
                                                                        <td id="tdTime" style="font-size: 8pt; width: 72px; color: black; border-top-style: none;
                                                                            font-style: normal; font-family: Verdana; border-right-style: none; border-left-style: none;
                                                                            font-variant: normal; border-bottom-style: none;padding-left:5px;">
                                                                            <asp:DropDownList ID="ddlTime" runat="server" TabIndex="15" CausesValidation="True" CssClass="mediumfontinput"
                                                                                Height="18px" Width="100px">
                                                                                <asp:ListItem Value="6:00:00 AM">06:00 AM</asp:ListItem>
                                                                                <asp:ListItem Value="6:30:00 AM">06:30 AM</asp:ListItem>
                                                                                <asp:ListItem Value="7:00:00 AM">07:00 AM</asp:ListItem>
                                                                                <asp:ListItem Value="7:30:00 AM">07:30 AM</asp:ListItem>
                                                                                <asp:ListItem Value="8:00:00 AM">08:00 AM</asp:ListItem>
                                                                                <asp:ListItem Value="8:30:00 AM">08:30 AM</asp:ListItem>
                                                                                <asp:ListItem Value="9:00:00 AM">09:00 AM</asp:ListItem>
                                                                                <asp:ListItem Value="9:30:00 AM">09:30 AM</asp:ListItem>
                                                                                <asp:ListItem Value="10:00:00 AM">10:00 AM</asp:ListItem>
                                                                                <asp:ListItem Value="10:30:00 AM">10:30 AM</asp:ListItem>
                                                                                <asp:ListItem Value="11:00:00 AM">11:00 AM</asp:ListItem>
                                                                                <asp:ListItem Value="11:30:00 AM">11:30 AM</asp:ListItem>
                                                                                <asp:ListItem Value="12:00:00 PM">12:00 PM</asp:ListItem>
                                                                                <asp:ListItem Value="12:30:00 PM">12:30 PM</asp:ListItem>
                                                                                <asp:ListItem Value="1:00:00 PM">01:00 PM</asp:ListItem>
                                                                                <asp:ListItem Value="1:30:00 PM">01:30 PM</asp:ListItem>
                                                                                <asp:ListItem Value="2:00:00 PM">02:00 PM</asp:ListItem>
                                                                                <asp:ListItem Value="2:30:00 PM">02:30 PM</asp:ListItem>
                                                                                <asp:ListItem Value="3:00:00 PM">03:00 PM</asp:ListItem>
                                                                                <asp:ListItem Value="3:30:00 PM">03:30 PM</asp:ListItem>
                                                                                <asp:ListItem Value="4:00:00 PM">04:00 PM</asp:ListItem>
                                                                                <asp:ListItem Value="4:30:00 PM">04:30 PM</asp:ListItem>
                                                                                <asp:ListItem Value="5:00:00 PM">05:00 PM</asp:ListItem>
                                                                                <asp:ListItem Value="5:30:00 PM">05:30 PM</asp:ListItem>
                                                                                <asp:ListItem Value="6:00:00 PM">06:00 PM</asp:ListItem>
                                                                                <asp:ListItem Value="6:30:00 PM">06:30 PM</asp:ListItem>
                                                                                <asp:ListItem Value="7:00:00 PM">07:00 PM</asp:ListItem>
                                                                                <asp:ListItem Value="7:30:00 PM">07:30 PM</asp:ListItem>
                                                                                <asp:ListItem Value="8:00:00 PM">08:00 PM</asp:ListItem>
                                                                                <asp:ListItem Value="8:30:00 PM">08:30 PM</asp:ListItem>
                                                                                <asp:ListItem Value="9:00:00 PM">09:00 PM</asp:ListItem>
                                                                                <asp:ListItem Value="9:30:00 PM">09:30 PM</asp:ListItem>
                                                                                <asp:ListItem Value="10:00:00 PM">10:00 PM</asp:ListItem>
                                                                                <asp:ListItem Value="10:30:00 PM">10:30 PM</asp:ListItem>
                                                                                <asp:ListItem Value="11:00:00 PM">11:00 PM</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                 </table>
                                                </td>
                                        <td align="right" style="height: 30px; padding-right:10px;" valign="middle">
                                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="Btn" Width="70px" TabIndex="16" />
                                            &nbsp;<input type="button" value="Cancel" onclick="parent.frameMain.location='CaseMain.aspx?ID=<%=Request.QueryString("ID") %>'"
                                                title="Cancel" class="Btn" style="width: 70px;" TabIndex="17">&nbsp;
                                        </td>
                                    </tr>
                                </table>
                                <asp:SqlDataSource ID="AdminsDS" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                    SelectCommand="Users_GetAll" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                <asp:SqlDataSource ID="ComplianceAdminsDS" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                    SelectCommand="Legal_GetComplianceUsers" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr style="height:1px;">
                            <td colspan="4" style="height:1px;" align="center">
                                <asp:CompareValidator  ID="cmpDate" runat="server" Display="Dynamic"
                                    ControlToValidate="txtReminderDate" 
                                    ControlToCompare="hdnCurrentDate" Operator="GreaterThan" ErrorMessage="Date must be in future."
                                    Type="Date"></asp:CompareValidator>
                                    <asp:TExtBox  ID="hdnCurrentDate"   runat="server" style="display:none;" />
                            </td>
                        </tr>

                        <tr>
                            <td height="1" colspan="4">
                                <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="padding-left:75px; width:300px;">
                                            <asp:CustomValidator
                                                 SetFocusOnError="true" 
                                                ID="cvAdmins" 
                                                runat="server" 
                                                ClientValidationFunction="chkNStatus"
                                                ControlToValidate="ddlAssignedTo" 
                                                CssClass="RequiredField" 
                                                ErrorMessage="Select waiting for!"
                                                Display="Dynamic">
                                            </asp:CustomValidator>
                                        </td>
                                        <td style="padding-left:10px;">
                                            <asp:CustomValidator SetFocusOnError="true" ID="cvReminder" CssClass="RequiredField" ClientValidationFunction="ValidateReminder" Display="Dynamic" runat="server" ErrorMessage="Enter reminder date."></asp:CustomValidator>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div align="center" id="Attachment" style="display: none; border: 0px solid black;
            position: absolute; left: 27%; top: 200px; width: 300px; height: 138px;">
            <table align="center" width="100%" cellpadding="0" cellspacing="0" class="MainAlertDiv">
                <tr>
                    <th height="21" align="left" valign="middle">
                        Attachments
                    </th>
                    <th align="right" valign="top">
                        <img src="../images/closebox2.gif" onclick="OnAttachmentSubmit(0); return false;"
                            style="cursor: pointer;"></th>
                </tr>
                <tr>
                    <td colspan="2" width="100%" valign="middle">
                        <table align="center" width="100%" cellpadding="0" cellspacing="0" class="MainAlertDiv"
                            style="border: none;">
                            <tr>
                                <td align="center" height="25" colspan="2">
                                    Attach Files!</td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td height="25">
                                    &nbsp;File 1: <span id="spnFileUpload1">
                                        <asp:FileUpload ID="FileUpload1" runat="server" Width="240px" /></span><br />
                                    &nbsp;File 2: <span id="spnFileUpload2">
                                        <asp:FileUpload ID="FileUpload2" runat="server" Width="240px" /></span><br />
                                    &nbsp;File 3: <span id="spnFileUpload3">
                                        <asp:FileUpload ID="FileUpload3" runat="server" Width="240px" /></span></td>
                            </tr>
                            <tr>
                                <td colspan="2" height="30" align="center">
                                    <input type="button" value="OK" onclick="OnAttachmentSubmit(0);" class="btnExtraSimple">
                                    </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>

