<%@ Page Language="VB" ValidateRequest="false" AutoEventWireup="false" CodeFile="URLmHome.aspx.vb" Inherits="EA_URLM_Default" Theme="Default"  %>
<%@ Register Src="~/controls/CtrlAlertdiv.ascx" TagName="CtrlAlertdiv" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"    Namespace="System.Web.UI" TagPrefix="asp" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>URL Managment</title>       
        <script language="JavaScript" src="../../scripts/disable_cr.js" type="text/javascript"></script>
        <script language="JavaScript" src="../../scripts/calendar.js" type="text/javascript"></script>
        <script language="JavaScript" src="../../scripts/functions.js" type="text/javascript"></script>
        <script language="JavaScript" src="../../scripts/calendar-en.js" type="text/javascript"></script>   
        <script type="text/javascript" language="JavaScript" src="../../scripts/calendar-fs.js"></script>        
        <link href="../../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="../../scripts/jquery.js"></script>
        <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=.2)" />  
<script type="text/javascript">
    function AdjustButtons(IsSafari)      
    {
        
        if(IsSafari==0)
        {
           $(".spnImageContainer img").attr("align","absmiddle");
           $(".spnImageContainer").attr("style","");
        }
        else
        {
            $(".spnImageContainer").attr("style","vertical-align:middle;");
            $(".spnImageContainer img").attr("align","none");
            $(".spnImageContainer img").css("padding-bottom","1px");
        }
    }
        
    </script>        
</head>
<body style ="margin :0px;background-color:#E4F1F7;">
<form id="frmURLs" runat="server" defaultbutton="btnsearch" >
<asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="300"  />
        <asp:UpdateProgress ID="Progress1" runat="server">
            <ProgressTemplate>
              <div class="ProgressIndicatorDIV" >
                   <br />
                     <asp:Image ID="Image2" runat="server" ImageUrl="../../images/indicator.gif" ImageAlign="AbsMiddle" /> <span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
                   <br />
                 <br />
              </div>
            </ProgressTemplate>
        </asp:UpdateProgress>  
        <table width="100%" style="height:100%; margin:0px; padding:0px;background-color:#E4F1F7; " cellspacing="0" cellpadding = "0" border="0"  >
             <tr class="UnderlinedRow" style="display:none;">
                 <td  style="height:20px;background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:5px;width:35%;">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                       <ContentTemplate>
                         Urls &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label runat="server" ID="lblActivityCount" />
                            &nbsp;<span class="NonBold">(<asp:Label runat="server" ID="lblfilter" Text="all" />)</span>
                        <asp:HiddenField ID="hdnAdminID" runat="server" Value="0" />
                        </ContentTemplate>
                            <triggers >                                  
                                  <asp:AsyncPostBacktrigger ControlID="ddlExpiry" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBacktrigger ControlID="ddlAccount" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBacktrigger ControlID="ddlRegistrar" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBacktrigger ControlID="ddlCategory" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBacktrigger ControlID="btnSearch" EventName="Click" />                              
                                  <asp:AsyncPostBacktrigger ControlID="lnkResetfilters" EventName="Click" />
                            </triggers>
                    </asp:UpdatePanel>
                </td>    
                <td style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right;cursor:pointer; height: 1px;width:150px;">
                  &nbsp;
                 
                 </td>              
                 <td style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right;cursor:pointer; height: 1px; ">
                     <img align="absMiddle"  height="20" src="../../images/pixel_skyBlue.jpg" width="1" alt="" /><img align="absMiddle"  height="20" src="../../images/pixel_skyBlue.JPG" width="1" alt="" />
                     &nbsp;                   
                     <asp:LinkButton ID="btnPrint" runat="server" CssClass="HomeButton"  OnClientClick="return URLMPrint();" >
                           <div style="width:80px;" class="LeadDetailButton" >
                           Print 
                                <span class="spnImageContainer" style="vertical-align:middle;"><img  src="../../images/blt_resetfilters.gif" width="10" height="10" style="border:0px;" /></span>
                           </div>
                     </asp:LinkButton> 
                 </td>                 
                         
                 <td style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right;cursor:pointer; height: 1px;width:150px; display:none;">
                    <img align="absMiddle"  height="20" src="../../images/pixel_skyBlue.jpg" width="1" alt="" /><img align="absMiddle"  height="20" src="../../images/pixel_skyBlue.JPG" width="1" alt="" />
                     &nbsp;                   
                     <asp:LinkButton ID="lnkResetfilters" runat="server" CssClass="HomeButton">
                            <div style="width:110px;" class="LeadDetailButton" onclick="javascript:resetfilters();">
                                Reset filters 
                            <span class="spnImageContainer" style="vertical-align:middle;"><img   alt="" src="../../images/blt_resetfilters.gif"  width="10" height="10" style="border:0px;"/></span>
                            </div>
                     </asp:LinkButton> 
                 </td>                        
             </tr>              
             <tr >
                  <td style="width:100%; height:35px;background-color:#BADCFC;font-size:11px;" colspan="6">    
                     <table width="100%" border="0" cellspacing="0" cellpadding="0" >                    
                      <tr >
                          <td align="right" valign="middle"   >
                            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tableSubHead" >
                             <tr style="height:25px;"  >
                                <td align="left"  valign="middle" style="padding-right:1px;display:none;"  >
                                   &nbsp;
                                  <asp:ImageButton ID="btnDeleteSelected" style="vertical-align:middle" runat="server" ToolTip="Delete All Selected URLs" CausesValidation="false" Visible="false" OnClientClick="return isReadyDelete();" ImageURL="../images/ico_deleteAll.gif" />
                                  </td>
                                    <td align="left" valign="middle" style="padding-top:2px; display:none;">
                                      <asp:ImageButton ID="btnUpdateAllURLs" Visible="false" style="vertical-align:middle" runat="server" ToolTip="Update All Selected URLs" CausesValidation="false"  OnClientClick="return isAnyCheckboxSelected();" ImageURL="../images/ico_updateAll.gif" />            
                                    </td>                               
                                <td align="left" valign="middle" style="padding-top:2px; padding-left:3px; width:100px; display:none; ">
                                        <span style="font-size: 7pt; color: #7c8798">Filters</span><br />      
                                        <asp:DropDownList ID="ddlExpiry" runat="server"
                                         style="width:120px;font-size:10px; height:20px; " 
                                         AutoPostBack="true" 
                                         EnableViewState="true">
                                             <asp:ListItem Text="Show All" Value="0"></asp:ListItem>
                                             <asp:ListItem Text="Coming expirations" Value="1"></asp:ListItem>
                                         </asp:DropDownList> 
                                </td>
                                <td style="width:10px;text-align:center; display:none;">
                                    <img  src="../../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" alt="" /> 
                                </td>                    
                                <td align="left" style="padding-top:2px;width:100px;  display:none;">  
                                         <span style="font-size: 7pt; color: #7c8798">Accounts</span><br /> 
                                        <asp:DropDownList ID="ddlAccount" runat="server"
                                            style="width:120px;font-size:10px; height:20px; " 
                                            DataSourceID="srcAccounts"
                                            DataTextField="DataText"
                                            DataValueField="ID"
                                            AutoPostBack="true" >                    
                                        </asp:DropDownList>
                                        <asp:ObjectdataSource
                                             id="srcAccounts"
                                             runat="server"
                                             TypeName="URLM"
                                             SelectMethod="GetAllAccounts" >         
                                         </asp:ObjectdataSource>  
                                   </td>
                                <td style="width:10px;text-align:center; display:none;">
                                    <img  src="../../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" alt="" /> 
                                </td>                    
                                <td align="left" style="padding-top:2px; width:100px; display:none; ">  
                                        <span style="font-size: 7pt; color: #7c8798">Category</span><br />
                                       <asp:DropDownList runat="server"
                                           id="ddlCategory"
                                           style="width:120px;font-size:10px; height:20px; " 
                                           DataSourceID="srcCategory" 
                                           DataTextField="DataText"
                                           DataValueField="ID"
                                           AutoPostBack="true">                    
                                        </asp:DropDownList>
                                        <asp:ObjectdataSource
                                             id="srcCategory"
                                             runat="server"
                                             Typename="URLM"
                                             SelectMethod="GetAllCategories">         
                                         </asp:ObjectdataSource>
                                        </td>
                                <td style="width:10px;text-align:center; display:none;">
                                    <img  src="../../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" alt="" /> 
                                </td>                    
                                <td align="left" style="padding-top:2px;width:100px; display:none; ">  
                                        <span style="font-size: 7pt; color: #7c8798">Registrars</span><br />
                                        <asp:DropDownList runat="server"
                                               id="ddlRegistrar"
                                               style="width:120px;font-size:10px; height:20px; " 
                                               DataSourceID="srcRegistrar" 
                                               DataTextField="DataText"
                                               DataValueField="ID"
                                               AutoPostBack="true">
                                         </asp:DropDownList>  
                                         <asp:ObjectdataSource
                                             id="srcRegistrar"
                                             runat="server"
                                             Typename="URLM"
                                             SelectMethod="GetAllRegistrars">         
                                             </asp:ObjectdataSource>
                                      </td>    
                                <td style="width:10px;text-align:center;">
                                    <%--<img  src="../../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" alt="" /> --%>
                                </td>                                           
                                <td align="left" valign="middle" style="padding-top:2px; width:220px;" >
                                   <span class="GreyTextSmall">Search</span><br />
                                      <asp:TextBox ID="txtSearch" runat="server" MaxLength="50" onfocus="javascript:this.value='';"  Width="100px"  Height="18px"/>
                                      <asp:ImageButton ID="btnSearch" runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />
                                  </td>
                                  <td >&nbsp;</td>
                                </tr>                 
                            </table>
                          </td>                   
                       </tr>           
                     </table>
                   </td>
              </tr>
             <tr>
               <td  colspan="6" style="background-color:#E4F1F7;margin:0px;padding:0px; height:100%;">
                    <div style="overflow-y:auto;height:100%;background-color:#E4F1F7;border:1px solid #ACBDD5;" id="_gridViewPanel1" class="ScrollBarHomeTicket">
                      <asp:UpdatePanel ID="UpdatePanel2"
                         runat="server" 
                         UpdateMode="conditional"
                         RenderMode="Inline">
                         <ContentTemplate>
                         <asp:HiddenField ID="hdnSearch" runat="server" Value="" />
                         <asp:GridView id="grdURLs" runat="server"
                             DataSourceID="srcURLs"
                             EnableViewState="false"
                             DataKeyNames="UrlID"                             
                             AutoGenerateColumns="False" 
                             EnableTheming="True"                              
                             SkinID="GridViewNormal"                         
                             AllowSorting="True" > 
                              <PagerSettings Mode="Numeric" Position="Bottom"  />
                                <PagerTemplate>                                                
                                  <div style="width:100%; border:0px black solid;" >
                                      <table width="100%" border="0" cellpadding="0" cellspacing="0"  style="height:20px;">
                                           <tr style="text-align:left;">
                                                 <td style="width:20%; white-space:nowrap;" align="left"  valign="middle" >
                                                   <span class="DarkBlueTextSmall" style="font-size:10px" >&nbsp; Page <asp:Literal id="litPageNumber" runat="server"/> of <asp:Literal id="litTotalPages"  runat="server"/></span>
                                                 </td>
                                                 <td style="width:10px; " align="right" ><img alt="" src="../../images/spacer.gif" width="15" height="1" align="absmiddle" /></td>                                    
                                                 <td style="width:1px; " align="center"><img alt="" src="../../images/pixel_darkBlue.jpg" width="1" height="20" align="absmiddle" /></td>
                                                 <td style="width:10px;" align="right"><img alt="" src="../../images/spacer.gif" width="15" height="1" align="absmiddle" /></td>
                                                 <td  align="right" valign="top"> <asp:Panel ID="pnlNumber" runat="server" HorizontalAlign="Right"  ></asp:Panel> </td>                                                                                                     
                                            </tr>
                                      </table>                                              
                                  </div>
                                </PagerTemplate>    
                                <Columns> 
                                <asp:TemplateField >
                                       <ItemStyle Width="2%" CssClass="NoSideBorder"  />
                                        <ItemTemplate  >
                                           <img src="../../images/arrows.gif" alt="" id="imgarrow" />
                                        </ItemTemplate>
                                </asp:TemplateField>                                  
                                <asp:TemplateField SortExpression="URL" HeaderText="&nbsp;URL">                                                        
                                    <ItemStyle CssClass="NoSideBorder" />
                                    <ItemTemplate>
                                            <asp:Label runat="server" ID="lblUrl" Text='<%# container.dataitem("URL")%>' style="display:none"></asp:Label>
                                            <asp:CheckBox ID="chkUpdateURL"  runat="server" cssClass="SmallCheckBox" visible="false"  />
                                            <a onclick="window.open('http://<%# Replace(container.dataitem("URL"),"'", "\'")%>');" class="hLink_imgbutton" title='Click to navigate the URL' > <%# Functions.StringTruncate(Functions.IfNull(container.dataitem("URL"),""),30) %>  </a>
                                    </ItemTemplate>
                                </asp:TemplateField>                                                                              
                            <%--    <asp:BoundField DataField="Registrar" HeaderText="Registrar"  HtmlEncode="False" SortExpression="Registrar" >
                                    <ItemStyle Height="15px" Width="12%" CssClass="NoSideBorder"  />
                                    <HeaderStyle  HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Category" HeaderText="Category" HtmlEncode="False" SortExpression="Category"  >
                                    <ItemStyle Height="15px" Width="15%" CssClass="NoSideBorder" />
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Account" HeaderText="Account" HtmlEncode="False" SortExpression="Account"  >
                                    <ItemStyle Height="15px" Width="15%" CssClass="NoSideBorder" />
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:BoundField>--%>
                                <asp:BoundField DataField="ReferralUrl" HeaderText="Pointing to" HtmlEncode="False" SortExpression="ReferralUrl"  >
                                    <ItemStyle Height="15px" Width="15%" CssClass="NoSideBorder" />
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Expiration_Date" HeaderText="Expiration" DataFormatString="{0:d}" HtmlEncode="False" SortExpression="Expiration_Date" >
                                    <ItemStyle  Font-Bold="true" Height="15px" Width="10%" CssClass="NoSideBorder" />
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:ImageField DataImageURLField="Status" SortExpression="Status" Visible="false" >
                                    <ItemStyle CssClass="hLink_nodecoration NoSideBorder" Height="15px" Width="4%"  />
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:ImageField>
                                <asp:BoundField DataField="RemaingDays" SortExpression="nothing" ShowHeader="False" Visible="False" />                            
                            </Columns>                                      
                         </asp:GridView> 
                         </ContentTemplate>
                                  <triggers >                                  
                                  <asp:AsyncPostBacktrigger ControlID="ddlExpiry" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBacktrigger ControlID="ddlAccount" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBacktrigger ControlID="ddlRegistrar" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBacktrigger ControlID="ddlCategory" EventName="SelectedIndexChanged" />
                                  <asp:AsyncPostBacktrigger ControlID="btnSearch" EventName="Click" />                              
                                  <asp:AsyncPostBacktrigger ControlID="lnkResetfilters" EventName="Click" />
                                  </triggers>
                         </asp:UpdatePanel>                                
                     <asp:ObjectdataSource 
                                ID="srcURLs" 
                                runat="server" 
                                TypeName="URLM" 
                                SelectMethod="GetAllURLsMyNetsolaceClient"
                                SelectCountMethod="GetTotalRecordsMyNetsolaceClient" 
                                EnablePaging="true"
                                SortParameterName="sortExpression">        
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="ddlAccount" Name="AccountID" DefaultValue="0" Type="Int32" />
                                    <asp:ControlParameter ControlID="ddlCategory" Name="CategoryID" DefaultValue="1" Type="int32" />
                                    <asp:ControlParameter ControlID="ddlRegistrar" Name="RegistrarId" DefaultValue="0" Type="int32" />
                                    <asp:ControlParameter ControlID="txtSearch" Name="Search" DefaultValue="" Type="string" />
                                    <asp:ControlParameter ControlID="ddlExpiry" Name="CommingExpries" DefaultValue="0" Type="int32" />
                               </SelectParameters>        
                        </asp:ObjectdataSource>
                     </div>                   
               </td>
             </tr> 
             <tr style="background-color:#BADCFC">
                <td align="left" colspan="5" id="CustomPagerRow" style="height:22px;">&nbsp;</td>
             </tr>                       
         </table>
         <uc1:CtrlAlertdiv id="CtrlAlertdiv" runat="server" EnableViewState="false"></uc1:CtrlAlertdiv> 
         <uc1:CtrlAlertdiv id="CtrldivLoading" runat="server"></uc1:CtrlAlertdiv>
         <!-- Div for update all URLs -->                         
        
    <iframe id="ifExportURLs" src="blank.aspx" width="0px" height="0px" runat="server"></iframe>
    <!--Div to show the updated status -->
       <div style="filter: revealtrans(duration=0.45,transition=12);position:absolute;left:20%; top:15%;height: 210px;WIDTH: 400px;"  id="divUpdatedStatus" runat="server">
        <table cellspacing="0" cellpadding="0"  style="width:100%; background-color:#f1f6fa;" border="0">                
             <tr>
                    <td style="height:30px;">
                     <table cellspacing="0" cellpadding="0" width="100%" border="0">                                   
                       <tr>  
                           <td align="left" style="border-bottom:solid 1px #000000; padding-left:1em; background-image:url(../../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
                            <strong><asp:Label runat="server" Font-Size="14px" ID="lblUpdatedDivStatus" Text="Updated Status " ForeColor="white"></asp:Label> </strong>
                          </td>
                           <td  style="border-bottom:solid 1px #000000;background-image:url(../../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%; height:28px; cursor:pointer;" onclick="javascript:closeDiv('<%=divUpdatedStatus.ClientID %>'); return false;">
                           <img  alt=""  src="../../images/win_btn_close_Black.jpg" width="21" height="28" runat="server" id="img2" visible="true" border="0" />                    
                           </td>               
                        </tr>                                 
                        </table>
                       </td>
                 </tr>
             <tr>
                   <td class="div_bg">
                             <table style="height:100%;" cellspacing="0" cellpadding="0" width="100%" border="0">
                                
                                    <tr>
                                        <td style="PADDING-BOTTOM: 10px; PADDING-TOP: 10px" align="left">
                                            <table cellspacing="4" cellpadding="0" width="90%" align="center" border="0">
                                                
                                                    <tr>
                                                        <td colspan="3">
                                                            <!-- Ajax toolkit updations --><ajaxToolkit:AlwaysVisibleControlExtender id="avce" runat="server" TargetControlID="divUpdatedStatus" VerticalSide="Middle" VerticalOffset="0" HorizontalSide="center" HorizontalOffset="0" ScrollEffectduration=".1"></ajaxToolkit:AlwaysVisibleControlExtender>
                                                             <!-- Main code starts here. -->
                                                                    <asp:GridView id="grdUdadtedURLs" 
                                                                                 runat="server"
                                                                                 DataSourceID="srcUdpatedURLs"
                                                                                 EnableViewState="false" 
                                                                                 CssClass="container" 
                                                                                 Width="100%" 
                                                                                 GridLines="Horizontal" 
                                                                                 EnableSortingAndPagingCallbacks="true" 
                                                                                 cellpadding="4" 
                                                                                 AutoGenerateColumns="False" 
                                                                                 SkinID="GridViewNormal"
                                                                                 AllowPaging="true" 
                                                                                 AllowSorting="true">
                                                                                    <Columns>               
                                                                                        <asp:BoundField DataField="Key" HeaderText="URL" HeaderStyle-HorizontalAlign="Left" HtmlEncode="false"  />
                                                                                        <asp:ImageField DataImageURLField="Value" HeaderText="Status" HeaderStyle-HorizontalAlign="center" ItemStyle-Width="15%" ItemStyle-CssClass="hLink_nodecoration"></asp:ImageField>                               
                                                                                    </Columns>             
                                                                                </asp:GridView>
                                                                    <asp:ObjectdataSource id="srcUdpatedURLs" 
                                                                            runat="server" 
                                                                            SelectMethod="GetUpdatedURLStatus" 
                                                                            TypeName="URLM">    
                                                                    </asp:ObjectdataSource>
                                                        </td>
                                                    </tr>
                                                
                                            </table>
                                         </td>
                                    </tr>
                                    <tr>
                                        <td style="PADDING-RIGHT: 5px" class="divBg_footer" valign="middle" align="right" height="30px">
                                            <a onclick="javascript:closeDivURL('<%=divUpdatedStatus.ClientId%>'); return false;" href="#">
                                            <asp:Button id="Button1" runat="server" Text="Close" CssClass="button_normal"></asp:Button></a>
                                        </td>
                                    </tr>
                                
                              </table>
                            </td>
              </tr>                             
        </table>
      </div>
     <!-- Div for manulay update a single URL -->
       
</form>
<script language="javascript" type="text/javascript" >

  function ShowHide(visible)
 {   
    if (visible == true)
    {
        setWindowedControlsVisibility(window,'visible');
    }
    else 
    {
       setWindowedControlsVisibility(window,'hidden');
    }      
 }
  
  function resetfilters()
    {
       
        var item;     
       
        if (item = document.getElementById('<%= txtSearch.ClientID %>'))
        {
        
            item.value = '';
        }
        if (item = document.getElementById('<%= ddlAccount.ClientID %>'))
        {
            item.value = '0';
        }
        if (item = document.getElementById('<%= ddlRegistrar.ClientID %>'))
        {
            item.value = '0';
        }
        if (item = document.getElementById('<%= ddlExpiry.ClientID %>'))
        {
            item.value = '0';
        }
        if (item = document.getElementById('<%= ddlCategory.ClientID %>'))
        {
            item.value = '0';
        }     
       return true;
    }
    
  function AdjustPagerRow(){
        var objTag = null;
        var objCustomRow = null;
        try{
        objCustomRow = getElement("CustomPagerRow");
        objTag = getElementByClassName('FloatingPager');
        objCustomRow.innerHTML = '&nbsp;';
        if (objTag != null && objCustomRow != null)
            {
            objTag.style.display = 'none';
            objCustomRow.innerHTML = "<table cellpadding=0 cellspacing=0 align='left' height='18' ><tr class='cpyFloatingPager'>"+objTag.innerHTML+"</tr></table>";
            }
        }catch(ex){
            alert("Javascript Error:\n"+ex.description);
        }
    }
    
    AdjustPagerRow();
    
    var postbackElement;
    Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(beginRequest);
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(pageLoaded);
    
    function beginRequest(sender, args) {
        postbackElement = args.get_postBackElement();
    }
    
    function pageLoaded(sender, args) {
        var updatedPanels = args.get_panelsUpdated();
        if (typeof(postbackElement) === "undefined") {
            return;
        } 
        for (i="0"; i < updatedPanels.length; i++){
 {
                AdjustPagerRow();
                $get('<%= txtSearch.ClientID %>').value='';               
            }
        }
    }

</script>
<script language="javascript" type="text/javascript">
    function ShowNewURL(divId, setfocustocontrol)
    {
        ShowAniDiv(getElement(divId));
		//document.getElementById('divContainer').style.display='inline';
		
    }
   function closeDivURL(divId)
    {
        
        hideAniDiv(getElement(divId));
        //document.getElementById('divContainer').style.display='none';     
           
             
    } 
     
  function openURL(URLstr)
  {
    window.open(URLstr );
  }
  function exportURLlist(URLstr)
  {
    document.getElementById("<%=ifExportURLs.clientid %>").src= URLstr
  }

   function isAnyCheckboxSelected()
	{
		var blnChecked = false;
		var objfrm =<%=frmURLs.ClientId%>
		
		for(var i = 0; i < objfrm.elements.length;i++)
		{
		
			if(objfrm.elements[i].type == 'checkbox')
			{
			  if(objfrm.elements[i].checked == true)
			  	{
					blnChecked = true;
					break;
				}
				
			}	
		}

		if(blnChecked == true)
			return true;
		else
		{
		    alert("Please select one checkbox at least.");
		    return false;
		 }
		    
		    
	}

  function isReadyDelete()
  {
  
    var blnChecked = false;
    blnChecked = isAnyCheckboxSelected();
    
        if (blnChecked==true) 
        
        {
            return confirm("Are you sure you want to delete selected URL(s)?");
        }   
        else
        {
            return false;
        }   
  }
  
 

	function ShowAniDiv(objDiv)
	{
	    popup = objDiv;	
		try
		{
		    if(popup.filters != null)
			    popup.filters[0].apply();
		}
		catch (e){}		    

		popup.style.display = "block";
		popup.style.visibility = "visible"
		
		try 
		{
		    if(popup.filters != null)
			    popup.filters[0].play();
		}
		catch (e){}

	}
	
	function hideAniDiv(objDiv)
	{
	
		popup = objDiv;	
		{
		    
		try
		{    
	    if (overlay!=null)
	        overlay.visibility = 'hidden';

			if(popup.filters != null)
			{
				popup.filters[0].apply();
				popup.style.visibility = "hidden";	
				popup.filters[0].play();
			}	
		}
		catch (e){}	
		
			popup.style.visibility = "hidden";	
		}
	}        
	function URLMPrint()
    {
        var search; 
        var account;
        var registrar;
        var expiry;
        var catagory;
        var strURL;
        
        search = document.getElementById('<%=hdnSearch.ClientID%>').value;
        account = document.getElementById('<%= ddlAccount.ClientID %>').value;
        registrar = document.getElementById('<%= ddlRegistrar.ClientID %>').value;
        expiry = document.getElementById('<%= ddlExpiry.ClientID %>').value;
        catagory = document.getElementById('<%= ddlCategory.ClientID %>').value;
        
        
        strURL = "ViewReport/default.aspx?ReportType=1&Exp="+expiry+"&RegistrarId="+registrar+"&AccountId="+account+"&CategoryId="+catagory+"&SearchBy="+search;  
        
        window.open(strURL);
        return false;
    } 
</script>
</body>
</html>