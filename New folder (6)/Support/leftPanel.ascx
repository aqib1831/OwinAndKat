<%@ Control Language="VB" AutoEventWireup="false" CodeFile="leftPanel.ascx.vb" Inherits="Support_leftPanel" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<table width="170px" border="0" cellpadding="0" cellspacing="0" style="border:solid 0px #EEEDE5; height:100%;" bgcolor="#DDEEFE">
<tr class="">
   <td  align="center" style="padding:15 10 15 10;">
        <table border="0" cellpadding="1" cellspacing="0" style="width:auto;height:100%;" >
           <tr>
            <td><img src="../images/ico_biling-supt.gif" alt="Support Billing" /></td>
            <td style="font-size:12px;font-weight:bold;padding-left:3px;">
                Support Billing
            </td>
           </tr>
        </table>
    </td>            
</tr>
<tr style="display:none;">     
    <td align="center" style="padding-bottom:15px;">
    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="imgBtnSearch">
        <table cellpadding="0" cellspacing="0" border="0" style="width:165px; background-color:#ffffff;">
            <tr>
                <td style="width:25px;border-top:solid 2px #82ABC7;border-bottom:solid 2px #82ABC7;border-left:solid 2px #82ABC7;" align="center"><img src="../images/icn_search.jpg" /></td>
                <td style="border-top:solid 2px #82ABC7;border-bottom:solid 2px #82ABC7;border-right:solid 2px #82ABC7;"><asp:TextBox ID="txtSearch" runat="server" ValidationGroup="vgSearch" MaxLength="20" style="height:100%; border:0; width:110px;"></asp:TextBox></td>
                <td><asp:ImageButton ID="imgBtnSearch" ValidationGroup="vgSearch" runat="server" ImageUrl="../images/btn_goTxtBox.jpg" OnClientClick="ShowSearch('visible');" /></td>
                <cc1:TextBoxWatermarkExtender ID="wmtxtSearch" runat="server" TargetControlID="txtSearch" WatermarkText="Search " WatermarkCssClass="watermarked">
                </cc1:TextBoxWatermarkExtender>
                <asp:RequiredFieldValidator ID="rfvSearch" runat="server" ControlToValidate="txtSearch" ValidationGroup="vgSearch"></asp:RequiredFieldValidator>                                    
            </tr>
        </table>
    </asp:Panel>
    </td>            
</tr>
<tr id="trMenu" style="display:inline;" runat="server">
    <td>
        <table id="Table1"  runat="server" width="170px" border="0" cellpadding="0" cellspacing="0" style="border:solid 0px #EEEDE5;" bgcolor="#DDEEFE">     
             <tr id="tr1" onclick="javascript:RedirectPage(1);" runat="server" visible="true" class="leftPanel_Normal">
                    <td style="width: 19px; padding-left:5px;" align="absmiddle" >
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">Support</a>
                        &nbsp;<a href="#"><span id="spncount"></span></a>
                   </td>
             </tr>
             <tr id="tr2" onclick="javascript:RedirectPage(2);" runat="server" visible="true" class="leftPanel_Normal" style="display:none;" >
                    <td style="width: 19px; padding-left:5px;" align="absmiddle" >
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">Not On Support</a>
                        &nbsp;<a href="#"><span id="spnnosupportcount"></span></a>
                   </td>
             </tr>
             <tr id="tr3" onclick="javascript:RedirectPage(3);" runat="server" visible="true" class="leftPanel_Normal" style="display:none;">
                    <td style="width: 19px; padding-left:5px;" align="absmiddle" >
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">Franchisee Billing</a>
                        &nbsp;<a href="#"><span id="Span1"></span></a>
                   </td>
             </tr>
             <tr id="tr5" onclick="javascript:RedirectPage(5);" runat="server" visible="true" class="leftPanel_Normal" >
                    <td style="width: 19px; padding-left:5px;" align="absmiddle" >
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">Billing Report</a>
                        &nbsp;<a href="#"><span id="Span2"></span></a>
                   </td>
             </tr>
             <tr id="tr6" onclick="javascript:RedirectPage(6);" runat="server" visible="true" class="leftPanel_Normal" >
                    <td style="width: 19px; padding-left:5px;" align="absmiddle" >
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">Process Billing</a>
                        &nbsp;<a href="#"><span id="Span3"></span></a>
                   </td>
             </tr>
             <tr id="tr7" onclick="javascript:RedirectPage(7);" runat="server" visible="true" class="leftPanel_Normal" >
                    <td style="width: 19px; padding-left:5px;" align="absmiddle" >
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">Bank Batch</a>
                        &nbsp;<a href="#"><span id="Span4"></span></a>
                   </td>
             </tr>
              <tr id="tr8" onclick="javascript:RedirectPage(8);" runat="server" visible="true" class="leftPanel_Normal" >
                    <td style="width: 19px; padding-left:5px;" align="absmiddle" >
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">Support Invoices</a>
                        &nbsp;<a href="#"><span id="Span5"></span></a>
                   </td>
             </tr>
             <tr id="tr4" class="leftPanel_Normal">
              <td colspan="2">
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
<tr id="trSearch" runat="server" style="display:none; height:100%; padding-top:1px;" >    
    <td style="height:100%;">                
        <div id="divSearch" runat="server" style="display:inline; width:100%; height:100%; border:solid 1px #609BD3; border-top:0px; overflow-y:auto;" class="ScrollBarHomeTicket">                
        <asp:UpdatePanel ID="upLicenseSearch" runat="server"> 
        <ContentTemplate>        
        <asp:Literal ID="ltrlNoRecord" runat="server" Visible="false" Text="<table style='height:100%; width:100%;'><tr><td style='height:100%; font-size:12px;' valign='middle' align='center'>No Records Found!</td></tr></table>"></asp:Literal>
        <asp:Repeater ID="rptSearchLicenses" runat="server">
            <HeaderTemplate>                
                <table cellpadding="0" cellspacing="0" border="0" style="width:100%; border-top:0;" class="gvwSilver">                
            </HeaderTemplate>
            <ItemTemplate>
                 <tr class="blueBorder" onclick="ShowDetail('<%# Eval("ID") %>');">                    
                    <td title='<%# Eval("RegKey") %>'><%#Functions.StringTruncate(Eval("RegKey"), 23)%></td>
                 </tr>
            </ItemTemplate>
            <FooterTemplate>                
                </table>                
            </FooterTemplate>
        </asp:Repeater>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="imgBtnSearch" EventName="Click" />
        </Triggers>
        </asp:UpdatePanel>
        <asp:UpdateProgress ID="uProgIdeaNotes" runat="server" DisplayAfter="1" AssociatedUpdatePanelID="upLicenseSearch">
            <ProgressTemplate>
            <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
              <tr>
                <td valign="middle">
                    <div class="ProgressIndicatorDivGray">                            
                    <br />
                    <img src="../../images/indicator.gif" align="absmiddle" /><b>&nbsp;&nbsp;Loading ...</b>
                    <br /><br />                                
                    </div>    
                </td>
              </tr>
            </table>
            </ProgressTemplate>
        </asp:UpdateProgress>
        </div>       
    </td>
</tr>
<tr style="height:100%;">
    <td>&nbsp;</td>
</tr>
</table>

<script type="text/javascript" language="javascript" >
     function showcount(count)
     {  spncount.innerHTML = ' - '+count+'' } 
     function showNosupportcount(count)
     {  spnnosupportcount.innerHTML = ' - '+count+'' }
      function RedirectPage(pageId){           
          ResetBackground();
          switch(pageId){
            case 1:
                iframeMain.location='NsProducts.aspx';
                document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Selected";
                break;
            case 2:
                iframeMain.location='NSNotOnSupport.aspx';
                document.getElementById('<%= tr2.ClientID %>').className="leftPanel_Selected";
                break;
             case 3:
                iframeMain.location='support_billing_report_header.asp';
                document.getElementById('<%= tr3.ClientID %>').className="leftPanel_Selected";
                break;
            case 5:
                iframeMain.location='SupportClient.aspx';
                document.getElementById('<%= tr5.ClientID %>').className="leftPanel_Selected";
                break;   
            case 6:
                iframeMain.location='SupportProcess.aspx';
                document.getElementById('<%= tr6.ClientID %>').className="leftPanel_Selected";
                break;          
            case 7:
                iframeMain.location='SupportBankBatch.aspx';
                document.getElementById('<%= tr7.ClientID %>').className="leftPanel_Selected";
                break; 
             case 8:
                iframeMain.location='SupportInvoice.aspx';
                document.getElementById('<%= tr8.ClientID %>').className="leftPanel_Selected";
                break;        
            default:
                document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Selected";
                break;
          }
      }
       
      function ResetBackground(){
           document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Normal";
           document.getElementById('<%= tr2.ClientID %>').className="leftPanel_Normal";
           document.getElementById('<%= tr3.ClientID %>').className="leftPanel_Normal";
           document.getElementById('<%= tr5.ClientID %>').className="leftPanel_Normal";
           document.getElementById('<%= tr6.ClientID %>').className="leftPanel_Normal";
           document.getElementById('<%= tr7.ClientID %>').className="leftPanel_Normal";
           document.getElementById('<%= tr8.ClientID %>').className="leftPanel_Normal";
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
           case 3:
                document.getElementById('<%= tr3.ClientID %>').className="leftPanel_Selected";
                break;     
          case 5:
                document.getElementById('<%= tr5.ClientID %>').className="leftPanel_Selected";
                break;
          case 6:
                document.getElementById('<%= tr6.ClientID %>').className="leftPanel_Selected";
                break;
          case 7:
                document.getElementById('<%= tr7.ClientID %>').className="leftPanel_Selected";
                break; 
          case 8:
                document.getElementById('<%= tr8.ClientID %>').className="leftPanel_Selected";
                break;       
           default:
                document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Selected";
                break;
         }
      }     
      function ShowSearch(visibility){        
        if(visibility == "hidden"){
          trSearchDivHead.style.display = "none";
          document.getElementById('<%= trSearch.ClientID %>').style.display = "none";
          document.getElementById('<%= trMenu.ClientID %>').style.display = "inline";
          document.getElementById('<%= txtSearch.ClientID %>').value='';
        }
        else{
          if(document.getElementById('<%= txtSearch.ClientID %>').value != '')
          {
              trSearchDivHead.style.display = "inline";
              document.getElementById('<%= trSearch.ClientID %>').style.display = "inline";
              document.getElementById('<%= trMenu.ClientID %>').style.display = "none";
          }
        }        
      }
      function ShowDetail(licenseId){
          iframeMain.location='LicenseDetail.aspx?LicenseID='+licenseId;
      }
      
</script>