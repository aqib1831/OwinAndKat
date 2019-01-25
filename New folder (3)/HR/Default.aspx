<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="HR_Default" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
<script type="text/javascript">
    var valsetinterval = null; 
    function message()
    {  
       valsetinterval =  setInterval('reset();', 3000);
    }
    function reset()
    {   
        if(valsetinterval != null)
        clearInterval(valsetinterval);
        document.getElementById('<%=lbErrMessage.ClientID %>').innerText = 'Employee Sign in. . .';	        
        document.getElementById('<%=lbErrMessage.ClientID %>').style.color = 'black';
        return false;
    }
</script>
</head>
<body style ="margin :0px; background-color:#E4F1F7; width:100%; height:100%;" >
    <form id="form1" runat="server">
    <div>
        <table width="100%" style="height:100%;" scroll="no" border="0" align="center" cellpadding="1" cellspacing="0">
             <tr>
                 <td style="height:15%" >
                    <table width="100%" style="height:100%" border="0" cellpadding="1" cellspacing="0">
			           <tr>
                          <td align="left" colspan="2" width="100%" valign="middle" style="font-size:14px; font-family:Verdana; font-weight:bold;">
                            <asp:Label ID="lbErrMessage" runat="server" Text="Employee Sign in. . ."></asp:Label>
                          </td>
                       </tr>
                      <!-- User Input Table  -->
		              <tr>
			            <td align="left" valign="top">&nbsp;&nbsp;<img src="images/ico_login.gif" /></td>
			            <td valign="top" style="padding-top:10px;">
			                <table width="100%" border="0" cellspacing="0"  cellpadding="0" style="font-size:12px;font-family:Verdana;">
				                <tr style="vertical-align:top;">
				                  <td width="100" >User Name: </td>
				                  <td>
				                    <asp:TextBox ID="txtEmployeeID" runat="server" MaxLength="50" Width="150px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" 
                                        runat="Server" ControlToValidate="txtEmployeeID"
                                        Text="Please Enter User Name" Display="Dynamic" >
                                    </asp:RequiredFieldValidator>
                                  </td>
				                </tr>
				                <tr style="vertical-align:top;">
				                  <td width="100" >Password:</td>
				                  <td>
				                    <asp:TextBox ID="txtPassword" runat="server" MaxLength="50" TextMode="Password" Width="150px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" 
                                        runat="server" ControlToValidate="txtPassword"
                                          Text="Please Enter Password" Display="Dynamic" >
                                    </asp:RequiredFieldValidator>
                                 </td>
				                </tr>
					        </table>
		                </td>
			          </tr>	
			        </table>
                 </td>
             </tr>      
             <tr>
                <td align="center" valign="top"  >
                      <asp:ImageButton ID="btnEmployeeLogin" runat="server" ImageUrl="Images/btn_login.jpg" />             
                </td>
             </tr>       
        </table>
    </div>
    </form>
</body>
</html>
