<%@ Page Language="VB"  AutoEventWireup="false" MasterPageFile="~/MyNetsolaceClient/MyNetsolace.master" CodeFile="MainPage.aspx.vb" Inherits="MyNetsolace_MainPage" title="Netsolace Portal - My Netsolace" Theme="Default" %>
<%@ Register Src="Controls/leftPanelLM.ascx" TagName="leftPanelLM" TagPrefix="LM" %>
<%@ MasterType VirtualPath="~/MyNetsolaceClient/MyNetsolace.master" %>
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
             <tr>
          <td colspan="3" style="background-color:#A0CDEE;font-size:15px;font-weight:bold;padding:5px;border-bottom:1px solid #609BD3;" >             
				<asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
                <span class="SimpleSmall">
				Search Franchisee:<br /></span>
				     <asp:TextBox runat="server" ID="txtSearch" Width="89%" CssClass="GreyTextBox" MaxLength="50" onfocus="javascript:this.value='';" /><span style="width:1px;"></span>
                     <asp:ImageButton ID="btnSearch" runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" /><br />                
                           <asp:DropDownList runat="server" ID="ddlStates" 
                            Width="100%"
                            SkinID="SmallTextCombo"
                            DataSourceID="sdsStates"
                            DataTextField="Name"
                            DataValueField="StateID"
                            AutoPostBack="True">
                           </asp:DropDownList> 
                           <asp:SqlDataSource ID="sdsStates" runat="server"
                                    ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                    SelectCommand="Franchises_GetAllStatesByClientId"
                                    SelectCommandType="StoredProcedure"
                                    DataSourceMode="DataReader">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="ClientId" SessionField="MyNetsolace_ClientID" />
                                    </SelectParameters>
                           </asp:SqlDataSource>		         
            </asp:Panel> 
          </td>                 
        </tr>
              <tr onclick="javascript:RedirectPage(1);"  visible="true" id="tr_One" runat="server" class="Calendar_Selected">
                <td align="right" style="width: 10px"  >
                    <div width="17" runat="server" id="Div2" height="31" align="right" />
                </td>
                <td colspan="2"  align="left" title="Inbox" >
                    &nbsp;
                    <a href="#" onclick="javascript:RedirectPage(1);">Inbox&nbsp;<label id="lblCount" title="Inbox"  >( 0 )</label></a>&nbsp;</td>
              </tr>
              <tr onclick="javascript:RedirectPage(2);"  id="tr_Two" runat="server" class="Calendar_Normal">
                <td align="right" style="width: 10px"  >
                    <div width="17" runat="server" id="Div1" height="31" align="right" />
                </td>
                <td colspan="2"  align="left" title="History" >
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
        <tr style="width:100%;">
      <td style="height:100%;" colspan="3">   
      <div id="div4" style="Height:100%;Width:100%;border:0px solid #FFFFFF;" class="ScrollBarHomeTicket">   
        <asp:UpdatePanel runat="server" ID="UPCurrentActivities" ChildrenAsTriggers="false"  UpdateMode="Conditional" RenderMode="block"  >
         <ContentTemplate>           
          <div id="divStores" runat="server" style="display:none;" >
           <div id="divToolTip" style="background:'#D8EAFC';border:1px solid black;display:none;position:absolute;width:300px;z-Index:1000;font-size:12px; padding:2px; padding-left:3px;"></div>            
             <asp:Repeater  runat="server" ID="rptStores" DataSourceID="sdsStores" EnableViewState="false">
                <HeaderTemplate>
					<table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%; font-size:11px;">
                        <tr class="Calendar_Normal"  style="height:31px">
                              <td colspan="2" style="cursor:default;Width:80%;" >&nbsp;Search Results</td>
                              <td style="padding-top:2px;padding-right:5px;"align="right"><img src="../images/btn_close.gif" onclick="HideEmployeeSearchDiv(); return false;" alt="" /></td>
                        </tr>
                        <tr>
                  <td colspan="3" style="height:100%;"  >
                      <div id="div1" style="overflow-y:auto;Height:100%;Width:100%;" class="ScrollBarHomeTicket">
                         <table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%; font-size:11px;">                                
                </HeaderTemplate>
                <ItemTemplate>
                            <tr style="height:25px;cursor:pointer;" onmousemove="this.className='HighlightedLeftPanelRow';showToolTip(this,'<%# "<b>" & Eval("StoreName") & " - " & Eval("StoreNumber") & "</b> [ " & Eval("ClientName") & " ]" & "<br/><b>Status:</b> " & Functions.GetStoreStatus(Eval("Status")) & "<br/><b>Phone:</b> " & Eval("Phone") & "<br/><b>Corporate Name:</b> " & Replace(Eval("CorporateName"), "'", "\'")%>');" onmouseout="this.className='';hideToolTip();" onclick="javascript:RedirectToFranchiseInbox('<%#Eval("ID")%>', '<%#Eval("ClientID")%>');">
                                    <td style="padding-left:2px; width:8px;" ><img src="../images/arrows.gif" width="8" height="8" /></td>
                                    <td colspan="2" style="padding-left:2px;width:90%;"><%#Functions.StringTruncate(Eval("StoreName"), 28) & " - " & Eval("StoreNumber")%></td>                            
                            </tr>
	                        <tr style="height:1px;" >
		                        <td height="1" colspan="3" bgcolor="98AECD"><img src="../images/spacer.gif" height="1" width="1"></td>
	                        </tr>
                </ItemTemplate>
                <FooterTemplate>                            
                                <tr id="trStores_NoRecord" style="height:25px;text-align:center;" runat="server" ><td colspan="3" style="font-style:italic;text-align:center;height:20px;">No Store to show!</td></tr>
                                <tr><td colspan="3" style="height:100%;text-align:center;"><img  src="../images/pixel_gray.JPG" height="1" width="100%" alt="" /></td></tr>
                                </table>
                             </div>
                         </td>
                    </tr>
                </table>
                </FooterTemplate>
              </asp:Repeater>
             <asp:ObjectDataSource ID="sdsStores" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="SearchStores" TypeName="Portal.BLL.Activities">
                 <SelectParameters>
                   <asp:ControlParameter ControlID="hdnClientID" Name="ClientID" Type="Int32" />                   
                   <asp:ControlParameter Name="StateID" Type="Int32" ControlID="ddlStates" PropertyName="SelectedValue" />
                   <asp:ControlParameter Name="Search" Type="String" ControlID="txtSearch" PropertyName="Text" ConvertEmptyStringToNull="false" />
                  </SelectParameters>
             </asp:ObjectDataSource>
           </div>
          </ContentTemplate>
          <Triggers>
           <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
           <asp:AsyncPostBackTrigger ControlID="ddlStates" EventName="SelectedIndexChanged" />
           </Triggers>
        </asp:UpdatePanel>
    </div>
        </td>
    </tr>
      </table>
    </td>
    <td id="lftforLicence" runat="server" style="width:170px;height:100%; vertical-align:top;" visible="false">
        <LM:leftPanelLM id="LeftPanelLM1" runat="server"></LM:leftPanelLM>
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
    function RedirectPage(id) {
        var clientId = document.getElementById('<%= hdnClientId.ClientID %>').value;
        switch (id) {
            case 1:
                {
                    ChangeBackGround();
                    document.getElementById('<%= tr_One.ClientID %>').className = 'Calendar_Selected';
                    iframeMain.location = 'FranchisorInbox.aspx?ClientID=' + clientId;
                }
                break;
            case 2:
                {
                    ChangeBackGround();
                    document.getElementById('<%= tr_Two.ClientID %>').className = 'Calendar_Selected';
                    iframeMain.location = 'FranchisorHistory.aspx?ClientID=' + clientId;
                }
                break;
            case 3:
                {
                    ChangeBackGround();
                    document.getElementById('<%= tr_Three.ClientID %>').className = 'Calendar_Selected';
                    iframeMain.location = 'AddActivity.aspx?New=1&PrevPage=3&ClientID=' + clientId;
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
 { lblCount.innerHTML = '( 0 )'; }

 var postbackElement;
 Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(beginRequest);
 Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(pageLoaded);

 function beginRequest(sender, args) {
     postbackElement = args.get_postBackElement();
 }

 function pageLoaded(sender, args) {
     if (document.getElementById('ctl00$contentMyNetsolace$LeftPanelLM1$txtSearch') == null) {
         if (document.getElementById('<%= txtsearch.ClientID %>').value != '' || document.getElementById('<%= ddlStates.ClientID %>').value != 0) {
             document.getElementById('<%= tr_One.ClientID %>').style.display = 'none';
             document.getElementById('<%= tr_Two.ClientID %>').style.display = 'none';
             document.getElementById('<%= tr_Three.ClientID %>').style.display = 'none';
         }
         else {
             document.getElementById('<%= tr_One.ClientID %>').style.display = 'inline';
             document.getElementById('<%= tr_Two.ClientID %>').style.display = 'inline';
             document.getElementById('<%= tr_Three.ClientID %>').style.display = 'inline';
         }
     }
 }

 function showToolTip(obj, msg) {
     var obj = document.getElementById("divToolTip");
     obj.innerHTML = msg;
     obj.style.left = event.x - 5;
     obj.style.top = event.y + 20;
     obj.style.display = 'inline';
 }

 function hideToolTip() {
     var obj = document.getElementById("divToolTip");
     obj.style.display = "none";
 }

 function RedirectToFranchiseInbox(FranchiseID, ClientID) {
     document.getElementById('<%= hdnFranchiseID.ClientID %>').value = FranchiseID
     iframeMain.location = 'Franchisor_StoreInbox.aspx?FranchiseID=' + FranchiseID + '&ClientID=' + ClientID;
 }
 function HideEmployeeSearchDiv() {
     document.getElementById('<%= txtsearch.ClientID %>').value = '';
     document.getElementById('<%= ddlStates.ClientID %>').value = 0;
     document.getElementById('<%= divStores.ClientID %>').style.display = 'none';
     document.getElementById('<%= tr_One.ClientID %>').style.display = 'inline';
     document.getElementById('<%= tr_Two.ClientID %>').style.display = 'inline';
     document.getElementById('<%= tr_Three.ClientID %>').style.display = 'inline';
 }

</script>
</asp:Content>

