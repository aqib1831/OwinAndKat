<%@ Control Language="VB" AutoEventWireup="false" CodeFile="~/communication/leftpanelComm.ascx.vb" Inherits="Communication_leftpanelComm"  %>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:solid 0px #EEEDE5; height:100%;"  bgcolor="#D8EAFC">
    <tr onclick="javascript:RedirectPage(2);" runat="server"  visible="true" id="tr_Two" class="Calendar_Normal">
        <td align="right" style="width: 10px">
            <div width="17" runat="server" id="img_Three" height="31" align="right" />
        </td>
        <td colspan="2" align="left" title="Click to View Tickets & Features which are Entered or Waiting for You" >
            &nbsp;
          <a href="#">Weekly Letter</a>&nbsp;</td>
     </tr>
     <tr onclick="javascript:RedirectPage(1);" runat="server" visible="true"  id="tr_One" class="Calendar_Normal">
        <td align="center" style="width: 10px"  >
              <div width="17" runat="server" id="img_One" height="31"  align="center" />
        </td>
        <td colspan="2"  align="left" title="Click to View Current Releases" >
            &nbsp;<a href="#">Compose</a>
       </td>
     </tr>
</table>
<script type="text/javascript" language="javascript">
   function RedirectPage(Page)   
    {

                ChangeTrBackGround(Page);
                if (Page==1)
                {  
                    IfCommuication.location='WeeklyLetter_Add.aspx?Forum=0';
                }
                else if (Page==2)
                {
                   IfCommuication.location='EAWeeklyLetters.aspx';
                }
    }
   function ChangeTrBackGround(type)
        {
               document.getElementById('<%= tr_One.ClientID %>').className="Calendar_Normal";
               document.getElementById('<%= tr_Two.ClientID %>').className="Calendar_Normal";
                if (type==1)
                {
                document.getElementById('<%= tr_One.ClientID %>').className="Calendar_Selected";              
                }
                else if (type==2)
                {               
                 document.getElementById('<%= tr_Two.ClientID %>').className="Calendar_Selected";          
                }
      }
</script>