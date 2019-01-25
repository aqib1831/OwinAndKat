<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Legal_AddActivity.aspx.vb"
    ValidateRequest="false" Theme="Default" Inherits="admin_Legal_Legal_AddActivity" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Add Activity</title>
    <link href="../style/Calendar/style.css" rel="stylesheet" type="text/css" />
    <link href="../style/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
 <script language="javascript" type="text/javascript">
    function validateSameFiles(oSrc, args)
    {
        if ( (getElement('<%= FileUpload1.ClientID %>').value == getElement('<%= FileUpload2.ClientID %>').value && getElement('<%= FileUpload1.ClientID %>').value != '' && getElement('<%= FileUpload2.ClientID %>').value != '') || 
             (getElement('<%= FileUpload1.ClientID %>').value == getElement('<%= FileUpload3.ClientID %>').value && getElement('<%= FileUpload1.ClientID %>').value != '' && getElement('<%= FileUpload3.ClientID %>').value != '') || 
             (getElement('<%= FileUpload2.ClientID %>').value == getElement('<%= FileUpload3.ClientID %>').value && getElement('<%= FileUpload2.ClientID %>').value != '' && getElement('<%= FileUpload3.ClientID %>').value != '') )
           args.IsValid = false
        else
           args.IsValid = true;
    }
    function validateFiles(oSrc, args)
    {
        if ( (getElement('<%= FileUpload1.ClientID %>').value == '') && 
             (getElement('<%= FileUpload2.ClientID %>').value == '') &&
             (getElement('<%= FileUpload3.ClientID %>').value == '') )
            args.IsValid = false
        else
            args.IsValid = true;
    }
  
    function OpenWindow(LeadID)
    {
        window.open('../BlankPage.aspx?Page=lead/PrintLead&PageTitle=Print Lead&LeadID='+LeadID,'','dialogHeight=750px,menubar=1,dialogWidth=600px,status=1');
    
    }

  
       function activityStateChange()
            {

            var ActivityState = document.getElementById('<%=ddlActivityStatus.ClientID %>')
            var WaitingFor = document.getElementById('<%=waitingfor.ClientID %>')

              
             
	            if (ActivityState.value == "4")
	                {
		            WaitingFor.style.display = 'inline';
		            return false;
		            }
            		
	            else
		            {
		            WaitingFor.style.display = 'none';				            
		             return true;
		            }
            		
            }   
            
       function CheckWaitingFor(oSrc, args)
            {
              var ActivityState = document.getElementById('<%=ddlActivityStatus.ClientID %>')
              var WaitingFor = document.getElementById('<%=ddlWaitingFor.ClientID %>')             
                if (ActivityState.value == "4")
                    {	                   
	                    if(WaitingFor.value == "0")
	                    {
	                    args.IsValid = false;
	                    }
	                    else 
	                    {
	                    args.IsValid = true;		                
	                    }		            
	                }            		
                else
	                {    		            	            
	                 args.IsValid = true;		               
	                }
            }
            
      function showAttachFiles()
    {
        document.getElementById("Attachment").style.display='inline';
        setWindowedControlsVisibility(window, 'hidden');
    }
    
    function OnAttachmentSubmit()
    {
      var Fupload = document.getElementById('<%=FileUpload1.ClientID%>')
        var count = 0 
        if (Fupload.value != '' )
        {
        count = count+1
        }
        Fupload = document.getElementById('<%=FileUpload2.ClientID%>')
        if (Fupload.value != '' )
        {
        count = count+1
        }
        Fupload = document.getElementById('<%=FileUpload3.ClientID%>')
        if (Fupload.value != '' )
        {
        count = count+1
        }       
        document.getElementById('AttachmentTotal').innerHTML = count       
	    document.getElementById("Attachment").style.display='none';
	}

 function textCounter(field)
     {
   
        if (field.value.length > 500)        
        field.value = field.value.substring(0, 500);
    }
    
 function ShowUpdateMessage()
     {
        document.getElementById('spnUpdateMessage').style.display = 'inline' ;       
        setTimeout('HideUpdateMessage()' , 3000)
     }
     
 function HideUpdateMessage()
     {       
        document.getElementById('spnUpdateMessage').style.display = 'none' ;
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
	        try{setWindowedControlsVisibility(window, 'visible');}catch(e){}	
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
            TD.innerHTML = str;
         } 
     function ResetAttachment1()
         {
         
            var Fupload = document.getElementById('<%=FileUpload1.ClientID%>');
            var TD = Fupload.parentElement ;
            var str = TD.innerHTML;
            str = str.replace(Fupload.value,'');
            TD.innerHTML = str;
           
         } 
   
    function ResetAttachment3()
        {
         
           var Fupload = document.getElementById('<%=FileUpload3.ClientID%>');
           var TD = Fupload.parentElement ;
           var str = TD.innerHTML;
           str = str.replace(Fupload.value,'');
           TD.innerHTML = str ;
        } 
 
   
 
 </script>   
</head>
<body style="margin: 0px; width: 100%; height: 100%;">
    <form id="form1" runat="server">
        <table align="center" border="0" cellpadding="0" cellspacing="0" class="Table" style="border-right: #609bd3 1px solid;
            border-top: #609bd3 1px solid; border-left: #609bd3 1px solid; width: 100%; border-bottom: #609bd3 1px solid;
            height: 100%; background-color: #ffffff">
            <tr>
                <td style="height: 85px">
                    <table style="border-left-color: #7391b9; border-bottom-color: #7391b9; width: 100%;
                        border-top-color: #7391b9; height: 25%; border-right-color: #7391b9" cellspacing="0"
                        cellpadding="0" align="center" border="0">
                        <tbody>
                            <tr style="background-color: #dde4ee">
                                <td style="height: 31px" colspan="6">
                                    <table cellspacing="0" cellpadding="0" width="100%">
                                        <tbody>
                                            <tr>
                                                <td style="width: 58%; color: #000000; border-bottom: #609bd3 1px solid; height: 31px;
                                                    background-color: #bde7bd" class="SimpleBold" colspan="2">
                                                    &nbsp;<asp:Label ID="lblTitle" runat="server" Text="Add Activity"></asp:Label>
                                                    &nbsp;(&nbsp;<asp:Label ID="lblFranchiseName" runat="server"></asp:Label>&nbsp;)<span style="font-size: 8pt; color: #ff0000">
                                                        </span><span style="display: none; color: #429e8c" id="spnUpdateMessage">
                                                            <span style="color: #000000">-- Record</span><span style="font-size: 8pt; color: #ff0000">
                                                            </span><span style="color: #000000">Updated </span></span>
                                                </td>
                                                <td style="padding-right: 3px; padding-left: 3px; font-weight: bold; font-size: 12px;
                                                    padding-bottom: 3px; width: 125px; cursor: pointer; color: #000000; padding-top: 3px;
                                                    border-bottom: #609bd3 1px solid; height: 1px; background-color: #bde7bd; text-align: right">
                                                    <asp:ScriptManager ID="ScriptManager1" runat="server"
                                                        AsyncPostBackTimeout="300">
                                                    </asp:ScriptManager>
                                                    &nbsp;
                                                </td>
                                                <td style="padding-right: 3px; padding-left: 3px; font-weight: bold; font-size: 12px;
                                                    padding-bottom: 3px; width: 155px; cursor: pointer; color: #437494; padding-top: 3px;
                                                    border-bottom: #609bd3 1px solid; height: 1px; background-color: #bde7bd; text-align: right">
                                                    <img height="20" alt="" src="../images/pixel_skyBlue.jpg" width="1" align="absMiddle" /><img height="20" alt="" src="../images/pixel_skyBlue.JPG"
                                                            width="1" align="absMiddle" />
                                                    &nbsp;
                                                    <asp:LinkButton ID="LinkButton1" runat="server"
                                                        CssClass="HomeButton">
                                                        <div style="width:110px;" class="LeadDetailButton">
                                                            &nbsp;&nbsp; New Message
                                                            <img  src="../images/blt_resetfilters.gif" align="absmiddle" width="10" height="10" style="border:0px;" alt="" />
                                                        </div>                                    
                                                    </asp:LinkButton>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <tr style="border-left-color: #f5f5f5; border-bottom-color: #f5f5f5; border-top-color: #f5f5f5;
                                background-color: #def7d6; border-right-color: #f5f5f5">
                                <td style="width: 2%; height: 25px">
                                </td>
                                <td style="width: 7%" class="SimpleExSmall">
                                    Type:<span style="color: #000000" class="RequiredField">*</span></td>
                                <td style="width: 36%; color: #000000">
                                    <asp:DropDownList ID="ddlFranchiseContact" runat="server"
                                        Width="150px" CssClass="SmallGreenTextBox">
                                    </asp:DropDownList>&nbsp;
                                    <asp:CompareValidator ID="valContact" runat="server"
                                        CssClass="ErrorMessage" ErrorMessage="Select contact" Display="Dynamic" ValueToCompare="0"
                                        Operator="GreaterThan" ControlToValidate="ddlFranchiseContact">
                                    </asp:CompareValidator>
                                </td>
                                <td style="width: 1%">
                                </td>
                                <td style="width: 13%" class="SimpleExSmall">
                                    Type:<span style="color: #000000; background-color: #d8eafc" class="RequiredField">*</span></td>
                                <td style="width: 41%; color: #000000; background-color: #d8eafc">
                                    <asp:DropDownList ID="ddlType" runat="server" Width="150px"
                                        CssClass="SmallGreenTextBox" AutoPostBack="false">
                                        <asp:ListItem Text="Choose..." Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Call" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="Email" Value="4"></asp:ListItem>
                                        <asp:ListItem Text="Fax" Value="5"></asp:ListItem>
                                        <asp:ListItem Text="Meeting" Value="6"></asp:ListItem>
                                        <asp:ListItem Text="Letter" Value="7"></asp:ListItem>
                                        <asp:ListItem Text="Other" Value="8"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CompareValidator ID="valType" runat="server"
                                        CssClass="ErrorMessage" ErrorMessage="Select activity type" Display="Dynamic"
                                        ValueToCompare="0" Operator="GreaterThan" ControlToValidate="ddlType">
                                    </asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" height="1">
                                    <img height="1" alt="" src="../images/spacer.gif" width="1" /></td>
                            </tr>
                            <tr style="border-left-color: #f5f5f5; border-bottom-color: #f5f5f5; border-top-color: #f5f5f5;
                                background-color: #def7d6; border-right-color: #f5f5f5" valign="middle">
                                <td>
                                </td>
                                <td style="height: 25px" class="SimpleExSmall">
                                    Date:
                                </td>
                                <td>
                                    <strong>
                                        <asp:Label ID="lblDate" runat="server" Width="150px"></asp:Label></strong>
                                </td>
                                <td>
                                </td>
                                <td class="SimpleExSmall">
                                    Sub Type:<span class="RequiredField">*</span></td>
                                <td>
                                    <asp:DropDownList ID="ddlSubType" runat="server"
                                        Width="150px" CssClass="SmallGreenTextBox" AutoPostBack="false">
                                        <asp:ListItem Text="Choose..." Value="0"></asp:ListItem>
                                        <asp:ListItem Text="General" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Notice" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Complaint" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="Compliment" Value="4"></asp:ListItem>
                                        <asp:ListItem Text="Violation" Value="5"></asp:ListItem>
                                        <asp:ListItem Text="Weekly call" Value="6"></asp:ListItem>
                                        <asp:ListItem Text="Left message" Value="7"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CompareValidator ID="valSubType" runat="server"
                                        CssClass="ErrorMessage" ErrorMessage="Select activity sub type" Display="Dynamic"
                                        ValueToCompare="0" Operator="GreaterThan" ControlToValidate="ddlSubType">
                                    </asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <img height="1" src="../images/spacer.gif" width="1" /></td>
                            </tr>
                            <tr style="border-left-color: #f5f5f5; border-bottom-color: #f5f5f5; border-top-color: #f5f5f5;
                                background-color: #def7d6; border-right-color: #f5f5f5">
                                <td>
                                </td>
                                <td style="height: 25px" class="SimpleExSmall">
                                    Assigned:<span class="RequiredField">*</span>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlDepartments" runat="server"
                                        Width="150px" CssClass="SmallGreenTextBox">
                                    </asp:DropDownList>&nbsp;
                                    <asp:CompareValidator ID="valDepartment" runat="server"
                                        CssClass="ErrorMessage" ErrorMessage="Select Department" Display="Dynamic" ValueToCompare="0"
                                        Operator="GreaterThan" ControlToValidate="ddlDepartments">
                                    </asp:CompareValidator>
                                </td>
                                <td>
                                </td>
                                <td class="SimpleExSmall">
                                    Time Spent:</td>
                                <td>
                                    <asp:DropDownList ID="ddlHoursNotes" runat="server"
                                        CssClass="SmallGreenTextBox" AutoPostBack="false">
                                        <asp:ListItem Text="00" Value="0" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="01" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="02" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="03" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="04" Value="4"></asp:ListItem>
                                        <asp:ListItem Text="05" Value="5"></asp:ListItem>
                                        <asp:ListItem Text="06" Value="6"></asp:ListItem>
                                        <asp:ListItem Text="07" Value="7"></asp:ListItem>
                                        <asp:ListItem Text="08" Value="8"></asp:ListItem>
                                        <asp:ListItem Text="09" Value="9"></asp:ListItem>
                                        <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                        <asp:ListItem Text="11" Value="11"></asp:ListItem>
                                    </asp:DropDownList>
                                    :
                                    <asp:DropDownList ID="ddlMinutesNotes" runat="server"
                                        CssClass="SmallGreenTextBox" AutoPostBack="false">
                                        <asp:ListItem Text="00" Value="0" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="01" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="02" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="03" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="04" Value="4"></asp:ListItem>
                                        <asp:ListItem Text="05" Value="5"></asp:ListItem>
                                        <asp:ListItem Text="06" Value="6"></asp:ListItem>
                                        <asp:ListItem Text="07" Value="7"></asp:ListItem>
                                        <asp:ListItem Text="08" Value="8"></asp:ListItem>
                                        <asp:ListItem Text="09" Value="9"></asp:ListItem>
                                        <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                        <asp:ListItem Text="11" Value="11"></asp:ListItem>
                                        <asp:ListItem Text="12" Value="12"></asp:ListItem>
                                        <asp:ListItem Text="13" Value="13"></asp:ListItem>
                                        <asp:ListItem Text="14" Value="14"></asp:ListItem>
                                        <asp:ListItem Text="15" Value="15"></asp:ListItem>
                                        <asp:ListItem Text="16" Value="16"></asp:ListItem>
                                        <asp:ListItem Text="17" Value="17"></asp:ListItem>
                                        <asp:ListItem Text="18" Value="18"></asp:ListItem>
                                        <asp:ListItem Text="19" Value="19"></asp:ListItem>
                                        <asp:ListItem Text="20" Value="20"></asp:ListItem>
                                        <asp:ListItem Text="21" Value="21"></asp:ListItem>
                                        <asp:ListItem Text="22" Value="22"></asp:ListItem>
                                        <asp:ListItem Text="23" Value="23"></asp:ListItem>
                                        <asp:ListItem Text="24" Value="24"></asp:ListItem>
                                        <asp:ListItem Text="25" Value="25"></asp:ListItem>
                                        <asp:ListItem Text="26" Value="26"></asp:ListItem>
                                        <asp:ListItem Text="27" Value="27"></asp:ListItem>
                                        <asp:ListItem Text="28" Value="28"></asp:ListItem>
                                        <asp:ListItem Text="29" Value="29"></asp:ListItem>
                                        <asp:ListItem Text="30" Value="30"></asp:ListItem>
                                        <asp:ListItem Text="31" Value="31"></asp:ListItem>
                                        <asp:ListItem Text="32" Value="32"></asp:ListItem>
                                        <asp:ListItem Text="33" Value="33"></asp:ListItem>
                                        <asp:ListItem Text="34" Value="34"></asp:ListItem>
                                        <asp:ListItem Text="35" Value="35"></asp:ListItem>
                                        <asp:ListItem Text="36" Value="36"></asp:ListItem>
                                        <asp:ListItem Text="37" Value="37"></asp:ListItem>
                                        <asp:ListItem Text="38" Value="38"></asp:ListItem>
                                        <asp:ListItem Text="39" Value="39"></asp:ListItem>
                                        <asp:ListItem Text="40" Value="40"></asp:ListItem>
                                        <asp:ListItem Text="41" Value="41"></asp:ListItem>
                                        <asp:ListItem Text="42" Value="42"></asp:ListItem>
                                        <asp:ListItem Text="43" Value="43"></asp:ListItem>
                                        <asp:ListItem Text="44" Value="44"></asp:ListItem>
                                        <asp:ListItem Text="45" Value="45"></asp:ListItem>
                                        <asp:ListItem Text="46" Value="46"></asp:ListItem>
                                        <asp:ListItem Text="47" Value="47"></asp:ListItem>
                                        <asp:ListItem Text="48" Value="48"></asp:ListItem>
                                        <asp:ListItem Text="49" Value="49"></asp:ListItem>
                                        <asp:ListItem Text="50" Value="50"></asp:ListItem>
                                        <asp:ListItem Text="51" Value="51"></asp:ListItem>
                                        <asp:ListItem Text="52" Value="52"></asp:ListItem>
                                        <asp:ListItem Text="53" Value="53"></asp:ListItem>
                                        <asp:ListItem Text="54" Value="54"></asp:ListItem>
                                        <asp:ListItem Text="55" Value="55"></asp:ListItem>
                                        <asp:ListItem Text="56" Value="56"></asp:ListItem>
                                        <asp:ListItem Text="57" Value="57"></asp:ListItem>
                                        <asp:ListItem Text="58" Value="58"></asp:ListItem>
                                        <asp:ListItem Text="59" Value="59"></asp:ListItem>
                                    </asp:DropDownList>
                                    (HH:MM)&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <img height="1" alt="" src="../images/spacer.gif" width="1" /></td>
                            </tr>
                            <tr style="border-left-color: #e9e9e9; border-bottom-color: #e9e9e9; border-top-color: #e9e9e9;
                                background-color: #bde7bd; border-right-color: #e9e9e9">
                                <td style="height: 25px">
                                </td>
                                <td class="SimpleExSmall">
                                    Subject:<span class="RequiredField">*</span></td>
                                <td colspan="3">
                                    <asp:TextBox ID="txtActivitySubject" runat="server"
                                        Width="80%" Text="" CssClass="SmallGreenTextBox" MaxLength="500"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="valSubject" runat="server"
                                        CssClass="ErrorMessage" ErrorMessage="Enter Subject" Display="Dynamic" ControlToValidate="txtActivitySubject">
                                    </asp:RequiredFieldValidator>
                                </td>
                                <td style="white-space: nowrap" class="SimpleExSmallBold" align="right">
                                    &nbsp;
                                    <asp:LinkButton Style="padding-right: 4px; padding-left: 4px; font-size: 11px; padding-bottom: 4px;
                                        width: 90px; padding-top: 4px; height: 18px" ID="btnAddNotes" oncontextmenu="return false;" runat="server" Text="Add Attachments" OnClientClick="showAttachFiles(); return false;"
                                        Font-Underline="true" CausesValidation="false"></asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <img height="1" alt="" src="../images/spacer.gif" width="1" /></td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="width: 100%; height: 100%">
                    <div class="DivScroll" style="vertical-align: top; width: 100%; height: 100%">
                        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%">
                            <tr id="trFiles" class="SimpleExSmallBold" style="border-right: medium none; border-top: medium none;
                                display: none; border-left: medium none; border-bottom: medium none">
                                <td colspan="4" style="height: 25px">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td align="center" rowspan="2" style="border-right: medium none; border-top: medium none;
                                                border-left: medium none; width: 5%; border-bottom: medium none">
                                                <img align="middle" alt="attach" src="../../images/ico_attachment.gif" /></td>
                                            <td id="tdFiles" style="border-right: medium none; border-top: medium none; border-left: medium none;
                                                border-bottom: medium none">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="4" style="border-right: medium none; border-top: medium none;
                                    border-left: medium none; border-bottom: medium none" class="SimpleExSmallBold">
                                    <asp:RequiredFieldValidator ID="valDescription" runat="server" ControlToValidate="txtDescription"
                                        CssClass="ErrorMessage" Display="Dynamic" ErrorMessage="&nbsp;Enter Description">
                                    </asp:RequiredFieldValidator>
                                    <asp:TextBox ID="txtDescription" runat="server" Font-Size="11px" Height="100%" Text=""
                                        TextMode="MultiLine" Width="100%">
                                    </asp:TextBox>
                                    <div id="Attachment" align="center" style="border-right: black 0px solid; border-top: black 0px solid;
                                        display: none; left: 386px; border-left: black 0px solid; width: 300px; border-bottom: black 0px solid;
                                        position: absolute; top: 200px; height: 138px">
                                        <table align="center" cellpadding="0" cellspacing="0" class="MainAlertDiv" width="100%">
                                            <tr>
                                                <th align="left" height="21" valign="middle">
                                                    Attachments
                                                </th>
                                                <th align="right" valign="top">
                                                    <strong>
                                                        <img onclick="OnAttachmentSubmit(0); return false;" src="../../images/closebox.gif"
                                                            style="cursor: pointer" /></strong></th>
                                            </tr>
                                            <tr>
                                                <td colspan="2" valign="middle" width="100%">
                                                    <table align="center" cellpadding="0" cellspacing="0" class="MainAlertDiv" style="border-right: medium none;
                                                        border-top: medium none; border-left: medium none; border-bottom: medium none"
                                                        width="100%">
                                                        <tr>
                                                            <td align="center" colspan="2" height="25">
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
                                                                    <asp:FileUpload ID="FileUpload3" runat="server" Width="240px" /></span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center" colspan="2" height="30">
                                                                <input class="btnExtraSimple" donotdisable="" onclick="OnAttachmentSubmit(0);" type="button"
                                                                    value="Submit" />
                                                                <input class="btnExtraSimple" donotdisable="" onclick="OnAttachmentSubmit(0);" type="button"
                                                                    value="Cancel" /></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr style="background-color: #bde7bd">
                <td style="border-top: #609bd3 1px solid">
                    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%">
                        <tr style="height: 31px">
                            <td class="SimpleExSmall" style="width: 35%">
                                <div id="divStatus" runat="server">
                                    &nbsp;Status:<span class="RequiredField">*</span>&nbsp;
                                    <asp:DropDownList ID="ddlActivityStatus" runat="server" CssClass="SmallGreenTextBox">
                                        <asp:ListItem Text="Select..." Value="0"></asp:ListItem>
                                        <asp:ListItem Selected="True" Text="Not Started" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="In Progress" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Waiting For" Value="4"></asp:ListItem>
                                        <asp:ListItem Text="Completed" Value="3"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CompareValidator ID="valStatus" runat="server" ControlToValidate="ddlActivityStatus"
                                        CssClass="ErrorMessage" Display="Dynamic" ErrorMessage="Select status" Operator="GreaterThan"
                                        ValueToCompare="0">
                                    </asp:CompareValidator>
                                </div>
                            </td>
                            <td class="SimpleExSmall" style="width: 55%">
                                <div id="waitingfor" runat="server" style="display: none">
                                    Waiting For: <span class="RequiredField">*</span>
                                    <asp:DropDownList ID="ddlWaitingFor" runat="server" CausesValidation="True" CssClass="SmallGreenTextBox"
                                        ValidationGroup="WaitingFor" Width="50%">
                                    </asp:DropDownList>
                                    <asp:CustomValidator ID="valwaitingfor" runat="server" ClientValidationFunction="CheckWaitingFor"
                                        CssClass="RequiredField" Display="Dynamic" ErrorMessage="Select Waiting For">                                                                    
                                    </asp:CustomValidator>
                                </div>
                            </td>
                            <td align="right" style="width: 25%">
                                <asp:Button ID="btnSave" runat="server" CausesValidation="True" CssClass="btngreen"
                                    Text="Save" Width="80px" />
                                &nbsp;
                                <button id="btnBack" class="btngreen" name="btnBack" style="width: 80px" type="button">Cancel</button>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>

</body>
</html>
