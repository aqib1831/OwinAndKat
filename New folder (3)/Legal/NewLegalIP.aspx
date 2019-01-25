<%@ Page Language="VB" AutoEventWireup="false" CodeFile="NewLegalIP.aspx.vb" Inherits="admin_Legal_NewLegal" Theme="Default" validateRequest="false" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>New Legal IP</title>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/functions.js"></script>
    <link href="../style/style.css" type="text/css" rel="stylesheet" />
    <link href="../Style/Style.css" type="text/css" rel="stylesheet" />
    <link href="../style/Calendar/style.css" type="text/css" rel="stylesheet" />
    <style type="text/css">
    .tableInfo
    {
      border:0px;
      cellpadding:0px;
      cellspacing:0px;
    }
    .tableInfo td
    {
        padding-left:0px;
        padding-top:2px;
        padding-bottom:1px;
        font-size:11px; 
    }
    .SummaryValidationDiv
    {
        border: 1px solid #6095B5;
        filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#C8E2FC,endColorStr=#EFF6FC);
        left: 20%;
        top: 15%;    
        width: 25%;
        border-bottom-style:groove;  
        z-index:20;
    }
    
    </style>
    <script type="text/javascript" language="javascript">
    function trim(str, chars) 
    {
    return ltrim(rtrim(str, chars), chars);
    }

    function ltrim(str, chars) 
    {
    chars = chars || "\\s";
    return str.replace(new RegExp("^[" + chars + "]+", "g"), "");
    }

    function rtrim(str, chars) 
    {
    chars = chars || "\\s";
    return str.replace(new RegExp("[" + chars + "]+$", "g"), "");
    }
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
    function chkSerial(sender,args)
    { 
       var status=document.getElementById("ddlStatus").value;
        if(status==3)
        {
        var serial=document.getElementById("txtSerialNo").value;
            if(serial!="")
                args.IsValid=true;
            else
                args.IsValid=false;
       }   
    }
    function chkReg(sender,args)
    {
         var status=document.getElementById("ddlStatus").value;
        if(status==3)
        {
        var reg=document.getElementById("txtRegNo").value;
            if(reg!="")
                args.IsValid=true;
            else
                args.IsValid=false;
        }   
    }
    function chkActivityState()
    {
        var status=document.getElementById("ddlActivityState").value;
        if(status==4)
        {
            TDWait1.style.display="inline";
        }
        else
        {
            TDWait1.style.display="none";
        }
    }
    function onLoad()
    {
       chkOptValidation();
       chkTypeValidation();
    }
    function chkNStatus(sender,args)
    {
    var status=document.getElementById("ddlActivityState").value;
        if(status==4)
        {
        var admin=document.getElementById("ddlAdmins").value;
        if(admin>0)
            args.IsValid=true
        else
            args.IsValid=false
        }
    }
    function AttachShow()
    {
     Attachment.style.display='inline'
    }
   function AttachHide()
    {
     Attachment.style.display='none'
    }
    function AttachCancel()
    {
     Attachment.style.display='none'
    }
	
	
	function newFirm()
	{
		FirmTR.style.display="inline";
		LegalTR.style.display="none";
	}
	function CancelFirm()
	{
		FirmTR.style.display="none";
		LegalTR.style.display="inline";
	}
	
	function FirmValidate()
	{
	var name=trim(document.getElementById("txtName").value," ");
	//var type=document.getElementById("ddlType").value;
	var address=trim(document.getElementById("txtAddress").value," ");
	var phone=trim(document.getElementById("txtPhone").value," ");
	var state=trim(document.getElementById("ddlStates").value," ");
	var country=trim(document.getElementById("ddlCountry").value," ");
	var city=trim(document.getElementById("txtCity").value," ");
	var zip=trim(document.getElementById("txtZipCode").value," ");
	if(name!=""&&address!=""&&phone!=""&&state>0&&country>0&&city!=""&&zip!="")
	{
	CancelFirm();
	}
	else
	{
	return;
	}
	
	}
	
	function ValidateAppliedDate(sender,args)
    {
        var status=document.getElementById("ddlStatus").value;
        if(status==2||status==3)
        {
        var DateApp=document.getElementById("txtDateApplied").value;
        if(DateApp!="")
        {
        args.IsValid=true;
        }
        else
        {
        args.IsValid=false;
        }}
    }
    
    function ValidateSerialNo(sender,args)
    {
        var status=document.getElementById("ddlStatus").value;
        if(status==2)
        {
        var serial=document.getElementById("txtSerialNo").value;
        if(serial!="")
        {
        args.IsValid=true;
        }
        else
        {
        args.IsValid=false;
        }
        }
    }
    
  function chkOptValidation()
	{
	    document.getElementById("st1").style.display='none';
	    document.getElementById("st2").style.display='none';
	    document.getElementById("st3").style.display='none';
	    document.getElementById("st4").style.display='none';
	    document.getElementById("st5").style.display='none';

	if(document.getElementById("ddlStatus").value==3)
	{
	    document.getElementById("st1").style.display='inline';
	    document.getElementById("st2").style.display='inline';
	    document.getElementById("st3").style.display='inline';
	    document.getElementById("st4").style.display='inline';
	    document.getElementById("st5").style.display='inline';
	}
	else if(document.getElementById("ddlStatus").value==2)
	{
	    document.getElementById("st1").style.display='inline';
	    document.getElementById("st2").style.display='inline';
	}
	}
	
	function ShowAddNewType()
    {
        setWindowedControlsVisibility(window,'hidden');
        document.getElementById("NewType").style.display='inline';
        document.getElementById("txtNewTypeNameIP").focus();
    }
    function HideAddNewType()
    {
        setWindowedControlsVisibility(window,'visible');
        document.getElementById("NewType").style.display='none';
        document.getElementById("lblMsgIP").style.display='none';
        document.getElementById("RequiredFieldValidatorIP").style.display='none';
    }
    function ShowAddNewTypeStatus()
    {
        setWindowedControlsVisibility(window,'hidden');
        document.getElementById("NewTypeStatus").style.display='inline';
        document.getElementById("txtNewTypeNameStatus").focus();
    }
    function HideAddNewTypeStatus()
    
    {
        document.getElementById("NewTypeStatus").style.display='none';
        document.getElementById("lblMsgStatus").style.display='none';
        setWindowedControlsVisibility(window,'visible');
        document.getElementById("RequiredFieldValidatorStatus").style.display='none';
        
    }
	/*function chkNotes(sender,args)
    {
        var notes=document.getElementById("txtNotes").value;
        if(notes.length<8000)
        {
            args.IsValid=true;
        }
        else
        args.IsValid=false;
    }*/
        function onSaveClick_IP(FirmID,ContactID){
        document.getElementById("FirmTR").style.display='none';
        document.getElementById("LegalTR").style.display='inline';
        document.getElementById("hdnFirmID").value=FirmID;
        document.getElementById("hdnContactID").value=ContactID;
        document.getElementById("btnBinder").click();

    }
    function ValidateFirmContact(sender,args)
    {
       
        if(document.getElementById("ddlFirm").value!=="-1")
        {   
            if(document.getElementById("ddlContact").value=="-1")        
            { 
                args.IsValid=false;
            }
            else
            {           
                args.IsValid=true;
            }
        }
        else
        {
            args.IsValid=true;
        }
    }
    
    function chkExpiresOn(sender,args)
    {
         var status = document.getElementById("ddlStatus").value;
        if(status==3)
        {
        var ExpOn = document.getElementById("txtExpiresOn").value;
            if(ExpOn != "")
                args.IsValid=true;
            else
                args.IsValid=false;
        }   
    }

    function chkExpiresTo(sender,args)
    {
         var status = document.getElementById("ddlStatus").value;
        if(status==3)
        {
        var ExpOn = document.getElementById("txtExpiresOnTo").value;
            if(ExpOn != "")
                args.IsValid=true;
            else
                args.IsValid=false;
        }   
    }
    
    function chkTypeValidation()
	{
	    document.getElementById("st6").style.display='none';
	    if(document.getElementById("ddlType").value == 22)    // For the case of Copyright
	    {
	        document.getElementById("st6").style.display='inline';
	    }   
	}

    function chkCreationDate(sender,args)
    {
         var type = document.getElementById("ddlType").value;
        if(type==22)    // For case of Copyright
        {
        var CrDate = document.getElementById("txtCreationDate").value;
            if(CrDate != "")
                args.IsValid=true;
            else
                args.IsValid=false;
        }   
    }
    function CloseValidationSummaryDiv()
    {
        var ValidationSummary3 = document.getElementById('ValidationSummary3')
        if (ValidationSummary3 != null)
        ValidationSummary3.style.display = 'none'; 
        Reset();            
    }
    function SetPosition()
    {
        var divDisable = document.getElementById('divDisable') ;
        divDisable.style.width = document.body.scrollWidth
        divDisable.style.height = document.body.scrollHeight
        divDisable.style.display = 'block';
        
    }
    function Reset()
    {    
        var divDisable = document.getElementById('divDisable') ;
        divDisable.style.width = 0;
        divDisable.style.height = 0;
        divDisable.style.display = 'none';
        return false;
    }
    function Validate()
    {
        if(Page_ClientValidate('ip') == false)
        {
            SetPosition();
            return false;
        }
        else                     
              return true;
     }       
    </script>

</head>
<body style="margin: 0px 0px 0px 0px; height: 100%; width: 100%; overflow: hidden;"
    onload="onLoad();" class="DivScroll">
    <form id="form1" runat="server" defaultfocus="txtTitle">
    <div>
        <asp:ValidationSummary
                style="position:absolute;z-Index:1000; width:50%; height:55%;left:25%"  
                ID="ValidationSummary3" 
                runat="server"
                Font-Bold="true" 
                Font-Size="11px"
                ForeColor="black" 
                ShowMessageBox="false"
                ValidationGroup="ip"
                DisplayMode="BulletList"
                HeaderText="<table width='100%' cellpadding='4' cellspacing='0' border='0' ><tr><td style='text-align:left;' class='ErrorMessageWindowTitle'>Alert</td><td style='text-align:right;' class='ErrorMessageWindowTitle' align='right'><img src='../images/closebox2.gif' alt='Close' onclick='CloseValidationSummaryDiv();'></td></tr></table><br>&nbsp;&nbsp;&nbsp;<img src='../images/icn_info.jpg'><input type='button' value='Close' style='position:absolute; left:45%; top:80%; height:22px; width:50px;' align='absmiddle' class='Btn3D' onclick='CloseValidationSummaryDiv();' />&nbsp;&nbsp;Please! fix the following problem(s) to proceed!"
                CssClass="SummaryValidationDiv" />
    </div>
       <iframe id="divDisable" marginheight="0" marginwidth="0" scrolling="no" frameborder="0" style="z-index:09;width:0;height:0; background-color:black;position:absolute;filter:progid:DXImageTransform.Microsoft.alpha(opacity=50);opacity:0.5;" src="blank.htm" ></iframe>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <div>
            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                <ProgressTemplate>
                    <div class="ProgressIndicatorDIV">
                        <br />
                        <asp:Image ID="Image7" runat="server" ImageAlign="AbsMiddle" ImageUrl="images/indicator.gif" />
                        <span style="font-size: 14px; color: #4b92c1"><b>&nbsp; Loading ...</b></span>
                        <br />
                        <br />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <asp:HiddenField ID="hdnFirmID" runat="server" Value="0" />
            <asp:HiddenField ID="hdnContactID" runat="server" Value="0" />
            <asp:HiddenField ID="hdnAssignedTo" runat="server" Value="0" />
             <asp:HiddenField ID="hdnStatus" runat="server" Value="0" />
               <asp:HiddenField ID="hdnType" runat="server" Value="0" />
            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                <tr style="display: inline" id="LegalTR">
                    <td>
                        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%;"
                            class="MainTable">
                            <tr class="HeaderRowGreen" style="height: 27px; background-image:url('images/bg_cellNormal_black.jpg'); border-bottom:0px; ">
                                <td style="font-weight: bold; width: 50%; font-family: Helvetica; height: 31px; border-bottom:0px;">
                                    <asp:Label ID="lblHeading" runat="server" Font-Names="Helvetica" font-weight="bold" ForeColor="white"  
                                        Text="New Intellectual Property"></asp:Label></td>
                                <td style="text-align: right; border-bottom:0px;">&nbsp;
                                    
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="padding-right: 0px; padding-left: 0px; background-color: #daf5d6" valign="top">
                                    <div style="overflow: auto; height: 100%;" align="center">
                                        <div id="NewTypeStatus" align="center" style="border-right: black 1px solid; border-top: black 1px solid;
                                            display: none; left: 128px; border-left: black 1px solid; width: 240px; border-bottom: black 1px solid;
                                            position: absolute; top: 24px; height: 150px">
                                            <asp:UpdatePanel ID="UPIPStatus" runat="server" UpdateMode="Conditional">
                                                <ContentTemplate>
                                                    <table id="Table1" border="0" cellpadding="0" cellspacing="0" height="150" style="display: inline;
                                                        font-weight: bold; font-size: 12px; width: 100%; border-bottom: #000000 1px solid;
                                                        background-color: #daf5d6">
                                                        <tr>
                                                            <td height="28" style="font-weight: bold; font-size: 12px; background-image: url(images/bg_CellNormal_black.jpg);
                                                                cursor: default; color: white; border-bottom: #000000 1px solid" width="100%">
                                                                &nbsp;New IP Status Type</td>
                                                            <td align="right" style="padding-right: 2px; font-weight: bold; font-size: 12px;
                                                                background-image: url(images/bg_CellNormal_black.jpg); color: white; padding-top: 2px;
                                                                border-bottom: #000000 1px solid; height: 20px" valign="top" width="35">
                                                                <img onClick="setWindowedControlsVisibility(window,'visible');HideAddNewTypeStatus();"
                                                                    src="../images/closebox2.gif" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center" colspan="2" style="border-right: 0px; border-top: #000000; border-left: 0px;
                                                                border-bottom: #609bd3 1px solid" valign="middle">
                                                                <table style="background-color: #daf5d6">
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:Label ID="lblMsgStatus" runat="server" CssClass="RequiredField" Font-Size="Smaller"></asp:Label></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            Name :</td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtNewTypeNameStatus" runat="server" CausesValidation="True" EnableViewState="False"
                                                                                MaxLength="25" ValidationGroup="newTypeStatus"></asp:TextBox></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                        </td>
                                                                        <td>
                                                                            <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidatorStatus"
                                                                                runat="server" ControlToValidate="txtNewTypeNameStatus" CssClass="RequiredField"
                                                                                Display="Dynamic" ErrorMessage="Please! Enter Type Name." ValidationGroup="newTypeStatus"></asp:RequiredFieldValidator></td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr class="HeaderRowGreen">
                                                            <td align="center" colspan="2" height="31">
                                                                <asp:Button ID="Save" runat="server" CssClass="btn" OnClick="Save_Click" OnClientClick="document.getElementById('lblMsgStatus').style.display='none';"
                                                                    Style="width: 50px; height: 20px" Text="Save" ValidationGroup="newTypeStatus"
                                                                     />
                                                                <input id="Button1" class="btn" name="Close" onClick="setWindowedControlsVisibility(window,'visible');HideAddNewTypeStatus();"
                                                                    style="width: 50px; height: 20px" type="button" value="Close" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="Save" EventName="Click" />
                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </div>
                                        <div id="NewType" align="center" style="border-right: black 1px solid; border-top: black 1px solid;
                                            display: none; left: 128px; border-left: black 1px solid; width: 240px; border-bottom: black 1px solid;
                                            position: absolute; top: 24px; height: 150px">
                                            <asp:UpdatePanel ID="UPIP" runat="server">
                                                <ContentTemplate>
                                                    <table id="tblSearch" border="0" cellpadding="0" cellspacing="0" height="150" style="display: inline;
                                                        font-weight: bold; font-size: 12px; width: 100%; border-bottom: #000000 1px solid;
                                                        background-color: #daf5d6">
                                                        <tr>
                                                            <td height="28" style="font-weight: bold; font-size: 12px; background-image: url(images/bg_CellNormal_black.jpg);
                                                                cursor: default; color: white; border-bottom: #000000 1px solid" width="100%">
                                                                &nbsp;New IP Type</td>
                                                            <td align="right" style="padding-right: 2px; font-weight: bold; font-size: 12px;
                                                                background-image: url(images/bg_CellNormal_black.jpg); color: white; padding-top: 2px;
                                                                border-bottom: #000000 1px solid; height: 20px" valign="top" width="35">
                                                                <img onClick="setWindowedControlsVisibility(window,'visible');HideAddNewType();"
                                                                    src="../images/closebox2.gif" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center" colspan="2" style="border-right: 0px; border-top: #000000; border-left: 0px;
                                                                border-bottom: #609bd3 1px solid" valign="middle">
                                                                <table style="background-color: #daf5d6">
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:Label ID="lblMsgIP" runat="server" CssClass="RequiredField" Font-Size="Smaller"></asp:Label></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            Name :</td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtNewTypeNameIP" runat="server" CausesValidation="True" EnableViewState="False"
                                                                                MaxLength="25" ValidationGroup="newType"></asp:TextBox></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                        </td>
                                                                        <td>
                                                                            <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidatorIP"
                                                                                runat="server" ControlToValidate="txtNewTypeNameIP" CssClass="RequiredField"
                                                                                Display="Dynamic" ErrorMessage="Please! Enter Type Name." ValidationGroup="newType"></asp:RequiredFieldValidator></td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr class="HeaderRowGreen">
                                                            <td align="center" colspan="2" height="31">
                                                                <asp:Button ID="SaveIP" runat="server" CssClass="btn" OnClientClick="document.getElementById(&quot;lblMsgIP&quot;).style.display='none';"
                                                                    Style="width: 50px; height: 20px" Text="Save" ValidationGroup="newType" />
                                                                <input id="Close" class="btn" name="Close" onClick="HideAddNewType();" style="width: 50px;
                                                                    height: 20px" type="button" value="Close" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="SaveIP" EventName="Click" />
                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </div>
                                        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%; text-align: left">
                                            <tr>
                                                <td style="width:33%; border:solid 2px #6C9BBC; border-right:0px; border-left:0px;" valign="top">
                                                       
                                                    <table border="0" cellpadding="0" cellspacing="0" style="width:100%;" class="tableInfo">
                                                         <tr id="trDept">
                                                            <td style="width:10px; border-bottom:solid 1px #BADCFC; padding-top:5px; padding-bottom:5px;">&nbsp;</td>
                                                            <td colspan="2" style="; border-bottom:solid 1px #BADCFC; padding-top:5px; padding-bottom:5px; ">
                                                                Title<br />
                                                                <asp:TextBox ID="txtTitle" runat="server" CssClass="MediumGreenTextBox" MaxLength="200"
                                                                Width="100%" ValidationGroup="ip"></asp:TextBox> 
                                                                 <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTitle"
                                                                 ErrorMessage="Title is Required." Display="None" CssClass="RequiredField"
                                                                 ValidationGroup="ip"></asp:RequiredFieldValidator>
                                                            </td>
                                                            <td style="width:10px; border-bottom:solid 1px #BADCFC; padding-top:5px; padding-bottom:5px;" valign="bottom"  >
                                                                &nbsp;<span class="RequiredField">*</span>
                                                            </td>
                                                        </tr>
                                                        
                                                        <tr id="TRRefNo" style="display:inline;">
                                                            <td style="width:10px; padding-top:5px;">&nbsp;</td>
                                                            <td style="width:80px; padding-top:5px; ">
                                                               Reg No. 
                                                            </td>
                                                            <td style="padding-top:5px;">
                                                                  <asp:TextBox ID="txtRegNo" runat="server" CssClass="MediumGreenTextBox" MaxLength="50"
                                                                  Width="100%" ValidationGroup="ip"></asp:TextBox>
                                                                  <asp:CustomValidator SetFocusOnError="true" ID="cvRegNo" runat="server" ClientValidationFunction="chkReg"
                                                                  ErrorMessage="Registration No. is Required." Display="None" CssClass="RequiredField"
                                                                  ValidationGroup="ip"></asp:CustomValidator>
                                                            </td>
                                                            <td style="width:10px; padding-top:5px;">
                                                            &nbsp;<asp:Label ID="st3" runat="server" CssClass="RequiredField" Text="*"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="display: inline;" id="TRSNo">
                                                            <td style="width:10px;">&nbsp;</td>
                                                            <td>
                                                                Serial No:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtSerialNo" runat="server" CssClass="MediumGreenTextBox" MaxLength="50"
                                                                Width="100%" ValidationGroup="ip"></asp:TextBox>
                                                                <asp:CustomValidator SetFocusOnError="true" ID="cvValidateSerialNo" runat="server"
                                                                ClientValidationFunction="ValidateSerialNo" CssClass="RequiredField" ErrorMessage="Serial No. is required."
                                                                Display="None" ValidationGroup="ip"></asp:CustomValidator>
                                                                <asp:CustomValidator SetFocusOnError="true" ID="cvSerialNo" runat="server" ClientValidationFunction="chkSerial"
                                                                ErrorMessage="Please! Enter Serial Number." Display="None" CssClass="RequiredField"
                                                                ValidationGroup="ip"></asp:CustomValidator>
                                                            </td>
                                                            <td style="width:10px;">&nbsp;<asp:Label ID="st2" runat="server" CssClass="RequiredField" Text="*"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:10px;">&nbsp;</td>
                                                            <td>
                                                                Ref No:
                                                            </td>
                                                            <td>
                                                                 <asp:TextBox ID="txtRefNo" runat="server" CssClass="MediumGreenTextBox" MaxLength="50"
                                                                Width="100%" ValidationGroup="ip"></asp:TextBox>
                                                            </td>
                                                            <td style="width:10px;">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:10px;">&nbsp;</td>
                                                            <td>
                                                                Type:<a href="#" onClick="ShowAddNewType();" style="font-size: 7pt; display:inline;">[Add New]</a>
                                                            </td>
                                                            <td>
                                                                <asp:UpdatePanel ID="UPIPType" runat="server" RenderMode="Inline">
                                                                    <Triggers>
                                                                        <asp:AsyncPostBackTrigger ControlID="SaveIP" EventName="Click" />
                                                                    </Triggers>
                                                                    <ContentTemplate>
                                                                        <asp:DropDownList ID="ddlType" runat="server" CssClass="MediumFontInput" Width="100%"
                                                                        ValidationGroup="ip" DataSourceID="sdsIPType" DataTextField="Name"
                                                                        DataValueField="ID" onchange="chkTypeValidation();">
                                                                        </asp:DropDownList>
                                                                        <asp:SqlDataSource ID="sdsIPType" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                        SelectCommand="Legal_GetIPTypes" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                                                    </ContentTemplate>
                                                              </asp:UpdatePanel>
                                                              <asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvType" runat="server" ControlToValidate="ddlType"
                                                               ErrorMessage="Type is Required." InitialValue="-1" Display="None" CssClass="RequiredField"
                                                               ValidationGroup="ip"></asp:RequiredFieldValidator>
                                                              
                                                            </td>
                                                            <td style="width:10px;">&nbsp;<span class="RequiredField">*</span></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:10px;">&nbsp;</td>
                                                            <td>Owner:</td>
                                                            <td>
                                                                 <asp:DropDownList ID="ddlOwner" runat="server" CssClass="MediumFontInput" Width="100%"
                                                                    ValidationGroup="ip" AppendDataBoundItems="True" DataSourceID="sdsIPOwner"
                                                                    DataTextField="Name" DataValueField="ID" >
                                                                    <asp:ListItem Value="-1">Choose...</asp:ListItem>
                                                                </asp:DropDownList><asp:RequiredFieldValidator SetFocusOnError="true" ID="RFV_ddlOwner" runat="server" ControlToValidate="ddlOwner"
                                                                ErrorMessage="Owner is Required." InitialValue="-1" Display="None" CssClass="RequiredField"
                                                                ValidationGroup="ip"></asp:RequiredFieldValidator>
                                                                <asp:SqlDataSource ID="sdsIPOwner" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                SelectCommand="Legal_IPOwners_GetAll" DataSourceMode="DataReader" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                                            </td>
                                                            <td style="width:10px;">
                                                                &nbsp;<span class="RequiredField">*</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:10px;">&nbsp;</td>
                                                            <td>
                                                                Assigned to:
                                                            </td>
                                                            <td>
                                                                <span>
                                                                    <asp:DropDownList ID="ddlAssignedTo" runat="server" DataSourceID="ComplianceAdminsDS"
                                                                       DataTextField="Name" DataValueField="ID" AppendDataBoundItems="true" Width="100%"
                                                                       CssClass="MediumFontInput">
                                                                       <asp:ListItem Value="-1">Choose...</asp:ListItem>
                                                                     </asp:DropDownList>
                                                                 </span>
                                                                   <asp:SqlDataSource ID="ComplianceAdminsDS" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                    SelectCommand="Legal_GetComplianceUsers" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                                            </td>
                                                            <td style="width:10px;">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:10px;">&nbsp;</td>
                                                            <td>
                                                                Status:<a href="#" onClick="ShowAddNewTypeStatus();" style="font-size: 7pt; display:inline;">[Add New]</a>
                                                            </td>
                                                            <td>
                                                                <asp:UpdatePanel ID="UPStatus" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="MediumFontInput" Width="100%"
                                                                            ValidationGroup="ip" DataSourceID="sdsIPStatusTypes"
                                                                            DataTextField="Name" DataValueField="ID" onchange="chkOptValidation();">
                                                                            <asp:ListItem Value="-1">Choose...</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                        <asp:SqlDataSource ID="sdsIPStatusTypes" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                            SelectCommand="Legal_GetIPStatusTypes" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel><asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvStatus" runat="server"
                                                                    ControlToValidate="ddlStatus" ErrorMessage="Status is Required." InitialValue="-1"
                                                                    Display="None" CssClass="RequiredField" ValidationGroup="ip" Width="96px"></asp:RequiredFieldValidator>
                                                             </td>
                                                            <td style="width:10px;">
                                                                &nbsp;<span class="RequiredField">*</span>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="width:33%; border:solid 2px #6C9BBC; border-right:0px;" valign="top">
                                                     <table border="0" cellpadding="0" cellspacing="0" style="width:100%;" class="tableInfo">
                                                        <tr>
                                                            <td style="width:10px; border-bottom:solid 1px #BADCFC; padding-top:5px; padding-bottom:5px; border-left:0px;">&nbsp;</td>
                                                            <td colspan="2" style="border-bottom:solid 1px #BADCFC; padding-top:5px; padding-bottom:5px; border-left:0px;">
                                                                Registration Date<br />
                                                                  <asp:TextBox ID="txtRegistrationDate" runat="server" CssClass="MediumGreenTextBox" Width="100%"
                                                                    ValidationGroup="ip" onfocus="setActiveStyleSheet(this, 'calstyle'); return showCalendar('txtRegistrationDate', 'MM/dd/y');"
                                                                    ReadOnly="True"></asp:TextBox>
                                                            </td>
                                                            <td style="width:10px; border-bottom:solid 1px #BADCFC; padding-top:5px; padding-bottom:5px; border-left:0px;">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:10px; padding-top:5px;">&nbsp;</td>
                                                            <td style="width:125px; padding-top:5px;">
                                                                Declaration of Use From:
                                                            </td>
                                                            <td style="padding-top:5px;">
                                                                <asp:TextBox ID="txtDeclarationofUseFrom" runat="server" CssClass="MediumGreenTextBox" Width="100%"
                                                                ValidationGroup="ip" onfocus="setActiveStyleSheet(this, 'calstyle'); return showCalendar('txtDeclarationofUseFrom', 'MM/dd/y');"
                                                                ReadOnly="True"></asp:TextBox>
                                                                <asp:CompareValidator ID="cmpv_DeclarationDate" runat="server" ValidationGroup="ip" ControlToCompare="txtDeclarationofUseFrom" ControlToValidate="txtDeclarationofUseTo" Type="date" Operator="GreaterThanEqual" ErrorMessage="From Date must be less than To Date" Display="None"></asp:CompareValidator>
                                                            </td>
                                                            <td style="width:10px; padding-top:5px;">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:10px;">&nbsp;</td>
                                                            <td>
                                                                Declaration of Use to:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtDeclarationofUseTo" runat="server" CssClass="MediumGreenTextBox" Width="100%"
                                                                    ValidationGroup="ip" onfocus="setActiveStyleSheet(this, 'calstyle'); return showCalendar('txtDeclarationofUseTo', 'MM/dd/y');"
                                                                    ReadOnly="True"></asp:TextBox>
                                                            </td>
                                                            <td style="width:10px;">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:10px;">&nbsp;</td>
                                                            <td>
                                                                Expires from:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtExpiresOn" ReadOnly="true" runat="server" CssClass="MediumGreenTextBox" ValidationGroup="ip"
                                                                    Width="100%" onfocus="setActiveStyleSheet(this, 'calstyle'); return showCalendar('txtExpiresOn', 'MM/dd/y');">
                                                                </asp:TextBox>
                                                                <asp:CustomValidator SetFocusOnError="true" ID="cv_ExpiresOn" runat="server" ClientValidationFunction="chkExpiresOn"
                                                                ErrorMessage="Expiration From Date is Required." Display="None" CssClass="RequiredField"
                                                                ValidationGroup="ip"></asp:CustomValidator>
                                                            </td>
                                                            <td style="width:10px;">&nbsp;<asp:Label ID="st4" runat="server" CssClass="RequiredField" Text="*"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:10px;">&nbsp;</td>
                                                            <td>
                                                                Expires to:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtExpiresOnTo" runat="server" CssClass="MediumGreenTextBox" Width="100%"
                                                                    ValidationGroup="ip" onfocus="setActiveStyleSheet(this, 'calstyle'); return showCalendar('txtExpiresOnTo', 'MM/dd/y');"
                                                                    ReadOnly="True"></asp:TextBox>
                                                                <asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="ip" ControlToCompare="txtExpiresOn" ControlToValidate="txtExpiresOnTo" Type="date" Operator="GreaterThanEqual" ErrorMessage="From Date must be less than To Date" Display="None"></asp:CompareValidator>                                                                    
                                                                 <asp:CustomValidator SetFocusOnError="true" ID="cv_ExpiresTo" runat="server" ClientValidationFunction="chkExpiresTo"
                                                                 ErrorMessage="Expiration To Date is Required." Display="None" CssClass="RequiredField"
                                                                 ValidationGroup="ip"></asp:CustomValidator>
                                                            </td>
                                                            <td style="width:10px;">&nbsp;<asp:Label ID="st5" runat="server" CssClass="RequiredField" Text="*"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:10px;">&nbsp;</td>
                                                            <td>
                                                                1<sup>st</sup> Used on:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtFirstUsed" runat="server" CssClass="MediumGreenTextBox" Width="100%"
                                                                    ValidationGroup="ip" onfocus="setActiveStyleSheet(this, 'calstyle'); return showCalendar('txtFirstUsed', 'MM/dd/y');"
                                                                    ReadOnly="True"></asp:TextBox>
                                                                 <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator3" runat="server"
                                                                 ControlToValidate="txtFirstUsed" CssClass="RequiredField" Display="None" ErrorMessage="Date First Used is Required."
                                                                 ValidationGroup="ip" Width="100%"></asp:RequiredFieldValidator>    
                                                            </td>
                                                            <td style="width:10px;">&nbsp;<span style="font-size: 8pt; color: #ff0000">*</span></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:10px;">&nbsp;</td>
                                                            <td>
                                                                Applied on:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtDateApplied" runat="server" CssClass="MediumGreenTextBox" Width="100%"
                                                                ValidationGroup="ip" onfocus="setActiveStyleSheet(this, 'calstyle'); return showCalendar('txtDateApplied', 'MM/dd/y');"
                                                                ReadOnly="True"></asp:TextBox>
                                                                <asp:CustomValidator ID="cvValidateAppliedDate" runat="server"
                                                                CssClass="RequiredField" ErrorMessage="Date Applied is required." ClientValidationFunction="ValidateAppliedDate"
                                                                ValidationGroup="ip" Display="None"></asp:CustomValidator>
                                                            </td>
                                                            <td style="width:10px;">&nbsp;<asp:Label ID="st1" runat="server" CssClass="RequiredField" Text="*"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:10px;">&nbsp;</td>
                                                            <td>
                                                                Created on:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtCreationDate" runat="server" CssClass="MediumGreenTextBox" Width="100%"
                                                                    ValidationGroup="ip" onfocus="setActiveStyleSheet(this, 'calstyle'); return showCalendar('txtCreationDate', 'MM/dd/y');"
                                                                    ReadOnly="True"></asp:TextBox>
                                                                <asp:CustomValidator ID="cv_CreationDate" runat="server" ClientValidationFunction="chkCreationDate"
                                                                    ErrorMessage="Creation Date is Required." Display="None" CssClass="RequiredField"
                                                                    ValidationGroup="ip"></asp:CustomValidator>
                                                            </td>
                                                            <td style="width:10px;">&nbsp;<asp:Label ID="st6" runat="server" CssClass="RequiredField" Text="*"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="width:33%; border:solid 2px #6C9BBC; border-right:0px;" valign="top">
                                                     <table border="0" cellpadding="0" cellspacing="0" style="width:100%;" class="tableInfo">
                                                        <tr style="">
                                                            <td style="width:10px; border-bottom:solid 1px #BADCFC; padding-top:5px; padding-bottom:5px; ">&nbsp;</td>
                                                            <td colspan="2" style="border-bottom:solid 1px #BADCFC; padding-top:5px; padding-bottom:5px;">
                                                                  Firm/Vendor <a href="#" onClick="newFirm();" style="font-size: 7pt; display:inline;">[New Firm/Vendor]</a><br />
                                                                  <asp:UpdatePanel ID="UPVendor" runat="server" RenderMode="Inline">
                                                                    <Triggers>
                                                                        <asp:AsyncPostBackTrigger ControlID="btnBinder" EventName="Click" />
                                                                    </Triggers>
                                                                    <ContentTemplate>
                                                                        <asp:DropDownList ID="ddlFirm" runat="server" CssClass="MediumFontInput" Width="100%"
                                                                            DataSourceID="FirmDS" DataTextField="Name" DataValueField="ID" ValidationGroup="ip"
                                                                            AutoPostBack="true">
                                                                        </asp:DropDownList>
                                                                    </ContentTemplate>
                                                                 </asp:UpdatePanel>
                                                               
                                                                <asp:SqlDataSource ID="FirmDS" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                SelectCommand="Legal_Firm_GetAll_ForList" DataSourceMode="DataReader" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                                            </td>
                                                            <td style="width:10px; border-bottom:solid 1px #BADCFC; padding-top:5px; padding-bottom:5px;">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:10px; padding-top:5px;">&nbsp;</td>
                                                            <td style="width:80px; padding-top:5px;">
                                                                Contact:
                                                            </td>
                                                            <td style="width:70%; padding-top:5px;">
                                                                <asp:UpdatePanel runat="server" ID="UpdateContact" UpdateMode="Conditional">
                                                                    <Triggers>
                                                                        <asp:AsyncPostBackTrigger ControlID="ddlFirm" EventName="SelectedIndexChanged" />
                                                                        <asp:AsyncPostBackTrigger ControlID="btnBinder" EventName="Click" />
                                                                    </Triggers>
                                                                    <ContentTemplate>
                                                                        <asp:DropDownList ID="ddlContact" runat="server" CssClass="MediumFontInput" Width="100%"
                                                                            DataSourceID="ContactsDS" DataTextField="Name" DataValueField="ID" ValidationGroup="ip">
                                                                            <asp:ListItem Value="-1">Choose...</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                        <asp:SqlDataSource ID="ContactsDS" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                            SelectCommand="Legal_GetContactsByFirmID" SelectCommandType="StoredProcedure">
                                                                            <SelectParameters>
                                                                                <asp:ControlParameter ControlID="ddlFirm" Name="FirmID" PropertyName="SelectedValue" />
                                                                            </SelectParameters>
                                                                        </asp:SqlDataSource>
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
                                                                 <asp:CustomValidator  ID="rfvContact" Display="None" ClientValidationFunction="ValidateFirmContact"
                                                                CssClass="RequiredField" ErrorMessage="Choose Contact" runat="server" ControlToValidate="ddlContact" ValidationGroup="ip"></asp:CustomValidator>

                                                            </td>
                                                            <td style="width:10px; padding-top:5px;">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:10px;">&nbsp;</td>
                                                            <td>
                                                                Country:
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlCountry" runat="server" CssClass="MediumFontInput" Width="100%"
                                                                    DataSourceID="odsCountries" DataTextField="Name" DataValueField="ID" ValidationGroup="ip">
                                                                    <asp:ListItem Value="-1">Choose...</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <asp:ObjectDataSource ID="odsCountries" runat="server" SelectMethod="GetAll"
                                                                    TypeName="Legal_Country" >
                                                                </asp:ObjectDataSource>
                                                            </td>
                                                            <td style="width:10px;">&nbsp;</td>
                                                        </tr>
                                                         <tr>
                                                            <td colspan="4" style="border-bottom:solid 2px #ACD4B1;">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:10px;">&nbsp;</td>
                                                            <td colspan="2" style="padding-top:10px; padding-right:5px; padding-left:5px;"> 
                                                                Published Opposition
                                                            </td>
                                                            <td style="width:10px;">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:10px;">&nbsp;</td>
                                                            <td colspan="2" style="padding-right:5px; padding-left:5px;"> 
                                                               <asp:TextBox ID="txtPublishedOpposition" runat="server" CssClass="MediumGreenTextBox" Width="100%"
                                                                ValidationGroup="ip" onfocus="setActiveStyleSheet(this, 'calstyle'); return showCalendar('txtPublishedOpposition', 'MM/dd/y');"
                                                                ReadOnly="True"></asp:TextBox>
                                                            </td>
                                                             <td style="width:10px;">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:10px;">&nbsp;</td>
                                                            <td colspan="2" style="padding-top:10px; padding-right:5px; padding-left:5px;">
                                                                Notify:
                                                            </td>
                                                            <td style="width:10px;">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:10px;">&nbsp;</td>
                                                            <td colspan="2" style="padding-right:5px; padding-left:5px;">
                                                                <asp:DropDownList ID="ddlNotify" CssClass="MediumFontInput" runat="server" Width="100%">
                                                                    <asp:ListItem Value="1">1 month</asp:ListItem>
                                                                    <asp:ListItem Value="2">2 months</asp:ListItem>
                                                                    <asp:ListItem Value="3">3 months</asp:ListItem>
                                                                    <asp:ListItem Value="4">4 months</asp:ListItem>
                                                                    <asp:ListItem Value="5">5 months</asp:ListItem>
                                                                    <asp:ListItem Value="6">6 months</asp:ListItem>
                                                                    <asp:ListItem Value="7">7 months</asp:ListItem>
                                                                    <asp:ListItem Value="8">8 months</asp:ListItem>
                                                                    <asp:ListItem Value="9">9 months</asp:ListItem>
                                                                    <asp:ListItem Value="10">10 months</asp:ListItem>
                                                                    <asp:ListItem Value="11">11 months</asp:ListItem>
                                                                    <asp:ListItem Value="12">12 months</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <asp:SqlDataSource ID="AdminsDS" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                 SelectCommand="Legal_GetAllUsers" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                                            </td>
                                                            <td style="width:10px;">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:10px;">&nbsp;
                                                                
                                                            </td>
                                                            <td>&nbsp;
                                                                                                                            
                                                            </td>
                                                            <td>&nbsp;
                                                                
                                                            </td>
                                                            <td style="width:10px;">&nbsp;
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                              </tr>
                                            <tr style="height:100%;">
                                                <td style="z-index:10;width:100%; height:100%; border:solid 3px #6C9BBC; border-top:solid 1px #6C9BBC; padding-bottom:0px;" colspan="3">
                                                       <asp:TextBox 
                                                        ID="txtNotes" 
                                                        runat="server" 
                                                        CssClass="MediumGreenTextBox" 
                                                        Height="100%"
                                                        TextMode="MultiLine"
                                                        Width="100%" 
                                                        ValidationGroup="ip">
                                                    </asp:TextBox>
                                                    
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">&nbsp; 
                                                   
                                                </td>
                                            </tr>
                                           <tr style="display: none;">
                                                <td>
                                                    <asp:Button ID="btnBinder" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left" style=" border:0px; padding-left: 5px; width: 25%; height: 10px">
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr class="FooterRowGreen">
                                <td align="center" colspan="2" style="padding-right: 31px; height: 31px">
                                    <asp:Button ID="BtnSave" runat="server" CssClass="btnGreen" Style="width: 80px" Text="Save"   OnClientClick="javascript:if(Validate()== false) return false;"
                                        ValidationGroup="ip" />&nbsp;
                                    <input id="btnCan" type="button" value="Cancel" class="btnGreen" onClick="parent.frameMain.location='Legal_IP.aspx'"
                                        style="width: 80px" />
                                </td>
                            </tr>
                        </table>
                        <div id="Attachment" align="center" style="border-right: black 0px solid; border-top: black 0px solid;
                            display: none; left: 40px; border-left: black 0px solid; width: 300px; border-bottom: black 0px solid;
                            position: absolute; top: 448px; height: 138px">
                            <table align="center" cellpadding="0" cellspacing="0" class="MainAlertDiv" width="100%">
                                <tr>
                                    <th align="left" height="21" style="background-color: #bde4b8" valign="middle">
                                        &nbsp;Attachments
                                    </th>
                                    <th align="right" style="background-color: #bde4b8" valign="top">
                                        <img onClick="OnAttachmentSubmit(0); return false;" src="../images/closebox2.gif"
                                            style="cursor: pointer" /></th>
                                </tr>
                                <tr>
                                    <td colspan="2" valign="middle" width="100%">
                                        <table align="center" cellpadding="0" cellspacing="0" class="MainAlertDiv" style="border-right: medium none;
                                            border-top: medium none; border-left: medium none; border-bottom: medium none"
                                            width="100%">
                                            <tr>
                                                <td align="center" colspan="2" height="25" style="background-color: #daf5d6">
                                                    Attach Files!</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td height="25" style="background-color: #daf5d6">
                                                    &nbsp;File 1: <span id="spnFile1">
                                                        <asp:FileUpload ID="FileUpload1" runat="server" Width="240px" /></span><br />
                                                    &nbsp;File 2: <span id="spnFile2">
                                                        <asp:FileUpload ID="FileUpload2" runat="server" Width="240px" /></span><br />
                                                    &nbsp;File 3: <span id="spnFile3">
                                                        <asp:FileUpload ID="FileUpload3" runat="server" Width="240px" /></span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="2" height="30" style="background-color: #daf5d6">
                                                    <input class="btnGreen" onClick="AttachHide();" type="button" value="Submit" />
                                                    <input class="btnGreen" onClick="AttachHide();" type="button" value="Cancel" /></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
            <div id="FirmTR" style="display: none; position: absolute; width: 100%; height: 100%;
                left: 0; top: 0;">
                <iframe id="frmNewFirm" width="100%" height="100%" frameborder="0" src="NewFirm.aspx?subpage=2">
                </iframe>
            </div>
        </div>
    </form>
</body>
</html>
