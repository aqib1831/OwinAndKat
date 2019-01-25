<%@ Control Language="VB" AutoEventWireup="false" CodeFile="LeftPanelMyNet.ascx.vb" Inherits="MyNetsolace_LeftPanelMyNet" %>
<table width="170px" border="0" cellpadding="0" cellspacing="0" style="border:solid 0px #EEEDE5; height:100%;" bgcolor="#DDEEFE">
<tr class="">
    <td  align="center" >
        <table border="0" cellpadding="1" cellspacing="0" style="width:auto;height:100%;" >
           <tr>
            <td ><img src="../images/img_billing_nServices.jpg" style="width: 167px; height: 82px"  /></td>
           <asp:Label ID="hdnClientID"  runat="server" style="display:none;" Text="0" ></asp:Label></tr>
        </table>
    </td>            
</tr>

<tr id="trMenu" style="display:inline;" runat="server">
    <td>
        <table id="Table1"  runat="server" width="170px" border="0" cellpadding="0" cellspacing="0" style="border:solid 0px #EEEDE5;" bgcolor="#DDEEFE">     
             <tr id="tr1" onclick="javascript:RedirectPage2(1);" runat="server" visible="true" class="leftPanel_Normal">
                    <td style="width: 19px; padding-left:5px;" align="absmiddle" >
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">My Services</a>
                        &nbsp;<a href="#"><asp:Label ID="ltrlnXtepCount" runat="server"></asp:Label></a>
                   </td>
             </tr>
             <tr id="tr4" onclick="" runat="server" visible="true" class="leftPanel_Normal">
                    <td style="width: 19px; padding-left:5px;" align="absmiddle" >
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">My Invoices</a>
                        &nbsp;<a href="#"><asp:Label ID="ltrlDMenuCount" runat="server"></asp:Label></a>
                   </td>
             </tr>
         </table>
    </td>
</tr>
<tr id="trSearchDivHead" style="display:none; border-bottom:solid 1px #ffffff;">
    <td >
        <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
        <tr class="searchResults">
            <td style="padding-left:5px;width:97%;">Search Results</td>
            <td style="cursor:pointer;" align="right"><span onclick="ShowSearch('hidden');">X&nbsp;</span></td>
        </tr>
        </table>
    </td>
</tr>

<tr style="height:100%;">
    <td>&nbsp;</td>
</tr>
</table>

<script type="text/javascript" language="javascript" >
   
      function RedirectPage2(pageId){           
          ResetBackground2();
          var hdnClientID = document.getElementById('<%= hdnClientID.ClientID %>').innerText
          switch(pageId){
            case 1:
                iframeMain.location = '../AreaDeveloper/FranchiseSubscription.aspx';
                document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Selected";
                break;
           
            default:
                iframeMain.location = '../AreaDeveloper/FranchiseSubscription.aspx';
                document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Selected";
                break;
          }
      }
       
      function ResetBackground2(){
           document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Normal";
           document.getElementById('<%= tr4.ClientID %>').className="leftPanel_Normal";
      }
      
      //To be called from other pages.
      function SetSelected2(pageId){
        ResetBackground2();
         switch(pageId){
            case 1:
                document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Selected";
                break;
           case 2:
               document.getElementById('<%= tr4.ClientID %>').className="leftPanel_Selected";
               break;        
           default:
                document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Selected";
                break;
         }
      }     
     SetSelected2(1);
      
</script>