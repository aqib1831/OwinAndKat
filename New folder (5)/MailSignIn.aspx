<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MailSignIn.aspx.vb" Inherits="MailSignIn" %>

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
    <body onload="SubmitLoginForm();">
       <form id="form1" method="post" action="http://mail.google.com/a/netsolace.com"> 
        </form>
    </body>
</html>