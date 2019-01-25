<%@ Page Language="VB" MasterPageFile="~/main.master" AutoEventWireup="false" CodeFile="CommMain.aspx.vb" Inherits="Communication_CommMain" title="Netsolace Communication" Theme="Default"  %>
<%@ Register Src="~/communication/leftpanelComm.ascx" TagName="ContactLeftPanel" TagPrefix="ucContactLeftPanel" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ MasterType VirtualPath="~/main.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" Runat="Server" >

<table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%;background-color:#E4F1F7;padding:4px;">
  <tr>              
    <td style="width:230px;height:100%; vertical-align:top;">
      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color:#D8EAFC;height:100%;border:1px solid #609BD3;">
        <tr>
          <td style="height:31px;background-color:#A0CDEE;font-size:15px;font-weight:bold;padding:5px;width:90%;border-bottom:1px solid #609BD3;">
              <span class="DarkBluelabel">Communication</span></td>                 
        </tr>
        <tr id="trTCC" runat="server">
                <td colspan="3" style="height:30px;  vertical-align:top; text-align:center;border-bottom:0px solid #A0CDEE;padding:1px 0px 1px 0px;border-top:1px solid #A0CDEE; background-color:#E4F1F7;" >
                    <asp:Panel runat="server" ID="pnlTCC"  Width="100%" Height="100%" DefaultButton="btnSearch">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#D8EAFC,endColorStr=#A0CDEE);">
                            <tr>
                                <td style="height:20px;font-size:11px;padding-left:5px;">
                                    <span style="font-size:12px;font-weight:bold;" >Search:</span>
                                </td>
                            </tr>
                            <tr>
                                <td style="height:20px;font-size:11px;padding-left:5px;padding-bottom:3px;">
                                    <asp:TextBox runat="server" ID="txtSearch" CssClass="GreyTextBox" MaxLength="50" Width="85%" AutoCompleteType="Disabled" ValidationGroup="searchticket" />
                                    <asp:ImageButton ID="btnSearch"  runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" ValidationGroup="searchticket" />
                                </td>
                            </tr>
                        </table>
                     </asp:Panel>                  
                </td>                    
        </tr>
        <tr id="leftpanel" runat="server">
          <td>
             <ucContactLeftPanel:ContactLeftPanel ID="CalendarLeftPanel1" runat="server" Selected="1" />
          </td>
        </tr>
        <tr >
            <td style="height:100%;">
            <table id="tblHeadSearch" border="0" cellpadding="0" cellspacing="0" style="height:31px; width:100%; font-size:11px;">
                <tr class="Calendar_Normal"  style="height:31px">
                  <td colspan="3" style="cursor:auto; white-space:nowrap;" >&nbsp;Search Results</td>
                  <td style="padding-top:2px;padding-right:6px;cursor:pointer;" valign="middle"  align="right"><img src="../images/btn_close.gif" onclick="HideSearchDiv(); return false;" alt="" /></td>
                </tr>
            </table>

            
             <asp:UpdatePanel ID="UpdatePanel2"
                         runat="server" 
                         UpdateMode="Always"  
                         RenderMode="Inline">
                        <ContentTemplate>
                        <div id="divToolTip" onmouseover="this.style.display='none'"  style="border:1px solid black;display:none;position:absolute;z-index:50000;color:#676860;font-size:11px; padding:5px; padding-left:5px;background:#F0F0F0;
                          filter:
                          progid:DXImageTransform.Microsoft.dropshadow(OffX=4, OffY=4, Color='gray', Positive='true')
                          progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#FFFFFF,endColorStr=#BEDAFF)
                          progid:DXImageTransform.Microsoft.Wheel(duration=3);">
                        </div>
                        <div id="div1" runat="server"  style="overflow-y:auto;Height:90%;Width:100%;border:0px solid #FFFFFF;" class="ScrollBarHomeTicket">
                        <asp:Repeater
                        runat="server"
                        ID="rptStores"
                        DataSourceID="ObjectDataSource1" >
                        <HeaderTemplate>
                            <table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%; font-size:11px;">                                  
                       </HeaderTemplate>
                        <ItemTemplate>
                                <tr style="height:25px;cursor:pointer;" onmousemove="this.className='HighlightedLeftPanelRow';showToolTip(this,'<%#  "Name:" & Server.HtmlEncode(Functions.StringTruncate(Functions.IfNull(Eval("Title"),""),25)) & "<br /> Status:" & iif(Eval("IsPublished"),"Published","Pending")%>');" onmouseout="this.className='';hideToolTip();" onclick="javascript:parent.window.location='WeeklyLetter_Head.aspx?AdminMgmt=1&LetterId=<%#Eval("ID")%>&IsPublished=<%#Eval("IsPublished")%>&backPageURL=EAIWeeklyList';">
					                    <td style="padding-left:5px; width:5px; text-align:left;" ></td>
				  	                    <td style="padding-left:5px; width:5px; text-align:left; white-space:nowrap;">
				  	                    </td>
					                    <td style="padding-left:5px; text-align:left; white-space:nowrap;" align="left" >
					                        <span title='<%#Eval("Title")%>' >
                                                <asp:Label ID="lblTitle" runat="server" Text='<%# Server.HtmlEncode(Functions.StringTruncate(Functions.IfNull(Eval("Title"),""),25))%>' > ></asp:Label>
                                            </span>
					                    </td>
					                    <td style="width:100%;">&nbsp;</td>                                                
		                        </tr>
						        <tr style="height:1px;" >
							        <td height="1" colspan="4" bgcolor="98AECD"><img src="../images/spacer.gif" height="1" width="1"></td>
						        </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                               
                                <tr id="trStores_NoRecord" runat="server" ><td colspan="4" style="font-style:italic;text-align:center;height:20px;">No Weekly Letter to show!</td></tr>
                                <tr><td colspan="4" style="height:1px;text-align:center;"><img  src="../images/pixel_gray.JPG" height="1" width="100%" alt="" /></td></tr>
                                <tr><td colspan="4" style="height:100%;text-align:center;"></td></tr>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>             
                      </div> 
                       </ContentTemplate>
                         <Triggers >
                            <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click"></asp:AsyncPostBackTrigger>                           
                         </Triggers>
                    </asp:UpdatePanel>    
                        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
                            SelectMethod="GetAllWeeklyLetterForComm" TypeName="Portal.BLL.Communication.WeeklyLetter">
                            <SelectParameters>                          
                                <asp:ControlParameter ControlID="txtsearch" DefaultValue="" Name="search" PropertyName="Text" Type="String" />
                                <asp:Parameter Name="IsPublished" Type="Boolean" DefaultValue="" />
                                <asp:Parameter Name="SortExpression" DefaultValue="" />
                                <asp:Parameter Name="MaximumRows" DefaultValue="100" />
                                <asp:Parameter Name="StartRowIndex" DefaultValue="0" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
            </td>
        </tr>
         <tr  style="height:10px;">
          <td>
          </td>
        </tr>
      </table>
    </td> 
    <td align="center" style="padding-left:0; vertical-align:top;">
      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin :0px; background-color:#BADCFC;height:100%;border:1px solid #609BD3;">
        <tr>
          <td style="width:100%; height:100%;">
             <iframe name="IfCommuication" runat="server" id="IfCommuication" src="EAWeeklyLetters.aspx" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
         </td>
       </tr>       
      </table>
    </td>
  </tr>
</table>
<script type="text/javascript" language="javascript" >
    function HideSearchDiv()
        {   
            document.getElementById('<%= txtsearch.ClientID %>').value = '';           
	        document.getElementById('<%= div1.ClientID %>').style.display='none';
	        document.getElementById('tblHeadSearch').style.display='none';
	        document.getElementById('<%= leftpanel.ClientID %>').style.display='inline';
        }
    function HideLeftPanel()
        {     
            document.getElementById('<%= div1.ClientID %>').style.display='inline';
            document.getElementById('tblHeadSearch').style.display='inline';
            document.getElementById('<%= leftpanel.ClientID %>').style.display='none';
            document.getElementById('<%= txtsearch.ClientID %>').focus() ;           
        }
        function showToolTip(obj, msg)
        {
	        var obj = document.getElementById("divToolTip");
	        obj.innerHTML = msg;	       
	        obj.style.left = event.x - 5;
	        obj.style.top = event.y - 50;
	        obj.style.display = 'inline';	        
        }
		
    function hideToolTip()
	    {
	    var obj = document.getElementById("divToolTip");	
	    obj.style.display = "none";
	    }
</script>
</asp:Content>

