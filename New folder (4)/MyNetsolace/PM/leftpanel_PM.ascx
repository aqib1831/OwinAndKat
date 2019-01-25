<%@ Control Language="VB" AutoEventWireup="false" CodeFile="leftpanel_PM.ascx.vb" Inherits="contacts_leftpanel_PM"  %>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:solid 0px #EEEDE5; height:100%;"  bgcolor="#D8EAFC">
      <tr onclick="javascript:RedirectPage(5);" runat="server"  visible="true" id="tr_five" class="Calendar_Normal">
        <td align="right" style="width: 10px"  >
            <div width="17" runat="server" id="Div2" height="31" align="right" />
        </td>
        <td colspan="2"  align="left" title="Click to Make New Ticket" >
            &nbsp;
            <a href="#">New Ticket</a>&nbsp;</td>
     </tr>
     <tr onclick="javascript:RedirectPage(2);" runat="server"  visible="true" id="tr1" class="Calendar_Normal">
        <td align="right" style="width: 10px"  >
            <div width="17" runat="server" id="Div5" height="31" align="right" />
        </td>
        <td colspan="2"  align="left" title="Click to View Tickets & Features which are Entered or Waiting for You" >
            &nbsp;
            <a href="#">My Tickets & Features</a>&nbsp;</td>
     </tr>
     <tr onclick="javascript:RedirectPage(3);" runat="server"  visible="true" id="tr_Three" class="Calendar_Normal">
        <td align="right" style="width: 10px"  >
            <div width="17" runat="server" id="img_Three" height="31" align="right" />
        </td>
        <td colspan="2"  align="left" title="Click to View Recent Tickets">
            &nbsp;
            <a href="#">Recent Tickets</a>&nbsp;</td>
     </tr>
     <tr onclick="javascript:RedirectPage(2);"  runat="server" id="tr_Two" class="Calendar_Normal">
        <td align="center" style="width: 10px"  >
            <div width="17" runat="server" id="img_Two" height="31" align="center" />
        </td>
        <td colspan="2"  align="left" title="Click to View Recent Tickets" >
            &nbsp;<a href="#">Recent Tickets</a>
        </td>
     </tr>
     <tr onclick="javascript:RedirectPage(7);" runat="server" visible="true"  id="tr_Seven" class="Calendar_Normal">
            <td align="center" style="width: 10px"  >
                  <div width="17" runat="server" id="Div4" height="31"  align="center" />
            </td>
            <td colspan="2"  align="left" title="Click to Make New Releases" >
                &nbsp;<a href="#">New Release</a>
           </td>
     </tr>
     <tr onclick="javascript:RedirectPage(1);" runat="server" visible="true"  id="tr_One" class="Calendar_Normal">
            <td align="center" style="width: 10px"  >
                  <div width="17" runat="server" id="img_One" height="31"  align="center" />
            </td>
            <td colspan="2"  align="left" title="Click to View Current Releases" >
                &nbsp;<a href="#">Current Releases</a>
           </td>
     </tr>
      <tr onclick="javascript:RedirectPage(4);"  runat="server" id="tr_four" class="Calendar_Normal">
        <td align="center" style="width: 10px"  >
            <div width="17" runat="server" id="Div1" height="31" align="center" />
        </td>
        <td colspan="2"  align="left" title="Click to View Tickets History which are Completed" >
            &nbsp;<a href="#">Tickets History</a>
        </td>
     </tr>
      <tr onclick="javascript:RedirectPage(6);"  runat="server" id="tr_six" class="Calendar_Normal">
        <td align="center" style="width: 10px"  >
            <div width="17" runat="server" id="Div3" height="31" align="center" />
        </td>
        <td colspan="2"  align="left" title="Click to View Release History which are Released" >
            &nbsp;<a href="#">Releases History</a>
        </td>
     </tr>
</table>
<script type="text/javascript" language="javascript" >

	function RedirectPage(Page) {

		ChangeTrBackGround(Page);
		if (Page == 1) {

			IfPM.location = 'Releases.aspx';
		}
		else if (Page == 2) {

			IfPM.location = 'Tickets.aspx';
		}
		else if (Page == 3) {

			IfPM.location = 'MYTickets.aspx';
		}
		else if (Page == 4) {
			IfPM.location = 'TicketsHistory.aspx';
		}
		else if (Page == 5) {
			IfPM.location = 'TicketsNew.aspx?PrevPage=4';
		}
		else if (Page == 6) {
			IfPM.location = 'ReleasesHistory.aspx';
		}
		else if (Page == 7) {
			IfPM.location = 'ReleasesNew.aspx';
		}
		else {
			IfPM.location = 'Tickets.aspx';
		}
	}


    function ChangeTrBackGround(type) {
    	document.getElementById('<%= tr_One.ClientID %>').className = "Calendar_Normal";
    	document.getElementById('<%= tr1.ClientID %>').className = "Calendar_Normal";
    	document.getElementById('<%= tr_Three.ClientID %>').className = "Calendar_Normal";
    	document.getElementById('<%= tr_four.ClientID %>').className = "Calendar_Normal";
    	document.getElementById('<%= tr_five.ClientID %>').className = "Calendar_Normal";
    	document.getElementById('<%= tr_six.ClientID %>').className = "Calendar_Normal";
    	document.getElementById('<%= tr_seven.ClientID %>').className = "Calendar_Normal";
    	if (type == 1) {
    		document.getElementById('<%= tr_One.ClientID %>').className = "Calendar_Selected";
    	}
    	else if (type == 2) {
    	document.getElementById('<%= tr1.ClientID %>').className = "Calendar_Selected";
    	}
    	else if (type == 3) {
    		document.getElementById('<%= tr_Three.ClientID %>').className = "Calendar_Selected";
    	}
    	else if (type == 4) {
    		document.getElementById('<%= tr_four.ClientID %>').className = "Calendar_Selected";
    	}
    	else if (type == 5) {
    		document.getElementById('<%= tr_five.ClientID %>').className = "Calendar_Selected";
    	}
    	else if (type == 6) {
    		document.getElementById('<%= tr_six.ClientID %>').className = "Calendar_Selected";
    	}
    	else if (type == 7) {
    		document.getElementById('<%= tr_seven.ClientID %>').className = "Calendar_Selected";
    	}
    	else {
    		document.getElementById('<%= tr_Three.ClientID %>').className = "Calendar_Selected";
    	}
    }

</script>