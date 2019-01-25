<%@ Page Language="VB" AutoEventWireup="false" CodeFile="~/HR/TimeCard.aspx.vb" Inherits="HR_TimeCard" title="" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
    <script type="text/javascript">

        var pagetimeout = 0;
        var valsetinterval = null; 
               
        function displaytime()
        {
            if(pagetimeout < 9)
            {
                pagetimeout = pagetimeout + 1;
	            document.getElementById("timeout").innerHTML=9-pagetimeout	        
            }
            else
            {  
                if(valsetinterval != null)
                clearInterval(valsetinterval);
	            document.getElementById('<%=btnExit.ClientID %>').click();	        
	            return false;
            }
        }
        
        //Call the function rapidly to update the time informaiton
        window.onload=function()
        {       
           valsetinterval =  setInterval('displaytime();', 1000);
        }
        
        function padlength(what)
        {
            var output=(what.toString().length==1)? "0"+what : what;
            return output;
        }
    </script>
</head>
<body style ="margin :0px; background-color:#E4F1F7; width:100%; height:100%;" >
  <form id="form1" runat="server">
    <div>
        <table width="100%" style="height:100%;font-size:12px;font-family:Verdana;" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                    <td style="padding-left:5px; vertical-align:top;height:30%;" width="30%" valign="top" >
                        <asp:Label runat="server"  ID="hdnuserid" style="display:none;" />
                        <asp:Label runat="server"  ID="hdnusergroupid" style="display:none;" />
                        <asp:Label runat="server" ID="hdntimezineoffset" style="display:none;" />
                        <asp:Label runat="server"  ID="hdnPunchInTime" style="display:none;" />
                        <asp:Label runat="server"  ID="hdnPunchOutTime" style="display:none;" />
                        <asp:Label runat="server"  ID="hdnForcedPunchOut" Value="false"  style="display:none;"/>
                        <asp:Label runat="server"  ID="HdnPunchInLimit" style="display:none;" />
                        <asp:HiddenField runat="server"  ID="hdnKey" Value=""  />
                        
                        Welcome &nbsp;<span id="SpanWellCome" runat="server" style="font-size:18px;font-weight:bold;font-family:Verdana;"></span>
                        <br />
                         Last Activity:&nbsp;<span id="lastpunchintime" runat="server" style="font-size:17px;font-weight:bold;font-family:Verdana;"></span>
                        <br />
                         Closing In
				          <span id="timeout" style="font-size:large;">9</span>
				          Seconds
                    </td>
                 </tr>
                 
                 <tr>
		              <td >
		              <table width="100%" style="height:100%;" border="0" cellpadding="1" cellspacing="1">
			              <tr>
			                    <td valign="top" >
			                        &nbsp;&nbsp;<img src="Images/ico_login.gif" />
			                    </td>
				                <td align="left" valign="top" style="padding-top:25px;padding-left:25px;" >
				                   <asp:ImageButton ID="btnActivity" runat="server" ImageUrl="~/HR/Images/btn_punchin.gif" />
				                   <asp:ImageButton ID="btnExit" runat="server" ImageUrl="~/HR/Images/btn_exit_Punch2.gif" />                            
                                </td>
				            </tr>
		              </table>
		              </td>
		          </tr>
        		
		         <tr>
	                  <td  valign="top" style="height:15%" >
	                    <asp:Label ID="lbMessage" runat="server" Font-Bold="false" Font-Size="9pt" ForeColor="Red">&nbsp;</asp:Label>
	                  </td>
		        </tr>

        </table> 
    </div>
  </form>

</body>
</html>