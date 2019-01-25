<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ActivityDetail.aspx.vb" Inherits="MyNetsolace_ActivityDetail" Title="Netsolace Portal - My Netsolace" %>

<%@ Register
    Assembly="AjaxControlToolkit"
    Namespace="AjaxControlToolkit"
    TagPrefix="ajaxToolkit" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">       
      <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
      <link href="../App_Themes/Default/Calendar/style.css" rel="stylesheet" type="text/css" />
      <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="javaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="javaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="javaScript" src="../scripts/calendar-fs.js"></script>
    <meta http-equiv="Page-Enter" content="progid:DXImageTransform.Microsoft.Fade(Duration=0.2)" />
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(Duration=0.2)" />
</head>
<body style="margin:0px;width:100%;height:100%;" >
 <form id="form1" runat="server" >
    <div id="divDisable" class="modalBackground" ></div>
    <div>
    <asp:HiddenField ID="hdnRegularExprssion" runat="server" />
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
              <td onclick="if (blnShowed == true){HideAttachFiles(); DivOptionHide(); showHideVital(); }"> 
                <table   style="width:100%;height:100%;background-color:#FFFFFF;" class="Table"   border="0" align="center" cellpadding="0" cellspacing="0" > 
                     <tr>
                       <td style="height:85px;">      
                       <asp:HiddenField ID="hdnID" runat="server" Value="0" />
                        <asp:HiddenField runat="server" Value="0" ID="hdnType" />
                       <asp:HiddenField ID="PrevPage" runat="server" Value="0" />  
                       <asp:HiddenField ID="hdnFranchiseID" runat="server" Value="0" />
                       <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
                       <asp:HiddenField ID="hdnIsClose" runat="server" Value="0" />
                       <asp:HiddenField ID="hdnDueDate" runat="server" Value="0" />                                                                              
                              <table style="width:100%;height:25%; border-color:#7391B9;"  border="0" align="center" cellpadding="0" cellspacing="0" class="Table"  >
                               <tr style="background-color:#DDE4EE;">
                                    <td style="height:31px;" colspan="6">	
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                               <td class="SimpleBold" style="height:31px;background-color:#BDE7BD;color:#000000;border-bottom:1 solid #609BD3; width:50%; ">
                                                &nbsp;<asp:Label ID="lblTitle" runat="server" Text="Ticket Detail" ></asp:Label> &nbsp;&nbsp;<asp:Label runat="server" ID="lblFranchiseName" />&nbsp;                                                                                                                                                                                                          
                                               </td>                                                                                                                                                 	                                                 					                                   
                                               <td style="height:31px;background-color:#BDE7BD;color:#000000;border-bottom:1 solid #609BD3; width:50%;" align="right">
                                               <asp:LinkButton ID="lnkBtnNewActivity"  runat="server">
                                                        <div style="height:22px; width:120px" class="LeadDetailButton">
                                                        New Ticket
                                                        </div>  
                                                </asp:LinkButton> &nbsp;
                                               </td>
                                            </tr>
                                       </table>
                                    </td>
                                </tr> 
                                <tr style="border-color:#F5F5F5; background-color:#DEF7D6;">
                                    <td style="width:2%;height:20px;"></td>
                                    <td style="width:10%;" class="SimpleExSmall">Ticket #:</td>
                                    <td style="width:20%;" colspan="4" >
                                    <strong><asp:Label runat="server" ID="lblTicketNumber" Text="" /></strong>
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
                                    <td colspan="3"></td>                                    
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
                                    <td colspan="3" ></td>                                                                      
                                </tr>
                                <tr > 
                                    <td height="1"  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" alt="" /></td>
                                </tr>
                                <tr style="border-color:#F5F5F5; background-color:#DEF7D6;" valign="middle">
                                    <td ></td>
                                    <td  style="height:20px;" class="SimpleExSmall">Related To: </td>
                                    <td  >                            
                                       <strong><asp:Label runat="server" ID="lblRelatedTo" Text="" /> </strong>
                                    </td>
                                    <td colspan="3" ></td>                                                                      
                                </tr>
                                <tr id="Tr_ModuleSpacer"> 
                                    <td height="1"  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" alt="" /></td>
                                </tr>
                                <tr id="Tr_Module" style="border-color:#F5F5F5; background-color:#DEF7D6;" valign="middle">
                                    <td ></td>
                                    <td  style="height:20px;" class="SimpleExSmall">Module: </td>
                                    <td  >                            
                                       <strong><asp:Label runat="server" ID="lblModule" Text="" /> </strong>
                                    </td>
                                    <td colspan="3" ></td>                                                                      
                                </tr>
                                <tr > 
                                    <td  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" alt="" /></td>
                                </tr>                               
                                <tr style="border-color:#E9E9E9; background-color:#BDE7BD">
                                    <td style="height:20px;"></td>
                                    <td class="SimpleExSmall" >Subject:</td>
                                    <td  colspan="3" >
                                        <strong> <asp:Label runat="server" ID="lblActivitySubject" Text="" /></strong>&nbsp;
                                    </td>                                                 
                                    <td style="white-space:nowrap;padding:4px;" class="SimpleExSmallBold" align="right"  >                                        
                                        <asp:LinkButton   ID="btnAddNotes" runat="server" CausesValidation="false" style="font-size:11px; width:90px; height:18px;" Text="Add Notes" Font-Underline="true" OnClientClick="Notes(); return false;" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
                          <div style="width: 100%;height:100%;vertical-align:top;"  class="DivScroll" ondblclick="Notes();">  
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
                                       <table style="width:100%; height:100%; vertical-align:top;"   border="0"  cellpadding="0" cellspacing="0" >
                                           <tr>
                                                <td style=" width:100%; height:100%; vertical-align:top;">
                                                    <div style="display: none; vertical-align:top;height:80px; width:100%; background-color:#DAF5D6; border-bottom:solid 1px #609BD3;" id="DivNotes" >                           
						                            <table width="100%"  cellpadding="0" cellspacing="0" border="0" style="padding:2px;">						                                
                                                        <tr>
                                                        <td  valign="top" class="SimpleExSmallBold" style="padding-left:5px"> Notes: </td>
                                                        <td valign="top" class="SimpleExSmallBold" style="width:70%;">                                                                                          
                                                               <asp:TextBox ID="txtNotes" runat="server" style="width:98%;  font-size:11px; "  CssClass="SmallGreenTextBox" Height="70px" TextMode="MultiLine" ></asp:TextBox>								                                                                                       
                                                        </td>
                                                        <td style="width:20%;">
                                                        <table width="100%" cellpadding="0" cellspacing="0">
                                                        <tr style="height:25px;">
                                                            <td align="center" style="border:none;">
                                                          <input type="button" id="btnattch" style="height:20px; width:80px;"  class="LeadDetailGreenButton" onclick="showAttachFiles(); return false;" value="Attach File" />
                                                          </td>
                                                        </tr>
                                                        <tr style="height:25px;">
                                                            <td align="center" style="border:none;">
                                                             <asp:Button ID="btnSaveNotes" runat="server" Text="Save" CssClass="LeadDetailGreenButton" Width="80px" Height="20px"  OnClientClick="if (validateNotes() == true) return true; else return false;" />                                                             
                                                             </td>
                                                        </tr>
                                                        </table> </td>
                                                        </tr>
                                                    </table>	                
                                                    </div>  
                                                    <div id="DivNotesDisplay"  runat="server"  style="width:100%;height:100%;overflow:auto; padding-left:10px;padding-right:10px;" class="DivScroll" >                                                    
                                                      <asp:UpdatePanel ID="UpdatePanel2"
                                                         runat="server" 
                                                         UpdateMode="conditional" 
                                                         RenderMode="Inline">
                                                         <ContentTemplate>
                                                        <asp:Repeater ID="rptrNotes" runat="server" DataSourceID="sdsNotes"  EnableViewState="false">
                                                            <HeaderTemplate>
                                                                <table width="100%" border="0" style="font-size:10px;" cellspacing="0" class="Table"  cellpadding="0" >                                                   
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                              <tr valign="top" style="height:20px;background-color:#FFFFFF; "  >
                                                                <td align="left" style="border-left:0px;border-bottom:1px solid #BDE4B8; border-bottom-style:dashed; padding-top:5px; font-size:11px;"    >
                                                               <b><%#IIf(CInt(Eval("PlacedBy"))= 1, "Netsolace said", Eval("ContactName"))%> on&nbsp;<%#String.Format("{0: MMMM dd, yyyy hh:mm:ss tt}", Eval("NotesDate"))%> <i> ( EST )</i></b> <br />
                                                                    <asp:Repeater ID="rptrAttachments" runat="server">
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
                                                                                    <td style="width:80%;" class="SimpleExSmall" >Original message sent by  <b> <asp:Label ID="lbladminName" runat="server" Text="" ></asp:Label> on&nbsp; <asp:Label ID="lblDate" runat="server" Text="" ></asp:Label></b> <br /></td>
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
                                                       <Triggers>                                                        
                                                        </Triggers>                                                
                                                        </asp:UpdatePanel>                                       
                                                       </div> 
                                                        <asp:ObjectDataSource ID="sdsNotes" runat="server"                                                                 
                                                                TypeName="Portal.BLL.ActivityNotes" SelectMethod="GetPublicNotesByActivityID">                                    
                                                            <SelectParameters>                                                                                         
                                                              <asp:ControlParameter Name="ActivityID" DefaultValue="0"  ControlID="hdnID" Type="int32" PropertyName="value" />                                
                                                            </SelectParameters>
                                                       </asp:ObjectDataSource>
                                                        <asp:SqlDataSource 
                                                            ID="sdsAttachments" 
                                                            runat="server" 
                                                            ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"                                                        
                                                            SelectCommand="Activities_GetAttachmentByActivityID" SelectCommandType="StoredProcedure" >
                                                            <SelectParameters >
                                                                 <asp:ControlParameter  Name="ActivityID" DefaultValue="0"  ControlID="hdnID" Type="int32" PropertyName="value" />                                        
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                         <asp:SqlDataSource 
                                                            ID="sdsActivityAttachments" 
                                                            runat="server" 
                                                            ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"                                                        
                                                            SelectCommand="Activities_GetActivityAttachment" SelectCommandType="StoredProcedure" >
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
                          <table style="width:100%; height:100%" border="0" cellpadding="0" cellspacing="0" >
                            <tr style="height:31px;" >
                                <td id="tdCloseTicket" runat="server" visible="false" class="SimpleExSmall" style="width:75%; padding-left:10px;">
                                    <img src="../images/ico_alert.gif" align="absmiddle" />&nbsp;&nbsp;&nbsp;Netsolace Wants to Close the Ticket. Do you want to close? &nbsp;<asp:Button ID="btnCloseTicket" runat="server" CssClass="Btn3D" Text="Yes" Width="45px" Height="20px" CausesValidation="false" OnClientClick="RateTicket(); return false;"  />&nbsp;&nbsp;<asp:Button ID="btnCanelTicketClose" runat="server" Text="No" CssClass="Btn3D" Width="45px" Height="20px" CausesValidation="false" />&nbsp;&nbsp;&nbsp;
                                </td>                                
                                <td style="width:25%;" align="right">                             
                                         <asp:Button ID="btnBack" runat="server"  CssClass="Btn3D" CausesValidation="false" Text="Back" Width="80px" />&nbsp;&nbsp;
                                </td>
                             </tr>
                             </table>
                             </ContentTemplate>                             
                             </asp:UpdatePanel>                                         
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
	        <th align="right" valign="top"><img src="../images/closebox2.gif" onclick="OnAttachmentSubmit(); return false;" style="cursor:pointer;" alt="" /></th>
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
        <div id="DivMessageAlert" style="display:none;border:solid 1px #609BD3; position:absolute;width:500px;height:350px; z-index:10;">
          <table style="height:100%;width:100%;" cellpadding="0" border="0" cellspacing="0">
           <tr>    
              <td align="left" style="border-bottom:solid 1px #609BD3; padding-left:5px;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=#ABD0E8,endColorStr=#FAFCFE);width:80%;">
                  <span title="Franchises Support Expiration Alert" style="color:black;font-weight:bold;font-size:12px;">Customer Satisfaction Survey</span>
              </td>
              <td  style="border-bottom:solid 1px #609BD3;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=#FAFCFE,endColorStr=#FFFFFF);width:20%;height:24px;cursor:pointer;">
                  <img src="../images/btn_close.gif" style="float:right;" alt="Close Window" onclick="DivMessageAlert.style.display='none';" />
              </td>
           </tr>
           <tr valign="top">
             <td colspan="2" style="width:100%;font-size:12px;">
                <table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%;text-align:center;font-size:12px;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#ABD0E8,endColorStr=#FFFFFF);">
                  <tr style="font-weight:bold;padding-top:5px;height:40px;">
                     <td>Please rate our customer service representative in each of following areas.<br />
						<asp:CustomValidator
								ID="CV_Rating"
								runat="server"
								ErrorMessage="Please select the following ratings to proceed."
								ClientValidationFunction="CheckRating"
								CssClass="RequiredField"
								Display="Dynamic"
								ValidationGroup="vgcomments">
						 </asp:CustomValidator>
                     </td>
                  </tr>
                  <tr >
                     <td style="height:10%;width:100%;">
                         <div style="float:left;position:relative;line-height:25px;left:10px;"><b>Promptness: <span class="RequiredField">*</span></b></div>
                         <div style="float:right;position:relative;line-height:25px;right:50px;"><asp:RadioButtonList ID="rblPromptness" runat="server" Font-Size="11px"  RepeatColumns="4" RepeatDirection="Horizontal" >
                            <asp:ListItem Text="Excellent" Value="4" ></asp:ListItem>
                            <asp:ListItem Text="Good" Value="3" ></asp:ListItem>
                            <asp:ListItem Text="Fair" Value="2" ></asp:ListItem>
                            <asp:ListItem Text="Poor" Value="1" ></asp:ListItem>
                        </asp:RadioButtonList>
                        </div>
                     </td>
                  </tr>
                  <tr >
                     <td style="height:10%;width:100%;">
                         <div style="float:left;position:relative;line-height:25px;left:10px;"><b>Courteousness: <span class="RequiredField">*</span></b></div>
                         <div style="float:right;position:relative;line-height:25px;right:50px;"><asp:RadioButtonList ID="rblCourteousness" runat="server" Font-Size="11px"  RepeatColumns="4" RepeatDirection="Horizontal" >
                            <asp:ListItem Text="Excellent" Value="4" ></asp:ListItem>
                            <asp:ListItem Text="Good" Value="3" ></asp:ListItem>
                            <asp:ListItem Text="Fair" Value="2" ></asp:ListItem>
                            <asp:ListItem Text="Poor" Value="1" ></asp:ListItem>
                        </asp:RadioButtonList>
                        </div>
                     </td>
                  </tr>
                  <tr >
                     <td style="height:10%;width:100%;">
                         <div style="float:left;position:relative;line-height:25px;left:10px;"><b>Clarity: <span class="RequiredField">*</span></b></div>
                         <div style="float:right;position:relative;line-height:25px;right:50px;"><asp:RadioButtonList ID="rblClarity" runat="server" Font-Size="11px"  RepeatColumns="4" RepeatDirection="Horizontal" >
                            <asp:ListItem Text="Excellent" Value="4" ></asp:ListItem>
                            <asp:ListItem Text="Good" Value="3" ></asp:ListItem>
                            <asp:ListItem Text="Fair" Value="2" ></asp:ListItem>
                            <asp:ListItem Text="Poor" Value="1" ></asp:ListItem>
                        </asp:RadioButtonList>
                        </div>
                     </td>
                  </tr>
                  <tr >
                     <td style="height:10%;width:100%;">
                         <div style="float:left;position:relative;line-height:25px;left:10px;"><b>Knowledgeable: <span class="RequiredField">*</span></b></div>
                         <div style="float:right;position:relative;line-height:25px;right:50px;"><asp:RadioButtonList ID="rblKnowledgeable" runat="server" Font-Size="11px"  RepeatColumns="4" RepeatDirection="Horizontal" >
                            <asp:ListItem Text="Excellent" Value="4" ></asp:ListItem>
                            <asp:ListItem Text="Good" Value="3" ></asp:ListItem>
                            <asp:ListItem Text="Fair" Value="2" ></asp:ListItem>
                            <asp:ListItem Text="Poor" Value="1" ></asp:ListItem>
                        </asp:RadioButtonList>
                        </div>
                     </td>
                  </tr>
                  <tr >
                     <td style="height:10%;width:100%;">
                         <div style="float:left;position:relative;line-height:25px;left:10px;"><b>Overall Experience: <span class="RequiredField">*</span></b></div>
                         <div style="float:right;position:relative;line-height:25px;right:50px;"><asp:RadioButtonList ID="rblRate" runat="server" Font-Size="11px"  RepeatColumns="4" RepeatDirection="Horizontal" >
                            <asp:ListItem Text="Excellent" Value="4" ></asp:ListItem>
                            <asp:ListItem Text="Good" Value="3" ></asp:ListItem>
                            <asp:ListItem Text="Fair" Value="2" ></asp:ListItem>
                            <asp:ListItem Text="Poor" Value="1" ></asp:ListItem>
                        </asp:RadioButtonList>
                        </div>
                     </td>
                  </tr>
                  <tr >
                     <td style="height:10%;width:100%;">
						<div style="width:100%;padding-left:10px;text-align:left;"><b>Comments: (Optional)</b></div>
                     </td>
                  </tr>
                  <tr >
                     <td style="height:90%;width:100%;padding-left:10px;padding-right:10px;" align="left">
                         <asp:TextBox ID="txtComments" runat="server" Height="85%" MaxLength="500" TextMode="MultiLine"  Width="100%" Font-Size="12px">
                          </asp:TextBox>
                               <asp:RequiredFieldValidator ID="RFV_txtDescription" runat="server" 
                                    ControlToValidate="txtComments"
                                    Display="Static"
                                    CssClass="RequiredField"
                                    Enabled="false" 
                                    ValidationGroup="vgcomments"
                                    ErrorMessage="Please Enter Comments">
                               </asp:RequiredFieldValidator>
                               <asp:RegularExpressionValidator 
                                    ID="REV_CheckCount" 
                                    runat="server" 
                                    ErrorMessage="Please Enter Characters Less Than 200" 
                                    ControlToValidate="txtComments" 
                                    CssClass="RequiredField"
                                    Display="Dynamic" 
                                    ValidationGroup="vgcomments"
                                    ValidationExpression="^[\s\S]{1,200}$">
                             </asp:RegularExpressionValidator>
                     </td>
                  </tr>
                  <tr>
                    <td style="padding-bottom:5px;padding-top:10px;">
                        <asp:Button ID="btnYes" runat="server"  CssClass="Btn3D" Text="Submit" Width="80px" Height="20px" CausesValidation="true" ValidationGroup="vgcomments"/>
						<asp:LinkButton ID="btnNoThanks" runat="server"  Text="No Thanks" Width="80px" Height="20px" Font-Underline="true" Font-Bold="true"  CausesValidation="false" style="position:relative;top:5px;" />
                    </td>
                  </tr>
                </table>
             </td>
           </tr>            
          </table>
        </div>
    <script language="javascript" type="text/javascript">
    function SetModuleDisplay(display){
        document.getElementById('Tr_Module').style.display=display;
        document.getElementById('Tr_ModuleSpacer').style.display=display;
    } 
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
           var ActivityState = document.getElementById('<%=hdnIsClose.ClientID %>')
         
           if (ActivityState.value != 'True')
             { 
               if (DivNotes.style.display=='none')
	                {
		                DivNotes.style.display = 'inline';	
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
		                document.getElementById('<%=txtNotes.ClientID%>').innerText = '';		                
		                document.getElementById('<%=btnAddNotes.ClientID%>').innerText = 'Add Notes';
	                }
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
	        else
	        {	        
		        ret = true;
	        }
	        return ret;
        }
        function onUpdating()
        {
            
                        
            var btnBack = getElement('<%= btnBack.ClientID %>')  
            var btnAddNotes = getElement('<%= btnAddNotes.ClientID %>')  
                                     
            
                     
                     
            if(btnBack != null)
            {
                btnBack.disabled = true;
            }           
                                                                   
           if (btnAddNotes != null)
           {
                  btnAddNotes.disabled = true;            
           }              
           
          
          if (DivNotes.style.display == "inline")
          {        
              DivNotes.style.display = "none";
              DivNotesDisplay.style.height = '100%';
		      document.getElementById('<%=btnAddNotes.ClientID%>').innerText = 'Add Notes';
          }                 
          getElement('img1').disabled = true;       
        }
    function onUpdated()
    {     
                              
            var btnBack = getElement('<%= btnBack.ClientID %>')  
            var btnAddNotes = getElement('<%= btnAddNotes.ClientID %>')

            if(btnBack !=null)
            {
                btnBack.disabled = false;
            }                        
            if (btnAddNotes != null)            
            {   
                   btnAddNotes.disabled = false;
            }                             
            if (DivNotes.style.display == "inline")
            {        
                DivNotes.style.display = "none";
                DivNotesDisplay.style.height = '100%';
		        document.getElementById('<%=btnAddNotes.ClientID%>').innerText = 'Add Notes';
            }           
                        		             
            getElement('img1').disabled = false; 
    }
    function RateTicket()
    {   
          var DivMessageAlert = document.getElementById('DivMessageAlert');
          var x1=document.body.offsetWidth;
          var y1=document.body.offsetHeight;
          DivMessageAlert.style.top = (y1/2) - 175; 
          DivMessageAlert.style.left = (x1/2) - 250; 
          DivMessageAlert.style.display = 'inline';
    }
      function CheckRating(oSrc, args) {
		var i = 0;
		var DivMessageAlert = document.getElementById('<%=rblRate.ClientID %>');
		var colradio = DivMessageAlert.getElementsByTagName('input');
		if (colradio[0].checked || colradio[1].checked || colradio[2].checked || colradio[3].checked) {
			i = i + 1;
		}
		var rblKnowledgeable = document.getElementById('<%=rblKnowledgeable.ClientID %>');
		colradio = rblKnowledgeable.getElementsByTagName('input');
		if (colradio[0].checked || colradio[1].checked || colradio[2].checked || colradio[3].checked) {
			i = i + 1;
		}
		var rblClarity = document.getElementById('<%=rblClarity.ClientID %>');
		colradio = rblClarity.getElementsByTagName('input');
		if (colradio[0].checked || colradio[1].checked || colradio[2].checked || colradio[3].checked) {
			i = i + 1;
		}
		var rblCourteousness = document.getElementById('<%=rblCourteousness.ClientID %>');
		colradio = rblCourteousness.getElementsByTagName('input');
		if (colradio[0].checked || colradio[1].checked || colradio[2].checked || colradio[3].checked) {
			i = i + 1;
		}
		var rblPromptness = document.getElementById('<%=rblPromptness.ClientID %>');
		colradio = rblPromptness.getElementsByTagName('input');
		if (colradio[0].checked || colradio[1].checked || colradio[2].checked || colradio[3].checked) {
			i = i + 1;
		}

		if (i >= 5) {
			document.getElementById('<%=btnYes.ClientID %>').click();
			args.IsValid = true
		}
		else
			args.IsValid = false
	}
 </script>
 </form> 
</body>
</html>


