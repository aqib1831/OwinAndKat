<%@ Control Language="VB" AutoEventWireup="false" CodeFile="VitalInformationFloatingDiv.ascx.vb" Inherits="com_VitalInformationFloatingDiv" %>
  <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
  <asp:HiddenField ID="hdnSOWAttachmentTypeID" runat="server" Value="0" />
<asp:HiddenField ID="hdnBRDAttachmentTypeID" runat="server" Value="0" />
<asp:HiddenField ID="hdnAttachmentTypeID" runat="server" Value="0" />
<style>

    #VitalInformationFloatingDiv_fvLeadVitals_gvSOWLog tr th,#VitalInformationFloatingDiv_fvLeadVitals_gvBRDLog tr th,#VitalInformationFloatingDiv_fvLeadVitals_gvAttachments tr th,#VitalInformationFloatingDiv_fvLeadVitals_GridView2 tr th{

        font-size:10px;
        background-color:#E4F1F7;
        border:2px solid white;

    }
    
    #VitalInformationFloatingDiv_fvLeadVitals_gvSOWLog tr td,#VitalInformationFloatingDiv_fvLeadVitals_gvBRDLog tr td,#VitalInformationFloatingDiv_fvLeadVitals_gvAttachments tr td{
    border-left:none;
    border-right:none;
    text-align:justify;

    }


    #VitalInformationFloatingDiv_fvLeadVitals_GridView2 tr td {
    
      border-left:none;
    border-right:none;
    text-align:justify;
    
    }
     .bluetext {
         
       color:#83A0C2;

    }

     
  
   

</style>
    <div id="DivIFrame" runat="server"  style="display:none;border:solid 1px #000000; position:absolute; width:600px;  height:60%;top:20%; left:20%; z-index:10001;"    >
          <table style="height:100%;" cellpadding="0" border="0" cellspacing="0"   >
           <tr >    
              <td align="left" style="vertical-align:middle; border-bottom:solid 1px #000000; padding-left:1em; background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
                 <asp:label ID="Label2" runat="server" Text="Synchronization Skip Key" Font-Bold="true" ForeColor="White" Font-Size="12pt" ></asp:label>
              </td>
              <td  style="border-bottom:solid 1px #000000;background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:20%; height:28px; cursor:pointer;">
                  <img src="../images/win_btn_close_black.jpg" style="float:right;" alt="Close Window" onClick="SkipReset();" />
              </td>               
           </tr>
           <tr valign="top">                
             <td colspan="2" style="height:100%; padding:0px; font-size:12px; background-color:White; border:0px;" >   
                <div id="divInnerIframe" style="overflow:auto; height:400px; width:600px; border:0px;" hdnClientID   
                    <iframe name="IfSkipSync" runat="server" id="IfSkipSync" src="blank.aspx" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
                </div>
             </td>
           </tr>            
          </table>
        </div>
<div align="left" id="FrachiseDetail" style="display: inline; position: absolute; overflow: auto; height:99%; width:348px; top:0px; left: -320px;">
               
                    <asp:FormView OnDataBound="fvLeadVitals_DataBound"
                runat="server"
                ID="fvLeadVitals"
                Width="100%"
                Height="100%"
                DataSourceID="sdsProjectInformation"
                CellPadding="0"
                CellSpacing="0"  >
                <ItemTemplate>
                    <table  style="width:100%; height:100%;" border="0" cellpadding="0" cellspacing="0">
                  <tr style="border-color:#FFFFFF;">
                    <td>
                      <table style="width:100%; height:100%;border-right:1px solid #609BD3;border-bottom:1px solid #609BD3;"  border="0" align="center" cellpadding="0" cellspacing="0" class="blueSubTableTD">
                        <tr> 
                            <th style="height:20px;" align="left">
    	                        &nbsp;Project Information
	                        </th>
	                    </tr>
                        <tr > 
                             <td>
                             <%--<asp:HiddenField ID="hdnStoreStatus" runat="server" Value='<%#Eval("Status") %>'/>
                             <asp:HiddenField ID="hdnSubStatus" runat="server" Value='<%#Eval("SubStatus") %>' />
                              <asp:HiddenField ID="hdnIsCorporate" runat="server"  Value='<%# Eval("IsCorporate") %>'/>--%>
                                <div style="height: 100%; width: 100%; overflow:auto; "> 
                                    <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                                      <tr  > 
                                        <td   >Project Manager:</td>
                                        <td style="height:auto;font-weight:bold;"  align="left" title='<%# Eval("ProjectManager") %>' colspan ="3" >                                        
                                                <%# Eval("ProjectManager")%> &nbsp;
                                        </td>
                                    </tr>
                                    <tr  > 
                                        <td >Product Owner:</td>
                                        <td   align="left" style="height:20px;font-weight:bold;"  title='<%# Eval("ProductOwner") %>'  colspan ="3">  
                                         <%# Eval("ProductOwner") %>   &nbsp; 
                                        </td>
                                    </tr>              
                                    <tr> 
                                        <td >Design Lead:</td>
                                        <td style="height:20px;font-weight:bold;" title='<%# Eval("DesignLead") %>'   colspan ="3"> 
                                         <%# Eval("DesignLead") %> &nbsp;
                                        </td>
                                    </tr>                                    
									<tr  > 
                                        <td colspan ="1">Development Lead:</td>
                                        <td style="height:20px;font-weight:bold;" title='<%# Eval("DevelopmentLead") %>'  colspan ="3" >
                                           <%# Eval("DevelopmentLead") %> &nbsp;
                                        </td>
                                    </tr>                                         
                                    <tr  > 
                                        <td  >QA Lead:</td>
                                        <td style="height:20px;font-weight:bold;" title='<%# Eval("QALead") %>' colspan ="3" >
                                           <%# Functions.StringTruncate(Eval("QALead"), 25)
                                               %> &nbsp;
                                        </td>
                                    </tr>                                                                             
                                 
                                  <% For Each items As System.Collections.Generic.KeyValuePair(Of String, String) In ListOfKey %>
                                    <tr>
                                        <td  >
                                         <%= Functions.StringTruncate(items.Key.ToString().Trim(), 20)%>: 
                                        </td>
                                        <td style="height:20px;font-weight:bold;"  colspan ="3"  > <b> <%= Functions.StringTruncate(items.Value.ToString(), 20)    %> </b></td>


                                    </tr>


                                      <%Next %>
                                     
                                    <tr > 
                                        <th style="height:20px;background-color:#AAD3EF!important ;font-weight:bold;font-weight:bold;border-top:1px solid #AAD3EF!important;" colspan="4" align="left">&nbsp;SOW Summary</th>
                                    </tr>              
                                    <tr  > 
                                        <td style="height:20px!important;text-align:center;font-weight:bold!important;background-color:#DCECF9;border:1px solid  white;font-size:8;">&nbsp;Document</td>
                                        <td style="height:15px!important;text-align:center;font-weight:bold!important;background-color:#DCECF9;border:1px solid  white;font-size:8;">&nbsp;Posted</td>
                                        <td style="height:20px!important;text-align:center;font-weight:bold!important;background-color:#DCECF9;border:1px solid  white;font-size:8;">&nbsp;CRB Approved</td>
                                        <td style="height:20px!important;text-align:center;font-weight:bold!important;background-color:#DCECF9;border:1px solid  white;font-size:8;">&nbsp;SOW Approved</td>                                        
                                    </tr>
                                    <tr>
                                        <td  title="<%#Eval("DocumentName")%>" style="font-weight:500;font-size:10px;text-align:left;padding-left:4"><a href='#' onclick="javascript:OpenAttachment('<%# ResolveUrl("Downlaod.aspx?dt=" & Functions.EncryptData(DateTime.Now) & "&AttachmentID=") & Functions.EncryptData(Eval("AttachmentID")) %>');"><%#  Functions.StringTruncate(Eval("DocumentName"), 15) %>&nbsp; </a></td>
                                        <td style="font-weight:500;font-size:9px;text-align:center" >&nbsp;<%# Eval("Posted") %></td> <%--<%# DateTime.Parse(Eval("Posted").ToString()).ToString("d") %>--%>
                                        <td style="font-weight:500;font-size:9px;text-align:center">&nbsp;<%#Functions.StringTruncate(Eval("CRBApprovalDate"), 11)%></td> <%--<%# DateTime.Parse(Eval("CRBApprovalDate").ToString()).ToString("d") %>--%>
                                        <td style="font-weight:500;font-size:9px;text-align:center">&nbsp;<%# Eval("SOWApprovalDate") %></td> <%--<%# DateTime.Parse(Eval("SOWApprovalDate").ToString()).ToString("d") %>--%>
                                    </tr>

                                    <tr id="sowrow" runat="server"> 
                                        <th style="height:20px;background-color:#AAD3EF!important ;font-weight:bold;border-top:1 solid #7DA4CD;" colspan="4" align="left">&nbsp;SOW Log</th>
                                    </tr>              
                                    <tr  id="sowrowgrid" runat="server"> 
                                        <td colspan="4" style="background-color:#E4F1F7;margin:0px;padding:0px; vertical-align:top;">
                                            <div style="overflow:auto;height:100%;background-color:#E4F1F7;border:1px solid #ACBDD5;" id="_gridViewPanel1"  class="ScrollBarHomeTicket">
                                            <asp:GridView ID="gvSOWLog" Width="100%" runat="server" DataSourceID ="odsGetSOWLog" OnRowDataBound="gvSOWLog_RowDataBound" SkinID="GridViewWithPaging" EnableViewState="false" AutoGenerateColumns="false">
                                              
                                                 <Columns>
                                               
                                                    <%--<asp:BoundField HeaderText="Document Name" DataField="FileName" />
                                                    <asp:BoundField HeaderText="Posted" DataField="DateAttached" />
                                                    <asp:BoundField HeaderText="User" DataField="FirstName" />--%>
                                                    <asp:TemplateField  HeaderText ="Document Name"  HeaderStyle-HorizontalAlign ="Left" HeaderStyle-Font-Bold="true" >
                                                        <ItemTemplate>
                                                            <%--<span class="bluetext"><%# Eval("FileName") %> &nbsp;</span>--%>
                                                            <a href='#' onclick="javascript:OpenAttachment('<%# ResolveUrl("Downlaod.aspx?dt=" & Functions.EncryptData(DateTime.Now) & "&AttachmentID=") & Functions.EncryptData(Container.DataItem("ID")) %>');"><%# Functions.StringTruncate(Container.DataItem("FileName"), 15)%></a> 
                                                        </ItemTemplate>
                                                        <ItemStyle Width="113" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText ="Posted" HeaderStyle-HorizontalAlign ="Center" HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate>
                                                           &nbsp; &nbsp;&nbsp; <%# Eval("DateAttached", "{0:MM/dd/yy}") %>
                                                            
                                                        </ItemTemplate>
                                                       
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText ="User" HeaderStyle-HorizontalAlign ="Center" HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate>
                                                             &nbsp; &nbsp;   <%# Eval("FirstName") %> 
                                                        </ItemTemplate>

                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText ="Type" HeaderStyle-HorizontalAlign ="Center" HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate>
                                                          &nbsp; &nbsp;  <img id="Img1" src='<%# GetImage(Eval("Type")) %>' runat="server" />
                                                            <%--<img id="Img2" src="../images/icn_Viewed.png" runat="server" visible='<%# Eval("Type") %>' />--%>
                                                            
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                            </div>
                                        </td>                                        
                                    </tr>
                                    <asp:ObjectDataSource ID="odsGetSOWLog"  runat="server" SelectMethod="PM_MYTicket_Attachment_GetByTicketID_GetByAttachmentType" TypeName="Portal.BLL.PM.PM_Ticket_Features">
                                        <SelectParameters>
                                            <asp:ControlParameter  Name="ID" Type="Int32" ControlID="hdnClientID" PropertyName="Value" />
                                            <asp:ControlParameter  Name="AttachmentType" Type="Int32" ControlID="hdnSOWAttachmentTypeID" PropertyName="Value" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>                                    
                                    <tr id="brdrow" runat="server"> 
                                        <th style="height:20px;font-weight:bold;border-top:1 solid #7DA4CD;" colspan="4" align="left">&nbsp;BRD</th>
                                    </tr>              
                                    <tr id="brdrowgrid" runat="server"> 
                                        <td colspan="4">
                                            <asp:GridView ID="gvBRDLog" Width="100%" OnDataBound="gvBRDLog_DataBound" OnRowDataBound="gvBRDLog_RowDataBound" runat="server" DataSourceID ="odsGetBRDLog" AutoGenerateColumns="false">
                                                <Columns>
                                                    <%--<asp:BoundField HeaderText="Document Name" DataField="FileName" />
                                                    <asp:BoundField HeaderText="Posted" DataField="DateAttached" />
                                                    <asp:BoundField HeaderText="User" DataField="FirstName" />--%>
                                                    <asp:TemplateField HeaderText ="Document Name" HeaderStyle-HorizontalAlign ="Left" HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate>
                                                          <%--<span class="bluetext">   <%# Eval("FileName") %> &nbsp;</span>--%>
                                                          <a href='#' onclick="javascript:OpenAttachment('<%# ResolveUrl("Downlaod.aspx?dt=" & Functions.EncryptData(DateTime.Now) & "&AttachmentID=") & Functions.EncryptData(Container.DataItem("ID")) %>');"><%#  Functions.StringTruncate(Container.DataItem("FileName"), 15)%></a>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText ="Posted" HeaderStyle-HorizontalAlign ="Center" HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate>
                                                      &nbsp;&nbsp; &nbsp; <%# Eval("DateAttached", "{0:MM/dd/yy}") %> &nbsp;
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText ="User" HeaderStyle-HorizontalAlign ="Center" HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate>
                                                          &nbsp;&nbsp;&nbsp; &nbsp;    <%#  Eval("FirstName") %> &nbsp;
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText ="Type" HeaderStyle-HorizontalAlign ="Center" HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate>
                                                         &nbsp;&nbsp; <img id="Img1" src='<%# GetImage(Eval("Type")) %>' runat="server" />
                                                            <%--<img id="Img2" src="../images/icn_Viewed.png" runat="server" visible='<%# Eval("Type") %>' />--%>
                                                             &nbsp;
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>                                        
                                    </tr>
                                    <asp:ObjectDataSource ID="odsGetBRDLog" runat="server" SelectMethod="PM_MYTicket_Attachment_GetByTicketID_GetByAttachmentType" TypeName="Portal.BLL.PM.PM_Ticket_Features">
                                        <SelectParameters>
                                            <asp:ControlParameter  Name="ID" Type="Int32" ControlID="hdnClientID" PropertyName="Value" />
                                            <asp:ControlParameter  Name="AttachmentType" Type="Int32" ControlID="hdnBRDAttachmentTypeID" PropertyName="Value" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>                                    
                                    <tr id="Attachmentsrow" runat="server"> 
                                        <th style="height:20px;font-weight:bold;border-top:1 solid #7DA4CD;" colspan="4" align="left">&nbsp;Attachments</th>
                                    </tr>              
                                    <tr  id="Attachmentsrowgrid" runat="server"> 
                                        <td colspan="4">
                                            <asp:GridView ID="gvAttachments" Width="100%"  runat="server" DataSourceID ="odsGetAttachmentLog" OnRowDataBound="gvAttachments_RowDataBound" AutoGenerateColumns="false">
                                                <Columns>
                                                    <%--<asp:BoundField HeaderText="Document Name" DataField="FileName" />
                                                    <asp:BoundField HeaderText="Posted" DataField="DateAttached" />
                                                    <asp:BoundField HeaderText="User" DataField="FirstName" />--%>
                                                    <asp:TemplateField HeaderText ="Document Name" HeaderStyle-HorizontalAlign ="Left" HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate>
                                                           <%--<span class="bluetext">  <%# Eval("FileName") %> &nbsp;</span>--%>
                                                           <a href='#' onclick="javascript:OpenAttachment('<%# IIf(Container.DataItem("NoteAttachment") = 1, ResolveUrl("Downlaod.aspx?dt=" & Functions.EncryptData(DateTime.Now) & "&AttachmentID=") & Functions.EncryptData(Container.DataItem("ID")), ResolveUrl("Downlaod.aspx?dt=" & Functions.EncryptData(DateTime.Now) & "&TicketID=") & Functions.EncryptData(Container.DataItem("ID")))%>');"><%#  Functions.StringTruncate(Container.DataItem("FileName"), 15) %></a>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText ="Posted" HeaderStyle-HorizontalAlign ="Center" HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate >
                                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%# Eval("DateAttached", "{0:MM/dd/yy}") %> &nbsp;
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText ="User" HeaderStyle-HorizontalAlign ="Center" HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate>
                                                           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <%# Eval("FirstName")%> &nbsp;
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText ="Type" HeaderStyle-HorizontalAlign ="Center" HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate>
                                                            &nbsp;&nbsp;&nbsp;<img id="Img1" src='<%# GetImage(Eval("Type")) %>' runat="server" />
                                                            <%--<img id="Img2" src="../images/icn_Viewed.png" runat="server" visible='<%# Eval("Type") %>' />--%>
                                                             &nbsp;
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>                                        
                                    </tr>
                                    <asp:ObjectDataSource ID="odsGetAttachmentLog" runat="server" SelectMethod="PM_MYTicket_Attachment_GetByTicketID_GetByAttachmentType" TypeName="Portal.BLL.PM.PM_Ticket_Features">
                                        <SelectParameters>
                                            <asp:ControlParameter  Name="ID" Type="Int32" ControlID="hdnClientID" PropertyName="Value" />
                                            <asp:ControlParameter  Name="AttachmentType" Type="Int32" ControlID="hdnAttachmentTypeID" PropertyName="Value" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>                                    
                                    <tr id="EstHead"  runat="server"> 
                                        <th style="height:20px;font-weight:bold;border-top:1 solid #7DA4CD;" colspan="4" align="left">&nbsp;Estimates</th>
                                    </tr>              
                                    <tr id="EstGrid" runat="server" > 
                                        <td colspan="4">
                                            <asp:GridView ID="GridView2" Width="100%" OnRowDataBound="GridView2_RowDataBound" runat="server" DataSourceID ="odsGetTicketEstimates" AutoGenerateColumns="false">
                                                <Columns>
                                                    <%--<asp:BoundField HeaderText="Document Name" DataField="FileName" />
                                                    <asp:BoundField HeaderText="Posted" DataField="DateAttached" />
                                                    <asp:BoundField HeaderText="User" DataField="FirstName" />--%>
                                                    <asp:TemplateField  HeaderText ="Type" HeaderStyle-HorizontalAlign ="Left" HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate>
                                                            <%# Functions.StringTruncate(CType(Container.DataItem, Data.DataRowView)("Title"), 25)  %> &nbsp;
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText ="Created By" HeaderStyle-HorizontalAlign ="Center" HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate>
                                                      &nbsp;&nbsp;&nbsp;        <asp:Label ID="CreatedBylbl" runat="server" Text='<%#  Eval("FirstName") %> &nbsp;' /> 
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText ="Posted" HeaderStyle-HorizontalAlign ="Center" HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate>
                                                         &nbsp;&nbsp;    <asp:Label ID="Postedlbl" runat="server" Text='<%# Eval("EstimateDate", "{0:MM/dd/yy}") %> &nbsp;'/>
                                                            
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText ="Hours" HeaderStyle-HorizontalAlign ="Center" HeaderStyle-Font-Bold="true">
                                                        <ItemTemplate>
                                                        
                                                               &nbsp;&nbsp;    <asp:Label ID="Hourslbl" runat="server" Text='<%# Eval("Estimates", "{0:N0}") %> &nbsp;' />
                                                            
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr id="totalrow" runat="server">
                                        <td colspan="3" style="text-align:right;font-weight:bold;">
                                         &nbsp;&nbsp;     &nbsp;&nbsp;     &nbsp;&nbsp;      &nbsp;&nbsp;       Total
                                        </td>
                                        <td style="text-align:center;font-weight:bold;">
                                        &nbsp;&nbsp; &nbsp;&nbsp; <%# Eval("TotalEstimates", "{0:0,0}") %>
                                        </td>
                                    </tr>
                                    <asp:ObjectDataSource ID="odsGetTicketEstimates" runat="server" SelectMethod="PM_MYTicket_Estimates_GetByTicketID" TypeName="Portal.BLL.PM.PM_Ticket_Features">
                                        <SelectParameters>
                                            <asp:ControlParameter  Name="ID" Type="Int32" ControlID="hdnClientID" PropertyName="Value" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                </table>
                            </div>
                        </td>
                      </tr>
                  </table>            
                </td>
                    <td  valign="top" style="width:27px;">
                          <table width="27" style="height:100%;" border="0" align="left" cellpadding="0" cellspacing="0">
                            <tr>
                              <td style="height:219px;cursor:pointer;" colspan="2" id="OpenProfile" ><img src="../images/project_info_open.gif" onmouseout="this.src='../images/project_info_open.gif'" onmouseover="this.src='../images/project_info_open_over.gif'" onclick="showHideVital();" name="img_vital_info" width="27" height="219" border="0" alt="" /></td>
                              <td style="height:219px;display:none;cursor:pointer;" colspan="2" id="CloseProfile" ><img src="../images/project_info_close.gif" onmouseout="this.src='../images/project_info_close.gif'" onmouseover="this.src='../images/project_info_close_over.gif'" onclick="showHideVital();" name="img_vital_info" width="27" height="219" border="0" alt="" /></td>
                            </tr>
                            <tr>
                              <td style="background-image:url(../images/vital_info_bottom_bg.gif);width:8px;border-bottom:1px solid #609BD3;" >&nbsp;</td>
                              <td style="width:19px;">&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                  </tr>
                </table>
                </ItemTemplate>
                </asp:FormView>
                   
                <asp:ObjectDataSource ID="sdsProjectInformation" OnSelected="sdsProjectInformation_Selected" runat="server" 
                    SelectMethod="PM_Project_Information_GetByTicketID"
                    TypeName="Portal.BLL.PM.PM_Ticket_Features">
                    <SelectParameters>
                      <asp:ControlParameter  Name="ID" Type="Int32" ControlID="hdnClientID"  PropertyName="Value" />                      
                    </SelectParameters>
            </asp:ObjectDataSource>              
             </div>
<script language="javascript" type="text/javascript"  >
  <%--function showSkipSyncDiv(StoreNumber,CountryID)
  {
            var FranchiseID = document.getElementById('<%= hdnFranchiseID.ClientID %>').value; 
            document.getElementById('divDisable').style.zIndex = '10000';
            var DivFram = getElement('<%= DivIFrame.ClientID %>')
            var divInnerIframe = getElement('divInnerIframe')
            IfSkipSync.location='Skip_Synchronization.aspx?StoreNumber='+StoreNumber+'&FranchiseID='+FranchiseID+'&CountryID='+CountryID;
            divInnerIframe.style.width = '350px';
            DivFram.style.width = '350px';
            divInnerIframe.style.height = '180px';
            DivFram.style.height = '180px';
            DivFram.style.left = '25%';
            
            document.getElementById('divDisable').style.width = '100%';
            document.getElementById('divDisable').style.height = '100%';
            DivFram.style.display= "inline"

   }--%>
    function SkipReset() {
        var DivFram = getElement('<%= DivIFrame.ClientID %>');
       document.getElementById('divDisable').style.width = 0;
       document.getElementById('divDisable').style.height = 0;
       IfSkipSync.location = 'blank.aspx';
       DivFram.style.display = 'none';
       return false;
   }
  <%--function rebinddata()
  { 
    showHideVital();
    document.getElementById('<%= btnRebind.ClientID %>').click(); 
  }--%>
    function ShowdivLoading() {
        document.getElementById('divLoading').style.display = "block";
    }
    function HidedivLoading() {
        moveit(0);
        blnShowed = true;
        document.getElementById('divLoading').style.display = "none";
    }
    function ShowLogin(id) {

        document.getElementById('trUserName_' + id).style.display = "inline";
        document.getElementById('trPassword_' + id).style.display = "inline";
        document.getElementById('trAccess_' + id).style.display = "inline";
        document.getElementById('dvBtnLogin_' + id).style.display = "none";
    }
    function ShowNoLogin(id) {
        document.getElementById('dvBtnLogin_' + id).style.display = "none";
        document.getElementById('divNoLogin_' + id).style.display = "inline";
    }

    function OpenAttachment(Path) {
        var IframeDownload = document.getElementById('IframeDownload');
        IframeDownload.src = Path;
    }
</script>