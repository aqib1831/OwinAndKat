 <%@ Page Language="VB" AutoEventWireup="false" CodeFile="TicketsDetail.aspx.vb" Inherits="PM_TicketsDetail"
    ValidateRequest="false" EnableEventValidation="false" ViewStateEncryptionMode="never" %>
<%@ Import Namespace="Portal.BLL" %>
<%@ Register TagPrefix="radU" Namespace="Telerik.WebControls" Assembly="RadUpload.Net2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Src="VitalInformationFloatingDiv.ascx" TagName="VitalInformationFloatingDiv" TagPrefix="CsCtrl" %>


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Ticket Details</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <link href="../App_Themes/Default/Calendar/style.css" rel="stylesheet" type="text/css" />        
  
    <link href="PMStyle.css" rel="stylesheet" type="text/css" />       
    <script type="text/javascript">
        var IsNewNotesEnabled = true;
        var IsLoadComplete = false;
    </script>
    <style>
        
         #tblUsersTimeSpentOnTicket tbody tr td
         {
             border-bottom: 1px solid gray;
         }
        .WhtLine img
        {
            height: 10px;
            width: 10px;
         
        }
        p {
            margin-top:0px;
            margin-bottom:5px;
        }
        .txt_black {
            font-size:14px !important;
        }
        #DivTicketDetail .FormInnerTable td {
            padding-top:2px;
            padding-bottom:2px;
        }
        #cke_2_resizer{
            display:none ;
        }
        .Form{
            margin-top:-10px;
        }
    </style>
</head>
<body style="margin: 0px; height: 100%;" onresize="OnResize();DivNotesDisplay_onload();">
    <form id="form1" runat="server">
    <script type="text/javascript">
        function OnStatusCompleted() {
            if (confirm("The Status has been selected as Compeletd.\n To confirm press OK, otherwise Cancel") == false) {
                BlackDivHide();
                return false;
            }
        }

        function BlackDivDisplay() {
            var divDisable = getElement('divDisable');
            divDisable.style.width = document.body.scrollWidth;
            divDisable.style.height = document.body.scrollHeight;
            divDisable.style.display = "Block";
        }
        function BlackDivDisplayVisible() {
            var divDisable = getElement('divDisable');
            divDisable.style.width = document.body.scrollWidth;
            divDisable.style.height = document.body.scrollHeight;
            divDisable.style.display = "Block";
            divDisable.style.visibility = "visible";
        }
        function BlackDivHide() {
            var divDisable = getElement('divDisable');
            divDisable.style.width = 0
            divDisable.style.height = 0
            divDisable.style.display = 'none';
        }
        function OnTicketReopen() {
            if (confirm('Are you sure you want to Reopen this ticket.\nTo Reopen press OK, otherwise Cancel') == false) {
                BlackDivHide();
                return false;
            }
        }
    </script>    
    <asp:ScriptManager ID="scTicketDetails" runat="server" AsyncPostBackTimeout="100" ScriptMode="Release" />
    <asp:UpdateProgress ID="Progress1" runat="server">
        <ProgressTemplate>
            <div class="ProgressIndicatorDIVGreen">
                <br />
                <asp:Image ID="imgIndicator" runat="server" ImageUrl="../images/indicator.gif" ImageAlign="AbsMiddle" />
                <span style="color: #4B92C1; font-size: 14px;"><b>&nbsp;&nbsp;Updating ...</b></span>
                <br />
                <br />
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <radU:RadProgressManager ID="Radprogressmanager1" runat="server" />
    <div align="center" id="progress" style="position: absolute; z-index: 405;">
        <radU:RadProgressArea ID="RadProgressArea1" runat="server">
        </radU:RadProgressArea>
    </div> 
     
       <div id="DivTicketDetail" style="position: absolute; display: none;width:455px;z-index: 102;height: 175px; background-color:#AAD3EF;border:1px solid #609BD3;">
           <table cellspacing="0" cellpadding="0" border="0" style="height:100%;width:100%;">
              <tr>
                  <td style="height:20px; padding:5px;">
                     <b>Search and Add Linked Ticket</b>
                    <%--   <span style="padding-bottom:10px;"> <b>Search and Add Linked Ticket&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;</b>
                       <span style="float:right;"></span><img src="../images/closebox2.gif" onclick="HideDiv();" style="cursor: pointer;"> </span>
                    &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                       --%>
                  
               </td>
                  <td style="text-align:right; padding-right:5px;">
                      <img src="../images/closebox2.gif" onclick="HideDiv();" style="cursor: pointer;">
                  </td>

              </tr>
               <tr>
                   <td style="height:40px; padding:5px;border-bottom:1px solid #609BD3;" colspan="2">
                       <asp:TextBox ID="txtSearchBox" runat="server"  Width="165" ValidationGroup="btn"></asp:TextBox> 
                     
                         <asp:Button ID="btnSearchpop" ValidationGroup="btn" Text ="Search" runat="server" Font-Size="10" OnClientClick="return validate()" OnClick ="btnSearchpop_Click" Style="margin-left :10px; border:none;background-color:white;" />
                     <br/>  <asp:RegularExpressionValidator id="RegularExpressionValidator1"
                                                       ControlToValidate="txtSearchBox"
                                                       ValidationExpression="^[\d\s]+$"
                                                       Display="Dynamic"
                                                       EnableClientScript="true"
                                                       ErrorMessage="Please enter numbers only"
                                                       runat="server"/>
                        </td>
               </tr>

               <tr>
                   <td style=padding:5px;background-color:white;" colspan="2">
                    <div style=" width:70%;">
                       <asp:GridView ID="ticketGrid"  EmptyDataText="No data found!" runat="server" Width="100%" AutoGenerateColumns="false" ShowHeader="False" BorderStyle="None" GridLines="None" Style="padding: 10px;">
                             <emptydatatemplate><asp:Label Text="No Data found ." runat="server"></asp:Label></emptydatatemplate> 
                            <Columns>
                                <asp:TemplateField HeaderText="Type" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true">
                                    <ItemTemplate> <asp:CheckBox ID="checkTicket" runat="server" Checked Enabled="false" /> </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Type" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true">
                                    <ItemTemplate>
                                        <asp:Label ID="ticketNumber" runat="server" Text='<%#Eval("ID")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Label ID="ticketName" runat="server" Text='<%#Eval("Name")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>

                    </div>
                  </td>
              </tr>
               <tr>
                   <td align="center" style="height: 40px; vertical-align: middle;" colspan="2">
                       <asp:Button ID="btnSaveTicket"   runat="server" Text="Save" CssClass="Btn3D" Width="80px" OnClick="btnSaveTicket_Click" />&nbsp;&nbsp;
                       <%-- <input type="button" class="Btn3D" value="Cancel" id="btnCancelTicket" runat="server" onclick ="" />--%>
                       <asp:Button ID="Button3" runat="server" Text="Cancel" CausesValidation="false" UseSubmitBehavior="false" OnClick="Button3_Click" CssClass="Btn3D" />
                      
                   </td>
               </tr>
            </table>
       </div>





           <div id="DivTicketFlag" style="position: absolute; display: none;width:495px;z-index: 102;height: 275px; background-color:#A1CCEE;border:1px solid #609BD3;">
           <table cellspacing="0" cellpadding="0" border="0" style="height:100%;width:100%;">
              <tr>
                  
                  <td style="height:30px; text-align:right; padding-right:5px;">
                      <img src="../images/closebox2.gif" onclick=" HideDivFlag();" style="cursor: pointer;">
                  </td>

              </tr>
               <tr>
                   <td style="height:100px; padding:5px;text-align:center;background-color:#D9EAFA;" >
                     <div style="width:90%;height:44px; background-color:white;text-align:center;border:1px solid #1F497D; z-index: 1;box-shadow:inset 10px 10px 5px #888;" >
                         <span style="position:relative ;top:8px;font-size:15px;"><b>Are you sure you want to add a follow-up flag to this ticket?</b></span>
                     </div>
                      
                 <%--  </td>
               </tr>

               <tr>
                   <td style=padding:0px;background-color:#D9EAFA;text-align:center;">--%>
                       <span style="padding:5px;width:90%;text-align:left;font-size:13px;"> Comments <span style="color:#808080"> (Optional)</span></span>
                       <div style="width:90%;height:70px; background-color:white;">
                           <asp:TextBox ID="flagComments" runat="server" Style="width: 100%; height: 100%;font-size:15px;border:1px solid #1F497D;"
                                                TextMode="MultiLine"></asp:TextBox>
                          
                      <%--  <asp:TextBox ID="flagComments" ></asp:TextBox>--%>
                      <%-- <textarea id="comments" runat="server"></textarea>--%>
                       </div>
                       <span style="padding:5px;width:90%;text-align:left; color:#808080; font-size :13px;"> Note:These comments will not be visible to client</span>
                      <div  style="padding:5px;width:90%; text-align:left;">
                          <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="Btn3D" Width="80px" OnClick="btnSubmit_Click" />&nbsp;&nbsp;
                       <input type="button" class="Btn3D" value="Cancel" id="btnCancelTicket" runat="server" onclick =" HideDivFlag();" />
                       <%--<asp:Button ID="Button5" runat="server" Text="Cancel" CausesValidation="false" UseSubmitBehavior="false" OnClick="Button3_Click" CssClass="Btn3D" />--%>
                      </div>
                  </td>
              </tr>
              <%-- <tr>
                   <td align="center" style="height: 40px; vertical-align: middle;" colspan="2">
                     <%--  <asp:Button ID="Button4" runat="server" Text="Save" CssClass="Btn3D" Width="80px" OnClick="btnSaveTicket_Click" />&nbsp;&nbsp;
                       <%-- <input type="button" class="Btn3D" value="Cancel" id="btnCancelTicket" runat="server" onclick ="" />--%>
                       <%--<asp:Button ID="Button5" runat="server" Text="Cancel" CausesValidation="false" UseSubmitBehavior="false" OnClick="Button3_Click" CssClass="Btn3D" />--%>
                      
               <%--    </td>
               </tr>--%>
            </table>
       </div>

           <div id="DivTicketFlagRemove" style="position: absolute; display: none;width:500px;z-index: 102;height: 50px; background-color:#A1CCEE;border:1px solid #609BD3;">
           <table cellspacing="0" cellpadding="0" border="0" style="height:100%;width:100%;">
              <tr>
                  
                  <td style="height:30px; text-align:right; padding-right:5px;">
                    
                  </td>

              </tr>
               <tr>
                   <td style="height:100px; padding:5px;text-align:center;background-color:#D9EAFA;" >
                     <div style="width:93%;height:44px; background-color:white;text-align:center;border:1px solid #1F497D; z-index: 1;box-shadow:inset 10px 10px 5px #888;" >
                         <span style="position:relative ;top:8px;font-size:15px;"><b>Are you sure you want to remove follow-up flag for this ticket?</b></span>
                     </div>
                      
                  </td>
               </tr>

               <tr>
                   <td style=padding:0px;background-color:#D9EAFA;text-align:center;">
                      
                      <div  style="padding:5px;width:90%; text-align:center ;">
                          <asp:Button ID="btnYes" runat="server" Text="Yes" CssClass="Btn3D" Width="80px" OnClick="btnYes_Click" />&nbsp;&nbsp;
                         <input type="button" class="Btn3D" value="No" id="btnNo" runat="server" onclick ="HideDivRemoveFlag();" />
                      
                      </div>
                  </td>
              </tr>
             
            </table>
       </div>
          
        <table style="width: 100%; height: 100%; background-color: #BADCFC;" border="0" cellspacing="0" cellpadding="0" class="MainTable">
        <tr>
            
            <td style="width: 27px;">
                    <asp:UpdatePanel ID="update1" runat="server" UpdateMode="Always" RenderMode="Block">
                        <ContentTemplate>
                            <CsCtrl:VitalInformationFloatingDiv ID="VitalInformationFloatingDiv" runat="server" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:HiddenField ID="hdnSubject" runat="server" />
                    <asp:HiddenField ID="hdnTicket" runat="server" />
                    <asp:HiddenField ID="hdnRelatedTo" runat="server" />
                </td>
                <td style="padding: 5px;" onclick="if (blnShowed == true){showHideVital();}">  <%--HideAttachFiles(); DivOptionHide(); --%>
                    <table width="100%" style="height: 100%; margin: 0px; padding: 0px; background-color: white; border: solid 1px #6298D0;" cellspacing="0" cellpadding="0" border="0">
               <asp:HiddenField ID="hdnIDPre" runat="server" Value="0" EnableViewState="false" />
                <asp:HiddenField ID="hdnID" runat="server" Value="0" EnableViewState="false" />
                <asp:HiddenField ID="PrevPage" runat="server" Value="0" EnableViewState="false" />
                <asp:HiddenField ID="hdnDueDate" runat="server" Value="0" EnableViewState="false" />
                <asp:HiddenField ID="IsRelease" runat="server" Value="0" EnableViewState="false" />
                <asp:HiddenField ID="hdnTimeSpent" runat="server" Value="00:00:00" EnableViewState="false" />
                <asp:HiddenField ID="hdnUserID" runat="server" Value="0" />
                <asp:HiddenField ID="hdnRefNo" runat="server" Value="0" EnableViewState="false" />
                <asp:HiddenField ID="hdnIsReadOnlyAccess" runat="server" Value="0" EnableViewState="false" />
                <asp:HiddenField ID="hdnClientID" runat="server" Value="0" EnableViewState="false" />
                <asp:HiddenField ID="hdnClientContactID" runat="server" Value="0" EnableViewState="false" />
                <asp:HiddenField ID="hdnPrevReleaseId" runat="server" />                            
                <asp:HiddenField ID="hdnDueDateShowToClient" runat="server" EnableViewState="false" />
                <asp:HiddenField ID="hdnShowDueDateForFlag" runat="server" EnableViewState="false" />
                <asp:HiddenField ID="hdnIsListChanged" runat="server" Value="0"  />
                <asp:HiddenField ID="hdnAssignTo" runat="server" Value="0"  />
                <asp:HiddenField ID="hdnStatus" runat="server" Value="0"  />                
                <asp:HiddenField ID="hdnClientStatusId" runat="server" Value="0"  />
                <asp:HiddenField ID="hdnAreaDeveloperID" runat="server" Value="0"  />
                <asp:HiddenField ID="hdnCategoryID" runat="server" Value="0" EnableViewState="false" />
                 <asp:HiddenField ID="hdnSubCategoryID" runat="server" Value="0" EnableViewState="false" />
                        <asp:HiddenField ID="hdnIsFeedBackRequired" runat="server" Value="0" EnableViewState="false" />
                <asp:HiddenField ID="hndProductOwnerID" runat="server" Value="0"  /> 
                         <asp:HiddenField ID="Tfield" runat="server" Value="0"  />

                <iframe id="divDisable" name="divDisable" marginheight="0" marginwidth="0" scrolling="no"
                    frameborder="0" src="../BlankPage.htm"></iframe>
                <iframe id="IframeDownload" name="IframeDownload" marginheight="0" marginwidth="0"
                            scrolling="no" frameborder="0" style="display: none; width: 0; height: 0;" src="../BlankPage.htm"></iframe>
                        <%--       <table style="width: 100%; height: 100%;" border="0" cellpadding="0" cellspacing="0">--%>
                    <tr>
                        <td style="height: 100px;">
                                <table style="width: 100%; height: 100px; border-color: #7391B9; background-color: #DEF7D6; font-size: 11px;"
                                    border="0" align="left" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td height="31" colspan="9">
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%" style="background-color: #DDE4EE;">
                                                <tr>
                                                    <td width="60%" height="31" class="SimpleBold" style="background-color: #BDE7BD; color: #000000; border-bottom: 1 solid #609BD3;">&nbsp;<asp:Label ID="lblTitle" runat="server" Text="Ticket Detail" EnableViewState="false"></asp:Label>&nbsp;
                                                    <asp:Image ID="ImgPriority" runat="server" EnableViewState="false" />
                                                        <span style="width: 40px;">
                                                            <asp:UpdatePanel ID="upanel11" runat="server" UpdateMode="Always">
                                                                <ContentTemplate>
                                   
                                                                    <asp:Image ID="imgDueDate" runat="server" EnableViewState="False" />
                                                                    <asp:Image ID="imgFlag" runat="server" AlternateText="Delayed Ticket" EnableViewState="false" />
                                                                     <asp:Image ID="ImageBlueFlag" runat="server" EnableViewState="false" Visible="false" />
                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>
                                                        

                                                        </span>
                                                        
                                                        <span id="spnUpdateMessage" style="display: none; color: #429E8C;">-- Due-date
                                                        Updated </span>
                                                       <asp:DropDownList ID="linkedTickets" runat="server" 
                                                            onchange="YourChangeFun(this);" Width="150" Height ="20" Font-Size ="8" OnDataBound="linkedTickets_DataBound" DataTextField="Subject"
                                                            DataValueField="Link_Ticket_Feature_Id" DataSourceID="LinkTicket">
                                                            <%--<asp:ListItem  Enabled="true" Text="Linked Tickets" Value="-1"></asp:ListItem>--%>
                                                            <%-- <asp:listitem Text="Add Ticket"></asp:listitem>--%>
                                                        </asp:DropDownList>
                                                        <asp:ObjectDataSource ID="LinkTicket" runat="server" SelectMethod="PM_TicketFeature_TicketLink_GetByTicketID" TypeName="Portal.BLL.PM.PM_Ticket_Features">
                                                        <SelectParameters>
                                                            <asp:ControlParameter Name="TicketID" Type="Int32" ControlID="hdnID" PropertyName="Value" />

                                                        </SelectParameters>
                                                    </asp:ObjectDataSource>
                                                    </td>
                                                    <td class="SimpleBold" style="width: 40%; text-align: right; background-color: #BDE7BD; color: #000000; border-bottom: 1 solid #609BD3; white-space: nowrap;">
                                                        <span>
                                                            <img alt="" src="../images/print.gif" align="absmiddle" style="cursor: pointer;"
                                                                onclick="window.open('TicketsReport.aspx?TicketID= <%= Request.QueryString("ID") %>')" />
                                                            <asp:HyperLink ID="lBtnPrint" runat="server" CausesValidation="false" Visible="true" EnableViewState="false"
                                                                Style="text-align: right; font-size: 11px; width: 23px; height: 18px; top: 3px; position: relative;"
                                                                Text="Print" Target="_blank" />&nbsp;

                                                        <asp:UpdatePanel ID="upBtnEditTicketDetail" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                                            <ContentTemplate>
                                                                <span id="spnEditTicketDetail" runat="server">
                                                                    <img alt="" src="../images/icn_Edit.png" onclick="EditTicketDetail();" align="absmiddle" style="cursor: pointer; margin-right: 2px;" />
                                                                    <asp:LinkButton ID="btnEditTicketDetail" runat="server" CausesValidation="false" Style="padding-right: 5px; text-align: right; font-size: 11px; width: 25px; height: 18px; top: 3px; position: relative;"
                                                                        Text="Edit" /></span>
                                                            </ContentTemplate>
                                                         </asp:UpdatePanel>
                                                                </span>

                                                     


                                                    <asp:UpdatePanel ID="UPSpanCompleted" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                                        <ContentTemplate>
                                                            <span id="SpanCompleted" runat="server" visible="false">
                                                                <img alt="" src="../images/icn_selected.gif" align="absmiddle" height="18" width="18"
                                                                    style="cursor: pointer;" onclick="BtnClose.click();" />
                                                                    <asp:LinkButton ID="BtnClose" runat="server" OnClientClick="BlackDivDisplay();return OnStatusCompleted();"
                                                                        CausesValidation="false" Style="padding-right: 5px; text-align: right; font-size: 11px; width: 25px; height: 18px; top: 3px; position: relative;"
                                                                        Text="Mark as completed" />
                                                                </span>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                    <tr class="bdrbWhite">
                                        <td style="width: 2%; height: 20px;">&nbsp;
                                        </td>
                                        <td style="width: 7%;">From:
                                        </td>
                                        <td style="width: 17%;"><strong><asp:Label runat="server" ID="lblAssignBy" EnableViewState="false" /></strong>
                                        </td>
                                        <td style="width: 2%;">&nbsp;
                                        </td>
                                        <td style="width: 7%;" class="SimpleExSmall">Type:
                                        </td>
                                        <td style="width: 14%;">
                                            <strong>
                                                <asp:Label runat="server" ID="lblActivityType" EnableViewState="false" /></strong>
                                        </td>
                                        <td style="width: 7%">Client:
                                        </td>
                                        <td style="width: 22%; white-space: nowrap;">
                                            <span style="float: left; position: relative;"><strong>
                                                <asp:Label runat="server" ID="lblClientName" EnableViewState="false" /></strong></span>
                                        </td>
                                        <td style="width: 22%;">Total Time&nbsp;(HH:MM): &nbsp;<b>
                                            <%-- <asp:Label runat="server" ID="lblTotalTimeSpent" Text="00:00:00" EnableViewState="false" OnClientClick="Notes(); return false;" />--%>
                                            <asp:LinkButton ID="lblTotalTimeSpent" runat="server" Text="00:00:00" EnableViewState="false"
                                                OnClientClick="TotalTimeSpent(); return false;" />
                                        </b>
                                        </td>
                                    </tr>
                                    <tr class="bdrbWhite">
                                        <td style="height: 20px">&nbsp;
                                        </td>
                                        <td>Due Date:
                                        </td>
                                        <td>
                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="always"
                                                RenderMode="block">
                                                <ContentTemplate>
                                                    <strong>
                                                        <asp:Label runat="server" ID="lblActivityDueDate" Text="" Visible="false" EnableViewState="false" />
                                                        <div id="DivDueDateTime" visible="true" runat="server" style="white-space: nowrap;">
                                                        <asp:CheckBox ID="chkDueDateShowToClient" runat="server" ToolTip="Show due date to client"
                                                             onclick="ShowDueDateVisibility();" />
                                                        <asp:TextBox ID="txtActivityDueDate" runat="server" MaxLength="50" Width="78" CssClass="SmallGreenTextBox"
                                                            EnableViewState="true" onfocus="javascript:this.blur();img1.click();" />&nbsp;
                                                        <img id="img1" src="../images/icn_calendar.png" border="0" align="absMiddle" onclick="setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtActivityDueDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');" />&nbsp;
                                                        <a href="#" onclick="ShowDueDateExtension();" runat="server" id="btnUpdateDueDate">Update</a>
                                                    </div>
                                                </strong>
                                            </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                        <td>Category:
                                        </td>
                                        <td>
                                            <strong>
                                                <asp:Label runat="server" ID="lblCategoryName" EnableViewState="false" /></strong>
                                        </td>
                                        <td id="tdSOWSignedDate" runat="server" style="visibility: hidden;;white-space: nowrap;" enableviewstate="false">SOW Signed Date:&nbsp;
                                           
                                        </td>
                                         <td style="visibility: hidden;">
                                              <span style="white-space: nowrap;">
                                                <strong >
                                                    <asp:Label ID="lblSOWSignedDate" runat="server" Font-Bold="true"></asp:Label>&nbsp;
                                                </strong></span>
                                         </td>
                                        <td id="helptdAreaDeveloper" runat="server">&nbsp;</td>
                                        <td id="tdAreaDeveloper" runat="server" style="white-space: nowrap;" visible="false" enableviewstate="false">Area Developer:
                                             <span style="white-space: nowrap;overflow:hidden"><strong>
                                                <asp:Label ID="lblAreaDeveloper" runat="server" Font-Bold="true"></asp:Label>&nbsp;</strong></span>
                                        </td>
                                        <td colspan="1" id="Help2tdAreaDeveloper" runat="server" enableviewstate="false">
                                            &nbsp;
                                            <asp:CheckBox ID="flag" runat="server"  onclick=" flagCalc();" />
                                            <span style="border:1px solid black;background-color:white;padding-top:2px;font-size:9pt;">Flag for Follow up </span>
                                        </td>
                                        <td>
                                
                                        </td>
                                    </tr>
                                    <tr id="trReleaseandOwner" class="bdrbWhite" runat="server">
                                            <td id="td1" runat="server" style="height: 21px;">&nbsp;&nbsp;</td>
                                        <td style="white-space: nowrap;" enableviewstate="false" runat="server" id="divRelease">Release:</td>
                                        <td colspan="2" style="white-space: nowrap;" runat="server" id="DivReleaselbl" enableviewstate="false">
                                            <asp:Label ID="lblReleaseName" runat="server" EnableViewState="false" Font-Bold="true"></asp:Label>&nbsp;</td>

                                        <td style="white-space: nowrap;" enableviewstate="false" runat="server" id="tdTicketOwnerlbl">Product Owner:</td>
                                        <td colspan="1" style="white-space: nowrap;" runat="server" id="tdTicketOwner" enableviewstate="false">
                                            <asp:Label ID="lblTicketOwner" runat="server" EnableViewState="false" Font-Bold="true"></asp:Label>&nbsp;</td>

                                           <td id="td2" runat="server" style="height: 21px;" >&nbsp;</td>
                                           <td  id="tdTitleSubCategory" style="white-space: nowrap;" enableviewstate="false" runat="server" >Sub Category:</td>
                                        <td colspan="1" style="white-space: nowrap;"  runat="server" id="tdSubCategory" enableviewstate="false">
                                        <asp:Label ID="lblSubCategory" runat="server" EnableViewState="false" Font-Bold="true"></asp:Label>&nbsp;</td>
                                    </tr>
                                <tr style="background-color: #BDE7BD;" class="bdrbWhite">
                                        <td height="20px">&nbsp;
                                        </td>
                                        <td>Subject:
                                        </td>
                                        <td colspan="5" style="white-space: nowrap;">
                                            <strong>
                                                <asp:Label runat="server" ID="lblActivitySubject" EnableViewState="false" /></strong>


                                        </td>
                                   
                                     <td style="white-space: nowrap;" align="right">
                                            <span style="white-space: nowrap; padding-right: 20px;">
                                                <asp:UpdatePanel ID="upAddNotes" runat="server" UpdateMode="Always">
                                                    <ContentTemplate>
                                                        <asp:LinkButton ID="btnAddNotes" runat="server" CausesValidation="false" Style="padding: 4px; text-align: right; font-size: 11px; width: 90px; height: 18px; font-weight: bold;"
                                                            Text="Add Notes" OnClientClick="Notes(); return false;" />
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                        </span>
                                    </td>
                                    <td >
                                </tr>                                
                                 
                             
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table style="width: 100%; height: 100%; vertical-align: top;" border="0" cellpadding="0"
                                cellspacing="0">
                                <tr> 
                                                                             

                                        <td style="vertical-align: top;">
                                            <table cellspacing="0" cellpadding="0" style="width: 100%; height: 100%; padding-left:5px;" class="DivScroll">
                                                <tr>
                                                    
                                                    <td style="height: 100%; width: 100%;">
                                                        <div id="DivNotesDisplay" runat="server" style="height: 100%; width: 100% !important; overflow-y: scroll; overflow-x: auto;" class="DivScroll" ondblclick="Notes();">
                                                            <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="always" RenderMode="Inline">
                                                            <ContentTemplate>
                                                                <asp:Repeater ID="rptrNotes" runat="server" OnItemCommand="rptrNotes_ItemCommand"   OnItemDataBound="rptrNotes_ItemDataBound" DataSourceID="odsNotes" >
                                                                    <HeaderTemplate>
                                                                        <table border="0" cellspacing="0" cellpadding="0" style="font-size: 12px; width: 100%;">                                                                        
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate >
                                                                        <tr>
                                                                            <td style="border-bottom: 1px solid #BDE4B8; border-bottom-style: dashed;">
                                                                                <br />
                                                                                <asp:Label  ID="lblID" runat="Server" Visible="false" Text='<%#Container.DataItem("ID")%>'></asp:Label>
                                                                              
                                                                                <asp:Label  ID="lblTimeSpent" runat="Server" Visible="false" Text='<%#Container.DataItem("TimeSpent")%>' />
                                                                                <b>
                                                                                    <%#IIf(Functions.IfNull(Container.DataItem("UserID"), 0) <> 0, Functions.IfNull(Container.DataItem("UserName"), ""), Functions.IfNull(Container.DataItem("ClientContactName"), ""))%></b>&nbsp;On:
                                                                                <b>
                                                                                  
                                                                                    <%#Container.DataItem("DateEntered")%><i>&nbsp;(EST)&nbsp;&nbsp;&nbsp;</i></b> 
                                                                              <asp:Button Width ="100px" BorderStyle="none" CommandName="Pub"  ID="Pub" Visible ="true"  runat="server"  Text="Make Public " /> 
                                                                                 
                                                                             <asp:Button Width ="100px" BorderStyle="none" CommandName="Pri" ID="Pri" runat="server" Visible ="true"  Text="Make Private" /> 
                                                                                  

                                                                                    <span style='<%# IIF(Functions.IfNull(Container.DataItem("TimeSpent"), "00:00:00") = "00:00:00" ,"Display:none" , "Display:inline;") %>'>
                                                                                        <br />
                                                                                        <i>TimeSpent(HH:MM): </i><b>
                                                                                            <asp:Label
                                                                                    ID="lblTimeSpentModified" runat="Server" /></b></span>
                                                                        
                                                                                      
                                                                                     <asp:Label
                                                                                    ID="ifyes" runat="Server" /></b></span><%--<br />
                                                                                <br />--%>
                                                                              
                                                                                <asp:Repeater ID="rptrAttachments" OnItemDataBound="rptrAttachments_ItemDataBound" runat="server" DataSource='<%# Container.DataItem.CreateChildView("Notes_Attachments") %>' EnableViewState="false">
                                                                                    <HeaderTemplate>
                                                                                            <i>
                                                                                               
                                                                                            <br />   Attachment filename: </i> 
                                                                                        </HeaderTemplate>
                                                                                        <ItemTemplate>
                                                                                            <a href='#' onclick="javascript:OpenAttachment('<%# ResolveUrl("Downlaod.aspx?dt=" & Functions.EncryptData(DateTime.Now) & "&AttachmentID=") & Functions.EncryptData(Container.DataItem("ID")) %>');"><%# Container.DataItem("FileName")%></a> 
                                                                                        <%--   < <%#Container.DataItem("FileName")%> >--%>
                                                                                        &nbsp;<i> was added.</i>
                                                                                        </ItemTemplate>
                                                                                    </asp:Repeater>
                                                                               
                                                                 
                                                                                    <div style="<%#IIF( Cbool(Eval("Type")) = True , "color:Blue;","color:Black;") %>">
                                                                                       <br /><br />   <%#
                                                                                            CType(Container.DataItem("Notes"), String).Replace("&nbsp;", "")%>
                                                                                    </div>
                                                                                    
                                                                             <br /><br />
                                                                            </td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <FooterTemplate>
                                                                        </table>
                                                                    </FooterTemplate>
                                                                </asp:Repeater>
                                                                <asp:Repeater ID="rptrTicket" runat="server" DataSourceID="odsTicketFeatures" EnableViewState="false">
                                                                    <ItemTemplate>
                                                                            <table cellpadding="0" cellspacing="0" border="0" style="font-size: 12px; width: 98%; padding-left:3px;">
                                                                            <tr>
                                                                                <td>
                                                                                    <br />
                                                                                    <b>Original message sent by
                                                                                        <%#IIF( Functions.Ifnull(Container.DataItem("UserID"),0) <> 0,Functions.Ifnull(Container.DataItem("UserName"),""),Functions.Ifnull(Container.DataItem("ClientContactName"),""))%>
                                                                                        on
                                                                                        <%#Container.DataItem("DateEntered")%><i>&nbsp;(EST)</i></b>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Repeater ID="rptrTicketAttachments" runat="server" DataSource='<%# Container.DataItem.CreateChildView("Tickets_Attachments") %>' EnableViewState="false"> 
                                                                                        <HeaderTemplate>
                                                                                           <i>Attachments:</i>
                                                                                        </HeaderTemplate>
                                                                                        <ItemTemplate>
                                                                                            [&nbsp;<a href='#' onclick="javascript:OpenAttachment('<%# ResolveUrl("Downlaod.aspx?dt=" & Functions.EncryptData(DateTime.Now) & "&TicketID=")& Functions.EncryptData(Container.DataItem("ID")) %>');"><%#Container.DataItem("FileName")%></a>&nbsp;]
                                                                                            &nbsp;
                                                                                        </ItemTemplate>
                                                                                    </asp:Repeater>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <br />
                                                                                    <%#CType(Container.DataItem("Description"), String).Replace(vbCrLf, "<br />")%><br />
                                                                                        <br />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="border-top: 1px solid #BDE4B8; border-top-style: solid;">&nbsp;
                                                                                    </td>
                                                                            </tr>
                                                                        </table>
                                                                        <br />
                                                                    </ItemTemplate>
                                                                </asp:Repeater>
                                                                <asp:ObjectDataSource ID="odsTicketFeatures" runat="server" TypeName="Portal.DAL.PM.DBPM_Ticket_Features" SelectMethod="GetDetailByID">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter Name="TicketID" DefaultValue="0" ControlID="hdnID" Type="int32"
                                                                            PropertyName="value" />
                                                                    </SelectParameters>
                                                                </asp:ObjectDataSource>                                                                
                                                                <asp:ObjectDataSource ID="odsNotes" runat="server" TypeName="Portal.BLL.PM.PM_Notes" SelectMethod="GetDetailByID">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter Name="TicketID" DefaultValue="0" ControlID="hdnID" Type="int32"
                                                                            PropertyName="value" />
                                                                    </SelectParameters>
                                                                </asp:ObjectDataSource>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                        </div>
                                                    </td>
                                                    <td style="height: 100%; padding: 0px;" valign="top">
                                                        <asp:UpdatePanel ID="upContactsTable" runat="server" UpdateMode="Conditional" RenderMode="Block">
                                                            <ContentTemplate>
                                                                <table id="contactsTable" runat="server" cellspacing="0" cellpadding="0" style="width: 200px; height: 100%;">
                                                                    <%--border="0" style="width: 200px; height: 100%; display: inline" enableviewstate="false">--%>
                                                                    <tr id="ClientContactTR" runat="server" style="width: 100%; height: 145px;" valign="top">
                                                                        <td style="width: 100%; padding: 0px;">
                                                                            <table cellpadding="0" cellspacing="0" border="0" style="height: 100%; width: 100%;">
                                                                                <tr>
                                                                                    <td style="height: 20px; background-color: #DEF7D6; padding-bottom: 1px; white-space: nowrap; padding-right: 3px;"
                                                                                        class="SimpleExSmallBold">
                                                                                        <asp:Label ID="lblContactClientName" runat="server" EnableViewState="false"></asp:Label>&nbsp;Contacts:
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                <td>
                                                                                    <div id="dvClients" style="width: 100%; height: 100%; overflow: auto;" class="DivScroll">
                                                                                        <asp:Repeater ID="rptClientContacts" runat="server" DataSourceID="sdsClientContacts" EnableViewState="false">
                                                                                            <HeaderTemplate>
                                                                                                <table cellpadding="3" cellspacing="0" class="SimpleExSmallBold" style="overflow: auto;">
                                                                                                </HeaderTemplate>
                                                                                                <ItemTemplate>
                                                                                                    <tr style="<%#IIf(Container.DataItem("Checked") = 1, "display:inline", "display:none")%>;">
                                                                                                        <td style="width: 5px;">
                                                                                                            <img src="../images/arrows.gif" />
                                                                                                    </td>
                                                                                                    <td title='<%#Eval("ClientUserName")%>'>
                                                                                                        <%#Functions.StringTruncate(Eval("ClientUserName"), 25)%>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </ItemTemplate>
                                                                                            <FooterTemplate>
                                                                                                </table>
                                                                                            </FooterTemplate>                                                                                            
                                                                                        </asp:Repeater>
                                                                                        <asp:SqlDataSource ID="sdsClientContacts" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                                            SelectCommand="PM_Ticket_Features_Users_ClientContacts" SelectCommandType="StoredProcedure"
                                                                                            DataSourceMode="DataReader">
                                                                                            <SelectParameters>
                                                                                                <asp:ControlParameter Name="ClientID" ControlID="hdnClientID" Type="Int32" PropertyName="value" />
                                                                                                <asp:ControlParameter Name="TicketID" ControlID="hdnID" Type="Int32" PropertyName="value" />
                                                                                            </SelectParameters>
                                                                                        </asp:SqlDataSource>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                    <tr id="trNetsolaceContactTR" runat="server" style="width: 100%; height: 175px;" valign="top">
                                                                    <td style="width: 100%; padding-top: 0px;">
                                                                        <table cellpadding="0" cellspacing="0" border="0" style="height: 100%; width: 100%;">
                                                                            <tr>
                                                                                    <td style="border-color: #F5F5F5; background-color: #DEF7D6; height: 20px; padding-top: 2px;"
                                                                                        class="SimpleExSmallBold">Netsolace Contacts:
                                                                                    </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <div id="dvNetsolaceUsers" style="width: 100%; height: 100%; overflow: auto;" class="DivScroll">
                                                                                        <asp:Repeater ID="rptUserContacts" runat="server" DataSourceID="sdsUsersContacts" EnableViewState="false">
                                                                                            <HeaderTemplate>
                                                                                                <table cellpadding="3" cellspacing="0" class="SimpleExSmallBold">
                                                                                            </HeaderTemplate>
                                                                                            <ItemTemplate>
                                                                                                    <tr style="<%#IIf(Container.DataItem("Checked") = 1, "display:inline", "display:none")%>;">
                                                                                                    <td style="width: 5px;">
                                                                                                        <img src="../images/arrows.gif" />
                                                                                                    </td>
                                                                                                    <td title='<%#Eval("UserName")%>'>
                                                                                                        <%#Functions.StringTruncate(Eval("UserName"), 25)%>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </ItemTemplate>
                                                                                            <FooterTemplate>
                                                                                                </table>
                                                                                            </FooterTemplate>
                                                                                        </asp:Repeater>
                                                                                        <asp:SqlDataSource ID="sdsUsersContacts" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                                            SelectCommand="PM_Ticket_Features_Users_UsersContacts" SelectCommandType="StoredProcedure"
                                                                                            DataSourceMode="DataReader">
                                                                                            <SelectParameters>
                                                                                                <asp:ControlParameter Name="TicketID" DefaultValue="0" ControlID="hdnID" Type="int32"
                                                                                                    PropertyName="value" />
                                                                                            </SelectParameters>
                                                                                        </asp:SqlDataSource>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
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
                        </td>
                    </tr>
                    <tr>
                        <td style="background-color: #BDE7BD; border-top: 1 solid #609BD3; height: 31px;">
                            <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional" RenderMode="block">
                                <ContentTemplate>
                                    <asp:HiddenField ID="hdnPreValueStatus" runat="server" Value="0" />
                                    <asp:UpdatePanel ID="upWaitingfor" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                    <ContentTemplate>
                                    <asp:HiddenField ID="hdnWaitingFor" runat="server" Value="0" />
                                    </ContentTemplate>
                                    </asp:UpdatePanel>                                    
                                    <asp:HiddenField ID="hdnReleaseDueDate" runat="server" Value="" />
                                    <asp:HiddenField ID="hdnReleaseID" runat="server" Value="0" />
                                    <asp:HiddenField ID="hdnReleaseName" runat="server" Value=""  />
                                    <asp:HiddenField ID="hdnLastAssignTo" runat="server" />
                                    <table style="width: 100%;" border="0" cellpadding="0" cellspacing="0" class="SimpleExSmall">
                                        <tr>
                                            <td id="UPAssginedto" runat="server" style="width:300px;">
                                                &nbsp;                                                
                                                 Assigned to:
                                                 <asp:Label ID="lblAssignedTo" runat="server" Font-Bold="true" EnableViewState="false"></asp:Label>
                                            </td>
                                            <td>
                                                <div runat="server" id="divStatus">
                                                    &nbsp;Status:&nbsp;
                                                    <asp:Label ID="lblActivityStatus" runat="server" Font-Bold="true" EnableViewState="false"></asp:Label>
                                                    &nbsp;<asp:Button ID="BtnReopen" runat="server" Text="Reopen" Visible="false" CssClass="Btn3D"
                                                        OnClientClick="BlackDivDisplay();return OnTicketReopen();" />
                                                </div>
                                                </td>
                                                <td style="white-space: nowrap;" align="right">
                                                    <asp:Button ID="btnPrev" runat="server" CssClass="Btn3D" UseSubmitBehavior="false" CausesValidation="false" EnableViewState="false"
                                                        Text="Previous ticket" Width="115px" Visible="false" />&nbsp;&nbsp;
                                                <asp:Button ID="btnNext" runat="server" CssClass="Btn3D" UseSubmitBehavior="false" CausesValidation="false" EnableViewState="false"
                                                    Text="Next ticket" Width="115px" Visible="false" />&nbsp;&nbsp;
                                                                                                
                                                <asp:Button ID="btnBack" runat="server" CssClass="Btn3D" UseSubmitBehavior="false" CausesValidation="false" EnableViewState="false"
                                                    Text="Back to ticket list" Width="115px" />&nbsp;&nbsp;
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

        <div align="center" id="Attachment" style="display: none; border: 0px solid black; position: absolute; left: 25%; top: 25%; width: 50%; height: 210px; z-index: 201;">
            <table align="center" cellpadding="0" cellspacing="0" style="width: 100%;" class="MainAlertDiv">
                <tr>
                    <th height="21" valign="middle" align="left">&nbsp;Attachment(s)
                    </th>
                    <th align="right" valign="top">
                        <img src="../images/closebox2.gif" onclick="OnAttachmentSubmit1(); return false;"
                            style="cursor: pointer;">
                    </th>
                </tr>
                <tr>
                    <td width="100%" valign="top" colspan="2">
                        <table align="center" width="100%" cellpadding="0" cellspacing="0" class="MainAlertDiv"
                            style="width: 100%; text-align: center; border: none;">
                            <tr>
                                <td></td>
                                <td align="right" height="25" style="padding-right: 10px;">
                                    <a href="#" onclick="OnAttachmentSubmit(1);"><u>Clear All</u></a>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td height="25">
                                <div>
                                        <div>
                                            File 1:
                                        <input id="file1" type="file" runat="server" style="width: 330px;" />
                                            <asp:RadioButton ID="SOW" GroupName="selectSowBrd" runat="server" Text="SOW" CssClass="hdng_Radio" />
                                          &nbsp;  <asp:RadioButton ID="BRD" GroupName="selectSowBrd" runat="server" Text="BRD" CssClass="hdng_Radio" />
                                        </div>
                                        <div style="text-align: left; padding-right: 5px; padding-left: 5px;">
                                            <asp:RegularExpressionValidator ID="REV_file1" runat="server" ErrorMessage="Attachment must be a .jpg, .jpeg, .png, .gif, .doc,.docx, .pdf, .txt, .rtf, .xls, .xlsx, .rar, or .zip file"
                                                ValidationExpression="^.*(.txt|.zip|.doc|.jpg|.jpeg|.png|.gif|.doc|.docx|.pdf|.rtf|.xls|.xlsx|.rar|.TXT|.ZIP|.DOC|.DOCX|.XLS|.XLSX|.JPG|.JPEG|.PNG|.GIF|.DOC|.DOCX|.XLS|.XLSX|.RAR|.PDF|.RTF)$"
                                                ValidationGroup="AttachmentGroup" Display="Dynamic" ControlToValidate="file1"
                                                Font-Size="10px" EnableViewState="false">
                                            </asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                    <div>
                                        <div>
                                            File 2:
                                        <input id="file2" type="file" runat="server" style="width: 330px;" />
                                            <asp:RadioButton ID="RadioButton2" GroupName="selectSowBrd1" runat="server" Text="SOW" CssClass="hdng_Radio" />
                                          &nbsp;  <asp:RadioButton ID="RadioButton4" GroupName="selectSowBrd1" runat="server" Text="BRD" CssClass="hdng_Radio" />
                                        </div>
                                        <div style="text-align: left; padding-right: 5px; padding-left: 5px;">
                                            <asp:RegularExpressionValidator ID="REV_file2" runat="server" ErrorMessage="Attachment must be a .jpg, .jpeg, .png, .gif, .doc,.docx, .pdf, .txt, .rtf, .xls, .xlsx, .rar, or .zip file"
                                                ValidationExpression="^.*(.txt|.zip|.doc|.jpg|.jpeg|.png|.gif|.doc|.docx|.pdf|.rtf|.xls|.xlsx|.rar|.TXT|.ZIP|.DOC|.DOCX|.XLS|.XLSX|.JPG|.JPEG|.PNG|.GIF|.DOC|.DOCX|.XLS|.XLSX|.RAR|.PDF|.RTF)$"
                                                ValidationGroup="AttachmentGroup" Display="Dynamic" ControlToValidate="file2"
                                                Font-Size="10px" EnableViewState="false">
                                            </asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                    <div>
                                        <div>
                                            File 3:
                                        <input id="file3" type="file" runat="server" style="width: 330px;" />
                                            <asp:RadioButton ID="RadioButton5" GroupName="selectSowBrd2" runat="server" Text="SOW" CssClass="hdng_Radio" />
                                          &nbsp;  <asp:RadioButton ID="RadioButton6" GroupName="selectSowBrd2" runat="server" Text="BRD" CssClass="hdng_Radio" />
                                        </div>
                                        <div style="text-align: left; padding-right: 5px; padding-left: 5px;">
                                        <asp:RegularExpressionValidator ID="REV_file3" runat="server" ErrorMessage="Attachment must be a .jpg, .jpeg, .png, .gif, .doc,.docx, .pdf, .txt, .rtf, .xls, .xlsx, .rar, or .zip file"
                                            ValidationExpression="^.*(.txt|.zip|.doc|.jpg|.jpeg|.png|.gif|.doc|.docx|.pdf|.rtf|.xls|.xlsx|.rar|.TXT|.ZIP|.DOC|.DOCX|.XLS|.XLSX|.JPG|.JPEG|.PNG|.GIF|.DOC|.DOCX|.XLS|.XLSX|.RAR|.PDF|.RTF)$"
                                                ValidationGroup="AttachmentGroup" Display="Dynamic" ControlToValidate="file3"
                                                Font-Size="10px" EnableViewState="false">
                                            </asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" height="30" align="center">
                                <input id="BtnOk" type="button" value="OK" style="width: 80px;" onclick="OnAttachmentSubmit1();"
                                    class="Btn3D">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>        
    </div>

    <div id="DivNotes" style="position: absolute; display: none;width:755px;z-index: 102;height: 428px;">    
        <table width="755px" border="0" cellspacing="0" cellpadding="0" class="tblNewNote"
            ondblclick="event.cancelBubble=true;" style="height: 428px;">
            <tr>
                <td class="bgLightBlue bdrB2pxDarkBlue" style="padding: 5px 0px 5px 0px;" valign="middle">
                    <span class="hdng_Small" style="padding-left: 5px;">Notes:<span class="Required">*</span><span style="padding-right: 15px;">&nbsp;</span>
                        Time Spent (HH:MM):<span class="Required">*</span>&nbsp;
                        <asp:DropDownList ID="ddlHoursNotes" runat="server" CssClass="SmallGreenTextBox" EnableViewState="false"
                            ValidationGroup="NotesAdd">                            
                        </asp:DropDownList>
                        &nbsp;:
                        <asp:DropDownList ID="ddlMinutesNotes" runat="server" CssClass="SmallGreenTextBox" EnableViewState="false"
                            ValidationGroup="NotesAdd" AutoPostBack="false">                           
                        </asp:DropDownList>
                        &nbsp;
                        <asp:CustomValidator ID="CV_TimeSpent" ClientValidationFunction="validateTime" ErrorMessage="Select Time Spent"
                            ValidationGroup="NotesAdd" runat="server" Display="Dynamic" CssClass="RequiredField">
                        </asp:CustomValidator>&nbsp;                        
                </td>
                <td class="bgLightBlue bdrB2pxDarkBlue" style="padding: 5px 0px 5px 0px;" valign="middle" align="right">
                    <span style="vertical-align:middle;" class="hdng_Small">
                         <asp:LinkButton ID="btnattch" runat="server" OnClientClick="showAttachFiles(); return false;"
                                CssClass="btnAttachFile"><img src="../images/ico_attachment.gif" align="middle" alt="attach" border="0" style="padding-bottom:5px;"/>&nbsp;Attach File</asp:LinkButton>
                    </span>
                </td>
                <td align="right" valign="top" class="bgLightBlue bdrB2pxDarkBlue" style="padding-top:3px;padding-right:5px;">
                    <img src="../images/closebox2.gif" onclick="Notes(); return false;" style="cursor: pointer;">
                </td>
            </tr>
            <tr>
                <td valign="top" colspan="3">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="height: 100%;">
                        <tr>
                            <td valign="top">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr id="trFiles" style="display: none;">
                                            <td style="background-color: white;">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="background-color: #fffff3; border: none; height: 25px;">
                                                    <tr>
                                                        <td style="border: none;" rowspan="2" align="center" width="5%">
                                                            <img src="../images/ico_attachment.gif" align="middle" alt="attach" />
                                                        </td>
                                                        <td id="tdFiles" style="padding-top: 2px;"></td>
                                                    </tr>
                                                </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border:solid 1px #a1ccee;background-color:White;">
                                           <asp:RequiredFieldValidator ID="rfvNotes" runat="server" ControlToValidate="txtNotes"
                                                CssClass="RequiredField" ValidationGroup="NotesAdd" ErrorMessage="Enter Notes<br/>"
                                                Display="Dynamic" Enabled="true"  />
                                            <%--<asp:RegularExpressionValidator ID="revNotesHtml" runat="server" CssClass="RequiredField"
                                                ControlToValidate="txtNotes" Display="Dynamic" ValidationExpression="^[^<>]*$"
                                                ErrorMessage="Please enter valid text<br/>" ValidationGroup="NotesAdd"></asp:RegularExpressionValidator>--%>
                                            <%--<asp:TextBox ID="txtNotes" runat="server" Style="width: 555px; height: 305px;" ValidationGroup="NotesAdd"
                                                CssClass="txt_black DivScrollBlue" TextMode="MultiLine"></asp:TextBox>--%>
                                             <textarea name="txtNotes" id="txtNotes" runat="server"></textarea>

                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <table border="0" style="width: 200px; height: 100%;">
                                    <tr style="background-color: #a1ccee;">
                                            <td style="height: 20px;">
                                                <asp:Panel ID="pmlsearch" runat="server" DefaultButton="btnSearch" Height="20px">
                                                    <div style="background-color: #a1ccee; padding-left: 7px; border-bottom: solid 1px white; white-space: nowrap; padding-right: 3px;">
                                                        <asp:TextBox ID="txtClientUserSearch" runat="server" Height="18" Width="140" onkeyup='SearchUsers(this);'></asp:TextBox>
                                                        <ajaxToolkit:TextBoxWatermarkExtender ID="wmtxtSearch" runat="server" TargetControlID="txtClientUserSearch"
                                                            WatermarkText="Search Contacts..." WatermarkCssClass="waterMark">
                                                        </ajaxToolkit:TextBoxWatermarkExtender>
                                                        <asp:ImageButton ID="btnSearch" runat="server" OnClientClick="txtClientUserSearch.onkeyup(); return false;"
                                                            ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />
                                                    </div>
                                                </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr id="trClientContactsOnNotes" runat="server">
                                            <td valign="top" style="background-color: White;">
                                                <table cellpadding="0" cellspacing="0" border="0" style="height: 100%; width: 100%;">
                                                    <tr>
                                                        <td style="height: 20px; background-color: #a1ccee; padding-bottom: 1px; white-space: nowrap; padding-right: 3px;"
                                                            class="SimpleExSmallBold">&nbsp;<asp:Label ID="lblContactClientNameOnNotes" runat="server" EnableViewState="false"></asp:Label>&nbsp;Contacts:
                                                        </td>
                                                    </tr>
                                                <tr>
                                                    <td>
                                                        <div id="DivClientContactsOnNotes" style="width: 100%; height: 100%; overflow: auto;"
                                                            class="DivScrollBlue">
                                                            <asp:UpdatePanel ID="upClientContacts" runat="server" UpdateMode="Conditional">
                                                            <ContentTemplate>
                                                                        <asp:Repeater ID="rptCC" runat="server" DataSourceID="sdsClientContacts" EnableViewState="false">
                                                                            <HeaderTemplate>
                                                                                <div id="dvClientContacts" class="SimpleExSmallBold" style="overflow: auto; height: 100%;">
                                                                            </HeaderTemplate>
                                                                            <ItemTemplate>
                                                                                <div>
                                                                                    <asp:CheckBox ID="chkCC" runat="server" ToolTip='<%# Eval("ClientUserName") %>'
                                                                                        Text='<%# Functions.StringTruncate(Eval("ClientUserName"), 25) %>' Checked='<%# Eval("Checked") %>'
                                                                                        ClientContactID='<%# Eval("ClientContactID") %>' PrevClientChecked='<%# Eval("Checked") %>' onclick="OnClientListChanged();" EnableViewState="false" />
                                                                                </div>
                                                                            </ItemTemplate>
                                                                            <FooterTemplate>
                                                                                </div>
                                                                            </FooterTemplate>
                                                                        </asp:Repeater>
                                                                    </ContentTemplate>
                                                            <Triggers>
                                                                <asp:AsyncPostBackTrigger ControlID="btnContactsListChanged" EventName="Click" />
                                                            </Triggers>
                                                            </asp:UpdatePanel>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td valign="top" style="background-color: White;border-bottom:solid 1px #a1ccee;">
                                            <table cellpadding="0" cellspacing="0" border="0" style="height: 100%; width: 100%;">
                                                <tr>
                                                        <td style="border-color: #F5F5F5; background-color: #a1ccee; height: 20px; padding-top: 2px;"
                                                            class="SimpleExSmallBold">&nbsp;Netsolace&nbsp;Contacts:
                                                        </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div id="DivUserContactsOnNotes" style="width: 100%; height: 100%; overflow: auto;"
                                                            class="DivScrollBlue">
                                                            <asp:UpdatePanel ID="upUserContacts" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                                            <ContentTemplate>                                                            
                                                                <asp:Repeater ID="rptUC" runat="server" DataSourceID="sdsUsersContactsOnNotes" EnableViewState="false">
                                                                    <HeaderTemplate>
                                                                        <div id="dvUsers" class="SimpleExSmallBold" style="overflow: auto; height: 100%;">
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <div>                                                                            
                                                                            <input type="checkbox" id="chkCU" runat="server" title='<%# Eval("UserName") %>' name="chkClientUsers"
                                                                                checked='<%# Eval("Checked") %>' value='<%# Eval("UserName") %>'
                                                                                        clientuserid='<%# Eval("UserID") %>' prevuserchecked='<%# Eval("Checked") %>'  enableviewstate="false" />
                                                                                    <label id="lblUserName" runat="server" clientuserid='<%# Eval("UserID") %>' title='<%# Eval("UserName") %>'><%#Functions.StringTruncate(Eval("UserName"), 25)%></label>
                                                                        </div>
                                                                    </ItemTemplate>
                                                                    <FooterTemplate>
                                                                        </div>
                                                                    </FooterTemplate>
                                                                </asp:Repeater>
                                                            </ContentTemplate>
                                                            <Triggers>
                                                                <asp:AsyncPostBackTrigger ControlID="btnContactsListChanged" EventName="Click" />
                                                            </Triggers>
                                                            </asp:UpdatePanel>
                                                            <asp:SqlDataSource ID="sdsUsersContactsOnNotes" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                                SelectCommand="PM_Ticket_Features_Users_UsersContacts" SelectCommandType="StoredProcedure"
                                                                DataSourceMode="DataReader">
                                                                <SelectParameters>
                                                                    <asp:ControlParameter Name="TicketID" DefaultValue="0" ControlID="hdnID" Type="int32"
                                                                        PropertyName="value" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                                <td class="bgSteelBlue" colspan="2" style="padding-bottom: 3px; padding-top: 3px;">&nbsp; <span class="hdng_Small">Type:<span class="Required">*</span></span>
                                <asp:RadioButton ID="rdoPrivate" GroupName="Type" runat="server" Text="Private" CssClass="hdng_Radio"
                                        Checked="true" onclick="ShowHideFeedback();" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:RadioButton ID="rdoPublic" GroupName="Type" runat="server" Text="Public" CssClass="hdng_Radio" onclick="ShowHideFeedback();" />&nbsp;&nbsp;
                                       <span id="dvIsClientFeedback"  runat="server" style="white-space: nowrap;">
                                           <asp:CheckBox ID="chkIsClientFeedback" runat="server"  ToolTip="Client's Feedback Requested" onclick="calc();"  />
                                           <span style="margin-left: 5px; font-family: Arial, Verdana, Sans-Serif; font-size: 12px;">Project Update</span>
                                      
                                       
                                         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <span id="ifYes" style="display:none">  <asp:RadioButton ID="SOWrev" GroupName="multi" runat="server" Text="SOW Review" CssClass="hdng_Radio" />&nbsp;&nbsp;
                                          &nbsp;&nbsp;  <asp:RadioButton ID="RadioButton1" GroupName="multi" runat="server" Text="Feedback Required" CssClass="hdng_Radio" />&nbsp;&nbsp;
                                        
                                        <asp:RadioButton ID="RadioButton3" GroupName="multi" runat="server" Text="Status Update" CssClass="hdng_Radio" Checked ="true" /></span>
                                            </span>
                                              
                                       
                                <asp:CustomValidator ID="cvType" runat="server" ClientValidationFunction="cvNoteType_ClientValidate"  ErrorMessage=""
                                     CssClass="RequiredField" Display="Dynamic" ValidationGroup="NotesAdd"></asp:CustomValidator>
                                <div style="padding-top: 5px; padding-bottom: 5px;">
                                    <table border="0" cellspacing="0" cellpadding="0" style="width: 100%;">
                                        <tr>
                                                <td style="width: 75px;" nowrap="nowrap" valign="top">&nbsp; <span class="hdng_Small">Assign to:<span class="Required">*</span></span>
                                            </td>
                                            <td style="width: 210px;" valign="top">
                                            <asp:UpdatePanel ID="upAssignto" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>                                            
                                                <asp:DropDownList ID="ddlAssignedto" runat="server" Width="190px" CssClass="SmallFontInput"
                                                    DataSourceID="sdsAssginedto" DataTextField="UserName" DataValueField="ID" onchange="toggleContactVisibility(this.value);">
                                                </asp:DropDownList>
                                                <asp:CompareValidator ID="cvAssignTo" runat="server" ValueToCompare="0" Display="Dynamic"
                                                    ErrorMessage="<br/>Please select assign to" Operator="GreaterThan" ControlToValidate="ddlAssignedto"
                                                    CssClass="RequiredField" ValidationGroup="NotesAdd" Type="Integer"></asp:CompareValidator>
                                                <asp:SqlDataSource ID="sdsAssginedto" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                    SelectCommand="PM_Ticket_Features_Users_Users" SelectCommandType="StoredProcedure"
                                                    DataSourceMode="DataReader">
                                                    <SelectParameters>
                                                        <asp:ControlParameter Name="TicketID" DefaultValue="0" ControlID="hdnID" Type="int32" PropertyName="value" />
                                                        <asp:ControlParameter Name="ClientID" DefaultValue="0" ControlID="hdnClientID" Type="Int32" PropertyName="value" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                                </ContentTemplate>
                                                <Triggers>
                                                                <asp:AsyncPostBackTrigger ControlID="btnContactsListChanged" EventName="Click" />
                                                            </Triggers>
                                            </asp:UpdatePanel>
                                            </td>
                                            <td style="width: 50px;" valign="top">
                                                <span class="hdng_Small">Status:<span class="Required">*</span></span>
                                                </td>
                                                <td style="width: 170px;" valign="top">
                                                    <asp:DropDownList ID="ddlActivityStatus" CssClass="SmallFontInput" runat="server" Width="150px" onchange="onactivitystatuschanged(this.value);">
                                                        <asp:ListItem Text="Please Select" Value="0"></asp:ListItem>
                                                        <asp:ListItem Text="Not Started" Value="2"></asp:ListItem>
                                                        <asp:ListItem Text="In Requirement Gathering" Value="14"></asp:ListItem>
                                                        <asp:ListItem Text="Completed" Value="5" Enabled="false"></asp:ListItem>
                                                        
                                                        <asp:ListItem Text="In Progress" Value="4"></asp:ListItem>
														<asp:ListItem Text="In Design Phase" Value="13"></asp:ListItem>
                                                        <asp:ListItem Text="In Development Phase" Value="11"></asp:ListItem>
                                                        <asp:ListItem Text="In QA Phase" Value="12"></asp:ListItem>
                                                        <%-- <asp:ListItem Text="Client's Feedback Requested" Enabled="true" Value="8"></asp:ListItem>
                                                        <asp:ListItem Text="Client's Feedback Recieved" Enabled="true" Value="9"></asp:ListItem>--%>
                                                        <asp:ListItem Text="UAT Phase" Value="15"></asp:ListItem>
                                                        <asp:ListItem Text="Local Production Checkout" Value="16"></asp:ListItem>
                                                        <asp:ListItem Text="Ready to go live " Value="17"></asp:ListItem>
                                                        <asp:ListItem Text="Confirm Solved" Value="10"></asp:ListItem>
                                                        <asp:ListItem Text="On Hold" Value="7"></asp:ListItem>

                                                    </asp:DropDownList>
                                                    <asp:CompareValidator ID="cvActivityStatus" runat="server" ValueToCompare="0" Display="Dynamic"
                                                        ErrorMessage="<br/>Please select status" Operator="GreaterThan" ControlToValidate="ddlActivityStatus"
                                                            CssClass="RequiredField" ValidationGroup="NotesAdd" Type="Integer"></asp:CompareValidator>
                                                  
                                            </td>
                                            <td style="width: 60px;" valign="top">
                                                <span class="hdng_Small">Release:</span>
                                            </td>
                                            <td valign="top">
                                                <asp:DropDownList ID="ddlReleases" runat="server" DataSourceID="odsReleasesGetForList" DataTextField="Name"
                                                    DataValueField="ID" CssClass="SmallFontInput" Width="150px" EnableViewState="false">
                                                </asp:DropDownList>
                                                    <asp:ObjectDataSource ID="odsReleasesGetForList" runat="server" SelectMethod="GetAllForList" TypeName="Portal.DAL.PM.DBPM_Releases">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="hdnClientID" Name="ClientID" Type="Int32" />
                                                        <asp:ControlParameter ControlID="hdnAreaDeveloperID" Name="AreaDeveloperID" Type="Int32" />                                                        
                                                    </SelectParameters>
                                                </asp:ObjectDataSource>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="bgLightBlue bdrT2pxDarkBlue" style="padding: 5px 0px 5px 0px;" align="center"
                    colspan="3">
                    <div style="padding-top: 5px;">
                        <asp:Button runat="server" ID="btnSave" OnClientClick="if (OnSaveClientSide() == false) return false;"
                            ValidationGroup="NotesAdd" CssClass="Btn3D" Text="Save" />&nbsp;&nbsp;
                        <input type="button" class="Btn3D" value="Cancel" onclick="Notes(); return false;" id="btnCancel" />
                    </div>
                </td>
            </tr>
        </table>    
    </div>    
        
        <div id="DivTicketDetail" style="position: absolute; display: none;width:755px;z-index: 102;height: 175px;">    
            <asp:HiddenField ID="hdnOldSubject" runat="server" />
            <asp:HiddenField ID="hdnOldSowSignedDate" runat="server" Value="" />
            <asp:HiddenField ID="hdnOldClientId" runat="server" />
            <asp:HiddenField ID="hdnOldCategoryId" runat="server" />
            <asp:HiddenField ID="hdnOldsubCategoryId" runat="server" />
            <asp:HiddenField ID="hdnOldCategoryValue" runat="server" />
            <asp:HiddenField ID="hdnOldSubCategoryValue" runat="server" />
            <asp:HiddenField ID="hdnOldTypeId" runat="server" />
            <asp:HiddenField ID="hdnOldPriorityId" runat="server" />
            <asp:HiddenField ID="hdnOldAreaDeveloperId" runat="server" Value="0"/>
            <table cellspacing="0" cellpadding="0" border="0" style="height:100%;width:100%;" class="FormTable">
              <tr>
                  <td  style="height:31px;font-size:11px;padding:5px;border-bottom:1px solid #609BD3;">
                      <b>Edit Ticket Details</b>
                   </td>
              </tr>
              <tr>
               <td align="center" style="vertical-align:top; height:100%; width:100%;" >
                    <div  style="overflow:auto;">
						<table border="0" cellpadding="1" cellspacing="0" class="FormInnerTable" style="width: 100%;height:100%;">
							<tr>
								<td style="width: 17%; height: 20px;"></td>
								<td style="width: 33%"></td>
								<td style="width: 15%"></td>
								<td style="width: 33%"></td>
							</tr>
							<tr class="WhtLine">
                                    <td style="padding-left: 15px;">Subject:<b class="RequiredField">*</b>
								</td>
								<td>
									<asp:TextBox ID="txtName" runat="server" MaxLength="50" SkinID="GreenSmallTextbox" Width="200px"></asp:TextBox>
									<asp:RequiredFieldValidator ID="RFV_Name" runat="server" ControlToValidate="txtName"
										Display="Dynamic" ErrorMessage="<br/>Please Enter Name" SkinID="RequiredFieldValidation"></asp:RequiredFieldValidator>
									<asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" CssClass="ErrorMessage"></asp:Label>
								</td>
                                    <td style="padding-left: 15px;">Type:<b class="RequiredField">*</b>
								</td>
								<td>
									<asp:DropDownList ID="ddlTicketTypes" runat="server" DataSourceID="SDS_Type" DataTextField="Name"
										DataValueField="ID" SkinID="SmallTextCombo" Width="200px" CssClass="SmallFontInput">
									</asp:DropDownList>
									<asp:SqlDataSource ID="SDS_Type" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                            SelectCommand="PM_TaskTypes_GetAll" SelectCommandType="StoredProcedure" DataSourceMode="DataReader"></asp:SqlDataSource>
									<asp:CompareValidator ID="CV_Type" runat="server" ControlToValidate="ddlTicketTypes" Display="Dynamic"
										ErrorMessage="<br/>Please Select Type" Operator="GreaterThan" SkinID="CompareValidation"
										Type="Integer" ValueToCompare="0"></asp:CompareValidator>
								</td>
							</tr>							
								<tr>
                                    <td style="padding-left: 15px;" id="tdSowSignedDateHead" runat="server">SOW Signed Date:
								     </td>
								     <td id="tdSowSignedDateText" runat="server">
                                         <div style="width:100%;float:left;position:relative;">
                                        <input id="txtSowSignedDate" runat="server" readonly="readonly" maxlength="10" skinid="GreenSmallTextbox" onfocus="imgDDCalander.click();" style="width: 175px" />
                                            <img id="imgClearSOW" align="absMiddle" border="0" onclick="$('[id$=txtSowSignedDate]').val('');"
									 onmouseover="style.cursor='hand';" src="../images/cross-icon.png" style="position:absolute;top:5px;left:162px;"/>
                                        <img id="imgDDCalander" align="absMiddle" border="0" onclick=" setActiveStyleSheet(this, 'winter'); showCalendar('<%= txtSowSignedDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>'); BlackDivDisplayVisible();"
									 onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" style="margin-left:2px"/>
                                             </div>
                                      </td>
                                    <td style="padding-left: 15px;">Priority:<b class="RequiredField">*</b>
								</td>
								<td>
									<asp:DropDownList ID="ddlPriority"  runat="server" SkinID="SmallTextCombo" Width="200px" CssClass="SmallFontInput"></asp:DropDownList>
									<asp:CompareValidator ID="CV_Priority" runat="server" ControlToValidate="ddlPriority"
								   Display="Dynamic" ErrorMessage="<br/>Please Select Priority" Operator="GreaterThan"
								   SkinID="CompareValidation" Type="Integer" ValueToCompare="0"></asp:CompareValidator>
								</td>
							</tr>							
							<tr class="WhtLine">
                                    <td style="padding-left: 15px;">Client:<b class="RequiredField">*</b>
								</td>
								<td>
									<asp:DropDownList ID="ddlTicketClients" runat="server" CssClass="SmallFontInput" DataSourceID="odsClients" DataTextField="Name"  
                                            DataValueField="ID" SkinID="SmallTextCombo" Width="200px" AutoPostBack="true">
                                        </asp:DropDownList>
									<asp:ObjectDataSource ID="odsClients" runat="server" TypeName="Portal.BLL.Users"
										SelectMethod="GetClientsByUserIDAndSubModuleIDs">
										<SelectParameters>
											<asp:SessionParameter Name="userId" Type="int32" SessionField="AdminID" />
										</SelectParameters>
									</asp:ObjectDataSource>
									<asp:CompareValidator ID="CV_Client" runat="server" ControlToValidate="ddlTicketClients"
										Display="Dynamic" ErrorMessage="<br/>Please Select Client" Operator="GreaterThan"
										SkinID="CompareValidation" Type="Integer" ValueToCompare="0" />
								</td>
								<td style="padding-left: 15px;" nowrap="nowrap">
								<asp:UpdatePanel ID="upAreaDeveloperTitle" runat="server" RenderMode="Inline" UpdateMode="Conditional">
								    <ContentTemplate>
								        <span id="spnAreaDeveloper" style="display:none;" runat="server">Area Developer:</span>
								    </ContentTemplate>
								    <Triggers>
								        <asp:AsyncPostBackTrigger ControlID="ddlTicketClients" EventName="SelectedIndexChanged" />
								    </Triggers>
                                        </asp:UpdatePanel>
                                        &nbsp;
								</td>
								<td>
								    <asp:UpdatePanel ID="upAreaDeveloper" runat="server" RenderMode="Inline" UpdateMode="Conditional">
								        <ContentTemplate>
                                                <asp:DropDownList ID="ddlAreaDeveloper" CssClass="SmallFontInput" runat="server" Width="200px" Style="display: none;"
								                              DataSourceID="odsAreaDeveloper" DataTextField="CorporateName" DataValueField="ID">
                                            </asp:DropDownList>     
                                            <asp:ObjectDataSource ID="odsAreaDeveloper" runat="server" TypeName="Portal.BLL.AreaDeveloper"
										            SelectMethod="GetAllByClientId">
										        <SelectParameters>
										                <asp:ControlParameter ControlID="ddlTicketClients" Name="ClientID" Type="Int32" />										
										        </SelectParameters>
									        </asp:ObjectDataSource>
								        </ContentTemplate>
								        <Triggers>
								            <asp:AsyncPostBackTrigger ControlID="ddlTicketClients" EventName="SelectedIndexChanged" />
								        </Triggers>								        
								    </asp:UpdatePanel>                                    
								</td>								
							</tr>	
                            							
								      <tr>
                                    <td style="padding-left: 15px;">Product Owner:
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlTicketOwner" runat="server" CssClass="SmallFontInput" DataSourceID="sdsTicketOwner" DataTextField="OwnerName"
                                            DataValueField="ID" SkinID="SmallTextCombo" Width="200px">
                                        </asp:DropDownList>
                                       
                                        <asp:SqlDataSource ID="sdsTicketOwner" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                            SelectCommand="PM_TicketOwner_GetAll" SelectCommandType="StoredProcedure" DataSourceMode="DataReader"></asp:SqlDataSource>
                                    </td>

                                    <td style="padding-left: 15px;">Category:<b class="RequiredField">*</b>
                                    </td>
                                    <td>
                                  <asp:UpdatePanel ID="UPCategories" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:DropDownList ID="ddlTicketCategories"  AutoPostBack="true" runat="server" CssClass="SmallFontInput" DataSourceID="SDS_Categories"
                                                    DataTextField="Name" DataValueField="ID" SkinID="SmallTextCombo" Width="200px">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="SDS_Categories" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                    SelectCommand="PM_Categories_Clients_GetAll" SelectCommandType="StoredProcedure" DataSourceMode="DataReader">
                                                    <SelectParameters>
											<asp:ControlParameter ControlID="ddlTicketClients" Name="ClientID" Type="Int32" />
										</SelectParameters>
									</asp:SqlDataSource>
									<asp:CompareValidator ID="CV_Category" runat="server" ControlToValidate="ddlTicketCategories"
										Display="Dynamic" ErrorMessage="<br/>Please Select Category" Operator="GreaterThan"
										SkinID="CompareValidation" Type="Integer" ValueToCompare="0" />
									</ContentTemplate>
									<Triggers>
										<asp:AsyncPostBackTrigger ControlID="ddlTicketClients" EventName="SelectedIndexChanged" />
									</Triggers>
									</asp:UpdatePanel>
								</td>	
							</tr>	
								      <tr>
                                    <td style="padding-left: 15px;">Sub Category
                                    </td>
                                    <td>
                                        <asp:UpdatePanel ID="UpdatePanel4" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:DropDownList ID="ddlSubCategories" runat="server" CssClass="SmallFontInput" DataSourceID="sdsSubCate"
                                                    DataTextField="Name" DataValueField="ID" SkinID="SmallTextCombo" Width="200px">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="sdsSubCate" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                    SelectCommand="PM_SubCategories_CategoryID" SelectCommandType="StoredProcedure" DataSourceMode="DataReader">
                                                    <SelectParameters>
											<asp:ControlParameter ControlID="ddlTicketCategories" Name="CategoryID" Type="Int32" />
										</SelectParameters>
									</asp:SqlDataSource>
									<asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlTicketCategories"
										Display="Dynamic" ErrorMessage="<br/>Please Select Category" Operator="GreaterThan"
										SkinID="CompareValidation" Type="Integer" ValueToCompare="0" />
									</ContentTemplate>
									<Triggers>
										<asp:AsyncPostBackTrigger ControlID="ddlTicketCategories" EventName="SelectedIndexChanged" />
									</Triggers>
									</asp:UpdatePanel>
								</td>	
							</tr>	
							
							
                                <tr>
                                    <td colspan="4" style="text-align: center; padding-top: 10px;">Fields marked with an asterisk <b class="RequiredField">*</b> are required.
                                    </td>
                                </tr>
                            <tr>
								<td  colspan="4" style="height: 20px;"></td>
							</tr>
						</table>
					</div>
			   </td>
			  </tr>
		<tr>
			<td align="center" style="height: 31px; border-top: 1px solid #609BD3; vertical-align: middle;">
				<asp:Button ID="btnUpdateTicketDetail" runat="server" Text="Save" CssClass="Btn3D" Width="80px" />&nbsp;&nbsp;
				<asp:Button ID="Button2" runat="server" Text="Cancel" CausesValidation="false" UseSubmitBehavior="false" OnClientClick="DivTicketDetail.style.display = 'none';BlackDivHide();return false;" CssClass="Btn3D" />
			</td>
		</tr>

                
	</table>
    </div> 

        <div id="DivTotalTimeSpent" style="position: absolute; display: none; width: 555px; z-index: 102; height: 428;">
            <table width="555px" border="0" cellspacing="0" cellpadding="0" class="tblTotalTimeSpent"
                style="height: 428; border: solid 2px #6B9AD2;">
                <tr style="height: 30px;">
                    <td class="bgLightBlue bdrB2pxDarkBlue" style="padding: 5px;" valign="middle">
                        <span class="hdng_Small" style="padding-left: 5px; text-align: left; width: 80%;">
                            <asp:Label ID="lblTotalTimeSpentOnTicket" runat="server" Text=" Total Time Spent on Ticket (HH:MM) 00:00"></asp:Label>
                        </span><span align="right" valign="top" class="bgLightBlue bdrB2pxDarkBlue" style="border-bottom: ''; padding-top: 3px; text-align: right; width: 18%;">
                            <img src="../images/closebox2.gif" onclick="TotalTimeSpent(); return false;" style="cursor: pointer;">
                        </span>
                </td>
            </tr>
            <tr style="background-color: White; vertical-align: top;">
                <td>
                    <div style="height: 318px; overflow: auto;">
                        <asp:Repeater ID="rptrUsersTimeSpent" runat="server" EnableViewState="false" DataSourceID="sdsGetuserByTicket">
                            <HeaderTemplate>
                                <table id="tblUsersTimeSpentOnTicket" width="555px" cellpadding="10" style="border-collapse: collapse;">
                                    <thead>
                                        <tr style="height: 20px; padding: 0 5px 0 px; background-color: #DEF7D6;">
                                            <td style="border-bottom: solid 1px #6B9AD2;">
                                                <span class="hdng_Small" style="text-align: left; width: 69%;">Name </span><span
                                                    class="hdng_Small" style="text-align: right; width: 29%;">Time Spent (HH:MM)
                                                </span>
                                            </td>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <span class="hdng_Small" style="text-align: left; width: 69%;">
                                            <%# Container.DataItem("FirstName") &" "& Container.DataItem("MiddleName") &" "& Container.DataItem("LastName")%></span>
                                        <span class="hdng_Small" style="text-align: right; width: 29%;">
                                            <asp:Label ID="lblUsersTotalTimeSpent" runat="server" Text='<%#Container.DataItem("TimeSpent")%>'></asp:Label>
                                          <%--  <%#Container.DataItem("TimeSpent")%>--%>
                                            </span>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody> </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                    <%--                    <table id="tblUsersTimeSpentOnTicket" width="555px" cellpadding="10" style="border-collapse: collapse;">
                        <tbody>
                          <tr>
                                  <td>
                                    <span class="hdng_Small" style="text-align:left;width:69%;"> James Friend </span>
                                    <span class="hdng_Small" style="text-align:right;width:29%;"> 120:20 </span>
                                 </td>
                            </tr>
                            <tr>
                                 <td>
                                   <span class="hdng_Small" style="text-align:left;width:49%;"> Abdullah Malik </span>
                                   <span class="hdng_Small" style="text-align:right;width:49%;"> 50:5 </span>
                                </td>
                            </tr>
                        </tbody>
                    </table>--%>
                </td>
            </tr>
            <tr style="height: 50px;">
                <td class="bgLightBlue" style="padding: 5px 0px 5px 0px; text-align: center; border-top: solid 2px #6B9AD2;">
                    <input type="button" class="Btn3D" value="Close" onclick="TotalTimeSpent(); return false;"
                        id="btnCloseTimeDiv" />
                </td>
            </tr>
        </table>
        </div>

        <div id="divDueDateVisibility" style="position: absolute; display: none; top: 10%; left: 10%; z-index: 102;">
            <table id="tblDueDateVisibility" width="370px" border="0" cellspacing="0" cellpadding="0"
                class="tblDueDate">
                <tr>
                <td class="bgHdrDueDate bdrB1pxDueDate" style="padding: 3px 0px 3px 0px;">
                    <div style="text-align: right; padding-right: 5px;">
                            <img src="../images/closebox2.gif" onclick="HideDueDateVisibility();" style="cursor: pointer;">
                        </div>
                </td>
            </tr>
            <tr>
                <td class="bgContentDueDate" style="padding-top:15px;padding-bottom:15px;">
                    <div style="padding-left: 15px;">
                        <div class="hdng_Small padT5B5">
                            <%=IIf(chkDueDateShowToClient.Checked, "Due date is visible to client.", "Due date is not visible to client")%>
                        </div>
                        <div id="divSetDate" class="lblNormal padT5B5">                            
                        </div>                        
                        <div id="divDueDateVisibilityReason">
                            <span class="lblNormal">Comments <span class="grayNote">(Optional)</span></span><br />                            
                                <asp:TextBox ID="txtReason" runat="server" TextMode="MultiLine" CssClass="txt_black" Style="height: 60px; width: 310px;"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="revReason" ControlToValidate="txtReason"
                                            ErrorMessage="<br/>Reason cannot be greater than 8000 characters." ValidationExpression="^[\s\S]{0,8000}$"
                                            Display="Dynamic" ValidationGroup="vgVisibility" runat="Server" SetFocusOnError="true" CssClass="Required" />
                            <span class="grayNote">
                                <br />
                                Note: These comments will also be visible to client</span>
                        </div>
                        <div class="lblNormal padT5B5">
                            <asp:Button runat="server" ID="btnSaveDueDateReason"   
                                        ValidationGroup="vgVisibility" CssClass="Btn3D" Text="Submit" />&nbsp;&nbsp;
                            <input type="button" class="Btn3D" value="Cancel" onclick="HideDueDateVisibility();" />                            
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>    

    <div id="divDueDateExtension" style="position: absolute; display: none;top: 10%; left: 10%;z-index: 102;">
        <table id="tblDueDateExtension" width="370px" style="height: 200px;" border="0" cellspacing="0"
            cellpadding="0" class="tblDueDate">
            <tr>
                <td class="bgHdrDueDate bdrB1pxDueDate">
                    <div style="text-align: right; padding-right: 5px;">
                            <img src="../images/closebox2.gif" onclick="HideDueDateExtension();" style="cursor: pointer;">
                        </div>
                </td>
            </tr>
            <tr>
                <td class="bgContentDueDate" valign="top" style="padding-top:18px;">
                    <div style="padding-left: 15px;padding-right: 15px;">
                        <div class="hdng_Small padT5B5">                            
                            <%=IIf(chkDueDateShowToClient.Checked, "Due date is already set for client.", "Due date is not set for client")%>
                            </div>                            
                        <div class="lblNormal padT5B5">
                                Do you really want to extend that?
                                            Do you really want to extend that?
                            </div>
                        <div id="divDueDateExtensionReason" style="display: inline;">
                            <table border="0" cellspacing="0" cellpadding="2">
                                <tr>
                                    <td style="width: 70px; padding-top: 2px;" class="lblNormal" valign="top" nowrap="nowrap">
                                        <span>Due to:<span class="Required">*</span></span>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlExtensionType" runat="server" DataTextField="Title" DataValueField="Id"
                                            Style="width: 180px" DataSourceID="sdsExtensionType" EnableViewState="false">
                                        </asp:DropDownList>                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                        <td>
                                            <asp:CompareValidator ID="cvExtensionType" ValidationGroup="vgdateupdate" runat="server"
                                            ControlToValidate="ddlExtensionType" Display="Dynamic" ValueToCompare="0" Operator="GreaterThan"
                                            ErrorMessage="Please select reason" CssClass="Required">
                                        </asp:CompareValidator>
                                        <asp:SqlDataSource ID="sdsExtensionType" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                            SelectCommand="PM_DueDateExtensionType_GetForList" SelectCommandType="StoredProcedure"
                                                DataSourceMode="DataReader"></asp:SqlDataSource>
                                        </td>
                                </tr>
                                <tr id="trExtenstionReason">
                                    <td style="padding-top: 2px;" class="lblNormal" valign="top">
                                        <span>Notes:</span><span class="Required">*</span>
                                    </td>
                                    <td>
                                            <asp:TextBox ID="txtExtensionReason" runat="server" Style="height: 60px; width: 180px;" TextMode="MultiLine" CssClass="txt_black"></asp:TextBox>
                                    </td>
                                </tr>
                                    <tr>
                                        <td></td>
                                        <td valign="top">
                                            <asp:RequiredFieldValidator ID="rfvExtensionReason" runat="server" ControlToValidate="txtExtensionReason"
                                                CssClass="Required" ValidationGroup="vgdateupdate" ErrorMessage="Enter Notes"
                                                Display="Dynamic" Enabled="true"  />
                                        <asp:RegularExpressionValidator ID="revExtenstionReason" ControlToValidate="txtExtensionReason"
                                            ErrorMessage="<br/>Reason cannot be greater than 8000 characters." ValidationExpression="^[\s\S]{0,8000}$"
                                                Display="Dynamic" ValidationGroup="vgdateupdate" runat="Server" SetFocusOnError="true" CssClass="Required" /></td>
                                    </tr>
                                <tr>
                                <td></td>
                                        <td style="padding-top: 5px; padding-bottom: 18px;">
                                            <asp:Button runat="server" ID="btnSaveDueDateExtension"
                                            CssClass="Btn3D" Text="Submit" ValidationGroup="vgdateupdate" OnClientClick="if (CheckReleaseDueDate() == false) return false;" />&nbsp;&nbsp;                                    
                                        <input type="button" class="Btn3D" value="Cancel" onclick="HideDueDateExtension();" />
                                    </td>
                                </tr>
                            </table>
                         </div>
                    </div>
                 </td>
            </tr>
        </table>
    </div>
    
    
    <asp:HiddenField ID="hdnAssignToText" runat="server" Value="" />
    <asp:HiddenField ID="hdnAssignToValue" runat="server" Value="0" />    
    <asp:HiddenField ID="hdnIsAssigntoChanged" runat="server" Value="0" />
        <asp:Button ID="btnContactsListChanged" runat="server" Style="display: none;" />

        <asp:SqlDataSource ID="sdsGetuserByTicket" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
            SelectCommand="PM_Notes_GetByTicketID_TimeSpent" SelectCommandType="StoredProcedure"
            DataSourceMode="DataReader">
            <SelectParameters>
                <asp:ControlParameter Name="TicketID" DefaultValue="0" ControlID="hdnID" Type="int32"
                    PropertyName="value" />
            </SelectParameters>
        </asp:SqlDataSource>
 <script type="text/javascript" src="../scripts/jquery-1.11.2.min.js"></script>
<%--<script type="text/javascript" src="/scripts/tinymce.min.js"></script>--%>
<%--<script src="//cdn.ckeditor.com/4.7.1/standard/ckeditor.js"></script>--%>
<%--<script src="../scripts/ckeditor.js"></script>--%>
<script src="../Standard/ckeditor.js"></script>
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
   <%-- <script type="text/javascript" language="JavaScript" src="../scripts/jquery-1.3.2.min.js"></script> --%>
    <script language="javascript" type="text/javascript">

        //window.onload = function () {
        //    //alert("here");
        //    //setTimeout(InitEditor, 2000);
        //    InitEditor();
        //};
        $( document ).ready(function() {
            InitEditor();
        });
        function InitEditor() {
  
            //CKEDITOR.replace('txtNotes');
            CKEDITOR.replace( 'txtNotes',
{
    on :
    {
        instanceReady : function( ev )
        {
            // Output paragraphs as <p>Text</p>.
            this.dataProcessor.writer.setRules( 'p',
                {
                    indent : false,
                    breakBeforeOpen : true,
                    breakAfterOpen : false,
                    breakBeforeClose : false,
                    breakAfterClose : true
                });
        }
    }
});
            CKEDITOR.config.toolbar = [
            ['Bold', 'Italic', 'Underline','NumberedList', 'BulletedList', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']
            ];
            CKEDITOR.config.height=260;
            //n.setRules('p',{indent:false,breakAfterOpen:false});
            CKEDITOR.config.width=555;
            CKEDITOR.config.removePlugins='elementspath,magicline';
            //CKEDITOR.config.removePlugins = '';
            CKEDITOR.on('instanceReady', function () {
                $.each(CKEDITOR.instances, function (instance) {
                    CKEDITOR.instances[instance].on("change",function (e) {
               
                        
                        for (instance in CKEDITOR.instances
    )
                            CKEDITOR.instances[instance].updateElement();


    });
                });
            });
           
    

        }

            //ShowHideFeedback();

        var Mybutton = null;

  <%--      if (document.getElementById('<%=rdoPrivate.ClientID%>').checked = true){

     $(function () {
document.getElementById('Pri').style.visibility = "visible";
     }); 
        }--%>


        function flagCalc()
        { 
        if(document.getElementById("<%=flag.ClientID %>").checked){
            ShowDivFlag();
            document.getElementById("<%=flag.ClientID %>").disabled = true;
        } 
        else{
            ShowDivRemoveFlag();
        }
        }

        function calc()
        {
            if (document.getElementById('chkIsClientFeedback').checked) 
            {
                
                document.getElementById('ifyes').style.display="inline";
                //if(document.getElementById('SOWrev').checked) {
                //    Mybutton=document.getElementById('SOWrev').innerText;
                //}else if(document.getElementById('RadioButton1').checked) {
                //    Mybutton=document.getElementById('RadioButton1').innerText;
                //}

                //else{
                //    Mybutton=document.getElementById('RadioButton3').innerText;
                //}
                //Mybutton=document.getElementById('ifyes').innerText;
                //document.getElementById('butt').innerText=Mybutton;
            } else {
                document.getElementById('ifyes').style.display="none";
                document.getElementById('chkIsClientFeedback').checked == false;
            }
        }


        function RemoveAttributeFromElement() {
            $('#DivNotesDisplay').removeAttr("ondblclick");
        }



        DivNotesDisplay_onload();
        function DivNotesDisplay_onload() {
            var DivNotesDisplay = document.getElementById('<%=DivNotesDisplay.ClientID%>');
                //to restrict the width to note area
                <%--if (document.getElementById('<%=contactsTable.ClientID%>').style.display == 'none')
                DivNotesDisplay.style.width = parseInt(document.body.clientWidth);
            else
                    DivNotesDisplay.style.width = parseInt(document.body.clientWidth) - 200;--%>
        }

        function OnUserListChanged(CurrentUserId) {
            document.getElementById('<%=hdnIsListChanged.ClientID %>').value = 1;
            var LastAssignTo = document.getElementById('<%=hdnLastAssignTo.ClientID %>').value;
            var WaitingFor = document.getElementById('<%=hdnWaitingFor.ClientID %>').value;
            var hdnUserId = document.getElementById('<%=hdnUserId.ClientID %>').value;

            var chkbox = $("#dvUsers div input[ClientUserId=" + CurrentUserId + "]");
            if (chkbox.is(":checked")) {
                var value = CurrentUserId;
                var text = chkbox.val();
                AddItem(text, value);
                //document.getElementById('<%=hdnAssignToText.ClientID %>').value = text;
                //document.getElementById('<%=hdnAssignToValue.ClientID %>').value = value;                    
            }
            else {
                $("#<%=ddlAssignedto.ClientID %> option[value=" + CurrentUserId + "]").remove();

                if (CurrentUserId == WaitingFor) {
                    document.getElementById('<%=ddlAssignedto.ClientID %>').value = hdnUserId;
                    document.getElementById('<%=hdnWaitingFor.ClientID %>').value = hdnUserId;
                    document.getElementById('<%=hdnAssignToValue.ClientID %>').value = hdnUserId;
                    document.getElementById('<%=hdnAssignToText.ClientID %>').value = document.getElementById('<%=ddlAssignedto.ClientID %>').options[document.getElementById('<%=ddlAssignedto.ClientID %>').selectedIndex].innerText;
                    document.getElementById('<%=hdnLastAssignTo.ClientID %>').value = hdnUserId;
                }

                //$("#<%=ddlAssignedto.ClientID %> option[value=" + WaitingFor + "]").attr("selected", "selected");
            }
        }

        function OnClientListChanged() {
            document.getElementById('<%=hdnIsListChanged.ClientID %>').value = 1;
        }

        function HideValidations() {
            document.getElementById('<%=cvAssignTo.ClientID%>').style.display = 'none';
        }


        function toggleContactVisibility(currentUserId) {
            var hdnLastAssignTo = document.getElementById('hdnLastAssignTo').value;
            var ddlAssignedto = document.getElementById('<%=ddlAssignedto.ClientID %>');
            var hdnIsAssigntoChanged = document.getElementById('<%=hdnIsAssigntoChanged.ClientID %>');
            hdnIsAssigntoChanged.value = 1;
            document.getElementById('hdnLastAssignTo').value = currentUserId;
            if (document.getElementById('<%=ddlAssignedto.ClientID %>').value != 0) {
                document.getElementById('<%=hdnAssignToText.ClientID %>').value = ddlAssignedto.options[ddlAssignedto.selectedIndex].text;
                document.getElementById('<%=hdnAssignToValue.ClientID %>').value = document.getElementById('<%=ddlAssignedto.ClientID %>').value;
            }
        }

        function AddItem(text, value) {
            // Create an Option object
            var opt = document.createElement("option");
            var ddlAssignedTo = document.getElementById('<%=ddlAssignedto.ClientID %>');

            // Add an Option object to Drop Down/List Box
            ddlAssignedTo.options.add(opt);        // Assign text and value to Option object
            opt.text = text;
            opt.value = value;
            //$("#<%=ddlAssignedto.ClientID %> option[value=" + value + "]").attr("selected", "selected");
        }

        function OnResize() {
            var divDisable = getElement('divDisable');
            var divNotes = getElement('DivNotes');
            var divTicketDetails = getElement('DivTicketDetail');
            if (divDisable.style.display == 'block') {
                BlackDivDisplay();
            }
            if (divNotes.style.display == 'inline'){
                CenterAlignDiv(document.getElementById('DivNotes'));
            }
            if (divTicketDetails.style.display == 'inline')
            {
                CenterAlignDiv(document.getElementById('DivTicketDetail'));
            }
        }

        function cvNoteType_ClientValidate(sender, args) {
            var ddlActivityStatus = document.getElementById('<%=ddlActivityStatus.ClientID %>').value;
            var hdnPreValueStatus = document.getElementById('<%=hdnPreValueStatus.ClientID %>').value;
            var isPublic = document.getElementById('<%=rdoPublic.ClientID %>').checked;
            if (ddlActivityStatus == hdnPreValueStatus) {
                args.IsValid = true;
            }
            else if ((hdnPreValueStatus == '<%= Enumeration.PMStatus.DevelopmentPhase %>' && ddlActivityStatus == '<%= Enumeration.PMStatus.QAPhase %>') ||
                     (hdnPreValueStatus == '<%= Enumeration.PMStatus.QAPhase %>' && ddlActivityStatus == '<%= Enumeration.PMStatus.DevelopmentPhase %>'))
                args.IsValid = true;

            else {
                if (isPublic)
                    args.IsValid = true;
                else {
                    $(sender).text("Status can only be changed with the type as public.");
                    args.IsValid = false;
                }
            }
        }

        function ShowDueDateExtension() {
            var IsDueDateChanged = false;
            var IsFutureDate = false;
            var CurrentDate = new Date('<%= Now.Date.ToShortDateString  %>');
            var txtActivityDate = new Date(document.getElementById('<%=txtActivityDueDate.ClientID %>').value);
            var txtDate = document.getElementById('<%=txtActivityDueDate.ClientID %>').value;

            if (document.getElementById('<%=hdnDueDate.ClientID %>').value != txtDate) {
                if (txtActivityDate >= CurrentDate) {
                    IsFutureDate = true;
                }
                else {
                    alert('Please select a future date.');
                    IsFutureDate = false;
                }
                IsDueDateChanged = true;
            }
            else {
                alert('Please change the due date in order to update.');
                IsDueDateChanged = false;
            }

            if (IsDueDateChanged == true && IsFutureDate == true) {
                divDueDateExtension.style.display = 'inline';
                document.getElementById('<%=cvExtensionType.ClientID %>').style.display = 'none';
                document.getElementById('<%=rfvExtensionReason.ClientID %>').style.display = 'none';
                document.getElementById('<%=revExtenstionReason.ClientID %>').style.display = 'none';
                BlackDivDisplay();
            }
        }

        function HideDueDateExtension() {
            document.getElementById('<%=txtExtensionReason.ClientID %>').value = '';
            document.getElementById('<%=ddlExtensionType.ClientID %>').value = 0;
            divDueDateExtension.style.display = 'none';
            //trExtenstionReason.style.display = 'none';                 
            BlackDivHide();
        }

        function ShowDueDateVisibility() {
            divDueDateVisibility.style.display = 'inline';
            var chkDueDateShowToClient = document.getElementById('<%= chkDueDateShowToClient.ClientID %>');
            if (chkDueDateShowToClient.checked == true)
                divSetDate.innerHTML = "Do you really want to finalize " + document.getElementById('<%= txtActivityDueDate.ClientID %>').value + " for the client?"
            else
                divSetDate.innerHTML = "Do you really want to set to <b>To be determined</b>&nbsp; for client?"
            document.getElementById('<%=revReason.ClientID %>').style.display = 'none';
            BlackDivDisplay();
        }

        function HideDueDateVisibility() {
            divDueDateVisibility.style.display = 'none';
            if (document.getElementById('<%=hdnDueDateShowToClient.ClientID %>').value.toLowerCase() == 'true')
                document.getElementById('<%=chkDueDateShowToClient.ClientID %>').checked = true;
            else
                document.getElementById('<%=chkDueDateShowToClient.ClientID %>').checked = false;
            document.getElementById('<%=txtReason.ClientID %>').value = '';
            BlackDivHide();
        }

        function SearchUsers(txtsearch) {
            var search = txtsearch.value.toLowerCase();
            if (search == 'search contacts...')
                search = '';

            var dvClientContacts = document.getElementById('dvClientContacts');
            if (dvClientContacts != null) {
                var colldvClientContacts = dvClientContacts.getElementsByTagName('div'); //array
                var i = colldvClientContacts.length;

                while (i--) {
                    var result = colldvClientContacts[i].getElementsByTagName('label')[0].innerHTML.toLowerCase().search(search);
                    if (result > -1 || search.length == 0)
                        colldvClientContacts[i].style.display = 'block';
                    else
                        colldvClientContacts[i].style.display = 'none';
                }

            }

            var dvUsers = document.getElementById('dvUsers');
            var colldvUsers = dvUsers.getElementsByTagName('div'); //array
            i = colldvUsers.length;

            while (i--) {
                var result = colldvUsers[i].getElementsByTagName('label')[0].innerHTML.toLowerCase().search(search);
                if (result > -1 || search.length == 0)
                    colldvUsers[i].style.display = 'block';
                else
                    colldvUsers[i].style.display = 'none';
            }
            return false;
        }


        function clearSearchUser() {
            var txtsearch = document.getElementById('<%=txtClientUserSearch.ClientID%>');
            txtsearch.value = '';

            var dvClientContacts = document.getElementById('dvClientContacts');
            if (dvClientContacts != null) {
                var colldvClientContacts = dvClientContacts.getElementsByTagName('div'); //array
                var colldvClientContactslength = colldvClientContacts.length;
                var i = colldvClientContactslength;

                while (i--) {
                    colldvClientContacts[i].style.display = 'block';
                }
            }

            var dvUsers = document.getElementById('dvUsers');
            var colldvUsers = dvUsers.getElementsByTagName('div'); //array
            var colldvUserslength = colldvUsers.length;
            i = colldvUserslength;

            while (i--) {
                colldvUsers[i].style.display = 'block';
            }
        }

        function validateSameFiles(oSrc, args) {
            if ((getElement('<%= File1.ClientID %>').value == getElement('<%= File2.ClientID %>').value && getElement('<%= File1.ClientID %>').value != '' && getElement('<%= File2.ClientID %>').value != '') ||
		 (getElement('<%= File1.ClientID %>').value == getElement('<%= File3.ClientID %>').value && getElement('<%= File1.ClientID %>').value != '' && getElement('<%= File3.ClientID %>').value != '') ||
		 (getElement('<%= File2.ClientID %>').value == getElement('<%= File3.ClientID %>').value && getElement('<%= File2.ClientID %>').value != '' && getElement('<%= File3.ClientID %>').value != ''))
                args.IsValid = false
            else
                args.IsValid = true;
        }
        function validateFiles(oSrc, args) {
            if ((getElement('<%= File1.ClientID %>').value == '') &&
		 (getElement('<%= File2.ClientID %>').value == '') &&
		 (getElement('<%= File3.ClientID %>').value == ''))
                args.IsValid = false
            else
                args.IsValid = true;
        }


        function HideAssigntoValidation() {
            document.getElementById('<%=cvAssignTo.ClientID%>').style.display = 'none';
        }

        Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(LoadCompleted)

        function LoadCompleted() {
            IsLoadComplete = true;
            document.getElementById('btnCancel').disabled = false;
	    ShowHideFeedback();
        }

        function Notes() {

            // HideVitalInfo();
            //IsLoadComplete = true;   // remove for live 
            //IsNewNotesEnabled = true; // remove for live 
            if (IsLoadComplete == true) {

                if (IsNewNotesEnabled == true) {

                    var ActivityState = document.getElementById('<%=ddlActivityStatus.ClientID %>')
                    var hdnPreValueStatus = document.getElementById('<%=hdnPreValueStatus.ClientID%>').value
                    var hdnWaitingFor = document.getElementById('<%=hdnWaitingFor.ClientID%>').value
                    var isReadOnlyAccess = document.getElementById('<%=hdnIsReadOnlyAccess.ClientID %>').value;
                    var ddlAssignedto = document.getElementById('<%=ddlAssignedto.ClientID%>');
                    document.getElementById('<%=rdoPrivate.ClientID%>').checked = true;
                    if (isReadOnlyAccess == 0) {
                        if (ActivityState.value != 5) {
                            if (DivNotes.style.display == 'none') {
                                //InitEditor();
                                CenterAlignDiv(document.getElementById('DivNotes'));
                                DivNotes.style.display = 'inline';
                                
                                document.getElementById('<%=txtNotes.ClientID%>').value = '';
                                document.getElementById('<%=txtNotes.ClientID%>').focus();
                                document.getElementById('<%=ddlHoursNotes.ClientID%>').value = 0;
                                document.getElementById('<%=ddlMinutesNotes.ClientID%>').value = 0;
                                ShowHideFeedback();
                                if (document.getElementById('<%=hdnIsFeedBackRequired.ClientID%>').value == "True")
                                {
                                    if (document.getElementById('<%=chkIsClientFeedback.ClientID%>') != null || undefined)
                                    document.getElementById('<%=chkIsClientFeedback.ClientID%>').checked = true;
                                }
                                else
                                {
                                    if (document.getElementById('<%=chkIsClientFeedback.ClientID%>') != null || undefined)
                                    document.getElementById('<%=chkIsClientFeedback.ClientID%>').checked = false;
                                }
                                
                                

                                if (ActivityState.value == '<%= Enumeration.PMStatus.FeedbackRequested %>' || ActivityState.value == '<%= Enumeration.PMStatus.ConfirmSolved %>') {
                                    ddlAssignedto.disabled = true;
                                    ValidatorEnable(document.getElementById('<%=cvAssignTo.ClientID%>'), false);
                                }
                                BlackDivDisplay();
                            }
                            else {
                                if (hdnWaitingFor == '')
                                    hdnWaitingFor = 0;
                                ddlAssignedto.value = hdnWaitingFor;
                                if (hdnPreValueStatus == '<%= Enumeration.PMStatus.InProgress %>')
                                    hdnPreValueStatus = 0;
                                document.getElementById('<%=ddlActivityStatus.ClientID%>').value = hdnPreValueStatus;
                                ddlAssignedto.disabled = false;
                                document.getElementById('<%=ddlReleases.ClientID%>').value = document.getElementById('<%=hdnReleaseId.ClientID%>').value;
                                document.getElementById('<%=CV_TimeSpent.ClientID%>').style.display = 'none';
                               <%-- document.getElementById('<%=rfvNotes.ClientID%>').style.display = 'none';--%>
                                document.getElementById('<%=cvType.ClientID%>').style.display = 'none';
                                document.getElementById('<%=cvAssignTo.ClientID%>').style.display = 'none';
                                document.getElementById('<%=cvActivityStatus.ClientID%>').style.display = 'none';
                                document.getElementById('<%=txtClientUserSearch.ClientID%>').value = '';
                                document.getElementById('<%=btnSearch.ClientID%>').click();
                                toggleContactVisibility(document.getElementById('<%=hdnLastAssignTo.ClientID%>').value);
                                trFiles.style.display = 'none';
                                OnAttachmentSubmit(1);

                                if (document.getElementById('<%=hdnIsListChanged.ClientID %>').value == 1) {
                                    __doPostBack('<%= btnContactsListChanged.ClientID %>', '')
                                    document.getElementById('<%=hdnIsListChanged.ClientID %>').value = 0;
                                }
                          
                                <%-- document.getElementById('<%=txtNotes.ClientID %>').value=" ";  --%>
                              <%--  $('<%= "#" + txtNotes.ClientID %>').htmlarea("html","");--%>
                                CKupdate();
                                DivNotes.style.display = 'none';
                                BlackDivHide();
                                
                            }
                        }
                    }
                }

            }

        }
        function CKupdate(){
            for ( instance in CKEDITOR.instances )
                CKEDITOR.instances[instance].updateElement();
            CKEDITOR.instances[instance].setData('');
        }

        <%--function EditTicketDetail() {
            //IsLoadComplete = true ; 
            //IsNewNotesEnabled = true ; 
            if (IsLoadComplete == true) {
            
                if (IsNewNotesEnabled == true) {
            
                    var ActivityState = document.getElementById('<%=ddlActivityStatus.ClientID %>')
                    var hdnPreValueStatus = document.getElementById('<%=hdnPreValueStatus.ClientID%>').value
                    var hdnWaitingFor = document.getElementById('<%=hdnWaitingFor.ClientID%>').value
                    var isReadOnlyAccess = document.getElementById('<%=hdnIsReadOnlyAccess.ClientID %>').value;
                    var ddlAssignedto = document.getElementById('<%=ddlAssignedto.ClientID%>');
                    document.getElementById('<%=rdoPrivate.ClientID%>').checked = true;
            
                    if (isReadOnlyAccess == 0) {
                        if (ActivityState.value != 5) {
                            if (DivTicketDetail.style.display == 'none') {
            
                                CenterAlignDiv(document.getElementById('DivTicketDetail'));
                                DivTicketDetail.style.display = 'inline';
                                document.getElementById('<%=txtNotes.ClientID%>').value = '';
                                document.getElementById('<%=txtNotes.ClientID%>').focus();
                                document.getElementById('<%=ddlHoursNotes.ClientID%>').value = 0;
                                document.getElementById('<%=ddlMinutesNotes.ClientID%>').value = 0;
                                if (ActivityState.value == '<%= Enumeration.PMStatus.FeedbackRequested %>' || ActivityState.value == '<%= Enumeration.PMStatus.ConfirmSolved %>') {
                                    ddlAssignedto.disabled = true;
                                    ValidatorEnable(document.getElementById('<%=cvAssignTo.ClientID%>'), false);
                                }
                                BlackDivDisplay();
                                
                            }
                            else {

                                if (hdnWaitingFor == '')
                                    hdnWaitingFor = 0;
                                ddlAssignedto.value = hdnWaitingFor;
                                if (hdnPreValueStatus == '<%= Enumeration.PMStatus.InProgress %>')
                                    hdnPreValueStatus = 0;
                                document.getElementById('<%=ddlActivityStatus.ClientID%>').value = hdnPreValueStatus;
                                ddlAssignedto.disabled = false;
                                document.getElementById('<%=ddlReleases.ClientID%>').value = document.getElementById('<%=hdnReleaseId.ClientID%>').value;
                                document.getElementById('<%=CV_TimeSpent.ClientID%>').style.display = 'none';
                                document.getElementById('<%=rfvNotes.ClientID%>').style.display = 'none';
                                document.getElementById('<%=cvType.ClientID%>').style.display = 'none';
                                document.getElementById('<%=cvAssignTo.ClientID%>').style.display = 'none';
                                document.getElementById('<%=cvActivityStatus.ClientID%>').style.display = 'none';
                                document.getElementById('<%=txtClientUserSearch.ClientID%>').value = '';
                                document.getElementById('<%=btnSearch.ClientID%>').click();
                                toggleContactVisibility(document.getElementById('<%=hdnLastAssignTo.ClientID%>').value);
                                trFilesTicketDetail.style.display = 'none';
                                OnAttachmentSubmit(1);
                                
                                if (document.getElementById('<%=hdnIsListChanged.ClientID %>').value == 1) {
                                    __doPostBack('<%= btnContactsListChanged.ClientID %>', '')
                                    document.getElementById('<%=hdnIsListChanged.ClientID %>').value = 0;
                                }
                                
                                DivTicketDetail.style.display = 'none';
                                BlackDivHide();
                            }
                        }
                    }
                }

            }

        }--%>



        function TotalTimeSpent() {
            if (IsLoadComplete == true) {

                

                    var ActivityState = document.getElementById('<%=ddlActivityStatus.ClientID %>')
                    var hdnPreValueStatus = document.getElementById('<%=hdnPreValueStatus.ClientID%>').value
                    var hdnWaitingFor = document.getElementById('<%=hdnWaitingFor.ClientID%>').value
                    var isReadOnlyAccess = document.getElementById('<%=hdnIsReadOnlyAccess.ClientID %>').value;
                    var ddlAssignedto = document.getElementById('<%=ddlAssignedto.ClientID%>');
                    document.getElementById('<%=rdoPrivate.ClientID%>').checked = true;
                    if (isReadOnlyAccess == 0) {
                        if (ActivityState.value != 5) {
                            if (DivTotalTimeSpent.style.display == 'none') {
                                CenterAlignDiv(document.getElementById('DivTotalTimeSpent'));
                                DivTotalTimeSpent.style.display = 'inline';
                                document.getElementById('<%=txtNotes.ClientID%>').value = '';
                                document.getElementById('<%=txtNotes.ClientID%>').focus();
                                document.getElementById('<%=ddlHoursNotes.ClientID%>').value = 0;
                                document.getElementById('<%=ddlMinutesNotes.ClientID%>').value = 0;
                                if (ActivityState.value == '<%= Enumeration.PMStatus.FeedbackRequested %>' || ActivityState.value == '<%= Enumeration.PMStatus.ConfirmSolved %>') {
                                    ddlAssignedto.disabled = true;
                                    ValidatorEnable(document.getElementById('<%=cvAssignTo.ClientID%>'), false);
                                }
                                BlackDivDisplay();
                            }
                            else {
                                if (hdnWaitingFor == '')
                                    hdnWaitingFor = 0;
                                ddlAssignedto.value = hdnWaitingFor;
                                if (hdnPreValueStatus == '<%= Enumeration.PMStatus.InProgress %>')
                                    hdnPreValueStatus = 0;
                                document.getElementById('<%=ddlActivityStatus.ClientID%>').value = hdnPreValueStatus;
                                ddlAssignedto.disabled = false;
                                document.getElementById('<%=ddlReleases.ClientID%>').value = document.getElementById('<%=hdnReleaseId.ClientID%>').value;
                                document.getElementById('<%=CV_TimeSpent.ClientID%>').style.display = 'none';
                               <%-- document.getElementById('<%=rfvNotes.ClientID%>').style.display = 'none';--%>
                                document.getElementById('<%=cvType.ClientID%>').style.display = 'none';
                                document.getElementById('<%=cvAssignTo.ClientID%>').style.display = 'none';
                                document.getElementById('<%=cvActivityStatus.ClientID%>').style.display = 'none';
                                document.getElementById('<%=txtClientUserSearch.ClientID%>').value = '';
                                document.getElementById('<%=btnSearch.ClientID%>').click();
                                toggleContactVisibility(document.getElementById('<%=hdnLastAssignTo.ClientID%>').value);
                                trFiles.style.display = 'none';
                                OnAttachmentSubmit(1);

                                if (document.getElementById('<%=hdnIsListChanged.ClientID %>').value == 1) {
                                    __doPostBack('<%= btnContactsListChanged.ClientID %>', '')
                                    document.getElementById('<%=hdnIsListChanged.ClientID %>').value = 0;
                                }
                                DivTotalTimeSpent.style.display = 'none';
                                BlackDivHide();
                            }
                        }
                    }
                }

          

        }


        function onactivitystatuschanged(activityid) {
            var ddlAssignedto = document.getElementById('<%=ddlAssignedto.ClientID%>');
            var ddlActivityStatus = document.getElementById('<%=ddlActivityStatus.ClientID %>')
            var WaitingFor = document.getElementById('<%=hdnWaitingFor.ClientID%>').value;
            var hdnPreValueStatus = document.getElementById('<%=hdnPreValueStatus.ClientID%>').value;

            if (activityid == '<%= Enumeration.PMStatus.ConfirmSolved %>' || activityid == '<%= Enumeration.PMStatus.FeedbackRequested %>') {
                ddlAssignedto.disabled = true;
                toggleContactVisibility(WaitingFor);
                ValidatorEnable(document.getElementById('<%=cvAssignTo.ClientID%>'), false);
                document.getElementById('<%=cvAssignTo.ClientID%>').style.display = 'none';
                ddlAssignedto.value = WaitingFor;
                LastAssignedTo = WaitingFor;
            }
            else {
                ddlAssignedto.disabled = false;
                ValidatorEnable(document.getElementById('<%=cvAssignTo.ClientID%>'), true);
            }
        }

        function activityStateChange() {
            var ActivityState = document.getElementById('<%=ddlActivityStatus.ClientID %>')
            if (ActivityState.value == "5") {
                if (confirm("The Status has been selected as Compeletd.\n To confirm press OK, otherwise Cancel") == false) {
                    ActivityState.value = document.getElementById('<%=hdnPreValueStatus.ClientID %>').value
                    return false;
                }
            }
            else if (ActivityState.value == "0") {
                ActivityState.value = document.getElementById('<%=hdnPreValueStatus.ClientID %>').value
                return false;
            }
            else { return true; }
        }

        function ResetAttachment2() {
            form1.file2.parentNode.innerHTML = form1.file2.parentNode.innerHTML;
        }
        function ResetAttachment1() {
            form1.file1.parentNode.innerHTML = form1.file1.parentNode.innerHTML;
        }
        function ResetAttachment3() {
            form1.file3.parentNode.innerHTML = form1.file3.parentNode.innerHTML;
        }
        function showAttachFiles() {
            document.getElementById("Attachment").style.display = 'inline';
            document.getElementById("BtnOk").focus();
        }

        function OnAttachmentSubmit1() {
            if (Page_ClientValidate('AttachmentGroup') == false) {
                alert('Please attach a valid file or remove it.')
                return false;
            }

            document.getElementById("Attachment").style.display = 'none';
            document.getElementById("<%=btnattch.ClientID%>").focus();
            var strFiles = '';
            if (document.getElementById('<%=File1.ClientID%>').value != '')
                strFiles += '<table style=\'display:inline;font-size:11px;border:solid 1px #989d97;background-color:eff2f9;height:19px;\' cellpadding=0 cellpadding=0><tr><td>' + trimFileName(getElement('file1').value.substr(getElement('file1').value.lastIndexOf("\\") + 1)) + '</td><td style=\'cursor:pointer;font-size:13px;color:grey;font-weight:bold;\' title=Remove align=left onClick=\'ResetAttachment1();OnAttachmentSubmit(0);\'> |x</td></tr></table>&nbsp;';
            if (document.getElementById('<%=File2.ClientID%>').value != '')
                strFiles += '<table style=\'display:inline;font-size:11px;border:solid 1px #989d97;background-color:eff2f9;height:19px;\' cellpadding=0 cellpadding=0><tr><td>' + trimFileName(getElement('file2').value.substr(getElement('file2').value.lastIndexOf("\\") + 1)) + '</td><td style=\'cursor:pointer;font-size:13px;color:grey;font-weight:bold;\' title=Remove align=left onClick=\'ResetAttachment2();OnAttachmentSubmit(0);\'> |x</td></tr></table>&nbsp;';
            if (document.getElementById('<%=File3.ClientID%>').value != '')
                strFiles += '<table style=\'display:inline;font-size:11px;border:solid 1px #989d97;background-color:eff2f9;height:19px;\' cellpadding=0 cellpadding=0 ><tr><td>' + trimFileName(getElement('file3').value.substr(getElement('file3').value.lastIndexOf("\\") + 1)) + '</td><td style=\'cursor:pointer;font-size:13px;color:grey;font-weight:bold;\' title=Remove align=left onClick=\'ResetAttachment3();OnAttachmentSubmit(0);\'> |x</td></tr></table>';

            if (strFiles == '') {
                getElement('trFiles').style.display = 'none';
                getElement('tdFiles').innerHTML = '';
            }
            else {
            getElement('trFiles').style.display = 'table-row';
                getElement('tdFiles').innerHTML = strFiles;
            }
            strFiles = '';
        }

        function textCounter(field) {

            if (field.value.length > 500)
                field.value = field.value.substring(0, 500);
        }

        function ShowUpdateMessage() {
            document.getElementById('spnUpdateMessage').style.display = 'inline';
            setTimeout('HideUpdateMessage()', 3000)
        }

        function HideUpdateMessage() {
            document.getElementById('spnUpdateMessage').style.display = 'none';
        }

        function OnAttachmentSubmit(flagCancel) {
            if (flagCancel == 1) {//Remove All
                document.getElementById("SOW").checked = false;
                document.getElementById("BRD").checked = false;
                document.getElementById("RadioButton2").checked = false;
                document.getElementById("RadioButton4").checked = false;
                document.getElementById("RadioButton5").checked = false;
                document.getElementById("RadioButton6").checked = false;
                ResetAttachment3(); ResetAttachment2(); ResetAttachment1();
                Page_ClientValidate('AttachmentGroup');
                //document.getElementById("BtnOk").focus();
                return false;
            }

            getElement('Attachment').style.display = 'none';
            document.getElementById("<%=btnattch.ClientID%>").focus();
            var strFiles = '';
            if (document.getElementById('<%=File1.ClientID%>').value != '')
                strFiles += '<table style=\'display:inline;font-size:11px;border:solid 1px #989d97;background-color:eff2f9;height:19px;\' cellpadding=0 cellpadding=0><tr><td>' + trimFileName(getElement('file1').value.substr(getElement('file1').value.lastIndexOf("\\") + 1)) + '</td><td style=\'cursor:pointer;font-size:13px;color:grey;font-weight:bold;\' title=Remove align=left onClick=\'ResetAttachment1();OnAttachmentSubmit(0);\'> |x</td></tr></table>&nbsp;';

            if (document.getElementById('<%=File2.ClientID%>').value != '')
                strFiles += '<table style=\'display:inline;font-size:11px;border:solid 1px #989d97;background-color:eff2f9;height:19px;\' cellpadding=0 cellpadding=0><tr><td>' + trimFileName(getElement('file2').value.substr(getElement('file2').value.lastIndexOf("\\") + 1)) + '</td><td style=\'cursor:pointer;font-size:13px;color:grey;font-weight:bold;\' title=Remove align=left onClick=\'ResetAttachment2();OnAttachmentSubmit(0);\'> |x</td></tr></table>&nbsp;';
            if (document.getElementById('<%=File3.ClientID%>').value != '')
                strFiles += '<table style=\'display:inline;font-size:11px;border:solid 1px #989d97;background-color:eff2f9;height:19px;\' cellpadding=0 cellpadding=0 ><tr><td>' + trimFileName(getElement('file3').value.substr(getElement('file3').value.lastIndexOf("\\") + 1)) + '</td><td style=\'cursor:pointer;font-size:13px;color:grey;font-weight:bold;\' title=Remove align=left onClick=\'ResetAttachment3();OnAttachmentSubmit(0);\'> |x</td></tr></table>';

            if (strFiles == '') {
                getElement('trFiles').style.display = 'none';
                getElement('tdFiles').innerHTML = '';
            }
            else {
                getElement('trFiles').style.display = 'inline';
                getElement('tdFiles').innerHTML = strFiles;
            }
            strFiles = '';
        }
        function trimFileName(strFileName) {
            if (strFileName.length > 20)
                return strFileName.substr(0, 20) + ' ...';
            else
                return strFileName;
        }
        function validateNotes() {
            var ret = false;
            if (trim(document.getElementById('<%=txtNotes.ClientID%>').value) == '') {
                alert('Please enter some Notes.');
                ret = false
            }
            else {
                ret = true;
            }
            return ret;
        }

        window.onload = function() {
            var ddlActivityStatus = getElement('<%= ddlActivityStatus.ClientID %>')

        }
        function onUpdating() {
            var ddlActivityStatus = getElement('<%= ddlActivityStatus.ClientID %>')
            var txtActivityDueDate = getElement('<%= txtActivityDueDate.ClientID %>')
            var btnUpdateDueDate = getElement('<%= btnUpdateDueDate.ClientID %>')
            var btnBack = getElement('<%= btnBack.ClientID %>')

            var btnAddNotes = getElement('<%= btnAddNotes.ClientID %>')
            var btnattch = getElement('<%=btnattch.ClientID%>')
            var btnSave = getElement('<%= btnSave.ClientID %>')
            ddlActivityStatus.disabled = true;
            txtActivityDueDate.disabled = true;
            btnUpdateDueDate.disabled = true;
            btnBack.disabled = true;
        }
        function onUpdated() {
            var ddlActivityStatus = getElement('<%= ddlActivityStatus.ClientID %>')
            var txtActivityDueDate = getElement('<%= txtActivityDueDate.ClientID %>')
            var btnUpdateDueDate = getElement('<%= btnUpdateDueDate.ClientID %>')
            var btnBack = getElement('<%= btnBack.ClientID %>')

            var btnAddNotes = getElement('<%= btnAddNotes.ClientID %>')
            var btnattch = getElement('<%=btnattch.ClientID%>')
            var btnSave = getElement('<%= btnSave.ClientID %>')
            ddlActivityStatus.disabled = false;
            txtActivityDueDate.disabled = false;
            btnUpdateDueDate.disabled = false;
            btnBack.disabled = false;
            getElement('img1').disabled = false;
        }

        function validateTime(oSrc, args) {
            var ddlHoursNotes = getElement('<%= ddlHoursNotes.ClientID %>');
            var ddlMinutesNotes = getElement('<%= ddlMinutesNotes.ClientID %>');
            if (ddlHoursNotes.value == 0 && ddlMinutesNotes.value == 0) {
                args.IsValid = false
            }
            else {
                args.IsValid = true
            }
        }

        function OnSaveClientSide() {
            if (Page_ClientValidate('NotesAdd') && Page_ClientValidate('AttachmentGroup')) {
                document.getElementById('btnCancel').disabled = true;
                var rdoPrivate = getElement('<%= rdoPrivate.ClientID %>');
                document.getElementById('divNotes').style.display = 'none';
                //if (rdoPrivate.checked)
                //{
                if ((getElement('<%= File1.ClientID %>').value != '') || (getElement('<%= File2.ClientID %>').value != '') || (getElement('<%= File3.ClientID %>').value != '')) {
                    var progress = document.getElementById('progress');
                    progress.style.display = 'inline';
                }
                //return true;
                //}
                return true;
            }
            else
                return false;
        }



        function CheckReleaseDueDate() {
            if (Page_ClientValidate('vgdateupdate')) {

                if (document.getElementById('<%=IsRelease.ClientID %>').value == 'False')
                { return true; }

                var hdnReleaseDueDate = new Date(document.getElementById('<%=hdnReleaseDueDate.ClientID %>').value)
                var txtDueDate = new Date(document.getElementById('<%=txtActivityDueDate.ClientID %>').value)
                var strmsg = '';
                var bool = 0;
                if (hdnReleaseDueDate < txtDueDate) {
                    bool = 1;
                    strmsg += 'Feature Due Date is greater than Release Due Date (' + document.getElementById('<%=hdnReleaseDueDate.ClientID %>').value + ')\n';
                    strmsg += 'Are you sure you want to update ';
                    strmsg += 'Release Due Date';
                    strmsg += ' ?';
                }

                if (bool > 0) {
                    if (confirm(strmsg))
                        return true;
                    else
                        return false;
                }
                else {
                    return true;
                }
            }
        }
        function OpenAttachment(Path) {
            var IframeDownload = document.getElementById('IframeDownload');
            IframeDownload.src = Path;
        }

        function SelectStatusDDL(value) {
            if ((getElement('<%= File1.ClientID %>').value != '') || (getElement('<%= File2.ClientID %>').value != '') || (getElement('<%= File3.ClientID %>').value != '')) {
                var progress = document.getElementById('progress')
                progress.style.display = 'inline';
            }
            BlackDivDisplay()
            return true;
        }
        function MoveToBack(url) {
            url = "PMReportDetail.aspx";
            /*url = url + '&TeamId=' + '<%=Request.QueryString("TeamId")%>';
            url = url + '&CategoryId=' + '<%=Request.QueryString("CategoryId")%>';
            url = url + '&Type=' + '<%=Request.QueryString("Type")%>';
            url = url + '&StartDate=' +'<%=Request.QueryString("StartDate")%>';
            url = url + '&EndDate=' + '<%=Request.QueryString("EndDate")%>';*/
            var coockieVal = document.cookie.valueOf();
            var dashboardcookie = coockieVal.substr(coockieVal.indexOf('StartDashBaordDetailCookie'), coockieVal.indexOf('EndDashBaordDetailCookie'));
            var Qstr = dashboardcookie.replace('StartDashBaordDetailCookie', '');
            Qstr = Qstr.replace('EndDashBaordDetailCookie', '');
            window.location = url + Qstr;  
        }


        function OnPagingClick(TicketID, ddlClients, ddlCategories, ddlStatus, ddlFilter, txtSearch, txtDateFrom, txtDateTo, hdnSortBy, CurrentPageNumber) {
            
            try{

            window.location = "TicketsDetail.aspx?ID=" + TicketID + "&ddlClients=" +ddlClients
                                                   + "&ddlCategories=" + ddlCategories
                                                  + "&ddlStatus=" + ddlStatus
                                                  + "&ddlFilter=" + ddlFilter
                                                  + "&txtSearch=" + txtSearch
                                                  + "&txtDateFrom=" + txtDateFrom
                                                  + "&txtDateTo=" + txtDateTo
                                                  + "&hdnSortBy=" + hdnSortBy
                                                  + "&PrevPage=4"
                                                  + "&CurrentPageNumber=" + CurrentPageNumber + "";


                
                //window.location = 'TicketsDetail.aspx';

             
            }
            catch(e)
            {
                return false;
            }
            
        }
        //function yesnoCheck() {
        //    if (document.getElementById('#chkIsClientFeedback').checked=true) {
        //        document.getElementById('ifYes').style.display = 'block';
        //    }
        //    else document.getElementById('ifYes').style.display = 'none';

        //}

   

        function ShowHideFeedback()
        {
            document.getElementById('<%=cvType.ClientID%>').style.display = 'none';
            var isPublic = document.getElementById('<%=rdoPublic.ClientID %>').checked;
            <%--if ('<%= hdnClientID.Value = Portal.BLL.Enumeration.ClientID.Netsolace Or hdnClientID.Value = Portal.BLL.Enumeration.ClientID.EA %>' == 'True')--%>
            {
                if (document.getElementById('dvIsClientFeedback') != null && document.getElementById('dvIsClientFeedback').style.display !=  undefined )
                {
                    if (isPublic == true)
                    {
                        document.getElementById('dvIsClientFeedback').style.display = "inline";
                    }
                    else
                    {
                        document.getElementById('dvIsClientFeedback').style.display = "none";
                    }
                }
            }
            //else
            { 
                // for JS error
                //if (document.getElementById('dvIsClientFeedback') != null)
                //{
                //    if (document.getElementById('dvIsClientFeedback').style.display !=  undefined)
                //    {
                //        document.getElementById('dvIsClientFeedback').style.display = "none";
                //    }
                //}

            }
            
        }
       function EditTicketDetail(){
           var id=$('#hdnID').val();
           var name = $('#lblAssignBy').text();
           window.location= "EditProjectInfo.aspx?ID="+id+"&AdminName="+name;
       }

       function YourChangeFun(ddl)
       {
           var $option = $(this).find('option:selected');
           var text=ddl.options[ddl.selectedIndex].innerHTML;
           var divTicketDetails = getElement('DivTicketDetail');
           if(text=="Add Ticket")
           {
               if (divTicketDetails.style.display == 'none') {
                   CenterAlignDiv(document.getElementById('DivTicketDetail'));
                   divTicketDetails.style.display = 'inline';
                   ddl.selectedIndex=0;
               }

           }
           else
           {  //var TicketNumber =ddl.options[ddl.selectedIndex].val()
              var TicketID= $('#linkedTickets option:selected').val();
              var preID =$('#hdnID').val();
              var isANumber = isNaN(TicketID) === false; 
               if(isANumber==true){
                   window.location="TicketsDetail.aspx?ID=" + TicketID +"&PreID="+ preID +"&PrevPage=0";
               }
           }
          
       }
       function ShowDiv(){
           var divTicketDetails = getElement('DivTicketDetail');
           if (divTicketDetails.style.display == 'none') {
               CenterAlignDiv(document.getElementById('DivTicketDetail'));
               divTicketDetails.style.display = 'inline';
           }
       }
       function ShowDivFlag(){
           var divTicketDetails = getElement('DivTicketFlag');
           if (divTicketDetails.style.display == 'none') {
               CenterAlignDiv(document.getElementById('DivTicketFlag'));
               divTicketDetails.style.display = 'inline';
               document.getElementById("flagComments").focus(); 

           }
       }
       function ShowDivRemoveFlag(){

           var divTicketDetails = getElement('DivTicketFlagRemove');
           if (divTicketDetails.style.display == 'none') {
               CenterAlignDiv(document.getElementById('DivTicketFlagRemove'));
               divTicketDetails.style.display = 'inline';
         

           }
           document.getElementById("<%=flag.ClientID %>").disabled = true;
       }
       

       function HideDiv(){
           var divTicketDetails = getElement('DivTicketDetail');
           divTicketDetails.style.display = 'none';
           $('#<%=ticketGrid.ClientID%>').html("");
           $('#txtSearchBox').val("");
       }
          function HideDivFlag(){
              var divTicketDetails = getElement('DivTicketFlag');
              $('#flag').attr('checked', false);
              divTicketDetails.style.display = 'none';
              document.getElementById("<%=flag.ClientID %>").disabled = false;
          <%-- $('#<%=ticketGrid.ClientID%>').html("");--%>
          }
         function HideDivRemoveFlag(){
             var divTicketDetails = getElement('DivTicketFlagRemove');
             divTicketDetails.style.display = 'none';
               document.getElementById("<%=flag.ClientID %>").checked = true;
             document.getElementById("<%=flag.ClientID %>").disabled = false;
       }
       //function isNumber(evt) {
       //    evt = (evt) ? evt : window.event;
       //    var charCode = (evt.which) ? evt.which : evt.keyCode;
       //    var ctrl = evt.ctrlKey ? evt.ctrlKey : ((key === 17) ? true : false);
       //    if (key == 86 && ctrl) {
       //        alert(11);
       //    }
       //    if (charCode > 31 && !((charCode >= 48 && charCode <= 57) || (charCode >= 96 && charCode <= 105))) {
       //        return false;
       //    }
       //    return true;
       //} 
        function prePage(){
            var ID =$('#hdnIDPre').val();
            window.location="TicketsDetail.aspx?ID=" + ID ;
        }
        function validate() {
            var text = $("#txtSearchBox").val();
            if (text == "") {
                return false;
            } else {
                return true;
            }
        }
    </script>
    </form>
</body>
</html>

