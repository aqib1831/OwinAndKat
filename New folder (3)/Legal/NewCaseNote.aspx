<%@ Page Language="VB" AutoEventWireup="false" CodeFile="NewCaseNote.aspx.vb" Inherits="admin_Legal_NewCaseNote" validateRequest="false" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <link href="../App_Themes/Default/Calendar/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" src="../scripts/calendar-fs.js"></script>
    <script type="text/javascript" src="../scripts/jquery.js"></script>
   <script>
function Notes()
{

	if(document.getElementById("ddlClose")!==null)
	{
	document.getElementById("tdReminder").style.display='none';
	return false;
	}
	    if (DivNotes.style.display=='none')
	        {
	    		DivNotes.style.display = 'inline';
	    		document.getElementById("ReplyCancel").value="Cancel";
	    		frmActivity.txtNotes.focus();
	    		document.getElementById("txtNotes").value="";
	    	}
    	else
    		{
    			DivNotes.style.display = 'none';
    			document.getElementById("ReplyCancel").value="Reply";
    		}
   }
function chkClosed()
{
    if(document.getElementById("ddlClose").value==2)
        document.getElementById("tdReminder").style.display='none';
}


function OnAttachmentSubmit(flagCancel)
{

    var FileExp = new RegExp("^.*(.txt|.zip|.doc|.jpg|.jpeg|.png|.gif|.doc|.docx|.pdf|.rtf|.xls|.xlsx|.rar|.TXT|.ZIP|.DOC|.DOCX|.XLS|.XLSX|.JPG|.JPEG|.PNG|.GIF|.DOC|.DOCX|.XLS|.XLSX|.RAR|.PDF|.RTF)$"); 
	if (flagCancel == 1)
	{
		ClearFile(1);ClearFile(2);ClearFile(3);
		
	}
	else 
	        {
	             if(!(FileExp.test(trim(document.getElementById('<%=FileUpload1.ClientID%>').value))))
	             {
	                ClearFile(1);
	             }
	             if(!(FileExp.test(trim(document.getElementById('<%=FileUpload2.ClientID%>').value))))
	             {
	             ClearFile(2);
	             }
	             if(!(FileExp.test(trim(document.getElementById('<%=FileUpload3.ClientID%>').value))))
	             {
	             ClearFile(3);
	             }
	         
	        }        
	
	getElement('Attachment').style.display = 'none';
	setWindowedControlsVisibility(window,'visible');
	
	var strFiles = '';
	if (getElement('FileUpload1').value != '')
		strFiles += '<table style=\'display:inline;bordor:0px;\' class=SimpleExSmallBold><tr><td rowspan=2 style=\'bordor:0px;\'>&nbsp;&nbsp;</td><td style=\'bordor:0px;\'>'+trimFileName(getElement('FileUpload1').value.substr(getElement('FileUpload1').value.lastIndexOf("\\")+1))+'</td></tr><tr><td style=\'cursor:pointer;font-size:7px;bordor:0px;\' align=right onClick=\'ClearFile(1);OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>' ;
	if (getElement('FileUpload2').value != '')
		strFiles += '<table style=\'display:inline;bordor:0px;\' class=SimpleExSmallBold><tr><td rowspan=2 style=\'bordor-bottom:none;\'>&nbsp;&nbsp;</td><td style=\'bordor-bottom:none;\'>'+trimFileName(getElement('FileUpload2').value.substr(getElement('FileUpload2').value.lastIndexOf("\\")+1))+'</td></tr><tr><td style=\'cursor:pointer;font-size:7px;\' align=right onClick=\'ClearFile(2);OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>' ;
	if (getElement('FileUpload3').value != '')
		strFiles += '<table style=\'display:inline;bordor:0px;\' class=SimpleExSmallBold><tr><td rowspan=2 style=\'bordor-bottom:none;\'>&nbsp;&nbsp;</td><td style=\'bordor-bottom:none;\'>'+trimFileName(getElement('FileUpload3').value.substr(getElement('FileUpload3').value.lastIndexOf("\\")+1))+'</td></tr><tr><td style=\'cursor:pointer;font-size:7px;\' align=right onClick=\'ClearFile(3);OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>' ;
	
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
}

function showAttachementPreview()
{
	var strFiles = '';
	if (getElement('FileUpload1').value != '')
		strFiles += '<table style=\'display:inline;\' class=SimpleExSmallBold><tr><td rowspan=2 style=\'bordor-bottom:none;\'>&nbsp;&nbsp;</td><td style=\'bordor-bottom:none;\'">'+getElement('FileUpload1').value.substr(getElement('FileUpload1').value.lastIndexOf("\\")+1)+'</td></tr><tr><td style=\'cursor:pointer;font-size:7px;bordor-bottom:none\' align=right></td></tr></table>' ;
	if (getElement('FileUpload2').value != '')
		strFiles += '<table style=\'display:inline;\' class=SimpleExSmallBold><tr><td rowspan=2 style=\'bordor-bottom:none;\'>&nbsp;&nbsp;</td><td style=\'bordor-bottom:none;\'>'+getElement('FileUpload2').value.substr(getElement('FileUpload2').value.lastIndexOf("\\")+1)+'</td></tr><tr><td style=\'cursor:pointer;font-size:7px;bordor-bottom:none\' align=right></td></tr></table>' ;
	if (getElement('FileUpload3').value != '')
		strFiles += '<table style=\'display:inline;\' class=SimpleExSmallBold><tr><td rowspan=2 style=\'bordor-bottom:none;\'>&nbsp;&nbsp;</td><td style=\'bordor-bottom:none;\'>'+getElement('FileUpload3').value.substr(getElement('FileUpload3').value.lastIndexOf("\\")+1)+'</td></tr><tr><td style=\'cursor:pointer;font-size:7px;bordor-bottom:none\' align=right></td></tr></table>' ;
	
	if (strFiles == '')
	{
		getElement('trFilesPreview').style.display = 'none';
		getElement('tdFilesPreview').innerHTML = '';
	}
	else
	{
		getElement('trFilesPreview').style.display = 'inline';
		getElement('tdFilesPreview').innerHTML = strFiles;	
	}
}
function trimFileName(strFileName)
{
	if (strFileName.length > 20)
		return strFileName.substr(0,20)+' ...';
	else
		return strFileName;
}
function ClearFile(num)
{
	getElement('spnFile'+num).innerHTML = '';
	getElement('spnFile'+num).innerHTML = '<input type=file name=FileUpload'+num+' id=FileUpload'+num+' style=width:240px>';
}
function chkStatus()
    {
//        var status=document.getElementById("ddlActivityState").value;
//        if(status=="4")
//        {
//            TDWait.style.display='inline';
//            return false;
//        }
//        else
//        {
//           TDWait.style.display='none';
//           //var validator=document.getElementById("cvAdmins");
//           //validator.style.display='none';
//           setTimeout('__doPostBack(\'ctl00$Content$ddlActivityState\',\'\')', 0);
//           return true;
//        }
    }
    function chkStatus1()
   {
//            var status=document.getElementById("ddlActivityState").value;
//        if(status=="4")
//        {
//            TDWait.style.display='inline';
//        }
//        else
//        {
//           TDWait.style.display='none';
//          // var validator=document.getElementById("cvAdmins");
//          // validator.style.display='none';
//        }
//       
//        if(status=="3")
//        {
//        var ddl=document.getElementById("ddlActivityState");
//        var ddlclose=document.getElementById("ddlClose");
//        ddl.style.display='none';
//        ddlclose.style.display='inline';
//        ddlclose.value=2;
//        }
//        else
//        {
//        var ddl=document.getElementById("ddlActivityState");
//        ddl.style.display='Inline';
//        var ddlclose=document.getElementById("ddlClose");
//        ddlclose.style.display='none';
//        }
//        chkClosed();
if(document.getElementById("ddlClose")!==null)
	{
	document.getElementById("tdReminder").style.display='none';
    document.getElementById("ReplyCancel").style.display='none';
	}
        showReminder();
   
    }
//function chkNStatus(sender,args)
//    {
//        var status=document.getElementById("ddlActivityState").value;
//        if(status==4)
//        {
//            var admin=document.getElementById("ddlAdmins").value;
//            if(admin>0)
//                args.IsValid=true
//            else
//                args.IsValid=false
//        }
//    }
//    function OnActivityOpen()
//    {
//    var ddlclose=document.getElementById("ddlClose");
//    var ddl=document.getElementById("ddlActivityState");
//        if(ddlclose.value==1)
//        {
//        ddlclose.style.display="none";
//        ddl.style.display="inline";
//        ddl.value=1;
//         setTimeout('__doPostBack(\'ctl00$Content$ddlActivityState\',\'\')', 0);
//        }
//        
//    }
    
function onNoteSave()
    {
        //DivCloseMessage.style.display="inline";
        setWindowedControlsVisibility(window,'visible');
        return false;
    }
    function chkTime(sender,args)
    {
       var hours=document.getElementById("ddlHours").value;
    var mins=document.getElementById("ddlMins").value;
    if(hours==0&&mins==0)
    {
        args.IsValid=false;
       
       setWindowedControlsVisibility(window,'visible');
         //alert('Please Select Time Spent.');
    }
    else 
    args.IsValid=true;
    }
    
  function ValidateReminder(sender,args)
    {
      if(document.getElementById("chkReminder").checked==true)
        {
           args.IsValid=true;
          }
            else
            {
            args.IsValid=false;
            }
        
    }
    function ValidateCost(sender,args)
    {
         var ntype=document.getElementById("ddlNType").value;
        var cost=document.getElementById("txtCost").value;
        if(cost=="")
        {
        args.IsValid=false;
        }
        else if(cost<0)
        {
        args.IsValid = false;
        }
        else
        {
            
            var regdigit=/^\d+(\.\d\d)?$/;
            if (!cost.match(regdigit)) 
                args.IsValid=false;
            else     
                args.IsValid=true;
        }
    }
       function EditReminder()
    {   
      //document.getElementById("lnkRemAdd").style.display='none';
      // document.getElementById("lnkEditRem").style.display='inline';
      // document.getElementById("lnkRemove").style.display='inline';
      // document.getElementById("lnkRemSave").style.display='none';
    }
    function AddReminder()
    {   
      //document.getElementById("lnkRemAdd").style.display='inline';
      // document.getElementById("lnkEditRem").style.display='none';
       //document.getElementById("lnkRemove").style.display='none';
       //document.getElementById("lnkRemSave").style.display='none';
    }
     function SaveReminder()
    {   
     // document.getElementById("lnkRemAdd").style.display='none';
      // document.getElementById("lnkEditRem").style.display='none';
       //document.getElementById("lnkRemove").style.display='none';
      // document.getElementById("lnkRemSave").style.display='inline';
    }
    function enableReminder()
    {
    // document.getElementById('txtReminderDate').onfocus=this.blur();
    //    document.getElementById('txtReminderDate').onclick="this.blur();setActiveStyleSheet(this, 'calstyle'); return showCalendar('txtReminderDate', 'MM/dd/y');"
    }
    function showReminder()
    {
        if(document.getElementById("chkReminder").checked==true){
            document.getElementById("tdDate").style.display='inline';
            document.getElementById("tdCalender").style.display='inline';
            document.getElementById("tdTime").style.display='inline';
            document.getElementById("tdReminderMsg").style.display='none';
            document.getElementById("tdRemChk").style.display='inline';
            try{document.getElementById("lnkRemAdd").style.display='inline';}catch(ex){}
        }else{
            document.getElementById("tdDate").style.display='none';
            document.getElementById("tdCalender").style.display='none';
            document.getElementById("tdTime").style.display='none';
            document.getElementById("rfvchkReminder").style.display='none';
            document.getElementById("tdReminderMsg").style.display='inline';
            try{document.getElementById("lnkRemAdd").style.display='none';}catch(ex){}
        }
        if (document.getElementById("chkReminder").disabled==true) {try{document.getElementById("lnkRemAdd").style.display='none';}catch(ex){}}
    }
    function ShowAddedReminder()
    {
        document.getElementById("tdRemChk").style.display='none';
        document.getElementById("tdDate").style.display='none';
        document.getElementById("tdCalender").style.display='none';
        document.getElementById("tdTime").style.display='none';
        document.getElementById("tdReminderMsg").style.display='inline';
        document.getElementById("tdButtons").style.display='inline';
    }
    </script>

    <title>New Activity Note</title>
</head>
<body style="margin: 0px; height: 100%; width: 100%; padding: 0px;" scroll="no" class="DivScroll" onload="chkStatus1();">
    <form id="frmActivity" runat="server">
    <asp:HiddenField ID="hdnWaiting" runat="server" Value="0" />
        <table id="tblMain"  height="100%" cellspacing="0" cellpadding="0"
            width="100%" align="center" border="0" class="table">
            <tbody>
                <tr style="cursor: default">
                    <td style="border-bottom: white 1px solid; padding-left: 8px; height: 31px;background-color: #bde7bd; " colspan="2" class="SimpleBold">
                        <strong>Activity Detail</strong>
                    </td>
                    <td class="" align="right" style="border-bottom: white 1px solid; height: 31px;background-color: #bde7bd; ">&nbsp;
                  </td>
                </tr>
                <tr>
                    <td valign="top" colspan="3">
                        <table style="border-right: medium none; border-top: medium none; border-left: medium none;
                            border-bottom: medium none; width:100%;" height="100%" cellspacing="0"
                            cellpadding="0" width="100%" align="center" border="0"  class="Table">
                            <tbody>
                                  <tr height="25" style="display: none;">
                                    <td colspan="2" style="background-color: #DAF5D6; height: 24px;">
                                        &nbsp;<asp:HiddenField ID="hdnCaseID" runat="server" />
                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                                        <asp:SqlDataSource ID="sdsCaseActivityType" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                            SelectCommand="SELECT * FROM [Legal_CaseActivityTypes] WHERE ([Deleted] = @Deleted)">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="false" Name="Deleted" Type="Boolean" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <asp:HiddenField ID="hdnReminderDate" runat="server" />
                                        &nbsp;
                                        &nbsp;&nbsp;
                    </td>
                                    <td align="right" colspan="2" style="background-color: #DAF5D6; height: 24px; border-bottom: white 1px solid;">
                                    
                                                        <asp:SqlDataSource ID="ComplianceAdminsDS" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                            SelectCommand="Legal_GetComplianceUsers" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                    
                                    </td>
                                </tr>
                                <tr height="25">
                                    <td style="width: 107px; background-color: #DAF5D6; border-bottom: white 1px solid; padding-left: 8px;" class="SimpleExSmall">
                                        Case Name:</td>
                                    <td style="width: 320px; height: 25px; background-color: #DAF5D6; border-bottom: white 1px solid;" class="SimpleExSmall">
                                        <b><asp:Label ID="lblCaseName" runat="server"></asp:Label></b></td>
                                    <td align="left" style="width: 96px; height: 25px; background-color: #DAF5D6; border-bottom: white 1px solid;" class="SimpleExSmall">
                                        Assigned to:</td>
                                    <td style="width: 150px; height: 25px; background-color: #DAF5D6; border-bottom: white 1px solid;" class="SimpleExSmall">
                                        <b><asp:Label ID="lblAssignedTo" runat="server"></asp:Label></b></td>
                                </tr>
                                <tr height="25">
                                    <td style="width: 107px; background-color: #DAF5D6; border-bottom: white 1px solid; padding-left: 8px;" class="SimpleExSmall">
                                        Type:</td>
                                    <td style="width: 320px; height: 25px; background-color: #DAF5D6; border-bottom: white 1px solid;" class="SimpleExSmall">
                                        <b><asp:Label ID="lblType" runat="server"></asp:Label></b></td>
                                    <td align="left" style="width: 96px; height: 25px; background-color: #DAF5D6; border-bottom: white 1px solid;" class="SimpleExSmall">
                                        Entered By:</td>
                                    <td style="width: 150px; height: 25px; background-color: #DAF5D6; border-bottom: white 1px solid;" class="SimpleExSmall">
                                        <b><asp:Label ID="lblFrom" runat="server"></asp:Label></b></td>
                                </tr>
                                <tr height="25">
                                    <td style="width: 107px; background-color: #DAF5D6; border-bottom: white 1px solid; padding-left: 8px;" class="SimpleExSmall">
                                        Time Spent:</td>
                                    <td style="width: 320px; height: 25px; background-color: #DAF5D6; border-bottom: white 1px solid;" class="SimpleExSmall">
                                    <b><asp:Label ID="lblTimeSpent" runat="server"></asp:Label></b>
                                        </td>
                                    <td align="left" style="width: 96px; height: 25px; background-color: #DAF5D6; border-bottom: white 1px solid;" class="SimpleExSmall">
                                        Cost:</td>
                                    <td style="width: 150px; height: 25px; background-color: #DAF5D6; border-bottom: white 1px solid;" class="SimpleExSmall">
                                        <b><asp:Label ID="lblCost" runat="server"></asp:Label></b>&nbsp;</td>
                                </tr>
                                <tr height="25" class="HeaderRowGreen">
                                    <td style="width: 107px; padding-left: 8px;" class="SimpleExSmall">
                                        Subject:</td>
                                    <td colspan="2" class="SimpleExSmall">
                                        <b><asp:Label ID="lblSubject" runat="server"></asp:Label></b></td>
                                    <td style="" align="right">
                                        <span class="SimpleExSmallBold">&nbsp;<input style="width: 96px" id="ReplyCancel" class="btn" onclick="Notes();"
                                                type="button" value="Reply" name="btnAttach" /></span> &nbsp;&nbsp;
                                    </td>
                                </tr>
                                <tr style="display: none;" id="trFiles">
                                    <td colspan="5" height="25" style="background-color:#FAFCCE;border:1px solid #50AF43;">
                                        <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                            <tbody>
                                                <tr>
                                                    <td style="padding-right: 5px;" align="right" width="5%" rowspan="2">
                                                        <img src="../images/ico_attachment.gif" align="middle" /></td>
                                                    <td id="tdFiles" class="SimpleExSmallBold">
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="5">
                                        <div style="display: none" id="DivNotes">
                                            <table style="padding-right: 2px; padding-left: 2px; padding-bottom: 2px; padding-top: 2px; background-color:#DAF5D6;"                                                cellspacing="0" cellpadding="0" width="100%">
                                                <tbody>
                                                    <tr>
                                                        <td class="SimpleExSmallBold" valign="top" width="86%" style="height: 119px">
                                                            <span id="Notes_Type" class="SimpleExSmallBold">
                                                                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%" class="Table">
                                                                    <tr>
                                                                        <td style="border-right: medium none; border-top: medium none; border-left: medium none;
                                                                            border-bottom: medium none; padding-top: 5px;">
                                                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                                <tr>
                                                                                    <td style="width: 30px; border-top-style: none; border-right-style: none; border-left-style: none;
                                                                                        border-bottom-style: none; padding-left: 8px;" class="SimpleExSmall">
                                                                                        Type:</td>
                                                                                    <td style="width: 80px; border-top-style: none; border-right-style: none; border-left-style: none;
                                                                                        border-bottom-style: none">
                                                                                        <asp:DropDownList ID="ddlNType" runat="server" CssClass="mediumfontinput" Width="95px">
                                                                                            <asp:ListItem Value="-1">Choose...</asp:ListItem>
                                                                                            <asp:ListItem Value="1">Call</asp:ListItem>
                                                                                            <asp:ListItem Value="2">Application</asp:ListItem>
                                                                                            <asp:ListItem Value="3">Letter</asp:ListItem>
                                                                                            <asp:ListItem Value="4">Fax</asp:ListItem>
                                                                                            <asp:ListItem Value="5">Meeting</asp:ListItem>
                                                                                            <asp:ListItem Value="7">Bill</asp:ListItem>
                                                                                            <asp:ListItem Value="6">Other</asp:ListItem>
                                                                                        </asp:DropDownList></td>
                                                                                    <td style="width: 72px; border-top-style: none; border-right-style: none; border-left-style: none;
                                                                                        border-bottom-style: none" class="SimpleExSmall">
                                                                                        &nbsp;TimeSpent:</td>
                                                                                    <td style="width: 80px; border-top-style: none; border-right-style: none; border-left-style: none;
                                                                                        border-bottom-style: none">
                                                                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                                            <tr>
                                                                                                <td align="right" style="font-size: 7pt; width: 71px; border-top-style: none; font-style: italic;
                                                                                                    border-right-style: none; border-left-style: none; font-variant: normal; border-bottom-style: none" class="SimpleExSmall">
                                                                                                    <asp:DropDownList ID="ddlHours" runat="server" CssClass="mediumfontinput" Width="49px">
                                                                                                        <asp:ListItem Value="00">HH</asp:ListItem>
                                                                                                        <asp:ListItem>01</asp:ListItem>
                                                                                                        <asp:ListItem>02</asp:ListItem>
                                                                                                        <asp:ListItem>03</asp:ListItem>
                                                                                                        <asp:ListItem>04</asp:ListItem>
                                                                                                        <asp:ListItem>05</asp:ListItem>
                                                                                                        <asp:ListItem>06</asp:ListItem>
                                                                                                        <asp:ListItem>07</asp:ListItem>
                                                                                                        <asp:ListItem>08</asp:ListItem>
                                                                                                        <asp:ListItem>09</asp:ListItem>
                                                                                                        <asp:ListItem>10</asp:ListItem>
                                                                                                        <asp:ListItem>11</asp:ListItem>
                                                                                                    </asp:DropDownList></td>
                                                                                                <td align="right" style="font-size: 7pt; width: 71px; border-top-style: none; font-style: italic;
                                                                                                    border-right-style: none; border-left-style: none; font-variant: normal; border-bottom-style: none">
                                                                                                    <asp:DropDownList ID="ddlMins" runat="server" CssClass="mediumfontinput" Width="49px" class="SimpleExSmall">
                                                                                                        <asp:ListItem Value="00">MM</asp:ListItem>
                                                                                                        <asp:ListItem>05</asp:ListItem>
                                                                                                        <asp:ListItem>10</asp:ListItem>
                                                                                                        <asp:ListItem>15</asp:ListItem>
                                                                                                        <asp:ListItem>20</asp:ListItem>
                                                                                                        <asp:ListItem>25</asp:ListItem>
                                                                                                        <asp:ListItem>30</asp:ListItem>
                                                                                                        <asp:ListItem>35</asp:ListItem>
                                                                                                        <asp:ListItem>40</asp:ListItem>
                                                                                                        <asp:ListItem>45</asp:ListItem>
                                                                                                        <asp:ListItem>50</asp:ListItem>
                                                                                                        <asp:ListItem>55</asp:ListItem>
                                                                                                    </asp:DropDownList></td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </td>
                                                                                        
                                                                                    <td align="right" style="width: 40px; border-top-style: none; border-right-style: none;
                                                                                        border-left-style: none; border-bottom-style: none" class="SimpleExSmall">
                                                                                        Cost:</td>
                                                                                    <td align="right" style="width: 80px; border-top-style: none; border-right-style: none;
                                                                                        border-left-style: none; border-bottom-style: none">
                                                                                        <asp:TextBox ID="txtCost" runat="server" Width="70px" CssClass="MediumGreenTextBox" MaxLength="10"></asp:TextBox></td>
                                                                                    <td align="right" style="width: 80px; border-top-style: none; border-right-style: none;
                                                                                        border-left-style: none; border-bottom-style: none">
                                                                                        &nbsp;</td>
                                                                                    
                                                                                    <td style="width: 80px; border-top-style: none; border-right-style: none; border-left-style: none;
                                                                                        border-bottom-style: none" align="right">
                                                                                    </td>
                                                                                    <td align="right" style="width: 80px; border-top-style: none; border-right-style: none;
                                                                                        border-left-style: none; border-bottom-style: none">
                                                                                    </td>
                                                                                    <td align="right" style="width: 80px; border-top-style: none; border-right-style: none;
                                                                                        border-left-style: none; border-bottom-style: none">
                                                                                    </td>
                                                                                
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="3" style="border-right: medium none; border-top: medium none; border-left: medium none;
                                                                                        border-bottom: medium none; height: 2px; padding-left: 10px;">
                                                                                        <asp:RequiredFieldValidator 
                                                                                            SetFocusOnError="true" 
                                                                                            ID="rfvNType" 
                                                                                            runat="server" 
                                                                                            ControlToValidate="ddlNType"
                                                                                            Display="Dynamic" 
                                                                                            ErrorMessage="Select activity type." 
                                                                                            InitialValue="-1" 
                                                                                            CssClass="RequiredField" SkinID="RequiredFieldValidation" ></asp:RequiredFieldValidator>
                                                                                    </td>
                                                                                    <td colspan="2" style="border-right: medium none; border-top: medium none; border-left: medium none;
                                                                                        border-bottom: medium none; height: 2px">
                                                                                        <asp:CustomValidator 
                                                                                            SetFocusOnError="true" 
                                                                                            ID="cvTimeSpent" 
                                                                                            runat="server"
                                                                                            ClientValidationFunction="chkTime" 
                                                                                            CssClass="RequiredField" 
                                                                                            Display="Dynamic"
                                                                                            ErrorMessage="Select time spent.">
                                                                                        </asp:CustomValidator>
                                                                                    </td> 
                                                                                    <td colspan="2" style="border-right: medium none; border-top: medium none; border-left: medium none;
                                                                                        border-bottom: medium none; height: 2px">
                                                                                       <asp:CustomValidator SetFocusOnError="true" ID="cvCost" runat="server" CssClass="RequiredField" Display="Dynamic"
                                                                                            ErrorMessage="Enter valid cost." ClientValidationFunction="ValidateCost"></asp:CustomValidator>
                                                                                            
                                                                                                                                                                                   
                                                                                            </td>
                                                                                    <td colspan="3" style="border-right: medium none; border-top: medium none; border-left: medium none;
                                                                                        border-bottom: medium none; height: 2px">
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                        <td rowspan="2" style="border-right: medium none; border-top: medium none; border-left: medium none;
                                                                            border-bottom: medium none">
                                                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                                                <tbody>
                                                                                    <tr height="25">
                                                                                        <td align="center" style="border-right: medium none; border-top: medium none; border-left: medium none;
                                                                                            border-bottom: medium none">
                                                                                            <input id="btnAttach" class="btn" name="btnAttach" onclick="try{Attachment.style.display = 'inline'; setWindowedControlsVisibility(window,'hidden'); return false;} catch(e){return false;}"
                                                                                                style="width: 85px" type="button" value="Attach Files" />
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr height="25">
                                                                                        <td align="center" style="border-right: medium none; border-top: medium none; border-left: medium none;
                                                                                            border-bottom: medium none">
                                                                                            <asp:Button ID="btnSave" runat="server" CssClass="btn" Style="width: 85px" Text="Save" />
                                                                                        </td>
                                                                                    </tr>
                                                                                </tbody>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="border-right: medium none; border-top: medium none; border-left: medium none;
                                                                            border-bottom: medium none; padding-left: 8px; padding-top: 5px;">
                                                                            Notes<br />
                                                                            <asp:textbox ID="txtNotes" runat="server" onkeypress="if(event.keyCode==27) Notes();"
                                                                                style="border-right: black 1px solid; border-top: black 1px solid; border-left: black 1px solid;
                                                                                width: 640; border-bottom: black 1px solid; font-size:11px;" Rows="6" TextMode="MultiLine" ></asp:textbox>
                                                                                <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtNotes"
                                                                                    CssClass="RequiredField" ErrorMessage="Please! enter notes" Display="Dynamic">
                                                                                </asp:RequiredFieldValidator>
                                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ControlToValidate="txtNotes"
                                                                                ErrorMessage="Note cannot be greater than 2000 characters." ValidationExpression="^[\s\S]{0,2000}$"
                                                                                Display="Dynamic" CssClass="RequiredField"  runat="Server" SetFocusOnError="true" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </span> </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                   <div style="overflow: auto; width: 100%; height: 100%; background-color: White;" ondblclick="Notes();" align="left">
                                            <asp:Repeater ID="Repeater1" runat="server" EnableTheming="True" DataSourceID="ActivityNotesDS">
                                                <HeaderTemplate>
                                                    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color: White;
                                                        background: none; border-right: solid 1px white;">
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr style="width: 100%">
                                                        <td style="background-color: White; border-bottom: none; padding-left: 10px;
                                                            padding-top: 5px" colspan="5" class="SimpleExSmall">
                                                            <span><asp:Label ID="lblNotesCaption" runat="server" Text="Notes Added "  class="SimpleExSmall"/> by
                                                                <b><asp:Label ID="Label1" runat="server" Text='<%#Eval("AdminName")%>'></asp:Label></b></span>
                                                            on
                                                            <b><asp:Label ID="Label2" runat="server" Text='<%#Eval("Date") %>'></asp:Label> - EST</b>
                                                            <br />
                                                            <font size="1" class="SimpleExSmall">Type:&nbsp;<b><asp:Label ID="rptTime" runat="server" Text='<%#CaseMgmt.GetActivityTypeID(CInt(Eval("Type"))) %>'></asp:Label></b>&nbsp;Time Spent:&nbsp;<b><asp:Label ID="Label5" runat="server" Text='<%# IIF(Eval("TimeSpent").ToString() <> "",Eval("TimeSpent").ToString().Substring(0,5)+" (HH:MM)","&nbsp;") %>'></asp:Label></b><span style=<%#IIF(Eval("Cost").ToString()<>"0.0000","width: 200px; background-color: White; border-bottom: none; padding-top: 5px;display:inline;","display:none;") %>> &nbsp;&nbsp;Cost:&nbsp;
                                                                <b><asp:Label ID="Label6" runat="server" Text='<%#Decimal.Round(Eval("Cost"),2) %>'></asp:Label></b></span></font></td>
                                                       
                                                    </tr>
                                                    <tr><td style="background-color: White; border-bottom: none; padding-left: 10px;" colspan="5" class="SimpleExSmall"><br />
                                                        <asp:Repeater ID="Attachments" runat="server" DataSource='<%# Container.DataItem.CreateChildView("NOTE_ATTACH") %>'>
                                                            <ItemTemplate>
                                                                [<img src="../images/ico_attachment.gif" style="" align="absmiddle" />
                                                                <!-- <a href='<%#ConfigurationManager.AppSettings("CaseAttachPath")+Eval("FilePath") %>' -->
                                                                <a href='download.aspx?ID=<%# Container.DataItem("ID") %>'
                                                                    target="_blank" style="text-decoration: underline;" class="SimpleExSmall"><b>
                                                                        <asp:Label ID="Label4" runat="server" Text='<%#CaseMgmt.GetAttachmentFileName(Eval("FilePath")) %>'></asp:Label></b></a>&nbsp;&nbsp;]
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                    <%--<asp:ObjectDataSource ID="AttachmentsDS" runat="server" SelectMethod="Legal_GetAttachments"
                                                        TypeName="IntellectualProperty">
                                                        <SelectParameters>
                                                            <asp:Parameter DefaultValue="0" Name="NoteID" Type="Int32" />
                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>--%></td>
                                                    </tr>
                                                    <tr>
                                                   
                                                        <td colspan="5" style="background-color: White; padding-left: 10px; border-bottom: dashed 1px grey; padding-right: 10px; width:540px;">
                                                              <br />  <asp:Literal ID="Label3" runat="server"  Text='<%#Server.HtmlEncode(CType(Container.DataItem("Notes"),String)).Replace(vbCrLf,"<br />")%>'></asp:Literal><br />
                                                            <br />
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    </table></FooterTemplate>
                                            </asp:Repeater>
                                            <asp:ObjectDataSource ID="ActivityNotesDS" runat="server" SelectMethod="GetNotesByActivtyID"
                                                TypeName="CaseMgmt">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="ActivityID" QueryStringField="ID" Type="Int32" />
                                                </SelectParameters>
                                            </asp:ObjectDataSource>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6" style=" height: 31px; border-top: #50af43 1px solid;">
                                        <table border="0" cellpadding="0" cellspacing="0" height="31" width="100%" class="table">
                                            <tbody>
                                                <tr class="headerrowgreen">
                                                    <td style="width: 260px; border-bottom: medium none; height: 31px">
                                                        
                                                                <table border="0" cellpadding="0" cellspacing="0">
                                                                    <tr>
                                                                        <td align="left" style="border-right: medium none; border-top: medium none; border-left: medium none;
                                                                            border-bottom: medium none" width="145">
                                                                    Status :<asp:DropDownList ID="ddlActivityState" runat="server" AutoPostBack="True"
                                                                                CssClass="mediumfontinput" onchange="chkStatus();" ValidationGroup="status" Width="95px">
                                                                                <asp:ListItem Value="1">Not Started</asp:ListItem>
                                                                                <asp:ListItem Value="2">In Progress</asp:ListItem>
                                                                                <asp:ListItem Value="3">Complete</asp:ListItem>
                                                                                <asp:ListItem Value="4">Waiting For</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                            <asp:DropDownList CssClass="mediumfontinput" ID="ddlClose" runat="server" AutoPostBack="True"
                                                                                ValidationGroup="status" Visible="False">
                                                                                <asp:ListItem Value="2">Closed</asp:ListItem>
                                                                                <asp:ListItem Selected="True" Value="1">Open</asp:ListItem>
                                                                            </asp:DropDownList><asp:HiddenField runat="server" ID="hdnActivityState" Value="" /> </td>
                                                                        <td id="TDWait" style="border-right: medium none; border-top: medium none; border-left: medium none;
                                                                            border-bottom: medium none" width="90">
                                                                            <asp:DropDownList ID="ddlAdmins" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                                                                CausesValidation="True" CssClass="mediumfontinput" DataSourceID="ComplianceAdminsDS"
                                                                                DataTextField="Name" DataValueField="ID" ValidationGroup="status" Visible="False"
                                                                                Width="110px">
                                                                                <asp:ListItem Value="0">Choose...</asp:ListItem>
                                                                            </asp:DropDownList></td>
                                                                    </tr>
                                                                </table>
                                                            
                        </td>
                                                    <td align="left" style="border-bottom: medium none; height: 31px" width="350">
                                                        <%--<asp:UpdatePanel ID="UPReminder" runat="server">
                                                            <ContentTemplate>--%>
                                                                <table id="tdReminder" border="0" cellpadding="0" cellspacing="0" width="350" height="31">
                                                                    <tr>
                                                                        <td id="tdReminderMsg" align="right" colspan="4" style="font-size: 8pt; border-top-style: none;
                                                                            border-right-style: none; border-left-style: none; border-bottom-style: none">
                                                                            <asp:Label ID="lblReminderMsg" runat="server"></asp:Label>
                                                                            </td>
                                                                        <td colspan="1" style="border-top-style: none; border-right-style: none; border-left-style: none;
                                                                            border-bottom-style: none">
                                                                        </td>
                                                                        <td colspan="1" style="border-top-style: none; border-right-style: none; border-left-style: none;
                                                                            border-bottom-style: none">
                                                                        </td>
                                                                        <td colspan="1" style="border-top-style: none; border-right-style: none; border-left-style: none;
                                                                            border-bottom-style: none">
                                                                        </td>
                                                                        <td colspan="1" style="border-top-style: none; border-right-style: none; border-left-style: none;
                                                                            border-bottom-style: none">
                                                                        </td>
                                                                        <td id="tdButtons" colspan="1" rowspan="2" style="border-top-style: none; border-right-style: none;
                                                                            border-left-style: none; border-bottom-style: none">
                                                                            <asp:LinkButton
                                                                                ID="lnkEditRem" runat="server" CausesValidation="False" Font-Size="XX-Small">[ Edit ]</asp:LinkButton><asp:LinkButton
                                                                                    ID="lnkRemSave" runat="server" Font-Size="XX-Small" ValidationGroup="Rem">[ Save ]</asp:LinkButton><asp:LinkButton
                                                                                        ID="lnkRemove" runat="server" CausesValidation="False" Font-Size="XX-Small" OnClientClick="return confirm('Are you sure you want to remove reminder from this activity?')">[ Remove ]</asp:LinkButton></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td id="tdRemChk" style="width: 20px; border-top-style: none; border-right-style: none;
                                                                            border-left-style: none; border-bottom-style: none">
                                                                            <asp:CheckBox ID="chkReminder" runat="server" CausesValidation="True" Font-Size="X-Small"
                                                                                Height="16px" onclick="showReminder();"
                                                                                Text="Reminder" ValidationGroup="Rem" Width="80px" /></td>
                                                                        <td id="tdDate" style="width: 72px; border-top-style: none; border-right-style: none;
                                                                            border-left-style: none; border-bottom-style: none">
                                                                            <asp:TextBox CssClass="MediumGreenTextBox" ID="txtReminderDate" runat="server" CausesValidation="True"
                                                                                ReadOnly="true" ValidationGroup="Rem" Width="70px"></asp:TextBox></td>
                                                                        <td id="tdCalender" style="border-top-style: none; border-right-style: none; border-left-style: none;
                                                                            border-bottom-style: none" width="16">
                                                                            <asp:ImageButton ID="imgCalender" runat="server" Height="16px" ImageUrl="~/images/icn_calendar.png"
                                                                                OnClientClick="setActiveStyleSheet(this, 'calstyle'); return showCalendar('txtReminderDate', 'MM/dd/y');"
                                                                                Width="16px" /></td>
                                                                        <td id="tdTime" style="font-size: 8pt; width: 75px; color: black; border-top-style: none;
                                                                            font-style: normal; font-family: Verdana; border-right-style: none; border-left-style: none;
                                                                            font-variant: normal; border-bottom-style: none">
                                                                            <asp:DropDownList ID="ddlTime" runat="server" CausesValidation="True" CssClass="mediumfontinput"
                                                                                Height="18px" ValidationGroup="Rem" Width="100px">
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
                                                                        <td style="font-size: 8pt; width: 75px; color: black; border-top-style: none; font-style: normal;
                                                                            font-family: Verdana; border-right-style: none; border-left-style: none; font-variant: normal;
                                                                            border-bottom-style: none" colspan="">
                                                                            <asp:LinkButton ID="lnkRemAdd" runat="server" Font-Size="XX-Small" ValidationGroup="Rem">[ Add ]</asp:LinkButton></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="4" style="border-right: medium none; border-top: medium none; border-left: medium none;
                                                                            border-bottom: medium none; height: 0px">
                                                                            <asp:CustomValidator SetFocusOnError="true" ID="CustomValidator1" runat="server" ClientValidationFunction="ValidateReminder"
                                                                                CssClass="RequiredField" Display="Dynamic" ErrorMessage="Please! check the reminder box."
                                                                                ValidationGroup="Rem"></asp:CustomValidator>
                                                                            <asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvchkReminder" runat="server" ControlToValidate="txtReminderDate"
                                                                                CssClass="RequiredField" Display="Dynamic" ErrorMessage="Please! enter reminder date."
                                                                                ValidationGroup="Rem"></asp:RequiredFieldValidator>
                                                                            <asp:Label ID="lblMsg" runat="server" CssClass="RequiredField"></asp:Label></td>
                                                                    </tr>
                                                                    
                                                                </table>
                                                           
                                                    </td>
                                                    <td align="left" colspan="1" style="border-bottom: medium none; height: 31px">
                                                        &nbsp;</td>
                                                    <td align="right" style="width: 100px; border-bottom: medium none; height: 31px"
                                                        width="100">
                                                        <asp:Button ID="LnkBack" runat="server" CausesValidation="False" CssClass="btn" Style="width: 85px;
                                                            text-align: center" Text="Back" /></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <tr style="height: 1px;" class="headerrowgreen">
                                    <td colspan="6" style="height: 1px;" align="center">
                                        <asp:CompareValidator ValidationGroup="Rem"  ID="cmpDate" runat="server" Display="Dynamic"
                                            ControlToValidate="txtReminderDate" ControlToCompare="hdnCurrentDate" Operator="GreaterThan"
                                            ErrorMessage="Date must be in future." Type="Date"></asp:CompareValidator>
                                        <asp:TExtBox  ID="hdnCurrentDate"  ValidationGroup="Rem"  runat="server" style="display:none;" />         
                                   </td>
                                </tr>

                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
        <div align="center" id="Attachment" style="display: none; border: 0px solid black;
            position: absolute; left: 248px; top: 228px; width: 300px; height: 138px;">
            <table align="center" width="100%" cellpadding="0" cellspacing="0" class="MainAlertDiv">
                <tr>
                    <th height="21" align="left" valign="middle">
                        Attachments
                    </th>
                    <th align="right" valign="top">
                             <img src="../images/closebox2.gif" onClick="OnAttachmentSubmit(0); return false;"
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
                                    &nbsp;File 1: <span id="spnFile1">
                                        <asp:FileUpload ID="FileUpload1" runat="server" Width="240px" /></span><br />
                                    &nbsp;File 2: <span id="spnFile2">
                                        <asp:FileUpload ID="FileUpload2" runat="server" Width="240px" /></span><br />
                                    &nbsp;File 3: <span id="spnFile3">
                                        <asp:FileUpload ID="FileUpload3" runat="server" Width="240px" /></span>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" height="30" align="center">
                                    <input type="button" value="OK" onClick="OnAttachmentSubmit(0);" 
                                        class="btnExtraSimple" />
                                    
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <asp:SqlDataSource ID="AdminsDS" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                    SelectCommand="Legal_GetAllUsers" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    </form>
</body>
</html>
