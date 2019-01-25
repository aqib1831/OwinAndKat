<%@ Control Language="VB" AutoEventWireup="false" CodeFile="leftpanel_Urlm.ascx.vb" Inherits="contacts_leftpanel_PM"  %>
<asp:UpdatePanel runat="server" ID="UPURLs" ChildrenAsTriggers="false"  UpdateMode="Conditional" RenderMode="block"  >
         <ContentTemplate>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:solid 0px #EEEDE5; height:100%;"  bgcolor="#D8EAFC">
    <tr>
      <td colspan="3" style="height:31px;background-color:#A0CDEE;font-size:15px;font-weight:bold;padding:5px;border-bottom:1px solid #609BD3;" >
         <span class="SimpleSmall">
			Search URL:</span><br />
			<asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
			
			     <asp:TextBox runat="server" ID="txtSearch" Width="89%" CssClass="GreyTextBox" MaxLength="50" onfocus="javascript:this.value='';" /><span style="width:1px;"></span>
                 <asp:ImageButton ID="btnSearch" runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />                             
             </asp:Panel>            
      </td>                 
    </tr>
    <tr onclick="javascript:RedirectPage(1);" runat="server" visible="true"  id="tr_One" class="Calendar_Selected">
            <td align="center" style="width: 10px"  >
                  <div width="17" runat="server" id="img_One" height="31"  align="center" />
            </td>
            <td colspan="2"  align="left" >
                &nbsp;<a href="#">URL Mgmt</a>
           </td>
     </tr> 
    <tr onclick="javascript:RedirectPage(2);" runat="server" visible="true"  id="tr_Two" class="Calendar_Normal">
            <td align="center" style="width: 10px"  >
                  <div width="17" runat="server" id="Div1" height="31"  align="center" />
            </td>
            <td colspan="2"  align="left" >
                &nbsp;<a href="#">Manage Accounts</a>
           </td>
     </tr>  
    <tr onclick="javascript:RedirectPage(3);" runat="server" visible="true"  id="tr_Three" class="Calendar_Normal">
            <td align="center" style="width: 10px"  >
                  <div width="17" runat="server" id="Div2" height="31"  align="center" />
            </td>
            <td colspan="2"  align="left" >
                &nbsp;<a href="#">Manage Categories</a>
           </td>
     </tr>  
    <tr onclick="javascript:RedirectPage(4);" runat="server" visible="true"  id="tr_Four" class="Calendar_Normal">
            <td align="center" style="width: 10px"  >
                  <div width="17" runat="server" id="Div3" height="31"  align="center" />
            </td>
            <td colspan="2"  align="left" >
                &nbsp;<a href="#">Manage Registrars</a>
           </td>
     </tr>
    <tr style="width:100%;height:100%;">
      <td style="height:100%;" colspan="3">   
      <div id="div4" style="Height:100%;Width:100%;border:0px solid #FFFFFF;" class="ScrollBarHomeTicket">           
          <div id="divStores" runat="server" style="display:none;Height:100%;Width:100%;" >
           <div id="divToolTip" style="background:#D8EAFC;border:1px solid black;display:none;position:absolute;width:300px;z-Index:1000;font-size:12px; font-weight:normal; padding:2px; padding-left:3px;"></div>            
                    <asp:Repeater
                        runat="server"
                        ID="rptStores"
                        DataSourceID="srcURLs" >
                        <HeaderTemplate>
                            <table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%; font-size:11px;">
                                <tr class="Calendar_Normal"  style="height:31px">
                                      <td colspan="2" style="cursor:default;Width:80%;" >&nbsp;Search Results</td>
                                      <td style="width:35px;padding-top:2px;padding-right:2px;" valign="top" align="right"><img src="../images/btn_close.gif" onclick="HideURLSearchDiv(); return false;" alt="" /></td>
                                </tr>
                                <tr>
                                      <td colspan="3" style="height:100%;"  >
                                          <div id="div1" style="overflow-y:auto;Height:100%;Width:100%;border:0px solid #FFFFFF;" class="ScrollBarHomeTicket">
                                             <table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%; font-size:11px;">                                
                        </HeaderTemplate>
                        <ItemTemplate>
                                                <tr style="height:25px;cursor:pointer;" onmousemove="this.className='HighlightedLeftPanelRow';showToolTip(this,'<%# "<b>" & Eval("URL")  &  "</b><br/><b>Registrar:</b> " & Eval("Registrar")  & "<br/><b>Category:</b> " & Eval("Category") & "<br/><b>Expiration:</b> " & Eval("Expiration_Date")%>');" onmouseout="this.className='';hideToolTip();" onclick="javascript:RedirectEditURLPage('<%#Eval("URLID")%>');">
					                                    <td style="padding-left:2px; width:8px;" ><img src="../images/arrows.gif" width="8" height="8" alt="" /></td>
				  	                                    <td style="padding-left:2px;width:90%;"><%#Eval("URL")%></td>					                                    
		                                        </tr>
						                        <tr style="height:1px;" >
							                        <td height="1" colspan="2" bgcolor="98AECD"><img src="../images/spacer.gif" height="1" width="1"></td>
						                        </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                                                <%--<tr><td colspan="3" style="text-align:center;">&nbsp;</td></tr>--%>
                                                <tr id="trStores_NoRecord" style="height:25px;text-align:center;" runat="server" ><td colspan="3" style="font-style:italic;text-align:center;height:20px;">No URL to show!</td></tr>
                                                <tr><td colspan="3" style="height:100%;text-align:center;"><img  src="../images/pixel_gray.JPG" height="1" width="100%" alt="" /></td></tr>
                                            </table>
                                         </div>
                                     </td>
                                  </tr>
                              </table>
                        </FooterTemplate>
                        </asp:Repeater>                   
                         <asp:ObjectdataSource 
                                ID="srcURLs" 
                                runat="server" 
                                TypeName="URLM" 
                                SelectMethod="GetAllURLs"
                                SelectCountMethod="GetTotalRecords" 
                                EnablePaging="false"
                                SortParameterName="sortExpression">        
                                <SelectParameters>
                                    <asp:Parameter Name="AccountID" DefaultValue="0" Type="Int32" />
                                    <asp:Parameter Name="CategoryID" DefaultValue="0" Type="int32" />
                                    <asp:Parameter Name="RegistrarId" DefaultValue="0" Type="int32" />
                                    <asp:Parameter Name="startRowIndex" DefaultValue="0" Type="int32" />
                                    <asp:Parameter Name="maximumRows" DefaultValue="100" Type="int32" />
                                    <asp:ControlParameter ControlID="txtSearch" Name="Search" DefaultValue="" Type="string" />
                                    <asp:Parameter Name="CommingExpries" DefaultValue="0" Type="int32" />
                               </SelectParameters>        
                        </asp:ObjectdataSource> 
                    </div>
        </div>
         <asp:HiddenField ID="hdnFranchiseID" runat="server" Value="0" />
         <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
        </td>
    </tr>          
	<tr  valign="top">
         <td colspan="3" id="display" style="padding:6px;"  valign="top"></td>
    </tr>  
</table>
</ContentTemplate>
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                    
    </Triggers>
</asp:UpdatePanel>
<script type="text/javascript" language="javascript" >
   
   function RedirectPage(Page)   
        {
                ChangeTrBackGround(Page);
                if (Page==1)
                {                  
                    Iframe.location='UrlmHome.aspx';
                }
                else  if (Page==2)
                {                  
                    Iframe.location='Accounts.aspx';
                }
                else   if (Page==3)
                {                  
                    Iframe.location='Category.aspx';
                }
                else   if (Page==4)
                {                  
                    Iframe.location='Registrar.aspx';
                }           
        }


   function ChangeTrBackGround(type)
        {
             document.getElementById('<%= tr_One.ClientID %>').className="Calendar_Normal"; 
             document.getElementById('<%= tr_Two.ClientID %>').className="Calendar_Normal"; 
             document.getElementById('<%= tr_Three.ClientID %>').className="Calendar_Normal"; 
             document.getElementById('<%= tr_Four.ClientID %>').className="Calendar_Normal"; 
            if (type==1)
                {
                document.getElementById('<%= tr_One.ClientID %>').className="Calendar_Selected";              
                }
                else  if (type==2)
                {                  
                   document.getElementById('<%= tr_Two.ClientID %>').className="Calendar_Selected";
                }
                else   if (type==3)
                {                  
                    document.getElementById('<%= tr_Three.ClientID %>').className="Calendar_Selected";
                }
                else   if (type==4)
                {                  
                    document.getElementById('<%= tr_Four.ClientID %>').className="Calendar_Selected";
                }
              
       }
       
    function RedirectEditURLPage(ID)
        {      
         
         Iframe.location = 'NewUrl.aspx?URLID='+ ID;
         
        }
        
    function HideURLSearchDiv()
	    {
	        document.getElementById('<%= txtsearch.ClientID %>').value = '';		    
		    document.getElementById('<%= divStores.ClientID %>').style.display='none';
		    document.getElementById('<%= tr_One.ClientID %>').style.display='';
		    document.getElementById('<%= tr_Two.ClientID %>').style.display='';
		    document.getElementById('<%= tr_Three.ClientID %>').style.display='';
		    document.getElementById('<%= tr_Four.ClientID %>').style.display='';
    				
	    }
	
	function HideRows()
	    {
	        
	        document.getElementById('<%= tr_One.ClientID %>').style.display='none';
	        document.getElementById('<%= tr_Two.ClientID %>').style.display='none';
	        document.getElementById('<%= tr_Three.ClientID %>').style.display='none';
		    document.getElementById('<%= tr_Four.ClientID %>').style.display='none';
    	
	    }
	
	function showToolTip(obj, msg)
        {
	        var obj = document.getElementById("divToolTip");
	        obj.innerHTML = msg;	       
	        obj.style.left = event.x - 5;
	        if(window.navigator.appName=="Microsoft Internet Explorer")
	        obj.style.top = event.y - 50;
	        else
	            obj.style.top = event.y+20;
	        obj.style.display = 'inline';
        }
		
    function hideToolTip()
	    {
	    var obj = document.getElementById("divToolTip");	
	    obj.style.display = "none";
	    }

	   function SetStoreDivHeight(height)
	   {
	    if(height>0)
	    {
	    document.getElementById('<%=divStores.ClientID%>').style.height=height;
	    }
	    else
	    {
	        document.getElementById('<%=divStores.ClientID%>').style.height = "100%";
	    }
	   }
</script>