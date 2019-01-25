<%@ Page Language="VB"  AutoEventWireup="false" CodeFile="Clock.aspx.vb" Inherits="HR_test"  %>

<html xmlns="http://www.w3.org/1999/xhtml">
 <head runat="server">
 <title></title>
    <style type="text/css">
    <!--
        body {
	        font-family: verdana, Arial, Helvetica, sans-serif;
	        font-weight: normal;
	        color: #000000;
	        margin: 0px;
        }
        .heading {
	        font-size: 44px;
	        font-weight: normal;
	        
        }
        .subHeading {
	        font-size: 20px;
	        font-weight: normal;
	        color:#000000;
	        
        }
        .bg_form1 {
	        background-color: #E4F2F5;
        }
      -->
    </style>
 </head>
 <body>
 <form runat="server" id="from1">
 <div style="text-align:center;">
<table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="bg_form1">
   <tr>
    <td >
      <span id="serverdate" class="subHeading"></span>
      <br />
      <span id="servertime" class="heading"></span>
    </td>
  </tr>
    <asp:HiddenField ID="HdnUserTime" runat="server" />
 </table>
 </div>
  </form>
 </body>
 <script type="text/javascript">
         var currenttime = document.getElementById('<%=HdnUserTime.ClientID%>').value;
         var montharray=new Array("January","February","March","April","May","June","July","August","September","October","November","December")
         var serverdate=new Date(currenttime)
         var pagetimeout = 0;
    function displaytime()
    {   
        serverdate.setSeconds(serverdate.getSeconds()+1)
        var datestring=montharray[serverdate.getMonth()]+" "+padlength(serverdate.getDate())+", "+serverdate.getFullYear()
        var timestring=padlength(serverdate.getHours())+":"+padlength(serverdate.getMinutes())+":"+padlength(serverdate.getSeconds())
        var curtime = new Date();
        var curhour = serverdate.getHours(); 
        var curmin = serverdate.getMinutes();
        var cursec = serverdate.getSeconds();
        var time = "";

          if(curhour == 0) curhour = 12;
          time = (curhour > 12 ? curhour - 12 : curhour) + ":" +
                 (curmin < 10 ? "0" : "") + curmin + ":" +
                 (cursec < 10 ? "0" : "") + cursec + " " +
                 (curhour >= 12 ? "PM" : "AM");
    	
        document.getElementById("serverdate").innerText=datestring;
        document.getElementById("servertime").innerText=time;
    }
    
    function padlength(what)
    {
        var output=(what.toString().length==1)? "0"+what : what;
        return output;
    }
    
    window.onload=function()
    {   
        setInterval('displaytime()', 1000);         
    }

</script>
</html>
