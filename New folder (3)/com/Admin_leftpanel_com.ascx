<%@ Control Language="VB" AutoEventWireup="false"  CodeFile="Admin_leftpanel_com.ascx.vb" Inherits="contacts_leftpanel_PM"  %>
    <script type="text/javascript" language="javascript" src="../scripts/functions.js" ></script>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:solid 0px #EEEDE5; height:100%;"  bgcolor="#D8EAFC">
      <tr>
          <td colspan="3" style="height:31px;background-color:#A0CDEE;font-size:15px;font-weight:bold;padding:5px;border-bottom:1px solid #609BD3;" >
             <span class="SimpleSmall">
				Search Franchisee:<br /></span>
				<asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
				
				     <asp:TextBox runat="server" ID="txtSearch" Width="85%" CssClass="GreyTextBox" MaxLength="50" AutoPostBack="false" onfocus="javascript:this.value='';" />
                     <asp:ImageButton ID="btnSearch" runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" /><br />
                <asp:UpdatePanel runat="server" ID="UpdatePanel1" ChildrenAsTriggers="True"  UpdateMode="Always" RenderMode="inline"  >
                    <ContentTemplate>
                         <asp:DropDownList runat="server" ID="ddlClient"
                            Width="100%"
                            Enabled="true"
                            SkinID="SmallTextCombo"
                            DataSourceID="sdsClients" 
                            DataTextField="Name"
                            DataValueField="ID"
                            AutoPostBack="false">
                          </asp:DropDownList>
                          <asp:SqlDataSource ID="sdsClients" 
                              runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                              SelectCommand="Clients_GetByUserIDForCom_BySubModuleID" 
                              SelectCommandType="StoredProcedure"
                              DataSourceMode="DataReader">
                              <SelectParameters>
                                  <asp:SessionParameter DefaultValue="" Name="UserID" SessionField="AdminID" Type="Int32" />
                                  <asp:ControlParameter ControlID="hdnSubModuleID" Name="SubModuleID"  PropertyName="Value" Type="String" />
                              </SelectParameters>
                          </asp:SqlDataSource>     
                           <asp:DropDownList runat="server" ID="ddlStates" 
                            Width="100%"
                            SkinID="SmallTextCombo"
                            DataSourceID="sdsStates"
                            DataTextField="Name"
                            DataValueField="StateID"
                            AutoPostBack="True" >
                           </asp:DropDownList> 
                           <asp:SqlDataSource ID="sdsStates" runat="server"
                                    ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                    SelectCommand="States_GetAll_ByFranchises"
                                    SelectCommandType="StoredProcedure"
                                    DataSourceMode="DataReader">
                                  <%--  <SelectParameters>
                                 <asp:ControlParameter ControlID="hdnFranchiseIDList" Name="FranchiseId"  PropertyName="Value" Type="String" />
                              </SelectParameters>--%>
                                    
                           </asp:SqlDataSource>
		         </ContentTemplate>
		            <Triggers >
    		            <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
		            </Triggers>
            </asp:UpdatePanel>
            </asp:Panel> 
          </td>                 
        </tr>
     <tr onclick="javascript:InboxTopic=0;RedirectPage(1);" runat="server" visible="true"  id="tr_One" class="Calendar_Normal">
            <td align="center" style="width: 10px"  >
                  <div width="17" runat="server" id="img_One" height="31"  align="center" />
            </td>
            <td colspan="2" style="width:100%;"  align="left" >
                &nbsp;<a href="#">Inbox&nbsp; <label id="lblCount" title=""  >( 0 )</label> </a>
           </td>
     </tr>   
     <tr onclick="javascript:RedirectPage(2);"  runat="server" id="tr_Two" class="Calendar_Normal">
        <td align="center" style="width: 10px"  >
            <div width="17" runat="server" id="img_Two" height="31" align="center" />
        </td>
        <td colspan="2"  align="left" >
            &nbsp;<a href="#">History</a>
        </td>
     </tr>   
      <tr onclick="javascript:RedirectPage(3);"  runat="server" id="tr_Three" class="Calendar_Normal" style="display:none;">
        <td align="center" style="width: 10px"  >
            <div width="17" runat="server" id="img_Three" height="31" align="center" />
        </td>
        <td colspan="2"  align="left" >
            &nbsp;<a href="#">Manage Topics</a>
        </td>
     </tr> 
      <tr onclick="javascript:RedirectPage(4);"  runat="server" id="tr_Four" class="Calendar_Normal">
        <td align="center" style="width: 10px"  >
            <div width="17" runat="server" id="Div2" height="31" align="center" />
        </td>
        <td colspan="2"  align="left" >
            &nbsp;<a href="#">Support Feedback Result</a>
        </td>
     </tr> 
      <tr runat="server" id="tr_five" >
        <td colspan="3">
         <asp:UpdatePanel runat="server" ID="UpdatePanel2" ChildrenAsTriggers="false"  UpdateMode="Conditional" RenderMode="block"  >
         <ContentTemplate>
             <asp:Repeater
                runat="server"
                ID="rptrTopics"
                DataSourceID="sdcTopics" >
                <HeaderTemplate>
					<table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%; font-size:11px;">
                      <tr class="Calendar_Normal"  style="height:31px">
                         <td colspan="2" style="cursor:default;Width:80%;" align="center" >&nbsp;Summary of Open Tickets</td>
                         <td style="padding-top:2px;padding-right:5px;"align="right">&nbsp;</td>
                      </tr>
                      <tr>
                      <td colspan="3" style="height:100%;"  >
                        <%--<div style="overflow-y:auto;Height:100%;Width:100%;" class="ScrollBarHomeTicket">--%>
                         <table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%; font-size:13px;" >
                </HeaderTemplate>
                <ItemTemplate>
                            <tr style="height:25px;cursor:pointer;" onmousemove="this.className='HighlightedLeftPanelRow';" onclick="InboxTopic=<%#Eval("ID")%>;RedirectPage(1);"  onmouseout="this.className='';" >
                                    <td style="padding-left:2px; width:8px;" ><img src="../images/arrows.gif" width="8" height="8" /></td>
                                    <td style="padding-left:2px;width:80%;"><%#Functions.StringTruncate(Eval("Topic"), 28)%></td>
                                    <td style="padding-right:5px;width:10%;text-align:right"><%#Eval("ActivityCount")%></td>
                            </tr>
                            <tr style="height:1px;" >
	                            <td height="1" colspan="3" bgcolor="98AECD"><img src="../images/spacer.gif" height="1" width="1"></td>
                            </tr>
                </ItemTemplate>
                <FooterTemplate>
                                <tr><td colspan="3" style="height:100%;text-align:center;"><img  src="../images/pixel_gray.JPG" height="1" width="100%" alt="" /></td></tr>
                                </table>
                            <%-- </div>--%>
                         </td>
                    </tr>
                </table>
                </FooterTemplate>
              </asp:Repeater>
               <asp:SqlDataSource ID="sdcTopics" runat="server"
                    SelectCommand="Activities_Topics_GetByFixed"
                    SelectCommandType="StoredProcedure"  
                    DataSourceMode ="DataReader"                                  
                    ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>">
                    <SelectParameters>
					  <asp:ControlParameter ControlID="hdnClientIDList" Name="ClientIDList"  PropertyName="Value" Type="String" />
					</SelectParameters>
          </asp:SqlDataSource> 
               </ContentTemplate>
            </asp:UpdatePanel>
        </td>
     </tr>
	 <tr style="width:100%;">
      <td style="height:100%;" colspan="3">   
      <div id="div1" style="Height:100%;Width:100%;border:0px solid #FFFFFF;" class="ScrollBarHomeTicket">   
        <asp:UpdatePanel runat="server" ID="UPCurrentActivities" ChildrenAsTriggers="false"  UpdateMode="Conditional" RenderMode="block"  >
         <ContentTemplate>
         <asp:HiddenField ID="hdnClientIDList" runat="server" Value="" />
         <asp:HiddenField ID="hdnFranchiseID" runat="server" Value="0" />
         <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
         <asp:HiddenField ID="hdnSubModuleID" runat="server" Value="" />
         <asp:HiddenField ID="hdnFranchiseIDList" runat="server" Value="" />

          
          <div id="divStores" runat="server" style="display:none;" >
           <div id="divToolTip" style="background:'#D8EAFC';border:1px solid black;display:none;position:absolute;width:300px;z-Index:1000;font-size:12px; padding:2px; padding-left:3px;"></div>            
                                <asp:Repeater  
                                    runat="server"
                                    ID="rptStores"
                                    DataSourceID="sdsStores" >
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
                                                <tr style="height:25px;cursor:pointer;" onmousemove="this.className='HighlightedLeftPanelRow';showToolTip(this,'<%# "<b>" & Eval("StoreName") & " - " & Eval("StoreNumber") & "</b> [ " & Eval("ClientName") & " ]" & "<br/><b>Status:</b> " & Functions.GetStoreStatus1(Eval("Status"),Eval("IsSuspended"),Eval("IsAbandon")) & "<br/><b>Phone:</b> " & Eval("Phone") & "<br/><b>Corporate Name:</b> " & Replace(Eval("CorporateName"), "'", "\'")%>');" onmouseout="this.className='';hideToolTip();" onclick="javascript:RedirectToFranchiseInbox('<%#Eval("ID")%>', '<%#Eval("ClientID")%>');">
					                                    <td style="padding-left:2px; width:8px;" ><img src="../images/arrows.gif" width="8" height="8" /></td>
				  	                                    <td colspan="2" style="padding-left:2px;width:90%;"><%#Functions.StringTruncate(Eval("StoreName"), 28) & " - " & Eval("StoreNumber")%></td>
					                                    <%--<td style="padding-left:2px;width:10%;" align="center" width="20"><%#Functions.IfNull(Eval("OpenActivities"), 0)%></td> Commented By sajjad we cant show it EA--%>                                                
		                                        </tr>
						                        <tr style="height:1px;" >
							                        <td height="1" colspan="3" bgcolor="98AECD"><img src="../images/spacer.gif" height="1" width="1"></td>
						                        </tr>
                                    </ItemTemplate>

                                    <FooterTemplate>
                                                <%--<tr><td colspan="3" style="text-align:center;">&nbsp;</td></tr>--%>
                                                    <tr id="trStores_NoRecord" style="height:25px;text-align:center;" runat="server" ><td colspan="3" style="font-style:italic;text-align:center;height:20px;">No Store to show!</td></tr>
                                                    <tr><td colspan="3" style="height:100%;text-align:center;"><img  src="../images/pixel_gray.JPG" height="1" width="100%" alt="" /></td></tr>
                                                    </table>
                                                 </div>
                                             </td>
                                        </tr>
                                    </table>
                                    </FooterTemplate>
                                  </asp:Repeater>
                    <asp:ObjectDataSource ID="sdsStores" runat="server"
                        OldValuesParameterFormatString="original_{0}"
                        SelectMethod="SearchStores_ByClientIdList"
                        TypeName="Portal.BLL.Activities">
                        <SelectParameters>
                           <%-- <asp:ControlParameter Name="ClientID" Type="Int32" ControlID="ddlClient" PropertyName="SelectedValue" />--%>
                            <asp:ControlParameter Name="StateID" Type="Int32" ControlID="ddlStates" PropertyName="SelectedValue" />
                            <asp:ControlParameter Name="Search" Type="String" ControlID="txtSearch" PropertyName="Text" ConvertEmptyStringToNull="false" />
                              <asp:ControlParameter ControlID="hdnClientIDList" Name="ClientIDList"  PropertyName="Value" Type="String" />
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
<script type="text/javascript" language="javascript" >
   var InboxTopic = 0;
   function RedirectPage(Page)   
    {
        document.getElementById('<%= tr_One.ClientID %>').className="Calendar_Normal";
        document.getElementById('<%= tr_Two.ClientID %>').className="Calendar_Normal";
        document.getElementById('<%= tr_Three.ClientID %>').className="Calendar_Normal";
        document.getElementById('<%= tr_Four.ClientID %>').className="Calendar_Normal";

         if (Page==1)
                {
                document.getElementById('<%= tr_One.ClientID %>').className="Calendar_Selected";
                Iframe.location='Admin_Inbox.aspx?ClientID='+ document.getElementById('<%= hdnClientID.ClientID %>').value +'&TopicID='+InboxTopic;
                }
         else if (Page==2)
                {
                document.getElementById('<%= tr_Two.ClientID %>').className="Calendar_Selected";
                Iframe.location='Admin_History.aspx?ClientID='+ document.getElementById('<%= hdnClientID.ClientID %>').value;
                }   
         else if (Page==3)
                {
                document.getElementById('<%= tr_Three.ClientID %>').className="Calendar_Selected";
                Iframe.location='Topic_List.aspx';
                }  
        else if (Page==4)
                {
                document.getElementById('<%= tr_Four.ClientID %>').className="Calendar_Selected";
                Iframe.location = 'TechnicianReport.aspx';
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
            else if (type==2)
                {
                document.getElementById('<%= tr_Two.ClientID %>').className="Calendar_Selected";
                }  
            else if (type==3)
                {
                document.getElementById('<%= tr_Three.ClientID %>').className="Calendar_Selected";
                }            
            else if (type==4)
                {
                document.getElementById('<%= tr_Four.ClientID %>').className="Calendar_Selected";
                }            
         }
      
    function SetInBox(value)    
        {       
        lblCount.innerHTML = '( ' + value + ' )';
        }

    function SetDefault()
        {
            lblCount.innerHTML = '( 0 )';
        }
        
   function RedirectToFranchiseInbox(FranchiseID, ClientID)
        {
         //alert('hdn = '+ document.getElementById('<%= hdnClientID.ClientID %>').value + ' ddl = ' + document.getElementById('<%= ddlClient.ClientID %>').value )
         document.getElementById('<%= hdnFranchiseID.ClientID %>').value = FranchiseID
         Iframe.location = 'Franchise_Inbox.aspx?FranchiseID='+ FranchiseID +'&ClientID=' +ClientID;
        }
        
  function HideEmployeeSearchDiv()
	    {
		    document.getElementById('<%= txtsearch.ClientID %>').value = '';
		    document.getElementById('<%= ddlStates.ClientID %>').value = 0;
		    document.getElementById('<%= divStores.ClientID %>').style.display='none';
		    document.getElementById('<%= tr_One.ClientID %>').style.display='inline';
		    document.getElementById('<%= tr_Two.ClientID %>').style.display='inline';
		    //document.getElementById('<%= tr_Three.ClientID %>').style.display='inline';
		    document.getElementById('<%= tr_Four.ClientID %>').style.display='inline';
		    document.getElementById('<%= tr_Five.ClientID %>').style.display='inline';
    				
	    }
	
	function HideRows()
	    {
	        document.getElementById('<%= tr_One.ClientID %>').style.display='none';
		    document.getElementById('<%= tr_Two.ClientID %>').style.display='none';
    	    //document.getElementById('<%= tr_Three.ClientID %>').style.display='none';
    	    document.getElementById('<%= tr_Four.ClientID %>').style.display='none';
    	    document.getElementById('<%= tr_Five.ClientID %>').style.display='none';
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
	
	function SetClient(ID)
        {
             HideEmployeeSearchDiv();
            document.getElementById('<%= hdnClientID.ClientID %>').value = ID;
            document.getElementById('<%= ddlClient.ClientID %>').value = ID;
            $get('<%=ddlStates.ClientID %>').value = 0;   
            document.getElementById('<%= btnSearch.ClientID %>').click();
           
        }
        
    var postbackElement;
    Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(beginRequest);
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(pageLoaded);
    
    function beginRequest(sender, args)
        {
            postbackElement = args.get_postBackElement();
        }
    
    function pageLoaded(sender, args) 
        {         
            if ( document.getElementById('<%= txtsearch.ClientID %>').value != '' ||  document.getElementById('<%= ddlStates.ClientID %>').value != 0 )
                {
		            document.getElementById('<%= tr_One.ClientID %>').style.display = 'none';
		            document.getElementById('<%= tr_Two.ClientID %>').style.display = 'none';
		           // document.getElementById('<%= tr_Three.ClientID %>').style.display='none';
		            document.getElementById('<%= tr_Four.ClientID %>').style.display='none';
		            document.getElementById('<%= tr_Five.ClientID %>').style.display='none';
		        }    
		    else 
		        {
		            document.getElementById('<%= tr_One.ClientID %>').style.display = 'inline';
		            document.getElementById('<%= tr_Two.ClientID %>').style.display = 'inline';
		           // document.getElementById('<%= tr_Three.ClientID %>').style.display='inline';
		            document.getElementById('<%= tr_Four.ClientID %>').style.display='inline';
		            document.getElementById('<%= tr_Five.ClientID %>').style.display='inline';
		        }
        }
        
        
   function DisableDropDown()
    {   
        setWindowedControlsVisibility(window, 'hidden'); 
        $get('<%=ddlStates.CLientID %>').value = 0;
        return true;
    }    
    
    function EnableDropDown()
    {              
       setWindowedControlsVisibility(window, 'visible');
       $get('<%=ddlStates.CLientID %>').value = 0;
       document.getElementById('<%= ddlStates.ClientID %>').style.visibility = 'visible'
    }
   
    function changeClient()
    {  //alert('hdn = '+ document.getElementById('<%= hdnClientID.ClientID %>').value + ' ddl = ' + document.getElementById('<%= ddlClient.ClientID %>').value )
       document.getElementById('<%= hdnClientID.ClientID %>').value = document.getElementById('<%= ddlClient.ClientID %>').value; 
       //alert('hdn = '+ document.getElementById('<%= hdnClientID.ClientID %>').value + '/n ddl = ' + document.getElementById('<%= ddlClient.ClientID %>').value )
       HideEmployeeSearchDiv();
    }
</script>