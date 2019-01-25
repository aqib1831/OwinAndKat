<%@ Page Language="VB" MasterPageFile="~/main.master" AutoEventWireup="false" CodeFile="OrdersMain.aspx.vb" Inherits="Orders_OrdersMain" title="Netsolace Orders Managment" Theme="Default"  %>
<%@ Register Src="~/Orders/leftpanel_Orders.ascx" TagName="ContactLeftPanel" TagPrefix="ucContactLeftPanel" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ MasterType VirtualPath="~/main.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" Runat="Server" >

<table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%;background-color:#E4F1F7;padding:4px;">
  <tr>              
    <td style="width:230px;height:100%; vertical-align:top;">
      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color:#D8EAFC;height:100%;border:1px solid #609BD3;">
        <tr>
          <td style="height:31px;background-color:#A0CDEE;font-size:15px;font-weight:bold;padding:5px;width:90%;border-bottom:1px solid #609BD3;">
              <span class="DarkBluelabel"> Netsolace Online Orders</span></td>                 
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
                                    <asp:TextBox runat="server" ID="txtSearch" CssClass="GreyTextBox" MaxLength="50" Width="85%" AutoCompleteType="Disabled" ValidationGroup="searchOrder" />
                                    <asp:RequiredFieldValidator ID="rfvSearch" runat="server" ControlToValidate="txtSearch" ErrorMessage="" ValidationGroup="searchOrder"></asp:RequiredFieldValidator>
                                    <asp:ImageButton ID="btnSearch"  runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" ValidationGroup="searchOrder"/>
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
                        <div id="div1" runat="server"  style="overflow-y:auto;Height:90%;Width:100%;border:0px solid #FFFFFF;" class="ScrollBarHomeTicket">
                        <asp:Repeater
                        runat="server"
                        ID="rptOrders"
                        DataSourceID="odsOrdersSearch" >
                        <HeaderTemplate>
                            <table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%; font-size:11px;">                                  
                       </HeaderTemplate>
                        <ItemTemplate>
                                <tr style="height:25px;cursor:pointer;"  onclick="javascript:IfPM.location='OrderDetail.aspx?OrderID=<%#Eval("ID")%>';">					                    
                                        <td style="width:3%; padding:5px;"><img src="../images/arrows.gif"/></td>					                    
					                    <td style="width:27%; padding:5px;"><%#Eval("ID")%></td>					                    
					                    <td style="width:70%;" align="right" style="padding-right:10px; color:Red;">(<%#Eval("OrderStatus")%>)</td>                                                
		                        </tr>
						        <tr style="height:1px;" >
							        <td height="1" colspan="4" bgcolor="98AECD"><img src="../images/spacer.gif" height="1" width="1"></td>
						        </tr>
                        </ItemTemplate>
                        <FooterTemplate>                               
                                <tr id="trStores_NoRecord" runat="server" ><td colspan="4" style="font-style:italic;text-align:center;height:20px;">No Ticket to show!</td></tr>
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
                        <asp:ObjectDataSource ID="odsOrdersSearch" runat="server" 
                            SelectMethod="SCM_SearchOrders" TypeName="Portal.BLL.Orders.SCM_Orders">
                            <SelectParameters>                          
                                <asp:ControlParameter ControlID="txtSearch" Name="Search" PropertyName="Text" Type="String" DefaultValue="" />
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
          <td style="width:100%; height:100%;"> <!--comments by saqib Second column -->
             <iframe name="IfPM" runat="server" id="IfPM" src="Orders.aspx" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
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
</script>
</asp:Content>

