<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SignIn.aspx.vb" Inherits="SignIn" %>

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
    <form id="FormSamlResponse" method="post" action="<%= ActionUrl %>" style="display:none" >
            <textarea id="SAMLResponse" name="SAMLResponse" cols="130" rows="15" runat="server"></textarea><br />
            <textarea id="RelayState" name="RelayState" cols="130" rows="5" runat="server"></textarea><br />
            <asp:Literal ID="LiteralAssertionUrl" runat="server" />
        
        <textarea id="TextAreaSamlRequestEncoded" cols="130" rows="5" runat="server" name="TextAreaSamlRequestEncoded"></textarea><br />
        <textarea id="TextAreaSamlRequestDecoded" cols="130" rows="8" runat="server" name="TextAreaSamlRequestDecoded"></textarea><br />
    </form>
    
</body>
</html>
