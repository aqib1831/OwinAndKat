<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SupportInvoiceDetail.aspx.vb" Inherits="Support_SupportInvoiceDetail" Theme="Default" EnableViewState="true" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Support Invoices</title>
    <script language="javascript" type="text/javascript" src="../scripts/functions.js"></script>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
</head>
<body style="border:0px; margin:0px; padding:0px;">
    <form id="form1" runat="server">
    <asp:HiddenField ID="hdnSupportInvoiceID" runat="server" Value="0" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdateProgress ID="uProgIdeaNotes" runat="server">
        <ProgressTemplate>        
        <div class="ProgressIndicatorDivGray">                            
            <br />
            <img src="../images/indicator.gif" align="absmiddle" /><b>&nbsp;&nbsp;Loading ...</b>
            <br /><br />
        </div>
     </ProgressTemplate>
    </asp:UpdateProgress>
    <div id="divConfirmed" style="background-color:#fff; border:solid 1px #000; display:none; position:absolute; color:#fff; height:150px; width:400px; left:25%; top:35%;">
       <table cellpadding="0" cellspacing="0" border="0" style="width:100%; height:150px;" class="MessageUsers">
           <tr>
                <th colspan="2" style="height:15px;">Confirm</th>
           </tr>
           <tr style="height:100%;">
                <td align="left" style="font-size:12px; width:10px;  padding: 15 5 5 5; vertical-align:top;"> 
                    <img align="absmiddle" src="../images/icn_info.gif" />
                </td>
                <td align="left" style="text-align:left; vertical-align:top; padding: 10 5 5 5; height:100%; width:100%;">
                        <span ID="ltrlReason" runat="server"></span> 
                </td>
           </tr>       
           <tr style="padding-bottom:8px;">
                <td colspan="2" align="center"><input type="button" class="btnSimple" style="width:60px;" value="Ok" onclick="HideConfirm();"/> </td>
           </tr>
        </table>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="conditional" RenderMode="Inline">
        <ContentTemplate>
    <div id="divNotConfirmed" style="background-color:#fff; border:solid 1px #000; display:none; position:absolute; color:#fff; height:150px; width:400px; left:25%; top:35%;">
       <table cellpadding="0" cellspacing="0" border="0" style="width:100%; height:150px;font-size:12px;" class="MessageUsers">
           <tr>
                <th colspan="2" style="height:15px;">Mark As Paid</th>
           </tr>
           <tr>
            <td style="padding-left:20%;">Payment Mode:</td>
            <td style="width:70%;">
                    <asp:DropDownList ID="ddlPaymentMethod" runat="server" CssClass="SmallGreenTextBox" Width="150px"
                    DataSourceID="SDS_ddlPaymentMethod" DataTextField="Name" DataValueField="ID">   
                    </asp:DropDownList>
                   <asp:SqlDataSource ID="SDS_ddlPaymentMethod" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                        SelectCommand="NS_PaymentMethod_GetAllForList" SelectCommandType="StoredProcedure" DataSourceMode="DataReader"  >
                     </asp:SqlDataSource> 
                     <asp:CompareValidator
                           ID="RFV_DueDate" runat="server" ControlToValidate="ddlPaymentMethod" Display="Dynamic" ValueToCompare="0" Operator="GreaterThan"   
                           ErrorMessage="<br/>Please Select Payment Method" SkinID="CompareValidation" ValidationGroup="abcd" >
                     </asp:CompareValidator> 
                </td>
           </tr> 
           <tr>
            <td style="padding-left:20%;">Quick Book Ref #:</td>
            <td style="width:70%;">
                   <asp:TextBox ID="txtQBNumber" runat="server" 
                       MaxLength="10" 
                       ValidationGroup="abcd" 
                       Width="150px">
                   </asp:TextBox>
                  <asp:RequiredFieldValidator
                       ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtQBNumber" Display="Dynamic"
                       ErrorMessage="<br />Please Enter Quick Book Ref #." SkinID="RequiredFieldValidation" ValidationGroup="abcd" >
                  </asp:RequiredFieldValidator>
                  <asp:RangeValidator
                       ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtQBNumber" Display="Dynamic"
                       ErrorMessage="<br />Please Enter Valid Quick Book Ref #." Font-Bold="false" Font-Size="10px"  ValidationGroup="abcd" Type="integer" MinimumValue="0" MaximumValue="999999999">
                  </asp:RangeValidator>
             </td>
           </tr>      
           <tr style="padding-bottom:8px;">
                <td colspan="2" align="center"><asp:Button ID="btnSave" runat="server" text="Save" ValidationGroup="abcd"   class="btnSimple" style="width:70px;" />
                <asp:Button ID="btnCancle" runat="server" text="Cancel"  class="btnSimple" CausesValidation="false" OnClientClick="HideNotConfirm(); return false;"   style="width:70px;" />
                </td>
           </tr>
        </table>
    </div>
    </ContentTemplate> 
        <Triggers>  
            <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel> 
    <div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="height:100%;">
      <tr class="GalleryTitle" style="background-image:url('../images/bg_mainHdr_1.jpg');height:31px;">
        <td>&nbsp;<span class="IdeaTitle">Support Invoices Detail</span></td>
        <td  style="padding-right:5px;" align="right">
            <asp:Button ID="btnSetPaid" runat="server" Text="Set Status" CssClass="btnSilver" Width="100px" />&nbsp;
            <asp:Button ID="btnPrint" runat="server" Text="Print" CssClass="btnSilver" Width="100px" OnClientClick="ifrmStatus.focus(); ifrmStatus.print(); return false;"  />&nbsp;
            <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btnSilver" Width="100px" PostBackUrl="~/Support/SupportInvoice.aspx" CausesValidation="false" />
        </td>
      </tr>
      <tr  style="height:31px;">
        <td valign="middle" colspan="2">
    	    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="height:100%;" class="gvwSearchSilver">
        	   <tr>
    	          <td style="padding-left:5px;"></td>
                  <td></td>
                  <td style="width:60%;">&nbsp;</td>
                  <td align="right" style="font-size:16px;padding-right:20px;">
                      <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="conditional" RenderMode="Inline">
                        <ContentTemplate>
                            Status: <asp:Label ID="lblStatus" runat="server" Font-Bold="true" ></asp:Label>
                        </ContentTemplate> 
                        <Triggers>  
                            <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel> 
                  </td>
               </tr>
            </table>           
        </td>
      </tr>
      <tr style="height:100%;">
        <td valign="top" colspan="2">
        <div id="divScroll" style="height:100%; width:100%; overflow-y:auto;" class="GrayScrollBar">    
             <iframe id="ifrmStatus" name="ifrmStatus" runat="server" frameborder="0" src="../BlankPage.htm" width="100%" height="100%"></iframe> 
        </div>
        </td>
      </tr>
    </table>
    </div>
    <script language="javascript" type="text/javascript">
    function ShowConfirm(str)
    {
        HideNotConfirm();
        getElement('divConfirmed').style.display='inline';
        getElement('<%=ltrlReason.ClientID%>').innerHTML=str;
    } 
    function HideConfirm()
    {
        getElement('divConfirmed').style.display='none';
    }
    function ShowNotConfirm(id)
    {
        HideConfirm();
        getElement('divNotConfirmed').style.display='inline';
        getElement('txtQBNumber').value='';
        getElement('ddlPaymentMethod').value=0;
    } 
    function HideNotConfirm()
    {
        getElement('divNotConfirmed').style.display='none';
    } 
    </script>
    </form>
</body>
</html>
