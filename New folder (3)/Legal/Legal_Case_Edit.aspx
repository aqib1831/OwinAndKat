<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Legal_Case_Edit.aspx.vb" validateRequest="false"
    Inherits="admin_Legal_NewLegal" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>New Legal Case</title>

    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>

    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>

    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>

    <script type="text/javascript" language="JavaScript" src="../scripts/functions.js"></script>

    <link href="../style/style.css" type="text/css" rel="stylesheet" />
    <link href="Style/Style.css" type="text/css" rel="stylesheet" />
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <link href="../App_Themes/Default/Calendar/style.css" rel="stylesheet" type="text/css" />

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
   function ShowFranSearch(tBox)
   {
   //alert(getRealLeft(tBox));
   setWindowedControlsVisibility(window,'visible');
   tBox.blur();
   document.getElementById("FranchiseeDiv").style.left=getRealLeft(tBox)
   document.getElementById("FranchiseeDiv").style.display="inline";
   document.getElementById("txtSearch").focus();
   }
    function HideFranSearch()
   {
   setWindowedControlsVisibility(window,'visible');
   document.getElementById("FranchiseeDiv").style.display='none';
   
   }
   function setFranchisee(ID,Store)
   {
   document.getElementById("txtFranchisee").value=Store;
   document.getElementById("hdnID").value=ID;
   document.getElementById("FranchiseeDiv").style.display='none';
   }
    function chkSerial(sender,args)
    { 
       var status=document.getElementById("ddlStatus").value;
        if(status==3)
        {
        var serial=document.getElementById("txtFirmCaseNo").value;
            if(serial!=="")
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
        var reg=document.getElementById("txtDocketNo").value;
            if(reg!=="")
                args.IsValid=true;
            else
                args.IsValid=false;
        }   
    }
    function onLoad()
    {
       chkOptValidation();
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
    function newFirm()
	{
        document.getElementById('LegalTR').style.display="none";
		document.getElementById('FirmTR').style.display="inline";
	}
	function CancelFirm()
	{
		document.getElementById('FirmTR').style.display="none";
		document.getElementById('LegalTR').style.display="inline";
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
    function chkTime(sender,args)
    {
       var hours=document.getElementById("ddlHours").value;
    var mins=document.getElementById("ddlMins").value;
    if(hours==0&&mins==0)
    {
        args.IsValid=false;
    }
    else 
    args.IsValid=true;
    }
    function chkOptValidation()
	{
	if(document.getElementById("ddlStatus").value==3)
	{
	document.getElementById("st1").style.display='inline';
	document.getElementById("st2").style.display='inline';
	}
	else
	{
	document.getElementById("st1").style.display='none';
	document.getElementById("st2").style.display='none';
	}
	}
/*	function chkNotes(sender,args)
    {
        var notes=document.getElementById("txtNotes").value;
        if(notes.length<8000)
        {
            args.IsValid=true;
        }
        else
        args.IsValid=false;
    }
*/    function chkAddress(sender,args)
    {
        var notes=document.getElementById("txtAddress").value;
        if(notes.length>0&&notes.length<150)
        {
            args.IsValid=true;
        }
        else
        args.IsValid=false;
    }
    function ShowAddNewStatusType()
    {
        
        document.getElementById("NewStatusType").style.display='inline';
        document.getElementById("txtNewTypeName").focus();
    }
    function HideAddNewStatusType()
    {
        document.getElementById("NewStatusType").style.display='none';
        document.getElementById("lblMsg").style.display='none';
        document.getElementById("RequiredFieldValidatorNew").style.display='none';
        setWindowedControlsVisibility(window,'visible');
    }
    function ShowAddNewType()
    {
   
        document.getElementById("NewType").style.display='inline';
        document.getElementById("txtNewTypeName1").focus();
    }
    function HideAddNewType()
    {
        document.getElementById("NewType").style.display='none';
        document.getElementById("lblMsgNew1").style.display='none';
         document.getElementById("RequiredFieldValidatorNew1").style.display='none';
         setWindowedControlsVisibility(window,'visible');
    }
    function chkParties(sender,args)
    {
        var notes=document.getElementById("txtConcernedParties").value;
        if(notes.length<3000)
        {
            args.IsValid=true;
          
        }
        else
        args.IsValid=false;
    }
     function onSaveClick_Case(FirmID,ContactID){

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
    </script>

</head>
<body style="margin: 0px 0px 0px 0px; height: 100%; width: 100%; overflow: hidden;"
    onload="onLoad();" class="divscroll">
  <form id="form1" runat="server" defaultfocus="txtTitle">
        <div>
            <asp:UpdateProgress ID="UpdateProgress7" runat="server">
                <ProgressTemplate>
                    <div class="ProgressIndicatorDIV">
                        <br />
                        <asp:Image ID="Image3" runat="server" ImageAlign="AbsMiddle" ImageUrl="images/indicator.gif" /><span
                            style="font-size: 14px; color: #4b92c1"><b>&nbsp; Loading ...</b></span>
                        <br />
                        <br />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <asp:HiddenField ID="hdnFirmID" Value="0" runat="server" />
            <asp:HiddenField ID="hdnContactID" Value="0" runat="server" />
            
    <asp:HiddenField ID="hdnAssignedTo" runat="server" Value="0" />
             <asp:HiddenField ID="hdnStatus" runat="server" Value="0" />
               <asp:HiddenField ID="hdnType" runat="server" Value="0" />
            <div id="divCase">
                <table cellpadding="0" cellspacing="0" border="0" width="100%" height="100%">
                    <tr id="LegalTR">
                        <td>
                            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%;"
                                class="MainTable">
                                <tr class="HeaderRowGreen" style="height: 31px;">
                                    <td style="font-weight: bold; width: 50%; font-family: Helvetica; height: 31px;">
                                        <asp:Label ID="lblHeading" runat="server" Font-Names="Helvetica" font-weight="bold"
                                            Text="Edit Case"></asp:Label></td>
                                    <td style="text-align: right">
                                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                                        </asp:ScriptManager>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2" style="padding-right: 2px; padding-left: 2px; background-color: #daf5d6"
                                        valign="top">
                                        <div style="height: 100%;" align="center" class="divscroll">
                                            <div id="NewType" align="center" style="border-right: black 1px solid; border-top: black 1px solid;
                                                display: none; left: 128px; border-left: black 1px solid; width: 240px; border-bottom: black 1px solid;
                                                position: absolute; top: 24px; height: 150px">
                                                <asp:UpdatePanel ID="UPStatus" runat="server">
                                                    <ContentTemplate>
                                                        <table id="Table2" border="0" cellpadding="0" cellspacing="0" height="150" style="display: inline;
                                                            font-weight: bold; font-size: 12px; width: 100%; border-bottom: #000000 1px solid;
                                                            background-color: #daf5d6">
                                                            <tr>
                                                                <td height="28" style="font-weight: bold; font-size: 12px; background-image: url(images/bg_CellNormal_black.jpg);
                                                                    cursor: default; color: white; border-bottom: #000000 1px solid" width="100%">
                                                                    &nbsp;New Case Type</td>
                                                                <td align="right" style="padding-right: 2px; font-weight: bold; font-size: 12px;
                                                                    background-image: url(images/bg_CellNormal_black.jpg); color: white; padding-top: 2px;
                                                                    border-bottom: #000000 1px solid; height: 20px" valign="top" width="35">
                                                                    <img onClick="setWindowedControlsVisibility(window,'visible');HideAddNewType();"
                                                                        src="../images/closebox.gif" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center" colspan="2" style="border-right: 0px; border-top: #000000; border-left: 0px;
                                                                    border-bottom: #609bd3 1px solid" valign="middle">
                                                                    <table style="background-color: #daf5d6">
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Label ID="lblMsgNew1" runat="server" CssClass="RequiredField" Font-Size="Smaller"></asp:Label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                Name :</td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtNewTypeName1" runat="server" CausesValidation="True" EnableViewState="False"
                                                                                    MaxLength="25" ValidationGroup="newType"></asp:TextBox></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                            </td>
                                                                            <td>
                                                                                <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidatorNew1"
                                                                                    runat="server" ControlToValidate="txtNewTypeName1" CssClass="RequiredField" Display="Dynamic"
                                                                                    ErrorMessage="Please Enter Type Name." ValidationGroup="newType"></asp:RequiredFieldValidator></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr class="HeaderRowGreen">
                                                                <td align="center" colspan="2" height="31">
                                                                    <asp:Button ID="SaveType" runat="server" CssClass="btn" OnClientClick="document.getElementById(&quot;lblMsgNew1&quot;).style.display='none';"
                                                                        Style="width: 50px; height: 20px" Text="Save" ValidationGroup="newType" /><input
                                                                            id="Button2" class="btn" name="Close" onClick="setWindowedControlsVisibility(window,'visible');HideAddNewType();"
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
                                            <div id="NewStatusType" align="center" style="border-right: black 1px solid; border-top: black 1px solid;
                                                display: none; left: 128px; border-left: black 1px solid; width: 240px; border-bottom: black 1px solid;
                                                position: absolute; top: 24px; height: 150px">
                                                <asp:UpdatePanel ID="UPCaseStatus" runat="server" UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                        <table id="Table1" border="0" cellpadding="0" cellspacing="0" height="150" style="display: inline;
                                                            font-weight: bold; font-size: 12px; width: 100%; border-bottom: #000000 1px solid;
                                                            background-color: #daf5d6">
                                                            <tr>
                                                                <td height="28" style="font-weight: bold; font-size: 12px; background-image: url(images/bg_CellNormal_black.jpg);
                                                                    cursor: default; color: white; border-bottom: #000000 1px solid" width="100%">
                                                                    &nbsp;New Case Status Type</td>
                                                                <td align="right" style="padding-right: 2px; font-weight: bold; font-size: 12px;
                                                                    background-image: url(images/bg_CellNormal_black.jpg); color: white; padding-top: 2px;
                                                                    border-bottom: #000000 1px solid; height: 20px" valign="top" width="35">
                                                                    <img onClick="setWindowedControlsVisibility(window,'visible');HideAddNewStatusType();"
                                                                        src="../images/closebox.gif" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center" colspan="2" style="border-right: 0px; border-top: #000000; border-left: 0px;
                                                                    border-bottom: #609bd3 1px solid" valign="middle">
                                                                    <table style="background-color: #daf5d6">
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Label ID="lblMsgNew" runat="server" CssClass="RequiredField" Font-Size="Smaller"></asp:Label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                Name :</td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtNewTypeName" runat="server" CausesValidation="True" EnableViewState="False"
                                                                                    MaxLength="25" ValidationGroup="newstype"></asp:TextBox></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                            </td>
                                                                            <td>
                                                                                <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidatorNew"
                                                                                    runat="server" ControlToValidate="txtNewTypeName" CssClass="RequiredField" Display="Dynamic"
                                                                                    ErrorMessage="Please Enter Type Name." ValidationGroup="newstype"></asp:RequiredFieldValidator></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr class="HeaderRowGreen">
                                                                <td align="center" colspan="2" height="31">
                                                                    <asp:Button ID="Save" runat="server" CssClass="btn" OnClientClick="document.getElementById(&quot;lblMsg&quot;).style.display='none';"
                                                                        Style="width: 50px; height: 20px" Text="Save" ValidationGroup="newstype" /><input
                                                                            id="Button1" class="btn" name="Close" onClick="setWindowedControlsVisibility(window,'visible');HideAddNewStatusType();"
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
                                            <div style="overflow: auto; height: 100%;">
                                                <table border="0" cellpadding="0" cellspacing="0" style="width: 550px; height: 100%;
                                                    text-align: left">
                                                    <tr style="display: none;">
                                                        <td>
                                                            <asp:Button ID="btnBinder" runat="server" CausesValidation="false" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" style="padding-left: 5px; height: 10px" colspan="2">
                                                            <asp:Label ID="lblMsg" runat="server" CssClass="RequiredField" ForeColor="Red"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" style="padding-left: 5px; width: 20%; height: 22px">
                                                            Title:<span class="RequiredField">*</span></td>
                                                        <td width="394px">
                                                            <asp:TextBox ID="txtTitle" runat="server" CssClass="MediumGreenTextBox" MaxLength="200"
                                                                Width="380px" TabIndex="1"></asp:TextBox></td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" style="padding-left: 5px; width: 20%; height: 1px">
                                                        </td>
                                                        <td>
                                                            <asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvTitle" runat="server" ControlToValidate="txtTitle"
                                                                ErrorMessage="Title is Required." Display="Dynamic" CssClass="RequiredField"></asp:RequiredFieldValidator></td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" style="padding-left: 5px; width: 20%; height: 22px">
                                                            Franchisee.</td>
                                                        <td>
                                                            <asp:TextBox ID="txtFranchisee" runat="server" CssClass="MediumGreenTextBox" MaxLength="200"
                                                                Width="368px" TabIndex="2"></asp:TextBox><img src="../images/arrow_down.gif" align="absmiddle"
                                                                    width="10" onClick="ShowFranSearch(txtFranchisee);" height="18" style="border: solid 1px #50AF43;" />
                                                        </td>
                                                    </tr>
                                                    <tr id="trDept">
                                                        <td align="left" style="padding-left: 5px; width: 25%; height: 22px">
                                                            Type:<span class="RequiredField">*</span>
                                                        </td>
                                                        <td>
                                                            <asp:UpdatePanel ID="UPCaseType" runat="server" RenderMode="inline">
                                                                <Triggers>
                                                                    <asp:AsyncPostBackTrigger ControlID="SaveType" EventName="Click" />
                                                                </Triggers>
                                                                <ContentTemplate>
                                                                    <asp:DropDownList ID="ddlType" runat="server" CssClass="MediumFontInput" Width="275px"
                                                                        DataSourceID="sdsCaseTypes" DataTextField="Name" DataValueField="ID" TabIndex="3">
                                                                        <asp:ListItem Value="-1">Choose...</asp:ListItem>
                                                                    </asp:DropDownList><asp:SqlDataSource ID="sdsCaseTypes" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                        SelectCommand="Legal_GetCaseTypes" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>
                                                            &nbsp;<a href="#" onClick="setWindowedControlsVisibility(window,'visible');ShowAddNewType();"
                                                                style="font-size: 7pt;">[New Type]</a>
                                                            <%--<input class="btngreen" style="width:65px; text-align:center; height:15px; cursor:pointer; font-size: 6pt;" onclick="setWindowedControlsVisibility(window,'hidden');ShowAddNewType();" value="New Type"/>--%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" style="padding-left: 5px; width: 20%; height: 1px">
                                                        </td>
                                                        <td>
                                                            <asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvType" runat="server" ControlToValidate="ddlType"
                                                                ErrorMessage="Type is Required." InitialValue="-1" Display="Dynamic" CssClass="RequiredField"></asp:RequiredFieldValidator></td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" style="padding-left: 5px; width: 25%; height: 22px">
                                                            Status:<span class="RequiredField">*</span></td>
                                                        <td>
                                                            <asp:UpdatePanel ID="UPStatusType" runat="server" RenderMode="Inline">
                                                                <Triggers>
                                                                    <asp:AsyncPostBackTrigger ControlID="Save" EventName="Click" />
                                                                </Triggers>
                                                                <ContentTemplate>
                                                                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="MediumFontInput" Width="275px"
                                                                        DataSourceID="sdsCaseStatus" DataTextField="Name" DataValueField="ID" TabIndex="4"
                                                                        onchange="chkOptValidation();">
                                                                        <asp:ListItem Value="-1">Choose...</asp:ListItem>
                                                                    </asp:DropDownList><asp:SqlDataSource ID="sdsCaseStatus" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                        SelectCommand="Legal_GetCaseStatusTypes" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>
                                                            &nbsp;<a href="#" onClick="setWindowedControlsVisibility(window,'visible');ShowAddNewStatusType();"
                                                                style="font-size: 7pt;">[New Status]</a>
                                                            <%--<input class="btngreen" style="width:65px; text-align:center; height:15px; cursor:pointer; font-size: 6pt;" onclick="setWindowedControlsVisibility(window,'hidden');ShowAddNewStatusType();" value="New Status"/>--%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" style="padding-left: 5px; width: 20%; height: 1px">
                                                        </td>
                                                        <td>
                                                            <asp:RequiredFieldValidator SetFocusOnError="true" ID="rfvStatus" runat="server"
                                                                ControlToValidate="ddlStatus" ErrorMessage="Status is Required." InitialValue="-1"
                                                                Display="Dynamic" CssClass="RequiredField"></asp:RequiredFieldValidator></td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" style="padding-left: 5px; width: 25%; height: 22px">
                                                            Firm/Vendor:</td>
                                                        <td>
                                                            <asp:UpdatePanel ID="UPVendor" runat="server" RenderMode="inline">
                                                                <Triggers>
                                                                    <asp:AsyncPostBackTrigger ControlID="btnBinder" EventName="Click" />
                                                                </Triggers>
                                                                <ContentTemplate>
                                                                    <asp:DropDownList ID="ddlFirm" runat="server" CssClass="MediumFontInput" Width="275px"
                                                                        DataSourceID="FirmDS" DataTextField="Name" DataValueField="ID" TabIndex="5" AutoPostBack="true"
                                                                        AppendDataBoundItems="true">
                                                                        <asp:ListItem Value="-1">Choose...</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:SqlDataSource ID="FirmDS" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                        SelectCommand="SELECT [ID], [Name] FROM [Legal_Firm] WHERE ([Deleted] = 0)  Order By [Name]"></asp:SqlDataSource>
                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>
                                                            &nbsp;<a href="#" onClick="newFirm();" style="font-size: 7pt;">[New Firm/Vendor]</a>
                                                            <%--<input class="btngreen" style="width:65px; text-align:center; height:15px; cursor:pointer; font-size: 6pt;" onclick="newFirm();" value="New Vendor"/>--%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" style="padding-left: 5px; width: 20%; height: 22px">
                                                            Contact:
                                                        </td>
                                                        <td>
                                                            <asp:UpdatePanel runat="server" ID="UpdatePanel2" UpdateMode="Conditional">
                                                                <Triggers>
                                                                    <asp:AsyncPostBackTrigger ControlID="ddlFirm" EventName="SelectedIndexChanged" />
                                                                    <asp:AsyncPostBackTrigger ControlID="btnBinder" EventName="Click" />
                                                                </Triggers>
                                                                <ContentTemplate>
                                                                    <asp:DropDownList ID="ddlContact" runat="server" CssClass="MediumFontInput" Width="275px"
                                                                        DataSourceID="ContactsDS" DataTextField="Name" DataValueField="ID" TabIndex="6">
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
                                                        </td>
                                                    </tr>
                                                    <tr height="1">
                                                        <td>
                                                        </td>
                                                        <td>
                                                            <asp:CustomValidator SetFocusOnError="true" ID="rfvContact" Display="Dynamic" ClientValidationFunction="ValidateFirmContact"
                                                                CssClass="RequiredField" ErrorMessage="Choose Contact" runat="server" ControlToValidate="ddlContact"></asp:CustomValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" style="padding-left: 5px; width: 20%; height: 22px" valign="top">
                                                            Concerned Parties:
                                                        </td>
                                                        <td height="50">
                                                            <asp:TextBox ID="txtConcernedParties" CssClass="MediumGreenTextBox" TextMode="MultiLine"
                                                                Height="50px" runat="server" Width="380" MaxLength="3000" TabIndex="7">
                                                            </asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" style="padding-left: 5px; width: 20%; height: 1px">
                                                        </td>
                                                        <td>
                                                            <asp:CustomValidator SetFocusOnError="true" ID="CVParties" ClientValidationFunction="chkParties"
                                                                runat="server" ErrorMessage="Concerned parties should not exceed 3000 characters."
                                                                CssClass="RequiredField" Display="Dynamic">
                                                            </asp:CustomValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" style="padding-left: 5px; height: 22px">
                                                            Assigned to:</td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlCompAdmins" runat="server" CssClass="MediumFontInput" Width="380px"
                                                                DataSourceID="ComplianceAdminsDS" DataTextField="Name" DataValueField="ID" ValidationGroup="1"
                                                                AppendDataBoundItems="True" TabIndex="8">
                                                                <asp:ListItem Value="-1">Choose...</asp:ListItem>
                                                            </asp:DropDownList></td>
                                                    </tr>
                                                    <tr id="TRSNo">
                                                        <td align="left" style="padding-left: 5px; height: 22px">
                                                            Docket No:<asp:Label ID="st1" runat="server" CssClass="RequiredField" Text="*"> 
                                                            </asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtDocketNo" runat="server" CssClass="MediumGreenTextBox" MaxLength="100"
                                                                Width="380px" TabIndex="9"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                     <tr height="1">
                                                        <td align="left" style="padding-left: 5px;">
                                                            </td>
                                                        <td>
                                                           <asp:CustomValidator SetFocusOnError="true"
                                                                    ID="cvSerialNo" runat="server" ClientValidationFunction="chkSerial" Display="Dynamic"
                                                                    ErrorMessage="Please Enter Docket Number." CssClass="RequiredField"> 
                                                                </asp:CustomValidator></td>
                                                    </tr>
                                                    <tr id="TRRegNo">
                                                        <td align="left" style="padding-left: 5px; height: 22px">
                                                            Firm Case No:<asp:Label ID="st2" runat="server" CssClass="RequiredField" Text="*"></asp:Label></td>
                                                        <td>
                                                            <asp:TextBox ID="txtFirmCaseNo" runat="server" CssClass="MediumGreenTextBox" MaxLength="100"
                                                                Width="380px" TabIndex="10"></asp:TextBox></td>
                                                    </tr>
                                                   <tr height="1">
                                                        <td align="left" style="padding-left: 5px;">
                                                            </td>
                                                        <td>
                                                            <asp:CustomValidator SetFocusOnError="true"
                                                                    ID="cvRegNo" runat="server" ClientValidationFunction="chkReg" Display="Dynamic"
                                                                    ErrorMessage="Please Enter Outside Firm Case Number." CssClass="RequiredField"></asp:CustomValidator></td>
                                                    </tr>
                                                    
                                                    <tr>
                                                        <td align="left" style="padding-left: 5px; width: 25%; height: 22px">
                                                            Date Entered:</td>
                                                        <td>
                                                            <table cellpadding="0" cellspacing="0" style="width: 380px">
                                                                <tr>
                                                                    <td style="width: 88px; height: 22px">
                                                                        <asp:TextBox ID="txtDateEntered" runat="server" CssClass="MediumGreenTextBox" ReadOnly="True"
                                                                            Width="120px" onfocus="this.blur();"></asp:TextBox></td>
                                                                    <td align="left" style="width: 239px; color: #000000; height: 22px">&nbsp;
                                                                        
                                                                    </td>
                                                                    <td align="left" style="width: 377px; color: #000000; height: 22px">
                                                                        Case Date :</td>
                                                                    <td colspan="2" style="height: 22px">
                                                                        <asp:TextBox ID="txtCaseDate" runat="server" CssClass="MediumGreenTextBox" ReadOnly="True"
                                                                            Width="120px" onfocus="setActiveStyleSheet(this, 'calstyle');return showCalendar('txtCaseDate', 'MM/dd/y');"
                                                                            TabIndex="11"></asp:TextBox>&nbsp;<img src="../images/ico_calendar.jpg" width="24" height="20" align="absmiddle" onclick="setActiveStyleSheet(this, 'calstyle'); return showCalendar('txtCaseDate', 'MM/dd/yyyy');"
                                                                        style="cursor: pointer;"></td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2" style="height: 0px">
                                                                    </td>
                                                                    <td align="right" colspan="3" style="height: 0px">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" style="padding-left: 5px; width: 25%;" valign="top">
                                                            Description:<span class="RequiredField"><asp:HiddenField ID="hdnID" runat="server" />
                                                            </span>
                                                            <br />
                                                        </td>
                                                        <td valign="top">
                                                            <asp:TextBox ID="txtNotes" runat="server" CssClass="MediumGreenTextBox" Height="98%"
                                                                TextMode="MultiLine" Width="380px" MaxLength="2000" TabIndex="12"></asp:TextBox></td>
                                                    </tr>
                                                    <tr height="5px;">
                                                        <td align="center" colspan="2" style="padding-left: 10px" valign="top">
                                                            &nbsp;&nbsp;
                                                            <asp:SqlDataSource ID="AdminsDS" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                SelectCommand="Users_Getall" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                                            <asp:SqlDataSource ID="ComplianceAdminsDS" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                SelectCommand="Legal_GetComplianceUsers" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                                            <asp:ObjectDataSource runat="server" ID="odsFranchisee" SelectMethod="SearchFranchisee"
                                                                TypeName="CaseMgmt">
                                                                <SelectParameters>
                                                                    <asp:Parameter Name="Key" Type="String" />
                                                                </SelectParameters>
                                                            </asp:ObjectDataSource>
                                                            &nbsp;&nbsp;
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
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
                                        <asp:Button ID="BtnSave" runat="server" CssClass="btnGreen" Style="width: 80px" Text="Save" TabIndex="13" />&nbsp;                                        
                                        <input type="button" class="btnGreen" style="width:80px;" value="Cancel" onclick="window.location='Legal_Case.aspx?<%= Request.QueryString().ToString() %>';"  />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <div id="FirmTR" style="display: none; position: absolute; width: 100%; height: 100%;
                    left: 0; top: 0;">
                    <iframe id="frmNewFirm" width="100%" height="100%" frameborder="0" src="NewFirm.aspx?subpage=1">
                    </iframe>
                </div>
                <div align="center" id="FranchiseeDiv" style="display: none; left: 251px; top: 81px;
                    width: 380px; height: 360px; position: absolute; border: #50AF43 1px solid; background-color: #bde4b8;">
                    <asp:UpdatePanel ID="UPFranchisee" runat="server">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                        </Triggers>
                        <ContentTemplate>
                            <table border="0" cellspacing="0" cellpadding="0" style="font-weight: bold; font-size: 12px;
                                color: white; height: 100%; width: 100%; display: inline;" id="tblSearch">
                                <tr style="display: none;">
                                    <td height="31px" width="100%" style="cursor: default; font-weight: bold; font-size: 12px;
                                        background-image: url(images/bg_CellNormal_black.jpg); color: white; border-bottom: #000000 1px solid;">
                                        &nbsp;Franchisee</td>
                                    <td width="35" valign="top" align="right" style="padding-top: 2px; padding-right: 2px;
                                        font-weight: bold; font-size: 12px; background-image: url(images/bg_CellNormal_black.jpg);
                                        color: white; border-bottom: #000000 1px solid; height: 22px;">
                                        <img src="../images/closebox.gif" onClick="HideFranSearch();"></td>
                                </tr>
                                <tr>
                                    <td colspan="2" height="31" style="color: Black; padding-left: 5px; border-bottom: #50af43 1px solid;">
                                        <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSearch" Height="50px" Width="125px">
                                            <table cellpadding="0" height="31" cellspacing="0" class="GreyTextSmall">
                                                <tr>
                                                    <td style="color: Black; background-color: #BDE4B8; width: 80px; height: 13px;" colspan="2">
                                                        Search:
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:TextBox ID="txtSearch" runat="server" CssClass="greenTextbox" Width="120px"
                                                            MaxLength="25"></asp:TextBox>&nbsp;</td>
                                                    <td align="left" style="width: 20px;">
                                                        <asp:ImageButton ID="btnSearch" align="absmiddle" runat="server" ImageUrl="~/images/ico_bullet.gif"
                                                            CausesValidation="False" /></td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                        Please enter a keyword to search franchise.</td>
                                </tr>
                                <tr>
                                    <td colspan="2" valign="top" bgcolor="#FFFFFF" style="border-bottom: #50af43 1px solid;
                                        border-top: #000000; border-right: 0px; border-left: 0px;">
                                        <div style="overflow-y: auto; height: 100%; width: 100%;">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                                                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="FranchiseSearchDS">
                                                    <ItemTemplate>
                                                        <tr style="font-size: 11px; font-family: Arial, Helvetica, Sans-Serif; padding-left: 0.5em;
                                                            border-bottom: 2px inset #E5F1FB; cursor: pointer; height: 20px; padding-right: 0px;"
                                                            onclick="setWindowedControlsVisibility(window,'visible');setFranchisee('<%#Container.DataItem("ID")%>','<%#Container.DataItem("Store")%>');document.getElementById('ddlType').focus();"
                                                            onmouseover="this.className='HighlightedHomeRow';" onMouseOut="this.className='SimpleHomeRow';">
                                                            <td class="GridArrowColumn" style="width: 10px; height: 20px; border-bottom: 2px inset #E5F1FB;"
                                                                valign="top">&nbsp;
                                                                
                                                            </td>
                                                            <td style="font-size: 11px; font-family: Arial, Helvetica, Sans-Serif; text-align: left;
                                                                padding-left: 0.5em; border-bottom: 2px inset #E5F1FB; cursor: pointer; height: 20px;
                                                                padding-right: 0px; border-bottom: 2px inset #E5F1FB;" valign="top">
                                                                <asp:Label ID="Label1" runat="server" Text='<%#Eval("Store").ToString() %>'></asp:Label></td>
                                                        </tr>
                                                       
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <tr>
                                                            <td height="100%" style="display: none;">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr id="trNoRec" runat="server" visible="false">
                                                            <td align="center" valign="middle" style="height: 100%">
                                                                No Franchisee found.
                                                            </td>
                                                        </tr>
                                                    </FooterTemplate>
                                                </asp:Repeater>
                                            </table>
                                            <asp:ObjectDataSource ID="FranchiseSearchDS" runat="server" SelectMethod="SearchFranchisee"
                                                TypeName="CaseMgmt">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="txtSearch" Name="Key" PropertyName="Text" Type="String"
                                                        ConvertEmptyStringToNull="true" />
                                                </SelectParameters>
                                            </asp:ObjectDataSource>
                                        </div>
                                    </td>
                                </tr>
                                <tr style="background-color: #BDE4B8">
                                    <td height="31" colspan="2" align="center">
                                        <input id="Close" name="Close" class="btnGreen" type="button" value="Close" style="width: 50px;
                                            height: 22px;" onClick="HideFranSearch();">
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
