<%@ Page Language="VB"  MasterPageFile="MasterPage.master" AutoEventWireup="false" CodeFile="VisitorLog.aspx.vb" Inherits="HR_VisitorLog" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMiddle" Runat="Server">
<script type="text/javascript">
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
</script>
<table width="100%" style="height:100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
	<td style="height:25px">&nbsp;</td>
  </tr>
  <tr>
	<td>
	
	  <table width="85%" style="height:100%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
		  <td>
		  <table width="100%" style="height:100%" border="0" cellpadding="0" cellspacing="0">
			<tr style="height:8px;">
			  <td colspan="3">
			      <table width="100%" style="height:100%;" border="0" cellspacing="0" cellpadding="0">
				      <tr>
					    <td width="8"><img src="images/form_top_left.jpg" width="8" height="8"></td>
					    <td valign="top" background="images/form_top_cntr.jpg"><img src="images/form_top_cntr.jpg" width="8" height="8"></td>
					    <td width="8"><img src="images/form_top_right.jpg" width="8" height="8"></td>
				      </tr>
			      </table>
			  </td>
			</tr>
			
			<tr>
			  <td width="1" background="images/form_left.jpg"><img src="images/form_left.jpg" width="1" height="8" /></td>
			  <td valign="top" class="bg_form1">
				 <table width="90%" style="height:100%" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr>
				  <td style="height:55px" align="center" class="subHeading"><asp:Label ID="lbErrMessage" runat="server" Text="Visitor Log . . ."></asp:Label></td>
				</tr>
				<tr>
				  <td>
				     <table width="100%" style="height:100%" border="0" cellpadding="0" cellspacing="0">
					     <tr>
						<td width="62"><img src="images/icon_login.gif" width="51" height="61" /></td>
						<td width="100">
						    <table width="100%" border="0" cellspacing="0" cellpadding="0">
							    <tr>
							      <td><img src="images/spacer.gif" width="100" height="1" /></td>
							      <td align="left"><img src="images/spacer.gif" width="170" height="1" /></td>
							    </tr>
							    <tr>
							      <td width="100" style="height:28px">Your Name : </td>
							      <td><asp:TextBox ID="txtEmployeeID" runat="server"></asp:TextBox></td>
							    </tr>
							    <tr>
							      <td width="100" style="height:28px">Telephone : </td>
							      <td><asp:TextBox ID="txtPassword" runat="server"></asp:TextBox></td>
							    </tr>
							    <tr>
							      <td width="100" style="height:28px">Meeting Who? </td>
							      <td><asp:TextBox ID="MeetingWho" runat="server"></asp:TextBox></td>
							    </tr>
						    </table>
						    </td>
						    <td><input type="image" src="images/btn_go.gif" width="26" height="30" /></td>
						    <td>&nbsp;</td>
						    </tr>
				     </table>
				  </td>
				</tr>
				<tr>
				  <td style="height:75px" valign="top">
				  <table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
					  <tr>
						<td style="height:30px" align="center" class="subHeading"><span id="serverdate"></span></td>
					  </tr>
					  <tr>
						<td align="center" class="heading"><span id="servertime"></span></td>
					  </tr>
				  </table>
				  </td>
				</tr>
			  </table>
			  </td>
			  <td width="1" background="images/form_right.jpg"><img src="images/form_right.jpg" width="1" height="8" /></td>
			</tr>
			
			<tr style="height:8px;">
			  <td colspan="3"><table width="100%" style="height:100%;" border="0" cellspacing="0" cellpadding="0">
				<tr>
				  <td width="8"><img src="images/form_bottom_left.jpg" width="8" height="8"></td>
				  <td valign="top" background="images/form_bottom_cntr.jpg"><img src="images/form_bottom_cntr.jpg" width="8" height="8"></td>
				  <td width="8"><img src="images/form_bottom_right.jpg" width="8" height="8"></td>
				</tr>
			  </table></td>
			</tr>
		  </table>
		  </td>
		</tr>
	</table>
		
	</td>
  </tr>
  <tr>
	<td style="height:60px">
	    <table width="52%" border="0" align="center" cellpadding="0" cellspacing="0">
		    <tr>
		      <td width="161" align="right"><asp:ImageButton ID="btnEmployeeLogin" runat="server" Height="34px" ImageUrl="Images/btn_empLogin.jpg" Width="138px" /></td>
		      <td width="10">&nbsp;</td>
		      <td width="163" align="left"><asp:ImageButton ID="ImageButton1" runat="server" Height="34px" ImageUrl="Images/btn_visitorLogin.jpg" Width="138px" /></td>
		    </tr>
	    </table>
	</td>
  </tr>
</table>                        
</asp:Content>