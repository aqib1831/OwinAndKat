<%@ Control Language="VB" AutoEventWireup="false" CodeFile="LeftPanelMyClientContact.ascx.vb" Inherits="MyNetsolace_LeftPanelMyClientContact" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<table width="170px" border="0" cellpadding="0" cellspacing="0" style="border:solid 0px #EEEDE5; height:100%;" bgcolor="#DDEEFE">

<tr>     
    <td align="center" style="padding-bottom:15px;"  >
    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="imgBtnSearch" style="margin:0;padding:0px; border:solid 0px #82ABC7; width:160px;" ScrollBars="None">
        <table cellpadding="0" cellspacing="0" border="0" style="width:100%; background-color:#ffffff;" >
            <tr>
                <td style="width:25px;border-top:solid 2px #82ABC7;border-bottom:solid 2px #82ABC7;border-left:solid 2px #82ABC7;" align="center">&nbsp;<img src="../images/icn_search.jpg" /></td>
                <td style="border-top:solid 2px #82ABC7;border-bottom:solid 2px #82ABC7;border-right:solid 2px #82ABC7;"><asp:TextBox ID="txtSearch" onchange="ShowSearch('visible');" runat="server" AutoPostBack="true" MaxLength="20" style="width:110px;height:100%; border:0;"  ></asp:TextBox></td>                 
                <td><asp:ImageButton ID="imgBtnSearch" ValidationGroup="vgSearch" runat="server" ImageUrl="../images/btn_goTxtBox.jpg" OnClientClick="ShowSearch('visible');"  /></td>
                <cc1:TextBoxWatermarkExtender ID="wtxtSearch" runat="server" TargetControlID="txtSearch" WatermarkText="Search ..." WatermarkCssClass="txtWaterMark" EnableViewState="false"></cc1:TextBoxWatermarkExtender>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtSearch" ValidationGroup="vgSearch"></asp:RequiredFieldValidator>                                    
                
            </tr>
            
        </table>
    </asp:Panel>
    </td>            
</tr>
<tr id="trMenu" >
    <td>
        <table id="Table1"  runat="server" width="170px" border="0" cellpadding="0" cellspacing="0" style="border:solid 0px #EEEDE5;" bgcolor="#DDEEFE">     
             <tr id="tr1" onclick="javascript:RedirectPage2(1);" runat="server" visible="true" class="leftPanel_Selected">
                    <td style="width: 19px; padding-left:5px;" align="absmiddle" >
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">Users</a>
                        &nbsp;<a href="#"><asp:Label ID="ltrlnXtepCount" runat="server"></asp:Label></a>
                   </td>
             </tr>
             <tr id="tr2" onclick="javascript:RedirectPage2(2);" runat="server" visible="true" class="leftPanel_Normal">
                    
             </tr>
         </table>
    </td>
</tr>
<tr id="trSearchDivHead" style="border-bottom:solid 1px #ffffff; display:none;">
    <td style="width: 170px;" >
        <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
        <tr class="searchResults">
            <td style="padding-left:5px;width:97%;">Search Results</td>
            <td style="cursor:pointer;" align="right"><span onclick="ShowSearch(false);">X&nbsp;</span></td>
        </tr>
        </table>
    </td>
</tr>

 <tr id="trSearch"  style="height:100%; padding-top:1px; display:none;">        
    <td style="height:100%;" colspan="3">
        <div id="divSearch" style="width:100%; height:100%; border-top:solid 1px #609BD3; border-top:0px; overflow-y:auto;" class="ScrollBarHomeTicket">
        <asp:UpdatePanel ID="upLicenseSearch" runat="server" > 
        <ContentTemplate>        
        <asp:Literal ID="ltrlNoRecord" runat="server" Visible="false" Text="<table style='height:100%; width:100%;'><tr><td style='height:100%; font-size:12px;' valign='middle' align='center'>No Records Found!</td></tr></table>"></asp:Literal>
        <asp:Repeater ID="rptSearchUsers" runat="server" DataSourceID="sdsUserSearch" >
            <HeaderTemplate>                
                <table cellpadding="0" cellspacing="0" border="0" style="width:100%; border-top:0;" class="gvwSilver">                
            </HeaderTemplate>
            <ItemTemplate>
                 <tr class="blueBorder" onclick="ShowDetail('<%# Eval("ID") %>');">                    
                    <td title='<%# Eval("Name") %>'><%#Functions.StringTruncate(Eval("Name"), 20)%></td>
                 </tr>
            </ItemTemplate>
            <FooterTemplate>                
                </table>                
            </FooterTemplate>
        </asp:Repeater>
        </ContentTemplate>        
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="txtSearch" EventName="TextChanged" />
            <asp:AsyncPostBackTrigger ControlID="imgBtnSearch" EventName="Click" />
        </Triggers>
        </asp:UpdatePanel>        
        </div>       
        <asp:SqlDataSource ID="sdsUserSearch" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                DataSourceMode="DataReader" SelectCommand="ClientContact_GetAll_ForSearch" SelectCommandType="StoredProcedure">
        <SelectParameters>            
            <asp:ControlParameter ControlID="txtSearch" Name="Search"  PropertyName="Text" ConvertEmptyStringToNull="true" />
        </SelectParameters>
        </asp:SqlDataSource>
       
    </td>
</tr>

<tr style="height:100%;">
    <td>&nbsp;<asp:Label ID="hdnClientID"  runat="server" style="display:none;" Text="0" ></asp:Label></td>
</tr>
</table>

<script type="text/javascript" language="javascript" >
   
      function RedirectPage2(pageId){           
          ResetBackground2();
          var hdnClientID = document.getElementById('<%= hdnClientID.ClientID %>').innerText
          switch(pageId){
            case 1:
                iframeMain.location = '../MyNetsolaceClient/ClientContactUser.aspx';
                document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Selected";
                break;
            case 2:
                iframeMain.location = '../MyNetsolaceClient/ClientContactNewUser.aspx';
                document.getElementById('<%= tr2.ClientID %>').className="leftPanel_Selected";
                break; 
            default:
                iframeMain.location = '../MyNetsolaceClient/ClientContactUser.aspx?PrevPage=MyNetsolace&ddlClient=' + hdnClientID;
                document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Selected";
                break;
          }
      }
       
      function ResetBackground2(){
           document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Normal";
           document.getElementById('<%= tr2.ClientID %>').className="leftPanel_Normal";
      }
      
      //To be called from other pages.
      function SetSelected2(pageId){
        ResetBackground2();
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
     function ShowSearch(isVisible)
    {
        
        if(isVisible){
            trMenu.style.display="none";
            trSearch.style.display="inline";
            trSearchDivHead.style.display="inline";                       
        }
        else{
            trMenu.style.display="inline";
            trSearch.style.display="none";
            trSearchDivHead.style.display="none";            
        }
    }
     function ShowDetail(userid){
            iframeMain.location = 'ClientContactNewUser.aspx?UserID='+userid;
       }
      
</script>