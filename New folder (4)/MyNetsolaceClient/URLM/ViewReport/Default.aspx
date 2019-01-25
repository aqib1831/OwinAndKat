<%@ Page Language="VB" ValidateRequest="false" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default2" %>



<html>
<head runat="server">
    <title>Netsolace Portal</title>
    <link href="Report.css" rel="stylesheet" type="text/css" />
    
</head>

<script type="text/javascript" language="javascript">
  function Body_OnLoad()
    {
			window.focus();
				if (factory.printing == null)
					return;
			try
			{		
			factory.printing.header = "&w&bPage &p of &P"
			factory.printing.footer = "";
			factory.printing.leftMargin = 0.50;
			factory.printing.rightMargin = 0.50;
			factory.printing.topMargin = 0.75;
			factory.printing.bottomMargin = 0.70;
			//factory.printing.Print(true);
			
			} catch(e) {}
    }
</script>

<body   onload="Body_OnLoad();">
<object id="factory" viewastext style="display:none" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814" codebase="ScriptX.cab#Version=6,2,433,9"></object>
    <form id="form1" runat="server">
    

    <%=HTMLString%>
 
    </form>
</body>
</html>
