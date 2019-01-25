<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FranchiseAutoSignIn.aspx.vb" Inherits="FranchiseAutoSignIn" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
	<head runat="server">
		<link rel="stylesheet" href="App_Themes/Default/Style.css" />
        <title>Signing In</title>
  </head>
	<body onload="frmSignIn.submit()" >
	<div align="center" id="divLoading" style="display: inline; border: 1px solid black; position: absolute; BACKGROUND-COLOR: #EDEFF8; width:35%; height:10%; left:35%; top:35%; z-index:1000 " class="MessageDiv"> 
	 <table width="100%" height="70" border="0" cellpadding="0" cellspacing="0">
	 <tr bgcolor="#000099">
		<td height="20" colspan="2"  valign="middle" id="divHeading" class="MessageDivHeading">&nbsp;Please wait....</td>
	 </tr>
	 <tr><td width="20%" align="right" valign="middle" height="60"><div align="right"><img src="images/loading.gif" align="absmiddle" id="imgInfo" >&nbsp;&nbsp; </div></td>
				<td width="80%" align="left" valign="middle" id="divMessage" class="SimpleSmall">&nbsp;Signing in...</td>
	 </tr></table>
	</div>

<%  If CInt(reqAccountType) = Portal.BLL.Enumeration.LoginAccountID.Owner Then%>
  
    <form id="frmSignIn" name="frmSignIn" method="post" action="<%= strFranSupportFranchiseeLoginPostUrl %>">
            <input type="hidden" name="CompanyCode" id="CompanyCode" value="EA" />
			<input name="Username" type="hidden" id="txtUsername" size="20" maxlength="50" value="<%= strUserName %>" />
			<input name="Password" type="hidden" id="txtPassword" size="20" maxlength="50" value="<%= strPassword %>" />
			<input type="hidden" name="txtPINPassword" value="2345" />
			<input type="hidden" name="SMSPin" value="<%=Functions.EncryptData("NET@HaEA7")%>" />
			<input name="txtPIN" type="hidden" id="txtPIN" size="12" maxlength="4" value="1414" />
			<input type="hidden" name="CoordinatorLogin" value="<%= reqCoordinator %>" />
			<input type="hidden" name="FranchiseID" value="<%= reqFrachiseID %>" />
    </form>
<%  Else
        Response.Redirect(strFranSupportStoreLoginPostUrl & "?UserName=" & Functions.EncryptData(strUserName) & "&Password=" & Functions.EncryptData(strPassword) & "&StoreNumber=" & strStoreNumber & "&CoordinatorLogin=" & reqCoordinator)
 End If %>

</body>
</html>