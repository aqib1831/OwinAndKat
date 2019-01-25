<%@ Control Language="VB" AutoEventWireup="false" CodeFile="leftPanelLM.ascx.vb" Inherits="LM_leftPanelLM" %>
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
            <td><img src="../images/icn_lice_mgt.gif" alt="License Management" /></td>
            <td style="font-size:12px;font-weight:bold;padding-left:5px;">
             License Management 
            </td>
           </tr>
        </table>
    </td>            
</tr>
<tr class="">     
    <td align="center" style="padding-bottom:15px;">
    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="imgBtnSearch">
        <table cellpadding="0" cellspacing="0" border="0" style="width:165px; background-color:#ffffff;">
            <tr>
                <td style="width:25px;border-top:solid 2px #82ABC7;border-bottom:solid 2px #82ABC7;border-left:solid 2px #82ABC7;" align="center"><img src="../images/icn_search.jpg" /></td>
                <td style="border-top:solid 2px #82ABC7;border-bottom:solid 2px #82ABC7;border-right:solid 2px #82ABC7;"><asp:TextBox ID="txtSearch" runat="server" ValidationGroup="vgSearch" onfocus="javascript:this.value='';" onkeyup="if(CheckNoisyWord()==false) return false;" MaxLength="50" style="height:100%; border:0; width:110px;"></asp:TextBox></td>
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
                        &nbsp;<a href="#">nXstep Licenses</a>
                        &nbsp;<a href="#"><asp:Label ID="ltrlnXtepCount" runat="server"></asp:Label></a>
                   </td>
             </tr>
             <tr id="tr4" onclick="javascript:RedirectPage(4);" runat="server" visible="true" class="leftPanel_Normal">
                    <td style="width: 19px; padding-left:5px;" align="absmiddle" >
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">DMenu Licenses</a>
                        &nbsp;<a href="#"><asp:Label ID="ltrlDMenuCount" runat="server"></asp:Label></a>
                   </td>
             </tr>
             <tr id="tr2" onclick="javascript:RedirectPage(2);" runat="server" visible="true" class="leftPanel_Normal">
                    <td style="width: 19px; padding-left:5px;" align="absmiddle">
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">SMS Licenses <asp:Label ID="ltrlSMSCount" runat="server"></asp:Label></a>
                   </td>
             </tr>
             <tr id="tr3" onclick="javascript:RedirectPage(3);" runat="server" visible="true" class="leftPanel_Normal">
                    <td style="width: 19px; padding-left:5px;" align="absmiddle">
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">Qs Licenses <asp:Label ID="ltrlQsCount" runat="server"></asp:Label></a>
                   </td>
             </tr>
             <tr id="tr5" onclick="javascript:RedirectPage(5);" runat="server" visible="true" class="leftPanel_Normal">
                    <td style="width: 19px; padding-left:5px;" align="absmiddle" >
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">SMSx Licenses</a>
                        <a href="#"><asp:Label ID="ltrlSMSXCount" runat="server"></asp:Label></a>
                   </td>
             </tr>
             <tr id="tr6" onclick="javascript:RedirectPage(6);" runat="server" visible="true" class="leftPanel_Normal">
                 <td style="width: 19px; padding-left:5px;" align="absmiddle" >
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">DF Licenses</a>
                        <a href="#"><asp:Label ID="lblDFLicensesCount" runat="server"></asp:Label></a>
                   </td>
             </tr>
             <tr id="tr8" onclick="javascript:RedirectPage(8);" runat="server" visible="true" class="leftPanel_Normal">
                    <td style="width: 19px; padding-left:5px;" align="absmiddle" >
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">DC Licenses</a>
                        <a href="#"><asp:Label ID="lblDigitalCatalogCount" runat="server" Text="- 0"></asp:Label></a>
                   </td>
             </tr>
             <tr id="tr9" onclick="javascript:RedirectPage(9);" runat="server" visible="true" class="leftPanel_Normal">
                    <td style="width: 19px; padding-left:5px;" align="absmiddle" >
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                              &nbsp;<a href="#">SMSx Live Update
                        <a href="#"><asp:Label ID="lblUpdateCount" runat="server" Text="- 0"></asp:Label></a>
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
        <asp:UpdatePanel ID="upLicenseSearch" runat="server" UpdateMode="Always" > 
        <ContentTemplate>        
        <asp:Literal ID="ltrlNoRecord" runat="server" Visible="false" Text="<table style='height:100%; width:100%;'><tr><td style='height:100%; font-size:12px;' valign='middle' align='center'>No Records Found!</td></tr></table>"></asp:Literal>
        <asp:HiddenField ID="lblTabSelected" runat="server" Value="1"></asp:HiddenField>
        <asp:Repeater ID="rptSearchLicenses" runat="server" DataSourceID="sdsLicences">
            <HeaderTemplate>                
                <table cellpadding="0" cellspacing="0" border="0" style="width:100%; border-top:0;" class="gvwSilver">                
            </HeaderTemplate>
            <ItemTemplate>
                 <tr class="blueBorder" onclick="ShowDetail('<%# Eval("ID") %>','<%# Eval("Type") %>');" onmouseout="hideToolTip();" onmousemove="showToolTip('<%# "Store #: <b>" & Eval("StoreNumber") & "</b><br /><b>" & Eval("StoreNick") & "</b><br />Key: " & Eval("RegKey") & "<br /><b>" & GetLicenceType(Eval("Type"))& "</b>"%>')">
                    <td>
                       <%#Functions.StringTruncate(Eval("RegKey"), 21)%>
                    </td>
                 </tr>
            </ItemTemplate>
            <FooterTemplate>                
                </table>                
            </FooterTemplate>
        </asp:Repeater>
        <asp:SqlDataSource ID="sdsLicences" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
            SelectCommand="Licenses_Search" SelectCommandType="StoredProcedure" DataSourceMode="DataReader"  >
           <SelectParameters>
             <asp:ControlParameter ControlID="txtSearch" Name="search" DefaultValue="" PropertyName="Text" />
           </SelectParameters>
         </asp:SqlDataSource>
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
     {  document.getElementById('<%= ltrlnXtepCount.ClientID %>').innerHTML = ' - '+count+'' }
     function showDMenuCount(count)
     {  document.getElementById('<%= ltrlDMenuCount.ClientID %>').innerHTML = ' - '+count+'' }
          function showsmscount(count)
     {  document.getElementById('<%= ltrlSMSCount.ClientID %>').innerHTML = ' - '+count+'' } 
     function showQScount(count)
     {  document.getElementById('<%= ltrlQsCount.ClientID %>').innerHTML = ' - '+count+'' }
     function showsmsxcount(count)
     {  document.getElementById('<%= ltrlSMSXCount.ClientID %>').innerHTML = ' - '+count+'' }
     function ShowDfLicenseCount(count)
     {document.getElementById('<%= lblDFLicensesCount.ClientID %>').innerHTML = ' - '+count+''}
	function showcountdigitalCatalog(count) {
         document.getElementById('<%= lblDigitalCatalogCount.ClientID %>').innerHTML = ' - ' + count + ''
     }
     function showUpdateCount(count) {
         document.getElementById('<%= lblUpdateCount.ClientID %>').innerHTML = ' - ' + count + ''
     }
      function RedirectPage(pageId){           
          ResetBackground();
          switch(pageId){
            case 1:
                iframeMain.location='LicenseManagement.aspx';
                document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Selected";
                document.getElementById('<%=lblTabSelected.ClientID %>').value = '1';
                break;
            case 2:
                iframeMain.location='SMSLicenseManagement.aspx';
                document.getElementById('<%= tr2.ClientID %>').className="leftPanel_Selected";
                document.getElementById('<%=lblTabSelected.ClientID %>').value = '2';
                break;    
            case 3:
                iframeMain.location='QsLicenseManagement.aspx';
                document.getElementById('<%= tr3.ClientID %>').className="leftPanel_Selected";
                document.getElementById('<%=lblTabSelected.ClientID %>').value = '3';
                break; 
            case 4:
                iframeMain.location='DMenuLicenseManagement.aspx';
                document.getElementById('<%= tr4.ClientID %>').className="leftPanel_Selected";
                document.getElementById('<%=lblTabSelected.ClientID %>').value = '4';
                break;
             case 5:
                iframeMain.location='SMSXLicenseManagement.aspx';
                document.getElementById('<%= tr5.ClientID %>').className="leftPanel_Selected";
                document.getElementById('<%=lblTabSelected.ClientID %>').value = '5';
                break;     
            case 6:
                iframeMain.location='DFLicenseManagement.aspx';
                document.getElementById('<%= tr6.ClientID %>').className="leftPanel_Selected";
                document.getElementById('<%=lblTabSelected.ClientID %>').value = '6';
                break;     
			case 8:
                iframeMain.location = 'LicenseManagementDC.aspx';
                document.getElementById('<%= tr8.ClientID %>').className = "leftPanel_Selected";
                document.getElementById('<%=lblTabSelected.ClientID %>').value = '8';
                break;
            case 9:
                iframeMain.location = 'UpdateManagement.aspx';
                document.getElementById('<%= tr9.ClientID %>').className = "leftPanel_Selected";
                document.getElementById('<%=lblTabSelected.ClientID %>').value = '9';
                break;
            default:
                document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Selected";
                document.getElementById('<%=lblTabSelected.ClientID %>').value = '1';
                break;
          }
      }
       
      function ResetBackground(){
           document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Normal";
           document.getElementById('<%= tr2.ClientID %>').className="leftPanel_Normal";
           document.getElementById('<%= tr3.ClientID %>').className="leftPanel_Normal";
           document.getElementById('<%= tr4.ClientID %>').className="leftPanel_Normal";
           document.getElementById('<%= tr5.ClientID %>').className="leftPanel_Normal";
           document.getElementById('<%= tr6.ClientID %>').className="leftPanel_Normal";
			document.getElementById('<%= tr8.ClientID %>').className = "leftPanel_Normal";
           document.getElementById('<%= tr9.ClientID %>').className = "leftPanel_Normal";
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
           case 4:
               document.getElementById('<%= tr4.ClientID %>').className="leftPanel_Selected";
               break;   
           case 5:
               document.getElementById('<%= tr5.ClientID %>').className="leftPanel_Selected";
               break;            
           case 6:
               document.getElementById('<%= tr6.ClientID %>').className="leftPanel_Selected"; 
               break;                 
			case 8:
               document.getElementById('<%= tr8.ClientID %>').className = "leftPanel_Selected";
               break;
           case 9:
               document.getElementById('<%= tr9.ClientID %>').className = "leftPanel_Selected";
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
      
       function ShowDetail(licenseId,Type){
           if (Type == 'nxstep')
           {
            iframeMain.location='LicenseDetail.aspx?LicenseID='+licenseId;
           }
           else if (Type == 'dmenu')
           {
           iframeMain.location='DMenuLicenseDetail.aspx?LicenseID='+licenseId+'&ddlClient=0&ddlStates=0&ddlFilters=0'
           }
           else if (Type =='smsx')
           {               
                iframeMain.location='SmsxLicenseDetails.aspx?LicenseID='+licenseId+'&ddlClient=0&ddlStates=0&ddlFilters=0'
           }
           else if (Type =='Qs')
           {               
                iframeMain.location='QsLicenseDetail.aspx?LicenseID='+licenseId+'&ddlClient=0&ddlStates=0&ddlFilters=0'
           }
           else if (Type=='DF')
           {
                iframeMain.location='DFLicenseDetails.aspx?LicenseID='+licenseId+'&ddlClient=0&ddlStates=0&ddlFilters=0'
           }
//           else if (Selectedtab == '3')
//           {
//           iframeMain.location='QSLicenseDetail.aspx?ID='+licenseId+'&ddlClient=0&ddlStores=0&ddlFilters=1'
//           }
//           else if (Selectedtab == '4')
//           {
//           iframeMain.location=' SMSLicenseDetail.aspx?ID='+licenseId+'&ddlClient=0&ddlStores=0&ddlFilters=0'
//           }
       }
    function showToolTip(msg)
    {  
        var obj = document.getElementById("divToolTip");
        obj.innerHTML = msg;
        obj.style.left = event.x - 20;
        obj.style.top = event.y - 50;
        obj.style.display = 'inline';
    }
    function hideToolTip()
    {
        var obj = document.getElementById("divToolTip");
        obj.style.display = "none";
    }
    function CheckNoisyWord() {
        var mybool = true;
        var InputStr = document.getElementById('<%=txtsearch.ClientID%>').value;
        if (CheckSpecailCharPage(InputStr) == true) {
        alert("Special characters are not Allowed.\nPlease remove them and try again.");
        document.getElementById('<%= txtSearch.ClientID %>').value = '';
        mybool = false;
        return false;
        }
        if (mybool == false)
        return false;
        else
        return true;
    }

function CheckSpecailCharPage(val) {
	
    var iChars = "!@#$%^&*()+=_[]\\\';,./{}|\":<>?";
    for (var i = 0; i < val.length; i++) {
        if (iChars.indexOf(val.charAt(i)) != -1) {
            return true;
        }
    }
}

</script>