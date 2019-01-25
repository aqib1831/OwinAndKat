<%@ Page Language="VB" MasterPageFile="~/MyNetsolaceClient/MyNetsolace.master" AutoEventWireup="false" CodeFile="PMMain.aspx.vb" Inherits="PM_PMMain" title="Netsolace Portal-Project Managment" Theme="Default"  %>
<%@ Register Src="~/MynetsolaceClient/PM/leftpanel_PM.ascx" TagName="ContactLeftPanel" TagPrefix="ucContactLeftPanel" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ MasterType VirtualPath="~/MynetsolaceClient/MyNetsolace.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="contentMyNetsolace" Runat="Server" >
<script language="javascript" type="text/javascript" src="../../scripts/functions.js" ></script>
<script src="../../scripts/jquery.js" type="text/javascript"></script>
<style type="text/css">
	.SearchTbl {height:100%;width:100%; font-size:11px;text-align:left;}
	.SearchTbl tr {height:25px;cursor:pointer;}
	.SearchTbl tr td {padding-left:5px;white-space:nowrap;font-size:11px;border-bottom:solid 1px #98AECD;}
</style>
<table border="0" cellpadding="3" cellspacing="0" width="100%" style="height:100%;background-color:#E4F1F7;padding:4px;" id="tblLeftPanel">
  <tr>              
    <td style="width:230px;height:100%; vertical-align:top;">
      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color:#D8EAFC;height:100%;border:1px solid #609BD3;">
        <tr>
          <td style="height:31px;background-color:#A0CDEE;font-size:15px;font-weight:bold;padding:5px;width:90%;border-bottom:1px solid #609BD3;">
              <span class="DarkBluelabel"> Project Management</span></td>
        </tr>
        <tr id="trTCC" runat="server">
                <td colspan="3" style="height:30px;  vertical-align:top; text-align:center;border-bottom:0px solid #A0CDEE;padding:1px 0px 1px 0px;border-top:1px solid #A0CDEE; background-color:#E4F1F7;" >
                    <asp:Panel runat="server" ID="pnlTCC"  Width="100%" DefaultButton="btnSearch" Height="40px">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#D8EAFC,endColorStr=#A0CDEE);background: -webkit-gradient(linear, center top, center bottom, from(#D8EAFC), to(#A0CDEE));background: -moz-linear-gradient(#D8EAFC, #A0CDEE);">
                            <tr>
                                <td style="height:20px;font-size:11px;padding-left:5px;">
                                    <span style="font-size:12px;font-weight:bold;" >Search Ticket & Feature:</span>
                                </td>
                            </tr>
                            <tr>
                                <td style="height:20px;font-size:11px;padding-left:5px;padding-bottom:3px;">
                                    <asp:TextBox runat="server" ID="txtSearch" CssClass="GreyTextBox" MaxLength="50" Width="85%" onkeyup="if(CheckNoisyWord()==false) return false;" AutoCompleteType="Disabled" ValidationGroup="searchticket" />
                                    <asp:ImageButton ID="btnSearch"  runat="server" OnClientClick="if(CheckNoisyWord()==false) return false;" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" ValidationGroup="searchticket" />
                                </td>
                            </tr>
                        </table>
                     </asp:Panel>
                </td>
        </tr>
        <tr id="leftpanel" runat="server">
          <td>
             <ucContactLeftPanel:ContactLeftPanel ID="CalendarLeftPanel1" runat="server" Selected="2" />
          </td>
        </tr>
        <tr >
            <td style="height:100%;vertical-align:top;">
            <table id="tblHeadSearch" border="0" cellpadding="0" cellspacing="0" style="height:31px; width:100%; font-size:11px;">
                <tr class="Calendar_Normal"  style="height:31px;">
                  <td colspan="3" style="cursor:auto; white-space:nowrap;width:190px;" >&nbsp;Search Results</td>
                  <td style="padding-top:2px;padding-right:6px;cursor:pointer;" valign="middle"  align="right"><img id="Img1" src="~/images/btn_close.gif" runat="server" onclick="HideSearchDiv(); return false;" alt="" /></td>
                </tr>
            </table>

            
             <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" RenderMode="inline">
                        <ContentTemplate>
                        <div id="divToolTip" onmouseover="this.style.display='none'" 
							style="width:180px;border:1px solid black;display:none;position:absolute;z-index:50000;color:black;font-size:11px;padding:5px;background:#E1ECFF;filter:progid:DXImageTransform.Microsoft.dropshadow(OffX=4, OffY=4, Color='gray', Positive='true');">
                        </div>
            <div id="div1" runat="server">            
				<asp:Repeater
					runat="server" ID="rptStores" DataSourceID="ObjectDataSource1">
						<HeaderTemplate>
							<table class="SearchTbl" border="0" cellpadding="0" cellspacing="0">
						</HeaderTemplate>
                        <ItemTemplate>
							<tr onmousemove="showToolTip(this,'<%#Server.HtmlEncode(Functions.StringTruncate(Functions.IfNull(Eval("AssingedBy"),""),25)) & "','" & Eval("TypeName")& "','" & Eval("Status") & "','" & Eval("CategoryName")& "','" & Eval("DueDate").tostring()& "','" & Eval("ReleaseName") %>');" onmouseout="OnOut(this);" onclick="OnClick('<%#Eval("ReleaseID")%>','<%#Eval("ID")%>');">
								<td style="width:5px;"><img src='<%= ConfigurationManager.AppSettings("ImagesURL") %><%#Eval("Priority") %>' /></td>
								<td style="width:5px;"><%#Eval("RefNo")%></td>
								<td><%#Server.HtmlEncode(Functions.StringTruncate(Functions.IfNull(Eval("Name"), ""), 24))%></td>
								<td style="width:2px;"></td>
							</tr>
						</ItemTemplate>
						<FooterTemplate>
								<tr id="trStores_NoRecord" runat="server" ><td colspan="4" style="font-style:italic;text-align:center;height:20px;">No Ticket & Feature to show!</td></tr>
								<tr><td colspan="4" style="height:100%;text-align:center;"></td></tr>
							</table>
						</FooterTemplate>
					</asp:Repeater>
					</div> 
                       </ContentTemplate>
                         <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click"></asp:AsyncPostBackTrigger>
                         </Triggers>
                    </asp:UpdatePanel>
						<asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
							SelectMethod="PM_TicketSearchForMyNetsolaceCorporate" TypeName="Portal.BLL.PM.PM_Ticket_Features">
							<SelectParameters>
								<asp:ControlParameter ControlID="txtsearch" DefaultValue="" Name="txtsearch" PropertyName="Text" Type="String" />
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
             <iframe name="IfPM" runat="server" id="IfPM" src="MyTickets.aspx" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
         </td>
       </tr>       
      </table>
    </td>
  </tr>
</table>
<script type="text/javascript" language="javascript" >
    function HideSearchDiv() {
        document.getElementById('<%= txtsearch.ClientID %>').value = '';
        document.getElementById('<%= div1.ClientID %>').style.display = 'none';
        document.getElementById('tblHeadSearch').style.display = 'none';
        document.getElementById('<%= leftpanel.ClientID %>').style.display = '';
    }
    function HideLeftPanel() {
        var client_height = $(window).height() - 220;
        document.getElementById('<%= div1.ClientID %>').style.display = '';
        document.getElementById('tblHeadSearch').style.display = '';
        document.getElementById('<%= leftpanel.ClientID %>').style.display = 'none';
        document.getElementById('<%= txtsearch.ClientID %>').focus();
        $('#ctl00_contentMyNetsolace_div1').attr('style', 'height:' + client_height + 'px;overflow-y:auto;Width:100%;border:0px solid #FFFFFF;');
    }
    function showToolTip(obj, AssignedBy, Type, Status, Category, DueDate, Release) {
        obj.className = 'HighlightedLeftPanelRow';
        var message = '';
        message += ' Assigned By: ' + AssignedBy + '<br /> Type: ' + Type + '<br /> Status: ' + Status + '<br /> Category: ' + Category + '<br /> DueDate: ' + DueDate;
        if (Release != '')
            message += '<br /> Release:' + Release;

        $('#divToolTip').html(message);
        $('#tblSearchResults').bind('mousemove', function (e) {
            var divToolTip = document.getElementById("divToolTip");
            divToolTip.style.display = '';
            divToolTip.style.left = e.pageX + 10;
            divToolTip.style.top = e.pageY - 70;
        });


    }
    function OnOut(tr) {
        tr.className = '';
        hideToolTip();
    }
    function OnClick(ReleaseID, ID) {
        IfPM.location = 'TicketsDetail.aspx?ReleaseID=' + ReleaseID + '&ID=' + ID + '&PrevPage=4';
    }

    function hideToolTip() {
        var divToolTip = document.getElementById("divToolTip");
        divToolTip.style.display = "none";
    }
    function CheckNoisyWord() {
        var mybool = true;
        var InputStr = document.getElementById('<%=txtsearch.ClientID%>').value;
        if (CheckSpecailChar(InputStr) == true) {
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
</script>
</asp:Content>

