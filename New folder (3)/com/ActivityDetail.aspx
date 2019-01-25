<%@ Page Language="VB" AutoEventWireup="false" ValidateRequest="false" EnableEventValidation="false" CodeFile="ActivityDetail.aspx.vb" Inherits="ActivityDetail" %>
<%@ Register Src="VitalInformationFloatingDiv.ascx" TagName="VitalInformationFloatingDiv"
    TagPrefix="CsCtrl" %>
<%@ Register
    Assembly="AjaxControlToolkit"
    Namespace="AjaxControlToolkit"
    TagPrefix="ajaxToolkit" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Activity Detail</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../scripts/functions.js"></script>
    <meta http-equiv="Page-Enter" content="progid:DXImageTransform.Microsoft.Fade(Duration=0.2)" />
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(Duration=0.2)" />
    
    <style type="text/css">
  #backgroundFilter
{
    position: absolute;
    top: 0;
    left: 0;
    overflow: hidden;
    padding: 0;
    margin: 0;
    background-color: #000;
    filter: alpha(opacity=60);
    opacity: 0.5;
    display: none;
    z-index: 1000;
    width: 100%;
    height: 100%;
}
.popupWindow
{
    position: absolute;
    display:none;
    z-index: 100000;
   /* background-color: #ddd; */
    background-color: #FFFFFF; 
    border: 2px solid #609BD3;
    /* height:365px; */
  
}
.CloseButton
 {
	cursor:pointer;
	font-weight:bold;
}.hdng_Label
{
	font-family:Arial, Verdana, Sans-Serif, Helvetica;
	font-size:11px; color:#000; font-weight:normal;
	vertical-align:bottom; height:20px;	
}
.tblRaingValue {border:solid 1px black;width:100%;font-size:11px;color:Black;}
.tblRaingValue td{border-left:solid 1px black;padding-left:3px;color:Black;}
    </style>
    
</head>
<body style="margin:0px;width:100%;height:100%;">
 <form id="form1" runat="server" >
  <div id="DivSMSX" class="popupWindow" style="border: solid 4px #609BD3; width: 550px; 
             display: none; margin-bottom: 0px; height: 300px;">
		<table cellpadding="0" border="0" cellspacing="0">
		    <tr>
                <td style="width: 90%;padding-left:5px; padding-top:5px;">
                    <span><strong class="lblTitle">SMSx Regenerate Download Link </strong></span>
                </td>
                <td class="lblTitle" align="right" style="padding-top:5px;">
                <a id="hrefClose" runat="server" onClick="CloseSMSX()" style="cursor:pointer;font-weight: bold;text-align:right;vertical-align:middle;color:Black;padding-top:3px;">X</a> &nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="2" style="height: 30px;vertical-align: top;padding:15px;" align="right">
                    <table cellpadding="0" cellspacing="0" border="0" style="background: #F0F5F9;width:100%; height:100%">
                        <tr>
                            <td style="padding-left:10; padding-bottom:5px;" Class="hdng_Label" align="right">
                                To :</td>
                            <td align="left" style="width: 85%;padding-bottom:5px;"Class="hdng_Label">
                                &nbsp;<asp:Label ID="lblTo" runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="height: 22px;padding-bottom:12px;" align="right" Class="hdng_Label">
                                <asp:Label ID="lblSubject" runat="server" Text="Subject:" Style="padding: 0 0 0 5;"
                                    ></asp:Label>
                            </td>
                            <td align="left" style="padding: 0 0 0 5; height: 22px; width: 85%;padding-bottom:10px;padding-right:15px;" Class="hdng_Label">
                                <asp:TextBox ID="txtSubject" runat="server" Width="100%" Text="Feedback Request"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
           
			<tr valign="top">
			 <td colspan="2" style="padding:15px;">
				<div style="overflow-y:auto; height:280px;width:600px; border:solid 2px #F0F5F9;">
			   
			    <asp:Label runat="server" ID="lblSMSXDescription"></asp:Label>
			 	</div>
			 </td>
			</tr>
			<tr>
                <td colspan="2" style="height: 20px; text-align: center; padding-top: 15px; padding-bottom:10px;">
                   <asp:button ID="btnSendSMSX" runat="Server" CssClass='Btn3D' Text="Send Download Link" Width="150"/>
				  <input id='btnClose' type='button' class='Btn3D' value='Close' style="height:24px;" title='Close Window' onClick="CloseSMSX();" />
                </td>
			</tr>
		  </table>
        </div>
    <iframe id="divDisable" marginheight="0" marginwidth="0" scrolling="no" frameborder="0" style="display:none;z-index:09;width:0;height:0;position:absolute;filter:progid:DXImageTransform.Microsoft.alpha(opacity=50);opacity:0.5;"src="../BlankPage.htm"></iframe>
    <div>
    <asp:HiddenField ID="hdnRegularExprssion" runat="server" />
     <asp:HiddenField ID="hdnHasSupportAccess" runat="server" Value="False" />
      <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="300" ></asp:ScriptManager>
      <asp:UpdateProgress ID="Progress1" runat="server">
            <ProgressTemplate>
                <div class="ProgressIndicatorDIV" >
                    <br />
                    <asp:Image ID="Image2" runat="server" ImageUrl="~/images/indicator.gif" ImageAlign="AbsMiddle" /> <span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
                    <br /><br />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
      <table style="width:100%;height:100%; background-color:#BADCFC;" border="0" cellspacing="0" cellpadding="0"  class="MainTable">
          <tr>
           <td style="width:27px;">
              <asp:UpdatePanel ID="update1" runat="server" UpdateMode="Always" RenderMode="Block" >
             <ContentTemplate>           
                <CsCtrl:VitalInformationFloatingDiv ID="VitalInformationFloatingDiv" runat="server" />
             </ContentTemplate>
           </asp:UpdatePanel>
	           <asp:HiddenField ID="hdnSubject" runat="server" />
               <asp:HiddenField ID="hdnTicket" runat="server" />
               <asp:HiddenField ID="hdnRelatedTo" runat="server" />
              </td>
              <td style="padding:5px" onClick="if (blnShowed == true){HideAttachFiles(); DivOptionHide(); showHideVital(); }"> 
                <table   style="width:100%;height:100%;background-color:#FFFFFF;border:1 solid #609BD3; " class="Table"   border="0" align="center" cellpadding="0" cellspacing="0" > 
                     <tr>
                       <td style="height:85px;">      
                       <asp:HiddenField ID="hdnID" runat="server" Value="0" />
                        <asp:HiddenField runat="server" Value="0" ID="hdnType" />
                       <asp:HiddenField ID="PrevPage" runat="server" Value="0" />  
                       <asp:HiddenField ID="hdnFranchiseID" runat="server" Value="0" />
                       <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
                       <asp:HiddenField ID="hdnDueDate" runat="server" Value="0" />                                                                              
                              <table style="width:100%;height:25%; border-color:#7391B9;"  border="0" align="center" cellpadding="0" cellspacing="0" class="Table"  >
                               <tr style="background-color:#DDE4EE;">
                                    <td style="height:31px;" colspan="6">	
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                               <td   colspan="2" class="SimpleBold" style="height:31px;background-color:#BDE7BD;color:#000000;border-bottom:1 solid #609BD3; width:50%; ">
                                                &nbsp;<asp:Label ID="lblTitle" runat="server" Text="Activity Detail" ></asp:Label> &nbsp;(&nbsp;<asp:Label runat="server" ID="lblFranchiseName" />&nbsp;) 
                                                 &nbsp; <img align="absMiddle"  height="20" src="../images/pixel_skyBlue.jpg" width="1" alt="" /><img align="absMiddle"  height="20" src="../images/pixel_skyBlue.JPG" width="1" alt="" />
                                                     &nbsp;                   
                                                    [&nbsp;<asp:Label ID="lblClient" runat="server" Text="" ></asp:Label>&nbsp;]&nbsp;&nbsp; &nbsp; &nbsp;                                                                                                     
                                                </td>                                                
                                                <td style="background-color:#BDE7BD;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right;cursor:pointer; height: 1px;border-bottom:1 solid #609BD3;  width:185px;" align="right">
                                                     <asp:DropDownList ID="ddlFranchiseContact" 
                                                            runat="server"                                                                                                                           
                                                            DataSourceID="sdsContacts"
                                                            AutoPostBack="false" 
                                                            DataTextField="Name"  
                                                            CssClass="SmallGreenTextBox" 
                                                            DataValueField="ID" Width="130px" >
                                                     </asp:DropDownList>
                                                     <asp:ObjectDataSource ID="sdsContacts" runat="server"
                                                        OldValuesParameterFormatString="original_{0}"                                                
                                                        SelectMethod="FranchisesContactByID"
                                                        TypeName="Portal.BLL.Franchises"> 
                                                        <SelectParameters>
                                                              <asp:ControlParameter Name="ClientID" DefaultValue="1"  ControlID="hdnClientID" Type="int32" PropertyName="value" />
                                                              <asp:ControlParameter  Name="FranchiseID" Type="Int32" ControlID="hdnFranchiseID" PropertyName="Value" />                      
                                                        </SelectParameters>                                                                                         
                                                     </asp:ObjectDataSource>
                                                            <div style="width:50px; padding:2px;" class="LeadDetailButton" onClick="Javascript:showContact();">
                                                                &nbsp;View&nbsp;
                                                            </div>
                                                 </td>
                                                 <td style="background-color:#BDE7BD;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right;cursor:pointer; height: 1px;border-bottom:1 solid #609BD3;  width:125px;">                                                    
                                                     <img align="absMiddle"  height="20" src="../images/pixel_skyBlue.jpg" width="1" alt="" /><img align="absMiddle"  height="20" src="../images/pixel_skyBlue.JPG" width="1" alt="" />
                                                     &nbsp;                   
                                                     <asp:LinkButton ID="btnNewActivity" runat="server"  CssClass="HomeButton">
                                                            <div style="width:110px;" class="LeadDetailButton" onClick="javascript:window.location='AddActivity.aspx?FranchiseID=<%=  Request.QueryString("FranchiseID").ToString() %>&ClientID=<%= Request.QueryString("ClientID").ToString() %>';return false;">
                                                                &nbsp;&nbsp; New Activity 
                                                                <img  src="../images/blt_resetfilters.gif" align="absmiddle" width="10" height="10" style="border:0px;" alt="" />
                                                            </div>
                                                     </asp:LinkButton> 
                                                 </td>	                                                 					                                   
                                            </tr>
                                       </table>
                                    </td>
                                </tr> 
                                <tr style="border-color:#F5F5F5; background-color:#DEF7D6;">
                                    <td style="width:2%;height:20px;"></td>
                                    <td style="width:10%;" class="SimpleExSmall">Ticket #:</td>
                                    <td style="width:20%;" colspan="" >
                                    <strong><asp:Label runat="server" ID="lblTicketNumber" Text="" /></strong>
                                    </td>                           
                                    <td></td>         
                                    <td class="SimpleExSmall">Contact Name:</td>
                                    <td >
                                    <strong><asp:Label ID="lblContactName" runat="server" Text=""></asp:Label></strong>
                                    </td>                           
                                </tr>
                                 <tr > 
                                    <td height="1"  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" alt="" /></td>
                                </tr>                                                                                       
                                <tr style="border-color:#F5F5F5; background-color:#DEF7D6;">
                                    <td style="width:2%;height:20px;"></td>
                                    <td style="width:10%;" class="SimpleExSmall">Initiated By:</td>
                                    <td style="width:20%;" >
                                    <strong><asp:Label runat="server" ID="lblAssignBy" Text="" /></strong>
                                    </td>
                                    <td style="width:4%;"></td>
                                    <td style="width:15%;" class="SimpleExSmall">Type:</td>
                                    <td style="width:49%;" >
                                    <strong><asp:Label runat="server" ID="lblActivityType" Text="" /></strong>
                                    </td>
                                </tr>                    
                                <tr > 
                                    <td height="1"  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" alt="" /></td>
                                </tr>
                                <tr style="border-color:#F5F5F5; background-color:#DEF7D6;" valign="middle">
                                    <td ></td>
                                    <td  style="height:20px;" class="SimpleExSmall">Start Date: </td>
                                    <td  >                            
                                       <strong><asp:Label runat="server" ID="lblActivityDueDate" Text="" /> </strong>
                                    </td>
                                    <td ></td>
                                    
                                    <td class="SimpleExSmall"><asp:Literal ID="ltrlTimeSpent" runat="server" Text="Time Spent (HH:MM):"></asp:Literal></td>
                                    <td  >                                    
                                     <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional" RenderMode="block">
                                      <ContentTemplate>
                                      <strong>
                                          <asp:Label runat="server" ID="lblTimeSpent" Text=""  Visible="true"/>
                                             <div id="divTime" runat="server" style="display:none;" >                           
                                            <asp:DropDownList ID="ddlHoursNotes"  runat="server" 
                                            CssClass="SmallGreenTextBox"  
                                            AutoPostBack="false">
                                            
                                            <asp:ListItem Text="00" Value="0" Selected="True" ></asp:ListItem>
                                            <asp:ListItem Text="01" Value="1"  ></asp:ListItem>
                                            <asp:ListItem Text="02" Value="2"  ></asp:ListItem>
                                            <asp:ListItem Text="03" Value="3"  ></asp:ListItem>
                                            <asp:ListItem Text="04" Value="4"  ></asp:ListItem>
                                            <asp:ListItem Text="05" Value="5"  ></asp:ListItem>
                                            <asp:ListItem Text="06" Value="6"  ></asp:ListItem>
                                            <asp:ListItem Text="07" Value="7"  ></asp:ListItem>
                                            <asp:ListItem Text="08" Value="8"  ></asp:ListItem>
                                            <asp:ListItem Text="09" Value="9"  ></asp:ListItem>
                                            <asp:ListItem Text="10" Value="10"  ></asp:ListItem>
                                            <asp:ListItem Text="11" Value="11"  ></asp:ListItem>
                                            
                                           </asp:DropDownList>
                                            :
                                            <asp:DropDownList ID="ddlMinutesNotes"  runat="server"                           
                                            CssClass="SmallGreenTextBox"  
                                            AutoPostBack="false" >
                                            <asp:ListItem Text="00" Value="0" Selected="True" ></asp:ListItem>
                                            <asp:ListItem Text="01" Value="1"  ></asp:ListItem>
                                            <asp:ListItem Text="02" Value="2"  ></asp:ListItem>
                                            <asp:ListItem Text="03" Value="3"  ></asp:ListItem>
                                            <asp:ListItem Text="04" Value="4"  ></asp:ListItem>
                                            <asp:ListItem Text="05" Value="5"  ></asp:ListItem>
                                            <asp:ListItem Text="06" Value="6"  ></asp:ListItem>
                                            <asp:ListItem Text="07" Value="7"  ></asp:ListItem>
                                            <asp:ListItem Text="08" Value="8"  ></asp:ListItem>
                                            <asp:ListItem Text="09" Value="9"  ></asp:ListItem>
                                            <asp:ListItem Text="10" Value="10"  ></asp:ListItem>
                                            <asp:ListItem Text="11" Value="11"  ></asp:ListItem>
                                            <asp:ListItem Text="12" Value="12"  ></asp:ListItem>
                                            <asp:ListItem Text="13" Value="13"  ></asp:ListItem>
                                            <asp:ListItem Text="14" Value="14"  ></asp:ListItem>
                                            <asp:ListItem Text="15" Value="15"  ></asp:ListItem>
                                            <asp:ListItem Text="16" Value="16"  ></asp:ListItem>
                                            <asp:ListItem Text="17" Value="17"  ></asp:ListItem>
                                            <asp:ListItem Text="18" Value="18"  ></asp:ListItem>
                                            <asp:ListItem Text="19" Value="19"  ></asp:ListItem>
                                            <asp:ListItem Text="20" Value="20"  ></asp:ListItem>
                                            <asp:ListItem Text="21" Value="21"  ></asp:ListItem>
                                            <asp:ListItem Text="22" Value="22"  ></asp:ListItem>
                                            <asp:ListItem Text="23" Value="23"  ></asp:ListItem>
                                            <asp:ListItem Text="24" Value="24"  ></asp:ListItem>
                                            <asp:ListItem Text="25" Value="25"  ></asp:ListItem>
                                            <asp:ListItem Text="26" Value="26"  ></asp:ListItem>
                                            <asp:ListItem Text="27" Value="27"  ></asp:ListItem>
                                            <asp:ListItem Text="28" Value="28"  ></asp:ListItem>
                                            <asp:ListItem Text="29" Value="29"  ></asp:ListItem>
                                            <asp:ListItem Text="30" Value="30"  ></asp:ListItem>
                                            <asp:ListItem Text="31" Value="31"  ></asp:ListItem>
                                            <asp:ListItem Text="32" Value="32"  ></asp:ListItem>
                                            <asp:ListItem Text="33" Value="33"  ></asp:ListItem>
                                            <asp:ListItem Text="34" Value="34"  ></asp:ListItem>
                                            <asp:ListItem Text="35" Value="35"  ></asp:ListItem>
                                            <asp:ListItem Text="36" Value="36"  ></asp:ListItem>
                                            <asp:ListItem Text="37" Value="37"  ></asp:ListItem>
                                            <asp:ListItem Text="38" Value="38"  ></asp:ListItem>
                                            <asp:ListItem Text="39" Value="39"  ></asp:ListItem>
                                            <asp:ListItem Text="40" Value="40"  ></asp:ListItem>
                                            <asp:ListItem Text="41" Value="41"  ></asp:ListItem>
                                            <asp:ListItem Text="42" Value="42"  ></asp:ListItem>
                                            <asp:ListItem Text="43" Value="43"  ></asp:ListItem>
                                            <asp:ListItem Text="44" Value="44"  ></asp:ListItem>
                                            <asp:ListItem Text="45" Value="45"  ></asp:ListItem>
                                            <asp:ListItem Text="46" Value="46"  ></asp:ListItem>
                                            <asp:ListItem Text="47" Value="47"  ></asp:ListItem>
                                            <asp:ListItem Text="48" Value="48"  ></asp:ListItem>
                                            <asp:ListItem Text="49" Value="49"  ></asp:ListItem>
                                            <asp:ListItem Text="50" Value="50"  ></asp:ListItem>
                                            <asp:ListItem Text="51" Value="51"  ></asp:ListItem>
                                            <asp:ListItem Text="52" Value="52"  ></asp:ListItem>
                                            <asp:ListItem Text="53" Value="53"  ></asp:ListItem>
                                            <asp:ListItem Text="54" Value="54"  ></asp:ListItem>
                                            <asp:ListItem Text="55" Value="55"  ></asp:ListItem>
                                            <asp:ListItem Text="56" Value="56"  ></asp:ListItem>
                                            <asp:ListItem Text="57" Value="57"  ></asp:ListItem>
                                            <asp:ListItem Text="58" Value="58"  ></asp:ListItem>
                                            <asp:ListItem Text="59" Value="59"  ></asp:ListItem>                                                    
                                            </asp:DropDownList>
                                           &nbsp;&nbsp;&nbsp;<asp:LinkButton    ID="btnUpdateDueDate"  CausesValidation="false" runat="server" style="width:50px;font-size:11px;  height:18px;" Text="Update"  />                  
                                           &nbsp;&nbsp;<span id="spnUpdateMessage" style="display:none;padding:4px; color:#429E8C; vertical-align:inherit;"  >&nbsp;[&nbsp;Record updated successfully&nbsp;]&nbsp;</span> &nbsp;&nbsp;&nbsp;
                                         </div>  
                                        </strong>
                                       </ContentTemplate>
                                     </asp:UpdatePanel>                                                  
                                    </td>                                                                                                
                                </tr>                                
                                <tr > 
                                    <td  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" alt="" /></td>
                                </tr>
                                <tr style="border-color:#F5F5F5; background-color:#DEF7D6;height:20px;">
                                    <td ></td>
                                    <td  class="SimpleExSmall">Topic:</td>
                                    <td >
                                        <strong><asp:Label runat="server" ID="lblSubType" Text="" /></strong>
                                    </td>                                                            
                                    <td ></td>                                    
                                    <td class="SimpleExSmall">Priority:</td>
                                    <td >
                                    <span id="spanlblPriority" runat="server" ><strong><asp:Label runat="server" ID="lblPriority" Text="" /></strong></span>
                                    <span id="spanddlPriority" runat="server" >
                                        <asp:DropDownList ID="ddlPriority" 
                                            runat="server"                                 
                                            AutoPostBack="true" 
                                            ValidationGroup="vgPriority"                                                                                                            
                                            CssClass="SmallGreenTextBox" 
                                            onchange="PriorityChanged(this)"
                                            Width="150px" >
                                            <asp:ListItem Text="Select..." Value="0" ></asp:ListItem>
                                            <asp:ListItem Text="Low" Value="1" />
                                            <asp:ListItem Text="Minimal" Value="2"/>
                                            <asp:ListItem Text="Moderate" Value="3"/>
                                            <asp:ListItem Text="High" Value="4" />
                                            <asp:ListItem Text="Critical" Value="5" />
                                     </asp:DropDownList>
                                     <asp:CompareValidator ID="CompareValidator1" 
                                        runat="server" 
                                        ControlToValidate="ddlPriority"
                                        Operator="GreaterThan"
                                        ErrorMessage="Select Priority"
                                        ValidationGroup="vgPriority"
                                        ValueToCompare="0" 
                                        Display="Dynamic"
                                        CssClass="ErrorMessage" >
                                     </asp:CompareValidator>
                                    </span> 
                                    </td>                                   
                                </tr>
                                <tr > 
                                    <td  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" alt="" /></td>
                                </tr>
                                <tr style="border-color:#F5F5F5; background-color:#DEF7D6;height:20px;">
                                    <td ></td>
                                    <td  class="SimpleExSmall">Related To:</td>
                                    <td >
                                        <strong><asp:Label runat="server" ID="lblRelatedTo" Text="" /></strong>
                                    </td>                                                            
                                    <td ></td>                                    
                                    <td id="TD_Module" runat="server" class="SimpleExSmall">Issue:</td>
                                    <td>
                                        <strong><asp:Label runat="server" ID="lblProductModule" Text="" /></strong>
                                    </td>                                   
                                </tr>
                                <tr > 
                                    <td  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" alt="" /></td>
                                </tr>
                                <tr style="border-color:#E9E9E9; background-color:#BDE7BD">
                                    <td style="height:20px;"></td>
                                    <td class="SimpleExSmall" >Subject:</td>
                                    <td colspan="3">
                                        <strong> <asp:Label runat="server" ID="lblActivitySubject" Text="" /></strong>&nbsp;
                                    </td>
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td class="SimpleExSmallBold" style="width:70%" colspan="3">
                                                            <a OnClick="OpneSMSX();" runat="server" id="SMSXLink" Style="font-size: 11px;
                                                                width: 200px; height: 18px;text-decoration:underline;cursor:hand">
                                                                Regenerate SMSx Download Link</a>
                                                  </td>
                                                <td style="white-space: nowrap;" class="SimpleExSmallBold" align="right"> 
                                                    <asp:UpdatePanel ID="updatepanelmes" runat="server" RenderMode="Inline" UpdateMode="Always">
                                                        <ContentTemplate>
                                                            <asp:LinkButton ID="btnAddNotes" runat="server" CausesValidation="false" Style="font-size: 11px;
                                                                width: 90px; height: 18px;" Text="Add Notes" Font-Underline="true" OnClientClick="Notes(); return false;" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>                                                                             
                               <tr > 
                                    <td  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" alt="" /></td>
                               </tr>                                                                        
                            </table>                                                                          
                      </td>
                    </tr>
                     <tr>
                       <td style="width: 100%;height:100%;">  
                          <div style="width: 100%;height:100%;vertical-align:top;"  class="DivScroll"   ondblclick="Notes();">  
                             <table style="width: 100%;height:100%;" cellpadding="0" cellspacing="0" border="0"> 
                                 <tr class="SimpleExSmallBold" id="trFiles" style="display:none;border:none;">
                                    <td style="height:25px;" colspan="4">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td style="border:none;width:5%;" rowspan="2" align="center" ><img src="../images/ico_attachment.gif" align="middle" alt="attach" /></td>
                                                <td style="border:none;" id="tdFiles"></td>
                                            </tr>
                                        </table> 
                                    </td>
                                  </tr>                  
                                <tr>
                                    <td style="padding:0px;" valign="top" >
                                       <table style="width:100%; height:100%; vertical-align:top;"   border="0"  cellpadding="0" cellspacing="0">
                                           <tr>
                                                <td style=" width:100%; height:100%; vertical-align:top;">
                                                    <div style="display: none; vertical-align:top;height:80px; width:100%; background-color:#DAF5D6; border-bottom:solid 1px #609BD3;" id="DivNotes" >                           
						                            <table width="100%"  cellpadding="0" cellspacing="0" border="0" style="padding:2px;" onDblClick="event.cancelBubble=true;">
						                                <tr>
						                                 <td  valign="top" class="SimpleExSmallBold" style="width:10%;">Type:</td>
						                                 <td class="SimpleExSmallBold" style="width:10%;" >
						                                  <asp:DropDownList ID="ddlNotesType"   
                                                                 CssClass="SmallGreenTextBox"
                                                                AutoPostBack="false"  
                                                                Visible="false"
                                                                Height="20px"
                                                                runat="server">
                                                                <asp:ListItem Value="0" Text="Public" ></asp:ListItem>
                                                                <asp:ListItem Value="1" Text="Private" Selected="True" ></asp:ListItem>                                                                                            
                                                            </asp:DropDownList>
                                                            <asp:Label ID="lblNotesType" runat="server" Text="[ Private ]" ></asp:Label>                                                           
                                                           </td>
                                                           <td class="SimpleExSmallBold" style="width:20%;" align="right">
                                                           Time Spent (HH:MM): 
                                                           </td>
                                                           <td style="width:40%;">
                                                           <div style="float:left;">
                                                               <asp:DropDownList ID="ddlHours"  runat="server"                            
                                                            CssClass="SmallGreenTextBox"  
                                                            AutoPostBack="false" >
                                                            <asp:ListItem Text="00" Value="0" Selected="True" ></asp:ListItem>
                                                            <asp:ListItem Text="01" Value="1"  ></asp:ListItem>
                                                            <asp:ListItem Text="02" Value="2"  ></asp:ListItem>
                                                            <asp:ListItem Text="03" Value="3"  ></asp:ListItem>
                                                            <asp:ListItem Text="04" Value="4"  ></asp:ListItem>
                                                            <asp:ListItem Text="05" Value="5"  ></asp:ListItem>
                                                            <asp:ListItem Text="06" Value="6"  ></asp:ListItem>
                                                            <asp:ListItem Text="07" Value="7"  ></asp:ListItem>
                                                            <asp:ListItem Text="08" Value="8"  ></asp:ListItem>
                                                            <asp:ListItem Text="09" Value="9"  ></asp:ListItem>
                                                            <asp:ListItem Text="10" Value="10"  ></asp:ListItem>
                                                            <asp:ListItem Text="11" Value="11"  ></asp:ListItem>
                                                            </asp:DropDownList>
                                                            :
                                                               <asp:DropDownList ID="ddlMinutes"  runat="server"                           
                                                            CssClass="SmallGreenTextBox"  
                                                            AutoPostBack="false" >
                                                            <asp:ListItem Text="00" Value="0" Selected="True" ></asp:ListItem>
                                                            <asp:ListItem Text="01" Value="1"  ></asp:ListItem>
                                                            <asp:ListItem Text="02" Value="2"  ></asp:ListItem>
                                                            <asp:ListItem Text="03" Value="3"  ></asp:ListItem>
                                                            <asp:ListItem Text="04" Value="4"  ></asp:ListItem>
                                                            <asp:ListItem Text="05" Value="5"  ></asp:ListItem>
                                                            <asp:ListItem Text="06" Value="6"  ></asp:ListItem>
                                                            <asp:ListItem Text="07" Value="7"  ></asp:ListItem>
                                                            <asp:ListItem Text="08" Value="8"  ></asp:ListItem>
                                                            <asp:ListItem Text="09" Value="9"  ></asp:ListItem>
                                                            <asp:ListItem Text="10" Value="10"  ></asp:ListItem>
                                                            <asp:ListItem Text="11" Value="11"  ></asp:ListItem>
                                                            <asp:ListItem Text="12" Value="12"  ></asp:ListItem>
                                                            <asp:ListItem Text="13" Value="13"  ></asp:ListItem>
                                                            <asp:ListItem Text="14" Value="14"  ></asp:ListItem>
                                                            <asp:ListItem Text="15" Value="15"  ></asp:ListItem>
                                                            <asp:ListItem Text="16" Value="16"  ></asp:ListItem>
                                                            <asp:ListItem Text="17" Value="17"  ></asp:ListItem>
                                                            <asp:ListItem Text="18" Value="18"  ></asp:ListItem>
                                                            <asp:ListItem Text="19" Value="19"  ></asp:ListItem>
                                                            <asp:ListItem Text="20" Value="20"  ></asp:ListItem>
                                                            <asp:ListItem Text="21" Value="21"  ></asp:ListItem>
                                                            <asp:ListItem Text="22" Value="22"  ></asp:ListItem>
                                                            <asp:ListItem Text="23" Value="23"  ></asp:ListItem>
                                                            <asp:ListItem Text="24" Value="24"  ></asp:ListItem>
                                                            <asp:ListItem Text="25" Value="25"  ></asp:ListItem>
                                                            <asp:ListItem Text="26" Value="26"  ></asp:ListItem>
                                                            <asp:ListItem Text="27" Value="27"  ></asp:ListItem>
                                                            <asp:ListItem Text="28" Value="28"  ></asp:ListItem>
                                                            <asp:ListItem Text="29" Value="29"  ></asp:ListItem>
                                                            <asp:ListItem Text="30" Value="30"  ></asp:ListItem>
                                                            <asp:ListItem Text="31" Value="31"  ></asp:ListItem>
                                                            <asp:ListItem Text="32" Value="32"  ></asp:ListItem>
                                                            <asp:ListItem Text="33" Value="33"  ></asp:ListItem>
                                                            <asp:ListItem Text="34" Value="34"  ></asp:ListItem>
                                                            <asp:ListItem Text="35" Value="35"  ></asp:ListItem>
                                                            <asp:ListItem Text="36" Value="36"  ></asp:ListItem>
                                                            <asp:ListItem Text="37" Value="37"  ></asp:ListItem>
                                                            <asp:ListItem Text="38" Value="38"  ></asp:ListItem>
                                                            <asp:ListItem Text="39" Value="39"  ></asp:ListItem>
                                                            <asp:ListItem Text="40" Value="40"  ></asp:ListItem>
                                                            <asp:ListItem Text="41" Value="41"  ></asp:ListItem>
                                                            <asp:ListItem Text="42" Value="42"  ></asp:ListItem>
                                                            <asp:ListItem Text="43" Value="43"  ></asp:ListItem>
                                                            <asp:ListItem Text="44" Value="44"  ></asp:ListItem>
                                                            <asp:ListItem Text="45" Value="45"  ></asp:ListItem>
                                                            <asp:ListItem Text="46" Value="46"  ></asp:ListItem>
                                                            <asp:ListItem Text="47" Value="47"  ></asp:ListItem>
                                                            <asp:ListItem Text="48" Value="48"  ></asp:ListItem>
                                                            <asp:ListItem Text="49" Value="49"  ></asp:ListItem>
                                                            <asp:ListItem Text="50" Value="50"  ></asp:ListItem>
                                                            <asp:ListItem Text="51" Value="51"  ></asp:ListItem>
                                                            <asp:ListItem Text="52" Value="52"  ></asp:ListItem>
                                                            <asp:ListItem Text="53" Value="53"  ></asp:ListItem>
                                                            <asp:ListItem Text="54" Value="54"  ></asp:ListItem>
                                                            <asp:ListItem Text="55" Value="55"  ></asp:ListItem>
                                                            <asp:ListItem Text="56" Value="56"  ></asp:ListItem>
                                                            <asp:ListItem Text="57" Value="57"  ></asp:ListItem>
                                                            <asp:ListItem Text="58" Value="58"  ></asp:ListItem>
                                                            <asp:ListItem Text="59" Value="59"  ></asp:ListItem>                                                    
                                                            </asp:DropDownList>                                                           
                                                            </div>
                                                            <div style="padding-right:5px;float:right;" class="hdng_label">Characters Left:&nbsp;<asp:Label ID="lblPBPRemainingCharacters" runat="server" Font-Bold="true" CssClass="hdng_Label"></asp:Label></div>                                                            
                                                           </td>
						                                </tr>
                                                        <tr>
                                                        <td  valign="top" class="SimpleExSmallBold"> Notes: </td>
                                                        <td valign="top" class="SimpleExSmallBold" colspan="3">                                                                                          
                                                               <asp:TextBox ID="txtNotes" runat="server" style="width:98%;  font-size:11px;" onblur="return GetContentLength(this);" onkeydown="return GetContentLength(this);" onkeyup="return GetContentLength(this);"  CssClass="SmallGreenTextBox" Height="70px" TextMode="MultiLine" ></asp:TextBox>
                                                        </td>
                                                        <td style="width:20%;">
                                                        <table width="100%" cellpadding="0" cellspacing="0">
                                                        <tr style="height:25px;">
                                                            <td align="center" style="border:none;">
                                                          <input type="button" id="btnattch" style="height:20px; width:80px;"  class="LeadDetailGreenButton" onClick="showAttachFiles(); return false;" value="Attach File" />
                                                          </td>
                                                        </tr>
                                                        <tr style="height:25px;">
                                                            <td align="center" style="border:none;">
                                                             <input type="button" id="Button1" style="height:20px; width:80px;"   class="LeadDetailGreenButton" onClick="if (validateNotes() == true) {DivCloseMessage.style.display = 'inline';}" value="Save" />
                                                             </td>
                                                        </tr>
                                                        </table> </td>
                                                        </tr>
                                                    </table>	                
                                                    </div>  
                                                    <div id="DivNotesDisplay"  runat="server"  style="height:100%;overflow-y:auto;overflow-x: auto; padding-left:10px;padding-right:10px;" class="DivScroll" >                                                    
                                                      <asp:UpdatePanel ID="UpdatePanel2"
                                                         runat="server" 
                                                         UpdateMode="conditional" 
                                                         RenderMode="Inline">
                                                         <ContentTemplate>
                                                         <table id="tblRating" runat="server" cellpadding="2" cellspacing="0" border="0" width="99%" style="font-size:11px;width:99%;color:Black;">
                                                                <tr>
                                                                    <td style="width:100%;color:Black"><b>This ticket is closed and rated by franchisee in following areas</b></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
																		<table class="tblRaingValue" border="1" cellpadding="0" cellspacing="0">
																			<tr>
																				<td>Promptness: <b><asp:Label ID="lblPromptness" runat="server" Text="" ></asp:Label></b></td>
																				<td>Courteousness: <b><asp:Label ID="lblCourteousness" runat="server" Text="" ></asp:Label></b></td>
																				<td>Clarity: <b><asp:Label ID="lblClarity" runat="server" Text="" ></asp:Label></b></td>
																				<td>Knowledgeable: <b><asp:Label ID="lblKnowledgeable" runat="server" Text="" ></asp:Label></b></td>
																				<td>Overall Experience: <b><asp:Label ID="lblOverallExperience" runat="server" Text="" ></asp:Label></b></td>
																			</tr>
																		</table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width:100%;border-left:0px;border-bottom:1px solid #BDE4B8; border-bottom-style:dashed; padding-top:5px; font-size:11px;">
                                                                      <span id="spancomments" runat="server"><b>Comments:</b></span><br />
                                                                      <asp:Label ID="lblComments" runat="server" Text="" ></asp:Label>
                                                                    </td>
                                                                </tr>
                                                         </table> 
                                                        <asp:Repeater ID="rptrNotes" runat="server" DataSourceID="sdsNotes"  EnableViewState="false">
                                                            <HeaderTemplate>
                                                                <table width="100%" border="0" style="font-size:10px;" cellspacing="0" class="Table"  cellpadding="0" >
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                              <tr valign="top" style="height:20px;background-color:#FFFFFF;">
                                                                <td align="left" style="border-left:0px;border-bottom:1px solid #BDE4B8; border-bottom-style:dashed; padding-top:5px; font-size:11px;"    >
                                                               <b><%#Eval("ContactName")%>&nbsp;&nbsp;&nbsp; <%#String.Format("{0: MMMM dd, yyyy hh:mm:ss tt}", Eval("NotesDate"))%> <i> ( EST )</i></b><br />
                                                                    <asp:Repeater ID="rptrAttachments" runat="server"  >
                                                                         <HeaderTemplate >
                                                                            <span style="font-style:italic;"><br />Attachment(s):</span>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <span >[<a href='<%= Functions.GetAttachmentUploadFolder(hdnClientID.Value)  %><%#  Container.DataItem("FilePath")  %>' target="_blank"><%#Container.DataItem("FilePath").Substring(Container.DataItem("FilePath").LastIndexOf("\") + 1, Container.DataItem("FilePath").Length - (Container.DataItem("FilePath").LastIndexOf("\") + 1))%> </a>] &nbsp;</span>
                                                                        </ItemTemplate>
                                                                    </asp:Repeater>
                                                                <br /><asp:Label ID="lblID" runat="Server" Visible="false" Text='<%#Eval("ID")%>' ></asp:Label>
                                                              <span style="<%#IIF( Cbool(Eval("Type")) = True , "color:Blue;","color:Black;") %>"><%#Eval("Notes").ToString().Replace(vbCrLf, "</br>")%>
                                                                    <br />
                                                                    <br />                                                                    
                                                                </td>                                    
                                                              </tr>                  
                                                            </ItemTemplate>
                                                            <FooterTemplate>               
                                                           </table>
                                                         </FooterTemplate>
                                                        </asp:Repeater>                                            
                                                            <table  cellpadding="0" cellspacing="0"  border="0" width="100%"  >
                                                                 <tr>
                                                                        <td>
                                                                             <table cellpadding="2" cellspacing="0" border="0" width="100%" style="font-size:11px;">                                                                    
                                                                                <tr>
                                                                                    <td colspan="3">                                                                        
                                                                                    <asp:Repeater ID="rptrStartActivityAttachments" runat="server"   EnableViewState="false" DataSourceID="sdsActivityAttachments" >
                                                                                         <HeaderTemplate >
                                                                                                <span style="font-style:italic;" class="SimpleExSmall"><br />Attachment(s):</span>
                                                                                         </HeaderTemplate>
                                                                                         <ItemTemplate>
                                                                                            <span class="SimpleExSmall">[<a href='<%= Functions.GetAttachmentUploadFolder(hdnClientID.Value) %><%#  Container.DataItem("FilePath")  %>' target="_blank"><%#Container.DataItem("FilePath").Substring(Container.DataItem("FilePath").LastIndexOf("\") + 1, Container.DataItem("FilePath").Length - (Container.DataItem("FilePath").LastIndexOf("\") + 1))%> </a>] &nbsp;</span>
                                                                                         </ItemTemplate>
                                                                                         <FooterTemplate>
                                                                                         </FooterTemplate>
                                                                                    </asp:Repeater>
                                                                                    </td>
                                                                                </tr>    
                                                                                <tr>                                                                                           
                                                                                    <td style="width:80%;" class="SimpleExSmall" >Original message sent by  <b> <asp:Label ID="lbladminName" runat="server" Text="" ></asp:Label> <asp:Label ID="lblDepartmentName" runat="server" Text="" ></asp:Label> on &nbsp;&nbsp; <asp:Label ID="lblDate" runat="server" Text="" ></asp:Label></b> <br /></td>
                                                                                    <td style="width:10%;" align="right"> </td>  
                                                                                    <td style="width:5%;">  </td>                           
                                                                                </tr>                                   
                                                                                <tr>                                                                                 
                                                                                    <td colspan="3"  class="SimpleExSmall">
                                                                                    <br />
                                                                                      <asp:Label ID="lblDescription" runat="server" Text="" ></asp:Label>  <br />            
                                                                                    </td>
                                                                                    <td> </td>
                                                                                </tr>      
                                                                            </table>                                 
                                                                        </td>
                                                                    </tr>                           
                                                                <tr>
                                                                  <td style="height:2px;">
                                                                  </td>
                                                              </tr>        
                                                            </table>                                                                          
                                                       </ContentTemplate>                                                                                        
                                                        </asp:UpdatePanel>                                       
                                                       </div> 
                                                        <asp:ObjectDataSource ID="sdsNotes" runat="server" 
                                                                SelectMethod="GetNotesByActivityID"
                                                                TypeName="Portal.BLL.ActivityNotes">                                    
                                                            <SelectParameters>                                                                                         
                                                              <asp:ControlParameter Name="ActivityID" DefaultValue="0"  ControlID="hdnID" Type="int32" PropertyName="value" />                                
                                                            </SelectParameters>
                                                       </asp:ObjectDataSource>
                                                        <asp:SqlDataSource 
                                                            ID="sdsAttachments" 
                                                            runat="server" 
                                                            ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"                                                        
                                                            SelectCommand="Portal_GetAttachmentByActivityID" SelectCommandType="StoredProcedure" >
                                                            <SelectParameters >
                                                                 <asp:ControlParameter  Name="ActivityID" DefaultValue="0"  ControlID="hdnID" Type="int32" PropertyName="value" />                                        
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                         <asp:SqlDataSource 
                                                            ID="sdsActivityAttachments" 
                                                            runat="server" 
                                                            ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"                                                        
                                                            SelectCommand="Portal_GetActivityAttachment" SelectCommandType="StoredProcedure" >
                                                            <SelectParameters >
                                                                 <asp:ControlParameter  Name="ActivityID" DefaultValue="0"  ControlID="hdnID" Type="int32" PropertyName="value" />                                        
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>  
                                               </td>                                                                      
                                           </tr>
                                           <tr>
                                               <td style="width:100%; height:100%; vertical-align:top;" >
                                                      
                                              </td>
                                           </tr>
                                       </table> 
                                    </td>
                                </tr>
                            </table>  
                         </div>            
                      </td>
                    </tr>          
                     <tr style="background-color:#BDE7BD;">
                         <td style="border-top:1 solid #609BD3;" > 
                         <asp:UpdatePanel ID="updatePanelStatus" runat="server" UpdateMode="Always" ChildrenAsTriggers="true" RenderMode="Block" >
                         <ContentTemplate>
                         <asp:HiddenField ID="hdnIsClose" runat="server" Value="0" />
                          <table style="width:100%; height:100%" border="0" cellpadding="0" cellspacing="0" >
                            <tr style="height:31;" >
                                <td class="SimpleExSmall" style="width:15%">
                                   <div runat="server"  id="divStatus">&nbsp;Status:&nbsp;                           
                                        <asp:DropDownList ID="ddlActivityStatus"   
                                            CssClass="SmallGreenTextBox"  
                                            AutoPostBack="true" 
                                            runat="server">
                                            <%--<asp:ListItem Value="0" Text="Select..." ></asp:ListItem>--%>
                                           <asp:ListItem Value="1" Text="Not Started" ></asp:ListItem>
                                            <asp:ListItem Value="2" Text="In Progress" ></asp:ListItem>
                                            <asp:ListItem Value="4" Text="Waiting For" ></asp:ListItem>
                                            <asp:ListItem Value="3" Text="Completed" ></asp:ListItem>
                                           <asp:ListItem Value="5" Text="Scheduled" ></asp:ListItem>                                 
                                        </asp:DropDownList>
                                   </div>
                                   <div runat="server"  id="divClose" style="display:none;">&nbsp;Status:&nbsp;
                                        <asp:DropDownList ID="ddlClose"   
                                            CssClass="SmallGreenTextBox"  
                                            AutoPostBack="true" 
                                            runat="server">
                                            <asp:ListItem Value="0" Text="Open" ></asp:ListItem>
                                            <asp:ListItem Value="1" Text="Close" Selected="True" ></asp:ListItem>                                                               
                                        </asp:DropDownList>
                                   </div>
                                </td>
                                <td class="SimpleExSmall"  style="width:60%; ">
                                    <div  runat="server" id="waitingfor" style="display:none;"> 
                                    <asp:DropDownList ID="ddlWaitingFor" 
                                        runat="server" 
                                        ValidationGroup="WaitingFor" 
                                        AutoPostBack="true" 
                                        CausesValidation="true"   
                                        OnDataBound="ddlWaitingFor_DataBound" 
                                        DataSourceID="sdsWaitingFor" 
                                        DataTextField="Name"  
                                        CssClass="SmallGreenTextBox" 
                                        DataValueField="ID"  Width="50%" >
                                    </asp:DropDownList>
                                        <asp:SqlDataSource ID="sdsWaitingFor" runat="server"
                                            ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>" 
                                            SelectCommand="Activities_GetAllWaitingFor_ByFranchiseID" 
                                            SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="hdnClientID" Name="ClientID" PropertyName="Value" />
                                                <asp:ControlParameter ControlID="hdnFranchiseID" Name="FranchiseID" PropertyName="Value" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <asp:CompareValidator
                                            ID="val_waitingfor"
                                            runat="server"
                                            ControlToValidate="ddlWaitingFor"
                                            ValueToCompare="0"
                                            Type="string"
                                            Operator="NotEqual"
                                            ValidationGroup="WaitingFor"
                                            ErrorMessage="Please choose Waiting For."
                                            Display="Dynamic" /></div>
                                </td>
                                <td style="width:25%;" align="right">                             
                                         <asp:Button ID="btnBack" runat="server"  CssClass="Btn3D" CausesValidation="false" Text="Back" Width="80px" />&nbsp;&nbsp;
                                </td>
                             </tr>
                             </table>
                             </ContentTemplate>
                             <Triggers>
                             <asp:AsyncPostBackTrigger ControlID ="ddlActivityStatus" EventName="SelectedIndexChanged" /> 
                             <asp:AsyncPostBackTrigger ControlID ="ddlClose" EventName="SelectedIndexChanged" /> 
                             </Triggers>
                             </asp:UpdatePanel>
                           <ajaxToolkit:UpdatePanelAnimationExtender ID="updatePanelAnimation" BehaviorID="animation" runat="server" TargetControlID="updatePanelStatus">
                            <Animations>
                                <OnUpdating>
                                    <Sequence>               
                                        <Parallel duration="0.5">
                                            <ScriptAction Script="onUpdating();" />
                                            <EnableAction AnimationTarget="ddlActivityStatus" Enabled="false" />                           
                                            <FadeOut minimumOpacity=".5" />
                                            <FadeOut AnimationTarget="DivNotesDisplay" minimumOpacity=".5" />                      
                                        </Parallel>
                                        <StyleAction Attribute="overflow" Value="hidden" />
                                    </Sequence>
                                  </OnUpdating>
                                    <OnUpdated>
                                        <Sequence>
                                            <Parallel duration="0.5">
                                                <ScriptAction Script="onUpdated();" />                                                         
                                                      <EnableAction AnimationTarget="ddlActivityStatus" Enabled="true" />
                                                      <FadeIn minimumOpacity=".5" />
                                                      <FadeIn AnimationTarget="DivNotesDisplay" minimumOpacity="1" />                          
                                            </Parallel>
                                        </Sequence>
                                    </OnUpdated>
                            </Animations>
                        </ajaxToolkit:UpdatePanelAnimationExtender>              
                         </td>
                    </tr>      
               </table>
           </td>
         </tr>
       </table>
    </div>
    <div align="center" id="Attachment" style="display:none; border:0px solid black; position:absolute;left:30%; top:35%; width: 450px; height: 210px;">
       <table align="center" width="100%" cellpadding="0" cellspacing="0" class="MainAlertDiv">
	      <tr>
	        <th style="height:21px;" align="left" valign="middle">&nbsp;Add - Attachments</th>
	        <th align="right" valign="top"><img src="../images/closebox2.gif" onClick="OnAttachmentSubmit(); return false;" style="cursor:pointer;" alt="" /></th>
	      </tr>
	      <tr>
	        <td style="width:100%;" valign="top" colspan="2">
		        <table align="center" width="100%" cellpadding="0" cellspacing="0" class="MainAlertDiv" style="border:none;">
			        <tr>
			            <td align="center" style="height:25px;" colspan="2">Attach Files!</td>
			        </tr>
                    <tr>
                        <td></td>
                        <td  style="height:25px;" >
                            <font size="2" face="verdana, Arial, Helvetica, sans-serif">
                            &nbsp;File 1: <span id="spnFile1">
                                                <asp:FileUpload id="file1" Runat="server" style="width:330px;" />
                                                <asp:RegularExpressionValidator 
                                                    id="REV_file1" runat="server" 
                                                    validationgroup="valNotes"
                                                    ErrorMessage="Attachment must be a .jpg, .jpeg, .png, .gif, .doc, .pdf, .txt, .rtf or .zip file" 
                                                    ValidationExpression="^.*(.txt|.zip|.doc|.jpg|.jpeg|.png|.gif|.doc|.docx|.pdf|.rtf|.xls|.xlsx|.rar|.TXT|.ZIP|.DOC|.DOCX|.XLS|.XLSX|.JPG|.JPEG|.PNG|.GIF|.DOC|.DOCX|.XLS|.XLSX|.RAR|.PDF|.RTF)$"  
                                                    Display="Dynamic"                                           
                                                    ControlToValidate="file1">
                                                </asp:RegularExpressionValidator>
                                           </span><br>
                            &nbsp;File 2: <span id="spnFile2">
                                                <asp:FileUpload id="file2" Runat="server" style="width:330px;" />
                                                <asp:RegularExpressionValidator 
                                                    id="REV_file2" runat="server" 
                                                    validationgroup="valNotes"
                                                    ErrorMessage="Attachment must be a .jpg, .jpeg, .png, .gif, .doc, .pdf, .txt, .rtf or .zip file" 
                                                    ValidationExpression="^.*(.txt|.zip|.doc|.jpg|.jpeg|.png|.gif|.doc|.docx|.pdf|.rtf|.xls|.xlsx|.rar|.TXT|.ZIP|.DOC|.DOCX|.XLS|.XLSX|.JPG|.JPEG|.PNG|.GIF|.DOC|.DOCX|.XLS|.XLSX|.RAR|.PDF|.RTF)$"  
                                                    Display="Dynamic"                                           
                                                    ControlToValidate="file2">
                                                </asp:RegularExpressionValidator>
                                          </span><br>
                            &nbsp;File 3: <span id="spnFile3">
                                                <asp:FileUpload id="file3" Runat="server" style="width:330px;" />
                                                <asp:RegularExpressionValidator 
                                                    id="REV_file3" runat="server" 
                                                    validationgroup="valNotes"
                                                    ErrorMessage="Attachment must be a .jpg, .jpeg, .png, .gif, .doc, .pdf, .txt, .rtf or .zip file" 
                                                    ValidationExpression="^.*(.txt|.zip|.doc|.jpg|.jpeg|.png|.gif|.doc|.docx|.pdf|.rtf|.xls|.xlsx|.rar|.TXT|.ZIP|.DOC|.DOCX|.XLS|.XLSX|.JPG|.JPEG|.PNG|.GIF|.DOC|.DOCX|.XLS|.XLSX|.RAR|.PDF|.RTF)$"  
                                                    Display="Dynamic"                                           
                                                    ControlToValidate="file3">
                                                </asp:RegularExpressionValidator>
                                           </span>
                           </font>
                       </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height:30px;" align="center">
                            <input type="button" value="OK" style="width:80px;"  onclick="OnAttachmentSubmit();"  class="btnExtraSimple" />&nbsp;
                        </td>
                    </tr>
                </table>
            </td>
          </tr>
	   </table>
    </div>
    <div align="center" id="DivCloseMessage" style="display: none; border: 0px solid black; position: absolute; left: 20%; top: 45%; width: 355px; height: 128px;"> 
	  <table width="100%"  cellpadding="0" cellspacing="0" class="MainAlertDiv">
		<tr>
		  <th style="height:21px;" colspan="2"  align="left" valign="middle">&nbsp;Ticket Close Confirmation - Alert</th>
		  </tr>
		<tr>
			<td style="width:100%;" align="left" valign="middle">
				<table align="center" width="100%" cellpadding="0" cellspacing="0" class="MainAlertDiv" style="border:none;">
					<tr>
					    <td align="center" style="height:25px;" colspan="2" class="SimpleSmallBold"></td></tr>
					<tr>
					<td  valign="Top" align="right">&nbsp;&nbsp;<img src="../images/ico_alert.gif" align="absmiddle" alt="" />&nbsp;&nbsp;</td>
					<td  style="height:25px;" class="SimpleSmallBold">Would you like to close this activity. </td></tr>
					<tr><td colspan="2" style="height:50px;" align="center">
					<asp:Button ID="btnCloseYes" runat="server" OnClientClick="ButtonYesOrNoPressed()"  CssClass="btnExtraSimple" CausesValidation="True" validationgroup="valNotes" Text="Yes" Width="70px" />
					<asp:Button ID="btnCloseNo" runat="server" OnClientClick="ButtonYesOrNoPressed()" CssClass="btnExtraSimple" CausesValidation="false" Text="No" Width="70px" />
                    <input type="button" name="btnCancel" value="Cancel" onClick="DivCloseMessage.style.display = 'none';" style="width:70px;" class="btnExtraSimple" /> 
                    </td></tr>
				</table>
			</td>
		</tr>
	 </table>
    </div>
    <div id="DivOption" runat="server"  style="display:none;border:solid 1px #000000; position:absolute; width:600px;  height:220px;top:15%; left:10%; z-index:10;"    >
          <table style="height:100%;" cellpadding="0" border="0" cellspacing="0"   >
           <tr>    
              <td align="left" style="border-bottom:solid 1px #000000;padding-top:4px; padding-left:1em;vertical-align:middle; background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
                  <label id="Label1" title="Notes"    style="color:White;height:100%; overflow:auto; font-weight:bold;"  >Contact Information</label>
              </td>
              <td  style="border-bottom:solid 1px #000000;background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%; height:28px; cursor:pointer;">
                  <img src="../images/win_btn_close_black.jpg" style="float:right;" alt="Close Window" onClick="DivOptionHide();" />
              </td>               
           </tr>
           <tr valign="top">                
             <td colspan="2" style="height:100%; padding:0px; font-size:12px; background-color:White;" >   
             <iframe name="IfContactProfile" runat="server" id="IfContactProfile" src="Blank.aspx" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
             </td>
           </tr>            
          </table>
        </div>
        <div id="DivMessageAlert" style="display:none;border:solid 1px #609BD3; position:absolute;width:400px;z-index:10;">
          <table style="height:100%;" cellpadding="0" border="0" cellspacing="0"   >
           <tr>    
              <td align="left" style="border-bottom:solid 1px #609BD3; padding-left:5px;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=#ABD0E8,endColorStr=#FAFCFE);width:80%;">
                  <span title="Franchises Support Expiration Alert" style="color:black;font-weight:bold;font-size:12px;">Franchises Support Expiration Alert</span>
              </td>
              <td  style="border-bottom:solid 1px #609BD3;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=#FAFCFE,endColorStr=#FFFFFF);width:20%;height:24px;cursor:pointer;">
                  <img src="../images/btn_close.gif" style="float:right;" alt="Close Window" onClick="Reset();" />
              </td>               
           </tr>
           <tr valign="top">                
             <td colspan="2" style="width:100%;font-size:12px;">
                <table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%;text-align:center;font-size:12px;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#ABD0E8,endColorStr=#FFFFFF);">
                  <tr style="font-weight:bold;padding-top:5px;">
                     <td>The following Product(s) with are expirated or not supported.</td>
                  </tr>
                  <tr >
                     <td style="height:100%;width:100%;">
                         <%--<table border="0" cellpadding="3" cellspacing="0" style="background-color:white;width:100%;font-size:12px;">
                           <tr style="color:#52789C;font-weight:bold;height:21px;">
                                <td style="width:100px;border-right:solid 1px #6B8AC1;border-bottom:solid 1px #6B8AC1;border-top:solid 1px #6B8AC1;">Product</td>
                                <td style="border-bottom:solid 1px #6B8AC1;border-top:solid 1px #6B8AC1;white-space:nowrap;">Expiration Date</td>
                            </tr>
                        </table>--%>
                        <div style="overflow-y:auto;height:120px;width:400px;">
                        <asp:Repeater
                            runat="server"
                            ID="rptrContactInfo"
                            DataSourceID="sdsContactInfo">
                            <HeaderTemplate>
                            <table id="tbsamplevalue" border="0" cellpadding="3" cellspacing="0" style="width:100%;font-size:12px;">
                            <tr style="color:#52789C;font-weight:bold;height:21px;background-color:white;top:expression(eval(this.parentElement.parentElement.parentElement.scrollTop));position:relative;">
                                <td style="width:150px;border-right:solid 1px #6B8AC1;border-bottom:solid 1px #6B8AC1;border-top:solid 1px #6B8AC1;">Product</td>
                                <td style="width:100px;border-right:solid 1px #6B8AC1;border-bottom:solid 1px #6B8AC1;border-top:solid 1px #6B8AC1;white-space:nowrap;">Expiration Date</td>
                                <td style="width:150px;border-right:solid 1px #6B8AC1;border-bottom:solid 1px #6B8AC1;border-top:solid 1px #6B8AC1;display:<%#iif(hdnHasSupportAccess.value,"inline","none") %>;">Action</td>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr style="height:22px;">
                                    <td style="width:150px;border-bottom:solid 1px #C9EAFC;"><%#Eval("ProductName")%></td>
                                    <td style="width:100px;border-bottom:solid 1px #C9EAFC;white-space:nowrap;"><%#IIf(Eval("OnSupport") = False, "Not On Support", "<b>" & String.Format("{0:MMM dd, yyyy}", Eval("SupportEndDate")) & "</b>")%></td>
                                    <td style="width:150px;border-bottom:solid 1px #C9EAFC;display:<%#iif(hdnHasSupportAccess.value,"inline","none") %>;"><a href='#' onClick="signup('<%#Eval("ProductsFranchisesID")%>','<%#Eval("FranchiseID")%>','<%#Eval("ClientID")%>','<%#Eval("ProductID")%>','<%#Eval("OnSupport")%>');"><%#IIf(Eval("OnSupport") = False AndAlso Eval("ProductsFranchisesID") = 0, "Sign Up", IIf(Eval("OnSupport") = False AndAlso Eval("ProductsFranchisesID") > 0, "Turn On", "Edit"))%></a></td>
                                </tr>    
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                        <asp:SqlDataSource 
                            ID="sdsContactInfo" 
                            runat="server" 
                            ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>" 
                            SelectCommand="com_NS_Product_Franchises_SupportEndDateByID" 
                            SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter Name="FranchiseID" ControlID="hdnFranchiseID" PropertyName="Value" DefaultValue="0"  />
                                <asp:ControlParameter Name="ProductID" ControlID="hdnRelatedTo" PropertyName="Value" DefaultValue="0"  />

                            </SelectParameters>
                        </asp:SqlDataSource> 
                        </div> 
                     </td>
                  </tr>
                  <tr style="font-weight:bold;padding-bottom:5px;padding-top:5px;">
                     <td>Do you want to proceed ?</td>
                  </tr>
                  <tr>
                    <td style="padding-bottom:5px;">
                        <INPUT class="Btn3D" id="Button2" style="WIDTH: 80px" onClick="Reset();" type="button"  name="btnOK" value="Yes" />
                        &nbsp;
                        <INPUT class="Btn3D" id="Button3" style="WIDTH: 80px" onClick="javascript:history.back();" type="button" name="btnCancle" value="No" />
                    </td>
                  </tr>
                </table>
             </td>
           </tr>            
          </table>
        </div>
  <div id="backgroundFilter">
  </div>
        <script type="text/javascript">
    function validateSameFiles(oSrc, args)
    {
        if ( (getElement('<%= File1.ClientID %>').value == getElement('<%= File2.ClientID %>').value && getElement('<%= File1.ClientID %>').value != '' && getElement('<%= File2.ClientID %>').value != '') || 
             (getElement('<%= File1.ClientID %>').value == getElement('<%= File3.ClientID %>').value && getElement('<%= File1.ClientID %>').value != '' && getElement('<%= File3.ClientID %>').value != '') || 
             (getElement('<%= File2.ClientID %>').value == getElement('<%= File3.ClientID %>').value && getElement('<%= File2.ClientID %>').value != '' && getElement('<%= File3.ClientID %>').value != '') )
           args.IsValid = false
        else
           args.IsValid = true;
    }
    
    function validateFiles(oSrc, args){
        if ( (getElement('<%= File1.ClientID %>').value == '') && 
             (getElement('<%= File2.ClientID %>').value == '') &&
             (getElement('<%= File3.ClientID %>').value == '') )
            args.IsValid = false
        else
            args.IsValid = true;
    }
 

     function Notes()
       {           
           var ActivityState = document.getElementById('<%=hdnIsClose.ClientID %>');
           if (ActivityState.value != 'True')
             { 
               if (DivNotes.style.display=='none')
	                {
		                DivNotes.style.display = 'inline';
		                DivNotesDisplay.style.height = '75%';	
		                 document.getElementById('<%=btnAddNotes.ClientID%>').innerText = 'Cancel';
		                 document.getElementById('<%=txtNotes.ClientID%>').focus();
	                }
                else
	                {
	                     ResetAttachment3();ResetAttachment2();ResetAttachment1();	
	                     if (getElement('trFiles').style.display = 'inline')
	                        {
	                        getElement('trFiles').style.display = 'none';
	                        }
	                     if ( document.getElementById("Attachment").style.display == 'inline' )
	                        {
	                        getElement('Attachment').style.display = 'none';
                            
	                        setWindowedControlsVisibility(window, 'visible');
	                        }
	                    
		                DivNotes.style.display = 'none';
		                DivNotesDisplay.style.height = '100%';
		                document.getElementById('<%=txtNotes.ClientID%>').innerText = '';
		                document.getElementById('<%=ddlHours.ClientID%>').value = 0;
		                document.getElementById('<%=ddlMinutes.ClientID%>').value = 0;
		                document.getElementById('<%=btnAddNotes.ClientID%>').innerText = 'Add Notes';
	                }
	         }
       }
       
       function activityStateChange()
            {

            var ActivityState = document.getElementById('<%=ddlActivityStatus.ClientID %>')
            var WaitingFor = document.getElementById('<%=waitingfor.ClientID %>')
	            if (ActivityState.value == "4")
	                {
		            WaitingFor.style.display = 'inline';
		            return false;
		            }            		
	            else
		            {
		            WaitingFor.style.display = 'none';		
		            //setTimeout('__doPostBack(\'ctl00$Content$ddlActivityStatus\',\'\')', 0);
		             return true;
		            }
            		
            }


        function ResetAttachment2()
             {
//               var Fupload = document.getElementById('<%=File2.ClientID%>');
//               var TD = Fupload.parentElement ;
//               var str = TD.innerHTML;
//                str = str.replace(Fupload.value,'');
             	//                TD.innerHTML = str ;
             	form1.file2.parentNode.innerHTML = form1.file2.parentNode.innerHTML;
               } 
      function ResetAttachment1()
              {
             
//               var Fupload = document.getElementById('<%=File1.ClientID%>');
//                var TD = Fupload.parentElement ;
//               var str = TD.innerHTML;
//                str = str.replace(Fupload.value,'');
//                TD.innerHTML = str ;
              	form1.file1.parentNode.innerHTML = form1.file1.parentNode.innerHTML;
               } 
   
      function ResetAttachment3()
              {
             
//               var Fupload = document.getElementById('<%=File3.ClientID%>');
//                var TD = Fupload.parentElement ;
//               var str = TD.innerHTML;
//                str = str.replace(Fupload.value,'');
//                TD.innerHTML = str ;
              	form1.file3.parentNode.innerHTML = form1.file3.parentNode.innerHTML;
               } 
      function showAttachFiles()
            {
                document.getElementById("Attachment").style.display='inline'; 
                try{setWindowedControlsVisibility(window, 'visible');}catch(e){}                              
                try{setWindowedControlsVisibility(window, 'hidden');}catch(e){} 
            } 
      function HideAttachFiles()
         {
            if (document.getElementById("Attachment").style.display == 'inline')
            {
                getElement('Attachment').style.display = 'none';
                setWindowedControlsVisibility(window, 'visible');       
            }
         }
     function textCounter(field)
         {
       
            if (field.value.length > 500)        
            field.value = field.value.substring(0, 500);
         }
    
    function ShowUpdateMessage()
         {
            document.getElementById('spnUpdateMessage').style.display = 'inline' ;       
            setTimeout('HideUpdateMessage()' , 3000)
         }
     
    function HideUpdateMessage()
         {       
            document.getElementById('spnUpdateMessage').style.display = 'none' ;
         }   
     
     
     function OnAttachmentSubmit(flagCancel)
        {
            var hdnRegularExprssion =  document.getElementById('<%=hdnRegularExprssion.ClientID%>');            
            var FileExp = new RegExp(hdnRegularExprssion.value); 
            //var FileExp = new RegExp("^.*(.txt|.zip|.doc|.jpg|.jpeg|.png|.gif|.doc|.docx|.pdf|.rtf|.xls|.xlsx|.rar|.TXT|.ZIP|.DOC|.DOCX|.XLS|.XLSX|.JPG|.JPEG|.PNG|.GIF|.DOC|.DOCX|.XLS|.XLSX|.RAR|.PDF|.RTF)$"); 
	        if (flagCancel == 1)
	        {
		        ResetAttachment3();ResetAttachment2();ResetAttachment1();
	        }
	        else 
	        {
	             if(!(FileExp.test(trim(document.getElementById('<%=File1.ClientID%>').value))))
	             {
	             ResetAttachment1();
	             }
	             if(!(FileExp.test(trim(document.getElementById('<%=File2.ClientID%>').value))))
	             {
	             ResetAttachment2();
	             }
	             if(!(FileExp.test(trim(document.getElementById('<%=File3.ClientID%>').value))))
	             {
	             ResetAttachment3();
	             }
	         
	        }        
        	
	        getElement('Attachment').style.display = 'none';	
	        var strFiles = '';
	       if (trim(document.getElementById('<%=File1.ClientID%>').value) != '')
		        strFiles += '<table style=\'display:inline;\' class=SimpleExSmallBold><tr><td rowspan=2 style=\'border:none;\'>&nbsp;&nbsp;</td><td style=\'border:none;\'>'+trimFileName(getElement('file1').value.substr(getElement('file1').value.lastIndexOf("\\")+1))+'</td></tr><tr><td style=\'cursor:pointer;font-size:7px;border:none;\' align=right onClick=\'ResetAttachment1();OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>' ;
	        if (trim(document.getElementById('<%=File2.ClientID%>').value) != '')
		        strFiles += '<table style=\'display:inline;\' class=SimpleExSmallBold><tr><td rowspan=2 style=\'border:none;\'>&nbsp;&nbsp;</td><td style=\'border:none;\'>'+trimFileName(getElement('file2').value.substr(getElement('file2').value.lastIndexOf("\\")+1))+'</td></tr><tr><td style=\'cursor:pointer;font-size:7px;border:none;\' align=right onClick=\'ResetAttachment2();OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>' ;
	        if (trim(document.getElementById('<%=File3.ClientID%>').value) != '')
		        strFiles += '<table style=\'display:inline;\' class=SimpleExSmallBold><tr><td rowspan=2 style=\'border:none;\'>&nbsp;&nbsp;</td><td style=\'border:none;\'>'+trimFileName(getElement('file3').value.substr(getElement('file3').value.lastIndexOf("\\")+1))+'</td></tr><tr><td style=\'cursor:pointer;font-size:7px;border:none;\' align=right onClick=\'ResetAttachment3();OnAttachmentSubmit(0);\'>[ R E M O V E ]</td></tr></table>' ;
        	
	        if (strFiles == '')
	        {
		        getElement('trFiles').style.display = 'none';
		        getElement('tdFiles').innerHTML = '';
	        }
	        else
	        {
	        
		        getElement('trFiles').style.display = 'inline';
		        getElement('tdFiles').innerHTML = strFiles;	
	        }
	        strFiles = '';                                    
           
	        setWindowedControlsVisibility(window, 'visible');
        }
        
        
        
        function trimFileName(strFileName)
            {
	            if (strFileName.length > 20)
		            return strFileName.substr(0,20)+' ...';
	            else
		            return strFileName;
            }
            
   //  Validate Notes
            
     
   function validateNotes()
        {
	        var ret = false;
	        var reExp = new RegExp("^[\\s\\S]{0,4000}$"); 
	        if (trim(document.getElementById('<%=txtNotes.ClientID%>').value) == '')
	        {
		        alert('Please enter some notes.');
		        ret = false
	        }	
	        else if(!(reExp.test(trim(document.getElementById('<%=txtNotes.ClientID%>').value))))
	        {
	         alert('Maximum 4000 character allowed.');
		        ret = false
	        }
	        else if ((document.getElementById('<%=ddlMinutes.ClientID%>').value == 0) && (document.getElementById('<%=ddlHours.ClientID%>').value == 0) )
	        {
	            alert('Please enter Time Spent.');
		        ret = false
	        
	        }	        
	        else
	        {	        
		        ret = true;
	        }
	        return ret;
        }
        function onUpdating()
        {
            var ddlActivityStatus = getElement('<%= ddlActivityStatus.ClientID %>')          
            var btnUpdateDueDate = getElement('<%= btnUpdateDueDate.ClientID %>')
            //var ddlHoursNotes = getElement('<%= ddlHoursNotes.ClientID %>')
            //var ddlMinutesNotes = getElement('<%= ddlMinutesNotes.ClientID %>')
            var ddlFranchiseContact = getElement('<%= ddlFranchiseContact.ClientID %>')
            
            var btnBack = getElement('<%= btnBack.ClientID %>')  
            var btnAddNotes = getElement('<%= btnAddNotes.ClientID %>')  
            var btnNewActivity = getElement('<%= btnNewActivity.ClientID %>')  
            var ddlHours = getElement('<%= ddlHours.ClientID %>')
            var ddlMinutes = getElement('<%= ddlMinutes.ClientID %>')
            var Button1 = getElement('Button1')
            var ddlNotesTypes = getElement('<%= ddlNotesType.ClientID %>')
            var ddlClose = getElement('<%= ddlClose.ClientID %>')
            if (ddlActivityStatus.disabled !=null)
            {
                ddlActivityStatus.disabled = true;
            }                        
            if(btnUpdateDueDate != null)
            {
                btnUpdateDueDate.disabled = true;
            }           
            if(btnBack != null)
            {
                btnBack.disabled = true;
            }           
//            if(ddlHoursNotes !=null)
//            {
//                ddlHoursNotes.disabled = true;
//            }
//            if(ddlMinutesNotes != null)
//            {
//               ddlMinutesNotes.disabled = true;
//            }             
            if(btnNewActivity != null)
            {
                btnNewActivity.disabled = true;
            }
            if(ddlFranchiseContact != null)
            {
                ddlFranchiseContact.disabled = true
            }            
            if(ddlClose !=null)
            {
                ddlClose.disabled = true;
            }                     
           if (btnAddNotes != null)
           {
                  btnAddNotes.disabled = true;            
           }
           if(ddlHours != null)
           {
            ddlHours.disabled = true;
           } 
           if(ddlMinutes !=null)
           {
                ddlMinutes.disabled = true;
           }          
           if(Button1 != null)
           {
                Button1.disabled = true;
           }
           if(ddlNotesTypes !=null)
           {
                ddlNotesTypes.disabled = true;
           }
          if (DivNotes.style.display == "inline")
          {        
              DivNotes.style.display = "none";
              DivNotesDisplay.style.height = '100%';
		      document.getElementById('<%=btnAddNotes.ClientID%>').innerText = 'Add Notes';
          }       
          if (ddlActivityStatus.value == 4)
          {
            var ddlWaitingFor = getElement('<%= ddlWaitingFor.ClientID %>')
            ddlWaitingFor.disabled = true;            
          }
          getElement('img1').disabled = true;       
        }
    function onUpdated()
    {
           
                
            var ddlActivityStatus = getElement('<%= ddlActivityStatus.ClientID %>') 
            var btnUpdateDueDate = getElement('<%= btnUpdateDueDate.ClientID %>')
            //var ddlHoursNotes = getElement('<%= ddlHoursNotes.ClientID %>')
            //var ddlMinutesNotes = getElement('<%= ddlMinutesNotes.ClientID %>')            
            var btnBack = getElement('<%= btnBack.ClientID %>')  
            var btnAddNotes = getElement('<%= btnAddNotes.ClientID %>')
            var btnNewActivity = getElement('<%= btnNewActivity.ClientID %>') 
            var ddlFranchiseContact = getElement('<%= ddlFranchiseContact.ClientID %>')
            var ddlHours = getElement('<%= ddlHours.ClientID %>');
            var ddlMinutes = getElement('<%= ddlMinutes.ClientID %>');
            var Button1 = getElement('Button1');
            var ddlNotesTypes = getElement('<%= ddlNotesType.ClientID %>');
            var ddlClose = getElement('<%= ddlClose.ClientID %>')
            if(ddlActivityStatus !=null)
            {
                ddlActivityStatus.disabled = false; 
            }           
            
            if(btnUpdateDueDate !=null)
            {
                 btnUpdateDueDate.disabled = false; 
            }
            if(btnBack !=null)
            {
                btnBack.disabled = false;
            }            
//            if(ddlHoursNotes !=null)
//            {
//                ddlHoursNotes.disabled = false;
//            }
//            if(ddlMinutesNotes !=null)
//            {
//               ddlMinutesNotes.disabled = false;
//            }
            if(btnNewActivity !=null)
            {
                btnNewActivity.disabled = false;
            }
            if(ddlFranchiseContact !=null)
            {
                 ddlFranchiseContact.disabled = false;          
            }           
           
           
            
            
            if(ddlClose !=null)
            {
                ddlClose.disabled = false;
            }
           if (btnAddNotes != null)            
           {   
               btnAddNotes.disabled = false;
           } 
           if(ddlHours != null)
           {
            ddlHours.disabled = false;
           }            
           if(ddlMinutes !=null)
           {
                ddlMinutes.disabled = false;
           }
           if(Button1 != null)
           {
                Button1.disabled = false;
           }
           if(ddlNotesTypes !=null)
           {
                ddlNotesTypes.disabled = false;
           }
            if (DivNotes.style.display == "inline")
            {        
                DivNotes.style.display = "none";
                DivNotesDisplay.style.height = '100%';
		        document.getElementById('<%=btnAddNotes.ClientID%>').innerText = 'Add Notes';
            }           
            if (ddlActivityStatus.value == 4)
            {
             var ddlWaitingFor = getElement('<%= ddlWaitingFor.ClientID %>')
             ddlWaitingFor.disabled = false;
            }
            		             
            getElement('img1').disabled = false;

 
    }
        
  //  Contatc Display 
        
  
   function showContact()
        {
            var DivOption = getElement('<%= DivOption.ClientID %>');
            var divDisable = getElement('divDisable');     
            divDisable.style.width = document.body.scrollWidth
            divDisable.style.height = document.body.scrollHeight
            divDisable.style.display= "Block";
            DivOption.style.display= "inline";
            HideAttachFiles();
//            try{setWindowedControlsVisibility(window, 'visible');}catch(e){}
//            setWindowedControlsVisibility(window,'hidden');
            IfContactProfile.location = "ContactDetail.aspx?ClientID="+$get('<%=hdnClientID.ClientID%>').value + "&ContactID=" + $get('<%=ddlFranchiseContact.ClientID%>').value;
        }
   function DivOptionHide()
        {
            var DivOption = getElement('<%= DivOption.ClientID %>');
            var divDisable = getElement('divDisable');
            divDisable.style.width = 0;
            divDisable.style.height = 0;
            divDisable.style.display= "none";
            DivOption.style.display= "none"; 
            IfContactProfile.location = "Blank.aspx"                            
            setWindowedControlsVisibility(window,'visible');
            return false;
        }
   window.onload=function start()
    {
       valtable = window.document.getElementById("tbsamplevalue");
        if(valtable.rows.length > 1){
           SetPosition();
           ShowMessageAlert();
          }
        else
          Reset();
      }
  function ShowMessageAlert()
    {
      var DivMessageAlert = document.getElementById('DivMessageAlert');
      var x1=document.body.offsetWidth;
      var y1=document.body.offsetHeight;
      DivMessageAlert.style.top = (y1/2) - 150; 
      DivMessageAlert.style.left = (x1/2) - 200; 
      DivMessageAlert.style.display = 'inline';
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
        DivMessageAlert.style.display = 'none';
        return false;
    }
    function Reset2()
    { Reset(); }
    function signup(id,franid,clientid,proid,onsupport)
    {   
       parent.showSupport(id,franid,clientid,proid,onsupport);
       //top.window.location='../Support/Main.aspx?From=helpdesk&ID='+id+'&FranchiseID='+franid+'&ClientID='+clientid+'&ProductID='+proid+'&OnSupport='+onsupport;
    }
 </script>

    <script language="javascript" type="text/javascript">
        var TrigUnload = true;
        function ClosePageForCloseOut(){
        var page = '<%= ResolveClientUrl("~/blank.aspx") %>';
        document.getElementById('dvActivity').style.display='none';
        document.getElementById("backgroundFilter").style.zIndex = '0';
        document.getElementById("popupWindow").style.zIndex = '0';
    }
    
    function backgroundFilter()
        {
            var div;
            div = document.getElementById('backgroundFilter'); 
            if(div.style.display==''&&div.offsetWidth!=undefined&&div.offsetHeight!=undefined)
            {
                div.style.display = (div.offsetWidth!=0&&div.offsetHeight!=0)?'block':'none'; 
            }
            div.style.display = (div.style.display==''||div.style.display=='block')?'none':'block';
        }
       var uniqueId;
        getUniqueId = function ()
        {
             var dateObject = new Date();
             uniqueId = 
                  dateObject.getFullYear() + '' + 
                  dateObject.getMonth() + '' + 
                  dateObject.getDate() + '' + 
                  dateObject.getTime();
        };
       
		function popup(show)
        {   var div;

            getUniqueId();
            div = document.getElementById('backgroundFilter'); 
            
            if(show == '1')
            {   if(document.getElementById("popupWindow")!=null){
                SetFeedBackDiv();
                document.getElementById("popupWindow").style.display='inline';
                document.getElementById("iframeFeedBackRequest").src='<%=ResolveClientURl("~/com/FeedBackRequest.aspx") %>?FranchiseID='+ document.getElementById('<%=hdnFranchiseID.ClientID%>').value+'&ClientID='+document.getElementById('<%=hdnClientID.ClientID %>').value+'&ID='+document.getElementById('<%=hdnID.ClientID%>').value+'&TicketNo='+document.getElementById('<%=hdnTicket.ClientID%>').value+'&Subject='+document.getElementById('<%=hdnSubject.ClientID%>').value;
                div.style.display='inline';}
            }
            else
            {
                document.getElementById("iframeFeedBackRequest").src='<%=ResolveClientURl("~/Blank.aspx") %>?NoCache'+getUniqueId;
                document.getElementById("popupWindow").style.display='none';
                div.style.display='none';
            }


           }
           function setButton3() {
           	var Button3 = document.getElementById('Button3');
           	Button3.attachEvent('onclick', NoClick);
           	//alert('fofofo');
           }
        
        function SetFeedBackDiv()
        {
         var DivFeedBack = document.getElementById('popupWindow');
		 if(DivFeedBack!=null){
         var x1=document.body.offsetWidth;
         var y1=document.body.offsetHeight;
         DivFeedBack .style.top = (y1/2) - 250; 
         DivFeedBack .style.left = (x1/2) - 285; 
         }
                
        }
        function NoClick() {
        	//alert('dodod');
        	history.go(-2);
        } 
        function OpneSMSX(){
        document.getElementById("backgroundFilter").style.display = 'inline';
        var x1=document.body.offsetWidth;
        var y1=document.body.offsetHeight;
		DivSMSX.style.width = '600px';
		DivSMSX.style.top =(y1/2) - 235; 
		DivSMSX.style.left =(x1/2) - 320; 
        DivSMSX.style.display = 'inline';
		}
        function CloseSMSX(){
        document.getElementById("backgroundFilter").style.display = 'none';
        DivSMSX.style.display = 'none';
        }
       
    function GetContentLength(oSender) {
        switch (oSender.id) {
            case "txtNotes":
                var txtNotes = document.getElementById('<%=txtNotes.ClientId%>');
                document.getElementById('<%=lblPBPRemainingCharacters.ClientId%>').innerHTML = 4000 - oSender.value.length;
                if (txtNotes.value.length > 4000) {
                    document.getElementById('<%=lblPBPRemainingCharacters.ClientId%>').innerHTML = 0;
                    txtNotes.value = txtNotes.value.substring(0, 4000);
                }
                break;            
        }
    }      
     
    function ButtonYesOrNoPressed() {
        TrigUnload = false;

    }

    function PriorityChanged(obj) {
        TrigUnload = false;
        if(obj.value==0) 
        return false;
    }
     window.onbeforeunload = WarningMessageForSupportPerson;
     function WarningMessageForSupportPerson() {
         if (TrigUnload == true) {
             if (document.getElementById('<%=ddlActivityStatus.ClientID%>').value == 2 && document.getElementById('<%=lblSubType.ClientID%>').innerText == "Support") {
                 alert("Warning! This request is in progress. Please handle soon");
             }
         }
     } 
        
    </script>

 </form>
   
</body>
</html>