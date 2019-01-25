<%@ Control Language="VB" AutoEventWireup="false" CodeFile="leftPanelLM.ascx.vb" Inherits="LM_leftPanelLM" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<table width="170px" border="0" cellpadding="0" cellspacing="0" style="border:solid 0px #EEEDE5; height:100%;" bgcolor="#DDEEFE">
<tr class="">
    <td  align="center" style="padding:15 10 15 10;">
        <table border="0" cellpadding="1" cellspacing="0" style="width:auto;height:100%;" >
           <tr>
            <td><img src="../images/icn_lice_mgt.gif" alt="License Management" /></td>
            <td style="font-size:12px;font-weight:bold;padding-left:5px;">
             License Management 
             <asp:Label ID="hdnClientID"  runat="server" style="display:none;" Text="0" ></asp:Label>
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
             <tr id="tr1" onclick="javascript:RedirectPage2(1);" runat="server" visible="true" class="leftPanel_Normal">
                    <td style="width: 19px; padding-left:5px;" align="absmiddle" >
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">nXstep Licenses</a>
                        &nbsp;<a href="#"><asp:Label ID="ltrlnXtepCount" runat="server"></asp:Label></a>
                   </td>
             </tr>
             <tr id="tr4" onclick="javascript:RedirectPage2(4);" runat="server" visible="true" class="leftPanel_Normal">
                    <td style="width: 19px; padding-left:5px;" align="absmiddle" >
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">DMenu Licenses</a>
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
                    <td title='<%# Eval("RegKey") %>'><%#Functions.StringTruncate(Eval("RegKey"), 20)%></td>
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
     {  document.getElementById('<%= ltrlnXtepCount.ClientID %>').innerHTML = ' - '+count+'' }
     function showDMenuCount(count)
     {  document.getElementById('<%= ltrlDMenuCount.ClientID %>').innerHTML = ' - '+count+'' }
      //RedirectPage2(1);
      function RedirectPage2(pageId){           
          ResetBackground2();
          var hdnClientID = document.getElementById('<%= hdnClientID.ClientID %>').innerText
          switch(pageId){
            case 1:
                iframeMain.location='../LM/LicenseManagement.aspx?PrevPage=MyNetsolace&ddlClient='+hdnClientID;
                document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Selected";
                break;
            case 4:
                iframeMain.location='../LM/DMenuLicenseManagement.aspx?PrevPage=MyNetsolace&ddlClient='+hdnClientID;
                document.getElementById('<%= tr4.ClientID %>').className="leftPanel_Selected";
                break; 
            default:
                iframeMain.location='../LM/LicenseManagement.aspx?PrevPage=MyNetsolace&ddlClient='+hdnClientID;
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
           case 4:
               document.getElementById('<%= tr4.ClientID %>').className="leftPanel_Selected";
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
           iframeMain.location='../LM/LicenseDetail.aspx?LicenseID='+licenseId+'&PrevPage=MyNetsolace';
       }
      
</script>