<%@ Control Language="VB" AutoEventWireup="false" CodeFile="leftpanel_Admin.ascx.vb" Inherits="contacts_leftpanel_Admin"  %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<table width="170px" border="0" cellpadding="0" cellspacing="0" style="border:solid 0px #EEEDE5; height:100%;" bgcolor="#DDEEFE">
<tr>     
    <td align="center" colspan="3" valign="middle" style="margin:0;padding:0px; height:50px;">
    <asp:Panel ID="pnlSearch" runat="server" style="margin:0;padding:0px; width:160px;" ScrollBars="None">
        <table cellpadding="0" cellspacing="0" border="0" style="width:165px; background-color:#ffffff;">
            <tr>
                <td style="width:25px;border-top:solid 2px #82ABC7;border-bottom:solid 2px #82ABC7;border-left:solid 2px #82ABC7;" align="center"><img src="../images/icn_search.jpg" /></td>
                <td style="border-top:solid 2px #82ABC7;border-bottom:solid 2px #82ABC7;border-right:solid 2px #82ABC7;"><asp:TextBox ID="txtSearch" runat="server" ValidationGroup="vgSearch" MaxLength="20" style="height:100%; border:0; width:110px;" onchange="ShowSearch(true);" AutoPostBack="true"></asp:TextBox></td>
                <td><img src="../images/btn_goTxtBox.jpg" style="cursor:pointer;" onclick="ShowSearch(true);" /></td>
                <cc1:TextBoxWatermarkExtender ID="wmtxtSearch" runat="server" TargetControlID="txtSearch" WatermarkText="Search" WatermarkCssClass="watermarked">
                </cc1:TextBoxWatermarkExtender>
                <asp:RequiredFieldValidator ID="rfvSearch" runat="server" ControlToValidate="txtSearch" ValidationGroup="vgSearch"></asp:RequiredFieldValidator>                                    
            </tr>
        </table>
        
    </asp:Panel>
    </td>            
</tr>
 <tr id="trMenus">
    <td style="height:100%; width: 216px;" valign="top"> 
     <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">       
      <tr onclick="javascript:RedirectPage(1);" runat="server" visible="true"  id="tr_One" class="leftPanel_Selected">
            <td align="center" style="width: 10px">
                  <div width="17" runat="server" id="Div1" height="31"  align="center" />
            </td>
            <td colspan="2"  align="left" >
                &nbsp;<a href="#">Manage Users </a>
           </td>
     </tr>            
      <tr onclick="javascript:RedirectPage(2);"   runat="server" id="tr_Two" class="leftPanel_Normal">
        <td align="right" style="width: 10px"  >
            <div width="17" runat="server" id="img_Three" height="31" align="right" />
        </td>
        <td colspan="2"  align="left" >
            &nbsp;<a href="#">Manage Clients</a>
        </td>
     </tr>
      <tr onclick="javascript:RedirectPage(3);"  runat="server" id="tr_Three" class="leftPanel_Normal">
        <td align="center" style="width: 10px">
            <div width="17" runat="server" id="Div2" height="31" align="center" />
        </td>
        <td colspan="2"  align="left" >
            &nbsp;<a href="#">Manage Topics</a>
        </td>
     </tr> 
      <tr onclick="javascript:RedirectPage(4);"  runat="server" id="tr_Four" class="leftPanel_Normal">
        <td align="center" style="width: 10px"  >
            <div width="17" runat="server" id="Div3" height="31" align="center" />
        </td>
        <td colspan="2"  align="left" >
            &nbsp;<a href="#">Manage Products</a>
        </td>
     </tr> 
      <tr onclick="javascript:RedirectPage(5);" style="display:none;"  runat="server" id="tr_Five" class="leftPanel_Normal">
        <td align="center" style="width: 10px"  >
            <div width="17" runat="server" id="Div4" height="31" align="center" />
        </td>
        <td colspan="2"  align="left" >
            &nbsp;<a href="#">Manage Clients</a>
        </td>
     </tr> 
	 <tr onclick="javascript:RedirectPage(7);" runat="server" visible="true"  id="tr_Seven" class="leftPanel_Normal">
            <td align="center" style="width: 10px">
                  <div width="17" runat="server" id="Div6" height="31"  align="center" />
            </td>
            <td colspan="2"  align="left" >
                &nbsp;<a href="#">Manage Product Modules </a>
           </td>
     </tr>
     <tr style="height:2px;">
                <td colspan="3"><img src="../images/bg_lftPnl_horLine2.jpg" height="2" width="100%" /></td>
             </tr>
    </table>
</td>
</tr>
<tr id="trSearchDivHead" style="border-bottom:solid 1px #ffffff; display:none;">
    <td style="width: 170px;" >
        <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
        <tr class="searchResults">
            <td style="padding-left:5px;width:97%; height: 19px;">Search Results</td>
            <td style="cursor:pointer; height: 19px; width: 16px;" align="right"><span onclick="ShowSearch(false);">X&nbsp;</span></td>
        </tr>
        </table>
    </td>
</tr>
 <tr id="trSearch" style="height:100%; padding-top:1px; display:none;">        
    <div id="divToolTip" style="background:'#D8EAFC';border:1px solid black;display:none;position:absolute;width:250px;z-Index:1000;font-size:12px; padding:2px; padding-left:3px;"></div>            
    <td style="height:100%;" colspan="3">
        <div id="divSearch" style="width:100%; height:100%;  border-top:0px; overflow-y:auto;" class="ScrollBarHomeTicket">
        <asp:UpdatePanel ID="upLicenseSearch" runat="server" RenderMode="Inline" UpdateMode="conditional"> 
        <ContentTemplate>        
        <asp:Literal ID="ltrlNoRecord" runat="server" Visible="false" Text="<table style='height:100%; width:100%;'><tr><td style='height:100%; font-size:12px;' valign='middle' align='center'>No Records Found!</td></tr></table>"></asp:Literal>
        <asp:Repeater ID="rptSearchUsers" runat="server" DataSourceID="sdsUserSearch">
            <HeaderTemplate>                
                <table cellpadding="0" cellspacing="0" border="0" style="width:100%; border-top:0;" class="gvwSilver">                
            </HeaderTemplate>
            <ItemTemplate>
                 <tr class="blueBorder" onclick="ShowDetail('<%# Eval("ID") %>');" onmousemove="this.className='onMouseOut';showToolTip(this,'<%# "<b>Name:</b> " & Eval("Name") & "<br/><b>Job Title:</b> " & Eval("JobTitle") & "<br/><b>Work Phone:</b> " & Eval("Phone") %>');" onmouseout="this.className='blueBorder';hideToolTip();">
                    <td><%#Functions.StringTruncate(Eval("Name"), 20)%></td>
                 </tr>
            </ItemTemplate>
            <FooterTemplate>                
                </table>                
            </FooterTemplate>
        </asp:Repeater>
        </ContentTemplate>        
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="txtSearch" EventName="TextChanged" />
        </Triggers>
        </asp:UpdatePanel>        
        </div>       
        <asp:SqlDataSource ID="sdsUserSearch" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                DataSourceMode="DataReader" SelectCommand="Users_GetAll_ForSearch" SelectCommandType="StoredProcedure">
        <SelectParameters>            
            <asp:ControlParameter ControlID="txtSearch" Name="Search"  PropertyName="Text" ConvertEmptyStringToNull="true" />
        </SelectParameters>
        </asp:SqlDataSource>
       
    </td>
</tr>
     <tr >
        <td colspan="3" style="height: 19px">&nbsp;</td>
     </tr>
</table>
<script type="text/javascript" language="javascript" >
    
     function RedirectPage(Page)   
   {
         document.getElementById('<%= tr_One.ClientID %>').className="leftPanel_Normal";
         document.getElementById('<%= tr_Two.ClientID %>').className="leftPanel_Normal";
         document.getElementById('<%= tr_Three.ClientID %>').className="leftPanel_Normal";
         document.getElementById('<%= tr_Four.ClientID %>').className="leftPanel_Normal";
         document.getElementById('<%= tr_Five.ClientID %>').className="leftPanel_Normal";
		 document.getElementById('<%= tr_Seven.ClientID %>').className="leftPanel_Normal";
		 
         if (Page==1)
         {        
                document.getElementById('<%= tr_One.ClientID %>').className="leftPanel_Selected";               
                IfAdmin.location='Users.aspx';
         }
         else if (Page==2)
         {      
                document.getElementById('<%= tr_Two.ClientID %>').className="leftPanel_Selected";               
                IfAdmin.location='Client.aspx';
         } 
         else if (Page==3)
         {      
                document.getElementById('<%= tr_Three.ClientID %>').className="leftPanel_Selected";               
                IfAdmin.location='Topic_List.aspx';
         }
         else if (Page==4)
         {      
                document.getElementById('<%= tr_Four.ClientID %>').className="leftPanel_Selected";               
                IfAdmin.location='NS_ProductsList.aspx';
         }
         else if (Page==5)
         {      
                document.getElementById('<%= tr_Five.ClientID %>').className="leftPanel_Selected";               
                IfAdmin.location='ManageClients.aspx';
         }
		 else if (Page==7)
         {      
                document.getElementById('<%= tr_Seven.ClientID %>').className="leftPanel_Selected";               
                IfAdmin.location='ManageProductModules.aspx';
         }           
    }
    
    function ShowSearch(isVisible)
    {
        
        if(isVisible){
            trMenus.style.display="none";
            trSearch.style.display="inline";
            trSearchDivHead.style.display="inline";
            
        }
        else{
            trMenus.style.display="inline";
            trSearch.style.display="none";
            trSearchDivHead.style.display="none";
            document.getElementById('<%= txtSearch.ClientID %>').value='';
        }
    }
   
    function ShowDetail(userid){
            IfAdmin.location = 'UsersEdit.aspx?userid='+userid;
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