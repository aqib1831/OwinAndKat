<%@ Page Language="VB" ValidateRequest="false" AutoEventWireup="false" CodeFile="URLmHome.aspx.vb" Inherits="EA_URLM_Default" Theme="Default"  %>
<%@ Register Src="~/controls/CtrlAlertdiv.ascx" TagName="CtrlAlertdiv" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"    Namespace="System.Web.UI" TagPrefix="asp" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>URL Managment</title>       
        <script language="JavaScript" src="../scripts/disable_cr.js" type="text/javascript"></script>
        <script language="JavaScript" src="../scripts/calendar.js" type="text/javascript"></script>
        <script language="JavaScript" src="../scripts/functions.js" type="text/javascript"></script>
        <script language="JavaScript" src="../scripts/calendar-en.js" type="text/javascript"></script>   
        <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>        
        <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="../scripts/jquery.js"></script>
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
                     <asp:Image ID="Image2" runat="server" ImageUrl="../images/indicator.gif" ImageAlign="AbsMiddle" /> <span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
                   <br />
                 <br />
              </div>
            </ProgressTemplate>
        </asp:UpdateProgress>  
        <table width="100%" style="height:100%; margin:0px; padding:0px;background-color:#E4F1F7; " cellspacing="0" cellpadding = "0" border="0"  >
             <tr class="UnderlinedRow">
                 <td  style="height:20px;background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:5px;width:60%;">
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
                   <%-- <img align="absMiddle"  height="20" src="../images/pixel_skyBlue.jpg" width="1" alt="" /><img align="absMiddle"  height="20" src="../images/pixel_skyBlue.JPG" width="1" alt="" />
                     &nbsp;                   
                     <asp:LinkButton ID="imgUpdateAll" runat="server" CssClass="HomeButton">
                          <div style="width:110px;" class="LeadDetailButton">
                              Update Urls
                              <img  alt="" src="../images/blt_resetfilters.gif" align="absmiddle" width="10" height="10" style="border:0px;"/>
                          </div>
                     </asp:LinkButton> --%>
                 </td>              
                 <td style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right;cursor:pointer; height: 1px;  width:100px;">
                     <img align="absMiddle"  height="20" src="../images/pixel_skyBlue.jpg" width="1" alt="" /><img align="absMiddle"  height="20" src="../images/pixel_skyBlue.JPG" width="1" alt="" />
                     &nbsp;                   
                     <asp:LinkButton ID="btnPrint" runat="server" CssClass="HomeButton"  OnClientClick="return URLMPrint();" >
                           <div style="width:80px;" class="LeadDetailButton" >
                             Print 
                                <span class="spnImageContainer" style="vertical-align:middle;"><img  src="../images/blt_resetfilters.gif" width="10" height="10" style="border:0px;" /></span>
                           </div>
                     </asp:LinkButton> 
                 </td>                 
                 <td style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right;cursor:pointer; height: 1px;">
                    <img align="absMiddle"  height="20" src="../images/pixel_skyBlue.jpg" width="1" alt="" /><img align="absMiddle"  height="20" src="../images/pixel_skyBlue.JPG" width="1"  alt=""/>
                     &nbsp;                   
                     <asp:LinkButton ID="imgNewURL" OnClientClick="javascript:window.location='NewUrl.aspx'; return false;" runat="server" CssClass="HomeButton">
                                <div style="width:85px;" class="LeadDetailButton" >
                             Add URL
                                <span class="spnImageContainer" style="vertical-align:middle;"><img  alt="" src="../images/blt_resetfilters.gif" width="10" height="10" style="border:0px;"/></span>
                                </div>
                     </asp:LinkButton> 
                 </td>                  
                 <td style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right;cursor:pointer; height: 1px;width:150px; display:none;">
                    <img align="absMiddle"  height="20" src="../images/pixel_skyBlue.jpg" width="1" alt="" /><img align="absMiddle"  height="20" src="../images/pixel_skyBlue.JPG" width="1" alt="" />
                     &nbsp;                   
                     <asp:LinkButton ID="lnkResetfilters" runat="server" CssClass="HomeButton">
                            <div style="width:110px;" class="LeadDetailButton" onclick="javascript:resetfilters();">
                                Reset filters 
                            <span class="spnImageContainer" style="vertical-align:middle;"><img   alt="" src="../images/blt_resetfilters.gif"  width="10" height="10" style="border:0px;"/></span>
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
                                <td align="left" valign="middle" style="padding-top:2px; padding-left:3px; width:100px;">
                                        <span style="font-size: 7pt; color: #7c8798">Filters</span><br />      
                                        <asp:DropDownList ID="ddlExpiry" runat="server"
                                         style="width:120px;font-size:10px; height:20px; " 
                                         AutoPostBack="true" 
                                         EnableViewState="true">
                                             <asp:ListItem Text="Show All" Value="0"></asp:ListItem>
                                             <asp:ListItem Text="Coming expirations" Value="1"></asp:ListItem>
                                         </asp:DropDownList> 
                                </td>
                                <td style="width:10px;text-align:center;">
                                    <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" alt="" /> 
                                </td>                    
                                <td align="left" style="padding-top:2px;width:100px; ">  
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
                                <td style="width:10px;text-align:center;">
                                    <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" alt="" /> 
                                </td>                    
                                <td align="left" style="padding-top:2px; width:100px; ">  
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
                                <td style="width:10px;text-align:center;">
                                    <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" alt="" /> 
                                </td>                    
                                <td align="left" style="padding-top:2px;width:100px; ">  
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
                                    <img  src="../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" alt="" /> 
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
                                                 <td style="width:10px; " align="right" ><img alt="" src="../images/spacer.gif" width="15" height="1" align="absmiddle" /></td>                                    
                                                 <td style="width:1px; " align="center"><img alt="" src="../images/pixel_darkBlue.jpg" width="1" height="20" align="absmiddle" /></td>
                                                 <td style="width:10px;" align="right"><img alt="" src="../images/spacer.gif" width="15" height="1" align="absmiddle" /></td>
                                                 <td  align="right" valign="top"> <asp:Panel ID="pnlNumber" runat="server" HorizontalAlign="Right"  ></asp:Panel> </td>                                                                                                     
                                            </tr>
                                      </table>                                              
                                  </div>
                                </PagerTemplate>    
                                <Columns> 
                                <asp:TemplateField >
                                       <ItemStyle Width="2%" CssClass="NoSideBorder"  />
                                        <ItemTemplate  >
                                           <img src="../images/arrows.gif" alt="" id="imgarrow" />
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
                                <asp:BoundField DataField="Registrar" HeaderText="Registrar"  HtmlEncode="False" SortExpression="Registrar" >
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
                                </asp:BoundField>
                                <asp:BoundField DataField="Expiration_Date" HeaderText="Expiration" DataFormatString="{0:d}" HtmlEncode="False" SortExpression="Expiration_Date" >
                                    <ItemStyle  Font-Bold="true" Height="15px" Width="10%" CssClass="NoSideBorder" />
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <%--<asp:TemplateField>
                                     <ItemStyle CssClass="NoSideBorder" />
                                     <ItemTemplate>
                                        <img  alt="" src='<%# container.dataitem("Status")%>'  class="hLink_nodecoration" title='<%# IIf(container.dataitem("Status")="../Images/ico_tick.gif","Up","Down")%>' /> 
                                    </ItemTemplate>
                                </asp:TemplateField>                        --%>
                                <asp:ImageField DataImageURLField="Status" SortExpression="Status" Visible="false" >
                                    <ItemStyle CssClass="hLink_nodecoration NoSideBorder" Height="15px" Width="4%"  />
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:ImageField>
                                <asp:BoundField DataField="RemaingDays" SortExpression="nothing" ShowHeader="False" Visible="False" />                            
                                <asp:TemplateField HeaderText="">
                                <ItemStyle Height="15px" Width="40px" CssClass="NoSideBorder" />
                                     <ItemTemplate >                                       
                                       <a id="btnEdit"  onclick="javascript:window.location='NewUrl.aspx?URLID=<%# Container.DataItem("UrlID") %>'; return false;"  title="Edit URL" >Edit</a>
                                    </ItemTemplate>
                                </asp:TemplateField>                             
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
                                SelectMethod="GetAllURLs"
                                SelectCountMethod="GetTotalRecords" 
                                EnablePaging="true"
                                SortParameterName="sortExpression">        
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="ddlAccount" Name="AccountID" DefaultValue="0" Type="Int32" />
                                    <asp:ControlParameter ControlID="ddlCategory" Name="CategoryID" DefaultValue="0" Type="int32" />
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
        <div style="filter: revealtrans(duration=0.45,transition=12);position:absolute;left:20%; top:10%;WIDTH: 520px;"  id="divUpdateURLs" runat="server" visible="false">
             <table cellspacing="0" cellpadding="0" width="100%" bgColor="#f1f6fa" border="0">                      
         <tr>
            <td style="WIDTH:531px">
                 <table cellspacing="0" cellpadding="0" width="100%" border="0">                                             
                    <tr>  
                       <td align="left" style="border-bottom:solid 1px #000000; padding-left:1em; background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
                            <strong><asp:Label runat="server" Font-Size="14px" ID="Label1" Text="Add New URL" ForeColor="white"></asp:Label> </strong>
                       </td>
                       <td  style="border-bottom:solid 1px #000000;background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%; height:28px; cursor:pointer;" onclick="javascript:closeDiv('<%=divUpdateURLs.ClientID %>'); return false;">
                            <img  alt=""  src="../images/win_btn_close_Black.jpg" width="21" height="28" runat="server" id="img1" visible="true" border="0" />                    
                       </td>               
                    </tr>                 
               </table>
            </td>
        </tr>
         <tr>
            <td style="WIDTH: 531px" class="div_bg">
               <table style="height:100%;" cellspacing="0" cellpadding="0" width="100%" border="0">                    
                    <tr>
                        <td style="PADDING-BOTTOM: 10px; PADDING-TOP: 10px" align="left">
                            <table cellspacing="4" cellpadding="1" width="80%" align="center" border="0">                                    
                                    <tr>
                                        <td style="FONT-WEIGHT: bold; FONT-SIZE: 12px; COLOR: red" valign="top" width="25%" colspan="3">
                                            Please enter one URL in one line.</td></tr><tr><td style="COLOR: red" valign="top"></td>
                                        <td valign="top"></td><td style="WIDTH: 190px" valign="top">
                                             <asp:RequiredFieldValidator id="RequiredFieldValidator3" runat="server" ControlToValidate="txtURLs" ValidationGroup="UpdateURLs" ErrorMessage="Please enter at least one URL." Display="Dynamic"></asp:RequiredFieldValidator></td>
                                    </tr>
                                    <tr>
                                        <td style="COLOR:red;FONT-SIZE:10px;" valign="top">*</td><td valign="top" style="FONT-SIZE: 12px;">URLs. </td>
                                        <td style="WIDTH: 190px; font-size:10px;" valign="top"><asp:TextBox id="txtURLs" runat="server" Font-Size="12px" Width="400px" Columns="50"   TextMode="MultiLine" Rows="10"></asp:TextBox> </td>
                                    </tr>
                                
                            </table>
                            <asp:Label id="Label3" runat="server" Font-Size="12px" Text=" &nbsp;Required *" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="PADDING-RIGHT: 5px; HEIGHT: 30px" class="divBg_footer" valign="middle" align="right">
                            &nbsp; <asp:Button id="btnUpdateAll" runat="server" Text="Update All" CausesValidation="true" CssClass="button_normal" ValidationGroup="UpdateURLs"></asp:Button>
                            &nbsp;
                        </td>
                    </tr>
               </table>
             </td>
         </tr>                        
       </table>
     </div>
    <iframe id="ifExportURLs" src="blank.aspx" width="0px" height="0px" runat="server"></iframe>
    <!--Div to show the updated status -->
       <div style="filter: revealtrans(duration=0.45,transition=12);position:absolute;left:20%; top:15%;height: 210px;WIDTH: 400px;"  id="divUpdatedStatus" runat="server">
        <table cellspacing="0" cellpadding="0"  style="width:100%; background-color:#f1f6fa;" border="0">                
             <tr>
                    <td style="height:30px;">
                     <table cellspacing="0" cellpadding="0" width="100%" border="0">                                   
                       <tr>  
                           <td align="left" style="border-bottom:solid 1px #000000; padding-left:1em; background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
                            <strong><asp:Label runat="server" Font-Size="14px" ID="lblUpdatedDivStatus" Text="Updated Status " ForeColor="white"></asp:Label> </strong>
                          </td>
                           <td  style="border-bottom:solid 1px #000000;background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%; height:28px; cursor:pointer;" onclick="javascript:closeDiv('<%=divUpdatedStatus.ClientID %>'); return false;">
                           <img  alt=""  src="../images/win_btn_close_Black.jpg" width="21" height="28" runat="server" id="img2" visible="true" border="0" />                    
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
       <div style="filter: revealtrans(duration=0.45,transition=12);position:absolute;left:20%; top:15%;height: 210px;WIDTH: 350px;" id="divNewURL" runat="server" visible="True">
            <table cellspacing="0" cellpadding="0" style="width:100%; background-color:#f1f6fa;" border="0">          
            <tr>
               <td>
                 <table cellspacing="0" cellpadding="0" width="100%" border="0">
                         <tr>  
                           <td align="left" style="border-bottom:solid 1px #000000; padding-left:1em; background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
                            <strong>
                                <asp:Label runat="server" Font-Size="14px" ID="lblHeadertext" Text="Add New URL" ForeColor="white"></asp:Label> 
                            </strong>
                          </td>
                           <td  style="border-bottom:solid 1px #000000;background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%; height:28px; cursor:pointer;" onclick="javascript:closeDiv('<%=divNewURL.ClientID %>'); return false;">
                                <img  alt=""  src="../images/win_btn_close_Black.jpg" width="21" height="28" runat="server" id="imgClose" visible="true" border="0" />                    
                           </td>               
                        </tr>   
                </table>
              </td>
            </tr>
            <tr>
                <td class="div_bg">
                        <table  style="height:100%;" cellspacing="0" cellpadding="0" width="100%" border="0">                                    
                            <tr>
                              <td style="PADDING-BOTTOM: 10px; PADDING-TOP: 10px;PADDING-LEFT: 35px" align="left">
                                <table cellspacing="4" cellpadding="1" width="100%" align="center" border="0">
                                       <tr>                                                                
                                            <td valign="top" width="25%" class="SimpleLabel">URL:<span class="ErrorMessage">*</span> </td>
                                            <td style="WIDTH: 75%;" valign="top">
                                                <asp:TextBox style="FONT-SIZE: 10px; WIDTH: 135px; HEIGHT: 15px" MaxLength="150" id="txtURL" runat="server" Width="150"></asp:TextBox> 
                                                <asp:RequiredFieldValidator id="RequiredFieldValidator2" CssClass="ErrorMessage" runat="server" ControlToValidate="txtURL" ValidationGroup="NewURL" ErrorMessage="Enter URL." Display="Dynamic">
                                                 </asp:RequiredFieldValidator>
                                                 <asp:RegularExpressionValidator ID="regUrl" runat="server" ValidationGroup="NewURL" CssClass="ErrorMessage" ControlToValidate="txtURL" Display="Dynamic" ErrorMessage="Enter valid URL." ValidationExpression="([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?"></asp:RegularExpressionValidator>
                                            </td>
                                       </tr>
                                       <tr>                                                                
                                            <td valign="top" class="SimpleLabel">Registrar:<span class="ErrorMessage">*</span></td>
                                            <td  valign="top">
                                                <asp:DropDownList style="FONT-SIZE: 10px; WIDTH: 135px; HEIGHT: 20px" id="ddlRegistrar1" runat="server" DataValueField="ID" DataTextField="DataText" DataSourceID="srcRegistrar" Width="150"></asp:DropDownList> 
                                                <asp:CompareValidator id="CompareValidator4" runat="server"  CssClass="ErrorMessage" ControlToValidate="ddlRegistrar1" ValidationGroup="NewURL" ErrorMessage="Select Registrar" Display="Dynamic" ValueToCompare="0" Operator="NotEqual"></asp:CompareValidator>
                                            </td>
                                       </tr>
                                       <tr>                                                              
                                             <td valign="top" class="SimpleLabel">Category:<span class="ErrorMessage">*</span></td>
                                             <td  valign="top">
                                                <asp:DropDownList style="FONT-SIZE: 10px; WIDTH: 135px; HEIGHT: 20px"
                                                     id="ddlCategory1" 
                                                     runat="server" 
                                                     DataValueField="ID" 
                                                     DataTextField="DataText" 
                                                     DataSourceID="srcCategory" 
                                                     Width="150">
                                                </asp:DropDownList>
                                                <asp:CompareValidator id="CompareValidator3" 
                                                     runat="server" 
                                                     ControlToValidate="ddlCategory1" 
                                                     ValidationGroup="NewURL" 
                                                     CssClass="ErrorMessage"
                                                     ErrorMessage="Select Category" 
                                                     Display="Dynamic" 
                                                     ValueToCompare="0" 
                                                     Operator="NotEqual">
                                                </asp:CompareValidator>
                                           </td>
                                       </tr>
                                       <tr>                                                               
                                            <td valign="top" class="SimpleLabel">Account:<span class="ErrorMessage">*</span> </td>
                                            <td  valign="top">
                                                <asp:DropDownList style="FONT-SIZE: 10px; WIDTH: 135px; HEIGHT: 20px"
                                                     id="ddlAccount1" 
                                                     runat="server" 
                                                     DataValueField="ID" 
                                                     DataTextField="DataText" 
                                                     DataSourceID="srcAccounts" 
                                                     EnableViewState="true" 
                                                     Width="150">
                                               </asp:DropDownList> 
                                               <asp:CompareValidator id="CompareValidator2" 
                                                      runat="server" 
                                                      ControlToValidate="ddlAccount1" 
                                                      CssClass="ErrorMessage"
                                                      ValidationGroup="NewURL" 
                                                      ErrorMessage="Select Account" 
                                                      Display="Dynamic" 
                                                      ValueToCompare="0" 
                                                      Operator="NotEqual">
                                              </asp:CompareValidator>
                                         </td>
                                      </tr>
                                       <tr>                                                               
                                            <td valign="top" class="SimpleLabel">Exp. Date:<span class="ErrorMessage">*</span> </td>
                                            <td valign="top">
                                                <asp:TextBox style="FONT-SIZE: 10px; WIDTH: 108px; HEIGHT: 15px" id="txtExpirydate" runat="server" Width="106"></asp:TextBox> <img style="CURSOR:pointer" onclick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtExpirydate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');" height="20" src="../images/ico_calendar.jpg" width="24" align=absMiddle alt="" />&nbsp; 
                                                <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" ControlToValidate="txtExpirydate" CssClass="ErrorMessage" ValidationGroup="NewURL" ErrorMessage="Enter Date" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator> 
                                                <asp:CompareValidator ID="CompareValidator1"  CssClass="ErrorMessage" runat="server" ControlToValidate="txtExpirydate"   Display="Dynamic" ErrorMessage="Enter valid Date" Operator="DataTypeCheck"  Type="Date" ValidationGroup="NewURL"></asp:CompareValidator>
                                            </td>
                                       </tr>
                                       <tr>                                                            
                                        <td valign="top" class="SimpleLabel">WhoisServer: </td>
                                        <td  valign="top">
                                            <asp:TextBox style="FONT-SIZE: 10px; WIDTH: 135px; HEIGHT: 15px" id="txtWhoisServer" runat="server" Width="150" MaxLength="16"></asp:TextBox>
                                        </td>
                                       </tr>
                                       <tr>                                                               
                                            <td valign="top" class="SimpleLabel">NameServer1: </td>
                                            <td  valign="top">
                                                <asp:TextBox style="FONT-SIZE: 10px; WIDTH: 135px; HEIGHT: 15px" MaxLength="70" id="txtnameServer1" runat="server" Width="150"></asp:TextBox> 
                                            </td>
                                       </tr>
                                       <tr>
                                           <td valign="top" class="SimpleLabel">NameServer2: </td>
                                            <td class="SimpleLabel" valign="top">
                                                <asp:TextBox style="WIDTH: 135px; HEIGHT: 15px" id="txtNameServer2" runat="server" Width="150" MaxLength="70"></asp:TextBox> 
                                            </td>
                                       </tr>
                                     <tr>                                                            
                                        <td valign="top" class="SimpleLabel">Referral URL: </td>
                                        <td  valign="top">
                                            <asp:TextBox style="FONT-SIZE: 10px; WIDTH: 135px; HEIGHT: 15px" id="txtreferralURL" runat="server" MaxLength="70" Width="70"></asp:TextBox> 
                                        </td>
                                     </tr>
                                     <tr>
                                        <td style="COLOR:red;" align="center" class="SimpleLabel" colspan="2" valign="top">Fields with * are required</td>
                                     </tr>                                            
                             </table>                                       
                              </td>
                            </tr>
                         <tr>
                            <td style="PADDING-RIGHT: 5px" class="divBg_footer" valign="middle" align="right" height="30px">&nbsp; 
                                <asp:Button id="btnSave" runat="server" Text="Add" CssClass="button_normal" ValidationGroup="NewURL" CausesValidation="false"></asp:Button>
                             </td>
                         </tr>                             
                    </table>
                </td>
            </tr>
        </table>
    </div>
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
  
  function checkvalidation(isUpdatingURLs)
  {
            if(Page_IsValid)
            {
                if (isUpdatingURLs==true)
                    closeDivURL(<%=divUpdateURLs.ClientId%>.id);
                else
                    closeDivURL(<%=divNewURL.ClientId%>.id);
                    
             try  
             { 
                document.getElementById('<%=ddlAccount1.ClientID%>').style.visibility="hidden";  
                document.getElementById('<%=ddlCategory1.ClientID%>').style.visibility="hidden";  
                document.getElementById('<%=ddlRegistrar1.ClientID%>').style.visibility="hidden";  
              }  
             catch(e) {}

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