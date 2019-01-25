<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AddMessage.aspx.vb" ValidateRequest="false" Theme="Default" Inherits="AddActivity" %>
<%@ Register Src="VitalInformationFloatingDiv.ascx" TagName="VitalInformationFloatingDiv"
    TagPrefix="CsCtrl" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Add Message</title>
      <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
      <link href="../App_Themes/Default/Calendar/style.css" rel="stylesheet" type="text/css" />
      <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
      <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
      <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
      <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
</head>
<body style="margin:0px;width:100%;height:100%;" >
 <form id="form1" runat="server" >
   <div id="divDisable" class="modalBackground" ></div>
    <div>
      <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="300"></asp:ScriptManager>
       <table style="width:100%;height:100%; background-color:#BADCFC;" border="0" cellspacing="0" cellpadding="0"  class="MainTable">
         <tr>
             <td style="width:27px;">
            <asp:UpdatePanel ID="update1" runat="server" UpdateMode="Always" RenderMode="Block" >
             <ContentTemplate>           
                <CsCtrl:VitalInformationFloatingDiv ID="VitalInformationFloatingDiv" runat="server" />
             </ContentTemplate>
           </asp:UpdatePanel>
             </td>
             <td style="padding:5px" onclick="if (blnShowed == true){showHideVital();}"> 
                <table   style="width:100%;height:100%;background-color:#FFFFFF;; border:1 solid #609BD3; " class="Table"   border="0" align="center" cellpadding="0" cellspacing="0" > 
                    <tr>
                       <td style="height:85px;">      
                       <asp:HiddenField ID="hdnID" runat="server" Value="0" />
                       <asp:HiddenField ID="PrevPage" runat="server" Value="0" />  
                       <asp:HiddenField ID="hdnFranchiseID" runat="server" Value="0" />
                       <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
                       <asp:HiddenField ID="hdnIsClose" runat="server" Value="0" />
                       <asp:HiddenField ID="hdnDueDate" runat="server" Value="0" />                                                                              
                          <table style="width:100%;height:25%; border-color:#7391B9;"  border="0" align="center" cellpadding="0" cellspacing="0" class="Table"  >
                              <tr style="background-color:#DDE4EE;">
                                    <td style="height:31px;" colspan="6">	
                                       <table cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td  colspan="2" class="SimpleBold" style="height:31px;background-color:#BDE7BD;color:#000000;border-bottom:1 solid #609BD3; width:48%; ">
                                                    &nbsp;<asp:Label ID="lblTitle" runat="server" Text="New Message" ></asp:Label> &nbsp;(&nbsp;<asp:Label runat="server" ID="lblFranchiseName" />&nbsp;) 
                                                    <span id="spnUpdateMessage" style="display:none; color:#429E8C;"  >--  Record  Updated </span>
                                                </td>
                                                <td style="background-color:#BDE7BD;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right;cursor:pointer; height: 1px;border-bottom:1 solid #609BD3; width:250px; ">
                                                     <asp:DropDownList ID="ddlFranchiseContact1" 
                                                            runat="server"                                                                                                                           
                                                            DataSourceID="odsContacts"
                                                            AutoPostBack="false" 
                                                            DataTextField="Name"  
                                                            CssClass="SmallGreenTextBox" 
                                                            DataValueField="ID" Width="130px" >
                                                     </asp:DropDownList>
                                                     <asp:ObjectDataSource ID="odsContacts" runat="server"
                                                        OldValuesParameterFormatString="original_{0}"                                                
                                                        SelectMethod="FranchisesContactByID"
                                                        TypeName="Portal.BLL.Franchises"> 
                                                        <SelectParameters>
                                                              <asp:ControlParameter Name="ClientID" DefaultValue="1"  ControlID="hdnClientID" Type="int32" PropertyName="value" />
                                                              <asp:ControlParameter  Name="FranchiseID" Type="Int32" ControlID="hdnFranchiseID" PropertyName="Value" />                      
                                                        </SelectParameters>                                                                                         
                                                     </asp:ObjectDataSource>
                                                            <div style="width:110px; height:22px; " class="LeadDetailButton" onclick="Javascript:showContact();">
                                                                &nbsp;View <img  src="../images/blt_resetfilters.gif" align="absmiddle" width="10" height="10" style="border:0px;" alt="" />
                                                            </div>
                                                </td>									                                   
                                                <td style="background-color:#BDE7BD;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right;cursor:pointer; height: 1px;border-bottom:1 solid #609BD3;  width:125px;">                                                  
                                                    <img align="absMiddle"  height="20" src="../images/pixel_skyBlue.jpg" width="1" alt="" /><img align="absMiddle"  height="20" src="../images/pixel_skyBlue.JPG" width="1" alt="" />
                                                     &nbsp;                   
                                                     <asp:LinkButton ID="btnNewActivity" runat="server" CssClass="HomeButton">
                                                        <div style="width:110px;" class="LeadDetailButton" onclick="javascript:window.location='AddActivity.aspx?FranchiseID=<%= Request.QueryString("FranchiseID").ToString() %>&ClientID=<%= Request.QueryString("ClientID").ToString() %>'; return false;">
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
                                    <td  style="width:2%; height:25px;"></td>
                                    <td style="width:7%;" class="SimpleExSmall">Contact:<span class="RequiredField">*</span></td>
                                    <td style="width:36%;" >
                                    <asp:DropDownList ID="ddlFranchiseContact" 
                                            runat="server"                                 
                                            AutoPostBack="false"                                                                 
                                            DataSourceID="sdsContacts" 
                                            DataTextField="Name"  
                                            CssClass="SmallGreenTextBox" 
                                            DataValueField="ID" Width="150px" >
                                     </asp:DropDownList>
                                     <asp:ObjectDataSource ID="sdsContacts" runat="server"
                                        OldValuesParameterFormatString="original_{0}"                                                
                                        SelectMethod="FranchisesContactByID"
                                        TypeName="Portal.BLL.Franchises"> 
                                        <SelectParameters>
                                              <asp:ControlParameter  Name="ClientID" Type="Int32" ControlID="hdnClientID" PropertyName="Value" />
                                              <asp:ControlParameter  Name="FranchiseID" Type="Int32" ControlID="hdnFranchiseID" PropertyName="Value" />                      
                                        </SelectParameters>                                                                                         
                                     </asp:ObjectDataSource>
                                      <asp:CompareValidator ID="valContact" 
                                        runat="server" 
                                        ControlToValidate="ddlFranchiseContact"
                                        Operator="GreaterThan"
                                        ValueToCompare="0" 
                                        Display="Dynamic"
                                        ErrorMessage="Select contact"
                                        CssClass="ErrorMessage" >
                                     </asp:CompareValidator>                                    
                                    </td>
                                    <td style="width:1%;"></td>
                                    <td style="width:13%;" class="SimpleExSmall">Type:<span class="RequiredField">*</span></td>
                                    <td style="width:41%;" >
                                        &nbsp;<strong>Message</strong>
                                        &nbsp;<asp:CheckBox runat="server" ID="chkCharge" Text="Billable" Checked="false" />
                                    </td>
                              </tr>                    
                              <tr > 
                                    <td height="1"  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" alt="" /></td>
                              </tr>
                              <tr style="border-color:#F5F5F5; background-color:#DEF7D6;" valign="middle">
                                    <td ></td>
                                    <td  style="height:25px;" class="SimpleExSmall">Date: </td>
                                    <td>                            
                                        <strong><asp:Label  ID="txtDueDate" runat="server" Width="150px"></asp:Label></strong>
                                    </td>
                                    <td ></td>
                                    <td  class="SimpleExSmall">Topic:<span class="RequiredField">*</span></td>
                                    <td >
                                      <asp:DropDownList runat="server" ID="ddlTopic"
                                            Width="150px"
                                            Enabled="true"
                                            SkinID="SmallTextCombo"
                                            DataSourceID="sdsTopics" 
                                            DataTextField="Topic"
                                            DataValueField="ID"
                                            AutoPostBack="false" >
                                          </asp:DropDownList>
                                          <asp:SqlDataSource ID="sdsTopics" 
                                              runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                              SelectCommand="Activities_GetTopics" 
                                              SelectCommandType="StoredProcedure"
                                              DataSourceMode="DataReader">
                                          </asp:SqlDataSource>
                                     <asp:CompareValidator ID="valTopic" 
                                        runat="server" 
                                        ControlToValidate="ddlTopic"
                                        Operator="GreaterThan"
                                        ErrorMessage="Select activity sub type"
                                        ValueToCompare="0" 
                                        Display="Dynamic"
                                        CssClass="ErrorMessage" >
                                     </asp:CompareValidator>
                                    </td>                                                            
                              </tr>
                              <tr > 
                                    <td  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" /></td>
                              </tr>
                              <tr style="border-color:#F5F5F5; background-color:#DEF7D6;">
                                    <td ></td>
                                    <td  class="SimpleExSmall">Time :</td>
                                    <td  >
                                     <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional" RenderMode="block">
                                      <ContentTemplate>
                                         <strong>                                         
                                             <div id="divTime" runat="server" >                           
                                            <asp:DropDownList ID="ddlHoursNotes"  runat="server"                            
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
                                                   (HH:MM)  <asp:CustomValidator ID="cvTimeSpent" runat="server" ControlToValidate="ddlHoursNotes" 
                                                                Display="Dynamic" ErrorMessage="Select Time Spent" ClientValidationFunction="ValidateTimeSpent">
                                                            </asp:CustomValidator>      
                                         </div>  
                                        </strong>
                                       </ContentTemplate>
                                     </asp:UpdatePanel>                           
                                    </td>                                                            
                                    <td ></td>
                                    <td  class="SimpleExSmall">Priority:<span class="RequiredField">*</span></td>
                                    <td >
                                      <asp:DropDownList ID="ddlPriority" 
                                            runat="server"                                 
                                            AutoPostBack="false"                                                                                                            
                                            CssClass="SmallGreenTextBox" 
                                            Width="150px" >
                                            <asp:ListItem Text="Select..." Value="0" ></asp:ListItem>
                                            <asp:ListItem Text="Low" Value="1" Selected="True" />
                                            <asp:ListItem Text="Minimal" Value="2"/>
                                            <asp:ListItem Text="Moderate" Value="3" />
                                            <asp:ListItem Text="Severe" Value="4" />
                                            <asp:ListItem Text="Critical" Value="5" />
                                     </asp:DropDownList>
                                     <asp:CompareValidator ID="CompareValidator1" 
                                        runat="server" 
                                        ControlToValidate="ddlPriority"
                                        Operator="GreaterThan"
                                        ErrorMessage="Select Priority"
                                        ValueToCompare="0" 
                                        Display="Dynamic"
                                        CssClass="ErrorMessage" >
                                     </asp:CompareValidator>
                                    </td>                                       
                               </tr>
                               <tr > 
                                    <td  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" alt="" /></td>
                               </tr>
                               <tr style="border-color:#E9E9E9; background-color:#BDE7BD">
                                    <td style="height:25px;"></td>
                                    <td class="SimpleExSmall" >Subject:<span class="RequiredField">*</span></td>
                                    <td  colspan="3" >
                                        <asp:TextBox runat="server" ID="txtActivitySubject" Text="" MaxLength="500"  CssClass="SmallGreenTextBox" Width="80%" />
                                        <asp:RegularExpressionValidator 
                                        ID="revDescrpHtml" 
                                        runat="server" 
                                        ControlToValidate="txtActivitySubject"
                                        ErrorMessage="<br>Enter valid subject." 
                                        ValidationExpression="^[^<>]*$" 
                                        CssClass="RequiredField" Display="Dynamic"></asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="valSubject" runat="server"
                                            ControlToValidate="txtActivitySubject"
                                            ErrorMessage="<br>Enter Subject"
                                            Display="Dynamic"
                                            CssClass="ErrorMessage" >
                                        </asp:RequiredFieldValidator>
                                    </td>                                                 
                                    <td style="white-space:nowrap;" class="SimpleExSmallBold" align="right"  >
                                        &nbsp;
                                        <asp:LinkButton   ID="btnAddNotes" runat="server" CausesValidation="false" style="padding:4px; font-size:11px; width:90px;height:18px;" oncontextmenu="return false;" Font-Underline="true" Text="Add Attachments" OnClientClick="showAttachFiles(); return false;"  />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
                          <div style="width: 100%;height:100%;vertical-align:top;"  class="DivScroll" >  
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
                                        <td style="border:none;" colspan="4" align="left" >
                                         <asp:RequiredFieldValidator ID="valDescription" runat="server"
                                            ControlToValidate="txtDescription"
                                            ErrorMessage="&nbsp;Enter Description"
                                            Display="Dynamic"
                                            CssClass="ErrorMessage" >
                                        </asp:RequiredFieldValidator>  
                                        <asp:TextBox runat="server" 
                                             ID="txtDescription" 
                                             TextMode="MultiLine" 
                                             Font-Size="11px"
                                             Width="100%"
                                             Height="100%"
                                             Text="">
                                         </asp:TextBox> 
                                                                                          
                                        </td>                                                
                                    </tr>                                                 
                            </table>  
                         </div>            
                      </td>
                    </tr>          
                    <tr style="background-color:#BDE7BD;">
                       <td style="border-top:1 solid #609BD3;" >
                          <table style="width:100%; height:100%" border="0" cellpadding="0" cellspacing="0" >
                            <tr style="height:31;" >
                                <td class="SimpleExSmall" style="width:35%">
                                &nbsp;<asp:CheckBox runat="server" ID="ChkEmail" Text="Email Notification" Checked="false" />
                               </td>
                                <td class="SimpleExSmall"  style="width:55%; ">
                                  </td>
                                 <td style="width:25%;" align="right">                             
                                    <asp:Button ID="btnSave" runat="server"  CssClass="Btn3D" CausesValidation="True" Text="Save" Width="80px" />&nbsp;&nbsp;
                                    <button id="btnBack" name="btnBack" class="Btn3D"  style="width:80px;" onclick="javascript:window.location='Franchise_Inbox.aspx?FranchiseID=<%= Request.QueryString("FranchiseID").ToString() %>&ClientID=<%= Request.QueryString("ClientID").ToString() %>';" >Cancel</button>&nbsp;&nbsp;                                         
                                 </td>
                             </tr>
                           </table>
                         </td>
                    </tr>      
                </table>
             </td>
         </tr>
       </table>
    </div>
    <div align="center" id="Attachment" style="display:none; border:0px solid black; position:absolute;left:25%; top:20%; width: 450px; height: 230px;">
        <table align="center" width="100%" cellpadding="0" cellspacing="0" class="MainAlertDiv">
	        <tr>
	          <th style="height:21px;" align="left" valign="middle">&nbsp;Add - Attachments</th>
	          <th align="right" valign="top"><img src="../images/closebox2.gif" onclick="OnAttachmentSubmit(); return false;" style="cursor:pointer;" alt="" /></th>
	        </tr>
	        <tr>
	           <td style="width:100%;" valign="top" colspan="2">
		            <table  align="center" width="100%" cellpadding="0" cellspacing="0" class="MainAlertDiv" style="border:none;">
			            <tr>
			                <td align="center" style="height:25px;" colspan="2">Attach Files!</td>
			            </tr>
                        <tr>
                            <td></td>
                            <td  style="height:25px;" >
                                <font size="2" face="verdana, Arial, Helvetica, sans-serif">
                                    &nbsp;File 1: <span id="spnFile1">
                                                        <asp:FileUpload id="file1" Runat="server" style="width:330px;" />
                                                        <asp:RegularExpressionValidator id="REV_file1" runat="server" 
                                                            ErrorMessage="Attachment must be a .jpg, .jpeg, .png, .gif, .doc, .pdf, .txt, .rtf or .zip file" 
                                                            ValidationExpression="^.*(.txt|.zip|.doc|.jpg|.jpeg|.png|.gif|.doc|.docx|.pdf|.rtf|.xls|.xlsx|.rar|.TXT|.ZIP|.DOC|.DOCX|.XLS|.XLSX|.JPG|.JPEG|.PNG|.GIF|.DOC|.DOCX|.XLS|.XLSX|.RAR|.PDF|.RTF)$"  
                                                            Display="Dynamic"                                           
                                                            ControlToValidate="file1">
                                                        </asp:RegularExpressionValidator>
                                                  </span><br/>
                                    &nbsp;File 2: <span id="spnFile2">
                                                        <asp:FileUpload id="file2" Runat="server" style="width:330px;" />
                                                        <asp:RegularExpressionValidator 
                                                            id="REV_file2" runat="server" 
                                                            ErrorMessage="Attachment must be a .jpg, .jpeg, .png, .gif, .doc, .pdf, .txt, .rtf or .zip file" 
                                                            ValidationExpression="^.*(.txt|.zip|.doc|.jpg|.jpeg|.png|.gif|.doc|.docx|.pdf|.rtf|.xls|.xlsx|.rar|.TXT|.ZIP|.DOC|.DOCX|.XLS|.XLSX|.JPG|.JPEG|.PNG|.GIF|.DOC|.DOCX|.XLS|.XLSX|.RAR|.PDF|.RTF)$"  
                                                            Display="Dynamic"                                           
                                                            ControlToValidate="file2">
                                                        </asp:RegularExpressionValidator>
                                                  </span><br />
                                    &nbsp;File 3: <span id="spnFile3">
                                                        <asp:FileUpload id="file3"  Runat="server" style="width:330px;" />
                                                        <asp:RegularExpressionValidator 
                                                            id="REV_file3" runat="server" 
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
    <div id="DivOption" runat="server"  style="display:none;border:solid 1px #000000; position:absolute; width:600px;  height:220px;top:15%; left:10%; z-index:1;"    >
          <table style="height:100%;" cellpadding="0" border="0" cellspacing="0"   >
           <tr>    
              <td align="left" style="border-bottom:solid 1px #000000;padding-top:4px; padding-left:1em;vertical-align:middle; background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
                  <label id="Label1" title="Notes"    style="color:White;height:100%; overflow:auto; font-weight:bold;"  >Contact Information</label>
              </td>
              <td  style="border-bottom:solid 1px #000000;background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%; height:28px; cursor:pointer;">
                  <img src="../images/win_btn_close_black.jpg" style="float:right;" alt="Close Window" onclick="DivOptionHide();" />
              </td>               
           </tr>
           <tr valign="top">                
             <td colspan="2" style="height:100%; padding:0px; font-size:12px; background-color:White;" >   
             <iframe name="IfContactProfile" runat="server" id="IfContactProfile" src="Blank.aspx" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
             </td>
           </tr>            
          </table>
        </div>   
 </form>
 <script language="javascript" type="text/javascript">
    function validateSameFiles(oSrc, args){
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
  
    function OpenWindow(LeadID)
    {
        window.open('../BlankPage.aspx?Page=lead/PrintLead&PageTitle=Print Lead&LeadID='+LeadID,'','dialogHeight=750px,menubar=1,dialogWidth=600px,status=1');
    
    }

  
 
      
      function showAttachFiles()
    {
        document.getElementById("Attachment").style.display='inline';
        setWindowedControlsVisibility(window, 'hidden');
    }
    


 function textCounter(field)
     {
   
        if (field.value.length > 500)        
        field.value = field.value.substring(0, 500);
    }
    

     
     
     
     function OnAttachmentSubmit(flagCancel)
         {
	        //var FileExp = new RegExp("^.*(.txt|.zip|.doc|.jpg|.jpeg|.png|.gif|.doc|.docx|.pdf|.rtf|.xls|.xlsx|.rar|.TXT|.ZIP|.DOC|.DOCX|.XLS|.XLSX|.JPG|.JPEG|.PNG|.GIF|.DOC|.DOCX|.XLS|.XLSX|.RAR|.PDF|.RTF)$"); 
	        if (flagCancel == 1)
	        {
		        ResetAttachment3();ResetAttachment2();ResetAttachment1();
	        }
//	        else 
//	        {
//	             if(!(FileExp.test(trim(document.getElementById('<%=File1.ClientID%>').value))))
//	             {
//	             ResetAttachment1();
//	             }
//	             if(!(FileExp.test(trim(document.getElementById('<%=File2.ClientID%>').value))))
//	             {
//	             ResetAttachment2();
//	             }
//	             if(!(FileExp.test(trim(document.getElementById('<%=File3.ClientID%>').value))))
//	             {
//	             ResetAttachment3();
//	             }
//	         
//	        }        
        	
	        getElement('Attachment').style.display = 'none';
	        try{setWindowedControlsVisibility(window, 'visible');}catch(e){}	
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
         }
        function trimFileName(strFileName)
         {
	            if (strFileName.length > 20)
		            return strFileName.substr(0,20)+' ...';
	            else
		            return strFileName;
         }
     function ResetAttachment2()
         {
            var Fupload = document.getElementById('<%=File2.ClientID%>');
            var TD = Fupload.parentElement ;
            var str = TD.innerHTML;
            str = str.replace(Fupload.value,'');
            TD.innerHTML = str;
         } 
     function ResetAttachment1()
         {
         
            var Fupload = document.getElementById('<%=File1.ClientID%>');
            var TD = Fupload.parentElement ;
            var str = TD.innerHTML;
            str = str.replace(Fupload.value,'');
            TD.innerHTML = str;
           
         } 
   
    function ResetAttachment3()
        {
         
           var Fupload = document.getElementById('<%=File3.ClientID%>');
           var TD = Fupload.parentElement ;
           var str = TD.innerHTML;
           str = str.replace(Fupload.value,'');
           TD.innerHTML = str ;
        } 
 
    function showContact()
    {
            var DivOption = getElement('<%= DivOption.ClientID %>')        
            divDisable.style.width = document.body.scrollWidth
            divDisable.style.height = document.body.scrollHeight
            DivOption.style.display= "inline";
            setWindowedControlsVisibility(window,'hidden');
            IfContactProfile.location = "ContactDetail.aspx?ClientID="+$get('<%=hdnClientID.ClientID%>').value + "&ContactID=" + $get('<%=ddlFranchiseContact1.ClientID%>').value;
        
   }
   function DivOptionHide()
   {
            var DivOption = getElement('<%= DivOption.ClientID %>')         
            divDisable.style.width = 0;
            divDisable.style.height = 0;
            DivOption.style.display= "none"; 
            IfContactProfile.location = "Blank.aspx"                            
            setWindowedControlsVisibility(window,'visible');
            return false;
   }
   
   function ValidateTimeSpent(sender, args)
   {
        if(document.getElementById('<%= ddlHoursNotes.ClientID %>').value == 0){        
            if(document.getElementById('<%= ddlMinutesNotes.ClientID %>').value == 0){            
                args.IsValid=false;
            }
            else{
                args.IsValid=true;
            }
        }
        else{
            args.IsValid=true;
        }
   }
 </script>   
</body>
</html>
