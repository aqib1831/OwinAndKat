<%@ Control Language="VB" AutoEventWireup="false" CodeFile="leftPanel.ascx.vb" Inherits="NSBS_leftPanel" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<table width="170px" border="0" cellpadding="0" cellspacing="0" style="border:solid 0px #EEEDE5; height:100%;" bgcolor="#DDEEFE">
<asp:HiddenField ID="hdnTabSelected" runat="server" Value="1"></asp:HiddenField>
<tr class="">
    <td  align="center" style="padding:15 10 15 10;">
        <table border="0" cellpadding="1" cellspacing="0" style="width:auto;height:100%;" >
           <tr>
            <td><img src="../../images/icn_pnl_NSBS.JPG" alt="Nesolace Backup System" /></td>
           </tr>
        </table>
    </td>             
</tr>

<tr id="trMenu" style="display:inline;" runat="server">
    <td>
        <table id="Table1"  runat="server" width="206px" border="0" cellpadding="0" cellspacing="0" style="border:solid 0px #EEEDE5;" bgcolor="#DDEEFE">     
             <tr id="tr1" onclick="javascript:RedirectPage(1);" runat="server" visible="true" class="leftPanel_Selected">
                    <td style="width: 19px; padding-left:5px;" align="absmiddle" >
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">View Status</a>&nbsp;
                   </td>
             </tr>
            <tr id="tr2" onclick="javascript:RedirectPage(2);" runat="server" visible="true"
                class="leftPanel_Normal">
                <td style="width: 19px; padding-left: 5px;" align="absmiddle">
                    <div width="17px" height="31" align="center" />
                </td>
                <td align="left" style="width: 100%; padding-left: 5px;">
                    &nbsp;<a href="#">Documents</a>&nbsp;
                </td>
            </tr>
            <tr style="height: 2px;">
                <td colspan="2">
                    <img src="../../images/bg_lftPnl_horLine.jpg" height="2" width="100%" /></td>
            </tr>
             
        </table>
    </td>
</tr>


<tr style="height:100%;">
    <td>&nbsp;</td>
</tr>
</table>

<script type="text/javascript" language="javascript" >
     
      function RedirectPage(pageId){           
          ResetBackground();
          switch(pageId){
            case 1:
                iframeMain.location='ViewStatus.aspx';
                document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Selected";
                document.getElementById('<%=hdnTabSelected.ClientID %>').value = '1';
                break;
            case 2:
                iframeMain.location='DocumentList.aspx';
                document.getElementById('<%= tr2.ClientID %>').className="leftPanel_Selected";
                document.getElementById('<%=hdnTabSelected.ClientID %>').value = '2';
                break;    
            default:
                document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Selected";
                document.getElementById('<%=hdnTabSelected.ClientID %>').value = '1';
                break;
          }
      }
       
      function ResetBackground(){
           document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Normal";
           document.getElementById('<%= tr2.ClientID %>').className="leftPanel_Normal";
      }
      
      //To be called from other pages.
      function SetSelected(pageId){
        ResetBackground();
         switch(pageId){
            case 1:
                document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Selected";
                break;
           case 2:
               document.getElementById('<%= tr2.ClientID %>').className="leftPanel_Selected";
               break;
           default:
                document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Selected";
                break;
         }
      }     
      
</script>