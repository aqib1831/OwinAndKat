<%@ Control Language="VB" AutoEventWireup="false" CodeFile="UMLeftPanel.ascx.vb" Inherits="UM_UMLeftPanel" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:HiddenField ID="hdnSearch" runat="server" />
<div id="divToolTip" style="background:'#D8EAFC';border:1px solid black;display:none;position:absolute;width:300px;z-Index:1;font-size:12px; font-weight:normal; padding:2px; padding-left:3px;"></div>
<table width="170px" border="0" cellpadding="0" cellspacing="0" style="border:solid 0px #EEEDE5; height:100%;" bgcolor="#DDEEFE">
<tr class="">
    <td  align="center" style="padding-top:15px; padding-bottom:15px;">
    <table border="0" cellpadding="0" cellspacing="0" >
    <tr>
        <td>
            <img src="images/ico_user_manual.gif" style="cursor:pointer;" alt="User Manual" onclick="window.iframeMain.location='RecentUpdates.aspx';"  />            
        </td>
        <td>
            <span style="font-size:10pt; font-weight:bold;">User Manual</span>
        </td>
    </tr>
    </table>
        
    </td>            
</tr>
<tr class="" style="display:inline;">     
    <td align="center" style="padding-bottom:15px;">
    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="imgBtnSearch">
        <table cellpadding="0" cellspacing="0" border="0" style="width:165px; background-color:#ffffff;">
            <tr>
                <td style="width:25px;border-top:solid 2px #82ABC7;border-bottom:solid 2px #82ABC7;border-left:solid 2px #82ABC7;" align="center"><img src="images/icn_search.jpg" /></td>
                <td style="border-top:solid 2px #82ABC7;border-bottom:solid 2px #82ABC7;border-right:solid 2px #82ABC7;"><asp:TextBox ID="txtSearch" runat="server" ValidationGroup="vgSearch" MaxLength="70" TabIndex="1" style="height:100%; border:0; width:110px;"></asp:TextBox></td>
                <td><asp:ImageButton ID="imgBtnSearch" ValidationGroup="vgSearch" runat="server" ImageUrl="images/btn_goTxtBox.jpg" OnClientClick="SetDefaultButton();" TabIndex="2" /></td>
                <cc1:TextBoxWatermarkExtender ID="wmtxtSearch" runat="server" TargetControlID="txtSearch" WatermarkText="Search" WatermarkCssClass="watermarked">
                </cc1:TextBoxWatermarkExtender>
                <asp:RequiredFieldValidator ID="rfvSearch" runat="server" ControlToValidate="txtSearch" ValidationGroup="vgSearch"></asp:RequiredFieldValidator>                    
                <asp:RegularExpressionValidator ID="revSearch" runat="server" ControlToValidate="txtSearch" ValidationExpression="^[^#[;.<>\\/)}{?|(]*$" ValidationGroup="vgSearch"></asp:RegularExpressionValidator>
                <asp:CustomValidator ID="cvSearch" runat="server" ControlToValidate="txtSearch"  ClientValidationFunction="SearchValidator" ValidationGroup="vgSearch" ></asp:CustomValidator>
            </tr>
        </table>
    </asp:Panel>
    </td>            
</tr>
<tr id="trMenu" style="display:inline;" runat="server">
    <td>
        <table id="tblMenu" width="170px" border="0" cellpadding="0" cellspacing="0" style="border:solid 0px #EEEDE5;" bgcolor="#DDEEFE">     
             <tr id="tr5" onclick="javascript:RedirectPage(5);" runat="server" visible="true" class="leftPanel_Normal">
                    <td style="width: 19px; padding-left:5px;" align="absmiddle" >
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">Home</a>
                   </td>
             </tr>   
             <tr id="tr1" onclick="javascript:RedirectPage(1);" runat="server" visible="true" class="leftPanel_Normal">
                    <td style="width: 19px; padding-left:5px;" align="absmiddle" >
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">Manuals</a>
                   </td>
             </tr>
             <tr id="tr2" onclick="javascript:RedirectPage(2);" runat="server" visible="true" class="leftPanel_Normal">
                    <td style="width: 19px; padding-left:5px;" align="absmiddle">
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">Documents</a>
                   </td>
             </tr>
             <tr id="tr3" onclick="javascript:RedirectPage(3);" runat="server" visible="true" class="leftPanel_Normal">
                    <td style="width: 19px; padding-left:5px;" align="absmiddle">
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">Links</a>
                   </td>
             </tr>
             <tr id="tr4" onclick="javascript:RedirectPage(4);" runat="server" visible="true" class="leftPanel_Normal">
                    <td style="width: 19px; padding-left:5px;" align="absmiddle">
                          <div width="17px" height="31"  align="center" />
                    </td>
                    <td align="left" style="width:100%; padding-left:5px;">
                        &nbsp;<a href="#">Knowledge Base</a>
                   </td>
             </tr>
             <tr style="height:2px;">
                <td colspan="2"><img src="images/bg_lftPnl_horLine.jpg" height="2" width="100%" /></td>
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
        <div id="divSearch" runat="server" style="display:inline; width:100%; height:100%; border:solid 1px #609BD3; border-top:0px; overflow-y:auto;" class="BlueScrollBar">        
        <asp:UpdatePanel ID="upUserManual" runat="server"> 
        <ContentTemplate>        
        <asp:Repeater ID="rptUserManual" runat="server" DataSourceID="odsUerManualSearch">
            <HeaderTemplate>                
                <table cellpadding="0" cellspacing="0" border="0" style="width:100%; border-top:0;" class="gvwSilver">                
            </HeaderTemplate>
            <ItemTemplate>
                 <tr class="blueBorder" title='<%#Eval("Title")%>' onmousemove="this.className='MouseOverClass';" onmouseout="this.className='blueBorder';" onclick="ShowDetail(<%#Eval("ID")%>,<%#Eval("UMType")%>);return false;">
                    <td style="border-right:0px;" ><%#Functions.StringTruncate(Eval("Title"), 11)%></td>
                    <td><%#Functions.StringTruncate(Eval("UMTypeString"), 7)%></td>
                 </tr>
            </ItemTemplate>
            <FooterTemplate>
                <asp:Literal ID="ltrlNoRecord" runat="server" Visible="false" Text="<span style='height:200px;width:150px;padding-left:25px;padding-top:30px;padding-right:5px; font-size:10pt;'><i>No Results found</i></span>"></asp:Literal>
                </table>                
            </FooterTemplate>
        </asp:Repeater>
        <asp:ObjectDataSource ID="odsUerManualSearch" runat="server" 
                SelectMethod="SearchUserManual" TypeName="Portal.BLL.UM.Category">
                <SelectParameters>                          
                    <asp:ControlParameter ControlID="txtSearch" DefaultValue="" Name="Search" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false"   />
                </SelectParameters>
            </asp:ObjectDataSource>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="imgBtnSearch" EventName="Click" />
        </Triggers>
        </asp:UpdatePanel>
        </div>       
    </td>
</tr>
<tr style="height:100%;">
    <td>&nbsp;</td>
</tr>
</table>
<script type="text/javascript" language="javascript" >          
      function RedirectPage(pageId){           
          ResetBackground();
          switch(pageId){
              
            case 1:
                iframeMain.location='ManualList.aspx?UMType=1';
                document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Selected";
                break;
            case 2:
                iframeMain.location='DocumentList.aspx?UMType=2';
                document.getElementById('<%= tr2.ClientID %>').className="leftPanel_Selected";
                break;
            case 3:
                iframeMain.location='LinksList.aspx?UMType=3';
                document.getElementById('<%= tr3.ClientID %>').className="leftPanel_Selected";
                break;          
            case 4:                
                iframeMain.location='ManualList.aspx?UMType=4';
                document.getElementById('<%= tr4.ClientID %>').className="leftPanel_Selected";
                break;
            case 5:
                iframeMain.location='RecentUpdates.aspx?UMType=5';
                document.getElementById('<%= tr5.ClientID %>').className="leftPanel_Selected";
                break;     
            default:
                document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Selected";
                break;
          }
      }
      function ResetBackground()
      {
               document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Normal";
               document.getElementById('<%= tr2.ClientID %>').className="leftPanel_Normal";
               document.getElementById('<%= tr3.ClientID %>').className="leftPanel_Normal";
               document.getElementById('<%= tr4.ClientID %>').className="leftPanel_Normal";
               document.getElementById('<%= tr5.ClientID %>').className="leftPanel_Normal";
      }
      
      //To be called from other pages.
      function SetSelected(pageId){
        ResetBackground();
         switch(pageId){
            case 1:
                document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Selected";
                break;
            case 2:
                document.getElementById('<%= tr2.ClientID %>').className="leftPanel_Selected";
                break;            
            case 3:
                document.getElementById('<%= tr3.ClientID %>').className="leftPanel_Selected";
                break; 
            case 4:
                document.getElementById('<%= tr4.ClientID %>').className="leftPanel_Selected";
                break;  
            case 5:
                document.getElementById('<%= tr5.ClientID %>').className="leftPanel_Selected";
                break;            
            default:
                document.getElementById('<%= tr1.ClientID %>').className="leftPanel_Selected";
                break;
         }
      }
      var postbackElement;
      Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(beginRequest);
      Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(pageLoaded);
      Sys.WebForms.PageRequestManager.getInstance().add_endRequest(endRequest);
      function beginRequest(sender, args)
      {
            postbackElement = args.get_postBackElement();
            document.getElementById('<%=hdnSearch.ClientID%>').value = document.getElementById('<%= txtsearch.ClientID %>').value;
      }
      function pageLoaded(sender, args) 
      {         
            if (document.getElementById('<%= txtsearch.ClientID %>').value != ''&  document.getElementById('<%= txtsearch.ClientID %>').value != 'Search' )
            {
                document.getElementById('<%= trMenu.ClientID %>').style.display = 'inline';
            }    
            else 
            {
                document.getElementById('<%= trMenu.ClientID %>').style.display = 'inline';
            }
      }
      function endRequest()
      {
            HideLeftPanel();
            document.getElementById('<%= txtsearch.ClientID %>').value = '';
      }
      function HideLeftPanel()
      {     
            document.getElementById('<%= trSearch.ClientID %>').style.display='inline';
            document.getElementById('<%= trMenu.ClientID %>').style.display='inline'; 
            trSearchDivHead.style.display = 'inline';
            document.getElementById('<%= txtsearch.ClientID %>').focus() ;   
            HideRows();
      }
      function HideRows()
      {
            document.getElementById('<%= trMenu.ClientID %>').style.display='none';
      }
      function ShowRows()
      {
            document.getElementById('<%= trMenu.ClientID %>').style.display='inline';
      }
      function ShowSearch(visibility)
      { 
            if(visibility == "hidden"){
              trSearchDivHead.style.display = "none";
              document.getElementById('<%= trSearch.ClientID %>').style.display = "none";
              document.getElementById('<%= trMenu.ClientID %>').style.display = "inline";
              document.getElementById('<%= txtSearch.ClientID %>').value='';
            }
            else{          
                trSearchDivHead.style.display = "inline";
                document.getElementById('<%= trSearch.ClientID %>').style.display = "inline";
                document.getElementById('<%= trMenu.ClientID %>').style.display = "none";
            }        
      }  
      function SetDefaultButton()
      {
            __defaultFired = false;
      }
      function ShowDetail(ID,UMType)
      {
            switch(UMType)
            {
                case 1:window.iframeMain.location = "NewTopic.aspx?TopicID=" + ID + '&UMType=' + UMType + '&Search=' +  document.getElementById('<%=hdnSearch.ClientID%>').value;
                       break;
                case 2:      
                       window.iframeMain.location = "NewDocument.aspx?DocumentID=" + ID + '&UMType=' + UMType + '&Search=' +  document.getElementById('<%=hdnSearch.ClientID%>').value;
                       break;
                case 3:
                       window.iframeMain.location = "NewLink.aspx?LinkID=" + ID + '&UMType=' + UMType + '&Search=' +  document.getElementById('<%=hdnSearch.ClientID%>').value;
                       break;                                               
                case 4:
                       window.iframeMain.location = "NewTopic.aspx?TopicID=" + ID + '&UMType=' + UMType + '&Search=' +  document.getElementById('<%=hdnSearch.ClientID%>').value;
                       break;            
            }
      }
      function showToolTip(obj, msg)
      {
                var obj = document.getElementById("divToolTip");
                obj.innerHTML = msg;	       
                obj.style.left = event.x - 5;
                obj.style.top = event.y + 0;
                obj.style.display = 'inline';	        
      }
      function hideToolTip()
      {
	            var obj = document.getElementById("divToolTip");	
	            obj.style.display = "none";
      }
      function SearchValidator(OSrc,args)
      {
            if (document.getElementById('<%=txtSearch.ClientID%>').value=='' | document.getElementById('<%=txtSearch.ClientID%>').value=='Search')
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
      }
</script>