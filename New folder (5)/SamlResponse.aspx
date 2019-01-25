<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SamlResponse.aspx.vb" Inherits="SamlResponse" %>


<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Portal Mail Login</title>
    <script type="text/javascript"  language="javascript"><!--
      function SubmitLoginForm() {
        document.forms[0].submit();
      }
    //-->
  </script>
</head>
<body onload="SubmitLoginForm()">
    <form id="form1" method="post" action="SignIn.aspx" style="display:none;">
        <input runat="server" type="text" id="Username" name="Username" size="50" maxlength="50" /><br />
        <textarea id="SAMLRequest" style="display:none" name="SAMLRequest" cols="130" rows="15"   runat="server"></textarea><br />
        <textarea id="RelayState" style="display:none" name="RelayState" cols="130" rows="5" runat="server"></textarea><br />
    </form>
</body>
</html>
