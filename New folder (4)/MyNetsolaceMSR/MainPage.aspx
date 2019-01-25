<%@ Page Language="VB"  AutoEventWireup="false" MasterPageFile="~/MyNetsolace/MyNetsolace.master" CodeFile="MainPage.aspx.vb" Inherits="MyNetsolace_MainPage" title="Netsolace Portal - My Netsolace" %>
<%@ Register Src="leftPanelLM.ascx" TagName="leftPanelLM" TagPrefix="LM" %>
<%@ Register Src="~/MyNetsolace/LeftPanelMyNet.ascx" TagName="leftPanelMyNet" TagPrefix="MyNet" %>
<%@ MasterType VirtualPath="~/MyNetsolace/MyNetsolace.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="contentMyNetsolace" Runat="Server">
<asp:HiddenField ID="hdnClientId" runat="server" />
<asp:HiddenField ID="hdnFranchiseId" runat="server" Value="0" />
<asp:HiddenField ID="hdnAreaDeveloperID" runat="server" Value="0" />
<table border="0" cellpadding="0" cellspacing="0"  width="100%" style="height:100%;background-color:#E4F1F7;padding:4px;">
  <tr>              
    <td id="lftforhelpDesk" runat="server" style="width:230px;height:100%; vertical-align:top;">
      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color:#D8EAFC;height:100%;border:1px solid #609BD3;">
        <tr>
          <td style="height:31px;background-color:#A0CDEE;font-size:15px;font-weight:bold;padding:5px;width:90%;border-bottom:1px solid #609BD3;">
              <span class="DarkBluelabel"> Help Desk </span></td>                 
        </tr>         
        <tr>
          <td valign="top">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:solid 0px #EEEDE5;"  bgcolor="#D8EAFC">
              <tr onclick="javascript:RedirectPage(1);"  visible="true" id="tr_One" runat="server" class="Calendar_Selected">
                <td align="right" style="width: 10px"  >
                    <div width="17" runat="server" id="Div2" height="31" align="right" />
                </td>
                <td colspan="2"  align="left" title="Click to Make New Ticket" >
                    &nbsp;
                    <a href="#" onclick="javascript:RedirectPage(1);">Inbox&nbsp;<label id="lblCount" title="Inbox"  >( 0 )</label></a>&nbsp;</td>
              </tr>
              <tr onclick="javascript:RedirectPage(2);"  id="tr_Two" runat="server" class="Calendar_Normal">
                <td align="right" style="width: 10px"  >
                    <div width="17" runat="server" id="Div1" height="31" align="right" />
                </td>
                <td colspan="2"  align="left" title="Click to Make New Ticket" >
                    &nbsp;
                    <a href="#" onclick="javascript:RedirectPage(2);">History&nbsp;<label id="Label1" title="History"  ></label></a>&nbsp;</td>
              </tr>
              <tr onclick="javascript:RedirectPage(3);"  id="tr_Three" runat="server" class="Calendar_Normal">
                <td align="right" style="width: 10px"  >
                    <div width="17" runat="server" id="Div3" height="31" align="right" />
                </td>
                <td colspan="2"  align="left" title="Click to Make New Ticket" >
                    &nbsp;
                    <a href="#" onclick="javascript:RedirectPage(3);">Submit New Ticket&nbsp;<label id="Label2" title="History"  ></label></a>&nbsp;</td>
              </tr>
            </table>            
          </td>
        </tr>
      </table>
    </td>
    <td id="lftforLicence" runat="server" style="width:170px;height:100%; vertical-align:top;" visible="false">
        <LM:leftPanelLM id="LeftPanelLM1" runat="server"></LM:leftPanelLM>
    </td>  
    <td id="lftforBilling" runat="server" style="width:170px;height:100%; vertical-align:top;" visible="false">
        <MyNet:leftPanelMyNet ID="LeftPanelMyNet2" runat="server" />
    </td>  
    <td align="center" style="padding-left:0; vertical-align:top;">
      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin :0px; background-color:#BADCFC;height:100%; border:solid 1px #609BD3;">
        <tr>
          <td style="width:100%; height:100%;"> <!--comments by saqib Second column -->
             <iframe name="iframeMain" runat="server"  title="Netsolace Portal - My Netsolace" id="iframeMain" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
         </td>
       </tr>       
      </table>
    </td>
  </tr>
</table>

<script language="javascript" type="text/javascript">
function RedirectPage(id)
{
  var clientId = document.getElementById('<%= hdnClientId.ClientID %>').value;
  var franchiseId = document.getElementById('<%= hdnFranchiseId.ClientID %>').value;
  var areaDeveloperId = document.getElementById('<%= hdnAreaDeveloperID.ClientID %>').value;

  switch(id)
  {  
      case 1:
        {      
            ChangeBackGround();  
            document.getElementById('<%= tr_One.ClientID %>').className='Calendar_Selected';            
            if(areaDeveloperId !=0){            
                iframeMain.location='AreaDeveloperInbox.aspx?ClientID='+ clientId;
            break;
            }
            if(franchiseId !=0){
                iframeMain.location='FranchiseeInbox.aspx?ClientID='+ clientId +'&FranchiseID=' + franchiseId;        
            }
            else{
                iframeMain.location='FranchisorInbox.aspx?ClientID='+ clientId;         
            }
        }
        break;
      case 2 :
        {
            ChangeBackGround();
            document.getElementById('<%= tr_Two.ClientID %>').className='Calendar_Selected';
            if(areaDeveloperId !=0){            
                iframeMain.location='AreaDeveloperHistory.aspx?ClientID='+ clientId;
            break;
            }
            if(franchiseId !=0){
                iframeMain.location='FranchiseeHistory.aspx?ClientID='+ clientId +'&FranchiseID=' + franchiseId;
                break;
            }
            else{
            iframeMain.location='FranchisorHistory.aspx?ClientID='+ clientId;         
            }
        } 
        break;    
      case 3: 
        {
            ChangeBackGround();
            document.getElementById('<%= tr_Three.ClientID %>').className='Calendar_Selected';
            if(areaDeveloperId !=0){            
                iframeMain.location='AddActivity.aspx?New=1&PrevPage=6&ClientID='+ clientId;
            break;
            }
            if(franchiseId !=0){
                iframeMain.location='AddActivity.aspx?PrevPage=2&ClientID='+ clientId + '&FranchiseID='+franchiseId;
                break;
            }
            else{
                iframeMain.location='AddActivity.aspx?New=1&PrevPage=3&ClientID='+ clientId;
            }
                   
        }
        break;
      
  } 
}

function ChangeBackGround()
{    
    document.getElementById('<%= tr_Two.ClientID %>').className='Calendar_Normal';    
    document.getElementById('<%= tr_One.ClientID %>').className='Calendar_Normal';    
    document.getElementById('<%= tr_Three.ClientID %>').className='Calendar_Normal'; 
    
}
function SetTrBackGround(trId)
{
    ChangeBackGround();
    switch(trId)
    {
        case 1:                
           document.getElementById('<%= tr_One.ClientID %>').className='Calendar_Selected';
           break;               
        case 2:
            document.getElementById('<%= tr_Two.ClientID %>').className='Calendar_Selected';                           
            break;
        case 3:
            document.getElementById('<%= tr_Three.ClientID %>').className='Calendar_Selected';                           
            break;
        default:
            document.getElementById('<%= tr_One.ClientID %>').className='Calendar_Selected';   
          
    }
}

 function SetInBox(value)    
    {   lblCount.innerHTML = '( ' + value + ' )';}
 function SetDefault()
    {   lblCount.innerHTML = '( 0 )';}
</script>
</asp:Content>

