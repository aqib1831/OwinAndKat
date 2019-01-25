<%@ Page Language="VB" AutoEventWireup="false" CodeFile="WeeklyLetter_Head.aspx.vb" Inherits="admin_comm_WeeklyLetter_Head" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Weekly Letter</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
    .BtnGreen
    {
    border:1px solid #3A5684;
    font-family:Verdana;
    letter-spacing:-1px;
    word-spacing:1px;
    text-transform:uppercase;
    font-size:10px;
    font-weight:bold;
    color:#333333;
    background-color:#A3B7D7;
    height:20px;
    }
    .SimpleSmall
    {
    FONT-SIZE: 8pt;
    FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif;
    }

    </style>
    
    <script language="javascript">
    function SetPosition()
    {
        if (navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.toUpperCase().indexOf("MSIE 7.0") < 0)
        {
            //setWindowedControlsVisibility(window,'hidden');
        }   
        divDisable.style.width = document.body.scrollWidth - 1;
        divDisable.style.height = document.body.scrollHeight - 1;
    }
    </script>
    
</head>
<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" scroll="no">
<div id="divDisable" class="modalBackground"></div>
<form id="frmWeeklyLetterHead" runat="server">
<asp:HiddenField ID="hdnLetterID" runat="server" Value="0" />
<table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top"><table width="100%" height="100%"  border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#ACBDD5">
              <tr>
                <td><iframe runat="server" id="frameWeeklyLetter" name="frameWeeklyLetter" width="100%" height="100%" frameborder="0"></iframe></td>
              </tr>
              <tr bordercolor="#E0E0E0" bgcolor="#486BA3">
                <td height="30" align="center" class="SimpleSmallBold" style="border-bottom:solid 1px #3A5684">
   	                <asp:Button ID="btnPublish" runat="server" CssClass="BtnGreen" Text="Publish" Width="80" />
	                <%--<input runat="server" type="button" id="btnBack" class="BtnGreen" onclick="window.location='<%= ConfigurationManager.AppSettings("FranSupportUrl").ToString() %>admin/mgmt/main.asp?PageName=EAIWeekly'" value="Back" style="width:80px;" />--%>
	                <asp:Button ID="btnBack" runat="server" CssClass="BtnGreen" Text="Back" Width="80" />
	                <asp:Button ID="btnBackFranchisee" runat="server" CssClass="BtnGreen" Text="Back" Width="80" />
	                <asp:Button ID="btnFranchiseContinue" runat="server" CssClass="BtnGreen" Text="Continue" />
	                <asp:Button ID="btnAdminContinue" runat="server" CssClass="BtnGreen" Text="Continue" Width="80" />
	                <input type="button" id="btnPrint" class="BtnGreen" onclick="frameWeeklyLetter.location='Weeklyletter_print.aspx?LetterID=<%= hdnLetterID.value %>&StoreEmployee=<%= Request.QueryString("StoreEmployee") %>'" value="Print" style="width:80px;" />
        		</td>
              </tr>
          </table></td>
        </tr>
    </table>
</form>

<div align="center" id="WaitingDiv" style="display:none; border: 1px solid black; position: absolute; width:15%; height:35; left:40%; top:35%; z-index:1003 " > 
 <table width="100%" height="50" border="0" cellpadding="0" cellspacing="0" bgcolor="#E7EFC6">
    <tr>
            <td align="right"><img src="../images/indicator.gif" /></td>
			<td width="70%" valign="middle" id="divMessage" class="SimpleSmall">
			    &nbsp;&nbsp;Please wait...
			</td>
    </tr>
 </table>
</div>

</body>
</html>
