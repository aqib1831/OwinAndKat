<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AddActivity.aspx.vb" Inherits="MyNetsolace_AddActivity" %>

<%@ Register Assembly="RadComboBox.Net2" Namespace="Telerik.WebControls" TagPrefix="radC" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Netsolace Portal - My Netsolace</title>
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
      <asp:UpdateProgress ID="uprogInbox" runat="server">
        <ProgressTemplate>
         <div class="ProgressIndicatorDIV" >
                    <br />
                    <asp:Image ID="Image2" runat="server" ImageUrl="../images/indicator.gif" ImageAlign="AbsMiddle" /> <span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
                    <br /><br />
                </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
       <table style="width:100%;height:100%; background-color:#BADCFC;" border="0" cellspacing="0" cellpadding="0"  class="MainTable">
         <tr>             
             <td onclick="if (blnShowed == true){showHideVital();}"> 
                <table   style="width:100%;height:100%;background-color:#FFFFFF;" class="Table"   border="0" align="center" cellpadding="0" cellspacing="0" > 
                    <tr>
                       <td >      
                       <asp:HiddenField ID="hdnAreaDeveloperID" runat="server"/>
                       <asp:HiddenField ID="hdnID" runat="server" Value="0" />
                       <asp:HiddenField ID="PrevPage" runat="server" Value="0" />  
                       <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
                       <asp:HiddenField ID="hdnIsClose" runat="server" Value="0" />
                       <asp:HiddenField ID="hdnDueDate" runat="server" Value="0" />                                                                              
                          <table style="width:100%;height:25%; border-color:#7391B9;"  border="0" align="center" cellpadding="0" cellspacing="0" class="Table"  >
                              <tr style="background-color:#DDE4EE;">
                                    <td style="height:31px;" colspan="6">	
                                       <table cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td  colspan="3" class="SimpleBold" style="height:31px;background-color:#BDE7BD;color:#000000;border-bottom:1 solid #609BD3; width:85%; ">
                                                    &nbsp;<asp:Label ID="lblTitle" runat="server" Text="New Ticket" ></asp:Label>
                                                    <span id="spnUpdateMessage" style="display:none; color:#429E8C;"  >--  Record  Updated </span>
                                                </td>                                               							                                                                                   
                                            </tr>
                                       </table>
                                    </td>
                               </tr>     
                               <tr style="border-color:#F5F5F5; background-color:#DEF7D6; display:none;" id="trStoreList" runat="server">
                                    <td  style="width:2%; height:25px;"></td>
                                    <td style="width:7%;" class="SimpleExSmall">For Stores :<span class="RequiredField">*</span></td>
                                    <td style="width:36%;white-space:nowrap;" >
                                       <%-- <radC:RadComboBox ID="ddlStores" AllowCustomText="false" 
                                            Skin="WindowsXP" DropDownWidth="300px" MaxLength="10" Width="150px" Height="100"
                                            MarkFirstMatch="true" runat="server" DataSourceID="sdsStoreList" 
                                            DataTextField="StoreName" DataValueField="ID"  ValidationGroup="vgStoreName"
                                            OnClientBlur="AssignID(this);">
                                        </radC:RadComboBox>--%>
                                        <table cellpadding="0" cellspacing="0" border="0" style="padding:0px; margin:0px; background-color:#ffffff;">
                                         <tr>
                                            <td style="width:20px;border-top:solid 1px #82ABC7;border-bottom:solid 1px #82ABC7;border-left:solid 1px #82ABC7; padding:0px; margin:0px;" align="center"><img src="../images/icn_search.jpg" /></td>
                                            <td style="border-top:solid 1px #82ABC7;border-bottom:solid 1px #82ABC7;border-right:solid 1px #82ABC7; padding:0px; margin:0px;">
                                                <%--<asp:UpdatePanel ID="upStores" runat="server" RenderMode="Inline" UpdateMode="Conditional">   
                                                <ContentTemplate>--%>
                                                <radC:RadComboBox id="ddlStores"                                                         
                                                        runat="server"
                                                        AutoPostBack="true"  
                                                        EnableViewState="true"  
                                                        AllowCustomText="true"
                                                        MarkFirstMatch="true"   
                                                        Width="129px" 
                                                        Height="100"
                                                        Skin="rnd"
                                                        DropDownWidth="300px"
                                                        DataTextField="StoreName" 
                                                        DataValueField="ID"  
                                                        ValidationGroup="vgStoreName" 
                                                        MaxLength="10"
                                                        ShowToggleImage="false"  
                                                        ShowWhileLoading="true"                                                        
                                                        EnableLoadOnDemand="true"
                                                        HighlightTemplatedItems="true">                                                   
                                                </radC:RadComboBox >                                                
                                               <%-- </ContentTemplate> 
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="ddlStores" EventName="SelectedIndexChanged" />
                                                 </Triggers>                               
                                              </asp:UpdatePanel>--%>
                                            </td> 
                                         </table>
                                         <asp:CustomValidator ID="CustomValidator1" 
                                                ValidationGroup="vgStoreName" 
                                                Display="Dynamic" 
                                                CssClass="RequiredField" 
                                                ClientValidationFunction="checkvalue"  
                                                ErrorMessage="Search Store" 
                                                runat="server">
                                          </asp:CustomValidator>
                                     <%--<asp:RequiredFieldValidator ID="rfvStores" ValidationGroup="vgStoreName" runat="server" InitialValue="0" ErrorMessage="Select a store" Display="Dynamic" ControlToValidate="ddlStores" ></asp:RequiredFieldValidator>--%>
                                     
                                     <asp:SqlDataSource ID="sdsStoreList" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                        SelectCommand="Franchises_GetAll_ByClientID" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="hdnClientID" DefaultValue="0" Name="ClientID" PropertyName="Value"
                                                Type="Int32" />
                                            <asp:ControlParameter ControlID="hdnAreaDeveloperID" DefaultValue="0" Name="AreaDeveloperID" PropertyName="Value"
                                                Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                                                                       
                                    </td>
                                    <td style="width:45%;" colspan="3"></td>                                    
                              </tr>    
                              <tr > 
                                    <td height="1"  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" alt="" /></td>
                              </tr>                                                                        
                              <tr style="border-color:#F5F5F5; background-color:#DEF7D6; display:none;" id="trContactList" runat="server">
                                    <td style="width:2%; height:25px;"></td>   
                                    <td style="width:7%;" class="SimpleExSmall">Contact:<span class="RequiredField">*</span></td>
                                    <td style="width:36%;" >
                                    <asp:UpdatePanel ID="upFranchiseContacts" runat="server"  RenderMode="Inline" UpdateMode="conditional" >   
                                    <ContentTemplate>
                                     <asp:HiddenField ID="hdnFranchiseID" runat="server" Value="0" />
                                    <asp:DropDownList ID="ddlFranchiseContact" 
                                            runat="server"                                 
                                            AutoPostBack="false"
                                            Width="150px" Height="100" 
                                            Font-Size="12px"                                                                                       
                                            ValidationGroup="vgContacts" 
                                            DataSourceID="sdsContacts" 
                                            DataTextField="NameTitle"  
                                            DataValueField="ID" >
                                        </asp:DropDownList>
                                     <asp:ObjectDataSource ID="sdsContacts" runat="server"
                                        OldValuesParameterFormatString="original_{0}"                                                
                                        SelectMethod="FranchisesContactByID"
                                        TypeName="Portal.BLL.Franchises"> 
                                        <SelectParameters>
                                              <asp:ControlParameter  Name="ClientID" Type="Int32" ControlID="hdnClientID" PropertyName="Value" />                      
                                              <asp:ControlParameter  Name="FranchiseID" Type="Int32" ControlID="ddlStores" PropertyName="Value" />                      
                                        </SelectParameters>                                                                                         
                                     </asp:ObjectDataSource>
                                     </ContentTemplate>
                                     <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="ddlStores" EventName="SelectedIndexChanged" />
                                     </Triggers>        
                                     </asp:UpdatePanel>
                                     <%--<asp:CompareValidator ID="valContact" 
                                        runat="server" 
                                        ValidationGroup="vgContacts"
                                        ControlToValidate="ddlFranchiseContact"
                                        Operator="NotEqual"
                                        ValueToCompare="Select..." 
                                        Display="Dynamic"
                                        ErrorMessage="Select Contact"
                                        CssClass="ErrorMessage" >
                                     </asp:CompareValidator>  --%>
                                     <asp:CustomValidator ID="CustomValidator2" 
                                        ValidationGroup="vgContacts" 
                                        Display="Dynamic" 
                                        CssClass="RequiredField" 
                                        ClientValidationFunction="checkvalue2"  
                                        ErrorMessage="Select Contact"
                                        runat="server">
                                     </asp:CustomValidator>
                                    </td>
                                    <td style="width:45%;" colspan="3"></td>                                    
                              </tr>                    
                              <tr id="trSeparator"> 
                                    <td height="1"  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" alt="" /></td>
                              </tr> 
                              <tr style="border-color:#F5F5F5; background-color:#DEF7D6;" valign="middle">
                                    <td ></td>
                                    <td  style="height:25px;" class="SimpleExSmall">Related To:<span class="RequiredField">*</span></td>
                                    <td>
                                         <asp:DropDownList ID="ddlProducts" 
                                            CssClass="SmallGreenTextBox" 
                                            runat="server" 
                                            Width="150px" 
                                            AutoPostBack="true" 
                                            DataSourceID="SDS_Products" 
                                            DataTextField="Title" 
                                            DataValueField="ID" >
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SDS_Products" runat="server" ConnectionString="<%$ConnectionStrings:PortalConnectionString%>"
                                                SelectCommand="NS_Products_GetAllForModules" SelectCommandType="StoredProcedure" DataSourceMode="DataReader">                                            
                                        </asp:SqlDataSource>   
                                        <asp:CompareValidator ID="CV_ddlProducts" runat="server" 
                                            ControlToValidate="ddlProducts"
                                            ValidationGroup="vgActivity"
                                            Operator="GreaterThan"
                                            ErrorMessage="Select Related To"
                                            ValueToCompare="0" 
                                            Display="Dynamic"
                                            CssClass="ErrorMessage">
                                     </asp:CompareValidator>
                                    </td>
                                    <td colspan="3">&nbsp;</td>                                                                                               
                              </tr>
                              <tr id="Tr_ModuleSpacer"> 
                                    <td  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" /></td>
                              </tr>
                              <tr id="Tr_Module" style="border-color:#F5F5F5; background-color:#DEF7D6;" valign="middle">
                                    <td style="height:25px;" ></td>
                                    <td class="SimpleExSmall" >Module:<span class="RequiredField">*</span></td>
                                    <td>
                                        <asp:UpdatePanel ID="upDivModules" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                        <table cellpadding="0" cellspacing="0" width="100%">
                                            <tr>                                                
                                                <td>
                                                    <asp:DropDownList ID="ddlModule" 
                                                        runat="server"
                                                        CssClass="SmallGreenTextBox" 
                                                        DataSourceID="sdsModules"                                                        
                                                        DataTextField="Name"
                                                        DataValueField="ID"
                                                        Width="150px">
                                                    </asp:DropDownList>
                                                    <asp:SqlDataSource 
                                                        ID="sdsModules"
                                                        runat="server" 
                                                        ConnectionString="<%$ConnectionStrings:PortalConnectionString%>"
                                                        SelectCommand="NS_ProductModules_GetByProductID" 
                                                        SelectCommandType="StoredProcedure">
                                                        <SelectParameters>
                                                            <asp:ControlParameter ControlID="ddlProducts" Name="ProductID" PropertyName="SelectedValue" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                    <asp:CompareValidator ID="cvModules" runat="server" 
                                                        ControlToValidate="ddlModule"
                                                        Operator="GreaterThan"
                                                        ValidationGroup="vgActivity"
                                                        ErrorMessage="Select Module"
                                                        ValueToCompare="0"                                    
                                                        CssClass="ErrorMessage">
                                                    </asp:CompareValidator>
                                                </td>
                                            </tr>
                                        </table>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlProducts" EventName="SelectedIndexChanged"/>
                                        </Triggers>
                                        </asp:UpdatePanel>
                                    </td>
                                    <td colspan="3">&nbsp;</td>                                                                                               
                              </tr>
                              <tr > 
                                    <td  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" /></td>
                              </tr>
                              <tr style="border-color:#F5F5F5; background-color:#DEF7D6;" valign="middle">
                                    <td ></td>
                                    <td  style="height:25px;" class="SimpleExSmall">Date: </td>
                                    <td>                            
                                        <strong><asp:Label  ID="txtDueDate" runat="server" Width="150px" style="white-space:nowrap;"></asp:Label></strong>
                                    </td>
                                    <td colspan="3">&nbsp;</td>                                                                                               
                              </tr>
                              <tr > 
                                    <td  colspan="6"><img  src="../images/spacer.gif" width="1" height="1" /></td>
                              </tr>                                                         
                               <tr style="border-color:#E9E9E9; background-color:#BDE7BD">
                                    <td style="height:25px;"></td>
                                    <td class="SimpleExSmall" >Subject:<span class="RequiredField">*</span></td>
                                    <td  colspan="3" >
                                        <asp:TextBox runat="server" ID="txtActivitySubject" ValidationGroup="vgActivity" Text="" MaxLength="500"  CssClass="SmallGreenTextBox" Width="80%" />
                                        <asp:RegularExpressionValidator 
                                        ID="revDescrpHtml" 
                                        runat="server" 
                                        ValidationGroup="vgActivity"
                                        ControlToValidate="txtActivitySubject"
                                        ErrorMessage="<br>Enter valid subject." ValidationExpression="^[^<>]*$" CssClass="RequiredField" Display="Dynamic">
                                        </asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="valSubject" runat="server"
                                            ControlToValidate="txtActivitySubject"
                                            ErrorMessage="<br>Enter Subject"
                                            Display="Dynamic"
                                            ValidationGroup="vgActivity"
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
                                            ValidationGroup="vgActivity"
                                            CssClass="ErrorMessage" >
                                        </asp:RequiredFieldValidator>
                                            <asp:CustomValidator ID="CSTValidater" CssClass="ErrorMessage" ValidationGroup="vgActivity" ControlToValidate="txtDescription" Display="Dynamic" ClientValidationFunction="Checklength" runat="server" ErrorMessage="&nbsp;Not more then 4000 charaters allowed"></asp:CustomValidator>
                                        <asp:TextBox runat="server" 
                                             ID="txtDescription" 
                                             TextMode="MultiLine" 
                                             ValidationGroup="vgActivity"
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
                          <table style="width:100%; height:31px; padding-top:5px;" border="0" cellpadding="0" cellspacing="0" >
                            <tr>
                                <td class="SimpleExSmall" style="width:35%">
                                    <div runat="server"  id="divStatus" style="display:none;">&nbsp;Status:<span class="RequiredField">*</span>&nbsp;                           
                                        <asp:DropDownList ID="ddlActivityStatus"   
                                            CssClass="SmallGreenTextBox"
                                            runat="server">
                                            <asp:ListItem Value="0" Text="Select..." ></asp:ListItem>
                                            <asp:ListItem Value="1" Text="Not Started" Selected="True" ></asp:ListItem>
                                            <asp:ListItem Value="2" Text="In Progress" ></asp:ListItem>
                                            <asp:ListItem Value="4" Text="Waiting For" ></asp:ListItem>
                                            <asp:ListItem Value="3" Text="Completed" ></asp:ListItem>
                                        </asp:DropDownList>
                                   </div>
                               </td>
                                <td class="SimpleExSmall"  style="width:55%; ">
                                    <div  runat="server" id="waitingfor" style="display:none;">Waiting For: <span class="RequiredField">*</span>
                                    <asp:DropDownList ID="ddlWaitingFor" 
                                        runat="server" 
                                        ValidationGroup="WaitingFor"
                                        CausesValidation="true"   
                                        OnDataBound="ddlWaitingFor_DataBound" 
                                        DataSourceID="sdsWaitingFor" 
                                        DataTextField="Name"  
                                        CssClass="SmallGreenTextBox" 
                                        DataValueField="ID"  Width="50%" >
                                    </asp:DropDownList>
                                        <asp:SqlDataSource ID="sdsWaitingFor" runat="server"
                                            ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>" 
                                            SelectCommand="Users_GetAll" 
                                            SelectCommandType="StoredProcedure">
                                        </asp:SqlDataSource>                                        
                                   </div>
                                  </td>
                                 <td style="width:25%;" align="right">                                                                                                    
                                    <asp:Button ID="btnSave" runat="server"  CssClass="Btn3D" CausesValidation="True" OnClientClick="if(ValidatePage() == false) return false;" Text="Save" Width="80px" />&nbsp;&nbsp;
                                    <asp:Button ID="btnBack" runat="server" CssClass="Btn3D" Width="80px"  Text="Cancel" CausesValidation="False"/> &nbsp;&nbsp;
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
 </form>
 <script language="javascript" type="text/javascript">
 function Checklength(oSrc, args){
           
            if($get('<%= txtDescription.ClientID %>').value.length<=4000)
                {
                args.IsValid = true;
               }
            else
            {
             args.IsValid = false;
             }          
             
        }
    function SetModuleDisplay(display){
        document.getElementById('Tr_Module').style.display=display;
        document.getElementById('Tr_ModuleSpacer').style.display=display;
    }    
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
		             return true;
		            }
            		
            }   
            
       function CheckWaitingFor(oSrc, args)
            {
              var ActivityState = document.getElementById('<%=ddlActivityStatus.ClientID %>')
              var WaitingFor = document.getElementById('<%=ddlWaitingFor.ClientID %>')             
                if (ActivityState.value == "4")
                    {	                   
	                    if(WaitingFor.value == "0")
	                    {
	                    args.IsValid = false;
	                    }
	                    else 
	                    {
	                    args.IsValid = true;		                
	                    }		            
	                }            		
                else
	                {    		            	            
	                 args.IsValid = true;		               
	                }
            }
            
      function showAttachFiles()
    {
        document.getElementById("Attachment").style.display='inline';
        setWindowedControlsVisibility(window, 'hidden');
    }
    
    function OnAttachmentSubmit()
    {
      var Fupload = document.getElementById('<%=File1.ClientID%>')
        var count = 0 
        if (Fupload.value != '' )
        {
        count = count+1
        }
        Fupload = document.getElementById('<%=File2.ClientID%>')
        if (Fupload.value != '' )
        {
        count = count+1
        }
        Fupload = document.getElementById('<%=File3.ClientID%>')
        if (Fupload.value != '' )
        {
        count = count+1
        }       
        document.getElementById('AttachmentTotal').innerHTML = count       
	    document.getElementById("Attachment").style.display='none';
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
//            var Fupload = document.getElementById('<%=File2.ClientID%>');
//            var TD = Fupload.parentElement ;
//            var str = TD.innerHTML;
//            str = str.replace(Fupload.value,'');
         	//            TD.innerHTML = str;
         	form1.file2.parentNode.innerHTML = form1.file2.parentNode.innerHTML;
         } 
     function ResetAttachment1()
         {
         
//            var Fupload = document.getElementById('<%=File1.ClientID%>');
//            var TD = Fupload.parentElement ;
//            var str = TD.innerHTML;
//            str = str.replace(Fupload.value,'');
//            TD.innerHTML = str;
         	form1.file1.parentNode.innerHTML = form1.file1.parentNode.innerHTML;
         } 
   
    function ResetAttachment3()
        {
         
//           var Fupload = document.getElementById('<%=File3.ClientID%>');
//           var TD = Fupload.parentElement ;
//           var str = TD.innerHTML;
//           str = str.replace(Fupload.value,'');
        	//           TD.innerHTML = str ;
        	form1.file3.parentNode.innerHTML = form1.file3.parentNode.innerHTML;
        } 
    var isselected = false;    
    function ValidatePage()
    {
        if(document.getElementById('<%= trStoreList.ClientID %>').style.display == 'inline')
        {   
            if(Page_ClientValidate('vgStoreName'))
            { 
                if(Page_ClientValidate('vgContacts'))
                {
                    return Page_ClientValidate('vgActivity');
                }
                else
                    return false;               
            }
            else
                return false;
                
        }
        else
        {     
             return Page_ClientValidate('vgActivity');   
        }       
    }   
   
    function checkvalue(sender,args){
//     var ddlstores = document.getElementById('<%=ddlstores.ClientID %>');        
//       alert('checkvalue');
//       alert(tlrkComboBoxes[0].GetValue());
        if(tlrkComboBoxes[0].GetValue() == '0' || tlrkComboBoxes[0].GetValue() == '')                                
           args.IsValid = false;
        else 
            args.IsValid = true;
        } 
    function checkvalue2(sender,args){
       //alert('checkvalue2');
       //alert(tlrkComboBoxes[1]);
       var ddlFranchiseContact = document.getElementById('<%=ddlFranchiseContact.ClientID %>'); 
       //alert(ddlFranchiseContact.value);
        if(ddlFranchiseContact.value == 0)                                
           args.IsValid = false;
        else 
            args.IsValid = true;
        }           
 </script>   
</body>
</html>

