<%@ Control Language="VB" AutoEventWireup="false" CodeFile="LeftPanel_Reports.ascx.vb" Inherits="Reports_LeftPanel_Reports" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<div id="divToolTip" onmouseover="this.style.display='none'"  style="width:300;border:1px solid black;display:none;position:absolute;z-index:50000;color:#676860;font-size:12px; padding:5px; padding-left:5px;background:#F0F0F0;
      filter:
      progid:DXImageTransform.Microsoft.dropshadow(OffX=4, OffY=4, Color='gray', Positive='true')
      progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#FFFFFF,endColorStr=#BEDAFF)
      progid:DXImageTransform.Microsoft.Wheel(duration=3);">
    </div>
<table width="170px" border="0" cellpadding="0" cellspacing="0" style="border:solid 0px #EEEDE5; height:100%;" bgcolor="#DDEEFE">
<tr class="">
    <td  align="center" style="padding:15 10 15 10;">
        <table border="0" cellpadding="1" cellspacing="0" style="width:auto;height:100%;" >
           <tr>
            <td><img src="../images/ico_reports.gif" alt="Reports" /></td>
            <td style="font-size:12px;font-weight:bold;padding-left:5px;">
             Report Management 
            </td>
           </tr>
        </table>
    </td>            
</tr>
<tr id="trMenu" style="display:inline;" runat="server">
    <td>
        <table id="Table1"  runat="server" width="170px" border="0" cellpadding="0" cellspacing="0" style="border:solid 0px #EEEDE5;" bgcolor="#DDEEFE">     
             <tr id="tr1" onclick="javascript:RedirectPage(1);" runat="server" visible="true" class="leftPanel_Selected">
                    <td style="width: 19px; padding-left:5px;" align="absmiddle" >
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">SMSx Version</a>
                        &nbsp;<a href="#"><asp:Label ID="ltrlSMSxVersionCount" runat="server"></asp:Label></a>
                   </td>
             </tr>
         </table>
    </td>
</tr>
<tr style="height:100%;">
    <td>&nbsp;</td>
</tr>
</table>

<script type="text/javascript" language="javascript" >
    function showsmsxcount(count)
     {        
          document.getElementById('<%= ltrlSMSxVersionCount.ClientID %>').innerHTML = ' - '+count ;
     }
     
      function RedirectPage(pageId){           
          ResetBackground();
          switch(pageId){
            case 1:
                iframeMain.location='SMSXLicenseManagement.aspx';
                document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Selected";                                               
                break;   
                
            default:
                
                break;
          }
      }
       
      function ResetBackground(){
           document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Normal";           
      }
      
      //To be called from other pages.
      function SetSelected(pageId){
        ResetBackground();
         switch(pageId){
            case 1:                
                document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Selected";                
                break;
           case 2:
               
               break;
           case 3:
               
               break;
           case 4:
               
               break;   
           case 5:
               
               break;            
           default:
                document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Selected";
                break;
         }
      }     
      
</script>