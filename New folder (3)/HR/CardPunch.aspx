<%@ Page Language="VB" AutoEventWireup="false" CodeFile="~/HR/CardPunch.aspx.vb" Inherits="HR_CardPunch"
    Title="" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
  <link href="StylesHR.css" rel="STYLESHEET" type="text/css" />

    

</head>
<body style="margin: 0px; background-color: #E4F1F7; width: 100%; height: 100%;" >
    <form id="form1" runat="server" >
        <div id="divDisable" class="modalBackground" style="display: none; height: 100%;
            width: 100%" runat="server">
        </div>
        <div>
            <asp:ScriptManager ID="sc" runat="server" ></asp:ScriptManager>
            <asp:UpdatePanel ID="UPpanel" runat="server" >
             <ContentTemplate>
                <table id="tblPunch" runat="server" visible="false"  width="100%" style="height: 100%; font-size: 12px; font-family: Verdana;"
                border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td style="padding-left: 5px; vertical-align: top; height: 30%;" width="30%" valign="top">
                        <asp:Label runat="server" ID="hdnuserid" Style="display: none;" />
                        <asp:Label runat="server" ID="hdnusergroupid" Style="display: none;" />
                        <asp:Label runat="server" ID="hdntimezineoffset" Style="display: none;" />
                        <asp:Label runat="server" ID="hdnPunchInTime" Style="display: none;" />
                        <asp:Label runat="server" ID="hdnPunchOutTime" Style="display: none;" />
                        <asp:Label runat="server" ID="hdnForcedPunchOut" Value="false" Style="display: none;" />
                        <asp:Label runat="server" ID="HdnPunchInLimit" Style="display: none;" />
                        <asp:HiddenField runat="server" ID="hdnKey" Value="" />
                        Welcome &nbsp;<span id="SpanWellCome" runat="server" style="font-size: 18px; font-weight: bold;
                            font-family: Verdana;"></span>
                       <br />
                        <asp:Label ID="lblMainStatus" runat="server" Font-Bold="True" Font-Size="17px" ForeColor="Red">&nbsp;</asp:Label>     
                        <br />
                        <br />
                        Last Activity:&nbsp;<span id="lastpunchintime" runat="server" style="font-size: 17px;
                            font-weight: bold; font-family: Verdana;"></span>
                        <br />
                        Closing In <span id="timeout" style="font-size: large;">3</span> Seconds
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="100%" style="height: 100%;" border="0" cellpadding="1" cellspacing="1" style="display:none;">
                            <tr>
                                <td valign="top">
                                    &nbsp;&nbsp;<img src="Images/ico_login.gif" />
                                </td>
                                <td align="left" valign="top" style="padding-top: 25px; padding-left: 25px;">
                                    <div>
                                        <asp:ImageButton ID="btnActivity" runat="server" ImageUrl="~/HR/Images/btn_punchin.gif" />
                                        <asp:ImageButton ID="btnExit" runat="server" ImageUrl="~/HR/Images/btn_exit_Punch2.gif" />
                                        <asp:ImageButton ID="btnPunchInterval" runat="server" ImageUrl="~/HR/Images/btn_exit_Punch2.gif" />
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td valign="top" style="height: 15%">
                        <asp:Label ID="lbMessage" runat="server" Font-Bold="false" Font-Size="9pt" ForeColor="Red" style="display:none;">&nbsp;</asp:Label>
                    </td> 
                </tr>
             </table>
               <table id="tblLogin" runat="server" visible="true" width="100%" style="height:100%" border="0" cellpadding="1" cellspacing="0">
			           <tr>
                          <td align="left" colspan="2" width="100%" valign="middle" style="font-size:14px; font-family:Verdana; font-weight:bold;">
                            <asp:Label ID="lbErrMessage" runat="server" Text="Show your employee card."></asp:Label>
                          </td>
                       </tr>
                      <!-- User Input Table  -->
		              <tr>
			            <td align="left" valign="top">&nbsp;&nbsp;<img src="images/ico_login.gif" /></td>
			            <td valign="top" style="padding-top:10px;">
			                <table width="100%" border="0" cellspacing="0"  cellpadding="0" style="font-size:12px;font-family:Verdana;">
				                <tr style="vertical-align:top;">
				                  <td width="100" >Login: </td>
				                  <td>
				                    <asp:Panel ID="pnl" runat="server" DefaultButton="btnEmployeeLogin">
				                        <asp:TextBox ID="txtEmployeeID" runat="server" MaxLength="50" Width="178px" TextMode="Password" ></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" 
                                            runat="Server" ControlToValidate="txtEmployeeID"
                                            Text="Please Enter User Name" Display="None"  >
                                        </asp:RequiredFieldValidator>
                                      </asp:Panel>
                                  </td>
				                </tr>
				                <tr style="vertical-align:top;padding-top:5px;">
				                  <td width="100" ></td>
				                  <td>
				                   <asp:ImageButton ID="btnEmployeeLogin" runat="server" ImageUrl="Images/btn_login.jpg" style="display:none;" />             
                                 </td>
				                </tr>
					        </table>
		                </td>
			          </tr>	
			        </table>
             </ContentTemplate>
            </asp:UpdatePanel>
            
        </div>
        <div id="dvLateComing" class="DivLateCome" style="display: none; overflow: hidden;
            left: 25%; top: 35%; width: 410px; height: 160px; position: absolute;" runat="server">
           <span style=" margin-left:10px; font-weight:bold; height:20px; vertical-align:middle">Please enter reason for late arrival:  </span><br />
            <div style="margin-left:10px;">
            <asp:TextBox runat="server" ID="txtMessage" Rows ="5" Height="94px" Width="389px" TextMode="MultiLine"></asp:TextBox><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtMessage" ValidationGroup="Latecoming"
                runat="server" Display="dynamic" ErrorMessage="Please enter reason"></asp:RequiredFieldValidator><br />
                </div>
                <div style="float:right; margin-right:3px;">
            <asp:Button runat="server" Text="Save" ID="btnSubmit" ValidationGroup="Latecoming" /></div></div>
    </form>
</body>

<script type="text/javascript">

        var pagetimeout = 0;
        var valsetinterval = null; 
               
        function displaytime()
        {
            if(pagetimeout < 3)
            {
                pagetimeout = pagetimeout + 1;
	            document.getElementById("timeout").innerHTML=3-pagetimeout	        
            }
            else
            {  
            
                if(valsetinterval != null)
                clearInterval(valsetinterval);
                
                if(document.getElementById('<%=dvLateComing.ClientID %>').style.display == "none")
                {
                    //document.getElementById('<%=btnExit.ClientID %>').click();
                    document.getElementById('<%=btnPunchInterval.ClientID %>').click();
	                return false;
                }
	              
            }
        }
        
        //Call the function rapidly to update the time informaiton
        window.onload=function()
        {       
           //valsetinterval =  setInterval('displaytime();', 1000);
        }
        function PunchInterval()
        {  
           pagetimeout = 0;      
           valsetinterval =  setInterval('displaytime();', 1000);
        }
        
        function padlength(what)
        {
            var output=(what.toString().length==1)? "0"+what : what;
            return output;
        }
    </script>
</html>
