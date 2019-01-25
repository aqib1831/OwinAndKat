<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LicenseDetail.aspx.vb" Inherits="LM_LicenseDetail" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>nXstep License Detail</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
</head>
<body style="margin:0; padding:0; height:100%;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager" runat="server"></asp:ScriptManager>
    <div>
    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color:#F2F2F2;height:100%;" class="tblDetail" >
    <tr style="height:30px; background-image:url(../images/bg_mainHdr_1.jpg);">
        <th colspan="3" align="left" class="IdeaTitle">nXstep License Detail</th>
        <th colspan="2" align="right" style="padding:0px;">        
            <div id="divltrlActive" runat="server" style=" width:150px; height:27px;" align="center">
                <table>
                <tr>
                    <td valign="middle" style="border-bottom:0;">
                    <b><asp:Label ID="ltrlActive" runat="server" style="color:White;" ></asp:Label>&nbsp;</b>
                    </td>
                </tr>
                </table>
            </div>
        </th>
    </tr> 
    <tr>
        <td style="width:15%;">Store #:</td>
        <td style="width:33%;">
           <b><asp:Literal ID="ltrlStoreNo" runat="server"></asp:Literal>&nbsp;</b></td>
        <td style="width:4%;">&nbsp;</td>
        <td style="width:15%;">Client:</td>
        <td style="width:33%;padding:0;padding-right:10px;">
             <table cellpadding="0" cellspacing="0" border="0" class="tblDetail" style="width:100%;padding:0px;" >
                <tr>
                    <td style="border-bottom:0"><b><asp:Literal ID="ltrlClientName" runat="server"></asp:Literal>&nbsp;</b></td>
                    <td style="border-bottom:0;padding:0;" align="right">
                            <asp:Button ID="btnClearSession" runat="server" Visible="false"  style="cursor:pointer;" Text="Clear System ID" Width="100" CssClass="btnSilver" />  
                    </td>
                    <td style="border-bottom:0;padding:0;" align="right">
                        <asp:Button ID="btnEdit" runat="server" style="cursor:pointer;" Text="Edit" CssClass="btnSilver" /></td>
                </tr>
             </table>
        </td>
   </tr>
   <tr>
        <td >Store Nick:</td>
        <td ><b><asp:Literal ID="ltrlStoreNick" runat="server"></asp:Literal>&nbsp;</b></td>
        <td>&nbsp;</td>        
        <td>Static IP:</td>
        <td><b><asp:Literal ID="ltrlStaticIP" runat="server"></asp:Literal>&nbsp;</b></td>
    </tr>
    <tr>
        <td >MAC Address:</td>
        <td ><b><asp:Literal ID="ltrlMACAddress" runat="server"></asp:Literal></b></td>
        <td>&nbsp;</td>        
        <td>Computer Name;</td>
        <td><b><asp:Literal ID="ltrlComputerName" runat="server"></asp:Literal></b></td>
    </tr>
    <tr>        
        <td>CurrentVersion:</td>
        <td><b><asp:Literal ID="ltrlCurrentVersion" runat="server"></asp:Literal>&nbsp;</b></td>
        <td>&nbsp;</td>
        <td id="tdsystemIP" runat="server" >System IP:</td>
        <td><b><asp:Literal ID="ltrlSystemIP" runat="server"></asp:Literal></b>&nbsp;</td>
    </tr>
    <tr>
        <td>Training Active:</td>
        <td><b><asp:Literal ID="ltrlTrainingActive" runat="server"></asp:Literal>&nbsp;</b></td>
        <td>&nbsp;</td>
        <td>Current IP:</td>
        <td><b><asp:Literal ID="ltrlCurrentIP" runat="server"></asp:Literal>&nbsp;</b></td>        
    </tr>
     <tr>
        <td>Invoice #:</td>
        <td ><b><asp:Literal ID="ltrlInvoiceNo" runat="server"></asp:Literal>&nbsp;</b></td>
        <td>&nbsp;</td>
        <td>App to Connect:</td>
        <td><b><asp:Literal ID="ltrlAppToconnect" runat="server"></asp:Literal>&nbsp;</b></td> 
    </tr>
    <tr>
        <td>Registration Key:</td>
        <td ><b><asp:Literal ID="ltrlRegkey" runat="server"></asp:Literal>&nbsp;</b></td>
        <td>&nbsp;</td>
        <td>Inactivate SMS:</td>
        <td><b><asp:Literal ID="ltrlInactiveSMS" runat="server"></asp:Literal>&nbsp;</b></td> 
    </tr>
    <tr>        
        <td>Last Time Sync:</td>
        <td colspan="4">
             <b><asp:Label ID="ltrlLastTimeSync" runat="server"></asp:Label>&nbsp;</b></td>
    </tr>
    <tr>    
        <td>Issued By:</td>
        <td> <b><asp:Literal ID="ltrlIssuedBy" runat="server"></asp:Literal>&nbsp;</b></td>            
        <td>&nbsp;</td>
        <td>Updated By:</td>
        <td><b><asp:Literal ID="ltrlUpdatedBy" runat="server"></asp:Literal>&nbsp;</b></td>
    </tr>    
      <tr>    
        <td>Issued On:</td>
        <td><b><asp:Label ID="ltrlIssuedOn" runat="server"></asp:Label>&nbsp;</b></td>
        <td>&nbsp;</td>
        <td>Updated On:</td>
        <td><b><asp:Label ID="ltrlUpdateOn" runat="server"></asp:Label>&nbsp;</b></td>
    </tr>  
    <tr>
        <td style="border-bottom:0;" valign="top" colspan="5">Notes :</td>        
    </tr>
    <tr style="height:100%;">
        <td style="border-bottom:0;" valign="top" colspan="5">
            <asp:Literal ID="ltrlNotes" runat="server"></asp:Literal>
        </td>        
    </tr>
    <tr style="height:30px; background-color:#dcdcdc;">
        <td colspan="6" style="border-top:solid 1px #609BD3; padding-right:10px;" align="right">
            <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btnSilver" />
        </td>
    </tr>
    </table>
    </div>
    </form>
</body>
</html>