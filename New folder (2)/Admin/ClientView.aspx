<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ClientView.aspx.vb" Inherits="Admin_ManageClients" Theme="Default"  %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Namespace="Telerik.WebControls" TagPrefix="radI" Assembly="RadInput.NET2"%>
<%@ Register TagPrefix="radcb" Namespace="Telerik.WebControls" Assembly="RadComboBox.NET2" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <link href="../RadControls/Combobox/Skins/White/Styles.css" rel="stylesheet" type="text/css" />
    <link href="../RadControls/Combobox/Skins/WhiteMandatory/Styles.css" rel="stylesheet" type="text/css" />
    <link href="../RadControls/Input/Skins/White/styles.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <style type="text/css">
    .GrayTextBackGround
    {        
        font-size:11px;
        color:#686667; 
        border-bottom:1px solid #CEE1EF;
        border-right:1px solid #CEE1EF;
        background-color:#EDE9E8;
        padding-left:10px;
    }
    .BlackTextWhiteBackGround
    {        
        font-size:11px;
        color:black; 
        border-bottom:1px solid #CEE1EF;
        border-right:1px solid #CEE1EF;
        background-color:white;
        padding-left:10px;
        font-weight:bold;
    }
    .BlackTextGrayBackGroundGradient
    {        
        font-size:11px;
        color:black; 
        border-bottom:1px solid #5F9DCE;
        cursor:pointer;
        filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#FEFEFE,endColorStr=#E3E3E3);
    }
    .GrayInfoForInput
    {
        background-color:#EDE9E8;
        font-size:11px;
        border-bottom:1px solid #A2CBE9;
        border-right:1px solid #A2CBE9;
        color:#686667;
        padding-left:5px;
        height:20px;
        white-space:nowrap;
    }
    .ContactInfoTextBoxClass
    {
        height:16px;
        border:solid 1px #A2CBE9;
    }
    .GrayTextWithoutBG
    {   
        font-size:11px;
        color:#686667;
    }
    </style> 
</head>
<body style="height:100%;width:100%;margin:0px;">
    <form id="form1" runat="server">
    <div >
          <asp:ValidationSummary
                style="position:absolute;z-Index:1000;padding-bottom:25px;"
                ID="ValidationSummary1" 
                runat="server"
                Font-Bold="true"  
                Font-Size="11px"
                ForeColor="black" 
                EnableClientScript="true"
                ShowMessageBox="false"
                ValidationGroup="vgContact"
                DisplayMode="BulletList" 
                HeaderText="<table width='100%' cellpadding='4' cellspacing='0' border='0' ><tr><td style='text-align:left;padding-left:10px;' class='ErrorMessageWindowTitle3D'>Alert</td><td style='text-align:right;padding-right:5px;' class='ErrorMessageWindowTitle3D' align='right'><img src='../images/btn_close.gif' alt='Close' style='cursor:hand;' onclick='CloseValidationSummaryDiv();'></td></tr></table><br>&nbsp;&nbsp;&nbsp;<img src='../images/ico_alert.gif' style='vertical-align:text-bottom;'><input type='button' value='Close' style='position:absolute; left:45%; bottom:10; height:22px; width:50px;' align='absmiddle' class='Btn3D' onclick='CloseValidationSummaryDiv();'/>&nbsp;&nbsp;Please fix the following problem(s) to proceed !"
                CssClass="SummaryValidationDiv3D" 
                 />
            <asp:ValidationSummary
                style="position:absolute;z-Index:1000;padding-bottom:25px;"
                ID="ValidationSummary2" 
                runat="server"
                Font-Bold="true"  
                Font-Size="11px"
                ForeColor="black" 
                EnableClientScript="true"
                ShowMessageBox="false"
                ValidationGroup="vgClient"
                DisplayMode="BulletList" 
                HeaderText="<table width='100%' cellpadding='4' cellspacing='0' border='0' ><tr><td style='text-align:left;padding-left:10px;' class='ErrorMessageWindowTitle3D'>Alert</td><td style='text-align:right;padding-right:5px;' class='ErrorMessageWindowTitle3D' align='right'><img src='../images/btn_close.gif' alt='Close' style='cursor:hand;' onclick='CloseValidationSummaryDiv();'></td></tr></table><br>&nbsp;&nbsp;&nbsp;<img src='../images/ico_alert.gif' style='vertical-align:text-bottom;'><input type='button' value='Close' style='position:absolute; left:45%; bottom:10; height:22px; width:50px;' align='absmiddle' class='Btn3D' onclick='CloseValidationSummaryDiv();'/>&nbsp;&nbsp;Please fix the following problem(s) to proceed !"
                CssClass="SummaryValidationDiv3D" 
                 />     
      </div>
      <div id="AlertDiv" class="SummaryValidationDiv3D" style="display:none;position:absolute;z-Index:1000;">
        <table width='100%' cellpadding='0' cellspacing='0' border='0' style="font-size:11px;font-weight:bold;text-align:center;" >
            <tr>
                <td style='text-align:left;padding-left:10px;border-bottom:0px;' class='ErrorMessageWindowTitle3D'>Alert</td>
                <td style='text-align:right;padding-right:5px;border-bottom:0px;' class='ErrorMessageWindowTitle3D' align='right'>
                    <img src='../images/btn_close.gif' alt='Close' style='cursor:hand;' onclick="document.getElementById('AlertDiv').style.display='none';Reset();">
                </td>
            </tr>
            <tr>
                <td colspan="2" align="left" style="padding-left:10px;white-space:nowrap;padding-right:10px;">
                    <br>
                    <img src='../images/ico_alert.gif' style='vertical-align:text-bottom;'>
                    &nbsp;&nbsp;Please fix the following problem(s) to proceed !    
                </td>
            </tr>
            <tr>
                <td colspan="2" align="left" style="padding-left:10px;padding-right:10px;">
                    <br>
                    <label ID="lblAlertMessage"></label>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:center;padding-bottom:10px;" >
                    <input type='button' value='Close' style='height:22px;width:50px;' align='absmiddle' class='Btn3D' onclick="document.getElementById('AlertDiv').style.display='none';Reset();"/>
                </td>
            </tr>
         </table>   
      </div>
    <iframe id="divDisable" marginheight="0" marginwidth="0" scrolling="no" frameborder="0" style="z-index:09;width:0;height:0; background-color:black;position:absolute;filter:progid:DXImageTransform.Microsoft.alpha(opacity=50);opacity:0.5;" src="../blankPage.htm" ></iframe>
    <div>
    <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="300"  />
    <asp:UpdateProgress ID="Progress1" runat="server">
            <ProgressTemplate>
                <div class="ProgressIndicatorDIV">
                    <br />
                    <asp:Image ID="Image2" runat="server" ImageUrl="../images/indicator.gif" ImageAlign="AbsMiddle" /> <span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
                    <br /><br />
                </div>
            </ProgressTemplate>
    </asp:UpdateProgress>
    <table border="0" cellpadding="0" cellspacing="0"  style="height:100%;width:100%;background-color:#D9EAFC;border:1px solid #79A1D4;" >
        <tr style="height:31px;background-color:#A0CDEE;display:none;">
            <td style="border-bottom:1px solid #79A1D4;">
                 <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Always">
                    <ContentTemplate >
                        <asp:Label ID="lblTitle" runat="server" Text="Edible Arrangements" style="font-size:12px;font-weight:bold;color:Black; padding-left:5px;"></asp:Label>
                        <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
                        <asp:HiddenField ID="hdnClientContactID" runat="server" Value="0" />
                        <asp:HiddenField ID="hdnClientImagePath" runat="server" Value="" />
                    </ContentTemplate>
                </asp:UpdatePanel>
                <span style="display:none;">
                <radi:radtextbox 
                        Width="100%"
                        ID="RadTextBox2" 
                        runat="server" 
                        TextMode="SingleLine" 
                        EmptyMessage="Client Code"
                        EnableTheming="true"
                        Skin="White">
                </radi:radtextbox>
                <radcb:radcombobox 
                    ID="RadComboBox2" 
                    Runat="server" 
                    Height="16px" 
                    Width="100%" 
                    Skin="White" 
                    NoWrap="true"
                    AllowCustomText="False"
                    MarkFirstMatch="True">
                </radcb:radcombobox>
                </span>
            </td>
            <td style="border-bottom:1px solid #79A1D4;">&nbsp;</td>
        </tr>
        <tr style="padding:5px;">
            <td style="height:100%;width:43%;">
                <asp:UpdatePanel ID="UpdatePanel5" runat="server" UpdateMode="Conditional" RenderMode="inline">
                   <ContentTemplate>
                    <table id="tblClientContactView" runat="server" visible="true" border="0" cellpadding="0" cellspacing="0"  style="height:100%;width:100%;">
                      <tr>
                        <td style="height:50%;width:100%;">
                          <div style="border:solid 1px #5E9DC6;width:100%;height:100%;">
                              <table style="height:100%;width:100%;text-align:left;" cellpadding="0" border="0" cellspacing="0"   >
                                   <tr style="height:18px; background-image:url(../images/gb_hdr_black.jpg);background-repeat:repeat-x;">    
                                      <td style="border-bottom:solid 1px #000000;"><asp:Label ID="lblClientViewTitle" runat="server" Text="Edible Arrangements" style="color:White;font-size:11px;font-weight:bold;padding-left:5px;vertical-align:middle;" /></td>
                                      <td  style="border-bottom:solid 1px #000000;"><asp:ImageButton ID="btnClientEdit" runat="server" ImageUrl="../images/btn_edit.jpg" CausesValidation="false" ToolTip="Edit Client" style="float:right;" /></td>               
                                   </tr>
                                   <tr>                
                                     <td colspan="2" style="height:100%;font-size:12px; background-color:White;" >
                                            <table id="tblClientNoRecord" runat="server" visible="false" border="0" cellpadding="0" cellspacing="0" style="height:100;width:100%;text-align:center;font-size:11px;font-weight:bold;">
                                                <tr><td style="height:45%;">&nbsp;</td></tr>
                                                <tr><td style="height:10%;">Please Press New Button to Enter Client Info.</td></tr>
                                                <tr><td style="height:45%;">&nbsp;</td></tr>
                                            </table>
                                            <table id="tblClientView" runat="server" border="0" cellpadding="0" cellspacing="0" style="height:100;width:100%;padding:3px;">
                                                <tr>
                                                    <td style="height:0;width:50%;"></td>
                                                    <td style="height:0;width:50%;"></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" style="text-align:center;"><asp:Image ID="imgClientLogo" runat="server" ImageUrl="~/images/spacer.gif" Height="92" Width="120" /></td>
                                                    
                                                </tr>
                                                <tr>
                                                    <td class="BlackTextWhiteBackGround" style="background-image:url(../images/bg_hdrLftPnl.jpg);background-repeat:repeat-x;height:35px;padding:5px;padding-left:10px;border-bottom:solid 0px black;" colspan="2">
                                                        <asp:Label ID="lblClientGeneralInformation" runat="server" Text="" ></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayTextBackGround">Code:</td>
                                                    <td class="BlackTextWhiteBackGround"><asp:Label ID="lblClientCode" runat="server" ></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayTextBackGround">Bill Send Option:</td>
                                                    <td class="BlackTextWhiteBackGround"><asp:Label ID="lblClientBillSendOption" runat="server" ></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayTextBackGround">Payment Mode:</td>
                                                    <td class="BlackTextWhiteBackGround"><asp:Label ID="lblClientPrefPaymentMode" runat="server" ></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayTextBackGround">URL:</td>
                                                    <td class="BlackTextWhiteBackGround"><asp:Label ID="lblClientURL" runat="server" ></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayTextBackGround">Corporate Email:</td>
                                                    <td class="BlackTextWhiteBackGround"><asp:Label ID="lblClientCorporateEmail" runat="server" ></asp:Label></td>
                                                </tr>
                                            </table>
                                     </td>
                                   </tr>            
                              </table>
                            </div>
                        </td>
                      </tr>
                      <tr>
                        <td style="height:50%;width:100%;padding-top:5px; ">
                           <div style="border:solid 1px #5E9DC6;width:100%;height:100%;">
                              <table style="height:100%;width:100%;text-align:left;" cellpadding="0" border="0" cellspacing="0"   >
                                   <tr style="height:18px; background-image:url(../images/gb_hdr_black.jpg);background-repeat:repeat-x;">    
                                      <td style="border-bottom:solid 1px #000000;">&nbsp;<img src="../images/icn_contact.jpg" alt="Contact Information" />&nbsp;<asp:Label ID="Label1" runat="server" Text="Contact Information" style="color:White;font-size:11px;font-weight:bold;vertical-align:middle;" /></td>
                                      <td  style="border-bottom:solid 1px #000000;"><asp:ImageButton ID="btnContactNew" runat="server" ImageUrl="../images/btn_newBlue.gif" CausesValidation="false" ToolTip="Edit Contact Info" style="float:right;" OnClientClick="return CheckClientID();"  /></td>
                                   </tr>
                                   <tr>                
                                     <td colspan="2" style="height:100%;font-size:12px;background-color:White;">
                                            <div  id="tblContactView" runat="server"  visible="true" style="overflow-y:auto;height:100%;width:100%;">
                                            <table border="0" cellpadding="0" cellspacing="0" style="height:100%;width:100%;" >                                                                                                                                                      
                                                <tr >
                                                    <td style="height:100%;width:100%;text-align:center;vertical-align:top;">                                                                                                
                                                        <asp:Repeater
                                                            runat="server"
                                                            ID="rptrContactInfo"
                                                            DataSourceID="sdsContactInfo" EnableViewState="true">
                                                            <HeaderTemplate>
                                                                <table id="tblContactInfo" border="0" cellpadding="0" cellspacing="0" style="height:100%;width:100%;font-size:11px;">                                       
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                    <tr onclick="OnClickTrContactInfo(this);">
                                                                        <td class="BlackTextGrayBackGroundGradient" style="width:10px;padding-left:5px;" onclick="varTrContactInfo=true;"><img src="../images/SinglePlus.gif" alt=""/></td>
                                                                        <td class="BlackTextGrayBackGroundGradient" style="height:25px;font-weight:bold;width:55%;" title='<%#Container.DataItem("FullName")%>'>
                                                                             <asp:Label ID="lblContactName" runat="server" Text='<%# Functions.StringTruncate(Functions.IfNull(Container.DataItem("FullName"),""),20)%>' onclick="varTrContactInfo=true;" ></asp:Label>
                                                                             <asp:Label ID="lblContactID" runat="server" Visible="false" Text='<%# Container.DataItem("ID") %>' ></asp:Label>
                                                                             <asp:LinkButton runat="server" ID="lnkContactID" CommandArgument='<%#Container.DataItem("ID") %>'  CommandName="Edit" Text="" ></asp:LinkButton>
                                                                         </td>
                                                                         <td class="BlackTextGrayBackGroundGradient" style="padding-right:5px;width:45%;white-space:nowrap;" align="right">&nbsp;
                                                                            <asp:Label ID="lblJobTitle" runat="server" Text='<%# Functions.StringTruncate(Functions.IfNull(Container.DataItem("JobTitle"),""),15)%>' ToolTip='<%# Functions.IfNull(Container.DataItem("JobTitle"),"")%>' onclick="varTrContactInfo=true;"></asp:Label>&nbsp;|&nbsp; 
                                                                            <asp:ImageButton ID="btnEditContact" runat="server" ImageUrl="../images/icn_edit_r1_c1.gif" CommandArgument='<%#Container.DataItem("ID") %>' CommandName="Edit" ToolTip="Edit this Contact" OnClientClick="varTrContactInfo=false;" />&nbsp;
                                                                            <asp:ImageButton ID="btnDelContact" runat="server" ImageUrl="../images/icn_delete.gif" CommandArgument='<%#Container.DataItem("ID") %>' CommandName="Delete" ToolTip="Delete this Contact" OnClientClick="varTrContactInfo=false; return confirm('Do you want to Delete this Contact ?')" />
                                                                         </td>
                                                                    </tr>
                                                                    <tr style="display:none;height:100px;">
                                                                        <td colspan="3" style="border:inset 1px #8A8A8A;border-top:0px;border-left:0px;width:100%;">
                                                                            <table border="0" cellpadding="0"  cellspacing="0" style="width:100%;font-size:11px;">
                                                                                <tr>
                                                                                    <td style="height:10;width:60%;">&nbsp;</td>
                                                                                    <td style="width:40%;"></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="padding-left:10px;padding-right:5px;" rowspan="2" valign="top" ><%#Functions.IfNull(Container.DataItem("Address"), "") & ",<br />" & Container.DataItem("City") & ", " & Container.DataItem("StateCode") & " " & Container.DataItem("Zip")%></td>
                                                                                    <td ><b>Home: </b><%#Functions.IfNull(Container.DataItem("HomePhone"), "")%></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td ><b>Work: </b><%#Functions.IfNull(Container.DataItem("WorkPhone"), "")%></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="padding-left:10px;padding-right:5px;white-space:nowrap;"><b>Email-1: </b><%#Functions.IfNull(Container.DataItem("Email1"), "")%></td>
                                                                                    <td ><b>Cell: </b><%#Functions.IfNull(Container.DataItem("CellPhone"), "")%></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="padding-left:10px;padding-right:5px;"><b>Email-2: </b><%#Functions.IfNull(Container.DataItem("Email2"), "")%></td>
                                                                                    <td ><b>Fax: </b><%#Functions.IfNull(Container.DataItem("Fax"), "")%></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="2" style="height:10;">&nbsp;</td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>                                                                                                                                     
                                                                    </tr>
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                   <tr>
                                                                        <td colspan="3" style="height:1%;width:100%;visibility:hidden;">&nbsp;</td>
                                                                    </tr>
                                                                    <tr id="trContacts_NoRecord" runat="server" style="height:100%;" visible="false">
                                                                        <td colspan="3" style="text-align:center;font-size:11px;font-weight:bold;">
                                                                           Please Press New Button to Enter Client Contact Info.
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="3" style="height:100%;width:100%;visibility:hidden;">&nbsp;</td>
                                                                    </tr>
                                                                </table
                                                            </FooterTemplate>
                                                        </asp:Repeater>
                                                        <asp:SqlDataSource 
                                                            ID="sdsContactInfo" 
                                                            runat="server" 
                                                            ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>" 
                                                            SelectCommand="Client_Contacts_GetByClientID" 
                                                            SelectCommandType="StoredProcedure">
                                                            <SelectParameters>
                                                                <asp:ControlParameter Name="ClientID" ControlID="hdnClientID" Type="Int32" PropertyName="Value" DefaultValue="0" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                        </td>
                                                    </tr>                                                                                                                                              
                                            </table>
                                            </div>
                                     </td>
                                   </tr>            
                              </table>
                            </div>
                        </td>
                      </tr>
                    </table>
                  <div id="tblClientEdit" runat="server" visible="false" style="border:solid 1px #5E9DC6;width:100%;height:100%;">
                      <table style="height:100%;width:100%;text-align:left;" cellpadding="0" border="0" cellspacing="0"   >
                           <tr style="height:18px; background-image:url(../images/gb_hdr_black.jpg);background-repeat:repeat-x;">    
                              <td style="border-bottom:solid 1px #000000;"><asp:Label ID="lblClientEditTitle" runat="server" Text="Edible Arrangements" style="color:White;font-size:11px;font-weight:bold;padding-left:5px;vertical-align:middle;" /></td>
                              <td  style="border-bottom:solid 1px #000000;text-align:right;padding-right:5px;">
                                <asp:ImageButton ID="btnClientSave" runat="server" ImageUrl="../images/btn_SaveBlue.jpg" CausesValidation="true" ToolTip="Update" OnClientClick="btnClientSaveOnclick();" ValidationGroup="vgClient" />
                                <asp:ImageButton ID="btnClientCancle" runat="server" ImageUrl="../images/btn_cancel.gif" CausesValidation="false" ToolTip="Cancle" />
                              </td>               
                           </tr>
                           <tr>                
                             <td colspan="2" style="height:100%;font-size:12px;">
                                    <table border="0" cellpadding="0" cellspacing="0" style="height:100%;width:100%;padding:0px;background-color:White;">
                                        <tr>
                                            <td colspan="2" style="height:40%; ">
                                                <table border="0" cellpadding="0" cellspacing="0" style="height:100%;width:100%; font-size:11px;" >
                                                    <tr>
                                                        <td style="height:12px;"><span style="padding-left:10px;" class="GrayTextWithoutBG">Client Logo:</span></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding-left:10px;padding-right:10px;height:50px;">
                                                            <iframe id="LogoUploadFrame"  name="LogoUploadFrame" 
                                                                src='UploadImage.aspx'
                                                                frameborder="0" width="100%" height="50" >
                                                            </iframe>
                                                        </td>
                                                    </tr>
                                                    <tr >
                                                        <td style="padding-left:10px;padding-right:10px;height:100px;">
                                                            <div id="ODiv" style="_height:100%;border:solid 2px #629BC8;vertical-align:middle;text-align:center;display:inline-block;filter:progid:DXImageTransform.Microsoft.Fade(duration=2);">
                                                                <asp:Image ID="imgClientEditLogo" runat="server" ImageUrl="../images/spacer.gif" Height="92" Width="120" />
                                                               
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height:10px;padding-left:7px;">
                                                            <asp:CheckBox ID="chkShowLogoNetWeb" runat="server"  text="Show logo on Netsolace website" CssClass="GrayTextWithoutBG" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="background-image:url(../images/bg_lftPnl_1.gif);background-repeat:repeat-x;height:18px;padding-left:10px;font-size:12px;font-weight:bold;vertical-align:middle;border-bottom:solid 1px #5C9CCC;">
                                                <span>General Information</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="height:100%;width:100%;">
                                            <div style="overflow-y:auto;height:100%;width:100%;">
                                            <table border="0" cellpadding="0" cellspacing="0" style="height:100%;width:100%;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#FAFEFF,endColorStr=#A5D7FF);" ><%--FAFEFF-A5D7FF--%>
                                                <tr>
                                                    <td style="height:0;width:40%;"></td>
                                                    <td style="height:0;width:60%;"></td>
                                                </tr>
                                                <tr >
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#FBFBFB,endColorStr=#F9F9F9);">Client Code:</td>
                                                    <td style="padding-right:10px;padding-left:5px;"><%--<asp:TextBox ID="txtClientCode" runat="server" Width="100%" Visible="false" CssClass="ContactInfoTextBoxClass"></asp:TextBox>--%>
                                                         <radi:RadTextBox ID="txtClientCode" runat="server"  EmptyMessage="Client Code Is Required." Width="100%" Height="16px" Skin="White" style="border-right:solid 3px red;" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#F9F9F9,endColorStr=#F8F8F8);">Client Name:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <radi:RadTextBox ID="txtClientName" runat="server"  EmptyMessage="Client Name Is Required." Width="100%" Height="16px" Skin="White" style="border-right:solid 3px red;"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#F8F8F8,endColorStr=#F6F6F6);">Address Line 1:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <radi:RadTextBox ID="txtAddress1" runat="server"  EmptyMessage="Address Is Required." Width="100%" Height="16px" Skin="White" style="border-right:solid 3px red;"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#F6F6F6,endColorStr=#F5F5F5);">Address Line 2:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <radi:RadTextBox ID="txtAddress2" runat="server"  EmptyMessage="" Width="100%" Height="16px" Skin="White" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#F5F5F5,endColorStr=#F3F3F3);">City:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">                                                        
                                                        <radi:RadTextBox ID="txtCity" runat="server"  EmptyMessage="City Is Required." Width="100%" Height="16px" Skin="White" style="border-right:solid 3px red;"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#F3F3F3,endColorStr=#F2F2F2);">Zip:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <radi:RadTextBox ID="txtZip" runat="server"  EmptyMessage="Zip Is Required." Width="100%" Height="16px" Skin="White" style="border-right:solid 3px red;"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#F2F2F2,endColorStr=#F0F0F0);">Country:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                      <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" RenderMode="inline">
                                                        <ContentTemplate>
                                                         <radcb:radcombobox 
                                                                ID="ddlClientCountry"
                                                                Runat="server"
                                                                AppendDataBoundItems="true"
                                                                Width="93%"
                                                                AutoPostBack="true" 
                                                                Skin="WhiteMandatory" 
                                                                ToolTip="Select a Country"
                                                                AllowCustomText="False"
                                                                DataTextField="Name" 
                                                                DataValueField="ID" 
                                                                DataSourceID="SDS_Countries"
                                                                OffsetX="3" 
                                                                Visible="true"
                                                                MarkFirstMatch="True"
                                                                 >
                                                                <Items>
                                                                    <radcb:RadComboBoxItem Text="Select Country" Value="0" Selected="true" Enabled="false"  />
                                                               </Items> 
                                                            </radcb:radcombobox>
                                                           <asp:SqlDataSource ID="SDS_Countries" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                SelectCommand="Countries_GetAll" 
                                                                SelectCommandType="StoredProcedure"
                                                                DataSourceMode="DataReader">
                                                            </asp:SqlDataSource>
                                                           </ContentTemplate>
                                                            <Triggers>
                                                          <asp:AsyncPostBackTrigger ControlID="ddlClientCountry" EventName="SelectedIndexChanged" />
                                                        </Triggers>
                                                        </asp:UpdatePanel>  
                                                        <%--window.frames.LogoUploadFrame.setClass();--%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#F0F0F0,endColorStr=#EEEEEE);">State:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                         <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="inline">
                                                            <ContentTemplate>
                                                             <radcb:radcombobox 
                                                                    ID="ddlClientStates"
                                                                    Runat="server"
                                                                    Width="93%"
                                                                    Height="95"
                                                                    Skin="White" 
                                                                    ToolTip="Select a State"
                                                                    AllowCustomText="False"
                                                                    DataTextField="Name" 
                                                                    DataValueField="ID" 
                                                                    DataSourceID="SDS_States"
                                                                    OffsetX="3"
                                                                    Visible="true"
                                                                    MarkFirstMatch="True">
                                                            </radcb:radcombobox>
                                                           <asp:SqlDataSource ID="SDS_States" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                SelectCommand="States_GetByCountryID" 
                                                                SelectCommandType="StoredProcedure"
                                                                DataSourceMode="DataReader">
                                                                <SelectParameters>
                                                                    <asp:ControlParameter ControlID="ddlClientCountry" DefaultValue="1" Name="CountryID" PropertyName="SelectedValue" Type="Int32" />
                                                                </SelectParameters> 
                                                            </asp:SqlDataSource>
                                                           </ContentTemplate>
                                                            <Triggers>
                                                              <asp:AsyncPostBackTrigger ControlID="ddlClientCountry" EventName="SelectedIndexChanged" />
                                                            </Triggers>
                                                            </asp:UpdatePanel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#EEEEEE,endColorStr=#EDEDED);">Phone:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <radi:RadTextBox ID="txtPhone" runat="server"  EmptyMessage="Phone Is Required." Width="100%" Height="16px" Skin="White" style="border-right:solid 3px red;" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#EDEDED,endColorStr=#EBEBEB);">Fax:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <radi:RadTextBox ID="txtFax" runat="server"  EmptyMessage="" Width="100%" Height="16px" Skin="White" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#EBEBEB,endColorStr=#EDEDED);">URL:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <radi:RadTextBox ID="txtURL" runat="server"  EmptyMessage="URL Is Required." Width="100%" Height="16px" Skin="White" style="border-right:solid 3px red;" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#EDEDED,endColorStr=#EBEBEB);">Corporate Email:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <radi:RadTextBox ID="txtCorporateEmail" runat="server"  EmptyMessage="Corporate Email Is Required." Width="100%" Height="16px" Skin="White" style="border-right:solid 3px red;" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#EBEBEB,endColorStr=#E9E9E9);">Bill send Option:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <%--<radi:RadMaskedTextBox  ID="txtBillSendOption" runat="server"  Visible="false"  EmptyMessage="Bill Option Is Required." Width="100%" Height="16px" Skin="White" ShowHint="true" Mask="<Post|Email>" PromptChar="_" Text="" AllowEmptyEnumerations="true" />--%>
                                                        <radcb:radcombobox 
                                                                ID="ddlBillSendOption" 
                                                                Runat="server"
                                                                Width="93%"
                                                                Skin="WhiteMandatory" 
                                                                ToolTip="Select a Bill Send"               
                                                                AllowCustomText="False"
                                                                OffsetX="3"
                                                                Visible="true"
                                                                MarkFirstMatch="True">
                                                                <Items>
                                                                    <radcb:RadComboBoxItem Text="Select Bill Send Option" Value="0" Selected="true" Enabled="false"  />
                                                                    <radcb:RadComboBoxItem Text="By Post" Value="1" />
                                                                    <radcb:RadComboBoxItem Text="By Email" Value="2" />
                                                                </Items>
                                                            </radcb:radcombobox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#E9E9E9,endColorStr=#E7E7E7);">Pref Payment Mode:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <%--<asp:TextBox ID="txtPrefPaymentMode" runat="server" Width="100%" Visible="false" CssClass="ContactInfoTextBoxClass"></asp:TextBox>--%>
                                                        <radcb:radcombobox 
                                                                ID="ddlPrefPaymentMode"
                                                                Runat="server"
                                                                Width="93%"
                                                                Skin="WhiteMandatory" 
                                                                ToolTip="Select a Payment Mode"
                                                                AllowCustomText="False"
                                                                OffsetX="3"
                                                                Visible="true"
                                                                MarkFirstMatch="True">
                                                                <Items>
                                                                    <radcb:RadComboBoxItem Text="Select Payment Mode" Value="0" Selected="true" Enabled="false"  />
                                                                    <radcb:RadComboBoxItem Text="Credit Card" Value="1" />
                                                                    <radcb:RadComboBoxItem Text="Debit Card" Value="2" />
                                                                    <radcb:RadComboBoxItem Text="Bill" Value="3" />
                                                                </Items>
                                                            </radcb:radcombobox>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                    <td colspan="2" style="height:0;display:none;">
                                                    <asp:CustomValidator ID="CV_ClientDuplicateName"  runat="server"
                                                        ErrorMessage="Client Name already exist."
                                                        ValidationGroup="vgClient" Display="None" />
                                                    <asp:RequiredFieldValidator ID="RFV_txtClientCode" runat="server" 
                                                        ControlToValidate="txtClientCode" ErrorMessage="Please Enter Code."
                                                        Display="None"  ValidationGroup="vgClient" SkinID="RequiredFieldValidation" />
                                                    <asp:RequiredFieldValidator ID="RFV_txtClientName" runat="server" 
                                                        ControlToValidate="txtClientName" ErrorMessage="Please Enter Client Name."
                                                        Display="None" ValidationGroup="vgClient" SkinID="RequiredFieldValidation" />
                                                    <asp:RequiredFieldValidator ID="RFV_txtAddress1" runat="server"
                                                        ControlToValidate="txtAddress1" ErrorMessage="Please Enter Address."
                                                        Display="None" ValidationGroup="vgClient" SkinID="RequiredFieldValidation" />
                                                    <asp:RequiredFieldValidator ID="RFV_txtCity" runat="server"
                                                        ControlToValidate="txtCity" ErrorMessage="Please Enter City."
                                                        Display="None" ValidationGroup="vgClient" SkinID="RequiredFieldValidation" />
                                                    <asp:RequiredFieldValidator ID="RFV_txtZip" runat="server"
                                                        ControlToValidate="txtZip" ErrorMessage="Please Enter Zip."
                                                        Display="None" ValidationGroup="vgClient" SkinID="RequiredFieldValidation" />
                                                   <asp:CompareValidator ID="CV_ddlClientCountry" runat="server" ControlToValidate="ddlClientCountry"
                                                          Display="None" ErrorMessage="Please Select Country." Operator="NotEqual" SkinID="CompareValidation"
                                                          ValueToCompare="Select Country" ValidationGroup="vgClient" />     
                                                    <asp:RequiredFieldValidator ID="RFV_txtPhone" runat="server"
                                                        ControlToValidate="txtPhone" ErrorMessage="Please Enter Phone."
                                                        Display="None" ValidationGroup="vgClient" SkinID="RequiredFieldValidation" />
                                                    <asp:RequiredFieldValidator ID="RFV_txtURL" runat="server"
                                                        ControlToValidate="txtURL" ErrorMessage="Please Enter URL."
                                                        Display="None" ValidationGroup="vgClient" SkinID="RequiredFieldValidation" />
                                                     <asp:RequiredFieldValidator ID="RFV_txtCorporateEmail" runat="server"
                                                        ControlToValidate="txtCorporateEmail" ErrorMessage="Please Enter Corporate Email."
                                                        Display="None" ValidationGroup="vgClient" SkinID="RequiredFieldValidation" />
                                                     <asp:RegularExpressionValidator ID="REV_txtCorporateEmail" runat="server"
                                                        ControlToValidate="txtCorporateEmail" ErrorMessage="Please Enter Valid Corporate Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                        Display="None" ValidationGroup="vgClient" />
                                                     <asp:CompareValidator ID="CV_ddlBillSendOption" runat="server" ControlToValidate="ddlBillSendOption"
                                                          Display="None" ErrorMessage="Please Select Bill Send  Option." Operator="NotEqual" SkinID="CompareValidation"
                                                          ValueToCompare="Select Bill Send Option" ValidationGroup="vgClient" />
                                                     <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddlClientCountry"
                                                          Display="None" ErrorMessage="Please Select Country." Operator="NotEqual" SkinID="CompareValidation"
                                                          ValueToCompare="Select Payment Mode" ValidationGroup="vgClient" />     
                                                    </td>
                                                </tr>
                                            </table>
                                            </div>
                                            </td>
                                        </tr>
                                    </table>
                             </td>
                           </tr>            
                      </table>
                    </div>
                  <div id="tblContactEdit" runat="server" visible="false" style="border:solid 1px #5E9DC6;width:100%;height:100%;">
                      <table style="height:100%;width:100%;text-align:left;" cellpadding="0" border="0" cellspacing="0"   >
                           <tr style="height:18px; background-image:url(../images/gb_hdr_black.jpg);background-repeat:repeat-x;">    
                              <td style="border-bottom:solid 1px #000000;">&nbsp;<img src="../images/icn_contact.jpg" alt="Contact Information" />&nbsp;<asp:Label ID="lblContactEditTitle" runat="server" Text="Contact Information" style="color:White;font-size:11px;font-weight:bold;vertical-align:middle;" /></td>
                              <td  style="border-bottom:solid 1px #000000;text-align:right;padding-right:5px;">
                                <asp:ImageButton ID="btnContactSave" runat="server" ImageUrl="../images/btn_SaveBlue.jpg" CausesValidation="true" ToolTip="Save" OnClientClick="btnContactSaveOnclick();" ValidationGroup="vgContact"  />
                                <asp:ImageButton ID="btnContactCancle" runat="server" ImageUrl="../images/btn_cancel.gif" CausesValidation="false" ToolTip="Cancle" />
                              </td>
                           </tr>
                           <tr>                
                             <td colspan="2" style="height:100%;font-size:12px; background-color:White;" >
                                    <div style="overflow-y:auto;height:100%;width:100%;">
                                            <table border="0" cellpadding="0" cellspacing="0" style="height:100%;width:100%;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#FAFEFF,endColorStr=#A5D7FF);" ><%--FAFEFF-A5D7FF--%>
                                                <tr>
                                                    <td style="height:0;width:40%;"></td>
                                                    <td style="height:0;width:60%;"></td>
                                                </tr>
                                                <tr >
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#FBFBFB,endColorStr=#F9F9F9);">Job Title:</td>
                                                    <td style="padding-right:10px;padding-left:5px;"><asp:TextBox ID="TextBox1" runat="server" Width="100%" Visible="false" CssClass="ContactInfoTextBoxClass"></asp:TextBox>
                                                         <radi:RadTextBox ID="txtContactJobTitle" runat="server"  EmptyMessage="Job Title Is Required." Width="100%" Height="16px" Skin="White" style="border-right:solid 3px red;" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#F9F9F9,endColorStr=#F8F8F8);">First Name:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <radi:RadTextBox ID="txtContactFirstName" runat="server"  EmptyMessage="First Name Is Required." Width="100%" Height="16px" Skin="White" style="border-right:solid 3px red;"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#F8F8F8,endColorStr=#F6F6F6);">Middle Name:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <radi:RadTextBox ID="txtContactMiddleName" runat="server"  EmptyMessage="" Width="100%" Height="16px" Skin="White" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#F6F6F6,endColorStr=#F5F5F5);">Last Name:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <radi:RadTextBox ID="txtContactLastName" runat="server"  EmptyMessage="Last Name Is Required." Width="100%" Height="16px" Skin="White" style="border-right:solid 3px red;" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#F6F6F6,endColorStr=#F5F5F5);">Gender:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <radcb:radcombobox 
                                                                    ID="ddlGender"
                                                                    Runat="server"
                                                                    Width="93%"
                                                                    Height="95"
                                                                    Skin="White" 
                                                                    ToolTip="Select a Gender"
                                                                    AllowCustomText="False"
                                                                    Visible="true"
                                                                    OffsetX="3"
                                                                    MarkFirstMatch="True">
                                                                    <Items>
																		<radcb:RadComboBoxItem Selected="true" Text="Select Gender" Value="0" Enabled="false"></radcb:RadComboBoxItem>
																		<radcb:RadComboBoxItem Text="Male" Value="True"></radcb:RadComboBoxItem>
																		<radcb:RadComboBoxItem Text="Female" Value="False"></radcb:RadComboBoxItem>
                                                                    </Items>
                                                            </radcb:radcombobox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#F5F5F5,endColorStr=#F3F3F3);">Country:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">                                                        
                                                        <asp:UpdatePanel ID="UpdatePanel6" runat="server" UpdateMode="Conditional" RenderMode="inline">
                                                        <ContentTemplate>
                                                         <radcb:radcombobox 
                                                                ID="ddlContactCountry"
                                                                Runat="server"
                                                                AppendDataBoundItems="true"
                                                                Width="93%"
                                                                AutoPostBack="true" 
                                                                Skin="WhiteMandatory" 
                                                                ToolTip="Select a Country"
                                                                AllowCustomText="False"
                                                                DataTextField="Name" 
                                                                DataValueField="ID" 
                                                                DataSourceID="SDS_ContactCountry"
                                                                Visible="true"
                                                                OffsetX="3"
                                                                MarkFirstMatch="True">
                                                                <Items>
                                                                    <radcb:RadComboBoxItem Text="Select Country" Value="0" Selected="true" Enabled="false"  />
                                                               </Items> 
                                                            </radcb:radcombobox>
                                                           <asp:SqlDataSource ID="SDS_ContactCountry" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                SelectCommand="Countries_GetAll" 
                                                                SelectCommandType="StoredProcedure"
                                                                DataSourceMode="DataReader">
                                                            </asp:SqlDataSource>
                                                           </ContentTemplate>
                                                            <Triggers>
                                                          <asp:AsyncPostBackTrigger ControlID="ddlContactCountry" EventName="SelectedIndexChanged" />
                                                         </Triggers>
                                                        </asp:UpdatePanel>
                                                        
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#F3F3F3,endColorStr=#F2F2F2);">State:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <asp:UpdatePanel ID="UpdatePanel7" runat="server" UpdateMode="Conditional" RenderMode="inline">
                                                            <ContentTemplate>
                                                             <radcb:radcombobox 
                                                                    ID="ddlContactState"
                                                                    Runat="server"
                                                                    Width="93%"
                                                                    Height="95"
                                                                    Skin="White" 
                                                                    ToolTip="Select a State"
                                                                    AllowCustomText="False"
                                                                    DataTextField="Name" 
                                                                    DataValueField="ID" 
                                                                    DataSourceID="SDS_ContractState"
                                                                    Visible="true"
                                                                    OffsetX="3"
                                                                    MarkFirstMatch="True">
                                                            </radcb:radcombobox>
                                                           <asp:SqlDataSource ID="SDS_ContractState" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                SelectCommand="States_GetByCountryID" 
                                                                SelectCommandType="StoredProcedure"
                                                                DataSourceMode="DataReader">
                                                                <SelectParameters>
                                                                    <asp:ControlParameter ControlID="ddlContactCountry" DefaultValue="1" Name="CountryID" PropertyName="SelectedValue" Type="Int32" />
                                                                </SelectParameters> 
                                                            </asp:SqlDataSource>
                                                           </ContentTemplate>
                                                            <Triggers>
                                                              <asp:AsyncPostBackTrigger ControlID="ddlContactCountry" EventName="SelectedIndexChanged" />
                                                            </Triggers>
                                                            </asp:UpdatePanel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#F2F2F2,endColorStr=#F0F0F0);">Address:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <radi:RadTextBox ID="txtContactAddress" runat="server"  EmptyMessage="Address Is Required." Width="100%" Height="16px" Skin="White" style="border-right:solid 3px red;"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#F2F2F2,endColorStr=#F0F0F0);">Address 2:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <radi:RadTextBox ID="txtContactAddress2" runat="server"  Width="100%" Height="16px" Skin="White" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#F0F0F0,endColorStr=#EEEEEE);">City:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                         <radi:RadTextBox ID="txtContactCity" runat="server"  EmptyMessage="City Is Required." Width="100%" Height="16px" Skin="White" style="border-right:solid 3px red;"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#EEEEEE,endColorStr=#EDEDED);">Zip / Postal Code:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <radi:RadTextBox ID="txtContactZip" runat="server"  EmptyMessage="Zip Is Required." Width="100%" Height="16px" Skin="White" style="border-right:solid 3px red;" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#EDEDED,endColorStr=#EBEBEB);">Email 1:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <radi:RadTextBox ID="txtContactEmail1" runat="server"  EmptyMessage="Work Email Is Required" Width="100%" Height="16px" Skin="White" style="border-right:solid 3px red;" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#EBEBEB,endColorStr=#EDEDED);">Email 2:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <radi:RadTextBox ID="txtContactEmail2" runat="server"  EmptyMessage="General Email Is Required." Width="100%" Height="16px" Skin="White" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#EDEDED,endColorStr=#EBEBEB);">Work Phone:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <radi:RadTextBox ID="txtContactWorkPhone" runat="server"  EmptyMessage="Work Phone Is Required." Width="100%" Height="16px" Skin="White" style="border-right:solid 3px red;" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#EBEBEB,endColorStr=#E9E9E9);">Home Phone:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <radi:RadTextBox ID="txtContactHomePhone" runat="server"  EmptyMessage="" Width="100%" Height="16px" Skin="White" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#E9E9E9,endColorStr=#E7E7E7);">Cell Phone:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <radi:RadTextBox ID="txtContactCellPhone" runat="server"  EmptyMessage="Cell Phone Is Required." Width="100%" Height="16px" Skin="White" style="border-right:solid 3px red;" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#E7E7E7,endColorStr=#E5E5E5);">Fax:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <radi:RadTextBox ID="txtContactFax" runat="server"  EmptyMessage="" Width="100%" Height="16px" Skin="White" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#E5E5E5,endColorStr=#E3E3E3);">User Name:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <radi:RadTextBox ID="txtUserName" runat="server"  EmptyMessage="User Name Is Required." Width="100%" Height="16px" Skin="White" style="border-right:solid 3px red;" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#E5E5E5,endColorStr=#E3E3E3);">User Type:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <radcb:radcombobox 
                                                                    ID="ddlUserType"
                                                                    Runat="server"
                                                                    Width="93%"
                                                                    Height="95"
                                                                    Skin="White" 
                                                                    ToolTip="Select a User Type"
                                                                    AllowCustomText="False"
                                                                    Visible="true"
                                                                    OffsetX="3"
                                                                    MarkFirstMatch="True">
                                                                    <Items>
																		<radcb:RadComboBoxItem Selected="true" Text="Select User Type" Value="0" Enabled="false"></radcb:RadComboBoxItem>
																		<radcb:RadComboBoxItem Text="Admin" Value="True"></radcb:RadComboBoxItem>
																		<radcb:RadComboBoxItem Text="No Admin" Value="False"></radcb:RadComboBoxItem>
                                                                    </Items>
                                                            </radcb:radcombobox>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#E5E5E5,endColorStr=#E3E3E3);">URLM Access:</td>
                                                    <td style="padding-right:10px;padding-left:5px;">
                                                        <radcb:radcombobox 
                                                                    ID="ddlURLMType"
                                                                    Runat="server"
                                                                    Width="93%"
                                                                    Height="95"
                                                                    Skin="White" 
                                                                    ToolTip="Select a User Type"
                                                                    AllowCustomText="False"
                                                                    Visible="true"
                                                                    OffsetX="3"
                                                                    MarkFirstMatch="True">
                                                                    <Items>
																		<radcb:RadComboBoxItem Selected="true" Text="Select URLM access" Value="0" Enabled="false"></radcb:RadComboBoxItem>
																		<radcb:RadComboBoxItem Text="Yes" Value="True"></radcb:RadComboBoxItem>
																		<radcb:RadComboBoxItem Text="No" Value="False"></radcb:RadComboBoxItem>
                                                                    </Items>
                                                            </radcb:radcombobox>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                    <td class="GrayInfoForInput" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#E5E5E5,endColorStr=#E1E1E1);">&nbsp;</td>
                                                    <td style="_height:100%;">&nbsp;
                                                    <asp:RequiredFieldValidator ID="RFV_txtContactJobTitle" runat="server" 
                                                        ControlToValidate="txtContactJobTitle" ErrorMessage="Please Enter Job Title."
                                                        Display="None"  ValidationGroup="vgContact" SkinID="RequiredFieldValidation" />
                                                    <asp:RequiredFieldValidator ID="RFV_txtContactFirstName" runat="server" 
                                                        ControlToValidate="txtContactFirstName" ErrorMessage="Please Enter First Name."
                                                        Display="None" ValidationGroup="vgContact" SkinID="RequiredFieldValidation" />
                                                    <asp:RequiredFieldValidator ID="RFV_txtContactLastName" runat="server"
                                                        ControlToValidate="txtContactLastName" ErrorMessage="Please Enter Last Name."
                                                        Display="None" ValidationGroup="vgContact" SkinID="RequiredFieldValidation" />
                                                     <asp:CompareValidator ID="CV_ddlGender" runat="server" ControlToValidate="ddlGender"
                                                          Display="None" ErrorMessage="Please Select Gender." Operator="NotEqual" SkinID="CompareValidation"
                                                          ValueToCompare="Select Gender" ValidationGroup="vgContact" />
                                                    <asp:CompareValidator ID="CV_ddlContactCountry" runat="server" ControlToValidate="ddlContactCountry"
                                                          Display="None" ErrorMessage="Please Select Country." Operator="NotEqual" SkinID="CompareValidation"
                                                          ValueToCompare="Select Country" ValidationGroup="vgContact" />
                                                    <asp:RequiredFieldValidator ID="RFV_txtContactAddress" runat="server"
                                                        ControlToValidate="txtContactAddress" ErrorMessage="Please Enter Address."
                                                        Display="None" ValidationGroup="vgContact" SkinID="RequiredFieldValidation" />
                                                    <asp:RequiredFieldValidator ID="RFV_txtContactCity" runat="server"
                                                        ControlToValidate="txtContactCity" ErrorMessage="Please Enter City."
                                                        Display="None" ValidationGroup="vgContact" SkinID="RequiredFieldValidation" />
                                                    <asp:RequiredFieldValidator ID="RFV_txtContactZip" runat="server"
                                                        ControlToValidate="txtContactZip" ErrorMessage="Please Enter Zip."
                                                        Display="None" ValidationGroup="vgContact" SkinID="RequiredFieldValidation" />
                                                    <asp:RequiredFieldValidator ID="RFV_txtContactEmail1" runat="server"
                                                        ControlToValidate="txtContactEmail1" ErrorMessage="Please Enter Email 1."
                                                        Display="None" ValidationGroup="vgContact" SkinID="RequiredFieldValidation" />
                                                     <asp:RegularExpressionValidator ID="REV_txtContactEmail1" runat="server"
                                                        ControlToValidate="txtContactEmail1" ErrorMessage="Please Enter Valid Contact Email 1" 
                                                        Display="None" ValidationGroup="vgContact" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />   
                                                     <asp:RequiredFieldValidator ID="RFV_txtContactEmail2" runat="server"
                                                        ControlToValidate="txtContactEmail2" ErrorMessage="Please Enter Email 2."
                                                        Display="None" ValidationGroup="vgContact" SkinID="RequiredFieldValidation" />
                                                      <asp:RegularExpressionValidator ID="REV_txtContactEmail2" runat="server"
                                                        ControlToValidate="txtContactEmail2" ErrorMessage="Please Enter Valid Contact Email 2"
                                                        Display="None" ValidationGroup="vgContact" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                                      <asp:RequiredFieldValidator ID="RFV_txtContactWorkPhone" runat="server"
                                                        ControlToValidate="txtContactWorkPhone" ErrorMessage="Please Enter Work Phone."
                                                        Display="None" ValidationGroup="vgContact" SkinID="RequiredFieldValidation" />
                                                      <asp:RequiredFieldValidator ID="RFV_txtContactCellPhone" runat="server"
                                                        ControlToValidate="txtContactCellPhone" ErrorMessage="Please Enter Cell Phone."
                                                        Display="None" ValidationGroup="vgContact" SkinID="RequiredFieldValidation" />
                                                      <asp:RequiredFieldValidator ID="RFV_txtUserName" runat="server"
                                                        ControlToValidate="txtUserName" ErrorMessage="Please Enter User Name."
                                                        Display="None" ValidationGroup="vgContact" SkinID="RequiredFieldValidation" />
                                                      <asp:CompareValidator ID="CV_ddlUserType" runat="server" ControlToValidate="ddlUserType"
                                                          Display="None" ErrorMessage="Please Select User Type." Operator="NotEqual" SkinID="CompareValidation"
                                                          ValueToCompare="Select User Type" ValidationGroup="vgContact" />
                                                        <asp:CompareValidator ID="CV_ddlURLMType" runat="server" ControlToValidate="ddlURLMType"
                                                          Display="None" ErrorMessage="Please Select URLM access." Operator="NotEqual" SkinID="CompareValidation"
                                                          ValueToCompare="Select User Type" ValidationGroup="vgContact" />
                                                        
                                                    </td>
                                                </tr>
                                            </table>
                                            </div>
                             </td>
                           </tr>            
                      </table>
                   </div>
                   </ContentTemplate> 
               </asp:UpdatePanel>    
            </td>
            <td style="height:100%;width:57%;padding-left:0px;">
             <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional" RenderMode="inline">
              <ContentTemplate> 
               <div style="border:solid 1px #5E9DC6;width:100%;height:100%;">
                  <table id="tblSubscribtionView" runat="server" style="height:100%;width:100%;text-align:left;" cellpadding="0" border="0" cellspacing="0"   >
                       <tr style="height:18px; background-image:url(../images/gb_hdr_black.jpg);background-repeat:repeat-x;">    
                          <td style="border-bottom:solid 1px #000000;"><asp:Label ID="lblSubscribtionViewTitle" runat="server" Text="Subscriptions" style="color:White;font-size:11px;font-weight:bold;padding-left:5px;vertical-align:middle;" /></td>
                          <td  style="border-bottom:solid 1px #000000;"><asp:ImageButton ID="btnSubscribtionEdit" runat="server" ImageUrl="../images/btn_edit.jpg" CausesValidation="false" ToolTip="Edit Client" style="float:right;" OnClientClick="return CheckClientID();" /></td>               
                       </tr>
                       <tr>                
                         <td colspan="2" style="height:100%;font-size:12px;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#FCFED5,endColorStr=#E4FEA3);" >   
                            <div style="overflow:auto;height:100%;width:100%;">
                                <asp:Repeater ID="rptProductTypesView" runat="server" DataSourceID="odsProductsModules">
                                  <HeaderTemplate>
                                    <table style="width:100%;font-size:11px;font-family:Arial;empty-cells:show;" cellpadding="0" cellspacing="0" border="0">
                                      <tr style="padding-left:10px;height:22px;font-weight:bold; background-image:url(../images/bg_hdrSilver.jpg); background-repeat:repeat-x;">
                                        <td style="width:40%;font-size:12px;border-right:solid 1px #CBCFD0;">Subscribed for</td>
                                        <td style="width:35%;border-right:solid 1px #CBCFD0;">&nbsp;</td>
                                        <td style="width:25%;">&nbsp;</td>
                                      </tr>
                                  </HeaderTemplate> 
                                  <ItemTemplate>
                                    <tr style="padding-left:10px;height:19px;font-size:11px;font-weight:bold;background-image:url(../images/bg_hdr_ltBlue.gif);background-repeat:repeat-x;">
                                        <td style="border-right:solid 1px #CBCFD0;border-bottom:solid 1px #74892E;border-top:solid 1px #74892E;"><%#Eval("ProductType")%></td>
                                        <td style="border-right:solid 1px #CBCFD0;border-bottom:solid 1px #74892E;border-top:solid 1px #74892E;">Price</td>
                                        <td style="border-bottom:solid 1px #74892E;border-top:solid 1px #74892E;">Bill To</td>
                                    </tr>
                                      <asp:Repeater ID="rptProducts" runat="server" DataSource='<%# Container.DataItem.CreateChildView("ProductTypes") %>' OnItemDataBound="rptProductsView_ItemDataBound"  >
                                         <ItemTemplate>
                                                <tr style="padding-left:10px;padding-top:4px;padding-bottom:4px;font-weight:bold;display:<%#IIf(Eval("Checked"),"inline","none") %>;"><%--background-color:<%#IIf((Container.ItemIndex Mod 2) = 0,"transparent","transparent") %>;--%>
                                                    <td style="border-right:solid 1px #CBCFD0;">
                                                       <asp:Label ID="lblProductID" runat="server" Visible="false" Text='<%#Eval("ID") %>'></asp:Label>
                                                       <span title='<%# Eval("Title")%>' style="font-size:11px;font-weight:bold;"><%#Functions.StringTruncate(Eval("Title"), 47)%></span>
                                                    </td>   
                                                    <td style="border-right:solid 1px #CBCFD0;">
                                                       <span><%#String.Format("{0:C}",Eval("Price"))%></span>
                                                       &nbsp;<span><%#IIf(Eval("PriceOption") = 1, "/ License", "/ Store per Month")%></span>
                                                    </td>
                                                    <td >
                                                       <asp:Label ID="lblBillTo" runat="server" Text='<%#Functions.BillToOption(Eval("BillTo"))%>'></asp:Label>
                                                       &nbsp;<span style="font-weight:bold;display:<%#IIf(Eval("BillTo")=3,"inline","none") %>">(corporate will pay&nbsp;<%#Eval("CorporatePay") & IIf(Functions.IfNull(Eval("CorporatePayType"), 2) = 2, " %", " $")%>)</span>
                                                    </td>
                                                </tr>
                                                <asp:Repeater ID="rptModules" runat="server" DataSource='<%# Container.DataItem.CreateChildView("ProductModules") %>' OnItemDataBound="rptModulesView_ItemDataBound">
                                                    <ItemTemplate>
                                                        <tr style="padding-left:10px;padding-top:2px;padding-bottom:2px;font-size:11px;display:<%#IIf(Eval("Checked"),"inline","none") %>;">
                                                            <td style="border-right:solid 1px #CBCFD0;">
                                                                <asp:Label ID="lblModuleID" runat="server" Visible="false" Text='<%#Eval("ID") %>' ></asp:Label>
                                                                <img src="../images/blt_normal.gif" alt=""/>
                                                                &nbsp;<span title='<%#Eval("Title")%>'><%#Functions.StringTruncate(Eval("Title"),20)%></span>
                                                            </td>
                                                            <td style="border-right:solid 1px #CBCFD0;"> 
                                                                <asp:Label ID="lblModulePrice" runat="server" Text='<%#String.Format("{0:C}",Eval("Price"))%>'></asp:Label>
                                                                &nbsp;<span><%#IIf(Eval("PriceOption") = 1, "/ License", "/ Store per Month")%></span>
                                                            </td>
                                                            <td >  
                                                               <asp:Label ID="lblBillToModule" runat="server" Text='<%#Functions.BillToOption(Eval("BillTo"))%>'></asp:Label>
                                                               &nbsp;<span style="display:<%#IIf(Eval("BillTo")=3,"inline","none") %>">(corporate will pay&nbsp;<%#Eval("CorporatePay")%>%)</span>
                                                           </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater> 
                                            </ItemTemplate> 
                                        </asp:Repeater>
                                   </ItemTemplate> 
                                  <FooterTemplate>
                                       <tr style="padding-left:10px;">
                                            <td style="border-right:solid 1px #CBCFD0;border-bottom:solid 1px #CBCFD0;">&nbsp;</td>
                                            <td style="border-right:solid 1px #CBCFD0;border-bottom:solid 1px #CBCFD0;">&nbsp;</td>
                                            <td style="border-right:solid 1px #CBCFD0;border-bottom:solid 1px #CBCFD0;">&nbsp;</td>
                                       </tr>  
                                     </table>
                                   </FooterTemplate> 
                                  </asp:Repeater>
                                <asp:ObjectDataSource ID="odsProductsModules" runat="server" TypeName="Portal.BLL.NSProducts"
                                    SelectMethod="GetProductsAndModules">
                                       <SelectParameters >
                                           <asp:ControlParameter  Name="ClientID" ControlID="hdnClientID" PropertyName="Value" Type="Int32"/>
                                       </SelectParameters>
                                   </asp:ObjectDataSource>
                                <table id="tblSubscribtionEmpty" runat="server" visible="false" border="0" cellpadding="0" cellspacing="0" style="height:100%;width:100%;text-align:center;font-size:11px;font-weight:bold;">
                                    <tr><td style="height:45%;">&nbsp;</td></tr>
                                    <tr><td style="height:10%;">Please Press Edit Button for Subscribtion</td></tr>
                                    <tr><td style="height:45%;">&nbsp;</td></tr>
                                </table> 
                            </div>     
                         </td>
                       </tr>            
                  </table>
                  <table id="tblSubscribtionEdit" runat="server" visible="false" style="height:100%;width:100%;text-align:left;" cellpadding="0" border="0" cellspacing="0"   >
                       <tr style="height:18px; background-image:url(../images/gb_hdr_black.jpg);background-repeat:repeat-x;">    
                          <td style="border-bottom:solid 1px #000000;"><asp:Label ID="lblSubscribtionEditTitle" runat="server" Text="Edit Subscriptions" style="color:White;font-size:11px;font-weight:bold;padding-left:5px;vertical-align:middle;" /></td>
                          <td  style="border-bottom:solid 1px #000000;text-align:right;padding-right:5px;">
                            <asp:ImageButton ID="btnSubscribtionSave" runat="server" ImageUrl="../images/btn_SaveBlue.jpg" CausesValidation="true" ToolTip="Edit Client" OnClientClick="btnSubscribtionSaveOnclick();"  ValidationGroup="vgSubscribtion" />
                            <asp:ImageButton ID="btnSubscribtionCancle" runat="server" ImageUrl="../images/btn_cancel.gif" CausesValidation="false" ToolTip="Edit Client" />
                             <asp:CustomValidator ID="CV_Subscribtion" runat="server" 
                                ClientValidationFunction="ValidateSubscribtion" Display="None" ValidationGroup="vgSubscribtion">
                             </asp:CustomValidator> 
                          </td>
                       </tr>
                       <tr>                
                         <td colspan="2" style="height:100%;font-size:12px;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#FCFED5,endColorStr=#E4FEA3);" >   
                            <div style="overflow:auto;height:100%;width:100%;">
                                <asp:Repeater ID="rptProductTypesEdit" runat="server" DataSourceID="odsProductsModules">
                                  <HeaderTemplate>
                                    <table id="tblSubscribtionEdit" style="width:100%;font-size:11px;font-family:Arial;empty-cells:show;" cellpadding="0" cellspacing="0" border="0">
                                      <tr style="padding-left:10px;height:22px;font-weight:bold; background-image:url(../images/bg_hdrSilver.jpg); background-repeat:repeat-x;">
                                        <td style="width:40%;font-size:12px;border-right:solid 1px #CBCFD0;">Subscribed for</td>
                                        <td style="width:35%;border-right:solid 1px #CBCFD0;">&nbsp;</td>
                                        <td style="width:25%;">&nbsp;</td>
                                      </tr>
                                  </HeaderTemplate> 
                                  <ItemTemplate>
                                    <tr style="padding-left:10px;height:19px;font-size:11px;font-weight:bold;background-image:url(../images/bg_hdr_ltBlue.gif);background-repeat:repeat-x;">
                                        <td style="border-right:solid 1px #CBCFD0;border-bottom:solid 1px #74892E;border-top:solid 1px #74892E;"><%#Eval("ProductType")%></td>
                                        <td style="border-right:solid 1px #CBCFD0;border-bottom:solid 1px #74892E;border-top:solid 1px #74892E;">Price</td>
                                        <td style="border-bottom:solid 1px #74892E;border-top:solid 1px #74892E;">Bill To</td>
                                    </tr>
                                      <asp:Repeater ID="rptProducts" runat="server" DataSource='<%# Container.DataItem.CreateChildView("ProductTypes") %>' OnItemDataBound="rptProducts_ItemDataBound" >
                                         <ItemTemplate>
                                                <tr style="padding-left:10px;padding-top:4px;padding-bottom:4px;font-weight:bold;"><%--background-color:<%#IIf((Container.ItemIndex Mod 2) = 0,"transparent","transparent") %>;--%>
                                                    <td style="border-right:solid 1px #CBCFD0;">
                                                       <asp:Label ID="lblProductID" runat="server" Visible="false" Text='<%#Eval("ID") %>'></asp:Label>
                                                       <asp:CheckBox ID="chkProducts" runat="server" Checked='<%# Bind("Checked")%>' Text='<%#Functions.StringTruncate(Eval("Title"),40)%>' ToolTip='<%#Eval("Title")%>' TextAlign="Right" style="font-size:11px;font-weight:bold;" />
                                                    </td>   
                                                    <td style="border-right:solid 1px #CBCFD0;">
                                                       <radI:RadNumericTextBox ID="txtProductPrice" runat="server"  EmptyMessage="" Text='<%#FormatNumber(Eval("Price"),0)%>' Width="50px" Height="16px" MinValue="0" Type="Currency" style="font-weight:bold;" NumberFormat-DecimalDigits="0"  Skin="White" EnabledStyle-HorizontalAlign="Right"  />
                                                       &nbsp;<span><%#IIf(Eval("PriceOption") = 1, "/ License", "/ Store per Month")%></span>
                                                    </td>
                                                    <td onmouseover="ddlmouseover(this);"onmouseout="ddlmouseout(this);">
                                                       <div id="DivCorporatePercentage1" Runat="server" style="position:absolute;height:50px;width:130px;background-color:#F3F4F8;padding-left:5px;padding-top:3px;font-weight:bold;border:solid 1px black;display:none; filter:progid:DXImageTransform.Microsoft.dropshadow(OffX=2, OffY=2, Color='gray', Positive='true');">
                                                           Corporate Will Pay:
                                                           <br />
                                                           <span style="padding-top:3px;white-space:nowrap;">
                                                            <radI:RadNumericTextBox ID="txtCorporatePercentage" runat="server"  EmptyMessage="" Text='<%#FormatNumber(Functions.IfNull(Eval("CorporatePay"),0),0)%>' Width="50px" Height="16px" MinValue="0"  Type="Number" style="font-weight:bold;" NumberFormat-DecimalDigits="0"  Skin="White" EnabledStyle-HorizontalAlign="Right" />
                                                            <asp:RadioButtonList ID="chkCorporatePercentageType" runat="server" Font-Size="8" RepeatDirection="Horizontal" RepeatColumns="0" RepeatLayout="Flow"  CellSpacing="0" CellPadding="0" style="vertical-align:middle;" SelectedValue='<%#Functions.IfNull(Eval("CorporatePayType"),2)%>'>
                                                                <asp:ListItem Text="%" Value="2" Selected="True" ></asp:ListItem>
                                                                <asp:ListItem Text="$" Value="1" ></asp:ListItem>
                                                            </asp:RadioButtonList> 
                                                           </span>
                                                           <br />
                                                       </div>
                                                        <radcb:radcombobox 
                                                                ID="ddlBillTo" Runat="server"
                                                                Width="80%"
                                                                Skin="White" ToolTip="Select Bill To"
                                                                AllowCustomText="False"
                                                                OffsetX="3" SelectedValue='<%#Bind("BillTo")%>'
                                                                Visible="true"
                                                                MarkFirstMatch="True">
                                                                <Items>
                                                                    <radcb:RadComboBoxItem Text="Select..." Value="0" Selected="True" />
                                                                    <radcb:RadComboBoxItem Text="Corporate" Value="1" />
                                                                    <radcb:RadComboBoxItem Text="Franchise" Value="2" />
                                                                    <radcb:RadComboBoxItem Text="Both" Value="3" />
                                                                </Items>
                                                         </radcb:radcombobox>
                                                    </td>
                                                </tr>
                                                <asp:Repeater ID="rptModules" runat="server" DataSource='<%# Container.DataItem.CreateChildView("ProductModules") %>' OnItemDataBound="rptModules_ItemDataBound" >
                                                    <ItemTemplate >
                                                        <tr style="padding-left:10px;padding-top:2px;padding-bottom:2px;font-size:11px;">
                                                            <td style="padding-left:20px;border-right:solid 1px #CBCFD0;">
                                                                <asp:Label ID="lblModuleID" runat="server" Visible="false" Text='<%#Eval("ID") %>' ></asp:Label>
                                                                <asp:CheckBox ID="chkModules" runat="server" Checked='<%#Bind("Checked")%>' Text='<%#Functions.StringTruncate(Eval("Title"),20)%>' ToolTip='<%#Eval("Title")%>' TextAlign="Right" />
                                                            </td>
                                                            <td style="border-right:solid 1px #CBCFD0;"> 
                                                               <%-- <asp:Label ID="lblModulePrice" runat="server" Text='<%#String.Format("{0:C}",Eval("Price"))%>'></asp:Label>--%>
                                                               <%--<span>$</span>--%>
                                                               <radi:RadNumericTextBox ID="txtModulePrice" runat="server"  EmptyMessage="" Text='<%#FormatNumber(Eval("Price"),0)%>' Width="50px" Height="16px" MinValue="0" Type="Currency" NumberFormat-DecimalDigits="0" Skin="White" EnabledStyle-HorizontalAlign="Right" />
                                                                &nbsp;<span><%#IIf(Eval("PriceOption") = 1, "/ License", "/ Store per Month")%></span>
                                                            </td>
                                                            <td onmouseover="ddlmouseover(this);"onmouseout="ddlmouseout(this);">  
                                                               <%--<asp:Label ID="lblBillToModule" runat="server" Text='<%#Functions.BillToOption(Eval("BillTo"))%>'></asp:Label>
                                                               &nbsp;<span style="display:<%#IIf(Eval("BillTo")=3,"inline","none") %>">(corporate will pay&nbsp;<%#Eval("CorporatePay")%>%)</span>--%>
                                                                <div id="DivCorporatePercentage2" Runat="server" style="position:absolute;height:50px;width:130px;background-color:#F3F4F8;padding-left:5px;padding-top:3px;font-weight:bold;border:solid 1px black;display:none; filter:progid:DXImageTransform.Microsoft.dropshadow(OffX=2, OffY=2, Color='gray', Positive='true');">
                                                                   Corporate Will Pay:
                                                                   <br />
                                                                   <span style="padding-top:3px;white-space:nowrap;">
                                                                    <radI:RadNumericTextBox ID="txtCorporatePercentage" runat="server"  EmptyMessage="" Text='<%#FormatNumber(Functions.IfNull(Eval("CorporatePay"),0),0)%>' Width="50px" Height="16px" MinValue="0"  Type="Number" style="font-weight:bold;" NumberFormat-DecimalDigits="0"  Skin="White" EnabledStyle-HorizontalAlign="Right" />
                                                                    <asp:RadioButtonList ID="chkCorporatePercentageType" runat="server" Font-Size="8" RepeatDirection="Horizontal" RepeatColumns="0" RepeatLayout="Flow"  CellSpacing="0" CellPadding="0" style="vertical-align:middle;" SelectedValue='<%#Functions.IfNull(Eval("CorporatePayType"),2)%>'>
                                                                        <asp:ListItem Text="%" Value="2" Selected="True" ></asp:ListItem>
                                                                        <asp:ListItem Text="$" Value="1" ></asp:ListItem>
                                                                    </asp:RadioButtonList> 
                                                                   </span>
                                                                   <br />
                                                               </div>
                                                               <radcb:radcombobox 
                                                                ID="ddlBillTo" Runat="server"
                                                                Width="80%"
                                                                Skin="White" ToolTip="Select Bill To"
                                                                AllowCustomText="False"
                                                                OffsetX="3" SelectedValue='<%#Bind("BillTo")%>'
                                                                Visible="true"
                                                                MarkFirstMatch="True">
                                                                <Items>
                                                                    <radcb:RadComboBoxItem Text="Select..." Value="0" Selected="True" />
                                                                    <radcb:RadComboBoxItem Text="Corporate" Value="1" />
                                                                    <radcb:RadComboBoxItem Text="Franchise" Value="2" />
                                                                    <radcb:RadComboBoxItem Text="Both" Value="3" />
                                                                </Items>
                                                         </radcb:radcombobox>
                                                           </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater> 
                                            </ItemTemplate> 
                                        </asp:Repeater>
                                   </ItemTemplate> 
                                  <FooterTemplate>
                                       <tr style="padding-left:10px;">
                                            <td style="border-right:solid 1px #CBCFD0;border-bottom:solid 1px #CBCFD0;">&nbsp;</td>
                                            <td style="border-right:solid 1px #CBCFD0;border-bottom:solid 1px #CBCFD0;">&nbsp;</td>
                                            <td style="border-right:solid 1px #CBCFD0;border-bottom:solid 1px #CBCFD0;">&nbsp;</td>
                                       </tr>  
                                     </table>
                                   </FooterTemplate> 
                                  </asp:Repeater>
                                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" TypeName="Portal.BLL.NSProducts"
                                    SelectMethod="GetProductsAndModules">
                                       <SelectParameters >
                                           <asp:ControlParameter  Name="ClientID" ControlID="hdnClientID" PropertyName="Value" Type="Int32"/>
                                       </SelectParameters>
                                   </asp:ObjectDataSource>
                            </div>     
                         </td>
                       </tr>            
                  </table>
                </div>
                </ContentTemplate> 
              </asp:UpdatePanel>   
            </td>
        </tr>
     </table>
     </div> 
    </form>
    <script language="javascript" type="text/javascript">
    var varTrContactInfo = false;
    function OnClickTrContactInfo(tr)
     {  
        var nextTR = tr.nextSibling;
        var temptr = nextTR.style.display;
        if(varTrContactInfo)
        {    
                var table = document.getElementById('tblContactInfo');
                for(i=0;i<table.rows.length-2;i++)
                {
                     if(i % 2 == 0)
                     {  
                        table.rows[i].getElementsByTagName("TD")[0].getElementsByTagName("img")[0].src = '../images/SinglePlus.gif'; 
                     }
                     else if(i % 2 == 1)
                     {
                        table.rows[i].style.display = 'none'
                     }
                }
                  
                var FirstTD = tr.getElementsByTagName("TD")[0];
                var img = FirstTD.getElementsByTagName("img")[0]; 
                if(temptr == 'none'){
                   nextTR.style.display = 'inline';
                   img.src = '../images/SingleMinus.gif';
                   }
                else{
                   nextTR.style.display = 'none';
                   img.src = '../images/SinglePlus.gif';
                   }
           }
     }
     function btnClientSaveOnclick()
     {
        if(!Page_ClientValidate('vgClient'))
        {
            SetPosition();
        }
     }
     function btnContactSaveOnclick()
     {
        if(!Page_ClientValidate('vgContact'))
        {
            SetPosition();
        }
     }
     function btnSubscribtionSaveOnclick()
     {
        if(!Page_ClientValidate('vgSubscribtion'))
        {
            SetPosition();
        }
     }
    function CloseValidationSummaryDiv()
    {    
         var ValidationSummary1 = document.getElementById('ValidationSummary1');
         if (ValidationSummary1 != null)
            ValidationSummary1.style.display = 'none';
         var ValidationSummary2 = document.getElementById('ValidationSummary2');
         if (ValidationSummary2 != null)
            ValidationSummary2.style.display = 'none';
         
         Reset();   
    }
    function SetPosition()
    {
        var divDisable = document.getElementById('divDisable') ;
        divDisable.style.width = document.body.scrollWidth
        divDisable.style.height = document.body.scrollHeight
        divDisable.style.display = 'block';
    }
  function Reset()
    {    
        var divDisable = document.getElementById('divDisable') ;
        divDisable.style.width = 0;
        divDisable.style.height = 0;
        divDisable.style.display = 'none';
        return false;
    }
    function SetImagePath(path,fullurlpath)
    {
      var hdnClientImagePath = document.getElementById('<%=hdnClientImagePath.ClientID%>');
      document.getElementById('oDiv');
      hdnClientImagePath.value = path;
      document.getElementById('oDiv').filters[0].Apply();
      var imgClientEditLogo = document.getElementById('<%=imgClientEditLogo.ClientID%>');
      imgClientEditLogo.src = fullurlpath;
      document.getElementById('oDiv').filters[0].Play();
    }
    function ShowAlertDiv(mess)
    {   
        document.getElementById('AlertDiv').style.display = 'inline';
        document.getElementById('lblAlertMessage').innerHTML = '<ul><li>' + mess + '</li></ul>';
        SetPosition();
    }
    function ShowAlertDivMultiple(mess)
    {   
        document.getElementById('AlertDiv').style.display = 'inline';
        document.getElementById('lblAlertMessage').innerHTML = mess;
        SetPosition();
    }
    function CheckClientID()
    {
        var hdnClientID = document.getElementById('<%=hdnClientID.ClientID%>');
        if(hdnClientID.value == 0)
        {
            ShowAlertDiv('Please Enter Client Information First');
            return false;
        }
        else
            return true;
    }
    function ValidateSubscribtion(sender,args)
    {
        var bool = true;
        var str = '<ul>';
        var tblSubscribtionEdit = document.getElementById('tblSubscribtionEdit');
        var span = tblSubscribtionEdit.getElementsByTagName("span");
        //tblSubscribtionEdit.getAttributeNode 
        //alert(span.length);
        for(i=0;i<span.length;i++)
        {
            if (span[i].atttxtProductPriceID != null)
            {
               //alert(span[i].getElementsByTagName("input")[0].checked);
               if(span[i].getElementsByTagName("input")[0].checked)
               {
               var txtProductPriceID = document.getElementById(span[i].atttxtProductPriceID);
               var ddlBillToID = document.getElementById(span[i].attddlBillToID);
               var txtCorporatePercentageID = document.getElementById(span[i].atttxtCorporatePercentage);
//               alert(span[i].getElementsByTagName("label")[0].innerHTML);
                 //alert(txtCorporatePercentageID == null);
//               alert(ddlBillToID.getElementsByTagName('input')[0].value == 'Select...');
                   if(txtProductPriceID.value == 0 || ddlBillToID.getElementsByTagName('input')[0].value == 'Select...')
                   {
                    bool = false;
                    if(txtProductPriceID.value == 0)
                        str += '<li>Please Enter Price of ' + span[i].getElementsByTagName("label")[0].innerHTML + '</li>'
                    if(ddlBillToID.getElementsByTagName('input')[0].value == 'Select...')
                        str += '<li>Please Select Billing Option of ' + span[i].getElementsByTagName("label")[0].innerHTML + '</li>'
                   }
//                   else if(txtCorporatePercentageID.value == 0 && ddlBillToID.getElementsByTagName('input')[0].value == 'Both')
//                   {bool = false;
//                    str += '<li>Please Enter Corporate Payment Value of ' + span[i].getElementsByTagName("label")[0].innerHTML + '</li>'
//                   }
                   
               }
            }
        }
        if(bool == false)
        {
            ShowAlertDivMultiple(str+'</ul>');
            return args.IsValid = false; 
        }
        else
        {
            return args.IsValid = true;
        }
        
    }
    
    function ddlmouseover(me)
    {
        var divs = me.getElementsByTagName('div');
//        alert(divs.length);
//        alert(divs[0].id);
//        alert(divs[1].id);
//        alert(divs[2].id);
        //alert(divs[3].id);
         x1=document.body.offsetWidth;
         y1=document.body.offsetHeight;
         var ddl = document.getElementById(divs[3].id);
         var txt = document.getElementById(divs[0].id);
         var txt2 = document.getElementById(divs[2].id);
         findPos(ddl);
//         alert(x);
//         alert(x1);
           //alert();
//         var combo = (RadComboBox)$get(divs[3].id);
//         alert(combo);
         //alert(me.offsetWidth);
         //alert(txt2.offsetWidth);
         //alert(x-x1+ me.offsetWidth);
         txt.style.left = x1 - x + 98;
         if(divs[2].getElementsByTagName('input')[1].value == 3)
            txt.style.display = 'block';
//        alert(divs[4].id);
//        alert(divs[5].id);
    }
    function ddlmouseout(me)
    {
        var divs = me.getElementsByTagName('div');
//        alert(divs.length);
//        alert(divs[0].id);
//        alert(divs[1].id);
//        alert(divs[2].id);
        //alert(divs[3].id);
//         x1=document.body.offsetWidth;
//         y1=document.body.offsetHeight;
//         var ddl = document.getElementById(divs[3].id);
         var txt = document.getElementById(divs[0].id);
//         findPos(ddl);
//         alert(x);
//         alert(x1);
//         txt.style.left = x1 - x + 130;
         txt.style.display = 'none';
//        alert(divs[4].id);
//        alert(divs[5].id);
    }
    var x,y;
    function findPos(obj)
    {
     var left = !!obj.offsetLeft ? obj.offsetLeft : 0;
     var top = !!obj.offsetTop ? obj.offsetTop : 0;

     while(obj = obj.offsetParent)
     {
      left += !!obj.offsetLeft ? obj.offsetLeft : 0;
      top += !!obj.offsetTop ? obj.offsetTop : 0;
     }
     x = left;
     y = top;
    }
    </script>
</body>
</html>