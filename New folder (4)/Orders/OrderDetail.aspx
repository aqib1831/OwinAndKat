<%@ Page Language="VB" AutoEventWireup="false" CodeFile="OrderDetail.aspx.vb" Inherits="OrderDetail" Theme="Default" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Invoice</title>
</head>
<body style="margin:0px; background-color: #FFFFFF;overflow:auto; width:100%; height:100%;">
    <form id="form1" runat="server">
        <div>
        <div id="divDisable" class="modalBackground" style="z-index:0;" ></div>
        <div id="DivIFrame" runat="server"  style="display:none;border:solid 1px #000000; position:absolute; width:600px;  height:85%;top:5%; left:17%; z-index:1;"    >
          <table style="height:100%; background-color:#CDE5FD;" cellpadding="0" border="0" cellspacing="0">
           <tr>    
              <td align="left" style="border-bottom:solid 1px #000000; padding-left:1em; background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
                  <label id="lblTitle" title="Notes" style="color:White; font-size:14px; font-weight:bold; overflow:auto;"  ></label>
              </td>
              <td  style="border-bottom:solid 1px #000000;background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%; height:28px; cursor:pointer;">
                  <img src="../images/win_btn_close_black.jpg" style="float:right;" alt="Close Window" onclick="CloseDiv();" />
              </td>               
           </tr>
           <tr valign="top">                
             <td colspan="2" style="height:100%; width:100%;"  align="center">                    
                <iframe id="ifrmStatus" frameborder="0" src="../BlankPage.htm" width="100%" height="100%"></iframe>
             </td>
           </tr>            
          </table>
        </div>        
        <asp:HiddenField ID="hdnOrderID" runat="server" Value="0" />
         <table  style="height:100%; width:100%; " cellspacing="0" border="0"  >
             <tr class="UnderlinedRow" style="height:5%;">
                 <td  style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:5px;width:25%;">
                   Online Order #&nbsp;<asp:Label ID="lblOrderNo" runat="server" Text="" ></asp:Label>
                </td>
                 <td style="width:75%;background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right;">
                    <table style="height:25px; width:100%; border:0px; text-align:right;border-bottom:0px;"  cellspacing="0" cellpadding="0" border="0">
                        <tr>
                            <td style="border-bottom:0px;" id="tdShippingInfo" visible="false" runat="server">
                                <div style="width:160px; cursor:pointer;" class="LeadDetailButton" onclick="ShowShipInfo();">
                                 Shipment Information&nbsp;<img  src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10"  style="border:0px;" />    
                                </div>
                            </td>
                            <td style="border-bottom:0px;" id="tdSetStatus" runat="server">                                                                    
                                    <div style="width:110px; cursor:pointer;" class="LeadDetailButton" onclick="ShowDiv();">
                                     Set Status&nbsp;<img  src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10"  style="border:0px;" />
                                    </div>                                
                            </td>
                            <td style="border-bottom:0px;">
                                
                                 <asp:LinkButton ID="lnkResetFilters" runat="server" CssClass="HomeButton">
                                    <div style="width:110px;" class="LeadDetailButton" onclick="IfOrderDetail.focus(); IfOrderDetail.print(); return false;">
                                        Print
                                    <img  src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10"  style="border:0px;" /></div>
                                  </asp:LinkButton>
                            </td>                            
                        </tr>
                    </table>
                 </td>                        
             </tr>
             <tr>                
                <td colspan="2" align="right" style="font-size:16px;font-family:Arial, Verdana, Sans-Serif, Helvetica; font-weight:bold; color:Red; padding:3px 10px 5px 5px;"><asp:Label ID="lblOrderStatus" runat="server"></asp:Label></td>
             </tr>
             <tr style=" height:95%; width:100%;">
               <td  colspan="2" style="background-color:#FFFFFF;  vertical-align:top; height: 95%; margin:0px;padding:0px;">              
                  <iframe name="IfOrderDetail" runat="server" id="IfOrderDetail" src="../BlankPage.htm" style="margin: 0px;width:100%;height:100%;border:0px" frameborder="0" marginheight="0" marginwidth="0"  scrolling="no"></iframe>
               </td>
             </tr>      
              <tr style="height:20px; background-color:#BADCFC;">
                <td style="width:75%; text-align:left;" id="CustomPagerRow">&nbsp;</td>                    
                <td style="width:25%;">
                    <table cellpadding="0" cellspacing="0" class="GrayHeader">
                            <tr>
                                <td>
                                    <span style="font-size:7pt; color: #ff0000"></span>
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span style="font-size:7pt; color: #ff0000"></span>
                                </td>
                            </tr>
                    </table> 
                </td>
             </tr>
            </table>
        </div>
    </form>
    <script type="text/javascript" language="javascript" >
    window.onload=function start()
    {  
       var hdnOrderID = document.getElementById('<%= hdnOrderID.ClientID %>')
       IfOrderDetail.location='OrderDetailPrint.aspx?OrderID=' + hdnOrderID.value;             
    } 
    
    function ShowDiv()
    {
        var orderID = document.getElementById('<%= hdnOrderID.ClientID %>').value;
        document.getElementById('lblTitle').innerText='Order Status';
        ifrmStatus.location= "ChangeStatus.aspx?OrderID="+orderID;
        DivIFrame.style.display="inline";
        divDisable.style.width = "100%";
        divDisable.style.height = "100%";        
    }
    
    function CloseDiv()
    {
        DivIFrame.style.display = 'none';
        divDisable.style.width = '0';
        divDisable.style.height = '0';
    }
    
    function ShowShipInfo()
    {
        document.getElementById('lblTitle').innerText='Shipment Information';
        var orderID = document.getElementById('<%= hdnOrderID.ClientID %>').value;
        ifrmStatus.location= "ShippingInformation.aspx?OrderID="+orderID;        
        DivIFrame.style.display="inline";
        divDisable.style.width = "100%";
        divDisable.style.height = "100%";
    }
    
    function ReloadPage()
    {
        var id = document.getElementById('<%= hdnOrderID.ClientID %>').value;
        window.location="OrderDetail.aspx?OrderID="+id;
    }
    </script>
</body>
</html>
