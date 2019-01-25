<%@ Control Language="VB" AutoEventWireup="false" CodeFile="~/HR/leftpanel_HR.ascx.vb" Inherits="leftpanel_HR"  %>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:solid 0px #EEEDE5; height:100%;"  bgcolor="#D8EAFC">
     <tr onclick="javascript:RedirectPage(1);" runat="server" visible="true"  id="tr1" class="Calendar_Normal">
            <td align="center" style="width: 10px"  >
                  <div width="17" runat="server" id="Div1" height="31"  align="center" />
            </td>
            <td colspan="2"  align="left" >
                &nbsp;<a href="#">Employee Time History</a>
           </td>
     </tr>
     <tr onclick="javascript:RedirectPage(2);" runat="server" id="tr2" class="Calendar_Normal">
            <td align="center" style="width: 10px"  >
                  <div width="17" runat="server" id="Div2" height="31"  align="center" />
            </td>
            <td colspan="2"  align="left" >
                &nbsp;<a href="#">Manage Time History</a>
           </td>
     </tr>   
    <tr onclick="javascript:RedirectPage(3);" runat="server" id="tr3" class="Calendar_Normal" style="display:inline;">
            <td align="center" style="width: 10px"  >
                  <div width="17" runat="server" id="Div3" height="31"  align="center" />
            </td>
            <td colspan="2"  align="left" >
                &nbsp;<a href="#">Netsolace Careers</a>
           </td>
     </tr>   
     <tr onclick="javascript:RedirectPage(4);" runat="server" id="tr4" class="Calendar_Normal" style="display:inline;">
            <td align="center" style="width: 10px"  >
                  <div width="17" runat="server" id="Div4" height="31"  align="center" />
            </td>
            <td colspan="2"  align="left" >
                &nbsp;<a href="#">New Interface</a>
           </td>
     </tr>   
     
	 <tr  valign="top">
         <td colspan="3" id="display" style="height:170px; padding:6px;"  valign="top"></td>
     </tr>
     <tr >
        <td colspan="3">&nbsp;</td>
     </tr>
</table>
<script type="text/javascript" language="javascript" >
   
   function RedirectPage(Page)   
    {
                ChangeTrBackGround(Page);   
                if (Page==1)
                {         
                IfHR.location='UsersTimeHistory.aspx';
                }
                else if (Page==2)
                {        
                IfHR.location='ManageTimeHistory.aspx';
                }
                else if (Page==3)
                { 
                  IfHR.location='Career.aspx';
                }
				else if (Page==4)
                { 
                  window.location='HRMainNew.aspx';
                }
				
      }
      function ChangeTrBackGround(type)
        {
            document.getElementById('<%= tr1.ClientID %>').className="Calendar_Normal";
            document.getElementById('<%= tr2.ClientID %>').className="Calendar_Normal";
            document.getElementById('<%= tr3.ClientID %>').className="Calendar_Normal";
			document.getElementById('<%= tr4.ClientID %>').className="Calendar_Normal";
       
            if (type==1)
                {
                document.getElementById('<%= tr1.ClientID %>').className="Calendar_Selected";
                }
           else if (type==2)
                {
                document.getElementById('<%= tr2.ClientID %>').className="Calendar_Selected";
                }     
           else if (type==3)
                {
                document.getElementById('<%= tr3.ClientID %>').className="Calendar_Selected";
                }
			else if (type==4)
                {
                document.getElementById('<%= tr4.ClientID %>').className="Calendar_Selected";
                }                              
                 
      }
      function HideRow()
      {        
        document.getElementById('<%= tr2.ClientID %>').style.display = 'none';
        document.getElementById('<%= tr3.ClientID %>').style.display = 'none';
      }

</script>