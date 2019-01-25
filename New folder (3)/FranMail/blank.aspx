<%@ Page Language="VB" AutoEventWireup="false" CodeFile="blank.aspx.vb" Inherits="FranMail_blank" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div class="ProgressIndicatorDIV" style="width:250px; bottom: 10px;" >
            <br />
            <asp:Image ID="Image2" runat="server" ImageUrl="~/images/indicator.gif" ImageAlign="AbsMiddle" /> <span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Loading Email...</b></span>
            <br /><br />
         </div>
    </div>
    </form>
</body>
</html>
